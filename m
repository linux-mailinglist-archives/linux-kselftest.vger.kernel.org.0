Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A499485295
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbiAEMgL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:6468 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240108AbiAEMgK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386170; x=1672922170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aeUnQ0nldUif+roAFALWH71NB+TeMdH9FuBi8iRppFs=;
  b=WzQ3muCk71trGxyKjn548RSEBUxxubl9b9ofv5MntkLYY9rGgtlBBsMN
   vFi49qZbvs2yaURDfn7GtjRAsUgXxkFLPRssslBhCWs0TrDVPOorqvdsG
   FP6ZR2SiTQ5aZQSS0q9jYlQ1dOcHx/Wuy7SkPkXhwpDCKv47JSVyduAgn
   ai8q9qUbvaV8v2A8SJl74o9lyIpNFtyd7TgxXI22qFgYr+EFMFTE5EUDs
   8hf/EI2QyCUOOPAaYid1ywq2orYDkUfdjTJfc+KXOe/OYqxUrWeCrdb17
   d7c7lA9niJBBzG6NKSxL5+Fr4Mhwd3+++uE7ng8u6UzQkH7rMp6GYANHT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249373"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249373"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004843"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:36 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 08/21] kvm: x86: Enable dynamic xfeatures at KVM_SET_CPUID2
Date:   Wed,  5 Jan 2022 04:35:19 -0800
Message-Id: <20220105123532.12586-9-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

KVM can request fpstate expansion in two approaches:

  1) When intercepting guest updates to XCR0 and XFD MSR;

  2) Before vcpu runs (e.g. at KVM_SET_CPUID2);

The first option doesn't waste memory for legacy guest if it doesn't
support XFD. However doing so introduces more complexity and also
imposes an order requirement in the restoring path, i.e. XCR0/XFD
must be restored before XSTATE.

Given that the agreement is to do the static approach. This is
considered a better tradeoff though it does waste 8K memory for
legacy guest if its CPUID includes dynamically-enabled xfeatures.

Successful fpstate expansion requires userspace VMM to acquire
guest xstate permissions before calling KVM_SET_CPUID2.

Also take the chance to adjust the indent in kvm_set_cpuid().

Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/kvm/cpuid.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index eb52dde5deec..a0fedf1514ab 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -84,9 +84,12 @@ static inline struct kvm_cpuid_entry2 *cpuid_entry2_find(
 	return NULL;
 }
 
-static int kvm_check_cpuid(struct kvm_cpuid_entry2 *entries, int nent)
+static int kvm_check_cpuid(struct kvm_vcpu *vcpu,
+			   struct kvm_cpuid_entry2 *entries,
+			   int nent)
 {
 	struct kvm_cpuid_entry2 *best;
+	u64 xfeatures;
 
 	/*
 	 * The existing code assumes virtual address is 48-bit or 57-bit in the
@@ -100,7 +103,20 @@ static int kvm_check_cpuid(struct kvm_cpuid_entry2 *entries, int nent)
 			return -EINVAL;
 	}
 
-	return 0;
+	/*
+	 * Exposing dynamic xfeatures to the guest requires additional
+	 * enabling in the FPU, e.g. to expand the guest XSAVE state size.
+	 */
+	best = cpuid_entry2_find(entries, nent, 0xd, 0);
+	if (!best)
+		return 0;
+
+	xfeatures = best->eax | ((u64)best->edx << 32);
+	xfeatures &= XFEATURE_MASK_USER_DYNAMIC;
+	if (!xfeatures)
+		return 0;
+
+	return fpu_enable_guest_xfd_features(&vcpu->arch.guest_fpu, xfeatures);
 }
 
 static void kvm_update_kvm_cpuid_base(struct kvm_vcpu *vcpu)
@@ -280,21 +296,21 @@ u64 kvm_vcpu_reserved_gpa_bits_raw(struct kvm_vcpu *vcpu)
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
