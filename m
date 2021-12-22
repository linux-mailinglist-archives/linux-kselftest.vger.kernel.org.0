Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7047D201
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245185AbhLVMlX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:41:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:11439 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245025AbhLVMlH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176867; x=1671712867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EpMl6feuqDrwEOO80GiNvACH9UVk+M+dGZGqnHBD8m8=;
  b=B6MGbHKgp8EQ3kTFwdX7H9bQv4wKpqrWEJpVafKuTRBmtp+CJOMWp3/L
   FZaAJEvuZDunUmVp0FgeABn+X/qO5NPnxvHX9r2cgXbT0ji1iJJfjGJLZ
   8ce45tgl1rdEIaYdpig49pSeYS1PcQKpIltiHArnxULUGgcU/VLwjVpQZ
   x65i201NesAQON0QhYJnceGbajAG2TVf6r2E56TxF0GFDHQ3B0i+8JW/z
   NTYsk8oISJ8DDAxOWYvUFpsL9DRJl1U/eyyiBGeenosU06UgLH1JjiWcJ
   PeAJ4sLqTnsIv1rsBUEVuyTKtGRDn2r5ugWcnq3VNPNBlIj+bW/Ug9YFj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833417"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833417"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:41:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002742"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:41:01 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 11/22] kvm: x86: Add emulation for IA32_XFD
Date:   Wed, 22 Dec 2021 04:40:41 -0800
Message-Id: <20211222124052.644626-12-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Intel's eXtended Feature Disable (XFD) feature allows the software
to dynamically adjust fpstate buffer size for XSAVE features which
have large state.

Because fpstate has been expanded for all possible dynamic xstates
at KVM_SET_CPUID2, emulation of the IA32_XFD MSR is straightforward.
For write just call fpu_update_guest_xfd() to update the guest fpu
container once all the sanity checks are passed. For read then
return the cached value in the container.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
 arch/x86/kvm/x86.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e50e97ac4408..36677b754ac9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1359,6 +1359,7 @@ static const u32 msrs_to_save_all[] = {
 	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
 	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
 	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
+	MSR_IA32_XFD,
 };
 
 static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_all)];
@@ -3669,6 +3670,19 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -3989,6 +4003,15 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -6422,6 +6445,10 @@ static void kvm_init_msr_list(void)
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
-- 
2.27.0

