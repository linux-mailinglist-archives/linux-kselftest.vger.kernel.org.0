Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D581FD514
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 21:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgFQTFM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 15:05:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:48978 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgFQTFL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 15:05:11 -0400
IronPort-SDR: MK/k9T2jFuVGb8gOOuAaAbdDc/VOCgrgjQmyZuycVOMFQTq6NbwC4CdSj0Y5ys1359UX2JtShy
 KTnPw1U4GEcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 12:05:09 -0700
IronPort-SDR: jsScCobBAxNj1+5VqD2s0okJHLATdhpgHIK+77640LR3Z49+tPFiJIh8n9cZE5wcdhDqg4mYTy
 E/N03xO2s5tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="273609635"
Received: from gza.jf.intel.com ([10.54.75.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2020 12:05:09 -0700
From:   John Andersen <john.s.andersen@intel.com>
To:     corbet@lwn.net, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, sean.j.christopherson@intel.com,
        liran.alon@oracle.com, drjones@redhat.com,
        rick.p.edgecombe@intel.com, kristen@linux.intel.com
Cc:     vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, mchehab+huawei@kernel.org,
        gregkh@linuxfoundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com,
        mike.kravetz@oracle.com, oneukum@suse.com, luto@kernel.org,
        peterz@infradead.org, fenghua.yu@intel.com,
        reinette.chatre@intel.com, vineela.tummalapalli@intel.com,
        dave.hansen@linux.intel.com, john.s.andersen@intel.com,
        arjan@linux.intel.com, caoj.fnst@cn.fujitsu.com, bhe@redhat.com,
        nivedita@alum.mit.edu, keescook@chromium.org,
        dan.j.williams@intel.com, eric.auger@redhat.com,
        aaronlewis@google.com, peterx@redhat.com,
        makarandsonare@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 2/4] KVM: x86: Introduce paravirt feature CR0/CR4 pinning
Date:   Wed, 17 Jun 2020 12:07:55 -0700
Message-Id: <20200617190757.27081-3-john.s.andersen@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617190757.27081-1-john.s.andersen@intel.com>
References: <20200617190757.27081-1-john.s.andersen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a CR pin feature bit to the KVM cpuid. Add read only MSRs to KVM
which guests use to identify which bits they may request be pinned. Add
CR pinned MSRs to KVM. Allow guests to request that KVM pin certain
bits within control register 0 or 4 via the CR pinned MSRs. Writes to
the MSRs fail if they include bits which aren't allowed. Host userspace
may clear or modify pinned bits at any time. Once pinned bits are set,
the guest may pin additional allowed bits, but not clear any. Clear
pinning on vCPU reset.

In the event that the guest vCPU attempts to disable any of the pinned
bits, send that vCPU a general protection fault, and leave the register
unchanged. Clear pinning on vCPU reset to avoid faulting non-boot
CPUs when they are disabled and then re-enabled, which is done when
hibernating.

Pinning is not active when running in SMM. Entering SMM disables pinned
bits. Writes to control registers within SMM would therefore trigger
general protection faults if pinning was enforced. Upon exit from SMM,
SMRAM is modified to ensure the values of CR0/4 that will be restored
contain the correct values for pinned bits. CR0/4 values are then
restored from SMRAM as usual.

When running with nested virtualization, should pinned bits be cleared
from host VMCS / VMCB, on VM-Exit, they will be silently restored.

Should userspace expose the CR pinning CPUID feature bit, it must zero
CR pinned MSRs on reboot. If it does not, it runs the risk of having the
guest enable pinning and subsequently cause general protection faults on
next boot due to early boot code setting control registers to values
which do not contain the pinned bits. Userspace is responsible for
migrating the contents of the CR* pinned MSRs. If userspace fails to
migrate the MSRs the protection will no longer be active.

Pinning of sensitive CR bits has already been implemented to protect
against exploits directly calling native_write_cr*(). The current
protection cannot stop ROP attacks which jump directly to a MOV CR
instruction.

https://web.archive.org/web/20171029060939/http://www.blackbunny.io/linux-kernel-x86-64-bypass-smep-kaslr-kptr_restric/

Guests running with paravirtualized CR pinning can now be protected
against the use of ROP to disable CR bits. The same bits that are being
pinned natively may be pinned via the CR pinned MSRs. These bits are WP
in CR0, and SMEP, SMAP, and UMIP in CR4.

Other hypervisors such as HyperV have implemented similar protections
for Control Registers and MSRs; which security researchers have found
effective.

https://www.abatchy.com/2018/01/kernel-exploitation-4

Future work could implement similar MSRs to protect bits elsewhere, such
as MSRs. The NXE bit of the EFER MSR is a prime candidate.

Changes for QEMU are required to expose the CR pin cpuid feature bit. As
well as clear the MSRs on reboot and enable migration.

https://github.com/qemu/qemu/commit/1b26f03653669c97dd8729f9f59be561d68e2b2d
https://github.com/qemu/qemu/commit/3af36d57457892c3088ee88de759d4f258c159a7

Signed-off-by: John Andersen <john.s.andersen@intel.com>
---
 Documentation/virt/kvm/msr.rst       |  53 ++++++++++++++
 arch/x86/include/asm/kvm_host.h      |   7 ++
 arch/x86/include/uapi/asm/kvm_para.h |   7 ++
 arch/x86/kvm/cpuid.c                 |   3 +-
 arch/x86/kvm/emulate.c               |   3 +-
 arch/x86/kvm/kvm_emulate.h           |   2 +-
 arch/x86/kvm/svm/nested.c            |  11 ++-
 arch/x86/kvm/vmx/nested.c            |  10 ++-
 arch/x86/kvm/x86.c                   | 106 ++++++++++++++++++++++++++-
 9 files changed, 193 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/msr.rst b/Documentation/virt/kvm/msr.rst
index e37a14c323d2..9fa43c4a5895 100644
--- a/Documentation/virt/kvm/msr.rst
+++ b/Documentation/virt/kvm/msr.rst
@@ -376,3 +376,56 @@ data:
 	write '1' to bit 0 of the MSR, this causes the host to re-scan its queue
 	and check if there are more notifications pending. The MSR is available
 	if KVM_FEATURE_ASYNC_PF_INT is present in CPUID.
+
+MSR_KVM_CR0_PIN_ALLOWED:
+	0x4b564d08
+MSR_KVM_CR4_PIN_ALLOWED:
+	0x4b564d09
+
+	Read only registers informing the guest which bits may be pinned for
+	each control register respectively via the CR pinned MSRs.
+
+data:
+	Bits which may be pinned.
+
+	Attempting to pin bits other than these will result in a failure when
+	writing to the respective CR pinned MSR.
+
+	Bits which are allowed to be pinned are WP for CR0 and SMEP, SMAP, and
+	UMIP for CR4.
+
+MSR_KVM_CR0_PINNED_LOW:
+	0x4b564d0a
+MSR_KVM_CR0_PINNED_HIGH:
+	0x4b564d0b
+MSR_KVM_CR4_PINNED_LOW:
+	0x4b564d0c
+MSR_KVM_CR4_PINNED_HIGH:
+	0x4b564d0d
+
+	Used to configure pinned bits in control registers
+
+data:
+	Bits to be pinned.
+
+	Fails if data contains bits which are not allowed to be pinned. Or if
+	attempting to pin bits high that are already pinned low, or vice versa.
+	Bits which are allowed to be pinned can be found by reading the CR pin
+	allowed MSRs.
+
+	The MSRs are read/write for host userspace, and write-only for the
+	guest.
+
+	Once set to a non-zero value, the guest cannot clear any of the bits
+	that have been pinned. The guest can pin more bits, so long as those
+	bits appear in the allowed MSR, and are not already pinned to the
+	opposite value.
+
+	Host userspace may clear or change pinned bits at any point. Host
+	userspace must clear pinned bits on reboot.
+
+	The MSR enables bit pinning for control registers. Pinning is active
+	when the guest is not in SMM. If an exit from SMM results in pinned
+	bits becoming unpinned. The guest will exit. If the guest attempts to
+	write values to cr* where bits differ from pinned bits, the write will
+	fail and the guest will be sent a general protection fault.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f8998e97457f..962cb48535d4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -565,6 +565,11 @@ struct kvm_vcpu_hv {
 	cpumask_t tlb_flush;
 };
 
+struct kvm_vcpu_cr_pinning {
+	unsigned long high;
+	unsigned long low;
+};
+
 struct kvm_vcpu_arch {
 	/*
 	 * rip and regs accesses must go through
@@ -576,10 +581,12 @@ struct kvm_vcpu_arch {
 
 	unsigned long cr0;
 	unsigned long cr0_guest_owned_bits;
+	struct kvm_vcpu_cr_pinning cr0_pinned;
 	unsigned long cr2;
 	unsigned long cr3;
 	unsigned long cr4;
 	unsigned long cr4_guest_owned_bits;
+	struct kvm_vcpu_cr_pinning cr4_pinned;
 	unsigned long cr8;
 	u32 host_pkru;
 	u32 pkru;
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 812e9b4c1114..91241e0d9691 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -32,6 +32,7 @@
 #define KVM_FEATURE_POLL_CONTROL	12
 #define KVM_FEATURE_PV_SCHED_YIELD	13
 #define KVM_FEATURE_ASYNC_PF_INT	14
+#define KVM_FEATURE_CR_PIN		15
 
 #define KVM_HINTS_REALTIME      0
 
@@ -53,6 +54,12 @@
 #define MSR_KVM_POLL_CONTROL	0x4b564d05
 #define MSR_KVM_ASYNC_PF_INT	0x4b564d06
 #define MSR_KVM_ASYNC_PF_ACK	0x4b564d07
+#define MSR_KVM_CR0_PIN_ALLOWED	0x4b564d08
+#define MSR_KVM_CR4_PIN_ALLOWED	0x4b564d09
+#define MSR_KVM_CR0_PINNED_LOW	0x4b564d0a
+#define MSR_KVM_CR0_PINNED_HIGH	0x4b564d0b
+#define MSR_KVM_CR4_PINNED_LOW	0x4b564d0c
+#define MSR_KVM_CR4_PINNED_HIGH	0x4b564d0d
 
 struct kvm_steal_time {
 	__u64 steal;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8a294f9747aa..bb0ed645324d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -716,7 +716,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			     (1 << KVM_FEATURE_PV_SEND_IPI) |
 			     (1 << KVM_FEATURE_POLL_CONTROL) |
 			     (1 << KVM_FEATURE_PV_SCHED_YIELD) |
-			     (1 << KVM_FEATURE_ASYNC_PF_INT);
+			     (1 << KVM_FEATURE_ASYNC_PF_INT) |
+			     (1 << KVM_FEATURE_CR_PIN);
 
 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index d0e2825ae617..95780422765b 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2685,7 +2685,8 @@ static int em_rsm(struct x86_emulate_ctxt *ctxt)
 		return X86EMUL_UNHANDLEABLE;
 	}
 
-	ctxt->ops->post_leave_smm(ctxt);
+	if (ctxt->ops->post_leave_smm(ctxt))
+		return X86EMUL_UNHANDLEABLE;
 
 	return X86EMUL_CONTINUE;
 }
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 43c93ffa76ed..e92dd7605e48 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -232,7 +232,7 @@ struct x86_emulate_ops {
 	void (*set_hflags)(struct x86_emulate_ctxt *ctxt, unsigned hflags);
 	int (*pre_leave_smm)(struct x86_emulate_ctxt *ctxt,
 			     const char *smstate);
-	void (*post_leave_smm)(struct x86_emulate_ctxt *ctxt);
+	int (*post_leave_smm)(struct x86_emulate_ctxt *ctxt);
 	int (*set_xcr)(struct x86_emulate_ctxt *ctxt, u32 index, u64 xcr);
 };
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 6bceafb19108..245bdff4b052 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -583,8 +583,15 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	svm->vmcb->save.idtr = hsave->save.idtr;
 	kvm_set_rflags(&svm->vcpu, hsave->save.rflags);
 	svm_set_efer(&svm->vcpu, hsave->save.efer);
-	svm_set_cr0(&svm->vcpu, hsave->save.cr0 | X86_CR0_PE);
-	svm_set_cr4(&svm->vcpu, hsave->save.cr4);
+	svm_set_cr0(&svm->vcpu,
+		    (hsave->save.cr0 |
+		    X86_CR0_PE |
+		    svm->vcpu.arch.cr0_pinned.high) &
+		    ~svm->vcpu.arch.cr0_pinned.low);
+	svm_set_cr4(&svm->vcpu,
+		    (hsave->save.cr4 |
+		    svm->vcpu.arch.cr4_pinned.high) &
+		    ~svm->vcpu.arch.cr4_pinned.low);
 	if (npt_enabled) {
 		svm->vmcb->save.cr3 = hsave->save.cr3;
 		svm->vcpu.arch.cr3 = hsave->save.cr3;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index adb11b504d5c..a12bac57b374 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4110,11 +4110,17 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	 * (KVM doesn't change it);
 	 */
 	vcpu->arch.cr0_guest_owned_bits = X86_CR0_TS;
-	vmx_set_cr0(vcpu, vmcs12->host_cr0);
+	vmx_set_cr0(vcpu,
+		    (vmcs12->host_cr0 |
+		     vcpu->arch.cr0_pinned.high) &
+		    ~vcpu->arch.cr0_pinned.low);
 
 	/* Same as above - no reason to call set_cr4_guest_host_mask().  */
 	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
-	vmx_set_cr4(vcpu, vmcs12->host_cr4);
+	vmx_set_cr4(vcpu,
+		   (vmcs12->host_cr4 |
+		    vcpu->arch.cr4_pinned.high) &
+		    ~vcpu->arch.cr4_pinned.low);
 
 	nested_ept_uninit_mmu_context(vcpu);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 00c88c2f34e4..940de9a968bd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -772,6 +772,9 @@ bool pdptrs_changed(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(pdptrs_changed);
 
+#define KVM_CR0_PIN_ALLOWED	(X86_CR0_WP)
+#define KVM_CR4_PIN_ALLOWED	(X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP)
+
 int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	unsigned long old_cr0 = kvm_read_cr0(vcpu);
@@ -792,6 +795,11 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	if ((cr0 & X86_CR0_PG) && !(cr0 & X86_CR0_PE))
 		return 1;
 
+	if (!is_smm(vcpu) && !is_guest_mode(vcpu) &&
+	    (((cr0 ^ vcpu->arch.cr0_pinned.high) & vcpu->arch.cr0_pinned.high) ||
+	    ((~cr0 ^ vcpu->arch.cr0_pinned.low) & vcpu->arch.cr0_pinned.low)))
+		return 1;
+
 	if (!is_paging(vcpu) && (cr0 & X86_CR0_PG)) {
 #ifdef CONFIG_X86_64
 		if ((vcpu->arch.efer & EFER_LME)) {
@@ -972,6 +980,11 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	if (kvm_valid_cr4(vcpu, cr4))
 		return 1;
 
+	if (!is_smm(vcpu) && !is_guest_mode(vcpu) &&
+	    (((cr4 ^ vcpu->arch.cr4_pinned.high) & vcpu->arch.cr4_pinned.high) ||
+	    ((~cr4 ^ vcpu->arch.cr4_pinned.low) & vcpu->arch.cr4_pinned.low)))
+		return 1;
+
 	if (is_long_mode(vcpu)) {
 		if (!(cr4 & X86_CR4_PAE))
 			return 1;
@@ -1291,6 +1304,12 @@ static const u32 emulated_msrs_all[] = {
 
 	MSR_K7_HWCR,
 	MSR_KVM_POLL_CONTROL,
+	MSR_KVM_CR0_PIN_ALLOWED,
+	MSR_KVM_CR4_PIN_ALLOWED,
+	MSR_KVM_CR0_PINNED_LOW,
+	MSR_KVM_CR0_PINNED_HIGH,
+	MSR_KVM_CR4_PINNED_LOW,
+	MSR_KVM_CR4_PINNED_HIGH,
 };
 
 static u32 emulated_msrs[ARRAY_SIZE(emulated_msrs_all)];
@@ -2986,6 +3005,54 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vcpu->arch.msr_kvm_poll_control = data;
 		break;
 
+	case MSR_KVM_CR0_PIN_ALLOWED:
+		return (data != KVM_CR0_PIN_ALLOWED);
+	case MSR_KVM_CR4_PIN_ALLOWED:
+		return (data != KVM_CR4_PIN_ALLOWED);
+	case MSR_KVM_CR0_PINNED_LOW:
+		if ((data & ~KVM_CR0_PIN_ALLOWED) ||
+		    (data & vcpu->arch.cr0_pinned.high))
+			return 1;
+
+		if (!msr_info->host_initiated &&
+		    (~data & vcpu->arch.cr0_pinned.low))
+			return 1;
+
+		vcpu->arch.cr0_pinned.low = data;
+		break;
+	case MSR_KVM_CR0_PINNED_HIGH:
+		if ((data & ~KVM_CR0_PIN_ALLOWED) ||
+		    (data & vcpu->arch.cr0_pinned.low))
+			return 1;
+
+		if (!msr_info->host_initiated &&
+		    (~data & vcpu->arch.cr0_pinned.high))
+			return 1;
+
+		vcpu->arch.cr0_pinned.high = data;
+		break;
+	case MSR_KVM_CR4_PINNED_LOW:
+		if ((data & ~KVM_CR4_PIN_ALLOWED) ||
+		    (data & vcpu->arch.cr4_pinned.high))
+			return 1;
+
+		if (!msr_info->host_initiated &&
+		    (~data & vcpu->arch.cr4_pinned.low))
+			return 1;
+
+		vcpu->arch.cr4_pinned.low = data;
+		break;
+	case MSR_KVM_CR4_PINNED_HIGH:
+		if ((data & ~KVM_CR4_PIN_ALLOWED) ||
+		    (data & vcpu->arch.cr4_pinned.low))
+			return 1;
+
+		if (!msr_info->host_initiated &&
+		    (~data & vcpu->arch.cr4_pinned.high))
+			return 1;
+
+		vcpu->arch.cr4_pinned.high = data;
+		break;
 	case MSR_IA32_MCG_CTL:
 	case MSR_IA32_MCG_STATUS:
 	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
@@ -3250,6 +3317,24 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_KVM_POLL_CONTROL:
 		msr_info->data = vcpu->arch.msr_kvm_poll_control;
 		break;
+	case MSR_KVM_CR0_PIN_ALLOWED:
+		msr_info->data = KVM_CR0_PIN_ALLOWED;
+		break;
+	case MSR_KVM_CR4_PIN_ALLOWED:
+		msr_info->data = KVM_CR4_PIN_ALLOWED;
+		break;
+	case MSR_KVM_CR0_PINNED_LOW:
+		msr_info->data = vcpu->arch.cr0_pinned.low;
+		break;
+	case MSR_KVM_CR0_PINNED_HIGH:
+		msr_info->data = vcpu->arch.cr0_pinned.high;
+		break;
+	case MSR_KVM_CR4_PINNED_LOW:
+		msr_info->data = vcpu->arch.cr4_pinned.low;
+		break;
+	case MSR_KVM_CR4_PINNED_HIGH:
+		msr_info->data = vcpu->arch.cr4_pinned.high;
+		break;
 	case MSR_IA32_P5_MC_ADDR:
 	case MSR_IA32_P5_MC_TYPE:
 	case MSR_IA32_MCG_CAP:
@@ -6414,9 +6499,23 @@ static int emulator_pre_leave_smm(struct x86_emulate_ctxt *ctxt,
 	return kvm_x86_ops.pre_leave_smm(emul_to_vcpu(ctxt), smstate);
 }
 
-static void emulator_post_leave_smm(struct x86_emulate_ctxt *ctxt)
+static int emulator_post_leave_smm(struct x86_emulate_ctxt *ctxt)
 {
-	kvm_smm_changed(emul_to_vcpu(ctxt));
+	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+	unsigned long cr0 = kvm_read_cr0(vcpu);
+	unsigned long cr4 = kvm_read_cr4(vcpu);
+
+	if (((cr0 ^ vcpu->arch.cr0_pinned.high) & vcpu->arch.cr0_pinned.high) ||
+	    ((~cr0 ^ vcpu->arch.cr0_pinned.low) & vcpu->arch.cr0_pinned.low))
+		return 1;
+
+	if (((cr4 ^ vcpu->arch.cr4_pinned.high) & vcpu->arch.cr4_pinned.high) ||
+	    ((~cr4 ^ vcpu->arch.cr4_pinned.low) & vcpu->arch.cr4_pinned.low))
+		return 1;
+
+	kvm_smm_changed(vcpu);
+
+	return 0;
 }
 
 static int emulator_set_xcr(struct x86_emulate_ctxt *ctxt, u32 index, u64 xcr)
@@ -9640,6 +9739,9 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	vcpu->arch.ia32_xss = 0;
 
+	memset(&vcpu->arch.cr0_pinned, 0, sizeof(vcpu->arch.cr0_pinned));
+	memset(&vcpu->arch.cr4_pinned, 0, sizeof(vcpu->arch.cr4_pinned));
+
 	kvm_x86_ops.vcpu_reset(vcpu, init_event);
 }
 
-- 
2.21.0

