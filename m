Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE1440CECD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 23:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhIOV3i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 17:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhIOV3g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 17:29:36 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E559C061767
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 14:28:16 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n128so5366659iod.5
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 14:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1h6fL4KefzmZ6oE2CqHJFkAoOlg/B4t8Zb8g1+TnN/A=;
        b=Vm8Hgnt6/p9PPFwKcr1rp22aZv6Zt0a3m+RrEo9q9okz9fRn/cFFLa7WmtD4AxrSl1
         pzoGGzWRg/LF9HaR/g+dvJdAIe/yCxWvv9+J/SngoEQaFRpBIWGe2bq1/leCRpgZMKhX
         Wa3q37uuh702Q8hh6BdRd/D3vG4SE1kTJgNjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1h6fL4KefzmZ6oE2CqHJFkAoOlg/B4t8Zb8g1+TnN/A=;
        b=j0H/ipDnUX1TpNpAvsiwVDL3YztbmMw8LXFCPj1s7321DuaHMiH9msFrgTXFmPFpX/
         4UzDeC41gu8NsM5Uxe1to4/v+BsfjKXDTk639+tpDWYYGA68SOH59yndaR0/fgpwomXz
         xdTabeY7R1C1tdfaY/tBdCv9giL30tbFqXM0RvOzFxQ3twL+/ekvSTCMXOks+W9dVRTt
         5eO+OB4M8BPYiaeG2xp0HVzsm300Rej3nozdIlkOAsjbmDahu3J6E/XErtrqv1gSMJ3W
         ivqt3TkcCI168zz7gff5MD79RD+Nvs45C5eXPkSKjTYloYt3WqCgNaGbd6/dL0EZZhwf
         RdvA==
X-Gm-Message-State: AOAM531FtEagnp7d+MAivs7xELJVw98KEtLSeqNPjbQHlljQAS7q//5T
        WeO2umoOAWVTtcfqH1uVV64eng==
X-Google-Smtp-Source: ABdhPJyo+TZP5qJ5Ub0+Wu0uWwvNu+DsRL3w38oj6I4r7gEFh7ltLgQl49viQUWjUqZuBBgLlIqdcQ==
X-Received: by 2002:a6b:6613:: with SMTP id a19mr1731994ioc.167.1631741295959;
        Wed, 15 Sep 2021 14:28:15 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f2sm622884ioz.14.2021.09.15.14.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:28:14 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] selftests: kvm: move get_run_delay() into lib/test_util
Date:   Wed, 15 Sep 2021 15:28:08 -0600
Message-Id: <d0931e759999f9853ff4315b4d3a5307fb738360.1631737524.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1631737524.git.skhan@linuxfoundation.org>
References: <cover.1631737524.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

get_run_delay() is defined static in xen_shinfo_test and steal_time test.
Move it to lib and remove code duplication.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kvm/include/test_util.h   |  1 +
 tools/testing/selftests/kvm/lib/test_util.c       | 15 +++++++++++++++
 tools/testing/selftests/kvm/steal_time.c          | 15 ---------------
 .../selftests/kvm/x86_64/xen_shinfo_test.c        | 15 ---------------
 4 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index d79be15dd3d2..c7409b9b4e5b 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -102,6 +102,7 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
 size_t get_backing_src_pagesz(uint32_t i);
 void backing_src_help(void);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
+long get_run_delay(void);
 
 /*
  * Whether or not the given source type is shared memory (as opposed to
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 938cd423643e..f80dd38a38b2 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -11,6 +11,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
 #include <linux/mman.h>
 #include "linux/kernel.h"
 
@@ -303,3 +304,17 @@ enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name)
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
+	fscanf(fp, "%ld %ld ", &val[0], &val[1]);
+	fclose(fp);
+
+	return val[1];
+}
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index ecec30865a74..51fe95a5c36a 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -10,7 +10,6 @@
 #include <sched.h>
 #include <pthread.h>
 #include <linux/kernel.h>
-#include <sys/syscall.h>
 #include <asm/kvm.h>
 #include <asm/kvm_para.h>
 
@@ -217,20 +216,6 @@ static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpuid)
 
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
-- 
2.30.2

