Return-Path: <linux-kselftest+bounces-33174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D25AB9C67
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 14:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B784C3BB8F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651BE23E34F;
	Fri, 16 May 2025 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVGU95fZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514523C50B
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399324; cv=none; b=eBhYvW9mvpPmBDDI9vbq4vSFwK+5KNM8zeaSDPb/Nrxp51glkqtLy/oG+jA6Lq7Xi4i4IepZ6T+TNmRw/g0tDqjV+jH9RHP8pa+Bwp6KyC9bdyDoSGYoT4O5hWZJBm/AlUb5dbyy09Ysnj1a7WVfRN/hHUwElNOakPlbe28QIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399324; c=relaxed/simple;
	bh=ZnLqUzqmtmd3T4ccFbbyc1OCh6eUKSsNHdmkORPnEaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RGc6fAniYvBLJroPr84hvBGgFAaSD1rku7BpaNwrVnWZemizBjmYcZ0dTDvI0CVo00ujML0SXDQ/ZBN4vhMB2hLschYNE2t/SLsXCWV7Z248NLVlKk3FHCzFBglaO2mXDF8GUkDGvVbs7LUHQNMf51lpeclXUe8KiIrnJrDAAqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVGU95fZ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af51596da56so1500430a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747399321; x=1748004121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OYO8xTEZb+YDN49PqUKYpy+crhe4PhLXdnKNeh0Eu4Q=;
        b=TVGU95fZjjEo04Gdr+cZYYKXZC5MZHkJ90NStlN2/X+q0C61j30UGAJmX/V+SLFl14
         LaCkuqNfh+VJxMiavQAch+sHbq21868trIqXLxU7xIGg8qvU2/mn4LHFfKIEJfhTeM6l
         eP3WSpSmla76Y705LnThJ7WgxBZfFlyyl7Nfopf+uCLgrrFSY/OGCGFhMOleLnidu0Y1
         nqI9aOw3Gq54MLoJFMBGa3NQfPyDg2KYpuFs/yyQ+dC+GCoLgg6r43GtDvu7ny+GESS3
         oNvwqxJKCaM5FYSvFbs1Ywd0qy1lvWWe4mKRMOnp7v8Rj3RcI57yfWfAYuO3KhDe7IYU
         KssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747399321; x=1748004121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYO8xTEZb+YDN49PqUKYpy+crhe4PhLXdnKNeh0Eu4Q=;
        b=MoEIB3l8hR16/nLx4N0lonvdHECkXiyozc4pv5+DR8o5/6joQA6As4cSOh/Ux7Lobr
         DDJ1RP1LmFYctanQdcH6G06aZ0byxHLIFAVN6FvfuOHHTzRVBnCfVQ+FvBSUPp+USeU7
         RmVt+QddfHx2vsZZZT7bFgvc6tjRpBYs0g9gsaPPigmx6Fajrq15cWzqPICsb7s6NC3d
         DrmPSDGWoAwAJkyAxQtEOTaen8FUuzW4WW2x0ITPZJj273cmyYqncbUAYTlOHtf3ZBSB
         WmxQK2j3TDQWy+qJJ5/RKY3R0SGH4ZdQBW7Tu0tTspHiZeNZ3PSrTM5J/QVlDnkSIhkP
         o95g==
X-Gm-Message-State: AOJu0YxaakfeYqjYa/7hYSA/3urgZ0bK2dmiC0f3WSii/k90Pw7GQENO
	wyd2VzE0prFZBN1UXX0lxUnD28phvUN8crUy7Vg5dgLHlOynvIo61zSYT+DcfQ==
X-Gm-Gg: ASbGncsFQKLI32tf01+6gcaoe2pczEEIeV1gsYI+L79N46tnsEKINe980YPGu3cacw/
	AjEzt3jMiMGw+4rpSuXMIUMQzEjC2pc3bzzK6TqwXYnSyzwmF6ZIH/b+SBS+bbMkhGlhMIoFXST
	62BrGGdilLQGNNzN0Vq0hi023/EzKhLww3UJhYq+sPCeXOVudX+YIpnb4X/Lysma2SIku5dWojf
	OENfHlGroStAUIwijRFq4ymMgP2MFGbQqneDBVRZmOz5iHceCH0gy76H7tPsTGJ3ILVMK+LArBE
	CWBjGq01n5er7Laqi2g5aE1l/jKwTf4kfmDaqeGwBO8est9iA2J2
X-Google-Smtp-Source: AGHT+IGVHRBqqUpaGusQCoVDhPZ73lQ/AruVyzZXvfcBogmiiOGGBmw4uDr0eWJr9NyjO0b6xSAo3A==
X-Received: by 2002:a17:90b:5188:b0:305:5f28:2d5c with SMTP id 98e67ed59e1d1-30e7d558d26mr4613923a91.15.1747399321102;
        Fri, 16 May 2025 05:42:01 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6e609sm1474085a12.19.2025.05.16.05.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 05:42:00 -0700 (PDT)
From: Suresh K C <suresh.k.chandrappa@gmail.com>
X-Google-Original-From: Suresh K C
To: linux-kselftest@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	suresh.k.chandrappa@gmail.com
Subject: [PATCH] selftests: cachestat: add mmap test and /proc/cpuinfo test case
Date: Fri, 16 May 2025 18:11:46 +0530
Message-ID: <20250516124146.94932-1-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suresh K C <suresh.k.chandrappa@gmail.com>

This patch adds a new test case to validate cachestat behavior with
memory-mapped files using mmap(). The test ensures that pages are
properly cached when accessed via mmap and verifies the expected
number of cached pages.

Additionally, a test case for /proc/cpuinfo has been added to observe
how cachestat handles virtual files under /proc. This helps improve
coverage of edge cases involving pseudo-filesystems

Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
---
 .../selftests/cachestat/test_cachestat.c      | 69 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 632ab44737ec..81e7f6dd2279 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -22,7 +22,7 @@
 
 static const char * const dev_files[] = {
 	"/dev/zero", "/dev/null", "/dev/urandom",
-	"/proc/version", "/proc"
+	"/proc/version","/proc/cpuinfo","/proc"
 };
 
 void print_cachestat(struct cachestat *cs)
@@ -202,6 +202,65 @@ static int test_cachestat(const char *filename, bool write_random, bool create,
 	return ret;
 }
 
+bool test_cachestat_mmap(void){
+
+	size_t PS = sysconf(_SC_PAGESIZE);
+	size_t filesize = PS * 512 * 2;;
+	int syscall_ret;
+	size_t compute_len = PS * 512;
+	struct cachestat_range cs_range = { PS, compute_len };
+	char *filename = "tmpshmcstat";
+	unsigned long num_pages = compute_len / PS;
+	struct cachestat cs;
+	bool ret = true;
+	int fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0) {
+		ksft_print_msg("Unable to create mmap file.\n");
+		ret = false;
+		goto out;
+	}
+	if (ftruncate(fd, filesize)) {
+		ksft_print_msg("Unable to truncate mmap file.\n");
+		ret = false;
+		goto close_fd;
+	}
+	if (!write_exactly(fd, filesize)) {
+		ksft_print_msg("Unable to write to mmap file.\n");
+		ret = false;
+		goto close_fd;
+	}
+	char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (map == MAP_FAILED) {
+		ksft_print_msg("mmap failed.\n");
+		ret = false;
+		goto close_fd;
+	}
+
+	for (int i = 0; i < filesize; i++) {
+		map[i] = 'A';
+	}
+	map[filesize - 1] = 'X';
+	
+	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
+	
+	if (syscall_ret) {
+		ksft_print_msg("Cachestat returned non-zero.\n");
+		ret = false;
+	} else {
+		print_cachestat(&cs);
+		if (cs.nr_cache + cs.nr_evicted != num_pages) {
+			ksft_print_msg("Total number of cached and evicted pages is off.\n");
+			ret = false;
+		}
+	}
+
+close_fd:
+	close(fd);
+	unlink(filename);
+out:
+	return ret;
+}
+
 bool test_cachestat_shmem(void)
 {
 	size_t PS = sysconf(_SC_PAGESIZE);
@@ -274,7 +333,7 @@ int main(void)
 		ret = 1;
 	}
 
-	for (int i = 0; i < 5; i++) {
+	for (int i = 0; i < 6; i++) {
 		const char *dev_filename = dev_files[i];
 
 		if (test_cachestat(dev_filename, false, false, false,
@@ -315,5 +374,11 @@ int main(void)
 		ret = 1;
 	}
 
+	if (test_cachestat_mmap())
+		ksft_test_result_pass("cachestat works with a mmap file\n");
+	else {
+		ksft_test_result_fail("cachestat fails with a mmap file\n");
+		ret = 1;
+	}
 	return ret;
 }
-- 
2.43.0


