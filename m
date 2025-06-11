Return-Path: <linux-kselftest+bounces-34752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF84AD5DDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 20:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A147AC59A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 18:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C412609C8;
	Wed, 11 Jun 2025 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKjkD6pc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D5C8FE;
	Wed, 11 Jun 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665392; cv=none; b=HuNlR/rnrBtqDcJYBTs1YaLArN7Xc915f6ClNH6xJ6axxPD9vBRYWbtRvCy3ZtWPHh/AiS0IzfMy9zFbuX+Rm4ljB7M2GzLZnYIxp7R+9MQu5/wu7+4Y6OfELaAzmc0Sp7vefossM9GMvg6qs7YFDxqSct5E5BMRidevbg/dY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665392; c=relaxed/simple;
	bh=f6O5q0W2J4qlVd61DBRnTyl1VWb5RPPJVnQLrHCKy0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBVRhKcTKntAdVehNtmSBvjC2Ds40PrQWeVzqzGnkV2xgsRkBXfEcysfnt+KD7O6W7K7FYxpWZUZqaV05tYm5On4hPTlx5+nQV4z4YPeyFlmzpiTNSzbKQfBWbHNlFwf53m35ZAMWWj44iqZ0wwdYe87+82Q/JR2nx8BAY0q+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKjkD6pc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234fcadde3eso1758015ad.0;
        Wed, 11 Jun 2025 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749665391; x=1750270191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZpCOMPL82z74J5eCC5crL6BX4mR7vO0hUuXz+7gl1U=;
        b=eKjkD6pcGgHkva10drGWUbmQRezvNh1k4zsxMjPFCINECeFnKkzi9UwZMDy5izmInp
         CXC8RIsyT+xMSXKTo/YJVvBGPOEx6+pmkO/ovi4tM2y+Zp4ThSmq8CTuurVihyE55sRl
         PCAR1BB28IfcOMG+uVozlSWQH98MxZHi/GEBbPWPkhv/Kom2f4i4c4m2L8kBpfvfrm+k
         dmLBKiTdo26N5WxnuRsgdcKkws0oyZWks80XFB0hxtNUKkPUe7eEAyortLOKA0JoQleo
         2cUKkyJ5NsadcswytrfgPQ1cNFRUzoCKb5263JV7v8GK1smxDNNzSVFzpQ7VEFNNioB3
         Y2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749665391; x=1750270191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZpCOMPL82z74J5eCC5crL6BX4mR7vO0hUuXz+7gl1U=;
        b=BdOyi8bjWM5FQhC9xLphBmHRpCDiztroxshZU9B+qqn/qKK9abJm06Ds52mfb2TKXh
         gUacJcLpokbDvjVQ+Pna9SatdfRqD8N+FVJ+PhcBimZ8yJVynAh1LKcJYG22uJ0LsxX+
         OIVzSIeL+BawZxVPEC9/ArPs7HiE4cF9M1B2ExpThXh8+BeI6SLJ6MV7BS5zgGVQW0HS
         RCJTDOCkQ1vWsaTWiZ91R3P3SAhucOz4UXCX2TOkvooEgvvabT9OUAQla7KOAbkaGPSO
         IgJO7Ezr08++4ZdBjJ/qN2qK8gD8g4Cr0OMIAUP248fIv2TIvczKF0vWlIXyQ7H3Yv9v
         IhMg==
X-Forwarded-Encrypted: i=1; AJvYcCVwuDVeo3Gszc7Pi6MvaMWpLs9Eaie5h2klRgpuafwhNFmaBPhwLq+Uc+RCYQ3zMWkejpcAsPPsbPGHx5A=@vger.kernel.org, AJvYcCXcH8YN/Tkzv2aA/kqciUdGCXlMn2OeCYLL+fsqQbuTMmcy17rF1kqRnMPiIm+vmDU0UzuA1wKsKUk1ciNGGKQ+@vger.kernel.org
X-Gm-Message-State: AOJu0YwYb2QVJxZDV36wTmClDf7njtOalrn/Jph/C8CpejDUL+GYflpf
	UK+CJMn3AvT1Py8zVq73ta/yA2jCvVTFTglq0/kF8XQEK0qUrDc6D/R1
X-Gm-Gg: ASbGncuxwb62gW6ctanGELBDnjU3j+qre0GQZsGVdde6StHtzL2r8JRApUuJgoKDFRr
	9lGC0i3JZBUjNgZUFtza2oGbL23RH8q1pDsz0zJsAcpsDuz1U0WeE+6JNd7Xt2ltdbCGXvYr3E5
	b269PLTxUcXLinTHyNwq6vp6QqBKlnH1PQo6CrvM9yH8AA5Kv61Yk1xory7H6JwzC/FZkuSrWfw
	EzOkHg4x3pY3azywHryR2UMJOeN6O8qexHsd/ZoeaRSDnyLaTYA5izFebh3BFXDLOBdCI1qahVh
	X8j8vrDgXqDJDQ+FtViU4OIR0sEahYUjYJYMOCJeiQnxdf4FRJELuBnmlvbuvEk=
X-Google-Smtp-Source: AGHT+IGooPNIiIm9bnCoj6EWYQVYOF49WnMejUgAL5ygblLJCYwU9fkECiTJwQdkrpLGyDJBqAe6oA==
X-Received: by 2002:a17:903:1206:b0:235:e96b:191c with SMTP id d9443c01a7336-2364d8b712dmr1098035ad.29.1749665390556;
        Wed, 11 Jun 2025 11:09:50 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b1ff0fa8sm1795699a91.8.2025.06.11.11.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 11:09:50 -0700 (PDT)
From: Suresh K C <suresh.k.chandrappa@gmail.com>
X-Google-Original-From: Suresh K C
To: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suresh K C <suresh.k.chandrappa@gmail.com>
Subject: [PATCH v2] selftests: cachestat: Refactor test to remove duplication
Date: Wed, 11 Jun 2025 23:39:36 +0530
Message-ID: <20250611180936.12886-1-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suresh K C <suresh.k.chandrappa@gmail.com>

Refactored the mmap and shmem test logic into a common function
to reduce code duplication and improve maintainability

Changes in v2:
    Refactored mmap and shmem tests into a common function
    Renamed test function to run_cachestat_test()
    Removed test for /proc/cpuinfo as a general /proc test case already exists

Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
---
 .../selftests/cachestat/test_cachestat.c      | 97 ++++++-------------
 1 file changed, 30 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 81e7f6dd2279..7c2f64175943 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -22,7 +22,7 @@
 
 static const char * const dev_files[] = {
 	"/dev/zero", "/dev/null", "/dev/urandom",
-	"/proc/version","/proc/cpuinfo","/proc"
+	"/proc/version","/proc"
 };
 
 void print_cachestat(struct cachestat *cs)
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
@@ -202,66 +207,8 @@ static int test_cachestat(const char *filename, bool write_random, bool create,
 	return ret;
 }
 
-bool test_cachestat_mmap(void){
-
-	size_t PS = sysconf(_SC_PAGESIZE);
-	size_t filesize = PS * 512 * 2;;
-	int syscall_ret;
-	size_t compute_len = PS * 512;
-	struct cachestat_range cs_range = { PS, compute_len };
-	char *filename = "tmpshmcstat";
-	unsigned long num_pages = compute_len / PS;
-	struct cachestat cs;
-	bool ret = true;
-	int fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
-	if (fd < 0) {
-		ksft_print_msg("Unable to create mmap file.\n");
-		ret = false;
-		goto out;
-	}
-	if (ftruncate(fd, filesize)) {
-		ksft_print_msg("Unable to truncate mmap file.\n");
-		ret = false;
-		goto close_fd;
-	}
-	if (!write_exactly(fd, filesize)) {
-		ksft_print_msg("Unable to write to mmap file.\n");
-		ret = false;
-		goto close_fd;
-	}
-	char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	if (map == MAP_FAILED) {
-		ksft_print_msg("mmap failed.\n");
-		ret = false;
-		goto close_fd;
-	}
-
-	for (int i = 0; i < filesize; i++) {
-		map[i] = 'A';
-	}
-	map[filesize - 1] = 'X';
-	
-	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
-	
-	if (syscall_ret) {
-		ksft_print_msg("Cachestat returned non-zero.\n");
-		ret = false;
-	} else {
-		print_cachestat(&cs);
-		if (cs.nr_cache + cs.nr_evicted != num_pages) {
-			ksft_print_msg("Total number of cached and evicted pages is off.\n");
-			ret = false;
-		}
-	}
-
-close_fd:
-	close(fd);
-	unlink(filename);
-out:
-	return ret;
-}
 
-bool test_cachestat_shmem(void)
+bool run_cachestat_test(enum file_type type)
 {
 	size_t PS = sysconf(_SC_PAGESIZE);
 	size_t filesize = PS * 512 * 2; /* 2 2MB huge pages */
@@ -271,27 +218,43 @@ bool test_cachestat_shmem(void)
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
@@ -333,7 +296,7 @@ int main(void)
 		ret = 1;
 	}
 
-	for (int i = 0; i < 6; i++) {
+	for (int i = 0; i < 5; i++) {
 		const char *dev_filename = dev_files[i];
 
 		if (test_cachestat(dev_filename, false, false, false,
@@ -367,14 +330,14 @@ int main(void)
 		break;
 	}
 
-	if (test_cachestat_shmem())
+	if (run_cachestat_test(FILE_SHMEM))
 		ksft_test_result_pass("cachestat works with a shmem file\n");
 	else {
 		ksft_test_result_fail("cachestat fails with a shmem file\n");
 		ret = 1;
 	}
 
-	if (test_cachestat_mmap())
+	if (run_cachestat_test(FILE_MMAP))
 		ksft_test_result_pass("cachestat works with a mmap file\n");
 	else {
 		ksft_test_result_fail("cachestat fails with a mmap file\n");
-- 
2.43.0


