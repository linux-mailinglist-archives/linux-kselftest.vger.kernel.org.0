Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48185EC064
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 13:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiI0LDd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiI0LC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 07:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609925B07B
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664276524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXlbqV3bMihYU4DcJv9mg2N2kXbruPismRocuYGvJL4=;
        b=fnFktNX/XPrQ2jLxkJxmLYauu2IPncpUNw6Pj92BkemimbnqDGlLXyhRlEMS+MZVDIJ0kS
        xXNdWOoaz82ewHmajiYU9RTPSXYkQtHjAZOlpnq3ymZqM4GRuqD/tX9RLJv3hmsLLA9/yg
        90oXe2FMlmbA7YcPUBxG4CJhq3i1QgI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-ZI3TsViQOP20dkgQFxNpFQ-1; Tue, 27 Sep 2022 07:01:48 -0400
X-MC-Unique: ZI3TsViQOP20dkgQFxNpFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99E39803D4A;
        Tue, 27 Sep 2022 11:01:47 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24964C15BA5;
        Tue, 27 Sep 2022 11:01:45 +0000 (UTC)
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
Subject: [PATCH v1 7/7] selftests/vm: anon_cow: add R/O longterm tests via gup_test
Date:   Tue, 27 Sep 2022 13:01:20 +0200
Message-Id: <20220927110120.106906-8-david@redhat.com>
In-Reply-To: <20220927110120.106906-1-david@redhat.com>
References: <20220927110120.106906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's trigger a R/O longterm pin on three cases of R/O mapped anonymous
pages:
* exclusive (never shared)
* shared (child still alive)
* previously shared (child no longer alive)

... and make sure that the pin is reliable: whatever we write via the page
tables has to be observable via the pin.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/anon_cow.c | 210 ++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/tools/testing/selftests/vm/anon_cow.c b/tools/testing/selftests/vm/anon_cow.c
index 369b3e15647d..055bf13a05d9 100644
--- a/tools/testing/selftests/vm/anon_cow.c
+++ b/tools/testing/selftests/vm/anon_cow.c
@@ -17,6 +17,7 @@
 #include <dirent.h>
 #include <assert.h>
 #include <sys/mman.h>
+#include <sys/ioctl.h>
 #include <sys/wait.h>
 
 #include "local_config.h"
@@ -24,6 +25,7 @@
 #include <liburing.h>
 #endif /* LOCAL_CONFIG_HAVE_LIBURING */
 
+#include "../../../../mm/gup_test.h"
 #include "../kselftest.h"
 #include "vm_util.h"
 
@@ -32,6 +34,7 @@ static int pagemap_fd;
 static size_t thpsize;
 static int nr_hugetlbsizes;
 static size_t hugetlbsizes[10];
+static int gup_fd;
 
 static void detect_thpsize(void)
 {
@@ -503,6 +506,170 @@ static void test_iouring_fork(char *mem, size_t size)
 
 #endif /* LOCAL_CONFIG_HAVE_LIBURING */
 
+enum ro_pin_test {
+	RO_PIN_TEST_SHARED,
+	RO_PIN_TEST_PREVIOUSLY_SHARED,
+	RO_PIN_TEST_RO_EXCLUSIVE,
+};
+
+static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
+			   bool fast)
+{
+	struct pin_longterm_test args;
+	struct comm_pipes comm_pipes;
+	char *tmp, buf;
+	__u64 tmp_val;
+	int ret;
+
+	if (gup_fd < 0) {
+		ksft_test_result_skip("gup_test not available\n");
+		return;
+	}
+
+	tmp = malloc(size);
+	if (!tmp) {
+		ksft_test_result_fail("malloc() failed\n");
+		return;
+	}
+
+	ret = setup_comm_pipes(&comm_pipes);
+	if (ret) {
+		ksft_test_result_fail("pipe() failed\n");
+		goto free_tmp;
+	}
+
+	switch (test) {
+	case RO_PIN_TEST_SHARED:
+	case RO_PIN_TEST_PREVIOUSLY_SHARED:
+		/*
+		 * Share the pages with our child. As the pages are not pinned,
+		 * this should just work.
+		 */
+		ret = fork();
+		if (ret < 0) {
+			ksft_test_result_fail("fork() failed\n");
+			goto close_comm_pipes;
+		} else if (!ret) {
+			write(comm_pipes.child_ready[1], "0", 1);
+			while (read(comm_pipes.parent_ready[0], &buf, 1) != 1)
+				;
+			exit(0);
+		}
+
+		/* Wait until our child is ready. */
+		while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
+			;
+
+		if (test == RO_PIN_TEST_PREVIOUSLY_SHARED) {
+			/*
+			 * Tell the child to quit now and wait until it quit.
+			 * The pages should now be mapped R/O into our page
+			 * tables, but they are no longer shared.
+			 */
+			write(comm_pipes.parent_ready[1], "0", 1);
+			wait(&ret);
+			if (!WIFEXITED(ret))
+				ksft_print_msg("[INFO] wait() failed\n");
+		}
+		break;
+	case RO_PIN_TEST_RO_EXCLUSIVE:
+		/*
+		 * Map the page R/O into the page table. Enable softdirty
+		 * tracking to stop the page from getting mapped R/W immediately
+		 * again by mprotect() optimizations. Note that we don't have an
+		 * easy way to test if that worked (the pagemap does not export
+		 * if the page is mapped R/O vs. R/W).
+		 */
+		ret = mprotect(mem, size, PROT_READ);
+		clear_softdirty();
+		ret |= mprotect(mem, size, PROT_READ | PROT_WRITE);
+		if (ret) {
+			ksft_test_result_fail("mprotect() failed\n");
+			goto close_comm_pipes;
+		}
+		break;
+	default:
+		assert(false);
+	}
+
+	/* Take a R/O pin. This should trigger unsharing. */
+	args.addr = (__u64)mem;
+	args.size = size;
+	args.flags = fast ? PIN_LONGTERM_TEST_FLAG_USE_FAST : 0;
+	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_START, &args);
+	if (ret) {
+		if (errno == EINVAL)
+			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed\n");
+		else
+			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed\n");
+		goto wait;
+	}
+
+	/* Modify the page. */
+	memset(mem, 0xff, size);
+
+	/*
+	 * Read back the content via the pin to the temporary buffer and
+	 * test if we observed the modification.
+	 */
+	tmp_val = (__u64)tmp;
+	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_READ, &tmp_val);
+	if (ret)
+		ksft_test_result_fail("PIN_LONGTERM_TEST_READ failed\n");
+	else
+		ksft_test_result(!memcmp(mem, tmp, size),
+				 "Longterm R/O pin is reliable\n");
+
+	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_STOP);
+	if (ret)
+		ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed\n");
+wait:
+	switch (test) {
+	case RO_PIN_TEST_SHARED:
+		write(comm_pipes.parent_ready[1], "0", 1);
+		wait(&ret);
+		if (!WIFEXITED(ret))
+			ksft_print_msg("[INFO] wait() failed\n");
+		break;
+	default:
+		break;
+	}
+close_comm_pipes:
+	close_comm_pipes(&comm_pipes);
+free_tmp:
+	free(tmp);
+}
+
+static void test_ro_pin_on_shared(char *mem, size_t size)
+{
+	do_test_ro_pin(mem, size, RO_PIN_TEST_SHARED, false);
+}
+
+static void test_ro_fast_pin_on_shared(char *mem, size_t size)
+{
+	do_test_ro_pin(mem, size, RO_PIN_TEST_SHARED, true);
+}
+
+static void test_ro_pin_on_ro_previously_shared(char *mem, size_t size)
+{
+	do_test_ro_pin(mem, size, RO_PIN_TEST_PREVIOUSLY_SHARED, false);
+}
+
+static void test_ro_fast_pin_on_ro_previously_shared(char *mem, size_t size)
+{
+	do_test_ro_pin(mem, size, RO_PIN_TEST_PREVIOUSLY_SHARED, true);
+}
+
+static void test_ro_pin_on_ro_exclusive(char *mem, size_t size)
+{
+	do_test_ro_pin(mem, size, RO_PIN_TEST_RO_EXCLUSIVE, false);
+}
+
+static void test_ro_fast_pin_on_ro_exclusive(char *mem, size_t size)
+{
+	do_test_ro_pin(mem, size, RO_PIN_TEST_RO_EXCLUSIVE, true);
+}
+
 typedef void (*test_fn)(char *mem, size_t size);
 
 static void do_run_with_base_page(test_fn fn, bool swapout)
@@ -850,6 +1017,48 @@ static const struct test_case test_cases[] = {
 	},
 
 #endif /* LOCAL_CONFIG_HAVE_LIBURING */
+	/*
+	 * Take a R/O longterm pin on a R/O-mapped shared anonymous page.
+	 * When modifying the page via the page table, the page content change
+	 * must be visible via the pin.
+	 */
+	{
+		"R/O GUP pin on R/O-mapped shared page",
+		test_ro_pin_on_shared,
+	},
+	/* Same as above, but using GUP-fast. */
+	{
+		"R/O GUP-fast pin on R/O-mapped shared page",
+		test_ro_fast_pin_on_shared,
+	},
+	/*
+	 * Take a R/O longterm pin on a R/O-mapped exclusive anonymous page that
+	 * was previously shared. When modifying the page via the page table,
+	 * the page content change must be visible via the pin.
+	 */
+	{
+		"R/O GUP pin on R/O-mapped previously-shared page",
+		test_ro_pin_on_ro_previously_shared,
+	},
+	/* Same as above, but using GUP-fast. */
+	{
+		"R/O GUP-fast pin on R/O-mapped previously-shared page",
+		test_ro_fast_pin_on_ro_previously_shared,
+	},
+	/*
+	 * Take a R/O longterm pin on a R/O-mapped exclusive anonymous page.
+	 * When modifying the page via the page table, the page content change
+	 * must be visible via the pin.
+	 */
+	{
+		"R/O GUP pin on R/O-mapped exclusive page",
+		test_ro_pin_on_ro_exclusive,
+	},
+	/* Same as above, but using GUP-fast. */
+	{
+		"R/O GUP-fast pin on R/O-mapped exclusive page",
+		test_ro_fast_pin_on_ro_exclusive,
+	},
 };
 
 static void run_test_case(struct test_case const *test_case)
@@ -902,6 +1111,7 @@ int main(int argc, char **argv)
 	ksft_print_header();
 	ksft_set_plan(nr_test_cases * tests_per_test_case());
 
+	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_fail_msg("opening pagemap failed\n");
-- 
2.37.3

