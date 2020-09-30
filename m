Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04AD27F507
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 00:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbgI3WWK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Sep 2020 18:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgI3WWJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Sep 2020 18:22:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC28C061755
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 15:22:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e2so3172866ybc.17
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc:content-transfer-encoding;
        bh=5bHwRAkIFgRUKgngW4gcP068wEdPRj/cA85ER5ge5+w=;
        b=uc1lC+BRciNCCenfHEg9UpdZN5PsHA6dts/eMegcTHFRbNmxAt+14yp2sd85qBnhWS
         /iQ6LFsh4BgYcnuYARjFzrcEz/ZOnAaRHA8vceh6iMmgL2CcCA1ShQXN6A0EkeRzto87
         XP2ahfz3G1rWtHeMk2Iie02Bh5Bh0tv3f3+acB7crNXPg47WZEE6HxKCeN+Ddv1yICAG
         sReM4qnVO2nhs3CV0JpJOlQduy3bOPn+tHSdXaPjkP+C6Geq901I1kmdC3Y2kNiZU8q4
         1q6YqqR+HGbk++rIzTfi4ZkgncraaFN0QqjeC/1v+W4BQT1+gF6vukHux4c1ngvQ68DW
         nFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc:content-transfer-encoding;
        bh=5bHwRAkIFgRUKgngW4gcP068wEdPRj/cA85ER5ge5+w=;
        b=Gb4eGsGQA9FWvS+vR//F8rrx0TXyBIN++ItGk/sDaD4fzTKXpMIUocCI4g6M73DQSi
         rH8ZxEuySf8gXaqahszIR9qAMGCWyUYo7RXL8UiRllNrZfZQJJVW3CLXhUd42XDdk+yt
         Lamz/lo2LB2QbRBfEMIFGJsDUVJSOGTmdATB4CoOQ1kCIX5yj9dYglngJcuUXCUo5hXW
         9LoOTMYE9b48q0T3rbpl9fkQcqWqcn65fV7JC/bMRxOB5wGLEVza318oi7ljG9tTyZH5
         hnRPHYzIAryk+TCjoc91MoG1Ec9T7R2FYksm8E/jvGe7ZXFara/ZR9uaxSoEex3Qa30Q
         iIpA==
X-Gm-Message-State: AOAM533YqiMJ80M8KhNZ/N3JsMtJIhfffZdlfNi8sHjb0fJRHHQXpN/K
        MNt1F1bUH4/Dbf8S4WMlYg7jQz9tg0sPqYkmdQ==
X-Google-Smtp-Source: ABdhPJwBYpAmlRALKHYyir3OblZbIEhsgUn0acpHu8aRfQEb5kag4nDCQqATpwKZEagaltStuNxSB3SptnIGiDEZdw==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a25:5d8:: with SMTP id
 207mr6822598ybf.444.1601504527236; Wed, 30 Sep 2020 15:22:07 -0700 (PDT)
Date:   Wed, 30 Sep 2020 22:21:20 +0000
In-Reply-To: <20200930222130.4175584-1-kaleshsingh@google.com>
Message-Id: <20200930222130.4175584-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH 3/5] mm: Speedup mremap on 1GB or larger regions
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kaleshsingh@google.com,
        kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jia He <justin.he@arm.com>, Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Brian Geffon <bgeffon@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Optimize mremap for >=3D 1GB-sized regions by moving at the PUD/PGD
level if the source and destination addresses are PUD-aligned.
For CONFIG_PGTABLE_LEVELS =3D=3D 3, moving at the PUD level in effect moves
PGD entries, since the PUD entry is =E2=80=9Cfolded back=E2=80=9D onto the =
PGD entry.
Add HAVE_MOVE_PUD so that architectures where moving at the PUD level
isn't supported/tested can turn this off by not selecting the config.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/Kconfig                     |   7 +
 arch/arm64/include/asm/pgtable.h |   1 +
 mm/mremap.c                      | 211 ++++++++++++++++++++++++++-----
 3 files changed, 189 insertions(+), 30 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index af14a567b493..5eabaa00bf9b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -602,6 +602,13 @@ config HAVE_IRQ_TIME_ACCOUNTING
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
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgta=
ble.h
index d5d3fbe73953..8848125e3024 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -415,6 +415,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PA=
GE_SHIFT) | pgprot_val(prot))
=20
 #define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp=
, pmd_pte(pmd))
+#define set_pud_at(mm, addr, pudp, pud)	set_pte_at(mm, addr, (pte_t *)pudp=
, pud_pte(pud))
=20
 #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
 #define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)
diff --git a/mm/mremap.c b/mm/mremap.c
index 138abbae4f75..a5a1440bd366 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -249,14 +249,167 @@ static bool move_normal_pmd(struct vm_area_struct *v=
ma, unsigned long old_addr,
=20
 	return true;
 }
+#else
+static inline bool move_normal_pmd(struct vm_area_struct *vma, unsigned lo=
ng old_addr,
+		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
+{
+	return false;
+}
 #endif
=20
+#ifdef CONFIG_HAVE_MOVE_PUD
+static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+
+	pgd =3D pgd_offset(mm, addr);
+	if (pgd_none_or_clear_bad(pgd))
+		return NULL;
+
+	p4d =3D p4d_offset(pgd, addr);
+	if (p4d_none_or_clear_bad(p4d))
+		return NULL;
+
+	pud =3D pud_offset(p4d, addr);
+	if (pud_none_or_clear_bad(pud))
+		return NULL;
+
+	return pud;
+}
+
+static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_struct *v=
ma,
+			    unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+
+	pgd =3D pgd_offset(mm, addr);
+	p4d =3D p4d_alloc(mm, pgd, addr);
+	if (!p4d)
+		return NULL;
+	pud =3D pud_alloc(mm, p4d, addr);
+	if (!pud)
+		return NULL;
+
+	return pud;
+}
+
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
+static inline bool move_normal_pud(struct vm_area_struct *vma, unsigned lo=
ng old_addr,
+		  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
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
 if valid.
+ * Else returns a smaller extent bounded by the end of the source and dest=
ination
+ * pgt_entry. Returns 0 if an invalid pgt_entry is specified.
+ */
+static unsigned long get_extent(enum pgt_entry entry, unsigned long old_ad=
dr,
+			unsigned long old_end, unsigned long new_addr)
+{
+	unsigned long next, extent, mask, size;
+
+	if (entry =3D=3D NORMAL_PMD || entry =3D=3D HPAGE_PMD) {
+		mask =3D PMD_MASK;
+		size =3D PMD_SIZE;
+	} else if (entry =3D=3D NORMAL_PUD) {
+		mask =3D PUD_MASK;
+		size =3D PUD_SIZE;
+	} else
+		return 0;
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
+			unsigned long old_addr, unsigned long new_addr, void *old_entry,
+			void *new_entry, bool need_rmap_locks)
+{
+	bool moved =3D false;
+
+	/* See comment in move_ptes() */
+	if (need_rmap_locks)
+		take_rmap_locks(vma);
+	if (entry =3D=3D NORMAL_PMD)
+		moved =3D  move_normal_pmd(vma, old_addr, new_addr, old_entry, new_entry=
);
+	else if (entry =3D=3D NORMAL_PUD)
+		moved =3D  move_normal_pud(vma, old_addr, new_addr, old_entry, new_entry=
);
+	else if (entry =3D=3D HPAGE_PMD)
+		moved =3D  move_huge_pmd(vma, old_addr, new_addr, old_entry, new_entry);
+	else
+		WARN_ON_ONCE(1);
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
@@ -269,14 +422,27 @@ unsigned long move_page_tables(struct vm_area_struct =
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
+#ifdef CONFIG_HAVE_MOVE_PUD
+		/*
+		 * If extent is PUD-sized try to speed up the move by moving at the
+		 * PUD level if possible.
+		 */
+		extent =3D get_extent(NORMAL_PUD, old_addr, old_end, new_addr);
+		if (extent =3D=3D PUD_SIZE) {
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
+#endif
+		extent =3D get_extent(NORMAL_PMD, old_addr, old_end, new_addr);
 		old_pmd =3D get_old_pmd(vma->vm_mm, old_addr);
 		if (!old_pmd)
 			continue;
@@ -284,18 +450,10 @@ unsigned long move_page_tables(struct vm_area_struct =
*vma,
 		if (!new_pmd)
 			break;
 		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) || pmd_devmap(*old=
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
+			if (extent =3D=3D HPAGE_PMD_SIZE &&
+			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr, old_pmd,
+					   new_pmd, need_rmap_locks))
+				continue;
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
@@ -305,15 +463,8 @@ unsigned long move_page_tables(struct vm_area_struct *=
vma,
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
+			if (move_pgt_entry(NORMAL_PMD, vma, old_addr, new_addr, old_pmd,
+					   new_pmd, need_rmap_locks))
 				continue;
 #endif
 		}
--=20
2.28.0.709.gb0816b6eb0-goog

