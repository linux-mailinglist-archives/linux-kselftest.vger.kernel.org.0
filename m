Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAD02A8B9E
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 01:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbgKFAwG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 19:52:06 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8446 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732838AbgKFAwG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 19:52:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa49e360006>; Thu, 05 Nov 2020 16:52:06 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 00:52:00 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 00:52:00 +0000
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v3 4/6] mm/thp: add THP allocation helper
Date:   Thu, 5 Nov 2020 16:51:45 -0800
Message-ID: <20201106005147.20113-5-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106005147.20113-1-rcampbell@nvidia.com>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604623926; bh=gT6gepnrM1WtFwSGyIYxXIn+WYLudok2qxIca0Wj42k=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=oZL2f7tFL6dXZy+k8i6jnnkaHUca7aBBFsVgDXAnb4xvEFYgpyFvCQ4YaxNbZ6XBq
         Wh3SlS7/fv42muBRoi1mZaQOpgVO3BO8z/HeoEc9Toj7kpKD7QD4Pin5rIkU0Rz1WI
         KNjgQYRTE2ltAGYmOTHDxGsM/jVB9zEcazwVpq0/aEz1cazc2NumdDnvTde16pxwlS
         p5ws5rm7fIGbvfDlIrUloSZYuY2u3FCJ8SxzgbiwISqxujHl3S2LsCwwJt9A5Jiles
         53AbVNbPVeFZNC8i9zbIt0/rsNliFLXQ1leUZ+aMu21sHMWwznYbxAhybb5rXHxd18
         pPpFN+3TyGtNg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Transparent huge page allocation policy is controlled by several sysfs
variables. Rather than expose these to each device driver that needs to
allocate THPs, provide a helper function.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/gfp.h | 10 ++++++++++
 mm/huge_memory.c    | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index c603237e006c..242398c4b556 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -564,6 +564,16 @@ static inline struct page *alloc_pages(gfp_t gfp_mask,=
 unsigned int order)
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 #define alloc_page_vma(gfp_mask, vma, addr)			\
 	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id(), false)
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+extern struct page *alloc_transhugepage(struct vm_area_struct *vma,
+					unsigned long addr);
+#else
+static inline struct page *alloc_transhugepage(struct vm_area_struct *vma,
+						unsigned long addr)
+{
+	return NULL;
+}
+#endif
=20
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a073e66d0ee2..c2c1d3e7c35f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -765,6 +765,20 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault =
*vmf)
 	return __do_huge_pmd_anonymous_page(vmf, page, gfp);
 }
=20
+struct page *alloc_transhugepage(struct vm_area_struct *vma,
+				 unsigned long haddr)
+{
+	gfp_t gfp;
+	struct page *page;
+
+	gfp =3D alloc_hugepage_direct_gfpmask(vma);
+	page =3D alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
+	if (page)
+		prep_transhuge_page(page);
+	return page;
+}
+EXPORT_SYMBOL_GPL(alloc_transhugepage);
+
 static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
 		pgtable_t pgtable)
--=20
2.20.1

