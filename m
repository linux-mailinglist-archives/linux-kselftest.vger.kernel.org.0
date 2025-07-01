Return-Path: <linux-kselftest+bounces-36207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50EAF0325
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 20:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39FE7A9064
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386D823AB8B;
	Tue,  1 Jul 2025 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIPCFHIW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7721CC40;
	Tue,  1 Jul 2025 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395757; cv=none; b=Ty1JeEjONqScOK8ICG1RfpN2UEK3embWg9AXY5cS8zSlaQmCM8WNozq9vHzRsACnpAF/a3p/Xl4phbC66q3pjxszMUWWgDVmtwqmnntxQvAm6Ajbe5ZZVf3MG14m/88J+bMwq6Nlnfz9aXsHz0uLTfGQwIO8kxltVtX1FKX/aeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395757; c=relaxed/simple;
	bh=1vjBYMQeftqWi7FZi8y1ssVtN6H/J3kGxcSJ0LgdVFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZO02payclt4Z7frK3B7TaR6tO8xLtJIa372SeLyc3RuAdNFYlNneFiJRjzz/CHE4VXALXzTyHZABfLSRF1b4J7bsFVWFTdrMNmjSJpRw+VoQO070z5jHXJVz4SOTyAHLHeKf/WymRC6TCxI+87rYDsp8EDAro8iPU/1Y2w4hg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIPCFHIW; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2e95ab2704fso2423781fac.3;
        Tue, 01 Jul 2025 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751395754; x=1752000554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6T6ShIaDgYa+eLDzLK1Z4CLo4u4A8Rd31tmUlpMfZZg=;
        b=dIPCFHIWILQAlDPI9UIb6G1iCUTqRZE+9yKurYAI9WHthFIWt9gVoNZQStyp17yvye
         ItpLopGBOMjQbLgH50ZK6MBQyDOjokbErvnC1SMGIxS2KKjghTSFOXX510oPBfH/aC9U
         UEFwNIG3/R/xCVZNB6EHYbpoHnlSpc863B1LrBN+yzubvJe/Ejzgw/DPwD4y2GahHnKT
         ZUAt5dtpx/xDGbR/EnYYdrlv+JDKmlmfcCwlkiQtndcPV+oyaGKtBm9vYWUlqsyZc7XD
         fWJZGyM5kiBs8kedAJKSh05g5buH94L4T7gJQv2j7bt6pfHjcKxvL/e6jhf4OCpsVxT3
         C6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751395754; x=1752000554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6T6ShIaDgYa+eLDzLK1Z4CLo4u4A8Rd31tmUlpMfZZg=;
        b=Vj0oJ3SihKswL2cTCc5SmjeYBHv5e4uyi35A1/09cvRNEtuXyEieu3LMyKFxW6tH2d
         R8Hgcn0foiYIKdj3a6PQFrTkjGdqwXeJi9esihR7Z5jAMeb5FPxofiD+58iICLoX4wWo
         fj3SMbaJXBndiV1Yz7szRt7zPXzCFBKUj8KfYTRJeiEZOvraLb+cOINKZ44MvumnxdVj
         LAlpE9Asz8BEV7KrB3OFKmfR9f3QzuW9VCpUXcUomqNj47+za7C0GTDo+WwzsUQHrMlu
         b/Yq7//tmqnZsnoCtdbNPJxL9QtIzoPSNJYqhU/kgL3XJpiOPzGuFlYCsoKhU7NmtdCV
         ANXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+cQcBna+QRn9Gb7xDrQXRWq8Z0nWR/XxyAmxcYLVtQ0oQdKOIOeLETL1HfZVLgTT5/mf/SIot5PlWJLh7EnBj@vger.kernel.org, AJvYcCXK/eCQBMPKMfjEJptUop+fkFvT3a87pFo4M/OfalaskqhxOo8S/KGByAVD4a0jad8IZDkH7qB/9TcWCGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw94FUpItsAJoDiotsuTkdzyqP/p8McBdBP3H4kkXOanFbd/UL
	HAlH02vo5b5BokHnks0ApDIIshjwzWq4mX5TbAnleO+qcJUBy5m2ghdg
X-Gm-Gg: ASbGncsGKhig1tr4zKOhE97LGtKQ6qg8tHnD9JyJ8ak5RPzTer5rFpxGBHcdsX2FAQe
	k8DGZTgFULufa4LxoQTuuNXiXwNwIayi83UhteX3eBsf/B5jVfZsj92ZARZ25T3+U0isjJKLw7A
	R/FOo6a7CBzAcKHZLOqsX2riEZwPUnvRSePDGEI8E15HYBgBNEpREpdRGttbYqFEkYzAlY2sExM
	SEgRAug14vc0MDrCBgNio/9VkxzX7JGWx4w9/jqGFXOvk24xV+QMnm1VRo9Elg6q+i6Y1PsxunD
	aLb5vNFucYvmmIRTxz3r0GWIzS+D6ot00Ytp0RumrEtRkpUJN1DmjfklFbY5K55gV8nEUgLSGg=
	=
X-Google-Smtp-Source: AGHT+IFQar7eRKIGXm/cAgR40K7ZQCBU6V/9cWUE3jHqi9PpFBjVeAa5Z08aoxBYmDlj+ul5E6tD3g==
X-Received: by 2002:a05:6871:3748:b0:2d6:2a40:fb9d with SMTP id 586e51a60fabf-2efed81d50cmr14218187fac.28.1751395754357;
        Tue, 01 Jul 2025 11:49:14 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb0e3160sm2213242a34.44.2025.07.01.11.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 11:49:13 -0700 (PDT)
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
Date: Wed,  2 Jul 2025 00:19:01 +0530
Message-ID: <20250701184902.8927-1-suresh.k.chandrappa@gmail.com>
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


