Return-Path: <linux-kselftest+bounces-27214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706FCA3FEC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 19:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA433A19DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8372528E4;
	Fri, 21 Feb 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/9THbcj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA6B253B50
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162360; cv=none; b=Pbk+rJ0rXDMqqv77S5t2nbDn6wT/Sh+XUR22/4dsi8+HZQcktDQsXVizA4QGRxQNrem0jcSbW+xgJxG8f5k1y4YbEwQ4FQO/Fn0VaNOe5guviLLy9fGK/9lVWk1qavs4e1wwD9PlGSbkTmai7+BDGA4lNs/JhoufiuJu53I8Cdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162360; c=relaxed/simple;
	bh=4ssZwG4qJ8pHk2UbwsWVXtiSTcecQacYeJEf+tBVsaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AvKGooKlkwEgxqEWTt63a2THd85oiPWxWFuxvcpih30mB5msJQDXRYornzBGBoogkueEFt7gq1KL2bahm7N/0EvSEXv/R53jH+PKB/4HBTXsVbl91SL4xTVBDCAT1zdBNF/halaT54VJ4xXtJRQRw3BSqVnvPhpCsHVOTd1Ce4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/9THbcj; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f3eb82fceso1154594f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 10:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162357; x=1740767157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAoxH1QQtcmtrqfrqrquGCaxLx3Ng1Kyj4nYfPKggLc=;
        b=q/9THbcjOsm/MU3YFLs1duJH799EYxCty5c3+2zn5XKiZM01q9sQbaUZzhA/zojHB1
         bC8iMGs9SgndQo3000FtNGz/UxUh8L3pT7XYnxwlE2shEFQdwb4DQz33Mc8Ajl/XKuQK
         pvtS2B35bgn+0CvZrVoDF+gH0VfrEgPPNVlq1pMLNRfHEnOkwLxFKkwsni1SU9XRxoK5
         q1qO+Mepp7zzxlqzIxspgE7/dH2eS6S5peklZLVuzWKPdYngAZtzy8lY2BO9EErZeW/X
         5hnkmUR3b6wCX6ZFiDnnl7RiCnKVIaAcslAn1EEdEqhvULphC0eERARHTcNTngSNeIpG
         0IdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162357; x=1740767157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAoxH1QQtcmtrqfrqrquGCaxLx3Ng1Kyj4nYfPKggLc=;
        b=TDCzft7vza2aJkwlfOj3fxMOPR58bOoYHVF8jUkSp+15FzbtrtqVw5ESCuSZN9W+Vi
         aifFph9/iEhNooU/dyljBeZdy/J5Rzgu6UOY5sVycUMNzfRBcmmVjyzCwnFX28otCk1p
         op0gXgHpJ1wLH/Z4W1JeaDLdMgnnammSmULg+elABV+6itiYIKf5ekHgtSqutd0P2hyq
         3O3q+ZvtHx+nbDJtH4I3NUP2HJBngWKY7yvoAdWk5ZDz/dzfLnUQjggsCkdhgxikP6bv
         2hGIP2z+fRVnhZb6mkp6LDkIPgSOX5vsn0lsvBQQ8zw1vzR8ctvdnVRHTA5qGVpTLBRT
         7N3g==
X-Forwarded-Encrypted: i=1; AJvYcCUk7z7H5dYSoD8OllNkCizsfy5ewhubNNEPtfA+/sLTS4EM/aUF6hH0kYPLAWKxID/HyQlQnJxrbNsRmq3yY/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEk3vOUIQHP1x4XDaQ0MtIz2BRVBdmd5Ep+So8qufgk0f8go7B
	tzd0VYokvnbSk5KQFZCS602SfeXJg9CA15xL1KGLyNIMQfu0abnxH/MSHp9narrwt3uXNjO5DHR
	hTlvemgXJvw==
X-Google-Smtp-Source: AGHT+IHHIQYpEKNyaX/t5tMIplaMMGcwEJk4a4wqfwMyLM1OocqQC+kF8/Z1ZzyO2qvH8d+pb7JjF85UNU1YYA==
X-Received: from wmbbh16.prod.google.com ([2002:a05:600c:3d10:b0:439:80fc:8bce])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6d04:0:b0:38f:4b2c:2475 with SMTP id ffacd0b85a97d-38f6e95c496mr3867149f8f.20.1740162357219;
 Fri, 21 Feb 2025 10:25:57 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:44 +0000
In-Reply-To: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-5-28c4d66383c5@google.com>
Subject: [PATCH v2 5/9] selftests/mm/uffd: Rename nr_cpus -> nr_threads
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

A later commit will bound this variable so it no longer necessarily
matches the number of CPUs. Rename it appropriately.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     |  8 ++++----
 tools/testing/selftests/mm/uffd-common.h     |  2 +-
 tools/testing/selftests/mm/uffd-stress.c     | 28 ++++++++++++++--------------
 tools/testing/selftests/mm/uffd-unit-tests.c |  2 +-
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 717539eddf98754250e70e564cd9a59f398bd7ea..a72a2ed5e89480ed06c81b034967ed5ae5f8cad5 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -10,7 +10,7 @@
 #define BASE_PMD_ADDR ((void *)(1UL << 30))
 
 volatile bool test_uffdio_copy_eexist = true;
-unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
+unsigned long nr_threads, nr_pages, nr_pages_per_cpu, page_size;
 char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 int uffd = -1, uffd_flags, finished, *pipefd, test_type;
 bool map_shared;
@@ -269,7 +269,7 @@ void uffd_test_ctx_clear(void)
 	size_t i;
 
 	if (pipefd) {
-		for (i = 0; i < nr_cpus * 2; ++i) {
+		for (i = 0; i < nr_threads * 2; ++i) {
 			if (close(pipefd[i]))
 				err("close pipefd");
 		}
@@ -365,10 +365,10 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	 */
 	uffd_test_ops->release_pages(area_dst);
 
-	pipefd = malloc(sizeof(int) * nr_cpus * 2);
+	pipefd = malloc(sizeof(int) * nr_threads * 2);
 	if (!pipefd)
 		err("pipefd");
-	for (cpu = 0; cpu < nr_cpus; cpu++)
+	for (cpu = 0; cpu < nr_threads; cpu++)
 		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
 			err("pipe");
 
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index a70ae10b5f6206daecc8e19ed3e3bbb388e265aa..604e3572fe17280ae346b031e2e867e039578f95 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -98,7 +98,7 @@ struct uffd_test_case_ops {
 };
 typedef struct uffd_test_case_ops uffd_test_case_ops_t;
 
-extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
+extern unsigned long nr_threads, nr_pages, nr_pages_per_cpu, page_size;
 extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 extern int uffd, uffd_flags, finished, *pipefd, test_type;
 extern bool map_shared;
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index ed68436fac62c76e2ca7060c661487f2f8a6ab45..ec842bbb9f18e291fa51de0ed8d1fbf9aaf14372 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -179,12 +179,12 @@ static void *background_thread(void *arg)
 static int stress(struct uffd_args *args)
 {
 	unsigned long cpu;
-	pthread_t locking_threads[nr_cpus];
-	pthread_t uffd_threads[nr_cpus];
-	pthread_t background_threads[nr_cpus];
+	pthread_t locking_threads[nr_threads];
+	pthread_t uffd_threads[nr_threads];
+	pthread_t background_threads[nr_threads];
 
 	finished = 0;
-	for (cpu = 0; cpu < nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_threads; cpu++) {
 		if (pthread_create(&locking_threads[cpu], &attr,
 				   locking_thread, (void *)cpu))
 			return 1;
@@ -202,7 +202,7 @@ static int stress(struct uffd_args *args)
 				   background_thread, (void *)cpu))
 			return 1;
 	}
-	for (cpu = 0; cpu < nr_cpus; cpu++)
+	for (cpu = 0; cpu < nr_threads; cpu++)
 		if (pthread_join(background_threads[cpu], NULL))
 			return 1;
 
@@ -218,11 +218,11 @@ static int stress(struct uffd_args *args)
 	uffd_test_ops->release_pages(area_src);
 
 	finished = 1;
-	for (cpu = 0; cpu < nr_cpus; cpu++)
+	for (cpu = 0; cpu < nr_threads; cpu++)
 		if (pthread_join(locking_threads[cpu], NULL))
 			return 1;
 
-	for (cpu = 0; cpu < nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_threads; cpu++) {
 		char c;
 		if (bounces & BOUNCE_POLL) {
 			if (write(pipefd[cpu*2+1], &c, 1) != 1)
@@ -245,11 +245,11 @@ static int userfaultfd_stress(void)
 {
 	void *area;
 	unsigned long nr;
-	struct uffd_args args[nr_cpus];
+	struct uffd_args args[nr_threads];
 	uint64_t mem_size = nr_pages * page_size;
 	int flags = 0;
 
-	memset(args, 0, sizeof(struct uffd_args) * nr_cpus);
+	memset(args, 0, sizeof(struct uffd_args) * nr_threads);
 
 	if (features & UFFD_FEATURE_WP_UNPOPULATED && test_type == TEST_ANON)
 		flags = UFFD_FEATURE_WP_UNPOPULATED;
@@ -324,7 +324,7 @@ static int userfaultfd_stress(void)
 		 */
 		uffd_test_ops->release_pages(area_dst);
 
-		uffd_stats_reset(args, nr_cpus);
+		uffd_stats_reset(args, nr_threads);
 
 		/* bounce pass */
 		if (stress(args)) {
@@ -358,7 +358,7 @@ static int userfaultfd_stress(void)
 
 		swap(area_src_alias, area_dst_alias);
 
-		uffd_stats_report(args, nr_cpus);
+		uffd_stats_report(args, nr_threads);
 	}
 	uffd_test_ctx_clear();
 
@@ -452,9 +452,9 @@ int main(int argc, char **argv)
 		return KSFT_SKIP;
 	}
 
-	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	nr_threads = sysconf(_SC_NPROCESSORS_ONLN);
 
-	nr_pages_per_cpu = bytes / page_size / nr_cpus;
+	nr_pages_per_cpu = bytes / page_size / nr_threads;
 	if (!nr_pages_per_cpu) {
 		_err("invalid MiB");
 		usage();
@@ -465,7 +465,7 @@ int main(int argc, char **argv)
 		_err("invalid bounces");
 		usage();
 	}
-	nr_pages = nr_pages_per_cpu * nr_cpus;
+	nr_pages = nr_pages_per_cpu * nr_threads;
 
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
 	       nr_pages, nr_pages_per_cpu);
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 9ff71fa1f9bf09b3ae599250663a25bbe2c13b8a..2f84fae5642c6f91b75fbf5f5d59ae64a1c15f92 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -197,7 +197,7 @@ uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
 
 	nr_pages = UFFD_TEST_MEM_SIZE / page_size;
 	/* TODO: remove this global var.. it's so ugly */
-	nr_cpus = 1;
+	nr_threads = 1;
 
 	/* Initialize test arguments */
 	args->mem_type = mem_type;

-- 
2.48.1.601.g30ceb7b040-goog


