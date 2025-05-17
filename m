Return-Path: <linux-kselftest+bounces-33241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AAFABA7C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 04:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F38B4C6478
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 02:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730AC7DA6A;
	Sat, 17 May 2025 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="IDMDaKoU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E0977102
	for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747447646; cv=none; b=nPKo51AQFRl35SeadEpH88ma8T07hBLE2rOKvyTPlXN/8Rcl7MESxxaPUkB3OdQDvKy4Cupg2rJrjLA8v4BgjFuoGWFkIKsiGd+8BpuTbRQKYcuRwK8RJ2bDlGbJ5UIfRyO7L4lwC/1s4u9oRM0RBBahRZ0n1Laxd/RBMqvA+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747447646; c=relaxed/simple;
	bh=x4Pk29mXlXFGt5bPU0zHpsrREAMkZcWP6ca7bVxz4ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9D87OCtoW5ydmttFv/3KF7vKkn5llya9e3nN3uLznAs2knzpAcXdDDtq5lvFyI3bnJiGA0aT8RW6RW5CEkp/lyLADNGgpRoVwZisZDW3j/rTr/ei+7y/XJ9ABxZS5cQqN08VygVorIHctofY8lgO73pZCH+KwCNm8+Fyz9oySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=IDMDaKoU; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1747447635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+lvRKo2opiHt3C2ZcxwzgvE4ABuKBnR+Dybtxkrz/r0=;
	b=IDMDaKoUIwN4IQBHxOec4J6VH5Kqfugn8dDL2XauaoNUUOB5pxRSl4RJ+irWjZmOrVOM6l
	lq4vEyDTkh2R6sTY4Snz4S1zEkKuJ67JxHmZQueeRnGL6hT4pHHzQVojaiic0q6Wm+PZu6
	u6XNhKEb9eBF0yi7bZLnYQtWRk0mLh+K5eXYC/e9PJ1x/vNKs7a0EYK3evcx00C4JJSfWy
	kuzdG3Ms7BU7HgeU5dOU31uWUCG+WQbOxvhmsPvKKaLXsXZxP5Cq9n5FH4lItdHkZqrCBK
	iKAF6z75w2KLiHvC1e+2D8vigRt7wUDN8s9gIl9gf94G1Jezk9Mi8PiC0zI+JA==
From: George Anthony Vernon <contact@gvernon.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: George Anthony Vernon <contact@gvernon.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] selftests/mm: compaction_test: convert comments to preferred style
Date: Sat, 17 May 2025 03:06:56 +0100
Message-ID: <20250517020658.358461-1-contact@gvernon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert multi-line comments to preferred style with beginning and ending
almost-blank lines.

Signed-off-by: George Anthony Vernon <contact@gvernon.com>
---
 tools/testing/selftests/mm/compaction_test.c | 22 +++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 2c3a0eb6b22d..b217ec4a434b 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *
  * A test for the patch "Allow compaction of unevictable pages".
  * With this patch we should be able to allocate at least 1/4
  * of RAM in huge pages. Without the patch much less is
@@ -94,8 +93,10 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 	snprintf(init_nr_hugepages, sizeof(init_nr_hugepages),
 		 "%lu", initial_nr_hugepages);
 
-	/* We want to test with 80% of available memory. Else, OOM killer comes
-	   in to play */
+	/*
+	 * We want to test with 80% of available memory. Else, OOM killer comes
+	 * in to play
+	 */
 	mem_free = mem_free * 0.8;
 
 	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
@@ -106,8 +107,10 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 		goto out;
 	}
 
-	/* Request a large number of huge pages. The Kernel will allocate
-	   as much as it can */
+	/*
+	 * Request a large number of huge pages. The Kernel will allocate
+	 * as much as it can
+	 */
 	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
 		ksft_print_msg("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
 			       strerror(errno));
@@ -122,8 +125,10 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 		goto close_fd;
 	}
 
-	/* We should have been able to request at least 1/3 rd of the memory in
-	   huge pages */
+	/*
+	 * We should have been able to request at least 1/3 rd of the memory in
+	 * huge pages
+	 */
 	nr_hugepages_ul = strtoul(nr_hugepages, NULL, 10);
 	if (!nr_hugepages_ul) {
 		ksft_print_msg("ERROR: No memory is available as huge pages\n");
@@ -243,7 +248,8 @@ int main(int argc, char **argv)
 		entry->next = list;
 		list = entry;
 
-		/* Write something (in this case the address of the map) to
+		/*
+		 * Write something (in this case the address of the map) to
 		 * ensure that KSM can't merge the mapped pages
 		 */
 		for (i = 0; i < MAP_SIZE; i += page_size)
-- 
2.49.0


