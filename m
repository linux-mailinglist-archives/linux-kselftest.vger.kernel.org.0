Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE3B28DD33
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Oct 2020 11:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgJNJXH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 05:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbgJNJWy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:54 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9B3C0251B9
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 17:54:27 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id o15so238268uai.11
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 17:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc:content-transfer-encoding;
        bh=IzZGCID9b9HhzvZ8/RaJRTkHytRRFfTSaspmRMNwBaA=;
        b=eFflQM/+RG4BVBAYNVEyyuipSodkeK8wBPKcxdINO7USZ9W/P0l35dgH9vl1VIZeJ9
         bkiZQM7OsCg60ny6AwEjl2XwAPMh0AGcBwhyXH+Suu5GVLf9M2QF5n/qFt2CbJyBsVaP
         fwLS3MlHGuZvTfQkza3F8/AIzqsg+Gy4OLLQMsmJQ4gFMBbEG4khhuZPJ+qt2wkGS4/b
         8Ww9904eDDdSwERaVP8fqC1FRqmRHw1svdmTCUG8UxkTqoCm1gGL2523YVhvrT1zH/XD
         tXXjMs3ezBMgWipmuQy0W+MhUsjB6r4HZ5DMcPI0+jhBIa8a2TNELZ0LOr7Aeyiui0YP
         TQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc:content-transfer-encoding;
        bh=IzZGCID9b9HhzvZ8/RaJRTkHytRRFfTSaspmRMNwBaA=;
        b=OfjufXOfi6a8Sbl11fjOFEQdTUcBFfY3D6vBD4uIhfoimqy9GFWI1JBxg4MsueeQpT
         yenqYZbYE7FK9y9kcs8PJq23Sh1VVXizXZB/+xo6a3UaAotLa00mDsEXjaNvVJWNOA8o
         JyCru9o3UIg03+HfADtHqY+RuxDEGIJn6zb0JVMOLHsMR/pewnyzog8kZD0GCmUQdpET
         kVKj1S0cvF2I/CgBtKvCok65261vydpbVjGL0tkiwzNYLHvz5di3vzysXo05rtgBrKKf
         LvYrscrVzVvLhfchE3DZV9ZpxYZTpn8FBVHBS8n+VmhE79ylBIXCeBjxLhkQaePQtYNl
         ixCQ==
X-Gm-Message-State: AOAM533FUidVDX62vAgrEJY5ORV/naCwIjFERnNL2yYF99YdlcKP+sHJ
        fa9nwOc9cibMLvQQDNA7g+A6l++KB2VskC5Fww==
X-Google-Smtp-Source: ABdhPJyvWVIRplGNDjzvs0XGL0v2uPPAxCKlSxv45bumE3CxcrygOi7erdOIOjU1LBZ+S2o7fjKUgCNTdGy1u8o7iA==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a9f:3dc7:: with SMTP id
 e7mr1870481uaj.3.1602636866064; Tue, 13 Oct 2020 17:54:26 -0700 (PDT)
Date:   Wed, 14 Oct 2020 00:53:08 +0000
In-Reply-To: <20201014005320.2233162-1-kaleshsingh@google.com>
Message-Id: <20201014005320.2233162-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201014005320.2233162-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v4 3/5] mm: Speedup mremap on 1GB or larger regions
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kaleshsingh@google.com,
        kernel-team@android.com, kernel test robot <lkp@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Jia He <justin.he@arm.com>, John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Mina Almasry <almasrymina@google.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Android needs to move large memory regions for garbage collection.
The GC requires moving physical pages of multi-gigabyte heap
using mremap. During this move, the application threads have to
be paused for correctness. It is critical to keep this pause as
short as possible to avoid jitters during user interaction.

Optimize mremap for >=3D 1GB-sized regions by moving at the PUD/PGD
level if the source and destination addresses are PUD-aligned.
For CONFIG_PGTABLE_LEVELS =3D=3D 3, moving at the PUD level in effect moves
PGD entries, since the PUD entry is =E2=80=9Cfolded back=E2=80=9D onto the =
PGD entry.
Add HAVE_MOVE_PUD so that architectures where moving at the PUD level
isn't supported/tested can turn this off by not selecting the config.

Fix build test error from v1 of this series reported by
kernel test robot in [1].

[1] https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/CKP=
GL4FH4NG7TGH2CVYX2UX76L25BTA3/

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes in v2:
  - Update commit message with description of Android GC's use case.
  - Move set_pud_at() to a separate patch.
  - Use switch() instead of ifs in move_pgt_entry()
  - Fix build test error reported by kernel test robot on x86_64 in [1].
    Guard move_huge_pmd() with IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE),
    since this section doesn't get optimized out in the kernel test
    robot's build test when HAVE_MOVE_PUD is enabled.
  - Keep WARN_ON_ONCE(1) instead of BUILD_BUG() for the aforementioned
    reason.

Changes in v3:
  - Move get_old_pud() and alloc_new_pud() out of
    #ifdef CONFIG_HAVE_MOVE_PUD.
  - Have get_old_pmd() and alloc_new_pmd() use get_old_pud() and
    alloc_old_pud().
  - Use switch() in get_extent() instead of ifs.
  - Add BUILD_BUG() to default case of get_extent().
  - Replace #ifdef CONFIG_HAVE_MOVE_PMD/PUD in move_page_tables() with
    IS_ENABLED(CONFIG_HAVE_MOVE_PMD/PUD).
  - Make lines 80 cols or less, where they don=E2=80=99t need to be longer.
  - s/=3D  /=3D /g (Fixed double spaces after '=3D').

Changes in v4:
  - Add Kirill's Acked-by.

 arch/Kconfig |   7 ++
 mm/mremap.c  | 230 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 197 insertions(+), 40 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 76ec3395b843..79da6d714264 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -608,6 +608,13 @@ config HAVE_IRQ_TIME_ACCOUNTING
 	  Archs need to ensure they use a high enough resolution clock to
 	  support irq time accounting and then call enable_sched_clock_irqtime().
=20
+config HAVE_MOVE_PUD
+	bool
+	help
+	  Architectures that select this are able to move page tables at the
+	  PUD level. If there are only 3 page table levels, the move effectively
+	  happens at the PGD level.
+
 config HAVE_MOVE_PMD
 	bool
 	help
diff --git a/mm/mremap.c b/mm/mremap.c
index 138abbae4f75..078f731277b6 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -30,12 +30,11 @@
=20
 #include "internal.h"
=20
-static pmd_t *get_old_pmd(struct mm_struct *mm, unsigned long addr)
+static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
-	pmd_t *pmd;
=20
 	pgd =3D pgd_offset(mm, addr);
 	if (pgd_none_or_clear_bad(pgd))
@@ -49,6 +48,18 @@ static pmd_t *get_old_pmd(struct mm_struct *mm, unsigned=
 long addr)
 	if (pud_none_or_clear_bad(pud))
 		return NULL;
=20
+	return pud;
+}
+
+static pmd_t *get_old_pmd(struct mm_struct *mm, unsigned long addr)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pud =3D get_old_pud(mm, addr);
+	if (!pud)
+		return NULL;
+
 	pmd =3D pmd_offset(pud, addr);
 	if (pmd_none(*pmd))
 		return NULL;
@@ -56,19 +67,27 @@ static pmd_t *get_old_pmd(struct mm_struct *mm, unsigne=
d long addr)
 	return pmd;
 }
=20
-static pmd_t *alloc_new_pmd(struct mm_struct *mm, struct vm_area_struct *v=
ma,
+static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_struct *v=
ma,
 			    unsigned long addr)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
=20
 	pgd =3D pgd_offset(mm, addr);
 	p4d =3D p4d_alloc(mm, pgd, addr);
 	if (!p4d)
 		return NULL;
-	pud =3D pud_alloc(mm, p4d, addr);
+
+	return pud_alloc(mm, p4d, addr);
+}
+
+static pmd_t *alloc_new_pmd(struct mm_struct *mm, struct vm_area_struct *v=
ma,
+			    unsigned long addr)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pud =3D alloc_new_pud(mm, vma, addr);
 	if (!pud)
 		return NULL;
=20
@@ -249,14 +268,148 @@ static bool move_normal_pmd(struct vm_area_struct *v=
ma, unsigned long old_addr,
=20
 	return true;
 }
+#else
+static inline bool move_normal_pmd(struct vm_area_struct *vma,
+		unsigned long old_addr, unsigned long new_addr, pmd_t *old_pmd,
+		pmd_t *new_pmd)
+{
+	return false;
+}
 #endif
=20
+#ifdef CONFIG_HAVE_MOVE_PUD
+static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_=
addr,
+		  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
+{
+	spinlock_t *old_ptl, *new_ptl;
+	struct mm_struct *mm =3D vma->vm_mm;
+	pud_t pud;
+
+	/*
+	 * The destination pud shouldn't be established, free_pgtables()
+	 * should have released it.
+	 */
+	if (WARN_ON_ONCE(!pud_none(*new_pud)))
+		return false;
+
+	/*
+	 * We don't have to worry about the ordering of src and dst
+	 * ptlocks because exclusive mmap_lock prevents deadlock.
+	 */
+	old_ptl =3D pud_lock(vma->vm_mm, old_pud);
+	new_ptl =3D pud_lockptr(mm, new_pud);
+	if (new_ptl !=3D old_ptl)
+		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+
+	/* Clear the pud */
+	pud =3D *old_pud;
+	pud_clear(old_pud);
+
+	VM_BUG_ON(!pud_none(*new_pud));
+
+	/* Set the new pud */
+	set_pud_at(mm, new_addr, new_pud, pud);
+	flush_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
+	if (new_ptl !=3D old_ptl)
+		spin_unlock(new_ptl);
+	spin_unlock(old_ptl);
+
+	return true;
+}
+#else
+static inline bool move_normal_pud(struct vm_area_struct *vma,
+		unsigned long old_addr, unsigned long new_addr, pud_t *old_pud,
+		pud_t *new_pud)
+{
+	return false;
+}
+#endif
+
+enum pgt_entry {
+	NORMAL_PMD,
+	HPAGE_PMD,
+	NORMAL_PUD,
+};
+
+/*
+ * Returns an extent of the corresponding size for the pgt_entry specified=
 if
+ * valid. Else returns a smaller extent bounded by the end of the source a=
nd
+ * destination pgt_entry.
+ */
+static unsigned long get_extent(enum pgt_entry entry, unsigned long old_ad=
dr,
+			unsigned long old_end, unsigned long new_addr)
+{
+	unsigned long next, extent, mask, size;
+
+	switch (entry) {
+	case HPAGE_PMD:
+	case NORMAL_PMD:
+		mask =3D PMD_MASK;
+		size =3D PMD_SIZE;
+		break;
+	case NORMAL_PUD:
+		mask =3D PUD_MASK;
+		size =3D PUD_SIZE;
+		break;
+	default:
+		BUILD_BUG();
+		break;
+	}
+
+	next =3D (old_addr + size) & mask;
+	/* even if next overflowed, extent below will be ok */
+	extent =3D (next > old_end) ? old_end - old_addr : next - old_addr;
+	next =3D (new_addr + size) & mask;
+	if (extent > next - new_addr)
+		extent =3D next - new_addr;
+	return extent;
+}
+
+/*
+ * Attempts to speedup the move by moving entry at the level corresponding=
 to
+ * pgt_entry. Returns true if the move was successful, else false.
+ */
+static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vm=
a,
+			unsigned long old_addr, unsigned long new_addr,
+			void *old_entry, void *new_entry, bool need_rmap_locks)
+{
+	bool moved =3D false;
+
+	/* See comment in move_ptes() */
+	if (need_rmap_locks)
+		take_rmap_locks(vma);
+
+	switch (entry) {
+	case NORMAL_PMD:
+		moved =3D move_normal_pmd(vma, old_addr, new_addr, old_entry,
+					new_entry);
+		break;
+	case NORMAL_PUD:
+		moved =3D move_normal_pud(vma, old_addr, new_addr, old_entry,
+					new_entry);
+		break;
+	case HPAGE_PMD:
+		moved =3D IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+			move_huge_pmd(vma, old_addr, new_addr, old_entry,
+				      new_entry);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+
+	if (need_rmap_locks)
+		drop_rmap_locks(vma);
+
+	return moved;
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
 		bool need_rmap_locks)
 {
-	unsigned long extent, next, old_end;
+	unsigned long extent, old_end;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
=20
@@ -269,53 +422,50 @@ unsigned long move_page_tables(struct vm_area_struct =
*vma,
=20
 	for (; old_addr < old_end; old_addr +=3D extent, new_addr +=3D extent) {
 		cond_resched();
-		next =3D (old_addr + PMD_SIZE) & PMD_MASK;
-		/* even if next overflowed, extent below will be ok */
-		extent =3D next - old_addr;
-		if (extent > old_end - old_addr)
-			extent =3D old_end - old_addr;
-		next =3D (new_addr + PMD_SIZE) & PMD_MASK;
-		if (extent > next - new_addr)
-			extent =3D next - new_addr;
+		/*
+		 * If extent is PUD-sized try to speed up the move by moving at the
+		 * PUD level if possible.
+		 */
+		extent =3D get_extent(NORMAL_PUD, old_addr, old_end, new_addr);
+		if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent =3D=3D PUD_SIZE) {
+			pud_t *old_pud, *new_pud;
+
+			old_pud =3D get_old_pud(vma->vm_mm, old_addr);
+			if (!old_pud)
+				continue;
+			new_pud =3D alloc_new_pud(vma->vm_mm, vma, new_addr);
+			if (!new_pud)
+				break;
+			if (move_pgt_entry(NORMAL_PUD, vma, old_addr, new_addr,
+					   old_pud, new_pud, need_rmap_locks))
+				continue;
+		}
+
+		extent =3D get_extent(NORMAL_PMD, old_addr, old_end, new_addr);
 		old_pmd =3D get_old_pmd(vma->vm_mm, old_addr);
 		if (!old_pmd)
 			continue;
 		new_pmd =3D alloc_new_pmd(vma->vm_mm, vma, new_addr);
 		if (!new_pmd)
 			break;
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) || pmd_devmap(*old=
_pmd)) {
-			if (extent =3D=3D HPAGE_PMD_SIZE) {
-				bool moved;
-				/* See comment in move_ptes() */
-				if (need_rmap_locks)
-					take_rmap_locks(vma);
-				moved =3D move_huge_pmd(vma, old_addr, new_addr,
-						      old_pmd, new_pmd);
-				if (need_rmap_locks)
-					drop_rmap_locks(vma);
-				if (moved)
-					continue;
-			}
+		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
+		    pmd_devmap(*old_pmd)) {
+			if (extent =3D=3D HPAGE_PMD_SIZE &&
+			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
+					   old_pmd, new_pmd, need_rmap_locks))
+				continue;
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
-		} else if (extent =3D=3D PMD_SIZE) {
-#ifdef CONFIG_HAVE_MOVE_PMD
+		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
+			   extent =3D=3D PMD_SIZE) {
 			/*
 			 * If the extent is PMD-sized, try to speed the move by
 			 * moving at the PMD level if possible.
 			 */
-			bool moved;
-
-			if (need_rmap_locks)
-				take_rmap_locks(vma);
-			moved =3D move_normal_pmd(vma, old_addr, new_addr,
-						old_pmd, new_pmd);
-			if (need_rmap_locks)
-				drop_rmap_locks(vma);
-			if (moved)
+			if (move_pgt_entry(NORMAL_PMD, vma, old_addr, new_addr,
+					   old_pmd, new_pmd, need_rmap_locks))
 				continue;
-#endif
 		}
=20
 		if (pte_alloc(new_vma->vm_mm, new_pmd))
--=20
2.28.0.1011.ga647a8990f-goog

