Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9975F0D61
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 16:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiI3OV1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 10:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiI3OVA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 10:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA924129FEF
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664547658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Os3ebntrNckY9ikYeoLSgVh4tT4cYPUxPafC1slc+E=;
        b=dy/ugYIt+LnElsYP/PUIUw22n0+LFPdAZ/cwS2dz9Eq3dTT/RRwSbUbRLZ6Ah+os1UbOU5
        aeRjnSLE+mDUqArZKvFXrbqU1G5w65AdJbqCf9brHQ8MsVSGftaSswnWpz8MYlIQS7g8pL
        6Upo6C4GZaO17Yk43jSZ2y3YS93FsMo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-gjvSGRHeOl-RFUWtXhoFUQ-1; Fri, 30 Sep 2022 10:20:33 -0400
X-MC-Unique: gjvSGRHeOl-RFUWtXhoFUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1544101E150;
        Fri, 30 Sep 2022 14:20:32 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92C461121315;
        Fri, 30 Sep 2022 14:20:30 +0000 (UTC)
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
Subject: [PATCH v1 5/7] mm/pagewalk: add walk_page_range_vma()
Date:   Fri, 30 Sep 2022 16:19:29 +0200
Message-Id: <20220930141931.174362-6-david@redhat.com>
In-Reply-To: <20220930141931.174362-1-david@redhat.com>
References: <20220930141931.174362-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's add walk_page_range_vma(), which is similar to walk_page_vma(),
however, is only interested in a subset of the VMA range.

To be used in KSM code to stop using follow_page() next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pagewalk.h |  3 +++
 mm/pagewalk.c            | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index f3fafb731ffd..2f8f6cc980b4 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -99,6 +99,9 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
 			  pgd_t *pgd,
 			  void *private);
+int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, const struct mm_walk_ops *ops,
+			void *private);
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		void *private);
 int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 131b2b335b2c..757c075da231 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -514,6 +514,33 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 	return __walk_page_range(start, end, &walk);
 }
 
+int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, const struct mm_walk_ops *ops,
+			void *private)
+{
+	struct mm_walk walk = {
+		.ops		= ops,
+		.mm		= vma->vm_mm,
+		.vma		= vma,
+		.private	= private,
+	};
+	int err;
+
+	if (start >= end || !walk.mm)
+		return -EINVAL;
+	if (start < vma->vm_start || end > vma->vm_end)
+		return -EINVAL;
+
+	mmap_assert_locked(walk.mm);
+
+	err = walk_page_test(start, end, &walk);
+	if (err > 0)
+		return 0;
+	if (err < 0)
+		return err;
+	return __walk_page_range(start, end, &walk);
+}
+
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		void *private)
 {
-- 
2.37.3

