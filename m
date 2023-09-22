Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E47AB0ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjIVLco (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 07:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjIVLcM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 07:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FB3CC2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 04:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695382279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccEdlostLZ9hW/Y+0NbfOfNDQJd+s3hdO6ELIs/CNv4=;
        b=Ec2vwQGJrhcedGKuXMrb4ZxFw+K015WW1v4r3pVBNZ2kxKmA5YnlNJ78WOSMCHCI2iwR/K
        RFPYdr3VcO4Co67U+2vrdTAB4gWYNNQVltUHqXPACxfv1Ey2YlFVFwaUCJeMCiwbZY00G/
        W6H/DuDdobphFmK+Prz0XS9k4o97juo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-gL529IiFPli31fOxi3rVow-1; Fri, 22 Sep 2023 07:31:13 -0400
X-MC-Unique: gL529IiFPli31fOxi3rVow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55A34101A529;
        Fri, 22 Sep 2023 11:31:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 161112156701;
        Fri, 22 Sep 2023 11:31:09 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 09/10] iov_iter: Add kunit to benchmark decanting of xarray to bvec
Date:   Fri, 22 Sep 2023 12:30:37 +0100
Message-ID: <20230922113038.1135236-10-dhowells@redhat.com>
In-Reply-To: <20230922113038.1135236-1-dhowells@redhat.com>
References: <20230922113038.1135236-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a kunit test to benchmark an xarray containing 256MiB of data getting
decanted into 256-page BVEC iterators that get copied from - modelling
bufferage being drawn from the pagecache and batched up for I/O.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Brendan Higgins <brendanhiggins@google.com>
cc: David Gow <davidgow@google.com>
cc: linux-kselftest@vger.kernel.org
cc: kunit-dev@googlegroups.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 lib/kunit_iov_iter.c | 87 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 1a43e9518a63..2fbe6f2afb26 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -1509,6 +1509,92 @@ static void __init iov_kunit_benchmark_xarray(struct kunit *test)
 	KUNIT_SUCCEED();
 }
 
+/*
+ * Time copying 256MiB through an ITER_XARRAY, decanting it to ITER_BVECs.
+ */
+static void __init iov_kunit_benchmark_xarray_to_bvec(struct kunit *test)
+{
+	struct iov_iter xiter;
+	struct xarray *xarray;
+	struct page *page;
+	unsigned int samples[IOV_KUNIT_NR_SAMPLES];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size = 256 * 1024 * 1024, npages = size / PAGE_SIZE;
+	void *scratch;
+	int i;
+
+	/* Allocate a page and tile it repeatedly in the buffer. */
+	page = alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+	kunit_add_action_or_reset(test, iov_kunit_free_page, page);
+
+	xarray = iov_kunit_create_xarray(test);
+
+	for (i = 0; i < npages; i++) {
+		void *x = xa_store(xarray, i, page, GFP_KERNEL);
+
+		KUNIT_ASSERT_FALSE(test, xa_is_err(x));
+	}
+
+	/* Create a single large buffer to copy to/from. */
+	scratch = iov_kunit_create_source(test, npages);
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over BVECs decanted from an XARRAY:\n");
+	for (i = 0; i < IOV_KUNIT_NR_SAMPLES; i++) {
+		size = 256 * 1024 * 1024;
+		iov_iter_xarray(&xiter, ITER_SOURCE, xarray, 0, size);
+		a = ktime_get_real();
+
+		do {
+			struct iov_iter biter;
+			struct bio_vec *bvec;
+			struct page **pages;
+			size_t req, part, offset0, got;
+			int j;
+
+			npages = 256;
+			req = min_t(size_t, size, npages * PAGE_SIZE);
+			bvec = kunit_kmalloc_array(test, npages, sizeof(bvec[0]), GFP_KERNEL);
+			KUNIT_ASSERT_NOT_NULL(test, bvec);
+
+			pages = (void *)bvec + array_size(npages, sizeof(bvec[0])) -
+				array_size(npages, sizeof(*pages));
+
+			part = iov_iter_extract_pages(&xiter, &pages, req,
+						      npages, 0, &offset0);
+			KUNIT_EXPECT_NE(test, part, 0);
+			KUNIT_EXPECT_GT(test, part, 0);
+
+			j = 0;
+			got = part;
+			do {
+				size_t chunk = min_t(size_t, got, PAGE_SIZE - offset0);
+
+				bvec_set_page(&bvec[j++], page, chunk, offset0);
+				offset0 = 0;
+				got -= chunk;
+			} while (got > 0);
+
+			iov_iter_bvec(&biter, ITER_SOURCE, bvec, j, part);
+			copied = copy_from_iter(scratch, part, &biter);
+			KUNIT_EXPECT_EQ(test, copied, part);
+			size -= copied;
+			if (test->status == KUNIT_FAILURE)
+				break;
+		} while (size > 0);
+
+		b = ktime_get_real();
+		samples[i] = ktime_to_us(ktime_sub(b, a));
+		if (test->status == KUNIT_FAILURE)
+			break;
+	}
+
+	iov_kunit_benchmark_print_stats(test, samples);
+	KUNIT_SUCCEED();
+}
+
 static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_copy_to_ubuf),
 	KUNIT_CASE(iov_kunit_copy_from_ubuf),
@@ -1529,6 +1615,7 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_benchmark_bvec),
 	KUNIT_CASE(iov_kunit_benchmark_bvec_split),
 	KUNIT_CASE(iov_kunit_benchmark_xarray),
+	KUNIT_CASE(iov_kunit_benchmark_xarray_to_bvec),
 	{}
 };
 

