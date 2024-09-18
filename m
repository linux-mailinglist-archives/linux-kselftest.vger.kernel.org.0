Return-Path: <linux-kselftest+bounces-18122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083FF97C227
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 01:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2460E1C21EB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 23:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526A1CB528;
	Wed, 18 Sep 2024 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g91/ANPd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE71BF33E
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726701069; cv=none; b=JZu7RXjegNTV4IuMKtXBGSQb3cGlNS8kYE4VPjhokcARto8WdB2YxAaxPxh+5ucXSgDHxZS4R6M1kNyYTK99ObMDlxKt8B5YxhvxIzTYO9o+USpbQqkTdomx71/+pfRkb9MNs6V8Hy0rswHZqOUqOC2V3A/Oj7N7kzeqdW20lBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726701069; c=relaxed/simple;
	bh=jEpaRqX8x9ZoV7NGwJBcnn25L7osKDYWpdYayHxA/LA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lyhjO/LM+G8+l24nVE4CvLSBTt+G/ok/FfFJTH/1iUrL7E6l6FNQjn21IC9+FdG8Y29slH1jgFmOPk8kz6Th2bU3KoD1kpuxo+k1xiMlwWBGqGvvVx/GvDs1cX/SJLss/ZwkWCix9F5IfPiyjy0Vo2doOZiIVtMbjKVPzIEs45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g91/ANPd; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718f329aefdso302233b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 16:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726701067; x=1727305867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YA0w8JE4YsZuKs1FGvLh6dGW1GjJTJ/xAnovafRZBSc=;
        b=g91/ANPdvKRT1unAuHZ3HNIG6DrWTaKovSUrPoIrqD1hG/4dFvffb3le2ooATQIfzI
         WLKk2hpkpkVJ/eO72I3Pd/YB1iGuMfVQCcfVm5ChV/rUpWqTeVLF8ej+b4Hpj2qdyKLk
         efZWxVtiQHAsnDsxLOtGWeGGyIOo5asAkuG47kp4o4Q5p7Lh0FMSTp7qmYpghsQ2vcgu
         hwI1ZhtfUA1doYnuLuwWm1IIfgsRUISYFjGQNKvuAQV0OtOGFEk6W1gP7hS8mo2qgRek
         BW+EPWeqKu21BGPa6f0XkxvuBmZFRfyY3y6QbX0NLtLASIzUPXcNClqZmr3k1O2g1ZdY
         kVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726701067; x=1727305867;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YA0w8JE4YsZuKs1FGvLh6dGW1GjJTJ/xAnovafRZBSc=;
        b=G6rK7f0G3ZsSk/Sk+2E4afjJzyHGPCmBB0VtP20SahP+/ko2Ew4eD0Q4YGgIYbsIu0
         9YSuYYbUwwLxc4q7pnhNe1QOtdaaxewINShzV5qWYBtx8iV5VkxqfGntFsi5CYEadNwp
         iwDm598k7HLp10wg3/0KLyOXdfPkhvR9cAONIi64/aimsW69VInmB2Y0rFRMVVlWz6u2
         epPsHKZ2BUEtGkHRDe9iHnaMIE2y+iKcN36c7+GD48vjuzDocQNFD/+fQisx2Ii9YuZc
         fMmZ9YbfNDZzIcTheWjmk15WqMyMkpUSMf9FbuKvn6QYTBn12wdEYj4jzWniuv2NftEi
         8wiw==
X-Gm-Message-State: AOJu0Ywcbr2jzC1VKd0QxfNBoOdgO6tK84R8yQpBn0fSTaqs52ob6mXV
	BOnnz5H7pPzteAfzIFDZqH6Z+K/oWq0LhibHnRe2Q1dyVy4HoI/tCNtlH+1y8Saae6hEBGKQfn6
	jLxPAPMYsQ5TOoRcYV7DVlEew7ncJ49K3NaDs9hhzW4wm79ZeNQQvUxqCgeEoIAlWwmqCWAcJj0
	wKv763So2H97TE3U44Gs1xusZKzH9ceh4YbCrvVBgTMxjL
X-Google-Smtp-Source: AGHT+IFR5wvpsM8KmOcWHfEpfCZTMacE04uaSHilS6oprIqygqchRKXw74pEjG1MSWi2VY6unf7hnOt+cOo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a62:e302:0:b0:718:d4f5:aa40 with SMTP id
 d2e1a72fcca58-71936b74189mr42304b3a.5.1726701065978; Wed, 18 Sep 2024
 16:11:05 -0700 (PDT)
Date: Wed, 18 Sep 2024 23:11:00 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918231102.234253-1-edliaw@google.com>
Subject: [PATCH RESEND v2] selftests/futex: Order calls in futex_requeue
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Davidlohr Bueso <dbueso@suse.de>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixes a race between parent and child threads in futex_requeue.

Similar to fbf4dec70277 ("selftests/futex: Order calls to
futex_lock_pi"), which fixed a flake in futex_lock_pi due to racing
between the parent and child threads.

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
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/futex_requeue.c       | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/too=
ls/testing/selftests/futex/functional/futex_requeue.c
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
 	to.tv_sec =3D 0;
 	to.tv_nsec =3D timeout_ns;

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
 	res =3D futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
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
 	res =3D futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
--
2.46.0.662.g92d0881bb0-goog


