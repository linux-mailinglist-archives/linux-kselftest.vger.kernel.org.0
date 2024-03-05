Return-Path: <linux-kselftest+bounces-5932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B5872356
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 16:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E18B24CC8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C7D12839A;
	Tue,  5 Mar 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="atsjRvu1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098F127B7A;
	Tue,  5 Mar 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654231; cv=none; b=h+mpBQKTjo1BVvAq6yj3D9dDTPHTQ45CvupQLrggn65/2ybZbAnzG/BpkL3gWAsoHgqaIHmvRADoQrGRbDgVPKsnqpRzwk2uwha96mB8BX9B5utHxERWsnkAtD/FDYa8TKcnwph0WE3oiUiP0dvoRTyugZKdroytn8INVjarkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654231; c=relaxed/simple;
	bh=Rs0Jkg+AK63hN5zWADFuYAjfsZqO2y6I0/L5O6JIRnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCqUAJs3QQ1cp/HdtI2nTyFontDN6xaOyTYc4H9hcdNsnNRVL+Y34Ym6o17ATykB+J9JOL8j5YH/Qt41lyxp3X/Lrz/FylmlUNo7gjWKP6yfdXpATaB86jkvT7NFRs1apU1WORe67PilvmHvDMlXcKrBDHnqeD4SWZE7WHJCYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=atsjRvu1; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tq0Yr2mjkzMsdB1;
	Tue,  5 Mar 2024 16:57:04 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tq0Yq5wDqzvh;
	Tue,  5 Mar 2024 16:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709654224;
	bh=Rs0Jkg+AK63hN5zWADFuYAjfsZqO2y6I0/L5O6JIRnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atsjRvu1BWI6JXWh+8BdHrdtA+aGqHDnrdK8MvgL/ETV2s6tvSvZ4ozqYPUj6Vkpp
	 jkfGKJrGUJgCwX0dwz2qigCKCBu+bT4DnMtbod1mxQspPPIahxqVAM/jfplDc1Efj9
	 pi8iDJyPCP4dGO0733XCHEwodeCrtBK0Vz7Lgkhs=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	davem@davemloft.net
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	edumazet@google.com,
	jakub@cloudflare.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v1 2/2] selftests/harness: Merge TEST_F_FORK() into TEST_F()
Date: Tue,  5 Mar 2024 16:56:48 +0100
Message-ID: <20240305155648.1292566-3-mic@digikod.net>
In-Reply-To: <20240305155648.1292566-1-mic@digikod.net>
References: <20240305.eth2Ohcawa7u@digikod.net>
 <20240305155648.1292566-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Replace Landlock-specific TEST_F_FORK() with an improved TEST_F() which
brings four related changes:

Run TEST_F()'s tests in a grandchild process to make it possible to
drop privileges and delegate teardown to the parent.

Compared to TEST_F_FORK(), simplify handling of the test grandchild
process thanks to vfork(2), and makes it generic (e.g. no explicit
conversion between exit code and _metadata).

Compared to TEST_F_FORK(), run teardown even when tests failed with an
assert thanks to commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN
for ASSERT failures").

By default teardown is run by the grandchild process, but it can be run
by its parent process if _metadata->teardown_parent is set to true.

Update Landlock tests' fixture setup to set _metadata->teardown, and
remove now-invalid umount calls in Landlock test teardowns.

Simplify the test harness code by removing the no_print and step fields
which are not used.  I added this feature just after I made
kselftest_harness.h more broadly available but this step counter
remained even though it wasn't needed after all. See commit 369130b63178
("selftests: Enhance kselftest_harness.h to print which assert failed").

Replace spaces with tabs in one line of __TEST_F_IMPL().

Cc: Günther Noack <gnoack@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

v5:
 - Fix TEST_SIGNAL() by forwarding grandchild signal to parent.
 - By default, run teardown in the grandchild, but allow teardown to be
   run in its parent if _metadata->teardown_parent is set to true.  This
   fixes seccomp tests that have assumptions about the process
   hierarchy.
 - Remove now-invalid umount calls in Landlock test teardowns.

v4:
 - GAND -> GRAND
 - init child to 1, otherwise assert in setup triggers a longjmp
   which in turn reads child without it ever getting initialized
   (or being 0, i.e. we mistakenly assume we're in the grandchild)
---
 tools/testing/selftests/kselftest_harness.h | 72 ++++++++++-----------
 tools/testing/selftests/landlock/common.h   | 62 +-----------------
 tools/testing/selftests/landlock/fs_test.c  | 22 +++----
 3 files changed, 48 insertions(+), 108 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index e05ac8261046..4f192904dfd6 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -95,14 +95,6 @@
  * E.g., #define TH_LOG_ENABLED 1
  *
  * If no definition is provided, logging is enabled by default.
- *
- * If there is no way to print an error message for the process running the
- * test (e.g. not allowed to write to stderr), it is still possible to get the
- * ASSERT_* number for which the test failed.  This behavior can be enabled by
- * writing `_metadata->no_print = true;` before the check sequence that is
- * unable to print.  When an error occur, instead of printing an error message
- * and calling `abort(3)`, the test process call `_exit(2)` with the assert
- * number as argument, which is then printed by the parent process.
  */
 #define TH_LOG(fmt, ...) do { \
 	if (TH_LOG_ENABLED) \
@@ -363,6 +355,11 @@
  * Defines a test that depends on a fixture (e.g., is part of a test case).
  * Very similar to TEST() except that *self* is the setup instance of fixture's
  * datatype exposed for use by the implementation.
+ *
+ * The @test_name code is run in a separate process sharing the same memory
+ * (i.e. vfork), which means that the test process can update its privileges
+ * without impacting the related FIXTURE_TEARDOWN() (e.g. to remove files from
+ * a directory where write access was dropped).
  */
 #define TEST_F(fixture_name, test_name) \
 	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT)
@@ -384,17 +381,34 @@
 	{ \
 		/* fixture data is alloced, setup, and torn down per call. */ \
 		FIXTURE_DATA(fixture_name) self; \
+		pid_t child = 1; \
+		int status = 0; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
 		if (setjmp(_metadata->env) == 0) { \
-			fixture_name##_setup(_metadata, &self, variant->data); \
-			/* Let setup failure terminate early. */ \
-                       if (!_metadata->passed || _metadata->skip) \
-				return; \
-			_metadata->setup_completed = true; \
-			fixture_name##_##test_name(_metadata, &self, variant->data); \
+			/* Use the same _metadata. */ \
+			child = vfork(); \
+			if (child == 0) { \
+				fixture_name##_setup(_metadata, &self, variant->data); \
+				/* Let setup failure terminate early. */ \
+				if (!_metadata->passed || _metadata->skip) \
+					_exit(0); \
+				_metadata->setup_completed = true; \
+				fixture_name##_##test_name(_metadata, &self, variant->data); \
+			} else if (child < 0 || child != waitpid(child, &status, 0)) { \
+				ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
+				_metadata->passed = 0; \
+			} \
 		} \
-		if (_metadata->setup_completed) \
+		if (child == 0) { \
+			if (_metadata->setup_completed && !_metadata->teardown_parent) \
+				fixture_name##_teardown(_metadata, &self, variant->data); \
+			_exit(0); \
+		} \
+		if (_metadata->setup_completed && _metadata->teardown_parent) \
 			fixture_name##_teardown(_metadata, &self, variant->data); \
+		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
+			/* Forward signal to __wait_for_test(). */ \
+			kill(getpid(), WTERMSIG(status)); \
 		__test_check_assert(_metadata); \
 	} \
 	static struct __test_metadata \
@@ -404,6 +418,7 @@
 		.fixture = &_##fixture_name##_fixture_object, \
 		.termsig = signal, \
 		.timeout = tmout, \
+		.teardown_parent = false, \
 	 }; \
 	static void __attribute__((constructor)) \
 			_register_##fixture_name##_##test_name(void) \
@@ -694,18 +709,12 @@
 	for (; _metadata->trigger; _metadata->trigger = \
 			__bail(_assert, _metadata))
 
-#define __INC_STEP(_metadata) \
-	/* Keep "step" below 255 (which is used for "SKIP" reporting). */	\
-	if (_metadata->passed && _metadata->step < 253) \
-		_metadata->step++;
-
 #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
 
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
 	__typeof__(_expected) __exp = (_expected); \
 	__typeof__(_seen) __seen = (_seen); \
-	if (_assert) __INC_STEP(_metadata); \
 	if (!(__exp _t __seen)) { \
 		/* Report with actual signedness to avoid weird output. */ \
 		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
@@ -751,7 +760,6 @@
 #define __EXPECT_STR(_expected, _seen, _t, _assert) do { \
 	const char *__exp = (_expected); \
 	const char *__seen = (_seen); \
-	if (_assert) __INC_STEP(_metadata); \
 	if (!(strcmp(__exp, __seen) _t 0))  { \
 		__TH_LOG("Expected '%s' %s '%s'.", __exp, #_t, __seen); \
 		_metadata->passed = 0; \
@@ -837,10 +845,9 @@ struct __test_metadata {
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool timed_out;	/* did this test timeout instead of exiting? */
-	__u8 step;
-	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool setup_completed; /* did setup finish? */
+	bool teardown_parent; /* run teardown in a parent process */
 	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
@@ -873,11 +880,8 @@ static inline int __bail(int for_realz, struct __test_metadata *t)
 
 static inline void __test_check_assert(struct __test_metadata *t)
 {
-	if (t->aborted) {
-		if (t->no_print)
-			_exit(t->step);
+	if (t->aborted)
 		abort();
-	}
 }
 
 struct __test_metadata *__active_test;
@@ -954,13 +958,12 @@ void __wait_for_test(struct __test_metadata *t)
 			case 0:
 				t->passed = 1;
 				break;
-			/* Other failure, assume step report. */
+			/* Failure */
 			default:
 				t->passed = 0;
 				fprintf(TH_LOG_STREAM,
-					"# %s: Test failed at step #%d\n",
-					t->name,
-					WEXITSTATUS(status));
+					"# %s: Test failed\n",
+					t->name);
 			}
 		}
 	} else if (WIFSIGNALED(status)) {
@@ -1114,8 +1117,6 @@ void __run_test(struct __fixture_metadata *f,
 	t->passed = 1;
 	t->skip = 0;
 	t->trigger = 0;
-	t->step = 1;
-	t->no_print = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
 	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
@@ -1137,8 +1138,7 @@ void __run_test(struct __fixture_metadata *f,
 		/* Pass is exit 0 */
 		if (t->passed)
 			_exit(0);
-		/* Something else happened, report the step. */
-		_exit(t->step);
+		_exit(1);
 	} else {
 		__wait_for_test(t);
 	}
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index f40146d40763..401e2eb092a3 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -23,66 +23,8 @@
 #define __maybe_unused __attribute__((__unused__))
 #endif
 
-/*
- * TEST_F_FORK() is useful when a test drop privileges but the corresponding
- * FIXTURE_TEARDOWN() requires them (e.g. to remove files from a directory
- * where write actions are denied).  For convenience, FIXTURE_TEARDOWN() is
- * also called when the test failed, but not when FIXTURE_SETUP() failed.  For
- * this to be possible, we must not call abort() but instead exit smoothly
- * (hence the step print).
- */
-/* clang-format off */
-#define TEST_F_FORK(fixture_name, test_name) \
-	static void fixture_name##_##test_name##_child( \
-		struct __test_metadata *_metadata, \
-		FIXTURE_DATA(fixture_name) *self, \
-		const FIXTURE_VARIANT(fixture_name) *variant); \
-	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT) \
-	{ \
-		int status; \
-		const pid_t child = fork(); \
-		if (child < 0) \
-			abort(); \
-		if (child == 0) { \
-			_metadata->no_print = 1; \
-			fixture_name##_##test_name##_child(_metadata, self, variant); \
-			if (_metadata->skip) \
-				_exit(255); \
-			if (_metadata->passed) \
-				_exit(0); \
-			_exit(_metadata->step); \
-		} \
-		if (child != waitpid(child, &status, 0)) \
-			abort(); \
-		if (WIFSIGNALED(status) || !WIFEXITED(status)) { \
-			_metadata->passed = 0; \
-			_metadata->step = 1; \
-			return; \
-		} \
-		switch (WEXITSTATUS(status)) { \
-		case 0: \
-			_metadata->passed = 1; \
-			break; \
-		case 255: \
-			_metadata->passed = 1; \
-			_metadata->skip = 1; \
-			break; \
-		default: \
-			_metadata->passed = 0; \
-			_metadata->step = WEXITSTATUS(status); \
-			break; \
-		} \
-	} \
-	static void fixture_name##_##test_name##_child( \
-		struct __test_metadata __attribute__((unused)) *_metadata, \
-		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
-		const FIXTURE_VARIANT(fixture_name) \
-			__attribute__((unused)) *variant)
-/* clang-format on */
-
-/* Makes backporting easier. */
-#undef TEST_F
-#define TEST_F(fixture_name, test_name) TEST_F_FORK(fixture_name, test_name)
+/* TEST_F_FORK() should not be used for new tests. */
+#define TEST_F_FORK(fixture_name, test_name) TEST_F(fixture_name, test_name)
 
 #ifndef landlock_create_ruleset
 static inline int
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 2d6d9b43d958..1d5952897e05 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -285,6 +285,8 @@ static void prepare_layout_opt(struct __test_metadata *const _metadata,
 
 static void prepare_layout(struct __test_metadata *const _metadata)
 {
+	_metadata->teardown_parent = true;
+
 	prepare_layout_opt(_metadata, &mnt_tmp);
 }
 
@@ -3861,9 +3863,7 @@ FIXTURE_SETUP(layout1_bind)
 
 FIXTURE_TEARDOWN(layout1_bind)
 {
-	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(0, umount(dir_s2d2));
-	clear_cap(_metadata, CAP_SYS_ADMIN);
+	/* umount(dir_s2d2)) is handled by namespace lifetime. */
 
 	remove_layout1(_metadata);
 
@@ -4276,9 +4276,8 @@ FIXTURE_TEARDOWN(layout2_overlay)
 	EXPECT_EQ(0, remove_path(lower_fl1));
 	EXPECT_EQ(0, remove_path(lower_do1_fo2));
 	EXPECT_EQ(0, remove_path(lower_fo1));
-	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(0, umount(LOWER_BASE));
-	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	/* umount(LOWER_BASE)) is handled by namespace lifetime. */
 	EXPECT_EQ(0, remove_path(LOWER_BASE));
 
 	EXPECT_EQ(0, remove_path(upper_do1_fu3));
@@ -4287,14 +4286,11 @@ FIXTURE_TEARDOWN(layout2_overlay)
 	EXPECT_EQ(0, remove_path(upper_do1_fo2));
 	EXPECT_EQ(0, remove_path(upper_fo1));
 	EXPECT_EQ(0, remove_path(UPPER_WORK "/work"));
-	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(0, umount(UPPER_BASE));
-	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	/* umount(UPPER_BASE)) is handled by namespace lifetime. */
 	EXPECT_EQ(0, remove_path(UPPER_BASE));
 
-	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(0, umount(MERGE_DATA));
-	clear_cap(_metadata, CAP_SYS_ADMIN);
+	/* umount(MERGE_DATA)) is handled by namespace lifetime. */
 	EXPECT_EQ(0, remove_path(MERGE_DATA));
 
 	cleanup_layout(_metadata);
@@ -4691,6 +4687,8 @@ FIXTURE_SETUP(layout3_fs)
 		SKIP(return, "this filesystem is not supported (setup)");
 	}
 
+	_metadata->teardown_parent = true;
+
 	slash = strrchr(variant->file_path, '/');
 	ASSERT_NE(slash, NULL);
 	dir_len = (size_t)slash - (size_t)variant->file_path;
-- 
2.44.0


