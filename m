Return-Path: <linux-kselftest+bounces-1782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5887E810797
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 02:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B2F1F210E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 01:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4641CA5D;
	Wed, 13 Dec 2023 01:23:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5110A5;
	Tue, 12 Dec 2023 17:23:07 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx+uh4B3llkIYAAA--.3280S3;
	Wed, 13 Dec 2023 09:23:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXeF1B3ll_JYBAA--.11124S3;
	Wed, 13 Dec 2023 09:23:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] selftests/vDSO: Fix building errors on LoongArch
Date: Wed, 13 Dec 2023 09:22:59 +0800
Message-ID: <20231213012300.5640-2-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:AQAAf8CxXeF1B3ll_JYBAA--.11124S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF4kZr48Kw18uFW3JrWkAFc_yoW8Xr4xpa
	n7G3sYkw4xKa4fKa4fJ398Ww4YkrZ3AFWxJr43G3y3Ary5Aws7XrZ7KFW3WFW2939Yqws5
	Ar1Igw4a9F1kJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxU2-txDUUUU

There exist the following errors when build vDSO selftests on LoongArch:

  # make headers && cd tools/testing/selftests/vDSO && make
  ...
  error: 'VDSO_VERSION' undeclared (first use in this function)
  ...
  error: 'VDSO_NAMES' undeclared (first use in this function)

We can see the following code in arch/loongarch/vdso/vdso.lds.S:

VERSION
{
        LINUX_5.10 {
        global:
                __vdso_getcpu;
                __vdso_clock_getres;
                __vdso_clock_gettime;
                __vdso_gettimeofday;
                __vdso_rt_sigreturn;
        local: *;
        };
}

so VDSO_VERSION should be 6 and VDSO_NAMES should be 1 for LoongArch,
add them to fix the building errors on LoongArch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/vDSO/vdso_config.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index cdfed403ba13..7b543e7f04d7 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -53,15 +53,19 @@
 #if __riscv_xlen == 32
 #define VDSO_32BIT		1
 #endif
+#elif defined(__loongarch__)
+#define VDSO_VERSION		6
+#define VDSO_NAMES		1
 #endif
 
-static const char *versions[6] = {
+static const char *versions[7] = {
 	"LINUX_2.6",
 	"LINUX_2.6.15",
 	"LINUX_2.6.29",
 	"LINUX_2.6.39",
 	"LINUX_4",
 	"LINUX_4.15",
+	"LINUX_5.10"
 };
 
 static const char *names[2][6] = {
-- 
2.42.0


