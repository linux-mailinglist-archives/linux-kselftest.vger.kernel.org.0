Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3955235230B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 00:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhDAW6n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Apr 2021 18:58:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:11537 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235767AbhDAW6j (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Apr 2021 18:58:39 -0400
IronPort-SDR: pzo4fIZ1nOyTZfVY/hs7vQp/+NnJUEyFEBBR7BG7XQbSLdsqdlPncgcZqhLS3ZcLWQM+cBvPp9
 521W2204pgmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="190117116"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="190117116"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:58:38 -0700
IronPort-SDR: /LAHeSDLYy7BAvnolYCZT1u8Y4SA5BtaY8kdH74hkqkQtSsM0InXJN+IdKDyyL1JWVpXiep5O9
 R/MmiwSZL07Q==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="611092368"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:58:37 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH V6 08/10] x86/entry: Preserve PKRS MSR across exceptions
Date:   Thu,  1 Apr 2021 15:58:31 -0700
Message-Id: <20210401225833.566238-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210401225833.566238-1-ira.weiny@intel.com>
References: <20210401225833.566238-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKRS MSR is not managed by XSAVE.  It is preserved through a context
switch but this support leaves exception handling code open to memory
accesses during exceptions.

2 possible places for preserving this state were considered,
irqentry_state_t or pt_regs.[1]  pt_regs was much more complicated and
was potentially fraught with unintended consequences.[2]  However, Andy
came up with a way to hide additional values on the stack which could be
accessed as "extended_pt_regs".[3]  This method allows for; any place
which has struct pt_regs can get access to the extra information; no
extra information is added to irq_state; and pt_regs is left intact for
compatibility with outside tools like BPF.

To simplify, the assembly code only adds space on the stack.  The
setting or use of any needed values are left to the C code.  While some
entry points may not use this space it is still added where ever pt_regs
is passed to the C code for consistency.

Each nested exception gets another copy of this extended space allowing
for any number of levels of exception handling.

In the assembly, a macro is defined to allow a central place to add
space for other uses should the need arise.

Finally export pkrs_{save_set|restore}_irq to the common code to allow
it to preserve the current task's PKRS in the new extended pt_regs if
enabled.

Peter, Thomas, Andy, Dave, and Dan all suggested parts of the patch or
aided in the development of the patch..

[1] https://lore.kernel.org/lkml/CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com/
[2] https://lore.kernel.org/lkml/874kpxx4jf.fsf@nanos.tec.linutronix.de/#t
[3] https://lore.kernel.org/lkml/CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com/

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V5:
	Dave Hansen
		Remove 'we' from comments

Changes from V4:
	Fix checkpatch errors

Changes from V3:
	Fix 0-day issues
	Move all extended regs stuff to pks.h
	From Dan Williams
		Move show_extended_regs_oops ifdefery to pks.h
		Remove a bad comment
		s/irq_save_set_pkrs/pkrs_save_set_irq
		s/irq_restore_pkrs/pkrs_restore_irq
		s/ARCH_HAS/ARCH_ENABLE_SUPERVISOR_PKEYS
	From Dave Hansen:
		remove extra macro parameter for most calls
		clarify with comments
		Add BUILD check for extend regs size
		use subq/addq vs push/pop
	From Dan Williams and Dave Hansen:
		Use a macro call to wrap the c function calls with
		push/pop extended_pt_regs
	From Dave Hansen:
		Guidance on where to find each of the pt_regs being
		passed to C code
	From Thomas Gleixner:
		Remove unnecessary noinstr's
	From Andy Lutomirski:
		Convert to using the extended pt_regs
		Add in showing pks on fault through the extended pt_regs

Changes from V1
	remove redundant irq_state->pkrs
		This value is only needed for the global tracking.  So
		it should be included in that patch and not in this one.

Changes from RFC V3
	Standardize on 'irq_state' variable name
	Per Dave Hansen
		irq_save_pkrs() -> irq_save_set_pkrs()
	Rebased based on clean up patch by Thomas Gleixner
		This includes moving irq_[save_set|restore]_pkrs() to
		the core as well.
---
 arch/x86/entry/calling.h               | 26 ++++++++++++
 arch/x86/entry/common.c                | 57 ++++++++++++++++++++++++++
 arch/x86/entry/entry_64.S              | 22 +++++-----
 arch/x86/entry/entry_64_compat.S       |  6 +--
 arch/x86/include/asm/pks.h             | 16 ++++++++
 arch/x86/include/asm/processor-flags.h |  2 +
 arch/x86/kernel/head_64.S              |  7 ++--
 arch/x86/mm/fault.c                    |  3 ++
 include/linux/pkeys.h                  | 17 ++++++++
 kernel/entry/common.c                  | 14 ++++++-
 10 files changed, 151 insertions(+), 19 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 07a9331d55e7..ec85f8f675be 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,6 +97,32 @@ For 32-bit we have the following conventions - kernel is built with
 
 #define SIZEOF_PTREGS	21*8
 
+/*
+ * __call_ext_ptregs - Helper macro to call into C with extended pt_regs
+ * @cfunc:		C function to be called
+ *
+ * This will ensure that extended_ptregs is added and removed as needed during
+ * a call into C code.
+ */
+.macro __call_ext_ptregs cfunc annotate_retpoline_safe:req
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+	/* add space for extended_pt_regs */
+	subq    $EXTENDED_PT_REGS_SIZE, %rsp
+#endif
+	.if \annotate_retpoline_safe == 1
+		ANNOTATE_RETPOLINE_SAFE
+	.endif
+	call	\cfunc
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+	/* remove space for extended_pt_regs */
+	addq    $EXTENDED_PT_REGS_SIZE, %rsp
+#endif
+.endm
+
+.macro call_ext_ptregs cfunc
+	__call_ext_ptregs \cfunc, annotate_retpoline_safe=0
+.endm
+
 .macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 4efd39aacb9f..239f01d710c5 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/pkeys.h>
 
 #ifdef CONFIG_XEN_PV
 #include <xen/xen-ops.h>
@@ -34,6 +35,7 @@
 #include <asm/io_bitmap.h>
 #include <asm/syscall.h>
 #include <asm/irq_stack.h>
+#include <asm/pks.h>
 
 #ifdef CONFIG_X86_64
 __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
@@ -214,6 +216,59 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+
+void show_extended_regs_oops(struct pt_regs *regs, unsigned long error_code)
+{
+	struct extended_pt_regs *ept_regs = extended_pt_regs(regs);
+
+	if (cpu_feature_enabled(X86_FEATURE_PKS) && (error_code & X86_PF_PK))
+		pr_alert("PKRS: 0x%x\n", ept_regs->thread_pkrs);
+}
+
+/*
+ * PKRS is a per-logical-processor MSR which overlays additional protection for
+ * pages which have been mapped with a protection key.
+ *
+ * The register is not maintained with XSAVE maintain the MSR value in software
+ * during context switch and exception handling.
+ *
+ * Context switches save the MSR in the task struct thus taking that value to
+ * other processors if necessary.
+ *
+ * To protect against exceptions having access to this memory save the current
+ * running value and set the PKRS value to be used during the exception.
+ */
+void pkrs_save_set_irq(struct pt_regs *regs, u32 val)
+{
+	struct extended_pt_regs *ept_regs;
+
+	BUILD_BUG_ON(sizeof(struct extended_pt_regs)
+			!= EXTENDED_PT_REGS_SIZE
+				+ sizeof(struct pt_regs));
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	ept_regs = extended_pt_regs(regs);
+	ept_regs->thread_pkrs = current->thread.saved_pkrs;
+	write_pkrs(val);
+}
+
+void pkrs_restore_irq(struct pt_regs *regs)
+{
+	struct extended_pt_regs *ept_regs;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	ept_regs = extended_pt_regs(regs);
+	write_pkrs(ept_regs->thread_pkrs);
+	current->thread.saved_pkrs = ept_regs->thread_pkrs;
+}
+
+#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
@@ -270,6 +325,8 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
+		/* Normally called by irqentry_exit, restore pkrs here */
+		pkrs_restore_irq(regs);
 		instrumentation_begin();
 		irqentry_exit_cond_resched();
 		instrumentation_end();
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 400908dff42e..d65952a18ad7 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -331,7 +331,7 @@ SYM_CODE_END(ret_from_fork)
 		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	.endif
 
-	call	\cfunc
+	call_ext_ptregs \cfunc
 
 	jmp	error_return
 .endm
@@ -434,7 +434,7 @@ SYM_CODE_START(\asmsym)
 
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
-	call	\cfunc
+	call_ext_ptregs \cfunc
 
 	jmp	paranoid_exit
 
@@ -495,7 +495,7 @@ SYM_CODE_START(\asmsym)
 	 * stack.
 	 */
 	movq	%rsp, %rdi		/* pt_regs pointer */
-	call	vc_switch_off_ist
+	call_ext_ptregs vc_switch_off_ist
 	movq	%rax, %rsp		/* Switch to new stack */
 
 	UNWIND_HINT_REGS
@@ -506,7 +506,7 @@ SYM_CODE_START(\asmsym)
 
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
-	call	\cfunc
+	call_ext_ptregs \cfunc
 
 	/*
 	 * No need to switch back to the IST stack. The current stack is either
@@ -541,7 +541,7 @@ SYM_CODE_START(\asmsym)
 	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
 	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-	call	\cfunc
+	call_ext_ptregs \cfunc
 
 	jmp	paranoid_exit
 
@@ -780,7 +780,7 @@ SYM_CODE_START_LOCAL(exc_xen_hypervisor_callback)
 	movq	%rdi, %rsp			/* we don't return, adjust the stack frame */
 	UNWIND_HINT_REGS
 
-	call	xen_pv_evtchn_do_upcall
+	call_ext_ptregs xen_pv_evtchn_do_upcall
 
 	jmp	error_return
 SYM_CODE_END(exc_xen_hypervisor_callback)
@@ -986,7 +986,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	/* Put us onto the real thread stack. */
 	popq	%r12				/* save return addr in %12 */
 	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
-	call	sync_regs
+	call_ext_ptregs sync_regs
 	movq	%rax, %rsp			/* switch stack */
 	ENCODE_FRAME_POINTER
 	pushq	%r12
@@ -1041,7 +1041,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * as if we faulted immediately after IRET.
 	 */
 	mov	%rsp, %rdi
-	call	fixup_bad_iret
+	call_ext_ptregs fixup_bad_iret
 	mov	%rax, %rsp
 	jmp	.Lerror_entry_from_usermode_after_swapgs
 SYM_CODE_END(error_entry)
@@ -1147,7 +1147,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
-	call	exc_nmi
+	call_ext_ptregs exc_nmi
 
 	/*
 	 * Return back to user mode.  We must *not* do the normal exit
@@ -1183,6 +1183,8 @@ SYM_CODE_START(asm_exc_nmi)
 	 * +---------------------------------------------------------+
 	 * | pt_regs                                                 |
 	 * +---------------------------------------------------------+
+	 * | (Optionally) extended_pt_regs                           |
+	 * +---------------------------------------------------------+
 	 *
 	 * The "original" frame is used by hardware.  Before re-enabling
 	 * NMIs, we need to be done with it, and we need to leave enough
@@ -1359,7 +1361,7 @@ end_repeat_nmi:
 
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
-	call	exc_nmi
+	call_ext_ptregs exc_nmi
 
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 0051cf5c792d..53254d29d5c7 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -136,7 +136,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 .Lsysenter_flags_fixed:
 
 	movq	%rsp, %rdi
-	call	do_SYSENTER_32
+	call_ext_ptregs do_SYSENTER_32
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
@@ -253,7 +253,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi
-	call	do_fast_syscall_32
+	call_ext_ptregs do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
@@ -410,6 +410,6 @@ SYM_CODE_START(entry_INT80_compat)
 	cld
 
 	movq	%rsp, %rdi
-	call	do_int80_syscall_32
+	call_ext_ptregs do_int80_syscall_32
 	jmp	swapgs_restore_regs_and_return_to_usermode
 SYM_CODE_END(entry_INT80_compat)
diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index 5d7067ada8fb..516d82f032b6 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -4,11 +4,27 @@
 
 #ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
 
+struct extended_pt_regs {
+	u32 thread_pkrs;
+	/* Keep stack 8 byte aligned */
+	u32 pad;
+	struct pt_regs pt_regs;
+};
+
 void setup_pks(void);
 
+static inline struct extended_pt_regs *extended_pt_regs(struct pt_regs *regs)
+{
+	return container_of(regs, struct extended_pt_regs, pt_regs);
+}
+
+void show_extended_regs_oops(struct pt_regs *regs, unsigned long error_code);
+
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
 static inline void setup_pks(void) { }
+static inline void show_extended_regs_oops(struct pt_regs *regs,
+					   unsigned long error_code) { }
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index 02c2cbda4a74..4a41fc4cf028 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -53,4 +53,6 @@
 # define X86_CR3_PTI_PCID_USER_BIT	11
 #endif
 
+#define EXTENDED_PT_REGS_SIZE 8
+
 #endif /* _ASM_X86_PROCESSOR_FLAGS_H */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 04bddaaba8e2..80531526b0d2 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -319,8 +319,7 @@ SYM_CODE_START_NOALIGN(vc_boot_ghcb)
 	movq    %rsp, %rdi
 	movq	ORIG_RAX(%rsp), %rsi
 	movq	initial_vc_handler(%rip), %rax
-	ANNOTATE_RETPOLINE_SAFE
-	call	*%rax
+	__call_ext_ptregs *%rax, annotate_retpoline_safe=1
 
 	/* Unwind pt_regs */
 	POP_REGS
@@ -397,7 +396,7 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
 	UNWIND_HINT_REGS
 
 	movq %rsp,%rdi		/* RDI = pt_regs; RSI is already trapnr */
-	call do_early_exception
+	call_ext_ptregs do_early_exception
 
 	decl early_recursion_flag(%rip)
 	jmp restore_regs_and_return_to_kernel
@@ -421,7 +420,7 @@ SYM_CODE_START_NOALIGN(vc_no_ghcb)
 	/* Call C handler */
 	movq    %rsp, %rdi
 	movq	ORIG_RAX(%rsp), %rsi
-	call    do_vc_no_ghcb
+	call_ext_ptregs do_vc_no_ghcb
 
 	/* Unwind pt_regs */
 	POP_REGS
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 0e0e90968f57..f694fbf9dcb8 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -32,6 +32,7 @@
 #include <asm/pgtable_areas.h>		/* VMALLOC_START, ...		*/
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
+#include <asm/pks.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -547,6 +548,8 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 		 (error_code & X86_PF_PK)    ? "protection keys violation" :
 					       "permissions violation");
 
+	show_extended_regs_oops(regs, error_code);
+
 	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
 		struct desc_ptr idt, gdt;
 		u16 ldtr, tr;
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 2955ba976048..a3d17a8e4e81 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -50,4 +50,21 @@ static inline void copy_init_pkru_to_fpregs(void)
 
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+
+void pkrs_save_set_irq(struct pt_regs *regs, u32 val);
+void pkrs_restore_irq(struct pt_regs *regs);
+
+#else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
+#ifndef INIT_PKRS_VALUE
+#define INIT_PKRS_VALUE 0
+#endif
+
+static inline void pkrs_save_set_irq(struct pt_regs *regs, u32 val) { }
+static inline void pkrs_restore_irq(struct pt_regs *regs) { }
+
+#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
 #endif /* _LINUX_PKEYS_H */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 8442e5c9cfa2..b50bcc2d3ea5 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -5,6 +5,7 @@
 #include <linux/highmem.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
+#include <linux/pkeys.h>
 
 #include "common.h"
 
@@ -363,7 +364,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		instrumentation_end();
 
 		ret.exit_rcu = true;
-		return ret;
+		goto done;
 	}
 
 	/*
@@ -378,6 +379,8 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	trace_hardirqs_off_finish();
 	instrumentation_end();
 
+done:
+	pkrs_save_set_irq(regs, INIT_PKRS_VALUE);
 	return ret;
 }
 
@@ -403,7 +406,12 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 	/* Check whether this returns to user mode */
 	if (user_mode(regs)) {
 		irqentry_exit_to_user_mode(regs);
-	} else if (!regs_irqs_disabled(regs)) {
+		return;
+	}
+
+	pkrs_restore_irq(regs);
+
+	if (!regs_irqs_disabled(regs)) {
 		/*
 		 * If RCU was not watching on entry this needs to be done
 		 * carefully and needs the same ordering of lockdep/tracing
@@ -457,11 +465,13 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 	ftrace_nmi_enter();
 	instrumentation_end();
 
+	pkrs_save_set_irq(regs, INIT_PKRS_VALUE);
 	return irq_state;
 }
 
 void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
 {
+	pkrs_restore_irq(regs);
 	instrumentation_begin();
 	ftrace_nmi_exit();
 	if (irq_state.lockdep) {
-- 
2.28.0.rc0.12.gb6a658bd00c9

