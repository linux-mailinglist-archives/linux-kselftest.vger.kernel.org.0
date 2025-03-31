Return-Path: <linux-kselftest+bounces-29946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA30A76364
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 11:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B634188C2EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1D11DE3D6;
	Mon, 31 Mar 2025 09:43:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9A1DE2C4;
	Mon, 31 Mar 2025 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414195; cv=none; b=SwO2u4ZcQ+LCvzUvPKqPP4hOIWphYglYqEmzFVslSe6wdoS5eyBbbGLAG1hwtzNcVdapxns3FpCtKURF0HOUajsXSCTClI9NOKiPiimmgtM8r4i42P5+cAEoDDtmJ9wRvQQX8ejbKYVj5G+YVU59DtQKDYK7ufm8YtXANv/td4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414195; c=relaxed/simple;
	bh=YX5yK9dgZEEpUwn+6ePHgBtfY/+RAMpBL6wfjM/LHK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uP38zFwqTFEMf2iB6UKc1vjAWrrx9TemjJzr+hI5J3c8VhL3PT4EeePhizskl3kZt/WYx8SkzRIiC+41uTli1T5RHr4QTcqKzuaqcMXEPbjz3U7eDdZo/lyzEoZZXW1QyhUPWA/8VhbORyCnqmMAvDfE9IwKlLZWkSU6Ni7m3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZR5lQ2qfxz13LGQ;
	Mon, 31 Mar 2025 17:42:42 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 978191800E2;
	Mon, 31 Mar 2025 17:43:11 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 31 Mar 2025 17:43:10 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <yangyicong@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH v2 4/6] kselftest/arm64: Add HWCAP test for FEAT_{LS64, LS64_V}
Date: Mon, 31 Mar 2025 17:43:18 +0800
Message-ID: <20250331094320.35226-5-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250331094320.35226-1-yangyicong@huawei.com>
References: <20250331094320.35226-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Add tests for FEAT_{LS64, LS64_V}. Issue related instructions
if feature presents, no SIGILL should be received. When such
instructions operate on Device memory or non-cacheable memory,
we may received a SIGBUS during the test (w/o FEAT_LS64WB).
Just ignore it since we only tested whether the instruction
itself can be issued as expected on platforms declaring the
support of such features.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 90 +++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 35f521e5f41c..e1724f038cc1 100644
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
@@ -578,6 +580,78 @@ static void lrcpc3_sigill(void)
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
+	 * LS64, LS64_V require target memory to be Device/Non-cacheable (if
+	 * FEAT_LS64WB not supported) and the completer supports these
+	 * instructions, otherwise we'll receive a SIGBUS. Since we are only
+	 * testing the ABI here, so just ignore the SIGBUS and see if we can
+	 * execute the instructions without receiving a SIGILL. Restore the
+	 * handler of SIGBUS after this test.
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
 static const struct hwcap_data {
 	const char *name;
 	unsigned long at_hwcap;
@@ -1098,6 +1172,22 @@ static const struct hwcap_data {
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
 };
 
 typedef void (*sighandler_fn)(int, siginfo_t *, void *);
-- 
2.24.0


