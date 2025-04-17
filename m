Return-Path: <linux-kselftest+bounces-31024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE5A910B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6537ACA16
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFCE22FDEB;
	Thu, 17 Apr 2025 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdRpeEn7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21922E00A;
	Thu, 17 Apr 2025 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849654; cv=none; b=idplwAkvxYVR2DhzCVyhDHSIKQZOgi7mXJRtql291clwR/fpznirTTm0sNUgZvn/n8MLtHLyqFq1TygRHciD9EIBTOOaD++DftM/pTjl6j9LYG4fdX788Y/DmPhMT6JHhcwLYN0gAzbJARBqh0kAQJSpnNc6YQt37Uck0Cj+JYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849654; c=relaxed/simple;
	bh=c22FTsDBl8on7JkOPsVEpDLeW97hqa6VyOk90f5/da4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K5APvQ5iNSLXyy/PTM7gycOZHvHVTJfNXU3QUI1TfXDymJFMCqfYxs6jIR+wbPy59gFsZEVVjuXIotaDiPyDbs+hwELghW2r1+UXQO32CrLt+l7xHeSE9Q+di/3sfxevhbpUWQaIRgBmDh+1qn1Zk6qPsPbmuD/XyVbSvIz9TMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdRpeEn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A729C4CEED;
	Thu, 17 Apr 2025 00:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849654;
	bh=c22FTsDBl8on7JkOPsVEpDLeW97hqa6VyOk90f5/da4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pdRpeEn7CrcVPx+kUfDsoI5/OAvjUj7WFrbF4LkM3BYxCHjzqplZNqkJMkrUaTzuV
	 c7my1t3zDLG8eWNQTgNcya0XNY9zCVVJB2htQNW5WV/9RzpmC86gmY4X1sjpCsDPx5
	 ZisOkzq8p2/j69nPr1xnLvRJicSLEIHSGDVvdd3hZNuKn44zioZjnZzuZT+Qr/Pu1H
	 xbGnvNP3pqhkZHUA6p3+i7j11Sp8t+8f5Te4Hs6CWoNgLg4hvgrJE1HdN9li+qKPVV
	 frAjLJt8WYVZZLAlF4fGIROL7u0mf+Cdt9+gEQlK28A6q2/45GUcRa5Y6ORTcFrzye
	 G0p7B2RoL+IhA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:32 +0100
Subject: [PATCH v5 28/28] KVM: arm64: selftests: Add SME to set_id_regs
 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-28-f469a2d5f574@kernel.org>
References: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
In-Reply-To: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3711; i=broonie@kernel.org;
 h=from:subject:message-id; bh=c22FTsDBl8on7JkOPsVEpDLeW97hqa6VyOk90f5/da4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEqEPmF1UWC0EBNqc6FOONN5AgLp5u4ISmCdeQ3d
 +1tXd0qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKhAAKCRAk1otyXVSH0Gh/B/
 9HAFpSzIdzlDrDNhb9algwishiTaXUKWuASjSDPBm1wCg6xVIGVPOWp9/N83PHSqzHCeYjpo4X4K0u
 gyHfVWPM9eDHZ8m9XrAzvEVRLv7Zr+HE3obFad8s3tkORdQfil/0/vGWXhpXQwXUiMyUHJM8f9QcKo
 sSs5j37wkt+KRS4anKOc8HrgvRR7MaxEnREFXI7II9vJmqNVAmSuvZC4mYCeHR3uZs4HOudiOBLt4N
 C2RJwtqS9Q+PQliixkCFALO12w7K5QPcAfdORLnmXwdjDIT7OaeIRO91nDZfQpdXkKHVgn8d2W0G56
 s1Ln1aXjPH01uX1yqB7S2fjKUu+5Ej
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add coverage of the SME ID registers to set_id_regs, ID_AA64PFR1_EL1.SME
becomes writable and we add ID_AA64SMFR_EL1 and it's subfields.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 30 +++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 322b9d3b0125..bcb00bb6be2d 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -138,6 +138,7 @@ static const struct reg_ftr_bits ftr_id_aa64pfr0_el1[] = {
 
 static const struct reg_ftr_bits ftr_id_aa64pfr1_el1[] = {
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, CSV2_frac, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, SME, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, SSBS, ID_AA64PFR1_EL1_SSBS_NI),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, BT, 0),
 	REG_FTR_END,
@@ -185,6 +186,28 @@ static const struct reg_ftr_bits ftr_id_aa64mmfr2_el1[] = {
 	REG_FTR_END,
 };
 
+static const struct reg_ftr_bits ftr_id_aa64smfr0_el1[] = {
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, FA64, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, LUTv2, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, SMEver, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, I16I64, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, F64F64, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, I16I32, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, B16B16, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, F16F16, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, F8F16, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, F8F32, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, I8I32, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, F16F32, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, B16F32, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, BI32I32, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, F32F32, 0)
+,	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, SF8FMA, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, SF8DP4, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, SF8DP2, 0),
+	REG_FTR_END,
+};
+
 static const struct reg_ftr_bits ftr_id_aa64zfr0_el1[] = {
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ZFR0_EL1, F64MM, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ZFR0_EL1, F32MM, 0),
@@ -215,6 +238,7 @@ static struct test_feature_reg test_regs[] = {
 	TEST_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0_el1),
 	TEST_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1_el1),
 	TEST_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2_el1),
+	TEST_REG(SYS_ID_AA64SMFR0_EL1, ftr_id_aa64smfr0_el1),
 	TEST_REG(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0_el1),
 };
 
@@ -231,6 +255,7 @@ static void guest_code(void)
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR0_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR1_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR2_EL1);
+	GUEST_REG_SYNC(SYS_ID_AA64SMFR0_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64ZFR0_EL1);
 	GUEST_REG_SYNC(SYS_CTR_EL0);
 	GUEST_REG_SYNC(SYS_MIDR_EL1);
@@ -700,8 +725,9 @@ int main(void)
 		   ARRAY_SIZE(ftr_id_aa64isar2_el1) + ARRAY_SIZE(ftr_id_aa64pfr0_el1) +
 		   ARRAY_SIZE(ftr_id_aa64pfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr0_el1) +
 		   ARRAY_SIZE(ftr_id_aa64mmfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr2_el1) +
-		   ARRAY_SIZE(ftr_id_aa64zfr0_el1) - ARRAY_SIZE(test_regs) + 3 +
-		   MPAM_IDREG_TEST;
+
+		   ARRAY_SIZE(ftr_id_aa64zfr0_el1) + ARRAY_SIZE(ftr_id_aa64smfr0_el1) -
+		   ARRAY_SIZE(test_regs) + 3 + MPAM_IDREG_TEST;
 
 	ksft_set_plan(test_cnt);
 

-- 
2.39.5


