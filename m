Return-Path: <linux-kselftest+bounces-27928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635E0A49F7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D1E175AE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB0D280A2F;
	Fri, 28 Feb 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjsjYz8T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F927781E
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761708; cv=none; b=WXEc8yU03v/JA2hquDZJBxNBKxtS8PgSvS6gWlcIhmbtgsP9YSUF3itUvxLRQpdFx6pj6U7B3vjcWY+5w2/AZInO9AMVGUVnVR9Z9as/l9OtF989h0JPz87cl6+se0Nt/tesjYfI2ptzWoX6biblV7ilm20Ft/H2+6nxOlEWRT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761708; c=relaxed/simple;
	bh=tfftHGPyv69HoB/ZMJmRXyKhQu/kB66LBoTZIdp1nOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BmO+xbOGCFTMg2NNUhAEBCzXkF11qriBGKDufcMQv0Q3JHCVN+6ncG56nsHxXfY22TkwJ6LEYbJg5jEqCcVf3fv1RFaANPhWLjbJHbpZ0/mxRGUJZZLoaDyukD9TasDT5+z7jXj0xsmyz1AtCB2AOPnirfSRBZImH734bL2SHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjsjYz8T; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390e5214efdso1477897f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 08:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761704; x=1741366504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S9QxBMT1dy5QbhO22yQnX/sY19xHXMzPESl6Emh05kM=;
        b=KjsjYz8Ta89Uy7JNeUGklshpIb0f/79zaiXV5ylxV0sTlC8eFLYGI64EAiB4PXiNXo
         MLuuYRZGbSsZ5QYEr98GW1OC8wTyKVcGV3ZxxgeukLhnDw8pYjgArgzCTmZnpQSezj5I
         QQc8e67aME9afa7F4I4d/XYyEDI9v9flnP4rwzVQf0GU914JxrkEp8Ln3swAc4xn3Wzp
         DW0jT0xH8p/+pNk0PppkniRnDuDKHj8fbqYtLyJdKyhBFzSk0L0X4LeJ+I2knqzNiGE1
         RxSRB0yrXDedd130L8fDXoVVoWmN4IWu2vReV7Xu5vWHJbVhmynNRMZq3axd52lNFDwL
         Kmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761704; x=1741366504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9QxBMT1dy5QbhO22yQnX/sY19xHXMzPESl6Emh05kM=;
        b=lFQBpA3LI6HojEV4mvF6HW0uv1Dg8hJcLOT41ea2cYWL1fSTf2XZVJNSFZGIvZia6X
         SpRSUiCclcG88K/cWDLtPTOsu1ktI43ZX7CEOiTBip4fRbiYWRfD/qeF0H4q7pHq8G0K
         qSYjOom27SWDFg9Q+A05gtdLjdsbyG3IHdjmPo+XLEtLxrDJKnSYHiBzqKSZ9+V0xS2I
         kx1X1mPQ4I5czZ/MFP5lLJskojNzne0rwDIBQVfGIo8bQbo0oh0m0tQ93DMSqnQsehmA
         1xv0hq/DZWgh1VLwpkqEkcF9vi6i0/fEuVClY3vi2YJ4432izUIJySrpPKY2/ztEbq8Z
         CHDA==
X-Forwarded-Encrypted: i=1; AJvYcCXOVdjfifg2pvWpKgTmJy5fZayx8TPoLz1g9YAt0OLv01TX7sWFAkZ9ThRQNH+95mSERzH8f7BlGucyToRUebU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5hzfzqXbu/lnsjn4IMHfD4rt95yqSbu0CadRb6ON3jkLGd9Ar
	WEnXxmcbeYQFh03YCkHAlBCd/tyew3ERlSl0zGvLHDx7SRKqTOFLGhbamyf3YVcBo3dTBTnSiGC
	5zE8IAFgl4Q==
X-Google-Smtp-Source: AGHT+IH0IbPgf0WZB4YwqpZ6IMtQ3dgzowLYjozZVKkhVKhCwE0plHrNAT013hhx4TNDxRckM/EIsEy0iSzC0A==
X-Received: from wrbfy2.prod.google.com ([2002:a05:6000:2d82:b0:390:e463:27fd])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c4:b0:390:ec10:9dca with SMTP id ffacd0b85a97d-390eca414e4mr3842391f8f.45.1740761704683;
 Fri, 28 Feb 2025 08:55:04 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:52 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-4-958e3b6f0203@google.com>
Subject: [PATCH v3 04/10] selftests/mm/uffd: Rename nr_cpus -> nr_threads
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
2.48.1.711.g2feabab25a-goog


