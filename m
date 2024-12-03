Return-Path: <linux-kselftest+bounces-22743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230BB9E1CA1
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 13:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E0B2834C6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966181F76C2;
	Tue,  3 Dec 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC1M3M5+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AE41EC01A;
	Tue,  3 Dec 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229844; cv=none; b=YpGcL/hhth6n2r0R+05Yz6TAR74bdRnKJkXHqiKtlU/8unxDXP3S7iVBd772e4t+ye4xr4G4pNK82arBVuZxGeFnjETWkjktRkNYq5Ekk100xmqb/vqBGYOllU7b4pVoMKNgdWH+LEiANWhiOj/0sf53C5eQ8+Dvhu8nDbQzUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229844; c=relaxed/simple;
	bh=tQF2bkOES8pELS6AoX890Q67hdQxb7iIENpry3lJWio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lGyOo5Pnjt87wdz7DEve9COa9Ckd+mVZblY5ksPbYuS/0NEYJLaVj1cQaHb1Nfsmw5HuozrCBdHzYK8q/8S0kJOMc7AOb6bcCRqhigWpRbVWDPMS7k+lZKWj8SpuJZUd+7XfOyqZrLf/xR4/sFuY4d/x1pVv8PWR21znA3yNAjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC1M3M5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBF7C4CED9;
	Tue,  3 Dec 2024 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733229844;
	bh=tQF2bkOES8pELS6AoX890Q67hdQxb7iIENpry3lJWio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nC1M3M5+VVBkODuzNkW9NGIdcDyI34Jna9XLZ1crkDpXOz/ZR4HyPnzQS1qIx/WLw
	 5lDAsem/1QBfyySsSoZXfiiZDYUVTtOZFWytgB8fTPQSzBjq30G1UrSHMhoY3LpqXk
	 FJWbyGUKhTJI1Q5EXZSa5FDXZTR2szbIUA3VavLPkHMlAJ+Y2tF0d8/Cbob8LA3St7
	 6PCZXBayvYngPYr+3juZw07DWGLZBye+lv5JmXQxV4s6rD5N035vFhdz2xQ4TjvugN
	 phFEKB+5/8+ZCdlQ0Qe6/hGLVgOacyeCkduOU4XVHRGuuM6KN605BdQlrLxWl6QVJH
	 hWEaNGDNfQ//Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:39:26 +0000
Subject: [PATCH v3 7/9] arm64/hwcap: Describe 2024 dpISA extensions to
 userspace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-2024-dpisa-v3-7-a6c78b1aa297@kernel.org>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
In-Reply-To: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=14319; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tQF2bkOES8pELS6AoX890Q67hdQxb7iIENpry3lJWio=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTvz50eVDO8Gq9OUeVRI3/nAoGKV05dELjxVA/Biw
 hUf4PEyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ078+QAKCRAk1otyXVSH0CuIB/
 0QFmJOko6uaGygzNaNhJL9FLz37MbQwYTkRUhPQYXWFa+eR9K4WcUyID8DubUjgvTxx7jN0aStCOec
 MiS5lQVL9oy6AEORg/aNM5TFWNqC4dzVXvwM4+trryYXyuzfJAKzvDbZKgcUdqV4OulZajaC8qSnfF
 BWK6xJSd9+qBQ04LpNXk7vwqGLFecNn+dspqMiw+HRQwFq1Yia8OsYQVbhtwTpgpi6cWK/ACrRd2jD
 I/w4BFOSOdaHw6q2aOL8lF6yNakWm1BaS+VytDm5Ui8RJ8Tj2UEdzWGWYSYf2J8tE3lWFj7qzxKzOw
 I86jB6sz+M0ljR8uoTpRdIzOS+v2Vq
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
index 2ff922a406ad83d0dff8104a6e362ac6b02d0e1f..7c99894ca3e8f5433b1a0db6a4679395e5cd9ecc 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -174,6 +174,57 @@ HWCAP_GCS
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
index 2b6c61c608e2cd107503b09aba5aaeab639b759a..dbec921ee39c8c897f3e1e1c84d522b5b57130bb 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -93,6 +93,23 @@
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
index 48d46b768eaec4c307360cd3bee8b564687f4b88..61fbc88d2bfb81d0bad639ed533ac67440ae2fc4 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -56,6 +56,23 @@
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
index 6ce71f444ed84f9056196bb21bbfac61c9687e30..7ba73fdee6deb57cd745ff684eeb97f66d2ea85f 100644
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
@@ -373,6 +378,20 @@ static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
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
 
@@ -381,6 +400,8 @@ static const struct arm64_ftr_bits ftr_id_aa64fpfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8FMA_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP4_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8DP2_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8MM8_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8MM4_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E4M3_SHIFT, 1, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64FPFR0_EL1_F8E5M2_SHIFT, 1, 0),
 	ARM64_FTR_END,
@@ -3092,12 +3113,15 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
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
@@ -3105,6 +3129,8 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
+	HWCAP_CAP(ID_AA64ZFR0_EL1, F16MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_F16MM),
+	HWCAP_CAP(ID_AA64ZFR0_EL1, EltPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_ELTPERM),
 #endif
 #ifdef CONFIG_ARM64_GCS
 	HWCAP_CAP(ID_AA64PFR1_EL1, GCS, IMP, CAP_HWCAP, KERNEL_HWCAP_GCS),
@@ -3124,6 +3150,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64MMFR0_EL1, ECV, IMP, CAP_HWCAP, KERNEL_HWCAP_ECV),
 	HWCAP_CAP(ID_AA64MMFR1_EL1, AFP, IMP, CAP_HWCAP, KERNEL_HWCAP_AFP),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, CSSC, IMP, CAP_HWCAP, KERNEL_HWCAP_CSSC),
+	HWCAP_CAP(ID_AA64ISAR2_EL1, CSSC, CMPBR, CAP_HWCAP, KERNEL_HWCAP_CMPBR),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, RPRFM, IMP, CAP_HWCAP, KERNEL_HWCAP_RPRFM),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, RPRES, IMP, CAP_HWCAP, KERNEL_HWCAP_RPRES),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, WFxT, IMP, CAP_HWCAP, KERNEL_HWCAP_WFXT),
@@ -3133,6 +3160,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64PFR1_EL1, SME, IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, LUTv2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_LUTV2),
+	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p2, CAP_HWCAP, KERNEL_HWCAP_SME2P2),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
@@ -3150,6 +3178,13 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
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
index d79e88fccdfce427507e7a34c5959ce6309cbd12..9861291843d8fbcc5f8e68e2b9eaac65a0b37c22 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -145,6 +145,23 @@ static const char *const hwcap_str[] = {
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
2.39.5


