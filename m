Return-Path: <linux-kselftest+bounces-3843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7273D844154
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D9C1C21A2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AF4129A90;
	Wed, 31 Jan 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3f+BaCVH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908DC8286E;
	Wed, 31 Jan 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709944; cv=none; b=SwNMcNsptKTZPESz80s2sFaSYtiuo6VPzQMmuLfZriG3vomk3m4qdOZnpZNqb7huHPwMHsjbVgxPPlus1vv8KaZLsF45dHzrLq9oeu1194/zW4gGFH0UJkZCyA1n1hXFrwym4GSgVHPcGYzRz0sS6SSX/myK9bQKJMszIABBxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709944; c=relaxed/simple;
	bh=oFf1K2mfeMM9jrFoVwJzVfcP3pmuBYS1DF+vRN85jqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxmSD8x/AdSAAtCKNFnv5cnLvt5ZSXKCVUJz//IzoD4C3K6VQPNziHISMNt0Vr/BM+Gwv/KlEopYnespncYG7xzLscLddMvCJQeJlJoTOM0kKahM9DC5BY7vmPWW+czIVprwmjavkS13Gvhzm468E8QyMhFnVsb+fHEuPRZ5MZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3f+BaCVH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706709940;
	bh=oFf1K2mfeMM9jrFoVwJzVfcP3pmuBYS1DF+vRN85jqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=3f+BaCVH11VOm4tY8FHrLyoUrRQ7PU62w2wjDp5L7h/Jdn4OXG4mCaiCuKGRLr7tb
	 RPpfVphdNKWzhuFSWjW1iJtzU4WlOyl7f9eNoZI9GtjICj7Eh3l6aTIgqfMllXCJe0
	 eI9UrT1cjnQIG3FCqyqOflwg7Nx09sTv1sQbMfV8DeRyEGr6ZHHHDhWTAdlUUUAvyP
	 yOCM0hF1ZMN6uXQgiCZkJLmsQ3/sYAHz0P91TtCaGz8YT0KL+OyugYk+WJAbHpgl8J
	 57df//bvcexHayvkMJQFhPIgQMS5VBA4VKOWZRpExyZy2XfgLXS8AwfMjcIB5M45Fc
	 5iU2blGJ+E+nw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 438843782081;
	Wed, 31 Jan 2024 14:05:39 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] selftests/mm: transhuge-stress: conform to TAP format output
Date: Wed, 31 Jan 2024 19:05:21 +0500
Message-ID: <20240131140528.320252-11-usama.anjum@collabora.com>
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
 tools/testing/selftests/mm/transhuge-stress.c | 36 +++++++++++--------
 tools/testing/selftests/mm/vm_util.c          |  6 ++--
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/mm/transhuge-stress.c b/tools/testing/selftests/mm/transhuge-stress.c
index c61fb9350b8c2..68201192e37c8 100644
--- a/tools/testing/selftests/mm/transhuge-stress.c
+++ b/tools/testing/selftests/mm/transhuge-stress.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include "vm_util.h"
+#include "../kselftest.h"
 
 int backing_fd = -1;
 int mmap_flags = MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE;
@@ -34,6 +35,8 @@ int main(int argc, char **argv)
 	int pagemap_fd;
 	int duration = 0;
 
+	ksft_print_header();
+
 	ram = sysconf(_SC_PHYS_PAGES);
 	if (ram > SIZE_MAX / psize() / 4)
 		ram = SIZE_MAX / 4;
@@ -43,7 +46,8 @@ int main(int argc, char **argv)
 
 	while (++i < argc) {
 		if (!strcmp(argv[i], "-h"))
-			errx(1, "usage: %s [-f <filename>] [-d <duration>] [size in MiB]", argv[0]);
+			ksft_exit_fail_msg("usage: %s [-f <filename>] [-d <duration>] [size in MiB]\n",
+					   argv[0]);
 		else if (!strcmp(argv[i], "-f"))
 			name = argv[++i];
 		else if (!strcmp(argv[i], "-d"))
@@ -52,10 +56,12 @@ int main(int argc, char **argv)
 			len = atoll(argv[i]) << 20;
 	}
 
+	ksft_set_plan(1);
+
 	if (name) {
 		backing_fd = open(name, O_RDWR);
 		if (backing_fd == -1)
-			errx(2, "open %s", name);
+			ksft_exit_fail_msg("open %s\n", name);
 		mmap_flags = MAP_SHARED;
 	}
 
@@ -65,21 +71,21 @@ int main(int argc, char **argv)
 
 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
 	if (pagemap_fd < 0)
-		err(2, "open pagemap");
+		ksft_exit_fail_msg("open pagemap\n");
 
 	len -= len % HPAGE_SIZE;
 	ptr = mmap(NULL, len + HPAGE_SIZE, PROT_RW, mmap_flags, backing_fd, 0);
 	if (ptr == MAP_FAILED)
-		err(2, "initial mmap");
+		ksft_exit_fail_msg("initial mmap");
 	ptr += HPAGE_SIZE - (uintptr_t)ptr % HPAGE_SIZE;
 
 	if (madvise(ptr, len, MADV_HUGEPAGE))
-		err(2, "MADV_HUGEPAGE");
+		ksft_exit_fail_msg("MADV_HUGEPAGE");
 
 	map_len = ram >> (HPAGE_SHIFT - 1);
 	map = malloc(map_len);
 	if (!map)
-		errx(2, "map malloc");
+		ksft_exit_fail_msg("map malloc\n");
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
 
@@ -103,7 +109,7 @@ int main(int argc, char **argv)
 				if (idx >= map_len) {
 					map = realloc(map, idx + 1);
 					if (!map)
-						errx(2, "map realloc");
+						ksft_exit_fail_msg("map realloc\n");
 					memset(map + map_len, 0, idx + 1 - map_len);
 					map_len = idx + 1;
 				}
@@ -114,17 +120,19 @@ int main(int argc, char **argv)
 
 			/* split transhuge page, keep last page */
 			if (madvise(p, HPAGE_SIZE - psize(), MADV_DONTNEED))
-				err(2, "MADV_DONTNEED");
+				ksft_exit_fail_msg("MADV_DONTNEED");
 		}
 		clock_gettime(CLOCK_MONOTONIC, &b);
 		s = b.tv_sec - a.tv_sec + (b.tv_nsec - a.tv_nsec) / 1000000000.;
 
-		warnx("%.3f s/loop, %.3f ms/page, %10.3f MiB/s\t"
-		      "%4d succeed, %4d failed, %4d different pages",
-		      s, s * 1000 / (len >> HPAGE_SHIFT), len / s / (1 << 20),
-		      nr_succeed, nr_failed, nr_pages);
+		ksft_print_msg("%.3f s/loop, %.3f ms/page, %10.3f MiB/s\t"
+			       "%4d succeed, %4d failed, %4d different pages\n",
+			       s, s * 1000 / (len >> HPAGE_SHIFT), len / s / (1 << 20),
+			       nr_succeed, nr_failed, nr_pages);
 
-		if (duration > 0 && b.tv_sec - start.tv_sec >= duration)
-			return 0;
+		if (duration > 0 && b.tv_sec - start.tv_sec >= duration) {
+			ksft_test_result_pass("Completed\n");
+			ksft_finished();
+		}
 	}
 }
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 05736c615734f..5a62530da3b56 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -232,17 +232,17 @@ int64_t allocate_transhuge(void *ptr, int pagemap_fd)
 	if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
 		 MAP_FIXED | MAP_ANONYMOUS |
 		 MAP_NORESERVE | MAP_PRIVATE, -1, 0) != ptr)
-		errx(2, "mmap transhuge");
+		ksft_exit_fail_msg("mmap transhuge\n");
 
 	if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
-		err(2, "MADV_HUGEPAGE");
+		ksft_exit_fail_msg("MADV_HUGEPAGE\n");
 
 	/* allocate transparent huge page */
 	*(volatile void **)ptr = ptr;
 
 	if (pread(pagemap_fd, ent, sizeof(ent),
 		  (uintptr_t)ptr >> (pshift() - 3)) != sizeof(ent))
-		err(2, "read pagemap");
+		ksft_exit_fail_msg("read pagemap\n");
 
 	if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
 	    PAGEMAP_PFN(ent[0]) + 1 == PAGEMAP_PFN(ent[1]) &&
-- 
2.42.0


