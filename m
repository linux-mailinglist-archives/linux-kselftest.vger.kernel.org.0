Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12264A8EE2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Feb 2022 21:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355193AbiBCUjc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Feb 2022 15:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbiBCUha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Feb 2022 15:37:30 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B830C061772
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Feb 2022 12:35:28 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id o10so3167401ilh.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Feb 2022 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=sMi/ry0VPEchkEVtZQsOkyVwV0CBtZonSddtv8ZEFtw=;
        b=dWqDctx28An+FK968i/CXLqOPypmJxfOQEfqMSl8rgOkvvfYBHSvrJpy76Na9VXpcz
         JmS84uFStoTaqbRlVNsFnXbJyeYk4ld9J6sc7CgKad8R0WT/0+IUK076CAQC/zM5eXPO
         4kCFAn15x59oN8GbM+tiARbkcPTyfNsja+du4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=sMi/ry0VPEchkEVtZQsOkyVwV0CBtZonSddtv8ZEFtw=;
        b=2dBcNWP/4Nrm6w8E1q0AfOlVL2Zfr9GZeqLobZ+orCFP9/z/5dOUXdIZTsevWnz0I2
         PDrggwknBuiohxFTSoOrF7So/l68YGsRTRA+ktuTabL8YhtIxB+nbTZvGq5MLv2wWwR9
         ccCkxOJZwFt3b1TuewYv5J3ct1JccM3WSHFTlyhTapcoBKfXvgdqJy8H+qdv4WmbHmdh
         CDQZVc4IRAdrApXHiAHShpf8qtjRqd4A0eeDlx/koDRQMFTw627y+/cprnUt3WsrE9a5
         qtywYE6T5rUabUak6zD3g6YL8UTBe7p/qklHJNor6jPM2/dYto/pp7Pe+TBUFI6nKOxm
         XoMA==
X-Gm-Message-State: AOAM530npWC9P8fuelIdPosnOunvxzkErYMXh7+IGQXSlkb2OnbsuSk2
        7vRHMvE7/e+X+BGNbWybdahtug==
X-Google-Smtp-Source: ABdhPJySx8xbPSP773Dhs20ussfV2oB8xU0xnyV2A63aoGoUcClTgwm2YQUaRXSbcCVDnN+qKkCX1A==
X-Received: by 2002:a05:6e02:15c4:: with SMTP id q4mr20072586ilu.281.1643920527556;
        Thu, 03 Feb 2022 12:35:27 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id x16sm3410111ilq.71.2022.02.03.12.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 12:35:27 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.17-rc3
Message-ID: <b82319f7-14d7-6a37-7b11-c53d90cadc4a@linuxfoundation.org>
Date:   Thu, 3 Feb 2022 13:35:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A90EBA950243061E631C7743"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------A90EBA950243061E631C7743
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.17-rc3

This Kselftest fixes update for Linux 5.17-rc3 consists of important
fixes to several tests and documentation clarification on running
mainline kselftest on stable releases. A few notable fixes:

- fix kselftest run hang due to child processes that haven't been
   terminated. Fix signals all child processes
- fix false pass/fail results from vdso_test_abi, openat2, mincore
- build failures when using -j (multiple jobs) option
- exec test build failure due to incorrect build rule for a run-time
   created "pipe"
- zram test fixes related to interaction with zram-generator to
   make sure zram test to coordinate deleted with zram-generator
- zram test compression ratio calculation fix and skipping
   max_comp_streams.
- increasing rtc test timeout
- cpufreq test to write test results to stdout which will necessary on
   automated test systems

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.17-rc3

for you to fetch changes up to ec049891b2dc16591813eacaddc476b3d27c8c14:

   kselftest: Fix vdso_test_abi return status (2022-01-31 10:35:14 -0700)

----------------------------------------------------------------
linux-kselftest-fixes-5.17-rc3

This Kselftest fixes update for Linux 5.17-rc3 consists of important
fixes to several tests and documentation clarification on running
mainline kselftest on stable releases. A few notable fixes:

- fix kselftest run hang due to child processes that haven't been
   terminated. Fix signals all child processes
- fix false pass/fail results from vdso_test_abi, openat2, mincore
- build failures when using -j (multiple jobs) option
- exec test build failure due to incorrect build rule for a run-time
   created "pipe"
- zram test fixes related to interaction with zram-generator to
   make sure zram test to coordinate deleted with zram-generator
- zram test compression ratio calculation fix and skipping
   max_comp_streams.
- increasing rtc test timeout
- cpufreq test to write test results to stdout which will necessary on
   automated test systems

----------------------------------------------------------------
Cristian Marussi (4):
       selftests: openat2: Print also errno in failure messages
       selftests: openat2: Add missing dependency in Makefile
       selftests: openat2: Skip testcases that fail with EOPNOTSUPP
       selftests: skip mincore.check_file_mmap when fs lacks needed support

Li Zhijian (1):
       kselftest: signal all child processes

Muhammad Usama Anjum (2):
       selftests/exec: Remove pipe from TEST_GEN_FILES
       selftests: futex: Use variable MAKE instead of make

Nícolas F. R. A. Prado (2):
       selftests: rtc: Increase test timeout so that all tests run
       selftests: cpufreq: Write test output to stdout as well

Shuah Khan (1):
       docs/kselftest: clarify running mainline tests on stables

Vincenzo Frascino (1):
       kselftest: Fix vdso_test_abi return status

Yang Xu (3):
       selftests/zram: Skip max_comp_streams interface on newer kernel
       selftests/zram01.sh: Fix compression ratio calculation
       selftests/zram: Adapt the situation that /dev/zram0 is being used

  Documentation/dev-tools/kselftest.rst              |   8 ++
  tools/testing/selftests/cpufreq/main.sh            |   2 +-
  tools/testing/selftests/exec/Makefile              |   2 +-
  tools/testing/selftests/futex/Makefile             |   4 +-
  tools/testing/selftests/kselftest_harness.h        |   4 +-
  tools/testing/selftests/mincore/mincore_selftest.c |  20 ++-
  tools/testing/selftests/openat2/Makefile           |   2 +-
  tools/testing/selftests/openat2/helpers.h          |  12 +-
  tools/testing/selftests/openat2/openat2_test.c     |  12 +-
  tools/testing/selftests/rtc/settings               |   2 +-
  tools/testing/selftests/vDSO/vdso_test_abi.c       | 135 ++++++++++-----------
  tools/testing/selftests/zram/zram.sh               |  15 +--
  tools/testing/selftests/zram/zram01.sh             |  33 ++---
  tools/testing/selftests/zram/zram02.sh             |   1 -
  tools/testing/selftests/zram/zram_lib.sh           | 134 +++++++++++++-------
  15 files changed, 209 insertions(+), 177 deletions(-)
----------------------------------------------------------------

--------------A90EBA950243061E631C7743
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.17-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.17-rc3.diff"

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index dcefee707ccd..a833ecf12fbc 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -7,6 +7,14 @@ directory. These are intended to be small tests to exercise individual code
 paths in the kernel. Tests are intended to be run after building, installing
 and booting a kernel.
 
+Kselftest from mainline can be run on older stable kernels. Running tests
+from mainline offers the best coverage. Several test rings run mainline
+kselftest suite on stable releases. The reason is that when a new test
+gets added to test existing code to regression test a bug, we should be
+able to run that test on an older kernel. Hence, it is important to keep
+code that can still test an older kernel and make sure it skips the test
+gracefully on newer releases.
+
 You can find additional information on Kselftest framework, how to
 write new tests using the framework on Kselftest wiki:
 
diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
index 31f8c9a76c5f..60ce18ed0666 100755
--- a/tools/testing/selftests/cpufreq/main.sh
+++ b/tools/testing/selftests/cpufreq/main.sh
@@ -194,5 +194,5 @@ prerequisite
 
 # Run requested functions
 clear_dumps $OUTFILE
-do_test >> $OUTFILE.txt
+do_test | tee -a $OUTFILE.txt
 dmesg_dumps $OUTFILE
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index dd61118df66e..12c5e27d32c1 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -5,7 +5,7 @@ CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script non-regular
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216
-TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
+TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
 
diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
index 12631f0076a1..11e157d7533b 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -11,7 +11,7 @@ all:
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
-		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
 		if [ -e $$DIR/$(TEST_PROGS) ]; then \
 			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/; \
 		fi \
@@ -32,6 +32,6 @@ override define CLEAN
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
-		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
 	done
 endef
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 471eaa7b3a3f..11779405dc80 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -877,7 +877,8 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	}
 
 	t->timed_out = true;
-	kill(t->pid, SIGKILL);
+	// signal process group
+	kill(-(t->pid), SIGKILL);
 }
 
 void __wait_for_test(struct __test_metadata *t)
@@ -987,6 +988,7 @@ void __run_test(struct __fixture_metadata *f,
 		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
 		t->passed = 0;
 	} else if (t->pid == 0) {
+		setpgrp();
 		t->fn(t, variant);
 		if (t->skip)
 			_exit(255);
diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e54106643337..4c88238fc8f0 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -207,15 +207,21 @@ TEST(check_file_mmap)
 
 	errno = 0;
 	fd = open(".", O_TMPFILE | O_RDWR, 0600);
-	ASSERT_NE(-1, fd) {
-		TH_LOG("Can't create temporary file: %s",
-			strerror(errno));
+	if (fd < 0) {
+		ASSERT_EQ(errno, EOPNOTSUPP) {
+			TH_LOG("Can't create temporary file: %s",
+			       strerror(errno));
+		}
+		SKIP(goto out_free, "O_TMPFILE not supported by filesystem.");
 	}
 	errno = 0;
 	retval = fallocate(fd, 0, 0, FILE_SIZE);
-	ASSERT_EQ(0, retval) {
-		TH_LOG("Error allocating space for the temporary file: %s",
-			strerror(errno));
+	if (retval) {
+		ASSERT_EQ(errno, EOPNOTSUPP) {
+			TH_LOG("Error allocating space for the temporary file: %s",
+			       strerror(errno));
+		}
+		SKIP(goto out_close, "fallocate not supported by filesystem.");
 	}
 
 	/*
@@ -271,7 +277,9 @@ TEST(check_file_mmap)
 	}
 
 	munmap(addr, FILE_SIZE);
+out_close:
 	close(fd);
+out_free:
 	free(vec);
 }
 
diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 4b93b1417b86..843ba56d8e49 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -5,4 +5,4 @@ TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS): helpers.c
+$(TEST_GEN_PROGS): helpers.c helpers.h
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index a6ea27344db2..7056340b9339 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -9,6 +9,7 @@
 
 #define _GNU_SOURCE
 #include <stdint.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <linux/types.h>
 #include "../kselftest.h"
@@ -62,11 +63,12 @@ bool needs_openat2(const struct open_how *how);
 					(similar to chroot(2)). */
 #endif /* RESOLVE_IN_ROOT */
 
-#define E_func(func, ...)						\
-	do {								\
-		if (func(__VA_ARGS__) < 0)				\
-			ksft_exit_fail_msg("%s:%d %s failed\n", \
-					   __FILE__, __LINE__, #func);\
+#define E_func(func, ...)						      \
+	do {								      \
+		errno = 0;						      \
+		if (func(__VA_ARGS__) < 0)				      \
+			ksft_exit_fail_msg("%s:%d %s failed - errno:%d\n",    \
+					   __FILE__, __LINE__, #func, errno); \
 	} while (0)
 
 #define E_asprintf(...)		E_func(asprintf,	__VA_ARGS__)
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 1bddbe934204..7fb902099de4 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -259,6 +259,16 @@ void test_openat2_flags(void)
 		unlink(path);
 
 		fd = sys_openat2(AT_FDCWD, path, &test->how);
+		if (fd < 0 && fd == -EOPNOTSUPP) {
+			/*
+			 * Skip the testcase if it failed because not supported
+			 * by FS. (e.g. a valid O_TMPFILE combination on NFS)
+			 */
+			ksft_test_result_skip("openat2 with %s fails with %d (%s)\n",
+					      test->name, fd, strerror(-fd));
+			goto next;
+		}
+
 		if (test->err >= 0)
 			failed = (fd < 0);
 		else
@@ -303,7 +313,7 @@ void test_openat2_flags(void)
 		else
 			resultfn("openat2 with %s fails with %d (%s)\n",
 				 test->name, test->err, strerror(-test->err));
-
+next:
 		free(fdpath);
 		fflush(stdout);
 	}
diff --git a/tools/testing/selftests/rtc/settings b/tools/testing/selftests/rtc/settings
index ba4d85f74cd6..a953c96aa16e 100644
--- a/tools/testing/selftests/rtc/settings
+++ b/tools/testing/selftests/rtc/settings
@@ -1 +1 @@
-timeout=90
+timeout=180
diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 3d603f1394af..883ca85424bc 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -33,110 +33,114 @@ typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, struct timespec *ts);
 typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
 typedef time_t (*vdso_time_t)(time_t *t);
 
-static int vdso_test_gettimeofday(void)
+#define VDSO_TEST_PASS_MSG()	"\n%s(): PASS\n", __func__
+#define VDSO_TEST_FAIL_MSG(x)	"\n%s(): %s FAIL\n", __func__, x
+#define VDSO_TEST_SKIP_MSG(x)	"\n%s(): SKIP: Could not find %s\n", __func__, x
+
+static void vdso_test_gettimeofday(void)
 {
 	/* Find gettimeofday. */
 	vdso_gettimeofday_t vdso_gettimeofday =
 		(vdso_gettimeofday_t)vdso_sym(version, name[0]);
 
 	if (!vdso_gettimeofday) {
-		printf("Could not find %s\n", name[0]);
-		return KSFT_SKIP;
+		ksft_test_result_skip(VDSO_TEST_SKIP_MSG(name[0]));
+		return;
 	}
 
 	struct timeval tv;
 	long ret = vdso_gettimeofday(&tv, 0);
 
 	if (ret == 0) {
-		printf("The time is %lld.%06lld\n",
-		       (long long)tv.tv_sec, (long long)tv.tv_usec);
+		ksft_print_msg("The time is %lld.%06lld\n",
+			       (long long)tv.tv_sec, (long long)tv.tv_usec);
+		ksft_test_result_pass(VDSO_TEST_PASS_MSG());
 	} else {
-		printf("%s failed\n", name[0]);
-		return KSFT_FAIL;
+		ksft_test_result_fail(VDSO_TEST_FAIL_MSG(name[0]));
 	}
-
-	return KSFT_PASS;
 }
 
-static int vdso_test_clock_gettime(clockid_t clk_id)
+static void vdso_test_clock_gettime(clockid_t clk_id)
 {
 	/* Find clock_gettime. */
 	vdso_clock_gettime_t vdso_clock_gettime =
 		(vdso_clock_gettime_t)vdso_sym(version, name[1]);
 
 	if (!vdso_clock_gettime) {
-		printf("Could not find %s\n", name[1]);
-		return KSFT_SKIP;
+		ksft_test_result_skip(VDSO_TEST_SKIP_MSG(name[1]));
+		return;
 	}
 
 	struct timespec ts;
 	long ret = vdso_clock_gettime(clk_id, &ts);
 
 	if (ret == 0) {
-		printf("The time is %lld.%06lld\n",
-		       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+		ksft_print_msg("The time is %lld.%06lld\n",
+			       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+		ksft_test_result_pass(VDSO_TEST_PASS_MSG());
 	} else {
-		printf("%s failed\n", name[1]);
-		return KSFT_FAIL;
+		ksft_test_result_fail(VDSO_TEST_FAIL_MSG(name[1]));
 	}
-
-	return KSFT_PASS;
 }
 
-static int vdso_test_time(void)
+static void vdso_test_time(void)
 {
 	/* Find time. */
 	vdso_time_t vdso_time =
 		(vdso_time_t)vdso_sym(version, name[2]);
 
 	if (!vdso_time) {
-		printf("Could not find %s\n", name[2]);
-		return KSFT_SKIP;
+		ksft_test_result_skip(VDSO_TEST_SKIP_MSG(name[2]));
+		return;
 	}
 
 	long ret = vdso_time(NULL);
 
 	if (ret > 0) {
-		printf("The time in hours since January 1, 1970 is %lld\n",
+		ksft_print_msg("The time in hours since January 1, 1970 is %lld\n",
 				(long long)(ret / 3600));
+		ksft_test_result_pass(VDSO_TEST_PASS_MSG());
 	} else {
-		printf("%s failed\n", name[2]);
-		return KSFT_FAIL;
+		ksft_test_result_fail(VDSO_TEST_FAIL_MSG(name[2]));
 	}
-
-	return KSFT_PASS;
 }
 
-static int vdso_test_clock_getres(clockid_t clk_id)
+static void vdso_test_clock_getres(clockid_t clk_id)
 {
+	int clock_getres_fail = 0;
+
 	/* Find clock_getres. */
 	vdso_clock_getres_t vdso_clock_getres =
 		(vdso_clock_getres_t)vdso_sym(version, name[3]);
 
 	if (!vdso_clock_getres) {
-		printf("Could not find %s\n", name[3]);
-		return KSFT_SKIP;
+		ksft_test_result_skip(VDSO_TEST_SKIP_MSG(name[3]));
+		return;
 	}
 
 	struct timespec ts, sys_ts;
 	long ret = vdso_clock_getres(clk_id, &ts);
 
 	if (ret == 0) {
-		printf("The resolution is %lld %lld\n",
-		       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+		ksft_print_msg("The vdso resolution is %lld %lld\n",
+			       (long long)ts.tv_sec, (long long)ts.tv_nsec);
 	} else {
-		printf("%s failed\n", name[3]);
-		return KSFT_FAIL;
+		clock_getres_fail++;
 	}
 
 	ret = syscall(SYS_clock_getres, clk_id, &sys_ts);
 
-	if ((sys_ts.tv_sec != ts.tv_sec) || (sys_ts.tv_nsec != ts.tv_nsec)) {
-		printf("%s failed\n", name[3]);
-		return KSFT_FAIL;
-	}
+	ksft_print_msg("The syscall resolution is %lld %lld\n",
+			(long long)sys_ts.tv_sec, (long long)sys_ts.tv_nsec);
 
-	return KSFT_PASS;
+	if ((sys_ts.tv_sec != ts.tv_sec) || (sys_ts.tv_nsec != ts.tv_nsec))
+		clock_getres_fail++;
+
+	if (clock_getres_fail > 0) {
+		ksft_test_result_fail(VDSO_TEST_FAIL_MSG(name[3]));
+	} else {
+		ksft_test_result_pass(VDSO_TEST_PASS_MSG());
+	}
 }
 
 const char *vdso_clock_name[12] = {
@@ -158,36 +162,23 @@ const char *vdso_clock_name[12] = {
  * This function calls vdso_test_clock_gettime and vdso_test_clock_getres
  * with different values for clock_id.
  */
-static inline int vdso_test_clock(clockid_t clock_id)
+static inline void vdso_test_clock(clockid_t clock_id)
 {
-	int ret0, ret1;
-
-	ret0 = vdso_test_clock_gettime(clock_id);
-	/* A skipped test is considered passed */
-	if (ret0 == KSFT_SKIP)
-		ret0 = KSFT_PASS;
-
-	ret1 = vdso_test_clock_getres(clock_id);
-	/* A skipped test is considered passed */
-	if (ret1 == KSFT_SKIP)
-		ret1 = KSFT_PASS;
+	ksft_print_msg("\nclock_id: %s\n", vdso_clock_name[clock_id]);
 
-	ret0 += ret1;
+	vdso_test_clock_gettime(clock_id);
 
-	printf("clock_id: %s", vdso_clock_name[clock_id]);
-
-	if (ret0 > 0)
-		printf(" [FAIL]\n");
-	else
-		printf(" [PASS]\n");
-
-	return ret0;
+	vdso_test_clock_getres(clock_id);
 }
 
+#define VDSO_TEST_PLAN	16
+
 int main(int argc, char **argv)
 {
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
-	int ret;
+
+	ksft_print_header();
+	ksft_set_plan(VDSO_TEST_PLAN);
 
 	if (!sysinfo_ehdr) {
 		printf("AT_SYSINFO_EHDR is not present!\n");
@@ -201,44 +192,42 @@ int main(int argc, char **argv)
 
 	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
 
-	ret = vdso_test_gettimeofday();
+	vdso_test_gettimeofday();
 
 #if _POSIX_TIMERS > 0
 
 #ifdef CLOCK_REALTIME
-	ret += vdso_test_clock(CLOCK_REALTIME);
+	vdso_test_clock(CLOCK_REALTIME);
 #endif
 
 #ifdef CLOCK_BOOTTIME
-	ret += vdso_test_clock(CLOCK_BOOTTIME);
+	vdso_test_clock(CLOCK_BOOTTIME);
 #endif
 
 #ifdef CLOCK_TAI
-	ret += vdso_test_clock(CLOCK_TAI);
+	vdso_test_clock(CLOCK_TAI);
 #endif
 
 #ifdef CLOCK_REALTIME_COARSE
-	ret += vdso_test_clock(CLOCK_REALTIME_COARSE);
+	vdso_test_clock(CLOCK_REALTIME_COARSE);
 #endif
 
 #ifdef CLOCK_MONOTONIC
-	ret += vdso_test_clock(CLOCK_MONOTONIC);
+	vdso_test_clock(CLOCK_MONOTONIC);
 #endif
 
 #ifdef CLOCK_MONOTONIC_RAW
-	ret += vdso_test_clock(CLOCK_MONOTONIC_RAW);
+	vdso_test_clock(CLOCK_MONOTONIC_RAW);
 #endif
 
 #ifdef CLOCK_MONOTONIC_COARSE
-	ret += vdso_test_clock(CLOCK_MONOTONIC_COARSE);
+	vdso_test_clock(CLOCK_MONOTONIC_COARSE);
 #endif
 
 #endif
 
-	ret += vdso_test_time();
-
-	if (ret > 0)
-		return KSFT_FAIL;
+	vdso_test_time();
 
-	return KSFT_PASS;
+	ksft_print_cnts();
+	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
 }
diff --git a/tools/testing/selftests/zram/zram.sh b/tools/testing/selftests/zram/zram.sh
index 232e958ec454..b0b91d9b0dc2 100755
--- a/tools/testing/selftests/zram/zram.sh
+++ b/tools/testing/selftests/zram/zram.sh
@@ -2,9 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TCID="zram.sh"
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
 . ./zram_lib.sh
 
 run_zram () {
@@ -18,14 +15,4 @@ echo ""
 
 check_prereqs
 
-# check zram module exists
-MODULE_PATH=/lib/modules/`uname -r`/kernel/drivers/block/zram/zram.ko
-if [ -f $MODULE_PATH ]; then
-	run_zram
-elif [ -b /dev/zram0 ]; then
-	run_zram
-else
-	echo "$TCID : No zram.ko module or /dev/zram0 device file not found"
-	echo "$TCID : CONFIG_ZRAM is not set"
-	exit $ksft_skip
-fi
+run_zram
diff --git a/tools/testing/selftests/zram/zram01.sh b/tools/testing/selftests/zram/zram01.sh
index 114863d9fb87..8f4affe34f3e 100755
--- a/tools/testing/selftests/zram/zram01.sh
+++ b/tools/testing/selftests/zram/zram01.sh
@@ -33,9 +33,7 @@ zram_algs="lzo"
 
 zram_fill_fs()
 {
-	local mem_free0=$(free -m | awk 'NR==2 {print $4}')
-
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		echo "fill zram$i..."
 		local b=0
 		while [ true ]; do
@@ -45,29 +43,17 @@ zram_fill_fs()
 			b=$(($b + 1))
 		done
 		echo "zram$i can be filled with '$b' KB"
-	done
 
-	local mem_free1=$(free -m | awk 'NR==2 {print $4}')
-	local used_mem=$(($mem_free0 - $mem_free1))
+		local mem_used_total=`awk '{print $3}' "/sys/block/zram$i/mm_stat"`
+		local v=$((100 * 1024 * $b / $mem_used_total))
+		if [ "$v" -lt 100 ]; then
+			 echo "FAIL compression ratio: 0.$v:1"
+			 ERR_CODE=-1
+			 return
+		fi
 
-	local total_size=0
-	for sm in $zram_sizes; do
-		local s=$(echo $sm | sed 's/M//')
-		total_size=$(($total_size + $s))
+		echo "zram compression ratio: $(echo "scale=2; $v / 100 " | bc):1: OK"
 	done
-
-	echo "zram used ${used_mem}M, zram disk sizes ${total_size}M"
-
-	local v=$((100 * $total_size / $used_mem))
-
-	if [ "$v" -lt 100 ]; then
-		echo "FAIL compression ratio: 0.$v:1"
-		ERR_CODE=-1
-		zram_cleanup
-		return
-	fi
-
-	echo "zram compression ratio: $(echo "scale=2; $v / 100 " | bc):1: OK"
 }
 
 check_prereqs
@@ -81,7 +67,6 @@ zram_mount
 
 zram_fill_fs
 zram_cleanup
-zram_unload
 
 if [ $ERR_CODE -ne 0 ]; then
 	echo "$TCID : [FAIL]"
diff --git a/tools/testing/selftests/zram/zram02.sh b/tools/testing/selftests/zram/zram02.sh
index e83b404807c0..2418b0c4ed13 100755
--- a/tools/testing/selftests/zram/zram02.sh
+++ b/tools/testing/selftests/zram/zram02.sh
@@ -36,7 +36,6 @@ zram_set_memlimit
 zram_makeswap
 zram_swapoff
 zram_cleanup
-zram_unload
 
 if [ $ERR_CODE -ne 0 ]; then
 	echo "$TCID : [FAIL]"
diff --git a/tools/testing/selftests/zram/zram_lib.sh b/tools/testing/selftests/zram/zram_lib.sh
index 6f872f266fd1..21ec1966de76 100755
--- a/tools/testing/selftests/zram/zram_lib.sh
+++ b/tools/testing/selftests/zram/zram_lib.sh
@@ -5,12 +5,17 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 # Modified: Naresh Kamboju <naresh.kamboju@linaro.org>
 
-MODULE=0
 dev_makeswap=-1
 dev_mounted=-1
-
+dev_start=0
+dev_end=-1
+module_load=-1
+sys_control=-1
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
+kernel_version=`uname -r | cut -d'.' -f1,2`
+kernel_major=${kernel_version%.*}
+kernel_minor=${kernel_version#*.}
 
 trap INT
 
@@ -25,68 +30,104 @@ check_prereqs()
 	fi
 }
 
+kernel_gte()
+{
+	major=${1%.*}
+	minor=${1#*.}
+
+	if [ $kernel_major -gt $major ]; then
+		return 0
+	elif [[ $kernel_major -eq $major && $kernel_minor -ge $minor ]]; then
+		return 0
+	fi
+
+	return 1
+}
+
 zram_cleanup()
 {
 	echo "zram cleanup"
 	local i=
-	for i in $(seq 0 $dev_makeswap); do
+	for i in $(seq $dev_start $dev_makeswap); do
 		swapoff /dev/zram$i
 	done
 
-	for i in $(seq 0 $dev_mounted); do
+	for i in $(seq $dev_start $dev_mounted); do
 		umount /dev/zram$i
 	done
 
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		echo 1 > /sys/block/zram${i}/reset
 		rm -rf zram$i
 	done
 
-}
+	if [ $sys_control -eq 1 ]; then
+		for i in $(seq $dev_start $dev_end); do
+			echo $i > /sys/class/zram-control/hot_remove
+		done
+	fi
 
-zram_unload()
-{
-	if [ $MODULE -ne 0 ] ; then
-		echo "zram rmmod zram"
+	if [ $module_load -eq 1 ]; then
 		rmmod zram > /dev/null 2>&1
 	fi
 }
 
 zram_load()
 {
-	# check zram module exists
-	MODULE_PATH=/lib/modules/`uname -r`/kernel/drivers/block/zram/zram.ko
-	if [ -f $MODULE_PATH ]; then
-		MODULE=1
-		echo "create '$dev_num' zram device(s)"
-		modprobe zram num_devices=$dev_num
-		if [ $? -ne 0 ]; then
-			echo "failed to insert zram module"
-			exit 1
-		fi
-
-		dev_num_created=$(ls /dev/zram* | wc -w)
+	echo "create '$dev_num' zram device(s)"
+
+	# zram module loaded, new kernel
+	if [ -d "/sys/class/zram-control" ]; then
+		echo "zram modules already loaded, kernel supports" \
+			"zram-control interface"
+		dev_start=$(ls /dev/zram* | wc -w)
+		dev_end=$(($dev_start + $dev_num - 1))
+		sys_control=1
+
+		for i in $(seq $dev_start $dev_end); do
+			cat /sys/class/zram-control/hot_add > /dev/null
+		done
+
+		echo "all zram devices (/dev/zram$dev_start~$dev_end" \
+			"successfully created"
+		return 0
+	fi
 
-		if [ "$dev_num_created" -ne "$dev_num" ]; then
-			echo "unexpected num of devices: $dev_num_created"
-			ERR_CODE=-1
+	# detect old kernel or built-in
+	modprobe zram num_devices=$dev_num
+	if [ ! -d "/sys/class/zram-control" ]; then
+		if grep -q '^zram' /proc/modules; then
+			rmmod zram > /dev/null 2>&1
+			if [ $? -ne 0 ]; then
+				echo "zram module is being used on old kernel" \
+					"without zram-control interface"
+				exit $ksft_skip
+			fi
 		else
-			echo "zram load module successful"
+			echo "test needs CONFIG_ZRAM=m on old kernel without" \
+				"zram-control interface"
+			exit $ksft_skip
 		fi
-	elif [ -b /dev/zram0 ]; then
-		echo "/dev/zram0 device file found: OK"
-	else
-		echo "ERROR: No zram.ko module or no /dev/zram0 device found"
-		echo "$TCID : CONFIG_ZRAM is not set"
-		exit 1
+		modprobe zram num_devices=$dev_num
 	fi
+
+	module_load=1
+	dev_end=$(($dev_num - 1))
+	echo "all zram devices (/dev/zram0~$dev_end) successfully created"
 }
 
 zram_max_streams()
 {
 	echo "set max_comp_streams to zram device(s)"
 
-	local i=0
+	kernel_gte 4.7
+	if [ $? -eq 0 ]; then
+		echo "The device attribute max_comp_streams was"\
+		               "deprecated in 4.7"
+		return 0
+	fi
+
+	local i=$dev_start
 	for max_s in $zram_max_streams; do
 		local sys_path="/sys/block/zram${i}/max_comp_streams"
 		echo $max_s > $sys_path || \
@@ -98,7 +139,7 @@ zram_max_streams()
 			echo "FAIL can't set max_streams '$max_s', get $max_stream"
 
 		i=$(($i + 1))
-		echo "$sys_path = '$max_streams' ($i/$dev_num)"
+		echo "$sys_path = '$max_streams'"
 	done
 
 	echo "zram max streams: OK"
@@ -108,15 +149,16 @@ zram_compress_alg()
 {
 	echo "test that we can set compression algorithm"
 
-	local algs=$(cat /sys/block/zram0/comp_algorithm)
+	local i=$dev_start
+	local algs=$(cat /sys/block/zram${i}/comp_algorithm)
 	echo "supported algs: $algs"
-	local i=0
+
 	for alg in $zram_algs; do
 		local sys_path="/sys/block/zram${i}/comp_algorithm"
 		echo "$alg" >	$sys_path || \
 			echo "FAIL can't set '$alg' to $sys_path"
 		i=$(($i + 1))
-		echo "$sys_path = '$alg' ($i/$dev_num)"
+		echo "$sys_path = '$alg'"
 	done
 
 	echo "zram set compression algorithm: OK"
@@ -125,14 +167,14 @@ zram_compress_alg()
 zram_set_disksizes()
 {
 	echo "set disk size to zram device(s)"
-	local i=0
+	local i=$dev_start
 	for ds in $zram_sizes; do
 		local sys_path="/sys/block/zram${i}/disksize"
 		echo "$ds" >	$sys_path || \
 			echo "FAIL can't set '$ds' to $sys_path"
 
 		i=$(($i + 1))
-		echo "$sys_path = '$ds' ($i/$dev_num)"
+		echo "$sys_path = '$ds'"
 	done
 
 	echo "zram set disksizes: OK"
@@ -142,14 +184,14 @@ zram_set_memlimit()
 {
 	echo "set memory limit to zram device(s)"
 
-	local i=0
+	local i=$dev_start
 	for ds in $zram_mem_limits; do
 		local sys_path="/sys/block/zram${i}/mem_limit"
 		echo "$ds" >	$sys_path || \
 			echo "FAIL can't set '$ds' to $sys_path"
 
 		i=$(($i + 1))
-		echo "$sys_path = '$ds' ($i/$dev_num)"
+		echo "$sys_path = '$ds'"
 	done
 
 	echo "zram set memory limit: OK"
@@ -158,8 +200,8 @@ zram_set_memlimit()
 zram_makeswap()
 {
 	echo "make swap with zram device(s)"
-	local i=0
-	for i in $(seq 0 $(($dev_num - 1))); do
+	local i=$dev_start
+	for i in $(seq $dev_start $dev_end); do
 		mkswap /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
 			cat err.log
@@ -182,7 +224,7 @@ zram_makeswap()
 zram_swapoff()
 {
 	local i=
-	for i in $(seq 0 $dev_makeswap); do
+	for i in $(seq $dev_start $dev_end); do
 		swapoff /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
 			cat err.log
@@ -196,7 +238,7 @@ zram_swapoff()
 
 zram_makefs()
 {
-	local i=0
+	local i=$dev_start
 	for fs in $zram_filesystems; do
 		# if requested fs not supported default it to ext2
 		which mkfs.$fs > /dev/null 2>&1 || fs=ext2
@@ -215,7 +257,7 @@ zram_makefs()
 zram_mount()
 {
 	local i=0
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		echo "mount /dev/zram$i"
 		mkdir zram$i
 		mount /dev/zram$i zram$i > /dev/null || \

--------------A90EBA950243061E631C7743--
