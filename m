Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C260F2E07F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2019 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfE2PEu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 May 2019 11:04:50 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:51321 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfE2PEt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 May 2019 11:04:49 -0400
Received: by mail-it1-f176.google.com with SMTP id m3so4419498itl.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2019 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=PJh+tH51cISlc+k9PbZLzCDGkI7OQ7r7QdvsJfI3jok=;
        b=M0PmkRdXy/Uh6tT+dTOa7sF8GwOwvbkOKp4wzg9ZQqY6So8nr9kP6XyU3EW86/72lM
         3iMzv1uo9iQKkuhBcp0mrtRK03Mfo4ZQdU9SwdnIqRrMv8ohyJSC3xkTY5Zu31df3lKY
         p3Je0CbMINCyUU047VHJIqnVF0cUhVKkiUYWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=PJh+tH51cISlc+k9PbZLzCDGkI7OQ7r7QdvsJfI3jok=;
        b=FH7dcqd8A+x0JOtcRFISQFrRpfP4dtUW5DtQnymc6XCXGfGPaAddShn/ALhKrI9Ee1
         6db288Bjz3bvGfbCAtHXP6yvVXC7ypP1Ak5JiHrbH6EKpGR62wzr55S6FvxhvQjhqGEd
         PGKv8phpTmlbgTDOge1E3aPws3QCuNUYirVJ91IaZTEPKQNeHtr/qa2hK/iacm0lweGi
         9Lzphu1pqhSLWVUcyfN7FKPu05K867xIGKhaPUMvSEHTf/FCQmmpbAQuPEuwukwuVsk7
         orfD8+23LOhsj9o7QsyMqJLNengSTJSsmZoR67m1wkKLCH0x/8zsAkSM9ni0fGdqjXdF
         g5gQ==
X-Gm-Message-State: APjAAAUCsy381ne+uznPQ9dOBcbEdiAotS+LBvoIOqODtCso/7etuAfb
        JFwTkvAk50gZPboEPK92PD/PnQ==
X-Google-Smtp-Source: APXvYqyLllj2g4BWTx5k2+IbxSQPgM8xKi6MjTV5gtgLhB9rrvSOmJdS71KFKEBL3tiGe1vmxNe7sg==
X-Received: by 2002:a02:930d:: with SMTP id d13mr35648476jah.48.1559142284118;
        Wed, 29 May 2019 08:04:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v190sm1234957ita.14.2019.05.29.08.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 08:04:43 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.2-rc3
Message-ID: <966d12fc-d32e-c72c-7996-34b8250388dc@linuxfoundation.org>
Date:   Wed, 29 May 2019 09:04:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------FFEEB26E0F873E8A7C0FD295"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------FFEEB26E0F873E8A7C0FD295
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.2-rc3.

This Kselftest update for Linux 5.2-rc3 consists of

- Alexandre Belloni's fixes to rtc regressions introduced in kselftest
   Makefile test run output refactoring work from Kees Cook.

- ftrace test checkbashisms fixes from Masami Hiramatsu

As a note, it is an usual and expected outcome to see a few regressions
when Kselftest run-time scripts are enhanced. No surprises there.

I am glad we are finding these problems early on in the rc cycle.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.2-rc3

for you to fetch changes up to eff82a263b5cfa3427fd9dbfedd96da94fdc9f19:

   selftests: rtc: rtctest: specify timeouts (2019-05-24 13:39:58 -0600)

----------------------------------------------------------------
linux-kselftest-5.2-rc3

This Kselftest update for Linux 5.2-rc3 consists of

- Alexandre Belloni's fixes to rtc regressions introduced in kselftest
   Makefile test run output refactoring work from Kees Cook.

- ftrace test checkbashisms fixes from Masami Hiramatsu

----------------------------------------------------------------
Alexandre Belloni (2):
       selftests/harness: Allow test to configure timeout
       selftests: rtc: rtctest: specify timeouts

Masami Hiramatsu (2):
       selftests/ftrace: Make a script checkbashisms clean
       selftests/ftrace: Add checkbashisms meta-testcase

  tools/testing/selftests/ftrace/ftracetest           |  1 +
  .../selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc |  2 +-
  .../selftests/ftrace/test.d/selftest/bashisms.tc    | 21 
+++++++++++++++++++++
  tools/testing/selftests/kselftest_harness.h         | 17 ++++++++++++-----
  tools/testing/selftests/rtc/rtctest.c               |  6 +++---
  5 files changed, 38 insertions(+), 9 deletions(-)
  create mode 100644 
tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
----------------------------------------------------------------

--------------FFEEB26E0F873E8A7C0FD295
Content-Type: text/x-patch;
 name="linux-kselftest-5.2-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.2-rc3.diff"

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 136387422b00..7da5e31fa0ed 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -318,6 +318,7 @@ run_test() { # testfile
     local testlog=/proc/self/fd/1
   fi
   export TMPDIR=`mktemp -d /tmp/ftracetest-dir.XXXXXX`
+  export FTRACETEST_ROOT=$TOP_DIR
   echo "execute$INSTANCE: "$1 > $testlog
   SIG_RESULT=0
   if [ $VERBOSE -eq -1 ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
index 492426e95e09..7650a82db3f5 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
@@ -3,7 +3,7 @@
 # description: Kprobe dynamic event with function tracer
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
-grep function available_tracers || exit_unsupported # this is configurable
+grep "function" available_tracers || exit_unsupported # this is configurable
 
 # prepare
 echo nop > current_tracer
diff --git a/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
new file mode 100644
index 000000000000..1b081e910e14
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Meta-selftest: Checkbashisms
+
+if [ ! -f $FTRACETEST_ROOT/ftracetest ]; then
+  echo "Hmm, we can not find ftracetest"
+  exit_unresolved
+fi
+
+if ! which checkbashisms > /dev/null 2>&1 ; then
+  echo "No checkbashisms found. skipped."
+  exit_unresolved
+fi
+
+checkbashisms $FTRACETEST_ROOT/ftracetest
+checkbashisms $FTRACETEST_ROOT/test.d/functions
+for t in $(find $FTRACETEST_ROOT/test.d -name \*.tc); do
+  checkbashisms $t
+done
+
+exit 0
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 941d9391377f..2067c6b0e8a1 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -62,6 +62,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#define TEST_TIMEOUT_DEFAULT 30
 
 /* Utilities exposed to the test definitions */
 #ifndef TH_LOG_STREAM
@@ -169,7 +170,8 @@
 	static void test_name(struct __test_metadata *_metadata); \
 	static struct __test_metadata _##test_name##_object = \
 		{ .name = "global." #test_name, \
-		  .fn = &test_name, .termsig = _signal }; \
+		  .fn = &test_name, .termsig = _signal, \
+		  .timeout = TEST_TIMEOUT_DEFAULT, }; \
 	static void __attribute__((constructor)) _register_##test_name(void) \
 	{ \
 		__register_test(&_##test_name##_object); \
@@ -280,12 +282,15 @@
  */
 /* TODO(wad) register fixtures on dedicated test lists. */
 #define TEST_F(fixture_name, test_name) \
-	__TEST_F_IMPL(fixture_name, test_name, -1)
+	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT)
 
 #define TEST_F_SIGNAL(fixture_name, test_name, signal) \
-	__TEST_F_IMPL(fixture_name, test_name, signal)
+	__TEST_F_IMPL(fixture_name, test_name, signal, TEST_TIMEOUT_DEFAULT)
 
-#define __TEST_F_IMPL(fixture_name, test_name, signal) \
+#define TEST_F_TIMEOUT(fixture_name, test_name, timeout) \
+	__TEST_F_IMPL(fixture_name, test_name, -1, timeout)
+
+#define __TEST_F_IMPL(fixture_name, test_name, signal, tmout) \
 	static void fixture_name##_##test_name( \
 		struct __test_metadata *_metadata, \
 		FIXTURE_DATA(fixture_name) *self); \
@@ -307,6 +312,7 @@
 		.name = #fixture_name "." #test_name, \
 		.fn = &wrapper_##fixture_name##_##test_name, \
 		.termsig = signal, \
+		.timeout = tmout, \
 	 }; \
 	static void __attribute__((constructor)) \
 			_register_##fixture_name##_##test_name(void) \
@@ -632,6 +638,7 @@ struct __test_metadata {
 	int termsig;
 	int passed;
 	int trigger; /* extra handler after the evaluation */
+	int timeout;
 	__u8 step;
 	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
 	struct __test_metadata *prev, *next;
@@ -696,7 +703,7 @@ void __run_test(struct __test_metadata *t)
 	t->passed = 1;
 	t->trigger = 0;
 	printf("[ RUN      ] %s\n", t->name);
-	alarm(30);
+	alarm(t->timeout);
 	child_pid = fork();
 	if (child_pid < 0) {
 		printf("ERROR SPAWNING TEST CHILD\n");
diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index b2065536d407..66af608fb4c6 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -49,7 +49,7 @@ TEST_F(rtc, date_read) {
 	       rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
 }
 
-TEST_F(rtc, uie_read) {
+TEST_F_TIMEOUT(rtc, uie_read, NUM_UIE + 2) {
 	int i, rc, irq = 0;
 	unsigned long data;
 
@@ -211,7 +211,7 @@ TEST_F(rtc, alarm_wkalm_set) {
 	ASSERT_EQ(new, secs);
 }
 
-TEST_F(rtc, alarm_alm_set_minute) {
+TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
 	struct timeval tv = { .tv_sec = 62 };
 	unsigned long data;
 	struct rtc_time tm;
@@ -264,7 +264,7 @@ TEST_F(rtc, alarm_alm_set_minute) {
 	ASSERT_EQ(new, secs);
 }
 
-TEST_F(rtc, alarm_wkalm_set_minute) {
+TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 	struct timeval tv = { .tv_sec = 62 };
 	struct rtc_wkalrm alarm = { 0 };
 	struct rtc_time tm;

--------------FFEEB26E0F873E8A7C0FD295--
