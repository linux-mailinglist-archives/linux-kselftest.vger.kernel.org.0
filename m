Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B9B5EC057
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 13:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiI0LC6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 07:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiI0LCV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 07:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4662D1E80
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664276507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6ppzU8NrJ3mYSPxoJruC+SRfOuYeuv/ezC2v1fvuK4=;
        b=bCLMABtaJ2uUtZAl83P1n7Zq0P7fH4nAXMWHXaH/n4+1hiQEVje4XNjY/GCz06c7LTWmIS
        ynHGIgfksdRpb1z2YxBDEpdDR1VwimE8Xv58d3+ZSQ/fKv95G6CcEh2iZQnxSAggUx046Q
        O5oEbeNoQQJPak/WMdzLMavq52gUQWE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-K67q5aYpPl6RfXIYoCfxYQ-1; Tue, 27 Sep 2022 07:01:45 -0400
X-MC-Unique: K67q5aYpPl6RfXIYoCfxYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC6B63C01D86;
        Tue, 27 Sep 2022 11:01:44 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C77CC15E76;
        Tue, 27 Sep 2022 11:01:42 +0000 (UTC)
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
Subject: [PATCH v1 6/7] mm/gup_test: start/stop/read functionality for PIN LONGTERM test
Date:   Tue, 27 Sep 2022 13:01:19 +0200
Message-Id: <20220927110120.106906-7-david@redhat.com>
In-Reply-To: <20220927110120.106906-1-david@redhat.com>
References: <20220927110120.106906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We want an easy way to take a R/O or R/W longterm pin on a range and be
able to observe the content of the pinned pages, so we can properly test
how longterm puns interact with our COW logic.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup_test.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/gup_test.h |  12 +++++
 2 files changed, 152 insertions(+)

diff --git a/mm/gup_test.c b/mm/gup_test.c
index 12b0a91767d3..2bbfacd31f5a 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -203,6 +203,134 @@ static int __gup_test_ioctl(unsigned int cmd,
 	return ret;
 }
 
+static DEFINE_MUTEX(pin_longterm_test_mutex);
+static struct page **pin_longterm_test_pages;
+static unsigned long pin_longterm_test_nr_pages;
+
+static inline void pin_longterm_test_stop(void)
+{
+	if (pin_longterm_test_pages) {
+		if (pin_longterm_test_nr_pages)
+			unpin_user_pages(pin_longterm_test_pages,
+					 pin_longterm_test_nr_pages);
+		kfree(pin_longterm_test_pages);
+		pin_longterm_test_pages = NULL;
+		pin_longterm_test_nr_pages = 0;
+	}
+}
+
+static inline int pin_longterm_test_start(unsigned long arg)
+{
+	long nr_pages, cur_pages, addr, remaining_pages;
+	int gup_flags = FOLL_LONGTERM;
+	struct pin_longterm_test args;
+	struct page **pages;
+	int ret = 0;
+	bool fast;
+
+	if (pin_longterm_test_pages)
+		return -EINVAL;
+
+	if (copy_from_user(&args, (void __user *)arg, sizeof(args)))
+		return -EFAULT;
+
+	if (args.flags &
+	    ~(PIN_LONGTERM_TEST_FLAG_USE_WRITE|PIN_LONGTERM_TEST_FLAG_USE_FAST))
+		return -EINVAL;
+	if (!IS_ALIGNED(args.addr | args.size, PAGE_SIZE))
+		return -EINVAL;
+	if (args.size > LONG_MAX)
+		return -EINVAL;
+	nr_pages = args.size / PAGE_SIZE;
+	if (!nr_pages)
+		return -EINVAL;
+
+	pages = kvcalloc(nr_pages, sizeof(void *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	if (args.flags & PIN_LONGTERM_TEST_FLAG_USE_WRITE)
+		gup_flags |= FOLL_WRITE;
+	fast = !!(args.flags & PIN_LONGTERM_TEST_FLAG_USE_FAST);
+
+	if (!fast && mmap_read_lock_killable(current->mm)) {
+		kfree(pages);
+		return -EINTR;
+	}
+
+	pin_longterm_test_pages = pages;
+	pin_longterm_test_nr_pages = 0;
+
+	while (nr_pages - pin_longterm_test_nr_pages) {
+		remaining_pages = nr_pages - pin_longterm_test_nr_pages;
+		addr = args.addr + pin_longterm_test_nr_pages * PAGE_SIZE;
+
+		if (fast)
+			cur_pages = pin_user_pages_fast(addr, remaining_pages,
+							gup_flags, pages);
+		else
+			cur_pages = pin_user_pages(addr, remaining_pages,
+						   gup_flags, pages, NULL);
+		if (cur_pages < 0) {
+			pin_longterm_test_stop();
+			ret = cur_pages;
+			break;
+		}
+		pin_longterm_test_nr_pages += cur_pages;
+		pages += cur_pages;
+	};
+
+	if (!fast)
+		mmap_read_unlock(current->mm);
+	return ret;
+}
+
+static inline int pin_longterm_test_read(unsigned long arg)
+{
+	__u64 user_addr;
+	unsigned long i;
+
+	if (!pin_longterm_test_pages)
+		return -EINVAL;
+
+	if (copy_from_user(&user_addr, (void __user *)arg, sizeof(user_addr)))
+		return -EFAULT;
+
+	for (i = 0; i < pin_longterm_test_nr_pages; i++) {
+		void *addr = page_to_virt(pin_longterm_test_pages[i]);
+
+		if (copy_to_user((void __user *)user_addr, addr, PAGE_SIZE))
+			return -EFAULT;
+		user_addr += PAGE_SIZE;
+	}
+	return 0;
+}
+
+static long pin_longterm_test_ioctl(struct file *filep, unsigned int cmd,
+				    unsigned long arg)
+{
+	int ret = -EINVAL;
+
+	if (mutex_lock_killable(&pin_longterm_test_mutex))
+		return -EINTR;
+
+	switch (cmd) {
+	case PIN_LONGTERM_TEST_START:
+		ret = pin_longterm_test_start(arg);
+		break;
+	case PIN_LONGTERM_TEST_STOP:
+		pin_longterm_test_stop();
+		ret = 0;
+		break;
+	case PIN_LONGTERM_TEST_READ:
+		ret = pin_longterm_test_read(arg);
+		break;
+	}
+
+	mutex_unlock(&pin_longterm_test_mutex);
+	return ret;
+}
+
 static long gup_test_ioctl(struct file *filep, unsigned int cmd,
 		unsigned long arg)
 {
@@ -217,6 +345,10 @@ static long gup_test_ioctl(struct file *filep, unsigned int cmd,
 	case PIN_BASIC_TEST:
 	case DUMP_USER_PAGES_TEST:
 		break;
+	case PIN_LONGTERM_TEST_START:
+	case PIN_LONGTERM_TEST_STOP:
+	case PIN_LONGTERM_TEST_READ:
+		return pin_longterm_test_ioctl(filep, cmd, arg);
 	default:
 		return -EINVAL;
 	}
@@ -234,9 +366,17 @@ static long gup_test_ioctl(struct file *filep, unsigned int cmd,
 	return 0;
 }
 
+static int gup_test_release(struct inode *inode, struct file *file)
+{
+	pin_longterm_test_stop();
+
+	return 0;
+}
+
 static const struct file_operations gup_test_fops = {
 	.open = nonseekable_open,
 	.unlocked_ioctl = gup_test_ioctl,
+	.release = gup_test_release,
 };
 
 static int __init gup_test_init(void)
diff --git a/mm/gup_test.h b/mm/gup_test.h
index 887ac1d5f5bc..5b37b54e8bea 100644
--- a/mm/gup_test.h
+++ b/mm/gup_test.h
@@ -10,6 +10,9 @@
 #define GUP_BASIC_TEST		_IOWR('g', 4, struct gup_test)
 #define PIN_BASIC_TEST		_IOWR('g', 5, struct gup_test)
 #define DUMP_USER_PAGES_TEST	_IOWR('g', 6, struct gup_test)
+#define PIN_LONGTERM_TEST_START	_IOW('g', 7, struct pin_longterm_test)
+#define PIN_LONGTERM_TEST_STOP	_IO('g', 8)
+#define PIN_LONGTERM_TEST_READ	_IOW('g', 9, __u64)
 
 #define GUP_TEST_MAX_PAGES_TO_DUMP		8
 
@@ -30,4 +33,13 @@ struct gup_test {
 	__u32 which_pages[GUP_TEST_MAX_PAGES_TO_DUMP];
 };
 
+#define PIN_LONGTERM_TEST_FLAG_USE_WRITE	1
+#define PIN_LONGTERM_TEST_FLAG_USE_FAST		2
+
+struct pin_longterm_test {
+	__u64 addr;
+	__u64 size;
+	__u32 flags;
+};
+
 #endif	/* __GUP_TEST_H */
-- 
2.37.3

