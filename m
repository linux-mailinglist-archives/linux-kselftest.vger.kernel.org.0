Return-Path: <linux-kselftest+bounces-35771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA654AE815E
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8E21C240FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245592F2703;
	Wed, 25 Jun 2025 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1VhB4oC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1C2D6626;
	Wed, 25 Jun 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850790; cv=none; b=rLYdPqpk8aO3QBiO/Ok5r8IYB+sCH9OBKwnq0easTxMigtgvrR1U1X9m1o6ojEXnOSyAGUTyuPociOHKJFEjT1NDTq66SBXUITo1Z0cneD2dQ1FvDyCkpizUXIpIMlzq3fQ780t9QvSwpdizcLKMOSLbfHHBAB8teJBWyZM3nLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850790; c=relaxed/simple;
	bh=/AEnPXo1dA8qwf5CIu0xk7I0CHglYXCtZ9CYRjry6l8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bM71cLpXArBVW0iou1IM8hJjKAhnddu9gHaqaiBvLG4/64H8S10Y2hblgpErE5wwtQ1IiJfzhYMPpfxJOAp7i0RvyNjLDArZ3A3Qj2WPQTp600U7UNjODRN04Crh9n/bKESmX0Miri8rJdcm1M6qq07aiqm7VWudQGB174tDbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1VhB4oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87511C4CEEA;
	Wed, 25 Jun 2025 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850789;
	bh=/AEnPXo1dA8qwf5CIu0xk7I0CHglYXCtZ9CYRjry6l8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S1VhB4oCwFp56rekUgYKd6f+8Wpmbr1vhPQmFkmjzZWBo9cfOlamDTba3WcN1HzF8
	 KyIrkF3AdsMCAFP0CeMnAAeR4YtgqgAS8be615FtRpYgL4if3hzsfIySkCvAi6jQDB
	 p5JhLn9bMlCuAz1kbk+DrJSgfvlaZrY3QMlmFFI/81Go2iJ5/O+VRES/Zo85m54t5a
	 exDhD/l/CHYWuofJTk20OFqeRyuqrOF2nQzhFCsIlOye0erW6/vLyHrWjB2NCIWrwW
	 oODvwyoRBIG818bZKoFEeet6vU25aCj7Nw0GFaw0H+IRy3jYxh0WLbqqFbJSwW+CBS
	 Rfh3xkZuV2VNA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:19 +0100
Subject: [PATCH v6 28/28] KVM: arm64: selftests: Add SME to set_id_regs
 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-28-114cff4ffe04@kernel.org>
References: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
In-Reply-To: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
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
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=3742; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/AEnPXo1dA8qwf5CIu0xk7I0CHglYXCtZ9CYRjry6l8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9x6rNqzz5sGrNiRrIXrOWy+bwyOVKM58C21N
 8UQF1abh0qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcegAKCRAk1otyXVSH
 0N0DB/9C9EuLoP1QX+nQpinl3+RPQkVA/LC6ibKQ/ADrljxkUPGGGzPd1i6TvLlJknrU6Vc4Nax
 WDtdGQKNgnTPy3sCEyI4C3+FgSGlHdBbbkgADugt9SKjXOL10CHbhQf+JMHP21/CLhiM70rXc1k
 zcC+isN7mi3oeWRgEXnU3koSXtr0NEPvmPdvraSFOd0YEvH9BdMPw5ucfSK+PBIXLcIGPng/i4A
 5eWSFYfsbv8Dgk61y2B/4VJqJPcuIvTihfFprFmrQovxnackxM2n4xpiD64Ufm59EZEYbJBIzuO
 jVunrH2tpAizaubCJdtSHop4CQE7fKYbG96ae0Xij6ouEAoH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add coverage of the SME ID registers to set_id_regs, ID_AA64PFR1_EL1.SME
becomes writable and we add ID_AA64SMFR_EL1 and it's subfields.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 29 +++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 8f422bfdfcb9..f41c4e7da3e8 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -140,6 +140,7 @@ static const struct reg_ftr_bits ftr_id_aa64pfr0_el1[] = {
 
 static const struct reg_ftr_bits ftr_id_aa64pfr1_el1[] = {
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, CSV2_frac, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, SME, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, SSBS, ID_AA64PFR1_EL1_SSBS_NI),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, BT, 0),
 	REG_FTR_END,
@@ -187,6 +188,28 @@ static const struct reg_ftr_bits ftr_id_aa64mmfr2_el1[] = {
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
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, F32F32, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, SF8FMA, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, SF8DP4, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64SMFR0_EL1, SF8DP2, 0),
+	REG_FTR_END,
+};
+
 static const struct reg_ftr_bits ftr_id_aa64zfr0_el1[] = {
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ZFR0_EL1, F64MM, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ZFR0_EL1, F32MM, 0),
@@ -217,6 +240,7 @@ static struct test_feature_reg test_regs[] = {
 	TEST_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0_el1),
 	TEST_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1_el1),
 	TEST_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2_el1),
+	TEST_REG(SYS_ID_AA64SMFR0_EL1, ftr_id_aa64smfr0_el1),
 	TEST_REG(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0_el1),
 };
 
@@ -233,6 +257,7 @@ static void guest_code(void)
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR0_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR1_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR2_EL1);
+	GUEST_REG_SYNC(SYS_ID_AA64SMFR0_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64ZFR0_EL1);
 	GUEST_REG_SYNC(SYS_CTR_EL0);
 	GUEST_REG_SYNC(SYS_MIDR_EL1);
@@ -774,8 +799,8 @@ int main(void)
 		   ARRAY_SIZE(ftr_id_aa64isar2_el1) + ARRAY_SIZE(ftr_id_aa64pfr0_el1) +
 		   ARRAY_SIZE(ftr_id_aa64pfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr0_el1) +
 		   ARRAY_SIZE(ftr_id_aa64mmfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr2_el1) +
-		   ARRAY_SIZE(ftr_id_aa64zfr0_el1) - ARRAY_SIZE(test_regs) + 3 +
-		   MPAM_IDREG_TEST + MTE_IDREG_TEST;
+		   ARRAY_SIZE(ftr_id_aa64zfr0_el1) + ARRAY_SIZE(ftr_id_aa64smfr0_el1) -
+		   ARRAY_SIZE(test_regs) + 3 + MPAM_IDREG_TEST + MTE_IDREG_TEST;
 
 	ksft_set_plan(test_cnt);
 

-- 
2.39.5


