Return-Path: <linux-kselftest+bounces-22294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7249D2A89
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 17:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083D2B2FDDA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE47D1D1E6C;
	Tue, 19 Nov 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0UoDJj+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D51D175F
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030771; cv=none; b=aOui87zRExo8GOnBRib72PEXEM8Ye0mT6jWKw2P7vH/ol0SYm1NRPDHMoiSilGxI8VhBvFf+IeRKwnpPixadxBxKIru0JkSx3BwHo0LQL0HRYOoer6K9Wco2NlZqVsaE2gi4uzgwaz80AWXuTmNhpNAAPFmWxyKPQyTAtRTFfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030771; c=relaxed/simple;
	bh=qZYlteLvCxXOvYUuzfcxn7fFpUiypvGlWfQxkKpgHw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqJy1dQxBPok9WYh/FVx0qV3qdWDXjoQ9NlxkHgYZlya+qNISZAdAEv5LphLltE2YsNOk+CrSMWvSgxHWgKGLieKFLSSawz4vvq3kCH/XSyikAa5rUDPkgDVm617ACIrlxeWosKAVFt6hxb5XNF/YtJMmf0a+kiB2SLM9Asef4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0UoDJj+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732030769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZhR8LJzRJ/NA3355q22R2um1DqV6KheeHOnZlXN8BQ=;
	b=V0UoDJj+mrLCzIuqd0TVI6rtcQMmNtLBqG7yksCmePkzi3Sy5tJgYeU27r+6MRHmgV/FZt
	B3r0mBHzyMzBYWwaOoyAEGMIhXACLHmGMB8Fyg7HJ6562o9ha1V5cUYPxXzpSc9AsukeWA
	DgJ84bicFE6Nxb0rlGAzlFnvhHwZKa8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-EyVM_Q77Oy2qLzT--XqbYw-1; Tue,
 19 Nov 2024 10:39:27 -0500
X-MC-Unique: EyVM_Q77Oy2qLzT--XqbYw-1
X-Mimecast-MFC-AGG-ID: EyVM_Q77Oy2qLzT--XqbYw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 209A21955F2C;
	Tue, 19 Nov 2024 15:39:22 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E38F30001A0;
	Tue, 19 Nov 2024 15:39:06 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Jason Baron <jbaron@akamai.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>,
	Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure to defer kernel TLBI
Date: Tue, 19 Nov 2024 16:35:00 +0100
Message-ID: <20241119153502.41361-14-vschneid@redhat.com>
In-Reply-To: <20241119153502.41361-1-vschneid@redhat.com>
References: <20241119153502.41361-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Kernel TLB invalidation IPIs are a common source of interference on
NOHZ_FULL CPUs. Given NOHZ_FULL CPUs executing in userspace are not
accessing any kernel addresses, these invalidations do not need to happen
immediately, and can be deferred until the next user->kernel transition.

Add a minimal, noinstr-compliant variant of __flush_tlb_all() that doesn't
try to leverage INVPCID. To achieve this:
o Add a noinstr variant of native_write_cr4(), keeping native_write_cr4() as
  "only" __no_profile.
o Make invalidate_user_asid() __always_inline

XXX: what about paravirt? Should these be instead new operations made
available through pv_ops.mmu.*? x86_64_start_kernel() uses
__native_tlb_flush_global() regardless of paravirt, so I'm thinking the
paravirt variants are more optimizations than hard requirements?

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/x86/include/asm/context_tracking_work.h |  4 +++
 arch/x86/include/asm/special_insns.h         |  1 +
 arch/x86/include/asm/tlbflush.h              | 16 ++++++++++--
 arch/x86/kernel/cpu/common.c                 |  6 ++++-
 arch/x86/mm/tlb.c                            | 26 ++++++++++++++++++--
 include/linux/context_tracking_work.h        |  2 ++
 6 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/context_tracking_work.h b/arch/x86/include/asm/context_tracking_work.h
index 2c66687ce00e2..9d4f021b5a45b 100644
--- a/arch/x86/include/asm/context_tracking_work.h
+++ b/arch/x86/include/asm/context_tracking_work.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_CONTEXT_TRACKING_WORK_H
 
 #include <asm/sync_core.h>
+#include <asm/tlbflush.h>
 
 static __always_inline void arch_context_tracking_work(int work)
 {
@@ -10,6 +11,9 @@ static __always_inline void arch_context_tracking_work(int work)
 	case CONTEXT_WORK_SYNC:
 		sync_core();
 		break;
+	case CONTEXT_WORK_TLBI:
+		__flush_tlb_all_noinstr();
+		break;
 	}
 }
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index aec6e2d3aa1d5..b97157a69d48e 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -74,6 +74,7 @@ static inline unsigned long native_read_cr4(void)
 	return val;
 }
 
+void native_write_cr4_noinstr(unsigned long val);
 void native_write_cr4(unsigned long val);
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 69e79fff41b80..a653b5f47f0e6 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -18,6 +18,7 @@
 DECLARE_PER_CPU(u64, tlbstate_untag_mask);
 
 void __flush_tlb_all(void);
+void noinstr __flush_tlb_all_noinstr(void);
 
 #define TLB_FLUSH_ALL	-1UL
 #define TLB_GENERATION_INVALID	0
@@ -418,9 +419,20 @@ static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 #endif
 #endif /* !MODULE */
 
+#define __NATIVE_TLB_FLUSH_GLOBAL(suffix, cr4)		\
+	native_write_cr4##suffix(cr4 ^ X86_CR4_PGE);	\
+	native_write_cr4##suffix(cr4)
+#define NATIVE_TLB_FLUSH_GLOBAL(cr4)         __NATIVE_TLB_FLUSH_GLOBAL(, cr4)
+#define NATIVE_TLB_FLUSH_GLOBAL_NOINSTR(cr4) __NATIVE_TLB_FLUSH_GLOBAL(_noinstr, cr4)
+
 static inline void __native_tlb_flush_global(unsigned long cr4)
 {
-	native_write_cr4(cr4 ^ X86_CR4_PGE);
-	native_write_cr4(cr4);
+	NATIVE_TLB_FLUSH_GLOBAL(cr4);
 }
+
+static inline void __native_tlb_flush_global_noinstr(unsigned long cr4)
+{
+	NATIVE_TLB_FLUSH_GLOBAL_NOINSTR(cr4);
+}
+
 #endif /* _ASM_X86_TLBFLUSH_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a5f221ea56888..a84bb8511650b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -424,7 +424,7 @@ void native_write_cr0(unsigned long val)
 }
 EXPORT_SYMBOL(native_write_cr0);
 
-void __no_profile native_write_cr4(unsigned long val)
+noinstr void native_write_cr4_noinstr(unsigned long val)
 {
 	unsigned long bits_changed = 0;
 
@@ -442,6 +442,10 @@ void __no_profile native_write_cr4(unsigned long val)
 			  bits_changed);
 	}
 }
+void native_write_cr4(unsigned long val)
+{
+	native_write_cr4_noinstr(val);
+}
 #if IS_MODULE(CONFIG_LKDTM)
 EXPORT_SYMBOL_GPL(native_write_cr4);
 #endif
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 86593d1b787d8..973a4ab3f53b3 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -256,7 +256,7 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
  *
  * See SWITCH_TO_USER_CR3.
  */
-static inline void invalidate_user_asid(u16 asid)
+static __always_inline void invalidate_user_asid(u16 asid)
 {
 	/* There is no user ASID if address space separation is off */
 	if (!IS_ENABLED(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION))
@@ -1198,7 +1198,7 @@ STATIC_NOPV void native_flush_tlb_global(void)
 /*
  * Flush the entire current user mapping
  */
-STATIC_NOPV void native_flush_tlb_local(void)
+static noinstr void native_flush_tlb_local_noinstr(void)
 {
 	/*
 	 * Preemption or interrupts must be disabled to protect the access
@@ -1213,6 +1213,11 @@ STATIC_NOPV void native_flush_tlb_local(void)
 	native_write_cr3(__native_read_cr3());
 }
 
+STATIC_NOPV void native_flush_tlb_local(void)
+{
+	native_flush_tlb_local_noinstr();
+}
+
 void flush_tlb_local(void)
 {
 	__flush_tlb_local();
@@ -1240,6 +1245,23 @@ void __flush_tlb_all(void)
 }
 EXPORT_SYMBOL_GPL(__flush_tlb_all);
 
+void noinstr __flush_tlb_all_noinstr(void)
+{
+	/*
+	 * This is for invocation in early entry code that cannot be
+	 * instrumented. A RMW to CR4 works for most cases, but relies on
+	 * being able to flip either of the PGE or PCIDE bits. Flipping CR4.PCID
+	 * would require also resetting CR3.PCID, so just try with CR4.PGE, else
+	 * do the CR3 write.
+	 *
+	 * XXX: this gives paravirt the finger.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_PGE))
+		__native_tlb_flush_global_noinstr(this_cpu_read(cpu_tlbstate.cr4));
+	else
+		native_flush_tlb_local_noinstr();
+}
+
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
 	struct flush_tlb_info *info;
diff --git a/include/linux/context_tracking_work.h b/include/linux/context_tracking_work.h
index 13fc97b395030..47d5ced39a43a 100644
--- a/include/linux/context_tracking_work.h
+++ b/include/linux/context_tracking_work.h
@@ -6,11 +6,13 @@
 
 enum {
 	CONTEXT_WORK_SYNC_OFFSET,
+	CONTEXT_WORK_TLBI_OFFSET,
 	CONTEXT_WORK_MAX_OFFSET
 };
 
 enum ct_work {
 	CONTEXT_WORK_SYNC     = BIT(CONTEXT_WORK_SYNC_OFFSET),
+	CONTEXT_WORK_TLBI     = BIT(CONTEXT_WORK_TLBI_OFFSET),
 	CONTEXT_WORK_MAX      = BIT(CONTEXT_WORK_MAX_OFFSET)
 };
 
-- 
2.43.0


