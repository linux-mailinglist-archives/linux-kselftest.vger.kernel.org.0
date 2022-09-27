Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E145EC058
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 13:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiI0LCz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiI0LCU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 07:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4523B657C
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 04:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664276505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zYDZlXUfZis44OdEGOtPWzAEVFKRwxP/5kxXQofWe1A=;
        b=i97kWJZK7ppGRc5gxNgWt+wFV39/poPSYBO/UU+oICa/xOkjbhLmNSZe3tyEiCVCxXdXJN
        XWoL1Rz8iPDIQ8wCXVyylCUUIle2KGUJrhuJ5Py6oVGjWIb38ig1q/JJgXqY2MmewX2Byp
        XQOp9b8rVj3zQTZyiCRcRrM2DAKQ65s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-R8C6XKtTMCCshDHp9MmHFw-1; Tue, 27 Sep 2022 07:01:42 -0400
X-MC-Unique: R8C6XKtTMCCshDHp9MmHFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFA801C1BD27;
        Tue, 27 Sep 2022 11:01:41 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42E85C15BB5;
        Tue, 27 Sep 2022 11:01:38 +0000 (UTC)
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
Subject: [PATCH v1 5/7] selftests/vm: anon_cow: add liburing test cases
Date:   Tue, 27 Sep 2022 13:01:18 +0200
Message-Id: <20220927110120.106906-6-david@redhat.com>
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

io_uring provides a simple mechanism to test long-term, R/W GUP pins
-- via fixed buffers -- and can be used to verify that GUP pins stay
in sync with the pages in the page table even if a page would
temporarily get mapped R/O or concurrent fork() could accidentially
end up sharing pinned pages with the child.

Note that this essentially re-introduces local_config support that was
removed recently in commit 6f83d6c74ea5 ("Kselftests: remove support of
libhugetlbfs from kselftests").

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/Makefile        |  21 ++-
 tools/testing/selftests/vm/anon_cow.c      | 190 +++++++++++++++++++++
 tools/testing/selftests/vm/check_config.sh |  31 ++++
 3 files changed, 241 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vm/check_config.sh

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index bc759534ec28..7931b84040ed 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm selftests
 
-LOCAL_HDRS += $(top_srcdir)/mm/gup_test.h
+LOCAL_HDRS += $(selfdir)/vm/local_config.h $(top_srcdir)/mm/gup_test.h
+
+include local_config.mk
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/ppc64/')
@@ -150,8 +152,25 @@ warn_32bit_failure:
 endif
 endif
 
+# ANON_COW_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
+$(OUTPUT)/anon_cow: LDLIBS += $(ANON_COW_EXTRA_LIBS)
+
 $(OUTPUT)/mlock-random-test $(OUTPUT)/memfd_secret: LDLIBS += -lcap
 
 $(OUTPUT)/ksm_tests: LDLIBS += -lnuma
 
 $(OUTPUT)/migration: LDLIBS += -lnuma
+
+local_config.mk local_config.h: check_config.sh
+	/bin/sh ./check_config.sh $(CC)
+
+EXTRA_CLEAN += local_config.mk local_config.h
+
+ifeq ($(ANON_COW_EXTRA_LIBS),)
+all: warn_missing_liburing
+
+warn_missing_liburing:
+	@echo ; \
+	echo "Warning: missing liburing support. Some COW tests will be skipped." ; \
+	echo
+endif
diff --git a/tools/testing/selftests/vm/anon_cow.c b/tools/testing/selftests/vm/anon_cow.c
index 06fd046bf1f2..369b3e15647d 100644
--- a/tools/testing/selftests/vm/anon_cow.c
+++ b/tools/testing/selftests/vm/anon_cow.c
@@ -19,6 +19,11 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 
+#include "local_config.h"
+#ifdef LOCAL_CONFIG_HAVE_LIBURING
+#include <liburing.h>
+#endif /* LOCAL_CONFIG_HAVE_LIBURING */
+
 #include "../kselftest.h"
 #include "vm_util.h"
 
@@ -334,6 +339,170 @@ static void test_vmsplice_after_fork(char *mem, size_t size)
 	do_test_vmsplice_in_parent(mem, size, false);
 }
 
+#ifdef LOCAL_CONFIG_HAVE_LIBURING
+static void do_test_iouring(char *mem, size_t size, bool use_fork)
+{
+	struct comm_pipes comm_pipes;
+	struct io_uring_cqe *cqe;
+	struct io_uring_sqe *sqe;
+	struct io_uring ring;
+	size_t cur, total;
+	struct iovec iov;
+	char *buf, *tmp;
+	int ret, fd;
+	FILE *file;
+
+	ret = setup_comm_pipes(&comm_pipes);
+	if (ret) {
+		ksft_test_result_fail("pipe() failed\n");
+		return;
+	}
+
+	file = tmpfile();
+	if (!file) {
+		ksft_test_result_fail("tmpfile() failed\n");
+		goto close_comm_pipes;
+	}
+	fd = fileno(file);
+	assert(fd);
+
+	tmp = malloc(size);
+	if (!tmp) {
+		ksft_test_result_fail("malloc() failed\n");
+		goto close_file;
+	}
+
+	/* Skip on errors, as we might just lack kernel support. */
+	ret = io_uring_queue_init(1, &ring, 0);
+	if (ret < 0) {
+		ksft_test_result_skip("io_uring_queue_init() failed\n");
+		goto free_tmp;
+	}
+
+	/*
+	 * Register the range as a fixed buffer. This will FOLL_WRITE | FOLL_PIN
+	 * | FOLL_LONGTERM the range.
+	 *
+	 * Skip on errors, as we might just lack kernel support or might not
+	 * have sufficient MEMLOCK permissions.
+	 */
+	iov.iov_base = mem;
+	iov.iov_len = size;
+	ret = io_uring_register_buffers(&ring, &iov, 1);
+	if (ret) {
+		ksft_test_result_skip("io_uring_register_buffers() failed\n");
+		goto queue_exit;
+	}
+
+	if (use_fork) {
+		/*
+		 * fork() and keep the child alive until we're done. Note that
+		 * we expect the pinned page to not get shared with the child.
+		 */
+		ret = fork();
+		if (ret < 0) {
+			ksft_test_result_fail("fork() failed\n");
+			goto unregister_buffers;
+		} else if (!ret) {
+			write(comm_pipes.child_ready[1], "0", 1);
+			while (read(comm_pipes.parent_ready[0], &buf, 1) != 1)
+				;
+			exit(0);
+		}
+
+		while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
+			;
+	} else {
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
+			goto unregister_buffers;
+		}
+	}
+
+	/*
+	 * Modify the page and write page content as observed by the fixed
+	 * buffer pin to the file so we can verify it.
+	 */
+	memset(mem, 0xff, size);
+	sqe = io_uring_get_sqe(&ring);
+	if (!sqe) {
+		ksft_test_result_fail("io_uring_get_sqe() failed\n");
+		goto quit_child;
+	}
+	io_uring_prep_write_fixed(sqe, fd, mem, size, 0, 0);
+
+	ret = io_uring_submit(&ring);
+	if (ret < 0) {
+		ksft_test_result_fail("io_uring_submit() failed\n");
+		goto quit_child;
+	}
+
+	ret = io_uring_wait_cqe(&ring, &cqe);
+	if (ret < 0) {
+		ksft_test_result_fail("io_uring_wait_cqe() failed\n");
+		goto quit_child;
+	}
+
+	if (cqe->res != size) {
+		ksft_test_result_fail("write_fixed failed\n");
+		goto quit_child;
+	}
+	io_uring_cqe_seen(&ring, cqe);
+
+	/* Read back the file content to the temporary buffer. */
+	total = 0;
+	while (total < size) {
+		cur = pread(fd, tmp + total, size - total, total);
+		if (cur < 0) {
+			ksft_test_result_fail("pread() failed\n");
+			goto quit_child;
+		}
+		total += cur;
+	}
+
+	/* Finally, check if we read what we expected. */
+	ksft_test_result(!memcmp(mem, tmp, size),
+			 "Longterm R/W pin is reliable\n");
+
+quit_child:
+	if (use_fork) {
+		write(comm_pipes.parent_ready[1], "0", 1);
+		wait(&ret);
+	}
+unregister_buffers:
+	io_uring_unregister_buffers(&ring);
+queue_exit:
+	io_uring_queue_exit(&ring);
+free_tmp:
+	free(tmp);
+close_file:
+	fclose(file);
+close_comm_pipes:
+	close_comm_pipes(&comm_pipes);
+}
+
+static void test_iouring_ro(char *mem, size_t size)
+{
+	do_test_iouring(mem, size, false);
+}
+
+static void test_iouring_fork(char *mem, size_t size)
+{
+	do_test_iouring(mem, size, true);
+}
+
+#endif /* LOCAL_CONFIG_HAVE_LIBURING */
+
 typedef void (*test_fn)(char *mem, size_t size);
 
 static void do_run_with_base_page(test_fn fn, bool swapout)
@@ -660,6 +829,27 @@ static const struct test_case test_cases[] = {
 		"vmsplice() + unmap in parent after fork()",
 		test_vmsplice_after_fork,
 	},
+#ifdef LOCAL_CONFIG_HAVE_LIBURING
+	/*
+	 * Take a R/W longterm pin and then map the page R/O into the page
+	 * table to trigger a write fault on next access. When modifying the
+	 * page, the page content must be visible via the pin.
+	 */
+	{
+		"R/O-mapping a page registered as iouring fixed buffer",
+		test_iouring_ro,
+	},
+	/*
+	 * Take a R/W longterm pin and then fork() a child. When modifying the
+	 * page, the page content must be visible via the pin. We expect the
+	 * pinned page to not get shared with the child.
+	 */
+	{
+		"fork() with an iouring fixed buffer",
+		test_iouring_fork,
+	},
+
+#endif /* LOCAL_CONFIG_HAVE_LIBURING */
 };
 
 static void run_test_case(struct test_case const *test_case)
diff --git a/tools/testing/selftests/vm/check_config.sh b/tools/testing/selftests/vm/check_config.sh
new file mode 100644
index 000000000000..9a44c6520925
--- /dev/null
+++ b/tools/testing/selftests/vm/check_config.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Probe for libraries and create header files to record the results. Both C
+# header files and Makefile include fragments are created.
+
+OUTPUT_H_FILE=local_config.h
+OUTPUT_MKFILE=local_config.mk
+
+tmpname=$(mktemp)
+tmpfile_c=${tmpname}.c
+tmpfile_o=${tmpname}.o
+
+# liburing
+echo "#include <sys/types.h>"        > $tmpfile_c
+echo "#include <liburing.h>"        >> $tmpfile_c
+echo "int func(void) { return 0; }" >> $tmpfile_c
+
+CC=${1:?"Usage: $0 <compiler> # example compiler: gcc"}
+$CC -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
+
+if [ -f $tmpfile_o ]; then
+    echo "#define LOCAL_CONFIG_HAVE_LIBURING 1"  > $OUTPUT_H_FILE
+    echo "ANON_COW_EXTRA_LIBS = -luring"         > $OUTPUT_MKFILE
+else
+    echo "// No liburing support found"          > $OUTPUT_H_FILE
+    echo "# No liburing support found, so:"      > $OUTPUT_MKFILE
+    echo "ANON_COW_EXTRA_LIBS = "               >> $OUTPUT_MKFILE
+fi
+
+rm ${tmpname}.*
-- 
2.37.3

