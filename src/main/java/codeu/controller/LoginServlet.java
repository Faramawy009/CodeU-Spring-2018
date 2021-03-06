// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.controller;

import codeu.model.data.Event;
import codeu.model.data.LoginLogoutEvent;
import codeu.model.data.Profile;
import codeu.model.data.User;
import codeu.model.store.basic.EventStore;
import codeu.model.store.basic.ProfileStore;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

/** Servlet class responsible for the login page. */
public class LoginServlet extends HttpServlet {

  /** Store class that gives access to Users. */
  private UserStore userStore;

  /** Store class that gives access to Events. */
  private EventStore eventStore;

  private ProfileStore profileStore;

  /**
   * Set up state for handling login-related requests. This method is only called when running in a
   * server, not when running in a test.
   */
  @Override
  public void init() throws ServletException {
    super.init();
    setUserStore(UserStore.getInstance());
    setEventStore(EventStore.getInstance());
    setProfileStore(ProfileStore.getInstance());
  }

  /**
   * Sets the UserStore used by this servlet. This function provides a common setup method for use
   * by the test framework or the servlet's init() function.
   */
  void setUserStore(UserStore userStore) {
    this.userStore = userStore;
  }

  void setProfileStore(ProfileStore profileStore) {
    this.profileStore = profileStore;
  }

  /**
   * Sets the EventStore used by this servlet. This function provides a common setup method for use
   * by the test framework or the servlet's init() function.
   */
  void setEventStore(EventStore eventStore) {
    this.eventStore = eventStore;
  }

  /**
   * This function fires when a user requests the /login URL. It simply forwards the request to
   * login.jsp.
   */
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
  }

  /**
   * This function fires when a user submits the login form. It gets the username and password from
   * the submitted form data, checks that they're valid, and either adds the user to the session so
   * we know the user is logged in or shows an error to the user.
   */
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String loginTypeParam = request.getParameter("logintype");
    String email = request.getParameter("email");

    User.LoginType loginType = null;
    try {
      loginType = User.LoginType.valueOf(loginTypeParam);
    } catch (Exception e) {
      request.setAttribute("error", "Not a valid login method");
    }
    if (loginType == User.LoginType.Facebook) {
      User user = userStore.getUserByEmail(email);
      if (user == null) {
        User newUser =
            new User(
                UUID.randomUUID(), username, "", Instant.now(), "", email, User.LoginType.Facebook);
        userStore.addUser(newUser);
        Profile profile =
            new Profile(
                newUser.getId(), Instant.now(), "Welcome to my " + "profile page!", null, null);
        profileStore.addProfile(profile);
      }
      request.getSession().setAttribute("user", username);
      Event event =
          new LoginLogoutEvent(username, "placeholderLink", Instant.now(), "login-event", true);
      eventStore.addEvent(event);
      response.sendRedirect("/conversations");
    } else {
      if (userStore.isUserRegistered(username)) {
        User user = userStore.getUser(username);
        // if the password is correct, redirect user to conversations page
        if (BCrypt.checkpw(password, user.getPassword())) {
          request.getSession().setAttribute("user", username);
          Event event =
              new LoginLogoutEvent(username, "placeholderLink", Instant.now(), "login-event", true);
          eventStore.addEvent(event);
          response.sendRedirect("/conversations");

        }
        // if the password isn't correct, redirect the user to login page again
        else {
          request.setAttribute("error", "Invalid password.");
          request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
      }
      // if the username isn't registered within the UserStore, redirects the user to the login page
      else {
        request.setAttribute("error", "That username was not found.");
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
      }
    }
  }
}
