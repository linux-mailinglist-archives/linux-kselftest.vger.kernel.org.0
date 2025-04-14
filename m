Return-Path: <linux-kselftest+bounces-30679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B248DA880A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999E83B22BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C9C2BEC43;
	Mon, 14 Apr 2025 12:41:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE93265609
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634508; cv=none; b=CXH8iVqBYP+3jd4aPJNSd0vkfT9Mkd5NJaa1gzQrWt/DJcI9RmgD0Ww+NFTKmtw/piMGnElfmci7NSEIg3Sm7N4AcDa8szB4V6kyrLYG8XDZrgigk2Wk2/YSPho8C9Uh/yHW600efpY93EjhBSXjPK3l7ug8AEqGk0Z/IRpidQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634508; c=relaxed/simple;
	bh=xs/xChQJ+EXLO8JrE05C4WI80rLUGS+/n8RI29Rdn2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdM06hfIVa72p1Qq5egfK4HJjnAQN5UKrNshvRgIAAaKIYSbuCwVJVgb7LD16W/nfq1ZhsNT6nQMnsqbU3HdHNIFLezaLe7VM0B8Fii9dXhj9IrSDncH3xNlbTmlz8g0JOM91UUyzDrOVegTOBLbYKfNBPuwC6XZmLEjLk9j9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 110D01007;
	Mon, 14 Apr 2025 05:41:45 -0700 (PDT)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F07E3F59E;
	Mon, 14 Apr 2025 05:41:44 -0700 (PDT)
From: Ben Horgan <ben.horgan@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Cc: maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	shuah@kernel.org,
	Ben Horgan <ben.horgan@arm.com>
Subject: [RFC PATCH 3/3] KVM: selftests: Confirm exposing MTE_frac does not break migration
Date: Mon, 14 Apr 2025 13:40:59 +0100
Message-ID: <20250414124059.1938303-4-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414124059.1938303-1-ben.horgan@arm.com>
References: <20250414124059.1938303-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When MTE is supported but MTE_ASYMM is not (ID_AA64PFR1_EL1.MTE == 2)
ID_AA64PFR1_EL1.MTE_frac == 0xF indicates MTE_ASYNC is unsupported
and MTE_frac == 0 indicates it is supported.

As MTE_frac was previously unconditionally read as 0 from the guest
and user-space, check that using SET_ONE_REG to set it to 0 succeeds
but does not change MTE_frac from unsupported (0xF) to supported (0).
This is required as values originating from KVM from user-space must
be accepted to avoid breaking migration.

Also, to allow this MTE field to be tested, enable KVM_ARM_CAP_MTE
for the set_id_regs test. No effect on existing tests is expected.

Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 .../testing/selftests/kvm/arm64/set_id_regs.c | 77 ++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 322b9d3b0125..34f4174e7285 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -15,6 +15,8 @@
 #include "test_util.h"
 #include <linux/bitfield.h>
 
+bool have_cap_arm_mte;
+
 enum ftr_type {
 	FTR_EXACT,			/* Use a predefined safe value */
 	FTR_LOWER_SAFE,			/* Smaller value is safe */
@@ -543,6 +545,70 @@ static void test_user_set_mpam_reg(struct kvm_vcpu *vcpu)
 		ksft_test_result_fail("ID_AA64PFR1_EL1.MPAM_frac value should not be ignored\n");
 }
 
+#define MTE_IDREG_TEST 1
+static void test_user_set_mte_reg(struct kvm_vcpu *vcpu)
+{
+	uint64_t masks[KVM_ARM_FEATURE_ID_RANGE_SIZE];
+	struct reg_mask_range range = {
+		.addr = (__u64)masks,
+	};
+	uint64_t val;
+	uint64_t mte;
+	uint64_t mte_frac;
+	int idx, err;
+
+	if (!have_cap_arm_mte) {
+		ksft_test_result_skip("MTE capability not supported, nothing to test\n");
+		return;
+	}
+
+	/* Get writable masks for feature ID registers */
+	memset(range.reserved, 0, sizeof(range.reserved));
+	vm_ioctl(vcpu->vm, KVM_ARM_GET_REG_WRITABLE_MASKS, &range);
+
+	idx = encoding_to_range_idx(SYS_ID_AA64PFR1_EL1);
+	if ((masks[idx] & ID_AA64PFR1_EL1_MTE_frac_MASK) == ID_AA64PFR1_EL1_MTE_frac_MASK) {
+		ksft_test_result_skip("ID_AA64PFR1_EL1.MTE_frac is officially writable, nothing to test\n");
+		return;
+	}
+
+	/*
+	 * When MTE is supported but MTE_ASYMM is not (ID_AA64PFR1_EL1.MTE == 2)
+	 * ID_AA64PFR1_EL1.MTE_frac == 0xF indicates MTE_ASYNC is unsupported
+	 * and MTE_frac == 0 indicates it is supported.
+	 *
+	 * As MTE_frac was previously unconditionally read as 0, check
+	 * that the set to 0 succeeds but does not change MTE_frac
+	 * from unsupported (0xF) to supported (0).
+	 *
+	 */
+	val = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_ID_AA64PFR1_EL1));
+
+	mte = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE), val);
+	mte_frac = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE_frac), val);
+	if (mte != ID_AA64PFR1_EL1_MTE_MTE2 ||
+	    mte_frac != ID_AA64PFR1_EL1_MTE_frac_NI) {
+		ksft_test_result_skip("MTE_ASYNC or MTE_ASYMM are supported, nothing to test\n");
+		return;
+	}
+
+	/* Try to set MTE_frac=0. */
+	val &= ~ID_AA64PFR1_EL1_MTE_frac_MASK;
+	val |= FIELD_PREP(ID_AA64PFR1_EL1_MTE_frac_MASK, 0);
+	err = __vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_ID_AA64PFR1_EL1), val);
+	if (err) {
+		ksft_test_result_fail("ID_AA64PFR1_EL1.MTE_frac=0 was not accepted\n");
+		return;
+	}
+
+	val = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_ID_AA64PFR1_EL1));
+	mte_frac = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE_frac), val);
+	if (mte_frac == ID_AA64PFR1_EL1_MTE_frac_NI)
+		ksft_test_result_pass("ID_AA64PFR1_EL1.MTE_frac=0 accepted and still 0xF\n");
+	else
+		ksft_test_result_pass("ID_AA64PFR1_EL1.MTE_frac no longer 0xF\n");
+}
+
 static void test_guest_reg_read(struct kvm_vcpu *vcpu)
 {
 	bool done = false;
@@ -673,6 +739,14 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 	ksft_test_result_pass("%s\n", __func__);
 }
 
+void kvm_arch_vm_post_create(struct kvm_vm *vm)
+{
+	if (vm_check_cap(vm, KVM_CAP_ARM_MTE)) {
+		vm_enable_cap(vm, KVM_CAP_ARM_MTE, 0);
+		have_cap_arm_mte = true;
+	}
+}
+
 int main(void)
 {
 	struct kvm_vcpu *vcpu;
@@ -701,7 +775,7 @@ int main(void)
 		   ARRAY_SIZE(ftr_id_aa64pfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr0_el1) +
 		   ARRAY_SIZE(ftr_id_aa64mmfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr2_el1) +
 		   ARRAY_SIZE(ftr_id_aa64zfr0_el1) - ARRAY_SIZE(test_regs) + 3 +
-		   MPAM_IDREG_TEST;
+		   MPAM_IDREG_TEST + MTE_IDREG_TEST;
 
 	ksft_set_plan(test_cnt);
 
@@ -709,6 +783,7 @@ int main(void)
 	test_vcpu_ftr_id_regs(vcpu);
 	test_vcpu_non_ftr_id_regs(vcpu);
 	test_user_set_mpam_reg(vcpu);
+	test_user_set_mte_reg(vcpu);
 
 	test_guest_reg_read(vcpu);
 
-- 
2.43.0


