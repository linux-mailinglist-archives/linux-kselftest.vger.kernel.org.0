Return-Path: <linux-kselftest+bounces-3834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED6A844142
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4D3B23428
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B921880C0E;
	Wed, 31 Jan 2024 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hVRTdRod"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3FD7F48F;
	Wed, 31 Jan 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709923; cv=none; b=AgbG7nQ91giiyj7zVRkf6FTD7FfKdk5qgKB7+cf+jX8IeU0sg+df2/lXe0eT5LjFJ4tO8K0W37VFi5MseAsDBLD+qH2YZatBqyfx0/walNBU2RqZiZ1keoscvoe3wEkkpJX2Uiwf3UA9ByNUQvMj5rtoc49vmwaqXXXJoP1yKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709923; c=relaxed/simple;
	bh=C1jyyNN3WoASzPdbjbyMPpmrKLB566vijGdtqZFTW+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dalnMkLyLLqbYw7lMfobP1sswPtPsXeYy6hEup2fo4LI+0rcyWK5TrcVxz1epI7ICpbgRgph0LMOQUc1oRr8m6KwT/p84ZXqwZK32PMPSi6+XedQb0M2dbrsAeSKhKki4ovSpo9DWR6sXqeYfWNETBx4PbQcl8IgiAKz4G7datw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hVRTdRod; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706709916;
	bh=C1jyyNN3WoASzPdbjbyMPpmrKLB566vijGdtqZFTW+0=;
	h=From:To:Cc:Subject:Date:From;
	b=hVRTdRodufiiXRyUTw9piPgw/oM92aLsJkDJGNDDTsunq7gJopZrnj+e3uqM09Ifw
	 k0w0zc9ThSlxrYjasOBccPbbcGyeFCFKGuOcVC5KieK9Sp4aGF33D6MfyXTLlTrZyb
	 dhTHrGWeb4FM7XQNVxruHPijt+Fkg/nEm98o5ebb8XFF8Qt/cXkO4XSlC3ndGxv0S2
	 oqaGai6ttvc6I60U/yqwE/TZ0j0LPMR46ap6XGlfAdWeChx84aXANCMFs6mYsw70DT
	 FjeAPcOuZmZ8KNZfI5GISi+BwMX4fEXehcftq/U7JIgfeAVesXIjXx8CTEtZ+dnC9a
	 BsGRGSxhSpIMg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8243E3781FCF;
	Wed, 31 Jan 2024 14:05:14 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] selftests/mm: map_fixed_noreplace: conform test to TAP format output
Date: Wed, 31 Jan 2024 19:05:11 +0500
Message-ID: <20240131140528.320252-1-usama.anjum@collabora.com>
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
While at it, convert commenting style from // to /**/.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../selftests/mm/map_fixed_noreplace.c        | 96 ++++++-------------
 1 file changed, 31 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/mm/map_fixed_noreplace.c b/tools/testing/selftests/mm/map_fixed_noreplace.c
index 598159f3df1f2..b74813fdc9514 100644
--- a/tools/testing/selftests/mm/map_fixed_noreplace.c
+++ b/tools/testing/selftests/mm/map_fixed_noreplace.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include "../kselftest.h"
 
 static void dump_maps(void)
 {
@@ -28,15 +29,12 @@ static unsigned long find_base_addr(unsigned long size)
 
 	flags = MAP_PRIVATE | MAP_ANONYMOUS;
 	addr = mmap(NULL, size, PROT_NONE, flags, -1, 0);
-	if (addr == MAP_FAILED) {
-		printf("Error: couldn't map the space we need for the test\n");
-		return 0;
-	}
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("Error: couldn't map the space we need for the test\n");
+
+	if (munmap(addr, size) != 0)
+		ksft_exit_fail_msg("Error: munmap failed\n");
 
-	if (munmap(addr, size) != 0) {
-		printf("Error: couldn't map the space we need for the test\n");
-		return 0;
-	}
 	return (unsigned long)addr;
 }
 
@@ -46,51 +44,39 @@ int main(void)
 	unsigned long flags, addr, size, page_size;
 	char *p;
 
+	ksft_print_header();
+	ksft_set_plan(9);
+
 	page_size = sysconf(_SC_PAGE_SIZE);
 
-	//let's find a base addr that is free before we start the tests
+	/* let's find a base addr that is free before we start the tests */
 	size = 5 * page_size;
 	base_addr = find_base_addr(size);
-	if (!base_addr) {
-		printf("Error: couldn't map the space we need for the test\n");
-		return 1;
-	}
 
 	flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE;
 
-	// Check we can map all the areas we need below
-	errno = 0;
+	/* Check we can map all the areas we need below */
 	addr = base_addr;
 	size = 5 * page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
-
-	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
-
 	if (p == MAP_FAILED) {
 		dump_maps();
-		printf("Error: couldn't map the space we need for the test\n");
-		return 1;
+		ksft_exit_fail_msg("Error: couldn't map the space we need for the test\n");
 	}
-
-	errno = 0;
 	if (munmap((void *)addr, 5 * page_size) != 0) {
 		dump_maps();
-		printf("Error: munmap failed!?\n");
-		return 1;
+		ksft_exit_fail_msg("Error: munmap failed!?\n");
 	}
-	printf("unmap() successful\n");
+	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
-	errno = 0;
 	addr = base_addr + page_size;
 	size = 3 * page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
-	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
-
 	if (p == MAP_FAILED) {
 		dump_maps();
-		printf("Error: first mmap() failed unexpectedly\n");
-		return 1;
+		ksft_exit_fail_msg("Error: first mmap() failed unexpectedly\n");
 	}
+	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
 	/*
 	 * Exact same mapping again:
@@ -100,17 +86,14 @@ int main(void)
 	 *     +3 | mapped | new
 	 *     +4 |  free  | new
 	 */
-	errno = 0;
 	addr = base_addr;
 	size = 5 * page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
-	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
-
 	if (p != MAP_FAILED) {
 		dump_maps();
-		printf("Error:1: mmap() succeeded when it shouldn't have\n");
-		return 1;
+		ksft_exit_fail_msg("Error:1: mmap() succeeded when it shouldn't have\n");
 	}
+	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
 	/*
 	 * Second mapping contained within first:
@@ -121,17 +104,14 @@ int main(void)
 	 *     +3 | mapped |
 	 *     +4 |  free  |
 	 */
-	errno = 0;
 	addr = base_addr + (2 * page_size);
 	size = page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
-	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
-
 	if (p != MAP_FAILED) {
 		dump_maps();
-		printf("Error:2: mmap() succeeded when it shouldn't have\n");
-		return 1;
+		ksft_exit_fail_msg("Error:2: mmap() succeeded when it shouldn't have\n");
 	}
+	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
 	/*
 	 * Overlap end of existing mapping:
@@ -141,17 +121,14 @@ int main(void)
 	 *     +3 | mapped | new
 	 *     +4 |  free  | new
 	 */
-	errno = 0;
 	addr = base_addr + (3 * page_size);
 	size = 2 * page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
-	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
-
 	if (p != MAP_FAILED) {
 		dump_maps();
-		printf("Error:3: mmap() succeeded when it shouldn't have\n");
-		return 1;
+		ksft_exit_fail_msg("Error:3: mmap() succeeded when it shouldn't have\n");
 	}
+	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
 	/*
 	 * Overlap start of existing mapping:
@@ -161,17 +138,14 @@ int main(void)
 	 *     +3 | mapped |
 	 *     +4 |  free  |
 	 */
-	errno = 0;
 	addr = base_addr;
 	size = 2 * page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
-	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
-
 	if (p != MAP_FAILED) {
 		dump_maps();
-		printf("Error:4: mmap() succeeded when it shouldn't have\n");
-		return 1;
+		ksft_exit_fail_msg("Error:4: mmap() succeeded when it shouldn't have\n");
 	}
+	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
 	/*
 	 * Adjacent to start of existing mapping:
@@ -181,17 +155,14 @@ int main(void)
 	 *     +3 | mapped |
 	 *     +4 |  free  |
 	 */
-	errno = 0;
 	addr = base_addr;
 	size = page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
-	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
-
 	if (p == MAP_FAILED) {
 		dump_maps();
-		printf("Error:5: mmap() failed when it shouldn't have\n");
-		return 1;
+		ksft_exit_fail_msg("Error:5: mmap() failed when it shouldn't have\n");
 	}
+	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
 	/*
 	 * Adjacent to end of existing mapping:
@@ -201,27 +172,22 @@ int main(void)
 	 *     +3 | mapped |
 	 *     +4 |  free  |  new
 	 */
-	errno = 0;
 	addr = base_addr + (4 * page_size);
 	size = page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
-	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
-
 	if (p == MAP_FAILED) {
 		dump_maps();
-		printf("Error:6: mmap() failed when it shouldn't have\n");
-		return 1;
+		ksft_exit_fail_msg("Error:6: mmap() failed when it shouldn't have\n");
 	}
+	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
 
 	addr = base_addr;
 	size = 5 * page_size;
 	if (munmap((void *)addr, size) != 0) {
 		dump_maps();
-		printf("Error: munmap failed!?\n");
-		return 1;
+		ksft_exit_fail_msg("Error: munmap failed!?\n");
 	}
-	printf("unmap() successful\n");
+	ksft_test_result_pass("Base Address unmap() successful\n");
 
-	printf("OK\n");
-	return 0;
+	ksft_finished();
 }
-- 
2.42.0


