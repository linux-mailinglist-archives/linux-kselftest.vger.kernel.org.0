Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8F71011C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 04:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfKSDNW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 22:13:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:21265 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfKSDNA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 22:13:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 19:12:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="218105701"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2019 19:12:41 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v3 01/19] x86/msr-index: Clean up bit defines for IA32_FEATURE_CONTROL MSR
Date:   Mon, 18 Nov 2019 19:12:22 -0800
Message-Id: <20191119031240.7779-2-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119031240.7779-1-sean.j.christopherson@intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As pointed out by Boris, the defines for bits in IA32_FEATURE_CONTROL
are quite a mouthful, especially the VMX bits which must differentiate
between enabling VMX inside and outside SMX (TXT) operation.  Rename the
bit defines to abbreviate FEATURE_CONTROL as FEAT_CTL so that they're a
little friendlier on the eyes.  Keep the full name for the MSR itself to
help even the most obtuse reader decipher the abbreviation, and to match
the name used by the Intel SDM.

Opportunistically fix a few other annoyances with the defines:

  - Relocate the bit defines so that they immediately follow the MSR
    define, e.g. aren't mistaken as belonging to MISC_FEATURE_CONTROL.
  - Add whitespace around the block of feature control defines to make
    it clear that FEAT_CTL is indeed short for FEATURE_CONTROL.
  - Use BIT() instead of manually encoding the bit shift.
  - Use "VMX" instead of "VMXON" to match the SDM.
  - Append "_ENABLED" to the LMCE bit to be consistent with the verbiage
    used for all other feature control bits.  (LCME is an acronym for
    Local Machine Check Exception, i.e. LMCE_ENABLED is not redundant).

Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/msr-index.h | 11 ++++++-----
 arch/x86/kernel/cpu/mce/intel.c  |  4 ++--
 arch/x86/kvm/vmx/nested.c        |  4 ++--
 arch/x86/kvm/vmx/vmx.c           | 32 ++++++++++++++++----------------
 arch/x86/kvm/vmx/vmx.h           |  2 +-
 5 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6a3124664289..4c80d530f751 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -556,7 +556,13 @@
 #define MSR_IA32_EBL_CR_POWERON		0x0000002a
 #define MSR_EBC_FREQUENCY_ID		0x0000002c
 #define MSR_SMI_COUNT			0x00000034
+
 #define MSR_IA32_FEATURE_CONTROL        0x0000003a
+#define FEAT_CTL_LOCKED				BIT(0)
+#define FEAT_CTL_VMX_ENABLED_INSIDE_SMX		BIT(1)
+#define FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX	BIT(2)
+#define FEAT_CTL_LMCE_ENABLED			BIT(20)
+
 #define MSR_IA32_TSC_ADJUST             0x0000003b
 #define MSR_IA32_BNDCFGS		0x00000d90
 
@@ -564,11 +570,6 @@
 
 #define MSR_IA32_XSS			0x00000da0
 
-#define FEATURE_CONTROL_LOCKED				(1<<0)
-#define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
-#define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
-#define FEATURE_CONTROL_LMCE				(1<<20)
-
 #define MSR_IA32_APICBASE		0x0000001b
 #define MSR_IA32_APICBASE_BSP		(1<<8)
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index e270d0770134..3e5b29acd301 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -119,8 +119,8 @@ static bool lmce_supported(void)
 	 * generate a #GP fault.
 	 */
 	rdmsrl(MSR_IA32_FEATURE_CONTROL, tmp);
-	if ((tmp & (FEATURE_CONTROL_LOCKED | FEATURE_CONTROL_LMCE)) ==
-		   (FEATURE_CONTROL_LOCKED | FEATURE_CONTROL_LMCE))
+	if ((tmp & (FEAT_CTL_LOCKED | FEAT_CTL_LMCE_ENABLED)) ==
+		   (FEAT_CTL_LOCKED | FEAT_CTL_LMCE_ENABLED))
 		return true;
 
 	return false;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0e7c9301fe86..5737a94a4305 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4434,8 +4434,8 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 	gpa_t vmptr;
 	uint32_t revision;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
-		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+	const u64 VMXON_NEEDED_FEATURES = FEAT_CTL_LOCKED
+		| FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
 
 	/*
 	 * The Intel VMX Instruction Reference lists a bunch of bits that are
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b83ff2030adc..a8e2c3b74daa 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1806,7 +1806,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_MCG_EXT_CTL:
 		if (!msr_info->host_initiated &&
 		    !(vmx->msr_ia32_feature_control &
-		      FEATURE_CONTROL_LMCE))
+		      FEAT_CTL_LMCE_ENABLED))
 			return 1;
 		msr_info->data = vcpu->arch.mcg_ext_ctl;
 		break;
@@ -2041,7 +2041,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_MCG_EXT_CTL:
 		if ((!msr_info->host_initiated &&
 		     !(to_vmx(vcpu)->msr_ia32_feature_control &
-		       FEATURE_CONTROL_LMCE)) ||
+		       FEAT_CTL_LMCE_ENABLED)) ||
 		    (data & ~MCG_EXT_CTL_LMCE_EN))
 			return 1;
 		vcpu->arch.mcg_ext_ctl = data;
@@ -2049,7 +2049,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_FEATURE_CONTROL:
 		if (!vmx_feature_control_msr_valid(vcpu, data) ||
 		    (to_vmx(vcpu)->msr_ia32_feature_control &
-		     FEATURE_CONTROL_LOCKED && !msr_info->host_initiated))
+		     FEAT_CTL_LOCKED && !msr_info->host_initiated))
 			return 1;
 		vmx->msr_ia32_feature_control = data;
 		if (msr_info->host_initiated && data == 0)
@@ -2195,21 +2195,21 @@ static __init int vmx_disabled_by_bios(void)
 	u64 msr;
 
 	rdmsrl(MSR_IA32_FEATURE_CONTROL, msr);
-	if (msr & FEATURE_CONTROL_LOCKED) {
+	if (msr & FEAT_CTL_LOCKED) {
 		/* launched w/ TXT and VMX disabled */
-		if (!(msr & FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX)
+		if (!(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)
 			&& tboot_enabled())
 			return 1;
 		/* launched w/o TXT and VMX only enabled w/ TXT */
-		if (!(msr & FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX)
-			&& (msr & FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX)
+		if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX)
+			&& (msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)
 			&& !tboot_enabled()) {
 			printk(KERN_WARNING "kvm: disable TXT in the BIOS or "
 				"activate TXT before enabling KVM\n");
 			return 1;
 		}
 		/* launched w/o TXT and VMX disabled */
-		if (!(msr & FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX)
+		if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX)
 			&& !tboot_enabled())
 			return 1;
 	}
@@ -2259,10 +2259,10 @@ static int hardware_enable(void)
 
 	rdmsrl(MSR_IA32_FEATURE_CONTROL, old);
 
-	test_bits = FEATURE_CONTROL_LOCKED;
-	test_bits |= FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+	test_bits = FEAT_CTL_LOCKED;
+	test_bits |= FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
 	if (tboot_enabled())
-		test_bits |= FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX;
+		test_bits |= FEAT_CTL_VMX_ENABLED_INSIDE_SMX;
 
 	if ((old & test_bits) != test_bits) {
 		/* enable and lock */
@@ -6793,7 +6793,7 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = -1ull;
 
-	vmx->msr_ia32_feature_control_valid_bits = FEATURE_CONTROL_LOCKED;
+	vmx->msr_ia32_feature_control_valid_bits = FEAT_CTL_LOCKED;
 
 	/*
 	 * Enforce invariant: pi_desc.nv is always either POSTED_INTR_VECTOR
@@ -7089,10 +7089,10 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 
 	if (nested_vmx_allowed(vcpu))
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits |=
-			FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+			FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
 	else
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits &=
-			~FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+			~FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
 
 	if (nested_vmx_allowed(vcpu)) {
 		nested_vmx_cr_fixed1_bits_update(vcpu);
@@ -7502,10 +7502,10 @@ static void vmx_setup_mce(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.mcg_cap & MCG_LMCE_P)
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits |=
-			FEATURE_CONTROL_LMCE;
+			FEAT_CTL_LMCE_ENABLED;
 	else
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits &=
-			~FEATURE_CONTROL_LMCE;
+			~FEAT_CTL_LMCE_ENABLED;
 }
 
 static int vmx_smi_allowed(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 5a0f34b1e226..2b138fe7951a 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -276,7 +276,7 @@ struct vcpu_vmx {
 
 	/*
 	 * Only bits masked by msr_ia32_feature_control_valid_bits can be set in
-	 * msr_ia32_feature_control. FEATURE_CONTROL_LOCKED is always included
+	 * msr_ia32_feature_control. FEAT_CTL_LOCKED is always included
 	 * in msr_ia32_feature_control_valid_bits.
 	 */
 	u64 msr_ia32_feature_control;
-- 
2.24.0

