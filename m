Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8303F47D237
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbhLVMm3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:42:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:11440 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244969AbhLVMlA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176860; x=1671712860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oudfdu6myNVjvoNfDhIoilt+uJCzFGHVxT+rvDPYbcw=;
  b=JMMSvgBofMb5N6Ut74l2iYWMccBunjmKWFACPGa838JE4XCpHEpBEaYm
   vA3Avgo1ZfcJhVMashRfkskin4iuZl9M67b88t3Bss67mtxsXfnJnXsdD
   YX6DwkgnKCj9IMYLhaPDHBbMfOJyxIkor6kv2XTPnXZrrULIHc2Gng3Pw
   8vuu3ybzkgne2D43tLByZHBWSOVDzI+pLo47680+i6nzsEHHiWk40JF5V
   Nu3au12YByqCp75KVZY15NvDEINaLLfFoZaI2e8StbUONPSbCCXtYgYvS
   ReZIY3/ldA2SCnv4aJgQRxjQ0OmMwezrNGtGLrKVWRDgEa4TtXkC1bTft
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833413"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833413"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002731"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:40:59 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 09/22] kvm: x86: Enable dynamic XSAVE features at KVM_SET_CPUID2
Date:   Wed, 22 Dec 2021 04:40:39 -0800
Message-Id: <20211222124052.644626-10-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Statically enable all xfeatures allowed by guest perm in
KVM_SET_CPUID2, with fpstate buffer sized accordingly. This avoids
run-time expansion in the emulation and restore path of XCR0 and
XFD MSR [1].

Change kvm_vcpu_after_set_cpuid() to return error given fpstate
reallocation may fail.

[1] https://lore.kernel.org/all/20211214024948.048572883@linutronix.de/

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
 arch/x86/kvm/cpuid.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index a068373a7fbd..eb5a5070accb 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -204,10 +204,12 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_update_cpuid_runtime);
 
-static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
+static int kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	struct kvm_cpuid_entry2 *best;
+	u64 xfeatures;
+	int r;
 
 	best = kvm_find_cpuid_entry(vcpu, 1, 0);
 	if (best && apic) {
@@ -222,9 +224,17 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	best = kvm_find_cpuid_entry(vcpu, 0xD, 0);
 	if (!best)
 		vcpu->arch.guest_supported_xcr0 = 0;
-	else
-		vcpu->arch.guest_supported_xcr0 =
-			(best->eax | ((u64)best->edx << 32)) & supported_xcr0;
+	else {
+		xfeatures = best->eax | ((u64)best->edx << 32);
+
+		vcpu->arch.guest_supported_xcr0 = xfeatures & supported_xcr0;
+
+		if (xfeatures != vcpu->arch.guest_fpu.xfeatures) {
+			r = fpu_update_guest_perm_features(&vcpu->arch.guest_fpu);
+			if (r)
+				return r;
+		}
+	}
 
 	/*
 	 * Bits 127:0 of the allowed SECS.ATTRIBUTES (CPUID.0x12.0x1) enumerate
@@ -260,6 +270,8 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * adjustments to the reserved GPA bits.
 	 */
 	kvm_mmu_after_set_cpuid(vcpu);
+
+	return 0;
 }
 
 int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu)
@@ -301,9 +313,7 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 
 	kvm_update_kvm_cpuid_base(vcpu);
 	kvm_update_cpuid_runtime(vcpu);
-	kvm_vcpu_after_set_cpuid(vcpu);
-
-	return 0;
+	return kvm_vcpu_after_set_cpuid(vcpu);
 }
 
 /* when an old userspace process fills a new kernel module */
-- 
2.27.0

