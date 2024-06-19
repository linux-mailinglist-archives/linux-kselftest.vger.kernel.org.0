Return-Path: <linux-kselftest+bounces-12189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 464B490E0C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C290D2833F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 00:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D4A15CE;
	Wed, 19 Jun 2024 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1r9twxW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93B1C3E
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718756531; cv=none; b=TKIet/Q6PbeiGfPmES3IYQA9lNQ5CRSsNDXjJq+JNUk+YUTcsIIywivbOX1KrvLDYXeS1eXzC3Qy75ydH5VBGlKXWE90z+e0gpad4UgpZEO0K2/Le+QlmzTgaU9XA+6JNb5UalrMekQi26BxiA93o2HLGdMu12TbeUobbpMN7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718756531; c=relaxed/simple;
	bh=qM+LxVb3gd4Cbbp6AwSC8O9zXKOmQtVsfa3JiOHGIIg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XfsJgc6a3UTmWH21ggKyiGcCmG+WpMCTbLk0aKGNBI7XJzhqi/FpIhOvISlm9S3IOfE3RW3VDFcyBKuHAB5BMabre/cMGsL6Eu+CszCRfH1uncuoaBemdkAZzXWMwkmbhuTMihMcuGi0IZsNOGWO7lcRd/USUmupm+rgltM39NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1r9twxW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f66f2e4cc7so82846475ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 17:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718756530; x=1719361330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ahBmUPS4Gd/AZ2DWokpFsWoFXzbZMIx0lYvExMMEgDs=;
        b=I1r9twxWQRxXYWRGLBkRuBkU8DXC53/eyeemo0zH+L7zK2N62hO4IRfjVcMzaHYXmU
         7S3OEb9goyKGpw2i1gYjo/kFeKYERSUQlJLHCf2zVACVwqS8+51pLfSbSigmcm16+jXG
         qB964P56z0fJ8M16rDSow0rRwfvMQBD7nhrWCNT7A7pW0kSAC3o0hbA/hNnwxIkE0OlT
         KOB/ZQZpFmQpWavEvzd0s5Hr6HEdwJmyO69L1kRRQd7+8vFXwJn8YqAzQExicCa5/QbO
         UD3sYYkErNXOl/B3L7uGC0nBVJKwoI6q07cbCX/bjvaUMHqypuqpfmhTMPKkPmBl3VBJ
         3zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718756530; x=1719361330;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ahBmUPS4Gd/AZ2DWokpFsWoFXzbZMIx0lYvExMMEgDs=;
        b=WY/acTrXCM/OCJqlkw1KFM/55Eyy1SKjVR5UxlKirKLNKrwu3ABeYuyrxqETyX+uvm
         ZZZ4QkvB734nJBInm9fzkY5vnV0dhwlQlkrzvn6kcXkel8qWVch1+x9CLqdXpOCgWKje
         MQt17I0mN1yXn6Pit/zAiUZFNU9SqmIu6xYVtXYuslmoFBLQK8dvABe3APYuw8NZqVxu
         TKlTa6v7jk+xrtBU52tnwNTgSUEOQ+9m12nwk+WB26OO53EbwbVSGyXbA4IEoSQjUQgF
         KB+miAFuiWA3mOQ4G1+pZKL1ejfSLcybVxq/OaaXZAqwYuv2wx+sXMK77o8t4Npj452W
         S1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzO8qt1vbsManNiS9unrbQp/8m389lFAfLOxSvefd9GvFUo7lsQRXLQZ7YOHThU7Q3SeeZ018WsI/fqajLCr7XzxsXcxR+TEDyhHRQJccC
X-Gm-Message-State: AOJu0YwqDV+obloQbnyTBrPXjjLthq4duVFAQ7ewyvXxBYJT4vU1kyuP
	QDwKQpv8k2sfTJWYr2M4wy9t0CN7Ka9smRmtEQqZL++e46XR4PCNqBDeSXT3riNkJ4XyrL2Rp/V
	vqg==
X-Google-Smtp-Source: AGHT+IGuzqkcfFNHspKhd9S3iQjNf5nMtU8q6h/0CLbWzogJs2rTSXjiomF+jr/wK3M2dHQupyre3nYJvrc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e744:b0:1f6:fbea:7959 with SMTP id
 d9443c01a7336-1f9aa25aaa7mr302005ad.0.1718756529581; Tue, 18 Jun 2024
 17:22:09 -0700 (PDT)
Date: Wed, 19 Jun 2024 00:22:03 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240619002204.2492673-1-edliaw@google.com>
Subject: [PATCH] selftests/futex: Order calls in futex_requeue
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>
Content-Type: text/plain; charset="UTF-8"

Like fbf4dec70277 ("selftests/futex: Order calls to futex_lock_pi"),
which fixed a flake in futex_lock_pi due to racing between the parent
and child threads.

The same issue can occur in the futex_requeue test, because it expects
waiterfn to make progress to futex_wait before the parent starts to
requeue. This is mitigated by the parent sleeping for WAKE_WAIT_US, but
it still fails occasionally. This can be reproduced by adding a sleep in
the waiterfn before futex_wait:

TAP version 13
1..2
not ok 1 futex_requeue simple returned: 0
not ok 2 futex_requeue simple returned: 0
not ok 3 futex_requeue many returned: 0
not ok 4 futex_requeue many returned: 0

Instead, replace the sleep with barriers to make the sequencing
explicit.

Fixes: 7cb5dd8e2c8c ("selftests: futex: Add futex compare requeue test")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../selftests/futex/functional/futex_requeue.c       | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
index 51485be6eb2f..8f7d3e8bf32a 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -12,9 +12,9 @@
 
 #define TEST_NAME "futex-requeue"
 #define timeout_ns  30000000
-#define WAKE_WAIT_US 10000
 
 volatile futex_t *f1;
+static pthread_barrier_t barrier;
 
 void usage(char *prog)
 {
@@ -32,6 +32,8 @@ void *waiterfn(void *arg)
 	to.tv_sec = 0;
 	to.tv_nsec = timeout_ns;
 
+	pthread_barrier_wait(&barrier);
+
 	if (futex_wait(f1, *f1, &to, 0))
 		printf("waiter failed errno %d\n", errno);
 
@@ -70,13 +72,15 @@ int main(int argc, char *argv[])
 	ksft_print_msg("%s: Test futex_requeue\n",
 		       basename(argv[0]));
 
+	pthread_barrier_init(&barrier, NULL, 2);
 	/*
 	 * Requeue a waiter from f1 to f2, and wake f2.
 	 */
 	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
 		error("pthread_create failed\n", errno);
 
-	usleep(WAKE_WAIT_US);
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_destroy(&barrier);
 
 	info("Requeuing 1 futex from f1 to f2\n");
 	res = futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
@@ -99,6 +103,7 @@ int main(int argc, char *argv[])
 		ksft_test_result_pass("futex_requeue simple succeeds\n");
 	}
 
+	pthread_barrier_init(&barrier, NULL, 11);
 
 	/*
 	 * Create 10 waiters at f1. At futex_requeue, wake 3 and requeue 7.
@@ -109,7 +114,8 @@ int main(int argc, char *argv[])
 			error("pthread_create failed\n", errno);
 	}
 
-	usleep(WAKE_WAIT_US);
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_destroy(&barrier);
 
 	info("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
 	res = futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
-- 
2.45.2.627.g7a2c4fd464-goog


