Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F5D417C55
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Sep 2021 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348400AbhIXUYf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Sep 2021 16:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348409AbhIXUYe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Sep 2021 16:24:34 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C4AC061571
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Sep 2021 13:23:01 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so12667795ota.13
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Sep 2021 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=9EXJi7A1yTVZrVRufkedawlpN9HCEyZZmN7KIo6e0hg=;
        b=Q4HAF7FkD8pyTHT8TB7OmxGNlQmHLFLdxvFuPXt2s72V+LSQbbzgrVeBiMtmhRp58J
         raAjh7AR3cPYLhOBhCPy4zUy2jwTPDuummjcA5C3dOzG/4jCqhTBD9p6ndtBAPBuzclM
         h4SPsrSM3J7PgMqnRKQoGXMqzh+4/syKhasG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=9EXJi7A1yTVZrVRufkedawlpN9HCEyZZmN7KIo6e0hg=;
        b=R7uGYm3ql4N+Hj0xnA/mG+Ej/U1CNiCugpViWBjf2NAF85fL5oG2r6ojBorAek16Kb
         ePWDM+uFuhC4u9VaEZLwNuGFe6sfrdOSSzKY+yAX4AAle5YUSEjaQaSwzbKtENXaP/Wz
         9exlYon6rUDtwjgV/kSrZJM2JJ40ofIY4nfaLstc3O7CW08/XSxQxKtScj8VP9h1z/uY
         s/j84Md2eXPdZUWhgfNSsnqmyzdtekPHJTMwQsDVeo/xEaxjeVNO3qEKJ7T2tuGMdguO
         f8SRE4qqZLOz27O61R0cco3D6BYu64hshtkvM5SJn9CKTg17wbLKBmMjPe7cvxKElEua
         yliQ==
X-Gm-Message-State: AOAM533i9gI/nh8BXcnMXX7A5B3wrvU9XzcVnp4biNTaV2shOD8sUKc2
        /ePNl/ht/wszaJQK+lMtNx9LIQ==
X-Google-Smtp-Source: ABdhPJxvpTUEQHpV+LwJMGaq9q75Tg2QzSqmaoOb8eHIJ/mbJ/cfZX4z8DSxdCQ9Zf4tcyNsCPLnQA==
X-Received: by 2002:a9d:1716:: with SMTP id i22mr5786434ota.20.1632514980860;
        Fri, 24 Sep 2021 13:23:00 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r188sm2395016oie.7.2021.09.24.13.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 13:23:00 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.15-rc3
Message-ID: <61a77c13-1963-1dd5-d9bb-806cc8435326@linuxfoundation.org>
Date:   Fri, 24 Sep 2021 14:22:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------4D0C20D5DAC32B487853F987"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------4D0C20D5DAC32B487853F987
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.15-rc3.

This Kselftest fixes update for Linux 5.15-rc3 consists of:

- fix to Kselftest common framework header install to run before
   other targets for it work correctly in parallel build case.
- fixes to kvm test to not ignore fscanf() returns which could
   result in inconsistent test behavior and failures.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.15-rc3

for you to fetch changes up to f5013d412a43662b63f3d5f3a804d63213acd471:

   selftests: kvm: fix get_run_delay() ignoring fscanf() return warn (2021-09-16 12:57:32 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-5.15-rc3

This Kselftest fixes update for Linux 5.15-rc3 consists of:

- fix to Kselftest common framework header install to run before
   other targets for it work correctly in parallel build case.
- fixes to kvm test to not ignore fscanf() returns which could
   result in inconsistent test behavior and failures.

----------------------------------------------------------------
Li Zhijian (1):
       selftests: be sure to make khdr before other targets

Shuah Khan (4):
       selftests:kvm: fix get_warnings_count() ignoring fscanf() return warn
       selftests:kvm: fix get_trans_hugepagesz() ignoring fscanf() return warn
       selftests: kvm: move get_run_delay() into lib/test_util
       selftests: kvm: fix get_run_delay() ignoring fscanf() return warn

  tools/testing/selftests/kvm/include/test_util.h    |  3 +++
  tools/testing/selftests/kvm/lib/test_util.c        | 22 +++++++++++++++++++++-
  tools/testing/selftests/kvm/steal_time.c           | 16 ----------------
  .../selftests/kvm/x86_64/mmio_warning_test.c       |  3 ++-
  .../testing/selftests/kvm/x86_64/xen_shinfo_test.c | 15 ---------------
  tools/testing/selftests/lib.mk                     |  1 +
  6 files changed, 27 insertions(+), 33 deletions(-)

----------------------------------------------------------------

--------------4D0C20D5DAC32B487853F987
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.15-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.15-rc3.diff"

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index d79be15dd3d2..451fed5ce8e7 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -95,6 +95,8 @@ struct vm_mem_backing_src_alias {
 	uint32_t flag;
 };
 
+#define MIN_RUN_DELAY_NS	200000UL
+
 bool thp_configured(void);
 size_t get_trans_hugepagesz(void);
 size_t get_def_hugetlb_pagesz(void);
@@ -102,6 +104,7 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
 size_t get_backing_src_pagesz(uint32_t i);
 void backing_src_help(void);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
+long get_run_delay(void);
 
 /*
  * Whether or not the given source type is shared memory (as opposed to
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index af1031fed97f..a9107bfae402 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -11,6 +11,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
 #include <linux/mman.h>
 #include "linux/kernel.h"
 
@@ -129,13 +130,16 @@ size_t get_trans_hugepagesz(void)
 {
 	size_t size;
 	FILE *f;
+	int ret;
 
 	TEST_ASSERT(thp_configured(), "THP is not configured in host kernel");
 
 	f = fopen("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "r");
 	TEST_ASSERT(f != NULL, "Error in opening transparent_hugepage/hpage_pmd_size");
 
-	fscanf(f, "%ld", &size);
+	ret = fscanf(f, "%ld", &size);
+	ret = fscanf(f, "%ld", &size);
+	TEST_ASSERT(ret < 1, "Error reading transparent_hugepage/hpage_pmd_size");
 	fclose(f);
 
 	return size;
@@ -300,3 +304,19 @@ enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name)
 	TEST_FAIL("Unknown backing src type: %s", type_name);
 	return -1;
 }
+
+long get_run_delay(void)
+{
+	char path[64];
+	long val[2];
+	FILE *fp;
+
+	sprintf(path, "/proc/%ld/schedstat", syscall(SYS_gettid));
+	fp = fopen(path, "r");
+	/* Return MIN_RUN_DELAY_NS upon failure just to be safe */
+	if (fscanf(fp, "%ld %ld ", &val[0], &val[1]) < 2)
+		val[1] = MIN_RUN_DELAY_NS;
+	fclose(fp);
+
+	return val[1];
+}
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index ecec30865a74..2172d65b85e4 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -10,7 +10,6 @@
 #include <sched.h>
 #include <pthread.h>
 #include <linux/kernel.h>
-#include <sys/syscall.h>
 #include <asm/kvm.h>
 #include <asm/kvm_para.h>
 
@@ -20,7 +19,6 @@
 
 #define NR_VCPUS		4
 #define ST_GPA_BASE		(1 << 30)
-#define MIN_RUN_DELAY_NS	200000UL
 
 static void *st_gva[NR_VCPUS];
 static uint64_t guest_stolen_time[NR_VCPUS];
@@ -217,20 +215,6 @@ static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpuid)
 
 #endif
 
-static long get_run_delay(void)
-{
-	char path[64];
-	long val[2];
-	FILE *fp;
-
-	sprintf(path, "/proc/%ld/schedstat", syscall(SYS_gettid));
-	fp = fopen(path, "r");
-	fscanf(fp, "%ld %ld ", &val[0], &val[1]);
-	fclose(fp);
-
-	return val[1];
-}
-
 static void *do_steal_time(void *arg)
 {
 	struct timespec ts, stop;
diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index e6480fd5c4bd..8039e1eff938 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -82,7 +82,8 @@ int get_warnings_count(void)
 	FILE *f;
 
 	f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
-	fscanf(f, "%d", &warnings);
+	if (fscanf(f, "%d", &warnings) < 1)
+		warnings = 0;
 	fclose(f);
 
 	return warnings;
diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index 117bf49a3d79..eda0d2a51224 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -14,7 +14,6 @@
 #include <stdint.h>
 #include <time.h>
 #include <sched.h>
-#include <sys/syscall.h>
 
 #define VCPU_ID		5
 
@@ -98,20 +97,6 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-static long get_run_delay(void)
-{
-        char path[64];
-        long val[2];
-        FILE *fp;
-
-        sprintf(path, "/proc/%ld/schedstat", syscall(SYS_gettid));
-        fp = fopen(path, "r");
-        fscanf(fp, "%ld %ld ", &val[0], &val[1]);
-        fclose(fp);
-
-        return val[1];
-}
-
 static int cmp_timespec(struct timespec *a, struct timespec *b)
 {
 	if (a->tv_sec > b->tv_sec)
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index fa2ac0e56b43..fe7ee2b0f29c 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -48,6 +48,7 @@ ARCH		?= $(SUBARCH)
 # When local build is done, headers are installed in the default
 # INSTALL_HDR_PATH usr/include.
 .PHONY: khdr
+.NOTPARALLEL:
 khdr:
 ifndef KSFT_KHDR_INSTALL_DONE
 ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))

--------------4D0C20D5DAC32B487853F987--
