Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2E16DDD77
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDKORN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 10:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDKORM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 10:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3446F4680
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681222549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qzK4ogixuaREht4MpkiqqhFPvzGg6ALQmBRRBO9bEhw=;
        b=jUbwLpSnffwcc5daCXto//mJke2UUJmVMz5P0LPI06H8rBkuQv/LNv+XSI2FgVvWJ3K+SV
        Uj/yZsznQ6/wUPcGLZ8nk3zOzcNzNoAJHZFAF6sVY+qG9qei7cXZsSAIwl7W9TVrb/+c61
        I7pxXTgX4nMDQG32zdfqPt8KJLmNly4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-bQTcdzQuNdGs3XWMcEGz2w-1; Tue, 11 Apr 2023 10:15:42 -0400
X-MC-Unique: bQTcdzQuNdGs3XWMcEGz2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FBF686A96C;
        Tue, 11 Apr 2023 14:15:32 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB346400F284;
        Tue, 11 Apr 2023 14:15:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH] mm/huge_memory: conditionally call maybe_mkwrite() and drop pte_wrprotect() in __split_huge_pmd_locked()
Date:   Tue, 11 Apr 2023 16:15:22 +0200
Message-Id: <20230411141529.428991-1-david@redhat.com>
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

No need to call maybe_mkwrite() to then wrprotect if the source PMD was not
writable.

It's worth nothing that this now allows for PTEs to be writable even if
the source PMD was not writable: if vma->vm_page_prot includes write
permissions.

As documented in commit 931298e103c2 ("mm/userfaultfd: rely on
vma->vm_page_prot in uffd_wp_range()"), any mechanism that intends to
have pages wrprotected (COW, writenotify, mprotect, uffd-wp, softdirty,
...) has to properly adjust vma->vm_page_prot upfront, to not include
write permissions. If vma->vm_page_prot includes write permissions, the
PTE/PMD can be writable as default.

This now mimics the handling in mm/migrate.c:remove_migration_pte() and in
mm/huge_memory.c:remove_migration_pmd(), which has been in place for a
long time (except that 96a9c287e25d ("mm/migrate: fix wrongly apply write
bit after mkdirty on sparc64") temporarily changed it).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6f3af65435c8..8332e16ac97b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2235,11 +2235,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_swp_mkuffd_wp(entry);
 		} else {
 			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
-			entry = maybe_mkwrite(entry, vma);
+			if (write)
+				entry = maybe_mkwrite(entry, vma);
 			if (anon_exclusive)
 				SetPageAnonExclusive(page + i);
-			if (!write)
-				entry = pte_wrprotect(entry);
 			if (!young)
 				entry = pte_mkold(entry);
 			/* NOTE: this may set soft-dirty too on some archs */
-- 
2.39.2

