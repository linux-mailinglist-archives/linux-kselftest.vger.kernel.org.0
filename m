Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886804F9CD5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 20:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiDHSiq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 14:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiDHSip (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 14:38:45 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B136307
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:36:40 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k25so11629418iok.8
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Apr 2022 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=Qgzq2HuHdQdM/z71YFRmKpS7BgF3gbqWv1M2FNFKojw=;
        b=GAX+MDMaigakwsyW1Bz/Qn15Uj/JUBay5uSIJmwT/bNKBj/cdCrRwBu8A4QZGuztAn
         vwl/lC5jdIKjG1Ch1dYsyjrw04F6NeNYBeqToY6I5i1crBbGEE1RAFgsxH52arvnsv/Y
         GQHeQtEtdmUr9mlfyYt0a9vW/8U9ZFcYLb2lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=Qgzq2HuHdQdM/z71YFRmKpS7BgF3gbqWv1M2FNFKojw=;
        b=CLqX8n3eCNx+dOVNPT4c3l7M7JctzqWxPi9xrEF9CuUjRRsWWx8iIl1M2NoaIZ1n/B
         HB1/gKALB+XPaN2RubwyBozaQHDIMT5iefGtJZREfhDGsAgj3P0bfEvI9409RH1s6cwj
         qpmZsaAds9SQRCU0zzAD5Bd0huxRolbm+ORhsqFPDrLOZVR3RFyQx7q0KG7AwOMlH1zm
         I2zF/WhBPaXJehc/a0i7y9NsthKoUjy/DzkRWBDcdNRz/0m+oxy9J7+ySFjkLfzNoFFZ
         /FOaRnBBhXlkt4xU1MvOjkbo95lAP9hnxhTQF1AUoxJoPtuhVWCtvz2vDSMChXLzAVtC
         rmew==
X-Gm-Message-State: AOAM533PFl7Uspe/2LBOZNCngNoe/r64OxJdomqURd3bUO3brsBMuXnO
        kIIMLeZySHJa6BQC3Byd2KfclA==
X-Google-Smtp-Source: ABdhPJzbPGOlg10CATvyYGl17cc+QGzfPiP/WfeNkO474Mov3VxNYC1C+/bdDHbN88eHksCruBNfZw==
X-Received: by 2002:a05:6638:258c:b0:323:cf58:212e with SMTP id s12-20020a056638258c00b00323cf58212emr9855647jat.89.1649442999793;
        Fri, 08 Apr 2022 11:36:39 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a3-20020a92d583000000b002c9fb55e727sm13562019iln.41.2022.04.08.11.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 11:36:39 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.18-rc2
Message-ID: <e4798810-fdb4-d436-ed19-0d0d38138002@linuxfoundation.org>
Date:   Fri, 8 Apr 2022 12:36:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------25A3FE5CCFEEB92F64F2B02E"
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------25A3FE5CCFEEB92F64F2B02E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.18-rc2.

This Kselftest fixes update for Linux 5.18-rc2 consists of build,
run-times fixes to tests:

- header dependencies
- missing tear-downs to release allocated resources in assert paths
- missing error messages when build fails
- coccicheck and unused variable warnings

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.18-rc2

for you to fetch changes up to 79ee8aa31d518c1fd5f3b1b1ac39dd1fb4dc7039:

   selftests/harness: Pass variant to teardown (2022-04-04 13:37:48 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-5.18-rc2

This Kselftest fixes update for Linux 5.18-rc2 consists of build,
run-times fixes to tests:

- header dependencies
- missing tear-downs to release allocated resources in assert paths
- missing error messages when build fails
- coccicheck and unused variable warnings

----------------------------------------------------------------
Axel Rasmussen (2):
       selftests: fix header dependency for pid_namespace selftests
       selftests: fix an unused variable warning in pidfd selftest

Geliang Tang (1):
       selftests: x86: add 32bit build warnings for SUSE

Guo Zhengkui (2):
       selftests/vDSO: fix array_size.cocci warning
       selftests/proc: fix array_size.cocci warning

Kees Cook (1):
       selftests/harness: Run TEARDOWN for ASSERT failures

Willem de Bruijn (1):
       selftests/harness: Pass variant to teardown

  tools/testing/selftests/kselftest_harness.h        | 59 +++++++++++++++-------
  tools/testing/selftests/pid_namespace/Makefile     |  6 +--
  tools/testing/selftests/pidfd/pidfd_wait.c         |  1 -
  tools/testing/selftests/proc/proc-pid-vm.c         |  6 ++-
  .../testing/selftests/vDSO/vdso_test_correctness.c |  9 ++--
  tools/testing/selftests/x86/Makefile               |  4 ++
  6 files changed, 54 insertions(+), 31 deletions(-)
----------------------------------------------------------------

--------------25A3FE5CCFEEB92F64F2B02E
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.18-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.18-rc2.diff"

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 11779405dc80..25f4d54067c0 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -64,6 +64,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <setjmp.h>
 
 #include "kselftest.h"
 
@@ -183,7 +184,10 @@
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata *variant) \
 	{ \
-		test_name(_metadata); \
+		_metadata->setup_completed = true; \
+		if (setjmp(_metadata->env) == 0) \
+			test_name(_metadata); \
+		__test_check_assert(_metadata); \
 	} \
 	static struct __test_metadata _##test_name##_object = \
 		{ .name = #test_name, \
@@ -287,7 +291,9 @@
 #define FIXTURE_TEARDOWN(fixture_name) \
 	void fixture_name##_teardown( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
-		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
+		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
+		const FIXTURE_VARIANT(fixture_name) \
+			__attribute__((unused)) *variant)
 
 /**
  * FIXTURE_VARIANT() - Optionally called once per fixture
@@ -302,9 +308,9 @@
  *       ...
  *     };
  *
- * Defines type of constant parameters provided to FIXTURE_SETUP() and TEST_F()
- * as *variant*. Variants allow the same tests to be run with different
- * arguments.
+ * Defines type of constant parameters provided to FIXTURE_SETUP(), TEST_F() and
+ * FIXTURE_TEARDOWN as *variant*. Variants allow the same tests to be run with
+ * different arguments.
  */
 #define FIXTURE_VARIANT(fixture_name) struct _fixture_variant_##fixture_name
 
@@ -356,10 +362,7 @@
  * Defines a test that depends on a fixture (e.g., is part of a test case).
  * Very similar to TEST() except that *self* is the setup instance of fixture's
  * datatype exposed for use by the implementation.
- *
- * Warning: use of ASSERT_* here will skip TEARDOWN.
  */
-/* TODO(wad) register fixtures on dedicated test lists. */
 #define TEST_F(fixture_name, test_name) \
 	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT)
 
@@ -381,12 +384,17 @@
 		/* fixture data is alloced, setup, and torn down per call. */ \
 		FIXTURE_DATA(fixture_name) self; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
-		fixture_name##_setup(_metadata, &self, variant->data); \
-		/* Let setup failure terminate early. */ \
-		if (!_metadata->passed) \
-			return; \
-		fixture_name##_##test_name(_metadata, &self, variant->data); \
-		fixture_name##_teardown(_metadata, &self); \
+		if (setjmp(_metadata->env) == 0) { \
+			fixture_name##_setup(_metadata, &self, variant->data); \
+			/* Let setup failure terminate early. */ \
+			if (!_metadata->passed) \
+				return; \
+			_metadata->setup_completed = true; \
+			fixture_name##_##test_name(_metadata, &self, variant->data); \
+		} \
+		if (_metadata->setup_completed) \
+			fixture_name##_teardown(_metadata, &self, variant->data); \
+		__test_check_assert(_metadata); \
 	} \
 	static struct __test_metadata \
 		      _##fixture_name##_##test_name##_object = { \
@@ -683,7 +691,7 @@
  */
 #define OPTIONAL_HANDLER(_assert) \
 	for (; _metadata->trigger; _metadata->trigger = \
-			__bail(_assert, _metadata->no_print, _metadata->step))
+			__bail(_assert, _metadata))
 
 #define __INC_STEP(_metadata) \
 	/* Keep "step" below 255 (which is used for "SKIP" reporting). */	\
@@ -830,6 +838,9 @@ struct __test_metadata {
 	bool timed_out;	/* did this test timeout instead of exiting? */
 	__u8 step;
 	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
+	bool aborted;	/* stopped test due to failed ASSERT */
+	bool setup_completed; /* did setup finish? */
+	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
 };
@@ -848,16 +859,26 @@ static inline void __register_test(struct __test_metadata *t)
 	__LIST_APPEND(t->fixture->tests, t);
 }
 
-static inline int __bail(int for_realz, bool no_print, __u8 step)
+static inline int __bail(int for_realz, struct __test_metadata *t)
 {
+	/* if this is ASSERT, return immediately. */
 	if (for_realz) {
-		if (no_print)
-			_exit(step);
-		abort();
+		t->aborted = true;
+		longjmp(t->env, 1);
 	}
+	/* otherwise, end the for loop and continue. */
 	return 0;
 }
 
+static inline void __test_check_assert(struct __test_metadata *t)
+{
+	if (t->aborted) {
+		if (t->no_print)
+			_exit(t->step);
+		abort();
+	}
+}
+
 struct __test_metadata *__active_test;
 static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 {
diff --git a/tools/testing/selftests/pid_namespace/Makefile b/tools/testing/selftests/pid_namespace/Makefile
index dcaefa224ca0..edafaca1aeb3 100644
--- a/tools/testing/selftests/pid_namespace/Makefile
+++ b/tools/testing/selftests/pid_namespace/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -g -I../../../../usr/include/
 
-TEST_GEN_PROGS := regression_enomem
+TEST_GEN_PROGS = regression_enomem
 
-include ../lib.mk
+LOCAL_HDRS += $(selfdir)/pidfd/pidfd.h
 
-$(OUTPUT)/regression_enomem: regression_enomem.c ../pidfd/pidfd.h
+include ../lib.mk
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 17999e082aa7..070c1c876df1 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -95,7 +95,6 @@ TEST(wait_states)
 		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
 		.exit_signal = SIGCHLD,
 	};
-	int ret;
 	pid_t pid;
 	siginfo_t info = {
 		.si_signo = 0,
diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 18a3bde8bc96..28604c9f805c 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -46,6 +46,8 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 
+#include "../kselftest.h"
+
 static inline long sys_execveat(int dirfd, const char *pathname, char **argv, char **envp, int flags)
 {
 	return syscall(SYS_execveat, dirfd, pathname, argv, envp, flags);
@@ -368,7 +370,7 @@ int main(void)
 		};
 		int i;
 
-		for (i = 0; i < sizeof(S)/sizeof(S[0]); i++) {
+		for (i = 0; i < ARRAY_SIZE(S); i++) {
 			assert(memmem(buf, rv, S[i], strlen(S[i])));
 		}
 
@@ -417,7 +419,7 @@ int main(void)
 		};
 		int i;
 
-		for (i = 0; i < sizeof(S)/sizeof(S[0]); i++) {
+		for (i = 0; i < ARRAY_SIZE(S); i++) {
 			assert(memmem(buf, rv, S[i], strlen(S[i])));
 		}
 	}
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index c4aea794725a..e691a3cf1491 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -20,6 +20,7 @@
 #include <limits.h>
 
 #include "vdso_config.h"
+#include "../kselftest.h"
 
 static const char **name;
 
@@ -306,10 +307,8 @@ static void test_clock_gettime(void)
 		return;
 	}
 
-	for (int clock = 0; clock < sizeof(clocknames) / sizeof(clocknames[0]);
-	     clock++) {
+	for (int clock = 0; clock < ARRAY_SIZE(clocknames); clock++)
 		test_one_clock_gettime(clock, clocknames[clock]);
-	}
 
 	/* Also test some invalid clock ids */
 	test_one_clock_gettime(-1, "invalid");
@@ -370,10 +369,8 @@ static void test_clock_gettime64(void)
 		return;
 	}
 
-	for (int clock = 0; clock < sizeof(clocknames) / sizeof(clocknames[0]);
-	     clock++) {
+	for (int clock = 0; clock < ARRAY_SIZE(clocknames); clock++)
 		test_one_clock_gettime64(clock, clocknames[clock]);
-	}
 
 	/* Also test some invalid clock ids */
 	test_one_clock_gettime64(-1, "invalid");
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 53df7d3893d3..0388c4d60af0 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -92,6 +92,10 @@ warn_32bit_failure:
 	echo "If you are using a Fedora-like distribution, try:";	\
 	echo "";							\
 	echo "  yum install glibc-devel.*i686";				\
+	echo "";							\
+	echo "If you are using a SUSE-like distribution, try:";		\
+	echo "";							\
+	echo "  zypper install gcc-32bit glibc-devel-static-32bit";	\
 	exit 0;
 endif
 

--------------25A3FE5CCFEEB92F64F2B02E--
