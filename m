Return-Path: <linux-kselftest+bounces-32089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6FDAA6180
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 18:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B981BC2EAD
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 16:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC96214A7B;
	Thu,  1 May 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwcIAC0g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDB213E6B;
	Thu,  1 May 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117632; cv=none; b=hmqKrUW7EHeO0S1Dkb8RFVjvV8og5qkl1KT5MhFmlia37ApZObS5P0HrcIzR3+Zl3XvTbpGxfD3eAi4HoT8vMd2u1ta5bAagAhVrQTmO7EJJ2pSoYtMfdn1YTGGfz1G04nTh875zDa73d5AnksglUUB4sNDL/I4/T1y1k70d3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117632; c=relaxed/simple;
	bh=10xi8XnFF2pBTeJnAxDi+RXeoSO0HvTFBqqyIUQtz5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDmvQMOkOiQ5L0Xir8wqHGsSjTR9zph34kBDdL78UNFIqWi4DhJIwL78sWPsoUwCriVS6AwBClRF4wKYhLkjKSbxLppWYBhx+wepB0woYbjsq8UVqxG/AKxsyYVcqb3YUxUz7bvjrcJJyeKy5NC1MxdEOQyoFqc2lc1SmVEKBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwcIAC0g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fd89d036so14454195ad.1;
        Thu, 01 May 2025 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746117628; x=1746722428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB5CY2RE6jxRDaA+m+PYgNXEE166rwLgA/ve5XtJU18=;
        b=QwcIAC0gMBppbcIRilOyT0rFjyq8cjaTNvZTo08CZz+56uIyJ0yIkh4hnDB1ytCL1R
         gNDt8qnUvuefBDmA424H5LmrL+NDGSNh43Pnp42ZZB8pEje9QtDaY6EsuVEJ7eNQIcO9
         LQhra2IWjShZ33tfyYfKOxIl9SQ4c66OIIXUMDGHeMKnZwzmIGxTYcIzu8TMlMOFWNJA
         /WSTmnlBMcVQCtOrju3/Dp0DurRZSd+6VkRDedzFD8HGNodbMfaLwTaIaOh5S3jFipPZ
         zyvvYH973O5PVnUvvYqqOYRL1yrh0v1I8T2IOLDSNpe0ueszty/VLeXIw4ITeox7Jn6I
         8vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117628; x=1746722428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB5CY2RE6jxRDaA+m+PYgNXEE166rwLgA/ve5XtJU18=;
        b=MCpr9g7TXdB46cLHGBbr7SJhdg26Zo4sNlzsQrFUK5Tc7JcTuo5vk/s2nOJezadGPd
         tDaQ9vQ1oRx85CujlFXBVD+B5vMf2VLpMpTOVkYVwktvfUG72rgQN8GfRMjpaWN+pv9X
         ioZnxa1oj8QQy8HHUuRcNP6xUP2wFMtHOtVZck4z9QtdRnDMEW+j9ww4KjEpLEDa0Kfv
         dTOmq2T5bY1TMASxQnGH46BYSn8d3m0MRT9ZMOOao/PyiI4jKronSuZIRZHsqulNf/Rm
         Ma25pZczNuJhT+KZebg3kdzqnoXMW7xAmKLiIUCMDXYkaCskUSIKE2ruwh2jPVNvwcXv
         hfcw==
X-Forwarded-Encrypted: i=1; AJvYcCXezFugxGz8y56CYQjSgSKRNgIEiYv+gW0OhqDUQHFD//kguO1rWisFZszVC60qzGyA9U3IS0iMhOdQQYCjYQCT@vger.kernel.org, AJvYcCXhZnBzsIsQIuf7Er0IS3i0WIb2A+ObI9C0uPFQ5dwcEtsqqcxjyZy+NUS0854+0VdTk5pvICZslgr+G8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLQav+dL0GJcYWEd6MZH7AwdCF1zRW6Nitp/wLZZ4kTRAr4IGk
	H6wEbUWjGJku1j4Tw6v+1XSoNHQE/wVXZW1nuCZBUuyQc+2leec=
X-Gm-Gg: ASbGncvut/AT0PYwRHzosGHRE0bjUNsjkKDKqqZ7SKM9CGSUtwRvkcVuadd2W/uP2tL
	SpPsYyWgLll6znWDnb/Mx6Qwh/CXtwpg7Cmf/iSs7neMwefAhZ9xYvdUxrKdBBVL/xWLs4CoEqF
	Yf8beZ4vIMqdLQpNcKqNl5XjR4BQgyrPg2dv6ZS/pBq0kd9xGOHyQMKtU3Nz3eBCGBbhaKdwZZF
	0VL8NaUjOO2MANldWi2yD9LDvgyjXylrck6a9vGTQONhgKvpmT/w5yTX+czlUw8Jwpnw7z4bQ1o
	65e/CNrrYizzO3sQR0tp6ovUhiZmt0CkbdTlCDFC0RUeTIZ5cw==
X-Google-Smtp-Source: AGHT+IFF2XwkPeUfk8rGjs5PW1mV2oDabtGlr3Dx/0Dju9uVUlBdz3MpeuCAI4X/YLR7g6bIrgOsvA==
X-Received: by 2002:a17:903:190:b0:216:6283:5a8c with SMTP id d9443c01a7336-22df58279b8mr106952975ad.39.1746117628251;
        Thu, 01 May 2025 09:40:28 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.132.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e0bc6e678sm8797525ad.132.2025.05.01.09.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:40:27 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: akpm@linux-foundation.org,
	peterx@redhat.com,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: [PATCH 3/4] selftests/mm/uffd: Swap global variables with global test opts
Date: Thu,  1 May 2025 22:08:26 +0530
Message-Id: <20250501163827.2598-4-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250501163827.2598-1-ujwal.kundur@gmail.com>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use the refactored uffd_global_test_opts instead of global variables
for uffd-unit-tests.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 523 ++++++++++---------
 1 file changed, 269 insertions(+), 254 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index e8fd9011c2a3..86ecf21e0722 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -76,7 +76,7 @@ struct uffd_test_args {
 typedef struct uffd_test_args uffd_test_args_t;
 
 /* Returns: UFFD_TEST_* */
-typedef void (*uffd_test_fn)(uffd_test_args_t *);
+typedef void (*uffd_test_fn)(uffd_global_test_opts_t *, uffd_test_args_t *);
 
 typedef struct {
 	const char *name;
@@ -181,33 +181,6 @@ static int test_uffd_api(bool use_dev)
 	return 1;
 }
 
-/*
- * This function initializes the global variables.  TODO: remove global
- * vars and then remove this.
- */
-static int
-uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
-		       mem_type_t *mem_type, const char **errmsg)
-{
-	map_shared = mem_type->shared;
-	uffd_test_ops = mem_type->mem_ops;
-	uffd_test_case_ops = test->test_case_ops;
-
-	if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
-		page_size = default_huge_page_size();
-	else
-		page_size = psize();
-
-	/* Ensure we have at least 2 pages */
-	nr_pages = MAX(UFFD_TEST_MEM_SIZE, page_size * 2) / page_size;
-	/* TODO: remove this global var.. it's so ugly */
-	nr_parallel = 1;
-
-	/* Initialize test arguments */
-	args->mem_type = mem_type;
-
-	return uffd_test_ctx_init(test->uffd_feature_required, errmsg);
-}
 
 static bool uffd_feature_supported(uffd_test_case_t *test)
 {
@@ -237,7 +210,8 @@ static int pagemap_open(void)
 	} while (0)
 
 typedef struct {
-	int parent_uffd, child_uffd;
+	uffd_global_test_opts_t *gopts;
+	int child_uffd;
 } fork_event_args;
 
 static void *fork_event_consumer(void *data)
@@ -245,10 +219,10 @@ static void *fork_event_consumer(void *data)
 	fork_event_args *args = data;
 	struct uffd_msg msg = { 0 };
 
-	ready_for_fork = true;
+	args->gopts->ready_for_fork = true;
 
 	/* Read until a full msg received */
-	while (uffd_read_msg(args->parent_uffd, &msg));
+	while (uffd_read_msg(args->gopts, &msg));
 
 	if (msg.event != UFFD_EVENT_FORK)
 		err("wrong message: %u\n", msg.event);
@@ -304,9 +278,9 @@ static void unpin_pages(pin_args *args)
 	args->pinned = false;
 }
 
-static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
+static int pagemap_test_fork(uffd_global_test_opts_t *gopts, bool with_event, bool test_pin)
 {
-	fork_event_args args = { .parent_uffd = uffd, .child_uffd = -1 };
+	fork_event_args args = { .gopts = gopts, .child_uffd = -1 };
 	pthread_t thread;
 	pid_t child;
 	uint64_t value;
@@ -314,10 +288,10 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 
 	/* Prepare a thread to resolve EVENT_FORK */
 	if (with_event) {
-		ready_for_fork = false;
+		gopts->ready_for_fork = false;
 		if (pthread_create(&thread, NULL, fork_event_consumer, &args))
 			err("pthread_create()");
-		while (!ready_for_fork)
+		while (!gopts->ready_for_fork)
 			; /* Wait for the poll_thread to start executing before forking */
 	}
 
@@ -328,14 +302,14 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 
 		fd = pagemap_open();
 
-		if (test_pin && pin_pages(&args, area_dst, page_size))
+		if (test_pin && pin_pages(&args, gopts->area_dst, gopts->page_size))
 			/*
 			 * Normally when reach here we have pinned in
 			 * previous tests, so shouldn't fail anymore
 			 */
 			err("pin page failed in child");
 
-		value = pagemap_get_entry(fd, area_dst);
+		value = pagemap_get_entry(fd, gopts->area_dst);
 		/*
 		 * After fork(), we should handle uffd-wp bit differently:
 		 *
@@ -361,70 +335,70 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
 	return result;
 }
 
-static void uffd_wp_unpopulated_test(uffd_test_args_t *args)
+static void uffd_wp_unpopulated_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
 	uint64_t value;
 	int pagemap_fd;
 
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
 			  false, true, false))
 		err("register failed");
 
 	pagemap_fd = pagemap_open();
 
 	/* Test applying pte marker to anon unpopulated */
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, true);
 
 	/* Test unprotect on anon pte marker */
-	wp_range(uffd, (uint64_t)area_dst, page_size, false);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, false);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Test zap on anon marker */
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	if (madvise(area_dst, page_size, MADV_DONTNEED))
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
+	if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
 		err("madvise(MADV_DONTNEED) failed");
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Test fault in after marker removed */
-	*area_dst = 1;
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	*gopts->area_dst = 1;
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, false);
 	/* Drop it to make pte none again */
-	if (madvise(area_dst, page_size, MADV_DONTNEED))
+	if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
 		err("madvise(MADV_DONTNEED) failed");
 
 	/* Test read-zero-page upon pte marker */
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	*(volatile char *)area_dst;
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
+	*(volatile char *)gopts->area_dst;
 	/* Drop it to make pte none again */
-	if (madvise(area_dst, page_size, MADV_DONTNEED))
+	if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
 		err("madvise(MADV_DONTNEED) failed");
 
 	uffd_test_pass();
 }
 
-static void uffd_wp_fork_test_common(uffd_test_args_t *args,
+static void uffd_wp_fork_test_common(uffd_global_test_opts_t *gopts, uffd_test_args_t *args,
 				     bool with_event)
 {
 	int pagemap_fd;
 	uint64_t value;
 
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
 			  false, true, false))
 		err("register failed");
 
 	pagemap_fd = pagemap_open();
 
 	/* Touch the page */
-	*area_dst = 1;
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	*gopts->area_dst = 1;
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, true);
-	if (pagemap_test_fork(uffd, with_event, false)) {
+	if (pagemap_test_fork(gopts, with_event, false)) {
 		uffd_test_fail("Detected %s uffd-wp bit in child in present pte",
 			       with_event ? "missing" : "stall");
 		goto out;
@@ -442,79 +416,79 @@ static void uffd_wp_fork_test_common(uffd_test_args_t *args,
 	 * to expose pte markers.
 	 */
 	if (args->mem_type->shared) {
-		if (madvise(area_dst, page_size, MADV_DONTNEED))
+		if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
 			err("MADV_DONTNEED");
 	} else {
 		/*
 		 * NOTE: ignore retval because private-hugetlb doesn't yet
 		 * support swapping, so it could fail.
 		 */
-		madvise(area_dst, page_size, MADV_PAGEOUT);
+		madvise(gopts->area_dst, gopts->page_size, MADV_PAGEOUT);
 	}
 
 	/* Uffd-wp should persist even swapped out */
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, true);
-	if (pagemap_test_fork(uffd, with_event, false)) {
+	if (pagemap_test_fork(gopts, with_event, false)) {
 		uffd_test_fail("Detected %s uffd-wp bit in child in zapped pte",
 			       with_event ? "missing" : "stall");
 		goto out;
 	}
 
 	/* Unprotect; this tests swap pte modifications */
-	wp_range(uffd, (uint64_t)area_dst, page_size, false);
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, false);
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Fault in the page from disk */
-	*area_dst = 2;
-	value = pagemap_get_entry(pagemap_fd, area_dst);
+	*gopts->area_dst = 2;
+	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
 	pagemap_check_wp(value, false);
 	uffd_test_pass();
 out:
-	if (uffd_unregister(uffd, area_dst, nr_pages * page_size))
+	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size))
 		err("unregister failed");
 	close(pagemap_fd);
 }
 
-static void uffd_wp_fork_test(uffd_test_args_t *args)
+static void uffd_wp_fork_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_wp_fork_test_common(args, false);
+	uffd_wp_fork_test_common(gopts, args, false);
 }
 
-static void uffd_wp_fork_with_event_test(uffd_test_args_t *args)
+static void uffd_wp_fork_with_event_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_wp_fork_test_common(args, true);
+	uffd_wp_fork_test_common(gopts, args, true);
 }
 
-static void uffd_wp_fork_pin_test_common(uffd_test_args_t *args,
-					 bool with_event)
+static void uffd_wp_fork_pin_test_common(uffd_global_test_opts_t *gopts,
+		uffd_test_args_t *args, bool with_event)
 {
 	int pagemap_fd;
 	pin_args pin_args = {};
 
-	if (uffd_register(uffd, area_dst, page_size, false, true, false))
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->page_size, false, true, false))
 		err("register failed");
 
 	pagemap_fd = pagemap_open();
 
 	/* Touch the page */
-	*area_dst = 1;
-	wp_range(uffd, (uint64_t)area_dst, page_size, true);
+	*gopts->area_dst = 1;
+	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
 
 	/*
 	 * 1. First pin, then fork().  This tests fork() special path when
 	 * doing early CoW if the page is private.
 	 */
-	if (pin_pages(&pin_args, area_dst, page_size)) {
+	if (pin_pages(&pin_args, gopts->area_dst, gopts->page_size)) {
 		uffd_test_skip("Possibly CONFIG_GUP_TEST missing "
 			       "or unprivileged");
 		close(pagemap_fd);
-		uffd_unregister(uffd, area_dst, page_size);
+		uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size);
 		return;
 	}
 
-	if (pagemap_test_fork(uffd, with_event, false)) {
+	if (pagemap_test_fork(gopts, with_event, false)) {
 		uffd_test_fail("Detected %s uffd-wp bit in early CoW of fork()",
 			       with_event ? "missing" : "stall");
 		unpin_pages(&pin_args);
@@ -527,49 +501,50 @@ static void uffd_wp_fork_pin_test_common(uffd_test_args_t *args,
 	 * 2. First fork(), then pin (in the child, where test_pin==true).
 	 * This tests COR, aka, page unsharing on private memories.
 	 */
-	if (pagemap_test_fork(uffd, with_event, true)) {
+	if (pagemap_test_fork(gopts, with_event, true)) {
 		uffd_test_fail("Detected %s uffd-wp bit when RO pin",
 			       with_event ? "missing" : "stall");
 		goto out;
 	}
 	uffd_test_pass();
 out:
-	if (uffd_unregister(uffd, area_dst, page_size))
+	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size))
 		err("register failed");
 	close(pagemap_fd);
 }
 
-static void uffd_wp_fork_pin_test(uffd_test_args_t *args)
+static void uffd_wp_fork_pin_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_wp_fork_pin_test_common(args, false);
+	uffd_wp_fork_pin_test_common(gopts, args, false);
 }
 
-static void uffd_wp_fork_pin_with_event_test(uffd_test_args_t *args)
+static void uffd_wp_fork_pin_with_event_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_wp_fork_pin_test_common(args, true);
+	uffd_wp_fork_pin_test_common(gopts, args, true);
 }
 
-static void check_memory_contents(char *p)
+static void check_memory_contents(uffd_global_test_opts_t *gopts, char *p)
 {
 	unsigned long i, j;
 	uint8_t expected_byte;
 
-	for (i = 0; i < nr_pages; ++i) {
+	for (i = 0; i < gopts->nr_pages; ++i) {
 		expected_byte = ~((uint8_t)(i % ((uint8_t)-1)));
-		for (j = 0; j < page_size; j++) {
-			uint8_t v = *(uint8_t *)(p + (i * page_size) + j);
+		for (j = 0; j < gopts->page_size; j++) {
+			uint8_t v = *(uint8_t *)(p + (i * gopts->page_size) + j);
 			if (v != expected_byte)
 				err("unexpected page contents");
 		}
 	}
 }
 
-static void uffd_minor_test_common(bool test_collapse, bool test_wp)
+static void uffd_minor_test_common(uffd_global_test_opts_t *gopts, bool test_collapse, bool test_wp)
 {
 	unsigned long p;
 	pthread_t uffd_mon;
 	char c;
 	struct uffd_args args = { 0 };
+	args.gopts = gopts;
 
 	/*
 	 * NOTE: MADV_COLLAPSE is not yet compatible with WP, so testing
@@ -577,7 +552,7 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
 	 */
 	assert(!(test_collapse && test_wp));
 
-	if (uffd_register(uffd, area_dst_alias, nr_pages * page_size,
+	if (uffd_register(gopts->uffd, gopts->area_dst_alias, gopts->nr_pages * gopts->page_size,
 			  /* NOTE! MADV_COLLAPSE may not work with uffd-wp */
 			  false, test_wp, true))
 		err("register failure");
@@ -586,9 +561,9 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
 	 * After registering with UFFD, populate the non-UFFD-registered side of
 	 * the shared mapping. This should *not* trigger any UFFD minor faults.
 	 */
-	for (p = 0; p < nr_pages; ++p)
-		memset(area_dst + (p * page_size), p % ((uint8_t)-1),
-		       page_size);
+	for (p = 0; p < gopts->nr_pages; ++p)
+		memset(gopts->area_dst + (p * gopts->page_size), p % ((uint8_t)-1),
+		       gopts->page_size);
 
 	args.apply_wp = test_wp;
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
@@ -600,50 +575,51 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
 	 * fault. uffd_poll_thread will resolve the fault by bit-flipping the
 	 * page's contents, and then issuing a CONTINUE ioctl.
 	 */
-	check_memory_contents(area_dst_alias);
+	check_memory_contents(gopts, gopts->area_dst_alias);
 
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
 		err("pipe write");
 	if (pthread_join(uffd_mon, NULL))
 		err("join() failed");
 
 	if (test_collapse) {
-		if (madvise(area_dst_alias, nr_pages * page_size,
+		if (madvise(gopts->area_dst_alias, gopts->nr_pages * gopts->page_size,
 			    MADV_COLLAPSE)) {
 			/* It's fine to fail for this one... */
 			uffd_test_skip("MADV_COLLAPSE failed");
 			return;
 		}
 
-		uffd_test_ops->check_pmd_mapping(area_dst,
-						 nr_pages * page_size /
+		uffd_test_ops->check_pmd_mapping(gopts,
+						 gopts->area_dst,
+						 gopts->nr_pages * gopts->page_size /
 						 read_pmd_pagesize());
 		/*
 		 * This won't cause uffd-fault - it purely just makes sure there
 		 * was no corruption.
 		 */
-		check_memory_contents(area_dst_alias);
+		check_memory_contents(gopts, gopts->area_dst_alias);
 	}
 
-	if (args.missing_faults != 0 || args.minor_faults != nr_pages)
+	if (args.missing_faults != 0 || args.minor_faults != gopts->nr_pages)
 		uffd_test_fail("stats check error");
 	else
 		uffd_test_pass();
 }
 
-void uffd_minor_test(uffd_test_args_t *args)
+void uffd_minor_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_minor_test_common(false, false);
+	uffd_minor_test_common(gopts, false, false);
 }
 
-void uffd_minor_wp_test(uffd_test_args_t *args)
+void uffd_minor_wp_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_minor_test_common(false, true);
+	uffd_minor_test_common(gopts, false, true);
 }
 
-void uffd_minor_collapse_test(uffd_test_args_t *args)
+void uffd_minor_collapse_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_minor_test_common(true, false);
+	uffd_minor_test_common(gopts, true, false);
 }
 
 static sigjmp_buf jbuf, *sigbuf;
@@ -678,7 +654,7 @@ static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
  * This also tests UFFD_FEATURE_EVENT_FORK event along with the signal
  * feature. Using monitor thread, verify no userfault events are generated.
  */
-static int faulting_process(int signal_test, bool wp)
+static int faulting_process(uffd_global_test_opts_t *gopts, int signal_test, bool wp)
 {
 	unsigned long nr, i;
 	unsigned long long count;
@@ -687,7 +663,7 @@ static int faulting_process(int signal_test, bool wp)
 	struct sigaction act;
 	volatile unsigned long signalled = 0;
 
-	split_nr_pages = (nr_pages + 1) / 2;
+	split_nr_pages = (gopts->nr_pages + 1) / 2;
 
 	if (signal_test) {
 		sigbuf = &jbuf;
@@ -701,7 +677,7 @@ static int faulting_process(int signal_test, bool wp)
 
 	for (nr = 0; nr < split_nr_pages; nr++) {
 		volatile int steps = 1;
-		unsigned long offset = nr * page_size;
+		unsigned long offset = nr * gopts->page_size;
 
 		if (signal_test) {
 			if (sigsetjmp(*sigbuf, 1) != 0) {
@@ -713,15 +689,15 @@ static int faulting_process(int signal_test, bool wp)
 					if (steps == 1) {
 						/* This is a MISSING request */
 						steps++;
-						if (copy_page(uffd, offset, wp))
+						if (copy_page(gopts, offset, wp))
 							signalled++;
 					} else {
 						/* This is a WP request */
 						assert(steps == 2);
-						wp_range(uffd,
-							 (__u64)area_dst +
+						wp_range(gopts->uffd,
+							 (__u64)gopts->area_dst +
 							 offset,
-							 page_size, false);
+							 gopts->page_size, false);
 					}
 				} else {
 					signalled++;
@@ -730,51 +706,53 @@ static int faulting_process(int signal_test, bool wp)
 			}
 		}
 
-		count = *area_count(area_dst, nr);
-		if (count != count_verify[nr])
+		count = *area_count(gopts->area_dst, nr, gopts);
+		if (count != gopts->count_verify[nr])
 			err("nr %lu memory corruption %llu %llu\n",
-			    nr, count, count_verify[nr]);
+			    nr, count, gopts->count_verify[nr]);
 		/*
 		 * Trigger write protection if there is by writing
 		 * the same value back.
 		 */
-		*area_count(area_dst, nr) = count;
+		*area_count(gopts->area_dst, nr, gopts) = count;
 	}
 
 	if (signal_test)
 		return signalled != split_nr_pages;
 
-	area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
-			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
-	if (area_dst == MAP_FAILED)
+	gopts->area_dst = mremap(gopts->area_dst, gopts->nr_pages * gopts->page_size,
+							gopts->nr_pages * gopts->page_size,
+							MREMAP_MAYMOVE | MREMAP_FIXED,
+							gopts->area_src);
+	if (gopts->area_dst == MAP_FAILED)
 		err("mremap");
 	/* Reset area_src since we just clobbered it */
-	area_src = NULL;
+	gopts->area_src = NULL;
 
-	for (; nr < nr_pages; nr++) {
-		count = *area_count(area_dst, nr);
-		if (count != count_verify[nr]) {
+	for (; nr < gopts->nr_pages; nr++) {
+		count = *area_count(gopts->area_dst, nr, gopts);
+		if (count != gopts->count_verify[nr]) {
 			err("nr %lu memory corruption %llu %llu\n",
-			    nr, count, count_verify[nr]);
+			    nr, count, gopts->count_verify[nr]);
 		}
 		/*
 		 * Trigger write protection if there is by writing
 		 * the same value back.
 		 */
-		*area_count(area_dst, nr) = count;
+		*area_count(gopts->area_dst, nr, gopts) = count;
 	}
 
-	uffd_test_ops->release_pages(area_dst);
+	uffd_test_ops->release_pages(gopts, gopts->area_dst);
 
-	for (nr = 0; nr < nr_pages; nr++)
-		for (i = 0; i < page_size; i++)
-			if (*(area_dst + nr * page_size + i) != 0)
+	for (nr = 0; nr < gopts->nr_pages; nr++)
+		for (i = 0; i < gopts->page_size; i++)
+			if (*(gopts->area_dst + nr * gopts->page_size + i) != 0)
 				err("page %lu offset %lu is not zero", nr, i);
 
 	return 0;
 }
 
-static void uffd_sigbus_test_common(bool wp)
+static void uffd_sigbus_test_common(uffd_global_test_opts_t *gopts, bool wp)
 {
 	unsigned long userfaults;
 	pthread_t uffd_mon;
@@ -782,25 +760,26 @@ static void uffd_sigbus_test_common(bool wp)
 	int err;
 	char c;
 	struct uffd_args args = { 0 };
+	args.gopts = gopts;
 
-	ready_for_fork = false;
+	gopts->ready_for_fork = false;
 
-	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
+	fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags | O_NONBLOCK);
 
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
 			  true, wp, false))
 		err("register failure");
 
-	if (faulting_process(1, wp))
+	if (faulting_process(gopts, 1, wp))
 		err("faulting process failed");
 
-	uffd_test_ops->release_pages(area_dst);
+	uffd_test_ops->release_pages(gopts, gopts->area_dst);
 
 	args.apply_wp = wp;
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	while (!ready_for_fork)
+	while (!gopts->ready_for_fork)
 		; /* Wait for the poll_thread to start executing before forking */
 
 	pid = fork();
@@ -808,12 +787,12 @@ static void uffd_sigbus_test_common(bool wp)
 		err("fork");
 
 	if (!pid)
-		exit(faulting_process(2, wp));
+		exit(faulting_process(gopts, 2, wp));
 
 	waitpid(pid, &err, 0);
 	if (err)
 		err("faulting process failed");
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
 		err("pipe write");
 	if (pthread_join(uffd_mon, (void **)&userfaults))
 		err("pthread_join()");
@@ -824,28 +803,29 @@ static void uffd_sigbus_test_common(bool wp)
 		uffd_test_pass();
 }
 
-static void uffd_sigbus_test(uffd_test_args_t *args)
+static void uffd_sigbus_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_sigbus_test_common(false);
+	uffd_sigbus_test_common(gopts, false);
 }
 
-static void uffd_sigbus_wp_test(uffd_test_args_t *args)
+static void uffd_sigbus_wp_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_sigbus_test_common(true);
+	uffd_sigbus_test_common(gopts, true);
 }
 
-static void uffd_events_test_common(bool wp)
+static void uffd_events_test_common(uffd_global_test_opts_t *gopts, bool wp)
 {
 	pthread_t uffd_mon;
 	pid_t pid;
 	int err;
 	char c;
 	struct uffd_args args = { 0 };
+	args.gopts = gopts;
 
-	ready_for_fork = false;
+	gopts->ready_for_fork = false;
 
-	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+	fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags | O_NONBLOCK);
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
 			  true, wp, false))
 		err("register failure");
 
@@ -853,7 +833,7 @@ static void uffd_events_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	while (!ready_for_fork)
+	while (!gopts->ready_for_fork)
 		; /* Wait for the poll_thread to start executing before forking */
 
 	pid = fork();
@@ -861,39 +841,39 @@ static void uffd_events_test_common(bool wp)
 		err("fork");
 
 	if (!pid)
-		exit(faulting_process(0, wp));
+		exit(faulting_process(gopts, 0, wp));
 
 	waitpid(pid, &err, 0);
 	if (err)
 		err("faulting process failed");
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
 		err("pipe write");
 	if (pthread_join(uffd_mon, NULL))
 		err("pthread_join()");
 
-	if (args.missing_faults != nr_pages)
+	if (args.missing_faults != gopts->nr_pages)
 		uffd_test_fail("Fault counts wrong");
 	else
 		uffd_test_pass();
 }
 
-static void uffd_events_test(uffd_test_args_t *args)
+static void uffd_events_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_events_test_common(false);
+	uffd_events_test_common(gopts, false);
 }
 
-static void uffd_events_wp_test(uffd_test_args_t *args)
+static void uffd_events_wp_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
-	uffd_events_test_common(true);
+	uffd_events_test_common(gopts, true);
 }
 
-static void retry_uffdio_zeropage(int ufd,
+static void retry_uffdio_zeropage(uffd_global_test_opts_t *gopts,
 				  struct uffdio_zeropage *uffdio_zeropage)
 {
-	uffd_test_ops->alias_mapping(&uffdio_zeropage->range.start,
+	uffd_test_ops->alias_mapping(gopts, &uffdio_zeropage->range.start,
 				     uffdio_zeropage->range.len,
 				     0);
-	if (ioctl(ufd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
+	if (ioctl(gopts->uffd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
 		if (uffdio_zeropage->zeropage != -EEXIST)
 			err("UFFDIO_ZEROPAGE error: %"PRId64,
 			    (int64_t)uffdio_zeropage->zeropage);
@@ -903,16 +883,16 @@ static void retry_uffdio_zeropage(int ufd,
 	}
 }
 
-static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
+static bool do_uffdio_zeropage(uffd_global_test_opts_t *gopts, bool has_zeropage)
 {
 	struct uffdio_zeropage uffdio_zeropage = { 0 };
 	int ret;
 	__s64 res;
 
-	uffdio_zeropage.range.start = (unsigned long) area_dst;
-	uffdio_zeropage.range.len = page_size;
+	uffdio_zeropage.range.start = (unsigned long) gopts->area_dst;
+	uffdio_zeropage.range.len = gopts->page_size;
 	uffdio_zeropage.mode = 0;
-	ret = ioctl(ufd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
+	ret = ioctl(gopts->uffd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
 	res = uffdio_zeropage.zeropage;
 	if (ret) {
 		/* real retval in ufdio_zeropage.zeropage */
@@ -921,10 +901,10 @@ static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
 		else if (res != -EINVAL)
 			err("UFFDIO_ZEROPAGE not -EINVAL");
 	} else if (has_zeropage) {
-		if (res != page_size)
+		if (res != gopts->page_size)
 			err("UFFDIO_ZEROPAGE unexpected size");
 		else
-			retry_uffdio_zeropage(ufd, &uffdio_zeropage);
+			retry_uffdio_zeropage(gopts, &uffdio_zeropage);
 		return true;
 	} else
 		err("UFFDIO_ZEROPAGE succeeded");
@@ -950,25 +930,27 @@ uffd_register_detect_zeropage(int uffd, void *addr, uint64_t len)
 }
 
 /* exercise UFFDIO_ZEROPAGE */
-static void uffd_zeropage_test(uffd_test_args_t *args)
+static void uffd_zeropage_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
 	bool has_zeropage;
 	int i;
 
-	has_zeropage = uffd_register_detect_zeropage(uffd, area_dst, page_size);
-	if (area_dst_alias)
+	has_zeropage = uffd_register_detect_zeropage(gopts->uffd, gopts->area_dst, gopts->page_size);
+	if (gopts->area_dst_alias)
 		/* Ignore the retval; we already have it */
-		uffd_register_detect_zeropage(uffd, area_dst_alias, page_size);
+		uffd_register_detect_zeropage(gopts->uffd, gopts->area_dst_alias, gopts->page_size);
 
-	if (do_uffdio_zeropage(uffd, has_zeropage))
-		for (i = 0; i < page_size; i++)
-			if (area_dst[i] != 0)
+	if (do_uffdio_zeropage(gopts, has_zeropage))
+		for (i = 0; i < gopts->page_size; i++)
+			if (gopts->area_dst[i] != 0)
 				err("data non-zero at offset %d\n", i);
 
-	if (uffd_unregister(uffd, area_dst, page_size))
+	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size))
 		err("unregister");
 
-	if (area_dst_alias && uffd_unregister(uffd, area_dst_alias, page_size))
+	if (gopts->area_dst_alias
+			&&
+		uffd_unregister(gopts->uffd, gopts->area_dst_alias, gopts->page_size))
 		err("unregister");
 
 	uffd_test_pass();
@@ -987,26 +969,26 @@ static void uffd_register_poison(int uffd, void *addr, uint64_t len)
 		err("registered area doesn't support COPY and POISON ioctls");
 }
 
-static void do_uffdio_poison(int uffd, unsigned long offset)
+static void do_uffdio_poison(uffd_global_test_opts_t *gopts, unsigned long offset)
 {
 	struct uffdio_poison uffdio_poison = { 0 };
 	int ret;
 	__s64 res;
 
-	uffdio_poison.range.start = (unsigned long) area_dst + offset;
-	uffdio_poison.range.len = page_size;
+	uffdio_poison.range.start = (unsigned long) gopts->area_dst + offset;
+	uffdio_poison.range.len = gopts->page_size;
 	uffdio_poison.mode = 0;
-	ret = ioctl(uffd, UFFDIO_POISON, &uffdio_poison);
+	ret = ioctl(gopts->uffd, UFFDIO_POISON, &uffdio_poison);
 	res = uffdio_poison.updated;
 
 	if (ret)
 		err("UFFDIO_POISON error: %"PRId64, (int64_t)res);
-	else if (res != page_size)
+	else if (res != gopts->page_size)
 		err("UFFDIO_POISON unexpected size: %"PRId64, (int64_t)res);
 }
 
 static void uffd_poison_handle_fault(
-	struct uffd_msg *msg, struct uffd_args *args)
+	uffd_global_test_opts_t *gopts, struct uffd_msg *msg, struct uffd_args *args)
 {
 	unsigned long offset;
 
@@ -1017,17 +999,17 @@ static void uffd_poison_handle_fault(
 	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR))
 		err("unexpected fault type %llu", msg->arg.pagefault.flags);
 
-	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
-	offset &= ~(page_size-1);
+	offset = (char *)(unsigned long)msg->arg.pagefault.address - gopts->area_dst;
+	offset &= ~(gopts->page_size-1);
 
 	/* Odd pages -> copy zeroed page; even pages -> poison. */
-	if (offset & page_size)
-		copy_page(uffd, offset, false);
+	if (offset & gopts->page_size)
+		copy_page(gopts, offset, false);
 	else
-		do_uffdio_poison(uffd, offset);
+		do_uffdio_poison(gopts, offset);
 }
 
-static void uffd_poison_test(uffd_test_args_t *targs)
+static void uffd_poison_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
 {
 	pthread_t uffd_mon;
 	char c;
@@ -1036,10 +1018,12 @@ static void uffd_poison_test(uffd_test_args_t *targs)
 	unsigned long nr_sigbus = 0;
 	unsigned long nr;
 
-	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
+	args.gopts = gopts;
 
-	uffd_register_poison(uffd, area_dst, nr_pages * page_size);
-	memset(area_src, 0, nr_pages * page_size);
+	fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags | O_NONBLOCK);
+
+	uffd_register_poison(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size);
+	memset(gopts->area_src, 0, gopts->nr_pages * gopts->page_size);
 
 	args.handle_fault = uffd_poison_handle_fault;
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
@@ -1051,9 +1035,9 @@ static void uffd_poison_test(uffd_test_args_t *targs)
 	if (sigaction(SIGBUS, &act, 0))
 		err("sigaction");
 
-	for (nr = 0; nr < nr_pages; ++nr) {
-		unsigned long offset = nr * page_size;
-		const char *bytes = (const char *) area_dst + offset;
+	for (nr = 0; nr < gopts->nr_pages; ++nr) {
+		unsigned long offset = nr * gopts->page_size;
+		const char *bytes = (const char *) gopts->area_dst + offset;
 		const char *i;
 
 		if (sigsetjmp(*sigbuf, 1)) {
@@ -1066,28 +1050,30 @@ static void uffd_poison_test(uffd_test_args_t *targs)
 			continue;
 		}
 
-		for (i = bytes; i < bytes + page_size; ++i) {
+		for (i = bytes; i < bytes + gopts->page_size; ++i) {
 			if (*i)
 				err("nonzero byte in area_dst (%p) at %p: %u",
-				    area_dst, i, *i);
+				    gopts->area_dst, i, *i);
 		}
 	}
 
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
 		err("pipe write");
 	if (pthread_join(uffd_mon, NULL))
 		err("pthread_join()");
 
-	if (nr_sigbus != nr_pages / 2)
+	if (nr_sigbus != gopts->nr_pages / 2)
 		err("expected to receive %lu SIGBUS, actually received %lu",
-		    nr_pages / 2, nr_sigbus);
+		    gopts->nr_pages / 2, nr_sigbus);
 
 	uffd_test_pass();
 }
 
 static void
-uffd_move_handle_fault_common(struct uffd_msg *msg, struct uffd_args *args,
-			      unsigned long len)
+uffd_move_handle_fault_common(uffd_global_test_opts_t *gopts,
+							struct uffd_msg *msg,
+							struct uffd_args *args,
+							unsigned long len)
 {
 	unsigned long offset;
 
@@ -1098,28 +1084,31 @@ uffd_move_handle_fault_common(struct uffd_msg *msg, struct uffd_args *args,
 	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR | UFFD_PAGEFAULT_FLAG_WRITE))
 		err("unexpected fault type %llu", msg->arg.pagefault.flags);
 
-	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+	offset = (char *)(unsigned long)msg->arg.pagefault.address - gopts->area_dst;
 	offset &= ~(len-1);
 
-	if (move_page(uffd, offset, len))
+	if (move_page(gopts, offset, len))
 		args->missing_faults++;
 }
 
-static void uffd_move_handle_fault(struct uffd_msg *msg,
+static void uffd_move_handle_fault(uffd_global_test_opts_t *gopts, struct uffd_msg *msg,
 				   struct uffd_args *args)
 {
-	uffd_move_handle_fault_common(msg, args, page_size);
+	uffd_move_handle_fault_common(gopts, msg, args, gopts->page_size);
 }
 
-static void uffd_move_pmd_handle_fault(struct uffd_msg *msg,
+static void uffd_move_pmd_handle_fault(uffd_global_test_opts_t *gopts, struct uffd_msg *msg,
 				       struct uffd_args *args)
 {
-	uffd_move_handle_fault_common(msg, args, read_pmd_pagesize());
+	uffd_move_handle_fault_common(gopts, msg, args, read_pmd_pagesize());
 }
 
 static void
-uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
-		      void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args))
+uffd_move_test_common(
+		uffd_global_test_opts_t *gopts, uffd_test_args_t *targs,
+		unsigned long chunk_size, void (*handle_fault)(struct uffd_global_test_opts *gopts,
+		struct uffd_msg *msg, struct uffd_args *args)
+)
 {
 	unsigned long nr;
 	pthread_t uffd_mon;
@@ -1131,11 +1120,13 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 	unsigned long src_offs = 0;
 	unsigned long dst_offs = 0;
 
+	args.gopts = gopts;
+
 	/* Prevent source pages from being mapped more than once */
-	if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
+	if (madvise(gopts->area_src, gopts->nr_pages * gopts->page_size, MADV_DONTFORK))
 		err("madvise(MADV_DONTFORK) failure");
 
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
 			  true, false, false))
 		err("register failure");
 
@@ -1143,22 +1134,22 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	step_size = chunk_size / page_size;
-	step_count = nr_pages / step_size;
+	step_size = chunk_size / gopts->page_size;
+	step_count = gopts->nr_pages / step_size;
 
-	if (chunk_size > page_size) {
-		char *aligned_src = ALIGN_UP(area_src, chunk_size);
-		char *aligned_dst = ALIGN_UP(area_dst, chunk_size);
+	if (chunk_size > gopts->page_size) {
+		char *aligned_src = ALIGN_UP(gopts->area_src, chunk_size);
+		char *aligned_dst = ALIGN_UP(gopts->area_dst, chunk_size);
 
-		if (aligned_src != area_src || aligned_dst != area_dst) {
-			src_offs = (aligned_src - area_src) / page_size;
-			dst_offs = (aligned_dst - area_dst) / page_size;
+		if (aligned_src != gopts->area_src || aligned_dst != gopts->area_dst) {
+			src_offs = (aligned_src - gopts->area_src) / gopts->page_size;
+			dst_offs = (aligned_dst - gopts->area_dst) / gopts->page_size;
 			step_count--;
 		}
-		orig_area_src = area_src;
-		orig_area_dst = area_dst;
-		area_src = aligned_src;
-		area_dst = aligned_dst;
+		orig_area_src = gopts->area_src;
+		orig_area_dst = gopts->area_dst;
+		gopts->area_src = aligned_src;
+		gopts->area_dst = aligned_dst;
 	}
 
 	/*
@@ -1172,34 +1163,34 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 
 		/* Check area_src content */
 		for (i = 0; i < step_size; i++) {
-			count = *area_count(area_src, nr + i);
-			if (count != count_verify[src_offs + nr + i])
+			count = *area_count(gopts->area_src, nr + i, gopts);
+			if (count != gopts->count_verify[src_offs + nr + i])
 				err("nr %lu source memory invalid %llu %llu\n",
-				    nr + i, count, count_verify[src_offs + nr + i]);
+				    nr + i, count, gopts->count_verify[src_offs + nr + i]);
 		}
 
 		/* Faulting into area_dst should move the page or the huge page */
 		for (i = 0; i < step_size; i++) {
-			count = *area_count(area_dst, nr + i);
-			if (count != count_verify[dst_offs + nr + i])
+			count = *area_count(gopts->area_dst, nr + i, gopts);
+			if (count != gopts->count_verify[dst_offs + nr + i])
 				err("nr %lu memory corruption %llu %llu\n",
-				    nr, count, count_verify[dst_offs + nr + i]);
+				    nr, count, gopts->count_verify[dst_offs + nr + i]);
 		}
 
 		/* Re-check area_src content which should be empty */
 		for (i = 0; i < step_size; i++) {
-			count = *area_count(area_src, nr + i);
+			count = *area_count(gopts->area_src, nr + i, gopts);
 			if (count != 0)
 				err("nr %lu move failed %llu %llu\n",
-				    nr, count, count_verify[src_offs + nr + i]);
+				    nr, count, gopts->count_verify[src_offs + nr + i]);
 		}
 	}
-	if (chunk_size > page_size) {
-		area_src = orig_area_src;
-		area_dst = orig_area_dst;
+	if (chunk_size > gopts->page_size) {
+		gopts->area_src = orig_area_src;
+		gopts->area_dst = orig_area_dst;
 	}
 
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
 		err("pipe write");
 	if (pthread_join(uffd_mon, NULL))
 		err("join() failed");
@@ -1210,31 +1201,31 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 		uffd_test_pass();
 }
 
-static void uffd_move_test(uffd_test_args_t *targs)
+static void uffd_move_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
 {
-	uffd_move_test_common(targs, page_size, uffd_move_handle_fault);
+	uffd_move_test_common(gopts, targs, gopts->page_size, uffd_move_handle_fault);
 }
 
-static void uffd_move_pmd_test(uffd_test_args_t *targs)
+static void uffd_move_pmd_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
 {
-	if (madvise(area_dst, nr_pages * page_size, MADV_HUGEPAGE))
+	if (madvise(gopts->area_dst, gopts->nr_pages * gopts->page_size, MADV_HUGEPAGE))
 		err("madvise(MADV_HUGEPAGE) failure");
-	uffd_move_test_common(targs, read_pmd_pagesize(),
+	uffd_move_test_common(gopts, targs, read_pmd_pagesize(),
 			      uffd_move_pmd_handle_fault);
 }
 
-static void uffd_move_pmd_split_test(uffd_test_args_t *targs)
+static void uffd_move_pmd_split_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
 {
-	if (madvise(area_dst, nr_pages * page_size, MADV_NOHUGEPAGE))
+	if (madvise(gopts->area_dst, gopts->nr_pages * gopts->page_size, MADV_NOHUGEPAGE))
 		err("madvise(MADV_NOHUGEPAGE) failure");
-	uffd_move_test_common(targs, read_pmd_pagesize(),
+	uffd_move_test_common(gopts, targs, read_pmd_pagesize(),
 			      uffd_move_pmd_handle_fault);
 }
 
-static int prevent_hugepages(const char **errmsg)
+static int prevent_hugepages(uffd_global_test_opts_t *gopts, const char **errmsg)
 {
 	/* This should be done before source area is populated */
-	if (madvise(area_src, nr_pages * page_size, MADV_NOHUGEPAGE)) {
+	if (madvise(gopts->area_src, gopts->nr_pages * gopts->page_size, MADV_NOHUGEPAGE)) {
 		/* Ignore only if CONFIG_TRANSPARENT_HUGEPAGE=n */
 		if (errno != EINVAL) {
 			if (errmsg)
@@ -1245,10 +1236,10 @@ static int prevent_hugepages(const char **errmsg)
 	return 0;
 }
 
-static int request_hugepages(const char **errmsg)
+static int request_hugepages(uffd_global_test_opts_t *gopts, const char **errmsg)
 {
 	/* This should be done before source area is populated */
-	if (madvise(area_src, nr_pages * page_size, MADV_HUGEPAGE)) {
+	if (madvise(gopts->area_src, gopts->nr_pages * gopts->page_size, MADV_HUGEPAGE)) {
 		if (errmsg) {
 			*errmsg = (errno == EINVAL) ?
 				"CONFIG_TRANSPARENT_HUGEPAGE is not set" :
@@ -1272,13 +1263,17 @@ struct uffd_test_case_ops uffd_move_test_pmd_case_ops = {
  * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
  */
 static void
-do_register_ioctls_test(uffd_test_args_t *args, bool miss, bool wp, bool minor)
+do_register_ioctls_test(uffd_global_test_opts_t *gopts,
+						uffd_test_args_t *args,
+						bool miss,
+						bool wp,
+						bool minor)
 {
 	uint64_t ioctls = 0, expected = BIT_ULL(_UFFDIO_WAKE);
 	mem_type_t *mem_type = args->mem_type;
 	int ret;
 
-	ret = uffd_register_with_ioctls(uffd, area_dst, page_size,
+	ret = uffd_register_with_ioctls(gopts->uffd, gopts->area_dst, gopts->page_size,
 					miss, wp, minor, &ioctls);
 
 	/*
@@ -1309,18 +1304,18 @@ do_register_ioctls_test(uffd_test_args_t *args, bool miss, bool wp, bool minor)
 		    "(miss=%d, wp=%d, minor=%d): expected=0x%"PRIx64", "
 		    "returned=0x%"PRIx64, miss, wp, minor, expected, ioctls);
 
-	if (uffd_unregister(uffd, area_dst, page_size))
+	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size))
 		err("unregister");
 }
 
-static void uffd_register_ioctls_test(uffd_test_args_t *args)
+static void uffd_register_ioctls_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
 {
 	int miss, wp, minor;
 
 	for (miss = 0; miss <= 1; miss++)
 		for (wp = 0; wp <= 1; wp++)
 			for (minor = 0; minor <= 1; minor++)
-				do_register_ioctls_test(args, miss, wp, minor);
+				do_register_ioctls_test(gopts, args, miss, wp, minor);
 
 	uffd_test_pass();
 }
@@ -1532,6 +1527,27 @@ int main(int argc, char *argv[])
 		}
 		for (j = 0; j < n_mems; j++) {
 			mem_type = &mem_types[j];
+
+			// Initialize global test options
+			uffd_global_test_opts_t gopts;
+
+			gopts.map_shared = mem_type->shared;
+			uffd_test_ops = mem_type->mem_ops;
+			uffd_test_case_ops = test->test_case_ops;
+
+			if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
+				gopts.page_size = default_huge_page_size();
+			else
+				gopts.page_size = psize();
+
+			/* Ensure we have at least 2 pages */
+			gopts.nr_pages = MAX(UFFD_TEST_MEM_SIZE, gopts.page_size * 2) / gopts.page_size;
+			/* TODO: remove this global var.. it's so ugly */
+			gopts.nr_parallel = 1;
+
+			/* Initialize test arguments */
+			args.mem_type = mem_type;
+
 			if (!(test->mem_targets & mem_type->mem_flag))
 				continue;
 
@@ -1546,13 +1562,12 @@ int main(int argc, char *argv[])
 				uffd_test_skip("feature missing");
 				continue;
 			}
-			if (uffd_setup_environment(&args, test, mem_type,
-						   &errmsg)) {
+			if (uffd_test_ctx_init(&gopts, test->uffd_feature_required, &errmsg)) {
 				uffd_test_skip(errmsg);
 				continue;
 			}
-			test->uffd_fn(&args);
-			uffd_test_ctx_clear();
+			test->uffd_fn(&gopts, &args);
+			uffd_test_ctx_clear(&gopts);
 		}
 	}
 
-- 
2.20.1


