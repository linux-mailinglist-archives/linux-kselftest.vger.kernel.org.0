Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E04481351
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbhL2NPD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:15:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:28049 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240433AbhL2NOY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783664; x=1672319664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0UD6nWK4GZnEjA/aZDd4WoR0dLayFxRmGDiVQqvy/Kc=;
  b=geJcottNTgLoZ9YJccnH0vEpfxBulwRTrXE0+ESPfhraNheTg4zxrwlX
   pL5SXt9dYsF7mbr1CFaXtj8dPhtG/swEl+HDlGfFB865M34mEIzgM/aEB
   DbsockZt9D3cKx11Li7V8zHCqQJ1NIVvOKzl8XBidN1Kub/q/XAOOyt+X
   9FlEBrtj3KaFNHA2BpYq+vMbTdKwdYa6lgYAAOugCV653hVbNg4LJbI+I
   ufLojZVyfh3Br76LK2mV5u1ThLbdiVVqvkXkSAoIoC+BVmI6ipZafevnw
   K/jH2v3kMMQQ1LFkGoDkKFCIv6AqoJWyMPTJkx7bm3pxOL3RwqGud8kfI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876154"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876154"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281207"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:41 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 16/21] kvm: x86: Add CPUID support for Intel AMX
Date:   Wed, 29 Dec 2021 05:13:23 -0800
Message-Id: <20211229131328.12283-17-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

Extend CPUID emulation to support XFD, AMX_TILE, AMX_INT8 and
AMX_BF16. Adding those bits into kvm_cpu_caps finally activates all
previous logics in this series.

Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/cpufeatures.h |  2 ++
 arch/x86/kvm/cpuid.c               | 25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d5b5f2ab87a0..da872b6f8d8b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -299,7 +299,9 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
 #define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index acbc10db550e..bce514637703 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -525,7 +525,8 @@ void kvm_set_cpu_caps(void)
 		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
 		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP) |
 		F(MD_CLEAR) | F(AVX512_VP2INTERSECT) | F(FSRM) |
-		F(SERIALIZE) | F(TSXLDTRK) | F(AVX512_FP16)
+		F(SERIALIZE) | F(TSXLDTRK) | F(AVX512_FP16) |
+		F(AMX_TILE) | F(AMX_INT8) | F(AMX_BF16)
 	);
 
 	/* TSC_ADJUST and ARCH_CAPABILITIES are emulated in software. */
@@ -544,7 +545,7 @@ void kvm_set_cpu_caps(void)
 	);
 
 	kvm_cpu_cap_mask(CPUID_D_1_EAX,
-		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES)
+		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) | F(XFD)
 	);
 
 	kvm_cpu_cap_init_scattered(CPUID_12_EAX,
@@ -670,6 +671,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
 	case 0x14:
 	case 0x17:
 	case 0x18:
+	case 0x1d:
+	case 0x1e:
 	case 0x1f:
 	case 0x8000001d:
 		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
@@ -942,6 +945,24 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 				goto out;
 		}
 		break;
+	/* Intel AMX TILE */
+	case 0x1d:
+		if (!kvm_cpu_cap_has(X86_FEATURE_AMX_TILE)) {
+			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+			break;
+		}
+
+		for (i = 1, max_idx = entry->eax; i <= max_idx; ++i) {
+			if (!do_host_cpuid(array, function, i))
+				goto out;
+		}
+		break;
+	case 0x1e: /* TMUL information */
+		if (!kvm_cpu_cap_has(X86_FEATURE_AMX_TILE)) {
+			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+			break;
+		}
+		break;
 	case KVM_CPUID_SIGNATURE: {
 		const u32 *sigptr = (const u32 *)KVM_SIGNATURE;
 		entry->eax = KVM_CPUID_FEATURES;
