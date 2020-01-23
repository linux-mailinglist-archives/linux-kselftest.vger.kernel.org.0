Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1061F14704E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 19:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgAWSEv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 13:04:51 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49507 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgAWSEu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:50 -0500
Received: by mail-pg1-f202.google.com with SMTP id u14so2222462pgq.16
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 10:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MyR2A3lG/6QZG1DSQDGZ1Xyya7Fcg8NXjHhCQPSoGIY=;
        b=RlzHUnZdlr2kuwqncMOZ9TpW0T8gMRYwxGtx+ywksjUQpzix1ZLfp+Puk+FjAU7Vid
         7gS0I3dp7o97USaMcHQ0ONQnvTqMoMFUWdW1ZtLI4mon1Pj587pZhuph8HKqpL3rUP5E
         m1BvKW+6JJW+8LOC/l4JDog8G0V1M14wFCJ7tONfEt1dQKaacGfrqgvyPVGAoLAz0lr0
         GC8f1r9+LPfvcN2S8JuesYPDn5MUVxS9qY7+2xSSprpAfgEi1sWcvzqV++78IJ/MuLtp
         QdSqk1rUDN2LqzdGlfIQEuGa8bkfdMGo/si2F1JzfdouYGyjwT7S5z8AsHPRwJ5ki7JW
         VU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MyR2A3lG/6QZG1DSQDGZ1Xyya7Fcg8NXjHhCQPSoGIY=;
        b=pKe1udMzL/sv98TvKYcVBKD0pb+F2SI4MURNk9osyQUSjZwatmG9hg3j8mb91br7lh
         JQkAHZ8iMudCv4RYyIF9UFsbA5lr+sRjGwMpksarpmEqiWJnNOkGhBZBHvDiXgqPrWQ3
         6pt7N8zu6o+ba+hdyKM0XV+eganoCkq/ymuYKhxehQsuFMX+kxE36LqHDtSLito1HmXv
         HWk9/JzUh22DinjyGAp/nXQdSupupVVBJIZrpcPVcYVE7JTLxLDC8MbHPxUQqEWWjwAE
         U5DKAOeysvLeE2xJkNr4VH87fpR4RrB/9/YE7/d6wb84C5sFOfG4VaY6IgsI0Z4zK1KF
         QKQw==
X-Gm-Message-State: APjAAAVva6wonwKX4dhzzZXauaBJmL+X54bOWR3zz0mCoGOP4JxEMwjD
        JviFrhefVjNvSw32Ii3MkRZCvj6/i6jJ
X-Google-Smtp-Source: APXvYqwMosnV9otkmUQmnv1fnNu+pzuFVtdPbNtGNih2YrjaFj5/U612rkJAHjRqsAYBuyNxABqKDFAF+NTd
X-Received: by 2002:a63:211f:: with SMTP id h31mr4933362pgh.299.1579802689866;
 Thu, 23 Jan 2020 10:04:49 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:30 -0800
In-Reply-To: <20200123180436.99487-1-bgardon@google.com>
Message-Id: <20200123180436.99487-5-bgardon@google.com>
Mime-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 04/10] KVM: selftests: Add memory size parameter to the
 demand paging test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add an argument to allow the demand paging test to work on larger and
smaller guest sizes.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/Makefile          |  2 +-
 .../selftests/kvm/demand_paging_test.c        | 57 ++++++++++-------
 .../testing/selftests/kvm/include/test_util.h |  2 +
 tools/testing/selftests/kvm/lib/test_util.c   | 61 +++++++++++++++++++
 4 files changed, 100 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/test_util.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index e2e1b92faee3b..89bf05d4c2f3e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -7,7 +7,7 @@ top_srcdir = ../../../..
 KSFT_KHDR_INSTALL := 1
 UNAME_M := $(shell uname -m)
 
-LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c
+LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c lib/test_util.c
 LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/ucall.c
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c
diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 01d2c76ada55d..9d7514e96a639 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -32,6 +32,8 @@
 /* Default guest test virtual memory offset */
 #define DEFAULT_GUEST_TEST_MEM		0xc0000000
 
+#define DEFAULT_GUEST_TEST_MEM_SIZE (1 << 30) /* 1G */
+
 /*
  * Guest/Host shared variables. Ensure addr_gva2hva() and/or
  * sync_global_to/from_guest() are used when accessing from
@@ -274,11 +276,10 @@ static int setup_demand_paging(struct kvm_vm *vm,
 	return 0;
 }
 
-#define GUEST_MEM_SHIFT 30 /* 1G */
 #define PAGE_SHIFT_4K  12
 
 static void run_test(enum vm_guest_mode mode, bool use_uffd,
-		     useconds_t uffd_delay)
+		     useconds_t uffd_delay, uint64_t guest_memory_bytes)
 {
 	pthread_t vcpu_thread;
 	pthread_t uffd_handler_thread;
@@ -287,33 +288,40 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	int r;
 
 	/*
-	 * We reserve page table for 2 times of extra dirty mem which
-	 * will definitely cover the original (1G+) test range.  Here
-	 * we do the calculation with 4K page size which is the
-	 * smallest so the page number will be enough for all archs
-	 * (e.g., 64K page size guest will need even less memory for
-	 * page tables).
+	 * We reserve page table for twice the ammount of memory we intend
+	 * to use in the test region for demand paging. Here we do the
+	 * calculation with 4K page size which is the smallest so the page
+	 * number will be enough for all archs. (e.g., 64K page size guest
+	 * will need even less memory for page tables).
 	 */
 	vm = create_vm(mode, VCPU_ID,
-		       2ul << (GUEST_MEM_SHIFT - PAGE_SHIFT_4K),
+		       (2 * guest_memory_bytes) >> PAGE_SHIFT_4K,
 		       guest_code);
 
 	guest_page_size = vm_get_page_size(vm);
-	/*
-	 * A little more than 1G of guest page sized pages.  Cover the
-	 * case where the size is not aligned to 64 pages.
-	 */
-	guest_num_pages = (1ul << (GUEST_MEM_SHIFT -
-				   vm_get_page_shift(vm))) + 16;
+
+	TEST_ASSERT(guest_memory_bytes % guest_page_size == 0,
+		    "Guest memory size is not guest page size aligned.");
+
+	guest_num_pages = guest_memory_bytes / guest_page_size;
+
 #ifdef __s390x__
 	/* Round up to multiple of 1M (segment size) */
 	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
 #endif
+	/*
+	 * If there should be more memory in the guest test region than there
+	 * can be pages in the guest, it will definitely cause problems.
+	 */
+	TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
+		    "Requested more guest memory than address space allows.\n"
+		    "    guest pages: %lx max gfn: %lx\n",
+		    guest_num_pages, vm_get_max_gfn(vm));
 
 	host_page_size = getpagesize();
-	host_num_pages = (guest_num_pages * guest_page_size) / host_page_size +
-			 !!((guest_num_pages * guest_page_size) %
-			    host_page_size);
+	TEST_ASSERT(guest_memory_bytes % host_page_size == 0,
+		    "Guest memory size is not host page size aligned.");
+	host_num_pages = guest_memory_bytes / host_page_size;
 
 	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
 			      guest_page_size;
@@ -403,7 +411,8 @@ static void help(char *name)
 	int i;
 
 	puts("");
-	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n", name);
+	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
+	       "          [-b memory]\n", name);
 	printf(" -m: specify the guest mode ID to test\n"
 	       "     (default: test all supported modes)\n"
 	       "     This option may be used multiple times.\n"
@@ -417,6 +426,8 @@ static void help(char *name)
 	printf(" -d: add a delay in usec to the User Fault\n"
 	       "     FD handler to simulate demand paging\n"
 	       "     overheads. Ignored without -u.\n");
+	printf(" -b: specify the size of the memory region which should be\n"
+	       "     demand paged. e.g. 10M or 3G. Default: 1G\n");
 	puts("");
 	exit(0);
 }
@@ -424,6 +435,7 @@ static void help(char *name)
 int main(int argc, char *argv[])
 {
 	bool mode_selected = false;
+	uint64_t guest_memory_bytes = DEFAULT_GUEST_TEST_MEM_SIZE;
 	unsigned int mode;
 	int opt, i;
 	bool use_uffd = false;
@@ -451,7 +463,7 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hm:ud:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:ud:b:")) != -1) {
 		switch (opt) {
 		case 'm':
 			if (!mode_selected) {
@@ -472,6 +484,9 @@ int main(int argc, char *argv[])
 			TEST_ASSERT(uffd_delay >= 0,
 				    "A negative UFFD delay is not supported.");
 			break;
+		case 'b':
+			guest_memory_bytes = parse_size(optarg);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -485,7 +500,7 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(vm_guest_mode_params[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i, use_uffd, uffd_delay);
+		run_test(i, use_uffd, uffd_delay, guest_memory_bytes);
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a41db6fb7e24b..e696c8219d69a 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -39,4 +39,6 @@ void test_assert(bool exp, const char *exp_str,
 		    #a, #b, #a, (unsigned long) __a, #b, (unsigned long) __b); \
 } while (0)
 
+size_t parse_size(const char *size);
+
 #endif /* SELFTEST_KVM_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
new file mode 100644
index 0000000000000..706e0f963a44b
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * tools/testing/selftests/kvm/lib/test_util.c
+ *
+ * Copyright (C) 2020, Google LLC.
+ */
+
+#include "test_util.h"
+
+#include <ctype.h>
+
+/*
+ * Parses "[0-9]+[kmgt]?".
+ */
+size_t parse_size(const char *size)
+{
+	size_t len = strlen(size);
+	size_t i;
+	size_t scale_shift = 0;
+	size_t base;
+
+	TEST_ASSERT(len > 0, "Need at least 1 digit in '%s'", size);
+
+	/* Find the first letter in the string, indicating scale. */
+	for (i = 0; i < len; i++) {
+		if (!isdigit(size[i])) {
+			TEST_ASSERT(i > 0, "Need at least 1 digit in '%s'",
+				    size);
+			TEST_ASSERT(i == len - 1,
+				    "Expected letter at the end in '%s'.",
+				    size);
+			switch (tolower(size[i])) {
+			case 't':
+				scale_shift = 40;
+				break;
+			case 'g':
+				scale_shift = 30;
+				break;
+			case 'm':
+				scale_shift = 20;
+				break;
+			case 'k':
+				scale_shift = 10;
+				break;
+			default:
+				TEST_ASSERT(false, "Unknown size letter %c",
+					    size[i]);
+			}
+		}
+	}
+
+	TEST_ASSERT(scale_shift < 8 * sizeof(size_t),
+		    "Overflow parsing scale!");
+
+	base = atoi(size);
+
+	TEST_ASSERT(!(base & ~((1 << (sizeof(size_t) - scale_shift)) - 1)),
+	       "Overflow parsing size!");
+
+	return base << scale_shift;
+}
-- 
2.25.0.341.g760bfbb309-goog

