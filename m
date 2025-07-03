Return-Path: <linux-kselftest+bounces-36472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4508AF7DD1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263207A818F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DDF25743D;
	Thu,  3 Jul 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9xYnMul"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB02550BA;
	Thu,  3 Jul 2025 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560017; cv=none; b=nnlsyNGcjzqmPlowdHZDGfiGMwjmJDH1cJvBbp6PCNTB7uaB1biXYhHIZajfFbMc0TDnXO9c9w1w9ovPGHdsbxLnyI3wNlqMoqb77fqZQQj6rqKhaUbWtrF2abhUQ/vOqwKg+sXVR12mQJ6jkJACB4qHPSGLk3XvuSL1LIqIk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560017; c=relaxed/simple;
	bh=0se/eq+gWDDz/zPGLfe64NetxynymgwpyPlKXYP8XIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRcCSWFJybUQIbCzOy3ZrmrDXtqxlSbUs/QRebW9ATKsjNU5UVoLXsaEamHlRhaQE52jJ+F/UaxUl/SEhUZNZJhk0jB2iuM+7PjVSuBgP8L9HcoCzZppBykxQvJ/ZalbbOsqtimh46AtfyFDLurVZUBb/AMHCOb4KAeGY0TID+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9xYnMul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57858C4CEE3;
	Thu,  3 Jul 2025 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751560015;
	bh=0se/eq+gWDDz/zPGLfe64NetxynymgwpyPlKXYP8XIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F9xYnMulVuNGNvAGTBMpLlkUdOXV29MzVXEe033VuqVu/tGe+RWsJngzdz4IffUZF
	 TlFfr0OzdjCXXzY5GuscScdCqMN4WdRq00y7yQ79g33zU0CeoS7fDu5zmWPpovhul5
	 ZpqA/v/ijUwmYLGzJmt8RMJ2UuKToISDuzKDPkyqtBjsZ0ev9agFlQ4yyBi80TBfV+
	 c9pcjON/ohz7/AITWDxJYIcAcipay9tALB0V3775LUsr27Z0zso2ElZBpm547GWVvL
	 /Seqd/LMJsI+P9t4/SG/wnc32xVf9Rwn8YlZIaCiUv6D0bP+sqI5ZeiRE+LEbZPRwp
	 cUgjf2kBSiWFA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Jul 2025 17:23:24 +0100
Subject: [PATCH v2 3/3] kselftest/arm64: Add lsfe to the hwcaps test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-arm64-lsfe-v2-3-eced80999cb4@kernel.org>
References: <20250703-arm64-lsfe-v2-0-eced80999cb4@kernel.org>
In-Reply-To: <20250703-arm64-lsfe-v2-0-eced80999cb4@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0se/eq+gWDDz/zPGLfe64NetxynymgwpyPlKXYP8XIU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoZq9DrX1z69CleuGaYuiPYfm4x17/sToCyk2zP
 Nm99VorSU2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaGavQwAKCRAk1otyXVSH
 0LtRB/45/MTmfubRL3pBtMgXgWZMq82PR/jkn5ACdHwS7IGViT7FD2ZmgEzsylFTLDfTmP4bjqb
 pbVkdOsCSZJylYyOKBy6J9aDXd7tjwVYbfLr1jFUylvwqe2j5aZ27QCwhe1PC+DOzTvNkqEzvEB
 UIUPledQkbmnZJXMySkE4RVNqUaTB8ws5T8BGrQjz+ncH0gVf+yZfXpkdxiXetLZ4QTqNj1FjDR
 ip9vM1mAiEyMlpLqJeNt0L/XcFLEWNFVgOO78k+oVlAMlESket+6r99C6oAxaBjOv9nmGxTRVCw
 0i3NukLDRtFDCW/v6+sTv43stjBooDOAlxzXewZLYPF/ko5z
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This feature has no traps associated with it so the SIGILL is not reliable.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 35f521e5f41c..faa0f82f27e0 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -17,6 +17,8 @@
 #include <asm/sigcontext.h>
 #include <asm/unistd.h>
 
+#include <linux/auxvec.h>
+
 #include "../../kselftest.h"
 
 #define TESTS_PER_HWCAP 3
@@ -165,6 +167,18 @@ static void lse128_sigill(void)
 		     : "cc", "memory");
 }
 
+static void lsfe_sigill(void)
+{
+	float __attribute__ ((aligned (16))) mem = 0;
+	register float *memp asm ("x0") = &mem;
+
+	/* LDFADD H0, H0, [X0] */
+	asm volatile(".inst 0x7c200000"
+		     : "+r" (memp)
+		     :
+		     : "cc", "memory");
+}
+
 static void lut_sigill(void)
 {
 	/* LUTI2 V0.16B, { V0.16B }, V[0] */
@@ -758,6 +772,13 @@ static const struct hwcap_data {
 		.cpuinfo = "lse128",
 		.sigill_fn = lse128_sigill,
 	},
+	{
+		.name = "LSFE",
+		.at_hwcap = AT_HWCAP3,
+		.hwcap_bit = HWCAP3_LSFE,
+		.cpuinfo = "lsfe",
+		.sigill_fn = lsfe_sigill,
+	},
 	{
 		.name = "LUT",
 		.at_hwcap = AT_HWCAP2,

-- 
2.39.5


