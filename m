Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C2C136E64
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2020 14:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgAJNoD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jan 2020 08:44:03 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:36583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgAJNoC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jan 2020 08:44:02 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MGQf5-1itQ9q2QKD-00Gosa; Fri, 10 Jan 2020 14:43:43 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] kunit: move binary assertion out of line
Date:   Fri, 10 Jan 2020 14:43:12 +0100
Message-Id: <20200110134337.1752000-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HcATK1ifbGpJ7hVrQRVqUF1GGCPpwH+Qs6NYk7NUoE6K6NUlYXY
 KI2KpnEmRJyDoOOY6+Stoi19S7wP14CzpY7ELeYXS8fDtU7eUjpBL8rX91K2W17HfLWaRtg
 7NJ2AKPomKLERhmIjef6tYAmV+gB6diN7dTpkBVIusux5xzj6vzGdrfX6cFj/717npRo9dp
 vPZSxjSVBOI/X5UnN1bYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JpeaIPdukI0=:ojZzAxIQDeHJB1zkZdySlW
 0cZQ4J5ewrnHDab4HGCjsQ28kNXhs87bFYetzx0PSEUiQDNO0U7z2EhOMyEMwwOXGEBpAhlDt
 dSzWPzOHY7QMGG0Qsd8q2m++039+nIr97jJnJR9VK6ipu1uAajelYxBVlUCUdrAKmEshbLtEz
 2Z4A5VgRZvGcL3X7aU0S/cXDmanBXOtpZxTQU8xRi3Dtw7K08e/Io9H8DYii0vD7/dE3MpB7/
 XEOf49mPbZZxXxPBmFBu2VLJsQ4tGWBB0EKdtXoJZRPOBTiNg13ll2RO9pfBCncPqMxfWlTM6
 3HwjslaAKQoeltUoioPV1Ac8mi8VOVgrBlUY7ug1hg/s40+IvSw0npO0vyqlZv0RYIBs/puQq
 mKstwY4ooDTAQe9m9b5ph2MsUaELcfDsnISwZl2zc8MtHcdOEWQXDpr4zfEbwa2FhvNFZ33W1
 sHv6JWld9gVTA0qkVi3u9EO+CTexIlt2CQWt/kGd6pgAOuiDO7ou3kgLwYrwq24VtQBRuigbF
 yT1BbJ0TJlOdCO4P5YI6RXroKAOFSSQVJ65jznKON5nNHs0EL3XldxhmdxLnPzXYpWUJQgOM3
 Pr2gACegaNTzQBC/J7z4yrsDwnIgHZT5lpGll/xsDz7FUxj6gfnEDKam7eLHodBDvsJMWHb4E
 Cg0g7bTft83Qzjo9CxIp83z4BL6aIm6iu1hatUiGt0DTqKlbgIjnM5BCI3/Wimk7yp8deS7zo
 NWh7diOifsweaZu2ai/3zKU5IeipXQDqmU6LNfpvXssUg09Wm1uROi5aGbHNmd5kkdXTGD31d
 4L9Rukle2zix6Ri5/yl1MS7MUlX0PNyTu2jnnb4NW/LhtOV/72JT8bwnW02T4qaij/7LCERFy
 WoFvS35rqw6u8BFxy8Ug==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In combination with the structleak gcc plugin, kunit can lead to excessive
stack usage when each assertion adds another structure to the stack from
of the calling function:

base/test/property-entry-test.c:99:1: error: the frame size of 3032 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

As most assertions are binary, change those over to a direct function
call that does not have this problem.  This can probably be improved
further, I just went for a straightforward conversion, but a function
call with 12 fixed arguments plus varargs it not great either.

Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I think improving the compiler or the plugin to not force the
allocation of these structs would be better, as it avoids the
whack-a-mole game of fixing up each time it hits us, but this
may not be possible using the current plugin infrastructure.
---
 include/kunit/test.h | 155 ++++++++++++-------------------------------
 lib/kunit/assert.c   |   8 +--
 lib/kunit/test.c     |  42 ++++++++++++
 3 files changed, 90 insertions(+), 115 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index dba48304b3bd..76eadd4a8b77 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -391,6 +391,16 @@ void kunit_do_assertion(struct kunit *test,
 			bool pass,
 			const char *fmt, ...);
 
+void kunit_do_binary_assertion(struct kunit *test, bool pass,
+			       enum kunit_assert_type type,
+			       int line, const char *file,
+			       const char *operation,
+			       const char *left_text, long long left_value,
+			       const char *right_text, long long right_value,
+			       void (*format)(const struct kunit_assert *assert,
+					       struct string_stream *stream),
+			       const char *fmt, ...);
+
 #define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
 	struct assert_class __assertion = INITIALIZER;			       \
 	kunit_do_assertion(test,					       \
@@ -491,19 +501,32 @@ do {									       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
 	((void)__typecheck(__left, __right));				       \
-									       \
-	KUNIT_ASSERTION(test,						       \
-			__left op __right,				       \
-			assert_class,					       \
-			ASSERT_CLASS_INIT(test,				       \
-					  assert_type,			       \
-					  #op,				       \
-					  #left,			       \
-					  __left,			       \
-					  #right,			       \
-					  __right),			       \
-			fmt,						       \
-			##__VA_ARGS__);					       \
+	kunit_do_binary_assertion(test, left op right, assert_type, 	       \
+				  __LINE__, __FILE__,  #op, #left, __left,     \
+				  #right, __right,			       \
+				  kunit_binary_assert_format,		       \
+				  fmt, ##__VA_ARGS__);			       \
+} while (0)
+
+#define KUNIT_BASE_POINTER_ASSERTION(test,				       \
+				     assert_class,			       \
+				     ASSERT_CLASS_INIT,			       \
+				     assert_type,			       \
+				     left,				       \
+				     op,				       \
+				     right,				       \
+				     fmt,				       \
+				     ...)				       \
+do {									       \
+	typeof(left) __left = (left);					       \
+	typeof(right) __right = (right);				       \
+	((void)__typecheck(__left, __right));				       \
+	kunit_do_binary_assertion(test, left op right, assert_type, 	       \
+				  __LINE__, __FILE__,  #op,		       \
+				  #left, (uintptr_t)__left,     	       \
+				  #right, (uintptr_t)__right,		       \
+				  kunit_binary_ptr_assert_format,	       \
+				  fmt, ##__VA_ARGS__);			       \
 } while (0)
 
 #define KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
@@ -625,12 +648,11 @@ do {									       \
 					  right,			       \
 					  fmt,				       \
 					  ...)				       \
-	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+	KUNIT_BASE_POINTER_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
 				    assert_type,			       \
-				    left,				       \
-				    right,				       \
+				    left, ==, right,			       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
@@ -664,12 +686,11 @@ do {									       \
 					  right,			       \
 					  fmt,				       \
 					  ...)				       \
-	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
+	KUNIT_BASE_POINTER_ASSERTION(test,				       \
+				    assert_class,			       \
+				    ASSERT_CLASS_INIT,			       \
 				    assert_type,			       \
-				    left,				       \
-				    right,				       \
+				    left, !=, right,			       \
 				    fmt,				       \
 				    ##__VA_ARGS__)
 
@@ -697,28 +718,6 @@ do {									       \
 				      right,				       \
 				      NULL)
 
-#define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_PTR_LT_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
 	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
@@ -736,28 +735,6 @@ do {									       \
 				      right,				       \
 				      NULL)
 
-#define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_PTR_LE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
 	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
@@ -775,28 +752,6 @@ do {									       \
 				      right,				       \
 				      NULL)
 
-#define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_PTR_GT_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
 	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
 				    kunit_binary_assert,		       \
@@ -814,28 +769,6 @@ do {									       \
 				      right,				       \
 				      NULL)
 
-#define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  fmt,				       \
-					  ...)				       \
-	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
-				    kunit_binary_ptr_assert,		       \
-				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
-				    assert_type,			       \
-				    left,				       \
-				    right,				       \
-				    fmt,				       \
-				    ##__VA_ARGS__)
-
-#define KUNIT_BINARY_PTR_GE_ASSERTION(test, assert_type, left, right)	       \
-	KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
-					  assert_type,			       \
-					  left,				       \
-					  right,			       \
-					  NULL)
-
 #define KUNIT_BINARY_STR_ASSERTION(test,				       \
 				   assert_type,				       \
 				   left,				       \
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 86013d4cf891..abb6c70de925 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -101,8 +101,8 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
 {
-	struct kunit_binary_ptr_assert *binary_assert = container_of(
-			assert, struct kunit_binary_ptr_assert, assert);
+	struct kunit_binary_assert *binary_assert = container_of(
+			assert, struct kunit_binary_assert, assert);
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
@@ -112,10 +112,10 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 			 binary_assert->right_text);
 	string_stream_add(stream, "\t\t%s == %pK\n",
 			 binary_assert->left_text,
-			 binary_assert->left_value);
+			 (void *)(uintptr_t)binary_assert->left_value);
 	string_stream_add(stream, "\t\t%s == %pK",
 			 binary_assert->right_text,
-			 binary_assert->right_value);
+			 (void *)(uintptr_t)binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c83c0fa59cbd..937f3fbe5ecc 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -172,6 +172,48 @@ void kunit_do_assertion(struct kunit *test,
 		kunit_abort(test);
 }
 
+void kunit_do_binary_assertion(struct kunit *test, bool pass,
+				enum kunit_assert_type type,
+				int line, const char *file,
+				const char *operation,
+				const char *left_text, long long left_value,
+				const char *right_text, long long right_value,
+				void (*format)(const struct kunit_assert *assert,
+						struct string_stream *stream),
+				const char *fmt, ...)
+{
+	va_list args;
+	struct kunit_binary_assert assert = {
+		.assert = {
+			.test = test,
+			.type = type,
+			.file = file,
+			.line = line,
+			.message.fmt = fmt,
+			.format = format,
+		},
+		.operation = operation,
+		.left_text = left_text,
+		.left_value = left_value,
+		.right_text = right_text,
+		.right_value = right_value,
+	};
+
+	if (pass)
+		return;
+
+	va_start(args, fmt);
+
+	assert.assert.message.va = &args;
+
+	kunit_fail(test, &assert.assert);
+
+	va_end(args);
+
+	if (type == KUNIT_ASSERTION)
+		kunit_abort(test);
+}
+
 void kunit_init_test(struct kunit *test, const char *name)
 {
 	spin_lock_init(&test->lock);
-- 
2.20.0

