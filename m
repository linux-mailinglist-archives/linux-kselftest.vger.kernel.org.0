Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3CB4852D2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbiAEMhH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:37:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:6467 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236024AbiAEMgL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386171; x=1672922171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zz6vVPHltIZjYaL4MvRvv7M7BfRIsEYo04ipkmGIG88=;
  b=CyawzACPembh2+LALWKY6X12+Vc76gcYp1ZgnjwUn6e0k1QJHehTBKCx
   K4CVv3N+Scl3ggXkA79LTSri7YmsjqF80du7NdiwL/obB8vRxs67NloWG
   fSwDPMYHtAl0CVogog4O3HRa9x6lHq0StI8QexVTwddeIt/KAu2zudJd2
   9g/WiuBC7m82d+uWr6bTB3lMt11WaoBmev+X075KqkDgQU1yqh/ANsep8
   d1CD0ggQ7KgkT1vEiGvpytGkLMJYvpXi42rx05vBSm2p0XV6N5vGMeM4A
   CapWI0EUVKtUrq/ioI41xU238Nd9m1I79xie9cMsTVZneWTI9g9IOoWs1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249381"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249381"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004867"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:39 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 13/21] kvm: x86: Emulate IA32_XFD_ERR for guest
Date:   Wed,  5 Jan 2022 04:35:24 -0800
Message-Id: <20220105123532.12586-14-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
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
index 2c988f8ca616..434986928552 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1377,7 +1377,7 @@ static const u32 msrs_to_save_all[] = {
 	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
 	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
 	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
-	MSR_IA32_XFD,
+	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
 };
 
 static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_all)];
@@ -3699,6 +3699,17 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
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
@@ -4028,6 +4039,13 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
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
@@ -6465,6 +6483,7 @@ static void kvm_init_msr_list(void)
 				continue;
 			break;
 		case MSR_IA32_XFD:
+		case MSR_IA32_XFD_ERR:
 			if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
 				continue;
 			break;
