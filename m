Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF5E61F95D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 17:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiKGQVa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 11:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiKGQUz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 11:20:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438E222B16
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 08:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667837966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Fr+6PvBJcVGo49mRUSTVB+G70kkKYpHo7niK5GMhiI=;
        b=MSmUfjoQAFits01DSJEv5yCGp+GHUzaGtUjMLGAP1e0Ez8gCJH+aO0vKTi2GBVOxzuVDD6
        ZKdOC4MfJqymYmaLi6wH86XXRYSmmZDamoFtBP7ba6Obza9Zk6zdgvCLfhOCkRfnvDTbh1
        gGocVANJaLIfDfKX7/h7NWMsat5Qm2M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-0nINmOCBNB6j33TN5DvJug-1; Mon, 07 Nov 2022 11:19:21 -0500
X-MC-Unique: 0nINmOCBNB6j33TN5DvJug-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED32D185A7AE;
        Mon,  7 Nov 2022 16:19:19 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48FAF4B400F;
        Mon,  7 Nov 2022 16:19:05 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH RFC 14/19] drm/etnaviv: remove FOLL_FORCE usage
Date:   Mon,  7 Nov 2022 17:17:35 +0100
Message-Id: <20221107161740.144456-15-david@redhat.com>
In-Reply-To: <20221107161740.144456-1-david@redhat.com>
References: <20221107161740.144456-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

GUP now supports reliable R/O long-term pinning in COW mappings, such
that we break COW early. MAP_SHARED VMAs only use the shared zeropage so
far in one corner case (DAXFS file with holes), which can be ignored
because GUP does not support long-term pinning in fsdax (see
check_vma_flags()).

commit cd5297b0855f ("drm/etnaviv: Use FOLL_FORCE for userptr")
documents that FOLL_FORCE | FOLL_WRITE was really only used for reliable
R/O pinning.

Consequently, FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM is no longer required
for reliable R/O long-term pinning: FOLL_LONGTERM is sufficient. So stop
using FOLL_FORCE, which is really only for debugger access.

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index cc386f8a7116..efe2240945d0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -638,6 +638,7 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
 	struct page **pvec = NULL;
 	struct etnaviv_gem_userptr *userptr = &etnaviv_obj->userptr;
 	int ret, pinned = 0, npages = etnaviv_obj->base.size >> PAGE_SHIFT;
+	unsigned int gup_flags = FOLL_LONGTERM;
 
 	might_lock_read(&current->mm->mmap_lock);
 
@@ -648,14 +649,15 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
 	if (!pvec)
 		return -ENOMEM;
 
+	if (!userptr->ro)
+		gup_flags |= FOLL_WRITE;
+
 	do {
 		unsigned num_pages = npages - pinned;
 		uint64_t ptr = userptr->ptr + pinned * PAGE_SIZE;
 		struct page **pages = pvec + pinned;
 
-		ret = pin_user_pages_fast(ptr, num_pages,
-					  FOLL_WRITE | FOLL_FORCE | FOLL_LONGTERM,
-					  pages);
+		ret = pin_user_pages_fast(ptr, num_pages, gup_flags, pages);
 		if (ret < 0) {
 			unpin_user_pages(pvec, pinned);
 			kvfree(pvec);
-- 
2.38.1

