Return-Path: <linux-kselftest+bounces-8995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B28B494A
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 05:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BBD1C20D70
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 03:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7342E23BB;
	Sun, 28 Apr 2024 03:05:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109111854;
	Sun, 28 Apr 2024 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714273542; cv=none; b=Y4cJ9Pfa6yg6b2I9AVYppEpvFr+8Gr5r/4zOHf2hrk7BnRjeb4jwgWQ2m0DDeBH1bwSfLVA2IMcEPy8HSBIAJWCOfU3wJelWM/jvWqhUoJYk96zhpyN8cSsk+KZg835iXy4S4grRMyIH11+X9AEFrzqQDsoT2CWXEI4Pu14H8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714273542; c=relaxed/simple;
	bh=/nBt/EInsoTVkYRGjAmDJe2GPmttLfF030/NoAPJxFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vC6GbirnH6gJepxGsN5Cf9Nc1sq+OVHwE1x1HiDPMwaljF2eE1xSD3XevXmmuABGkiCgGW52gaunScPmeLakBCfj36H12Q6n4uGQMd75AA58gswRcPxV9px+ZD1uUV/KyGrAOiKNbNGp0vmYkDBTY3pwtnup6GMtHpZaY7kEgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxqekBvS1mOTcEAA--.3393S3;
	Sun, 28 Apr 2024 11:05:37 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxHlX6vC1mZOcHAA--.5433S4;
	Sun, 28 Apr 2024 11:05:34 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] selftests/vDSO: Fix runtime errors on LoongArch
Date: Sun, 28 Apr 2024 11:05:30 +0800
Message-ID: <20240428030530.24399-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240428030530.24399-1-yangtiezhu@loongson.cn>
References: <20240428030530.24399-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxHlX6vC1mZOcHAA--.5433S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFy5Gw1UAFWkKF1kGF48uFX_yoWrZr4rpa
	n7K342kw48tay5Kw1Iy3s8ur4fJrn7Ga18Aw4UAFW3AF47Zw48JrWDGFy5X3Z3urWvvws8
	ua4Fgr4F9aykJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

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
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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


