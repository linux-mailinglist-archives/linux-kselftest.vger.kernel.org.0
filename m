Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A639F6DDDD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 16:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDKO1L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 10:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDKO1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 10:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C13149FA
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681223133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMuXjs2koZ/Flt7PJQx7eiW1x5ktANLpUol8YMKeKVs=;
        b=jH4I4lgufgNcKog7oMzVI1YUzAU0IZoEHExeSqY4Oka0Eo7hOhcv6hrf4xGt8/DfUd3xXP
        1feipEV39BuTS6mMsEOi6hzBFoL1XBBjVfXcbhj6Ru5ELbC3AN9+i5em3hHiRuXztLShnt
        uL5tu3TMnCtOgXBPETEnpkerdRo3axc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-HXPMVzgwN7ms9In_1b7_gA-1; Tue, 11 Apr 2023 10:25:29 -0400
X-MC-Unique: HXPMVzgwN7ms9In_1b7_gA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF19628237D4;
        Tue, 11 Apr 2023 14:25:28 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA53914171D7;
        Tue, 11 Apr 2023 14:25:26 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Shuah Khan <shuah@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Yu Zhao <yuzhao@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v1 RESEND 5/6] mm/huge_memory: revert "Partly revert "mm/thp: carry over dirty bit when thp splits on pmd""
Date:   Tue, 11 Apr 2023 16:25:11 +0200
Message-Id: <20230411142512.438404-6-david@redhat.com>
In-Reply-To: <20230411142512.438404-1-david@redhat.com>
References: <20230411142512.438404-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

