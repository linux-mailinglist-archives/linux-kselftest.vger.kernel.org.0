Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B0F6A8513
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 16:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCBPVF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 10:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCBPVF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 10:21:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E704B2CFD2
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Mar 2023 07:21:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E93211FB;
        Thu,  2 Mar 2023 07:21:46 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEE3E3F67D;
        Thu,  2 Mar 2023 07:21:02 -0800 (PST)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvmarm@lists.linux.dev,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1] KVM: selftests: arm64: Fix ttbr0_el1 encode for PA bits > 48
Date:   Thu,  2 Mar 2023 15:20:33 +0000
Message-Id: <20230302152033.242073-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Bits [51:48] of the pgd address are stored at bits [5:1] of ttbr0_el1.
page_table_test stores its page tables at the far end of IPA space so
was tripping over this when run on a system that supports FEAT_LPA (or
FEAT_LPA2).

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/kvm/lib/aarch64/processor.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 13f28d96521c..3947f3ccee7e 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -242,7 +242,7 @@ void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
 {
 	struct kvm_vcpu_init default_init = { .target = -1, };
 	struct kvm_vm *vm = vcpu->vm;
-	uint64_t sctlr_el1, tcr_el1;
+	uint64_t sctlr_el1, tcr_el1, ttbr0_el1;

 	if (!init)
 		init = &default_init;
@@ -293,10 +293,13 @@ void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
 		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
 	}

+	ttbr0_el1 = vm->pgd & GENMASK(47, vm->page_shift);
+
 	/* Configure output size */
 	switch (vm->mode) {
 	case VM_MODE_P52V48_64K:
 		tcr_el1 |= 6ul << 32; /* IPS = 52 bits */
+		ttbr0_el1 |= (vm->pgd & GENMASK(51, 48)) >> (48 - 2);
 		break;
 	case VM_MODE_P48V48_4K:
 	case VM_MODE_P48V48_16K:
@@ -326,7 +329,7 @@ void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
 	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1), sctlr_el1);
 	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL1), tcr_el1);
 	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MAIR_EL1), DEFAULT_MAIR_EL1);
-	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL1), vm->pgd);
+	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL1), ttbr0_el1);
 	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TPIDR_EL1), vcpu->id);
 }

--
2.25.1

