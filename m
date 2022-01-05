Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847E14852A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiAEMgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:6474 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240125AbiAEMgL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386171; x=1672922171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MiEkpbwnr9QTnGUVPC2AmMPRWnP8+VY4S3dyXYzzM7g=;
  b=nezc3YGw1X9l9SUC4tlDFmj2yFBJ2wsw7bd+EeGzQqM97btUobfnv5o5
   WcfelHKbTfaFsP3Wt8sbRN7qGEMph/1td6QdO0sbJb7vmfICDOh3Ih8nq
   ltudE7BmLUCTNPWkjK3cUtngJM7/3fqZTp6yEF73bfRNHEwxkrH89v0Gu
   FdkrpT8ia2ryIZ94u4pft4I3tEN6PynO9HeAUXxw08XxQ4wilKx8m6nG+
   zAnHC2UUjPk0y3ndypQXfZj4aZyk1ZFVlO5JWrn7DFVng08HojgNf87Hw
   PFjn+cviRJH5nPCdBGoA9eEySwIwMbJorDLtp6wQphEwgHkZrVAlvqvyu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249387"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249387"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004880"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:41 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 16/21] kvm: x86: Add CPUID support for Intel AMX
Date:   Wed,  5 Jan 2022 04:35:27 -0800
Message-Id: <20220105123532.12586-17-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

Extend CPUID emulation to support XFD, AMX_TILE, AMX_INT8 and
AMX_BF16. Adding those bits into kvm_cpu_caps finally activates all
previous logics in this series.

Hide XFD on 32bit host kernels. Otherwise it leads to a weird situation
where KVM tells userspace to migrate MSR_IA32_XFD and then rejects
attempts to read/write the MSR.

Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/cpufeatures.h |  2 ++
 arch/x86/kvm/cpuid.c               | 27 +++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

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
index a0fedf1514ab..ba4c3d5d2386 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -442,9 +442,11 @@ void kvm_set_cpu_caps(void)
 #ifdef CONFIG_X86_64
 	unsigned int f_gbpages = F(GBPAGES);
 	unsigned int f_lm = F(LM);
+	unsigned int f_xfd = F(XFD);
 #else
 	unsigned int f_gbpages = 0;
 	unsigned int f_lm = 0;
+	unsigned int f_xfd = 0;
 #endif
 	memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));
 
@@ -512,7 +514,8 @@ void kvm_set_cpu_caps(void)
 		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
 		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP) |
 		F(MD_CLEAR) | F(AVX512_VP2INTERSECT) | F(FSRM) |
-		F(SERIALIZE) | F(TSXLDTRK) | F(AVX512_FP16)
+		F(SERIALIZE) | F(TSXLDTRK) | F(AVX512_FP16) |
+		F(AMX_TILE) | F(AMX_INT8) | F(AMX_BF16)
 	);
 
 	/* TSC_ADJUST and ARCH_CAPABILITIES are emulated in software. */
@@ -531,7 +534,7 @@ void kvm_set_cpu_caps(void)
 	);
 
 	kvm_cpu_cap_mask(CPUID_D_1_EAX,
-		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES)
+		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) | f_xfd
 	);
 
 	kvm_cpu_cap_init_scattered(CPUID_12_EAX,
@@ -657,6 +660,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
 	case 0x14:
 	case 0x17:
 	case 0x18:
+	case 0x1d:
+	case 0x1e:
 	case 0x1f:
 	case 0x8000001d:
 		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
@@ -929,6 +934,24 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
