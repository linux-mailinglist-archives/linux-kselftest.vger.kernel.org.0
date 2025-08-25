Return-Path: <linux-kselftest+bounces-39865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8454B34836
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 19:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD1D189FB0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E312F99BD;
	Mon, 25 Aug 2025 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBYHNRcX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81F502BE
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141627; cv=none; b=taxLAwOjHi2mD7S7HNLxg4baaej9btb4uEK/6Mjg1hE1HG8VR4aJmPspaJbHRMOZlVK0o5WAlKxf3oNJZ1WHRowVzPPwWVqxJiyxCCdVG85Qa86EGdgd7IgR2DnOQn0W3Sk1ShR2STEKBz/25JE33LXtfnhlm0xUqdF/+7zvx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141627; c=relaxed/simple;
	bh=5PUlfoVWVRg6I2FFtXNFbJ4L0V8P8GIIUsk8ZG7Fglk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjnv3nZ0ZNxptH5Y69X4FEwqgCK2OrjUSMPSxEBdzxAIicc9PMw1/GXFbEMQJEi7l95PCnonT3DUAfsOZkmkijycAHsi5+sMN5dIXXlcLke/Z985gGWPfN5W8mt0pn73uAR3jW1fFK57uRoVIyIkASZgJyNG2WhxygLNLGgI098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBYHNRcX; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so2453232a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756141625; x=1756746425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o5RmAfR4rYsxlFJUhIr+eW2wt0BUW3DWgzYQ+evh+1Q=;
        b=HBYHNRcXuPZg7SJacFOsFZRMbCKV2jUwe9HiVHj0nd8ft2uLLnVwxVDwjf5M5d7yGC
         mWYqjyEjVceRtlSONbvB2Orh2fJAi1Vto6JJnBjNcb5B1xO+yH4qpzXKtjIISqU9bgxb
         cc9I5D/us2nTYdJZBZTysm5YPAGvepxy/MS67gwTgte6roUaaMmsii6mTexk/vU7qqlF
         cLTEqFlHVim96uBzD+KmyL8uPadyZnJDOBGHfQINct64fKVvFOfyVtpczoJQvjIR8y3M
         LlbMNAqxJfr1fniwv9M+Yhnn6A8QGKwQwmO5yxW3lRzdysSZJlYdHZ3ZKBm2NGYDNG/M
         pmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141625; x=1756746425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5RmAfR4rYsxlFJUhIr+eW2wt0BUW3DWgzYQ+evh+1Q=;
        b=pvtXF99ilaGRo65+V74iYRLurS3UieI6tvGUWg3R3uiT3mDDstq4qVQtlbykYqjCXT
         k/EtSML3kxL1iZaeRpkgj8mnl2uIXHrnuQWc0hORzhvAx9Z238gPKaE+EYRZeogJfdBo
         zXD2JDOKzGDCESe39YDpSs1OBjBWRKmlSNuSvA5PpitxFu2cUwN6eKAbw6B4ZVBQUQTp
         vQIIBbgY6QF3vwFIvnEMzEVpLFlJXgmcAiA+thV3KcA68URt0UBcrBRTkqbpU+eZn51X
         wMGccv2z5g21q8fzEYaHmylphkuEpnRRXMMbub2pT+m0j66jvsNkCpfpVT74oEngxz0g
         3N/w==
X-Forwarded-Encrypted: i=1; AJvYcCWGk3KAIKPmz4UYBVoko/JhgeQ4FuHfWum78a/UI9tSfPOc8wrO8gVEWiLRFE5HUWwzYbB2Vl+d3eb17rqwwas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEs+zMPgsQZ3CJgQG0KS1A8yW9Z6PV5Ym8P5jSZbfq01pNBDgy
	wYSIkxqwLMg3AbGvKBZoQE/Anaq84dQjEkZ8omFaHXsBnyDPBXNH3qp3
X-Gm-Gg: ASbGnctWWdySC5lC7ypQKn9cstuYunOuCM3JWHKZuR/h+J6owGY62byC+Aew++biVy/
	DRm21afLVx4C7d/CvjEtTw09Bghf6G8Q58EneKxvirZ7nNURWm7HPC3Ygzdy1XEmBao0TCsBug4
	zD8fojp4VCI60VQzn2kkoHi1ra++ipM9j+QbCVaIVfUTj6r9vcS0qtSs9POeOVyB68nMWEGMwoa
	SPiFAakvXVobvdSy822xrDi1Z3utNaVtS4U2klDNTYCd4+pLa149WCu/kwvdxaM6OKnxb30zUJc
	eER5R0JshmbwLlpxaRrA+k7Fc+cv2IRFRnXuE4JG38XUk/W7YJwNeY01wxDpHDF4tIikR43EQih
	8Ic1U8NsyTj68u7Uy27vWwCQi9rPa2REh5ok=
X-Google-Smtp-Source: AGHT+IEkhsxEhLSZfQy3k7sFLEhX/tDwtC0J4MzkXu5Dz/C+lrHURinY952j7BmG/n6fx8oK3A6/fg==
X-Received: by 2002:a17:903:1a08:b0:246:a8ad:3f24 with SMTP id d9443c01a7336-246a8ad4130mr81739215ad.7.1756141624869;
        Mon, 25 Aug 2025 10:07:04 -0700 (PDT)
Received: from linux ([223.181.114.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254b8ff608sm7486025a91.29.2025.08.25.10.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:07:04 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: shuah@kernel.org
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH] selftests/mm: use calloc instead of malloc in pagemap_ioctl.c
Date: Mon, 25 Aug 2025 22:36:43 +0530
Message-ID: <20250825170643.63174-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per Documentation/process/deprecated.rst, dynamic size calculations
should not be performed in memory allocator arguments due to possible
overflows.

Replaced malloc with calloc to avoid open-ended arithmetic
and prevent possible overflows.

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
Even though the arguments are small enough an overflow cannot happen,
I think it's still better to follow kernel standard practices.

 tools/testing/selftests/mm/pagemap_ioctl.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 0d4209eef0c3..4e6b815e96b2 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -209,7 +209,7 @@ int userfaultfd_tests(void)
 	wp_addr_range(mem, mem_size);
 
 	vec_size = mem_size/page_size;
-	vec = malloc(sizeof(struct page_region) * vec_size);
+	vec = calloc(vec_size, sizeof(struct page_region));
 
 	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 				vec_size - 2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
@@ -247,11 +247,11 @@ int sanity_tests_sd(void)
 	vec_size = num_pages/2;
 	mem_size = num_pages * page_size;
 
-	vec = malloc(sizeof(struct page_region) * vec_size);
+	vec = calloc(vec_size, sizeof(struct page_region));
 	if (!vec)
 		ksft_exit_fail_msg("error nomem\n");
 
-	vec2 = malloc(sizeof(struct page_region) * vec_size);
+	vec2 = calloc(vec_size, sizeof(struct page_region));
 	if (!vec2)
 		ksft_exit_fail_msg("error nomem\n");
 
@@ -436,7 +436,7 @@ int sanity_tests_sd(void)
 	mem_size = 1050 * page_size;
 	vec_size = mem_size/(page_size*2);
 
-	vec = malloc(sizeof(struct page_region) * vec_size);
+	vec = calloc(vec_size, sizeof(struct page_region));
 	if (!vec)
 		ksft_exit_fail_msg("error nomem\n");
 
@@ -491,7 +491,7 @@ int sanity_tests_sd(void)
 	mem_size = 10000 * page_size;
 	vec_size = 50;
 
-	vec = malloc(sizeof(struct page_region) * vec_size);
+	vec = calloc(vec_size, sizeof(struct page_region));
 	if (!vec)
 		ksft_exit_fail_msg("error nomem\n");
 
@@ -541,7 +541,7 @@ int sanity_tests_sd(void)
 	vec_size = 1000;
 	mem_size = vec_size * page_size;
 
-	vec = malloc(sizeof(struct page_region) * vec_size);
+	vec = calloc(vec_size, sizeof(struct page_region));
 	if (!vec)
 		ksft_exit_fail_msg("error nomem\n");
 
@@ -695,8 +695,8 @@ int base_tests(char *prefix, char *mem, unsigned long long mem_size, int skip)
 	}
 
 	vec_size = mem_size/page_size;
-	vec = malloc(sizeof(struct page_region) * vec_size);
-	vec2 = malloc(sizeof(struct page_region) * vec_size);
+	vec = calloc(vec_size, sizeof(struct page_region));
+	vec2 = calloc(vec_size, sizeof(struct page_region));
 
 	/* 1. all new pages must be not be written (dirty) */
 	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
@@ -807,8 +807,8 @@ int hpage_unit_tests(void)
 	unsigned long long vec_size = map_size/page_size;
 	struct page_region *vec, *vec2;
 
-	vec = malloc(sizeof(struct page_region) * vec_size);
-	vec2 = malloc(sizeof(struct page_region) * vec_size);
+	vec = calloc(vec_size, sizeof(struct page_region));
+	vec2 = calloc(vec_size, sizeof(struct page_region));
 	if (!vec || !vec2)
 		ksft_exit_fail_msg("malloc failed\n");
 
@@ -997,7 +997,7 @@ int unmapped_region_tests(void)
 	void *start = (void *)0x10000000;
 	int written, len = 0x00040000;
 	long vec_size = len / page_size;
-	struct page_region *vec = malloc(sizeof(struct page_region) * vec_size);
+	struct page_region *vec = calloc(vec_size, sizeof(struct page_region));
 
 	/* 1. Get written pages */
 	written = pagemap_ioctl(start, len, vec, vec_size, 0, 0,
@@ -1062,7 +1062,7 @@ int sanity_tests(void)
 	mem_size = 10 * page_size;
 	vec_size = mem_size / page_size;
 
-	vec = malloc(sizeof(struct page_region) * vec_size);
+	vec = calloc(vec_size, sizeof(struct page_region));
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED || vec == MAP_FAILED)
 		ksft_exit_fail_msg("error nomem\n");
-- 
2.50.1


