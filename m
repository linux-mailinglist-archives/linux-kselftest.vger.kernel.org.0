Return-Path: <linux-kselftest+bounces-20160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7669A447A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 19:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8451B2312B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2DD2040A6;
	Fri, 18 Oct 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LlC8oyGX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88690204096
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271892; cv=none; b=d2XA7vhN1nW1wWITPysm1+caXWrQw1c01LhU83VW9QLBxF06oH0Y38OszHSRXoZvwUqYZIpyYnmeA0OdMVXQGjWYeA3+ArO3y6l0wJkCBeoJHMIR1vNAQCjfIE/htmdorY1yQxKCVzM6mTmwLS125YNFFGVUfnBqbLoZtHnzgbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271892; c=relaxed/simple;
	bh=dk+2Ao6eBpxXZJV7TRzBnZbcedhZSUClpihRKk8bXbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JUP5WeHP6obXJ7yOlk8oJOttGaSk7n1GD5f74c0PJFs+WQGB+BX6C671mfP2WqEiFAeYitp3KtHSsa20sBaVEqFtmwAsgwkkRbnJPYAKXomqeBaR5dm9MVx0gPHvEZGW+sjwSVv2tIs/IIsuBXLAu+Eq4vF1M6NMiEgxwHlsmhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LlC8oyGX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7db9418552fso2005649a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729271890; x=1729876690; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFQHSO14/jAsIAlP6YyLD1M4ZuBPXyCrx6oOfYWGU30=;
        b=LlC8oyGXLf1cy3p6LBurgktJLjCmIcWudN5IIwj8gKMkUjOpNuVu8HgQekq5SESGut
         6C+6FlLRcjv9toHNHDyqcHOsxs7N9pJkhq60QMi2Fy1Osq303KIjrMKT/MNZ/ptb8cE3
         lpkcky+Ah9wkrLQbTo93IM7knvFeoNTqi8A8Z2Qg5/eV666Lu9C3Fv73NXdxQSJLz247
         JYxCeEvMtOkSJLyAZZYrLLf4peq4On0AfNKBfk/C34tX+lc62A/zJjkoVHSZ7FL4yedg
         qd1yzfHFxLGPGlQm2i/g0Z04pr0ralzZQtSa5iMQOjzK+qdpvyZ7ZF9f+zQbKOqKmuCn
         ux1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729271890; x=1729876690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFQHSO14/jAsIAlP6YyLD1M4ZuBPXyCrx6oOfYWGU30=;
        b=mhVVR+DiQR24FPOJQ5rgF70CT3bHDOE/iLstIOLMlcAvwdUyVnO6MMXS1DVZ+RD0iE
         iVsBhCTrbNuQnRnQEHz120oBfBhf7GsDtvYea9upizNkhWktQjA7yO2PQ578h5Lknu8E
         aZ61bQt6RDdQFNWt9SQrmtyQzzcKUWIT/Gg7fxiIgVRrX4PsTb0gKzYu93dCsCbiIGBP
         Do4fuZRaoYUbhZJzkcXMdqq+ZW4ViAWIhmd+D3wC3noAWHjS+RbeNhNbFA8UQPj1Ly6v
         5fizZS5oe5hTTBPeHH3zTbs69RZVWNCBZ9mHcNLFHvtiVux0hTg/DgF8USrVwruQ5wCU
         DsCQ==
X-Gm-Message-State: AOJu0Yy3rDdjUrR74yRiR0hMIi3DQXGzfciroMH6q1xIjYBxnORDirva
	6br04NM/z304kX0tJu8Lqpp/oWgp8mcwLtEfPTz5BaCizqyrCmxWvyM1HfIfTkZ74isUHGdoZys
	FDSJqOcnhqFskg+nxIcd8epS6s8U368wmBZd9PnIK6kvtLVTbFnt2yY7+sQKynp5obAKgUpahUh
	uNulh/cfeAjV+nyVLI6wnn/vepVFsnp5LWckxaldFArM7t
X-Google-Smtp-Source: AGHT+IElgKqKmBxxYFR30EicUCVFsCvFx4Ofclcxsw9+z9zau8/mq1g11dMoqL/6qwWZQUMW1ChAG57xdLs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:3858:0:b0:7e9:f93c:22b9 with SMTP id
 41be03b00d2f7-7eacc895cf2mr3205a12.10.1729271888448; Fri, 18 Oct 2024
 10:18:08 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:17:23 +0000
In-Reply-To: <20241018171734.2315053-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018171734.2315053-1-edliaw@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241018171734.2315053-3-edliaw@google.com>
Subject: [PATCH 2/3] Revert "selftests/mm: replace atomic_bool with pthread_barrier_t"
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit e61ef21e27e8deed8c474e9f47f4aa7bc37e138c.

uffd_poll_thread may be called by other tests that do not initialize the
pthread_barrier, so this approach is not correct.  This will revert to
using atomic_bool instead.

Fixes: e61ef21e27e8 ("selftests/mm: replace atomic_bool with pthread_barrier_t")
CC: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     |  5 ++---
 tools/testing/selftests/mm/uffd-common.h     |  3 ++-
 tools/testing/selftests/mm/uffd-unit-tests.c | 14 ++++++--------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 852e7281026e..717539eddf98 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -18,7 +18,7 @@ bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
 uffd_test_case_ops_t *uffd_test_case_ops;
-pthread_barrier_t ready_for_fork;
+atomic_bool ready_for_fork;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -519,8 +519,7 @@ void *uffd_poll_thread(void *arg)
 	pollfd[1].fd = pipefd[cpu*2];
 	pollfd[1].events = POLLIN;
 
-	/* Ready for parent thread to fork */
-	pthread_barrier_wait(&ready_for_fork);
+	ready_for_fork = true;
 
 	for (;;) {
 		ret = poll(pollfd, 2, -1);
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 3e6228d8e0dc..a70ae10b5f62 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -33,6 +33,7 @@
 #include <inttypes.h>
 #include <stdint.h>
 #include <sys/random.h>
+#include <stdatomic.h>
 
 #include "../kselftest.h"
 #include "vm_util.h"
@@ -104,7 +105,7 @@ extern bool map_shared;
 extern bool test_uffdio_wp;
 extern unsigned long long *count_verify;
 extern volatile bool test_uffdio_copy_eexist;
-extern pthread_barrier_t ready_for_fork;
+extern atomic_bool ready_for_fork;
 
 extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 3db2296ac631..b3d21eed203d 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -774,7 +774,7 @@ static void uffd_sigbus_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };
 
-	pthread_barrier_init(&ready_for_fork, NULL, 2);
+	ready_for_fork = false;
 
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
@@ -791,9 +791,8 @@ static void uffd_sigbus_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	/* Wait for child thread to start before forking */
-	pthread_barrier_wait(&ready_for_fork);
-	pthread_barrier_destroy(&ready_for_fork);
+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
 
 	pid = fork();
 	if (pid < 0)
@@ -834,7 +833,7 @@ static void uffd_events_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };
 
-	pthread_barrier_init(&ready_for_fork, NULL, 2);
+	ready_for_fork = false;
 
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
@@ -845,9 +844,8 @@ static void uffd_events_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
-	/* Wait for child thread to start before forking */
-	pthread_barrier_wait(&ready_for_fork);
-	pthread_barrier_destroy(&ready_for_fork);
+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
 
 	pid = fork();
 	if (pid < 0)
-- 
2.47.0.105.g07ac214952-goog


