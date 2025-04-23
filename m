Return-Path: <linux-kselftest+bounces-31388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0A6A987A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 12:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A285A47DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A391F26A0D0;
	Wed, 23 Apr 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rlf2Kmze"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DD1DE4E6
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404618; cv=none; b=CiCaU2iazhCAX6NnkiJX0znA0BsNHmhB8Yn36rq5/LxKiGFbD3KrmJCifbHmg3d3EBnOUFsHQrUQ1mSbg/r32d9S/J9BTh16oeQGyjPtgxM41I29IAB/S9pCIuaV2BRCqaaQJOXdlXgh3YVelTpFsq0x2VI081itYFUXUYgVgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404618; c=relaxed/simple;
	bh=lTr8RzRdNFKUfB7PWPjnn4jA/+fBxw14/jHRrM9Q28s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f0cpRUN9Q/j/crDCJjdmb9//L8V+OKbcU2BU4kKmMIpSoGdqQ/QbWKTdOg+zqQIzGSY+3jy2Qhl5S8fZUrFWPREP277asn4/ln2WJLRpN0GHAx28v+qjctWT+L6ApnZFBc1i30QCWqYL44FzRRQ+T+9BrWtBmqhWab60l/Y8pAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rlf2Kmze; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745404606; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7UV3Sx7chqx94m/WYooWcJnWJngfPHWmkbDclQkQiqg=;
	b=Rlf2KmzexOIkgtAcpjybjkegIT4z8M/xjyYq7gzZjo70rIn4l7zBtvV62jFzurIL0Y6AHytaHV6ntZLSsnTcs1c2T7MPTZlzIR9GtwqtEu2bXnm2TkBVhnVFtk71JL0ceWQWDvAx0BmJssiF9daDAerh1ONqgUhiLiIvp9YdvTM=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WXuKlPh_1745404605 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Apr 2025 18:36:46 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Sri Jayaramappa <sjayaram@akamai.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: baolin.wang@linux.alibaba.com,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH] selftests/mm: compaction_test: Support platform with huge mount of memory
Date: Wed, 23 Apr 2025 18:36:45 +0800
Message-Id: <20250423103645.2758-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running mm selftest to verify mm patches, 'compaction_test' case
failed on an x86 server with 1TB memory. And the root cause is that it
has too much free memory than what the test supports.

The test case tries to allocate 100000 huge pages, which is about 200 GB
for that x86 server, and when it succeeds, it expects it's large than
1/3 of 80% of the free memory in system. This logic only works for
platform with 750 GB ( 200 / (1/3) / 80% ) or less free memory, and may
raise false alarm for others.

Fix it by changing the fixed page number to self-adjustable number
according to the real number of free memory.

Fixes: bd67d5c15cc19 ("Test compaction of mlocked memory")
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 tools/testing/selftests/mm/compaction_test.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 2c3a0eb6b22d..9bc4591c7b16 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -90,6 +90,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 	int compaction_index = 0;
 	char nr_hugepages[20] = {0};
 	char init_nr_hugepages[24] = {0};
+	char target_nr_hugepages[24] = {0};
+	int slen;
 
 	snprintf(init_nr_hugepages, sizeof(init_nr_hugepages),
 		 "%lu", initial_nr_hugepages);
@@ -106,11 +108,18 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 		goto out;
 	}
 
-	/* Request a large number of huge pages. The Kernel will allocate
-	   as much as it can */
-	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
-		ksft_print_msg("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+	/*
+	 * Request huge pages for about half of the free memory. The Kernel
+	 * will allocate as much as it can, and we expect it will get at least 1/3
+	 */
+	nr_hugepages_ul = mem_free / hugepage_size / 2;
+	snprintf(target_nr_hugepages, sizeof(target_nr_hugepages),
+		 "%lu", nr_hugepages_ul);
+
+	slen = strlen(target_nr_hugepages);
+	if (write(fd, target_nr_hugepages, slen) != slen) {
+		ksft_print_msg("Failed to write %lu to /proc/sys/vm/nr_hugepages: %s\n",
+			       nr_hugepages_ul, strerror(errno));
 		goto close_fd;
 	}
 
-- 
2.43.5


