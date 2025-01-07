Return-Path: <linux-kselftest+bounces-23987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B04DAA04272
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD1A188769E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 14:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12761E47DB;
	Tue,  7 Jan 2025 14:26:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A2F1F1909
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Jan 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259969; cv=none; b=e9pXRcuV7/rUi8XFLZBLFdV6fJpfH69PIIrWDuFbzkHUGBYjQBYUPMz5SAiS78jstz08dIiPqi4bl/mktapf5h54y8oYXy8HnZUH12Tu22jW0RzgY05yJAVHo/anU7kb1wX2iEgepeHq1UooadYLZltY6RZxxuGO7wr2eg/sfLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259969; c=relaxed/simple;
	bh=wbYx6kJFsDa8xtqDkU+qrLjOBTqe8khQdgMEXBRMTrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akZt/G9bANE1JnJiG0OaVUFefv53jSU2W59sDIFyUsPTcB9j/GXof2AHs+QL52DEP64rWrVgYnGp1P8IK+xH08ICn2G7125ZpDEvyMhcBffSO5K95PvPcW/p8hs0P0HXx7WdSQyECDhNAwNbBLgu3s9oCxFpoW5Ey9zcoHGjPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AC511424;
	Tue,  7 Jan 2025 06:26:34 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3B023F59E;
	Tue,  7 Jan 2025 06:26:04 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1] selftests/mm: Set allocated memory to non-zero content in cow test
Date: Tue,  7 Jan 2025 14:25:53 +0000
Message-ID: <20250107142555.1870101-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit b1f202060afe ("mm: remap unused subpages to shared zeropage
when splitting isolated thp"), cow test cases involving swapping out
THPs via madvise(MADV_PAGEOUT) started to be skipped due to the
subsequent check via pagemap determining that the memory was not
actually swapped out. Logs similar to this were emitted:

   ...

   # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP (16 kB)
   ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
   # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP (16 kB)
   ok 3 # SKIP MADV_PAGEOUT did not work, is swap enabled?
   # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP (32 kB)
   ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?

   ...

The commit in question introduces the behaviour of scanning THPs and if
their content is predominantly zero, it splits them and replaces the
pages which are wholly zero with the zero page. These cow test cases
were getting caught up in this.

So let's avoid that by filling the contents of all allocated memory with
a non-zero value. With this in place, the tests are passing again.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Applies on top of mm-unstable (f349e79bfbf3)

Thanks,
Ryan

 tools/testing/selftests/mm/cow.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 32c6ccc2a6be..1238e1c5aae1 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -758,7 +758,7 @@ static void do_run_with_base_page(test_fn fn, bool swapout)
 	}

 	/* Populate a base page. */
-	memset(mem, 0, pagesize);
+	memset(mem, 1, pagesize);

 	if (swapout) {
 		madvise(mem, pagesize, MADV_PAGEOUT);
@@ -824,12 +824,12 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 	 * Try to populate a THP. Touch the first sub-page and test if
 	 * we get the last sub-page populated automatically.
 	 */
-	mem[0] = 0;
+	mem[0] = 1;
 	if (!pagemap_is_populated(pagemap_fd, mem + thpsize - pagesize)) {
 		ksft_test_result_skip("Did not get a THP populated\n");
 		goto munmap;
 	}
-	memset(mem, 0, thpsize);
+	memset(mem, 1, thpsize);

 	size = thpsize;
 	switch (thp_run) {
@@ -1012,7 +1012,7 @@ static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
 	}

 	/* Populate an huge page. */
-	memset(mem, 0, hugetlbsize);
+	memset(mem, 1, hugetlbsize);

 	/*
 	 * We need a total of two hugetlb pages to handle COW/unsharing
--
2.43.0


