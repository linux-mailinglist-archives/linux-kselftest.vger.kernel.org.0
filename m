Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA45EC051
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 13:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiI0LCf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 07:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiI0LCI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 07:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18A1B2CFB
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664276496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkTzwNdbrev2vLdkwk3qfmkYbyeGY/wzkkordbf1PA4=;
        b=Nssm/QzixKT9/+1Sb2N+r6y2E2ciJ/zNf5ML2/nlpRJgVqgdx0So8jdXuHvivTVcDnJRQM
        igNBXnP40ZIJRSVd6c1ZSLrIM+xgqVN21Zbc6vC2ncfc5srHsXcdAOLCUgxnExTYbJpE2D
        35G3Fc6sJiWGGEMd3Gr6LIhCvv4jLtY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-vtxyoS1vPpmxrTaBbo-T1Q-1; Tue, 27 Sep 2022 07:01:32 -0400
X-MC-Unique: vtxyoS1vPpmxrTaBbo-T1Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BA89101E14D;
        Tue, 27 Sep 2022 11:01:32 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A58EC15BB1;
        Tue, 27 Sep 2022 11:01:29 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>
Subject: [PATCH v1 2/7] selftests/vm: factor out pagemap_is_populated() into vm_util
Date:   Tue, 27 Sep 2022 13:01:15 +0200
Message-Id: <20220927110120.106906-3-david@redhat.com>
In-Reply-To: <20220927110120.106906-1-david@redhat.com>
References: <20220927110120.106906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We'll reuse it in the anon_cow test next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/madv_populate.c | 8 --------
 tools/testing/selftests/vm/vm_util.c       | 8 ++++++++
 tools/testing/selftests/vm/vm_util.h       | 1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vm/madv_populate.c b/tools/testing/selftests/vm/madv_populate.c
index 715a42e8e2cd..60547245e479 100644
--- a/tools/testing/selftests/vm/madv_populate.c
+++ b/tools/testing/selftests/vm/madv_populate.c
@@ -27,14 +27,6 @@
 
 static size_t pagesize;
 
-static bool pagemap_is_populated(int fd, char *start)
-{
-	uint64_t entry = pagemap_get_entry(fd, start);
-
-	/* Present or swapped. */
-	return entry & 0xc000000000000000ull;
-}
-
 static void sense_support(void)
 {
 	char *addr;
diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests/vm/vm_util.c
index 6456027e1985..d37dbabeb875 100644
--- a/tools/testing/selftests/vm/vm_util.c
+++ b/tools/testing/selftests/vm/vm_util.c
@@ -35,6 +35,14 @@ bool pagemap_is_swapped(int fd, char *start)
 	return entry & 0x4000000000000000ull;
 }
 
+bool pagemap_is_populated(int fd, char *start)
+{
+	uint64_t entry = pagemap_get_entry(fd, start);
+
+	/* Present or swapped. */
+	return entry & 0xc000000000000000ull;
+}
+
 void clear_softdirty(void)
 {
 	int ret;
diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
index bb8ec8d69623..691d063e79cc 100644
--- a/tools/testing/selftests/vm/vm_util.h
+++ b/tools/testing/selftests/vm/vm_util.h
@@ -5,6 +5,7 @@
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
 bool pagemap_is_swapped(int fd, char *start);
+bool pagemap_is_populated(int fd, char *start);
 void clear_softdirty(void);
 uint64_t read_pmd_pagesize(void);
 uint64_t check_huge(void *addr);
-- 
2.37.3

