Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B752A049
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 23:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404255AbfEXVTc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 17:19:32 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:40436 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfEXVTc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 17:19:32 -0400
Received: by mail-io1-f46.google.com with SMTP id n5so2694465ioc.7
        for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2019 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=KYXQt2whxv6x7kpRG6iEs+vvTF4+uz3zFZJURRtED+s=;
        b=XWsYcJOsGthJS8ikaosBR2+hY/Po31NL67DTA9TzIFypwW344BUbHheOQQk5j1dy3d
         3kVIPcNch1VUKoH8K1+Q4V/zwa2Ts1Q2+KJQ0yHJd6I7VZeAbXUc3IXA2ELoy26Ux0da
         iN4Bxy5xOq4AbgRDZmn0Ja7Es+/YyT9ppW8Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=KYXQt2whxv6x7kpRG6iEs+vvTF4+uz3zFZJURRtED+s=;
        b=Y5EMvlNhC7d7mT/Anyl3bDIGl7nEaGQ6YeU9f9WgLR6mGudiktSGDb2rPSDsKMxXJ3
         rnap5mD9xgvABnQVT/i+kfwYA3wgq132NGvRDFwATN4b+hRirgd+KSduGXb4ZuhFyvOY
         CMYxqyNHO6i6EA8wNnAyTrHMPMSJbu+5d5YUvwyguv22yg3yeHdvID3oNc/pXKZbppvW
         XHirdcvhtjplmFTttRmEM+FuBuyWTKgx9wq/WpjbZPxoiSojwyf0acmAn25PKFhEPnZh
         8aef8yKR/A6N9/ZyxgDDa3qqV3MvYAZkfwnM+bMpz3Hjw+aKbAmhRAT81MvtcScFEDVI
         /BfQ==
X-Gm-Message-State: APjAAAWJv1vuloICvPlmiJGskF9FJyCvkY/hwQ3Cwzs4sTZygi9QKpPu
        ScDXIWKEzt4t5iSPKEw4Jcry2nw4aS4=
X-Google-Smtp-Source: APXvYqyGRqVSIpEzwmE2FXWOJuny+ypfonApKNSsX2sTpzbIXTgM1Q6K6vMvy1Dkw3aAbMeOGntcGQ==
X-Received: by 2002:a6b:8b49:: with SMTP id n70mr35095442iod.198.1558732771302;
        Fri, 24 May 2019 14:19:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h125sm1720701ita.44.2019.05.24.14.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 14:19:30 -0700 (PDT)
To:     torvalds@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tong Bo <bo.tong@intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.2-rc2
Message-ID: <46b8fc51-ac8f-c03d-443e-4bd265cd4527@linuxfoundation.org>
Date:   Fri, 24 May 2019 15:19:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7A70FC3819073854B4F83C8C"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------7A70FC3819073854B4F83C8C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.2-rc2.

This Kselftest fixes update for Linux 5.2-rc2 consists of:

- 2 fixes to regressions introduced in kselftest Makefile test run
   output refactoring work from Kees Cook.
- Adding Atom support to syscall_arg_fault test from Tong Bo.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.2-rc2

for you to fetch changes up to fe48319243a626c860fd666ca032daacc2ba84a5:

   selftests/timers: Add missing fflush(stdout) calls (2019-05-21 
09:24:31 -0600)

----------------------------------------------------------------
linux-kselftest-5.2-rc2

This Kselftest fixes update for Linux 5.2-rc2 consists of:

- 2 fixes to regressions introduced in kselftest Makefile test run output
   refactoring work from Kees Cook.
- Adding Atom support to syscall_arg_fault test from Tong Bo.

----------------------------------------------------------------
Kees Cook (2):
       selftests: Remove forced unbuffering for test running
       selftests/timers: Add missing fflush(stdout) calls

Tong Bo (1):
       selftests/x86: Support Atom for syscall_arg_fault test

  tools/testing/selftests/kselftest/runner.sh     | 12 +-----------
  tools/testing/selftests/timers/adjtick.c        |  1 +
  tools/testing/selftests/timers/leapcrash.c      |  1 +
  tools/testing/selftests/timers/mqueue-lat.c     |  1 +
  tools/testing/selftests/timers/nanosleep.c      |  1 +
  tools/testing/selftests/timers/nsleep-lat.c     |  1 +
  tools/testing/selftests/timers/raw_skew.c       |  1 +
  tools/testing/selftests/timers/set-tai.c        |  1 +
  tools/testing/selftests/timers/set-tz.c         |  2 ++
  tools/testing/selftests/timers/threadtest.c     |  1 +
  tools/testing/selftests/timers/valid-adjtimex.c |  2 ++
  tools/testing/selftests/x86/syscall_arg_fault.c | 10 ++++++++--
  12 files changed, 21 insertions(+), 13 deletions(-)

----------------------------------------------------------------

--------------7A70FC3819073854B4F83C8C
Content-Type: text/x-patch;
 name="linux-kselftest-5.2-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.2-rc2.diff"

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index eff3ee303d0d..00c9020bdda8 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -24,16 +24,6 @@ tap_prefix()
 	fi
 }
 
-# If stdbuf is unavailable, we must fall back to line-at-a-time piping.
-tap_unbuffer()
-{
-	if ! which stdbuf >/dev/null ; then
-		"$@"
-	else
-		stdbuf -i0 -o0 -e0 "$@"
-	fi
-}
-
 run_one()
 {
 	DIR="$1"
@@ -54,7 +44,7 @@ run_one()
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
 		cd `dirname $TEST` > /dev/null
-		(((((tap_unbuffer ./$BASENAME_TEST 2>&1; echo $? >&3) |
+		(((((./$BASENAME_TEST 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
 		echo "ok $test_num $TEST_HDR_MSG") ||
diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index 0caca3a06bd2..54d8d87f36b3 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -136,6 +136,7 @@ int check_tick_adj(long tickval)
 
 	eppm = get_ppm_drift();
 	printf("%lld usec, %lld ppm", systick + (systick * eppm / MILLION), eppm);
+	fflush(stdout);
 
 	tx1.modes = 0;
 	adjtimex(&tx1);
diff --git a/tools/testing/selftests/timers/leapcrash.c b/tools/testing/selftests/timers/leapcrash.c
index 830c462f605d..dc80728ed191 100644
--- a/tools/testing/selftests/timers/leapcrash.c
+++ b/tools/testing/selftests/timers/leapcrash.c
@@ -101,6 +101,7 @@ int main(void)
 		}
 		clear_time_state();
 		printf(".");
+		fflush(stdout);
 	}
 	printf("[OK]\n");
 	return ksft_exit_pass();
diff --git a/tools/testing/selftests/timers/mqueue-lat.c b/tools/testing/selftests/timers/mqueue-lat.c
index 1867db5d6f5e..7916cf5cc6ff 100644
--- a/tools/testing/selftests/timers/mqueue-lat.c
+++ b/tools/testing/selftests/timers/mqueue-lat.c
@@ -102,6 +102,7 @@ int main(int argc, char **argv)
 	int ret;
 
 	printf("Mqueue latency :                          ");
+	fflush(stdout);
 
 	ret = mqueue_lat_test();
 	if (ret < 0) {
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 8adb0bb51d4d..71b5441c2fd9 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -142,6 +142,7 @@ int main(int argc, char **argv)
 			continue;
 
 		printf("Nanosleep %-31s ", clockstring(clockid));
+		fflush(stdout);
 
 		length = 10;
 		while (length <= (NSEC_PER_SEC * 10)) {
diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index c3c3dc10db17..eb3e79ed7b4a 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -155,6 +155,7 @@ int main(int argc, char **argv)
 			continue;
 
 		printf("nsleep latency %-26s ", clockstring(clockid));
+		fflush(stdout);
 
 		length = 10;
 		while (length <= (NSEC_PER_SEC * 10)) {
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index dcf73c5dab6e..b41d8dd0c40c 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -112,6 +112,7 @@ int main(int argv, char **argc)
 		printf("WARNING: ADJ_OFFSET in progress, this will cause inaccurate results\n");
 
 	printf("Estimating clock drift: ");
+	fflush(stdout);
 	sleep(120);
 
 	get_monotonic_and_raw(&mon, &raw);
diff --git a/tools/testing/selftests/timers/set-tai.c b/tools/testing/selftests/timers/set-tai.c
index 70fed27d8fd3..8c4179ee2ca2 100644
--- a/tools/testing/selftests/timers/set-tai.c
+++ b/tools/testing/selftests/timers/set-tai.c
@@ -55,6 +55,7 @@ int main(int argc, char **argv)
 	printf("tai offset started at %i\n", ret);
 
 	printf("Checking tai offsets can be properly set: ");
+	fflush(stdout);
 	for (i = 1; i <= 60; i++) {
 		ret = set_tai(i);
 		ret = get_tai();
diff --git a/tools/testing/selftests/timers/set-tz.c b/tools/testing/selftests/timers/set-tz.c
index 877fd5532fee..62bd33eb16f0 100644
--- a/tools/testing/selftests/timers/set-tz.c
+++ b/tools/testing/selftests/timers/set-tz.c
@@ -65,6 +65,7 @@ int main(int argc, char **argv)
 	printf("tz_minuteswest started at %i, dst at %i\n", min, dst);
 
 	printf("Checking tz_minuteswest can be properly set: ");
+	fflush(stdout);
 	for (i = -15*60; i < 15*60; i += 30) {
 		ret = set_tz(i, dst);
 		ret = get_tz_min();
@@ -76,6 +77,7 @@ int main(int argc, char **argv)
 	printf("[OK]\n");
 
 	printf("Checking invalid tz_minuteswest values are caught: ");
+	fflush(stdout);
 
 	if (!set_tz(-15*60-1, dst)) {
 		printf("[FAILED] %i didn't return failure!\n", -15*60-1);
diff --git a/tools/testing/selftests/timers/threadtest.c b/tools/testing/selftests/timers/threadtest.c
index 759c9c06f1a0..cf3e48919874 100644
--- a/tools/testing/selftests/timers/threadtest.c
+++ b/tools/testing/selftests/timers/threadtest.c
@@ -163,6 +163,7 @@ int main(int argc, char **argv)
 	strftime(buf, 255, "%a, %d %b %Y %T %z", localtime(&start));
 	printf("%s\n", buf);
 	printf("Testing consistency with %i threads for %ld seconds: ", thread_count, runtime);
+	fflush(stdout);
 
 	/* spawn */
 	for (i = 0; i < thread_count; i++)
diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index d9d3ab93b31a..5397de708d3c 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -123,6 +123,7 @@ int validate_freq(void)
 	/* Set the leap second insert flag */
 
 	printf("Testing ADJ_FREQ... ");
+	fflush(stdout);
 	for (i = 0; i < NUM_FREQ_VALID; i++) {
 		tx.modes = ADJ_FREQUENCY;
 		tx.freq = valid_freq[i];
@@ -250,6 +251,7 @@ int set_bad_offset(long sec, long usec, int use_nano)
 int validate_set_offset(void)
 {
 	printf("Testing ADJ_SETOFFSET... ");
+	fflush(stdout);
 
 	/* Test valid values */
 	if (set_offset(NSEC_PER_SEC - 1, 1))
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 7db4fc9fa09f..d2548401921f 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -43,7 +43,7 @@ static sigjmp_buf jmpbuf;
 
 static volatile sig_atomic_t n_errs;
 
-static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
+static void sigsegv_or_sigbus(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t*)ctx_void;
 
@@ -73,7 +73,13 @@ int main()
 	if (sigaltstack(&stack, NULL) != 0)
 		err(1, "sigaltstack");
 
-	sethandler(SIGSEGV, sigsegv, SA_ONSTACK);
+	sethandler(SIGSEGV, sigsegv_or_sigbus, SA_ONSTACK);
+	/*
+	 * The actual exception can vary.  On Atom CPUs, we get #SS
+	 * instead of #PF when the vDSO fails to access the stack when
+	 * ESP is too close to 2^32, and #SS causes SIGBUS.
+	 */
+	sethandler(SIGBUS, sigsegv_or_sigbus, SA_ONSTACK);
 	sethandler(SIGILL, sigill, SA_ONSTACK);
 
 	/*

--------------7A70FC3819073854B4F83C8C--
