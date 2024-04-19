Return-Path: <linux-kselftest+bounces-8407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60338AA968
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 09:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932382843AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 07:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3482F4B5DA;
	Fri, 19 Apr 2024 07:44:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579FC15D;
	Fri, 19 Apr 2024 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512646; cv=none; b=TyiGBcfXeD84R7GlaaTeVVYkW6m0upB9NwoadIRaNIufW5pYadC1X0WAH+37WHT030HitPyxtaG34LVNu5uk4C7QqODNWI8ja1cQyjm1XqoMDJZGTYneJ14qgVtNITJSiZ1KT1/JgAF038XasHdVEnTVDefskgmL7UnWPMT/Wv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512646; c=relaxed/simple;
	bh=hAY0+3UrRpRD+oKDHhysTAMhrmtmVoJ4mxOOyBbhG0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iee6kPKZsVGbHzBKFX8rcW5yXww4IkEnYelJhEnb3w9teaJfww92ZGR7/ZXTvf45FYaDd/VyDQ0fGQCR26vjSGjyb9ppx1LiPagRSmf0NhTQ6hFg1JtOwxZdEA83FfEd/PxHxJo/wI3GLpTAHTGuuVXdYUJvp19oW4lNx5XK+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C18F339;
	Fri, 19 Apr 2024 00:44:26 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D9543F792;
	Fri, 19 Apr 2024 00:43:55 -0700 (PDT)
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
Subject: [PATCH v1 1/5] arm64/mm: Move PTE_PROT_NONE and PMD_PRESENT_INVALID
Date: Fri, 19 Apr 2024 08:43:40 +0100
Message-Id: <20240419074344.2643212-2-ryan.roberts@arm.com>
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

Previously PTE_PROT_NONE was occupying bit 58, one of the bits reserved
for SW use when the PTE is valid. This is a waste of those precious SW
bits since PTE_PROT_NONE can only ever be set when valid is clear.
Instead let's overlay it on what would be a HW bit if valid was set.

We need to be careful about which HW bit to choose since some of them
must be preserved; when pte_present() is true (as it is for a
PTE_PROT_NONE pte), it is legitimate for the core to call various
accessors, e.g. pte_dirty(), pte_write() etc. There are also some
accessors that are private to the arch which must continue to be
honoured, e.g. pte_user(), pte_user_exec() etc.

So we choose to overlay PTE_UXN; This effectively means that whenever a
pte has PTE_PROT_NONE set, it will always report pte_user_exec() ==
false, which is obviously always correct.

As a result of this change, we must shuffle the layout of the
arch-specific swap pte so that PTE_PROT_NONE is always zero and not
overlapping with any other field. As a result of this, there is no way
to keep the `type` field contiguous without conflicting with
PMD_PRESENT_INVALID (bit 59), which must also be 0 for a swap pte. So
let's move PMD_PRESENT_INVALID to bit 60.

In the end, this frees up bit 58 for future use as a proper SW bit (e.g.
soft-dirty or uffd-wp).

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h |  4 ++--
 arch/arm64/include/asm/pgtable.h      | 16 +++++++++-------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index dd9ee67d1d87..ef952d69fd04 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -18,14 +18,14 @@
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
-#define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
+#define PTE_PROT_NONE		(PTE_UXN)		 /* Reuse PTE_UXN; only when !PTE_VALID */

 /*
  * This bit indicates that the entry is present i.e. pmd_page()
  * still points to a valid huge page in memory even if the pmd
  * has been invalidated.
  */
-#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
+#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 60) /* only when !PMD_SECT_VALID */

 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index afdd56d26ad7..23aabff4fa6f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1248,20 +1248,22 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
  *	bits 2:		remember PG_anon_exclusive
- *	bits 3-7:	swap type
- *	bits 8-57:	swap offset
- *	bit  58:	PTE_PROT_NONE (must be zero)
+ *	bits 4-53:	swap offset
+ *	bit  54:	PTE_PROT_NONE (overlays PTE_UXN) (must be zero)
+ *	bits 55-59:	swap type
+ *	bit  60:	PMD_PRESENT_INVALID (must be zero)
  */
-#define __SWP_TYPE_SHIFT	3
+#define __SWP_TYPE_SHIFT	55
 #define __SWP_TYPE_BITS		5
-#define __SWP_OFFSET_BITS	50
 #define __SWP_TYPE_MASK		((1 << __SWP_TYPE_BITS) - 1)
-#define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
+#define __SWP_OFFSET_SHIFT	4
+#define __SWP_OFFSET_BITS	50
 #define __SWP_OFFSET_MASK	((1UL << __SWP_OFFSET_BITS) - 1)

 #define __swp_type(x)		(((x).val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK)
 #define __swp_offset(x)		(((x).val >> __SWP_OFFSET_SHIFT) & __SWP_OFFSET_MASK)
-#define __swp_entry(type,offset) ((swp_entry_t) { ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
+#define __swp_entry(type, offset) ((swp_entry_t) { ((unsigned long)(type) << __SWP_TYPE_SHIFT) | \
+						   ((unsigned long)(offset) << __SWP_OFFSET_SHIFT) })

 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
--
2.25.1


