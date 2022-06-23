Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CB55577B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jun 2022 12:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiFWKRs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jun 2022 06:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiFWKRq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jun 2022 06:17:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32B24A3C1;
        Thu, 23 Jun 2022 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655979458; x=1687515458;
  h=from:to:cc:subject:date:message-id;
  bh=NeJur9sIZ5lmTLg5cdWYNoS4OW5zTNJwPnCWv1GQGJQ=;
  b=RKbywVx9PMGvPw04y8SV1yu8BppdGdSsdSPqWH2pmMt2bOt+zOwpHRSz
   j27UOlgsLMdPwsDBfZM/fWHHcy/KB04hylR3pT6b8XzSbn6oRE7r3OdnX
   ofvUoVbk3tCPPUdhSsCx7xo7eUwH8ogYXZ8rXZpbzqnF4TCNxvZFaE0Z5
   Quih5e7b4xY3EHJl06xvQxR/0aU+5rHwRxVrMHvceYkX63jBV/aP6p0jw
   y3CkAob2tUldRyB8xzI9zZ6NQHYnd1hZal0eHKntVusS/qtUwAM0dkQa9
   6rGMiADDQguAfQTVhOQVLPuWYdG0c22mbQVruqOFQ1QQzwKTr4oGsTVWs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="269405571"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="269405571"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 03:17:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644669573"
Received: from arthur-vostro-3668.sh.intel.com ([10.239.13.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 03:17:33 -0700
From:   Zeng Guang <guang.zeng@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, Gao Chao <chao.gao@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zeng Guang <guang.zeng@intel.com>
Subject: [PATCH v2] KVM: selftest: Enhance handling WRMSR ICR register in x2APIC mode
Date:   Thu, 23 Jun 2022 17:45:11 +0800
Message-Id: <20220623094511.26066-1-guang.zeng@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 0792334ba243..df916c6f53f9 100644
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
+		ASSERT_EQ(icr & ~APIC_ICR_BUSY, val & ~APIC_ICR_BUSY);
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

