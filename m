Return-Path: <linux-kselftest+bounces-4005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076B3846EEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 12:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A501F2583E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51A13E206;
	Fri,  2 Feb 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MhaCkmdq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246E1386BB;
	Fri,  2 Feb 2024 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873494; cv=none; b=MQwVHmmKJq3LqEfrIqCXTf76M8AbYlNGUDlV6G0y4HYyiTWqDCquFyiI42Gsl0zGJjjVAAMB3unSiQ5MyVgmk4YKmsrDjv7Eeo69L46yLdOrcyKY+2lzy57JhGBNjQluDeIP/0DlmgZpWP4gHQWQ99Tqj1cRdOt5s+oMji4pImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873494; c=relaxed/simple;
	bh=C1jyyNN3WoASzPdbjbyMPpmrKLB566vijGdtqZFTW+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADY+7lflgrMmVmiJGBKjEKAtua/TYOlv+JEiY1PYU82W1tKkECrQiDdmFbOSjpk0+j6FGy/ZkfdjqagkhCG1waqXqNJcG540LEDsYJWWa5wPoP2HnayRZH5g/BvisEvqbyZ2oO6mPFZBMC6uFE4D3xgfzRILGi0aNAjoUDpSxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MhaCkmdq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706873491;
	bh=C1jyyNN3WoASzPdbjbyMPpmrKLB566vijGdtqZFTW+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhaCkmdqlAPaMKIWzcOoFyg1Zay9BqMS0mFEeyAchaqMGVRG21jicoefi69wIVvWn
	 w3JpGvqZm7Bs0vXUH/kuKTycmoy/jDkHf+GcvXomLhf8xM/ki0N8S240OKn0/E8v8H
	 TOjJZvOUb1Gn1X6HPMZ+PSilecNhsLUSEYIhdyTsulpavA6Adq/1bYxSTUK2x7pJn5
	 SyjFrMVD4dmSCFWTu/WSHV3ZNJ00DTUEQhj2hQuOaRYFDwDYO0SxT+uMWsChFxJqh3
	 a/3XyISDLqoVfXfj06X4XNUoX2fEIWQPVNMxBtsWYtmSZsEjleU/TkN0kcZ69/le/f
	 14eATrM7mh5zA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D30C13782093;
	Fri,  2 Feb 2024 11:31:29 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/12] selftests/mm: map_fixed_noreplace: conform test to TAP format output
Date: Fri,  2 Feb 2024 16:31:08 +0500
Message-ID: <20240202113119.2047740-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240202113119.2047740-1-usama.anjum@collabora.com>
References: <20240202113119.2047740-1-usama.anjum@collabora.com>
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


