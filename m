Return-Path: <linux-kselftest+bounces-9363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 207AA8BAB44
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 13:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E5F1F21883
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705815534B;
	Fri,  3 May 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZElVIJFC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C7153BE7
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733926; cv=none; b=tf3bz+WfxsKuWbyfPff32rBAEwp8yl6MgZ51LptDpKXs7wsTqh+hs7wv898ZAwypM1yCIh4ZnxA7owsQ9iWT/GQ/F+9rHoDhd+DjRNey/fji/3QTljqWRqlH35nCEfVJD7HMYPclosM0DRWei0HwjdIrqBuPmOHMqESuZUcQQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733926; c=relaxed/simple;
	bh=lkJ/NtXCTI7QEAqlNDktUdaUxThWKrN4RaigHastoj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJwrkYCAM7imIf6G2XDHg5xSJYzwaAyiqZFSDZ1CDTJcQ11VoLKciRF9fJVnXer2vadk9MI4sYwIsBNmeFeLUFl+kHYiIEfpZDukm3/TA+7H0rn9DZKouZNokDFcorX93JYOYu41gxm8d9utfY3dKKHOMDxRJlb9OuLTieguKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZElVIJFC; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VW78J4L8BzCG1;
	Fri,  3 May 2024 12:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714733920;
	bh=lkJ/NtXCTI7QEAqlNDktUdaUxThWKrN4RaigHastoj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZElVIJFCAgAOjIBXklhRcZBuRoxYuY0GrhDZaYuScr5xODgqJojHcwAy4KtXndLfB
	 WMsihYb18N8+v4q83OiqDusMyTfM1NkBQSTjKsgiVvebNgV/AztJkKo6QkIuCbSPAb
	 HuIyz0LfaiDMDDH4XPXUGdJ/IRRsUxmzxQLVudyc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VW78J0n3CzZTv;
	Fri,  3 May 2024 12:58:40 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 09/10] selftests/harness: Fix vfork() side effects
Date: Fri,  3 May 2024 12:58:19 +0200
Message-ID: <20240503105820.300927-10-mic@digikod.net>
In-Reply-To: <20240503105820.300927-1-mic@digikod.net>
References: <20240503105820.300927-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Setting the time namespace with CLONE_NEWTIME returns -EUSERS if the
calling thread shares memory with another thread (because of the shared
vDSO), which is the case when it is created with vfork().

Fix pidfd_setns_test by replacing test harness's vfork() call with a
clone3() call with CLONE_VFORK, and an explicit sharing of the
_metadata and self objects.

Replace _metadata->teardown_parent with a new FIXTURE_TEARDOWN_PARENT()
helper that can replace FIXTURE_TEARDOWN().  This is a cleaner approach
and it enables to selectively share the fixture data between the child
process running tests and the parent process running the fixture
teardown.  This also avoids updating several tests to not rely on the
self object's copy-on-write property (e.g. storing the returned value of
a fork() call).

Cc: Christian Brauner <brauner@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Günther Noack <gnoack@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202403291015.1fcfa957-oliver.sang@intel.com
Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240503105820.300927-10-mic@digikod.net
---

Changes since v1:
* Split changes (suggested by Kees).
* Improve documentation.
* Remove the static fixture_name##_teardown_parent initialisation to
  false (as suggested by checkpatch.pl).
---
 tools/testing/selftests/kselftest_harness.h | 66 ++++++++++++++++-----
 tools/testing/selftests/landlock/fs_test.c  | 16 ++---
 2 files changed, 57 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index ea78bec5856f..eb25f7c11949 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -294,6 +294,32 @@ static inline pid_t clone3_vfork(void)
  * A bare "return;" statement may be used to return early.
  */
 #define FIXTURE_TEARDOWN(fixture_name) \
+	static const bool fixture_name##_teardown_parent; \
+	__FIXTURE_TEARDOWN(fixture_name)
+
+/**
+ * FIXTURE_TEARDOWN_PARENT()
+ * *_metadata* is included so that EXPECT_*, ASSERT_* etc. work correctly.
+ *
+ * @fixture_name: fixture name
+ *
+ * .. code-block:: c
+ *
+ *     FIXTURE_TEARDOWN_PARENT(fixture_name) { implementation }
+ *
+ * Same as FIXTURE_TEARDOWN() but run this code in a parent process.  This
+ * enables the test process to drop its privileges without impacting the
+ * related FIXTURE_TEARDOWN_PARENT() (e.g. to remove files from a directory
+ * where write access was dropped).
+ *
+ * To make it possible for the parent process to use *self*, share (MAP_SHARED)
+ * the fixture data between all forked processes.
+ */
+#define FIXTURE_TEARDOWN_PARENT(fixture_name) \
+	static const bool fixture_name##_teardown_parent = true; \
+	__FIXTURE_TEARDOWN(fixture_name)
+
+#define __FIXTURE_TEARDOWN(fixture_name) \
 	void fixture_name##_teardown( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
@@ -368,10 +394,11 @@ static inline pid_t clone3_vfork(void)
  * Very similar to TEST() except that *self* is the setup instance of fixture's
  * datatype exposed for use by the implementation.
  *
- * The @test_name code is run in a separate process sharing the same memory
- * (i.e. vfork), which means that the test process can update its privileges
- * without impacting the related FIXTURE_TEARDOWN() (e.g. to remove files from
- * a directory where write access was dropped).
+ * The _metadata object is shared (MAP_SHARED) with all the potential forked
+ * processes, which enables them to use EXCEPT_*() and ASSERT_*().
+ *
+ * The *self* object is only shared with the potential forked processes if
+ * FIXTURE_TEARDOWN_PARENT() is used instead of FIXTURE_TEARDOWN().
  */
 #define TEST_F(fixture_name, test_name) \
 	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT)
@@ -392,39 +419,49 @@ static inline pid_t clone3_vfork(void)
 		struct __fixture_variant_metadata *variant) \
 	{ \
 		/* fixture data is alloced, setup, and torn down per call. */ \
-		FIXTURE_DATA(fixture_name) self; \
+		FIXTURE_DATA(fixture_name) self_private, *self = NULL; \
 		pid_t child = 1; \
 		int status = 0; \
 		/* Makes sure there is only one teardown, even when child forks again. */ \
 		bool *teardown = mmap(NULL, sizeof(*teardown), \
 			PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
 		*teardown = false; \
-		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
+		if (sizeof(*self) > 0) { \
+			if (fixture_name##_teardown_parent) { \
+				self = mmap(NULL, sizeof(*self), PROT_READ | PROT_WRITE, \
+					MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
+			} else { \
+				memset(&self_private, 0, sizeof(self_private)); \
+				self = &self_private; \
+			} \
+		} \
 		if (setjmp(_metadata->env) == 0) { \
-			/* Use the same _metadata. */ \
-			child = vfork(); \
+			/* _metadata and potentially self are shared with all forks. */ \
+			child = clone3_vfork(); \
 			if (child == 0) { \
-				fixture_name##_setup(_metadata, &self, variant->data); \
+				fixture_name##_setup(_metadata, self, variant->data); \
 				/* Let setup failure terminate early. */ \
 				if (_metadata->exit_code) \
 					_exit(0); \
 				_metadata->setup_completed = true; \
-				fixture_name##_##test_name(_metadata, &self, variant->data); \
+				fixture_name##_##test_name(_metadata, self, variant->data); \
 			} else if (child < 0 || child != waitpid(child, &status, 0)) { \
 				ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
 				_metadata->exit_code = KSFT_FAIL; \
 			} \
 		} \
 		if (child == 0) { \
-			if (_metadata->setup_completed && !_metadata->teardown_parent && \
+			if (_metadata->setup_completed && !fixture_name##_teardown_parent && \
 					__sync_bool_compare_and_swap(teardown, false, true)) \
-				fixture_name##_teardown(_metadata, &self, variant->data); \
+				fixture_name##_teardown(_metadata, self, variant->data); \
 			_exit(0); \
 		} \
-		if (_metadata->setup_completed && _metadata->teardown_parent && \
+		if (_metadata->setup_completed && fixture_name##_teardown_parent && \
 				__sync_bool_compare_and_swap(teardown, false, true)) \
-			fixture_name##_teardown(_metadata, &self, variant->data); \
+			fixture_name##_teardown(_metadata, self, variant->data); \
 		munmap(teardown, sizeof(*teardown)); \
+		if (self && fixture_name##_teardown_parent) \
+			munmap(self, sizeof(*self)); \
 		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
 			/* Forward signal to __wait_for_test(). */ \
 			kill(getpid(), WTERMSIG(status)); \
@@ -895,7 +932,6 @@ struct __test_metadata {
 	bool timed_out;	/* did this test timeout instead of exiting? */
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool setup_completed; /* did setup finish? */
-	bool teardown_parent; /* run teardown in a parent process */
 	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 1e2cffde02b5..27744524df51 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -286,8 +286,6 @@ static void prepare_layout_opt(struct __test_metadata *const _metadata,
 
 static void prepare_layout(struct __test_metadata *const _metadata)
 {
-	_metadata->teardown_parent = true;
-
 	prepare_layout_opt(_metadata, &mnt_tmp);
 }
 
@@ -316,7 +314,7 @@ FIXTURE_SETUP(layout0)
 	prepare_layout(_metadata);
 }
 
-FIXTURE_TEARDOWN(layout0)
+FIXTURE_TEARDOWN_PARENT(layout0)
 {
 	cleanup_layout(_metadata);
 }
@@ -379,7 +377,7 @@ FIXTURE_SETUP(layout1)
 	create_layout1(_metadata);
 }
 
-FIXTURE_TEARDOWN(layout1)
+FIXTURE_TEARDOWN_PARENT(layout1)
 {
 	remove_layout1(_metadata);
 
@@ -3692,7 +3690,7 @@ FIXTURE_SETUP(ftruncate)
 	create_file(_metadata, file1_s1d1);
 }
 
-FIXTURE_TEARDOWN(ftruncate)
+FIXTURE_TEARDOWN_PARENT(ftruncate)
 {
 	EXPECT_EQ(0, remove_path(file1_s1d1));
 	cleanup_layout(_metadata);
@@ -3870,7 +3868,7 @@ FIXTURE_SETUP(layout1_bind)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
-FIXTURE_TEARDOWN(layout1_bind)
+FIXTURE_TEARDOWN_PARENT(layout1_bind)
 {
 	/* umount(dir_s2d2)) is handled by namespace lifetime. */
 
@@ -4275,7 +4273,7 @@ FIXTURE_SETUP(layout2_overlay)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
-FIXTURE_TEARDOWN(layout2_overlay)
+FIXTURE_TEARDOWN_PARENT(layout2_overlay)
 {
 	if (self->skip_test)
 		SKIP(return, "overlayfs is not supported (teardown)");
@@ -4708,8 +4706,6 @@ FIXTURE_SETUP(layout3_fs)
 		SKIP(return, "this filesystem is not supported (setup)");
 	}
 
-	_metadata->teardown_parent = true;
-
 	prepare_layout_opt(_metadata, &variant->mnt);
 
 	/* Creates directory when required. */
@@ -4743,7 +4739,7 @@ FIXTURE_SETUP(layout3_fs)
 	free(dir_path);
 }
 
-FIXTURE_TEARDOWN(layout3_fs)
+FIXTURE_TEARDOWN_PARENT(layout3_fs)
 {
 	if (self->skip_test)
 		SKIP(return, "this filesystem is not supported (teardown)");
-- 
2.45.0


