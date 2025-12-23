Return-Path: <linux-kselftest+bounces-47900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 426F2CD7CA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1819730BF0C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE2349AF5;
	Tue, 23 Dec 2025 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lecEL8eO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B13491C8;
	Tue, 23 Dec 2025 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766453024; cv=none; b=bN2ckrg1Uz9XoBreX1dItVEN0O9KSMIe4L1TR9BG7AoGchRfvKlJMHdSYoeBvyDFiD6CSDUy+02TSWC2zACkZYUK35VneBSRzJlZUG+8mc5P4PuS10jv6SIrh74jRCxWPoxIde6eM4gAY2GeVHqsQPZUPrxKNZ99DQkb766++wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766453024; c=relaxed/simple;
	bh=biBZze5wJQdB2Qc9fXo86i+NjUBgBr6X/9wDncv9D5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l6qbMsOeuKFzjq68qLan6TBNAuh3upLAboDV4ReRF8dY7yyQfE31NKs/N7w/DcdxeDyhNiyKVHTWnhlWhy5XAgRxFai35xn3eVn5O7W3bX0dBZ8wx+mh0/yXhDkAss2w3ZqhUf0NdnaB9ne3gifHdc1WusVyTc0/15RVcopSjSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lecEL8eO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75150C4CEF1;
	Tue, 23 Dec 2025 01:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766453024;
	bh=biBZze5wJQdB2Qc9fXo86i+NjUBgBr6X/9wDncv9D5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lecEL8eOZXFmjzpni/xmLZL/Z86cerSieXn+9NDNhqxg61iPWXtGinqGPWE32xxKn
	 Sdf2+JykhJIGkxKvmrAflNj49YoeSXa5WtfMMl3G15ebOBnVVJDzuR81ZltmkRUbBg
	 SLs7dnpOb4gALrpTQjXQeBHroDbB1KYr9/CdPS6RQP/V6fXnqUEZcs8HCtwwhAVKD9
	 nKNncO41OCNTDQduqNyCWKATmH/JpX0WdBR3I+6FPTkPMClm5uhqRi3yibvv4/U8Ue
	 H6Yh4hUDeFuXsxf/TTHMRz4qsSveBW74iA1N7ynstRjxciYsnqKK+LrUrZoll9NpAw
	 zxoZ031Plt4CQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:24 +0000
Subject: [PATCH v9 30/30] KVM: arm64: selftests: Add SME to set_id_regs
 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-30-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=broonie@kernel.org;
 h=from:subject:message-id; bh=biBZze5wJQdB2Qc9fXo86i+NjUBgBr6X/9wDncv9D5Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6ZkgocYr2mGN9fKdCMYgkg1el8uznuZmkoj
 G98q/feEOOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnumQAKCRAk1otyXVSH
 0K85B/wNsRCOfe6FnZaGCX+B0kHmxdSjtYhwgjJdEAvSvTKLAtZmj7jDPO+5qc7+VVh4pX/MmhI
 aefgBuf4s+uCqd0d0o0zQoZpmu3n3KLeBJeg+6A+tfistXav4qG8kBQ8OwtKkReRVNus6ppmGWx
 OIBxWlmQP5DghzNK4P5WqRro7rC/P8XpI3mS5lfGLLlupC6kvePjQ+QamKlY0zOK8pVzCnj61xp
 /PvPFqdEnX4+cRCHIGqBpEk8LLPN1K9R14DoyviycsggQd5GC991rANwaV4/g+Hl5VStaetztPI
 XY2x1ikz93+SlwLZI3b3kXGGEvSabfKcm5V8AeMmF42b+wF4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add coverage of the SME ID registers to set_id_regs, ID_AA64PFR1_EL1.SME
becomes writable and we add ID_AA64SMFR_EL1 and it's subfields.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 641194c5005a..73489c48d550 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -203,6 +203,28 @@ static const struct reg_ftr_bits ftr_id_aa64mmfr3_el1[] = {
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
@@ -235,6 +257,7 @@ static struct test_feature_reg test_regs[] = {
 	TEST_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1_el1),
 	TEST_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2_el1),
 	TEST_REG(SYS_ID_AA64MMFR3_EL1, ftr_id_aa64mmfr3_el1),
+	TEST_REG(SYS_ID_AA64SMFR0_EL1, ftr_id_aa64smfr0_el1),
 	TEST_REG(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0_el1),
 };
 
@@ -254,6 +277,7 @@ static void guest_code(void)
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR1_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR2_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR3_EL1);
+	GUEST_REG_SYNC(SYS_ID_AA64SMFR0_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64ZFR0_EL1);
 	GUEST_REG_SYNC(SYS_MPIDR_EL1);
 	GUEST_REG_SYNC(SYS_CLIDR_EL1);

-- 
2.47.3


