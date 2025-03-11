Return-Path: <linux-kselftest+bounces-28740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6111A5C248
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700E11883646
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78231D514A;
	Tue, 11 Mar 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7rBrxT2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2E1C9DC6
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699109; cv=none; b=rdoF/GFS7KJ7Bf+eTmG928uhGIXiio3V3mQjCsqzPkv2RCe8D779zJ+TZX8HkpYoRt+3b67GMa3q5v6MQ9uK1EYLQaLvBhrdxI4LmidWYuaVwTpa4cAyTOx0I1VY3gWFczWfv7FDPBBb+2fX1JND3qgsVlKxythqnCJ/Omg+8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699109; c=relaxed/simple;
	bh=7cu9Mo5jePwqRqrQo8QLwmI2cqs8fPM09Kmi4kZUvjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jnY9dH5T723J9ody4uWdYv8uk2q+rwn7XlFXQBfMaSA/TJClCoKNhlslTrMjONLbK4QTZ/Nkxtm/iGjjOaz6D8nmmoJOP2RCz0SYpqSFOKNoSs0HX1v/Qccz8RNa+S47vBq4ay26drNdl5BK0jCp3VfjeTXsuV1dEsh8TQRivww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7rBrxT2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so21726945e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699106; x=1742303906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QUtJ68S5WVMBdPVxDoGekz8XvAVXh0h8UUq5TqoFAw=;
        b=n7rBrxT2Yk8Ff/HuAbhiwpQDQKDuYlr7cRXL7aJjI61NU3ZU734PgVzJSawdaxQRdJ
         blvMsdcYwwUzdtosHTMe9ywU+Tcsk/mlYq/n6/4lO1TeY8FvOyXLKhBGZKQpnqflEf6s
         slXmCM1byGNUDvZYm0opb8lh2Bl/uUzlDrcuMWdicbJKNTMzKc/ZhSbc5zU5lwuwBcDN
         d+OrCMqqVz18FN/MfKZgQFX+CEwcyEIyiKkgldDSXLMa6hv8y6fzLArN1VwqAthWLdbX
         Yd32i2kq50JBSvAz92bF3U8u/dW66B9uA2cNqSR8Z63OA9WDpAcNG2uPv5F5rH0EAao+
         HCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699106; x=1742303906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QUtJ68S5WVMBdPVxDoGekz8XvAVXh0h8UUq5TqoFAw=;
        b=fdxTZrY9lxG4jF0lp701IcrphWj2pnrlylWxJPksqHswo74HTmQNFiNtbiEVoEvGif
         iCFHUxjIWiv0uK5t01uO6ANBibpNH2cTM/kA7yUtJQjNS61lM/H1DSPeC4yCt9w70E8m
         KiN/cYOLYHvm6txQwQTNg3Q50C9yiE0MbkWlWZ7ifIlCHqdQILUeXxxo4xahKvMeOiTx
         ZMb4Gk7bPRCs+9/zgDhLpVeJpscs4flaUcepl7z7+0DdaMmjWH7WSFhLJNE8OrHMPyLZ
         y6Ex6y9Pxjoa9tDAexFNN5WurrI4CxLsB3iqWzwrN52zsZlYt3e7Nra0mLr2LHAZDqLn
         pgXA==
X-Forwarded-Encrypted: i=1; AJvYcCX68BCH3bX7Q1O4t1Ig2p3iYZgQSaGuqQXJslKEwJ0nFuN4OA7TylA7DvJwZUsEzbJIp+eYOT7gRUYc+lNEmww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs3JKPt92RpCZkWdKaMSScolsnVEwdCSZbpSzAnio81hMbURVy
	p36lLyymbid12Gzv3JAsZWvmD9408LmeLnggUGB5/g047nWpRZi6kDfLph35TFDV60ZQOj1a+HS
	FSAhqABqAgQ==
X-Google-Smtp-Source: AGHT+IHToyTOs3PPNxoBJUiCtaIlgO3ErHmKsYxSiQO/bRF9eUGsPTje1OCUomarBDaBQGTLwh5n+zuKNOR9zw==
X-Received: from wmbet7.prod.google.com ([2002:a05:600c:8187:b0:43c:fad4:7595])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3554:b0:43c:fffc:787b with SMTP id 5b1f17b1804b1-43cfffc7b0fmr77724175e9.12.1741699106174;
 Tue, 11 Mar 2025 06:18:26 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:15 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-4-dec210a658f5@google.com>
Subject: [PATCH v4 04/12] selftests/mm/uffd: Rename nr_cpus -> nr_parallel
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

A later commit will bound this variable so it no longer necessarily
matches the number of CPUs. Rename it appropriately.

Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     |  8 ++++----
 tools/testing/selftests/mm/uffd-common.h     |  2 +-
 tools/testing/selftests/mm/uffd-stress.c     | 28 ++++++++++++++--------------
 tools/testing/selftests/mm/uffd-unit-tests.c |  2 +-
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 7ad6ba660c7d6f1f5762d0b231b92b05e971a3c5..dd01d2c95175b0329a75e220d2f43c915261090c 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -10,7 +10,7 @@
 #define BASE_PMD_ADDR ((void *)(1UL << 30))
 
 volatile bool test_uffdio_copy_eexist = true;
-unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
+unsigned long nr_parallel, nr_pages, nr_pages_per_cpu, page_size;
 char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 int uffd = -1, uffd_flags, finished, *pipefd, test_type;
 bool map_shared;
@@ -269,7 +269,7 @@ void uffd_test_ctx_clear(void)
 	size_t i;
 
 	if (pipefd) {
-		for (i = 0; i < nr_cpus * 2; ++i) {
+		for (i = 0; i < nr_parallel * 2; ++i) {
 			if (close(pipefd[i]))
 				err("close pipefd");
 		}
@@ -365,10 +365,10 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	 */
 	uffd_test_ops->release_pages(area_dst);
 
-	pipefd = malloc(sizeof(int) * nr_cpus * 2);
+	pipefd = malloc(sizeof(int) * nr_parallel * 2);
 	if (!pipefd)
 		err("pipefd");
-	for (cpu = 0; cpu < nr_cpus; cpu++)
+	for (cpu = 0; cpu < nr_parallel; cpu++)
 		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
 			err("pipe");
 
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index a70ae10b5f6206daecc8e19ed3e3bbb388e265aa..7700cbfa397563d2f2bc82be45f96f2fc2032bbe 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -98,7 +98,7 @@ struct uffd_test_case_ops {
 };
 typedef struct uffd_test_case_ops uffd_test_case_ops_t;
 
-extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
+extern unsigned long nr_parallel, nr_pages, nr_pages_per_cpu, page_size;
 extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 extern int uffd, uffd_flags, finished, *pipefd, test_type;
 extern bool map_shared;
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 91174e9425cde2500b459db78cb27adda6647b55..d6b57e5a2e1d7611aa1588ee41601ce16117a574 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -180,12 +180,12 @@ static void *background_thread(void *arg)
 static int stress(struct uffd_args *args)
 {
 	unsigned long cpu;
-	pthread_t locking_threads[nr_cpus];
-	pthread_t uffd_threads[nr_cpus];
-	pthread_t background_threads[nr_cpus];
+	pthread_t locking_threads[nr_parallel];
+	pthread_t uffd_threads[nr_parallel];
+	pthread_t background_threads[nr_parallel];
 
 	finished = 0;
-	for (cpu = 0; cpu < nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_parallel; cpu++) {
 		if (pthread_create(&locking_threads[cpu], &attr,
 				   locking_thread, (void *)cpu))
 			return 1;
@@ -203,7 +203,7 @@ static int stress(struct uffd_args *args)
 				   background_thread, (void *)cpu))
 			return 1;
 	}
-	for (cpu = 0; cpu < nr_cpus; cpu++)
+	for (cpu = 0; cpu < nr_parallel; cpu++)
 		if (pthread_join(background_threads[cpu], NULL))
 			return 1;
 
@@ -219,11 +219,11 @@ static int stress(struct uffd_args *args)
 	uffd_test_ops->release_pages(area_src);
 
 	finished = 1;
-	for (cpu = 0; cpu < nr_cpus; cpu++)
+	for (cpu = 0; cpu < nr_parallel; cpu++)
 		if (pthread_join(locking_threads[cpu], NULL))
 			return 1;
 
-	for (cpu = 0; cpu < nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_parallel; cpu++) {
 		char c;
 		if (bounces & BOUNCE_POLL) {
 			if (write(pipefd[cpu*2+1], &c, 1) != 1)
@@ -246,11 +246,11 @@ static int userfaultfd_stress(void)
 {
 	void *area;
 	unsigned long nr;
-	struct uffd_args args[nr_cpus];
+	struct uffd_args args[nr_parallel];
 	uint64_t mem_size = nr_pages * page_size;
 	int flags = 0;
 
-	memset(args, 0, sizeof(struct uffd_args) * nr_cpus);
+	memset(args, 0, sizeof(struct uffd_args) * nr_parallel);
 
 	if (features & UFFD_FEATURE_WP_UNPOPULATED && test_type == TEST_ANON)
 		flags = UFFD_FEATURE_WP_UNPOPULATED;
@@ -325,7 +325,7 @@ static int userfaultfd_stress(void)
 		 */
 		uffd_test_ops->release_pages(area_dst);
 
-		uffd_stats_reset(args, nr_cpus);
+		uffd_stats_reset(args, nr_parallel);
 
 		/* bounce pass */
 		if (stress(args)) {
@@ -359,7 +359,7 @@ static int userfaultfd_stress(void)
 
 		swap(area_src_alias, area_dst_alias);
 
-		uffd_stats_report(args, nr_cpus);
+		uffd_stats_report(args, nr_parallel);
 	}
 	uffd_test_ctx_clear();
 
@@ -453,9 +453,9 @@ int main(int argc, char **argv)
 		return KSFT_SKIP;
 	}
 
-	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	nr_parallel = sysconf(_SC_NPROCESSORS_ONLN);
 
-	nr_pages_per_cpu = bytes / page_size / nr_cpus;
+	nr_pages_per_cpu = bytes / page_size / nr_parallel;
 	if (!nr_pages_per_cpu) {
 		_err("invalid MiB");
 		usage();
@@ -466,7 +466,7 @@ int main(int argc, char **argv)
 		_err("invalid bounces");
 		usage();
 	}
-	nr_pages = nr_pages_per_cpu * nr_cpus;
+	nr_pages = nr_pages_per_cpu * nr_parallel;
 
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
 	       nr_pages, nr_pages_per_cpu);
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 74c8bc02b5063f4667c4284c432edc7dee7ba3a5..24ea82ee223184612781adc852460138c4fe28f0 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -198,7 +198,7 @@ uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
 
 	nr_pages = UFFD_TEST_MEM_SIZE / page_size;
 	/* TODO: remove this global var.. it's so ugly */
-	nr_cpus = 1;
+	nr_parallel = 1;
 
 	/* Initialize test arguments */
 	args->mem_type = mem_type;

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


