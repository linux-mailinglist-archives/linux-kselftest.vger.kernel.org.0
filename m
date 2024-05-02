Return-Path: <linux-kselftest+bounces-9259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704638B96E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 10:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325402822F3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E351C5F;
	Thu,  2 May 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vc0yg0Dt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892B47F51
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639991; cv=none; b=F6BEVqByyGfBWoSnd4UNUFxJOLRPaUszasTwyvZxDLMyppkjH+gBlKrB+HOQncW0wemYU5TOXIAQAqwtjgZlrx6vl40yG/iTbELx5cAQTjKdpMgxRa1fvQKg1ZhccC3Brz7OBHe5EMr33rfR0x/ngIBZewvmP18jeY/u6nzCO4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639991; c=relaxed/simple;
	bh=N/tebkFV1ky+1joNxCtc9i6jY8/JpH9+z98mvzjHXac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfSXtoqcXzuG6ATEFk+GowPsdwZHVxD1FPa0sv7fSFjEbg2b+AjooLXyD6nvlTpDBPbxofstI02+i5dEDsOjOEr6zZQ9IYQT8w7zpVNXhDQfVNxpmwBRqwJk6ggRtqfTVTAeW8Fr8uUoHBzD0M1M0EOyrUIwt4lHzW0aY4ql/9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vc0yg0Dt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714639988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+yrxtuOeiS5hFZRcaRgCRs2sR/PYpyzZgCPJ77ecgw=;
	b=Vc0yg0DtnDPuhnwtYyxMDdWIpcODmI9d+jfehI7mN5iEripEZqUqQ1OGWSq8L/wnwc9UEH
	7ZtW5JOZ5wLRI+/0cODYVi4on0HdVwH9pdZ+iT4zD++EV1nZouJ3BRfLEvJ5hitTaML1JV
	MPIaYLQF9MxcA5QDcg0RinIKFAxvnEw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-0C5_9SRkMNef5MUxGF2VxA-1; Thu, 02 May 2024 04:53:04 -0400
X-MC-Unique: 0C5_9SRkMNef5MUxGF2VxA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EC168032FA;
	Thu,  2 May 2024 08:53:04 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.224])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 826F5492BC6;
	Thu,  2 May 2024 08:53:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 1/2] selftests: mm: cow: flag vmsplice() hugetlb tests as XFAIL
Date: Thu,  2 May 2024 10:52:58 +0200
Message-ID: <20240502085259.103784-2-david@redhat.com>
In-Reply-To: <20240502085259.103784-1-david@redhat.com>
References: <20240502085259.103784-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The vmsplice() hugetlb tests have been failing right from the start, and
we documented that in the introducing commit 7dad331be781 ("selftests/vm:
anon_cow: hugetlb tests"):

	Note that some tests cases still fail. This will, for example, be
	fixed once vmsplice properly uses FOLL_PIN instead of FOLL_GET for
	pinning. With 2 MiB and 1 GiB hugetlb on x86_64, the expected
	failures are:

Until vmsplice() is changed, these tests will likely keep failing: hugetlb
COW reuse logic is harder to change, because using the same COW reuse logic
as we use for !hugetlb could harm other (sane) users when running out
of free hugetlb pages.

More details can be found in [1], especially around how hugetlb pages
cannot really be overcommitted, and why we don't particularly care about
these vmsplice() leaks for hugetlb -- in contrast to ordinary memory.

These (expected) failures keep confusing people, so flag them accordingly.

Before:
	$ ./cow
	[...]
	Bail out! 8 out of 778 tests failed
	# Totals: pass:769 fail:8 xfail:0 xpass:0 skip:1 error:0
	$ echo $?
	1

After:
	$ ./cow
	[...]
	# Totals: pass:769 fail:0 xfail:8 xpass:0 skip:1 error:0
	$ echo $?
	0

[1] https://lore.kernel.org/all/8b42a24d-caf0-46ef-9e15-0f88d47d2f21@redhat.com/

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/cow.c | 106 +++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 363bf5f801be5..0549672acbd63 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -199,7 +199,7 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
 typedef int (*child_fn)(char *mem, size_t size, struct comm_pipes *comm_pipes);
 
 static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
-				  child_fn fn)
+		child_fn fn, bool xfail)
 {
 	struct comm_pipes comm_pipes;
 	char buf;
@@ -247,33 +247,47 @@ static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
 	else
 		ret = -EINVAL;
 
-	ksft_test_result(!ret, "No leak from parent into child\n");
+	if (!ret) {
+		ksft_test_result_pass("No leak from parent into child\n");
+	} else if (xfail) {
+		/*
+		 * With hugetlb, some vmsplice() tests are currently expected to
+		 * fail because (a) harder to fix and (b) nobody really cares.
+		 * Flag them as expected failure for now.
+		 */
+		ksft_test_result_xfail("Leak from parent into child\n");
+	} else {
+		ksft_test_result_fail("Leak from parent into child\n");
+	}
 close_comm_pipes:
 	close_comm_pipes(&comm_pipes);
 }
 
-static void test_cow_in_parent(char *mem, size_t size)
+static void test_cow_in_parent(char *mem, size_t size, bool is_hugetlb)
 {
-	do_test_cow_in_parent(mem, size, false, child_memcmp_fn);
+	do_test_cow_in_parent(mem, size, false, child_memcmp_fn, false);
 }
 
-static void test_cow_in_parent_mprotect(char *mem, size_t size)
+static void test_cow_in_parent_mprotect(char *mem, size_t size, bool is_hugetlb)
 {
-	do_test_cow_in_parent(mem, size, true, child_memcmp_fn);
+	do_test_cow_in_parent(mem, size, true, child_memcmp_fn, false);
 }
 
-static void test_vmsplice_in_child(char *mem, size_t size)
+static void test_vmsplice_in_child(char *mem, size_t size, bool is_hugetlb)
 {
-	do_test_cow_in_parent(mem, size, false, child_vmsplice_memcmp_fn);
+	do_test_cow_in_parent(mem, size, false, child_vmsplice_memcmp_fn,
+			      is_hugetlb);
 }
 
-static void test_vmsplice_in_child_mprotect(char *mem, size_t size)
+static void test_vmsplice_in_child_mprotect(char *mem, size_t size,
+		bool is_hugetlb)
 {
-	do_test_cow_in_parent(mem, size, true, child_vmsplice_memcmp_fn);
+	do_test_cow_in_parent(mem, size, true, child_vmsplice_memcmp_fn,
+			      is_hugetlb);
 }
 
 static void do_test_vmsplice_in_parent(char *mem, size_t size,
-				       bool before_fork)
+				       bool before_fork, bool xfail)
 {
 	struct iovec iov = {
 		.iov_base = mem,
@@ -355,8 +369,18 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
 		}
 	}
 
-	ksft_test_result(!memcmp(old, new, transferred),
-			 "No leak from child into parent\n");
+	if (!memcmp(old, new, transferred)) {
+		ksft_test_result_pass("No leak from child into parent\n");
+	} else if (xfail) {
+		/*
+		 * With hugetlb, some vmsplice() tests are currently expected to
+		 * fail because (a) harder to fix and (b) nobody really cares.
+		 * Flag them as expected failure for now.
+		 */
+		ksft_test_result_xfail("Leak from child into parent\n");
+	} else {
+		ksft_test_result_fail("Leak from child into parent\n");
+	}
 close_pipe:
 	close(fds[0]);
 	close(fds[1]);
@@ -367,14 +391,14 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
 	free(new);
 }
 
-static void test_vmsplice_before_fork(char *mem, size_t size)
+static void test_vmsplice_before_fork(char *mem, size_t size, bool is_hugetlb)
 {
-	do_test_vmsplice_in_parent(mem, size, true);
+	do_test_vmsplice_in_parent(mem, size, true, is_hugetlb);
 }
 
-static void test_vmsplice_after_fork(char *mem, size_t size)
+static void test_vmsplice_after_fork(char *mem, size_t size, bool is_hugetlb)
 {
-	do_test_vmsplice_in_parent(mem, size, false);
+	do_test_vmsplice_in_parent(mem, size, false, is_hugetlb);
 }
 
 #ifdef LOCAL_CONFIG_HAVE_LIBURING
@@ -529,12 +553,12 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 	close_comm_pipes(&comm_pipes);
 }
 
-static void test_iouring_ro(char *mem, size_t size)
+static void test_iouring_ro(char *mem, size_t size, bool is_hugetlb)
 {
 	do_test_iouring(mem, size, false);
 }
 
-static void test_iouring_fork(char *mem, size_t size)
+static void test_iouring_fork(char *mem, size_t size, bool is_hugetlb)
 {
 	do_test_iouring(mem, size, true);
 }
@@ -678,37 +702,41 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 	free(tmp);
 }
 
-static void test_ro_pin_on_shared(char *mem, size_t size)
+static void test_ro_pin_on_shared(char *mem, size_t size, bool is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_SHARED, false);
 }
 
-static void test_ro_fast_pin_on_shared(char *mem, size_t size)
+static void test_ro_fast_pin_on_shared(char *mem, size_t size, bool is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_SHARED, true);
 }
 
-static void test_ro_pin_on_ro_previously_shared(char *mem, size_t size)
+static void test_ro_pin_on_ro_previously_shared(char *mem, size_t size,
+		bool is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_PREVIOUSLY_SHARED, false);
 }
 
-static void test_ro_fast_pin_on_ro_previously_shared(char *mem, size_t size)
+static void test_ro_fast_pin_on_ro_previously_shared(char *mem, size_t size,
+		bool is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_PREVIOUSLY_SHARED, true);
 }
 
-static void test_ro_pin_on_ro_exclusive(char *mem, size_t size)
+static void test_ro_pin_on_ro_exclusive(char *mem, size_t size,
+		bool is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_RO_EXCLUSIVE, false);
 }
 
-static void test_ro_fast_pin_on_ro_exclusive(char *mem, size_t size)
+static void test_ro_fast_pin_on_ro_exclusive(char *mem, size_t size,
+		bool is_hugetlb)
 {
 	do_test_ro_pin(mem, size, RO_PIN_TEST_RO_EXCLUSIVE, true);
 }
 
-typedef void (*test_fn)(char *mem, size_t size);
+typedef void (*test_fn)(char *mem, size_t size, bool hugetlb);
 
 static void do_run_with_base_page(test_fn fn, bool swapout)
 {
@@ -740,7 +768,7 @@ static void do_run_with_base_page(test_fn fn, bool swapout)
 		}
 	}
 
-	fn(mem, pagesize);
+	fn(mem, pagesize, false);
 munmap:
 	munmap(mem, pagesize);
 }
@@ -904,7 +932,7 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 		break;
 	}
 
-	fn(mem, size);
+	fn(mem, size, false);
 munmap:
 	munmap(mmap_mem, mmap_size);
 	if (mremap_mem != MAP_FAILED)
@@ -997,7 +1025,7 @@ static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
 	}
 	munmap(dummy, hugetlbsize);
 
-	fn(mem, hugetlbsize);
+	fn(mem, hugetlbsize, true);
 munmap:
 	munmap(mem, hugetlbsize);
 }
@@ -1036,7 +1064,7 @@ static const struct test_case anon_test_cases[] = {
 	 */
 	{
 		"vmsplice() + unmap in child",
-		test_vmsplice_in_child
+		test_vmsplice_in_child,
 	},
 	/*
 	 * vmsplice() test, but do an additional mprotect(PROT_READ)+
@@ -1044,7 +1072,7 @@ static const struct test_case anon_test_cases[] = {
 	 */
 	{
 		"vmsplice() + unmap in child with mprotect() optimization",
-		test_vmsplice_in_child_mprotect
+		test_vmsplice_in_child_mprotect,
 	},
 	/*
 	 * vmsplice() [R/O GUP] in parent before fork(), unmap in parent after
@@ -1322,23 +1350,31 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
 	close_comm_pipes(&comm_pipes);
 }
 
-static void test_anon_thp_collapse_unshared(char *mem, size_t size)
+static void test_anon_thp_collapse_unshared(char *mem, size_t size,
+		bool is_hugetlb)
 {
+	assert(!is_hugetlb);
 	do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_UNSHARED);
 }
 
-static void test_anon_thp_collapse_fully_shared(char *mem, size_t size)
+static void test_anon_thp_collapse_fully_shared(char *mem, size_t size,
+		bool is_hugetlb)
 {
+	assert(!is_hugetlb);
 	do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_FULLY_SHARED);
 }
 
-static void test_anon_thp_collapse_lower_shared(char *mem, size_t size)
+static void test_anon_thp_collapse_lower_shared(char *mem, size_t size,
+		bool is_hugetlb)
 {
+	assert(!is_hugetlb);
 	do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_LOWER_SHARED);
 }
 
-static void test_anon_thp_collapse_upper_shared(char *mem, size_t size)
+static void test_anon_thp_collapse_upper_shared(char *mem, size_t size,
+		bool is_hugetlb)
 {
+	assert(!is_hugetlb);
 	do_test_anon_thp_collapse(mem, size, ANON_THP_COLLAPSE_UPPER_SHARED);
 }
 
-- 
2.44.0


