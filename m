Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53B974EB46
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 11:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjGKJ5X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjGKJ5V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 05:57:21 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED30C100;
        Tue, 11 Jul 2023 02:57:14 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxRvF5J61kCXYDAA--.10244S3;
        Tue, 11 Jul 2023 17:57:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3yN2J61kzH4oAA--.9186S4;
        Tue, 11 Jul 2023 17:57:12 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 2/2] selftests/vDSO: Get version and name for all archs
Date:   Tue, 11 Jul 2023 17:57:05 +0800
Message-Id: <1689069425-17414-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1689069425-17414-1-git-send-email-yangtiezhu@loongson.cn>
References: <1689069425-17414-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Bx3yN2J61kzH4oAA--.9186S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFy5Gw1UAFWkKF1kGF48uFX_yoWrAw13pa
        n7Kry2kw48tayYgw1Iyw1Dur4rJrn7Ga18Aw48AFW3AF47Zw48JrWDGFyrX3ZxurWvvrs8
        u3WFgr4F9aykJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It could not find __vdso_getcpu and __vdso_gettimeofday when test
getcpu and gettimeofday on LoongArch.

  # make headers && cd tools/testing/selftests/vDSO && make
  # ./vdso_test_getcpu
  Could not find __vdso_getcpu
  # ./vdso_test_gettimeofday
  Could not find __vdso_gettimeofday

One simple way is to add LoongArch case to define version and name,
just like commit d942f231afc0 ("selftests/vDSO: Add riscv getcpu &
gettimeofday test"), but it is not the best way.

Since each architecture has already defined names and versions in
vdso_config.h, it is proper to include vdso_config.h to get version
and name for all archs.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/vDSO/vdso_test_getcpu.c    | 16 +++++--------
 .../selftests/vDSO/vdso_test_gettimeofday.c        | 26 ++++++----------------
 2 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
index 1df5d05..b758f68 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -13,13 +13,7 @@
 
 #include "../kselftest.h"
 #include "parse_vdso.h"
-
-#if defined(__riscv)
-const char *version = "LINUX_4.15";
-#else
-const char *version = "LINUX_2.6";
-#endif
-const char *name = "__vdso_getcpu";
+#include "vdso_config.h"
 
 struct getcpu_cache;
 typedef long (*getcpu_t)(unsigned int *, unsigned int *,
@@ -27,6 +21,8 @@ typedef long (*getcpu_t)(unsigned int *, unsigned int *,
 
 int main(int argc, char **argv)
 {
+	const char *version = versions[VDSO_VERSION];
+	const char **name = (const char **)&names[VDSO_NAMES];
 	unsigned long sysinfo_ehdr;
 	unsigned int cpu, node;
 	getcpu_t get_cpu;
@@ -40,9 +36,9 @@ int main(int argc, char **argv)
 
 	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
 
-	get_cpu = (getcpu_t)vdso_sym(version, name);
+	get_cpu = (getcpu_t)vdso_sym(version, name[4]);
 	if (!get_cpu) {
-		printf("Could not find %s\n", name);
+		printf("Could not find %s\n", name[4]);
 		return KSFT_SKIP;
 	}
 
@@ -50,7 +46,7 @@ int main(int argc, char **argv)
 	if (ret == 0) {
 		printf("Running on CPU %u node %u\n", cpu, node);
 	} else {
-		printf("%s failed\n", name);
+		printf("%s failed\n", name[4]);
 		return KSFT_FAIL;
 	}
 
diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index e411f28..ee4f1ca 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -18,25 +18,13 @@
 
 #include "../kselftest.h"
 #include "parse_vdso.h"
-
-/*
- * ARM64's vDSO exports its gettimeofday() implementation with a different
- * name and version from other architectures, so we need to handle it as
- * a special case.
- */
-#if defined(__aarch64__)
-const char *version = "LINUX_2.6.39";
-const char *name = "__kernel_gettimeofday";
-#elif defined(__riscv)
-const char *version = "LINUX_4.15";
-const char *name = "__vdso_gettimeofday";
-#else
-const char *version = "LINUX_2.6";
-const char *name = "__vdso_gettimeofday";
-#endif
+#include "vdso_config.h"
 
 int main(int argc, char **argv)
 {
+	const char *version = versions[VDSO_VERSION];
+	const char **name = (const char **)&names[VDSO_NAMES];
+
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
 	if (!sysinfo_ehdr) {
 		printf("AT_SYSINFO_EHDR is not present!\n");
@@ -47,10 +35,10 @@ int main(int argc, char **argv)
 
 	/* Find gettimeofday. */
 	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
-	gtod_t gtod = (gtod_t)vdso_sym(version, name);
+	gtod_t gtod = (gtod_t)vdso_sym(version, name[0]);
 
 	if (!gtod) {
-		printf("Could not find %s\n", name);
+		printf("Could not find %s\n", name[0]);
 		return KSFT_SKIP;
 	}
 
@@ -61,7 +49,7 @@ int main(int argc, char **argv)
 		printf("The time is %lld.%06lld\n",
 		       (long long)tv.tv_sec, (long long)tv.tv_usec);
 	} else {
-		printf("%s failed\n", name);
+		printf("%s failed\n", name[0]);
 		return KSFT_FAIL;
 	}
 
-- 
2.1.0

