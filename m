Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F2B25B251
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 18:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgIBQ6m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 12:58:42 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10769 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbgIBQ6j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 12:58:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4fcebc0000>; Wed, 02 Sep 2020 09:56:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 09:58:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 02 Sep 2020 09:58:36 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 16:58:35 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Sep 2020 16:58:35 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4fcf3b0003>; Wed, 02 Sep 2020 09:58:35 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 1/7] mm/thp: fix __split_huge_pmd_locked() for migration PMD
Date:   Wed, 2 Sep 2020 09:58:24 -0700
Message-ID: <20200902165830.5367-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200902165830.5367-1-rcampbell@nvidia.com>
References: <20200902165830.5367-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599065788; bh=rYznWX/3ek3S83R/7nq7shz57nrdV/4Q+HZHpdHukkI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=UuV7rEAutskEk3OCoCdPdBe6gOlmH/ZAhnWtJDfMYT0NTh+pvndsN15Tz3easb3Ns
         Rw1AZsD/UIX3dsS6tZs9MF8t4KZk4EkyC9a/zfDNF91ULaQYYwgWo+1lyQw6ghegAj
         7b1+UKbB1rIZUMGwJ393qEydUIxuKq2enGDw3lxEdWnd1NFYlaT6NYd1/LshOIVCre
         MYHQqUrKh00QlOGM759IN1pT/I9LM68S4Ni6bn2k0IBRGJMzpJNNgg+Xcxhx/hf5+T
         8sKcmGSNF+FNHsej6fZYSfrR6IaovFTJokeCvDqqWsD5w/zyYIX2JHUAmd9+v+d0hR
         E76dIGIbzcvMA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A migrating transparent huge page has to already be unmapped. Otherwise,
the page could be modified while it is being copied to a new page and
data could be lost. The function __split_huge_pmd() checks for a PMD
migration entry before calling __split_huge_pmd_locked() leading one to
think that __split_huge_pmd_locked() can handle splitting a migrating PMD.
However, the code always increments the page->_mapcount and adjusts the
memory control group accounting assuming the page is mapped.
Also, if the PMD entry is a migration PMD entry, the call to
is_huge_zero_pmd(*pmd) is incorrect because it calls pmd_pfn(pmd) instead
of migration_entry_to_pfn(pmd_to_swp_entry(pmd)).
Fix these problems by checking for a PMD migration entry.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/huge_memory.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a468a4acb0a..606d712d9505 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2023,7 +2023,7 @@ static void __split_huge_pmd_locked(struct vm_area_st=
ruct *vma, pmd_t *pmd,
 		put_page(page);
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
-	} else if (is_huge_zero_pmd(*pmd)) {
+	} else if (pmd_trans_huge(*pmd) && is_huge_zero_pmd(*pmd)) {
 		/*
 		 * FIXME: Do we want to invalidate secondary mmu by calling
 		 * mmu_notifier_invalidate_range() see comments below inside
@@ -2117,30 +2117,34 @@ static void __split_huge_pmd_locked(struct vm_area_=
struct *vma, pmd_t *pmd,
 		pte =3D pte_offset_map(&_pmd, addr);
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, entry);
-		atomic_inc(&page[i]._mapcount);
-		pte_unmap(pte);
-	}
-
-	/*
-	 * Set PG_double_map before dropping compound_mapcount to avoid
-	 * false-negative page_mapped().
-	 */
-	if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
-		for (i =3D 0; i < HPAGE_PMD_NR; i++)
+		if (!pmd_migration)
 			atomic_inc(&page[i]._mapcount);
+		pte_unmap(pte);
 	}
=20
-	lock_page_memcg(page);
-	if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
-		/* Last compound_mapcount is gone. */
-		__dec_lruvec_page_state(page, NR_ANON_THPS);
-		if (TestClearPageDoubleMap(page)) {
-			/* No need in mapcount reference anymore */
+	if (!pmd_migration) {
+		/*
+		 * Set PG_double_map before dropping compound_mapcount to avoid
+		 * false-negative page_mapped().
+		 */
+		if (compound_mapcount(page) > 1 &&
+		    !TestSetPageDoubleMap(page)) {
 			for (i =3D 0; i < HPAGE_PMD_NR; i++)
-				atomic_dec(&page[i]._mapcount);
+				atomic_inc(&page[i]._mapcount);
+		}
+
+		lock_page_memcg(page);
+		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
+			/* Last compound_mapcount is gone. */
+			__dec_lruvec_page_state(page, NR_ANON_THPS);
+			if (TestClearPageDoubleMap(page)) {
+				/* No need in mapcount reference anymore */
+				for (i =3D 0; i < HPAGE_PMD_NR; i++)
+					atomic_dec(&page[i]._mapcount);
+			}
 		}
+		unlock_page_memcg(page);
 	}
-	unlock_page_memcg(page);
=20
 	smp_wmb(); /* make pte visible before pmd */
 	pmd_populate(mm, pmd, pgtable);
--=20
2.20.1

