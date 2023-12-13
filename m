Return-Path: <linux-kselftest+bounces-1783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E502A810799
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 02:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D521F21AED
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 01:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07D2EDF;
	Wed, 13 Dec 2023 01:23:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19543A7;
	Tue, 12 Dec 2023 17:23:09 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxE_B4B3lllIYAAA--.3300S3;
	Wed, 13 Dec 2023 09:23:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXeF1B3ll_JYBAA--.11124S4;
	Wed, 13 Dec 2023 09:23:04 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] selftests/vDSO: Fix runtime errors on LoongArch
Date: Wed, 13 Dec 2023 09:23:00 +0800
Message-ID: <20231213012300.5640-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213012300.5640-1-yangtiezhu@loongson.cn>
References: <20231213012300.5640-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxXeF1B3ll_JYBAA--.11124S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFy5Gw1UAFWkKF1kGF48uFX_yoWrCr18pa
	n7Kry2kw48tay5Kw1Iyw1Dur4rJrn7Ga18Aw48AFW3AF47Zw48JrWDGFy5X3ZxurW0vr45
	u3WFgr4F9aykJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jrPEfUUUUU=

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
 .../testing/selftests/vDSO/vdso_test_getcpu.c | 16 +++++-------
 .../selftests/vDSO/vdso_test_gettimeofday.c   | 26 +++++--------------
 2 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
index 1df5d057d79f..b758f68c6c9c 100644
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
index e411f287a426..ee4f1ca56a71 100644
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
2.42.0


