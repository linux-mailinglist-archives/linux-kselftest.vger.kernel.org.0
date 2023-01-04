Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759D665D68B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jan 2023 15:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjADOuE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Jan 2023 09:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjADOuA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Jan 2023 09:50:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C117E2D
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Jan 2023 06:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672843753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vYvLrxNyig4C2xqpvcE+0kFAae3psmSX82BXbPf3PXw=;
        b=GR9MmgqtWlWjSfms4RWkgTug8w3YxaWmsHku4bVyNzsdF00N0ATlCjIK8EX/uwYX47Ydps
        zF9CLlw/nqDakqWGMnSIUNOWFl0hDaJZJ2ruNDix0FsiZaIbbmCnJfNd5iqMmOKOEYADNw
        2ytfEYdCFRNqtweS86JwWoxjX76n2Kk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-uZTwnicCP9GfYWq8ihQLrg-1; Wed, 04 Jan 2023 09:49:10 -0500
X-MC-Unique: uZTwnicCP9GfYWq8ihQLrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8414E858F09;
        Wed,  4 Jan 2023 14:49:09 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FC66C15BA0;
        Wed,  4 Jan 2023 14:49:06 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH mm-unstable v1] selftests/vm: cow: Add COW tests for collapsing of PTE-mapped anon THP
Date:   Wed,  4 Jan 2023 15:49:05 +0100
Message-Id: <20230104144905.460075-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, anonymous PTE-mapped THPs cannot be collapsed in-place:
collapsing (e.g., via MADV_COLLAPSE) implies allocating a fresh THP and
mapping that new THP via a PMD: as it's a fresh anon THP, it will get the
exclusive flag set on the head page and everybody is happy.

However, if the kernel would ever support in-place collapse of anonymous
THPs (replacing a page table mapping each sub-page of a THP via PTEs with a
single PMD mapping the complete THP), exclusivity information stored for
each sub-page would have to be collapsed accordingly:

(1) All PTEs map !exclusive anon sub-pages: the in-place collapsed THP
    must not not have the exclusive flag set on the head page mapped by
    the PMD. This is the easiest case to handle ("simply don't set any
    exclusive flags").

(2) All PTEs map exclusive anon sub-pages: when collapsing, we have to
    clear the exclusive flag from all tail pages and only leave the
    exclusive flag set for the head page. Otherwise, fork() after
    collapse would not clear the exclusive flags from the tail pages
    and we'd be in trouble once PTE-mapping the shared THP when writing
    to shared tail pages that still have the exclusive flag set. This
    would effectively revert what the PTE-mapping code does when
    propagating the exclusive flag to all sub-pages.

(3) PTEs map a mixture of exclusive and !exclusive anon sub-pages (can
    happen e.g., due to MADV_DONTFORK before fork()). We must not
    collapse the THP in-place, otherwise bad things may happen:
    the exclusive flags of sub-pages would get ignored and the
    exclusive flag of the head page would get used instead.

Now that we have MADV_COLLAPSE in place to trigger collapsing a THP,
let's add some test cases that would bail out early, if we'd
voluntarily/accidantially unlock in-place collapse for anon THPs and
forget about taking proper care of exclusive flags.

Running the test on a kernel with MADV_COLLAPSE support:
  # [INFO] Anonymous THP tests
  # [RUN] Basic COW after fork() when collapsing before fork()
  ok 169 No leak from parent into child
  # [RUN] Basic COW after fork() when collapsing after fork() (fully shared)
  ok 170 # SKIP MADV_COLLAPSE failed: Invalid argument
  # [RUN] Basic COW after fork() when collapsing after fork() (lower shared)
  ok 171 No leak from parent into child
  # [RUN] Basic COW after fork() when collapsing after fork() (upper shared)
  ok 172 No leak from parent into child

For now, MADV_COLLAPSE always seems to fail if all PTEs map shared
sub-pages.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Zach O'Keefe <zokeefe@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

A patch from Hugh made me explore the wonderful world of in-place collapse
of THP, and I was briefly concerned that it would apply to anon THP as
well. After thinking about it a bit, I decided to add test cases, to better
be safe than sorry in any case, and to document how PG_anon_exclusive is to
be handled in that case.

---
 tools/testing/selftests/vm/cow.c | 228 +++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/tools/testing/selftests/vm/cow.c b/tools/testing/selftests/vm/cow.c
index 26f6ea3079e2..16216d893d96 100644
--- a/tools/testing/selftests/vm/cow.c
+++ b/tools/testing/selftests/vm/cow.c
@@ -30,6 +30,10 @@
 #include "../kselftest.h"
 #include "vm_util.h"
 
+#ifndef MADV_COLLAPSE
+#define MADV_COLLAPSE 25
+#endif
+
 static size_t pagesize;
 static int pagemap_fd;
 static size_t thpsize;
@@ -1178,6 +1182,228 @@ static int tests_per_anon_test_case(void)
 	return tests;
 }
 
+enum anon_thp_collapse_test {
+	ANON_THP_COLLAPSE_UNSHARED,
+	ANON_THP_COLLAPSE_FULLY_SHARED,
+	ANON_THP_COLLAPSE_LOWER_SHARED,
+	ANON_THP_COLLAPSE_UPPER_SHARED,
+};
+
+static void do_test_anon_thp_collapse(char *mem, size_t size,
+				      enum anon_thp_collapse_test test)
+{
+	struct comm_pipes comm_pipes;
+	char buf;
+	int ret;
+
+	ret = setup_comm_pipes(&comm_pipes);
+	if (ret) {
+		ksft_test_result_fail("pipe() failed\n");
+		return;
+	}
+
+	/*
+	 * Trigger PTE-mapping the THP by temporarily mapping a single subpage
+	 * R/O, such that we can try collapsing it later.
+	 */
+	ret = mprotect(mem + pagesize, pagesize, PROT_READ);
+	if (ret) {
+		ksft_test_result_fail("mprotect() failed\n");
+		goto close_comm_pipes;
+	}
+	ret = mprotect(mem + pagesize, pagesize, PROT_READ | PROT_WRITE);
+	if (ret) {
+		ksft_test_result_fail("mprotect() failed\n");
+		goto close_comm_pipes;
+	}
+
+	switch (test) {
+	case ANON_THP_COLLAPSE_UNSHARED:
+		/* Collapse before actually COW-sharing the page. */
+		ret = madvise(mem, size, MADV_COLLAPSE);
+		if (ret) {
+			ksft_test_result_skip("MADV_COLLAPSE failed: %s\n",
+					      strerror(errno));
+			goto close_comm_pipes;
+		}
+		break;
+	case ANON_THP_COLLAPSE_FULLY_SHARED:
+		/* COW-share the full PTE-mapped THP. */
+		break;
+	case ANON_THP_COLLAPSE_LOWER_SHARED:
+		/* Don't COW-share the upper part of the THP. */
+		ret = madvise(mem + size / 2, size / 2, MADV_DONTFORK);
+		if (ret) {
+			ksft_test_result_fail("MADV_DONTFORK failed\n");
+			goto close_comm_pipes;
+		}
+		break;
+	case ANON_THP_COLLAPSE_UPPER_SHARED:
+		/* Don't COW-share the lower part of the THP. */
+		ret = madvise(mem, size / 2, MADV_DONTFORK);
+		if (ret) {
+			ksft_test_result_fail("MADV_DONTFORK failed\n");
+			goto close_comm_pipes;
+		}
+		break;
+	default:
+		assert(false);
+	}
+
+	ret = fork();
+	if (ret < 0) {
+		ksft_test_result_fail("fork() failed\n");
+		goto close_comm_pipes;
+	} else if (!ret) {
+		switch (test) {
+		case ANON_THP_COLLAPSE_UNSHARED:
+		case ANON_THP_COLLAPSE_FULLY_SHARED:
+			exit(child_memcmp_fn(mem, size, &comm_pipes));
+			break;
+		case ANON_THP_COLLAPSE_LOWER_SHARED:
+			exit(child_memcmp_fn(mem, size / 2, &comm_pipes));
+			break;
+		case ANON_THP_COLLAPSE_UPPER_SHARED:
+			exit(child_memcmp_fn(mem + size / 2, size / 2,
+					     &comm_pipes));
+			break;
+		default:
+			assert(false);
+		}
+	}
+
+	while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
+		;
+
+	switch (test) {
+	case ANON_THP_COLLAPSE_UNSHARED:
+		break;
+	case ANON_THP_COLLAPSE_UPPER_SHARED:
+	case ANON_THP_COLLAPSE_LOWER_SHARED:
+		/*
+		 * Revert MADV_DONTFORK such that we merge the VMAs and are
+		 * able to actually collapse.
+		 */
+		ret = madvise(mem, size, MADV_DOFORK);
+		if (ret) {
+			ksft_test_result_fail("MADV_DOFORK failed\n");
+			write(comm_pipes.parent_ready[1], "0", 1);
+			wait(&ret);
+			goto close_comm_pipes;
+		}
+		/* FALLTHROUGH */
+	case ANON_THP_COLLAPSE_FULLY_SHARED:
+		/* Collapse before anyone modified the COW-shared page. */
+		ret = madvise(mem, size, MADV_COLLAPSE);
+		if (ret) {
+			ksft_test_result_skip("MADV_COLLAPSE failed: %s\n",
+					      strerror(errno));
+			write(comm_pipes.parent_ready[1], "0", 1);
+			wait(&ret);
+			goto close_comm_pipes;
+		}
+		break;
+	default:
+		assert(false);
+	}
+
+	/* Modify the page. */
+	memset(mem, 0xff, size);
+	write(comm_pipes.parent_ready[1], "0", 1);
+
+	wait(&ret);
+	if (WIFEXITED(ret))
+		ret = WEXITSTATUS(ret);
+	else
+		ret = -EINVAL;
+
+	ksft_test_result(!ret, "No leak from parent into child\n");
+close_comm_pipes:
+	close_comm_pipes(&comm_pipes);
+}
+
+static void test_anon_thp_collapse_unshared(char *mem, size_t size)
+{
+	do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_UNSHARED);
+}
+
+static void test_anon_thp_collapse_fully_shared(char *mem, size_t size)
+{
+	do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_FULLY_SHARED);
+}
+
+static void test_anon_thp_collapse_lower_shared(char *mem, size_t size)
+{
+	do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_LOWER_SHARED);
+}
+
+static void test_anon_thp_collapse_upper_shared(char *mem, size_t size)
+{
+	do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_UPPER_SHARED);
+}
+
+/*
+ * Test cases that are specific to anonymous THP: pages in private mappings
+ * that may get shared via COW during fork().
+ */
+static const struct test_case anon_thp_test_cases[] = {
+	/*
+	 * Basic COW test for fork() without any GUP when collapsing a THP
+	 * before fork().
+	 *
+	 * Re-mapping a PTE-mapped anon THP using a single PMD ("in-place
+	 * collapse") might easily get COW handling wrong when not collapsing
+	 * exclusivity information properly.
+	 */
+	{
+		"Basic COW after fork() when collapsing before fork()",
+		test_anon_thp_collapse_unshared,
+	},
+	/* Basic COW test, but collapse after COW-sharing a full THP. */
+	{
+		"Basic COW after fork() when collapsing after fork() (fully shared)",
+		test_anon_thp_collapse_fully_shared,
+	},
+	/*
+	 * Basic COW test, but collapse after COW-sharing the lower half of a
+	 * THP.
+	 */
+	{
+		"Basic COW after fork() when collapsing after fork() (lower shared)",
+		test_anon_thp_collapse_lower_shared,
+	},
+	/*
+	 * Basic COW test, but collapse after COW-sharing the upper half of a
+	 * THP.
+	 */
+	{
+		"Basic COW after fork() when collapsing after fork() (upper shared)",
+		test_anon_thp_collapse_upper_shared,
+	},
+};
+
+static void run_anon_thp_test_cases(void)
+{
+	int i;
+
+	if (!thpsize)
+		return;
+
+	ksft_print_msg("[INFO] Anonymous THP tests\n");
+
+	for (i = 0; i < ARRAY_SIZE(anon_thp_test_cases); i++) {
+		struct test_case const *test_case = &anon_thp_test_cases[i];
+
+		ksft_print_msg("[RUN] %s\n", test_case->desc);
+		do_run_with_thp(test_case->fn, THP_RUN_PMD);
+	}
+}
+
+static int tests_per_anon_thp_test_case(void)
+{
+	return thpsize ? 1 : 0;
+}
+
 typedef void (*non_anon_test_fn)(char *mem, const char *smem, size_t size);
 
 static void test_cow(char *mem, const char *smem, size_t size)
@@ -1518,6 +1744,7 @@ int main(int argc, char **argv)
 
 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(anon_test_cases) * tests_per_anon_test_case() +
+		      ARRAY_SIZE(anon_thp_test_cases) * tests_per_anon_thp_test_case() +
 		      ARRAY_SIZE(non_anon_test_cases) * tests_per_non_anon_test_case());
 
 	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
@@ -1526,6 +1753,7 @@ int main(int argc, char **argv)
 		ksft_exit_fail_msg("opening pagemap failed\n");
 
 	run_anon_test_cases();
+	run_anon_thp_test_cases();
 	run_non_anon_test_cases();
 
 	err = ksft_get_fail_cnt();
-- 
2.39.0

