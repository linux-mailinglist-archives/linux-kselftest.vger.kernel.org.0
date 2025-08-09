Return-Path: <linux-kselftest+bounces-38624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B5B1F2C6
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 09:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275CD4E04B7
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 07:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FBF26B755;
	Sat,  9 Aug 2025 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuLlsZL0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465AB221DAE
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Aug 2025 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754723854; cv=none; b=PU3bF9zqt/aMlkBJt1+OTJUTrXVgyUlZin1iiIzk2ELai22qjH4sYnfFY7vln1HWDAX3f1jnIBix0yTq3TEt0dgf9PvijSM5zYGnbW3J0a62rVfID51b8YIOthjC71Y7xDqmIYQLnCJ/nPxCknF/TiBRoRmSMi1zIzL54idUHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754723854; c=relaxed/simple;
	bh=7RdV+FBP06VjwQ/txKPnl67VliS6wYw4Wv2njRykI9o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=E2KV43OK5ECaCxUrute/xln/D6OXjhvchSYW9ZhCrd6nBClqiP3rDtAlrSpoXx0buw9fIRi9X7Hm+aiLb+FuFy9JsQI5bt8dRO3Dn2zQLxXPg+QtY7f1LVt5YeFlzXPL/9FhFa1xHsy1m2yJnYtw8rKKhmMVdj747CPih83Djoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuLlsZL0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4310451ae4so2092483a12.3
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Aug 2025 00:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754723852; x=1755328652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DWzStXgfyy77iNEtIPZKhtNkEi1SDYKI2NDSZbmaLwo=;
        b=BuLlsZL04LUSb0mYNIMf0VPURhWhSBRkML5AaCqGMIv23E2f8FcsrFmgltjz5ob3N/
         r6C8qC61YtCp4Gmp3fo6z5Bt2rfALo4AxTuUq8xYk6Kq3HJB/JKShmUj0kW+3qMqkA/C
         3PemGKjJLZ95ierBuEsjFxECnHmpKII+dzDgbvLtb92ltRcJh1j4tF0PBPa0OFRpmBki
         IemM5CHR+qDvHpAP9VMKmpcDXwEX9+C3EuoAfLGbJgbqHjv6pQ1R1l9aUnlYY58W/rvJ
         qj4Xl0wznfmh1srVle9MTwsMCftWn6QBW1KNOg1BaND4a0iwJLCU37fIAXbqoY0iuiyO
         SrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754723852; x=1755328652;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWzStXgfyy77iNEtIPZKhtNkEi1SDYKI2NDSZbmaLwo=;
        b=KIUF2eysuqSUdADtuOxXysnxiXbA9JU25uFuZVvETPg+WukOs6EUHQaEL5P5OqQIeI
         AptHZmvwCWi9R3Pcp0wB6fSwM6Wem7cLfEZJlN695gb8w93D3P8P4TtZv2hI0PYHFjqa
         2/UBdx+3qrV3/x3KnVt5zoFuAWJ0oeb1FyHnAcWjAfhrwJPCSCAwXvG2E56VjueZ+v/m
         Km+w03pzmvOC1pnsNOdrrpIPr+LTFVMxQYnWdELllEx8dJCXnKRRFRI5bF6kJK43x00C
         K1V7vf2MifD7qfy0kV5xA44KrAj3HtyqDLnOYtzJZHyn5k7M+V64l1GbEb3nX3eBuPs+
         7b4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaQ0YGSkc0OsiF78bMeLudaCPovOxQNmqb8aq2qPXEHC2wnHN1+LhiNNQw8Prx3yGIFVxneGO4l7s7COAEY5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJjjH4+mDKTz+XRWpnY3INemM5OBqIfRs5h0e6j+DvZjt032O5
	n8NRuwuZhuArYcdh+s3J/U+dHxuekoY0SwG3fkMpqflmwEscSwi81hPlF/FZWl5awMNAmbTXKXg
	Cgw==
X-Google-Smtp-Source: AGHT+IFA477Allh8p4wSHn1fQQvXfGqMNrPjal5kZ4Vn4LBMPx05x5CDly/bO1x7yhwbMPnwO0/ig+WGlg==
X-Received: from plnd6.prod.google.com ([2002:a17:903:1986:b0:240:cb70:ad8e])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:110f:b0:23f:df36:5f0c
 with SMTP id d9443c01a7336-242c21dda3emr83175785ad.29.1754723852568; Sat, 09
 Aug 2025 00:17:32 -0700 (PDT)
Date: Sat,  9 Aug 2025 15:17:27 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250809071727.2422511-1-wakel@google.com>
Subject: [PATCH v3] selftests/futex: Check for shmget support at runtime
From: Wake Liu <wakel@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Wake Liu <wakel@google.com>
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
 .../selftests/futex/functional/futex_wait.c   | 57 ++++++++-------
 .../selftests/futex/functional/futex_waitv.c  | 73 ++++++++++++-------
 2 files changed, 78 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/testing/selftests/futex/functional/futex_wait.c
index 685140d9b93d..2a834f074959 100644
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
@@ -96,32 +96,37 @@ int main(int argc, char *argv[])
 	/* Testing an anon page shared memory */
 	shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
 	if (shm_id < 0) {
-		perror("shmget");
-		exit(1);
-	}
-
-	shared_data = shmat(shm_id, NULL, 0);
-
-	*shared_data = 0;
-	futex = shared_data;
-
-	info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
-
-	usleep(WAKE_WAIT_US);
-
-	info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
-	res = futex_wake(futex, 1, 0);
-	if (res != 1) {
-		ksft_test_result_fail("futex_wake shared (page anon) returned: %d %s\n",
-				      errno, strerror(errno));
-		ret = RET_FAIL;
+		if (errno == ENOSYS) {
+			ksft_test_result_skip("Kernel does not support System V shared memory\n");
+		} else {
+			ksft_test_result_fail("shmget() failed with error: %s\n", strerror(errno));
+			ret = RET_FAIL;
+		}
 	} else {
-		ksft_test_result_pass("futex_wake shared (page anon) succeeds\n");
+		shared_data = shmat(shm_id, NULL, 0);
+
+		*shared_data = 0;
+		futex = shared_data;
+
+		info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
+		if (pthread_create(&waiter, NULL, waiterfn, NULL))
+			error("pthread_create failed\n", errno);
+
+		usleep(WAKE_WAIT_US);
+
+		info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
+        res = futex_wake(futex, 1, 0);
+        if (res != 1) {
+            if (res < 0)
+                ksft_test_result_fail("futex_wake shared (page anon) failed with res=%d: %m\n", res);
+            else
+                ksft_test_result_fail("futex_wake shared (page anon) returned %d, expected 1\n", res);
+            ret = RET_FAIL;
+        } else {
+            ksft_test_result_pass("futex_wake shared (page anon) succeeds\n");
+        }
 	}
 
-
 	/* Testing a file backed shared memory */
 	fd = open(SHM_PATH, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
 	if (fd < 0) {
@@ -161,7 +166,8 @@ int main(int argc, char *argv[])
 	}
 
 	/* Freeing resources */
-	shmdt(shared_data);
+	if (shared_data)
+		shmdt(shared_data);
 	munmap(shm, sizeof(f_private));
 	remove(SHM_PATH);
 	close(fd);
@@ -169,3 +175,4 @@ int main(int argc, char *argv[])
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


