Return-Path: <linux-kselftest+bounces-5441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01CB867BC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 17:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6536728548D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C7E12D75F;
	Mon, 26 Feb 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fRemlhUx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DE12D772
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964638; cv=none; b=UkU/S2Mlr9v43iZj/N838vdi0vGF+NWg1xIytD4ZNwsI9T+BqayuLo6DI1o6rO9tyblEcPurS/74khrGD3SxOKTHZ6iol2KxR/FqHtYEGeqPooTkGA0HDkPvMx2WGxz1e+/Ev2pMUXX64gyAf600j5TI7Mz8rSaaeWSvXs37/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964638; c=relaxed/simple;
	bh=c3Zr+OccwjA0SrXPF9UpZOuGeG4y5Fl0LEH4JSHh5Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qfp8/fiKSXMEMZq426GGibwgJ7SO/xXhJCzDb5/6DKqbwuffYyJUpqscehzOrpTNekR1FlW4coUTR13Y3mVNc55DyNzhKNiUs4Dkru5HG1EfhA3tXx46plcLs6h7bSjsqIkNMGcXi8ZApOZGdi/TKG4W53E4XJK9U96wQGNkKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=fRemlhUx; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tk5XM2WdFzMpnw8;
	Mon, 26 Feb 2024 17:23:47 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tk5XL5Hcfz6YY;
	Mon, 26 Feb 2024 17:23:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708964627;
	bh=c3Zr+OccwjA0SrXPF9UpZOuGeG4y5Fl0LEH4JSHh5Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRemlhUxf+yObrmNhLGPbS/xZGyxsFXGUuvYl2zs5JGCqpbDof2KTLcPJjw7gYnMk
	 QcJwWnRqnO27scec/HibAkHYfE4txhVs/B0GrG5uzjCgVEZ8UZIvRTyYpMEk6YB3LQ
	 8ZjwxKNDrQU1Eb7ctLxuXkyhZTihAeQzWiGg/1k8=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH 2/2] selftests/harness: Merge TEST_F_FORK() into TEST_F()
Date: Mon, 26 Feb 2024 17:23:35 +0100
Message-ID: <20240226162335.3532920-3-mic@digikod.net>
In-Reply-To: <20240226162335.3532920-1-mic@digikod.net>
References: <20240223160259.22c61d1e@kernel.org>
 <20240226162335.3532920-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Remplace Landlock-specific TEST_F_FORK() with an improved TEST_F() which
brings four related changes:

Run TEST_F()'s tests in a grandchild process to make it possible to
drop privileges and delegate teardown to the parent.

Compared to TEST_F_FORK(), simplify handling of the test grandchild
process thanks to vfork(2), and makes it generic (e.g. no explicit
conversion between exit code and _metadata).

Compared to TEST_F_FORK(), run teardown even when tests failed with an
assert thanks to commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN
for ASSERT failures").

Simplify the test harness code by removing the no_print and step fields
which are not used.  I added this feature just after I made
kselftest_harness.h more broadly available but this step counter
remained even though it wasn't needed after all. See commit 369130b63178
("selftests: Enhance kselftest_harness.h to print which assert failed").

Replace spaces with tabs in one line of __TEST_F_IMPL().

Cc: Günther Noack <gnoack@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/kselftest_harness.h | 56 +++++++++----------
 tools/testing/selftests/landlock/common.h   | 62 +--------------------
 2 files changed, 27 insertions(+), 91 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index e05ac8261046..841d34deb1a6 100644
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
@@ -384,15 +381,28 @@
 	{ \
 		/* fixture data is alloced, setup, and torn down per call. */ \
 		FIXTURE_DATA(fixture_name) self; \
+		pid_t child; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
 		if (setjmp(_metadata->env) == 0) { \
 			fixture_name##_setup(_metadata, &self, variant->data); \
 			/* Let setup failure terminate early. */ \
-                       if (!_metadata->passed || _metadata->skip) \
+			if (!_metadata->passed || _metadata->skip) \
 				return; \
 			_metadata->setup_completed = true; \
-			fixture_name##_##test_name(_metadata, &self, variant->data); \
+			/* Use the same _metadata. */ \
+			child = vfork(); \
+			if (child == 0) { \
+				fixture_name##_##test_name(_metadata, &self, variant->data); \
+				_exit(0); \
+			} \
+			if (child < 0) { \
+				ksft_print_msg("ERROR SPAWNING TEST GANDCHILD\n"); \
+				_metadata->passed = 0; \
+			} \
 		} \
+		if (child == 0) \
+			/* Child failed and updated the shared _metadata. */ \
+			_exit(0); \
 		if (_metadata->setup_completed) \
 			fixture_name##_teardown(_metadata, &self, variant->data); \
 		__test_check_assert(_metadata); \
@@ -694,18 +704,12 @@
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
@@ -751,7 +755,6 @@
 #define __EXPECT_STR(_expected, _seen, _t, _assert) do { \
 	const char *__exp = (_expected); \
 	const char *__seen = (_seen); \
-	if (_assert) __INC_STEP(_metadata); \
 	if (!(strcmp(__exp, __seen) _t 0))  { \
 		__TH_LOG("Expected '%s' %s '%s'.", __exp, #_t, __seen); \
 		_metadata->passed = 0; \
@@ -837,8 +840,6 @@ struct __test_metadata {
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool timed_out;	/* did this test timeout instead of exiting? */
-	__u8 step;
-	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool setup_completed; /* did setup finish? */
 	jmp_buf env;	/* for exiting out of test early */
@@ -873,11 +874,8 @@ static inline int __bail(int for_realz, struct __test_metadata *t)
 
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
@@ -954,13 +952,12 @@ void __wait_for_test(struct __test_metadata *t)
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
@@ -1114,8 +1111,6 @@ void __run_test(struct __fixture_metadata *f,
 	t->passed = 1;
 	t->skip = 0;
 	t->trigger = 0;
-	t->step = 1;
-	t->no_print = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
 	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
@@ -1137,8 +1132,7 @@ void __run_test(struct __fixture_metadata *f,
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
index 0bc15d36971a..7e2b431b9f90 100644
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
-- 
2.44.0


