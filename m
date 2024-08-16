Return-Path: <linux-kselftest+bounces-15550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C3E954FF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3CD1C20823
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FEC1C0DE8;
	Fri, 16 Aug 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAlZrUEJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF492BB0D;
	Fri, 16 Aug 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829061; cv=none; b=QQK9Vln2FBBsMdgkjyZ/uvxvpldzFgdbPqphR9VUD/0Gc6JQ9RTdd1XgLYJsYPURoCoCSpB1LFBytyTvxCfPf6yeTVxE6953a/lP7z0Wz4IeiejV2t/7woYxjquUaYGl5BsmNJXgwXXmIv5NQnk+5naAoO90ruT73yi5KFee5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829061; c=relaxed/simple;
	bh=gfs8VaCiqUCC8u5QXEZrwy0/UJQHHtDJhlCueki9qRw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k4Vn44qT6qYJ9zUxhiIXebkLc228OrU/B7bdyaDRDP6YaRjhv9doVIE0NUf/Wr4ETJkq5ANvVaeAKzNOpEHdfNjeY29caNC7YPzCGkWUUA4qOl3upYyYHiY/YVZx/5LbSLe26B742sKRKZUVdFwS82nxoqhhXTBuUboTb77FjoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAlZrUEJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-201f7fb09f6so14838605ad.2;
        Fri, 16 Aug 2024 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723829059; x=1724433859; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/dmrRqqXj2v9b4YTwmz0D6SlhuRLFNEyjT4EiFc8HE=;
        b=QAlZrUEJIKF5IuV8uYbXtTCoVUmJ9w3sooxwM5VzDE9ak/SEuar+dWKxo1yvK4f3Wc
         YMoRs7en5+dT8asEBrUMR1O9UC1moUeIFbcX0yjwjMqh+1MEKYnvcCJ1u69QfrR3nof9
         pcNOENdfOY489LoTOnYOXHu2sY4/sK+pi1uVhHPnQdwEe1E52KxyWEAEVtxrmY+iAo1k
         EScmc9eXEFu1OinHqc8SmkO9Hgm0T6uXTLPlaxwjHzcMTEkGFx3oYCNpeVpdor9FnpJH
         1TX7vuFKq/jjTZRi0//1iaXLtzJNBeZ7G4K27HhEd6vKFq7GimnleE5wnso2u/vQqYSo
         UNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723829059; x=1724433859;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/dmrRqqXj2v9b4YTwmz0D6SlhuRLFNEyjT4EiFc8HE=;
        b=g9VdInS+TB6liQqEN9e8mDHfvviEUqzW28IIfzU2DSam5q9duYn1e0dObmzf6Vhcyj
         jxPBHjoA9Q54Ca5bdRStJx5vq3DdsN8Gobm8oPV/SPhCxHAI3l6Z9I7f6Sp03tIrHQkP
         +wFBHuV31cJphniXjMQfczfETYkBVwyraoNriUfBoWE5lG6X0ps+UV6hD4UK6eMcKvDr
         FDAbj9egtJxKfcQXXrjddJroiBPiiIKx2S499sSGo6JMc8T08cOVDZYD8omwJJ5vSlzU
         ELSaqMgZN3c8kwN0c2upnSyy0snwaP5Op+T4KWBYsyVk+Ls0UmsA4la8TRe+Ogy0Os0B
         ljkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCGODQWBdeGgkdqN9IRUvWPsxoYhodya8oZUnz+rYP9286yeRpfiEe3TRucZ9Ow22qLv3LS3ip4N1i79OGsLL795VzoAFwTCsg0qvdJMR+kcjipxSBuLdXV24UV1koHzQCAhxgsESHODHCXdT8
X-Gm-Message-State: AOJu0YzvjvXVCZ0YdysKqCssnWG8yYB2nRQtcc+tb6H1RTBvNGU2MPbh
	tZXze763lbLMtjv3tMh/dHapZAa9Ie4t0/RidAshIEZ5i+9uQAs00C05spkl
X-Google-Smtp-Source: AGHT+IGuHnGEDCRtfNvw9KKo4hDVg4qVJqRvhyCt1ml1QtQrt/cBiuDQmT43rzSeWvqOmG2vgLyyKQ==
X-Received: by 2002:a17:902:d50f:b0:1fd:a503:88f0 with SMTP id d9443c01a7336-20203eefb29mr44980425ad.34.1723829059518;
        Fri, 16 Aug 2024 10:24:19 -0700 (PDT)
Received: from localhost ([27.6.216.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fa2d5sm27913985ad.49.2024.08.16.10.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:24:19 -0700 (PDT)
Date: Fri, 16 Aug 2024 22:51:02 +0530
From: Aryabhatta Dey <aryabhattadey35@gmail.com>
To: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] selftests/mm: compaction_test: Move often used filepaths
 to strings
Message-ID: <al5jalqx6ng4w2qyf7nctxpm7u6cdjrazcixcemzi5mbvyluoo@rc5e7gqrwby7>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add defines for file path names to avoid duplicate strings
in print messages and make it easier to maintain.

Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
---
 tools/testing/selftests/mm/compaction_test.c | 46 ++++++++++----------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index e140558e6f53..541ac0373258 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -21,6 +21,9 @@
 #define MAP_SIZE_MB	100
 #define MAP_SIZE	(MAP_SIZE_MB * 1024 * 1024)
 
+#define COMPACT_UNEVICTABLE_ALLOWED "/proc/sys/vm/compact_unevictable_allowed"
+#define NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
+
 struct map_list {
 	void *map;
 	struct map_list *next;
@@ -59,17 +62,16 @@ int prereq(void)
 	char allowed;
 	int fd;
 
-	fd = open("/proc/sys/vm/compact_unevictable_allowed",
-		  O_RDONLY | O_NONBLOCK);
+	fd = open(COMPACT_UNEVICTABLE_ALLOWED, O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
-		ksft_print_msg("Failed to open /proc/sys/vm/compact_unevictable_allowed: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to open %s: %s\n",
+			       COMPACT_UNEVICTABLE_ALLOWED, strerror(errno));
 		return -1;
 	}
 
 	if (read(fd, &allowed, sizeof(char)) != sizeof(char)) {
-		ksft_print_msg("Failed to read from /proc/sys/vm/compact_unevictable_allowed: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to read from %s: %s\n",
+			       COMPACT_UNEVICTABLE_ALLOWED, strerror(errno));
 		close(fd);
 		return -1;
 	}
@@ -97,10 +99,10 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 	   in to play */
 	mem_free = mem_free * 0.8;
 
-	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
+	fd = open(NR_HUGEPAGES, O_RDWR | O_NONBLOCK);
 	if (fd < 0) {
-		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to open %s: %s\n",
+			       NR_HUGEPAGES, strerror(errno));
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
+			       NR_HUGEPAGES, strerror(errno));
 		goto close_fd;
 	}
 
 	lseek(fd, 0, SEEK_SET);
 
 	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
-		ksft_print_msg("Failed to re-read from /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to re-read from %s: %s\n",
+			       NR_HUGEPAGES, strerror(errno));
 		goto close_fd;
 	}
 
@@ -134,8 +136,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 
 	if (write(fd, init_nr_hugepages, strlen(init_nr_hugepages))
 	    != strlen(init_nr_hugepages)) {
-		ksft_print_msg("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to write value to %s: %s\n",
+			       NR_HUGEPAGES, strerror(errno));
 		goto close_fd;
 	}
 
@@ -162,15 +164,15 @@ int set_zero_hugepages(unsigned long *initial_nr_hugepages)
 	int fd, ret = -1;
 	char nr_hugepages[20] = {0};
 
-	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
+	fd = open(NR_HUGEPAGES, O_RDWR | O_NONBLOCK);
 	if (fd < 0) {
-		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to open %s: %s\n",
+			       NR_HUGEPAGES, strerror(errno));
 		goto out;
 	}
 	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
-		ksft_print_msg("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to read from %s: %s\n",
+			       NR_HUGEPAGES, strerror(errno));
 		goto close_fd;
 	}
 
@@ -178,8 +180,8 @@ int set_zero_hugepages(unsigned long *initial_nr_hugepages)
 
 	/* Start with the initial condition of 0 huge pages */
 	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
-		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+		ksft_print_msg("Failed to write 0 to %s: %s\n",
+			       NR_HUGEPAGES, strerror(errno));
 		goto close_fd;
 	}
 
-- 
2.46.0


