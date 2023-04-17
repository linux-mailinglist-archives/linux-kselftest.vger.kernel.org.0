Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0686E53D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 23:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDQV3M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 17:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDQV3L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 17:29:11 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9006FF;
        Mon, 17 Apr 2023 14:29:09 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-552ae3e2cbeso61562807b3.13;
        Mon, 17 Apr 2023 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681766948; x=1684358948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=55hC0C6PEmc4uh5DYwJYIxp6KDXjWnD+6ic8XLUbNJk=;
        b=YKbaQH880ffbrD1wSOeYaho611fZvl8uvV2IkFui1/mpcsuGl8HTmTKzTVyNAeeWRv
         K2HCmGqXq9q9RWCBtcngTm57FIzo6bzfEBLWPGXhcknNkGBtu/JWCSUGP994oL9GdPs1
         BXU6gnQ18K9Yy8NqmxORm35quAoZireqRWLj4qXR7WhrabKwun03lI1kOWmO6B8EyO95
         zagmJFtTWpSdzvCaZOb7G5RHn8+Ohcw55170PB6SgxcEysKW6yrM5vqkLbQ2DNaYhKGL
         so8Hv47MKZSHkTptbG3Tp0ZjZM6r8NOfl1kiqxIEU+uxEy7RT8ZMjzyS7CUnFb7LhFf+
         1byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681766948; x=1684358948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55hC0C6PEmc4uh5DYwJYIxp6KDXjWnD+6ic8XLUbNJk=;
        b=Ycge3riNQ6QRU/LPs3RLP4IW+BZD/tC62Nqu5zOOcGD/TEqnJhr99BUvNIODKcXU/v
         xHC3UF+AWQ4hxJ7HEIbQfEC1WOv3k4j2hulcyQAwlpYItcLLPft4uBO6wvnYOBif/Obd
         nfakUcbWWjju7wc9tt/1EzpfobDsaCJLdx+bntDbsyZntxkEKWm4mp1ptYVRsBDycaJA
         7gXZvBQCxpIlM1/nDroGal9QMoxmZkQuSIv4N3wRpUGDbINe+EEEEOA//muDUNobFcxh
         p8WBNCTz4La08SH7H/iVZHPDiRUtVwSgtbshIm1vbWVMC4R5auy9qdbNh0HR9mowpxT/
         ZrSw==
X-Gm-Message-State: AAQBX9el1gMj2A8qjVDReFD2r8NP+y6zjv3CkxLexFsVBYVe0StCvkVa
        gvDEkCzg64bN6g9eZSdc8cLfI581dUM=
X-Google-Smtp-Source: AKy350Z4Nlte19iUKzHlWFsNgXXDy8Cm/QC1uz8bpSc6mOHOgOUn+xPO/slxQ2mViPvD61RnB4T2MQ==
X-Received: by 2002:a81:4f09:0:b0:541:66e8:d4da with SMTP id d9-20020a814f09000000b0054166e8d4damr14851383ywb.29.1681766947164;
        Mon, 17 Apr 2023 14:29:07 -0700 (PDT)
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id cl22-20020a05690c0c1600b0054fbadd96c4sm3332372ywb.126.2023.04.17.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 14:29:06 -0700 (PDT)
Sender: Tavian Barnes <tavianator@gmail.com>
From:   tavianator@tavianator.com
To:     linux-kernel@vger.kernel.org
Cc:     Tavian Barnes <tavianator@tavianator.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/futex: Fix pthread_create() error handling
Date:   Mon, 17 Apr 2023 17:28:57 -0400
Message-Id: <42a8405a78936a3ec96bbd0c6b5d983291faf646.1681766292.git.tavianator@tavianator.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Tavian Barnes <tavianator@tavianator.com>

The pthread APIs return error codes, rather than setting errno.

Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
---
 .../selftests/futex/functional/futex_requeue.c    | 10 ++++++----
 .../functional/futex_requeue_pi_mismatched_ops.c  |  5 +++--
 .../selftests/futex/functional/futex_wait.c       | 15 +++++++++------
 .../functional/futex_wait_private_mapped_file.c   |  2 +-
 .../functional/futex_wait_uninitialized_heap.c    |  2 +-
 .../selftests/futex/functional/futex_waitv.c      | 10 ++++++----
 6 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
index 51485be6eb2f..76f672ad5263 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -73,8 +73,9 @@ int main(int argc, char *argv[])
 	/*
 	 * Requeue a waiter from f1 to f2, and wake f2.
 	 */
-	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+	res = pthread_create(&waiter[0], NULL, waiterfn, NULL);
+	if (res)
+		error("pthread_create failed\n", res);
 
 	usleep(WAKE_WAIT_US);
 
@@ -105,8 +106,9 @@ int main(int argc, char *argv[])
 	 * At futex_wake, wake INT_MAX (should be exactly 7).
 	 */
 	for (i = 0; i < 10; i++) {
-		if (pthread_create(&waiter[i], NULL, waiterfn, NULL))
-			error("pthread_create failed\n", errno);
+		res = pthread_create(&waiter[i], NULL, waiterfn, NULL);
+		if (res)
+			error("pthread_create failed\n", res);
 	}
 
 	usleep(WAKE_WAIT_US);
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
index d0a4d332ea44..e28de62bc03a 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
@@ -79,8 +79,9 @@ int main(int argc, char *argv[])
 	ksft_print_msg("%s: Detect mismatched requeue_pi operations\n",
 	       basename(argv[0]));
 
-	if (pthread_create(&child, NULL, blocking_child, NULL)) {
-		error("pthread_create\n", errno);
+	ret = pthread_create(&child, NULL, blocking_child, NULL);
+	if (ret) {
+		error("pthread_create\n", ret);
 		ret = RET_ERROR;
 		goto out;
 	}
diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/testing/selftests/futex/functional/futex_wait.c
index 685140d9b93d..2e06539e5bb7 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -78,8 +78,9 @@ int main(int argc, char *argv[])
 
 	/* Testing a private futex */
 	info("Calling private futex_wait on futex: %p\n", futex);
-	if (pthread_create(&waiter, NULL, waiterfn, (void *) &flags))
-		error("pthread_create failed\n", errno);
+	res = pthread_create(&waiter, NULL, waiterfn, (void *) &flags);
+	if (res)
+		error("pthread_create failed\n", res);
 
 	usleep(WAKE_WAIT_US);
 
@@ -106,8 +107,9 @@ int main(int argc, char *argv[])
 	futex = shared_data;
 
 	info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+	res = pthread_create(&waiter, NULL, waiterfn, NULL);
+	if (res)
+		error("pthread_create failed\n", res);
 
 	usleep(WAKE_WAIT_US);
 
@@ -145,8 +147,9 @@ int main(int argc, char *argv[])
 	futex = shm;
 
 	info("Calling shared (file backed) futex_wait on futex: %p\n", futex);
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+	res = pthread_create(&waiter, NULL, waiterfn, NULL);
+	if (res)
+		error("pthread_create failed\n", res);
 
 	usleep(WAKE_WAIT_US);
 
diff --git a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
index fb4148f23fa3..7b4a28e8dc1a 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
@@ -100,7 +100,7 @@ int main(int argc, char **argv)
 		basename(argv[0]));
 
 	ret = pthread_create(&thr, NULL, thr_futex_wait, NULL);
-	if (ret < 0) {
+	if (ret) {
 		fprintf(stderr, "pthread_create error\n");
 		ret = RET_ERROR;
 		goto out;
diff --git a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
index ed9cd07e31c1..bf7529bd7f0d 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
@@ -103,7 +103,7 @@ int main(int argc, char **argv)
 
 	ret = pthread_create(&thr, NULL, wait_thread, NULL);
 	if (ret) {
-		error("pthread_create\n", errno);
+		error("pthread_create\n", ret);
 		ret = RET_ERROR;
 		goto out;
 	}
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index a94337f677e1..d2400b3c7d0a 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -94,8 +94,9 @@ int main(int argc, char *argv[])
 	}
 
 	/* Private waitv */
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+	res = pthread_create(&waiter, NULL, waiterfn, NULL);
+	if (res)
+		error("pthread_create failed\n", res);
 
 	usleep(WAKE_WAIT_US);
 
@@ -127,8 +128,9 @@ int main(int argc, char *argv[])
 		waitv[i].__reserved = 0;
 	}
 
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+	res = pthread_create(&waiter, NULL, waiterfn, NULL);
+	if (res)
+		error("pthread_create failed\n", res);
 
 	usleep(WAKE_WAIT_US);
 
-- 
2.40.0

