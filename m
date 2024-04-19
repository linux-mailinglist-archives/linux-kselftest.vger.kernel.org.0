Return-Path: <linux-kselftest+bounces-8410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D618AA96D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 09:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13BD28442B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 07:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4358119;
	Fri, 19 Apr 2024 07:44:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9604EB54;
	Fri, 19 Apr 2024 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512648; cv=none; b=icsuOR7TpGaiUagtgvpCjYwKNb8R1lnvmT5JZB2dq1bKkL5Zb+Qxx6aGOTj7pZx1G/4T6lcLjg21PVUk3WVYTTi6IjuqzMMuEMJ3xPqwYeBajwJJcerVnVKYd9xHjXeU7Y0nxoDnKCMxUEdCA+yOOp0b4ia8dbxWpHVL2gJh5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512648; c=relaxed/simple;
	bh=cFCB0HW1F8i4RqJKFYQAyHsEBSwyxzhxB8bvV/tDs0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bjLjKpnwMuoAT17hGxEc7BQ6xb/q35P81jcE+cupFKPmjiS/up6w/ZrEMuNxbF6gqlS8OjP1LKnH6wUw/qCmsRxmhRrXLBoN1mm4wt5D1wT+YWxVcsyuLRyQk1cw9Q3iL0uHxBEnnZl3malrpnOqfh+D4S5k6GpZUfRG6XgbPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8C9D106F;
	Fri, 19 Apr 2024 00:44:28 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A6E63F792;
	Fri, 19 Apr 2024 00:43:58 -0700 (PDT)
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
Subject: [PATCH v1 2/5] arm64/mm: Add uffd write-protect support
Date: Fri, 19 Apr 2024 08:43:41 +0100
Message-Id: <20240419074344.2643212-3-ryan.roberts@arm.com>
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

Let's use the newly-free PTE SW bit (58) to add support for uffd-wp.

The standard handlers are implemented for set/test/clear for both pte
and pmd. Additionally we must also track the uffd-wp state as a pte swp
bit, so use a free swap entry pte bit (3).

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/pgtable-prot.h |  8 ++++
 arch/arm64/include/asm/pgtable.h      | 55 +++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..763e221f2169 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -255,6 +255,7 @@ config ARM64
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
+	select HAVE_ARCH_USERFAULTFD_WP if USERFAULTFD
 	select TRACE_IRQFLAGS_SUPPORT
 	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select HAVE_SOFTIRQ_ON_OWN_STACK
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index ef952d69fd04..f1e1f6306e03 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -20,6 +20,14 @@
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 #define PTE_PROT_NONE		(PTE_UXN)		 /* Reuse PTE_UXN; only when !PTE_VALID */

+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+#define PTE_UFFD_WP		(_AT(pteval_t, 1) << 58) /* uffd-wp tracking */
+#define PTE_SWP_UFFD_WP		(_AT(pteval_t, 1) << 3)	 /* only for swp ptes */
+#else
+#define PTE_UFFD_WP		(_AT(pteval_t, 0))
+#define PTE_SWP_UFFD_WP		(_AT(pteval_t, 0))
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+
 /*
  * This bit indicates that the entry is present i.e. pmd_page()
  * still points to a valid huge page in memory even if the pmd
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 23aabff4fa6f..3f4748741fdb 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -271,6 +271,34 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
 }

+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+static inline int pte_uffd_wp(pte_t pte)
+{
+	bool wp = !!(pte_val(pte) & PTE_UFFD_WP);
+
+#ifdef CONFIG_DEBUG_VM
+	/*
+	 * Having write bit for wr-protect-marked present ptes is fatal, because
+	 * it means the uffd-wp bit will be ignored and write will just go
+	 * through. See comment in x86 implementation.
+	 */
+	WARN_ON_ONCE(wp && pte_write(pte));
+#endif
+
+	return wp;
+}
+
+static inline pte_t pte_mkuffd_wp(pte_t pte)
+{
+	return pte_wrprotect(set_pte_bit(pte, __pgprot(PTE_UFFD_WP)));
+}
+
+static inline pte_t pte_clear_uffd_wp(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(PTE_UFFD_WP));
+}
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+
 static inline void __set_pte(pte_t *ptep, pte_t pte)
 {
 	WRITE_ONCE(*ptep, pte);
@@ -463,6 +491,23 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return clear_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
 }

+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+static inline pte_t pte_swp_mkuffd_wp(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(PTE_SWP_UFFD_WP));
+}
+
+static inline int pte_swp_uffd_wp(pte_t pte)
+{
+	return !!(pte_val(pte) & PTE_SWP_UFFD_WP);
+}
+
+static inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(PTE_SWP_UFFD_WP));
+}
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * See the comment in include/linux/pgtable.h
@@ -508,6 +553,15 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+#define pmd_uffd_wp(pmd)	pte_uffd_wp(pmd_pte(pmd))
+#define pmd_mkuffd_wp(pmd)	pte_pmd(pte_mkuffd_wp(pmd_pte(pmd)))
+#define pmd_clear_uffd_wp(pmd)	pte_pmd(pte_clear_uffd_wp(pmd_pte(pmd)))
+#define pmd_swp_uffd_wp(pmd)	pte_swp_uffd_wp(pmd_pte(pmd))
+#define pmd_swp_mkuffd_wp(pmd)	pte_pmd(pte_swp_mkuffd_wp(pmd_pte(pmd)))
+#define pmd_swp_clear_uffd_wp(pmd) \
+				pte_pmd(pte_swp_clear_uffd_wp(pmd_pte(pmd)))
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */

 static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 {
@@ -1248,6 +1302,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
  *	bits 2:		remember PG_anon_exclusive
+ *	bit  3:		remember uffd-wp state
  *	bits 4-53:	swap offset
  *	bit  54:	PTE_PROT_NONE (overlays PTE_UXN) (must be zero)
  *	bits 55-59:	swap type
--
2.25.1


