package com.example.board;

import java.util.Date;
import java.util.List;

public class BoardVO {
	private int id;            // 기존 seq -> id로 변경
	private String userid;     // 추가된 userid 필드
	private String title;
	private String professor;  // 추가된 professor 필드
	private String contents;   // 기존 content -> contents로 변경
	private Date regdate;
	private int view;          // 기존 cnt -> view로 변경
	private int like;          // 추가된 like 필드
	private int dislike;       // 추가된 dislike 필드
	private boolean secret;    // 추가된 secret 필드
	private String subject;


	// Getter and Setter methods
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getProfessor() {
		return professor;
	}
	public void setProfessor(String professor) {
		this.professor = professor;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getView() {
		return view;
	}
	public void setView(int view) {
		this.view = view;
	}
	public int getLike() {
		return like;
	}
	public void setLike(int like) {
		this.like = like;
	}
	public int getDislike() {
		return dislike;
	}
	public void setDislike(int dislike) {
		this.dislike = dislike;
	}
	public boolean isSecret() {
		return secret;
	}
	public void setSecret(boolean secret) {
		this.secret = secret;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}

	@Override
	public String toString() {
		return "BoardVO{" +
				"id=" + id +
				", userid='" + userid + '\'' +
				", title='" + title + '\'' +
				", professor='" + professor + '\'' +
				", contents='" + contents + '\'' +
				", regdate=" + regdate +
				", view=" + view +
				", like=" + like +
				", dislike=" + dislike +
				", secret=" + secret +
				", subject='" + subject + '\'' +
				'}';
	}
}
