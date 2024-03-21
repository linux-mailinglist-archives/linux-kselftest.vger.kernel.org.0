Return-Path: <linux-kselftest+bounces-6472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574E2886297
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 22:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BEC2829CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 21:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF4313664C;
	Thu, 21 Mar 2024 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4hKH7/W3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3DB134CEF
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057065; cv=none; b=pywmRTx//vVOY8L0FBotfeRMDvpwSMvAW0RWV/eENZ+jILRneQe7s+owoIuwtY+bFTFe5FMUxjbenVZfICeOB6Zt1JjvcuReU/7wAWmslYkSdydJh5AM6quyf8/+4iG8Wzr6VQJtXTln7ZnfkUe3rn81xHCIAYtdQ0OLBBhcQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057065; c=relaxed/simple;
	bh=17nLr5++Gj5gPnA/3LVk7GlcT9/oObVsxL2RNm5//ng=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qc9orqW+naR/VEKuYit4pHKjKA+YmzAWJLg1EXop5irSLg6pMLXEnCfvlVKGAzt4CDkx3fYAqj2ClkYhSpgpGX196xbFFK2gkYZX3jMI2SQgGWaIEvqlJfosLhqISg9/pGh0oaPQPcAaYxy3HFXU1rzyj8p21iknSAQlfIyZ/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4hKH7/W3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d5a080baf1so835739a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711057063; x=1711661863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wOtrT19asMXEr0TwJpVFoh7wEKo99GZ26en2SG6Gpmk=;
        b=4hKH7/W3UDowwovv1Q1sNb1buuDOb7tGrwCFSAQALV/opyM8WW5VncOj6caWEcqgAZ
         AMkJjhyKTbFjiQYDrCeqiKc/+swjYtHYxiQW2kz+AAV1iQ0QjaX/fOUH+W1geO0a45sr
         Gxpegg8Nf37eTMM+UVRjXX2im2U+ELwPUHBc2wsRW4EFRvXZQY+un2uPi62PMExQgTHH
         henRfVN7Gskbg1BSeTHu58ZBVsAo6D5pPHO7zXDkitroBCFSn53jXBNRTvHdBvEDfqpB
         qoKnejrWsoC+RmTXf9+5Kqlh+B4nl/e7AcTaqwrSV6M2HfT+lcrN3iDSdzeJUKInA8jQ
         N4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711057063; x=1711661863;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOtrT19asMXEr0TwJpVFoh7wEKo99GZ26en2SG6Gpmk=;
        b=UVJmLHGkH53PZ+ooITafXP0KHsf4jf5so0KeYEcmqgk/VihZKP1e4mNaHCS7FyaqQ0
         cxhDDR8UPaGWd9XQciepYahkQ/I4wi8z5SxbRu99HAV6lWmXKhjRFc913XFQCXc/1WWi
         Sh6wi/cjOy/xxatI0tKina9zi8h+LucLlvh/HYPAP2GPjs7Vyk5cRQKV8Y5sccidthv1
         MmWKCY4B4rzsmkfAxkXA0p5qDJbEgZspUjfkxV/8aBKy5EzNcmVWc2ibSnWE3+tlIkn6
         ya3SqDJ0SaLly3hTWU4a0kBnD0b4bG/OJwg8z1LBdz5MLd5Bhgoy+ej7Tk4QwYx++Lza
         jIIA==
X-Gm-Message-State: AOJu0YxSmybIXQQkvA24Ye/SOzD3Ixtt+hZ/RkSIjISg4otQo1hy5Gml
	R6H0E8ZYkUwTEOtbgIVPVvpXH1uvO7tQCgSx/S3y1Bid2gmVlFOZ66LxDYZVORkFRq/dNL+KRg+
	6Hw==
X-Google-Smtp-Source: AGHT+IFG44GRpyLSoCdzTAgGOvr+Ykn7xEnNSiVaxpdqGc3Wa47XGjUxz3BVE+W4nqXyifeoqem9jdAgDIM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:f1e:0:b0:5d5:1e4d:c845 with SMTP id
 e30-20020a630f1e000000b005d51e4dc845mr1288pgl.10.1711057063490; Thu, 21 Mar
 2024 14:37:43 -0700 (PDT)
Date: Thu, 21 Mar 2024 21:37:38 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240321213738.1705396-1-edliaw@google.com>
Subject: [PATCH v2] uffd-unit-tests: Fix ARM related issue with fork after pthread_create
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Lokesh Gidra <lokeshgidra@google.com>
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
 tools/testing/selftests/mm/uffd-common.c     |  3 +++
 tools/testing/selftests/mm/uffd-common.h     |  2 ++
 tools/testing/selftests/mm/uffd-unit-tests.c | 10 ++++++++++
 3 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index b0ac0ec2356d..7ad6ba660c7d 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -18,6 +18,7 @@ bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
 uffd_test_case_ops_t *uffd_test_case_ops;
+atomic_bool ready_for_fork;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -518,6 +519,8 @@ void *uffd_poll_thread(void *arg)
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


