package member;

/*
DTO(Data Transfer Object)
:JSP와 Java간에 데이터를 전달하기 위한 객체로 자바빈 규약에 의해 제작

자바빈의 규약
1 자바빈즈는 기본(default) 패키지 이외의 패키지에 속해 있어야 합니다. 
2 멤버 변수(속성, 프로퍼티)의 접근 지정자는 private으로 선언합니다.
3 기본 생성자가 있어야 합니다. 
4 멤버 변수에 접근할 수 있는 게터/세터 메서드가 있어야 합니다. 
5 게터/세터 메서드의 접근 지정자는 public으로 선언합니다.

*/
public class MemberDTO {
	private String id;
	private String password;
	private String name;
	private String regidate;

	/*
	 * 생성자의 경우 꼭 필요한 경우가 아니라면 생략 이 경우 디폴트 생성자가 컴파일러에 의해 자동으로 추가되기 때문
	 */

	/*
	 * 정보은닉된 멤버변수에 접근하기 위해 public으로 정의된 getter/setter 메서드를 정의
	 */
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String pass) {
		this.password = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRegidate() {
		return regidate;
	}

	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}

}
