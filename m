Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9DC7A82B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 15:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjITNF0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbjITNF0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 09:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2199E
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695215071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ut+h9nLVtpMfUa14begCRaPNr+Lp71R8/RKDVqE44g=;
        b=Cffc1Wlcek7eptfGgutt2BerhfdiVJBEHc0aPHgEUlrrEex5T4O8Yy6pZAbZ1nxAifai1S
        CFuY1jHcozXnLCpmgGR7fTjUZaKVzFdGw7XHIR2IOk1KbzcEuja896xs3YuFeQ+tkYe6Iv
        H7aq27oe2fDMsz2FdxQlnzyNzEEZs/A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-682-AR2qMwyVMnipdkVKppdkYw-1; Wed, 20 Sep 2023 09:04:30 -0400
X-MC-Unique: AR2qMwyVMnipdkVKppdkYw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2277101A529;
        Wed, 20 Sep 2023 13:04:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF1E3492B16;
        Wed, 20 Sep 2023 13:04:15 +0000 (UTC)
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
Subject: [RFC PATCH v2 2/9] iov_iter: Consolidate some of the repeated code into helpers
Date:   Wed, 20 Sep 2023 14:03:53 +0100
Message-ID: <20230920130400.203330-3-dhowells@redhat.com>
In-Reply-To: <20230920130400.203330-1-dhowells@redhat.com>
References: <20230920130400.203330-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Consolidate some of the repeated code snippets into helper functions to
reduce the line count.

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
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 lib/kunit_iov_iter.c | 189 +++++++++++++++++++------------------------
 1 file changed, 84 insertions(+), 105 deletions(-)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 4a6c0efd33f5..ee586eb652b4 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -19,18 +19,18 @@ MODULE_AUTHOR("David Howells <dhowells@redhat.com>");
 MODULE_LICENSE("GPL");
 
 struct kvec_test_range {
-	int	from, to;
+	int	page, from, to;
 };
 
 static const struct kvec_test_range kvec_test_ranges[] = {
-	{ 0x00002, 0x00002 },
-	{ 0x00027, 0x03000 },
-	{ 0x05193, 0x18794 },
-	{ 0x20000, 0x20000 },
-	{ 0x20000, 0x24000 },
-	{ 0x24000, 0x27001 },
-	{ 0x29000, 0xffffb },
-	{ 0xffffd, 0xffffe },
+	{ 0, 0x00002, 0x00002 },
+	{ 0, 0x00027, 0x03000 },
+	{ 0, 0x05193, 0x18794 },
+	{ 0, 0x20000, 0x20000 },
+	{ 0, 0x20000, 0x24000 },
+	{ 0, 0x24000, 0x27001 },
+	{ 0, 0x29000, 0xffffb },
+	{ 0, 0xffffd, 0xffffe },
 	{ -1 }
 };
 
@@ -69,6 +69,57 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
 	return buffer;
 }
 
+/*
+ * Build the reference pattern in the scratch buffer that we expect to see in
+ * the iterator buffer (ie. the result of copy *to*).
+ */
+static void iov_kunit_build_to_reference_pattern(struct kunit *test, u8 *scratch,
+						 size_t bufsize,
+						 const struct kvec_test_range *pr)
+{
+	int i, patt = 0;
+
+	memset(scratch, 0, bufsize);
+	for (; pr->page >= 0; pr++)
+		for (i = pr->from; i < pr->to; i++)
+			scratch[i] = pattern(patt++);
+}
+
+/*
+ * Build the reference pattern in the iterator buffer that we expect to see in
+ * the scratch buffer (ie. the result of copy *from*).
+ */
+static void iov_kunit_build_from_reference_pattern(struct kunit *test, u8 *buffer,
+						   size_t bufsize,
+						   const struct kvec_test_range *pr)
+{
+	size_t i = 0, j;
+
+	memset(buffer, 0, bufsize);
+	for (; pr->page >= 0; pr++) {
+		for (j = pr->from; j < pr->to; j++) {
+			buffer[i++] = pattern(j);
+			if (i >= bufsize)
+				return;
+		}
+	}
+}
+
+/*
+ * Compare two kernel buffers to see that they're the same.
+ */
+static void iov_kunit_check_pattern(struct kunit *test, const u8 *buffer,
+				    const u8 *scratch, size_t bufsize)
+{
+	size_t i;
+
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
+		if (buffer[i] != scratch[i])
+			return;
+	}
+}
+
 static void __init iov_kunit_load_kvec(struct kunit *test,
 				       struct iov_iter *iter, int dir,
 				       struct kvec *kvec, unsigned int kvmax,
@@ -79,7 +130,7 @@ static void __init iov_kunit_load_kvec(struct kunit *test,
 	int i;
 
 	for (i = 0; i < kvmax; i++, pr++) {
-		if (pr->from < 0)
+		if (pr->page < 0)
 			break;
 		KUNIT_ASSERT_GE(test, pr->to, pr->from);
 		KUNIT_ASSERT_LE(test, pr->to, bufsize);
@@ -97,13 +148,12 @@ static void __init iov_kunit_load_kvec(struct kunit *test,
  */
 static void __init iov_kunit_copy_to_kvec(struct kunit *test)
 {
-	const struct kvec_test_range *pr;
 	struct iov_iter iter;
 	struct page **spages, **bpages;
 	struct kvec kvec[8];
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, patt;
+	int i;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -125,20 +175,8 @@ static void __init iov_kunit_copy_to_kvec(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
 	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
 
-	/* Build the expected image in the scratch buffer. */
-	patt = 0;
-	memset(scratch, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
-		for (i = pr->from; i < pr->to; i++)
-			scratch[i] = pattern(patt++);
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
-		if (buffer[i] != scratch[i])
-			return;
-	}
-
+	iov_kunit_build_to_reference_pattern(test, scratch, bufsize, kvec_test_ranges);
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -147,13 +185,12 @@ static void __init iov_kunit_copy_to_kvec(struct kunit *test)
  */
 static void __init iov_kunit_copy_from_kvec(struct kunit *test)
 {
-	const struct kvec_test_range *pr;
 	struct iov_iter iter;
 	struct page **spages, **bpages;
 	struct kvec kvec[8];
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, j;
+	int i;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -175,25 +212,8 @@ static void __init iov_kunit_copy_from_kvec(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
 	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
 
-	/* Build the expected image in the main buffer. */
-	i = 0;
-	memset(buffer, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		for (j = pr->from; j < pr->to; j++) {
-			buffer[i++] = pattern(j);
-			if (i >= bufsize)
-				goto stop;
-		}
-	}
-stop:
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
-		if (scratch[i] != buffer[i])
-			return;
-	}
-
+	iov_kunit_build_from_reference_pattern(test, buffer, bufsize, kvec_test_ranges);
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -210,7 +230,7 @@ static const struct bvec_test_range bvec_test_ranges[] = {
 	{ 5, 0x0000, 0x1000 },
 	{ 6, 0x0000, 0x0ffb },
 	{ 6, 0x0ffd, 0x0ffe },
-	{ -1, -1, -1 }
+	{ -1 }
 };
 
 static void __init iov_kunit_load_bvec(struct kunit *test,
@@ -225,7 +245,7 @@ static void __init iov_kunit_load_bvec(struct kunit *test,
 	int i;
 
 	for (i = 0; i < bvmax; i++, pr++) {
-		if (pr->from < 0)
+		if (pr->page < 0)
 			break;
 		KUNIT_ASSERT_LT(test, pr->page, npages);
 		KUNIT_ASSERT_LT(test, pr->page * PAGE_SIZE, bufsize);
@@ -288,20 +308,14 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 	b = 0;
 	patt = 0;
 	memset(scratch, 0, bufsize);
-	for (pr = bvec_test_ranges; pr->from >= 0; pr++, b++) {
+	for (pr = bvec_test_ranges; pr->page >= 0; pr++, b++) {
 		u8 *p = scratch + pr->page * PAGE_SIZE;
 
 		for (i = pr->from; i < pr->to; i++)
 			p[i] = pattern(patt++);
 	}
 
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
-		if (buffer[i] != scratch[i])
-			return;
-	}
-
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -341,7 +355,7 @@ static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 	/* Build the expected image in the main buffer. */
 	i = 0;
 	memset(buffer, 0, bufsize);
-	for (pr = bvec_test_ranges; pr->from >= 0; pr++) {
+	for (pr = bvec_test_ranges; pr->page >= 0; pr++) {
 		size_t patt = pr->page * PAGE_SIZE;
 
 		for (j = pr->from; j < pr->to; j++) {
@@ -352,13 +366,7 @@ static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 	}
 stop:
 
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
-		if (scratch[i] != buffer[i])
-			return;
-	}
-
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -409,7 +417,7 @@ static void __init iov_kunit_copy_to_xarray(struct kunit *test)
 	struct page **spages, **bpages;
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, patt;
+	int i;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -426,7 +434,7 @@ static void __init iov_kunit_copy_to_xarray(struct kunit *test)
 	iov_kunit_load_xarray(test, &iter, READ, xarray, bpages, npages);
 
 	i = 0;
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+	for (pr = kvec_test_ranges; pr->page >= 0; pr++) {
 		size = pr->to - pr->from;
 		KUNIT_ASSERT_LE(test, pr->to, bufsize);
 
@@ -439,20 +447,8 @@ static void __init iov_kunit_copy_to_xarray(struct kunit *test)
 		i += size;
 	}
 
-	/* Build the expected image in the scratch buffer. */
-	patt = 0;
-	memset(scratch, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
-		for (i = pr->from; i < pr->to; i++)
-			scratch[i] = pattern(patt++);
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
-		if (buffer[i] != scratch[i])
-			return;
-	}
-
+	iov_kunit_build_to_reference_pattern(test, scratch, bufsize, kvec_test_ranges);
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -467,7 +463,7 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 	struct page **spages, **bpages;
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, j;
+	int i;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -484,7 +480,7 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 	iov_kunit_load_xarray(test, &iter, READ, xarray, bpages, npages);
 
 	i = 0;
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+	for (pr = kvec_test_ranges; pr->page >= 0; pr++) {
 		size = pr->to - pr->from;
 		KUNIT_ASSERT_LE(test, pr->to, bufsize);
 
@@ -497,25 +493,8 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 		i += size;
 	}
 
-	/* Build the expected image in the main buffer. */
-	i = 0;
-	memset(buffer, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		for (j = pr->from; j < pr->to; j++) {
-			buffer[i++] = pattern(j);
-			if (i >= bufsize)
-				goto stop;
-		}
-	}
-stop:
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
-		if (scratch[i] != buffer[i])
-			return;
-	}
-
+	iov_kunit_build_from_reference_pattern(test, buffer, bufsize, kvec_test_ranges);
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -573,7 +552,7 @@ static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
 			while (from == pr->to) {
 				pr++;
 				from = pr->from;
-				if (from < 0)
+				if (pr->page < 0)
 					goto stop;
 			}
 			ix = from / PAGE_SIZE;
@@ -651,7 +630,7 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 			while (from == pr->to) {
 				pr++;
 				from = pr->from;
-				if (from < 0)
+				if (pr->page < 0)
 					goto stop;
 			}
 			ix = pr->page + from / PAGE_SIZE;
@@ -698,7 +677,7 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 	iov_kunit_create_buffer(test, &bpages, npages);
 	iov_kunit_load_xarray(test, &iter, READ, xarray, bpages, npages);
 
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+	for (pr = kvec_test_ranges; pr->page >= 0; pr++) {
 		from = pr->from;
 		size = pr->to - from;
 		KUNIT_ASSERT_LE(test, pr->to, bufsize);

