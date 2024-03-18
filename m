Return-Path: <linux-kselftest+bounces-6378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3176787E228
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 03:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A2B1F21EA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 02:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47201FDA;
	Mon, 18 Mar 2024 02:35:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ECF17547;
	Mon, 18 Mar 2024 02:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710729308; cv=none; b=tRkJxhTEilTC8ARPtltVFEkzKl1QGOlvf8ZhWal1r6veBFZ3ozhLjtITzjYxGKUD2VeLej1JrJfTZrLvLlSf1T2hkiCMaDDjecTRFL4X3BDr6Z488cdqTfy7W8ohqMsozwo72bnJSbI9M48HIVBM+hrls6snOdzEwGRU8CXcasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710729308; c=relaxed/simple;
	bh=3fvjQ3XM2dUSCoHrk4prb1GoygcuSIqrovfjGK/r3oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A21ZIJCwLsiQXpUrSPUo00iygoGH3bNR9tQzsgEcO/b2cIcTGRKE+MW0Qvw+q2cD+TkiBQiOmw1WCBCnc3ZANnsEdGKGypqCasMCWf+sjAX14D6PtmI8+uTyh9TWMSUc7V5fqH0vIIzNGUw2cvdG8sijfiE/HaL3VZXzgDimDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id B1C3E72C8F5;
	Mon, 18 Mar 2024 05:35:03 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 9DA5836D015F;
	Mon, 18 Mar 2024 05:35:03 +0300 (MSK)
From: Vitaly Chikunov <vt@altlinux.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vitaly Chikunov <vt@altlinux.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftests/mm: Fix build with _FORTIFY_SOURCE
Date: Mon, 18 Mar 2024 05:34:44 +0300
Message-ID: <20240318023445.3192922-1-vt@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing flags argument to open(2) call with O_CREAT.

Some tests fail to compile if _FORTIFY_SOURCE is defined (to any valid
value) (together with -O), resulting in similar error messages such as:

  In file included from /usr/include/fcntl.h:342,
                   from gup_test.c:1:
  In function 'open',
      inlined from 'main' at gup_test.c:206:10:
  /usr/include/bits/fcntl2.h:50:11: error: call to '__open_missing_mode' declared with attribute error: open with O_CREAT or O_TMPFILE in second argument needs 3 arguments
     50 |           __open_missing_mode ();
        |           ^~~~~~~~~~~~~~~~~~~~~~

_FORTIFY_SOURCE is enabled by default in some distributions, so the
tests are not built by default and are skipped.

open(2) man-page warns about missing flags argument: "if it is not
supplied, some arbitrary bytes from the stack will be applied as the
file mode."

Fixes: aeb85ed4f41a ("tools/testing/selftests/vm/gup_benchmark.c: allow user specified file")
Fixes: fbe37501b252 ("mm: huge_memory: debugfs for file-backed THP split")
Fixes: c942f5bd17b3 ("selftests: soft-dirty: add test for mprotect")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 tools/testing/selftests/mm/gup_test.c             | 2 +-
 tools/testing/selftests/mm/soft-dirty.c           | 2 +-
 tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index cbe99594d319..18a49c70d4c6 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -203,7 +203,7 @@ int main(int argc, char **argv)
 	ksft_print_header();
 	ksft_set_plan(nthreads);
 
-	filed = open(file, O_RDWR|O_CREAT);
+	filed = open(file, O_RDWR|O_CREAT, 0664);
 	if (filed < 0)
 		ksft_exit_fail_msg("Unable to open %s: %s\n", file, strerror(errno));
 
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index cc5f144430d4..7dbfa53d93a0 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -137,7 +137,7 @@ static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
 		if (!map)
 			ksft_exit_fail_msg("anon mmap failed\n");
 	} else {
-		test_fd = open(fname, O_RDWR | O_CREAT);
+		test_fd = open(fname, O_RDWR | O_CREAT, 0664);
 		if (test_fd < 0) {
 			ksft_test_result_skip("Test %s open() file failed\n", __func__);
 			return;
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 856662d2f87a..6c988bd2f335 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -223,7 +223,7 @@ void split_file_backed_thp(void)
 		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
 	}
 
-	fd = open(testfile, O_CREAT|O_WRONLY);
+	fd = open(testfile, O_CREAT|O_WRONLY, 0664);
 	if (fd == -1) {
 		ksft_perror("Cannot open testing file");
 		goto cleanup;
-- 
2.42.1


