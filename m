Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57462481348
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbhL2NOZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:14:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:28049 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240016AbhL2NN5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783637; x=1672319637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGd3WlJXKFaGPvJ1L0nRxLNEBnCCuKsoOGF7jXEr4R8=;
  b=kbBkBkctVxg+toOoB5aGI0mrz+Wzc+CxBNImEP/bpI8nhelDUj/MKA30
   sbloddy97ruiD7qur3QEA54SR1/mxuBkRexOJydC1s5QqLBjPOZ7kuT2G
   Q0DiXm37MMwzyYu3ZWrS89GdGgVfQmEuE4UqzJInKQRigG0DZ+wq8cFKD
   Xte5X77rgsHupN0C76hKfURq/G4UkLacG08gkXfGrmI5Ml0d2RRMtyf4+
   9wTGHSZlqcklSy18yZ6kL6C0WoBQfXY21gu+7BYQV9gJ6OT5k4DbP0ndE
   iBbRkUdnm/dRS2oKyTPNfkaMiDGzlXcltLkLFcyfgQ0M+zESUYmyZVCrc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876142"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876142"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281197"
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
Subject: [PATCH v4 13/21] kvm: x86: Emulate IA32_XFD_ERR for guest
Date:   Wed, 29 Dec 2021 05:13:20 -0800
Message-Id: <20211229131328.12283-14-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

Emulate read/write to IA32_XFD_ERR MSR.

Only the saved value in the guest_fpu container is touched in the
emulation handler. Actual MSR update is handled right before entering
the guest (with preemption disabled)

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/kvm/x86.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b22defad5cab..a48a89f73027 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1359,7 +1359,7 @@ static const u32 msrs_to_save_all[] = {
 	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
 	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
 	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
-	MSR_IA32_XFD,
+	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
 };
 
 static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_all)];
@@ -3682,6 +3682,17 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		fpu_update_guest_xfd(&vcpu->arch.guest_fpu, data);
 		break;
+	case MSR_IA32_XFD_ERR:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_XFD))
+			return 1;
+
+		if (data & ~(XFEATURE_MASK_USER_DYNAMIC &
+			     vcpu->arch.guest_supported_xcr0))
+			return 1;
+
+		vcpu->arch.guest_fpu.xfd_err = data;
+		break;
 #endif
 	default:
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
@@ -4011,6 +4022,13 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		msr_info->data = vcpu->arch.guest_fpu.fpstate->xfd;
 		break;
+	case MSR_IA32_XFD_ERR:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_XFD))
+			return 1;
+
+		msr_info->data = vcpu->arch.guest_fpu.xfd_err;
+		break;
 #endif
 	default:
 		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
@@ -6446,6 +6464,7 @@ static void kvm_init_msr_list(void)
 				continue;
 			break;
 		case MSR_IA32_XFD:
+		case MSR_IA32_XFD_ERR:
 			if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
 				continue;
 			break;
