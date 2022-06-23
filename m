Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430A0557619
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jun 2022 10:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiFWI6i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jun 2022 04:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiFWI6h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jun 2022 04:58:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46BF140CD;
        Thu, 23 Jun 2022 01:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655974716; x=1687510716;
  h=from:to:cc:subject:date:message-id;
  bh=laL22yp//q+jqKuq9HA61KLZ09Gii3voigcEHYG+ZkM=;
  b=D6UOZ7LHelyj1iaBASzURzopv7CdF8cKjx32XJk5woO6eQbX1/JFNmHt
   DDgOOtP0E4yF4bYuZhU6kTZHjYJzoyPWCVKr7sjRIvFk8m05ATryrF5fe
   0TrbhyC4oNaSPcDJCK2Z79NPQyHDscD+1YpOA5J8eD6sI/zF4FHDhFW3g
   cV5RF/TjIz0y0ohAzGpUHHUj9Wfyohv05rGQCd3viNB4QLvmFJ78NViUP
   MXkXyF3eaqj38L637dJ0QbmWmgOZegvH+twR1lZuuaDpHJHvQuaLKjsyb
   eM97e5FLA2ro56WLxxWj1P5kcSl2G5ekr5IP86BymumQrJHBqSC5mhmIK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344656350"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="344656350"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 01:58:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644642226"
Received: from arthur-vostro-3668.sh.intel.com ([10.239.13.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 01:58:32 -0700
From:   Zeng Guang <guang.zeng@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, Gao Chao <chao.gao@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zeng Guang <guang.zeng@intel.com>
Subject: [PATCH] KVM: selftest: Enhance handling WRMSR ICR register in x2APIC mode
Date:   Thu, 23 Jun 2022 16:26:01 +0800
Message-Id: <20220623082601.25588-1-guang.zeng@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hardware would directly write x2APIC ICR register instead of software
emulation in some circumstances, e.g when Intel IPI virtualization is
enabled. This behavior requires normal reserved bits checking to ensure
them input as zero, otherwise it will cause #GP. So we need mask out
those reserved bits from the data written to vICR register.

Remove Delivery Status bit emulation in test case as this flag
is invalid and not needed in x2APIC mode. KVM may ignore clearing
it during interrupt dispatch which will lead to fake test failure.

Opportunstically correct vector number for test sending IPI to
non-existent vCPUs.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
---
 .../selftests/kvm/x86_64/xapic_state_test.c   | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index 0792334ba243..062d2e1adeb7 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -70,13 +70,27 @@ static void ____test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu, uint64_t val)
 	vcpu_ioctl(vm, vcpu->id, KVM_GET_LAPIC, &xapic);
 	icr = (u64)(*((u32 *)&xapic.regs[APIC_ICR])) |
 	      (u64)(*((u32 *)&xapic.regs[APIC_ICR2])) << 32;
-	if (!vcpu->is_x2apic)
+	if (!vcpu->is_x2apic) {
 		val &= (-1u | (0xffull << (32 + 24)));
-	ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
+		ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
+	} else {
+		ASSERT_EQ(icr, val);
+	}
 }
 
+#define X2APIC_RSVED_BITS_MASK  (GENMASK_ULL(31,20) | \
+				 GENMASK_ULL(17,16) | \
+				 GENMASK_ULL(13,13))
+
 static void __test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu, uint64_t val)
 {
+	if (vcpu->is_x2apic) {
+		/* Hardware writing vICR register requires reserved bits 31:20,
+		 * 17:16 and 13 kept as zero to avoid #GP exception. Data value
+		 * written to vICR should mask out those bits above.
+		 */
+		val &= ~X2APIC_RSVED_BITS_MASK;
+	}
 	____test_icr(vm, vcpu, val | APIC_ICR_BUSY);
 	____test_icr(vm, vcpu, val & ~(u64)APIC_ICR_BUSY);
 }
@@ -100,7 +114,7 @@ static void test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	icr = APIC_INT_ASSERT | 0xff;
 	for (i = vcpu->id + 1; i < 0xff; i++) {
 		for (j = 0; j < 8; j++)
-			__test_icr(vm, vcpu, i << (32 + 24) | APIC_INT_ASSERT | (j << 8));
+			__test_icr(vm, vcpu, i << (32 + 24) | icr | (j << 8));
 	}
 
 	/* And again with a shorthand destination for all types of IPIs. */
-- 
2.27.0

