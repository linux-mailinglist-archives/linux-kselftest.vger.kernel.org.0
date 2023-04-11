Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28E86DDD74
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 16:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjDKOQf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 10:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDKOQc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 10:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2963E1FEB
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681222546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMuXjs2koZ/Flt7PJQx7eiW1x5ktANLpUol8YMKeKVs=;
        b=LwgERl6Uo/kGosNuZRDNgXNUQCuUZR4P73NnbdxE08C/offS1YbJDW1WQBK+7pM35Kcc+k
        PUYIvEnL0amlE1xsmJhmtlI79BwbXx1Z5HhtA+33/IiEX0o+MUqzxt8GhJVFtEgyjVF59D
        5IcmFCuxvgbpdyTlRKh4kOYfN7xw+ME=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-zLozqPi3M5SQg6bnZDFiDQ-1; Tue, 11 Apr 2023 10:15:44 -0400
X-MC-Unique: zLozqPi3M5SQg6bnZDFiDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4008E1C0A5A5;
        Tue, 11 Apr 2023 14:15:43 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E630400F287;
        Tue, 11 Apr 2023 14:15:42 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 5/6] mm/huge_memory: revert "Partly revert "mm/thp: carry over dirty bit when thp splits on pmd""
Date:   Tue, 11 Apr 2023 16:15:28 +0200
Message-Id: <20230411141529.428991-7-david@redhat.com>
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

This reverts commit 624a2c94f5b7 ("Partly revert "mm/thp: carry over dirty
bit when thp splits on pmd"") and the fixup in commit e833bc503405
("mm/thp: re-apply mkdirty for small pages after split").

Now that sparc64 mkdirty handling is fixed and no longer sets a PTE/PMD
writable that shouldn't be writable, let's revert the temporary fix and
remove the stale comment.

The mkdirty mm selftest still passes with this change on sparc64.

Note that loongarch handling was fixed in commit bf2f34a506e6 ("LoongArch:
Set _PAGE_DIRTY only if _PAGE_WRITE is set in {pmd,pte}_mkdirty()")

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ec86bf1d4e81..6f3af65435c8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2238,18 +2238,13 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			entry = maybe_mkwrite(entry, vma);
 			if (anon_exclusive)
 				SetPageAnonExclusive(page + i);
+			if (!write)
+				entry = pte_wrprotect(entry);
 			if (!young)
 				entry = pte_mkold(entry);
 			/* NOTE: this may set soft-dirty too on some archs */
 			if (dirty)
 				entry = pte_mkdirty(entry);
-			/*
-			 * NOTE: this needs to happen after pte_mkdirty,
-			 * because some archs (sparc64, loongarch) could
-			 * set hw write bit when mkdirty.
-			 */
-			if (!write)
-				entry = pte_wrprotect(entry);
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
 			if (uffd_wp)
-- 
2.39.2

