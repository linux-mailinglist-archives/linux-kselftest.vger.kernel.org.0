Return-Path: <linux-kselftest+bounces-36470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E710AF7DD0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DB34E2529
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7131256C6C;
	Thu,  3 Jul 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HedWyBd+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759752566F5;
	Thu,  3 Jul 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560010; cv=none; b=n6YOtIkAgSARBMc3AfB/5ph0foxdus91XyAbnV8egXpnoTawVQkoiVWRP8tjG5A4OqhIehm2tAzK7yc9ddP4XDVka6qbdiFB5QSypNAgjadlUxZSYkOjzzdlqyTqT6DarhmTbnIulo3X+q7eAMMWq14S9TL9GUNivD9jtdQlxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560010; c=relaxed/simple;
	bh=sHk5RpacHVScooaj/Y+sk96HDvaUhpAnndDJawkuV2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U59LTX3dg/xJ//IwDprN8CV0fhFv+YgNESW2dbjVwjT5R+Mpjo8cHz8Qpx5Kb+VLwCHfeU48imfsF02P/5otVB+7I1vHtqopNjuf7yQmzHUiI6/9oEpXki34+MRpKEo0AzSYB1WkXe3EL8nVx2Mea0hGhKTrw/Vmh3b00WGVFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HedWyBd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB96C4CEF1;
	Thu,  3 Jul 2025 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751560010;
	bh=sHk5RpacHVScooaj/Y+sk96HDvaUhpAnndDJawkuV2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HedWyBd+fVrdJb7ZFB/ZzloAW5DC4A1rKR/JSNuloo+jbi7hjbeDbB7FGQlJ1KWuE
	 6NmREHEpbyfWVqH4rcAM/BJSagP6kb28oPtkWbyY2+NoxZXbfbRRWsT+dploeGpNHA
	 qnIiZPl0FmanZrR4+l/BC6mgQetitQCsKR9fAGKT9TdVXdbbxxPyQUftdMg3Iw2FJ/
	 rBq9tm3FhcZpKt5u0LbiB5HGzeMbBMkmmncxAAU9Uq5uzWyAep7rXhjBBvQndcrbzj
	 js9B1tuRUZNgboMdhGdkAdZO1hBH1v0CpcrkhA4qexOs5KJ5HnMU2iuMLVL7iKV8tN
	 +QO1yIk65wHhQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Jul 2025 17:23:22 +0100
Subject: [PATCH v2 1/3] arm64/hwcap: Add hwcap for FEAT_LSFE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-arm64-lsfe-v2-1-eced80999cb4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3594; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sHk5RpacHVScooaj/Y+sk96HDvaUhpAnndDJawkuV2o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoZq9BbLBYY6ZPTr0ScopGZi7pIWUwFpkjiTLYw
 WiIYcMaHGGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaGavQQAKCRAk1otyXVSH
 0Hu5B/4h6S7uymGyXHFARqr6EOo69IpLGfhMt/L+m18jiaE5K2pRwiGMm9j0TsKuyvbjw6EzASR
 5cF640qfgCn58dJlciWVoN5glmq3lkyLmwgkBT7NwWObKxqseS1mTx+H56c5dvoCPup88slMMZS
 skjgrdQN4kupB3S/B613366W9atbvcHFGkHcZFMuZt1oKIFKeUVK8Znq2uMWK1HF+Q73YpT9uZH
 YCylRwuOsIolEGK6Xcq23L+n2KDhQB8i+TPjHnt5ua4Cd8ul+kAjR98lwhsPKL7qop0an+k6GK2
 XBvbkOQKsc5C5Waner0/reOHrx104rlKcoGp5lkZd5Cfee6M
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_LSFE (Large System Float Extension), providing atomic floating point
memory operations, is optional from v9.5. This feature adds no new
architectural stare and we have no immediate use for it in the kernel so
simply provide a hwcap for it to support discovery by userspace.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 4 ++++
 arch/arm64/include/asm/hwcap.h          | 1 +
 arch/arm64/include/uapi/asm/hwcap.h     | 1 +
 arch/arm64/kernel/cpufeature.c          | 2 ++
 arch/arm64/kernel/cpuinfo.c             | 1 +
 5 files changed, 9 insertions(+)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 69d7afe56853..aafb969ca263 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -435,6 +435,10 @@ HWCAP2_SME_SF8DP4
 HWCAP2_POE
     Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.
 
+HWCAP3_LSFE
+    Functionality implied by ID_AA64ISAR3_EL1.LSFE == 0b0001
+
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 1c3f9617d54f..f8d02c14e5a2 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -176,6 +176,7 @@
 #define KERNEL_HWCAP_POE		__khwcap2_feature(POE)
 
 #define __khwcap3_feature(x)		(const_ilog2(HWCAP3_ ## x) + 128)
+#define KERNEL_HWCAP_LSFE		__khwcap3_feature(LSFE)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 705a7afa8e58..339b9dbf7cfc 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -143,5 +143,6 @@
 /*
  * HWCAP3 flags - for AT_HWCAP3
  */
+#define HWCAP3_LSFE		(1 << 0)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b34044e20128..726054ac8091 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -278,6 +278,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
 
 static const struct arm64_ftr_bits ftr_id_aa64isar3[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR3_EL1_FPRCVT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR3_EL1_LSFE_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR3_EL1_FAMINMAX_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
@@ -3175,6 +3176,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR1_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_I8MM),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, LUT, IMP, CAP_HWCAP, KERNEL_HWCAP_LUT),
 	HWCAP_CAP(ID_AA64ISAR3_EL1, FAMINMAX, IMP, CAP_HWCAP, KERNEL_HWCAP_FAMINMAX),
+	HWCAP_CAP(ID_AA64ISAR3_EL1, LSFE, IMP, CAP_HWCAP, KERNEL_HWCAP_LSFE),
 	HWCAP_CAP(ID_AA64MMFR2_EL1, AT, IMP, CAP_HWCAP, KERNEL_HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(ID_AA64PFR0_EL1, SVE, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index c1f2b6b04b41..2a1efe8e1fdf 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -160,6 +160,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SME_SFEXPA]	= "smesfexpa",
 	[KERNEL_HWCAP_SME_STMOP]	= "smestmop",
 	[KERNEL_HWCAP_SME_SMOP4]	= "smesmop4",
+	[KERNEL_HWCAP_LSFE]		= "lsfe",
 };
 
 #ifdef CONFIG_COMPAT

-- 
2.39.5


