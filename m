Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF51C48134B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbhL2NOd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:14:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:28053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240358AbhL2NOH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783647; x=1672319647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hRvKYcK6yv9rsCQUr0TnGZVJtGSCMREIPvCaoPI9zgw=;
  b=Jrhr2mD/RdK8HAH2WlkM3zh3ob1Rp39OH7Kx5MbwBRPe343X5yROx9aD
   f3JRFoE3aHcnqyxrk3oWHMFGEgEUTzXwhnr1QRf7Gu+bjn9zHbqj6DUQT
   sMkjsp5pm4s7LfXnASWchOvnZXINFfM5sMc1/DBDJzqgN5yI/1Qa7xB9/
   g+sBwQPEhnycFTuCgtliaAA9gMeGJBkN1xv1UiKX++rYV4Utpu2vqmLBT
   jPlu/TaMuPBG1Q3K+NHDGCZtsKXk+Ih8KmyvAZ7ZUSzV2C/PXg9etp9+/
   SQ54kNB/QYRQDvOw6EMd1dY7hPURG5YYn19w6G8LpkGPidpd+O4F+oofl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876146"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876146"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281201"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:39 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 14/21] kvm: x86: Disable RDMSR interception of IA32_XFD_ERR
Date:   Wed, 29 Dec 2021 05:13:21 -0800
Message-Id: <20211229131328.12283-15-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

Disable read emulation of IA32_XFD_ERR MSR if guest cpuid includes XFD.
This saves one unnecessary VM-exit in guest #NM handler, given that the
MSR is already restored with the guest value before the guest is resumed.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 6 ++++++
 arch/x86/kvm/vmx/vmx.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4e51de876085..638665b3e241 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -162,6 +162,7 @@ static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
 	MSR_FS_BASE,
 	MSR_GS_BASE,
 	MSR_KERNEL_GS_BASE,
+	MSR_IA32_XFD_ERR,
 #endif
 	MSR_IA32_SYSENTER_CS,
 	MSR_IA32_SYSENTER_ESP,
@@ -7228,6 +7229,11 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	if (boot_cpu_has(X86_FEATURE_XFD))
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_XFD_ERR, MSR_TYPE_R,
+					  !guest_cpuid_has(vcpu, X86_FEATURE_XFD));
+
+
 	set_cr4_guest_host_mask(vmx);
 
 	vmx_write_encls_bitmap(vcpu, NULL);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 4df2ac24ffc1..bf9d3051cd6c 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -340,7 +340,7 @@ struct vcpu_vmx {
 	struct lbr_desc lbr_desc;
 
 	/* Save desired MSR intercept (read: pass-through) state */
-#define MAX_POSSIBLE_PASSTHROUGH_MSRS	13
+#define MAX_POSSIBLE_PASSTHROUGH_MSRS	14
 	struct {
 		DECLARE_BITMAP(read, MAX_POSSIBLE_PASSTHROUGH_MSRS);
 		DECLARE_BITMAP(write, MAX_POSSIBLE_PASSTHROUGH_MSRS);
