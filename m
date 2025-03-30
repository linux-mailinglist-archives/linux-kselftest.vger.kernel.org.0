Return-Path: <linux-kselftest+bounces-29923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF3AA759A9
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 12:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05C81888396
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 10:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD6E158DD8;
	Sun, 30 Mar 2025 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU//tgzO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62FB1C69D;
	Sun, 30 Mar 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743331729; cv=none; b=Yzz52YAZM0F4JnHqGw9oiaW/vytt/Gi/BPgy+e7QDaza1iRbs4DVpGXrgrNEuRPcaAEs9UZYguUogffFEnI6lH66BeC0F3xSOP/b6bdmAkBeOO/cS6OQxnpmHizcANGNwtbfztRxnQSe08Oe187J/qWGg5Va3vpGDCYQcRx94y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743331729; c=relaxed/simple;
	bh=43PJnVmDXlSkNIbZSfZ5nIH7lMoqhFoLvAaDmKLPNRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gxm9/GfE86wINPHDIGWJTksa7Yxdhtg0QLMgS9F4ECBtSPWNVmWF12QL7BeF8TkC/AD2cE/STWaoo8Xe6IjWYTH0CkUEB2wZDgFwelE+blkyal7pnTS5rV/KAFqbMixurxCoU4U/MVmz/ICfU3e7yLkCV4bBUJ7O8TC1WrYyKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU//tgzO; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso4668764a91.3;
        Sun, 30 Mar 2025 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743331727; x=1743936527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHz10v3+4PyiYacdlvoE6pvL8VVZTMsprAuRMJhfIe8=;
        b=YU//tgzOZ6/7MWTeY1WBWR8ytIVX0VSCTlS57JlMijxYlk1GORQxWXPCuB7lqgWRIo
         w9Qwdw+8mMY40j1cuA2PBa20t/vv22CdqFKgPGIS0yWejofS6vwqHFHQ1/ZjZYMJDAO9
         uHwGg6x7EeHB93RA6q1jxaxMa74uGWOelgiC64e5C7pUyuk05tMVhuWjWTtl/XUtTxky
         zxTEV+yQuQRXAWkw13bjTjFchBl/XMV5rNFHYegZRH+eiPNZ6hWJMRe4dn/kMSWb5fAT
         QIxEg27dUS11WzSnK7TKDk9kSj9llsbX8TsZJl6/MB6XBtz+JQK9fl3LpSnJNLQqVez+
         YrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743331727; x=1743936527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHz10v3+4PyiYacdlvoE6pvL8VVZTMsprAuRMJhfIe8=;
        b=QDdphccLCP9t+vDgH7s1iuhqClCAF6z4fbKr/p7N8oNUgcASOXUa1iGd17YJE+v0tX
         79rAU1VIoPqy7ePHqt64MnYpovs8sRr8kavPqqjWsN+Ic5x7KNhaKbUAI+M/+3/yqNK8
         n8gOVApJ0MBR/g0CV8WYUklzlDuC0BG4PKwbWP2Rjjd0pH6IPaumZ+3O36x3NHVt9Am2
         D95ohbV/GrCErONML3Y3j6M7TW1p6BehhOQlBq4aqjJyRpOST/VNBftYxqiHzEzpEp0a
         4Tu6Kxm6EboqVqb6xtnILwA0Iffsa+3wiFma21fLB32qwyyYLl6K3tTPAWCidjeCEWk6
         JVww==
X-Forwarded-Encrypted: i=1; AJvYcCUlHTJdJBNF1KygJSEpESl6H4iep+TjmvTZD3XOGATkTfXImj56xqcTw6tbEcCTrCejbOfYVCAfjrI4HyFO/NTO@vger.kernel.org, AJvYcCW6/tYscKQ2q06x1Z3QiW/StfumF/nsieMwMHk7SHaeqt07WWgdjku9oTM3ETw3nqnI2zMAKpCEvg3mkxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjnLjGqO+FRA2LDZt0G4/b4/B2/BV2Ozu9KzSUwkvtOfoz0i6
	D6h2UIFqb3YFSGnXJt+LZGv4nB0Dzcp2+u+Kn+HJl3q1U7zxifwREXqVQbC0
X-Gm-Gg: ASbGncvWqH0h9XKp1DIsPrwkFwieCDJhZzEhdQKYHB56TVWb+WrbunF0RZmqagKSLFH
	9jk4rg5cHPBXPQe1T25wPJYKiEVk+p4Axh5qiroelsTpTfU03JLGg0OLh/dTQf7RGsQ+PSW4E77
	Xd51+Vz/NVI/qoHhNhUlFvXw8ZOaGCq4jVQaigIh5aDNJ16bSgUvORFGn3HX0fTgmMnphM06A6g
	TlHzTG1Htve0DQ7+SF0ycRHIkvDeZWHnOWOa1rmEWbw59uG0q5P0/Wmzrps5dk+tsouElZECxOf
	7tGqqZPKCGAUx+Oe1q3gB06M0gpsFw37O32kq0hPEEy53p/hxHPXL/hVPQG8tDWC
X-Google-Smtp-Source: AGHT+IE4poOureteWyKOSBbsir3J88iiC+iCQKof1Qef0WrAMNHGqmzABUQfjIymvFjRy76TUVQChg==
X-Received: by 2002:a17:90b:2e4e:b0:2ee:e518:c1d8 with SMTP id 98e67ed59e1d1-3053215ce9bmr9501857a91.30.1743331726821;
        Sun, 30 Mar 2025 03:48:46 -0700 (PDT)
Received: from sid-Inspiron-15-3525.. ([106.222.230.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305175cae32sm5178803a91.42.2025.03.30.03.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 03:48:46 -0700 (PDT)
From: Siddarth G <siddarthsgml@gmail.com>
To: shuah@kernel.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Siddarth G <siddarthsgml@gmail.com>,
	David Binderman <dcb314@hotmail.com>
Subject: [PATCH v2] selftests/mm: Convert page_size to unsigned long
Date: Sun, 30 Mar 2025 16:18:37 +0530
Message-ID: <20250330104837.21360-1-siddarthsgml@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cppcheck warning:
int result is assigned to long long variable. If the variable is long long
to avoid loss of information, then you have loss of information.

This patch changes the type of page_size from 'unsigned int' to
'unsigned long' instead of using ULL suffixes. Changing hpage_size to
'unsigned long' was considered, but since gethugepage() expects an int,
this change was avoided. Similarly, wp_init(), wp_free(), wp_addr_range()
are designed to accept int parameters, even though they are assigned with
long values. Future updates to these functions might be required ?

Reported-by: David Binderman <dcb314@hotmail.com>
Closes: https://lore.kernel.org/all/AS8PR02MB10217315060BBFDB21F19643E9CA62@AS8PR02MB10217.eurprd02.prod.outlook.com/

Signed-off-by: Siddarth G <siddarthsgml@gmail.com>
---
Changes since v1:
 - Instead of using ULL suffixes, converted page_size and related
   variables involving it from 'int' to 'long'

 tools/testing/selftests/mm/pagemap_ioctl.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index f3b12402ca89..fe5ae8b25ff6 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -34,7 +34,7 @@
 #define PAGEMAP "/proc/self/pagemap"
 int pagemap_fd;
 int uffd;
-unsigned int page_size;
+unsigned long page_size;
 unsigned int hpage_size;
 const char *progname;
 
@@ -184,7 +184,7 @@ void *gethugetlb_mem(int size, int *shmid)
 
 int userfaultfd_tests(void)
 {
-	int mem_size, vec_size, written, num_pages = 16;
+	long mem_size, vec_size, written, num_pages = 16;
 	char *mem, *vec;
 
 	mem_size = num_pages * page_size;
@@ -213,7 +213,7 @@ int userfaultfd_tests(void)
 	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 				vec_size - 2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", written, errno, strerror(errno));
 
 	ksft_test_result(written == 0, "%s all new pages must not be written (dirty)\n", __func__);
 
@@ -244,7 +244,7 @@ int sanity_tests_sd(void)
 	long walk_end;
 
 	vec_size = num_pages/2;
-	mem_size = num_pages * (long long)page_size;
+	mem_size = num_pages * page_size;
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
 	if (!vec)
@@ -432,7 +432,7 @@ int sanity_tests_sd(void)
 	free(vec2);
 
 	/* 8. Smaller vec */
-	mem_size = 1050ULL * page_size;
+	mem_size = 1050 * page_size;
 	vec_size = mem_size/(page_size*2);
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
@@ -487,7 +487,7 @@ int sanity_tests_sd(void)
 	total_pages = 0;
 
 	/* 9. Smaller vec */
-	mem_size = 10000ULL * page_size;
+	mem_size = 10000 * page_size;
 	vec_size = 50;
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
@@ -995,7 +995,7 @@ int unmapped_region_tests(void)
 {
 	void *start = (void *)0x10000000;
 	int written, len = 0x00040000;
-	int vec_size = len / page_size;
+	long vec_size = len / page_size;
 	struct page_region *vec = malloc(sizeof(struct page_region) * vec_size);
 
 	/* 1. Get written pages */
@@ -1051,14 +1051,14 @@ static void test_simple(void)
 int sanity_tests(void)
 {
 	unsigned long long mem_size, vec_size;
-	int ret, fd, i, buf_size;
+	long ret, fd, i, buf_size;
 	struct page_region *vec;
 	char *mem, *fmem;
 	struct stat sbuf;
 	char *tmp_buf;
 
 	/* 1. wrong operation */
-	mem_size = 10ULL * page_size;
+	mem_size = 10 * page_size;
 	vec_size = mem_size / page_size;
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
@@ -1160,7 +1160,7 @@ int sanity_tests(void)
 
 	ret = stat(progname, &sbuf);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
 	fmem = mmap(NULL, sbuf.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (fmem == MAP_FAILED)
@@ -1507,7 +1507,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	sanity_tests_sd();
 
 	/* 2. Normal page testing */
-	mem_size = 10ULL * page_size;
+	mem_size = 10 * page_size;
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
 		ksft_exit_fail_msg("error nomem\n");
@@ -1520,7 +1520,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	munmap(mem, mem_size);
 
 	/* 3. Large page testing */
-	mem_size = 512ULL * 10 * page_size;
+	mem_size = 512 * 10 * page_size;
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
 		ksft_exit_fail_msg("error nomem\n");
-- 
2.43.0


