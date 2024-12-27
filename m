Return-Path: <linux-kselftest+bounces-23772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EA09FD13D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 08:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B723A0689
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 07:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88461474CF;
	Fri, 27 Dec 2024 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh80oV+h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2528146A71;
	Fri, 27 Dec 2024 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735284558; cv=none; b=GLuEiEC7DI6pjKWH6HRzRI2u9NG0boOK+P/XIwgJa4Zw65Ljtx9KqVeNjqIlu081URQ3louJQbT1WMo3ls5w37kdSncvP5tt6KZBDXSWYweMKvKTONsEcF/QcRx0TgcEN7giG176cYBMMOmTAdcUUYqTdmz5dNFoasXkqBanKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735284558; c=relaxed/simple;
	bh=FqmeKOdxdJ7a2m5t/X9aYwdfjOV0nVl0+/73FfCFau0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp+dhLgJf8lwDaB19r9YjdJCqkcZcTjduWSmNHc1GgKBktqv1c7mXr49awBxoJbrgjPtOW3N4lJds/FeuDIKfdQcVW1c1a2GKvn3PD6kjoXMnSyV4nABCjkCQ8lokhPkDQND9edAsbbODDdsgVpZW5g7Z2XF9139PkhcZscJr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh80oV+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE6AC4CED0;
	Fri, 27 Dec 2024 07:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735284556;
	bh=FqmeKOdxdJ7a2m5t/X9aYwdfjOV0nVl0+/73FfCFau0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hh80oV+hFNDxk2u7u2M5S6a+d8LX0hjSp0XpKgfOj04wjrYxAJPeXs+POJREwL41U
	 JR/qH4kYzWMQgMWbk83uSdtwe1A697JTr8qTOO/i80nDu1xSbLzIckQGQn5r3usg6A
	 F8kTaV1y3sT0bYQOwSKqT85evFAgwX/N45O5XAmWgAOGuH2SGPoTSeWB0r1yVzxqxT
	 PCRKOs3HflTSffBeVV44vMRIuO4wADCmWaX125GZGZdGW2ewck9DqhC39XLO6ytaEG
	 3tywgHm1LfzkrvBLGY77jOs0OxfTdEou09qrxJGsizJkWldALgu8KjGTRPsACisDMf
	 RIdYinWh5g3ew==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
	Daniel Thompson <danielt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Rae Moar <rmoar@google.com>,
	Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	live-patching@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 3/8] x86/mm/pat: Restore large pages after fragmentation
Date: Fri, 27 Dec 2024 09:28:20 +0200
Message-ID: <20241227072825.1288491-4-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241227072825.1288491-1-rppt@kernel.org>
References: <20241227072825.1288491-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Change of attributes of the pages may lead to fragmentation of direct
mapping over time and performance degradation as result.

With current code it's one way road: kernel tries to avoid splitting
large pages, but it doesn't restore them back even if page attributes
got compatible again.

Any change to the mapping may potentially allow to restore large page.

Hook up into cpa_flush() path to check if there's any pages to be
recovered in PUD_SIZE range around pages we've just touched.

CPUs don't like[1] to have to have TLB entries of different size for the
same memory, but looks like it's okay as long as these entries have
matching attributes[2]. Therefore it's critical to flush TLB before any
following changes to the mapping.

Note that we already allow for multiple TLB entries of different sizes
for the same memory now in split_large_page() path. It's not a new
situation.

set_memory_4k() provides a way to use 4k pages on purpose. Kernel must
not remap such pages as large. Re-use one of software PTE bits to
indicate such pages.

[1] See Erratum 383 of AMD Family 10h Processors
[2] https://lore.kernel.org/linux-mm/1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com/

[rppt@kernel.org:
 * s/restore/collapse/
 * update formatting per peterz
 * use 'struct ptdesc' instead of 'struct page' for list of page tables to
   be freed
 * try to collapse PMD first and if it succeeds move on to PUD as peterz
   suggested
 * flush TLB twice: for changes done in the original CPA call and after
   collapsing of large pages
]

Link: https://lore.kernel.org/all/20200416213229.19174-1-kirill.shutemov@linux.intel.com
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/include/asm/pgtable_types.h |   2 +
 arch/x86/mm/pat/set_memory.c         | 213 ++++++++++++++++++++++++++-
 include/linux/vm_event_item.h        |   2 +
 mm/vmstat.c                          |   2 +
 4 files changed, 216 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 4b804531b03c..c90e9c51edb7 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -33,6 +33,7 @@
 #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
 #define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
+#define _PAGE_BIT_KERNEL_4K	_PAGE_BIT_SOFTW3 /* page must not be converted to large */
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
 #ifdef CONFIG_X86_64
@@ -64,6 +65,7 @@
 #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
 #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
 #define _PAGE_CPA_TEST	(_AT(pteval_t, 1) << _PAGE_BIT_CPA_TEST)
+#define _PAGE_KERNEL_4K	(_AT(pteval_t, 1) << _PAGE_BIT_KERNEL_4K)
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 #define _PAGE_PKEY_BIT0	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT0)
 #define _PAGE_PKEY_BIT1	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT1)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d43b919b11ae..89cd8176c99f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -107,6 +107,18 @@ static void split_page_count(int level)
 	direct_pages_count[level - 1] += PTRS_PER_PTE;
 }
 
+static void collapse_page_count(int level)
+{
+	direct_pages_count[level]++;
+	if (system_state == SYSTEM_RUNNING) {
+		if (level == PG_LEVEL_2M)
+			count_vm_event(DIRECT_MAP_LEVEL2_COLLAPSE);
+		else if (level == PG_LEVEL_1G)
+			count_vm_event(DIRECT_MAP_LEVEL3_COLLAPSE);
+	}
+	direct_pages_count[level - 1] -= PTRS_PER_PTE;
+}
+
 void arch_report_meminfo(struct seq_file *m)
 {
 	seq_printf(m, "DirectMap4k:    %8lu kB\n",
@@ -124,6 +136,7 @@ void arch_report_meminfo(struct seq_file *m)
 }
 #else
 static inline void split_page_count(int level) { }
+static inline void collapse_page_count(int level) { }
 #endif
 
 #ifdef CONFIG_X86_CPA_STATISTICS
@@ -396,15 +409,50 @@ static void __cpa_flush_tlb(void *data)
 		flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
 }
 
+static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
+
+static void cpa_collapse_large_pages(struct cpa_data *cpa)
+{
+	unsigned long start, addr, end;
+	struct ptdesc *ptdesc, *tmp;
+	LIST_HEAD(pgtables);
+	int collapsed = 0;
+	int i;
+
+	if (cpa->flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
+		for (i = 0; i < cpa->numpages; i++)
+			collapsed += collapse_large_pages(__cpa_addr(cpa, i),
+							  &pgtables);
+	} else {
+		addr = __cpa_addr(cpa, 0);
+		start = addr & PMD_MASK;
+		end = addr + PAGE_SIZE * cpa->numpages;
+
+		for (addr = start; within(addr, start, end); addr += PMD_SIZE)
+			collapsed += collapse_large_pages(addr, &pgtables);
+	}
+
+	if (!collapsed)
+		return;
+
+	flush_tlb_all();
+
+	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
+		list_del(&ptdesc->pt_list);
+		__free_page(ptdesc_page(ptdesc));
+	}
+}
+
 static void cpa_flush(struct cpa_data *cpa, int cache)
 {
+	LIST_HEAD(pgtables);
 	unsigned int i;
 
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
 	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
 		cpa_flush_all(cache);
-		return;
+		goto collapse_large_pages;
 	}
 
 	if (cpa->force_flush_all || cpa->numpages > tlb_single_page_flush_ceiling)
@@ -413,7 +461,7 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 		on_each_cpu(__cpa_flush_tlb, cpa, 1);
 
 	if (!cache)
-		return;
+		goto collapse_large_pages;
 
 	mb();
 	for (i = 0; i < cpa->numpages; i++) {
@@ -429,6 +477,9 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 			clflush_cache_range_opt((void *)fix_addr(addr), PAGE_SIZE);
 	}
 	mb();
+
+collapse_large_pages:
+	cpa_collapse_large_pages(cpa);
 }
 
 static bool overlaps(unsigned long r1_start, unsigned long r1_end,
@@ -1198,6 +1249,161 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 	return 0;
 }
 
+static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
+			     struct list_head *pgtables)
+{
+	pmd_t _pmd, old_pmd;
+	pte_t *pte, first;
+	unsigned long pfn;
+	pgprot_t pgprot;
+	int i = 0;
+
+	addr &= PMD_MASK;
+	pte = pte_offset_kernel(pmd, addr);
+	first = *pte;
+	pfn = pte_pfn(first);
+
+	/* Make sure alignment is suitable */
+	if (PFN_PHYS(pfn) & ~PMD_MASK)
+		return 0;
+
+	/* The page is 4k intentionally */
+	if (pte_flags(first) & _PAGE_KERNEL_4K)
+		return 0;
+
+	/* Check that the rest of PTEs are compatible with the first one */
+	for (i = 1, pte++; i < PTRS_PER_PTE; i++, pte++) {
+		pte_t entry = *pte;
+
+		if (!pte_present(entry))
+			return 0;
+		if (pte_flags(entry) != pte_flags(first))
+			return 0;
+		if (pte_pfn(entry) != pte_pfn(first) + i)
+			return 0;
+	}
+
+	old_pmd = *pmd;
+
+	/* Success: set up a large page */
+	pgprot = pgprot_4k_2_large(pte_pgprot(first));
+	pgprot_val(pgprot) |= _PAGE_PSE;
+	_pmd = pfn_pmd(pfn, pgprot);
+	set_pmd(pmd, _pmd);
+
+	/* Queue the page table to be freed after TLB flush */
+	list_add(&page_ptdesc(pmd_page(old_pmd))->pt_list, pgtables);
+
+	if (IS_ENABLED(CONFIG_X86_32) && !SHARED_KERNEL_PMD) {
+		struct page *page;
+
+		/* Update all PGD tables to use the same large page */
+		list_for_each_entry(page, &pgd_list, lru) {
+			pgd_t *pgd = (pgd_t *)page_address(page) + pgd_index(addr);
+			p4d_t *p4d = p4d_offset(pgd, addr);
+			pud_t *pud = pud_offset(p4d, addr);
+			pmd_t *pmd = pmd_offset(pud, addr);
+			/* Something is wrong if entries doesn't match */
+			if (WARN_ON(pmd_val(old_pmd) != pmd_val(*pmd)))
+				continue;
+			set_pmd(pmd, _pmd);
+		}
+	}
+
+	if (virt_addr_valid(addr) && pfn_range_is_mapped(pfn, pfn + 1))
+		collapse_page_count(PG_LEVEL_2M);
+
+	return 1;
+}
+
+static int collapse_pud_page(pud_t *pud, unsigned long addr,
+			     struct list_head *pgtables)
+{
+	unsigned long pfn;
+	pmd_t *pmd, first;
+	int i;
+
+	if (!direct_gbpages)
+		return 0;
+
+	addr &= PUD_MASK;
+	pmd = pmd_offset(pud, addr);
+	first = *pmd;
+
+	/*
+	 * To restore PUD page all PMD entries must be large and
+	 * have suitable alignment
+	 */
+	pfn = pmd_pfn(first);
+	if (!pmd_leaf(first) || (PFN_PHYS(pfn) & ~PUD_MASK))
+		return 0;
+
+	/*
+	 * To restore PUD page, all following PMDs must be compatible with the
+	 * first one.
+	 */
+	for (i = 1, pmd++; i < PTRS_PER_PMD; i++, pmd++) {
+		pmd_t entry = *pmd;
+
+		if (!pmd_present(entry) || !pmd_leaf(entry))
+			return 0;
+		if (pmd_flags(entry) != pmd_flags(first))
+			return 0;
+		if (pmd_pfn(entry) != pmd_pfn(first) + i * PTRS_PER_PTE)
+			return 0;
+	}
+
+	/* Restore PUD page and queue page table to be freed after TLB flush */
+	list_add(&page_ptdesc(pud_page(*pud))->pt_list, pgtables);
+	set_pud(pud, pfn_pud(pfn, pmd_pgprot(first)));
+
+	if (virt_addr_valid(addr) && pfn_range_is_mapped(pfn, pfn + 1))
+		collapse_page_count(PG_LEVEL_1G);
+
+	return 1;
+}
+
+/*
+ * Collapse PMD and PUD pages in the kernel mapping around the address where
+ * possible.
+ *
+ * Caller must flush TLB and free page tables queued on the list before
+ * touching the new entries. CPU must not see TLB entries of different size
+ * with different attributes.
+ */
+static int collapse_large_pages(unsigned long addr, struct list_head *pgtables)
+{
+	int collapsed = 0;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	addr &= PMD_MASK;
+
+	spin_lock(&pgd_lock);
+	pgd = pgd_offset_k(addr);
+	if (pgd_none(*pgd))
+		goto out;
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		goto out;
+	pud = pud_offset(p4d, addr);
+	if (!pud_present(*pud) || pud_leaf(*pud))
+		goto out;
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd) || pmd_leaf(*pmd))
+		goto out;
+
+	collapsed = collapse_pmd_page(pmd, addr, pgtables);
+	if (collapsed)
+		collapsed += collapse_pud_page(pud, addr, pgtables);
+
+out:
+	spin_unlock(&pgd_lock);
+	return collapsed;
+}
+
 static bool try_to_free_pte_page(pte_t *pte)
 {
 	int i;
@@ -2148,7 +2354,8 @@ int set_memory_p(unsigned long addr, int numpages)
 
 int set_memory_4k(unsigned long addr, int numpages)
 {
-	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
+	return change_page_attr_set_clr(&addr, numpages,
+					__pgprot(_PAGE_KERNEL_4K),
 					__pgprot(0), 1, 0, NULL);
 }
 
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f70d0958095c..5a37cb2b6f93 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -151,6 +151,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
+		DIRECT_MAP_LEVEL2_COLLAPSE,
+		DIRECT_MAP_LEVEL3_COLLAPSE,
 #endif
 #ifdef CONFIG_PER_VMA_LOCK_STATS
 		VMA_LOCK_SUCCESS,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4d016314a56c..d5e1d7f34f3c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1435,6 +1435,8 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
 	"direct_map_level3_splits",
+	"direct_map_level2_collapses",
+	"direct_map_level3_collapses",
 #endif
 #ifdef CONFIG_PER_VMA_LOCK_STATS
 	"vma_lock_success",
-- 
2.45.2


