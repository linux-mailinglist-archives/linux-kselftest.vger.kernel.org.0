Return-Path: <linux-kselftest+bounces-15554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA3955098
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 20:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E57E1F22A91
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE1A1C2302;
	Fri, 16 Aug 2024 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsX2078Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101F1BB698;
	Fri, 16 Aug 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831931; cv=none; b=Wwly6uFb8LharQb3BGFukRQpMlEywkslaqiZC9IVQGfeu3aubvgRu8Kotq3S80iNBfJJiBdAAwo4XGPq2w3cxAJ0kRxi2M0SpFJlig/4Uku/S4X7baULv7wiaaUteBV1o1aEw/e/f4QlqISCE1ivMNc6blWm0HquFE2aJSYGA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831931; c=relaxed/simple;
	bh=mupVOxGtRgyXrHi0m4zC6bQx0ZXLDP9VTuKBPwP+2iM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dX1S0fu/lOp/sE+SkiA/bUJLymUZwGFcSJPq60C6nU41V3qLi03LXl1kcOX+NFAmJ6cpakMYRnMHyP+9y+uDJzqHQsNp0qzxrch3s8N7Xn+Di8O+PculwBYLiJZv/OC4OSX+ctISIYALbsOe/r9mw6R6DMdtweDEVjbhJGLHfnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsX2078Y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201f2b7fe0dso16244695ad.1;
        Fri, 16 Aug 2024 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723831929; x=1724436729; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5l/0VSy6fqZaacoTqYSq61RAXhnTHweezwv61jbJ0Y=;
        b=CsX2078YS2pSP2F8oR2T+zHM2p9W4aqkWoga6SvhZE06CmleWM5N8JqnxZejMxq8Ik
         Ock5wJOgO34RkhjrvtE0uB5qDkX4BRTImo7Ch/v46hUnlyqGiv93Q6MPI77LXlOCmzmu
         CBQS4nHQFankF0xg63vZbb+nSPA5vSuTX5wQrB/fYSvW7cr7HnnApxlRQsXnoaPpmIgo
         VprEMUuhxBpSDqJI4780yc4ZGXsDcpjFkmS6ZC27SmYa1FZZvoV5CDuDqV3kkFCKyNvn
         heLFoOOmqscROU/t3SiiVjl5ufvMxDWIq6JX5UkjNvpivZiqhyQQqpir/Si+i8htvJsv
         I9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723831929; x=1724436729;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5l/0VSy6fqZaacoTqYSq61RAXhnTHweezwv61jbJ0Y=;
        b=sdvR8WnZ9g//GXkTjwsN5fjh7Ysss/oA5XQP2CjcMeIhFT1TLraHRVYR2LgUnOGkLA
         bUEGfb9QfQcT0NU9vpvJwH1Ran0o+mD/B7We8BkKj5SG53Zd6q2ONKxEmmkuHfCeLGE4
         bIwCuZzAiL2SSwZan6SOHFqzqWXmUGIetmAfobXw00l46MbHflFcOu7Z9Zrk9uKZxFY6
         yQMHEqCORBeVC33Og4Dsz25rq//NEtKio48cXwiDHxohn5GYkYDbeQsi5+U/Tl0VGhke
         hxp55IaSVRqAUBAEE0TI1DfASnApCokoihkyOOoRAHIZ9NDk2ixgHuET1eacqfyHc3YY
         yl0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7FHMuYLW/IWWa95KN996pHXJWyZj4tmO8/z90xbmUcGuyYwH/iAi28l2Dxrlow7Zse50iChO6oBfvKtOhLGd8KC2YzVotM0uS4Un5effcmpPxAV67bVBLiVmZmOQ7BjuX+n1Yl2IZD21QXL6f
X-Gm-Message-State: AOJu0Yytyu64x0O2aIl+ZXeV5/Jw7yvzwCOrCjASn79cNm1QvP6H80bO
	RXoHIZ8lhgv4eWD1Tyk5sTsicyjy+g/aH2+yt7az1seQGkjbX1LF
X-Google-Smtp-Source: AGHT+IE9C/aLOhdS0C3ly72nc2bgoyh9bdEhmy1vCLr8xsbc57OwrGBuSeS6GRQihj7C/li24A4YOg==
X-Received: by 2002:a17:902:cec1:b0:201:ef87:9535 with SMTP id d9443c01a7336-20203e4c9c5mr46728515ad.3.1723831928894;
        Fri, 16 Aug 2024 11:12:08 -0700 (PDT)
Received: from localhost ([27.6.216.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037599asm28293515ad.149.2024.08.16.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:12:08 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:38:51 +0530
From: Aryabhatta Dey <aryabhattadey35@gmail.com>
To: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] selftests/mm: compaction_test: Move often used filepaths
 to strings
Message-ID: <5kedpmxee2wvblijsxmmyk5l6aufuwkjkiovnsyh7n7iuz7cok@7lfnhaobpzd7>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add defines for the file path names to avoid duplicate strings
in print messages and make it easier to maintain.

Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
---
 tools/testing/selftests/mm/compaction_test.c | 46 ++++++++++----------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index e140558e6f53..8f46431a9182 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -21,6 +21,9 @@
 #define MAP_SIZE_MB	100
 #define MAP_SIZE	(MAP_SIZE_MB * 1024 * 1024)
 
+#define COMPACT_UNEVICTABLE_ALLOWED_FILE_PATH "/proc/sys/vm/compact_unevictable_allowed"
+#define NR_HUGEPAGES_FILE_NAME_PATH "/proc/sys/vm/nr_hugepages"
+
 struct map_list {
 	void *map;
 	struct map_list *next;
@@ -59,17 +62,16 @@ int prereq(void)
 	char allowed;
 	int fd;
 
-	fd = open("/proc/sys/vm/compact_unevictable_allowed",
-		  O_RDONLY | O_NONBLOCK);
+	fd = open(COMPACT_UNEVICTABLE_ALLOWED_FILE_PATH, O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
-		ksft_print_msg("Failed to open /proc/sys/vm/compact_unevictable_allowed: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to open %s: %s\n",
+			       COMPACT_UNEVICTABLE_ALLOWED_FILE_PATH, strerror(errno));
 		return -1;
 	}
 
 	if (read(fd, &allowed, sizeof(char)) != sizeof(char)) {
-		ksft_print_msg("Failed to read from /proc/sys/vm/compact_unevictable_allowed: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to read from %s: %s\n",
+			       COMPACT_UNEVICTABLE_ALLOWED_FILE_PATH, strerror(errno));
 		close(fd);
 		return -1;
 	}
@@ -97,10 +99,10 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 	   in to play */
 	mem_free = mem_free * 0.8;
 
-	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
+	fd = open(NR_HUGEPAGES_FILE_NAME_PATH, O_RDWR | O_NONBLOCK);
 	if (fd < 0) {
-		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to open %s: %s\n",
+			       NR_HUGEPAGES_FILE_NAME_PATH, strerror(errno));
 		ret = -1;
 		goto out;
 	}
@@ -108,16 +110,16 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 	/* Request a large number of huge pages. The Kernel will allocate
 	   as much as it can */
 	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
-		ksft_print_msg("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to write 100000 to %s: %s\n",
+			       NR_HUGEPAGES_FILE_NAME_PATH, strerror(errno));
 		goto close_fd;
 	}
 
 	lseek(fd, 0, SEEK_SET);
 
 	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
-		ksft_print_msg("Failed to re-read from /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to re-read from %s: %s\n",
+			       NR_HUGEPAGES_FILE_NAME_PATH, strerror(errno));
 		goto close_fd;
 	}
 
@@ -134,8 +136,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 
 	if (write(fd, init_nr_hugepages, strlen(init_nr_hugepages))
 	    != strlen(init_nr_hugepages)) {
-		ksft_print_msg("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to write value to %s: %s\n",
+			       NR_HUGEPAGES_FILE_NAME_PATH, strerror(errno));
 		goto close_fd;
 	}
 
@@ -162,15 +164,15 @@ int set_zero_hugepages(unsigned long *initial_nr_hugepages)
 	int fd, ret = -1;
 	char nr_hugepages[20] = {0};
 
-	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
+	fd = open(NR_HUGEPAGES_FILE_NAME_PATH, O_RDWR | O_NONBLOCK);
 	if (fd < 0) {
-		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to open %s: %s\n",
+			       NR_HUGEPAGES_FILE_NAME_PATH, strerror(errno));
 		goto out;
 	}
 	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
-		ksft_print_msg("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to read from %s: %s\n",
+			       NR_HUGEPAGES_FILE_NAME_PATH, strerror(errno));
 		goto close_fd;
 	}
 
@@ -178,8 +180,8 @@ int set_zero_hugepages(unsigned long *initial_nr_hugepages)
 
 	/* Start with the initial condition of 0 huge pages */
 	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
-		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to write 0 to %s: %s\n",
+			       NR_HUGEPAGES_FILE_NAME_PATH, strerror(errno));
 		goto close_fd;
 	}
 
-- 
2.46.0


