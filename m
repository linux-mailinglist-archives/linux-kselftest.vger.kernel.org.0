Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA93F61F90B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 17:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiKGQUD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 11:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiKGQUA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 11:20:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18942099C
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667837892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lSxL+XrmZJW7NH2+twP4XE4aLK3QEV8h23a3ZmFqyA=;
        b=aAuXKpDNpXbEprERu350ivYC2ag5Yf6LUoihKAa+2+XyxC3EDzfDgoOtanDXy7pg+TLfHK
        mvoQg00vJMVH7PVsHQ3/bqj+ufcDDpQmWPWD7ihsYXdUJGC/V2ugTlBUj0Zl9CEEB0c+mJ
        5uE/NmEqDjp3HpDWNL4W7Dp051VpbCk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-PWBvwyXsP6uR-JYwyobXFQ-1; Mon, 07 Nov 2022 11:18:06 -0500
X-MC-Unique: PWBvwyXsP6uR-JYwyobXFQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 080183811F3B;
        Mon,  7 Nov 2022 16:18:05 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 749974B3FC6;
        Mon,  7 Nov 2022 16:18:00 +0000 (UTC)
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
        Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RFC 03/19] selftests/vm: cow: R/O long-term pinning reliability tests for non-anon pages
Date:   Mon,  7 Nov 2022 17:17:24 +0100
Message-Id: <20221107161740.144456-4-david@redhat.com>
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

Let's test whether R/O long-term pinning is reliable for non-anonymous
memory: when R/O long-term pinning a page, the expectation is that we
break COW early before pinning, such that actual write access via the
page tables won't break COW later and end up replacing the R/O-pinned
page in the page table.

Consequently, R/O long-term pinning in private mappings would only target
exclusive anonymous pages.

For now, all tests fail:
	# [RUN] R/O longterm GUP pin ... with shared zeropage
	not ok 151 Longterm R/O pin is reliable
	# [RUN] R/O longterm GUP pin ... with memfd
	not ok 152 Longterm R/O pin is reliable
	# [RUN] R/O longterm GUP pin ... with tmpfile
	not ok 153 Longterm R/O pin is reliable
	# [RUN] R/O longterm GUP pin ... with huge zeropage
	not ok 154 Longterm R/O pin is reliable
	# [RUN] R/O longterm GUP pin ... with memfd hugetlb (2048 kB)
	not ok 155 Longterm R/O pin is reliable
	# [RUN] R/O longterm GUP pin ... with memfd hugetlb (1048576 kB)
	not ok 156 Longterm R/O pin is reliable
	# [RUN] R/O longterm GUP-fast pin ... with shared zeropage
	not ok 157 Longterm R/O pin is reliable
	# [RUN] R/O longterm GUP-fast pin ... with memfd
	not ok 158 Longterm R/O pin is reliable
	# [RUN] R/O longterm GUP-fast pin ... with tmpfile
	not ok 159 Longterm R/O pin is reliable
	# [RUN] R/O longterm GUP-fast pin ... with huge zeropage
	not ok 160 Longterm R/O pin is reliable
	# [RUN] R/O longterm GUP-fast pin ... with memfd hugetlb (2048 kB)
	not ok 161 Longterm R/O pin is reliable
	# [RUN] R/O longterm GUP-fast pin ... with memfd hugetlb (1048576 kB)
	not ok 162 Longterm R/O pin is reliable

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/cow.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/cow.c b/tools/testing/selftests/vm/cow.c
index 93c643bcdcf5..40ba45d0c6b4 100644
--- a/tools/testing/selftests/vm/cow.c
+++ b/tools/testing/selftests/vm/cow.c
@@ -534,6 +534,7 @@ static void test_iouring_fork(char *mem, size_t size)
 #endif /* LOCAL_CONFIG_HAVE_LIBURING */
 
 enum ro_pin_test {
+	RO_PIN_TEST,
 	RO_PIN_TEST_SHARED,
 	RO_PIN_TEST_PREVIOUSLY_SHARED,
 	RO_PIN_TEST_RO_EXCLUSIVE,
@@ -566,6 +567,8 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 	}
 
 	switch (test) {
+	case RO_PIN_TEST:
+		break;
 	case RO_PIN_TEST_SHARED:
 	case RO_PIN_TEST_PREVIOUSLY_SHARED:
 		/*
@@ -1150,6 +1153,16 @@ static void test_cow(char *mem, const char *smem, size_t size)
 	free(old);
 }
 
+static void test_ro_pin(char *mem, const char *smem, size_t size)
+{
+	do_test_ro_pin(mem, size, RO_PIN_TEST, false);
+}
+
+static void test_ro_fast_pin(char *mem, const char *smem, size_t size)
+{
+	do_test_ro_pin(mem, size, RO_PIN_TEST, true);
+}
+
 static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
 {
 	char *mem, *smem, tmp;
@@ -1390,7 +1403,7 @@ struct non_anon_test_case {
 };
 
 /*
- * Test cases that target any pages in private mappings that are non anonymous:
+ * Test cases that target any pages in private mappings that are not anonymous:
  * pages that may get shared via COW ndependent of fork(). This includes
  * the shared zeropage(s), pagecache pages, ...
  */
@@ -1403,6 +1416,19 @@ static const struct non_anon_test_case non_anon_test_cases[] = {
 		"Basic COW",
 		test_cow,
 	},
+	/*
+	 * Take a R/O longterm pin. When modifying the page via the page table,
+	 * the page content change must be visible via the pin.
+	 */
+	{
+		"R/O longterm GUP pin",
+		test_ro_pin,
+	},
+	/* Same as above, but using GUP-fast. */
+	{
+		"R/O longterm GUP-fast pin",
+		test_ro_fast_pin,
+	},
 };
 
 static void run_non_anon_test_case(struct non_anon_test_case const *test_case)
-- 
2.38.1

