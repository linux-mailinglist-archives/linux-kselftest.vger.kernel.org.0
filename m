Return-Path: <linux-kselftest+bounces-22295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F59D2A4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B7FB30C56
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166D1D1E99;
	Tue, 19 Nov 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJeT2Tyl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0C1D1514
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030786; cv=none; b=atc9bOJhwHdCyz0VMlewq5eC4sJxFdk3newmgqbhrei2s936Jgu8m3RIZT7CdQqynovphqXaxJmVIF6EF+zb5IrNc7TA+9B09r/fU8Gj/APCKDk2pUHTji06FhLOC0lpnxUAZVdnYU25KOgzOTeKBNlmH88s7kUsMeaBQAYv5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030786; c=relaxed/simple;
	bh=xDTiVCke+dcOcHJv8qISnvLe6s6Z2yfLt5JyeXbmVNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S84GCw/Mq4QptXywDAqZIr+TCmQs43KfitmlG/iUjtuzRChzYwGba216BfmubUCYsxlMqahBhvZ1VPGK1Mw6PeYofdxRsT/ododsGMvaDDBqNww7xKMhm4T5dg/6dvSLCb1QpO6kApy+huH26uuWwHJbLP/PErrMMfkbGbOWNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJeT2Tyl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732030783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xImyrBZyvIgQkmg3c7kz+ISL+g7A1zTmv4nEmku3rgI=;
	b=JJeT2Tyl0AB0TWw6cslgZoBG+I/YkoALTGILYVjDpfm1MKG2XHNktYy+U8S1ecXs2huUhU
	Ty9YZZHrFPpxEpTNqz67bOVNf3ZIaN7drJheODbTJvNQQIq3egdmB6ZNBCHN1tJp6kiOpM
	u/BzbgaDmlOt0sqQZYQsTWYZtxuQ5Xk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-Nxl_Cjx6PWO_riG5D1782Q-1; Tue,
 19 Nov 2024 10:39:41 -0500
X-MC-Unique: Nxl_Cjx6PWO_riG5D1782Q-1
X-Mimecast-MFC-AGG-ID: Nxl_Cjx6PWO_riG5D1782Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9AB019560A2;
	Tue, 19 Nov 2024 15:39:36 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 901D830001A0;
	Tue, 19 Nov 2024 15:39:22 +0000 (UTC)
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
Subject: [RFC PATCH v3 14/15] x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
Date: Tue, 19 Nov 2024 16:35:01 +0100
Message-ID: <20241119153502.41361-15-vschneid@redhat.com>
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

vunmap()'s issued from housekeeping CPUs are a relatively common source of
interference for isolated NOHZ_FULL CPUs, as they are hit by the
flush_tlb_kernel_range() IPIs.

Given that CPUs executing in userspace do not access data in the vmalloc
range, these IPIs could be deferred until their next kernel entry.

Deferral vs early entry danger zone
===================================

This requires a guarantee that nothing in the vmalloc range can be vunmap'd
and then accessed in early entry code.

Vmalloc uses are, as reported by vmallocinfo:

  $ cat /proc/vmallocinfo | awk '{ print $3 }' | sort | uniq
  __pci_enable_msix_range+0x32b/0x560
  acpi_os_map_iomem+0x22d/0x250
  bpf_prog_alloc_no_stats+0x34/0x140
  fork_idle+0x79/0x120
  gen_pool_add_owner+0x3e/0xb0          ?
  hpet_enable+0xbf/0x470
  irq_init_percpu_irqstack+0x129/0x160
  kernel_clone+0xab/0x3b0
  memremap+0x164/0x330
  n_tty_open+0x18/0xa0
  pcpu_create_chunk+0x4e/0x1b0
  pcpu_create_chunk+0x75/0x1b0
  pcpu_get_vm_areas+0x0/0x1100
  unpurged
  vp_modern_map_capability+0x140/0x270
  zisofs_init+0x16/0x30

I've categorized these as:

a) Device or percpu mappings

   For these to be unmapped, the device (or CPU) has to be removed and an
   eventual IRQ freed. Even if the IRQ isn't freed, context tracking entry
   happens before handling the IRQ itself, per irqentry_enter() usage.

   __pci_enable_msix_range()
   acpi_os_map_iomem()
   irq_init_percpu_irqstack() (not even unmapped when CPU is hot-unplugged!)
   memremap()
   n_tty_open()
   pcpu_create_chunk()
   pcpu_get_vm_areas()
   vp_modern_map_capability()

b) CONFIG_VMAP_STACK

  fork_idle() & kernel_clone()

  vmalloc'd kernel stacks are AFAICT a safe example, as a task running in
  userspace needs to enter kernelspace to execute do_exit() before its
  stack can be vfree'd.

c) Non-issues

  bpf_prog_alloc_no_stats() - early entry is noinstr, no BPF!
  hpet_enable() - hpet_clear_mapping() is only called if __init function
		  fails, no runtime worries
  zisofs_init () - used for zisofs block decompression, that's way past
		   context tracking entry

d) I'm not sure, have a look?

  gen_pool_add_owner() - AIUI this is mainly for PCI / DMA stuff, which
			 again I wouldn't expect to be accessed before
			 context tracking entry.

Changes
======

Blindly deferring any and all flush of the kernel mappings is a risky move,
so introduce a variant of flush_tlb_kernel_range() that explicitly allows
deferral. Use it for vunmap flushes.

Note that while flush_tlb_kernel_range() may end up issuing a full
flush (including user mappings), this only happens when reaching a
invalidation range threshold where it is cheaper to do a full flush than to
individually invalidate each page in the range via INVLPG. IOW, it doesn't
*require* invalidating user mappings, and thus remains safe to defer until
a later kernel entry.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/x86/include/asm/tlbflush.h |  1 +
 arch/x86/mm/tlb.c               | 23 +++++++++++++++++++---
 mm/vmalloc.c                    | 35 ++++++++++++++++++++++++++++-----
 3 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index a653b5f47f0e6..d89345c85fa9c 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -249,6 +249,7 @@ extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
 				bool freed_tables);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+extern void flush_tlb_kernel_range_deferrable(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 973a4ab3f53b3..bf6ff16a1a523 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -12,6 +12,7 @@
 #include <linux/task_work.h>
 #include <linux/mmu_notifier.h>
 #include <linux/mmu_context.h>
+#include <linux/context_tracking.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -1041,6 +1042,11 @@ static void do_flush_tlb_all(void *info)
 	__flush_tlb_all();
 }
 
+static bool do_kernel_flush_defer_cond(int cpu, void *info)
+{
+	return !ct_set_cpu_work(cpu, CONTEXT_WORK_TLBI);
+}
+
 void flush_tlb_all(void)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
@@ -1057,12 +1063,13 @@ static void do_kernel_range_flush(void *info)
 		flush_tlb_one_kernel(addr);
 }
 
-void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+static inline void
+__flush_tlb_kernel_range(smp_cond_func_t cond_func, unsigned long start, unsigned long end)
 {
 	/* Balance as user space task's flush, a bit conservative */
 	if (end == TLB_FLUSH_ALL ||
 	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
-		on_each_cpu(do_flush_tlb_all, NULL, 1);
+		on_each_cpu_cond(cond_func, do_flush_tlb_all, NULL, 1);
 	} else {
 		struct flush_tlb_info *info;
 
@@ -1070,13 +1077,23 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		info = get_flush_tlb_info(NULL, start, end, 0, false,
 					  TLB_GENERATION_INVALID);
 
-		on_each_cpu(do_kernel_range_flush, info, 1);
+		on_each_cpu_cond(cond_func, do_kernel_range_flush, info, 1);
 
 		put_flush_tlb_info();
 		preempt_enable();
 	}
 }
 
+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	__flush_tlb_kernel_range(NULL, start, end);
+}
+
+void flush_tlb_kernel_range_deferrable(unsigned long start, unsigned long end)
+{
+	__flush_tlb_kernel_range(do_kernel_flush_defer_cond, start, end);
+}
+
 /*
  * This can be used from process context to figure out what the value of
  * CR3 is without needing to do a (slow) __read_cr3().
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 634162271c004..02838c515ce2c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -467,6 +467,31 @@ void vunmap_range_noflush(unsigned long start, unsigned long end)
 	__vunmap_range_noflush(start, end);
 }
 
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+/*
+ * !!! BIG FAT WARNING !!!
+ *
+ * The CPU is free to cache any part of the paging hierarchy it wants at any
+ * time. It's also free to set accessed and dirty bits at any time, even for
+ * instructions that may never execute architecturally.
+ *
+ * This means that deferring a TLB flush affecting freed page-table-pages (IOW,
+ * keeping them in a CPU's paging hierarchy cache) is akin to dancing in a
+ * minefield.
+ *
+ * This isn't a problem for deferral of TLB flushes in vmalloc, because
+ * page-table-pages used for vmap() mappings are never freed - see how
+ * __vunmap_range_noflush() walks the whole mapping but only clears the leaf PTEs.
+ * If this ever changes, TLB flush deferral will cause misery.
+ */
+void __weak flush_tlb_kernel_range_deferrable(unsigned long start, unsigned long end)
+{
+	flush_tlb_kernel_range(start, end);
+}
+#else
+#define flush_tlb_kernel_range_deferrable(start, end) flush_tlb_kernel_range(start, end)
+#endif
+
 /**
  * vunmap_range - unmap kernel virtual addresses
  * @addr: start of the VM area to unmap
@@ -480,7 +505,7 @@ void vunmap_range(unsigned long addr, unsigned long end)
 {
 	flush_cache_vunmap(addr, end);
 	vunmap_range_noflush(addr, end);
-	flush_tlb_kernel_range(addr, end);
+	flush_tlb_kernel_range_deferrable(addr, end);
 }
 
 static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
@@ -2265,7 +2290,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
 
 	nr_purge_nodes = cpumask_weight(&purge_nodes);
 	if (nr_purge_nodes > 0) {
-		flush_tlb_kernel_range(start, end);
+		flush_tlb_kernel_range_deferrable(start, end);
 
 		/* One extra worker is per a lazy_max_pages() full set minus one. */
 		nr_purge_helpers = atomic_long_read(&vmap_lazy_nr) / lazy_max_pages();
@@ -2368,7 +2393,7 @@ static void free_unmap_vmap_area(struct vmap_area *va)
 	flush_cache_vunmap(va->va_start, va->va_end);
 	vunmap_range_noflush(va->va_start, va->va_end);
 	if (debug_pagealloc_enabled_static())
-		flush_tlb_kernel_range(va->va_start, va->va_end);
+		flush_tlb_kernel_range_deferrable(va->va_start, va->va_end);
 
 	free_vmap_area_noflush(va);
 }
@@ -2816,7 +2841,7 @@ static void vb_free(unsigned long addr, unsigned long size)
 	vunmap_range_noflush(addr, addr + size);
 
 	if (debug_pagealloc_enabled_static())
-		flush_tlb_kernel_range(addr, addr + size);
+		flush_tlb_kernel_range_deferrable(addr, addr + size);
 
 	spin_lock(&vb->lock);
 
@@ -2881,7 +2906,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 	free_purged_blocks(&purge_list);
 
 	if (!__purge_vmap_area_lazy(start, end, false) && flush)
-		flush_tlb_kernel_range(start, end);
+		flush_tlb_kernel_range_deferrable(start, end);
 	mutex_unlock(&vmap_purge_lock);
 }
 
-- 
2.43.0


