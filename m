Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F41247D1E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244970AbhLVMlB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:41:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:11431 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244921AbhLVMk5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176857; x=1671712857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cq5pl+LFSmydyprw9+uNd5O4QogykkkHwYzeeS4aZ1E=;
  b=CuinwUQizNZ6fn69KhJekXaE02Mkb/m0FiaQxP7sELVin5MgXKuxVu0I
   Bu4SQrvu8wCmK1OTK/iAJhhJBvAHz9FpMNxaF3I1dAwCbApqgNSQj/apr
   RBaxeCTotG3Hie0keHrzpISpioP+otnd85D1yxU9dmrXIYSMappyDi1Af
   k5P36NZ8Lv4R6+T3PywYPlD9k07N7KNRId0RohHqj19w8EGtQwmgqCGzs
   0HKy/gtuECPiFK4CkVLoPtw+Mn100ArJxt9BQGNx39MPRYyiw6FeOj31H
   iJ/Th1gO9nFpdLt0Ge9/IaznD9mofy+nCYBhIe3aU7vD0jvzMYP0NPB+Q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833408"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833408"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:40:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002714"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:40:56 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 05/22] kvm: x86: Check permitted dynamic xfeatures at KVM_SET_CPUID2
Date:   Wed, 22 Dec 2021 04:40:35 -0800
Message-Id: <20211222124052.644626-6-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Guest xstate permissions should be set by userspace VMM before vcpu
creation. Extend KVM_SET_CPUID2 to verify that every feature reported
in CPUID[0xD] has proper permission set.

Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
 arch/x86/kvm/cpuid.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4855344091b8..a068373a7fbd 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -81,7 +81,9 @@ static inline struct kvm_cpuid_entry2 *cpuid_entry2_find(
 	return NULL;
 }
 
-static int kvm_check_cpuid(struct kvm_cpuid_entry2 *entries, int nent)
+static int kvm_check_cpuid(struct kvm_vcpu *vcpu,
+			   struct kvm_cpuid_entry2 *entries,
+			   int nent)
 {
 	struct kvm_cpuid_entry2 *best;
 
@@ -97,6 +99,16 @@ static int kvm_check_cpuid(struct kvm_cpuid_entry2 *entries, int nent)
 			return -EINVAL;
 	}
 
+	/* Check guest permissions for dynamically-enabled xfeatures */
+	best = cpuid_entry2_find(entries, nent, 0xd, 0);
+	if (best) {
+		u64 xfeatures;
+
+		xfeatures = best->eax | ((u64)best->edx << 32);
+		if (xfeatures & ~vcpu->arch.guest_fpu.perm)
+			return -ENXIO;
+	}
+
 	return 0;
 }
 
@@ -277,21 +289,21 @@ u64 kvm_vcpu_reserved_gpa_bits_raw(struct kvm_vcpu *vcpu)
 static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
                         int nent)
 {
-    int r;
+	int r;
 
-    r = kvm_check_cpuid(e2, nent);
-    if (r)
-        return r;
+	r = kvm_check_cpuid(vcpu, e2, nent);
+	if (r)
+		return r;
 
-    kvfree(vcpu->arch.cpuid_entries);
-    vcpu->arch.cpuid_entries = e2;
-    vcpu->arch.cpuid_nent = nent;
+	kvfree(vcpu->arch.cpuid_entries);
+	vcpu->arch.cpuid_entries = e2;
+	vcpu->arch.cpuid_nent = nent;
 
-    kvm_update_kvm_cpuid_base(vcpu);
-    kvm_update_cpuid_runtime(vcpu);
-    kvm_vcpu_after_set_cpuid(vcpu);
+	kvm_update_kvm_cpuid_base(vcpu);
+	kvm_update_cpuid_runtime(vcpu);
+	kvm_vcpu_after_set_cpuid(vcpu);
 
-    return 0;
+	return 0;
 }
 
 /* when an old userspace process fills a new kernel module */
-- 
2.27.0

