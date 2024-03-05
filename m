Return-Path: <linux-kselftest+bounces-5928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808A5872315
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 16:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BED1C22E4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E9E127B4A;
	Tue,  5 Mar 2024 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dp/pNqKv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B08664C;
	Tue,  5 Mar 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653649; cv=none; b=nP/WxgJJoJKsgl9C78Qhx6pzIcySSV3+qiFzP7fEyJuqLKEbLY5yBf8+nilXoG+iwhzZa08NrNCJVVGUs4wHk8loCD43g8vuzxc7e2JQlYQvEKe4I0p6K9KKzSwwk70m2XZz2B33IOXrfTd1b6fP2r9XTQEneaKR+aXfX1pqWfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653649; c=relaxed/simple;
	bh=duBANKVhq58rBHhVYkw7FTlZOWm2zo4TG4uCQWF95e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXOwlNUGAs+UaMmlTkeEiHCF1kbzxwuulx9i7d25h6w+xS3iY7kD9HmjLLz3lpaM+gn/m+kqgzv0cHXQIapSLPoZ/EECUVtI/7X5ZPTSPKZsVP22C5Iu1SScdYLWjKsfJuBU/0Gh1nWf9KoHRHpwQMd+84gDoefM3ohpdcn1NAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dp/pNqKv; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tq0LW5MRvz1nq;
	Tue,  5 Mar 2024 16:47:15 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tq0LV6S2ZzCKN;
	Tue,  5 Mar 2024 16:47:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709653635;
	bh=duBANKVhq58rBHhVYkw7FTlZOWm2zo4TG4uCQWF95e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dp/pNqKvQb4HclVSuUUg/mHvDvYH+GVnYA+Lanaiuq9GbxhHsWD+YDLySuBCemll0
	 EhCQIdpGnmW1y1mdVMbI2iQn45K5pa5GGov356x4qfxOtVrj4NJOVsG+Jf3yssjG1j
	 4MWaL1drChA5WJrw2nwTS42luJy8+sjNrC8ERdGY=
Date: Tue, 5 Mar 2024 16:47:04 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, jakub@cloudflare.com, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v4 02/12] selftests/harness: Merge TEST_F_FORK() into
 TEST_F()
Message-ID: <20240305.eth2Ohcawa7u@digikod.net>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <20240229005920.2407409-3-kuba@kernel.org>
 <20240301.Miem9Kei4eev@digikod.net>
 <20240304.ceje1phaiFei@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304.ceje1phaiFei@digikod.net>
X-Infomaniak-Routing: alpha

I think I fixed all reported issues with the following patch.  It always
execute the fixture setup in the child process and execute the teardown
in the child process by default (e.g. for seccomp tests which have
assumptions about that). Only the Landlock teardown tests are executed
in the parent process thanks to the new _metadata->teardown_parent
boolean.  Child signals are always forwarded to the parent process where
__wait_for_test() check that.  This works with seccomp and Landlock
tests, and I think with all the others.  I'll send a v2 of the vfork
patch.

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index ad49832457af..4f192904dfd6 100644
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
-			if (!_metadata->passed || _metadata->skip) \
-				return; \
-			_metadata->setup_completed = true; \
 			/* Use the same _metadata. */ \
 			child = vfork(); \
 			if (child == 0) { \
+				fixture_name##_setup(_metadata, &self, variant->data); \
+				/* Let setup failure terminate early. */ \
+				if (!_metadata->passed || _metadata->skip) \
+					_exit(0); \
+				_metadata->setup_completed = true; \
 				fixture_name##_##test_name(_metadata, &self, variant->data); \
-				_exit(0); \
-			} \
-			if (child < 0) { \
+			} else if (child < 0 || child != waitpid(child, &status, 0)) { \
 				ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
 				_metadata->passed = 0; \
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
@@ -842,6 +847,7 @@ struct __test_metadata {
 	bool timed_out;	/* did this test timeout instead of exiting? */
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool setup_completed; /* did setup finish? */
+	bool teardown_parent; /* run teardown in a parent process */
 	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
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


On Mon, Mar 04, 2024 at 08:31:49PM +0100, Mickaël Salaün wrote:
> On Mon, Mar 04, 2024 at 08:27:50PM +0100, Mickaël Salaün wrote:
> > Testing the whole series, I found that some Landlock tests are flaky
> > starting with this patch.  I tried to not use the longjmp in the
> > grandchild but it didn't change.  I suspect missing volatiles but I
> > didn't find the faulty one(s) yet. :/
> > I'll continue investigating tomorrow but help would be much appreciated!
> 
> The issue is with the fs_test.c, often starting with this one:
> 
> #  RUN           layout1.relative_chroot_only ...
> # fs_test.c:294:relative_chroot_only:Expected 0 (0) == umount(TMP_DIR) (-1)
> # fs_test.c:296:relative_chroot_only:Expected 0 (0) == remove_path(TMP_DIR) (16)
> # relative_chroot_only: Test failed
> #          FAIL  layout1.relative_chroot_only
> 
> ...or this one:
> 
> #  RUN           layout3_fs.hostfs.tag_inode_dir_child ...
> # fs_test.c:4707:tag_inode_dir_child:Expected 0 (0) == mkdir(self->dir_path, 0700) (-1)
> # fs_test.c:4709:tag_inode_dir_child:Failed to create directory "tmp/dir": No such file or directory
> # fs_test.c:4724:tag_inode_dir_child:Expected 0 (0) <= fd (-1)
> # fs_test.c:4726:tag_inode_dir_child:Failed to create file "tmp/dir/file": No such file or directory
> # fs_test.c:4729:tag_inode_dir_child:Expected 0 (0) == close(fd) (-1)
> # tag_inode_dir_child: Test failed
> #          FAIL  layout3_fs.hostfs.tag_inode_dir_child
> 

This was because the vfork() wasn't followed by a wait().

> 
> > 
> > 
> > On Wed, Feb 28, 2024 at 04:59:09PM -0800, Jakub Kicinski wrote:
> > > From: Mickaël Salaün <mic@digikod.net>
> > > 
> > > Replace Landlock-specific TEST_F_FORK() with an improved TEST_F() which
> > > brings four related changes:
> > > 
> > > Run TEST_F()'s tests in a grandchild process to make it possible to
> > > drop privileges and delegate teardown to the parent.
> > > 
> > > Compared to TEST_F_FORK(), simplify handling of the test grandchild
> > > process thanks to vfork(2), and makes it generic (e.g. no explicit
> > > conversion between exit code and _metadata).
> > > 
> > > Compared to TEST_F_FORK(), run teardown even when tests failed with an
> > > assert thanks to commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN
> > > for ASSERT failures").
> > > 
> > > Simplify the test harness code by removing the no_print and step fields
> > > which are not used.  I added this feature just after I made
> > > kselftest_harness.h more broadly available but this step counter
> > > remained even though it wasn't needed after all. See commit 369130b63178
> > > ("selftests: Enhance kselftest_harness.h to print which assert failed").
> > > 
> > > Replace spaces with tabs in one line of __TEST_F_IMPL().
> > > 
> > > Cc: Günther Noack <gnoack@google.com>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: Will Drewry <wad@chromium.org>
> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > --
> > > v4:
> > >  - GAND -> GRAND
> > >  - init child to 1, otherwise assert in setup triggers a longjmp
> > >    which in turn reads child without it ever getting initialized
> > >    (or being 0, i.e. we mistakenly assume we're in the grandchild)
> > 
> > Good catch!

