Return-Path: <linux-kselftest+bounces-20846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE249B3BC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00ADC283416
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96BA204F64;
	Mon, 28 Oct 2024 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNMT5tQa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69C20495B;
	Mon, 28 Oct 2024 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147205; cv=none; b=tSTajeQpQrOcnBOoJJ7oE3CPKzlTNIUabIhNzXP5AYHjUMcrkTCaVQbjnlfd2ALIQRzk9hXNeHHvQ3q5KgAZRho5LhCIWty8gKJGYjfcwJCxqCTzwn2puJfmRIO9v7iKMTVLFMcdwo5qkPh5CSIs0A7VYcn10ZsJYWH4W9kTZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147205; c=relaxed/simple;
	bh=G7tcq3Seo5cpWXELSNXBCez29eWf6wZuSlfxRLSzlko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SgQe1zYORtI72M+/h4nhLvGxYnzjRKPmwZNO4ERh7P2dO1jHwagNsou/orpmlbnaoqwZ4BwRWG/Khii6xwC75GF8+DTzUHZsMpn8vv7Nf6vDqTCnD0P2fUzxJmqZeYrN9PH/Pc7NypIljRr+JvS+y0jrm25uEIDnpXWr+fTVcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNMT5tQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A90C4CEE3;
	Mon, 28 Oct 2024 20:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147205;
	bh=G7tcq3Seo5cpWXELSNXBCez29eWf6wZuSlfxRLSzlko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nNMT5tQawyH5AAsYYN2SLVMMSlxYwOcR41Z99TwYLIa13AmWMZNVovXtt6giBUEro
	 tIDhn75bLhoeZC7UADNv1kS8q9KIvsVp7zuGqOGpU4Y0UQfrWIc7l72v/nu0zkwTxX
	 2Wrvh/+2buH/B8f/IQtLxcf7b0wUS1LaFcjGqQUTjVnyoKelkp7Lt6vpSG64ZSYYRN
	 Kq5r69y0zXJQMOafhIFqvO+6obVci75PZRcbD49mSIQEkkEkyQ07/6Ge2H1icvC2np
	 /aP6eXfgbxXwrCL5ukL6eWN5vuH+lIG1fWFEK2BN2eG87aXyx3Su33vY2e3sPz819i
	 2vD/YOWcTvwww==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 28 Oct 2024 20:24:16 +0000
Subject: [PATCH 7/9] arm64/hwcap: Describe 2024 dpISA extensions to
 userspace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-arm64-2024-dpisa-v1-7-a38d08b008a8@kernel.org>
References: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
In-Reply-To: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=14318; i=broonie@kernel.org;
 h=from:subject:message-id; bh=G7tcq3Seo5cpWXELSNXBCez29eWf6wZuSlfxRLSzlko=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnH/NqJ5vjIbjIWCK71H9LX1oaJEMDmh3F45BPmw7i
 ACR9F3GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZx/zagAKCRAk1otyXVSH0C/bB/
 0XSo2aC7lWO17804YLBo+MHdRHmZY7ZXMHAe2ZN4vm5aHhoS/uibiL/tXYGdLB6VFX1h806hvi39fa
 VYx0//T5AwOfZMWDqsh8iI4/VyE0BggHJUNXRwx8G5IURslEflVHUlnG5etrM4T6ykeZUUozSMLFZI
 lffOc3Ed9DnVPMG2/whPHJkxOz4sCurBFvuw4E9O3Vr8iydysGxwazvybb7b98nLe8/Rd2jJnn9oP0
 u576D3dE6UZpuFZ6uyRoCBCBllrjdJzTk9H4Va4LUfEz4PirW+VETl83UcbAWc+vEAS5mgSUMroni5
 27DJr7dM3ZOBIwwIm2e12+yJGcRUNU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2024 dpISA introduces a number of architecture features all of which
only add new instructions so only require the addition of hwcaps and ID
register visibility.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 51 +++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/hwcap.h          | 17 +++++++++++
 arch/arm64/include/uapi/asm/hwcap.h     | 17 +++++++++++
 arch/arm64/kernel/cpufeature.c          | 35 ++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c             | 17 +++++++++++
 5 files changed, 137 insertions(+)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 694f67fa07d196816b1292e896ebe6a1b599c125..a364bb04cc797e2597d31798540ccd3a2e6ddd71 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -170,6 +170,57 @@ HWCAP_PACG
     ID_AA64ISAR1_EL1.GPI == 0b0001, as described by
     Documentation/arch/arm64/pointer-authentication.rst.
 
+HWCAP_CMPBR
+    Functionality implied by ID_AA64ISAR2_EL1.CSSC == 0b0010.
+
+HWCAP_FPRCVT
+    Functionality implied by ID_AA64ISAR3_EL1.FPRCVT == 0b0001.
+
+HWCAP_F8MM8
+    Functionality implied by ID_AA64FPFR0_EL1.F8MM8 == 0b0001.
+
+HWCAP_F8MM4
+    Functionality implied by ID_AA64FPFR0_EL1.F8MM4 == 0b0001.
+
+HWCAP_SVE_F16MM
+    Functionality implied by ID_AA64ZFR0_EL1.F16MM == 0b0001.
+
+HWCAP_SVE_ELTPERM
+    Functionality implied by ID_AA64ZFR0_EL1.ELTPERM == 0b0001.
+
+HWCAP_SVE_AES2
+    Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0011.
+
+HWCAP_SVE_BFSCALE
+    Functionality implied by ID_AA64ZFR0_EL1.B16B16 == 0b0010.
+
+HWCAP_SVE2P2
+    Functionality implied by ID_AA64ZFR0_EL1.SVEver == 0b0011.
+
+HWCAP_SME2P2
+    Functionality implied by ID_AA64SMFR0_EL1.SMEver == 0b0011.
+
+HWCAP_SME_SF8MM8
+    Functionality implied by ID_AA64SMFR0_EL1.SF8MM8 == 0b1.
+
+HWCAP_SME_SF8MM4
+    Functionality implied by ID_AA64SMFR0_EL1.SF8MM4 == 0b1.
+
+HWCAP_SME_SBITPERM
+    Functionality implied by ID_AA64SMFR0_EL1.SBitPerm == 0b1.
+
+HWCAP_SME_AES
+    Functionality implied by ID_AA64SMFR0_EL1.AES == 0b1.
+
+HWCAP_SME_SFEXPA
+    Functionality implied by ID_AA64SMFR0_EL1.SFEXPA == 0b1.
+
+HWCAP_SME_STMOP
+    Functionality implied by ID_AA64SMFR0_EL1.STMOP == 0b1.
+
+HWCAP_SME_SMOP4
+    Functionality implied by ID_AA64SMFR0_EL1.SMOP4 == 0b1.
+
 HWCAP2_DCPODP
     Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index a775adddecf25633e87d58fb9ac9e6293beac1b3..aad44880c31d4ddb1691a22946ed492456ab6cd6 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -92,6 +92,23 @@
 #define KERNEL_HWCAP_SB			__khwcap_feature(SB)
 #define KERNEL_HWCAP_PACA		__khwcap_feature(PACA)
 #define KERNEL_HWCAP_PACG		__khwcap_feature(PACG)
+#define KERNEL_HWCAP_CMPBR		__khwcap_feature(CMPBR)
+#define KERNEL_HWCAP_FPRCVT		__khwcap_feature(FPRCVT)
+#define KERNEL_HWCAP_F8MM8		__khwcap_feature(F8MM8)
+#define KERNEL_HWCAP_F8MM4		__khwcap_feature(F8MM4)
+#define KERNEL_HWCAP_SVE_F16MM		__khwcap_feature(SVE_F16MM)
+#define KERNEL_HWCAP_SVE_ELTPERM	__khwcap_feature(SVE_ELTPERM)
+#define KERNEL_HWCAP_SVE_AES2		__khwcap_feature(SVE_AES2)
+#define KERNEL_HWCAP_SVE_BFSCALE	__khwcap_feature(SVE_BFSCALE)
+#define KERNEL_HWCAP_SVE2P2		__khwcap_feature(SVE2P2)
+#define KERNEL_HWCAP_SME2P2		__khwcap_feature(SME2P2)
+#define KERNEL_HWCAP_SME_SF8MM8		__khwcap_feature(SME_SF8MM8)
+#define KERNEL_HWCAP_SME_SF8MM4		__khwcap_feature(SME_SF8MM4)
+#define KERNEL_HWCAP_SME_SBITPERM	__khwcap_feature(SME_SBITPERM)
+#define KERNEL_HWCAP_SME_AES		__khwcap_feature(SME_AES)
+#define KERNEL_HWCAP_SME_SFEXPA		__khwcap_feature(SME_SFEXPA)
+#define KERNEL_HWCAP_SME_STMOP		__khwcap_feature(SME_STMOP)
+#define KERNEL_HWCAP_SME_SMOP4		__khwcap_feature(SME_SMOP4)
 
 #define __khwcap2_feature(x)		(const_ilog2(HWCAP2_ ## x) + 64)
 #define KERNEL_HWCAP_DCPODP		__khwcap2_feature(DCPODP)
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 055381b2c61595361c2d57d38be936c2dfeaa195..6720c7b6cfa4df818b088b858b1bffe084dd85f3 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -55,6 +55,23 @@
 #define HWCAP_SB		(1 << 29)
 #define HWCAP_PACA		(1 << 30)
 #define HWCAP_PACG		(1UL << 31)
+#define HWCAP_CMPBR		(1UL << 33)
+#define HWCAP_FPRCVT		(1UL << 34)
+#define HWCAP_F8MM8		(1UL << 35)
+#define HWCAP_F8MM4		(1UL << 36)
+#define HWCAP_SVE_F16MM		(1UL << 37)
+#define HWCAP_SVE_ELTPERM	(1UL << 38)
+#define HWCAP_SVE_AES2		(1UL << 39)
+#define HWCAP_SVE_BFSCALE	(1UL << 40)
+#define HWCAP_SVE2P2		(1UL << 41)
+#define HWCAP_SME2P2		(1UL << 42)
+#define HWCAP_SME_SF8MM8	(1UL << 43)
+#define HWCAP_SME_SF8MM4	(1UL << 44)
+#define HWCAP_SME_SBITPERM	(1UL << 45)
+#define HWCAP_SME_AES		(1UL << 46)
+#define HWCAP_SME_SFEXPA	(1UL << 47)
+#define HWCAP_SME_STMOP		(1UL << 48)
+#define HWCAP_SME_SMOP4		(1UL << 49)
 
 /*
  * HWCAP2 flags - for AT_HWCAP2
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430fad5151b73fa213a510efac3f834..fc4acd62e853dfc9793dcf0afac52d7dfed78519 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -266,6 +266,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar3[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR3_EL1_FPRCVT_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR3_EL1_FAMINMAX_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
@@ -313,6 +314,8 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_F64MM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_F32MM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_F16MM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_I8MM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
@@ -325,6 +328,8 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_BF16_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_BitPerm_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_EltPerm_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_AES_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
@@ -369,6 +374,20 @@ static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8DP4_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8DP2_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8MM8_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8MM4_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SBitPerm_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_AES_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SFEXPA_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_STMOP_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SMOP4_SHIFT, 1, 0),
 	ARM64_FTR_END,
 };
 
@@ -377,6 +396,8 @@ static const struct arm64_ftr_bits ftr_id_aa64fpfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8FMA_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP4_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP2_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8MM8_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8MM4_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E4M3_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E5M2_SHIFT, 1, 0),
 	ARM64_FTR_END,
@@ -2992,12 +3013,15 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64MMFR2_EL1, AT, IMP, CAP_HWCAP, KERNEL_HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(ID_AA64PFR0_EL1, SVE, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE),
+	HWCAP_CAP(ID_AA64ZFR0_EL1, SVEver, SVE2p2, CAP_HWCAP, KERNEL_HWCAP_SVE2P2),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, SVEver, SVE2p1, CAP_HWCAP, KERNEL_HWCAP_SVE2P1),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, SVEver, SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, AES, PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
+	HWCAP_CAP(ID_AA64ZFR0_EL1, AES, AES2, CAP_HWCAP, KERNEL_HWCAP_SVE_AES2),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, BitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_B16B16),
+	HWCAP_CAP(ID_AA64ZFR0_EL1, B16B16, BFSCALE, CAP_HWCAP, KERNEL_HWCAP_SVE_BFSCALE),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, BF16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_SVE_EBF16),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, SHA3, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
@@ -3005,6 +3029,8 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
+	HWCAP_CAP(ID_AA64ZFR0_EL1, F16MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_F16MM),
+	HWCAP_CAP(ID_AA64ZFR0_EL1, EltPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_ELTPERM),
 #endif
 	HWCAP_CAP(ID_AA64PFR1_EL1, SSBS, SSBS2, CAP_HWCAP, KERNEL_HWCAP_SSBS),
 #ifdef CONFIG_ARM64_BTI
@@ -3021,6 +3047,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64MMFR0_EL1, ECV, IMP, CAP_HWCAP, KERNEL_HWCAP_ECV),
 	HWCAP_CAP(ID_AA64MMFR1_EL1, AFP, IMP, CAP_HWCAP, KERNEL_HWCAP_AFP),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, CSSC, IMP, CAP_HWCAP, KERNEL_HWCAP_CSSC),
+	HWCAP_CAP(ID_AA64ISAR2_EL1, CSSC, CMPBR, CAP_HWCAP, KERNEL_HWCAP_CMPBR),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, RPRFM, IMP, CAP_HWCAP, KERNEL_HWCAP_RPRFM),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, RPRES, IMP, CAP_HWCAP, KERNEL_HWCAP_RPRES),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, WFxT, IMP, CAP_HWCAP, KERNEL_HWCAP_WFXT),
@@ -3030,6 +3057,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64PFR1_EL1, SME, IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, LUTv2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_LUTV2),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p2, CAP_HWCAP, KERNEL_HWCAP_SME2P2),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
@@ -3047,6 +3075,13 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8FMA),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP4),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP2),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM8, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM8),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8MM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8MM4),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SBitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SBITPERM),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_AES),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SFEXPA, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SFEXPA),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, STMOP, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_STMOP),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SMOP4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SMOP4),
 #endif /* CONFIG_ARM64_SME */
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8CVT, IMP, CAP_HWCAP, KERNEL_HWCAP_F8CVT),
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_F8FMA),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 44718d0482b3b43175a1673ccbebc70cf16ddcb2..d2e4f1a861e59d73bb77a06b030c4b51a8542db6 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -144,6 +144,23 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SME_SF8DP4]	= "smesf8dp4",
 	[KERNEL_HWCAP_SME_SF8DP2]	= "smesf8dp2",
 	[KERNEL_HWCAP_POE]		= "poe",
+	[KERNEL_HWCAP_CMPBR]		= "cmpbr",
+	[KERNEL_HWCAP_FPRCVT]		= "fprcvt",
+	[KERNEL_HWCAP_F8MM8]		= "f8mm8",
+	[KERNEL_HWCAP_F8MM4]		= "f8mm4",
+	[KERNEL_HWCAP_SVE_F16MM]	= "svef16mm",
+	[KERNEL_HWCAP_SVE_ELTPERM]	= "sveeltperm",
+	[KERNEL_HWCAP_SVE_AES2]		= "sveaes2",
+	[KERNEL_HWCAP_SVE_BFSCALE]	= "svebfscale",
+	[KERNEL_HWCAP_SVE2P2]		= "sve2p2",
+	[KERNEL_HWCAP_SME2P2]		= "sme2p2",
+	[KERNEL_HWCAP_SME_SF8MM8]	= "smesf8mm8",
+	[KERNEL_HWCAP_SME_SF8MM4]	= "smesf8mm4",
+	[KERNEL_HWCAP_SME_SBITPERM]	= "smesbitperm",
+	[KERNEL_HWCAP_SME_AES]		= "smeaes",
+	[KERNEL_HWCAP_SME_SFEXPA]	= "smesfexpa",
+	[KERNEL_HWCAP_SME_STMOP]	= "smestmop",
+	[KERNEL_HWCAP_SME_SMOP4]	= "smesmop4",
 };
 
 #ifdef CONFIG_COMPAT

-- 
2.39.2


