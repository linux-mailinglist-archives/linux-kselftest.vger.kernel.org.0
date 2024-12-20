Return-Path: <linux-kselftest+bounces-23694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BE69F9779
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F39189A1BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDC622B5B2;
	Fri, 20 Dec 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqRjWyNk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4F21A458;
	Fri, 20 Dec 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713559; cv=none; b=tGc3e2RNLFvIHdl6itBzI0HTrAHujoxmElEvRH+VOLOD08xJYkTfUc8uI2YJrWxznI4tMpHFwFRcez4GN+1sDr/9wmSOG60tLnaGVRI0wYdomwFWuELNbVM9QDJhwdCaku3FZQbFolePT6/KV6IshvqX1Dlc7KHfBPGX8PWnQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713559; c=relaxed/simple;
	bh=6kn8YcyG3uuWVTS1B2ujfbi26Z2jCCYjwR1TrhqEy2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+KEGdZ0Bbj2tqPf8lVIURmvNMWafx4LfwGLHrq3v+oKTxTcMWWU5MKtQ/QTrzLcymiRdWdIkmDzcDE5JxckAMEBv/B44PXatxTgjAxghBjlpvK2Syj6H/j2a+1bgEebUkhYJyQS6R8ed9a9MQIa6LoVUE+IbC0V9DXMulFiNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqRjWyNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E167AC4CED3;
	Fri, 20 Dec 2024 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713559;
	bh=6kn8YcyG3uuWVTS1B2ujfbi26Z2jCCYjwR1TrhqEy2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XqRjWyNk9kIYPWXzlnb9og0pSjDfTTTe45d7kqmxpS9DXBj2LHwD6ojWrjz8MNbwu
	 XwIouMaWV2fBKQ+cu7e/1Pos7V7ZvsOS+pwchWq6wY6ryoWo4bqjn+zzo+6+HW5QZN
	 Br8LuB95Av9Nr6aVlrX765GiIvBh7Av6TuI6y27s0lLm5YjoApuZHxeATGCeaYUxfN
	 UeFtlTva/ah9guJwpvQtv6eV8+jMr38vXUgyxmJ4VIh1nk1XIH2v5ZDFpVrLCRve1C
	 Q9ZC4lkKJQzEw7HocYHRJI5X3zYDQegf0ANXiVp3x3NdNhGreJj44Bl6mzMAFFwSSO
	 IX1T3X2OKfhcg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:52 +0000
Subject: [PATCH RFC v3 27/27] KVM: arm64: selftests: Add SME to set_id_regs
 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-27-05b018c1ffeb@kernel.org>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
In-Reply-To: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3741; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6kn8YcyG3uuWVTS1B2ujfbi26Z2jCCYjwR1TrhqEy2Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBpXKAVT7Xj2TrzanVTCDxoQiBb4OID5YM+cEX6
 jYIeZXKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgaQAKCRAk1otyXVSH0IeFB/
 9sKnmq2qh8uWU0H5kwqGp5XMMe1DPeJUtofdlK9oQiX2eJ6fapOjfe0UTwC2KukPy2FJNYDiHfAhfZ
 M66Y9CgKhl52tOGqK7TBZoHhJLSA5EoNKUHEsD2u0Ck6av673xKkWaWzP9VtfzkEn17ZUthldmVcB+
 QIs/WZbMDD51k777cWEyWmHmboUneznPe9Cok2xzLQRTWk8PV6goqbZm4/RRKtyB98khGEBocmacrx
 yUJgOvL+aX0tooOaYFhnmA8oXyJNJruPuaaqs06xzOkyVPfMLbU0KKMkgvfRHaqPdjtsJM/2TxjOO/
 Jfded9UGUS71PlDH+JqqMIFCtnSqYm
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add coverage of the SME ID registers to set_id_regs, ID_AA64PFR1_EL1.SME
becomes writable and we add ID_AA64SMFR_EL1 and it's subfields.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/set_id_regs.c | 29 +++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/set_id_regs.c b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
index a79b7f18452d2ec336ae623b8aa5c9cf329b6b4e..ce20ca3bd2733002465ff690e3b99d23d1284de4 100644
--- a/tools/testing/selftests/kvm/aarch64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
@@ -138,6 +138,7 @@ static const struct reg_ftr_bits ftr_id_aa64pfr0_el1[] = {
 
 static const struct reg_ftr_bits ftr_id_aa64pfr1_el1[] = {
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, CSV2_frac, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, SME, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, SSBS, ID_AA64PFR1_EL1_SSBS_NI),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR1_EL1, BT, 0),
 	REG_FTR_END,
@@ -183,6 +184,28 @@ static const struct reg_ftr_bits ftr_id_aa64mmfr2_el1[] = {
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
@@ -213,6 +236,7 @@ static struct test_feature_reg test_regs[] = {
 	TEST_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0_el1),
 	TEST_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1_el1),
 	TEST_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2_el1),
+	TEST_REG(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64smfr0_el1),
 	TEST_REG(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0_el1),
 };
 
@@ -229,6 +253,7 @@ static void guest_code(void)
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR0_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR1_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR2_EL1);
+	GUEST_REG_SYNC(SYS_ID_AA64SMFR0_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64ZFR0_EL1);
 	GUEST_REG_SYNC(SYS_CTR_EL0);
 
@@ -676,8 +701,8 @@ int main(void)
 		   ARRAY_SIZE(ftr_id_aa64isar2_el1) + ARRAY_SIZE(ftr_id_aa64pfr0_el1) +
 		   ARRAY_SIZE(ftr_id_aa64pfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr0_el1) +
 		   ARRAY_SIZE(ftr_id_aa64mmfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr2_el1) +
-		   ARRAY_SIZE(ftr_id_aa64zfr0_el1) - ARRAY_SIZE(test_regs) + 2 +
-		   MPAM_IDREG_TEST;
+		   ARRAY_SIZE(ftr_id_aa64zfr0_el1) + ARRAY_SIZE(ftr_id_aa64smfr0_el1) - ARRAY_SIZE(test_regs) +
+		   2 + MPAM_IDREG_TEST;
 
 	ksft_set_plan(test_cnt);
 

-- 
2.39.5


