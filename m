Return-Path: <linux-kselftest+bounces-36328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC2EAF5AFD
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA033BBB0F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586AC2F4A12;
	Wed,  2 Jul 2025 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="P0SRCvrM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A128A725;
	Wed,  2 Jul 2025 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466098; cv=pass; b=NANORY3Bq3GCB5StX7XVWU2iZVzBVmGVKZTn73mzS1Ta+ECQGc9PuAMYVMJEtEHsv4ij5jBU8h7HlI3iF7BrnG/2IChjqCwCANmb85PIwaNhaZjmHsebEe85Flqykjym5RvOksIW/JtNvjzpys5hR9hZGmOX8yT77PpRdtyD4L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466098; c=relaxed/simple;
	bh=JPYsE1H9x9ALSEZAE4peMOPJnkOXnIORtP4J63kxwPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0o9NU7Afze0bLqQnoHX+6UI+t58qqehKW3hQyhr4zNGIOD5kUZpqEJMnPOvlbHUJeTovwFhg+iJTsCgtMjLVdHdf7N4t4uiaTImqOG5SZkpJY157/B4Bu4MwQgWZoZ9XPztkgj0HXyhXKnQB3asXKfoYMXxjAUySv76Elt3h34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=P0SRCvrM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751466079; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JjFU/wTd7C2n15LaDCtVw4c5SLp4fYQqW6KjugfaTRu/jrmZUzM7J1qZEA5663zmu2VMSmqqPWfgFHC/G5zg8zG00gmgYt6fuulxDF7929o8jETu/Yi1Y1WhP/56M8bYWX/A6c6xlLDQaLbQ/GpVVn668HTpb2DNsduuG1EyR9A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751466079; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2/PLCRDX5zQwb9vO9glSCFCybgO+wL+GFj+YcKmCwxY=; 
	b=jw62NL3OcEjtChqVcuhIwONQ4/RJoR3PkVG8VXFYPHRdI2zHk7NE5BiXDxudPZlf9ucTTYJ6ChV2EMnmPiWjvGEBnsk8tWIitCoqvTdS7ILlteRDTqzOIk+qvzEttwVisP2xi5FXTESHTDmXiUSxjZH2Skx2GjewoYJ5IFMNq1A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751466079;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2/PLCRDX5zQwb9vO9glSCFCybgO+wL+GFj+YcKmCwxY=;
	b=P0SRCvrMW8to+PMLKnzJMzI7zPfWcLYGtY2c80g3CSvPjZlBCZhPbCSkNPTbRjks
	i2g+VeY3blhZx3RiCgPNMNULw9hjGdTTPkEm56Mv9Z5Ap0J3UgXkVI5UFi9q0qJCTgi
	hlgvEaL4lqwXkNTwF/A02GAlIYAoMJiFO6XeP+Q8=
Received: by mx.zohomail.com with SMTPS id 1751466077488209.397213001875;
	Wed, 2 Jul 2025 07:21:17 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/mm: pagemap_scan ioctl: add PFN ZERO test cases
Date: Wed,  2 Jul 2025 19:20:51 +0500
Message-ID: <20250702142052.45116-1-usama.anjum@collabora.com>
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
Changes since v1:
- Skip if madvise() fails
- Skip test if use_zero_page isn't set to 1
- Keep on using memalign()+free() to allocate huge pages
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 86 +++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 57b4bba2b45f3..976ab357f4651 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <fcntl.h>
@@ -1480,6 +1481,86 @@ static void transact_test(int page_size)
 			      extra_thread_faults);
 }
 
+bool is_use_zero_page_set(void)
+{
+	ssize_t bytes_read;
+	char buffer[2];
+	int fd;
+
+	fd = open("/sys/kernel/mm/transparent_hugepage/use_zero_page", O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	bytes_read = read(fd, buffer, sizeof(buffer) - 1);
+	if (bytes_read <= 0) {
+		close(fd);
+		return 0;
+	}
+
+	close(fd);
+	if (atoi(buffer) != 1)
+		return 0;
+
+	return 1;
+}
+
+void zeropfn_tests(void)
+{
+	unsigned long long mem_size;
+	struct page_region vec;
+	int i, ret;
+	char *mem;
+
+	/* Test with normal memory */
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
+	/* Test with huge page if user_zero_page is set to 1 */
+	if (!is_use_zero_page_set()) {
+		ksft_test_result_skip("%s use_zero_page not supported or set to 1\n", __func__);
+		return;
+	}
+
+	mem_size = 10 * hpage_size;
+	mem = memalign(hpage_size, mem_size);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	ret = madvise(mem, mem_size, MADV_HUGEPAGE);
+	if (!ret) {
+		for (i = 0; i < mem_size; i += hpage_size)
+			(void)((volatile char *)mem)[i];
+
+		ret = pagemap_ioctl(mem, mem_size, &vec, 1, 0,
+				    (mem_size / page_size), PAGE_IS_PFNZERO, 0, 0, PAGE_IS_PFNZERO);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 1 && LEN(vec) == (mem_size / page_size),
+				 "%s all huge pages must have PFNZERO set\n", __func__);
+
+		free(mem);
+	} else {
+		ksft_test_result_skip("%s huge page not supported\n", __func__);
+	}
+}
+
 int main(int __attribute__((unused)) argc, char *argv[])
 {
 	int shmid, buf_size, fd, i, ret;
@@ -1494,7 +1575,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	if (init_uffd())
 		ksft_exit_pass();
 
-	ksft_set_plan(115);
+	ksft_set_plan(117);
 
 	page_size = getpagesize();
 	hpage_size = read_pmd_pagesize();
@@ -1669,6 +1750,9 @@ int main(int __attribute__((unused)) argc, char *argv[])
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


