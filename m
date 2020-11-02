Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A26C2A3593
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Nov 2020 21:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgKBUyT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 15:54:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:1372 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgKBUxp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 15:53:45 -0500
IronPort-SDR: zg8Vm5fbb1VmFQtgc7RqZWUKySvlLT9VT0p6xSH8Gdcx2szfADV0MGBzOZUhPdZczzOsVR4m3L
 GkKqVhrAegCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="156729730"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="156729730"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 12:53:44 -0800
IronPort-SDR: s47BXJGy2gTtDsXX2m22sPthFRa3cdJaVDdPwbpcxRby7YNw3xq+SL6N1yHe6NXzzaQ6Y4sKyl
 P4LRBxZPwsHw==
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="336289183"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 12:53:43 -0800
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH V2 09/10] x86/fault: Report the PKRS state on fault
Date:   Mon,  2 Nov 2020 12:53:19 -0800
Message-Id: <20201102205320.1458656-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201102205320.1458656-1-ira.weiny@intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

When only user space pkeys are enabled faulting within the kernel was an
unexpected condition which should never happen.  Therefore a WARN_ON in
the kernel fault handler would detect if it ever did.  Now this is no
longer the case if PKS is enabled and supported.

Report a Pkey fault with a normal splat and add the PKRS state to the
fault splat text.  Note the PKS register is reset during an exception
therefore the saved PKRS value from before the beginning of the
exception is passed down.

If PKS is not enabled, or not active, maintain the WARN_ON_ONCE() from
before.

Because each fault has its own state the pkrs information will be
correctly reported even if a fault 'faults'.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC V3
	Update commit message
	Per Dave Hansen
		Don't print PKRS if !cpu_feature_enabled(X86_FEATURE_PKS)
		Fix comment
		Remove check on CONFIG_ARCH_HAS_SUPERVISOR_PKEYS in favor of
			disabled-features.h
---
 arch/x86/mm/fault.c | 58 ++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 8d20c4c13abf..931603102010 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -504,7 +504,8 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
 }
 
 static void
-show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long address)
+show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long address,
+		irqentry_state_t *irq_state)
 {
 	if (!oops_may_print())
 		return;
@@ -548,6 +549,11 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 		 (error_code & X86_PF_PK)    ? "protection keys violation" :
 					       "permissions violation");
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+	if (cpu_feature_enabled(X86_FEATURE_PKS) && irq_state && (error_code & X86_PF_PK))
+		pr_alert("PKRS: 0x%x\n", irq_state->pkrs);
+#endif
+
 	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
 		struct desc_ptr idt, gdt;
 		u16 ldtr, tr;
@@ -626,7 +632,8 @@ static void set_signal_archinfo(unsigned long address,
 
 static noinline void
 no_context(struct pt_regs *regs, unsigned long error_code,
-	   unsigned long address, int signal, int si_code)
+	   unsigned long address, int signal, int si_code,
+	   irqentry_state_t *irq_state)
 {
 	struct task_struct *tsk = current;
 	unsigned long flags;
@@ -732,7 +739,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	 */
 	flags = oops_begin();
 
-	show_fault_oops(regs, error_code, address);
+	show_fault_oops(regs, error_code, address, irq_state);
 
 	if (task_stack_end_corrupted(tsk))
 		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
@@ -785,7 +792,8 @@ static bool is_vsyscall_vaddr(unsigned long vaddr)
 
 static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
-		       unsigned long address, u32 pkey, int si_code)
+		       unsigned long address, u32 pkey, int si_code,
+		       irqentry_state_t *irq_state)
 {
 	struct task_struct *tsk = current;
 
@@ -832,14 +840,14 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	if (is_f00f_bug(regs, address))
 		return;
 
-	no_context(regs, error_code, address, SIGSEGV, si_code);
+	no_context(regs, error_code, address, SIGSEGV, si_code, irq_state);
 }
 
 static noinline void
 bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
-		     unsigned long address)
+		     unsigned long address, irqentry_state_t *irq_state)
 {
-	__bad_area_nosemaphore(regs, error_code, address, 0, SEGV_MAPERR);
+	__bad_area_nosemaphore(regs, error_code, address, 0, SEGV_MAPERR, irq_state);
 }
 
 static void
@@ -853,7 +861,7 @@ __bad_area(struct pt_regs *regs, unsigned long error_code,
 	 */
 	mmap_read_unlock(mm);
 
-	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
+	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code, NULL);
 }
 
 static noinline void
@@ -923,7 +931,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 {
 	/* Kernel mode? Handle exceptions or die: */
 	if (!(error_code & X86_PF_USER)) {
-		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
+		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR, NULL);
 		return;
 	}
 
@@ -957,7 +965,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 	       unsigned long address, vm_fault_t fault)
 {
 	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
-		no_context(regs, error_code, address, 0, 0);
+		no_context(regs, error_code, address, 0, 0, NULL);
 		return;
 	}
 
@@ -965,7 +973,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 		/* Kernel mode? Handle exceptions or die: */
 		if (!(error_code & X86_PF_USER)) {
 			no_context(regs, error_code, address,
-				   SIGSEGV, SEGV_MAPERR);
+				   SIGSEGV, SEGV_MAPERR, NULL);
 			return;
 		}
 
@@ -980,7 +988,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 			     VM_FAULT_HWPOISON_LARGE))
 			do_sigbus(regs, error_code, address, fault);
 		else if (fault & VM_FAULT_SIGSEGV)
-			bad_area_nosemaphore(regs, error_code, address);
+			bad_area_nosemaphore(regs, error_code, address, NULL);
 		else
 			BUG();
 	}
@@ -1148,14 +1156,14 @@ bool fault_in_kernel_space(unsigned long address)
  */
 static void
 do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
-		   unsigned long address)
+		   unsigned long address, irqentry_state_t *irq_state)
 {
 	/*
-	 * Protection keys exceptions only happen on user pages.  We
-	 * have no user pages in the kernel portion of the address
-	 * space, so do not expect them here.
+	 * PF_PK is only expected on kernel addresses when supervisor pkeys are
+	 * enabled.
 	 */
-	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		WARN_ON_ONCE(hw_error_code & X86_PF_PK);
 
 #ifdef CONFIG_X86_32
 	/*
@@ -1204,7 +1212,7 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	 * Don't take the mm semaphore here. If we fixup a prefetch
 	 * fault we could otherwise deadlock:
 	 */
-	bad_area_nosemaphore(regs, hw_error_code, address);
+	bad_area_nosemaphore(regs, hw_error_code, address, irq_state);
 }
 NOKPROBE_SYMBOL(do_kern_addr_fault);
 
@@ -1245,7 +1253,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		     !(hw_error_code & X86_PF_USER) &&
 		     !(regs->flags & X86_EFLAGS_AC)))
 	{
-		bad_area_nosemaphore(regs, hw_error_code, address);
+		bad_area_nosemaphore(regs, hw_error_code, address, NULL);
 		return;
 	}
 
@@ -1254,7 +1262,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * in a region with pagefaults disabled then we must not take the fault
 	 */
 	if (unlikely(faulthandler_disabled() || !mm)) {
-		bad_area_nosemaphore(regs, hw_error_code, address);
+		bad_area_nosemaphore(regs, hw_error_code, address, NULL);
 		return;
 	}
 
@@ -1316,7 +1324,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 			 * Fault from code in kernel from
 			 * which we do not expect faults.
 			 */
-			bad_area_nosemaphore(regs, hw_error_code, address);
+			bad_area_nosemaphore(regs, hw_error_code, address, NULL);
 			return;
 		}
 retry:
@@ -1375,7 +1383,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, hw_error_code, address, SIGBUS,
-				   BUS_ADRERR);
+				   BUS_ADRERR, NULL);
 		return;
 	}
 
@@ -1415,7 +1423,7 @@ trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
 
 static __always_inline void
 handle_page_fault(struct pt_regs *regs, unsigned long error_code,
-			      unsigned long address)
+		  unsigned long address, irqentry_state_t *irq_state)
 {
 	trace_page_fault_entries(regs, error_code, address);
 
@@ -1424,7 +1432,7 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 
 	/* Was the fault on kernel-controlled part of the address space? */
 	if (unlikely(fault_in_kernel_space(address))) {
-		do_kern_addr_fault(regs, error_code, address);
+		do_kern_addr_fault(regs, error_code, address, irq_state);
 	} else {
 		do_user_addr_fault(regs, error_code, address);
 		/*
@@ -1482,7 +1490,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	irqentry_enter(regs, &irq_state);
 
 	instrumentation_begin();
-	handle_page_fault(regs, error_code, address);
+	handle_page_fault(regs, error_code, address, &irq_state);
 	instrumentation_end();
 
 	irqentry_exit(regs, &irq_state);
-- 
2.28.0.rc0.12.gb6a658bd00c9

