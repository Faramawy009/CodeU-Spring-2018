package codeu.model.data;

import java.time.Instant;

public class NewMessageEvent extends Event {
    private String userName;
    private String userLink;
    private String conversationName;
    private String conversationLink;

    /**
     * Constructs a new event that monitors users sending messages activities
     *
     * @param userName           name of the user who loggedIn/loggedOut
     * @param userLink           link to the profile of the user who loggedIn/loggedOut
     * @param timeStamp          the time at which this event happened
     * @param conversationName   the name of the conversation at which the message was sent
     * @param conversationLink   the link to the conversation at which the message was sent
     */
    public NewMessageEvent(String userName, String userLink, Instant timeStamp, String conversationName, String conversationLink) {
        this.userName = userName;
        this.userLink = userLink;
        super.timeStamp = timeStamp;
        this.conversationName = conversationName;
        this.conversationLink = conversationLink;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserLink() {
        return userLink;
    }

    public void setUserLink(String userLink) {
        this.userLink = userLink;
    }

    public String getConversationName() {
        return conversationName;
    }

    public void setConversationName(String conversationName) {
        this.conversationName = conversationName;
    }

    public String getConversationLink() {
        return conversationLink;
    }

    public void setConversationLink(String conversationLink) {
        this.conversationLink = conversationLink;
    }

    @Override
    public String toString() {
        return  this.userName +
                " ( " + this.userLink + " )" +
                " has sent a new message on" +
                " " + conversationName +
                " ( " + conversationLink + " ) at" +
                " " + super.timeStamp.toString() + "\n";
    }
}
