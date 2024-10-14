Return-Path: <linux-kselftest+bounces-19658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB5099CF29
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 16:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE3A28B423
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC3D1AE017;
	Mon, 14 Oct 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g8Qldc6d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7EE481B3;
	Mon, 14 Oct 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917289; cv=none; b=Rqm04GX1PtUhpPBEw25dc4hEJILTXYlF8uUUxI1LJ/1UVwm4vtms+KM7GAwnXJDdPxy4vKR8EQH+Emy45hY3Bqgrdgyw239LxKhfjvGgool+joUTJT4buTvlOk1n5TwCBGnFJYiVi94RwAmyPg5zoZkbrxe9pQsuyKZKVSr/3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917289; c=relaxed/simple;
	bh=/mNCmmI7sy6okCSU/K0mpQJbBcvuzTAm1gx7gSI1gFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTmkYEXakl1ApPJUZKORF+hG5nEYXqWpMgKN20XC56wW8AWPc6kBk+/hL+wPwyDiJQlPeQbTmmbn6hoaEtUjZfDxdQB4GBCl5OTRcJgZ1WdLHPCRCxqoCuoWFzqYxGrk56fEQrxX4/EJ4fyBuYo0xC3ZYiRYJaf2e5AWOsRHwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g8Qldc6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC27C4CEC3;
	Mon, 14 Oct 2024 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917289;
	bh=/mNCmmI7sy6okCSU/K0mpQJbBcvuzTAm1gx7gSI1gFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8Qldc6daf+rGMOQkYSaBsy+ov3IVXItkUkmAR4gKPzSG2d6Eq/Dxrc4r6Amt02k4
	 qmgXR+XuIg7F9lyF4njPMWQlebZG6Gn8wDGu3anvkh8o8Ewj6ZkNLCj4upk3pIcw++
	 nENqoVDBxYUkpqq4wAT0kWXIrMajvQwCd22Jcaeg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Carlos ODonell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 6.6 206/213] selftests/rseq: Fix mm_cid test failure
Date: Mon, 14 Oct 2024 16:21:52 +0200
Message-ID: <20241014141051.001836938@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
References: <20241014141042.954319779@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit a0cc649353bb726d4aa0db60dce467432197b746 upstream.

Adapt the rseq.c/rseq.h code to follow GNU C library changes introduced by:

glibc commit 2e456ccf0c34 ("Linux: Make __rseq_size useful for feature detection (bug 31965)")

Without this fix, rseq selftests for mm_cid fail:

./run_param_test.sh
Default parameters
Running test spinlock
Running compare-twice test spinlock
Running mm_cid test spinlock
Error: cpu id getter unavailable

Fixes: 18c2355838e7 ("selftests/rseq: Implement rseq mm_cid field support")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
CC: Carlos O'Donell <carlos@redhat.com>
CC: Florian Weimer <fweimer@redhat.com>
CC: linux-kselftest@vger.kernel.org
CC: stable@vger.kernel.org
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/rseq/rseq.c |  110 ++++++++++++++++++++++++------------
 tools/testing/selftests/rseq/rseq.h |   10 ---
 2 files changed, 77 insertions(+), 43 deletions(-)

--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -60,12 +60,6 @@ unsigned int rseq_size = -1U;
 /* Flags used during rseq registration.  */
 unsigned int rseq_flags;
 
-/*
- * rseq feature size supported by the kernel. 0 if the registration was
- * unsuccessful.
- */
-unsigned int rseq_feature_size = -1U;
-
 static int rseq_ownership;
 static int rseq_reg_success;	/* At least one rseq registration has succeded. */
 
@@ -111,6 +105,43 @@ int rseq_available(void)
 	}
 }
 
+/* The rseq areas need to be at least 32 bytes. */
+static
+unsigned int get_rseq_min_alloc_size(void)
+{
+	unsigned int alloc_size = rseq_size;
+
+	if (alloc_size < ORIG_RSEQ_ALLOC_SIZE)
+		alloc_size = ORIG_RSEQ_ALLOC_SIZE;
+	return alloc_size;
+}
+
+/*
+ * Return the feature size supported by the kernel.
+ *
+ * Depending on the value returned by getauxval(AT_RSEQ_FEATURE_SIZE):
+ *
+ * 0:   Return ORIG_RSEQ_FEATURE_SIZE (20)
+ * > 0: Return the value from getauxval(AT_RSEQ_FEATURE_SIZE).
+ *
+ * It should never return a value below ORIG_RSEQ_FEATURE_SIZE.
+ */
+static
+unsigned int get_rseq_kernel_feature_size(void)
+{
+	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
+
+	auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
+	assert(!auxv_rseq_align || auxv_rseq_align <= RSEQ_THREAD_AREA_ALLOC_SIZE);
+
+	auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
+	assert(!auxv_rseq_feature_size || auxv_rseq_feature_size <= RSEQ_THREAD_AREA_ALLOC_SIZE);
+	if (auxv_rseq_feature_size)
+		return auxv_rseq_feature_size;
+	else
+		return ORIG_RSEQ_FEATURE_SIZE;
+}
+
 int rseq_register_current_thread(void)
 {
 	int rc;
@@ -119,7 +150,7 @@ int rseq_register_current_thread(void)
 		/* Treat libc's ownership as a successful registration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, rseq_size, 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
 	if (rc) {
 		if (RSEQ_READ_ONCE(rseq_reg_success)) {
 			/* Incoherent success/failure within process. */
@@ -140,28 +171,12 @@ int rseq_unregister_current_thread(void)
 		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, rseq_size, RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (rc)
 		return -1;
 	return 0;
 }
 
-static
-unsigned int get_rseq_feature_size(void)
-{
-	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
-
-	auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
-	assert(!auxv_rseq_align || auxv_rseq_align <= RSEQ_THREAD_AREA_ALLOC_SIZE);
-
-	auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
-	assert(!auxv_rseq_feature_size || auxv_rseq_feature_size <= RSEQ_THREAD_AREA_ALLOC_SIZE);
-	if (auxv_rseq_feature_size)
-		return auxv_rseq_feature_size;
-	else
-		return ORIG_RSEQ_FEATURE_SIZE;
-}
-
 static __attribute__((constructor))
 void rseq_init(void)
 {
@@ -178,28 +193,54 @@ void rseq_init(void)
 	}
 	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p &&
 			*libc_rseq_size_p != 0) {
+		unsigned int libc_rseq_size;
+
 		/* rseq registration owned by glibc */
 		rseq_offset = *libc_rseq_offset_p;
-		rseq_size = *libc_rseq_size_p;
+		libc_rseq_size = *libc_rseq_size_p;
 		rseq_flags = *libc_rseq_flags_p;
-		rseq_feature_size = get_rseq_feature_size();
-		if (rseq_feature_size > rseq_size)
-			rseq_feature_size = rseq_size;
+
+		/*
+		 * Previous versions of glibc expose the value
+		 * 32 even though the kernel only supported 20
+		 * bytes initially. Therefore treat 32 as a
+		 * special-case. glibc 2.40 exposes a 20 bytes
+		 * __rseq_size without using getauxval(3) to
+		 * query the supported size, while still allocating a 32
+		 * bytes area. Also treat 20 as a special-case.
+		 *
+		 * Special-cases are handled by using the following
+		 * value as active feature set size:
+		 *
+		 *   rseq_size = min(32, get_rseq_kernel_feature_size())
+		 */
+		switch (libc_rseq_size) {
+		case ORIG_RSEQ_FEATURE_SIZE:
+			fallthrough;
+		case ORIG_RSEQ_ALLOC_SIZE:
+		{
+			unsigned int rseq_kernel_feature_size = get_rseq_kernel_feature_size();
+
+			if (rseq_kernel_feature_size < ORIG_RSEQ_ALLOC_SIZE)
+				rseq_size = rseq_kernel_feature_size;
+			else
+				rseq_size = ORIG_RSEQ_ALLOC_SIZE;
+			break;
+		}
+		default:
+			/* Otherwise just use the __rseq_size from libc as rseq_size. */
+			rseq_size = libc_rseq_size;
+			break;
+		}
 		return;
 	}
 	rseq_ownership = 1;
 	if (!rseq_available()) {
 		rseq_size = 0;
-		rseq_feature_size = 0;
 		return;
 	}
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
 	rseq_flags = 0;
-	rseq_feature_size = get_rseq_feature_size();
-	if (rseq_feature_size == ORIG_RSEQ_FEATURE_SIZE)
-		rseq_size = ORIG_RSEQ_ALLOC_SIZE;
-	else
-		rseq_size = RSEQ_THREAD_AREA_ALLOC_SIZE;
 }
 
 static __attribute__((destructor))
@@ -209,7 +250,6 @@ void rseq_exit(void)
 		return;
 	rseq_offset = 0;
 	rseq_size = -1U;
-	rseq_feature_size = -1U;
 	rseq_ownership = 0;
 }
 
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -68,12 +68,6 @@ extern unsigned int rseq_size;
 /* Flags used during rseq registration. */
 extern unsigned int rseq_flags;
 
-/*
- * rseq feature size supported by the kernel. 0 if the registration was
- * unsuccessful.
- */
-extern unsigned int rseq_feature_size;
-
 enum rseq_mo {
 	RSEQ_MO_RELAXED = 0,
 	RSEQ_MO_CONSUME = 1,	/* Unused */
@@ -193,7 +187,7 @@ static inline uint32_t rseq_current_cpu(
 
 static inline bool rseq_node_id_available(void)
 {
-	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, node_id);
+	return (int) rseq_size >= rseq_offsetofend(struct rseq_abi, node_id);
 }
 
 /*
@@ -207,7 +201,7 @@ static inline uint32_t rseq_current_node
 
 static inline bool rseq_mm_cid_available(void)
 {
-	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, mm_cid);
+	return (int) rseq_size >= rseq_offsetofend(struct rseq_abi, mm_cid);
 }
 
 static inline uint32_t rseq_current_mm_cid(void)



