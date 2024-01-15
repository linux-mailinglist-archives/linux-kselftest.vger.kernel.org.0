Return-Path: <linux-kselftest+bounces-2965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D825682D4A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 08:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFC71F21802
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 07:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AB4440A;
	Mon, 15 Jan 2024 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UJUhNeQk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4193B4401;
	Mon, 15 Jan 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705303994;
	bh=msYTdYSBLgcNB9Pwi9Sv9tDsr6IJ72WoG34TW93BI1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJUhNeQkyC7Ebkc3pFt7p01Xk/7PFHg5FBEns8H05Dd0K80Kb/n+KbvzLg99xQ/fr
	 QF60mReOOE2DW+zEesgI+RLd4oELswj9b997YK0WauQOmKio0/r4Er2QaRAUAGjhQy
	 XRwFzDM17zAVXftavQQuYbJMB85p5CbO/CGvsCrLzFy/5yHG9rnNu1itvdNueknnaw
	 dL/TlVljeeXacf/UN6+XtNTKS61dzfYS5oFE+iGzB3iC8paz/IrLY+Bn3JReI9z/gB
	 N05C21HN8PkqTGZi19xYVfWbN2IpCX5PkFgHila8eDRGMB5lC6uP87uV7iInAN/2IN
	 ke/zANdj9UbOQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC8753781F80;
	Mon, 15 Jan 2024 07:33:12 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] selftests/mm: hugetlb-read-hwpoison: conform test to TAP format output
Date: Mon, 15 Jan 2024 12:32:41 +0500
Message-ID: <20240115073247.1280266-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240115073247.1280266-1-usama.anjum@collabora.com>
References: <20240115073247.1280266-1-usama.anjum@collabora.com>
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
Changes in v3:
- Use ksft_perror as short hand instead of missing strerror(errno) at
  one place

Tested this by reverting the patch a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
("mm/filemap: remove hugetlb special casing in filemap.c") as it has
broken the test. The bug report can be found at [1].

Tested with proposed fix as well [2].

[1] https://lore.kernel.org/all/079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com
[2] https://lore.kernel.org/all/a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@oracle.com
---
 .../selftests/mm/hugetlb-read-hwpoison.c      | 116 ++++++++----------
 1 file changed, 54 insertions(+), 62 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
index ba6cc6f9cabc..23b41b88c6af 100644
--- a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
+++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
@@ -58,8 +58,8 @@ static bool verify_chunk(char *buf, size_t len, char val)
 
 	for (i = 0; i < len; ++i) {
 		if (buf[i] != val) {
-			printf(PREFIX ERROR_PREFIX "check fail: buf[%lu] = %u != %u\n",
-				i, buf[i], val);
+			ksft_print_msg(PREFIX ERROR_PREFIX "check fail: buf[%lu] = %u != %u\n",
+				       i, buf[i], val);
 			return false;
 		}
 	}
@@ -75,21 +75,21 @@ static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
 	ssize_t total_ret_count = 0;
 	char val = offset / wr_chunk_size + offset % wr_chunk_size;
 
-	printf(PREFIX PREFIX "init val=%u with offset=0x%lx\n", val, offset);
-	printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
-	       expected);
+	ksft_print_msg(PREFIX PREFIX "init val=%u with offset=0x%lx\n", val, offset);
+	ksft_print_msg(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
+		       expected);
 	if (lseek(fd, offset, SEEK_SET) < 0) {
-		perror(PREFIX ERROR_PREFIX "seek failed");
+		ksft_perror(PREFIX ERROR_PREFIX "seek failed");
 		return false;
 	}
 
 	while (offset + total_ret_count < len) {
 		ret_count = read(fd, buf, wr_chunk_size);
 		if (ret_count == 0) {
-			printf(PREFIX PREFIX "read reach end of the file\n");
+			ksft_print_msg(PREFIX PREFIX "read reach end of the file\n");
 			break;
 		} else if (ret_count < 0) {
-			perror(PREFIX ERROR_PREFIX "read failed");
+			ksft_perror(PREFIX ERROR_PREFIX "read failed");
 			break;
 		}
 		++val;
@@ -98,8 +98,8 @@ static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
 
 		total_ret_count += ret_count;
 	}
-	printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
-	       total_ret_count);
+	ksft_print_msg(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
+		       total_ret_count);
 
 	return total_ret_count == expected;
 }
@@ -112,15 +112,15 @@ static bool read_hugepage_filemap(int fd, size_t len,
 	ssize_t total_ret_count = 0;
 	char val = 0;
 
-	printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
-	       expected);
+	ksft_print_msg(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
+		       expected);
 	while (total_ret_count < len) {
 		ret_count = read(fd, buf, wr_chunk_size);
 		if (ret_count == 0) {
-			printf(PREFIX PREFIX "read reach end of the file\n");
+			ksft_print_msg(PREFIX PREFIX "read reach end of the file\n");
 			break;
 		} else if (ret_count < 0) {
-			perror(PREFIX ERROR_PREFIX "read failed");
+			ksft_perror(PREFIX ERROR_PREFIX "read failed");
 			break;
 		}
 		++val;
@@ -129,8 +129,8 @@ static bool read_hugepage_filemap(int fd, size_t len,
 
 		total_ret_count += ret_count;
 	}
-	printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
-	       total_ret_count);
+	ksft_print_msg(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
+		       total_ret_count);
 
 	return total_ret_count == expected;
 }
@@ -142,14 +142,14 @@ test_hugetlb_read(int fd, size_t len, size_t wr_chunk_size)
 	char *filemap = NULL;
 
 	if (ftruncate(fd, len) < 0) {
-		perror(PREFIX ERROR_PREFIX "ftruncate failed");
+		ksft_perror(PREFIX ERROR_PREFIX "ftruncate failed");
 		return status;
 	}
 
 	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
 		       MAP_SHARED | MAP_POPULATE, fd, 0);
 	if (filemap == MAP_FAILED) {
-		perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
+		ksft_perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
 		goto done;
 	}
 
@@ -162,7 +162,7 @@ test_hugetlb_read(int fd, size_t len, size_t wr_chunk_size)
 	munmap(filemap, len);
 done:
 	if (ftruncate(fd, 0) < 0) {
-		perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
+		ksft_perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
 		status = TEST_FAILED;
 	}
 
@@ -179,14 +179,14 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
 	const unsigned long pagesize = getpagesize();
 
 	if (ftruncate(fd, len) < 0) {
-		perror(PREFIX ERROR_PREFIX "ftruncate failed");
+		ksft_perror(PREFIX ERROR_PREFIX "ftruncate failed");
 		return status;
 	}
 
 	filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
 		       MAP_SHARED | MAP_POPULATE, fd, 0);
 	if (filemap == MAP_FAILED) {
-		perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
+		ksft_perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
 		goto done;
 	}
 
@@ -201,7 +201,7 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
 	 */
 	hwp_addr = filemap + len / 2 + pagesize;
 	if (madvise(hwp_addr, pagesize, MADV_HWPOISON) < 0) {
-		perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
+		ksft_perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
 		goto unmap;
 	}
 
@@ -228,7 +228,7 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
 	munmap(filemap, len);
 done:
 	if (ftruncate(fd, 0) < 0) {
-		perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
+		ksft_perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
 		status = TEST_FAILED;
 	}
 
@@ -240,27 +240,32 @@ static int create_hugetlbfs_file(struct statfs *file_stat)
 	int fd;
 
 	fd = memfd_create("hugetlb_tmp", MFD_HUGETLB);
-	if (fd < 0) {
-		perror(PREFIX ERROR_PREFIX "could not open hugetlbfs file");
-		return -1;
-	}
+	if (fd < 0)
+		ksft_exit_fail_msg(PREFIX ERROR_PREFIX "could not open hugetlbfs file: %s\n",
+				   strerror(errno));
 
 	memset(file_stat, 0, sizeof(*file_stat));
+
 	if (fstatfs(fd, file_stat)) {
-		perror(PREFIX ERROR_PREFIX "fstatfs failed");
-		goto close;
+		close(fd);
+		ksft_exit_fail_msg(PREFIX ERROR_PREFIX "fstatfs failed: %s\n", strerror(errno));
 	}
 	if (file_stat->f_type != HUGETLBFS_MAGIC) {
-		printf(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
-		goto close;
+		close(fd);
+		ksft_exit_fail_msg(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
 	}
 
 	return fd;
-close:
-	close(fd);
-	return -1;
 }
 
+#define KSFT_PRINT_MSG(status, fmt, ...)					\
+	do {									\
+		if (status == TEST_SKIPPED)					\
+			ksft_test_result_skip(fmt, __VA_ARGS__);		\
+		else								\
+			ksft_test_result(status == TEST_PASSED, fmt, __VA_ARGS__); \
+	} while (0)
+
 int main(void)
 {
 	int fd;
@@ -273,50 +278,37 @@ int main(void)
 	};
 	size_t i;
 
+	ksft_print_header();
+	ksft_set_plan(12);
+
 	for (i = 0; i < ARRAY_SIZE(wr_chunk_sizes); ++i) {
-		printf("Write/read chunk size=0x%lx\n",
-		       wr_chunk_sizes[i]);
+		ksft_print_msg("Write/read chunk size=0x%lx\n",
+			       wr_chunk_sizes[i]);
 
 		fd = create_hugetlbfs_file(&file_stat);
-		if (fd < 0)
-			goto create_failure;
-		printf(PREFIX "HugeTLB read regression test...\n");
+		ksft_print_msg(PREFIX "HugeTLB read regression test...\n");
 		status = test_hugetlb_read(fd, file_stat.f_bsize,
 					   wr_chunk_sizes[i]);
-		printf(PREFIX "HugeTLB read regression test...%s\n",
-		       status_to_str(status));
+		KSFT_PRINT_MSG(status, PREFIX "HugeTLB read regression test...%s\n",
+			       status_to_str(status));
 		close(fd);
-		if (status == TEST_FAILED)
-			return -1;
 
 		fd = create_hugetlbfs_file(&file_stat);
-		if (fd < 0)
-			goto create_failure;
-		printf(PREFIX "HugeTLB read HWPOISON test...\n");
+		ksft_print_msg(PREFIX "HugeTLB read HWPOISON test...\n");
 		status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
 						    wr_chunk_sizes[i], false);
-		printf(PREFIX "HugeTLB read HWPOISON test...%s\n",
-		       status_to_str(status));
+		KSFT_PRINT_MSG(status, PREFIX "HugeTLB read HWPOISON test...%s\n",
+			       status_to_str(status));
 		close(fd);
-		if (status == TEST_FAILED)
-			return -1;
 
 		fd = create_hugetlbfs_file(&file_stat);
-		if (fd < 0)
-			goto create_failure;
-		printf(PREFIX "HugeTLB seek then read HWPOISON test...\n");
+		ksft_print_msg(PREFIX "HugeTLB seek then read HWPOISON test...\n");
 		status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
 						    wr_chunk_sizes[i], true);
-		printf(PREFIX "HugeTLB seek then read HWPOISON test...%s\n",
-		       status_to_str(status));
+		KSFT_PRINT_MSG(status, PREFIX "HugeTLB seek then read HWPOISON test...%s\n",
+			       status_to_str(status));
 		close(fd);
-		if (status == TEST_FAILED)
-			return -1;
 	}
 
-	return 0;
-
-create_failure:
-	printf(ERROR_PREFIX "Abort test: failed to create hugetlbfs file\n");
-	return -1;
+	ksft_finished();
 }
-- 
2.42.0


