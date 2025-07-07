Return-Path: <linux-kselftest+bounces-36702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75951AFB748
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 17:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036EB1707F1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 15:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E192E266E;
	Mon,  7 Jul 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9h7uVuK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B352E2EE0;
	Mon,  7 Jul 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901970; cv=none; b=NsWtH9ux0TXOcKbomG3eV1kDjfezLCxQ4ccqXOGG0FP6y/PnqbuPUI83t3OZe96iKGLNzznR+UyGU+K/+9R0xqG4ot2ap31SDcLeeHqIj0yfLfAQAfvbpUQP8s3mG5M6C1XSXkHqNKBryobg4YPxpDwYRgeT1R46OXzzU/ouaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901970; c=relaxed/simple;
	bh=1vjBYMQeftqWi7FZi8y1ssVtN6H/J3kGxcSJ0LgdVFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjwxEWrJZDEu9dCDygWCyk2E7XTUKk4dwO4IM+KNkEH4+oV3qsAn9Q/y1SjXBvvWmjSmlLrGi/rgeJ10wSKvbxrqOX3vHzeSaZ/3r0yIHJ3F/VdSB38M6utJ37w0fRUQmaUBCULLJXcYWfNDh5TaoEt6WRY/ovvYalXcUwvBPws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9h7uVuK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2349f096605so47081845ad.3;
        Mon, 07 Jul 2025 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751901968; x=1752506768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6T6ShIaDgYa+eLDzLK1Z4CLo4u4A8Rd31tmUlpMfZZg=;
        b=j9h7uVuK37bvQh8Ysax2df4JWK49wrZaVoBKOAkm+UWvKHCcIWlHxRY3+8aRBRECLe
         cQBuYI5x0UZcwVSabeNLBq2aPEHxXbNQhqd9/Ls6zfDXmUagJVv/sfrkzcUsl0ozCTid
         F5Oj3EOs75c6enHLEIyirnSJSSxTXzS8Hspb0XV43evRowjiXtdsz7MuWfljOPjlPMJZ
         7s3OIzdXnOTMzZB8ztjfRngEjoyBqow86zDx83IQ9zpFuFsTw7hfonS1uS36EyLXdgfS
         LggLwLEt7kreFrVQFxxnVOgPn8ZiwskFlrF13ysVZlOnEkSnK+8EhgRvfnNVQS/S3oUw
         V0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751901968; x=1752506768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6T6ShIaDgYa+eLDzLK1Z4CLo4u4A8Rd31tmUlpMfZZg=;
        b=A1emW0b/n6RNniINsNqteVy2KCNX+f+L6RtIKizUbdX1k8u5g1Vj8PPhITzsrJnK85
         NT2Uq7RXMw9LFQ3Oatyd/wVPxMLEKQ/XC10sQ3rhQxIQx/cDnnoJVGKXW/saM/scw0Xo
         wkblCOBj9OibI++wzSY+qalvo9D1jscADWlAnR/cGuinMcqPTxJQL4canwlKSBneXt+d
         aztHUvkUexo5b5zbBHFWFUUispGDaZhwqig2BFqewnHsPPfmeKwsnGz6SwBz5I2jUSEJ
         Typ+CdXtR6NOCGxXJP3imHp8zK0GHm1n9J9Rn3eKhNnJQ9lRm7ouRjsUZK08seQIg1wF
         ZeKw==
X-Forwarded-Encrypted: i=1; AJvYcCVTBkP75kyzpBPIV6yRQ3XMwAfrt6waHdmGDYuHfrLvU9R7/BYhrKGmp+YbzClQx89sP1UBYajdNalPMvc=@vger.kernel.org, AJvYcCXmC+fd0VVB9p3SuzKewcCaiQ8NKo1MIQpYK7cslwJGP7nIeBBp7T5AG/wCN7SqM6fnE2Mf4zlJ/9qoJuNfBjBT@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBdjJqZhThxiwkgI98muwIZkTTmHZJTwcKKSDydfMYboUpDIJ
	gaRDAeWUxws71CCKUxzisAWQL5ESJ39Isdaz4FtClZA0KhzH9GHbbNKg
X-Gm-Gg: ASbGncuqbQN6WYtYJxDuGFm6uHKIwVBxe2wZp0hSJYRTP6wkbuxZdXm9nYvUwsgyrF3
	iiQ8ZhgclKxslWQ1pppZ2vtBG+UG3+a0apcaQRTVs3SK0/9CX2obtvJK2BfwwUPrGTAwoTfFzrP
	OSGjS+16tu0GfIS1Xu3sN/sO7gbQeBTdgyOd0qDLAPqRcamfV1dV7N790uCHugJt5slm6elyVXC
	GuGQn79P7QsSmAt+HPsGdgx9bGj4H1LqaPT2Mn3x/E7jsyKtOZl4EVEAzh9PdKM8+0cXK3FXxGi
	hTL9EqJgNHwbRw3zDWCbQdbMUBXEw9li/qlWS3W5NyosKYCQxRGQ9vvcjQoG4R0=
X-Google-Smtp-Source: AGHT+IG5SRYDX/otRUvxb1vrGIRBHOn23NuN9PHO89Y/+FotRBvffqs8Ouyh0Bp2FwSJf8AUd5unng==
X-Received: by 2002:a17:902:ec91:b0:235:129a:175f with SMTP id d9443c01a7336-23c8755bef6mr202997435ad.34.1751901967601;
        Mon, 07 Jul 2025 08:26:07 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84593e0asm87533495ad.193.2025.07.07.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:26:07 -0700 (PDT)
From: Suresh K C <suresh.k.chandrappa@gmail.com>
X-Google-Original-From: Suresh K C
To: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	joshua.hahnjy@gmail.com,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suresh K C <suresh.k.chandrappa@gmail.com>
Subject: [PATCH v2 1/2] selftests: cachestat: add tests for mmap
Date: Mon,  7 Jul 2025 20:55:56 +0530
Message-ID: <20250707152557.49877-1-suresh.k.chandrappa@gmail.com>
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


