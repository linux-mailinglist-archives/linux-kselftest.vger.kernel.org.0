Return-Path: <linux-kselftest+bounces-36847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93BAFF013
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970233B0B26
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0A21D001;
	Wed,  9 Jul 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWR/rxdY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55A20F078;
	Wed,  9 Jul 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083233; cv=none; b=qigxiLzjxD9HAzJjSTezds41Tjuc5G2iCCkQrJLX15sgmxYdr4IefJ3nDJTC/X+rLMMygY0u+l0hXEepARB7+/chXrntS2T6vqWKIgZBUJTA9yjH8ZgJbvzMEENpNY6fB3BfQG88Qc7ytN4F2TJIaYul/ubsBYVTTXlxhYh7uFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083233; c=relaxed/simple;
	bh=1t55F+zLlhpAv1GrqVoTSgh35qXs0yUuQPsJJzEGS7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QaMX5Qe3zAJK3KC4fta+D1eyunJNHztuzN8FTOM1xyVX03tl+3B/QN8XafPCdwRdDkoXiPMQ06W+A9GmjCcwh9e+Cc1sKZzZMU/EN+C3V1ypqWqpJE9rdoDIhL9UxHKYhAZqQz1Y9NTQac54sS7AwdUjqTvHGUCrUsZ54oOX1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWR/rxdY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74ce477af25so94143b3a.3;
        Wed, 09 Jul 2025 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752083231; x=1752688031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdJCSh+a/a0vurjEEgP9Hf7+uRN4IVWDqJmRDGG9p1I=;
        b=fWR/rxdYkiYBl3vhgJ9ZTGlfiYnXrThi4oHBmJwneGIuO7j8gq+i2f1fSFE2npzsRz
         r6rT8V/KyHNVe70wnWlTrrbpkBHJYFPUbODv8h3PE1m0UizUlUjkInOAmBQmNFDUefHg
         AvpE5jcqxVqNlsHKdI4J4UAt/uqn02dl2RbUv9J6O53dd0RfN6vP3Z80kmbCxzz2TNFj
         bQ1uJI8j0A+50tEYpkhCo0DQhmwcvEoUQU+uePAaa2cEmtd08i/CMuU0sIcirZ9O4eo3
         fXsVOWW1Bza1x8xYJqGueG6JXLRkir+yR/aVLfQq7pL69rqiVAfXd7mnN+OxxznTmQnq
         20hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752083231; x=1752688031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdJCSh+a/a0vurjEEgP9Hf7+uRN4IVWDqJmRDGG9p1I=;
        b=dqiK+lWqQaGhw3jz9q5ThfzAJVbTnglljpNXxiSV05RYMs/5On6sxPwOHjySh+lVzH
         OaW7j4uzYmmpkx9ocmQ97oLDU392mW2HFeCgnI4Wsj6cEivmwiL7ch2V9DZFl73v6cBo
         /sROjs58tvlBY48FHc+dzpHnK+9vGoHrGZo5fYL31A6PVoq9W0ak2iGrmOQUrIZltf4z
         Kzs/ed4TilykM6It+GCAJIdEaln8bfhWL2ghzzbLvkI+ohaPGg0prupNZxgYLQO4bqmf
         zcjzMlDUYPvGW7aXgtQzem3mrqtT0uzFWTCxFa6gy9TsZoauvR9OhU00uwwSiZ74PTZL
         ZhzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU43WcLOGhWc/w8zTrKif5qaoqNqnv/RI6WqDi/lGOerZfrByu1BFhnzwL/0V59ZfgU8k7pSnOA0eyew+I=@vger.kernel.org, AJvYcCUIgn9KEYt7k1IJVuLOWkwe6rO2V35fT2Pdy8ZMT2eOxOSpxLwXbw4ApTuG4PfHuCm+GscInrFXfPDwOddAlJHp@vger.kernel.org
X-Gm-Message-State: AOJu0YylWKUXE6M4B4K5uMJEExcwo1hc18X5tu62ZASc8FaDYM3PSgIN
	vSKkDuuMLkdQBc6wB4W4xRzobDn8jDKsevf/mRowb8T1LuluxCEgbd/y
X-Gm-Gg: ASbGncujA4FzobDRPhvkKTASooIG7grS1Lu6n+LpQ7ETghcTPgZlpiCPUjKtmlkTAn1
	gcv34NjVlb8S5sOZZ0XutuLZTYGTaxVxHTWIHZ8OSEAzoCzmuhdLO6CsmlobYZaSC55RsDooYCE
	qdd21I/3MP38oQ+tN6Fy7BQgwOaUWiQAKe4GEu8tUJoYl1hgziSsxLjMySzJoQ0XXPen8DDSEl6
	gmYnghqgVBJLTRMp7HkyUbMbUPjHO8XfeIqu7XTLOmCqaXqyuGPW6xOjiFNyfxLnBQCMOEgvnk3
	0IlMgu1akzGjf2eMXJIuCxIqmXdDMLwgUXdKbfE35NYR9VnAnwgaWwrN0ipTSSw=
X-Google-Smtp-Source: AGHT+IGiDIPsjHUYET9EGq1pGVgz8JIHHC3QtQVJFTR9ANYfbQ8ajG6QIGQGyNAJoMLajgRSLbeZlg==
X-Received: by 2002:a05:6a00:bd90:b0:748:68dd:ecc8 with SMTP id d2e1a72fcca58-74eb566a8f1mr460576b3a.22.1752083230927;
        Wed, 09 Jul 2025 10:47:10 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42ab1f1sm16323750b3a.142.2025.07.09.10.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:47:10 -0700 (PDT)
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
Subject: [PATCH v3] selftests: cachestat: add tests for mmap Refactor and enhance mmap test for cachestat validation
Date: Wed,  9 Jul 2025 23:16:57 +0530
Message-ID: <20250709174657.6916-1-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suresh K C <suresh.k.chandrappa@gmail.com>

This patch merges the previous two patches into a single,
cohesive test case that verifies cachestat behavior with memory-mapped files using mmap().
It also refactors the test logic to reduce redundancy, improve error reporting, and clarify failure messages for both shmem and mmap file types.

Changes since v2:

- Merged the two patches into one as suggested
- Improved error messages for better clarity

Tested on x86_64 with default kernel config.

Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
---
 .../selftests/cachestat/test_cachestat.c      | 66 +++++++++++++++----
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 632ab44737ec..18188d7c639e 100644
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
@@ -201,8 +206,19 @@ static int test_cachestat(const char *filename, bool write_random, bool create,
 out:
 	return ret;
 }
+const char* file_type_str(enum file_type type) {
+	switch (type) {
+		case FILE_SHMEM:
+			return "shmem";
+		case FILE_MMAP:
+			return "mmap";
+		default:
+			return "unknown";
+	}
+}
 
-bool test_cachestat_shmem(void)
+
+bool run_cachestat_test(enum file_type type)
 {
 	size_t PS = sysconf(_SC_PAGESIZE);
 	size_t filesize = PS * 512 * 2; /* 2 2MB huge pages */
@@ -212,27 +228,49 @@ bool test_cachestat_shmem(void)
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
+		ksft_print_msg("Unable to create %s file.\n",file_type_str(type));
 		ret = false;
 		goto out;
 	}
 
 	if (ftruncate(fd, filesize)) {
-		ksft_print_msg("Unable to truncate shmem file.\n");
+		ksft_print_msg("Unable to truncate %s file.\n",file_type_str(type));
 		ret = false;
 		goto close_fd;
 	}
-
-	if (!write_exactly(fd, filesize)) {
-		ksft_print_msg("Unable to write to shmem file.\n");
-		ret = false;
-		goto close_fd;
+	switch (type){
+		case FILE_SHMEM:
+			if (!write_exactly(fd, filesize)) {
+				ksft_print_msg("Unable to write to file.\n");
+				ret = false;
+				goto close_fd;
+			}
+			break;
+		case FILE_MMAP:
+			char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+			if (map == MAP_FAILED) {
+				ksft_print_msg("mmap failed.\n");
+				ret = false;
+				goto close_fd;
+			}
+			for (int i = 0; i < filesize; i++) {
+				map[i] = 'A';
+			}
+			break;
+		default:
+			ksft_print_msg("Unsupported file type.\n");
+			ret = false;
+			goto close_fd;
+			break;
 	}
-
 	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
 
 	if (syscall_ret) {
@@ -308,12 +346,18 @@ int main(void)
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


