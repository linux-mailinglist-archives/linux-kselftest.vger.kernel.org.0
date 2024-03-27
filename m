Return-Path: <linux-kselftest+bounces-6710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AA488DCE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 12:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E701F26775
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 11:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE74C12C552;
	Wed, 27 Mar 2024 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B5N3Z8/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDDE12C525;
	Wed, 27 Mar 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540418; cv=none; b=fDEllgJvCyk70lr7hL8t3qiuv9NwPq2868sj/OXaOSCzThZmRLYfLEaLDjIUGO19b8DD3H+3Vg3TjLTTxJ+LO97ufQIKYoTLKMsdiASMAH570tx9qdByhQCyxnI1mH04AN9iCuWnJyfnF2WnUEVgUl5RsBX0Lrevy0uSU0UGbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540418; c=relaxed/simple;
	bh=hqyLU1Joi1RQhgBqSVEErd8zzBIoSRaagRQVKefQx4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fgbaJQVjvA2Pez83XMVKi9hr+ehG0eVox0BSWilA5r7oofI7NftYNRKarGIKxkM5Ec8HxpxFBfdz0Q76HtEnIsVDzhdzubxbY7m2jjwdsGznKkPpyLH1msOtaNnduNrHbfjOZG2So2Vhgk8KL8GWHsOQrpNpdzHEzdQrPAO9VZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B5N3Z8/b; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711540414;
	bh=hqyLU1Joi1RQhgBqSVEErd8zzBIoSRaagRQVKefQx4o=;
	h=From:To:Cc:Subject:Date:From;
	b=B5N3Z8/bTVafZAa7MjCzdnkZyHNkfUCTShga5P2rHRCK7IrWA9YoLtEhRHT3yWHco
	 NqVZVu24kmhoCyUtML0o0T1emIr8Vz0744XiKAca3F8RlhLdKjp4Bvfutf4gi5KC4y
	 DhwC8cl2ukrF5o00IElwvYMDxgxYrL/SDhbpRoM5hx5s5X9QydzkqgczDMWlT3E6cw
	 hPmw7Z7zsYf/P25b59Yf2CrO8LnI9GNuRAVUpLqyz9COEFiHCzhjVAsvQd2u3YBRCh
	 ziBFyUWKcFSTLBR1Rr4pv6tdFIrVzG5awwjTIQq9glQj5A6sOg/SWjvTfEXzzk2n/f
	 xNa3qDBdDzgaw==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2EDA637820E4;
	Wed, 27 Mar 2024 11:53:31 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	"T.J. Mercier" <tjmercier@google.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] selftests/dmabuf-heap: conform test to TAP format output
Date: Wed, 27 Mar 2024 16:53:52 +0500
Message-Id: <20240327115353.3634735-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.
Improve the TAP messages as well.

Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v5:
- Make the TAP messages more by adding more informat

Changes since v4:
- close fds correctly with code changes added in v3

Chanages since v3:
- abort test-case instead of exiting if heap/mem allocation fails
- Correct test_alloc_zeroed() test case in case of failure

Changes since v2:
- Minor improvements in test_alloc_zeroed() results

Changes since v1:
- Update some more error handling code
---
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 247 +++++++-----------
 1 file changed, 101 insertions(+), 146 deletions(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 890a8236a8ba7..5f541522364fb 100644
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
+		ksft_exit_fail_msg("snprintf failed! %d\n", ret);
 
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
@@ -148,27 +148,19 @@ static int test_alloc_and_import(char *heap_name)
 	int ret;
 
 	heap_fd = dmabuf_heap_open(heap_name);
-	if (heap_fd < 0)
-		return -1;
 
-	printf("  Testing allocation and importing:  ");
+	ksft_print_msg("Testing allocation and importing:\n");
 	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
 	if (ret) {
-		printf("FAIL (Allocation Failed!)\n");
-		ret = -1;
-		goto out;
+		ksft_test_result_fail("FAIL (Allocation Failed!) %d\n", ret);
+		return;
 	}
+
 	/* mmap and write a simple pattern */
-	p = mmap(NULL,
-		 ONE_MEG,
-		 PROT_READ | PROT_WRITE,
-		 MAP_SHARED,
-		 dmabuf_fd,
-		 0);
+	p = mmap(NULL, ONE_MEG, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd, 0);
 	if (p == MAP_FAILED) {
-		printf("FAIL (mmap() failed)\n");
-		ret = -1;
-		goto out;
+		ksft_test_result_fail("FAIL (mmap() failed): %s\n", strerror(errno));
+		goto close_and_return;
 	}
 
 	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
@@ -178,71 +170,64 @@ static int test_alloc_and_import(char *heap_name)
 
 	importer_fd = open_vgem();
 	if (importer_fd < 0) {
-		ret = importer_fd;
-		printf("(Could not open vgem - skipping):  ");
+		ksft_test_result_skip("Could not open vgem %d\n", importer_fd);
 	} else {
 		ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
-		if (ret < 0) {
-			printf("FAIL (Failed to import buffer)\n");
-			goto out;
-		}
+		ksft_test_result(ret >= 0, "Import buffer %d\n", ret);
 	}
 
 	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
 	if (ret < 0) {
-		printf("FAIL (DMA_BUF_SYNC_START failed!)\n");
+		ksft_print_msg("FAIL (DMA_BUF_SYNC_START failed!) %d\n", ret);
 		goto out;
 	}
 
 	memset(p, 0xff, ONE_MEG);
 	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
 	if (ret < 0) {
-		printf("FAIL (DMA_BUF_SYNC_END failed!)\n");
+		ksft_print_msg("FAIL (DMA_BUF_SYNC_END failed!) %d\n", ret);
 		goto out;
 	}
 
 	close_handle(importer_fd, handle);
-	ret = 0;
-	printf(" OK\n");
+	ksft_test_result_pass("%s dmabuf sync succeeded\n", __func__);
+	return;
+
 out:
-	if (p)
-		munmap(p, ONE_MEG);
-	if (importer_fd >= 0)
-		close(importer_fd);
-	if (dmabuf_fd >= 0)
-		close(dmabuf_fd);
-	if (heap_fd >= 0)
-		close(heap_fd);
+	ksft_test_result_fail("%s dmabuf sync failed\n", __func__);
+	munmap(p, ONE_MEG);
+	close(importer_fd);
 
-	return ret;
+close_and_return:
+	close(dmabuf_fd);
+	close(heap_fd);
 }
 
-static int test_alloc_zeroed(char *heap_name, size_t size)
+static void test_alloc_zeroed(char *heap_name, size_t size)
 {
 	int heap_fd = -1, dmabuf_fd[32];
-	int i, j, ret;
+	int i, j, k, ret;
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
+		if (ret) {
+			ksft_test_result_fail("FAIL (Allocation (%i) failed) %d\n", i, ret);
+			goto close_and_return;
 		}
+
 		/* mmap and fill with simple pattern */
 		p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd[i], 0);
 		if (p == MAP_FAILED) {
-			printf("FAIL (mmap() failed!)\n");
-			ret = -1;
-			goto out;
+			ksft_test_result_fail("FAIL (mmap() failed!): %s\n", strerror(errno));
+			goto close_and_return;
 		}
+
 		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
 		memset(p, 0xff, size);
 		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
@@ -251,48 +236,47 @@ static int test_alloc_zeroed(char *heap_name, size_t size)
 	/* close them all */
 	for (i = 0; i < 32; i++)
 		close(dmabuf_fd[i]);
+	ksft_test_result_pass("Allocate and fill a bunch of buffers\n");
 
 	/* Allocate and validate all buffers are zeroed */
 	for (i = 0; i < 32; i++) {
 		ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
 		if (ret < 0) {
-			printf("FAIL (Allocation (%i) failed)\n", i);
-			goto out;
+			ksft_test_result_fail("FAIL (Allocation (%i) failed) %d\n", i, ret);
+			goto close_and_return;
 		}
 
 		/* mmap and validate everything is zero */
 		p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd[i], 0);
 		if (p == MAP_FAILED) {
-			printf("FAIL (mmap() failed!)\n");
-			ret = -1;
-			goto out;
+			ksft_test_result_fail("FAIL (mmap() failed!): %s\n", strerror(errno));
+			goto close_and_return;
 		}
+
 		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
 		c = (char *)p;
 		for (j = 0; j < size; j++) {
 			if (c[j] != 0) {
-				printf("FAIL (Allocated buffer not zeroed @ %i)\n", j);
-				break;
+				ksft_print_msg("FAIL (Allocated buffer not zeroed @ %i)\n", j);
+				dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
+				munmap(p, size);
+				goto out;
 			}
 		}
 		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
 		munmap(p, size);
 	}
-	/* close them all */
-	for (i = 0; i < 32; i++)
-		close(dmabuf_fd[i]);
-
-	close(heap_fd);
-	printf("OK\n");
-	return 0;
 
 out:
-	while (i > 0) {
-		close(dmabuf_fd[i]);
-		i--;
-	}
+	ksft_test_result(i == 32, "Allocate and validate all buffers are zeroed\n");
+
+close_and_return:
+	/* close them all */
+	for (k = 0; k < i; k++)
+		close(dmabuf_fd[k]);
+
 	close(heap_fd);
-	return ret;
+	return;
 }
 
 /* Test the ioctl version compatibility w/ a smaller structure then expected */
@@ -360,126 +344,97 @@ static int dmabuf_heap_alloc_newer(int fd, size_t len, unsigned int flags,
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
+	ksft_test_result(ret, "Error expected on invalid fd %d\n", ret);
 
 	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0x111111, &dmabuf_fd);
-	if (!ret) {
-		printf("FAIL (Did not see expected error (invalid heap flags)!)\n");
-		ret = -1;
-		goto out;
-	}
+	ksft_test_result(ret, "Error expected on invalid heap flags %d\n", ret);
 
 	ret = dmabuf_heap_alloc_fdflags(heap_fd, ONE_MEG,
 					~(O_RDWR | O_CLOEXEC), 0, &dmabuf_fd);
-	if (!ret) {
-		printf("FAIL (Did not see expected error (invalid fd flags)!)\n");
-		ret = -1;
-		goto out;
-	}
+	ksft_test_result(ret, "Error expected on invalid heap flags %d\n", ret);
 
-	printf("OK\n");
-	ret = 0;
-out:
 	if (dmabuf_fd >= 0)
 		close(dmabuf_fd);
-	if (heap_fd >= 0)
-		close(heap_fd);
+	close(heap_fd);
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
+	ksft_set_plan(11 * numer_of_heaps());
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
2.39.2


