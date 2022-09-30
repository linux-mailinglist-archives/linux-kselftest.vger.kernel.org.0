Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0545F0D4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 16:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiI3OUD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 10:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiI3OUA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 10:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B865ED
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 07:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664547596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/FXbSZy3Kth2MbXXSfAiotPyH32a5Ri5Xru6xlLiiI=;
        b=YDc7aufxQ77ETpXIcbgafFZyy8JWN7shPnqUct7ECf6vunr50eNVmpO9qeOGLkrJc/+MBu
        FNxaQj+mJ8hck6hwzu6EbHNEVrU9xBk0T1xAzHFNpJyrerw6OcbMdpCYCh38NSr3iefO+h
        QFnWtRgT0Grsi5ngY8dQoVZHlJvZZjs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-xX1KmHDqPWyeq4x3g8JPWw-1; Fri, 30 Sep 2022 10:19:53 -0400
X-MC-Unique: xX1KmHDqPWyeq4x3g8JPWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3D0380C8C3;
        Fri, 30 Sep 2022 14:19:52 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05DD71121314;
        Fri, 30 Sep 2022 14:19:48 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v1 2/7] mm/ksm: simplify break_ksm() to not rely on VM_FAULT_WRITE
Date:   Fri, 30 Sep 2022 16:19:26 +0200
Message-Id: <20220930141931.174362-3-david@redhat.com>
In-Reply-To: <20220930141931.174362-1-david@redhat.com>
References: <20220930141931.174362-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that GUP no longer requires VM_FAULT_WRITE, break_ksm() is the sole
remaining user of VM_FAULT_WRITE. As we also want to stop triggering a
fake write fault and instead use FAULT_FLAG_UNSHARE -- similar to
GUP-triggered unsharing when taking a R/O pin on a shared anonymous page
(including KSM pages), let's stop relying on VM_FAULT_WRITE.

Let's rework break_ksm() to not rely on the return value of
handle_mm_fault() anymore to figure out whether COW-breaking was
successful. Simply perform another follow_page() lookup to verify the
result.

While this makes break_ksm() slightly less efficient, we can simplify
handle_mm_fault() a little and easily switch to FAULT_FLAG_UNSHARE
without introducing similar KSM-specific behavior for
FAULT_FLAG_UNSHARE.

In my setup (AMD Ryzen 9 3900X), running the KSM selftest to test
unmerge performance on 2 GiB (taskset 0x8 ./ksm_tests -D -s 2048), this
results in a performance degradation of ~4% -- 5% (old: ~5250 MiB/s,
new: ~5010 MiB/s).

I don't think that we particularly care about that performance drop when
unmerging. If it ever turns out to be an actual performance issue, we can
think about a better alternative for FAULT_FLAG_UNSHARE -- let's just keep
it simple for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 0cd2f4b62334..e8d987fb379e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -473,26 +473,27 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 	vm_fault_t ret = 0;
 
 	do {
+		bool ksm_page = false;
+
 		cond_resched();
 		page = follow_page(vma, addr,
 				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
 		if (IS_ERR_OR_NULL(page))
 			break;
 		if (PageKsm(page))
-			ret = handle_mm_fault(vma, addr,
-					      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
-					      NULL);
-		else
-			ret = VM_FAULT_WRITE;
+			ksm_page = true;
 		put_page(page);
-	} while (!(ret & (VM_FAULT_WRITE | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
+
+		if (!ksm_page)
+			return 0;
+		ret = handle_mm_fault(vma, addr,
+				      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
+				      NULL);
+	} while (!(ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
 	/*
-	 * We must loop because handle_mm_fault() may back out if there's
-	 * any difficulty e.g. if pte accessed bit gets updated concurrently.
-	 *
-	 * VM_FAULT_WRITE is what we have been hoping for: it indicates that
-	 * COW has been broken, even if the vma does not permit VM_WRITE;
-	 * but note that a concurrent fault might break PageKsm for us.
+	 * We must loop until we no longer find a KSM page because
+	 * handle_mm_fault() may back out if there's any difficulty e.g. if
+	 * pte accessed bit gets updated concurrently.
 	 *
 	 * VM_FAULT_SIGBUS could occur if we race with truncation of the
 	 * backing file, which also invalidates anonymous pages: that's
-- 
2.37.3

