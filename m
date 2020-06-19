Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3C201DA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 23:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgFSV60 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 17:58:26 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4424 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgFSV5H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 17:57:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eed34800003>; Fri, 19 Jun 2020 14:56:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Jun 2020 14:57:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Jun 2020 14:57:07 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jun
 2020 21:57:00 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 19 Jun 2020 21:57:00 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eed34ab0011>; Fri, 19 Jun 2020 14:56:59 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 14/16] mm/thp: add THP allocation helper
Date:   Fri, 19 Jun 2020 14:56:47 -0700
Message-ID: <20200619215649.32297-15-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200619215649.32297-1-rcampbell@nvidia.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592603776; bh=kXXozYTDYK7aMNWLdQJr5nharDoHGXvNmoZn/icUffg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=FB8GkXl+JEJSuRFlcL7kSXF1wfVMoMzx1IZIVNBmIiCssD6ZvOYMcM4g1YlwXD9Xc
         fUwVOGUQi9vqV9+u+Ocu4VWoyn3uEfrDzBm9oCJUXIYAcHisKTublwOvC4PJSur7Gi
         /1B2H0AkYvyG2FNIHj2VvGVTHaH+45IUAFgwvy0CpuX2r/rExOl5hW33pkDoiDv3Qd
         GLYCfju0skH62G6N7QReitjSze4ILceA2kmi0aGfBmpxlU8S+CED9CvSTkWwpnSeF0
         j9Aax8vf8qI3IQ7FhyjjeeLp50D4hXmshMLXdtPMwiKnxLmTRyoXGdGwZ8PUqq7fs1
         RWIjwYg0Au3pg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Transparent huge page allocation policy is controlled by several sysfs
variables. Rather than expose these to each device driver that needs to
allocate THPs, provide a helper function.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/gfp.h | 10 ++++++++++
 mm/huge_memory.c    | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 67a0774e080b..1c7d968a27d3 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -562,6 +562,16 @@ extern struct page *alloc_pages_vma(gfp_t gfp_mask, in=
t order,
 	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id(), false)
 #define alloc_page_vma_node(gfp_mask, vma, addr, node)		\
 	alloc_pages_vma(gfp_mask, 0, vma, addr, node, false)
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
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
index 25d95f7b1e98..f749633ed350 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -775,6 +775,22 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault =
*vmf)
 	return __do_huge_pmd_anonymous_page(vmf, page, gfp);
 }
=20
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
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
+#endif
+
 static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
 		pgtable_t pgtable)
--=20
2.20.1

