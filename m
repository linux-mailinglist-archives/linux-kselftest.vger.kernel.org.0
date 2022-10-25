Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB12260CC1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiJYMms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiJYMmj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35D618C431
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666701757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6mk7l7TEcSmMlQlt2X6+supC9mE0OUP3ip+KZCOd0UQ=;
        b=TA2AYfBFcOffYghsaRnmFDFWrPCfEkn3xoV3W5vcGW0qll5MP40bEW816tq8+sGaZrPD6B
        76CExVrWvFzIAFM5B4wRkNodZGzNEOOZoKQFHOteEbjIghIDd/flk/CBbwMIoFV5y14SL4
        PnmsUEwNBk5aPV6QucRgFJYBdumTS+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-LT4vJzZ4OnqmljNv6q7EoQ-1; Tue, 25 Oct 2022 08:42:32 -0400
X-MC-Unique: LT4vJzZ4OnqmljNv6q7EoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89094858F17;
        Tue, 25 Oct 2022 12:42:31 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36FBD20290A2;
        Tue, 25 Oct 2022 12:42:28 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Yang Zhong <yang.zhong@intel.com>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Guang Zeng <guang.zeng@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Wei Wang <wei.w.wang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v4 01/23] KVM: x86: start moving SMM-related functions to new files
Date:   Tue, 25 Oct 2022 15:42:01 +0300
Message-Id: <20221025124223.227577-2-mlevitsk@redhat.com>
In-Reply-To: <20221025124223.227577-1-mlevitsk@redhat.com>
References: <20221025124223.227577-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Create a new header and source with code related to system management
mode emulation.  Entry and exit will move there too; for now,
opportunistically rename put_smstate to PUT_SMSTATE while moving
it to smm.h, and adjust the SMM state saving code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |   6 --
 arch/x86/kvm/Makefile           |   1 +
 arch/x86/kvm/emulate.c          |   1 +
 arch/x86/kvm/kvm_cache_regs.h   |   5 --
 arch/x86/kvm/lapic.c            |  14 ++-
 arch/x86/kvm/lapic.h            |   7 +-
 arch/x86/kvm/mmu/mmu.c          |   1 +
 arch/x86/kvm/smm.c              |  37 ++++++++
 arch/x86/kvm/smm.h              |  25 ++++++
 arch/x86/kvm/svm/nested.c       |   1 +
 arch/x86/kvm/svm/svm.c          |   5 +-
 arch/x86/kvm/vmx/nested.c       |   1 +
 arch/x86/kvm/vmx/vmx.c          |   1 +
 arch/x86/kvm/x86.c              | 148 ++++++++++++--------------------
 14 files changed, 138 insertions(+), 115 deletions(-)
 create mode 100644 arch/x86/kvm/smm.c
 create mode 100644 arch/x86/kvm/smm.h

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7551b6f9c31c52..af9798681f88a1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2084,12 +2084,6 @@ static inline int kvm_cpu_get_apicid(int mps_cpu)
 #endif
 }
 
-#define put_smstate(type, buf, offset, val)                      \
-	*(type *)((buf) + (offset) - 0x7e00) = val
-
-#define GET_SMSTATE(type, buf, offset)		\
-	(*(type *)((buf) + (offset) - 0x7e00))
-
 int kvm_cpu_dirty_log_size(void);
 
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 30f244b6452349..ec6f7656254b9f 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -20,6 +20,7 @@ endif
 
 kvm-$(CONFIG_X86_64) += mmu/tdp_iter.o mmu/tdp_mmu.o
 kvm-$(CONFIG_KVM_XEN)	+= xen.o
+kvm-y			+= smm.o
 
 kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
 			   vmx/evmcs.o vmx/nested.o vmx/posted_intr.o
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 3b27622d46425b..de09660a61e522 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -30,6 +30,7 @@
 #include "tss.h"
 #include "mmu.h"
 #include "pmu.h"
+#include "smm.h"
 
 /*
  * Operand types
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 3febc342360cc7..c09174f73a344f 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -200,9 +200,4 @@ static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
 	return vcpu->arch.hflags & HF_GUEST_MASK;
 }
 
-static inline bool is_smm(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.hflags & HF_SMM_MASK;
-}
-
 #endif
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d7639d126e6c7a..e636d8c681f4bb 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -42,6 +42,7 @@
 #include "x86.h"
 #include "cpuid.h"
 #include "hyperv.h"
+#include "smm.h"
 
 #ifndef CONFIG_X86_64
 #define mod_64(x, y) ((x) - (y) * div64_u64(x, y))
@@ -1170,9 +1171,10 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 		break;
 
 	case APIC_DM_SMI:
-		result = 1;
-		kvm_make_request(KVM_REQ_SMI, vcpu);
-		kvm_vcpu_kick(vcpu);
+		if (!kvm_inject_smi(vcpu)) {
+			kvm_vcpu_kick(vcpu);
+			result = 1;
+		}
 		break;
 
 	case APIC_DM_NMI:
@@ -3020,6 +3022,12 @@ int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len)
 	return 0;
 }
 
+bool kvm_apic_init_sipi_allowed(struct kvm_vcpu *vcpu)
+{
+	return !is_smm(vcpu) &&
+	       !static_call(kvm_x86_apic_init_signal_blocked)(vcpu);
+}
+
 int kvm_apic_accept_events(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index a5ac4a5a517920..cb7e68c93e1a23 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -7,7 +7,6 @@
 #include <linux/kvm_host.h>
 
 #include "hyperv.h"
-#include "kvm_cache_regs.h"
 
 #define KVM_APIC_INIT		0
 #define KVM_APIC_SIPI		1
@@ -229,11 +228,7 @@ static inline bool kvm_apic_has_pending_init_or_sipi(struct kvm_vcpu *vcpu)
 	return lapic_in_kernel(vcpu) && vcpu->arch.apic->pending_events;
 }
 
-static inline bool kvm_apic_init_sipi_allowed(struct kvm_vcpu *vcpu)
-{
-	return !is_smm(vcpu) &&
-	       !static_call(kvm_x86_apic_init_signal_blocked)(vcpu);
-}
+bool kvm_apic_init_sipi_allowed(struct kvm_vcpu *vcpu);
 
 static inline bool kvm_lowest_prio_delivery(struct kvm_lapic_irq *irq)
 {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6f81539061d648..6a30d67fadb4d6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -22,6 +22,7 @@
 #include "tdp_mmu.h"
 #include "x86.h"
 #include "kvm_cache_regs.h"
+#include "smm.h"
 #include "kvm_emulate.h"
 #include "cpuid.h"
 #include "spte.h"
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
new file mode 100644
index 00000000000000..b91c48d91f6ed9
--- /dev/null
+++ b/arch/x86/kvm/smm.c
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/kvm_host.h>
+#include "x86.h"
+#include "kvm_cache_regs.h"
+#include "kvm_emulate.h"
+#include "smm.h"
+#include "trace.h"
+
+void kvm_smm_changed(struct kvm_vcpu *vcpu, bool entering_smm)
+{
+	trace_kvm_smm_transition(vcpu->vcpu_id, vcpu->arch.smbase, entering_smm);
+
+	if (entering_smm) {
+		vcpu->arch.hflags |= HF_SMM_MASK;
+	} else {
+		vcpu->arch.hflags &= ~(HF_SMM_MASK | HF_SMM_INSIDE_NMI_MASK);
+
+		/* Process a latched INIT or SMI, if any.  */
+		kvm_make_request(KVM_REQ_EVENT, vcpu);
+
+		/*
+		 * Even if KVM_SET_SREGS2 loaded PDPTRs out of band,
+		 * on SMM exit we still need to reload them from
+		 * guest memory
+		 */
+		vcpu->arch.pdptrs_from_userspace = false;
+	}
+
+	kvm_mmu_reset_context(vcpu);
+}
+
+void process_smi(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.smi_pending = true;
+	kvm_make_request(KVM_REQ_EVENT, vcpu);
+}
diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
new file mode 100644
index 00000000000000..d85d4ccd32dd13
--- /dev/null
+++ b/arch/x86/kvm/smm.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ASM_KVM_SMM_H
+#define ASM_KVM_SMM_H
+
+#define GET_SMSTATE(type, buf, offset)		\
+	(*(type *)((buf) + (offset) - 0x7e00))
+
+#define PUT_SMSTATE(type, buf, offset, val)                      \
+	*(type *)((buf) + (offset) - 0x7e00) = val
+
+static inline int kvm_inject_smi(struct kvm_vcpu *vcpu)
+{
+	kvm_make_request(KVM_REQ_SMI, vcpu);
+	return 0;
+}
+
+static inline bool is_smm(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.hflags & HF_SMM_MASK;
+}
+
+void kvm_smm_changed(struct kvm_vcpu *vcpu, bool in_smm);
+void process_smi(struct kvm_vcpu *vcpu);
+
+#endif
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 4c620999d230a5..cc0fd75f7cbab5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -25,6 +25,7 @@
 #include "trace.h"
 #include "mmu.h"
 #include "x86.h"
+#include "smm.h"
 #include "cpuid.h"
 #include "lapic.h"
 #include "svm.h"
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 58f0077d935799..496ee7d1ae2fb7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -6,6 +6,7 @@
 #include "mmu.h"
 #include "kvm_cache_regs.h"
 #include "x86.h"
+#include "smm.h"
 #include "cpuid.h"
 #include "pmu.h"
 
@@ -4442,9 +4443,9 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 		return 0;
 
 	/* FED8h - SVM Guest */
-	put_smstate(u64, smstate, 0x7ed8, 1);
+	PUT_SMSTATE(u64, smstate, 0x7ed8, 1);
 	/* FEE0h - SVM Guest VMCB Physical Address */
-	put_smstate(u64, smstate, 0x7ee0, svm->nested.vmcb12_gpa);
+	PUT_SMSTATE(u64, smstate, 0x7ee0, svm->nested.vmcb12_gpa);
 
 	svm->vmcb->save.rax = vcpu->arch.regs[VCPU_REGS_RAX];
 	svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8f67a9c4a28706..29215925e75b11 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -16,6 +16,7 @@
 #include "trace.h"
 #include "vmx.h"
 #include "x86.h"
+#include "smm.h"
 
 static bool __read_mostly enable_shadow_vmcs = 1;
 module_param_named(enable_shadow_vmcs, enable_shadow_vmcs, bool, S_IRUGO);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9dba04b6b019ac..038809c6800601 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -66,6 +66,7 @@
 #include "vmcs12.h"
 #include "vmx.h"
 #include "x86.h"
+#include "smm.h"
 
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4bd5f8a751de91..6a5cebf7250826 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -30,6 +30,7 @@
 #include "hyperv.h"
 #include "lapic.h"
 #include "xen.h"
+#include "smm.h"
 
 #include <linux/clocksource.h>
 #include <linux/interrupt.h>
@@ -119,7 +120,6 @@ static u64 __read_mostly cr4_reserved_bits = CR4_RESERVED_BITS;
 
 static void update_cr8_intercept(struct kvm_vcpu *vcpu);
 static void process_nmi(struct kvm_vcpu *vcpu);
-static void process_smi(struct kvm_vcpu *vcpu);
 static void enter_smm(struct kvm_vcpu *vcpu);
 static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 static void store_regs(struct kvm_vcpu *vcpu);
@@ -4896,13 +4896,6 @@ static int kvm_vcpu_ioctl_nmi(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int kvm_vcpu_ioctl_smi(struct kvm_vcpu *vcpu)
-{
-	kvm_make_request(KVM_REQ_SMI, vcpu);
-
-	return 0;
-}
-
 static int vcpu_ioctl_tpr_access_reporting(struct kvm_vcpu *vcpu,
 					   struct kvm_tpr_access_ctl *tac)
 {
@@ -5125,8 +5118,6 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
 	memset(&events->reserved, 0, sizeof(events->reserved));
 }
 
-static void kvm_smm_changed(struct kvm_vcpu *vcpu, bool entering_smm);
-
 static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 					      struct kvm_vcpu_events *events)
 {
@@ -5579,7 +5570,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_SMI: {
-		r = kvm_vcpu_ioctl_smi(vcpu);
+		r = kvm_inject_smi(vcpu);
 		break;
 	}
 	case KVM_SET_CPUID: {
@@ -8527,29 +8518,6 @@ static bool retry_instruction(struct x86_emulate_ctxt *ctxt,
 static int complete_emulated_mmio(struct kvm_vcpu *vcpu);
 static int complete_emulated_pio(struct kvm_vcpu *vcpu);
 
-static void kvm_smm_changed(struct kvm_vcpu *vcpu, bool entering_smm)
-{
-	trace_kvm_smm_transition(vcpu->vcpu_id, vcpu->arch.smbase, entering_smm);
-
-	if (entering_smm) {
-		vcpu->arch.hflags |= HF_SMM_MASK;
-	} else {
-		vcpu->arch.hflags &= ~(HF_SMM_MASK | HF_SMM_INSIDE_NMI_MASK);
-
-		/* Process a latched INIT or SMI, if any.  */
-		kvm_make_request(KVM_REQ_EVENT, vcpu);
-
-		/*
-		 * Even if KVM_SET_SREGS2 loaded PDPTRs out of band,
-		 * on SMM exit we still need to reload them from
-		 * guest memory
-		 */
-		vcpu->arch.pdptrs_from_userspace = false;
-	}
-
-	kvm_mmu_reset_context(vcpu);
-}
-
 static int kvm_vcpu_check_hw_bp(unsigned long addr, u32 type, u32 dr7,
 				unsigned long *db)
 {
@@ -10033,16 +10001,16 @@ static void enter_smm_save_seg_32(struct kvm_vcpu *vcpu, char *buf, int n)
 	int offset;
 
 	kvm_get_segment(vcpu, &seg, n);
-	put_smstate(u32, buf, 0x7fa8 + n * 4, seg.selector);
+	PUT_SMSTATE(u32, buf, 0x7fa8 + n * 4, seg.selector);
 
 	if (n < 3)
 		offset = 0x7f84 + n * 12;
 	else
 		offset = 0x7f2c + (n - 3) * 12;
 
-	put_smstate(u32, buf, offset + 8, seg.base);
-	put_smstate(u32, buf, offset + 4, seg.limit);
-	put_smstate(u32, buf, offset, enter_smm_get_segment_flags(&seg));
+	PUT_SMSTATE(u32, buf, offset + 8, seg.base);
+	PUT_SMSTATE(u32, buf, offset + 4, seg.limit);
+	PUT_SMSTATE(u32, buf, offset, enter_smm_get_segment_flags(&seg));
 }
 
 #ifdef CONFIG_X86_64
@@ -10056,10 +10024,10 @@ static void enter_smm_save_seg_64(struct kvm_vcpu *vcpu, char *buf, int n)
 	offset = 0x7e00 + n * 16;
 
 	flags = enter_smm_get_segment_flags(&seg) >> 8;
-	put_smstate(u16, buf, offset, seg.selector);
-	put_smstate(u16, buf, offset + 2, flags);
-	put_smstate(u32, buf, offset + 4, seg.limit);
-	put_smstate(u64, buf, offset + 8, seg.base);
+	PUT_SMSTATE(u16, buf, offset, seg.selector);
+	PUT_SMSTATE(u16, buf, offset + 2, flags);
+	PUT_SMSTATE(u32, buf, offset + 4, seg.limit);
+	PUT_SMSTATE(u64, buf, offset + 8, seg.base);
 }
 #endif
 
@@ -10070,47 +10038,47 @@ static void enter_smm_save_state_32(struct kvm_vcpu *vcpu, char *buf)
 	unsigned long val;
 	int i;
 
-	put_smstate(u32, buf, 0x7ffc, kvm_read_cr0(vcpu));
-	put_smstate(u32, buf, 0x7ff8, kvm_read_cr3(vcpu));
-	put_smstate(u32, buf, 0x7ff4, kvm_get_rflags(vcpu));
-	put_smstate(u32, buf, 0x7ff0, kvm_rip_read(vcpu));
+	PUT_SMSTATE(u32, buf, 0x7ffc, kvm_read_cr0(vcpu));
+	PUT_SMSTATE(u32, buf, 0x7ff8, kvm_read_cr3(vcpu));
+	PUT_SMSTATE(u32, buf, 0x7ff4, kvm_get_rflags(vcpu));
+	PUT_SMSTATE(u32, buf, 0x7ff0, kvm_rip_read(vcpu));
 
 	for (i = 0; i < 8; i++)
-		put_smstate(u32, buf, 0x7fd0 + i * 4, kvm_register_read_raw(vcpu, i));
+		PUT_SMSTATE(u32, buf, 0x7fd0 + i * 4, kvm_register_read_raw(vcpu, i));
 
 	kvm_get_dr(vcpu, 6, &val);
-	put_smstate(u32, buf, 0x7fcc, (u32)val);
+	PUT_SMSTATE(u32, buf, 0x7fcc, (u32)val);
 	kvm_get_dr(vcpu, 7, &val);
-	put_smstate(u32, buf, 0x7fc8, (u32)val);
+	PUT_SMSTATE(u32, buf, 0x7fc8, (u32)val);
 
 	kvm_get_segment(vcpu, &seg, VCPU_SREG_TR);
-	put_smstate(u32, buf, 0x7fc4, seg.selector);
-	put_smstate(u32, buf, 0x7f64, seg.base);
-	put_smstate(u32, buf, 0x7f60, seg.limit);
-	put_smstate(u32, buf, 0x7f5c, enter_smm_get_segment_flags(&seg));
+	PUT_SMSTATE(u32, buf, 0x7fc4, seg.selector);
+	PUT_SMSTATE(u32, buf, 0x7f64, seg.base);
+	PUT_SMSTATE(u32, buf, 0x7f60, seg.limit);
+	PUT_SMSTATE(u32, buf, 0x7f5c, enter_smm_get_segment_flags(&seg));
 
 	kvm_get_segment(vcpu, &seg, VCPU_SREG_LDTR);
-	put_smstate(u32, buf, 0x7fc0, seg.selector);
-	put_smstate(u32, buf, 0x7f80, seg.base);
-	put_smstate(u32, buf, 0x7f7c, seg.limit);
-	put_smstate(u32, buf, 0x7f78, enter_smm_get_segment_flags(&seg));
+	PUT_SMSTATE(u32, buf, 0x7fc0, seg.selector);
+	PUT_SMSTATE(u32, buf, 0x7f80, seg.base);
+	PUT_SMSTATE(u32, buf, 0x7f7c, seg.limit);
+	PUT_SMSTATE(u32, buf, 0x7f78, enter_smm_get_segment_flags(&seg));
 
 	static_call(kvm_x86_get_gdt)(vcpu, &dt);
-	put_smstate(u32, buf, 0x7f74, dt.address);
-	put_smstate(u32, buf, 0x7f70, dt.size);
+	PUT_SMSTATE(u32, buf, 0x7f74, dt.address);
+	PUT_SMSTATE(u32, buf, 0x7f70, dt.size);
 
 	static_call(kvm_x86_get_idt)(vcpu, &dt);
-	put_smstate(u32, buf, 0x7f58, dt.address);
-	put_smstate(u32, buf, 0x7f54, dt.size);
+	PUT_SMSTATE(u32, buf, 0x7f58, dt.address);
+	PUT_SMSTATE(u32, buf, 0x7f54, dt.size);
 
 	for (i = 0; i < 6; i++)
 		enter_smm_save_seg_32(vcpu, buf, i);
 
-	put_smstate(u32, buf, 0x7f14, kvm_read_cr4(vcpu));
+	PUT_SMSTATE(u32, buf, 0x7f14, kvm_read_cr4(vcpu));
 
 	/* revision id */
-	put_smstate(u32, buf, 0x7efc, 0x00020000);
-	put_smstate(u32, buf, 0x7ef8, vcpu->arch.smbase);
+	PUT_SMSTATE(u32, buf, 0x7efc, 0x00020000);
+	PUT_SMSTATE(u32, buf, 0x7ef8, vcpu->arch.smbase);
 }
 
 #ifdef CONFIG_X86_64
@@ -10122,46 +10090,46 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu, char *buf)
 	int i;
 
 	for (i = 0; i < 16; i++)
-		put_smstate(u64, buf, 0x7ff8 - i * 8, kvm_register_read_raw(vcpu, i));
+		PUT_SMSTATE(u64, buf, 0x7ff8 - i * 8, kvm_register_read_raw(vcpu, i));
 
-	put_smstate(u64, buf, 0x7f78, kvm_rip_read(vcpu));
-	put_smstate(u32, buf, 0x7f70, kvm_get_rflags(vcpu));
+	PUT_SMSTATE(u64, buf, 0x7f78, kvm_rip_read(vcpu));
+	PUT_SMSTATE(u32, buf, 0x7f70, kvm_get_rflags(vcpu));
 
 	kvm_get_dr(vcpu, 6, &val);
-	put_smstate(u64, buf, 0x7f68, val);
+	PUT_SMSTATE(u64, buf, 0x7f68, val);
 	kvm_get_dr(vcpu, 7, &val);
-	put_smstate(u64, buf, 0x7f60, val);
+	PUT_SMSTATE(u64, buf, 0x7f60, val);
 
-	put_smstate(u64, buf, 0x7f58, kvm_read_cr0(vcpu));
-	put_smstate(u64, buf, 0x7f50, kvm_read_cr3(vcpu));
-	put_smstate(u64, buf, 0x7f48, kvm_read_cr4(vcpu));
+	PUT_SMSTATE(u64, buf, 0x7f58, kvm_read_cr0(vcpu));
+	PUT_SMSTATE(u64, buf, 0x7f50, kvm_read_cr3(vcpu));
+	PUT_SMSTATE(u64, buf, 0x7f48, kvm_read_cr4(vcpu));
 
-	put_smstate(u32, buf, 0x7f00, vcpu->arch.smbase);
+	PUT_SMSTATE(u32, buf, 0x7f00, vcpu->arch.smbase);
 
 	/* revision id */
-	put_smstate(u32, buf, 0x7efc, 0x00020064);
+	PUT_SMSTATE(u32, buf, 0x7efc, 0x00020064);
 
-	put_smstate(u64, buf, 0x7ed0, vcpu->arch.efer);
+	PUT_SMSTATE(u64, buf, 0x7ed0, vcpu->arch.efer);
 
 	kvm_get_segment(vcpu, &seg, VCPU_SREG_TR);
-	put_smstate(u16, buf, 0x7e90, seg.selector);
-	put_smstate(u16, buf, 0x7e92, enter_smm_get_segment_flags(&seg) >> 8);
-	put_smstate(u32, buf, 0x7e94, seg.limit);
-	put_smstate(u64, buf, 0x7e98, seg.base);
+	PUT_SMSTATE(u16, buf, 0x7e90, seg.selector);
+	PUT_SMSTATE(u16, buf, 0x7e92, enter_smm_get_segment_flags(&seg) >> 8);
+	PUT_SMSTATE(u32, buf, 0x7e94, seg.limit);
+	PUT_SMSTATE(u64, buf, 0x7e98, seg.base);
 
 	static_call(kvm_x86_get_idt)(vcpu, &dt);
-	put_smstate(u32, buf, 0x7e84, dt.size);
-	put_smstate(u64, buf, 0x7e88, dt.address);
+	PUT_SMSTATE(u32, buf, 0x7e84, dt.size);
+	PUT_SMSTATE(u64, buf, 0x7e88, dt.address);
 
 	kvm_get_segment(vcpu, &seg, VCPU_SREG_LDTR);
-	put_smstate(u16, buf, 0x7e70, seg.selector);
-	put_smstate(u16, buf, 0x7e72, enter_smm_get_segment_flags(&seg) >> 8);
-	put_smstate(u32, buf, 0x7e74, seg.limit);
-	put_smstate(u64, buf, 0x7e78, seg.base);
+	PUT_SMSTATE(u16, buf, 0x7e70, seg.selector);
+	PUT_SMSTATE(u16, buf, 0x7e72, enter_smm_get_segment_flags(&seg) >> 8);
+	PUT_SMSTATE(u32, buf, 0x7e74, seg.limit);
+	PUT_SMSTATE(u64, buf, 0x7e78, seg.base);
 
 	static_call(kvm_x86_get_gdt)(vcpu, &dt);
-	put_smstate(u32, buf, 0x7e64, dt.size);
-	put_smstate(u64, buf, 0x7e68, dt.address);
+	PUT_SMSTATE(u32, buf, 0x7e64, dt.size);
+	PUT_SMSTATE(u64, buf, 0x7e68, dt.address);
 
 	for (i = 0; i < 6; i++)
 		enter_smm_save_seg_64(vcpu, buf, i);
@@ -10247,12 +10215,6 @@ static void enter_smm(struct kvm_vcpu *vcpu)
 	kvm_mmu_reset_context(vcpu);
 }
 
-static void process_smi(struct kvm_vcpu *vcpu)
-{
-	vcpu->arch.smi_pending = true;
-	kvm_make_request(KVM_REQ_EVENT, vcpu);
-}
-
 void kvm_make_scan_ioapic_request_mask(struct kvm *kvm,
 				       unsigned long *vcpu_bitmap)
 {
-- 
2.34.3

