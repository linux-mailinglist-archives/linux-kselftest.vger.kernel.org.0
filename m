Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8289147D20C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245109AbhLVMlj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:41:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:11439 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245090AbhLVMlM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176872; x=1671712872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/7tJVlxUhNBAWdzKM9/812twVZqkE1eUm48Gf8V1D2E=;
  b=QWijrOUdzr2nWrFk9cQpmI09RYNh3Z3ftUdxDx7FbWKWkuexg1Hp0IE1
   AkSBIaXlAx0DfFLg6R+7mPFD1RUziVhxMQs5AY/9+fEpNEMOIag+OqRbJ
   hosLcrDn6FmTp1WBUexwURhq29w/9RCytI8AL/cPKF2QjhjNPs1gK06aP
   Imd0O0pP6D8eVLCaOK+XqUNdF81M5x4zHz6XpcyA/a6G/d53IlXR03OeT
   9wANXdJjf1vfdoXy6WceCeXHrqfLNq1Pbf1KAEBV8DqMTs1SOpY5Ddr9U
   wXrhasmKnTwWdMBygcADaobxVW/Xa5AgwDKgp0bt/lRvZ2xjevpqSl1Z2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833423"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833423"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002758"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:41:03 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 14/22] kvm: x86: Emulate IA32_XFD_ERR for guest
Date:   Wed, 22 Dec 2021 04:40:44 -0800
Message-Id: <20211222124052.644626-15-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Emulate read/write to IA32_XFD_ERR MSR.

Only the saved value in the guest_fpu container is touched in the
emulation handler. Actual MSR update is handled right before entering
the guest (with preemption disabled)

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
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
-- 
2.27.0

