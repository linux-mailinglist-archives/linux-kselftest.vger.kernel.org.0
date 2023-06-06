Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3F4724C26
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 21:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbjFFTFB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 15:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbjFFTEa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7BE1725
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 12:04:22 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53f44c25595so2296120a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078262; x=1688670262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TbnAfmaUEaUTjNKT8epdT4a2IjxXaCNnR/Vzf4sBC5I=;
        b=HeyHfG//kNLUaGcFQWwTewKEgcn4vPYn8juDXqEsqn0adr4vG649KYKYHbBgxoXbAB
         ahAsJnvxbrxRZIn8HaOziynSothNYKlQfcTu3jAM4uhoNpX3LWBrkvui47Zp8M9CRSxM
         Hv3v6i8Oi9BrSmd48ktue72BHNGZsJ2uSICRouR0ffp2LrDCVbnCBmA+g2SulzB0hGNV
         h/9GOrxYxtycjJuMZs46LGZ0YhTsDAihpMdCj9p8GQJvBLZp7PdD2PUuqFKV1kr3TMS1
         NWDPMg3o3REsZ5x50h8pQh4zEK7vomJrpG+mCaUeJtrTs1RdwqH+EB5u26LqsONPQnLR
         jEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078262; x=1688670262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbnAfmaUEaUTjNKT8epdT4a2IjxXaCNnR/Vzf4sBC5I=;
        b=R3lQNVCUKmy9OAi8ae8/KvAcUMjqL0Tr5x7+s43o6OxN3DDW2JGmxe/pEUePMXcJb6
         M81MSmra8i16olCIUrVcClu+aL/Cl3xyVYx3yrWfx6AjH/Aunp3veBHR6Blh1wM2eEj8
         0+HrHyJmQmNXOGwPp2Mf1ACrQJQNxrWeJnEEfxTmjiu6fz8EajLc0RcDKuDbV14QnHRr
         PxxW5u4501KzDFE0EzcVL+EpYeeestdgI0W2ayrG9rTJ4la6tbDjTgtQ/JXranUvSJje
         4LvqXSfqKoGkp280QaSixUZB1d/GXhrxhfSUh6EUfthcoUlBAzB28J0vZikbNJ64snHz
         gtOA==
X-Gm-Message-State: AC+VfDxmGVKySeu1MHEUvs1nCYl3MPIP2Hy+R2i2KNfPbAM9YqjuYUdq
        h5erhdkneQH4FeZNhYFlCHDY1pURN3FeP7tdaw==
X-Google-Smtp-Source: ACHHUZ7WRmD6VfCo02eYhPrQlyc6XnpZbLw7oQUgpoj7hXhb698PIwiX79ZF4kn3hNLKX22XHrTVhzRB5PnobIvmJA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a63:fe05:0:b0:513:9753:46d2 with SMTP
 id p5-20020a63fe05000000b00513975346d2mr634687pgh.2.1686078262212; Tue, 06
 Jun 2023 12:04:22 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:50 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <7827774c13e975d3d1dedc4a4684cb92eac8b548.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 05/19] mm: hugetlb: Allow alloc_hugetlb_folio() to be
 parametrized by subpool and hstate
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, willy@infradead.org
Cc:     brauner@kernel.org, chao.p.peng@linux.intel.com,
        coltonlewis@google.com, david@redhat.com, dhildenb@redhat.com,
        dmatlack@google.com, erdemaktas@google.com, hughd@google.com,
        isaku.yamahata@gmail.com, jarkko@kernel.org, jmattson@google.com,
        joro@8bytes.org, jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
        wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, x86@kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

subpool_inode() and hstate_inode() are hugetlbfs-specific.

By allowing subpool and hstate to be specified, hugetlb is further
modularized from hugetlbfs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2457d7a21974..14df89d1642c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -747,6 +747,9 @@ struct huge_bootmem_page {
 };
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
+struct folio *alloc_hugetlb_folio_from_subpool(
+	struct hugepage_subpool *spool, struct hstate *h,
+	struct vm_area_struct *vma, unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9da419b930df..99ab4bbdb2ce 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3008,11 +3008,10 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	return ret;
 }
 
-struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-				    unsigned long addr, int avoid_reserve)
+struct folio *alloc_hugetlb_folio_from_subpool(
+	struct hugepage_subpool *spool, struct hstate *h,
+	struct vm_area_struct *vma, unsigned long addr, int avoid_reserve)
 {
-	struct hugepage_subpool *spool = subpool_vma(vma);
-	struct hstate *h = hstate_vma(vma);
 	struct folio *folio;
 	long map_chg, map_commit;
 	long gbl_chg;
@@ -3139,6 +3138,15 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	return ERR_PTR(-ENOSPC);
 }
 
+struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
+				    unsigned long addr, int avoid_reserve)
+{
+	struct hugepage_subpool *spool = subpool_vma(vma);
+	struct hstate *h = hstate_vma(vma);
+
+	return alloc_hugetlb_folio_from_subpool(spool, h, vma, addr, avoid_reserve);
+}
+
 int alloc_bootmem_huge_page(struct hstate *h, int nid)
 	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
 int __alloc_bootmem_huge_page(struct hstate *h, int nid)
-- 
2.41.0.rc0.172.g3f132b7071-goog

