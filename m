Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C03C48529E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiAEMgQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:6474 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240111AbiAEMgK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386170; x=1672922170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KqCQvwKkPCl6SH6c/rZ1VwuxF4iroOdKVTGjHdmWS5Y=;
  b=dPRpppuMKfjS+fF7VBaHOVJX8K9tPJaWmRUjK8uBzABn91/IoU/qRG1n
   cf2/M18+8QSaClGbjDyT+/nXmtZaGXDZnVaGddU8WkeCqr26DLeZe1VAE
   yImOyoNWLzmiA8niXDdgUp0iOsHC2+6TAPx6ANNFCtS5iYMgIEOI9HhmB
   T3vPCGM0YSTVh+02eLDPwvqsjxIX351AVnwpbI6H0HIT2+l/vtyLL3ggx
   1l6bssU8Qjoa8T0PyoOkzNyBvtiF6egE+ud0M4YOVhMGC6Fg7pB8hvIDz
   2ndP2E6HpsVyNcAJGUzvE+sWtxrMUClcoBve7sCiN6HvIXTX3pxb1HW86
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249378"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249378"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004852"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:37 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 10/21] kvm: x86: Add emulation for IA32_XFD
Date:   Wed,  5 Jan 2022 04:35:21 -0800
Message-Id: <20220105123532.12586-11-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

Intel's eXtended Feature Disable (XFD) feature allows the software
to dynamically adjust fpstate buffer size for XSAVE features which
have large state.

Because guest fpstate has been expanded for all possible dynamic
xstates at KVM_SET_CPUID2, emulation of the IA32_XFD MSR is
straightforward. For write just call fpu_update_guest_xfd() to
update the guest fpu container once all the sanity checks are passed.
For read simply return the cached value in the container.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/kvm/x86.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c194a8cbd25f..21ce65220e38 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1377,6 +1377,7 @@ static const u32 msrs_to_save_all[] = {
 	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
 	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
 	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
+	MSR_IA32_XFD,
 };
 
 static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_all)];
@@ -3686,6 +3687,19 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vcpu->arch.msr_misc_features_enables = data;
 		break;
+#ifdef CONFIG_X86_64
+	case MSR_IA32_XFD:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_XFD))
+			return 1;
+
+		if (data & ~(XFEATURE_MASK_USER_DYNAMIC &
+			     vcpu->arch.guest_supported_xcr0))
+			return 1;
+
+		fpu_update_guest_xfd(&vcpu->arch.guest_fpu, data);
+		break;
+#endif
 	default:
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
 			return kvm_pmu_set_msr(vcpu, msr_info);
@@ -4006,6 +4020,15 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_K7_HWCR:
 		msr_info->data = vcpu->arch.msr_hwcr;
 		break;
+#ifdef CONFIG_X86_64
+	case MSR_IA32_XFD:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_XFD))
+			return 1;
+
+		msr_info->data = vcpu->arch.guest_fpu.fpstate->xfd;
+		break;
+#endif
 	default:
 		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
 			return kvm_pmu_get_msr(vcpu, msr_info);
@@ -6441,6 +6464,10 @@ static void kvm_init_msr_list(void)
 			    min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
 				continue;
 			break;
+		case MSR_IA32_XFD:
+			if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
+				continue;
+			break;
 		default:
 			break;
 		}
