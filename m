Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683C923D132
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 21:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgHET5k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 15:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgHEQnw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 12:43:52 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D8EC0086CB
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Aug 2020 07:13:48 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id o36so8789806ooi.11
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Aug 2020 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=aRlEACQYRDhybx8Cl4FMk6zTDQ3Az4xNUrCzfez0AtI=;
        b=MR2mmFuTHbSF7aOtG6U2rsCx7M43x1JJOV24hVVUiNBwXj09Ad+PyBs6fpEYuwJ8SO
         o/AndKFlF6q2h8tBUyqfGhfv7q/nBa4FBIGNsmoE40zP+v2GHXod9uxISlhyirKZ4tNW
         oAB6vEKsWPh/eQgizvejy+CoG38i5xCMnyQOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=aRlEACQYRDhybx8Cl4FMk6zTDQ3Az4xNUrCzfez0AtI=;
        b=iFamop374aIcWLHVDjT32Be5mha0JsJIejaadJi9O7I4OR2y2tP6ih0JnXytlxWybQ
         ptYrr5TIixX1xLfA3c+A6ER+BlM5uOlIlA99pGJ0yL3EpufgkoIB+V5hem9CLcWduyxG
         POqTRZZLWz8zlFiAvXLTU0r5DyZ01F2VagFIFZ6qoRBEyQXQ0uOuicRdc/kHWmv5DiB+
         q61oWfgYksGqShloqZDplIchP90kMCti5JcSnhtVeVxBDdh1zxtthtjjcrGqyr2+CwFx
         xJV3aN1/g6PHmreUk9tKnw922TQp0EyKQXXprJq+M9j6KnJjeJkoRNmVIbbttbTN4Vwz
         sINA==
X-Gm-Message-State: AOAM532Q6NH6YtnA0BEmeynVPRiGbhR8DQWx8wltt/1WN9d0Nbd1YJ2T
        mTcWcRtEDHWRFYcMi0NwBhiV2w==
X-Google-Smtp-Source: ABdhPJyvASPIUq1f0IcUU5iZ4N7c1vG+NnSytys8qybplI5lm1mCaUaasXwOcjfUfaTXtK2gMs9gDQ==
X-Received: by 2002:a4a:9298:: with SMTP id i24mr3025517ooh.5.1596636825982;
        Wed, 05 Aug 2020 07:13:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v75sm454121oie.25.2020.08.05.07.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 07:13:45 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <0e3a9c1f-7ac6-33e2-ed11-5a56659fc5f7@linuxfoundation.org>
 <CAHk-=wi4iDwuazgXQ-1yvM_JMTBepi9rc-zfSMeyjfDgSS2fgA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8d894cb3-83ac-66bc-48ec-dc273d1afcbe@linuxfoundation.org>
Date:   Wed, 5 Aug 2020 08:13:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi4iDwuazgXQ-1yvM_JMTBepi9rc-zfSMeyjfDgSS2fgA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------30EADDB4BC2B14BAD175AA6B"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------30EADDB4BC2B14BAD175AA6B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/20 12:00 AM, Linus Torvalds wrote:
> On Tue, Aug 4, 2020 at 2:56 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Please pull the following Kselftest update for Linux 5.9-rc1.
> 
> Shortlog? diffstat? And the actual git address to pull from?
> 
> I see the attached diff, and I'm sure I could guess what branch you
> want me to pull from, but please do a proper pull request.
> 
>              Linus
> 

My apologies. I was so focused on summarizing the conflict between the
commits, I messed up the pull request text. Let me try this again.

Please pull the following Kselftest update for Linux 5.9-rc1.

This Kselftest update for Linux 5.9-rc1 consists of

- TAP output reporting related fixes from Paolo Bonzini and Kees Cook.
   These fixes make it skip reporting consistent with TAP format.
- Cleanup fixes to framework run_tests from Yauheni Kaliuta

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

   Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.9-rc1

for you to fetch changes up to 850d0cc64c8e2e0895acf735ac0a53c78b80dbe5:

   selftests/harness: Limit step counter reporting (2020-07-17 13:56:35 
-0600)

----------------------------------------------------------------
linux-kselftest-5.9-rc1

This Kselftest update for Linux 5.9-rc1 consists of

- TAP output reporting related fixes from Paolo Bonzini and Kees Cook.
   These fixes make it skip reporting consistent with TAP format.
- Cleanup fixes to framework run_tests from Yauheni Kaliuta

----------------------------------------------------------------
Alexander A. Klimov (1):
       Replace HTTP links with HTTPS ones: KMOD KERNEL MODULE LOADER - 
USERMODE HELPER

Kees Cook (13):
       selftests/clone3: Reorder reporting output
       selftests: Remove unneeded selftest API headers
       selftests/binderfs: Fix harness API usage
       selftests: Add header documentation and helpers
       selftests/harness: Switch to TAP output
       selftests/harness: Refactor XFAIL into SKIP
       selftests/harness: Display signed values correctly
       selftests/harness: Report skip reason
       selftests: kmod: Add module address visibility test
       selftests/harness: Clean up kern-doc for fixtures
       selftests/seccomp: Refactor to use fixture variants
       selftests/seccomp: Check ENOSYS under tracing
       selftests/harness: Limit step counter reporting

Paolo Bonzini (7):
       kselftest: fix TAP output for skipped tests
       selftests: breakpoints: fix computation of test plan
       selftests: breakpoints: do not use ksft_exit_skip after ksft_set_plan
       selftests: sigaltstack: do not use ksft_exit_skip after ksft_set_plan
       selftests: sync_test: do not use ksft_exit_skip after ksft_set_plan
       selftests: pidfd: do not use ksft_exit_skip after ksft_set_plan
       selftests: pidfd: skip test if unshare fails with EPERM

Yauheni Kaliuta (2):
       selftests: do not use .ONESHELL
       selftests: fix condition in run_tests
  .../breakpoints/step_after_suspend_test.c          |  53 ++--
  tools/testing/selftests/clone3/clone3.c            |   2 +-
  .../selftests/clone3/clone3_clear_sighand.c        |   3 +-
  tools/testing/selftests/clone3/clone3_set_tid.c    |   2 +-
  .../selftests/filesystems/binderfs/binderfs_test.c | 284 
+++++++++++----------
  tools/testing/selftests/kmod/kmod.sh               |  38 ++-
  tools/testing/selftests/kselftest.h                | 106 +++++++-
  tools/testing/selftests/kselftest/runner.sh        |   2 +-
  tools/testing/selftests/kselftest_harness.h        | 181 +++++++++----
  tools/testing/selftests/lib.mk                     |  20 +-
  .../selftests/pid_namespace/regression_enomem.c    |   1 -
  tools/testing/selftests/pidfd/pidfd_getfd_test.c   |   1 -
  tools/testing/selftests/pidfd/pidfd_setns_test.c   |   1 -
  tools/testing/selftests/pidfd/pidfd_test.c         |  55 +++-
  tools/testing/selftests/seccomp/seccomp_bpf.c      | 225 +++++-----------
  tools/testing/selftests/sigaltstack/sas.c          |   4 +-
  tools/testing/selftests/sync/sync_test.c           |   2 +-
  tools/testing/selftests/uevent/uevent_filtering.c  |   1 -
  18 files changed, 570 insertions(+), 411 deletions(-)

----------------------------------------------------------------

--------------30EADDB4BC2B14BAD175AA6B
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.9-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.9-rc1.diff"

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index b3ead29c6089..2cf6f10ab7c4 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -47,7 +47,7 @@ void child(int cpu)
 	_exit(0);
 }
 
-bool run_test(int cpu)
+int run_test(int cpu)
 {
 	int status;
 	pid_t pid = fork();
@@ -55,7 +55,7 @@ bool run_test(int cpu)
 
 	if (pid < 0) {
 		ksft_print_msg("fork() failed: %s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (pid == 0)
 		child(cpu);
@@ -63,67 +63,68 @@ bool run_test(int cpu)
 	wpid = waitpid(pid, &status, __WALL);
 	if (wpid != pid) {
 		ksft_print_msg("waitpid() failed: %s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (!WIFSTOPPED(status)) {
 		ksft_print_msg("child did not stop: %s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (WSTOPSIG(status) != SIGSTOP) {
 		ksft_print_msg("child did not stop with SIGSTOP: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 
 	if (ptrace(PTRACE_SINGLESTEP, pid, NULL, NULL) < 0) {
 		if (errno == EIO) {
-			ksft_exit_skip(
+			ksft_print_msg(
 				"ptrace(PTRACE_SINGLESTEP) not supported on this architecture: %s\n",
 				strerror(errno));
+			return KSFT_SKIP;
 		}
 		ksft_print_msg("ptrace(PTRACE_SINGLESTEP) failed: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 
 	wpid = waitpid(pid, &status, __WALL);
 	if (wpid != pid) {
 		ksft_print_msg("waitpid() failed: $s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (WIFEXITED(status)) {
 		ksft_print_msg("child did not single-step: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (!WIFSTOPPED(status)) {
 		ksft_print_msg("child did not stop: %s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (WSTOPSIG(status) != SIGTRAP) {
 		ksft_print_msg("child did not stop with SIGTRAP: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 
 	if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
 		ksft_print_msg("ptrace(PTRACE_CONT) failed: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 
 	wpid = waitpid(pid, &status, __WALL);
 	if (wpid != pid) {
 		ksft_print_msg("waitpid() failed: %s\n", strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 	if (!WIFEXITED(status)) {
 		ksft_print_msg("child did not exit after PTRACE_CONT: %s\n",
 			strerror(errno));
-		return false;
+		return KSFT_FAIL;
 	}
 
-	return true;
+	return KSFT_PASS;
 }
 
 void suspend(void)
@@ -183,32 +184,38 @@ int main(int argc, char **argv)
 		}
 	}
 
+	err = sched_getaffinity(0, sizeof(available_cpus), &available_cpus);
+	if (err < 0)
+		ksft_exit_fail_msg("sched_getaffinity() failed\n");
+
 	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
 		if (!CPU_ISSET(cpu, &available_cpus))
 			continue;
 		tests++;
 	}
-	ksft_set_plan(tests);
 
 	if (do_suspend)
 		suspend();
 
-	err = sched_getaffinity(0, sizeof(available_cpus), &available_cpus);
-	if (err < 0)
-		ksft_exit_fail_msg("sched_getaffinity() failed\n");
-
+	ksft_set_plan(tests);
 	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
-		bool test_success;
+		int test_success;
 
 		if (!CPU_ISSET(cpu, &available_cpus))
 			continue;
 
 		test_success = run_test(cpu);
-		if (test_success) {
+		switch (test_success) {
+		case KSFT_PASS:
 			ksft_test_result_pass("CPU %d\n", cpu);
-		} else {
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("CPU %d\n", cpu);
+			break;
+		case KSFT_FAIL:
 			ksft_test_result_fail("CPU %d\n", cpu);
 			succeeded = false;
+			break;
 		}
 	}
 
diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index f14c269a5a18..b7e6dec36173 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -131,9 +131,9 @@ int main(int argc, char *argv[])
 
 	uid_t uid = getuid();
 
-	test_clone3_supported();
 	ksft_print_header();
 	ksft_set_plan(17);
+	test_clone3_supported();
 
 	/* Just a simple clone3() should return 0.*/
 	test_clone3(0, 0, 0, CLONE3_ARGS_NO_TEST);
diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
index 9e1af8aa7698..db5fc9c5edcf 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -119,9 +119,8 @@ static void test_clone3_clear_sighand(void)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	test_clone3_supported();
-
 	ksft_set_plan(1);
+	test_clone3_supported();
 
 	test_clone3_clear_sighand();
 
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 25beb22f35b5..5831c1082d6d 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -157,8 +157,8 @@ int main(int argc, char *argv[])
 	pid_t set_tid[MAX_PID_NS_LEVEL * 2];
 
 	ksft_print_header();
-	test_clone3_supported();
 	ksft_set_plan(29);
+	test_clone3_supported();
 
 	if (pipe(pipe_1) < 0 || pipe(pipe_2) < 0)
 		ksft_exit_fail_msg("pipe() failed\n");
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 8a6b507e34a8..1d27f52c61e6 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -21,7 +21,6 @@
 #include <linux/android/binder.h>
 #include <linux/android/binderfs.h>
 
-#include "../../kselftest.h"
 #include "../../kselftest_harness.h"
 
 #define DEFAULT_THREADS 4
@@ -37,37 +36,26 @@
 		fd = -EBADF;        \
 	}
 
-#define log_exit(format, ...)                                                  \
-	({                                                                     \
-		fprintf(stderr, format "\n", ##__VA_ARGS__);                   \
-		exit(EXIT_FAILURE);                                            \
-	})
-
-static void change_mountns(void)
+static void change_mountns(struct __test_metadata *_metadata)
 {
 	int ret;
 
 	ret = unshare(CLONE_NEWNS);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to unshare mount namespace\n",
-				   strerror(errno));
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to unshare mount namespace",
+			strerror(errno));
+	}
 
 	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to mount / as private\n",
-				   strerror(errno));
-}
-
-static void rmdir_protect_errno(const char *dir)
-{
-	int saved_errno = errno;
-	(void)rmdir(dir);
-	errno = saved_errno;
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to mount / as private",
+			strerror(errno));
+	}
 }
 
-static int __do_binderfs_test(void)
+static int __do_binderfs_test(struct __test_metadata *_metadata)
 {
-	int fd, ret, saved_errno;
+	int fd, ret, saved_errno, result = 1;
 	size_t len;
 	ssize_t wret;
 	struct binderfs_device device = { 0 };
@@ -75,113 +63,107 @@ static int __do_binderfs_test(void)
 	char binderfs_mntpt[] = P_tmpdir "/binderfs_XXXXXX",
 		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
 
-	change_mountns();
+	change_mountns(_metadata);
 
-	if (!mkdtemp(binderfs_mntpt))
-		ksft_exit_fail_msg(
-			"%s - Failed to create binderfs mountpoint\n",
+	EXPECT_NE(mkdtemp(binderfs_mntpt), NULL) {
+		TH_LOG("%s - Failed to create binderfs mountpoint",
 			strerror(errno));
+		goto out;
+	}
 
 	ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
-	if (ret < 0) {
-		if (errno != ENODEV)
-			ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
-					   strerror(errno));
-
-		rmdir_protect_errno(binderfs_mntpt);
-		return 1;
+	EXPECT_EQ(ret, 0) {
+		if (errno == ENODEV)
+			XFAIL(goto out, "binderfs missing");
+		TH_LOG("%s - Failed to mount binderfs", strerror(errno));
+		goto rmdir;
 	}
 
-	/* binderfs mount test passed */
-	ksft_inc_pass_cnt();
+	/* success: binderfs mounted */
 
 	memcpy(device.name, "my-binder", strlen("my-binder"));
 
 	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
 	fd = open(device_path, O_RDONLY | O_CLOEXEC);
-	if (fd < 0)
-		ksft_exit_fail_msg(
-			"%s - Failed to open binder-control device\n",
+	EXPECT_GE(fd, 0) {
+		TH_LOG("%s - Failed to open binder-control device",
 			strerror(errno));
+		goto umount;
+	}
 
 	ret = ioctl(fd, BINDER_CTL_ADD, &device);
 	saved_errno = errno;
 	close(fd);
 	errno = saved_errno;
-	if (ret < 0) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg(
-			"%s - Failed to allocate new binder device\n",
+	EXPECT_GE(ret, 0) {
+		TH_LOG("%s - Failed to allocate new binder device",
 			strerror(errno));
+		goto umount;
 	}
 
-	ksft_print_msg(
-		"Allocated new binder device with major %d, minor %d, and name %s\n",
+	TH_LOG("Allocated new binder device with major %d, minor %d, and name %s",
 		device.major, device.minor, device.name);
 
-	/* binder device allocation test passed */
-	ksft_inc_pass_cnt();
+	/* success: binder device allocation */
 
 	snprintf(device_path, sizeof(device_path), "%s/my-binder", binderfs_mntpt);
 	fd = open(device_path, O_CLOEXEC | O_RDONLY);
-	if (fd < 0) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg("%s - Failed to open my-binder device\n",
-				   strerror(errno));
+	EXPECT_GE(fd, 0) {
+		TH_LOG("%s - Failed to open my-binder device",
+			strerror(errno));
+		goto umount;
 	}
 
 	ret = ioctl(fd, BINDER_VERSION, &version);
 	saved_errno = errno;
 	close(fd);
 	errno = saved_errno;
-	if (ret < 0) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg(
-			"%s - Failed to open perform BINDER_VERSION request\n",
+	EXPECT_GE(ret, 0) {
+		TH_LOG("%s - Failed to open perform BINDER_VERSION request",
 			strerror(errno));
+		goto umount;
 	}
 
-	ksft_print_msg("Detected binder version: %d\n",
-		       version.protocol_version);
+	TH_LOG("Detected binder version: %d", version.protocol_version);
 
-	/* binder transaction with binderfs binder device passed */
-	ksft_inc_pass_cnt();
+	/* success: binder transaction with binderfs binder device */
 
 	ret = unlink(device_path);
-	if (ret < 0) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg("%s - Failed to delete binder device\n",
-				   strerror(errno));
+	EXPECT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to delete binder device",
+			strerror(errno));
+		goto umount;
 	}
 
-	/* binder device removal passed */
-	ksft_inc_pass_cnt();
+	/* success: binder device removal */
 
 	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
 	ret = unlink(device_path);
-	if (!ret) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg("Managed to delete binder-control device\n");
-	} else if (errno != EPERM) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg(
-			"%s - Failed to delete binder-control device but exited with unexpected error code\n",
+	EXPECT_NE(ret, 0) {
+		TH_LOG("Managed to delete binder-control device");
+		goto umount;
+	}
+	EXPECT_EQ(errno, EPERM) {
+		TH_LOG("%s - Failed to delete binder-control device but exited with unexpected error code",
 			strerror(errno));
+		goto umount;
 	}
 
-	/* binder-control device removal failed as expected */
-	ksft_inc_xfail_cnt();
+	/* success: binder-control device removal failed as expected */
+	result = 0;
 
-on_error:
+umount:
 	ret = umount2(binderfs_mntpt, MNT_DETACH);
-	rmdir_protect_errno(binderfs_mntpt);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to unmount binderfs\n",
-				   strerror(errno));
-
-	/* binderfs unmount test passed */
-	ksft_inc_pass_cnt();
-	return 0;
+	EXPECT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to unmount binderfs", strerror(errno));
+	}
+rmdir:
+	ret = rmdir(binderfs_mntpt);
+	EXPECT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to rmdir binderfs mount", strerror(errno));
+	}
+out:
+	return result;
 }
 
 static int wait_for_pid(pid_t pid)
@@ -291,7 +273,7 @@ static int write_id_mapping(enum idmap_type type, pid_t pid, const char *buf,
 	return 0;
 }
 
-static void change_userns(int syncfds[2])
+static void change_userns(struct __test_metadata *_metadata, int syncfds[2])
 {
 	int ret;
 	char buf;
@@ -299,25 +281,29 @@ static void change_userns(int syncfds[2])
 	close_prot_errno_disarm(syncfds[1]);
 
 	ret = unshare(CLONE_NEWUSER);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to unshare user namespace\n",
-				   strerror(errno));
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to unshare user namespace",
+			strerror(errno));
+	}
 
 	ret = write_nointr(syncfds[0], "1", 1);
-	if (ret != 1)
-		ksft_exit_fail_msg("write_nointr() failed\n");
+	ASSERT_EQ(ret, 1) {
+		TH_LOG("write_nointr() failed");
+	}
 
 	ret = read_nointr(syncfds[0], &buf, 1);
-	if (ret != 1)
-		ksft_exit_fail_msg("read_nointr() failed\n");
+	ASSERT_EQ(ret, 1) {
+		TH_LOG("read_nointr() failed");
+	}
 
 	close_prot_errno_disarm(syncfds[0]);
 
-	if (setid_userns_root())
-		ksft_exit_fail_msg("setid_userns_root() failed");
+	ASSERT_EQ(setid_userns_root(), 0) {
+		TH_LOG("setid_userns_root() failed");
+	}
 }
 
-static void change_idmaps(int syncfds[2], pid_t pid)
+static void change_idmaps(struct __test_metadata *_metadata, int syncfds[2], pid_t pid)
 {
 	int ret;
 	char buf;
@@ -326,35 +312,42 @@ static void change_idmaps(int syncfds[2], pid_t pid)
 	close_prot_errno_disarm(syncfds[0]);
 
 	ret = read_nointr(syncfds[1], &buf, 1);
-	if (ret != 1)
-		ksft_exit_fail_msg("read_nointr() failed\n");
+	ASSERT_EQ(ret, 1) {
+		TH_LOG("read_nointr() failed");
+	}
 
 	snprintf(id_map, sizeof(id_map), "0 %d 1\n", getuid());
 	ret = write_id_mapping(UID_MAP, pid, id_map, strlen(id_map));
-	if (ret)
-		ksft_exit_fail_msg("write_id_mapping(UID_MAP) failed");
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("write_id_mapping(UID_MAP) failed");
+	}
 
 	snprintf(id_map, sizeof(id_map), "0 %d 1\n", getgid());
 	ret = write_id_mapping(GID_MAP, pid, id_map, strlen(id_map));
-	if (ret)
-		ksft_exit_fail_msg("write_id_mapping(GID_MAP) failed");
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("write_id_mapping(GID_MAP) failed");
+	}
 
 	ret = write_nointr(syncfds[1], "1", 1);
-	if (ret != 1)
-		ksft_exit_fail_msg("write_nointr() failed");
+	ASSERT_EQ(ret, 1) {
+		TH_LOG("write_nointr() failed");
+	}
 
 	close_prot_errno_disarm(syncfds[1]);
 }
 
+struct __test_metadata *_thread_metadata;
 static void *binder_version_thread(void *data)
 {
+	struct __test_metadata *_metadata = _thread_metadata;
 	int fd = PTR_TO_INT(data);
 	struct binder_version version = { 0 };
 	int ret;
 
 	ret = ioctl(fd, BINDER_VERSION, &version);
 	if (ret < 0)
-		ksft_print_msg("%s - Failed to open perform BINDER_VERSION request\n", strerror(errno));
+		TH_LOG("%s - Failed to open perform BINDER_VERSION request\n",
+			strerror(errno));
 
 	pthread_exit(data);
 }
@@ -377,68 +370,79 @@ TEST(binderfs_stress)
 		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
 
 	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, syncfds);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to create socket pair", strerror(errno));
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to create socket pair", strerror(errno));
+	}
 
 	pid = fork();
-	if (pid < 0) {
+	ASSERT_GE(pid, 0) {
+		TH_LOG("%s - Failed to fork", strerror(errno));
 		close_prot_errno_disarm(syncfds[0]);
 		close_prot_errno_disarm(syncfds[1]);
-		ksft_exit_fail_msg("%s - Failed to fork", strerror(errno));
 	}
 
 	if (pid == 0) {
 		int i, j, k, nthreads;
 		pthread_attr_t attr;
 		pthread_t threads[DEFAULT_THREADS];
-		change_userns(syncfds);
-		change_mountns();
+		change_userns(_metadata, syncfds);
+		change_mountns(_metadata);
 
-		if (!mkdtemp(binderfs_mntpt))
-			log_exit("%s - Failed to create binderfs mountpoint\n",
-				 strerror(errno));
+		ASSERT_NE(mkdtemp(binderfs_mntpt), NULL) {
+			TH_LOG("%s - Failed to create binderfs mountpoint",
+				strerror(errno));
+		}
 
 		ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
-		if (ret < 0)
-			log_exit("%s - Failed to mount binderfs\n", strerror(errno));
+		ASSERT_EQ(ret, 0) {
+			TH_LOG("%s - Failed to mount binderfs", strerror(errno));
+		}
 
 		for (int i = 0; i < ARRAY_SIZE(fds); i++) {
 
 			snprintf(device_path, sizeof(device_path),
 				 "%s/binder-control", binderfs_mntpt);
 			fd = open(device_path, O_RDONLY | O_CLOEXEC);
-			if (fd < 0)
-				log_exit("%s - Failed to open binder-control device\n", strerror(errno));
+			ASSERT_GE(fd, 0) {
+				TH_LOG("%s - Failed to open binder-control device",
+					strerror(errno));
+			}
 
 			memset(&device, 0, sizeof(device));
 			snprintf(device.name, sizeof(device.name), "%d", i);
 			ret = ioctl(fd, BINDER_CTL_ADD, &device);
 			close_prot_errno_disarm(fd);
-			if (ret < 0)
-				log_exit("%s - Failed to allocate new binder device\n", strerror(errno));
+			ASSERT_EQ(ret, 0) {
+				TH_LOG("%s - Failed to allocate new binder device",
+					strerror(errno));
+			}
 
 			snprintf(device_path, sizeof(device_path), "%s/%d",
 				 binderfs_mntpt, i);
 			fds[i] = open(device_path, O_RDONLY | O_CLOEXEC);
-			if (fds[i] < 0)
-				log_exit("%s - Failed to open binder device\n", strerror(errno));
+			ASSERT_GE(fds[i], 0) {
+				TH_LOG("%s - Failed to open binder device", strerror(errno));
+			}
 		}
 
 		ret = umount2(binderfs_mntpt, MNT_DETACH);
-		rmdir_protect_errno(binderfs_mntpt);
-		if (ret < 0)
-			log_exit("%s - Failed to unmount binderfs\n", strerror(errno));
+		ASSERT_EQ(ret, 0) {
+			TH_LOG("%s - Failed to unmount binderfs", strerror(errno));
+			rmdir(binderfs_mntpt);
+		}
 
 		nthreads = get_nprocs_conf();
 		if (nthreads > DEFAULT_THREADS)
 			nthreads = DEFAULT_THREADS;
 
+		_thread_metadata = _metadata;
 		pthread_attr_init(&attr);
 		for (k = 0; k < ARRAY_SIZE(fds); k++) {
 			for (i = 0; i < nthreads; i++) {
 				ret = pthread_create(&threads[i], &attr, binder_version_thread, INT_TO_PTR(fds[k]));
 				if (ret) {
-					ksft_print_msg("%s - Failed to create thread %d\n", strerror(errno), i);
+					TH_LOG("%s - Failed to create thread %d",
+						strerror(errno), i);
 					break;
 				}
 			}
@@ -448,7 +452,8 @@ TEST(binderfs_stress)
 
 				ret = pthread_join(threads[j], &fdptr);
 				if (ret)
-					ksft_print_msg("%s - Failed to join thread %d for fd %d\n", strerror(errno), j, PTR_TO_INT(fdptr));
+					TH_LOG("%s - Failed to join thread %d for fd %d",
+						strerror(errno), j, PTR_TO_INT(fdptr));
 			}
 		}
 		pthread_attr_destroy(&attr);
@@ -459,11 +464,12 @@ TEST(binderfs_stress)
 		exit(EXIT_SUCCESS);
 	}
 
-	change_idmaps(syncfds, pid);
+	change_idmaps(_metadata, syncfds, pid);
 
 	ret = wait_for_pid(pid);
-	if (ret)
-		ksft_exit_fail_msg("wait_for_pid() failed");
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("wait_for_pid() failed");
+	}
 }
 
 TEST(binderfs_test_privileged)
@@ -471,7 +477,7 @@ TEST(binderfs_test_privileged)
 	if (geteuid() != 0)
 		XFAIL(return, "Tests are not run as root. Skipping privileged tests");
 
-	if (__do_binderfs_test() == 1)
+	if (__do_binderfs_test(_metadata))
 		XFAIL(return, "The Android binderfs filesystem is not available");
 }
 
@@ -482,31 +488,33 @@ TEST(binderfs_test_unprivileged)
 	pid_t pid;
 
 	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, syncfds);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to create socket pair", strerror(errno));
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to create socket pair", strerror(errno));
+	}
 
 	pid = fork();
-	if (pid < 0) {
+	ASSERT_GE(pid, 0) {
 		close_prot_errno_disarm(syncfds[0]);
 		close_prot_errno_disarm(syncfds[1]);
-		ksft_exit_fail_msg("%s - Failed to fork", strerror(errno));
+		TH_LOG("%s - Failed to fork", strerror(errno));
 	}
 
 	if (pid == 0) {
-		change_userns(syncfds);
-		if (__do_binderfs_test() == 1)
+		change_userns(_metadata, syncfds);
+		if (__do_binderfs_test(_metadata))
 			exit(2);
 		exit(EXIT_SUCCESS);
 	}
 
-	change_idmaps(syncfds, pid);
+	change_idmaps(_metadata, syncfds, pid);
 
 	ret = wait_for_pid(pid);
 	if (ret) {
 		if (ret == 2)
 			XFAIL(return, "The Android binderfs filesystem is not available");
-		else
-			ksft_exit_fail_msg("wait_for_pid() failed");
+		ASSERT_EQ(ret, 0) {
+			TH_LOG("wait_for_pid() failed");
+		}
 	}
 }
 
diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 3702dbcc90a7..ea2147248ebe 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -63,6 +63,8 @@ ALL_TESTS="$ALL_TESTS 0008:150:1"
 ALL_TESTS="$ALL_TESTS 0009:150:1"
 ALL_TESTS="$ALL_TESTS 0010:1:1"
 ALL_TESTS="$ALL_TESTS 0011:1:1"
+ALL_TESTS="$ALL_TESTS 0012:1:1"
+ALL_TESTS="$ALL_TESTS 0013:1:1"
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -128,7 +130,7 @@ test_reqs()
 	if [[ $KMOD_VERSION  -le 19 ]]; then
 		echo "$0: You need at least kmod 20" >&2
 		echo "kmod <= 19 is buggy, for details see:" >&2
-		echo "http://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/libkmod/libkmod-module.c?id=fd44a98ae2eb5eb32161088954ab21e58e19dfc4" >&2
+		echo "https://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/libkmod/libkmod-module.c?id=fd44a98ae2eb5eb32161088954ab21e58e19dfc4" >&2
 		exit $ksft_skip
 	fi
 
@@ -470,6 +472,38 @@ kmod_test_0011()
 	echo "$MODPROBE" > /proc/sys/kernel/modprobe
 }
 
+kmod_check_visibility()
+{
+	local name="$1"
+	local cmd="$2"
+
+	modprobe $DEFAULT_KMOD_DRIVER
+
+	local priv=$(eval $cmd)
+	local unpriv=$(capsh --drop=CAP_SYSLOG -- -c "$cmd")
+
+	if [ "$priv" = "$unpriv" ] || \
+	   [ "${priv:0:3}" = "0x0" ] || \
+	   [ "${unpriv:0:3}" != "0x0" ] ; then
+		echo "${FUNCNAME[0]}: FAIL, $name visible to unpriv: '$priv' vs '$unpriv'" >&2
+		exit 1
+	else
+		echo "${FUNCNAME[0]}: OK!"
+	fi
+}
+
+kmod_test_0012()
+{
+	kmod_check_visibility /proc/modules \
+		"grep '^${DEFAULT_KMOD_DRIVER}\b' /proc/modules | awk '{print \$NF}'"
+}
+
+kmod_test_0013()
+{
+	kmod_check_visibility '/sys/module/*/sections/*' \
+		"cat /sys/module/${DEFAULT_KMOD_DRIVER}/sections/.*text | head -n1"
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -489,6 +523,8 @@ list_tests()
 	echo "0009 x $(get_test_count 0009) - multithreaded - push kmod_concurrent over max_modprobes for get_fs_type()"
 	echo "0010 x $(get_test_count 0010) - test nonexistent modprobe path"
 	echo "0011 x $(get_test_count 0011) - test completely disabling module autoloading"
+	echo "0012 x $(get_test_count 0012) - test /proc/modules address visibility under CAP_SYSLOG"
+	echo "0013 x $(get_test_count 0013) - test /sys/module/*/sections/* visibility under CAP_SYSLOG"
 }
 
 usage()
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 0ac49d91a260..3af0311de158 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -1,11 +1,43 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * kselftest.h:	kselftest framework return codes to include from
- *		selftests.
+ * kselftest.h:	low-level kselftest framework to include from
+ *		selftest programs. When possible, please use
+ *		kselftest_harness.h instead.
  *
  * Copyright (c) 2014 Shuah Khan <shuahkh@osg.samsung.com>
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *
+ * Using this API consists of first counting how many tests your code
+ * has to run, and then starting up the reporting:
+ *
+ *     ksft_print_header();
+ *     ksft_set_plan(total_number_of_tests);
+ *
+ * For each test, report any progress, debugging, etc with:
+ *
+ *     ksft_print_msg(fmt, ...);
+ *
+ * and finally report the pass/fail/skip/xfail state of the test with one of:
+ *
+ *     ksft_test_result(condition, fmt, ...);
+ *     ksft_test_result_pass(fmt, ...);
+ *     ksft_test_result_fail(fmt, ...);
+ *     ksft_test_result_skip(fmt, ...);
+ *     ksft_test_result_xfail(fmt, ...);
+ *     ksft_test_result_error(fmt, ...);
+ *
+ * When all tests are finished, clean up and exit the program with one of:
+ *
+ *    ksft_exit(condition);
+ *    ksft_exit_pass();
+ *    ksft_exit_fail();
+ *
+ * If the program wants to report details on why the entire program has
+ * failed, it can instead exit with a message (this is usually done when
+ * the program is aborting before finishing all tests):
+ *
+ *    ksft_exit_fail_msg(fmt, ...);
+ *
  */
 #ifndef __KSELFTEST_H
 #define __KSELFTEST_H
@@ -74,7 +106,7 @@ static inline void ksft_print_cnts(void)
 	if (ksft_plan != ksft_test_num())
 		printf("# Planned tests != run tests (%u != %u)\n",
 			ksft_plan, ksft_test_num());
-	printf("# Pass %d Fail %d Xfail %d Xpass %d Skip %d Error %d\n",
+	printf("# Totals: pass:%d fail:%d xfail:%d xpass:%d skip:%d error:%d\n",
 		ksft_cnt.ksft_pass, ksft_cnt.ksft_fail,
 		ksft_cnt.ksft_xfail, ksft_cnt.ksft_xpass,
 		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
@@ -120,6 +152,32 @@ static inline void ksft_test_result_fail(const char *msg, ...)
 	va_end(args);
 }
 
+/**
+ * ksft_test_result() - Report test success based on truth of condition
+ *
+ * @condition: if true, report test success, otherwise failure.
+ */
+#define ksft_test_result(condition, fmt, ...) do {	\
+	if (!!(condition))				\
+		ksft_test_result_pass(fmt, ##__VA_ARGS__);\
+	else						\
+		ksft_test_result_fail(fmt, ##__VA_ARGS__);\
+	} while (0)
+
+static inline void ksft_test_result_xfail(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	ksft_cnt.ksft_xfail++;
+
+	va_start(args, msg);
+	printf("ok %d # XFAIL ", ksft_test_num());
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
+
 static inline void ksft_test_result_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
@@ -128,12 +186,13 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 	ksft_cnt.ksft_xskip++;
 
 	va_start(args, msg);
-	printf("not ok %d # SKIP ", ksft_test_num());
+	printf("ok %d # SKIP ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
 }
 
+/* TODO: how does "error" differ from "fail" or "skip"? */
 static inline void ksft_test_result_error(const char *msg, ...)
 {
 	int saved_errno = errno;
@@ -156,11 +215,22 @@ static inline int ksft_exit_pass(void)
 
 static inline int ksft_exit_fail(void)
 {
-	printf("Bail out!\n");
 	ksft_print_cnts();
 	exit(KSFT_FAIL);
 }
 
+/**
+ * ksft_exit() - Exit selftest based on truth of condition
+ *
+ * @condition: if true, exit self test with success, otherwise fail.
+ */
+#define ksft_exit(condition) do {	\
+	if (!!(condition))		\
+		ksft_exit_pass();	\
+	else				\
+		ksft_exit_fail();	\
+	} while (0)
+
 static inline int ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
@@ -190,18 +260,30 @@ static inline int ksft_exit_xpass(void)
 
 static inline int ksft_exit_skip(const char *msg, ...)
 {
-	if (msg) {
-		int saved_errno = errno;
-		va_list args;
+	int saved_errno = errno;
+	va_list args;
+
+	va_start(args, msg);
 
-		va_start(args, msg);
-		printf("not ok %d # SKIP ", 1 + ksft_test_num());
+	/*
+	 * FIXME: several tests misuse ksft_exit_skip so produce
+	 * something sensible if some tests have already been run
+	 * or a plan has been printed.  Those tests should use
+	 * ksft_test_result_skip or ksft_exit_fail_msg instead.
+	 */
+	if (ksft_plan || ksft_test_num()) {
+		ksft_cnt.ksft_xskip++;
+		printf("ok %d # SKIP ", 1 + ksft_test_num());
+	} else {
+		printf("1..0 # SKIP ");
+	}
+	if (msg) {
 		errno = saved_errno;
 		vprintf(msg, args);
 		va_end(args);
-	} else {
-		ksft_print_cnts();
 	}
+	if (ksft_test_num())
+		ksft_print_cnts();
 	exit(KSFT_SKIP);
 }
 
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 676b3a8b114d..f4815cbcd60f 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -77,7 +77,7 @@ run_one()
 		echo "ok $test_num $TEST_HDR_MSG") ||
 		(rc=$?;	\
 		if [ $rc -eq $skip_rc ]; then	\
-			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
+			echo "ok $test_num $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
 			echo "#"
 			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index c9f03ef93338..4f78e4805633 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -50,7 +50,9 @@
 #ifndef __KSELFTEST_HARNESS_H
 #define __KSELFTEST_HARNESS_H
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <asm/types.h>
 #include <errno.h>
 #include <stdbool.h>
@@ -58,10 +60,13 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include "kselftest.h"
+
 #define TEST_TIMEOUT_DEFAULT 30
 
 /* Utilities exposed to the test definitions */
@@ -104,26 +109,28 @@
 
 /* Unconditional logger for internal use. */
 #define __TH_LOG(fmt, ...) \
-		fprintf(TH_LOG_STREAM, "%s:%d:%s:" fmt "\n", \
+		fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
 			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
 
 /**
- * XFAIL(statement, fmt, ...)
+ * SKIP(statement, fmt, ...)
  *
- * @statement: statement to run after reporting XFAIL
+ * @statement: statement to run after reporting SKIP
  * @fmt: format string
  * @...: optional arguments
  *
- * This forces a "pass" after reporting a failure with an XFAIL prefix,
+ * This forces a "pass" after reporting why something is being skipped
  * and runs "statement", which is usually "return" or "goto skip".
  */
-#define XFAIL(statement, fmt, ...) do { \
+#define SKIP(statement, fmt, ...) do { \
+	snprintf(_metadata->results->reason, \
+		 sizeof(_metadata->results->reason), fmt, ##__VA_ARGS__); \
 	if (TH_LOG_ENABLED) { \
-		fprintf(TH_LOG_STREAM, "[  XFAIL!  ] " fmt "\n", \
-			##__VA_ARGS__); \
+		fprintf(TH_LOG_STREAM, "#      SKIP     %s\n", \
+			_metadata->results->reason); \
 	} \
-	/* TODO: find a way to pass xfail to test runner process. */ \
 	_metadata->passed = 1; \
+	_metadata->skip = 1; \
 	_metadata->trigger = 0; \
 	statement; \
 } while (0)
@@ -195,8 +202,9 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE_DATA(datatype name)
+ *     FIXTURE_DATA(datatype_name)
  *
+ * Almost always, you want just FIXTURE() instead (see below).
  * This call may be used when the type of the fixture data
  * is needed.  In general, this should not be needed unless
  * the *self* is being passed to a helper directly.
@@ -211,7 +219,7 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE(datatype name) {
+ *     FIXTURE(fixture_name) {
  *       type property1;
  *       ...
  *     };
@@ -238,7 +246,7 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE_SETUP(fixture name) { implementation }
+ *     FIXTURE_SETUP(fixture_name) { implementation }
  *
  * Populates the required "setup" function for a fixture.  An instance of the
  * datatype defined with FIXTURE_DATA() will be exposed as *self* for the
@@ -264,7 +272,7 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE_TEARDOWN(fixture name) { implementation }
+ *     FIXTURE_TEARDOWN(fixture_name) { implementation }
  *
  * Populates the required "teardown" function for a fixture.  An instance of the
  * datatype defined with FIXTURE_DATA() will be exposed as *self* for the
@@ -285,7 +293,7 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE_VARIANT(datatype name) {
+ *     FIXTURE_VARIANT(fixture_name) {
  *       type property1;
  *       ...
  *     };
@@ -305,8 +313,8 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE_ADD(datatype name) {
- *       .property1 = val1;
+ *     FIXTURE_VARIANT_ADD(fixture_name, variant_name) {
+ *       .property1 = val1,
  *       ...
  *     };
  *
@@ -672,20 +680,53 @@
 			__bail(_assert, _metadata->no_print, _metadata->step))
 
 #define __INC_STEP(_metadata) \
-	if (_metadata->passed && _metadata->step < 255) \
+	/* Keep "step" below 255 (which is used for "SKIP" reporting). */	\
+	if (_metadata->passed && _metadata->step < 253) \
 		_metadata->step++;
 
+#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
+
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
 	__typeof__(_expected) __exp = (_expected); \
 	__typeof__(_seen) __seen = (_seen); \
 	if (_assert) __INC_STEP(_metadata); \
 	if (!(__exp _t __seen)) { \
-		unsigned long long __exp_print = (uintptr_t)__exp; \
-		unsigned long long __seen_print = (uintptr_t)__seen; \
-		__TH_LOG("Expected %s (%llu) %s %s (%llu)", \
-			 _expected_str, __exp_print, #_t, \
-			 _seen_str, __seen_print); \
+		/* Report with actual signedness to avoid weird output. */ \
+		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
+		case 0: { \
+			unsigned long long __exp_print = (uintptr_t)__exp; \
+			unsigned long long __seen_print = (uintptr_t)__seen; \
+			__TH_LOG("Expected %s (%llu) %s %s (%llu)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 1: { \
+			unsigned long long __exp_print = (uintptr_t)__exp; \
+			long long __seen_print = (intptr_t)__seen; \
+			__TH_LOG("Expected %s (%llu) %s %s (%lld)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 2: { \
+			long long __exp_print = (intptr_t)__exp; \
+			unsigned long long __seen_print = (uintptr_t)__seen; \
+			__TH_LOG("Expected %s (%lld) %s %s (%llu)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 3: { \
+			long long __exp_print = (intptr_t)__exp; \
+			long long __seen_print = (intptr_t)__seen; \
+			__TH_LOG("Expected %s (%lld) %s %s (%lld)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		} \
 		_metadata->passed = 0; \
 		/* Ensure the optional handler is triggered */ \
 		_metadata->trigger = 1; \
@@ -726,6 +767,10 @@
 	} \
 }
 
+struct __test_results {
+	char reason[1024];	/* Reason for test result */
+};
+
 struct __test_metadata;
 struct __fixture_variant_metadata;
 
@@ -773,11 +818,13 @@ struct __test_metadata {
 	struct __fixture_metadata *fixture;
 	int termsig;
 	int passed;
+	int skip;	/* did SKIP get used? */
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool timed_out;	/* did this test timeout instead of exiting? */
 	__u8 step;
 	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
+	struct __test_results *results;
 	struct __test_metadata *prev, *next;
 };
 
@@ -813,12 +860,12 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	/* Sanity check handler execution environment. */
 	if (!t) {
 		fprintf(TH_LOG_STREAM,
-			"no active test in SIGALRM handler!?\n");
+			"# no active test in SIGALRM handler!?\n");
 		abort();
 	}
 	if (sig != SIGALRM || sig != info->si_signo) {
 		fprintf(TH_LOG_STREAM,
-			"%s: SIGALRM handler caught signal %d!?\n",
+			"# %s: SIGALRM handler caught signal %d!?\n",
 			t->name, sig != SIGALRM ? sig : info->si_signo);
 		abort();
 	}
@@ -839,7 +886,7 @@ void __wait_for_test(struct __test_metadata *t)
 	if (sigaction(SIGALRM, &action, &saved_action)) {
 		t->passed = 0;
 		fprintf(TH_LOG_STREAM,
-			"%s: unable to install SIGALRM handler\n",
+			"# %s: unable to install SIGALRM handler\n",
 			t->name);
 		return;
 	}
@@ -851,7 +898,7 @@ void __wait_for_test(struct __test_metadata *t)
 	if (sigaction(SIGALRM, &saved_action, NULL)) {
 		t->passed = 0;
 		fprintf(TH_LOG_STREAM,
-			"%s: unable to uninstall SIGALRM handler\n",
+			"# %s: unable to uninstall SIGALRM handler\n",
 			t->name);
 		return;
 	}
@@ -860,39 +907,51 @@ void __wait_for_test(struct __test_metadata *t)
 	if (t->timed_out) {
 		t->passed = 0;
 		fprintf(TH_LOG_STREAM,
-			"%s: Test terminated by timeout\n", t->name);
+			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
-		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
 		if (t->termsig != -1) {
+			t->passed = 0;
 			fprintf(TH_LOG_STREAM,
-				"%s: Test exited normally "
-				"instead of by signal (code: %d)\n",
-				t->name,
-				WEXITSTATUS(status));
-		} else if (!t->passed) {
-			fprintf(TH_LOG_STREAM,
-				"%s: Test failed at step #%d\n",
+				"# %s: Test exited normally instead of by signal (code: %d)\n",
 				t->name,
 				WEXITSTATUS(status));
+		} else {
+			switch (WEXITSTATUS(status)) {
+			/* Success */
+			case 0:
+				t->passed = 1;
+				break;
+			/* SKIP */
+			case 255:
+				t->passed = 1;
+				t->skip = 1;
+				break;
+			/* Other failure, assume step report. */
+			default:
+				t->passed = 0;
+				fprintf(TH_LOG_STREAM,
+					"# %s: Test failed at step #%d\n",
+					t->name,
+					WEXITSTATUS(status));
+			}
 		}
 	} else if (WIFSIGNALED(status)) {
 		t->passed = 0;
 		if (WTERMSIG(status) == SIGABRT) {
 			fprintf(TH_LOG_STREAM,
-				"%s: Test terminated by assertion\n",
+				"# %s: Test terminated by assertion\n",
 				t->name);
 		} else if (WTERMSIG(status) == t->termsig) {
 			t->passed = 1;
 		} else {
 			fprintf(TH_LOG_STREAM,
-				"%s: Test terminated unexpectedly "
-				"by signal %d\n",
+				"# %s: Test terminated unexpectedly by signal %d\n",
 				t->name,
 				WTERMSIG(status));
 		}
 	} else {
 		fprintf(TH_LOG_STREAM,
-			"%s: Test ended in some other way [%u]\n",
+			"# %s: Test ended in some other way [%u]\n",
 			t->name,
 			status);
 	}
@@ -904,25 +963,39 @@ void __run_test(struct __fixture_metadata *f,
 {
 	/* reset test struct */
 	t->passed = 1;
+	t->skip = 0;
 	t->trigger = 0;
 	t->step = 0;
 	t->no_print = 0;
+	memset(t->results->reason, 0, sizeof(t->results->reason));
 
-	printf("[ RUN      ] %s%s%s.%s\n",
+	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
 	t->pid = fork();
 	if (t->pid < 0) {
-		printf("ERROR SPAWNING TEST CHILD\n");
+		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
 		t->passed = 0;
 	} else if (t->pid == 0) {
 		t->fn(t, variant);
-		/* return the step that failed or 0 */
-		_exit(t->passed ? 0 : t->step);
+		if (t->skip)
+			_exit(255);
+		/* Pass is exit 0 */
+		if (t->passed)
+			_exit(0);
+		/* Something else happened, report the step. */
+		_exit(t->step);
 	} else {
 		__wait_for_test(t);
 	}
-	printf("[     %4s ] %s%s%s.%s\n", (t->passed ? "OK" : "FAIL"),
+	ksft_print_msg("         %4s  %s%s%s.%s\n", t->passed ? "OK" : "FAIL",
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+
+	if (t->skip)
+		ksft_test_result_skip("%s\n", t->results->reason[0] ?
+					t->results->reason : "unknown");
+	else
+		ksft_test_result(t->passed, "%s%s%s.%s\n",
+			f->name, variant->name[0] ? "." : "", variant->name, t->name);
 }
 
 static int test_harness_run(int __attribute__((unused)) argc,
@@ -931,6 +1004,7 @@ static int test_harness_run(int __attribute__((unused)) argc,
 	struct __fixture_variant_metadata no_variant = { .name = "", };
 	struct __fixture_variant_metadata *v;
 	struct __fixture_metadata *f;
+	struct __test_results *results;
 	struct __test_metadata *t;
 	int ret = 0;
 	unsigned int case_count = 0, test_count = 0;
@@ -945,14 +1019,20 @@ static int test_harness_run(int __attribute__((unused)) argc,
 		}
 	}
 
-	/* TODO(wad) add optional arguments similar to gtest. */
-	printf("[==========] Running %u tests from %u test cases.\n",
+	results = mmap(NULL, sizeof(*results), PROT_READ | PROT_WRITE,
+		       MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	ksft_print_header();
+	ksft_set_plan(test_count);
+	ksft_print_msg("Starting %u tests from %u test cases.\n",
 	       test_count, case_count);
 	for (f = __fixture_list; f; f = f->next) {
 		for (v = f->variant ?: &no_variant; v; v = v->next) {
 			for (t = f->tests; t; t = t->next) {
 				count++;
+				t->results = results;
 				__run_test(f, v, t);
+				t->results = NULL;
 				if (t->passed)
 					pass_count++;
 				else
@@ -960,9 +1040,14 @@ static int test_harness_run(int __attribute__((unused)) argc,
 			}
 		}
 	}
-	printf("[==========] %u / %u tests passed.\n", pass_count, count);
-	printf("[  %s  ]\n", (ret ? "FAILED" : "PASSED"));
-	return ret;
+	munmap(results, sizeof(*results));
+
+	ksft_print_msg("%s: %u / %u tests passed.\n", ret ? "FAILED" : "PASSED",
+			pass_count, count);
+	ksft_exit(ret == 0);
+
+	/* unreachable */
+	return KSFT_FAIL;
 }
 
 static void __attribute__((constructor)) __constructor_order_first(void)
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index b0556c752443..7a17ea815736 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -59,9 +59,8 @@ else
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 endif
 
-.ONESHELL:
 define RUN_TESTS
-	@BASE_DIR="$(selfdir)";			\
+	BASE_DIR="$(selfdir)";			\
 	. $(selfdir)/kselftest/runner.sh;	\
 	if [ "X$(summary)" != "X" ]; then       \
 		per_test_logging=1;		\
@@ -71,22 +70,21 @@ endef
 
 run_tests: all
 ifdef building_out_of_srctree
-	@if [ "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" ]; then
-		@rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT)
+	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
+		rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
-	@if [ "X$(TEST_PROGS)" != "X" ]; then
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS))
-	else
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS))
+	@if [ "X$(TEST_PROGS)" != "X" ]; then \
+		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS)) ; \
+	else \
+		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS)); \
 	fi
 else
-	$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
+	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 endif
 
 define INSTALL_SINGLE_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
-	$(if $(INSTALL_LIST),@echo rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
-	$(if $(INSTALL_LIST),@rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
+	$(if $(INSTALL_LIST),rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
 endef
 
 define INSTALL_RULE
diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 73d532556d17..7d84097ad45c 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -11,7 +11,6 @@
 #include <syscall.h>
 #include <sys/wait.h>
 
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 #include "../pidfd/pidfd.h"
 
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index 84b65ecccb04..7758c98be015 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -18,7 +18,6 @@
 #include <linux/kcmp.h>
 
 #include "pidfd.h"
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 
 /*
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 9418108eae13..dc95125ae037 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -20,7 +20,6 @@
 
 #include "pidfd.h"
 #include "../clone3/clone3_selftests.h"
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 
 enum {
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 7aff2d3b42c0..c585aaa2acd8 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -8,6 +8,7 @@
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
@@ -27,6 +28,8 @@
 
 #define MAX_EVENTS 5
 
+static bool have_pidfd_send_signal;
+
 static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 {
 	size_t stack_size = 1024;
@@ -56,6 +59,13 @@ static int test_pidfd_send_signal_simple_success(void)
 	int pidfd, ret;
 	const char *test_name = "pidfd_send_signal send SIGUSR1";
 
+	if (!have_pidfd_send_signal) {
+		ksft_test_result_skip(
+			"%s test: pidfd_send_signal() syscall not supported\n",
+			test_name);
+		return 0;
+	}
+
 	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
 	if (pidfd < 0)
 		ksft_exit_fail_msg(
@@ -86,6 +96,13 @@ static int test_pidfd_send_signal_exited_fail(void)
 	pid_t pid;
 	const char *test_name = "pidfd_send_signal signal exited process";
 
+	if (!have_pidfd_send_signal) {
+		ksft_test_result_skip(
+			"%s test: pidfd_send_signal() syscall not supported\n",
+			test_name);
+		return 0;
+	}
+
 	pid = fork();
 	if (pid < 0)
 		ksft_exit_fail_msg("%s test: Failed to create new process\n",
@@ -137,16 +154,34 @@ static int test_pidfd_send_signal_recycled_pid_fail(void)
 	pid_t pid1;
 	const char *test_name = "pidfd_send_signal signal recycled pid";
 
+	if (!have_pidfd_send_signal) {
+		ksft_test_result_skip(
+			"%s test: pidfd_send_signal() syscall not supported\n",
+			test_name);
+		return 0;
+	}
+
 	ret = unshare(CLONE_NEWPID);
-	if (ret < 0)
+	if (ret < 0) {
+		if (errno == EPERM) {
+			ksft_test_result_skip("%s test: Unsharing pid namespace not permitted\n",
+					      test_name);
+			return 0;
+		}
 		ksft_exit_fail_msg("%s test: Failed to unshare pid namespace\n",
 				   test_name);
+	}
 
 	ret = unshare(CLONE_NEWNS);
-	if (ret < 0)
-		ksft_exit_fail_msg(
-			"%s test: Failed to unshare mount namespace\n",
-			test_name);
+	if (ret < 0) {
+		if (errno == EPERM) {
+			ksft_test_result_skip("%s test: Unsharing mount namespace not permitted\n",
+					      test_name);
+			return 0;
+		}
+		ksft_exit_fail_msg("%s test: Failed to unshare mount namespace\n",
+				   test_name);
+	}
 
 	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
 	if (ret < 0)
@@ -325,15 +360,17 @@ static int test_pidfd_send_signal_syscall_support(void)
 
 	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
 	if (ret < 0) {
-		if (errno == ENOSYS)
-			ksft_exit_skip(
+		if (errno == ENOSYS) {
+			ksft_test_result_skip(
 				"%s test: pidfd_send_signal() syscall not supported\n",
 				test_name);
-
+			return 0;
+		}
 		ksft_exit_fail_msg("%s test: Failed to send signal\n",
 				   test_name);
 	}
 
+	have_pidfd_send_signal = true;
 	close(pidfd);
 	ksft_test_result_pass(
 		"%s test: pidfd_send_signal() syscall is supported. Tests can be executed\n",
@@ -521,7 +558,7 @@ static void test_pidfd_poll_leader_exit(int use_waitpid)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(4);
+	ksft_set_plan(8);
 
 	test_pidfd_poll_exec(0);
 	test_pidfd_poll_exec(1);
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 252140a52553..ab52eb100c92 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1470,6 +1470,7 @@ pid_t setup_trace_fixture(struct __test_metadata *_metadata,
 
 	return tracer_pid;
 }
+
 void teardown_trace_fixture(struct __test_metadata *_metadata,
 			    pid_t tracer)
 {
@@ -1750,7 +1751,7 @@ void change_syscall(struct __test_metadata *_metadata,
 	EXPECT_EQ(0, ret);
 }
 
-void tracer_syscall(struct __test_metadata *_metadata, pid_t tracee,
+void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
 		    int status, void *args)
 {
 	int ret;
@@ -1827,6 +1828,24 @@ FIXTURE(TRACE_syscall) {
 	pid_t tracer, mytid, mypid, parent;
 };
 
+FIXTURE_VARIANT(TRACE_syscall) {
+	/*
+	 * All of the SECCOMP_RET_TRACE behaviors can be tested with either
+	 * SECCOMP_RET_TRACE+PTRACE_CONT or plain ptrace()+PTRACE_SYSCALL.
+	 * This indicates if we should use SECCOMP_RET_TRACE (false), or
+	 * ptrace (true).
+	 */
+	bool use_ptrace;
+};
+
+FIXTURE_VARIANT_ADD(TRACE_syscall, ptrace) {
+	.use_ptrace = true,
+};
+
+FIXTURE_VARIANT_ADD(TRACE_syscall, seccomp) {
+	.use_ptrace = false,
+};
+
 FIXTURE_SETUP(TRACE_syscall)
 {
 	struct sock_filter filter[] = {
@@ -1842,12 +1861,11 @@ FIXTURE_SETUP(TRACE_syscall)
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_TRACE | 0x1005),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
-
-	memset(&self->prog, 0, sizeof(self->prog));
-	self->prog.filter = malloc(sizeof(filter));
-	ASSERT_NE(NULL, self->prog.filter);
-	memcpy(self->prog.filter, filter, sizeof(filter));
-	self->prog.len = (unsigned short)ARRAY_SIZE(filter);
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	long ret;
 
 	/* Prepare some testable syscall results. */
 	self->mytid = syscall(__NR_gettid);
@@ -1865,60 +1883,54 @@ FIXTURE_SETUP(TRACE_syscall)
 	ASSERT_NE(self->parent, self->mypid);
 
 	/* Launch tracer. */
-	self->tracer = setup_trace_fixture(_metadata, tracer_syscall, NULL,
-					   false);
-}
+	self->tracer = setup_trace_fixture(_metadata,
+					   variant->use_ptrace ? tracer_ptrace
+							       : tracer_seccomp,
+					   NULL, variant->use_ptrace);
 
-FIXTURE_TEARDOWN(TRACE_syscall)
-{
-	teardown_trace_fixture(_metadata, self->tracer);
-	if (self->prog.filter)
-		free(self->prog.filter);
-}
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret);
 
-TEST_F(TRACE_syscall, ptrace_syscall_redirected)
-{
-	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
-	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
-					   true);
+	if (variant->use_ptrace)
+		return;
 
-	/* Tracer will redirect getpid to getppid. */
-	EXPECT_NE(self->mypid, syscall(__NR_getpid));
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+	ASSERT_EQ(0, ret);
 }
 
-TEST_F(TRACE_syscall, ptrace_syscall_errno)
+FIXTURE_TEARDOWN(TRACE_syscall)
 {
-	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
 	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
-					   true);
-
-	/* Tracer should skip the open syscall, resulting in ESRCH. */
-	EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
 }
 
-TEST_F(TRACE_syscall, ptrace_syscall_faked)
+TEST(negative_ENOSYS)
 {
-	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
-	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
-					   true);
+	/* Untraced negative syscalls should return ENOSYS. */
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-1));
+	EXPECT_EQ(errno, ENOSYS);
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-101));
+	EXPECT_EQ(errno, ENOSYS);
+}
 
-	/* Tracer should skip the gettid syscall, resulting fake pid. */
-	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
+TEST_F(TRACE_syscall, negative_ENOSYS)
+{
+	/*
+	 * There should be no difference between an "internal" skip
+	 * and userspace asking for syscall "-1".
+	 */
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-1));
+	EXPECT_EQ(errno, ENOSYS);
+	/* And no difference for "still not valid but not -1". */
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-101));
+	EXPECT_EQ(errno, ENOSYS);
 }
 
 TEST_F(TRACE_syscall, syscall_allowed)
 {
-	long ret;
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
 	/* getppid works as expected (no changes). */
 	EXPECT_EQ(self->parent, syscall(__NR_getppid));
 	EXPECT_NE(self->mypid, syscall(__NR_getppid));
@@ -1926,14 +1938,6 @@ TEST_F(TRACE_syscall, syscall_allowed)
 
 TEST_F(TRACE_syscall, syscall_redirected)
 {
-	long ret;
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
 	/* getpid has been redirected to getppid as expected. */
 	EXPECT_EQ(self->parent, syscall(__NR_getpid));
 	EXPECT_NE(self->mypid, syscall(__NR_getpid));
@@ -1941,33 +1945,17 @@ TEST_F(TRACE_syscall, syscall_redirected)
 
 TEST_F(TRACE_syscall, syscall_errno)
 {
-	long ret;
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* openat has been skipped and an errno return. */
+	/* Tracer should skip the open syscall, resulting in ESRCH. */
 	EXPECT_SYSCALL_RETURN(-ESRCH, syscall(__NR_openat));
 }
 
 TEST_F(TRACE_syscall, syscall_faked)
 {
-	long ret;
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* gettid has been skipped and an altered return value stored. */
+	/* Tracer skips the gettid syscall and store altered return value. */
 	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
 }
 
-TEST_F(TRACE_syscall, skip_after_RET_TRACE)
+TEST_F(TRACE_syscall, skip_after)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
@@ -1982,14 +1970,7 @@ TEST_F(TRACE_syscall, skip_after_RET_TRACE)
 	};
 	long ret;
 
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install fixture filter. */
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install "errno on getppid" filter. */
+	/* Install additional "errno on getppid" filter. */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
 	ASSERT_EQ(0, ret);
 
@@ -1999,7 +1980,7 @@ TEST_F(TRACE_syscall, skip_after_RET_TRACE)
 	EXPECT_EQ(EPERM, errno);
 }
 
-TEST_F_SIGNAL(TRACE_syscall, kill_after_RET_TRACE, SIGSYS)
+TEST_F_SIGNAL(TRACE_syscall, kill_after, SIGSYS)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
@@ -2014,77 +1995,7 @@ TEST_F_SIGNAL(TRACE_syscall, kill_after_RET_TRACE, SIGSYS)
 	};
 	long ret;
 
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install fixture filter. */
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install "death on getppid" filter. */
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Tracer will redirect getpid to getppid, and we should die. */
-	EXPECT_NE(self->mypid, syscall(__NR_getpid));
-}
-
-TEST_F(TRACE_syscall, skip_after_ptrace)
-{
-	struct sock_filter filter[] = {
-		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
-			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
-		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | EPERM),
-		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
-	};
-	struct sock_fprog prog = {
-		.len = (unsigned short)ARRAY_SIZE(filter),
-		.filter = filter,
-	};
-	long ret;
-
-	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
-	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
-					   true);
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install "errno on getppid" filter. */
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Tracer will redirect getpid to getppid, and we should see EPERM. */
-	EXPECT_EQ(-1, syscall(__NR_getpid));
-	EXPECT_EQ(EPERM, errno);
-}
-
-TEST_F_SIGNAL(TRACE_syscall, kill_after_ptrace, SIGSYS)
-{
-	struct sock_filter filter[] = {
-		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
-			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
-		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
-		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
-	};
-	struct sock_fprog prog = {
-		.len = (unsigned short)ARRAY_SIZE(filter),
-		.filter = filter,
-	};
-	long ret;
-
-	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
-	teardown_trace_fixture(_metadata, self->tracer);
-	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
-					   true);
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	ASSERT_EQ(0, ret);
-
-	/* Install "death on getppid" filter. */
+	/* Install additional "death on getppid" filter. */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
 	ASSERT_EQ(0, ret);
 
@@ -3069,7 +2980,7 @@ TEST(get_metadata)
 
 	/* Only real root can get metadata. */
 	if (geteuid()) {
-		XFAIL(return, "get_metadata requires real root");
+		SKIP(return, "get_metadata requires real root");
 		return;
 	}
 
@@ -3112,7 +3023,7 @@ TEST(get_metadata)
 	ret = ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md);
 	EXPECT_EQ(sizeof(md), ret) {
 		if (errno == EINVAL)
-			XFAIL(goto skip, "Kernel does not support PTRACE_SECCOMP_GET_METADATA (missing CONFIG_CHECKPOINT_RESTORE?)");
+			SKIP(goto skip, "Kernel does not support PTRACE_SECCOMP_GET_METADATA (missing CONFIG_CHECKPOINT_RESTORE?)");
 	}
 
 	EXPECT_EQ(md.flags, SECCOMP_FILTER_FLAG_LOG);
@@ -3673,7 +3584,7 @@ TEST(user_notification_continue)
 	resp.val = 0;
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0) {
 		if (errno == EINVAL)
-			XFAIL(goto skip, "Kernel does not support SECCOMP_USER_NOTIF_FLAG_CONTINUE");
+			SKIP(goto skip, "Kernel does not support SECCOMP_USER_NOTIF_FLAG_CONTINUE");
 	}
 
 skip:
@@ -3681,7 +3592,7 @@ TEST(user_notification_continue)
 	EXPECT_EQ(true, WIFEXITED(status));
 	EXPECT_EQ(0, WEXITSTATUS(status)) {
 		if (WEXITSTATUS(status) == 2) {
-			XFAIL(return, "Kernel does not support kcmp() syscall");
+			SKIP(return, "Kernel does not support kcmp() syscall");
 			return;
 		}
 	}
diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index ad0f8df2ca0a..8934a3766d20 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -71,7 +71,7 @@ void my_usr1(int sig, siginfo_t *si, void *u)
 	swapcontext(&sc, &uc);
 	ksft_print_msg("%s\n", p->msg);
 	if (!p->flag) {
-		ksft_exit_skip("[RUN]\tAborting\n");
+		ksft_exit_fail_msg("[RUN]\tAborting\n");
 		exit(EXIT_FAILURE);
 	}
 }
@@ -144,7 +144,7 @@ int main(void)
 	err = sigaltstack(&stk, NULL);
 	if (err) {
 		if (errno == EINVAL) {
-			ksft_exit_skip(
+			ksft_test_result_skip(
 				"[NOTE]\tThe running kernel doesn't support SS_AUTODISARM\n");
 			/*
 			 * If test cases for the !SS_AUTODISARM variant were
diff --git a/tools/testing/selftests/sync/sync_test.c b/tools/testing/selftests/sync/sync_test.c
index 3824b66f41a0..414a617db993 100644
--- a/tools/testing/selftests/sync/sync_test.c
+++ b/tools/testing/selftests/sync/sync_test.c
@@ -86,9 +86,9 @@ int main(void)
 	int err;
 
 	ksft_print_header();
-	ksft_set_plan(3 + 7);
 
 	sync_api_supported();
+	ksft_set_plan(3 + 7);
 
 	ksft_print_msg("[RUN]\tTesting sync framework\n");
 
diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index f83391aa42cf..5cebfb356345 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -19,7 +19,6 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 
 #define __DEV_FULL "/sys/devices/virtual/mem/full/uevent"

--------------30EADDB4BC2B14BAD175AA6B--
