Return-Path: <linux-kselftest+bounces-38465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B902B1D728
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 14:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195321891C7D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C81521C167;
	Thu,  7 Aug 2025 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNt1hp2P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A704D1FDD
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568074; cv=none; b=TzJqbByoLKSLY2nf1WF6E9x9o1O3Mh6n6ZOLBfJrntZZsqSKIkrRep9HGu4z0Xpnqikb2xH6fFM+qg6DELvI/vSBwoWDwu5O8pyydiKxupRneDjXBQlDRLyqcg3Rb3W6rpmqwY6q6t/vH+4vnMrf5TJkHlV4ggtCzfKChSc6hZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568074; c=relaxed/simple;
	bh=PTuDDwFBwxhGEN64Mf0RFqdneEGdd1Qgrhit1izSWXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ctx/Dv1XJGNdpPUfgoLJTjXaAg0i8sXzsJG6qfl2pVGgOREafNvE2CJfkbTdcLu0ye3XN0di1KanId/DTjRUstFQGKG+VfPQM3htKQ+L4atc6lBfyXQ9qPwIo4dN7SZ640M88WZAnyXPZdwsmvHAhrv7xXZmbVyF5PyUq9/WTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNt1hp2P; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3211b736a11so2100698a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754568072; x=1755172872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nE+MHF3K5eYH5csmXDAz3FZkVfKhmhgeV7wuvi+Opms=;
        b=NNt1hp2PiU00rpElFCxC7emx05wyFj5a3k7fnvcty/TXyWjM1J99NFGjUxO0ha1ga1
         mjppkimoZ664VwQKt06z8RL4kJ81ZpmmQyG/zxjvPPrI85gYYXm8ZUFJPVrfs+9CyDzY
         jYTrfJ/rHmvpWtGeeESQl8TtiS29J3tOo9cUfOhHKA6isd2xL5ig9Kmms90wMxcWtmH8
         zA8hdNy0K++sLOn7samhN/tQ4tsLavXM+qLRn73LXCymgFm55BB1m/bOyxGo1yWSr2Hj
         MbeWTW0gF+VqY0fVdVgQ7vXCr8Vs4Yeh0ydj483rtnL617vOdnGAVm3ssO0kJm/oax4H
         vPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754568072; x=1755172872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nE+MHF3K5eYH5csmXDAz3FZkVfKhmhgeV7wuvi+Opms=;
        b=dZ2dzpCQMNSiGIdMnCGSa/vWdSX0SZmE/eXv5NsXntQjANfOlTTwfOJlW7sQxpZ+0N
         8VYm7D6i/oIq6xnRd4DPRW7rWUI8ZmFfsYPieV3uxB7n0xWC2f0j8Oji+sqw3Y87o3lX
         Oo1v07sbuUBnqOHNumFBWU48nMgEec5YxEYohboHHp+LmuYW7j0f/I5A4X9MVOJvJe3l
         WbunIvUwZEAoaVjGyHmjOBeTXdbGhKhACjbjKZQzJ87ss71IaVPexfowoeBwrwpE7o/I
         OOUsD+RtZ3oREr46Dibs+6HKhEMaywWGJ1qxHzWKEMek6mLd1JeYlIyiscl9Kpq5e5U8
         oh3w==
X-Forwarded-Encrypted: i=1; AJvYcCXKK0lTaLbVK/8jl6iM1ELQWfO1gdPYtynoaDyybrbrRprsqKRfH1xFp38mPiKPOi29az6WeDRHGtuxPkFhE2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh31+09zSU/nNcHDJEmimtCng+DYwD/l6sBwQv49g/KBjp24p0
	ZJgyAGz6R3t5xyrWovh0ycmhLnF+V/gNWK3cYsRPzia49rFvbe4i8scWmXuvqpQ5WgkRiYmgM/H
	E8w==
X-Google-Smtp-Source: AGHT+IEiq+F58PXfR8QwIK6Rfn8eBJtpb9nE3fFwhIJI+opiDopLji7Te3FqifzMunuYwkoBSIlVwbNmUw==
X-Received: from pjbpv3.prod.google.com ([2002:a17:90b:3c83:b0:312:e266:f849])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5101:b0:31f:3c3:947c
 with SMTP id 98e67ed59e1d1-32166c2af67mr9244790a91.10.1754568071943; Thu, 07
 Aug 2025 05:01:11 -0700 (PDT)
Date: Thu,  7 Aug 2025 20:00:42 +0800
In-Reply-To: <20250807120042.1761685-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807120042.1761685-1-wakel@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807120042.1761685-2-wakel@google.com>
Subject: [PATCH v2 1/1] selftests/futex: Check for shmget support at runtime
From: Wake Liu <wakel@google.com>
To: tglx@linutronix.de, mingo@redhat.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net, 
	andrealmeid@igalia.com, wakel@google.com
Content-Type: text/plain; charset="UTF-8"

The futex tests `futex_wait.c` and `futex_waitv.c` rely on the `shmget()`
syscall, which may not be available if the kernel is built without
System V IPC support (CONFIG_SYSVIPC=n). This can lead to test
failures on such systems.

This patch modifies the tests to check for `shmget()` support at
runtime by calling it and checking for an `ENOSYS` error. If `shmget()`
is not supported, the tests are skipped with a clear message,
improving the user experience and preventing false negatives.

This approach is more robust than relying on compile-time checks and
ensures that the tests run only when the required kernel features are
present.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../selftests/futex/functional/futex_wait.c   | 49 +++++++------
 .../selftests/futex/functional/futex_waitv.c  | 73 ++++++++++++-------
 2 files changed, 73 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/testing/selftests/futex/functional/futex_wait.c
index 685140d9b93d..17a465313a59 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -48,7 +48,7 @@ static void *waiterfn(void *arg)
 int main(int argc, char *argv[])
 {
 	int res, ret = RET_PASS, fd, c, shm_id;
-	u_int32_t f_private = 0, *shared_data;
+	u_int32_t f_private = 0, *shared_data = NULL;
 	unsigned int flags = FUTEX_PRIVATE_FLAG;
 	pthread_t waiter;
 	void *shm;
@@ -96,32 +96,35 @@ int main(int argc, char *argv[])
 	/* Testing an anon page shared memory */
 	shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
 	if (shm_id < 0) {
-		perror("shmget");
-		exit(1);
-	}
-
-	shared_data = shmat(shm_id, NULL, 0);
+		if (errno == ENOSYS) {
+			ksft_test_result_skip("Kernel does not support System V shared memory\n");
+		} else {
+			ksft_test_result_fail("shmget() failed with error: %s\n", strerror(errno));
+			ret = RET_FAIL;
+		}
+	} else {
+		shared_data = shmat(shm_id, NULL, 0);
 
-	*shared_data = 0;
-	futex = shared_data;
+		*shared_data = 0;
+		futex = shared_data;
 
-	info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
+		if (pthread_create(&waiter, NULL, waiterfn, NULL))
+			error("pthread_create failed\n", errno);
 
-	usleep(WAKE_WAIT_US);
+		usleep(WAKE_WAIT_US);
 
-	info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
-	res = futex_wake(futex, 1, 0);
-	if (res != 1) {
-		ksft_test_result_fail("futex_wake shared (page anon) returned: %d %s\n",
-				      errno, strerror(errno));
-		ret = RET_FAIL;
-	} else {
-		ksft_test_result_pass("futex_wake shared (page anon) succeeds\n");
+		info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
+		res = futex_wake(futex, 1, 0);
+		if (res != 1) {
+			ksft_test_result_fail("futex_wake shared (page anon) returned: %d %s\n",
+					      errno, strerror(errno));
+			ret = RET_FAIL;
+		} else {
+			ksft_test_result_pass("futex_wake shared (page anon) succeeds\n");
+		}
 	}
 
-
 	/* Testing a file backed shared memory */
 	fd = open(SHM_PATH, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
 	if (fd < 0) {
@@ -161,7 +164,8 @@ int main(int argc, char *argv[])
 	}
 
 	/* Freeing resources */
-	shmdt(shared_data);
+	if (shared_data)
+		shmdt(shared_data);
 	munmap(shm, sizeof(f_private));
 	remove(SHM_PATH);
 	close(fd);
@@ -169,3 +173,4 @@ int main(int argc, char *argv[])
 	ksft_print_cnts();
 	return ret;
 }
+
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index a94337f677e1..034dbfef40cb 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -110,40 +110,58 @@ int main(int argc, char *argv[])
 	}
 
 	/* Shared waitv */
-	for (i = 0; i < NR_FUTEXES; i++) {
-		int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
-
-		if (shm_id < 0) {
-			perror("shmget");
-			exit(1);
+	bool shm_supported = true;
+	int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+
+	if (shm_id < 0) {
+		if (errno == ENOSYS) {
+			shm_supported = false;
+			ksft_test_result_skip("Kernel does not support System V shared memory\n");
+		} else {
+			ksft_test_result_fail("shmget() failed with error: %s\n", strerror(errno));
+			ret = RET_FAIL;
+			shm_supported = false;
 		}
+	} else {
+		shmctl(shm_id, IPC_RMID, NULL);
+	}
 
-		unsigned int *shared_data = shmat(shm_id, NULL, 0);
+	if (shm_supported) {
+		for (i = 0; i < NR_FUTEXES; i++) {
+			int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
 
-		*shared_data = 0;
-		waitv[i].uaddr = (uintptr_t)shared_data;
-		waitv[i].flags = FUTEX_32;
-		waitv[i].val = 0;
-		waitv[i].__reserved = 0;
-	}
+			if (shm_id < 0) {
+				perror("shmget");
+				exit(1);
+			}
 
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+			unsigned int *shared_data = shmat(shm_id, NULL, 0);
 
-	usleep(WAKE_WAIT_US);
+			*shared_data = 0;
+			waitv[i].uaddr = (uintptr_t)shared_data;
+			waitv[i].flags = FUTEX_32;
+			waitv[i].val = 0;
+			waitv[i].__reserved = 0;
+		}
 
-	res = futex_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), 1, 0);
-	if (res != 1) {
-		ksft_test_result_fail("futex_wake shared returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
-	} else {
-		ksft_test_result_pass("futex_waitv shared\n");
-	}
+		if (pthread_create(&waiter, NULL, waiterfn, NULL))
+			error("pthread_create failed\n", errno);
 
-	for (i = 0; i < NR_FUTEXES; i++)
-		shmdt(u64_to_ptr(waitv[i].uaddr));
+		usleep(WAKE_WAIT_US);
+
+		res = futex_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), 1, 0);
+        if (res != 1) {
+            ksft_test_result_fail("futex_wake shared returned: %d %s\n",
+                                  res ? errno : res,
+                                  res ? strerror(errno) : "");
+            ret = RET_FAIL;
+        } else {
+			ksft_test_result_pass("futex_waitv shared\n");
+		}
+
+		for (i = 0; i < NR_FUTEXES; i++)
+			shmdt(u64_to_ptr(waitv[i].uaddr));
+	}
 
 	/* Testing a waiter without FUTEX_32 flag */
 	waitv[0].flags = FUTEX_PRIVATE_FLAG;
@@ -235,3 +253,4 @@ int main(int argc, char *argv[])
 	ksft_print_cnts();
 	return ret;
 }
+
-- 
2.50.1.703.g449372360f-goog


