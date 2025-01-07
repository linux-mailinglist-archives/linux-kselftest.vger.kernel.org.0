Return-Path: <linux-kselftest+bounces-24036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4165AA04CF3
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 00:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6E33A5AC1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 23:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942091F75B2;
	Tue,  7 Jan 2025 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEQEsbz2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAC1F7589;
	Tue,  7 Jan 2025 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290882; cv=none; b=HRMsMgvQd504ZvjkHteLTMDzFO4L2uv6tIrt3bAsAYkLQcyKP8Op1amj5+obZEXvyF+SEFa9WacqXWWoeYhH/G+WSpvirquRXDK0p31YVmroC/gnLnYc7HsUATkcHqMJ0W25mQdnDqAY+y5XojF+z+8nn0zzWAdCoOwi1k2HWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290882; c=relaxed/simple;
	bh=Yf+F+i6fymzobqabHIEyUghwzhEXr5FwCU7OgnIE4OA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hd2lil2WcKlFnUorbPqGsRidK7dQVgnskffP02sGRT7gT+05DH2vNAzZhPwx/n4sMgrSujU4sVtgWxuJgLRkitx+lkmiBxVKRxTQwd0Gf2S/009+yKnhz4s0Y7exzDm4CSK2s7p12fG3bpxlKwWXVAsBD3EikOhu65QWO/vmDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEQEsbz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8471CC4CEE1;
	Tue,  7 Jan 2025 23:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736290882;
	bh=Yf+F+i6fymzobqabHIEyUghwzhEXr5FwCU7OgnIE4OA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YEQEsbz2zmX4h2vNVQsUuEU7+ssUMDbHK4KLAciUtNdcfK1uAoEUWNohMXKXll0xN
	 lFfQ6CJZW2psTszP/I+p7B84sO7lv6p9hW221uUG+xR/A6iJ8uWhiG8YeAZq/QJafY
	 R2RiShBFYyx/biXsoKPtmr4pW+BNzj/bNkTmBqxQ2UEx1dDMH9Y/zUMkJ22YaYm3cl
	 6IWijXHDYDaxOU7h9jv9+HiHr8vFcpqdwdREzS5xZhDqQn3mVAOKgUe0A/suZYdjEt
	 syIAiBWqnjFMOisbgkVA/ESk6u3YVTOCdS45vhhHgVpbsm6OL0Kg1h9mg6q1mp/3WG
	 /DbEh0bHmRAbw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 07 Jan 2025 22:59:43 +0000
Subject: [PATCH v5 3/5] arm64/hwcap: Describe 2024 dpISA extensions to
 userspace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-arm64-2024-dpisa-v5-3-7578da51fc3d@kernel.org>
References: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
In-Reply-To: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=14222; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Yf+F+i6fymzobqabHIEyUghwzhEXr5FwCU7OgnIE4OA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnfbIz/b3HZXSJPuGtj/jb0dcbuGHN9m4reK8Fn6ZQ
 Tv/64KSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ32yMwAKCRAk1otyXVSH0D9iB/
 9y0mohb7VExy/MJCVABONGDWC/LuLW4CoQP9GPafBzBHmPxtY8YteJZnZ9erF5GYlH9kU3vXPcTGBd
 odW0lduV8C7B8vSCK4MNqsFoZQ1WkxD67A4Ms01BH7ccclFwf45fRMhYmDvLc+bHO+hVT4GJPkJe5d
 0Ut1bGsc+5NOswDnLQUxhQqHGpF3bFsJt/kn+I9dlSoQDKzvjxEV2uTUiMjqETCMjSzNJuMxfvDIF/
 nUeLtBPq0H57eaAM3eXeG7strfXaeHQPvNSYbqnKKl3NefDr6Fx6zSyFW1gEhe2/Iu+vvKut33CwmO
 N88/5qFT4weUGbQ13QIqimdHzPic++
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2024 dpISA introduces a number of architecture features all of which
only add new instructions so only require the addition of hwcaps and ID
register visibility.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 50 +++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/hwcap.h          | 15 ++++++++++
 arch/arm64/include/uapi/asm/hwcap.h     | 15 ++++++++++
 arch/arm64/kernel/cpufeature.c          | 31 ++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c             | 15 ++++++++++
 5 files changed, 126 insertions(+)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 1a31723e79fd24894df5223588b9e1255943875e..69d7afe5685306a5965d279dfb0b971988424ddd 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -174,6 +174,56 @@ HWCAP_GCS
     Functionality implied by ID_AA64PFR1_EL1.GCS == 0b1, as
     described by Documentation/arch/arm64/gcs.rst.
 
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
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.F16MM == 0b0001.
+
+HWCAP_SVE_ELTPERM
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.ELTPERM == 0b0001.
+
+HWCAP_SVE_AES2
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.AES == 0b0011.
+
+HWCAP_SVE_BFSCALE
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.B16B16 == 0b0010.
+
+HWCAP_SVE2P2
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.SVEver == 0b0011.
+
+HWCAP_SME2P2
+    Functionality implied by ID_AA64SMFR0_EL1.SMEver == 0b0011.
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
index 2b6c61c608e2cd107503b09aba5aaeab639b759a..1c3f9617d54fe5a0090e87153b8633ea4dc7ffa0 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -93,6 +93,21 @@
 #define KERNEL_HWCAP_PACA		__khwcap_feature(PACA)
 #define KERNEL_HWCAP_PACG		__khwcap_feature(PACG)
 #define KERNEL_HWCAP_GCS		__khwcap_feature(GCS)
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
+#define KERNEL_HWCAP_SME_SBITPERM	__khwcap_feature(SME_SBITPERM)
+#define KERNEL_HWCAP_SME_AES		__khwcap_feature(SME_AES)
+#define KERNEL_HWCAP_SME_SFEXPA		__khwcap_feature(SME_SFEXPA)
+#define KERNEL_HWCAP_SME_STMOP		__khwcap_feature(SME_STMOP)
+#define KERNEL_HWCAP_SME_SMOP4		__khwcap_feature(SME_SMOP4)
 
 #define __khwcap2_feature(x)		(const_ilog2(HWCAP2_ ## x) + 64)
 #define KERNEL_HWCAP_DCPODP		__khwcap2_feature(DCPODP)
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 48d46b768eaec4c307360cd3bee8b564687f4b88..705a7afa8e587dc007523779c71dfc247c0b006a 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -56,6 +56,21 @@
 #define HWCAP_PACA		(1 << 30)
 #define HWCAP_PACG		(1UL << 31)
 #define HWCAP_GCS		(1UL << 32)
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
+#define HWCAP_SME_SBITPERM	(1UL << 43)
+#define HWCAP_SME_AES		(1UL << 44)
+#define HWCAP_SME_SFEXPA	(1UL << 45)
+#define HWCAP_SME_STMOP		(1UL << 46)
+#define HWCAP_SME_SMOP4		(1UL << 47)
 
 /*
  * HWCAP2 flags - for AT_HWCAP2
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f088f0f5a118284cd711da029f8cb6958ec32551..7c352d64db5c7aad6c447b573a25f53383143eee 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -268,6 +268,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar3[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR3_EL1_FPRCVT_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR3_EL1_FAMINMAX_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
@@ -317,6 +318,8 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_F64MM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_F32MM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_F16MM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_I8MM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
@@ -329,6 +332,8 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_BF16_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_BitPerm_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_EltPerm_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_AES_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
@@ -373,6 +378,16 @@ static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8DP4_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_EL1_SF8DP2_SHIFT, 1, 0),
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
 
@@ -381,6 +396,8 @@ static const struct arm64_ftr_bits ftr_id_aa64fpfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8FMA_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP4_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP2_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8MM8_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8MM4_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E4M3_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E5M2_SHIFT, 1, 0),
 	ARM64_FTR_END,
@@ -3105,12 +3122,15 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64MMFR2_EL1, AT, IMP, CAP_HWCAP, KERNEL_HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(ID_AA64PFR0_EL1, SVE, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2p2, CAP_HWCAP, KERNEL_HWCAP_SVE2P2),
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2p1, CAP_HWCAP, KERNEL_HWCAP_SVE2P1),
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, AES2, CAP_HWCAP, KERNEL_HWCAP_SVE_AES2),
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, BitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_B16B16),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, B16B16, BFSCALE, CAP_HWCAP, KERNEL_HWCAP_SVE_BFSCALE),
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, BF16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_SVE_EBF16),
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SHA3, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
@@ -3118,6 +3138,8 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
 	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, F16MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_F16MM),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, EltPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_ELTPERM),
 #endif
 #ifdef CONFIG_ARM64_GCS
 	HWCAP_CAP(ID_AA64PFR1_EL1, GCS, IMP, CAP_HWCAP, KERNEL_HWCAP_GCS),
@@ -3137,6 +3159,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64MMFR0_EL1, ECV, IMP, CAP_HWCAP, KERNEL_HWCAP_ECV),
 	HWCAP_CAP(ID_AA64MMFR1_EL1, AFP, IMP, CAP_HWCAP, KERNEL_HWCAP_AFP),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, CSSC, IMP, CAP_HWCAP, KERNEL_HWCAP_CSSC),
+	HWCAP_CAP(ID_AA64ISAR2_EL1, CSSC, CMPBR, CAP_HWCAP, KERNEL_HWCAP_CMPBR),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, RPRFM, IMP, CAP_HWCAP, KERNEL_HWCAP_RPRFM),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, RPRES, IMP, CAP_HWCAP, KERNEL_HWCAP_RPRES),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, WFxT, IMP, CAP_HWCAP, KERNEL_HWCAP_WFXT),
@@ -3146,6 +3169,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64PFR1_EL1, SME, IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, LUTv2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_LUTV2),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p2, CAP_HWCAP, KERNEL_HWCAP_SME2P2),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
@@ -3163,6 +3187,13 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
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
index d79e88fccdfce427507e7a34c5959ce6309cbd12..b08ea3dd5e210626102b83edc3be4efcc9225fc6 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -145,6 +145,21 @@ static const char *const hwcap_str[] = {
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
+	[KERNEL_HWCAP_SME_SBITPERM]	= "smesbitperm",
+	[KERNEL_HWCAP_SME_AES]		= "smeaes",
+	[KERNEL_HWCAP_SME_SFEXPA]	= "smesfexpa",
+	[KERNEL_HWCAP_SME_STMOP]	= "smestmop",
+	[KERNEL_HWCAP_SME_SMOP4]	= "smesmop4",
 };
 
 #ifdef CONFIG_COMPAT

-- 
2.39.5


