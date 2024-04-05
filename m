Return-Path: <linux-kselftest+bounces-7289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A526899E2A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF201C2101E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B56416D4CA;
	Fri,  5 Apr 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gUfX2mXb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397CB16D333;
	Fri,  5 Apr 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323113; cv=none; b=ZtY4U0p4MATxROYJsUoneFBlwizQLtLCbA3wJaLQa4NoiI17D2E/vtjOL2AQ/143BD90Q168wq9q6uShsWG84XPm5i8u7CvBtV3lL4Fv5oh2A0FiIPKo8zbkuL/SZbqFJCXpwBctebgr+hyQ+62yaUCT1du5XgACIa0UyGaTw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323113; c=relaxed/simple;
	bh=2NJTbB3KaJRZg2EfipZnI/yOoGaBufin+vZb188D0aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKdhP9r3Mox7ji+aNCDB4YRjFdibAHq9bw7L4r+TBu1xilqVaHdArWMm7OoTI6fTeOX9iDSMsGhRydxv6ExtjGEwCwOXBziw+nWWq6pvcitKKDq/vYqdbr7/A6bkDZ8XL+HRg2v+0CNGPTF4U+TRvwW+QhouTJ3xDhGktX08M2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gUfX2mXb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712323108;
	bh=2NJTbB3KaJRZg2EfipZnI/yOoGaBufin+vZb188D0aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUfX2mXbHlaeYra2Prqyfh+icckGOEpq9cvuiO8/FveKqOaWIw4Ujpu/3siAnID0I
	 QU3oGklkyUNZIstg+EujOVnN8JgvMKIJNmuqircjMQG3IQkWqWZjvysI+mVY+4d1sh
	 ZSSnqCoQUEo/AFkSZkUjJNdsb/wzhPImmRu9qm4aNGGbG86ZXKYt2uTFXhoGRoRVaj
	 XHWIw8MqAZQQm16TbNRzKr9CTHWx9f6FB54eFBshsHLWZTJ4m0PMteIUo4szwXkOSR
	 4MtOxCxo6ZKbS0temHeWzoZNIBVMs4Q2d9JErFhYwiwtHktIBqL8Kqdhmb8gA9Kayy
	 LbnTriNqjuX3Q==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 57C653782128;
	Fri,  5 Apr 2024 13:18:25 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 2/2] selftests: Remove Error/Failed prefix from ksft_exit_fail*() usages
Date: Fri,  5 Apr 2024 18:17:48 +0500
Message-Id: <20240405131748.1582646-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405131748.1582646-1-usama.anjum@collabora.com>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove Error/Failed prefix from ksft_exit_fail*() usages as prefix is
already present in the ksft_exit_fail*().

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/exec/load_address.c   |   8 +-
 .../testing/selftests/exec/recursion-depth.c  |  10 +-
 .../selftests/mm/map_fixed_noreplace.c        |  24 +--
 tools/testing/selftests/mm/map_populate.c     |   2 +-
 tools/testing/selftests/mm/mremap_dontunmap.c |   2 +-
 tools/testing/selftests/mm/pagemap_ioctl.c    | 166 +++++++++---------
 .../selftests/mm/split_huge_page_test.c       |   2 +-
 7 files changed, 107 insertions(+), 107 deletions(-)

diff --git a/tools/testing/selftests/exec/load_address.c b/tools/testing/selftests/exec/load_address.c
index 17e3207d34ae7..438856b07260c 100644
--- a/tools/testing/selftests/exec/load_address.c
+++ b/tools/testing/selftests/exec/load_address.c
@@ -47,16 +47,16 @@ int main(int argc, char **argv)
 
 	ret = dl_iterate_phdr(ExtractStatistics, &extracted);
 	if (ret != 1)
-		ksft_exit_fail_msg("FAILED: dl_iterate_phdr\n");
+		ksft_exit_fail_msg("dl_iterate_phdr\n");
 
 	if (extracted.alignment == 0)
-		ksft_exit_fail_msg("FAILED: No alignment found\n");
+		ksft_exit_fail_msg("No alignment found\n");
 	else if (extracted.alignment & (extracted.alignment - 1))
-		ksft_exit_fail_msg("FAILED: Alignment is not a power of 2\n");
+		ksft_exit_fail_msg("Alignment is not a power of 2\n");
 
 	misalign = extracted.load_address & (extracted.alignment - 1);
 	if (misalign)
-		ksft_exit_fail_msg("FAILED: alignment = %llu, load_address = %llu\n",
+		ksft_exit_fail_msg("alignment = %llu, load_address = %llu\n",
 				   extracted.alignment, extracted.load_address);
 
 	ksft_test_result_pass("Completed\n");
diff --git a/tools/testing/selftests/exec/recursion-depth.c b/tools/testing/selftests/exec/recursion-depth.c
index 438c8ff2fd260..9dd20251dc7eb 100644
--- a/tools/testing/selftests/exec/recursion-depth.c
+++ b/tools/testing/selftests/exec/recursion-depth.c
@@ -37,25 +37,25 @@ int main(void)
 			ksft_test_result_skip("error: unshare, errno %d\n", errno);
 			ksft_finished();
 		}
-		ksft_exit_fail_perror("error: unshare");
+		ksft_exit_fail_perror("unshare");
 	}
 
 	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1)
-		ksft_exit_fail_perror("error: mount '/'");
+		ksft_exit_fail_perror("mount '/'");
 
 	/* Require "exec" filesystem. */
 	if (mount(NULL, "/tmp", "ramfs", 0, NULL) == -1)
-		ksft_exit_fail_perror("error: mount ramfs");
+		ksft_exit_fail_perror("mount ramfs");
 
 #define FILENAME "/tmp/1"
 
 	fd = creat(FILENAME, 0700);
 	if (fd == -1)
-		ksft_exit_fail_perror("error: creat");
+		ksft_exit_fail_perror("creat");
 
 #define S "#!" FILENAME "\n"
 	if (write(fd, S, strlen(S)) != strlen(S))
-		ksft_exit_fail_perror("error: write");
+		ksft_exit_fail_perror("write");
 
 	close(fd);
 
diff --git a/tools/testing/selftests/mm/map_fixed_noreplace.c b/tools/testing/selftests/mm/map_fixed_noreplace.c
index b74813fdc9514..58fb562efe25b 100644
--- a/tools/testing/selftests/mm/map_fixed_noreplace.c
+++ b/tools/testing/selftests/mm/map_fixed_noreplace.c
@@ -30,10 +30,10 @@ static unsigned long find_base_addr(unsigned long size)
 	flags = MAP_PRIVATE | MAP_ANONYMOUS;
 	addr = mmap(NULL, size, PROT_NONE, flags, -1, 0);
 	if (addr == MAP_FAILED)
-		ksft_exit_fail_msg("Error: couldn't map the space we need for the test\n");
+		ksft_exit_fail_msg("couldn't map the space we need for the test\n");
 
 	if (munmap(addr, size) != 0)
-		ksft_exit_fail_msg("Error: munmap failed\n");
+		ksft_exit_fail_msg("munmap failed\n");
 
 	return (unsigned long)addr;
 }
@@ -61,11 +61,11 @@ int main(void)
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	if (p == MAP_FAILED) {
 		dump_maps();
-		ksft_exit_fail_msg("Error: couldn't map the space we need for the test\n");
+		ksft_exit_fail_msg("couldn't map the space we need for the test\n");
 	}
 	if (munmap((void *)addr, 5 * page_size) != 0) {
 		dump_maps();
-		ksft_exit_fail_msg("Error: munmap failed!?\n");
+		ksft_exit_fail_msg("munmap failed!?\n");
 	}
 	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
@@ -74,7 +74,7 @@ int main(void)
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	if (p == MAP_FAILED) {
 		dump_maps();
-		ksft_exit_fail_msg("Error: first mmap() failed unexpectedly\n");
+		ksft_exit_fail_msg("first mmap() failed unexpectedly\n");
 	}
 	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
@@ -91,7 +91,7 @@ int main(void)
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	if (p != MAP_FAILED) {
 		dump_maps();
-		ksft_exit_fail_msg("Error:1: mmap() succeeded when it shouldn't have\n");
+		ksft_exit_fail_msg("1: mmap() succeeded when it shouldn't have\n");
 	}
 	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
@@ -109,7 +109,7 @@ int main(void)
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	if (p != MAP_FAILED) {
 		dump_maps();
-		ksft_exit_fail_msg("Error:2: mmap() succeeded when it shouldn't have\n");
+		ksft_exit_fail_msg("2: mmap() succeeded when it shouldn't have\n");
 	}
 	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
@@ -126,7 +126,7 @@ int main(void)
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	if (p != MAP_FAILED) {
 		dump_maps();
-		ksft_exit_fail_msg("Error:3: mmap() succeeded when it shouldn't have\n");
+		ksft_exit_fail_msg("3: mmap() succeeded when it shouldn't have\n");
 	}
 	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
@@ -143,7 +143,7 @@ int main(void)
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	if (p != MAP_FAILED) {
 		dump_maps();
-		ksft_exit_fail_msg("Error:4: mmap() succeeded when it shouldn't have\n");
+		ksft_exit_fail_msg("4: mmap() succeeded when it shouldn't have\n");
 	}
 	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
@@ -160,7 +160,7 @@ int main(void)
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	if (p == MAP_FAILED) {
 		dump_maps();
-		ksft_exit_fail_msg("Error:5: mmap() failed when it shouldn't have\n");
+		ksft_exit_fail_msg("5: mmap() failed when it shouldn't have\n");
 	}
 	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
@@ -177,7 +177,7 @@ int main(void)
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	if (p == MAP_FAILED) {
 		dump_maps();
-		ksft_exit_fail_msg("Error:6: mmap() failed when it shouldn't have\n");
+		ksft_exit_fail_msg("6: mmap() failed when it shouldn't have\n");
 	}
 	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
@@ -185,7 +185,7 @@ int main(void)
 	size = 5 * page_size;
 	if (munmap((void *)addr, size) != 0) {
 		dump_maps();
-		ksft_exit_fail_msg("Error: munmap failed!?\n");
+		ksft_exit_fail_msg("munmap failed!?\n");
 	}
 	ksft_test_result_pass("Base Address unmap() successful\n");
 
diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 5c8a53869b1bd..8254f80da376b 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -23,7 +23,7 @@
 #define BUG_ON(condition, description)						\
 	do {									\
 		if (condition)							\
-			ksft_exit_fail_msg("[FAIL]\t%s:%d\t%s:%s\n",		\
+			ksft_exit_fail_msg("%s:%d\t%s:%s\n",			\
 					   __func__, __LINE__, (description),	\
 					   strerror(errno));			\
 	} while (0)
diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
index 1d75084b9ca56..bb5c878059fa0 100644
--- a/tools/testing/selftests/mm/mremap_dontunmap.c
+++ b/tools/testing/selftests/mm/mremap_dontunmap.c
@@ -31,7 +31,7 @@ static void dump_maps(void)
 	do {									\
 		if (condition) {						\
 			dump_maps();						\
-			ksft_exit_fail_msg("[FAIL]\t%s:%d\t%s:%s\n",		\
+			ksft_exit_fail_msg("%s:%d\t%s:%s\n",			\
 					   __func__, __LINE__, (description),	\
 					   strerror(errno));			\
 		}								\
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index d59517ed3d48b..da90948f5dcc5 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -153,7 +153,7 @@ int wp_addr_range(void *lpBaseAddress, int dwRegionSize)
 	if (pagemap_ioctl(lpBaseAddress, dwRegionSize, NULL, 0,
 			  PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN) < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", 1, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", 1, errno, strerror(errno));
 
 	return 0;
 }
@@ -190,7 +190,7 @@ int userfaultfd_tests(void)
 	mem_size = num_pages * page_size;
 	mem = mmap(NULL, mem_size, PROT_NONE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	wp_init(mem, mem_size);
 
@@ -213,7 +213,7 @@ int userfaultfd_tests(void)
 	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 				vec_size - 2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", written, errno, strerror(errno));
 
 	ksft_test_result(written == 0, "%s all new pages must not be written (dirty)\n", __func__);
 
@@ -246,15 +246,15 @@ int sanity_tests_sd(void)
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
 	if (!vec)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	vec2 = malloc(sizeof(struct page_region) * vec_size);
 	if (!vec2)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	wp_init(mem, mem_size);
 	wp_addr_range(mem, mem_size);
@@ -321,7 +321,7 @@ int sanity_tests_sd(void)
 	ret = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0, PAGE_IS_WRITTEN, 0,
 			    0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	ksft_test_result(ret == mem_size/(page_size * 2),
 			 "%s Repeated pattern of written and non-written pages\n", __func__);
@@ -331,18 +331,18 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    num_pages/2 - 2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	ret2 = pagemap_ioctl(mem, mem_size, vec, 2, 0, 0, PAGE_IS_WRITTEN, 0, 0,
 			     PAGE_IS_WRITTEN);
 	if (ret2 < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret2, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret2, errno, strerror(errno));
 
 	ret3 = pagemap_ioctl(mem, mem_size, vec, vec_size,
 			     PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			     0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret3 < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret3, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret3, errno, strerror(errno));
 
 	ksft_test_result((ret + ret3) == num_pages/2 && ret2 == 2,
 			 "%s Repeated pattern of written and non-written pages in parts %d %d %d\n",
@@ -357,13 +357,13 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    num_pages/2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	ret2 = pagemap_ioctl(mem, mem_size, vec, vec_size,
 			     PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			     0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret2 < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret2, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret2, errno, strerror(errno));
 
 	ksft_test_result(ret == num_pages/2 && ret2 == 1,
 			 "%s Repeated pattern of written and non-written pages max_pages\n",
@@ -378,12 +378,12 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	ret2 = pagemap_ioctl(mem, mem_size, vec2, vec_size, 0, 0,
 			      PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret2 < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret2, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret2, errno, strerror(errno));
 
 	ksft_test_result(ret == 1 && LEN(vec[0]) == 2 &&
 			 vec[0].start == (uintptr_t)(mem + page_size) &&
@@ -398,10 +398,10 @@ int sanity_tests_sd(void)
 	/* 7. Two regions */
 	m[0] = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (m[0] == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 	m[1] = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (m[1] == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	wp_init(m[0], mem_size);
 	wp_init(m[1], mem_size);
@@ -416,7 +416,7 @@ int sanity_tests_sd(void)
 	ret = pagemap_ioctl(m[1], mem_size, vec, 1, 0, 0, PAGE_IS_WRITTEN, 0, 0,
 			    PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	ksft_test_result(ret == 1 && LEN(vec[0]) == mem_size/page_size,
 			 "%s Two regions\n", __func__);
@@ -435,11 +435,11 @@ int sanity_tests_sd(void)
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
 	if (!vec)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	wp_init(mem, mem_size);
 	wp_addr_range(mem, mem_size);
@@ -448,7 +448,7 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC, 0,
 			    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	for (i = 0; i < mem_size/page_size; i += 2)
 		mem[i * page_size]++;
@@ -457,7 +457,7 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    mem_size/(page_size*5), PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	total_pages += ret;
 
@@ -465,7 +465,7 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    mem_size/(page_size*5), PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	total_pages += ret;
 
@@ -473,7 +473,7 @@ int sanity_tests_sd(void)
 			    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			    mem_size/(page_size*5), PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	total_pages += ret;
 
@@ -490,11 +490,11 @@ int sanity_tests_sd(void)
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
 	if (!vec)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	wp_init(mem, mem_size);
 	wp_addr_range(mem, mem_size);
@@ -515,7 +515,7 @@ int sanity_tests_sd(void)
 					  vec_size, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 					  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 			if (ret < 0)
-				ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+				ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 			if (ret > vec_size)
 				break;
@@ -540,11 +540,11 @@ int sanity_tests_sd(void)
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
 	if (!vec)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	wp_init(mem, mem_size);
 	wp_addr_range(mem, mem_size);
@@ -554,63 +554,63 @@ int sanity_tests_sd(void)
 	ret = pagemap_ioc(mem, 0, vec, vec_size, 0,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 0 && walk_end == (long)mem,
 			 "Walk_end: Same start and end address\n");
 
 	ret = pagemap_ioc(mem, 0, vec, vec_size, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 0 && walk_end == (long)mem,
 			 "Walk_end: Same start and end with WP\n");
 
 	ret = pagemap_ioc(mem, 0, vec, 0, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 0 && walk_end == (long)mem,
 			 "Walk_end: Same start and end with 0 output buffer\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + mem_size),
 			 "Walk_end: Big vec\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, 1, 0,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + mem_size),
 			 "Walk_end: vec of minimum length\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, 1, 0,
 			  vec_size, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + mem_size),
 			 "Walk_end: Max pages specified\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  vec_size/2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + mem_size/2),
 			 "Walk_end: Half max pages\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  1, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + page_size),
 			 "Walk_end: 1 max page\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  -1, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + mem_size),
 			 "Walk_end: max pages\n");
 
@@ -621,49 +621,49 @@ int sanity_tests_sd(void)
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == vec_size/2 && walk_end == (long)(mem + mem_size),
 			 "Walk_end sparse: Big vec\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, 1, 0,
 			  0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + page_size * 2),
 			 "Walk_end sparse: vec of minimum length\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, 1, 0,
 			  vec_size, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + page_size * 2),
 			 "Walk_end sparse: Max pages specified\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size/2, 0,
 			  vec_size, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == vec_size/2 && walk_end == (long)(mem + mem_size),
 			 "Walk_end sparse: Max pages specified\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  vec_size, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == vec_size/2 && walk_end == (long)(mem + mem_size),
 			 "Walk_end sparse: Max pages specified\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  vec_size/2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == vec_size/2 && walk_end == (long)(mem + mem_size),
 			 "Walk_endsparse : Half max pages\n");
 
 	ret = pagemap_ioc(mem, mem_size, vec, vec_size, 0,
 			  1, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 	ksft_test_result(ret == 1 && walk_end == (long)(mem + page_size * 2),
 			 "Walk_end: 1 max page\n");
 
@@ -698,7 +698,7 @@ int base_tests(char *prefix, char *mem, int mem_size, int skip)
 	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 				vec_size - 2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", written, errno, strerror(errno));
 
 	ksft_test_result(written == 0, "%s all new pages must not be written (dirty)\n", prefix);
 
@@ -708,7 +708,7 @@ int base_tests(char *prefix, char *mem, int mem_size, int skip)
 	written = pagemap_ioctl(mem, mem_size, vec, 1, 0, 0, PAGE_IS_WRITTEN, 0, 0,
 			      PAGE_IS_WRITTEN);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", written, errno, strerror(errno));
 
 	ksft_test_result(written == 1 && LEN(vec[0]) == mem_size/page_size,
 			 "%s all pages must be written (dirty)\n", prefix);
@@ -717,14 +717,14 @@ int base_tests(char *prefix, char *mem, int mem_size, int skip)
 	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 				0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", written, errno, strerror(errno));
 
 	memset(mem + page_size, 0, mem_size - (2 * page_size));
 
 	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 				0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", written, errno, strerror(errno));
 
 	ksft_test_result(written == 1 && LEN(vec[0]) >= vec_size - 2 && LEN(vec[0]) <= vec_size,
 			 "%s all pages dirty other than first and the last one\n", prefix);
@@ -732,7 +732,7 @@ int base_tests(char *prefix, char *mem, int mem_size, int skip)
 	written = pagemap_ioctl(mem, mem_size, vec, 1, 0, 0,
 				PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", written, errno, strerror(errno));
 
 	ksft_test_result(written == 0,
 			 "%s PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC\n", prefix);
@@ -741,14 +741,14 @@ int base_tests(char *prefix, char *mem, int mem_size, int skip)
 	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 				0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", written, errno, strerror(errno));
 
 	mem[vec_size/2 * page_size]++;
 
 	written = pagemap_ioctl(mem, mem_size, vec, vec_size, 0, 0, PAGE_IS_WRITTEN,
 				0, 0, PAGE_IS_WRITTEN);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", written, errno, strerror(errno));
 
 	ksft_test_result(written == 1 && LEN(vec[0]) >= 1,
 			 "%s only middle page dirty\n", prefix);
@@ -757,7 +757,7 @@ int base_tests(char *prefix, char *mem, int mem_size, int skip)
 	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 				0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN | PAGE_IS_HUGE);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", written, errno, strerror(errno));
 
 	mem[vec_size/2 * page_size]++;
 	mem[(vec_size/2 + 1) * page_size]++;
@@ -765,7 +765,7 @@ int base_tests(char *prefix, char *mem, int mem_size, int skip)
 	written = pagemap_ioctl(&mem[vec_size/2 * page_size], 2 * page_size, vec, 1, 0,
 				0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN | PAGE_IS_HUGE);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", written, errno, strerror(errno));
 
 	ksft_test_result(written == 1 && vec[0].start == (uintptr_t)(&mem[vec_size/2 * page_size])
 			 && LEN(vec[0]) == 2,
@@ -818,7 +818,7 @@ int hpage_unit_tests(void)
 				    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC, 0,
 				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 		if (ret < 0)
-			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+			ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 		ksft_test_result(ret == 0, "%s all new huge page must not be written (dirty)\n",
 				 __func__);
@@ -827,7 +827,7 @@ int hpage_unit_tests(void)
 		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
 				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 		if (ret < 0)
-			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+			ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 		ksft_test_result(ret == 0, "%s all the huge page must not be written\n", __func__);
 
@@ -837,7 +837,7 @@ int hpage_unit_tests(void)
 				    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 				    0, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 		if (ret < 0)
-			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+			ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 		ksft_test_result(ret == 1 && vec[0].start == (uintptr_t)map &&
 				 LEN(vec[0]) == vec_size && vec[0].categories == PAGE_IS_WRITTEN,
@@ -854,7 +854,7 @@ int hpage_unit_tests(void)
 		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
 				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 		if (ret < 0)
-			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+			ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 		ksft_test_result(ret == 1 && LEN(vec[0]) > 0,
 				 "%s only middle page written\n", __func__);
@@ -881,7 +881,7 @@ int hpage_unit_tests(void)
 		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
 				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 		if (ret < 0)
-			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+			ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 		ksft_test_result(ret == 1 && LEN(vec[0]) == vec_size/2 &&
 				 vec[0].start == (uintptr_t)(map + map_size/2),
@@ -904,12 +904,12 @@ int hpage_unit_tests(void)
 				    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 				    vec_size/2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 		if (ret < 0)
-			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+			ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
 				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 		if (ret < 0)
-			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+			ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 		ksft_test_result(ret == 1 && LEN(vec[0]) == vec_size/2 &&
 				 vec[0].start == (uintptr_t)(map + map_size/2),
@@ -934,12 +934,12 @@ int hpage_unit_tests(void)
 				    PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC, vec_size/2,
 				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 		if (ret < 0)
-			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+			ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 		ret = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
 				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 		if (ret < 0)
-			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+			ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 		ksft_test_result(ret == 1 && LEN(vec[0]) == vec_size/2,
 				 "%s clear second half huge page\n", __func__);
@@ -963,7 +963,7 @@ int hpage_unit_tests(void)
 				    hpage_size/(2*page_size), PAGE_IS_WRITTEN, 0, 0,
 				    PAGE_IS_WRITTEN);
 		if (ret < 0)
-			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+			ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 		ksft_test_result(ret == 1 && LEN(vec[0]) == hpage_size/(2*page_size),
 				 "%s get half huge page\n", __func__);
@@ -971,7 +971,7 @@ int hpage_unit_tests(void)
 		ret2 = pagemap_ioctl(map, map_size, vec, vec_size, 0, 0,
 				    PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 		if (ret2 < 0)
-			ksft_exit_fail_msg("error %d %d %s\n", ret2, errno, strerror(errno));
+			ksft_exit_fail_msg("%d %d %s\n", ret2, errno, strerror(errno));
 
 		ksft_test_result(ret2 == 1 && LEN(vec[0]) == (map_size - hpage_size/2)/page_size,
 				 "%s get half huge page\n", __func__);
@@ -999,7 +999,7 @@ int unmapped_region_tests(void)
 	written = pagemap_ioctl(start, len, vec, vec_size, 0, 0,
 				PAGEMAP_NON_WRITTEN_BITS, 0, 0, PAGEMAP_NON_WRITTEN_BITS);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", written, errno, strerror(errno));
 
 	ksft_test_result(written >= 0, "%s Get status of pages\n", __func__);
 
@@ -1060,7 +1060,7 @@ int sanity_tests(void)
 	vec = malloc(sizeof(struct page_region) * vec_size);
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED || vec == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 
 	wp_init(mem, mem_size);
 	wp_addr_range(mem, mem_size);
@@ -1088,7 +1088,7 @@ int sanity_tests(void)
 	/* 2. Get sd and present pages with anyof_mask */
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 	wp_init(mem, mem_size);
 	wp_addr_range(mem, mem_size);
 
@@ -1134,7 +1134,7 @@ int sanity_tests(void)
 	/* 8. Find written present pages with return mask */
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 	wp_init(mem, mem_size);
 	wp_addr_range(mem, mem_size);
 
@@ -1156,11 +1156,11 @@ int sanity_tests(void)
 
 	ret = stat(progname, &sbuf);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	fmem = mmap(NULL, sbuf.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (fmem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
+		ksft_exit_fail_msg("nomem %d %s\n", errno, strerror(errno));
 
 	tmp_buf = malloc(sbuf.st_size);
 	memcpy(tmp_buf, fmem, sbuf.st_size);
@@ -1190,7 +1190,7 @@ int sanity_tests(void)
 
 	fmem = mmap(NULL, buf_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (fmem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
+		ksft_exit_fail_msg("nomem %d %s\n", errno, strerror(errno));
 
 	wp_init(fmem, buf_size);
 	wp_addr_range(fmem, buf_size);
@@ -1232,7 +1232,7 @@ int mprotect_tests(void)
 	/* 1. Map two pages */
 	mem = mmap(0, 2 * page_size, PROT_READ|PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 	wp_init(mem, 2 * page_size);
 	wp_addr_range(mem, 2 * page_size);
 
@@ -1242,7 +1242,7 @@ int mprotect_tests(void)
 	ret = pagemap_ioctl(mem, 2 * page_size, &vec, 1, 0, 0, PAGE_IS_WRITTEN,
 			    0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	ksft_test_result(ret == 1 && LEN(vec) == 2, "%s Both pages written\n", __func__);
 
@@ -1257,7 +1257,7 @@ int mprotect_tests(void)
 	mem2 = mmap(mem + page_size, page_size, PROT_READ|PROT_WRITE,
 		    MAP_PRIVATE|MAP_ANON|MAP_FIXED, -1, 0);
 	if (mem2 == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 	wp_init(mem2, page_size);
 	wp_addr_range(mem2, page_size);
 
@@ -1277,7 +1277,7 @@ int mprotect_tests(void)
 	ret = pagemap_ioctl(mem, 2 * page_size, &vec, 1, 0, 0, PAGE_IS_WRITTEN,
 			    0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	ksft_test_result(ret == 1 && LEN(vec) == 2,
 			 "%s Both pages written after remap and mprotect\n", __func__);
@@ -1290,7 +1290,7 @@ int mprotect_tests(void)
 	ret = pagemap_ioctl(mem, 2 * page_size, &vec, 1, 0, 0, PAGE_IS_WRITTEN,
 			    0, 0, PAGE_IS_WRITTEN);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	ksft_test_result(ret == 1 && LEN(vec) == 2,
 			 "%s Clear and make the pages written\n", __func__);
@@ -1397,7 +1397,7 @@ static void transact_test(int page_size)
 	mem = mmap(NULL, 0x1000 * nthreads * pages_per_thread, PROT_READ | PROT_WRITE,
 		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("Error mmap %s.\n", strerror(errno));
+		ksft_exit_fail_msg("mmap %s.\n", strerror(errno));
 
 	wp_init(mem, 0x1000 * nthreads * pages_per_thread);
 	wp_addr_range(mem, 0x1000 * nthreads * pages_per_thread);
@@ -1502,7 +1502,7 @@ int main(int argc, char *argv[])
 	mem_size = 10 * page_size;
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 	wp_init(mem, mem_size);
 	wp_addr_range(mem, mem_size);
 
@@ -1515,7 +1515,7 @@ int main(int argc, char *argv[])
 	mem_size = 512 * 10 * page_size;
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem\n");
+		ksft_exit_fail_msg("nomem\n");
 	wp_init(mem, mem_size);
 	wp_addr_range(mem, mem_size);
 
@@ -1595,11 +1595,11 @@ int main(int argc, char *argv[])
 
 	ret = stat(__FILE__".tmp0", &sbuf);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("%d %d %s\n", ret, errno, strerror(errno));
 
 	fmem = mmap(NULL, sbuf.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (fmem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
+		ksft_exit_fail_msg("nomem %d %s\n", errno, strerror(errno));
 
 	wp_init(fmem, sbuf.st_size);
 	wp_addr_range(fmem, sbuf.st_size);
@@ -1619,7 +1619,7 @@ int main(int argc, char *argv[])
 				   strerror(errno));
 
 	if (ftruncate(fd, buf_size))
-		ksft_exit_fail_msg("Error ftruncate\n");
+		ksft_exit_fail_msg("ftruncate\n");
 
 	for (i = 0; i < buf_size; i++)
 		if (write(fd, "c", 1) < 0)
@@ -1627,7 +1627,7 @@ int main(int argc, char *argv[])
 
 	fmem = mmap(NULL, buf_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (fmem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
+		ksft_exit_fail_msg("nomem %d %s\n", errno, strerror(errno));
 
 	wp_init(fmem, buf_size);
 	wp_addr_range(fmem, buf_size);
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 6c988bd2f3356..f0a400f196956 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -264,7 +264,7 @@ void split_file_backed_thp(void)
 cleanup:
 	umount(tmpfs_loc);
 	rmdir(tmpfs_loc);
-	ksft_exit_fail_msg("Error occurred\n");
+	ksft_exit_fail_msg("occurred\n");
 }
 
 bool prepare_thp_fs(const char *xfs_path, char *thp_fs_template,
-- 
2.39.2


