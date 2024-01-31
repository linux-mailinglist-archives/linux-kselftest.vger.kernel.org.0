Return-Path: <linux-kselftest+bounces-3836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF4F84414A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33C6B24FB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3478289D;
	Wed, 31 Jan 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MACRpNQR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EEB82869;
	Wed, 31 Jan 2024 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709926; cv=none; b=Dw/uLHoqpsqvaY5SBG7G8h2BdKUohXP5Q6AfspuOl6jLX2omiUSLKnpytXVwJU3pkfT5w2/N45kQSEu0squDISi242QGD4SjQk0rjRNA7cHOpiEcrNsy/eGMvHX9T71jFIS1mJxGIT9/THxv0w33RamSj+IzATQde+Zv/k9CaDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709926; c=relaxed/simple;
	bh=AYYPiG5/eQFpT9F2zXPDgcKcsgIGjoY5wyEFVeBzakA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3mYtxtEW4AiB3S7tJjrH4r8dGGuXmlSCUK4nB5gtsA1n4VI3fcIL319vMtD7mmXbl6TQKYiD+O5PtqHoRyZEuDJD6TeuK8MyluJP2HlNBkrr6MC6iMedsaXcDry64ZYdkmUpUF5CqE7L0b6fAymacsrQwuN9kheOk1RGrZzjFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MACRpNQR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706709923;
	bh=AYYPiG5/eQFpT9F2zXPDgcKcsgIGjoY5wyEFVeBzakA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MACRpNQRni2hxNtFtl0XFeCH9MObYnCAvaART/lNidK151skysiHjPaR4MZboLENO
	 kSiZzJkI2kq3aACjopN5pOvZ07EYablIQQ8ZbPv1J5rVeVKClSoDDoqqabEv8hKQNe
	 tJwrEM+7F7Aow/nmgzl5c2D3G5Vk03PKnxPylQsEqm2R0DUzvZfxEfpuTFzzHWJ9iX
	 4p3Zl8ns1zYYh5d93xBE6QgQRca+dM+UixWexBKSRzQp+LckUG8PPvV0d7o3hSwCWe
	 GZ9zqxWUgp9pbf8g46q3WGpnY/14HJYTjCZUvXRjDDlQ8fyb8uf6B4d9/ixrxI9tXo
	 JHuSSK3zpAelQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9F8E23782084;
	Wed, 31 Jan 2024 14:05:21 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] selftests/mm: mlock-random-test: conform test to TAP format output
Date: Wed, 31 Jan 2024 19:05:14 +0500
Message-ID: <20240131140528.320252-4-usama.anjum@collabora.com>
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
 .../testing/selftests/mm/mlock-random-test.c  | 136 +++++++-----------
 1 file changed, 54 insertions(+), 82 deletions(-)

diff --git a/tools/testing/selftests/mm/mlock-random-test.c b/tools/testing/selftests/mm/mlock-random-test.c
index 1fba77df7f628..1cd80b0f76c33 100644
--- a/tools/testing/selftests/mm/mlock-random-test.c
+++ b/tools/testing/selftests/mm/mlock-random-test.c
@@ -13,6 +13,7 @@
 #include <sys/ipc.h>
 #include <sys/shm.h>
 #include <time.h>
+#include "../kselftest.h"
 #include "mlock2.h"
 
 #define CHUNK_UNIT (128 * 1024)
@@ -31,14 +32,14 @@ int set_cap_limits(rlim_t max)
 	new.rlim_cur = max;
 	new.rlim_max = max;
 	if (setrlimit(RLIMIT_MEMLOCK, &new)) {
-		perror("setrlimit() returns error\n");
+		ksft_perror("setrlimit() returns error\n");
 		return -1;
 	}
 
 	/* drop capabilities including CAP_IPC_LOCK */
 	if (cap_set_proc(cap)) {
-		perror("cap_set_proc() returns error\n");
-		return -2;
+		ksft_perror("cap_set_proc() returns error\n");
+		return -1;
 	}
 
 	return 0;
@@ -52,27 +53,24 @@ int get_proc_locked_vm_size(void)
 	unsigned long lock_size = 0;
 
 	f = fopen("/proc/self/status", "r");
-	if (!f) {
-		perror("fopen");
-		return -1;
-	}
+	if (!f)
+		ksft_exit_fail_msg("fopen: %s\n", strerror(errno));
 
 	while (fgets(line, 1024, f)) {
 		if (strstr(line, "VmLck")) {
 			ret = sscanf(line, "VmLck:\t%8lu kB", &lock_size);
 			if (ret <= 0) {
-				printf("sscanf() on VmLck error: %s: %d\n",
-						line, ret);
 				fclose(f);
-				return -1;
+				ksft_exit_fail_msg("sscanf() on VmLck error: %s: %d\n",
+						   line, ret);
 			}
 			fclose(f);
 			return (int)(lock_size << 10);
 		}
 	}
 
-	perror("cannot parse VmLck in /proc/self/status\n");
 	fclose(f);
+	ksft_exit_fail_msg("cannot parse VmLck in /proc/self/status: %s\n", strerror(errno));
 	return -1;
 }
 
@@ -91,10 +89,8 @@ int get_proc_page_size(unsigned long addr)
 	size_t size;
 
 	smaps = seek_to_smaps_entry(addr);
-	if (!smaps) {
-		printf("Unable to parse /proc/self/smaps\n");
-		return 0;
-	}
+	if (!smaps)
+		ksft_exit_fail_msg("Unable to parse /proc/self/smaps\n");
 
 	while (getline(&line, &size, smaps) > 0) {
 		if (!strstr(line, "MMUPageSize")) {
@@ -105,12 +101,9 @@ int get_proc_page_size(unsigned long addr)
 		}
 
 		/* found the MMUPageSize of this section */
-		if (sscanf(line, "MMUPageSize:    %8lu kB",
-					&mmupage_size) < 1) {
-			printf("Unable to parse smaps entry for Size:%s\n",
-					line);
-			break;
-		}
+		if (sscanf(line, "MMUPageSize:    %8lu kB", &mmupage_size) < 1)
+			ksft_exit_fail_msg("Unable to parse smaps entry for Size:%s\n",
+					   line);
 
 	}
 	free(line);
@@ -136,7 +129,7 @@ int get_proc_page_size(unsigned long addr)
  *    return value: 0 - success
  *    else: failure
  */
-int test_mlock_within_limit(char *p, int alloc_size)
+static void test_mlock_within_limit(char *p, int alloc_size)
 {
 	int i;
 	int ret = 0;
@@ -145,11 +138,9 @@ int test_mlock_within_limit(char *p, int alloc_size)
 	int page_size = 0;
 
 	getrlimit(RLIMIT_MEMLOCK, &cur);
-	if (cur.rlim_cur < alloc_size) {
-		printf("alloc_size[%d] < %u rlimit,lead to mlock failure\n",
-				alloc_size, (unsigned int)cur.rlim_cur);
-		return -1;
-	}
+	if (cur.rlim_cur < alloc_size)
+		ksft_exit_fail_msg("alloc_size[%d] < %u rlimit,lead to mlock failure\n",
+				   alloc_size, (unsigned int)cur.rlim_cur);
 
 	srand(time(NULL));
 	for (i = 0; i < TEST_LOOP; i++) {
@@ -169,13 +160,11 @@ int test_mlock_within_limit(char *p, int alloc_size)
 			ret = mlock2_(p + start_offset, lock_size,
 				       MLOCK_ONFAULT);
 
-		if (ret) {
-			printf("%s() failure at |%p(%d)| mlock:|%p(%d)|\n",
-					is_mlock ? "mlock" : "mlock2",
-					p, alloc_size,
-					p + start_offset, lock_size);
-			return ret;
-		}
+		if (ret)
+			ksft_exit_fail_msg("%s() failure at |%p(%d)| mlock:|%p(%d)|\n",
+					   is_mlock ? "mlock" : "mlock2",
+					   p, alloc_size,
+					   p + start_offset, lock_size);
 	}
 
 	/*
@@ -183,18 +172,12 @@ int test_mlock_within_limit(char *p, int alloc_size)
 	 */
 	locked_vm_size = get_proc_locked_vm_size();
 	page_size = get_proc_page_size((unsigned long)p);
-	if (page_size == 0) {
-		printf("cannot get proc MMUPageSize\n");
-		return -1;
-	}
 
-	if (locked_vm_size > PAGE_ALIGN(alloc_size, page_size) + page_size) {
-		printf("test_mlock_within_limit() left VmLck:%d on %d chunk\n",
-				locked_vm_size, alloc_size);
-		return -1;
-	}
+	if (locked_vm_size > PAGE_ALIGN(alloc_size, page_size) + page_size)
+		ksft_exit_fail_msg("%s left VmLck:%d on %d chunk\n",
+				   __func__, locked_vm_size, alloc_size);
 
-	return 0;
+	ksft_test_result_pass("%s\n", __func__);
 }
 
 
@@ -213,7 +196,7 @@ int test_mlock_within_limit(char *p, int alloc_size)
  *    return value: 0 - success
  *    else: failure
  */
-int test_mlock_outof_limit(char *p, int alloc_size)
+static void test_mlock_outof_limit(char *p, int alloc_size)
 {
 	int i;
 	int ret = 0;
@@ -221,11 +204,9 @@ int test_mlock_outof_limit(char *p, int alloc_size)
 	struct rlimit cur;
 
 	getrlimit(RLIMIT_MEMLOCK, &cur);
-	if (cur.rlim_cur >= alloc_size) {
-		printf("alloc_size[%d] >%u rlimit, violates test condition\n",
-				alloc_size, (unsigned int)cur.rlim_cur);
-		return -1;
-	}
+	if (cur.rlim_cur >= alloc_size)
+		ksft_exit_fail_msg("alloc_size[%d] >%u rlimit, violates test condition\n",
+				   alloc_size, (unsigned int)cur.rlim_cur);
 
 	old_locked_vm_size = get_proc_locked_vm_size();
 	srand(time(NULL));
@@ -240,56 +221,47 @@ int test_mlock_outof_limit(char *p, int alloc_size)
 		else
 			ret = mlock2_(p + start_offset, lock_size,
 					MLOCK_ONFAULT);
-		if (ret == 0) {
-			printf("%s() succeeds? on %p(%d) mlock%p(%d)\n",
-					is_mlock ? "mlock" : "mlock2",
-					p, alloc_size,
-					p + start_offset, lock_size);
-			return -1;
-		}
+		if (ret == 0)
+			ksft_exit_fail_msg("%s() succeeds? on %p(%d) mlock%p(%d)\n",
+					   is_mlock ? "mlock" : "mlock2",
+					   p, alloc_size, p + start_offset, lock_size);
 	}
 
 	locked_vm_size = get_proc_locked_vm_size();
-	if (locked_vm_size != old_locked_vm_size) {
-		printf("tests leads to new mlocked page: old[%d], new[%d]\n",
-				old_locked_vm_size,
-				locked_vm_size);
-		return -1;
-	}
+	if (locked_vm_size != old_locked_vm_size)
+		ksft_exit_fail_msg("tests leads to new mlocked page: old[%d], new[%d]\n",
+				   old_locked_vm_size,
+				   locked_vm_size);
 
-	return 0;
+	ksft_test_result_pass("%s\n", __func__);
 }
 
 int main(int argc, char **argv)
 {
 	char *p = NULL;
-	int ret = 0;
+
+	ksft_print_header();
 
 	if (set_cap_limits(MLOCK_RLIMIT_SIZE))
-		return -1;
+		ksft_finished();
+
+	ksft_set_plan(2);
 
 	p = malloc(MLOCK_WITHIN_LIMIT_SIZE);
-	if (p == NULL) {
-		perror("malloc() failure\n");
-		return -1;
-	}
-	ret = test_mlock_within_limit(p, MLOCK_WITHIN_LIMIT_SIZE);
-	if (ret)
-		return ret;
+	if (p == NULL)
+		ksft_exit_fail_msg("malloc() failure: %s\n", strerror(errno));
+
+	test_mlock_within_limit(p, MLOCK_WITHIN_LIMIT_SIZE);
 	munlock(p, MLOCK_WITHIN_LIMIT_SIZE);
 	free(p);
 
-
 	p = malloc(MLOCK_OUTOF_LIMIT_SIZE);
-	if (p == NULL) {
-		perror("malloc() failure\n");
-		return -1;
-	}
-	ret = test_mlock_outof_limit(p, MLOCK_OUTOF_LIMIT_SIZE);
-	if (ret)
-		return ret;
+	if (p == NULL)
+		ksft_exit_fail_msg("malloc() failure: %s\n", strerror(errno));
+
+	test_mlock_outof_limit(p, MLOCK_OUTOF_LIMIT_SIZE);
 	munlock(p, MLOCK_OUTOF_LIMIT_SIZE);
 	free(p);
 
-	return 0;
+	ksft_finished();
 }
-- 
2.42.0


