Return-Path: <linux-kselftest+bounces-4009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8571846EF6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 12:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9043D28B5C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E128140767;
	Fri,  2 Feb 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VmnKlYaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E438D13F00E;
	Fri,  2 Feb 2024 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873503; cv=none; b=tDVl9yeSF8s3uF6ldczdJ5jf0mkPWxzOUR06Zn2F7Kimctikl1BBrckN4dO+fytfcPWSV6FOVXKjp7HdwHsKolHmtG7Y02I5BrVXrGM+6crYtQySYfs948PWWTuOZYN7Kdu+ATwTA+X0zMJYD1R9u7XCXP3RD17CIXVMUS7l1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873503; c=relaxed/simple;
	bh=/wNqMM3jESWbi0B8UMhy6VskAZTZSdGLdkXtnfOduUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaWlFc7voXLy4TjN0VDbm3WB8tsKJF5+7ceOSwn94RSyMvR86gKGBuLmgVimUFzYFr7l4GRFZGnv+rN8q33jypIacTIueMCOJKBR+TPutW0HKVJ3ev5terahDyjGztM3GCgA/YAlicYuiTzSogZ9Us/fHew1qybdWZZK9dqLK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VmnKlYaa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706873499;
	bh=/wNqMM3jESWbi0B8UMhy6VskAZTZSdGLdkXtnfOduUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VmnKlYaaN7iHjJyHdVxs6DAU1PbRTxyuTN7EWKAIl0uUMbaTO9FgrADeAPJhFntqk
	 ZiTooyxO4xDiUBIpU3z46hL6WG0TwXzV+tjPKQmuh4oY7K42JqWYn3HQKZtlNh40ci
	 M0v2jXbp8Jw+hMmBI+WKfHZT3vdQZEMlrcNJEPaMzOQYcmjS0SN66Bc5NzorZmdlD9
	 Rbjp9HJCVfzriK2e6VFkm7+VwavbcQY9K0VrR+LeoPD4A7x6icfivUywMd9gItOYgs
	 aEmm4lNhJiLzKmi0cFzFQ4ROjv3052tc/WcXLWGkp7rNNa2l6gZ+Z3FD1ldyD1pNFN
	 G1No0kSnuF9yQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B3B523782099;
	Fri,  2 Feb 2024 11:31:37 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/12] selftests/mm: mlock2-tests: conform test to TAP format output
Date: Fri,  2 Feb 2024 16:31:12 +0500
Message-ID: <20240202113119.2047740-6-usama.anjum@collabora.com>
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
I've done some cleanups as well.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/mlock2-tests.c | 282 +++++++++-------------
 tools/testing/selftests/mm/mlock2.h       |  11 +-
 2 files changed, 118 insertions(+), 175 deletions(-)

diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
index 80cddc0de2061..26f744188ad0c 100644
--- a/tools/testing/selftests/mm/mlock2-tests.c
+++ b/tools/testing/selftests/mm/mlock2-tests.c
@@ -7,9 +7,8 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <stdbool.h>
-#include "mlock2.h"
-
 #include "../kselftest.h"
+#include "mlock2.h"
 
 struct vm_boundaries {
 	unsigned long start;
@@ -40,14 +39,14 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
 	while(fgets(line, 1024, file)) {
 		end_addr = strchr(line, '-');
 		if (!end_addr) {
-			printf("cannot parse /proc/self/maps\n");
+			ksft_print_msg("cannot parse /proc/self/maps\n");
 			goto out;
 		}
 		*end_addr = '\0';
 		end_addr++;
 		stop = strchr(end_addr, ' ');
 		if (!stop) {
-			printf("cannot parse /proc/self/maps\n");
+			ksft_print_msg("cannot parse /proc/self/maps\n");
 			goto out;
 		}
 
@@ -78,7 +77,7 @@ static bool is_vmflag_set(unsigned long addr, const char *vmflag)
 
 	smaps = seek_to_smaps_entry(addr);
 	if (!smaps) {
-		printf("Unable to parse /proc/self/smaps\n");
+		ksft_print_msg("Unable to parse /proc/self/smaps\n");
 		goto out;
 	}
 
@@ -115,7 +114,7 @@ static unsigned long get_value_for_name(unsigned long addr, const char *name)
 
 	smaps = seek_to_smaps_entry(addr);
 	if (!smaps) {
-		printf("Unable to parse /proc/self/smaps\n");
+		ksft_print_msg("Unable to parse /proc/self/smaps\n");
 		goto out;
 	}
 
@@ -129,7 +128,7 @@ static unsigned long get_value_for_name(unsigned long addr, const char *name)
 
 		value_ptr = line + strlen(name);
 		if (sscanf(value_ptr, "%lu kB", &value) < 1) {
-			printf("Unable to parse smaps entry for Size\n");
+			ksft_print_msg("Unable to parse smaps entry for Size\n");
 			goto out;
 		}
 		break;
@@ -180,57 +179,45 @@ static int lock_check(unsigned long addr)
 static int unlock_lock_check(char *map)
 {
 	if (is_vmflag_set((unsigned long)map, LOCKED)) {
-		printf("VMA flag %s is present on page 1 after unlock\n", LOCKED);
+		ksft_print_msg("VMA flag %s is present on page 1 after unlock\n", LOCKED);
 		return 1;
 	}
 
 	return 0;
 }
 
-static int test_mlock_lock()
+static void test_mlock_lock(void)
 {
 	char *map;
-	int ret = 1;
 	unsigned long page_size = getpagesize();
 
 	map = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
 		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (map == MAP_FAILED) {
-		perror("test_mlock_locked mmap");
-		goto out;
-	}
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap error: %s", strerror(errno));
 
 	if (mlock2_(map, 2 * page_size, 0)) {
-		if (errno == ENOSYS) {
-			printf("Cannot call new mlock family, skipping test\n");
-			_exit(KSFT_SKIP);
-		}
-		perror("mlock2(0)");
-		goto unmap;
+		munmap(map, 2 * page_size);
+		ksft_exit_fail_msg("mlock2(0): %s\n", strerror(errno));
 	}
 
-	if (!lock_check((unsigned long)map))
-		goto unmap;
+	ksft_test_result(lock_check((unsigned long)map), "%s: Locked\n", __func__);
 
 	/* Now unlock and recheck attributes */
 	if (munlock(map, 2 * page_size)) {
-		perror("munlock()");
-		goto unmap;
+		munmap(map, 2 * page_size);
+		ksft_exit_fail_msg("munlock(): %s\n", strerror(errno));
 	}
 
-	ret = unlock_lock_check(map);
-
-unmap:
+	ksft_test_result(!unlock_lock_check(map), "%s: Locked\n", __func__);
 	munmap(map, 2 * page_size);
-out:
-	return ret;
 }
 
 static int onfault_check(char *map)
 {
 	*map = 'a';
 	if (!is_vma_lock_on_fault((unsigned long)map)) {
-		printf("VMA is not marked for lock on fault\n");
+		ksft_print_msg("VMA is not marked for lock on fault\n");
 		return 1;
 	}
 
@@ -243,172 +230,131 @@ static int unlock_onfault_check(char *map)
 
 	if (is_vma_lock_on_fault((unsigned long)map) ||
 	    is_vma_lock_on_fault((unsigned long)map + page_size)) {
-		printf("VMA is still lock on fault after unlock\n");
+		ksft_print_msg("VMA is still lock on fault after unlock\n");
 		return 1;
 	}
 
 	return 0;
 }
 
-static int test_mlock_onfault()
+static void test_mlock_onfault(void)
 {
 	char *map;
-	int ret = 1;
 	unsigned long page_size = getpagesize();
 
 	map = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
 		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (map == MAP_FAILED) {
-		perror("test_mlock_locked mmap");
-		goto out;
-	}
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap error: %s", strerror(errno));
 
 	if (mlock2_(map, 2 * page_size, MLOCK_ONFAULT)) {
-		if (errno == ENOSYS) {
-			printf("Cannot call new mlock family, skipping test\n");
-			_exit(KSFT_SKIP);
-		}
-		perror("mlock2(MLOCK_ONFAULT)");
-		goto unmap;
+		munmap(map, 2 * page_size);
+		ksft_exit_fail_msg("mlock2(MLOCK_ONFAULT): %s\n", strerror(errno));
 	}
 
-	if (onfault_check(map))
-		goto unmap;
+	ksft_test_result(!onfault_check(map), "%s: VMA marked for lock on fault\n", __func__);
 
 	/* Now unlock and recheck attributes */
 	if (munlock(map, 2 * page_size)) {
-		if (errno == ENOSYS) {
-			printf("Cannot call new mlock family, skipping test\n");
-			_exit(KSFT_SKIP);
-		}
-		perror("munlock()");
-		goto unmap;
+		munmap(map, 2 * page_size);
+		ksft_exit_fail_msg("munlock(): %s\n", strerror(errno));
 	}
 
-	ret = unlock_onfault_check(map);
-unmap:
+	ksft_test_result(!unlock_onfault_check(map), "VMA open lock after fault\n");
 	munmap(map, 2 * page_size);
-out:
-	return ret;
 }
 
-static int test_lock_onfault_of_present()
+static void test_lock_onfault_of_present(void)
 {
 	char *map;
-	int ret = 1;
 	unsigned long page_size = getpagesize();
 
 	map = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
 		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (map == MAP_FAILED) {
-		perror("test_mlock_locked mmap");
-		goto out;
-	}
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap error: %s", strerror(errno));
 
 	*map = 'a';
 
 	if (mlock2_(map, 2 * page_size, MLOCK_ONFAULT)) {
-		if (errno == ENOSYS) {
-			printf("Cannot call new mlock family, skipping test\n");
-			_exit(KSFT_SKIP);
-		}
-		perror("mlock2(MLOCK_ONFAULT)");
-		goto unmap;
+		munmap(map, 2 * page_size);
+		ksft_test_result_fail("mlock2(MLOCK_ONFAULT) error: %s", strerror(errno));
 	}
 
-	if (!is_vma_lock_on_fault((unsigned long)map) ||
-	    !is_vma_lock_on_fault((unsigned long)map + page_size)) {
-		printf("VMA with present pages is not marked lock on fault\n");
-		goto unmap;
-	}
-	ret = 0;
-unmap:
+	ksft_test_result(is_vma_lock_on_fault((unsigned long)map) ||
+			 is_vma_lock_on_fault((unsigned long)map + page_size),
+			 "VMA with present pages is not marked lock on fault\n");
 	munmap(map, 2 * page_size);
-out:
-	return ret;
 }
 
-static int test_munlockall()
+static void test_munlockall0(void)
 {
 	char *map;
-	int ret = 1;
 	unsigned long page_size = getpagesize();
 
 	map = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
 		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-
-	if (map == MAP_FAILED) {
-		perror("test_munlockall mmap");
-		goto out;
-	}
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap error: %s\n", strerror(errno));
 
 	if (mlockall(MCL_CURRENT)) {
-		perror("mlockall(MCL_CURRENT)");
-		goto out;
+		munmap(map, 2 * page_size);
+		ksft_exit_fail_msg("mlockall(MCL_CURRENT): %s\n", strerror(errno));
 	}
 
-	if (!lock_check((unsigned long)map))
-		goto unmap;
+	ksft_test_result(lock_check((unsigned long)map), "%s: Locked memory area\n", __func__);
 
 	if (munlockall()) {
-		perror("munlockall()");
-		goto unmap;
+		munmap(map, 2 * page_size);
+		ksft_exit_fail_msg("munlockall(): %s\n", strerror(errno));
 	}
 
-	if (unlock_lock_check(map))
-		goto unmap;
-
+	ksft_test_result(!unlock_lock_check(map), "%s: No locked memory\n", __func__);
 	munmap(map, 2 * page_size);
+}
+
+static void test_munlockall1(void)
+{
+	char *map;
+	unsigned long page_size = getpagesize();
 
 	map = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
 		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-
-	if (map == MAP_FAILED) {
-		perror("test_munlockall second mmap");
-		goto out;
-	}
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap error: %s", strerror(errno));
 
 	if (mlockall(MCL_CURRENT | MCL_ONFAULT)) {
-		perror("mlockall(MCL_CURRENT | MCL_ONFAULT)");
-		goto unmap;
+		munmap(map, 2 * page_size);
+		ksft_exit_fail_msg("mlockall(MCL_CURRENT | MCL_ONFAULT): %s\n", strerror(errno));
 	}
 
-	if (onfault_check(map))
-		goto unmap;
+	ksft_test_result(!onfault_check(map), "%s: VMA marked for lock on fault\n", __func__);
 
 	if (munlockall()) {
-		perror("munlockall()");
-		goto unmap;
+		munmap(map, 2 * page_size);
+		ksft_exit_fail_msg("munlockall(): %s\n", strerror(errno));
 	}
 
-	if (unlock_onfault_check(map))
-		goto unmap;
+	ksft_test_result(!unlock_onfault_check(map), "%s: Unlocked\n", __func__);
 
 	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
-		perror("mlockall(MCL_CURRENT | MCL_FUTURE)");
-		goto out;
+		munmap(map, 2 * page_size);
+		ksft_exit_fail_msg("mlockall(MCL_CURRENT | MCL_FUTURE): %s\n", strerror(errno));
 	}
 
-	if (!lock_check((unsigned long)map))
-		goto unmap;
+	ksft_test_result(lock_check((unsigned long)map), "%s: Locked\n", __func__);
 
 	if (munlockall()) {
-		perror("munlockall()");
-		goto unmap;
+		munmap(map, 2 * page_size);
+		ksft_exit_fail_msg("munlockall() %s\n", strerror(errno));
 	}
 
-	ret = unlock_lock_check(map);
-
-unmap:
+	ksft_test_result(!unlock_lock_check(map), "%s: No locked memory\n", __func__);
 	munmap(map, 2 * page_size);
-out:
-	munlockall();
-	return ret;
 }
 
-static int test_vma_management(bool call_mlock)
+static void test_vma_management(bool call_mlock)
 {
-	int ret = 1;
 	void *map;
 	unsigned long page_size = getpagesize();
 	struct vm_boundaries page1;
@@ -417,25 +363,19 @@ static int test_vma_management(bool call_mlock)
 
 	map = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
 		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (map == MAP_FAILED) {
-		perror("mmap()");
-		return ret;
-	}
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap error: %s", strerror(errno));
 
 	if (call_mlock && mlock2_(map, 3 * page_size, MLOCK_ONFAULT)) {
-		if (errno == ENOSYS) {
-			printf("Cannot call new mlock family, skipping test\n");
-			_exit(KSFT_SKIP);
-		}
-		perror("mlock(ONFAULT)\n");
-		goto out;
+		munmap(map, 3 * page_size);
+		ksft_test_result_fail("mlock error: %s", strerror(errno));
 	}
 
 	if (get_vm_area((unsigned long)map, &page1) ||
 	    get_vm_area((unsigned long)map + page_size, &page2) ||
 	    get_vm_area((unsigned long)map + page_size * 2, &page3)) {
-		printf("couldn't find mapping in /proc/self/maps\n");
-		goto out;
+		munmap(map, 3 * page_size);
+		ksft_test_result_fail("couldn't find mapping in /proc/self/maps");
 	}
 
 	/*
@@ -444,76 +384,86 @@ static int test_vma_management(bool call_mlock)
 	 * not a failure)
 	 */
 	if (page1.start != page2.start || page2.start != page3.start) {
-		printf("VMAs are not merged to start, aborting test\n");
-		ret = 0;
-		goto out;
+		munmap(map, 3 * page_size);
+		ksft_test_result_fail("VMAs are not merged to start, aborting test");
 	}
 
 	if (munlock(map + page_size, page_size)) {
-		perror("munlock()");
-		goto out;
+		munmap(map, 3 * page_size);
+		ksft_test_result_fail("munlock(): %s", strerror(errno));
 	}
 
 	if (get_vm_area((unsigned long)map, &page1) ||
 	    get_vm_area((unsigned long)map + page_size, &page2) ||
 	    get_vm_area((unsigned long)map + page_size * 2, &page3)) {
-		printf("couldn't find mapping in /proc/self/maps\n");
-		goto out;
+		munmap(map, 3 * page_size);
+		ksft_test_result_fail("couldn't find mapping in /proc/self/maps");
 	}
 
 	/* All three VMAs should be different */
 	if (page1.start == page2.start || page2.start == page3.start) {
-		printf("failed to split VMA for munlock\n");
-		goto out;
+		munmap(map, 3 * page_size);
+		ksft_test_result_fail("failed to split VMA for munlock");
 	}
 
 	/* Now unlock the first and third page and check the VMAs again */
 	if (munlock(map, page_size * 3)) {
-		perror("munlock()");
-		goto out;
+		munmap(map, 3 * page_size);
+		ksft_test_result_fail("munlock(): %s", strerror(errno));
 	}
 
 	if (get_vm_area((unsigned long)map, &page1) ||
 	    get_vm_area((unsigned long)map + page_size, &page2) ||
 	    get_vm_area((unsigned long)map + page_size * 2, &page3)) {
-		printf("couldn't find mapping in /proc/self/maps\n");
-		goto out;
+		munmap(map, 3 * page_size);
+		ksft_test_result_fail("couldn't find mapping in /proc/self/maps");
 	}
 
 	/* Now all three VMAs should be the same */
 	if (page1.start != page2.start || page2.start != page3.start) {
-		printf("failed to merge VMAs after munlock\n");
-		goto out;
+		munmap(map, 3 * page_size);
+		ksft_test_result_fail("failed to merge VMAs after munlock");
 	}
 
-	ret = 0;
-out:
+	ksft_test_result_pass("%s call_mlock %d\n", __func__, call_mlock);
 	munmap(map, 3 * page_size);
-	return ret;
 }
 
-static int test_mlockall(int (test_function)(bool call_mlock))
+static void test_mlockall(void)
 {
-	int ret = 1;
+	if (mlockall(MCL_CURRENT | MCL_ONFAULT | MCL_FUTURE))
+		ksft_exit_fail_msg("mlockall failed: %s\n", strerror(errno));
 
-	if (mlockall(MCL_CURRENT | MCL_ONFAULT | MCL_FUTURE)) {
-		perror("mlockall");
-		return ret;
-	}
-
-	ret = test_function(false);
+	test_vma_management(false);
 	munlockall();
-	return ret;
 }
 
 int main(int argc, char **argv)
 {
-	int ret = 0;
-	ret += test_mlock_lock();
-	ret += test_mlock_onfault();
-	ret += test_munlockall();
-	ret += test_lock_onfault_of_present();
-	ret += test_vma_management(true);
-	ret += test_mlockall(test_vma_management);
-	return ret;
+	int ret, size = 3 * getpagesize();
+	void *map;
+
+	ksft_print_header();
+
+	map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap error: %s", strerror(errno));
+
+	ret = mlock2_(map, size, MLOCK_ONFAULT);
+	if (ret && errno == ENOSYS)
+		ksft_finished();
+
+	munmap(map, size);
+
+	ksft_set_plan(13);
+
+	test_mlock_lock();
+	test_mlock_onfault();
+	test_munlockall0();
+	test_munlockall1();
+	test_lock_onfault_of_present();
+	test_vma_management(true);
+	test_mlockall();
+
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/mm/mlock2.h b/tools/testing/selftests/mm/mlock2.h
index 8e02991b313c8..4417eaa5cfb78 100644
--- a/tools/testing/selftests/mm/mlock2.h
+++ b/tools/testing/selftests/mm/mlock2.h
@@ -6,12 +6,7 @@
 
 static int mlock2_(void *start, size_t len, int flags)
 {
-#ifdef __NR_mlock2
 	return syscall(__NR_mlock2, start, len, flags);
-#else
-	errno = ENOSYS;
-	return -1;
-#endif
 }
 
 static FILE *seek_to_smaps_entry(unsigned long addr)
@@ -27,10 +22,8 @@ static FILE *seek_to_smaps_entry(unsigned long addr)
 	char path[BUFSIZ];
 
 	file = fopen("/proc/self/smaps", "r");
-	if (!file) {
-		perror("fopen smaps");
-		_exit(1);
-	}
+	if (!file)
+		ksft_exit_fail_msg("fopen smaps: %s\n", strerror(errno));
 
 	while (getline(&line, &size, file) > 0) {
 		if (sscanf(line, "%lx-%lx %s %lx %s %lu %s\n",
-- 
2.42.0


