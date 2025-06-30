Return-Path: <linux-kselftest+bounces-36095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D7BAED9BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 12:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D033A23EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA50252904;
	Mon, 30 Jun 2025 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="DfI8HVR7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D41E2858;
	Mon, 30 Jun 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279123; cv=pass; b=l2F8wnt6wdWSIy+qijv5VY0EfHnFiwHv5f78JotrEragvj1go4ss4Rp5B7noIjHtWbLIyoNe/5xHIhigh23vR/CaRttkpuXrrScdNCsMw/x1tr9sZQdAU5bBPUKqqB5tK/cZAHO6NMdowKYoAFhZZEbsFC1bvFH3PGnNhW4wHEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279123; c=relaxed/simple;
	bh=pIec2uRujmt1WMqVydkBXQSel8wTBLV0+sgYDEDHZIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtGB6a8Xe78O+ai07Xpjj6stjOob4nByDn6o+ipzN5i+sfumgtVk4h6GMUvJZFcbv36tO62qwdcqnb4LRL+NXVcU/WQ9lZkaebDpHDQo1LjXTU/3orhwFbXfPWzHnHxZ9hLpqvwOHmmpZhXL786X822E6pAObokU8B0GjfQzeLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=DfI8HVR7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751279104; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G0beHDLVv+/Ffycsq5m2pVM4PZKgW0NbssB+zOfPFZL2AD8qIx5IpXwZIrmrenobNvk+4mSkF6xEWVuZkaX8EKpJ1TH4cuwvOJ++9bQaYoCOrz/W6lleoBD4KKJnEcYH6cKHnVpbxPklsis5KF+W0Ujsw+wimjTdPx3Y00Euhxo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751279104; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cpPJV8/hADr82PgAqaYBF0nyZvBsZKRCuN6YMIHqdcE=; 
	b=AZmT/28hE5MjevYWpzItdm9xJu3ytA3v+c6BBSQy/CAv3u/9ZXzDBbwMWXSamhXpBwnAhfGSYbihFIrgXYC89/tBZtDsZziV9EARk+DyWMwHXJp3a4j7GvD/MIylQuYHH2srgw+XhFN3th7aJ3HYPMdmDHB0m5lcI/L6549egrs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751279104;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cpPJV8/hADr82PgAqaYBF0nyZvBsZKRCuN6YMIHqdcE=;
	b=DfI8HVR7ASoe0e4njpTNc3CHsUcpAB4jvqBmmzCyKFdsTAr8W+TbFy9BDWnTnDY8
	k5CPq340DAKKjDEeDI7AU0e4LL8meXj+9JzTAZsJv+zm5tfnNx0xaWLa0gYLslJBgD0
	1WbS1MXVuxE1Yd6y5IZB50gyef/dSK1Bajs1fGS4=
Received: by mx.zohomail.com with SMTPS id 1751279102242736.6456034251825;
	Mon, 30 Jun 2025 03:25:02 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/mm: pagemap_scan ioctl: add PFN ZERO test cases
Date: Mon, 30 Jun 2025 15:24:42 +0500
Message-ID: <20250630102443.137809-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add test cases to test the correctness of PFN ZERO flag of pagemap_scan
ioctl. Test with normal pages backed memory and huge pages backed
memory.

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
The bug has been fixed [1].

[1] https://lore.kernel.org/all/20250617143532.2375383-1-david@redhat.com
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 57 +++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 57b4bba2b45f3..6138de0087edf 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <fcntl.h>
@@ -1480,6 +1481,57 @@ static void transact_test(int page_size)
 			      extra_thread_faults);
 }
 
+void zeropfn_tests(void)
+{
+	unsigned long long mem_size;
+	struct page_region vec;
+	int i, ret;
+	char *mem;
+
+	/* Test with page backed memory */
+	mem_size = 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("error nomem\n");
+
+	/* Touch each page to ensure it's mapped */
+	for (i = 0; i < mem_size; i += page_size)
+		(void)((volatile char *)mem)[i];
+
+	ret = pagemap_ioctl(mem, mem_size, &vec, 1, 0,
+			    (mem_size / page_size), PAGE_IS_PFNZERO, 0, 0, PAGE_IS_PFNZERO);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && LEN(vec) == (mem_size / page_size),
+			 "%s all pages must have PFNZERO set\n", __func__);
+
+	munmap(mem, mem_size);
+
+	/* Test with huge page */
+	mem_size = 10 * hpage_size;
+	mem = memalign(hpage_size, mem_size);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	ret = madvise(mem, mem_size, MADV_HUGEPAGE);
+	if (ret)
+		ksft_exit_fail_msg("madvise failed %d %s\n", errno, strerror(errno));
+
+	for (i = 0; i < mem_size; i += hpage_size)
+		(void)((volatile char *)mem)[i];
+
+	ret = pagemap_ioctl(mem, mem_size, &vec, 1, 0,
+			    (mem_size / page_size), PAGE_IS_PFNZERO, 0, 0, PAGE_IS_PFNZERO);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	ksft_test_result(ret == 1 && LEN(vec) == (mem_size / page_size),
+			 "%s all huge pages must have PFNZERO set\n", __func__);
+
+	free(mem);
+}
+
 int main(int __attribute__((unused)) argc, char *argv[])
 {
 	int shmid, buf_size, fd, i, ret;
@@ -1494,7 +1546,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	if (init_uffd())
 		ksft_exit_pass();
 
-	ksft_set_plan(115);
+	ksft_set_plan(117);
 
 	page_size = getpagesize();
 	hpage_size = read_pmd_pagesize();
@@ -1669,6 +1721,9 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	/* 16. Userfaultfd tests */
 	userfaultfd_tests();
 
+	/* 17. ZEROPFN tests */
+	zeropfn_tests();
+
 	close(pagemap_fd);
 	ksft_exit_pass();
 }
-- 
2.43.0


