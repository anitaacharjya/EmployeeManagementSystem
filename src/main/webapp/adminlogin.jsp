<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body>
 <section class="contact-us" id="contact">
        <div class="container">
            <div class="row justify-content-center">
                <div class="title text-center col-md-12">
                    <h2>Administrator Login</h2>
                    <div class="border"></div>
                </div>
                <div class="col-md-6">
                    <div class="contact-form">
                        <form id="contact-form" method="post" action="AdminLoginServlet">
                            <div class="form-group">
                                <input type="text" placeholder="Your Username" class="form-control" name="username" id="username" required>
                            </div>
                            <div class="form-group">
                                <input type="password" placeholder="Your Password" class="form-control" name="password" id="password" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <input type="submit" id="contact-submit" name="Login" class="btn btn-transparent" value="Login">
                                </div>
                                <div class="col-md-6">
                                    <input type="reset" id="contact-submit" name="Cancel" class="btn btn-transparent" value="Cancel">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

</body>
</html>