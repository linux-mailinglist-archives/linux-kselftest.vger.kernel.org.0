Return-Path: <linux-kselftest+bounces-24450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8D4A10A16
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 15:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7297B18870BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A72815746B;
	Tue, 14 Jan 2025 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uJtnCU+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543BF155CBF;
	Tue, 14 Jan 2025 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866732; cv=none; b=jVmIIADEmHcGZiNa0lW3HCFDTJY5oZPAbnkp7SiJFwOWm0VgNih2gDegLijZqSYzi4CXN00wtKMWT8GS1WWVnv+A+372xAj2NqOm+N8WE2gsyzznnhQC7+5qe1P6FRfbcAFynfFcS9DuhoLxlsKZGjOGIEQZ87OC7nqs2oSguPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866732; c=relaxed/simple;
	bh=Dg25GqDVqqCMzAW6PQxRrOB9Py5nYcOhwwIW8ovLDYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mmkMag5psr0ndv+G+IAChGTtywQ1LgT3/nWcp6O3/KoKicprMb2Fl3J/RqvKQmu4KumKx1gZaszpwpJ+HKzdfnG1sH9vE4cAAMjg/7uNjTo1aCsXMMeRcgVhhvkUvWkoNDk6fLxUWGtr2XIFby+IEL4P0FzKp0cWSKGnSUv3hJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=uJtnCU+Q; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1736866297;
	bh=Dg25GqDVqqCMzAW6PQxRrOB9Py5nYcOhwwIW8ovLDYY=;
	h=From:To:Cc:Subject:Date:From;
	b=uJtnCU+Qnk5rFjnzVK/b25yXDRcnfrUN4wn1zjfzXskvJSKElhYrybZ5tltXCLHg6
	 PECHwiTVprgHddFQOYMbS06BaoLFEn6RyArLRvv2GVROGIIwIZL2yHXpBPk55Hbe8P
	 9bpdM4xkE8JZiUkVm9s2rPkNJRWC46Et2ApYvKcPy8OFCGgbTm7eJsLuVdwkdwsEBM
	 NOr40uvv+0LY7CQW1u/k7xlPsq3CU09U2kYR0ENSmGnVkoq2SXKzMlVe1U2Ny2GfdV
	 SOqqTnQp0ussdqS2sES9Un5AB2hupchi58M6jDqs5JW5UU78Ks6igcxE3YVFG1mZlD
	 KdrGebd1O0gyw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4YXXBw6nWBz1HCw;
	Tue, 14 Jan 2025 09:51:36 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] selftests/rseq: Fix handling of glibc without rseq support
Date: Tue, 14 Jan 2025 09:51:32 -0500
Message-Id: <20250114145132.612569-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When porting librseq commit:

commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")

from librseq to the kernel selftests, the following line was missed
at the end of rseq_init():

  rseq_size = get_rseq_kernel_feature_size();

which effectively leaves rseq_size initialized to -1U when glibc does not
have rseq support. glibc supports rseq from version 2.35 onwards.

In a following librseq commit

commit c67d198627c2 ("Only set 'rseq_size' on first thread registration")

to mimic the libc behavior, a new approach is taken: don't set the
feature size in 'rseq_size' until at least one thread has successfully
registered. This allows using 'rseq_size' in fast-paths to test for both
registration status and available features. The caveat is that on libc
either all threads are registered or none are, while with bare librseq
it is the responsability of the user to register all threads using rseq.

This combines the changes from the following librseq commits:

commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")
commit c67d198627c2 ("Only set 'rseq_size' on first thread registration")

Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: linux-kselftest@vger.kernel.org
Cc: stable@vger.kernel.org
---
 tools/testing/selftests/rseq/rseq.c | 32 ++++++++++++++++++++++-------
 tools/testing/selftests/rseq/rseq.h |  9 +++++++-
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 5b9772cdf265..f6156790c3b4 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -61,7 +61,6 @@ unsigned int rseq_size = -1U;
 unsigned int rseq_flags;
 
 static int rseq_ownership;
-static int rseq_reg_success;	/* At least one rseq registration has succeded. */
 
 /* Allocate a large area for the TLS. */
 #define RSEQ_THREAD_AREA_ALLOC_SIZE	1024
@@ -152,14 +151,27 @@ int rseq_register_current_thread(void)
 	}
 	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
 	if (rc) {
-		if (RSEQ_READ_ONCE(rseq_reg_success)) {
+		/*
+		 * After at least one thread has registered successfully
+		 * (rseq_size > 0), the registration of other threads should
+		 * never fail.
+		 */
+		if (RSEQ_READ_ONCE(rseq_size) > 0) {
 			/* Incoherent success/failure within process. */
 			abort();
 		}
 		return -1;
 	}
 	assert(rseq_current_cpu_raw() >= 0);
-	RSEQ_WRITE_ONCE(rseq_reg_success, 1);
+
+	/*
+	 * The first thread to register sets the rseq_size to mimic the libc
+	 * behavior.
+	 */
+	if (RSEQ_READ_ONCE(rseq_size) == 0) {
+		RSEQ_WRITE_ONCE(rseq_size, get_rseq_kernel_feature_size());
+	}
+
 	return 0;
 }
 
@@ -235,12 +247,18 @@ void rseq_init(void)
 		return;
 	}
 	rseq_ownership = 1;
-	if (!rseq_available()) {
-		rseq_size = 0;
-		return;
-	}
+
+	/* Calculate the offset of the rseq area from the thread pointer. */
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
+
+	/* rseq flags are deprecated, always set to 0. */
 	rseq_flags = 0;
+
+	/*
+	 * Set the size to 0 until at least one thread registers to mimic the
+	 * libc behavior.
+	 */
+	rseq_size = 0;
 }
 
 static __attribute__((destructor))
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 4e217b620e0c..062d10925a10 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -60,7 +60,14 @@
 extern ptrdiff_t rseq_offset;
 
 /*
- * Size of the registered rseq area. 0 if the registration was
+ * The rseq ABI is composed of extensible feature fields. The extensions
+ * are done by appending additional fields at the end of the structure.
+ * The rseq_size defines the size of the active feature set which can be
+ * used by the application for the current rseq registration. Features
+ * starting at offset >= rseq_size are inactive and should not be used.
+ *
+ * The rseq_size is the intersection between the available allocation
+ * size for the rseq area and the feature size supported by the kernel.
  * unsuccessful.
  */
 extern unsigned int rseq_size;
-- 
2.39.5


