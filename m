Return-Path: <linux-kselftest+bounces-36125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14368AEE67E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 20:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1663AAA08
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D4292B54;
	Mon, 30 Jun 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0Qte6wF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B98F2E0B6D;
	Mon, 30 Jun 2025 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306905; cv=none; b=s8lqKlCrmLc3fG6TxOlWJOW7aP+n5cp5z5dY3Opb1smZIkvB+Degd9dqPy8EL+Nfjq/3QASACytBM8R9l8/E0VjsGU0iJucHzbZszdsWUhsQewsyQElUufjbvHwlBX+yYJgS/DAgIF6KS8WnhgFzKfskdhNaa+5VKgQ7DWnk6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306905; c=relaxed/simple;
	bh=1vjBYMQeftqWi7FZi8y1ssVtN6H/J3kGxcSJ0LgdVFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVcvYPLnETfR0gmj67z4TYr7KQtBWwbcQrl5kAh/J4lJQ4j42lz+scWhB285VA+PmHlkMVRGH9h1k8NMBZdL1VKwvQbDFAbfpasrIZz2p2/0EqJml7z82CTZYl+GbXbuNCJVNvcBxYQmqRujzH74dqz8IvVtonzsSXSFoihoTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0Qte6wF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742c7a52e97so4935454b3a.3;
        Mon, 30 Jun 2025 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751306903; x=1751911703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6T6ShIaDgYa+eLDzLK1Z4CLo4u4A8Rd31tmUlpMfZZg=;
        b=b0Qte6wFJ/ozdM0193RmUtiW2YrS9j6e5B76jFvc/EeO2tjGKtjGAk2jEEBS1Oj4+E
         /o4Z1P5vF1SxoO8mb4tKz7kWxANX/5nEfunp4r56hyqbIAFb7Glus1FJUgZ57ojt0r9u
         rZFcA/dIGFF/RMgUDjc3ruVP2zvW3jDuqxnCkTkPn7S/ck329W51Rd4+9EHMLYR2+oDG
         m2uug3pkHQ9E1Qa4uSzawG1YnCQuFaaJxCBengk2ZpJb5qK+cO2WUyhDDqO0Uf3Cxjsa
         YgsuJLXny3dYNtLF5xRBlV1UUWC4kwbX+ba/43BoZ/LNLAHP+XZlxufx81SS/L8xu1S6
         Oxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751306903; x=1751911703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6T6ShIaDgYa+eLDzLK1Z4CLo4u4A8Rd31tmUlpMfZZg=;
        b=RR6kq0dfnBblH9OSNJ7C8O2afS/QL9EyhcUnrAzHpUWX8uln5NFYu21P8B0u/WLLov
         Dwu7tpDckGl+7nLt8FVZUpBF/i48CR012yhOul+IJDrBE9TCnshA8phnAnfcs5ZSWwZj
         hoBZcNCLULwTB/JB3jRMVW/7IJXIg53vJQ3aVIwttXTeGsEy84ICN6yJnzTKsmHR7cPJ
         PAcEXXPcfx3gljzW7fRytvjWkssVRo9q+VeqSYx8ifVs1gHAhT3wH74z/ELmIggnUFwU
         MQXVP+Axg3NoDmx1O4O5VeUeJ3qyBFVcXfWzLD1/AicIxHPzYjvIEGdp6hROhjFeqLMC
         a6uA==
X-Forwarded-Encrypted: i=1; AJvYcCXHJeMhVg/ghBr7ePSKTeA9rCs8PAZiwJwPqFJghbTlL6dEMxp8+0lhPxEltrvBXiFhmj4hvO3ry5bgREbZ8+SB@vger.kernel.org, AJvYcCXkX9eD+0CImhxCQ6kHaaRhylinvENCMAqrBOP12tchE8qaotTFv8mQFVLmnLM+I2Pnb01XMmeusJ0JNo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcsr80NUc0XCKmUAH8WJvR5Ejcr9mBRAmSIQZ9WxMm/Or9xZJ9
	7Cr5L2cEiTUvxJ+qosdUVMiNsPWl+NKtuQIW4bH8ukOQ+uKPZJWXjZdd
X-Gm-Gg: ASbGncvbb9OH2qi4V1tk7sUzR2scv8eB67zYZs80VaG3fhACQgcpai+wJg0YuRHD54C
	F0xWwaTW9Xj9Ag8sTYIRbo/QzKgQr4/AmcDUgS6PIIQMihOs4UYxrQO/jFE1afxxGBTa0BmzwAI
	Ezwx+5M8d6nJzWdckyuDSISvxURp/9peudxc9kbUTEb/ccH53TI3U476NpimPKSlp3j1inqK3r7
	9JshUucXimVM+cTk35kUo6T5p+uctgTEilUGNN63IzIXD+CgFeleGjSzokiqdiRptrtnOTbPrhZ
	GAqN4msJL233LDKtGa4rhWGpdO9K7+/q3hjrDzRM6QNi7WjEAVCAyhrkDZi3IFm9d1J+dggQkA=
	=
X-Google-Smtp-Source: AGHT+IGfZZ+Zwjhq1svTSCDB3OQiG9TwUzr5RDKzedUN9ml7LO9I5lCEqLgS9yoQoN7QtZ0f7/LgDg==
X-Received: by 2002:a05:6a00:2302:b0:749:4fd7:3513 with SMTP id d2e1a72fcca58-74af6f2e991mr18447410b3a.16.1751306902770;
        Mon, 30 Jun 2025 11:08:22 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56d0cb1sm9410550b3a.134.2025.06.30.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:08:22 -0700 (PDT)
From: Suresh K C <suresh.k.chandrappa@gmail.com>
X-Google-Original-From: Suresh K C
To: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suresh K C <suresh.k.chandrappa@gmail.com>
Subject: [PATCH] selftests: cachestat: add tests for mmap
Date: Mon, 30 Jun 2025 23:38:03 +0530
Message-ID: <20250630180803.12866-1-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suresh K C <suresh.k.chandrappa@gmail.com>

Add a test case to verify cachestat behavior with memory-mapped files
using mmap(). This ensures that pages accessed via mmap are correctly
accounted for in the page cache.

Tested on x86_64 with default kernel config

Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
---
 .../selftests/cachestat/test_cachestat.c      | 39 ++++++++++++++++---
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 632ab44737ec..b6452978dae0 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -33,6 +33,11 @@ void print_cachestat(struct cachestat *cs)
 	cs->nr_evicted, cs->nr_recently_evicted);
 }
 
+enum file_type {
+	FILE_MMAP,
+	FILE_SHMEM
+};
+
 bool write_exactly(int fd, size_t filesize)
 {
 	int random_fd = open("/dev/urandom", O_RDONLY);
@@ -202,7 +207,7 @@ static int test_cachestat(const char *filename, bool write_random, bool create,
 	return ret;
 }
 
-bool test_cachestat_shmem(void)
+bool run_cachestat_test(enum file_type type)
 {
 	size_t PS = sysconf(_SC_PAGESIZE);
 	size_t filesize = PS * 512 * 2; /* 2 2MB huge pages */
@@ -212,27 +217,43 @@ bool test_cachestat_shmem(void)
 	char *filename = "tmpshmcstat";
 	struct cachestat cs;
 	bool ret = true;
+	int fd;
 	unsigned long num_pages = compute_len / PS;
-	int fd = shm_open(filename, O_CREAT | O_RDWR, 0600);
+	if (type == FILE_SHMEM)
+		fd = shm_open(filename, O_CREAT | O_RDWR, 0600);
+	else
+		fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
 
 	if (fd < 0) {
-		ksft_print_msg("Unable to create shmem file.\n");
+		ksft_print_msg("Unable to create file.\n");
 		ret = false;
 		goto out;
 	}
 
 	if (ftruncate(fd, filesize)) {
-		ksft_print_msg("Unable to truncate shmem file.\n");
+		ksft_print_msg("Unable to truncate file.\n");
 		ret = false;
 		goto close_fd;
 	}
 
 	if (!write_exactly(fd, filesize)) {
-		ksft_print_msg("Unable to write to shmem file.\n");
+		ksft_print_msg("Unable to write to file.\n");
 		ret = false;
 		goto close_fd;
 	}
 
+	if (type == FILE_MMAP){
+		char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+		if (map == MAP_FAILED) {
+			ksft_print_msg("mmap failed.\n");
+			ret = false;
+			goto close_fd;
+		}
+		for (int i = 0; i < filesize; i++) {
+			map[i] = 'A';
+		}
+		map[filesize - 1] = 'X';
+	}
 	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
 
 	if (syscall_ret) {
@@ -308,12 +329,18 @@ int main(void)
 		break;
 	}
 
-	if (test_cachestat_shmem())
+	if (run_cachestat_test(FILE_SHMEM))
 		ksft_test_result_pass("cachestat works with a shmem file\n");
 	else {
 		ksft_test_result_fail("cachestat fails with a shmem file\n");
 		ret = 1;
 	}
 
+	if (run_cachestat_test(FILE_MMAP))
+		ksft_test_result_pass("cachestat works with a mmap file\n");
+	else {
+		ksft_test_result_fail("cachestat fails with a mmap file\n");
+		ret = 1;
+	}
 	return ret;
 }
-- 
2.43.0


