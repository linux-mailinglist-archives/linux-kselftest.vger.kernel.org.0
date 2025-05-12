Return-Path: <linux-kselftest+bounces-32857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD463AB3617
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 13:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E123A78B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6310258CD5;
	Mon, 12 May 2025 11:41:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD029293A;
	Mon, 12 May 2025 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050110; cv=none; b=taW+FzKYNs7t5dqZetlSHVkkyC+fkHnZ5WwnGcHdtVeZ0+xO1rN4gwlJ0qsrFY9+M2k4Lf0rvhherM99t5LAY+ZFGekhBw4NK4HOnCRmRiGlboJRfic1RuOZYSDowKWnCkvrcL8azd4/TZUPWOmlBVbzdpTuMpMLkxnrb8T56qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050110; c=relaxed/simple;
	bh=PUnV4ryXbMtS1dKTsmDxXvI17Aa+AepNrgTPDr5kSQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze4BQ5c9xZ4kO/ctPsWmetDmeh2QJcm2mGdxQVkcEcjAO7GBMpwJc5EYqmNpL6nN9EBnb8nmvsHoc8zM4gzxA2VGezkx12MhfTUH+Yk1q0Hc1GtUkiiQhGJCclrs7KhKIFr1k5C2TUP6ikKGRXJAhaBG6Yfh0YtH1z+tSFmruPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 645BA150C;
	Mon, 12 May 2025 04:41:37 -0700 (PDT)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E04EE3F5A1;
	Mon, 12 May 2025 04:41:45 -0700 (PDT)
From: Ben Horgan <ben.horgan@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	pbonzini@redhat.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: james.morse@arm.com,
	Ben Horgan <ben.horgan@arm.com>
Subject: [RFC PATCH v2 2/3] KVM: arm64: Make MTE_frac masking conditional on MTE capability
Date: Mon, 12 May 2025 12:41:11 +0100
Message-ID: <20250512114112.359087-3-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512114112.359087-1-ben.horgan@arm.com>
References: <20250512114112.359087-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If MTE_frac is masked out unconditionally then the guest will always
see ID_AA64PFR1_EL1_MTE_frac as 0. However, a value of 0 when
ID_AA64PFR1_EL1_MTE is 2 indicates that MTE_ASYNC is supported. Hence, for
a host with ID_AA64PFR1_EL1_MTE==2 and ID_AA64PFR1_EL1_MTE_frac==0xf
(MTE_ASYNC unsupported) the guest would see MTE_ASYNC advertised as
supported whilst the host does not support it. Hence, expose the sanitised
value of MTE_frac to the guest and user-space.

As MTE_frac was previously hidden, always 0, and KVM must accept values
from KVM provided by user-space, when ID_AA64PFR1_EL1.MTE is 2 allow
user-space to set ID_AA64PFR1_EL1.MTE_frac to 0. However, ignore it to
avoid incorrectly claiming hardware support for MTE_ASYNC in the guest.

Note that linux does not check the value of ID_AA64PFR1_EL1_MTE_frac and
wrongly assumes that MTE async faults can be generated even on hardware
that does nto support them. This issue is not addressed here.

Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 005ad28f7306..ee30c94c0ace 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1600,13 +1600,14 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		val = sanitise_id_aa64pfr0_el1(vcpu, val);
 		break;
 	case SYS_ID_AA64PFR1_EL1:
-		if (!kvm_has_mte(vcpu->kvm))
+		if (!kvm_has_mte(vcpu->kvm)) {
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE);
+			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE_frac);
+		}
 
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_RNDR_trap);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_NMI);
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE_frac);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_GCS);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_THE);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTEX);
@@ -1953,11 +1954,34 @@ static int set_id_aa64pfr1_el1(struct kvm_vcpu *vcpu,
 {
 	u64 hw_val = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
 	u64 mpam_mask = ID_AA64PFR1_EL1_MPAM_frac_MASK;
+	u8 mte = SYS_FIELD_GET(ID_AA64PFR1_EL1, MTE, hw_val);
+	u8 user_mte_frac = SYS_FIELD_GET(ID_AA64PFR1_EL1, MTE_frac, user_val);
+	u8 hw_mte_frac = SYS_FIELD_GET(ID_AA64PFR1_EL1, MTE_frac, hw_val);
 
 	/* See set_id_aa64pfr0_el1 for comment about MPAM */
 	if ((hw_val & mpam_mask) == (user_val & mpam_mask))
 		user_val &= ~ID_AA64PFR1_EL1_MPAM_frac_MASK;
 
+	/*
+	 * Previously MTE_frac was hidden from guest. However, if the
+	 * hardware supports MTE2 but not MTE_ASYM_FAULT then a value
+	 * of 0 for this field indicates that the hardware supports
+	 * MTE_ASYNC. Whereas, 0xf indicates MTE_ASYNC is not supported.
+	 *
+	 * As KVM must accept values from KVM provided by user-space,
+	 * when ID_AA64PFR1_EL1.MTE is 2 allow user-space to set
+	 * ID_AA64PFR1_EL1.MTE_frac to 0. However, ignore it to avoid
+	 * incorrectly claiming hardware support for MTE_ASYNC in the
+	 * guest.
+	 */
+
+	if (mte == ID_AA64PFR1_EL1_MTE_MTE2 &&
+	    hw_mte_frac == ID_AA64PFR1_EL1_MTE_frac_NI &&
+	    user_mte_frac == ID_AA64PFR1_EL1_MTE_frac_ASYNC) {
+		user_val &= ~ID_AA64PFR1_EL1_MTE_frac_MASK;
+		user_val |= hw_val & ID_AA64PFR1_EL1_MTE_frac_MASK;
+	}
+
 	return set_id_reg(vcpu, rd, user_val);
 }
 
-- 
2.43.0


