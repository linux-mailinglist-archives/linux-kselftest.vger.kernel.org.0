Return-Path: <linux-kselftest+bounces-32088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE8AA617E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 18:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CDB1BC2E02
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF5E211488;
	Thu,  1 May 2025 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLKa8+DX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C520D516;
	Thu,  1 May 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117628; cv=none; b=MSD8soTJUU9iiUYB1Q2V2ol1vhvjIAuERLyYJ1J9UZWfEBrwzsyOVIg6qXR0RuNNlPL+x363cdmYcHX/dd+2PTNX3dD0gah5YOBLCCuAeN+bYYeejUST/VgISoMe23AxaF8ruPeEMk94c6CKdVZTUDnZu0ULbZQchkXxm2Io2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117628; c=relaxed/simple;
	bh=gJG4WpKMeRT8LmCgKCwBrhcvPflBKv0xPyIKj8UB5+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRqTeVTIrHZtbLY7GthneilQ4An/fGITVtE/DoUnQL7ZgihXALT1sz/MV+yqenb2IR+tD3FlbP618vX381VQVfp0EHzrZ8q/ojI3q7cIbOMvEoJUqOWi2tqW1QaAm/0YtiVg1zakoCs4KbV+FQZ5tEQyY+ThbJ3lkqN8oWTp5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLKa8+DX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2243803b776so20200185ad.0;
        Thu, 01 May 2025 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746117625; x=1746722425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF9bCGSiDG6aAnBM3zsgH3EAIDOOJCJJIDxIMwiMydU=;
        b=jLKa8+DXz5X9bO9hGVqU4pbucxbExzPju7rnSkIUA7b02aVv+99bNr2mT74JOB3ySi
         lcXnyfQ/ydHxF08b7awB+0/PU32RJNsGarzGsBSJrK9azHspSB4gd7NrkE/TyWgNBKiy
         t/XEtUL03VBQOB1Oj8uEjvLeALFGD0QoNJP+uqjEWpVW9OPUbuwD+BQdtwAxf+ObzYOt
         YKYhQUoZ11+ak/mG2ne89JHsQcgQDAbH6TknEUfuOJRMsLnj6xhaeo07Hzfxc9Fo5iuu
         EB1rh18of/8u5oiy3+orot34PpemFrIpuExhwccvi/KaWLMq7X0wqlRNcFCBhSYSB+10
         36Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117625; x=1746722425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF9bCGSiDG6aAnBM3zsgH3EAIDOOJCJJIDxIMwiMydU=;
        b=rIKnbUeAjeQYGqAnzGoRfXLJVve2yPyoEtxXjqodK51HAj0FC0GI2GB96yWloP+8fj
         xMhmz2PHbXSDWjL2ekSjFuc/bEovxpZm1XD6Nn31I4LpaKN3im5Gr8Sf8U/AmrME1TnI
         KMiw1x2NC+hFxiBtFFYw9LtHLdeb8KcfYYoCnWX825k84f11bUaczrbyKJ7syUS3+Jv6
         SxLZ0Irf+4mvj4g1DD+SUIKOxnxAmmYWEfT//eE83Do1U5xtTvJLpVZI7g03nQ+pc3m9
         Xlfm6pfkojL+rIyL0tep3nLkjMSu+kr3Im7J6SPp2iHhsD6zEmya3pp40q6URldmXCos
         HwTw==
X-Forwarded-Encrypted: i=1; AJvYcCVEa888uLpjiKa6W2cwQ5AhnGKCnlqzv5c1qLcvhMOT1gHaJLXiupX4UZm8KUPylNCn18R4skaKiPXfzZXzdvDI@vger.kernel.org, AJvYcCVlhdytXu70ovKY5BgIvAII/ER9FQufqg/sZ5JVLofe7GJnIiQDbKJqX8nXmlpDxVrnkYqb8siBkAasH7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqcWROPzj95pz4iE4bbx1k0MqOTfPulWpjQW5qMiVuHTYthuW
	VFo9eq3MLkjpRQOZY1QFLBvSoU4EMWkeoyJV+WDUhaIET2e35W0=
X-Gm-Gg: ASbGnctGJ1njvbJ7g/3bHmGUEiN6PRxaD6cvOOeiynf89uEVfDp3wgZig8ZocINE0jY
	Ge4wIs07ADPuM2Lk9U6vWCkFG1oYrUSrkGBvhejN52B2VRjrRXLxfL92LjobhaeM/YBKzHGPgZ2
	1NERfaewtbD2uTALHL8HXHokD1JpvYLxqDoa1dklEqcrCMNdyUjaaOQgFD1Qdib+fumKbMKeHQ/
	UcCnAVE5C5sYeSw2Co0MWPsex7K4BFrFQBbaJ0d9IPO1cgonr2xREsRRjtKnWNLk3brB4kU1Jbu
	Mb1Rs0QzvuO8pVp8DvEed/g77XvHAS/ko+ZaL1u1XFTWHT5v6g==
X-Google-Smtp-Source: AGHT+IGF2JIgoeWIE0b6mWruCPVwb/wE1gTNq+7B89OLJ6JmGJIc1XBbfBpmp+9eRRyxdzcTDUYPog==
X-Received: by 2002:a17:902:db01:b0:22c:336f:cb54 with SMTP id d9443c01a7336-22e040c8179mr56051845ad.29.1746117625603;
        Thu, 01 May 2025 09:40:25 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.132.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e0bc6e678sm8797525ad.132.2025.05.01.09.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:40:25 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: akpm@linux-foundation.org,
	peterx@redhat.com,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: [PATCH 2/4] selftests/mm/uffd: Swap global vars with global test options
Date: Thu,  1 May 2025 22:08:25 +0530
Message-Id: <20250501163827.2598-3-ujwal.kundur@gmail.com>
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

We use the refactored uffd_global_test_opts struct instead of global
variables for uffd-stress tests.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 226 ++++++++++++-----------
 1 file changed, 122 insertions(+), 104 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 40af7f67c407..e7aac958d57d 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -76,54 +76,58 @@ static void usage(void)
 	exit(1);
 }
 
-static void uffd_stats_reset(struct uffd_args *args, unsigned long n_cpus)
+static void uffd_stats_reset(uffd_global_test_opts_t *gopts, struct uffd_args *args,
+							unsigned long n_cpus)
 {
 	int i;
 
 	for (i = 0; i < n_cpus; i++) {
 		args[i].cpu = i;
-		args[i].apply_wp = test_uffdio_wp;
+		args[i].apply_wp = gopts->test_uffdio_wp;
 		args[i].missing_faults = 0;
 		args[i].wp_faults = 0;
 		args[i].minor_faults = 0;
+		args[i].gopts = gopts;
 	}
 }
 
 static void *locking_thread(void *arg)
 {
-	unsigned long cpu = (unsigned long) arg;
+	struct uffd_args *args = (struct uffd_args *) arg;
+	uffd_global_test_opts_t *gopts = args->gopts;
+	unsigned long cpu = (unsigned long) args->cpu;
 	unsigned long page_nr;
 	unsigned long long count;
 
 	if (!(bounces & BOUNCE_RANDOM)) {
 		page_nr = -bounces;
 		if (!(bounces & BOUNCE_RACINGFAULTS))
-			page_nr += cpu * nr_pages_per_cpu;
+			page_nr += cpu * gopts->nr_pages_per_cpu;
 	}
 
-	while (!finished) {
+	while (!gopts->finished) {
 		if (bounces & BOUNCE_RANDOM) {
 			if (getrandom(&page_nr, sizeof(page_nr), 0) != sizeof(page_nr))
 				err("getrandom failed");
 		} else
 			page_nr += 1;
-		page_nr %= nr_pages;
-		pthread_mutex_lock(area_mutex(area_dst, page_nr));
-		count = *area_count(area_dst, page_nr);
-		if (count != count_verify[page_nr])
+		page_nr %= gopts->nr_pages;
+		pthread_mutex_lock(area_mutex(gopts->area_dst, page_nr, gopts));
+		count = *area_count(gopts->area_dst, page_nr, gopts);
+		if (count != gopts->count_verify[page_nr])
 			err("page_nr %lu memory corruption %llu %llu",
-			    page_nr, count, count_verify[page_nr]);
+			    page_nr, count, gopts->count_verify[page_nr]);
 		count++;
-		*area_count(area_dst, page_nr) = count_verify[page_nr] = count;
-		pthread_mutex_unlock(area_mutex(area_dst, page_nr));
+		*area_count(gopts->area_dst, page_nr, gopts) = gopts->count_verify[page_nr] = count;
+		pthread_mutex_unlock(area_mutex(gopts->area_dst, page_nr, gopts));
 	}
 
 	return NULL;
 }
 
-static int copy_page_retry(int ufd, unsigned long offset)
+static int copy_page_retry(uffd_global_test_opts_t *gopts, unsigned long offset)
 {
-	return __copy_page(ufd, offset, true, test_uffdio_wp);
+	return __copy_page(gopts, offset, true, gopts->test_uffdio_wp);
 }
 
 pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
@@ -131,15 +135,16 @@ pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
 static void *uffd_read_thread(void *arg)
 {
 	struct uffd_args *args = (struct uffd_args *)arg;
+	uffd_global_test_opts_t *gopts = args->gopts;
 	struct uffd_msg msg;
 
 	pthread_mutex_unlock(&uffd_read_mutex);
 	/* from here cancellation is ok */
 
 	for (;;) {
-		if (uffd_read_msg(uffd, &msg))
+		if (uffd_read_msg(gopts, &msg))
 			continue;
-		uffd_handle_page_fault(&msg, args);
+		uffd_handle_page_fault(gopts, &msg, args);
 	}
 
 	return NULL;
@@ -147,32 +152,34 @@ static void *uffd_read_thread(void *arg)
 
 static void *background_thread(void *arg)
 {
-	unsigned long cpu = (unsigned long) arg;
+	struct uffd_args *args = (struct uffd_args *) arg;
+	uffd_global_test_opts_t *gopts = args->gopts;
+	unsigned long cpu = (unsigned long) args->cpu;
 	unsigned long page_nr, start_nr, mid_nr, end_nr;
 
-	start_nr = cpu * nr_pages_per_cpu;
-	end_nr = (cpu+1) * nr_pages_per_cpu;
+	start_nr = cpu * gopts->nr_pages_per_cpu;
+	end_nr = (cpu+1) * gopts->nr_pages_per_cpu;
 	mid_nr = (start_nr + end_nr) / 2;
 
 	/* Copy the first half of the pages */
 	for (page_nr = start_nr; page_nr < mid_nr; page_nr++)
-		copy_page_retry(uffd, page_nr * page_size);
+		copy_page_retry(gopts, page_nr * gopts->page_size);
 
 	/*
 	 * If we need to test uffd-wp, set it up now.  Then we'll have
 	 * at least the first half of the pages mapped already which
 	 * can be write-protected for testing
 	 */
-	if (test_uffdio_wp)
-		wp_range(uffd, (unsigned long)area_dst + start_nr * page_size,
-			nr_pages_per_cpu * page_size, true);
+	if (gopts->test_uffdio_wp)
+		wp_range(gopts->uffd, (unsigned long)gopts->area_dst + start_nr * gopts->page_size,
+			gopts->nr_pages_per_cpu * gopts->page_size, true);
 
 	/*
 	 * Continue the 2nd half of the page copying, handling write
 	 * protection faults if any
 	 */
 	for (page_nr = mid_nr; page_nr < end_nr; page_nr++)
-		copy_page_retry(uffd, page_nr * page_size);
+		copy_page_retry(gopts, page_nr * gopts->page_size);
 
 	return NULL;
 }
@@ -180,17 +187,23 @@ static void *background_thread(void *arg)
 static int stress(struct uffd_args *args)
 {
 	unsigned long cpu;
-	pthread_t locking_threads[nr_parallel];
-	pthread_t uffd_threads[nr_parallel];
-	pthread_t background_threads[nr_parallel];
+	uffd_global_test_opts_t *gopts = args->gopts;
+	pthread_t locking_threads[gopts->nr_parallel];
+	pthread_t uffd_threads[gopts->nr_parallel];
+	pthread_t background_threads[gopts->nr_parallel];
 
-	finished = 0;
-	for (cpu = 0; cpu < nr_parallel; cpu++) {
+	gopts->finished = 0;
+	for (cpu = 0; cpu < gopts->nr_parallel; cpu++) {
 		if (pthread_create(&locking_threads[cpu], &attr,
-				   locking_thread, (void *)cpu))
+				   locking_thread, (void *)&args[cpu]))
 			return 1;
 		if (bounces & BOUNCE_POLL) {
-			if (pthread_create(&uffd_threads[cpu], &attr, uffd_poll_thread, &args[cpu]))
+			if (pthread_create(
+						&uffd_threads[cpu],
+						&attr,
+						uffd_poll_thread,
+						(void *) &args[cpu])
+					)
 				err("uffd_poll_thread create");
 		} else {
 			if (pthread_create(&uffd_threads[cpu], &attr,
@@ -200,10 +213,10 @@ static int stress(struct uffd_args *args)
 			pthread_mutex_lock(&uffd_read_mutex);
 		}
 		if (pthread_create(&background_threads[cpu], &attr,
-				   background_thread, (void *)cpu))
+				   background_thread, (void *)&args[cpu]))
 			return 1;
 	}
-	for (cpu = 0; cpu < nr_parallel; cpu++)
+	for (cpu = 0; cpu < gopts->nr_parallel; cpu++)
 		if (pthread_join(background_threads[cpu], NULL))
 			return 1;
 
@@ -216,17 +229,17 @@ static int stress(struct uffd_args *args)
 	 * UFFDIO_COPY without writing zero pages into area_dst
 	 * because the background threads already completed).
 	 */
-	uffd_test_ops->release_pages(area_src);
+	uffd_test_ops->release_pages(gopts, gopts->area_src);
 
-	finished = 1;
-	for (cpu = 0; cpu < nr_parallel; cpu++)
+	gopts->finished = 1;
+	for (cpu = 0; cpu < gopts->nr_parallel; cpu++)
 		if (pthread_join(locking_threads[cpu], NULL))
 			return 1;
 
-	for (cpu = 0; cpu < nr_parallel; cpu++) {
+	for (cpu = 0; cpu < gopts->nr_parallel; cpu++) {
 		char c;
 		if (bounces & BOUNCE_POLL) {
-			if (write(pipefd[cpu*2+1], &c, 1) != 1)
+			if (write(gopts->pipefd[cpu*2+1], &c, 1) != 1)
 				err("pipefd write error");
 			if (pthread_join(uffd_threads[cpu],
 					 (void *)&args[cpu]))
@@ -242,26 +255,26 @@ static int stress(struct uffd_args *args)
 	return 0;
 }
 
-static int userfaultfd_stress(void)
+static int userfaultfd_stress(uffd_global_test_opts_t *gopts)
 {
 	void *area;
 	unsigned long nr;
-	struct uffd_args args[nr_parallel];
-	uint64_t mem_size = nr_pages * page_size;
+	struct uffd_args args[gopts->nr_parallel];
+	uint64_t mem_size = gopts->nr_pages * gopts->page_size;
 	int flags = 0;
 
-	memset(args, 0, sizeof(struct uffd_args) * nr_parallel);
+	memset(args, 0, sizeof(struct uffd_args) * gopts->nr_parallel);
 
-	if (features & UFFD_FEATURE_WP_UNPOPULATED && test_type == TEST_ANON)
+	if (features & UFFD_FEATURE_WP_UNPOPULATED && gopts->test_type == TEST_ANON)
 		flags = UFFD_FEATURE_WP_UNPOPULATED;
 
-	if (uffd_test_ctx_init(flags, NULL))
+	if (uffd_test_ctx_init(gopts, flags, NULL))
 		err("context init failed");
 
-	if (posix_memalign(&area, page_size, page_size))
+	if (posix_memalign(&area, gopts->page_size, gopts->page_size))
 		err("out of memory");
 	zeropage = area;
-	bzero(zeropage, page_size);
+	bzero(zeropage, gopts->page_size);
 
 	pthread_mutex_lock(&uffd_read_mutex);
 
@@ -284,18 +297,18 @@ static int userfaultfd_stress(void)
 		fflush(stdout);
 
 		if (bounces & BOUNCE_POLL)
-			fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
+			fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags | O_NONBLOCK);
 		else
-			fcntl(uffd, F_SETFL, uffd_flags & ~O_NONBLOCK);
+			fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags & ~O_NONBLOCK);
 
 		/* register */
-		if (uffd_register(uffd, area_dst, mem_size,
-				  true, test_uffdio_wp, false))
+		if (uffd_register(gopts->uffd, gopts->area_dst, mem_size,
+				  true, gopts->test_uffdio_wp, false))
 			err("register failure");
 
-		if (area_dst_alias) {
-			if (uffd_register(uffd, area_dst_alias, mem_size,
-					  true, test_uffdio_wp, false))
+		if (gopts->area_dst_alias) {
+			if (uffd_register(gopts->uffd, gopts->area_dst_alias, mem_size,
+					  true, gopts->test_uffdio_wp, false))
 				err("register failure alias");
 		}
 
@@ -323,87 +336,88 @@ static int userfaultfd_stress(void)
 		 * MADV_DONTNEED only after the UFFDIO_REGISTER, so it's
 		 * required to MADV_DONTNEED here.
 		 */
-		uffd_test_ops->release_pages(area_dst);
+		uffd_test_ops->release_pages(gopts, gopts->area_dst);
 
-		uffd_stats_reset(args, nr_parallel);
+		uffd_stats_reset(gopts, args, gopts->nr_parallel);
 
 		/* bounce pass */
 		if (stress(args)) {
-			uffd_test_ctx_clear();
+			uffd_test_ctx_clear(gopts);
 			return 1;
 		}
 
 		/* Clear all the write protections if there is any */
-		if (test_uffdio_wp)
-			wp_range(uffd, (unsigned long)area_dst,
-				 nr_pages * page_size, false);
+		if (gopts->test_uffdio_wp)
+			wp_range(gopts->uffd, (unsigned long)gopts->area_dst,
+				 gopts->nr_pages * gopts->page_size, false);
 
 		/* unregister */
-		if (uffd_unregister(uffd, area_dst, mem_size))
+		if (uffd_unregister(gopts->uffd, gopts->area_dst, mem_size))
 			err("unregister failure");
-		if (area_dst_alias) {
-			if (uffd_unregister(uffd, area_dst_alias, mem_size))
+		if (gopts->area_dst_alias) {
+			if (uffd_unregister(gopts->uffd, gopts->area_dst_alias, mem_size))
 				err("unregister failure alias");
 		}
 
 		/* verification */
 		if (bounces & BOUNCE_VERIFY)
-			for (nr = 0; nr < nr_pages; nr++)
-				if (*area_count(area_dst, nr) != count_verify[nr])
+			for (nr = 0; nr < gopts->nr_pages; nr++)
+				if (*area_count(gopts->area_dst, nr, gopts) !=
+						gopts->count_verify[nr])
 					err("error area_count %llu %llu %lu\n",
-					    *area_count(area_src, nr),
-					    count_verify[nr], nr);
+					    *area_count(gopts->area_src, nr, gopts),
+					    gopts->count_verify[nr], nr);
 
 		/* prepare next bounce */
-		swap(area_src, area_dst);
+		swap(gopts->area_src, gopts->area_dst);
 
-		swap(area_src_alias, area_dst_alias);
+		swap(gopts->area_src_alias, gopts->area_dst_alias);
 
-		uffd_stats_report(args, nr_parallel);
+		uffd_stats_report(args, gopts->nr_parallel);
 	}
-	uffd_test_ctx_clear();
+	uffd_test_ctx_clear(gopts);
 
 	return 0;
 }
 
-static void set_test_type(const char *type)
+static void set_test_type(uffd_global_test_opts_t *gopts, const char *type)
 {
 	if (!strcmp(type, "anon")) {
-		test_type = TEST_ANON;
+		gopts->test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
 	} else if (!strcmp(type, "hugetlb")) {
-		test_type = TEST_HUGETLB;
+		gopts->test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
-		map_shared = true;
+		gopts->map_shared = true;
 	} else if (!strcmp(type, "hugetlb-private")) {
-		test_type = TEST_HUGETLB;
+		gopts->test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
 	} else if (!strcmp(type, "shmem")) {
-		map_shared = true;
-		test_type = TEST_SHMEM;
+		gopts->map_shared = true;
+		gopts->test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
 	} else if (!strcmp(type, "shmem-private")) {
-		test_type = TEST_SHMEM;
+		gopts->test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
 	}
 }
 
-static void parse_test_type_arg(const char *raw_type)
+static void parse_test_type_arg(uffd_global_test_opts_t *gopts, const char *raw_type)
 {
-	set_test_type(raw_type);
+	set_test_type(gopts, raw_type);
 
-	if (!test_type)
+	if (!gopts->test_type)
 		err("failed to parse test type argument: '%s'", raw_type);
 
-	if (test_type == TEST_HUGETLB)
-		page_size = default_huge_page_size();
+	if (gopts->test_type == TEST_HUGETLB)
+		gopts->page_size = default_huge_page_size();
 	else
-		page_size = sysconf(_SC_PAGE_SIZE);
+		gopts->page_size = sysconf(_SC_PAGE_SIZE);
 
-	if (!page_size)
+	if (!gopts->page_size)
 		err("Unable to determine page size");
-	if ((unsigned long) area_count(NULL, 0) + sizeof(unsigned long long) * 2
-	    > page_size)
+	if ((unsigned long) area_count(NULL, 0, gopts) + sizeof(unsigned long long) * 2
+	    > gopts->page_size)
 		err("Impossible to run this test");
 
 	/*
@@ -415,21 +429,22 @@ static void parse_test_type_arg(const char *raw_type)
 	if (uffd_get_features(&features) && errno == ENOENT)
 		ksft_exit_skip("failed to get available features (%d)\n", errno);
 
-	test_uffdio_wp = test_uffdio_wp &&
+	gopts->test_uffdio_wp = gopts->test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
 
-	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_HUGETLBFS_SHMEM))
-		test_uffdio_wp = false;
+	if (gopts->test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_HUGETLBFS_SHMEM))
+		gopts->test_uffdio_wp = false;
 
-	close(uffd);
-	uffd = -1;
+	close(gopts->uffd);
+	gopts->uffd = -1;
 }
 
 static void sigalrm(int sig)
 {
 	if (sig != SIGALRM)
 		abort();
-	test_uffdio_copy_eexist = true;
+	// TODO: Set this without access to global vars
+	// gopts->test_uffdio_copy_eexist = true;
 	alarm(ALARM_INTERVAL_SECS);
 }
 
@@ -438,6 +453,9 @@ int main(int argc, char **argv)
 	unsigned long nr_cpus;
 	size_t bytes;
 
+	uffd_global_test_opts_t *gopts =
+		(uffd_global_test_opts_t *) malloc(sizeof(uffd_global_test_opts_t));
+
 	if (argc < 4)
 		usage();
 
@@ -445,11 +463,11 @@ int main(int argc, char **argv)
 		err("failed to arm SIGALRM");
 	alarm(ALARM_INTERVAL_SECS);
 
-	parse_test_type_arg(argv[1]);
+	parse_test_type_arg(gopts, argv[1]);
 	bytes = atol(argv[2]) * 1024 * 1024;
 
-	if (test_type == TEST_HUGETLB &&
-	   get_free_hugepages() < bytes / page_size) {
+	if (gopts->test_type == TEST_HUGETLB &&
+	   get_free_hugepages() < bytes / gopts->page_size) {
 		printf("skip: Skipping userfaultfd... not enough hugepages\n");
 		return KSFT_SKIP;
 	}
@@ -459,15 +477,15 @@ int main(int argc, char **argv)
 		/* Don't let calculation below go to zero. */
 		ksft_print_msg("_SC_NPROCESSORS_ONLN (%lu) too large, capping nr_threads to 32\n",
 			       nr_cpus);
-		nr_parallel = 32;
+		gopts->nr_parallel = 32;
 	} else {
-		nr_parallel = nr_cpus;
+		gopts->nr_parallel = nr_cpus;
 	}
 
-	nr_pages_per_cpu = bytes / page_size / nr_parallel;
-	if (!nr_pages_per_cpu) {
+	gopts->nr_pages_per_cpu = bytes / gopts->page_size / gopts->nr_parallel;
+	if (!gopts->nr_pages_per_cpu) {
 		_err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
-			bytes, page_size, nr_parallel);
+			bytes, gopts->page_size, gopts->nr_parallel);
 		usage();
 	}
 
@@ -476,11 +494,11 @@ int main(int argc, char **argv)
 		_err("invalid bounces");
 		usage();
 	}
-	nr_pages = nr_pages_per_cpu * nr_parallel;
+	gopts->nr_pages = gopts->nr_pages_per_cpu * gopts->nr_parallel;
 
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
-	       nr_pages, nr_pages_per_cpu);
-	return userfaultfd_stress();
+	       gopts->nr_pages, gopts->nr_pages_per_cpu);
+	return userfaultfd_stress(gopts);
 }
 
 #else /* __NR_userfaultfd */
-- 
2.20.1


