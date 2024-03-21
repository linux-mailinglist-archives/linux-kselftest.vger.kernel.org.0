Return-Path: <linux-kselftest+bounces-6469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB77886057
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 19:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5941C21A25
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12421332AD;
	Thu, 21 Mar 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kPs2cuII"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565B810782
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044612; cv=none; b=B0dxo2sY3Cv+JFgdUHI9yYWz5awS1XPb1HcApKtzkt1Q+s4vHo+M6TBhQEUTmCTRK/gjLhZSe46kmE/APm+motRBf2GfI5Fv0ll56/Hi4mW3wGgaooydfH/uRYM7MyluBROLZcUjYlnoBa/Le1kf1tsbn91IY2XdiP6FY2717gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044612; c=relaxed/simple;
	bh=J5T69WFQ9USHQjLVUN1osaWhJDJNI4GDdeUlvKQfx7M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=feQ1pQPntagyQc5ECKgeZzpdnlzZFnB+Oh79K+euTfhcP/Rox06L7zcltrSuGR3PXrXdoxrh4sMHHS3y9mg929r2HHxkrOjV8qjvPnbdfRx2imOVskc11TvDJS3DmRvJseA0B5t7cCGUHYDtnQ0s1RKrSEW0ULnAR0jtjE4bXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kPs2cuII; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ea7f05b546so190105b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711044610; x=1711649410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PbnhbS3nC1f/Uw+2QJySA42Qs2PFTt6bDMzEjk8k/Mc=;
        b=kPs2cuII4b9yLXTzOSk0uNphUi2EJ8wNMGqN+Cqko4UMqHVlzOXBhYEYuGvwSDF2lG
         nd6FCpm46rfwRTNL6Mh6DuBrE4p/h9EMGBDPsrBRC88fKluCru69t7qvTrP1MWy846fn
         vMRgytx1yVn6ZR3SN56cM1uCWyJZbfEdOemmIv+xoqbv43eMd+C7h0nZf7DqvlG0kiF6
         hsZl849IswBcO7wStl4IYrYtO7Gl5Uh9TdTaPyB7J8WUnQ3j4MvpGtopO77DRlocfOeZ
         h5LUSwtfrTVcGADeAzTXvAZE0VuJQnS3x+Z1WpoV+E6QAOaiXDAOoYduMb/l7JFht2Yl
         uEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711044610; x=1711649410;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbnhbS3nC1f/Uw+2QJySA42Qs2PFTt6bDMzEjk8k/Mc=;
        b=Xtog3VwvgM/q9qK8MxgZYo+t52iKYq1h0be3AAt3D1he22A3pXbEhGOa8dJEhbfzDO
         aCWtuBOypd5JtdMaSBNdhfLaiXRLcDxh52DW/aWTl095FtcTzBU7V+g5teNq12JMDfqJ
         Kc1Co65XFYkUid4CMgRyezEhDRPo4ePst6c5hRuXGo29AYFdpDx6HTUniaQcnZfFFHUw
         AuAy6O5Ef1yqoskx7VZht/nPrSzD+44E9RRevVFY43cfWJqU5l4qiSPF7j0gqHj95Aig
         6jvcvM6RkSSUB1BjtAbhlCJlXubXMcEeIK4mHyXNqNseeHsjZA1DYykXn8L27l3pzjXa
         HX7A==
X-Gm-Message-State: AOJu0YwKTywCMolw+KdukAbMuU4dgWb5GDNrmHX8Er9i4kTlll1x2kpn
	bQQKE4cgAlH4S/AClXJlD57UJoT+7THDKpjLrXCXKOH85fISdj/2MuUUmjEKBWGhYjVjNO4Wmw+
	jzg==
X-Google-Smtp-Source: AGHT+IFYni3VvlWRaTmYz+82jv0WpYU31SYMq2cohi3G9fHRYPBqE7DFoZnmZbyg80iXWTMzj1CSpz2vwMs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:938b:b0:6e7:3fcb:38ba with SMTP id
 ka11-20020a056a00938b00b006e73fcb38bamr10155pfb.6.1711044610507; Thu, 21 Mar
 2024 11:10:10 -0700 (PDT)
Date: Thu, 21 Mar 2024 18:09:28 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240321180933.1029746-1-edliaw@google.com>
Subject: [PATCH v1] uffd-unit-tests: Fix ARM related issue with fork after pthread_create
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Following issue was observed while running the uffd-unit-tests selftest
on ARM devices. On x86_64 no issues were detected:

pthread_create followed by fork caused deadlock in certain cases
wherein fork required some work to be completed by the created thread.
Used synchronization to ensure that created thread's start function has
started before invoking fork.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
[edliaw: Refactored to use atomic_bool]
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     |  4 +++-
 tools/testing/selftests/mm/uffd-common.h     |  2 ++
 tools/testing/selftests/mm/uffd-unit-tests.c | 10 ++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index b0ac0ec2356d..14ed98c3a389 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -17,7 +17,7 @@ bool map_shared;
 bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
-uffd_test_case_ops_t *uffd_test_case_ops;
+atomic_bool ready_for_fork;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -518,6 +518,8 @@ void *uffd_poll_thread(void *arg)
 	pollfd[1].fd = pipefd[cpu*2];
 	pollfd[1].events = POLLIN;
 
+	ready_for_fork = true;
+
 	for (;;) {
 		ret = poll(pollfd, 2, -1);
 		if (ret <= 0) {
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index cb055282c89c..cc5629c3d2aa 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -32,6 +32,7 @@
 #include <inttypes.h>
 #include <stdint.h>
 #include <sys/random.h>
+#include <stdatomic.h>
 
 #include "../kselftest.h"
 #include "vm_util.h"
@@ -103,6 +104,7 @@ extern bool map_shared;
 extern bool test_uffdio_wp;
 extern unsigned long long *count_verify;
 extern volatile bool test_uffdio_copy_eexist;
+extern atomic_bool ready_for_fork;
 
 extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 2b9f8cc52639..4a48dc617c6b 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -775,6 +775,8 @@ static void uffd_sigbus_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };
 
+	ready_for_fork = false;
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
@@ -790,6 +792,9 @@ static void uffd_sigbus_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
+
 	pid = fork();
 	if (pid < 0)
 		err("fork");
@@ -829,6 +834,8 @@ static void uffd_events_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };
 
+	ready_for_fork = false;
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
 			  true, wp, false))
@@ -838,6 +845,9 @@ static void uffd_events_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");
 
+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
+
 	pid = fork();
 	if (pid < 0)
 		err("fork");
-- 
2.44.0.396.g6e790dbe36-goog


