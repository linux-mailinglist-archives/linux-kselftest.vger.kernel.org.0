Return-Path: <linux-kselftest+bounces-5479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4401386903E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 13:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2E51C24FEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D613EFE9;
	Tue, 27 Feb 2024 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XiPlDdlM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0A13B2A5;
	Tue, 27 Feb 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036351; cv=none; b=dcj+IjFLccU4at+DK/KiAmJehuEEcbC6rzX3Fgq//h1o7L1RCDy/qRnFipUjwLac94ohI4bttJ9vwB8MbORBc/Yx+tkMr1mbO5kwnSdNkGHxAkpI2Ub1ypLm6+W7v0EINSWrqlQw0F7g/hUlrvLEBrLGtYHDF5wdIRY+Q0/9XGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036351; c=relaxed/simple;
	bh=+tAJLc4gOObaF0V5QjxZ6s6onijd+n2DVJhu4lZ65CI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCei2aoFVlUlfwCfwMgrKdu4K512ktciEJXqR2G1RW02hm70PrHt+3zQpFa+SYLM9OuphtTsu8CKHlrZnGV/jQmdPdJ16LGbWftiy9hI7O3Jjtv1+VYIwlzY7gNnmZOAOubAlVRpXGD9WNp4pExenp5GLzoBVKJBA8Eem1CaK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XiPlDdlM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709036348;
	bh=+tAJLc4gOObaF0V5QjxZ6s6onijd+n2DVJhu4lZ65CI=;
	h=From:To:Cc:Subject:Date:From;
	b=XiPlDdlM75Nrqrz9GkoHeKShxYwgA4V0LTzIxaYodSfoicp+fKg1QVHDzT0HmRCou
	 Ns//JUH87NIshIuNb9oxhV0QxY8o6Y15ED8IO9YvQz+BON1URl/g8zqNyDnmG2XAEa
	 ol8TCasLzjNxWtUcxu5yeBuL6QfTCpHDhNZjonGFJMEq2m46vEVrRJSNyvnNPamqb/
	 xodVcjTSz+UOO42ss6rn2cDbg+vVFB0r7qY5Z0QaWDMgo/TcXAPTW/RmAs1LKyc3/N
	 qfnmi+iewoN5FH5nUBXXA18cu5GmFD/TrQWTkJ2T7EX8v207cT+n+AzVufzQ9okCus
	 2Etbb9aPAIDzg==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1292337813B6;
	Tue, 27 Feb 2024 12:19:05 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] selftests/dmabuf-heap: conform test to TAP format output
Date: Tue, 27 Feb 2024 17:19:09 +0500
Message-ID: <20240227121920.1905095-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Update some more error handling code
---
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 217 +++++++-----------
 1 file changed, 81 insertions(+), 136 deletions(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 890a8236a8ba7..41a8485cad5d0 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -15,6 +15,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
 #include <drm/drm.h>
+#include "../kselftest.h"
 
 #define DEVPATH "/dev/dma_heap"
 
@@ -90,14 +91,13 @@ static int dmabuf_heap_open(char *name)
 	char buf[256];
 
 	ret = snprintf(buf, 256, "%s/%s", DEVPATH, name);
-	if (ret < 0) {
-		printf("snprintf failed!\n");
-		return ret;
-	}
+	if (ret < 0)
+		ksft_exit_fail_msg("snprintf failed!\n");
 
 	fd = open(buf, O_RDWR);
 	if (fd < 0)
-		printf("open %s failed!\n", buf);
+		ksft_exit_fail_msg("open %s failed: %s\n", buf, strerror(errno));
+
 	return fd;
 }
 
@@ -140,7 +140,7 @@ static int dmabuf_sync(int fd, int start_stop)
 
 #define ONE_MEG (1024 * 1024)
 
-static int test_alloc_and_import(char *heap_name)
+static void test_alloc_and_import(char *heap_name)
 {
 	int heap_fd = -1, dmabuf_fd = -1, importer_fd = -1;
 	uint32_t handle = 0;
@@ -148,16 +148,12 @@ static int test_alloc_and_import(char *heap_name)
 	int ret;
 
 	heap_fd = dmabuf_heap_open(heap_name);
-	if (heap_fd < 0)
-		return -1;
 
-	printf("  Testing allocation and importing:  ");
+	ksft_print_msg("Testing allocation and importing:\n");
 	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
-	if (ret) {
-		printf("FAIL (Allocation Failed!)\n");
-		ret = -1;
-		goto out;
-	}
+	if (ret)
+		ksft_exit_fail_msg("FAIL (Allocation Failed!)\n");
+
 	/* mmap and write a simple pattern */
 	p = mmap(NULL,
 		 ONE_MEG,
@@ -165,11 +161,8 @@ static int test_alloc_and_import(char *heap_name)
 		 MAP_SHARED,
 		 dmabuf_fd,
 		 0);
-	if (p == MAP_FAILED) {
-		printf("FAIL (mmap() failed)\n");
-		ret = -1;
-		goto out;
-	}
+	if (p == MAP_FAILED)
+		ksft_exit_fail_msg("FAIL (mmap() failed)\n");
 
 	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
 	memset(p, 1, ONE_MEG / 2);
@@ -179,31 +172,28 @@ static int test_alloc_and_import(char *heap_name)
 	importer_fd = open_vgem();
 	if (importer_fd < 0) {
 		ret = importer_fd;
-		printf("(Could not open vgem - skipping):  ");
+		ksft_test_result_skip("Could not open vgem\n");
 	} else {
 		ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
-		if (ret < 0) {
-			printf("FAIL (Failed to import buffer)\n");
-			goto out;
-		}
+		ksft_test_result(ret >= 0, "Import buffer\n");
 	}
 
 	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
 	if (ret < 0) {
-		printf("FAIL (DMA_BUF_SYNC_START failed!)\n");
+		ksft_print_msg("FAIL (DMA_BUF_SYNC_START failed!)\n");
 		goto out;
 	}
 
 	memset(p, 0xff, ONE_MEG);
 	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
 	if (ret < 0) {
-		printf("FAIL (DMA_BUF_SYNC_END failed!)\n");
+		ksft_print_msg("FAIL (DMA_BUF_SYNC_END failed!)\n");
 		goto out;
 	}
 
 	close_handle(importer_fd, handle);
-	ret = 0;
-	printf(" OK\n");
+	ksft_test_result_pass("%s\n", __func__);
+	return;
 out:
 	if (p)
 		munmap(p, ONE_MEG);
@@ -214,35 +204,30 @@ static int test_alloc_and_import(char *heap_name)
 	if (heap_fd >= 0)
 		close(heap_fd);
 
-	return ret;
+	ksft_test_result_fail("%s\n", __func__);
 }
 
-static int test_alloc_zeroed(char *heap_name, size_t size)
+static void test_alloc_zeroed(char *heap_name, size_t size)
 {
 	int heap_fd = -1, dmabuf_fd[32];
 	int i, j, ret;
 	void *p = NULL;
 	char *c;
 
-	printf("  Testing alloced %ldk buffers are zeroed:  ", size / 1024);
+	ksft_print_msg("Testing alloced %ldk buffers are zeroed:\n", size / 1024);
 	heap_fd = dmabuf_heap_open(heap_name);
-	if (heap_fd < 0)
-		return -1;
 
 	/* Allocate and fill a bunch of buffers */
 	for (i = 0; i < 32; i++) {
 		ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
-		if (ret < 0) {
-			printf("FAIL (Allocation (%i) failed)\n", i);
-			goto out;
-		}
+		if (ret)
+			ksft_exit_fail_msg("FAIL (Allocation (%i) failed)\n", i);
+
 		/* mmap and fill with simple pattern */
 		p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd[i], 0);
-		if (p == MAP_FAILED) {
-			printf("FAIL (mmap() failed!)\n");
-			ret = -1;
-			goto out;
-		}
+		if (p == MAP_FAILED)
+			ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
+
 		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
 		memset(p, 0xff, size);
 		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
@@ -255,23 +240,19 @@ static int test_alloc_zeroed(char *heap_name, size_t size)
 	/* Allocate and validate all buffers are zeroed */
 	for (i = 0; i < 32; i++) {
 		ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
-		if (ret < 0) {
-			printf("FAIL (Allocation (%i) failed)\n", i);
-			goto out;
-		}
+		if (ret < 0)
+			ksft_exit_fail_msg("FAIL (Allocation (%i) failed)\n", i);
 
 		/* mmap and validate everything is zero */
 		p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd[i], 0);
-		if (p == MAP_FAILED) {
-			printf("FAIL (mmap() failed!)\n");
-			ret = -1;
-			goto out;
-		}
+		if (p == MAP_FAILED)
+			ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
+
 		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
 		c = (char *)p;
 		for (j = 0; j < size; j++) {
 			if (c[j] != 0) {
-				printf("FAIL (Allocated buffer not zeroed @ %i)\n", j);
+				ksft_print_msg("FAIL (Allocated buffer not zeroed @ %i)\n", j);
 				break;
 			}
 		}
@@ -283,16 +264,8 @@ static int test_alloc_zeroed(char *heap_name, size_t size)
 		close(dmabuf_fd[i]);
 
 	close(heap_fd);
-	printf("OK\n");
-	return 0;
-
-out:
-	while (i > 0) {
-		close(dmabuf_fd[i]);
-		i--;
-	}
-	close(heap_fd);
-	return ret;
+	ksft_test_result_pass("%s\n", __func__);
+	return;
 }
 
 /* Test the ioctl version compatibility w/ a smaller structure then expected */
@@ -360,126 +333,98 @@ static int dmabuf_heap_alloc_newer(int fd, size_t len, unsigned int flags,
 	return ret;
 }
 
-static int test_alloc_compat(char *heap_name)
+static void test_alloc_compat(char *heap_name)
 {
-	int heap_fd = -1, dmabuf_fd = -1;
-	int ret;
+	int ret, heap_fd = -1, dmabuf_fd = -1;
 
 	heap_fd = dmabuf_heap_open(heap_name);
-	if (heap_fd < 0)
-		return -1;
 
-	printf("  Testing (theoretical)older alloc compat:  ");
+	ksft_print_msg("Testing (theoretical) older alloc compat:\n");
 	ret = dmabuf_heap_alloc_older(heap_fd, ONE_MEG, 0, &dmabuf_fd);
-	if (ret) {
-		printf("FAIL (Older compat allocation failed!)\n");
-		ret = -1;
-		goto out;
-	}
-	close(dmabuf_fd);
-	printf("OK\n");
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+	ksft_test_result(!ret, "dmabuf_heap_alloc_older\n");
 
-	printf("  Testing (theoretical)newer alloc compat:  ");
+	ksft_print_msg("Testing (theoretical) newer alloc compat:\n");
 	ret = dmabuf_heap_alloc_newer(heap_fd, ONE_MEG, 0, &dmabuf_fd);
-	if (ret) {
-		printf("FAIL (Newer compat allocation failed!)\n");
-		ret = -1;
-		goto out;
-	}
-	printf("OK\n");
-out:
 	if (dmabuf_fd >= 0)
 		close(dmabuf_fd);
-	if (heap_fd >= 0)
-		close(heap_fd);
+	ksft_test_result(!ret, "dmabuf_heap_alloc_newer\n");
 
-	return ret;
+	close(heap_fd);
 }
 
-static int test_alloc_errors(char *heap_name)
+static void test_alloc_errors(char *heap_name)
 {
 	int heap_fd = -1, dmabuf_fd = -1;
 	int ret;
 
 	heap_fd = dmabuf_heap_open(heap_name);
-	if (heap_fd < 0)
-		return -1;
 
-	printf("  Testing expected error cases:  ");
+	ksft_print_msg("Testing expected error cases:\n");
 	ret = dmabuf_heap_alloc(0, ONE_MEG, 0x111111, &dmabuf_fd);
-	if (!ret) {
-		printf("FAIL (Did not see expected error (invalid fd)!)\n");
-		ret = -1;
-		goto out;
-	}
+	ksft_test_result(ret, "Error expected on invalid fd\n");
 
 	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0x111111, &dmabuf_fd);
-	if (!ret) {
-		printf("FAIL (Did not see expected error (invalid heap flags)!)\n");
-		ret = -1;
-		goto out;
-	}
+	ksft_test_result(ret, "Error expected on invalid heap flags\n");
 
 	ret = dmabuf_heap_alloc_fdflags(heap_fd, ONE_MEG,
 					~(O_RDWR | O_CLOEXEC), 0, &dmabuf_fd);
-	if (!ret) {
-		printf("FAIL (Did not see expected error (invalid fd flags)!)\n");
-		ret = -1;
-		goto out;
-	}
+	ksft_test_result(ret, "Error expected on invalid heap flags\n");
 
-	printf("OK\n");
-	ret = 0;
-out:
 	if (dmabuf_fd >= 0)
 		close(dmabuf_fd);
 	if (heap_fd >= 0)
 		close(heap_fd);
+}
 
-	return ret;
+static int numer_of_heaps(void)
+{
+	DIR *d = opendir(DEVPATH);
+	struct dirent *dir;
+	int heaps = 0;
+
+	while ((dir = readdir(d))) {
+		if (!strncmp(dir->d_name, ".", 2))
+			continue;
+		if (!strncmp(dir->d_name, "..", 3))
+			continue;
+		heaps++;
+	}
+
+	return heaps;
 }
 
 int main(void)
 {
-	DIR *d;
 	struct dirent *dir;
-	int ret = -1;
+	DIR *d;
+
+	ksft_print_header();
 
 	d = opendir(DEVPATH);
 	if (!d) {
-		printf("No %s directory?\n", DEVPATH);
-		return -1;
+		ksft_print_msg("No %s directory?\n", DEVPATH);
+		return KSFT_SKIP;
 	}
 
-	while ((dir = readdir(d)) != NULL) {
+	ksft_set_plan(9 * numer_of_heaps());
+
+	while ((dir = readdir(d))) {
 		if (!strncmp(dir->d_name, ".", 2))
 			continue;
 		if (!strncmp(dir->d_name, "..", 3))
 			continue;
 
-		printf("Testing heap: %s\n", dir->d_name);
-		printf("=======================================\n");
-		ret = test_alloc_and_import(dir->d_name);
-		if (ret)
-			break;
-
-		ret = test_alloc_zeroed(dir->d_name, 4 * 1024);
-		if (ret)
-			break;
-
-		ret = test_alloc_zeroed(dir->d_name, ONE_MEG);
-		if (ret)
-			break;
-
-		ret = test_alloc_compat(dir->d_name);
-		if (ret)
-			break;
-
-		ret = test_alloc_errors(dir->d_name);
-		if (ret)
-			break;
+		ksft_print_msg("Testing heap: %s\n", dir->d_name);
+		ksft_print_msg("=======================================\n");
+		test_alloc_and_import(dir->d_name);
+		test_alloc_zeroed(dir->d_name, 4 * 1024);
+		test_alloc_zeroed(dir->d_name, ONE_MEG);
+		test_alloc_compat(dir->d_name);
+		test_alloc_errors(dir->d_name);
 	}
 	closedir(d);
 
-	return ret;
+	ksft_finished();
 }
-- 
2.42.0


