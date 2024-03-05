Return-Path: <linux-kselftest+bounces-5953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F80872855
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 21:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D6D2922A7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 20:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3467127B7B;
	Tue,  5 Mar 2024 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="iqRjI1Dy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64EB5C5FD
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669459; cv=none; b=ZbKY2sLxPTtUy97Mpfv77eGZIbP42R1Wv6d4HiyNMegAar2E4p1oLEm+eCz2Q/mniQF1NLJ30+iyUEm9HLKT3TQeU373o4JWA/UGeG3VoUomGhvF0xjqL4dpCufUcZ53XhOYfMqUkOjnLLKamPI6SHIYz8eIZlkjrSPEIZhR8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669459; c=relaxed/simple;
	bh=YagDFFA6rbmtQARJcRghj4PIMIy8y9znN8rxiNy6FWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8MR2zq30FhsXnZIleYovW/a7dttQq0UDBGHS4txKDNJynf85kBrk+/AMBplEP8SqhaBXhTu4tzflhYM5ANGLSL+CHs7echovjukGfl0vv10CKuVek0oWxWUzXyJr2eXnj5kjHWu7RRXRUI1EBgvji8neM6eFKCzzDm/YgF3+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=iqRjI1Dy; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tq6Bh3hBzzMqFcJ;
	Tue,  5 Mar 2024 21:10:52 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tq6Bg4Rt6z3W;
	Tue,  5 Mar 2024 21:10:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709669452;
	bh=YagDFFA6rbmtQARJcRghj4PIMIy8y9znN8rxiNy6FWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqRjI1Dy24DR8Hdurm3d3isbc56yHWvmpEKMfRgZ0QEGyvKHer+cdIGDKvDQeYKas
	 11oLvI7VsJYOxwcNZUAiNi8sfJJyapxPmMqHGWJCPMgb11x7Wk2vDMQCoG++3Tdt3x
	 wtP9I51i9h8vpR3tiipkGYG2oxtCb/Z4Pq8eEIls=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>
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
Subject: [PATCH] selftests/harness: Fix TEST_F()'s vfork handling
Date: Tue,  5 Mar 2024 21:10:29 +0100
Message-ID: <20240305201029.1331333-1-mic@digikod.net>
In-Reply-To: <20240305.sheeF9yain1O@digikod.net>
References: <20240305.sheeF9yain1O@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Always run fixture setup in the grandchild process, and by default also
run the teardown in the same process.  However, this change makes it
possible to run the teardown in a parent process when
_metadata->teardown_parent is set to true (e.g. in fixture setup).

Fix TEST_SIGNAL() by forwarding grandchild's signal to its parent.  Fix
seccomp tests by running the test setup in the parent of the test
thread, as expected by the related test code.  Fix Landlock tests by
waiting for the grandchild before processing _metadata.

Use of exit(3) in tests should be OK because the environment in which
the vfork(2) call happen is already dedicated to the running test (with
flushed stdio, setpgrp() call), see __run_test() and the call to fork(2)
just before running the setup/test/teardown.  Even if the test
configures its own exit handlers, they will not be run by the parent
because it never calls exit(3), and the test function either ends with a
call to _exit(2) or a signal.

Cc: David S. Miller <davem@davemloft.net>
Cc: Günther Noack <gnoack@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
Link: https://lore.kernel.org/r/20240305201029.1331333-1-mic@digikod.net
---
 tools/testing/selftests/kselftest_harness.h | 28 +++++++++++++--------
 tools/testing/selftests/landlock/fs_test.c  | 22 ++++++++--------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 634be793ad58..4fd735e48ee7 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -382,29 +382,33 @@
 		/* fixture data is alloced, setup, and torn down per call. */ \
 		FIXTURE_DATA(fixture_name) self; \
 		pid_t child = 1; \
+		int status = 0; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
 		if (setjmp(_metadata->env) == 0) { \
-			fixture_name##_setup(_metadata, &self, variant->data); \
-			/* Let setup failure terminate early. */ \
-			if (_metadata->exit_code) \
-				return; \
-			_metadata->setup_completed = true; \
 			/* Use the same _metadata. */ \
 			child = vfork(); \
 			if (child == 0) { \
+				fixture_name##_setup(_metadata, &self, variant->data); \
+				/* Let setup failure terminate early. */ \
+				if (_metadata->exit_code) \
+					_exit(0); \
+				_metadata->setup_completed = true; \
 				fixture_name##_##test_name(_metadata, &self, variant->data); \
-				_exit(0); \
-			} \
-			if (child < 0) { \
+			} else if (child < 0 || child != waitpid(child, &status, 0)) { \
 				ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
 				_metadata->exit_code = KSFT_FAIL; \
 			} \
 		} \
-		if (child == 0) \
-			/* Child failed and updated the shared _metadata. */ \
+		if (child == 0) { \
+			if (_metadata->setup_completed && !_metadata->teardown_parent) \
+				fixture_name##_teardown(_metadata, &self, variant->data); \
 			_exit(0); \
-		if (_metadata->setup_completed) \
+		} \
+		if (_metadata->setup_completed && _metadata->teardown_parent) \
 			fixture_name##_teardown(_metadata, &self, variant->data); \
+		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
+			/* Forward signal to __wait_for_test(). */ \
+			kill(getpid(), WTERMSIG(status)); \
 		__test_check_assert(_metadata); \
 	} \
 	static struct __test_metadata \
@@ -414,6 +418,7 @@
 		.fixture = &_##fixture_name##_fixture_object, \
 		.termsig = signal, \
 		.timeout = tmout, \
+		.teardown_parent = false, \
 	 }; \
 	static void __attribute__((constructor)) \
 			_register_##fixture_name##_##test_name(void) \
@@ -873,6 +878,7 @@ struct __test_metadata {
 	bool timed_out;	/* did this test timeout instead of exiting? */
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool setup_completed; /* did setup finish? */
+	bool teardown_parent; /* run teardown in a parent process */
 	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 98817a14c91b..9a6036fbf289 100644
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


