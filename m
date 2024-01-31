Return-Path: <linux-kselftest+bounces-3833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3914C84413F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E838728819E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C24080C08;
	Wed, 31 Jan 2024 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h5UcZbpz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C07BB15;
	Wed, 31 Jan 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709923; cv=none; b=h7olNyBX3169rbdivXDuSuINM0mSee4DZHWdomZl/i33hcviyP1OH17+/08hBc2eBdyN9R6N3EcaZIvYgHrIo7C1xH3oT9uiMkedqUzJSd/t4tysHAPy0HuMPnku99tLAQOfgLSFOasMv3N2OgAY18hZh06iy4ucJR1TX3RL7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709923; c=relaxed/simple;
	bh=svTlCA3lz9tOssty2sVCUQ4b7cMa6+0k/VLIT1J7+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbMujybhC7yIF4F8OOiJRlszpriwfQUr55d1vbFzXOjj2+cMg35va9ELn4kYOxla/pue3JJdFN6QfFJbI2eiX+UeZRFx+pxfe9cKCbpu/wRFqtDQMveP8LOiGvb3xsocCyRRO6BL6zqEm2FI/wpxHYhmE5BVDJt352C7GpMVHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h5UcZbpz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706709918;
	bh=svTlCA3lz9tOssty2sVCUQ4b7cMa6+0k/VLIT1J7+9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5UcZbpzz5WlVb6jsielorPLdi7v9/5hx+xUipMprgD+tt9/1YkFLdd7AoC6TPQD2
	 NcHFBo3gJQVxh7DMj5VVABkH8bWv78M2C/pj4/9cYseG2EGjirR5Ge6NtKUmIO+Lk1
	 HJDbWdNJx/ipBXngFurJcHtqlDx+MnfotdHuxskbV+P5KCqGTnzjfR2vaV2sqXjP2s
	 XkvGMKGKGgioz+Yto7G22wbUCJKIJ629n4HIFURwALHAb7kBdlNkoMlOwxXwwixab4
	 mqjs6T3SNxuWD0Xuz5r8aX3sdSIZmlPHXu+180DZ14ycRcfzHfHHRyh18Rw+hDbzYD
	 gmQBMl4TqlH1Q==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D3794378200E;
	Wed, 31 Jan 2024 14:05:16 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] selftests/mm: map_hugetlb: conform test to TAP format output
Date: Wed, 31 Jan 2024 19:05:12 +0500
Message-ID: <20240131140528.320252-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240131140528.320252-1-usama.anjum@collabora.com>
References: <20240131140528.320252-1-usama.anjum@collabora.com>
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
 tools/testing/selftests/mm/map_hugetlb.c | 42 +++++++++++-------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/map_hugetlb.c b/tools/testing/selftests/mm/map_hugetlb.c
index 86e8f2048a409..a1f005a90a4f0 100644
--- a/tools/testing/selftests/mm/map_hugetlb.c
+++ b/tools/testing/selftests/mm/map_hugetlb.c
@@ -16,6 +16,7 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include "vm_util.h"
+#include "../kselftest.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -31,7 +32,7 @@
 
 static void check_bytes(char *addr)
 {
-	printf("First hex is %x\n", *((unsigned int *)addr));
+	ksft_print_msg("First hex is %x\n", *((unsigned int *)addr));
 }
 
 static void write_bytes(char *addr, size_t length)
@@ -42,23 +43,21 @@ static void write_bytes(char *addr, size_t length)
 		*(addr + i) = (char)i;
 }
 
-static int read_bytes(char *addr, size_t length)
+static void read_bytes(char *addr, size_t length)
 {
 	unsigned long i;
 
 	check_bytes(addr);
 	for (i = 0; i < length; i++)
-		if (*(addr + i) != (char)i) {
-			printf("Mismatch at %lu\n", i);
-			return 1;
-		}
-	return 0;
+		if (*(addr + i) != (char)i)
+			ksft_exit_fail_msg("Mismatch at %lu\n", i);
+
+	ksft_test_result_pass("Read correct data\n");
 }
 
 int main(int argc, char **argv)
 {
 	void *addr;
-	int ret;
 	size_t hugepage_size;
 	size_t length = LENGTH;
 	int flags = FLAGS;
@@ -69,6 +68,9 @@ int main(int argc, char **argv)
 	if (hugepage_size > length)
 		length = hugepage_size;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {
@@ -78,27 +80,23 @@ int main(int argc, char **argv)
 	}
 
 	if (shift)
-		printf("%u kB hugepages\n", 1 << (shift - 10));
+		ksft_print_msg("%u kB hugepages\n", 1 << (shift - 10));
 	else
-		printf("Default size hugepages\n");
-	printf("Mapping %lu Mbytes\n", (unsigned long)length >> 20);
+		ksft_print_msg("Default size hugepages\n");
+	ksft_print_msg("Mapping %lu Mbytes\n", (unsigned long)length >> 20);
 
 	addr = mmap(ADDR, length, PROTECTION, flags, -1, 0);
-	if (addr == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 
-	printf("Returned address is %p\n", addr);
+	ksft_print_msg("Returned address is %p\n", addr);
 	check_bytes(addr);
 	write_bytes(addr, length);
-	ret = read_bytes(addr, length);
+	read_bytes(addr, length);
 
 	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
-	if (munmap(addr, length)) {
-		perror("munmap");
-		exit(1);
-	}
+	if (munmap(addr, length))
+		ksft_exit_fail_msg("munmap: %s\n", strerror(errno));
 
-	return ret;
+	ksft_finished();
 }
-- 
2.42.0


