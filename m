Return-Path: <linux-kselftest+bounces-22680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137C09E0425
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 14:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F831677F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298FE1FECA8;
	Mon,  2 Dec 2024 13:56:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB9202F89;
	Mon,  2 Dec 2024 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147769; cv=none; b=UThHmkDtL7oOi+FcGCq6NJCq8cBWKkDw25X38gqTXzvm3p4sQOC5f4o3ynimMtORH9oCr8RjVQtcQqsvDkcAUYB+5zNSjMro64KejfToqCX5DOWU7rZSJFX426UX5pV06YP9Zj32HQ7uQNgq/G72+dx8gP5vc1mWffV0o8hTa9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147769; c=relaxed/simple;
	bh=7IMXpOoF9UZW9whL9fhcHuUZXNyCFA9w0imB5sIFRpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDD6JKTUCHHZ6Tg8SRhYdc7q2HsFRlTOrnVcMXwV9yzboMAW49/U+p/9du17ny2kZ4i7f0P8igVyGI5KshzsK0UC23aJ1cx+hpXj1Mcu0lhYBsjlLlnBHWNKhMfgmJAxUsOxXbTfzr8g+vkn8go09J2FwIhWr0pB+hT3xkMBVLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y24xC5nBsz1V5RR;
	Mon,  2 Dec 2024 21:53:03 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id D6CE71403D2;
	Mon,  2 Dec 2024 21:55:57 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 2 Dec 2024 21:55:56 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 3/5] kselftest/arm64: Add HWCAP test for FEAT_{LS64, LS64_V, LS64_ACCDATA}
Date: Mon, 2 Dec 2024 21:55:02 +0800
Message-ID: <20241202135504.14252-4-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20241202135504.14252-1-yangyicong@huawei.com>
References: <20241202135504.14252-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Add tests for FEAT_{LS64, LS64_V, LS64_ACCDATA}. Issue related
instructions if feature presents, no SIGILL should be received.
Since such instructions can only operate on Device memory or
non-cacheable memory, we may received a SIGBUS during the test.
Just ignore it since we only tested whether the instruction itself
can be issued as expected on platforms declaring the support of
such features.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 127 ++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 0029ed9c5c9a..6c826d4bb056 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -11,6 +11,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/auxvec.h>
+#include <linux/compiler.h>
 #include <sys/auxv.h>
 #include <sys/prctl.h>
 #include <asm/hwcap.h>
@@ -452,6 +454,107 @@ static void lrcpc3_sigill(void)
 	              : "=r" (data0), "=r" (data1) : "r" (src) :);
 }
 
+static void ignore_signal(int sig, siginfo_t *info, void *context)
+{
+	ucontext_t *uc = context;
+
+	uc->uc_mcontext.pc += 4;
+}
+
+static void ls64_sigill(void)
+{
+	struct sigaction ign, old;
+	char src[64] __aligned(64) = { 1 };
+
+	/*
+	 * LS64, LS64_V, LS64_ACCDATA require target memory to be
+	 * Device/Non-cacheable and the completer supports these
+	 * instructions, otherwise we'll receive a SIGBUS. Since
+	 * we are only testing the ABI here, so just ignore the
+	 * SIGBUS and see if we can execute the instructions
+	 * without receiving a SIGILL. Restore the handler of
+	 * SIGBUS after this test.
+	 */
+	ign.sa_sigaction = ignore_signal;
+	ign.sa_flags = SA_SIGINFO | SA_RESTART;
+	sigemptyset(&ign.sa_mask);
+	sigaction(SIGBUS, &ign, &old);
+
+	register void *xn asm ("x8") = src;
+	register u64 xt_1 asm ("x0");
+	register u64 __maybe_unused xt_2 asm ("x1");
+	register u64 __maybe_unused xt_3 asm ("x2");
+	register u64 __maybe_unused xt_4 asm ("x3");
+	register u64 __maybe_unused xt_5 asm ("x4");
+	register u64 __maybe_unused xt_6 asm ("x5");
+	register u64 __maybe_unused xt_7 asm ("x6");
+	register u64 __maybe_unused xt_8 asm ("x7");
+
+	/* LD64B x0, [x8] */
+	asm volatile(".inst 0xf83fd100" : "=r" (xt_1) : "r" (xn));
+
+	/* ST64B x0, [x8] */
+	asm volatile(".inst 0xf83f9100" : : "r" (xt_1), "r" (xn));
+
+	sigaction(SIGBUS, &old, NULL);
+}
+
+static void ls64_v_sigill(void)
+{
+	struct sigaction ign, old;
+	char dst[64] __aligned(64);
+
+	/* See comment in ls64_sigill() */
+	ign.sa_sigaction = ignore_signal;
+	ign.sa_flags = SA_SIGINFO | SA_RESTART;
+	sigemptyset(&ign.sa_mask);
+	sigaction(SIGBUS, &ign, &old);
+
+	register void *xn asm ("x8") = dst;
+	register u64 xt_1 asm ("x0") = 1;
+	register u64 __maybe_unused xt_2 asm ("x1") = 2;
+	register u64 __maybe_unused xt_3 asm ("x2") = 3;
+	register u64 __maybe_unused xt_4 asm ("x3") = 4;
+	register u64 __maybe_unused xt_5 asm ("x4") = 5;
+	register u64 __maybe_unused xt_6 asm ("x5") = 6;
+	register u64 __maybe_unused xt_7 asm ("x6") = 7;
+	register u64 __maybe_unused xt_8 asm ("x7") = 8;
+	register u64 st   asm ("x9");
+
+	/* ST64BV x9, x0, [x8] */
+	asm volatile(".inst 0xf829b100" : "=r" (st) : "r" (xt_1), "r" (xn));
+
+	sigaction(SIGBUS, &old, NULL);
+}
+
+static void ls64_accdata_sigill(void)
+{
+	struct sigaction ign, old;
+	char dst[64] __aligned(64);
+
+	/* See comment in ls64_sigill() */
+	ign.sa_sigaction = ignore_signal;
+	ign.sa_flags = SA_SIGINFO | SA_RESTART;
+	sigemptyset(&ign.sa_mask);
+	sigaction(SIGBUS, &ign, &old);
+
+	register void *xn asm ("x8") = dst;
+	register u64 xt_1 asm ("x0") = 1;
+	register u64 __maybe_unused xt_2 asm ("x1") = 2;
+	register u64 __maybe_unused xt_3 asm ("x2") = 3;
+	register u64 __maybe_unused xt_4 asm ("x3") = 4;
+	register u64 __maybe_unused xt_5 asm ("x4") = 5;
+	register u64 __maybe_unused xt_6 asm ("x5") = 6;
+	register u64 __maybe_unused xt_7 asm ("x6") = 7;
+	register u64 __maybe_unused xt_8 asm ("x7") = 8;
+	register u64 st asm ("x9");
+
+	/* ST64BV0 x9, x0, [x8] */
+	asm volatile(".inst 0xf829a100" : "=r" (st) : "r" (xt_1), "r" (xn));
+
+	sigaction(SIGBUS, &old, NULL);
+}
+
 static const struct hwcap_data {
 	const char *name;
 	unsigned long at_hwcap;
@@ -867,6 +970,30 @@ static const struct hwcap_data {
 		.sigill_fn = hbc_sigill,
 		.sigill_reliable = true,
 	},
+	{
+		.name = "LS64",
+		.at_hwcap = AT_HWCAP3,
+		.hwcap_bit = HWCAP3_LS64,
+		.cpuinfo = "ls64",
+		.sigill_fn = ls64_sigill,
+		.sigill_reliable = true,
+	},
+	{
+		.name = "LS64_V",
+		.at_hwcap = AT_HWCAP3,
+		.hwcap_bit = HWCAP3_LS64_V,
+		.cpuinfo = "ls64_v",
+		.sigill_fn = ls64_v_sigill,
+		.sigill_reliable = true,
+	},
+	{
+		.name = "LS64_ACCDATA",
+		.at_hwcap = AT_HWCAP3,
+		.hwcap_bit = HWCAP3_LS64_ACCDATA,
+		.cpuinfo = "ls64_accdata",
+		.sigill_fn = ls64_accdata_sigill,
+		.sigill_reliable = true,
+	},
 };
 
 typedef void (*sighandler_fn)(int, siginfo_t *, void *);
-- 
2.24.0


