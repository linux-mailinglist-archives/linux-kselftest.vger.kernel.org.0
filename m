Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4EC59EFA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 01:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiHWXXw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 19:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiHWXXu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 19:23:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AA5895EB;
        Tue, 23 Aug 2022 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661297029; x=1692833029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4B/TRj1BZONwzy5151e2R6Dce0IveHMSY69LyGwAY6I=;
  b=TpazPvRMWKrwvnNdnSGQczRw4h4Bvcdq1x2sn6xRJZqWjUwFjzRrm457
   3FBQjbFC8Ua67nIVF5sZTefqtTB7yNnA13fRsMUbPpx7Y5SB4wNuxalL/
   k4BnjUpixB4wfRy3VfIITHZRSY0/Fbx//EJQtiUVWmZEHTy0O9bKSfNHF
   agvq4CDzbAlcV96lPhRtfExVoFxgD7/ZQjSKbj8hSv9vV9tY2SN1g+g8e
   tt3Br9Si3+UeDnqFaR9hHzL7FOaJGbjG79n9IEQ+sHcwgUQWRg/SJDT/M
   XxkzA+dIfN6pkLNaoB919mra81kl58f3Y3Q1wpjoyok6Nc9trdQSlpInr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355547572"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="355547572"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 16:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="605831224"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 23 Aug 2022 16:23:47 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, yang.zhong@intel.com,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 2/2] selftests: kvm: Use the KVM API to enable dynamic XSTATE features
Date:   Tue, 23 Aug 2022 16:14:02 -0700
Message-Id: <20220823231402.7839-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823231402.7839-1-chang.seok.bae@intel.com>
References: <20220823231402.7839-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the KVM_X86_XCOMP_GUEST_PERM attribute, instead of the x86-specific prctl()
options.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/arch/x86/include/uapi/asm/kvm.h         |  1 +
 .../selftests/kvm/lib/x86_64/processor.c      | 22 ++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 46de10a809ec..6ab9a2b38061 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -461,6 +461,7 @@ struct kvm_sync_regs {
 
 /* attributes for system fd (group 0) */
 #define KVM_X86_XCOMP_GUEST_SUPP	0
+#define KVM_X86_XCOMP_GUEST_PERM	1
 
 struct kvm_vmx_nested_state_data {
 	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 2e6e61bbe81b..b67f28676d15 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -593,8 +593,6 @@ void __vm_xsave_require_permission(int bit, const char *name)
 
 	kvm_fd = open_kvm_dev_path_or_exit();
 	rc = __kvm_ioctl(kvm_fd, KVM_GET_DEVICE_ATTR, &attr);
-	close(kvm_fd);
-
 	if (rc == -1 && (errno == ENXIO || errno == EINVAL))
 		__TEST_REQUIRE(0, "KVM_X86_XCOMP_GUEST_SUPP not supported");
 
@@ -603,13 +601,25 @@ void __vm_xsave_require_permission(int bit, const char *name)
 	__TEST_REQUIRE(bitmask & (1ULL << bit),
 		       "Required XSAVE feature '%s' not supported", name);
 
-	TEST_REQUIRE(!syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_GUEST_PERM, bit));
+	attr.attr = KVM_X86_XCOMP_GUEST_PERM;
+	attr.addr = (unsigned long) bit;
+	rc = __kvm_ioctl(kvm_fd, KVM_SET_DEVICE_ATTR, &attr);
+	if (rc == -1 && (errno == ENXIO || errno == EINVAL))
+		__TEST_REQUIRE(0, "KVM_X86_XCOMP_GUEST_PERM not supported");
 
-	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_GUEST_PERM, &bitmask);
-	TEST_ASSERT(rc == 0, "prctl(ARCH_GET_XCOMP_GUEST_PERM) error: %ld", rc);
+	TEST_ASSERT(rc == 0, "KVM_SET_DEVICE_ATTR(0, KVM_X86_XCOMP_GUEST_PERM) error: %ld", rc);
+
+	attr.addr = (unsigned long) &bitmask;
+	rc = __kvm_ioctl(kvm_fd, KVM_GET_DEVICE_ATTR, &attr);
+	if (rc == -1 && (errno == ENXIO || errno == EINVAL))
+		__TEST_REQUIRE(0, "KVM_X86_XCOMP_GUEST_PERM not supported");
+
+	TEST_ASSERT(rc == 0, "KVM_GET_DEVICE_ATTR(0, KVM_X86_XCOMP_GUEST_PERM) error: %ld", rc);
 	TEST_ASSERT(bitmask & (1ULL << bit),
-		    "prctl(ARCH_REQ_XCOMP_GUEST_PERM) failure bitmask=0x%lx",
+		    "KVM_GET_DEVICE_ATTR(0, KVM_X86_XCOMP_GUEST_PERM) failure bitmask=0x%lx",
 		    bitmask);
+
+	close(kvm_fd);
 }
 
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
-- 
2.17.1

