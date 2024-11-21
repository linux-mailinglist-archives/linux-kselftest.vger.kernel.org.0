Return-Path: <linux-kselftest+bounces-22414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B907B9D50AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 17:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787EE280FEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02017C210;
	Thu, 21 Nov 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VOP1mjd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BF32309B4;
	Thu, 21 Nov 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206376; cv=none; b=Fstn80xdrgqGVK6dkUq7kkWFanUJca/tHCdMJAxyyXddzo2G1pqgEK7rs/AoVKqse2/gvCaGUk4JDYrrRibWjEphEqekSP99Xm2ene2qtkXLGZDCYpHeB90WKaeFbkAET+t/tu5ztIlKeTMp6+nSUou1vOvRysfwChQjlK401Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206376; c=relaxed/simple;
	bh=2KjqvOMr22iESXG26FlZ/rGx86WXrxEf2zGELliCazA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOG/prLidhy+mC+cyVrSz/IYG5SFhpyVeapRlBpcMWUO4CFtol4ZXgGdHMHStTUabeGx9a20YI9ZeBy+rMo2PVWWMPVvEaN6QSftWrl3KSfzUdFzhGJfTXkLwRt75VRbQfN0pqC2D2kI0WUgwtScaLXpasRxBC8nJQR6g/sw3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VOP1mjd0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Tuw6u61XVKgJzrI+RtEbzlt5dJzkuA15z61icpJOg2Y=; b=VOP1mjd0n9h7RsYZs0Q5ZkeARh
	64Dxb1fCHluTUer5pycoxBMwlPq3sVsjV874CwaAx38wYIMDpIvkHeFWd9HsDmgvK/KbxK9OeviIn
	Jp4y7YwfdrXzLLVcCdIjTGtm5OdS1gIHpdDLqXEuJAsZPcAhvcJH3oI0v5Yls3X3XFEqCZGPK2q4p
	N3PTXsNIhlA1jtjZ9veHX/fqUeszwhWX+ijSVInuGupwCioCAnk+RkAOi1j3rZP02aiTgtdWSeKin
	FjQsDlflSJbwUF/xPs6pzoeDLcwufwdGAJnkcj+mXt2Ojs9QKOAVrDikRzL0hg4Zi2Yu23wOsdOgA
	u2DiSygA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEA0Q-00000006ZOb-3m1D;
	Thu, 21 Nov 2024 16:26:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9C68430068B; Thu, 21 Nov 2024 17:26:09 +0100 (CET)
Date: Thu, 21 Nov 2024 17:26:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	x86@kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>, Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure to
 defer kernel TLBI
Message-ID: <20241121162609.GM24774@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-14-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-14-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:35:00PM +0100, Valentin Schneider wrote:

> @@ -418,9 +419,20 @@ static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
>  #endif
>  #endif /* !MODULE */
>  
> +#define __NATIVE_TLB_FLUSH_GLOBAL(suffix, cr4)		\
> +	native_write_cr4##suffix(cr4 ^ X86_CR4_PGE);	\
> +	native_write_cr4##suffix(cr4)
> +#define NATIVE_TLB_FLUSH_GLOBAL(cr4)         __NATIVE_TLB_FLUSH_GLOBAL(, cr4)
> +#define NATIVE_TLB_FLUSH_GLOBAL_NOINSTR(cr4) __NATIVE_TLB_FLUSH_GLOBAL(_noinstr, cr4)
> +
>  static inline void __native_tlb_flush_global(unsigned long cr4)
>  {
> -	native_write_cr4(cr4 ^ X86_CR4_PGE);
> -	native_write_cr4(cr4);
> +	NATIVE_TLB_FLUSH_GLOBAL(cr4);
>  }
> +
> +static inline void __native_tlb_flush_global_noinstr(unsigned long cr4)
> +{
> +	NATIVE_TLB_FLUSH_GLOBAL_NOINSTR(cr4);
> +}

How about something like this instead? I've only compile tested the
tlb.c bit, but it should get __flush_tlb_global() to be noinstr I think,
including the Xen bit (unless I missed something but then objtool should
complain).

---
diff --git a/arch/x86/include/asm/invpcid.h b/arch/x86/include/asm/invpcid.h
index 734482afbf81..ff26136fcd9c 100644
--- a/arch/x86/include/asm/invpcid.h
+++ b/arch/x86/include/asm/invpcid.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_INVPCID
 #define _ASM_X86_INVPCID
 
-static inline void __invpcid(unsigned long pcid, unsigned long addr,
+static __always_inline void __invpcid(unsigned long pcid, unsigned long addr,
 			     unsigned long type)
 {
 	struct { u64 d[2]; } desc = { { pcid, addr } };
@@ -13,7 +13,7 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
 	 * mappings, we don't want the compiler to reorder any subsequent
 	 * memory accesses before the TLB flush.
 	 */
-	asm volatile("invpcid %[desc], %[type]"
+	asm_inline volatile("invpcid %[desc], %[type]"
 		     :: [desc] "m" (desc), [type] "r" (type) : "memory");
 }
 
@@ -23,26 +23,25 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
 #define INVPCID_TYPE_ALL_NON_GLOBAL	3
 
 /* Flush all mappings for a given pcid and addr, not including globals. */
-static inline void invpcid_flush_one(unsigned long pcid,
-				     unsigned long addr)
+static __always_inline void invpcid_flush_one(unsigned long pcid, unsigned long addr)
 {
 	__invpcid(pcid, addr, INVPCID_TYPE_INDIV_ADDR);
 }
 
 /* Flush all mappings for a given PCID, not including globals. */
-static inline void invpcid_flush_single_context(unsigned long pcid)
+static __always_inline void invpcid_flush_single_context(unsigned long pcid)
 {
 	__invpcid(pcid, 0, INVPCID_TYPE_SINGLE_CTXT);
 }
 
 /* Flush all mappings, including globals, for all PCIDs. */
-static inline void invpcid_flush_all(void)
+static __always_inline void invpcid_flush_all(void)
 {
 	__invpcid(0, 0, INVPCID_TYPE_ALL_INCL_GLOBAL);
 }
 
 /* Flush all mappings for all PCIDs except globals. */
-static inline void invpcid_flush_all_nonglobals(void)
+static __always_inline void invpcid_flush_all_nonglobals(void)
 {
 	__invpcid(0, 0, INVPCID_TYPE_ALL_NON_GLOBAL);
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d4eb9e1d61b8..b3daee3d4667 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -75,7 +75,7 @@ static inline void __flush_tlb_local(void)
 	PVOP_VCALL0(mmu.flush_tlb_user);
 }
 
-static inline void __flush_tlb_global(void)
+static __always_inline void __flush_tlb_global(void)
 {
 	PVOP_VCALL0(mmu.flush_tlb_kernel);
 }
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index a2dd24947eb8..b4c635b20538 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -357,8 +357,8 @@ MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
 	trace_xen_mc_entry(mcl, 4);
 }
 
-static inline void
-MULTI_mmuext_op(struct multicall_entry *mcl, struct mmuext_op *op, int count,
+static __always_inline void
+__MULTI_mmuext_op(struct multicall_entry *mcl, struct mmuext_op *op, int count,
 		int *success_count, domid_t domid)
 {
 	mcl->op = __HYPERVISOR_mmuext_op;
@@ -366,6 +366,13 @@ MULTI_mmuext_op(struct multicall_entry *mcl, struct mmuext_op *op, int count,
 	mcl->args[1] = count;
 	mcl->args[2] = (unsigned long)success_count;
 	mcl->args[3] = domid;
+}
+
+static inline void
+MULTI_mmuext_op(struct multicall_entry *mcl, struct mmuext_op *op, int count,
+		int *success_count, domid_t domid)
+{
+	__MULTI_mmuext_op(mcl, op, count, success_count, domid);
 
 	trace_xen_mc_entry(mcl, 4);
 }
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b0d5a644fc84..0cfc00a34b7e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1168,9 +1168,10 @@ void flush_tlb_one_user(unsigned long addr)
 /*
  * Flush everything
  */
-STATIC_NOPV void native_flush_tlb_global(void)
+STATIC_NOPV noinstr void native_flush_tlb_global(void)
 {
 	unsigned long flags;
+	unsigned long cr4;
 
 	if (static_cpu_has(X86_FEATURE_INVPCID)) {
 		/*
@@ -1189,9 +1190,15 @@ STATIC_NOPV void native_flush_tlb_global(void)
 	 * be called from deep inside debugging code.)
 	 */
 	raw_local_irq_save(flags);
-
-	__native_tlb_flush_global(this_cpu_read(cpu_tlbstate.cr4));
-
+	cr4 = this_cpu_read(cpu_tlbstate.cr4);
+	asm volatile("mov %0,%%cr4": : "r" (cr4 ^ X86_CR4_PGE) : "memory");
+	asm volatile("mov %0,%%cr4": : "r" (cr4) : "memory");
+	/*
+	 * In lieu of not having the pinning crap, hard fail if CR4 doesn't
+	 * match the expected value. This ensures that anybody doing dodgy gets
+	 * the fallthrough check.
+	 */
+	BUG_ON(cr4 != this_cpu_read(cpu_tlbstate.cr4));
 	raw_local_irq_restore(flags);
 }
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 55a4996d0c04..4eb265eb867a 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1231,22 +1231,22 @@ static noinstr void xen_write_cr2(unsigned long cr2)
 	this_cpu_read(xen_vcpu)->arch.cr2 = cr2;
 }
 
-static noinline void xen_flush_tlb(void)
+static noinline noinstr void xen_flush_tlb(void)
 {
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	preempt_disable();
+	preempt_disable_notrace();
 
 	mcs = xen_mc_entry(sizeof(*op));
 
 	op = mcs.args;
 	op->cmd = MMUEXT_TLB_FLUSH_LOCAL;
-	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
+	__MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
 
-	xen_mc_issue(XEN_LAZY_MMU);
+	__xen_mc_issue(XEN_LAZY_MMU);
 
-	preempt_enable();
+	preempt_enable_notrace();
 }
 
 static void xen_flush_tlb_one_user(unsigned long addr)
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index e1b782e823e6..31eddca45c27 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -235,15 +235,19 @@ static inline struct multicall_space xen_mc_entry(size_t args)
 void xen_mc_flush(void);
 
 /* Issue a multicall if we're not in a lazy mode */
-static inline void xen_mc_issue(unsigned mode)
+static __always_inline void __xen_mc_issue(unsigned mode)
 {
-	trace_xen_mc_issue(mode);
-
 	if ((xen_get_lazy_mode() & mode) == 0)
 		xen_mc_flush();
 
 	/* restore flags saved in xen_mc_batch */
-	local_irq_restore(this_cpu_read(xen_mc_irq_flags));
+	raw_local_irq_restore(this_cpu_read(xen_mc_irq_flags));
+}
+
+static inline void xen_mc_issue(unsigned mode)
+{
+	trace_xen_mc_issue(mode);
+	__xen_mc_issue(mode);
 }
 
 /* Set up a callback to be called when the current batch is flushed */

