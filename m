Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496426DDD75
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjDKOQf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 10:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDKOQc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 10:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE32E43
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681222544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCmOrD6a+wU+gQBMdrpGdoWY5w1T2pXs/1sAiD9BNP4=;
        b=bcu5wu8AydCIPl15MQcOjNEIRouoLljOLn/4k4kR/9XRWYg4Qt1L5GxXs0pl/przKwAAwg
        5iJBxVEhXsBal03QqSJ1c2+WWX6A8csBqg7PQnnQ7xn6oakk8XHHbzIlVKRNjV/1MdEum2
        qwlBPJ/lrM/Y9sl0JVVNhWh2HbLFfnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-8t3asOMrN_Sxm6SwwHsM4A-1; Tue, 11 Apr 2023 10:15:42 -0400
X-MC-Unique: 8t3asOMrN_Sxm6SwwHsM4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14C95185A791;
        Tue, 11 Apr 2023 14:15:42 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16E57400F285;
        Tue, 11 Apr 2023 14:15:40 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 4/6] mm/migrate: revert "mm/migrate: fix wrongly apply write bit after mkdirty on sparc64"
Date:   Tue, 11 Apr 2023 16:15:27 +0200
Message-Id: <20230411141529.428991-6-david@redhat.com>
In-Reply-To: <20230411141529.428991-1-david@redhat.com>
References: <20230411141529.428991-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This reverts commit 96a9c287e25d ("mm/migrate: fix wrongly apply write bit
after mkdirty on sparc64").

Now that sparc64 mkdirty handling is fixed and no longer sets a PTE/PMD
writable that shouldn't be writable, let's revert the temporary fix.

The mkdirty mm selftest still passes with this change on sparc64.

Note that loongarch handling was fixed in commit bf2f34a506e6 ("LoongArch:
Set _PAGE_DIRTY only if _PAGE_WRITE is set in {pmd,pte}_mkdirty()").

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 6 ++----
 mm/migrate.c     | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 032fb0ef9cd1..ec86bf1d4e81 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3276,6 +3276,8 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
+	if (is_writable_migration_entry(entry))
+		pmde = maybe_pmd_mkwrite(pmde, vma);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_mkuffd_wp(pmde);
 	if (!is_migration_entry_young(entry))
@@ -3283,10 +3285,6 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	/* NOTE: this may contain setting soft-dirty on some archs */
 	if (PageDirty(new) && is_migration_entry_dirty(entry))
 		pmde = pmd_mkdirty(pmde);
-	if (is_writable_migration_entry(entry))
-		pmde = maybe_pmd_mkwrite(pmde, vma);
-	else
-		pmde = pmd_wrprotect(pmde);
 
 	if (PageAnon(new)) {
 		rmap_t rmap_flags = RMAP_COMPOUND;
diff --git a/mm/migrate.c b/mm/migrate.c
index db3f154446af..3b21c44e2176 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -225,8 +225,6 @@ static bool remove_migration_pte(struct folio *folio,
 			pte = maybe_mkwrite(pte, vma);
 		else if (pte_swp_uffd_wp(*pvmw.pte))
 			pte = pte_mkuffd_wp(pte);
-		else
-			pte = pte_wrprotect(pte);
 
 		if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
-- 
2.39.2

