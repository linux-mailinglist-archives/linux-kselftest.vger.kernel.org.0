Return-Path: <linux-kselftest+bounces-39251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052F2B2B1A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 21:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFB7624EDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC931275B02;
	Mon, 18 Aug 2025 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enYR4qj7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37C275AFA;
	Mon, 18 Aug 2025 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545192; cv=none; b=WlpiJ4X8srgIdDrn2BqLeWTnLHsI84SGNELFhSkCklmveN9gFqctYDZN5VXxFIapknozu71ZxFP64T/GYTPLWSJZLv4Oq0dQcSyBcamYp/E+orCDtLXZwmLWDCaAZgPBfCVeXxOgMjoxSETD6jJuanjKcsKJ1frc9iaLHQ1D5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545192; c=relaxed/simple;
	bh=Yp4rWZGTDT5KFNRfuZwRUzBhL1WXxvUosbp+WU+yAyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loxAxHnsT+Mv4ohU0aI0jtWsYofuY6ewuRut7PpllrxuUrINCl6bTLcWfCPrd+hJVc3mDDfjom5/jblKD/DlDzzvvs5Aah/LHpeimg5zqM4lUTyaGfZFFaFxbGoSVvae1p6IYdZ7VIjnksIQH5tt7imp7/bPvCKR2X9elWvU7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enYR4qj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B7CC4CEED;
	Mon, 18 Aug 2025 19:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755545192;
	bh=Yp4rWZGTDT5KFNRfuZwRUzBhL1WXxvUosbp+WU+yAyM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=enYR4qj7ytofyZvFaTFCUCZu1/wM8GKJTrdhnlmPC6ADnC98OmNkXGeWKYxgkkiqa
	 JS/LtmHCCrQdxGDD8KFOLsz4q8ZxyD2h0cxqCrMLEK3Ze7Bwnj4vbXBAW8SIMc0ELF
	 7Ipj640hZ51Kz4yC7uauTta29m2s7d9Uo27IIEI9rzQYwkMVvbs1GxRaJ+ENLSWuC6
	 J6uSsSX9bh3IAYHCOTXWWRNtHgic/0kET6gfjGWr0Juyf5Bs9AWTobf8R0JznyREix
	 mQO3Ev9ysKTMxqHlbvymgM0A44bC2DcPDSI8EiEZPcW/SbC3YdClUypJYMRReLWSKd
	 BYz1JaMud4g2g==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 18 Aug 2025 20:21:20 +0100
Subject: [PATCH v3 3/3] kselftest/arm64: Add lsfe to the hwcaps test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-arm64-lsfe-v3-3-af6f4d66eb39@kernel.org>
References: <20250818-arm64-lsfe-v3-0-af6f4d66eb39@kernel.org>
In-Reply-To: <20250818-arm64-lsfe-v3-0-af6f4d66eb39@kernel.org>
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
 h=from:subject:message-id; bh=Yp4rWZGTDT5KFNRfuZwRUzBhL1WXxvUosbp+WU+yAyM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoo35cNLSX6TytXvCWIkh1aXNAVcK8MraPbgJUI
 mJwRba6cluJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKN+XAAKCRAk1otyXVSH
 0CH0CACCOVx3HNaVMqyPEwTi7A3oJxaPSzOk7n4/tjcUwCF85/+WFdLaEaHCuePMjrYUveEuGsw
 xCWs2hJ+6pJG5LR2/YwTcp75aeAxyCPybxR5Km1Lb1yotTpw2ZlaO1vQP6ZA3TbBfa41bQR8EMr
 dWqtGVwyJeN0eJRue9bp2yiwqwvSAKXS1JETnFsjAQSk3L3p6zDU4rf8ozCvjhOfGWm5bTBzO2j
 ePrni6UZoCwVxGZC4twgwRkO71CcRCKhUh+UrJcfAK+aSWcntU1rh7bL/p+qx3+fXAeS1KdYn01
 dZ/0qMkZ6lTfSrIHzp/T+EIBmfzZx4g9Py0TNy5DznPPFols
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This feature has no traps associated with it so the SIGILL is not reliable.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 002ec38a8bbb..941890f69df6 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -17,6 +17,8 @@
 #include <asm/sigcontext.h>
 #include <asm/unistd.h>
 
+#include <linux/auxvec.h>
+
 #include "../../kselftest.h"
 
 #define TESTS_PER_HWCAP 3
@@ -169,6 +171,18 @@ static void lse128_sigill(void)
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
@@ -762,6 +776,13 @@ static const struct hwcap_data {
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


