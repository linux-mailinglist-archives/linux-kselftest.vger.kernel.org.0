Return-Path: <linux-kselftest+bounces-41323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CCAB54AEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE10A0374C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5083019D8;
	Fri, 12 Sep 2025 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvb/I5NW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F43019C1;
	Fri, 12 Sep 2025 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676135; cv=none; b=ThcHkUiCkcl1pLIQrK2E5VaFuVoevvf9rgP/FJYwuyCuYflRRKV5zbof4yyrkTS4IEMG8fFNaOoyg7/zbpjFvam5EwAS4vT6n5OS+vYv83l/9rzldrgLk44iaWZza2i7b0UvKj16bi58/IyTMe+4Za7PM5oVBRkc/0J5lKYweo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676135; c=relaxed/simple;
	bh=xaVskRKfvaYHjeBh7ZUg/Y9QZVgaF1sqMd02LaZ+I3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Asiu8PFt3/JtSZgAyIZgb4W7TqXlxxYcMQDo+RT0cpS7HbhcG/i326qBQpwYhoaLwJWVabp5xAivEUCSa8kUJ2leEt8aidS0lWXWJxCJmdNXhqU3QGl1EoVU/BstfxlBmMgw590SxEKeYs7Fbjy5hB8TCwV3P/7STL/0Bnpxu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvb/I5NW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89522C4CEF7;
	Fri, 12 Sep 2025 11:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757676134;
	bh=xaVskRKfvaYHjeBh7ZUg/Y9QZVgaF1sqMd02LaZ+I3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lvb/I5NWrp7HtvlplxuWpL2vNGssAA7pBilYGFeo9znUH28bTMemg3VODTUQ+KixA
	 72S3Fwd3PD340IhxFsPTo36Eh4pbAbBpFnDGRTGPYDTCJL6ve3P040yvjYtnuKTswm
	 HFzzFeTvv956UFQwEq7V+QgqFxyC60+CpUy7uU58cWez5ZToInUtUl6sllDaeh4N3L
	 CSnunXYlowbD6jMyBu+2vZAkotAiPdhwD1EHWwupDGZ+8MgIqU2M3InbVhtHpchobe
	 x66WdnLa1ybUqom7AYwWtbkI2k0e5LyCWwlj+wRMtebuVovqWoo9xnELzWrKYLMfDe
	 KUQmhR5WJKoEg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 12 Sep 2025 10:25:30 +0100
Subject: [PATCH v16 4/6] KVM: arm64: Validate GCS exception lock when
 emulating ERET
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-arm64-gcs-v16-4-6435e5ec37db@kernel.org>
References: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
In-Reply-To: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2656; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xaVskRKfvaYHjeBh7ZUg/Y9QZVgaF1sqMd02LaZ+I3g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoxAJXCR4RyxPnfSQCG7eAvAVupSzVjrtMNwsGJ
 6JUwuO6RhmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaMQCVwAKCRAk1otyXVSH
 0H5+B/9E8krfa7iOgqbgX6kd63Vmw1Uc5wEELqhQ42KmcIl9iZrDNCGP7GpjV3eHls/O7bCcH9n
 Rk8SxCyZl/k7lgtDSiyl7Kqtt+r9wvpuZFEDOKWfoIV+yDHHa5zKiEtCedUQyPAU/tBCQ8Er3jf
 4QgXevDz+SIuD4yh66FtcZjq53tGrmXAFumQiSRx4IN1cTcU1a8kWwu5Jb1PyJFKTLVlR1P+Nl+
 Uc0Gkz3591iMuMXASYuJJuHDLpyo8VwazmAXaf+VmK0xTiBQmAy/e0oGFdyxJtRuEt/8SUdzbzL
 ZR3xu0yw47Co2/+JqwE7U0TU7ociDovb5/zoSo+Bk6SHfNWi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As per DDI0487 R_TYTWB GCS adds an additional case where an illegal
exception return can be generated. If all of:

 - PSTATE.EXLOCK is 0.
 - The EL is not being changed by the ERET.
 - GCSCR_ELx.EXLOCKEN is 1.

are true then the return is illegal. Emulate this behaviour when
emulating ERET for nested guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/emulate-nested.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 90cb4b7ae0ff..9b02b85eda64 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -2632,6 +2632,41 @@ bool forward_debug_exception(struct kvm_vcpu *vcpu)
 	return forward_mdcr_traps(vcpu, MDCR_EL2_TDE);
 }
 
+/*
+ * A subset of the pseudocode ELFromSPSR(), validity checks are
+ * assumed to have been done in code that is not GCS specific.
+ */
+static inline int exlock_el_from_spsr(u64 spsr)
+{
+	return FIELD_GET(GENMASK(3, 2), spsr);
+}
+
+/* See IllegalExceptionReturn() pseudocode */
+static bool kvm_check_illegal_exlock_return(struct kvm_vcpu *vcpu, u64 spsr)
+{
+	u64 cur_el, target_el;
+	u64 gcscr;
+
+	if (!kvm_has_gcs(vcpu->kvm))
+		return false;
+
+	if (spsr & PSR_EXLOCK_BIT)
+		return false;
+
+	cur_el = exlock_el_from_spsr(vcpu->arch.ctxt.regs.pstate);
+	target_el = exlock_el_from_spsr(spsr);
+
+	if (cur_el != target_el)
+		return false;
+
+	if (vcpu_is_el2(vcpu))
+		gcscr = __vcpu_sys_reg(vcpu, GCSCR_EL2);
+	else
+		gcscr = __vcpu_sys_reg(vcpu, GCSCR_EL1);
+
+	return gcscr & GCSCR_ELx_EXLOCKEN;
+}
+
 static u64 kvm_check_illegal_exception_return(struct kvm_vcpu *vcpu, u64 spsr)
 {
 	u64 mode = spsr & PSR_MODE_MASK;
@@ -2642,12 +2677,15 @@ static u64 kvm_check_illegal_exception_return(struct kvm_vcpu *vcpu, u64 spsr)
 	 * - trying to return to an illegal M value
 	 * - trying to return to a 32bit EL
 	 * - trying to return to EL1 with HCR_EL2.TGE set
+	 * - GCSCR_ELx.EXLOCKEN is 1 and PSTATE.EXLOCK is 0 when attempting
+	 *   to return from ELx the same EL.
 	 */
 	if (mode == PSR_MODE_EL3t   || mode == PSR_MODE_EL3h ||
 	    mode == 0b00001         || (mode & BIT(1))       ||
 	    (spsr & PSR_MODE32_BIT) ||
 	    (vcpu_el2_tge_is_set(vcpu) && (mode == PSR_MODE_EL1t ||
-					   mode == PSR_MODE_EL1h))) {
+					   mode == PSR_MODE_EL1h)) ||
+	    kvm_check_illegal_exlock_return(vcpu, spsr)) {
 		/*
 		 * The guest is playing with our nerves. Preserve EL, SP,
 		 * masks, flags from the existing PSTATE, and set IL.

-- 
2.47.2


