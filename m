Return-Path: <linux-kselftest+bounces-8408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF00C8AA969
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 09:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D3B1C21CF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8EA4C3D0;
	Fri, 19 Apr 2024 07:44:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9054D59F;
	Fri, 19 Apr 2024 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512646; cv=none; b=i7KIWY3wCOen43icUWUuDaSpyl5Lawz0k5x3LeZSYmZtSjeQaXLnwVT1p4FBaC55LBeTdQtGqo7REnJdglxG/BYvn3aDJxE75XCQzoINf4QDy5atYaD2DoLgIXUiTwW6t6IgpNAbYVvNyANdFl1KTRTTYcaiux3UlgG8VtMQUdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512646; c=relaxed/simple;
	bh=MueeC5vDWlU6BfPLsZeHCIT7LcwiULET6ke/0rRi0AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fxJhJDWvLFVQeGEv8wQ8g+k0YzFpBbQs6lsKB02FDMVMN3+agwZ60ocdZAm6st5qVyRq7QFr9PPwBUhQhBB+FeRhK3FQrIU9eptpajbG44ulI+PXT7n+AaZDszt8X3xZaV0czdLjFrV960i8O1qFUoXkC3Mx2SzGWuO1UY3KQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60ECC1424;
	Fri, 19 Apr 2024 00:44:31 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E73D03F792;
	Fri, 19 Apr 2024 00:44:00 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Shivansh Vij <shivanshvij@outlook.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 3/5] arm64/mm: Add soft-dirty page tracking support
Date: Fri, 19 Apr 2024 08:43:42 +0100
Message-Id: <20240419074344.2643212-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419074344.2643212-1-ryan.roberts@arm.com>
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the final remaining PTE SW bit (63) for soft-dirty tracking. The
standard handlers are implemented for set/test/clear for both pte and
pmd. Additionally we must also track the soft-dirty state as a pte swp
bit, so use a free swap entry pte bit (61).

There are a few complexities worth calling out:

  - The semantic of soft-dirty calls for having it auto-set by
    pte_mkdirty(). But the arch code would previously call pte_mkdirty()
    for various house-keeping operations such as gathering dirty bits
    into a pte across a contpte block. These operations must not cause
    soft-dirty to be set. So an internal version, __pte_mkdirty(), has
    been created that does not manipulate soft-dirty, and pte_mkdirty()
    is now a wrapper around that, which also sets the soft-dirty bit.

  - For a region with soft-dirty tracking enabled, it works by
    wrprotecting the ptes, causing a write to fault, where the handler
    calls pte_mkdirty(ptep_get()) (which causes soft-dirty to be set),
    then the resulting pte is written back with ptep_set_access_flags().
    So the arm64 version of ptep_set_access_flags() now needs to
    explicitly also set the soft-dirty bit to prevent loss.

The patch is very loosely based on a similar patch posted by Shivansh
Vij <shivanshvij@outlook.com>, at the below link.

Primary motivation for adding soft-dirty support is to allow
Checkpoint-Restore in Userspace (CRIU) to be able to track a memory
page's changes if we want to enable pre-dumping, which is important for
live migration.

Link: https://lore.kernel.org/linux-arm-kernel/MW4PR12MB687563EFB56373E8D55DDEABB92B2@MW4PR12MB6875.namprd12.prod.outlook.com/
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/pgtable-prot.h |  8 +++++
 arch/arm64/include/asm/pgtable.h      | 47 +++++++++++++++++++++++++--
 arch/arm64/mm/contpte.c               |  6 ++--
 arch/arm64/mm/fault.c                 |  3 +-
 arch/arm64/mm/hugetlbpage.c           |  6 ++--
 6 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 763e221f2169..3a5e22208e38 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -178,6 +178,7 @@ config ARM64
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_SOFT_DIRTY
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index f1e1f6306e03..7fce22ed3fda 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -28,6 +28,14 @@
 #define PTE_SWP_UFFD_WP		(_AT(pteval_t, 0))
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */

+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define PTE_SOFT_DIRTY		(_AT(pteval_t, 1) << 63) /* soft-dirty tracking */
+#define PTE_SWP_SOFT_DIRTY	(_AT(pteval_t, 1) << 61) /* only for swp ptes */
+#else
+#define PTE_SOFT_DIRTY		(_AT(pteval_t, 0))
+#define PTE_SWP_SOFT_DIRTY	(_AT(pteval_t, 0))
+#endif /* CONFIG_MEM_SOFT_DIRTY */
+
 /*
  * This bit indicates that the entry is present i.e. pmd_page()
  * still points to a valid huge page in memory even if the pmd
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3f4748741fdb..0118e6e0adde 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -114,6 +114,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
 #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
 #define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
+#define pte_soft_dirty(pte)	(!!(pte_val(pte) & PTE_SOFT_DIRTY))
 #define pte_tagged(pte)		((pte_val(pte) & PTE_ATTRINDX_MASK) == \
 				 PTE_ATTRINDX(MT_NORMAL_TAGGED))

@@ -206,7 +207,7 @@ static inline pte_t pte_mkclean(pte_t pte)
 	return pte;
 }

-static inline pte_t pte_mkdirty(pte_t pte)
+static inline pte_t __pte_mkdirty(pte_t pte)
 {
 	pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));

@@ -216,6 +217,11 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	return pte;
 }

+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte_mkdirty(set_pte_bit(pte, __pgprot(PTE_SOFT_DIRTY)));
+}
+
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	/*
@@ -299,6 +305,16 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
 }
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */

+static inline pte_t pte_mksoft_dirty(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(PTE_SOFT_DIRTY));
+}
+
+static inline pte_t pte_clear_soft_dirty(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(PTE_SOFT_DIRTY));
+}
+
 static inline void __set_pte(pte_t *ptep, pte_t pte)
 {
 	WRITE_ONCE(*ptep, pte);
@@ -508,6 +524,21 @@ static inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
 }
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */

+static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(PTE_SWP_SOFT_DIRTY));
+}
+
+static inline bool pte_swp_soft_dirty(pte_t pte)
+{
+	return !!(pte_val(pte) & PTE_SWP_SOFT_DIRTY);
+}
+
+static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(PTE_SWP_SOFT_DIRTY));
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * See the comment in include/linux/pgtable.h
@@ -562,6 +593,15 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #define pmd_swp_clear_uffd_wp(pmd) \
 				pte_pmd(pte_swp_clear_uffd_wp(pmd_pte(pmd)))
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+#define pmd_soft_dirty(pmd)	pte_soft_dirty(pmd_pte(pmd))
+#define pmd_mksoft_dirty(pmd)	pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
+#define pmd_clear_soft_dirty(pmd) \
+				pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)))
+#define pmd_swp_soft_dirty(pmd)	pte_swp_soft_dirty(pmd_pte(pmd))
+#define pmd_swp_mksoft_dirty(pmd) \
+				pte_pmd(pte_swp_mksoft_dirty(pmd_pte(pmd)))
+#define pmd_swp_clear_soft_dirty(pmd) \
+				pte_pmd(pte_swp_clear_soft_dirty(pmd_pte(pmd)))

 static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 {
@@ -1093,7 +1133,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 * dirtiness again.
 	 */
 	if (pte_sw_dirty(pte))
-		pte = pte_mkdirty(pte);
+		pte = __pte_mkdirty(pte);
 	return pte;
 }

@@ -1228,7 +1268,7 @@ static inline pte_t __get_and_clear_full_ptes(struct mm_struct *mm,
 		addr += PAGE_SIZE;
 		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
 		if (pte_dirty(tmp_pte))
-			pte = pte_mkdirty(pte);
+			pte = __pte_mkdirty(pte);
 		if (pte_young(tmp_pte))
 			pte = pte_mkyoung(pte);
 	}
@@ -1307,6 +1347,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  *	bit  54:	PTE_PROT_NONE (overlays PTE_UXN) (must be zero)
  *	bits 55-59:	swap type
  *	bit  60:	PMD_PRESENT_INVALID (must be zero)
+ *	bit  61:	remember soft-dirty state
  */
 #define __SWP_TYPE_SHIFT	55
 #define __SWP_TYPE_BITS		5
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 1b64b4c3f8bf..c6f52fcf5d9a 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -62,7 +62,7 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
 		pte_t ptent = __ptep_get_and_clear(mm, addr, ptep);

 		if (pte_dirty(ptent))
-			pte = pte_mkdirty(pte);
+			pte = __pte_mkdirty(pte);

 		if (pte_young(ptent))
 			pte = pte_mkyoung(pte);
@@ -170,7 +170,7 @@ pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
 		pte = __ptep_get(ptep);

 		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
+			orig_pte = __pte_mkdirty(orig_pte);

 		if (pte_young(pte))
 			orig_pte = pte_mkyoung(orig_pte);
@@ -227,7 +227,7 @@ pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
 			goto retry;

 		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
+			orig_pte = __pte_mkdirty(orig_pte);

 		if (pte_young(pte))
 			orig_pte = pte_mkyoung(orig_pte);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8251e2fea9c7..678171fd88bd 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -220,7 +220,8 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
 		return 0;

 	/* only preserve the access flags and write permission */
-	pte_val(entry) &= PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY;
+	pte_val(entry) &= PTE_RDONLY | PTE_AF | PTE_WRITE |
+			  PTE_DIRTY | PTE_SOFT_DIRTY;

 	/*
 	 * Setting the flags must be done atomically to avoid racing with the
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0f0e10bb0a95..4605eb146a2f 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -155,7 +155,7 @@ pte_t huge_ptep_get(pte_t *ptep)
 		pte_t pte = __ptep_get(ptep);

 		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
+			orig_pte = __pte_mkdirty(orig_pte);

 		if (pte_young(pte))
 			orig_pte = pte_mkyoung(orig_pte);
@@ -189,7 +189,7 @@ static pte_t get_clear_contig(struct mm_struct *mm,
 		 * so check them all.
 		 */
 		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
+			orig_pte = __pte_mkdirty(orig_pte);

 		if (pte_young(pte))
 			orig_pte = pte_mkyoung(orig_pte);
@@ -464,7 +464,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,

 	/* Make sure we don't lose the dirty or young state */
 	if (pte_dirty(orig_pte))
-		pte = pte_mkdirty(pte);
+		pte = __pte_mkdirty(pte);

 	if (pte_young(orig_pte))
 		pte = pte_mkyoung(pte);
--
2.25.1


