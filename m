Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74C72A8B9D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 01:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbgKFAwG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 19:52:06 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9221 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732833AbgKFAwF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 19:52:05 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa49e330001>; Thu, 05 Nov 2020 16:52:03 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 00:51:59 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 00:51:59 +0000
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
Subject: [PATCH v3 1/6] mm/thp: add prep_transhuge_device_private_page()
Date:   Thu, 5 Nov 2020 16:51:42 -0800
Message-ID: <20201106005147.20113-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106005147.20113-1-rcampbell@nvidia.com>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604623923; bh=MxvX11Do/3TUW7vYVdXjys2hT9iLLmhsTNuHLf5CCr8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=jycxpJC/sIQZd6sCGvcrgobqobx/hb+2eYyacKc6TH4S0nfwyol+QFqcBb3W/gDPy
         f6cAT+my0FZ/zM/BKJ2f5Npp4lo+QkW8SIlLXL0JNJmrUnqRFdBv/aeKUgaGG2uYId
         t/H/ElW+D+WfTRyPAqlX5rUPMWlVAub+vwtrPjAo979gBgan5xECfXatoCNS6kPhMz
         vFSjXJV5E5Ih2U4dUsypaiJB576mHrBc4XEUvG1j1u+z3UPYLk5m6JM3aJqzErWcGz
         iwpZPWyEfrSYv2pKhQFhoH1r/8s0MvYggRMW6CcubxCYwKBwr2VKdHr/JCSiTlyC6P
         UbTX+0jw2ODtA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a helper function to allow device drivers to create device private
transparent huge pages. This is intended to help support device private
THP migrations.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/huge_mm.h | 5 +++++
 mm/huge_memory.c        | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0365aa97f8e7..3ec26ef27a93 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -184,6 +184,7 @@ extern unsigned long thp_get_unmapped_area(struct file =
*filp,
 		unsigned long flags);
=20
 extern void prep_transhuge_page(struct page *page);
+extern void prep_transhuge_device_private_page(struct page *page);
 extern void free_transhuge_page(struct page *page);
 bool is_transparent_hugepage(struct page *page);
=20
@@ -377,6 +378,10 @@ static inline bool transhuge_vma_suitable(struct vm_ar=
ea_struct *vma,
=20
 static inline void prep_transhuge_page(struct page *page) {}
=20
+static inline void prep_transhuge_device_private_page(struct page *page)
+{
+}
+
 static inline bool is_transparent_hugepage(struct page *page)
 {
 	return false;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 08a183f6c3ab..b4141f12ff31 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -498,6 +498,15 @@ void prep_transhuge_page(struct page *page)
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
 }
=20
+void prep_transhuge_device_private_page(struct page *page)
+{
+	prep_compound_page(page, HPAGE_PMD_ORDER);
+	prep_transhuge_page(page);
+	/* Only the head page has a reference to the pgmap. */
+	percpu_ref_put_many(page->pgmap->ref, HPAGE_PMD_NR - 1);
+}
+EXPORT_SYMBOL_GPL(prep_transhuge_device_private_page);
+
 bool is_transparent_hugepage(struct page *page)
 {
 	if (!PageCompound(page))
--=20
2.20.1

