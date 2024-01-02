Return-Path: <linux-kselftest+bounces-2555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF90821876
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 09:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFD1281777
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D434C84;
	Tue,  2 Jan 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bEq7Iz0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BEE6AA1;
	Tue,  2 Jan 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704184961;
	bh=spflRRYbVyJI+GGk2sTIi1F+XFwMR1bA9QOFqaNLvnI=;
	h=From:To:Cc:Subject:Date:From;
	b=bEq7Iz0D56xaFA4xRPKaUIKofXDRD9rmgTlSkaYBaCPO6vLHZxyOV/FZI5V5TUGC1
	 W5c/iSO1ZL+6ihdoA1eiFBHABzyVVtcwme79aUBopxjNwFDyKVr2Oz0PVDEifNsTLM
	 tjhR9BsNHIyv+9yQTL1D1DtjIHaLyF5XrxYbgV1J3Lj4alhVh0YjdqP0TadeB0sMBt
	 v+Y+/7QU6Wrw1CUWDEWFlcT6KCY8YYiZ3RHgzXIbHcUuCIa4duV+amHSLDX3DV6M9p
	 XAI1TC+0rpBFfoihFhIGNSAuro2HetPS5Br9aWe0wQz5UK/sj12o+iZ/imUJPdpTKP
	 5qZDwuCWaTArw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C054237804B2;
	Tue,  2 Jan 2024 08:42:39 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/selftests: hugepage-mremap: conform test to TAP format output
Date: Tue,  2 Jan 2024 13:19:18 +0500
Message-ID: <20240102081919.2325570-1-usama.anjum@collabora.com>
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
 tools/testing/selftests/mm/hugepage-mremap.c | 87 ++++++++------------
 1 file changed, 35 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index cabd0084f57b..c463d1c09c9b 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -24,6 +24,7 @@
 #include <sys/ioctl.h>
 #include <string.h>
 #include <stdbool.h>
+#include "../kselftest.h"
 #include "vm_util.h"
 
 #define DEFAULT_LENGTH_MB 10UL
@@ -34,7 +35,7 @@
 
 static void check_bytes(char *addr)
 {
-	printf("First hex is %x\n", *((unsigned int *)addr));
+	ksft_print_msg("First hex is %x\n", *((unsigned int *)addr));
 }
 
 static void write_bytes(char *addr, size_t len)
@@ -52,7 +53,7 @@ static int read_bytes(char *addr, size_t len)
 	check_bytes(addr);
 	for (i = 0; i < len; i++)
 		if (*(addr + i) != (char)i) {
-			printf("Mismatch at %lu\n", i);
+			ksft_print_msg("Mismatch at %lu\n", i);
 			return 1;
 		}
 	return 0;
@@ -66,17 +67,13 @@ static void register_region_with_uffd(char *addr, size_t len)
 	/* Create and enable userfaultfd object. */
 
 	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
-	if (uffd == -1) {
-		perror("userfaultfd");
-		exit(1);
-	}
+	if (uffd == -1)
+		ksft_exit_fail_msg("userfaultfd: %s\n", strerror(errno));
 
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = 0;
-	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
-		perror("ioctl-UFFDIO_API");
-		exit(1);
-	}
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1)
+		ksft_exit_fail_msg("ioctl-UFFDIO_API: %s\n", strerror(errno));
 
 	/* Create a private anonymous mapping. The memory will be
 	 * demand-zero paged--that is, not yet allocated. When we
@@ -86,21 +83,17 @@ static void register_region_with_uffd(char *addr, size_t len)
 
 	addr = mmap(NULL, len, PROT_READ | PROT_WRITE,
 		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-	if (addr == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 
-	printf("Address returned by mmap() = %p\n", addr);
+	ksft_print_msg("Address returned by mmap() = %p\n", addr);
 
 	/* Register the memory range of the mapping we just created for
 	 * handling by the userfaultfd object. In mode, we request to track
 	 * missing pages (i.e., pages that have not yet been faulted in).
 	 */
-	if (uffd_register(uffd, addr, len, true, false, false)) {
-		perror("ioctl-UFFDIO_REGISTER");
-		exit(1);
-	}
+	if (uffd_register(uffd, addr, len, true, false, false))
+		ksft_exit_fail_msg("ioctl-UFFDIO_REGISTER: %s\n", strerror(errno));
 }
 
 int main(int argc, char *argv[])
@@ -108,10 +101,11 @@ int main(int argc, char *argv[])
 	size_t length = 0;
 	int ret = 0, fd;
 
-	if (argc >= 2 && !strcmp(argv[1], "-h")) {
-		printf("Usage: %s [length_in_MB]\n", argv[0]);
-		exit(1);
-	}
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	if (argc >= 2 && !strcmp(argv[1], "-h"))
+		ksft_exit_fail_msg("Usage: %s [length_in_MB]\n", argv[0]);
 
 	/* Read memory length as the first arg if valid, otherwise fallback to
 	 * the default length.
@@ -123,50 +117,40 @@ int main(int argc, char *argv[])
 
 	length = MB_TO_BYTES(length);
 	fd = memfd_create(argv[0], MFD_HUGETLB);
-	if (fd < 0) {
-		perror("Open failed");
-		exit(1);
-	}
+	if (fd < 0)
+		ksft_exit_fail_msg("Open failed: %s\n", strerror(errno));
 
 	/* mmap to a PUD aligned address to hopefully trigger pmd sharing. */
 	unsigned long suggested_addr = 0x7eaa40000000;
 	void *haddr = mmap((void *)suggested_addr, length, PROTECTION,
 			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
-	printf("Map haddr: Returned address is %p\n", haddr);
-	if (haddr == MAP_FAILED) {
-		perror("mmap1");
-		exit(1);
-	}
+	ksft_print_msg("Map haddr: Returned address is %p\n", haddr);
+	if (haddr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap1: %s\n", strerror(errno));
 
 	/* mmap again to a dummy address to hopefully trigger pmd sharing. */
 	suggested_addr = 0x7daa40000000;
 	void *daddr = mmap((void *)suggested_addr, length, PROTECTION,
 			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
-	printf("Map daddr: Returned address is %p\n", daddr);
-	if (daddr == MAP_FAILED) {
-		perror("mmap3");
-		exit(1);
-	}
+	ksft_print_msg("Map daddr: Returned address is %p\n", daddr);
+	if (daddr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap3: %s\n", strerror(errno));
 
 	suggested_addr = 0x7faa40000000;
 	void *vaddr =
 		mmap((void *)suggested_addr, length, PROTECTION, FLAGS, -1, 0);
-	printf("Map vaddr: Returned address is %p\n", vaddr);
-	if (vaddr == MAP_FAILED) {
-		perror("mmap2");
-		exit(1);
-	}
+	ksft_print_msg("Map vaddr: Returned address is %p\n", vaddr);
+	if (vaddr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap2: %s\n", strerror(errno));
 
 	register_region_with_uffd(haddr, length);
 
 	void *addr = mremap(haddr, length, length,
 			    MREMAP_MAYMOVE | MREMAP_FIXED, vaddr);
-	if (addr == MAP_FAILED) {
-		perror("mremap");
-		exit(1);
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mremap: %s\n", strerror(errno));
 
-	printf("Mremap: Returned address is %p\n", addr);
+	ksft_print_msg("Mremap: Returned address is %p\n", addr);
 	check_bytes(addr);
 	write_bytes(addr, length);
 	ret = read_bytes(addr, length);
@@ -174,12 +158,11 @@ int main(int argc, char *argv[])
 	munmap(addr, length);
 
 	addr = mremap(addr, length, length, 0);
-	if (addr != MAP_FAILED) {
-		printf("mremap: Expected failure, but call succeeded\n");
-		exit(1);
-	}
+	if (addr != MAP_FAILED)
+		ksft_exit_fail_msg("mremap: Expected failure, but call succeeded\n");
 
 	close(fd);
 
-	return ret;
+	ksft_test_result(!ret, "Read same data\n");
+	ksft_exit(!ret);
 }
-- 
2.42.0


