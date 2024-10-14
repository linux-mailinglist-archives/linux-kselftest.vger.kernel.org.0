Return-Path: <linux-kselftest+bounces-19657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EB799CDB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 16:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864DA2827D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E01AA793;
	Mon, 14 Oct 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j9bPxjn7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0192E571;
	Mon, 14 Oct 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916509; cv=none; b=XB6mg6yVwZMZbabdqZ1JLKnTpEWud65zZorhj+dH/PRU/U26axGHx6vpS2k4wcZJ87mIAdxHkstR+yPBO5nmk4Gi2tzclg82v+e+OmlNhsW6CfMl/agNCoc4AWdnrNLn3tBPjLBYdfyyn3gOjWdiqf7K0AZcBb1CZrU8LbZK0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916509; c=relaxed/simple;
	bh=ouDfWqcOhNHpj65eL5iZABGyHF6C/jEfTlitDGMESxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syIoJuOTCNtEfz0GTjIbbdqNiVZIaN/xTAbZ15wxf2GF9ERJLUh2RqKq7qf5YYqYSo2oZRgf2lkKKGrxm+FqSZqHUC+MSUe3lC3gIvarvVofLydBYXMvcvNMvQ163YkRdTaRqIjr69F8mYi3XrYqegR/6sqM+a2H2xgBhOje1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j9bPxjn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B77C4CEC3;
	Mon, 14 Oct 2024 14:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916509;
	bh=ouDfWqcOhNHpj65eL5iZABGyHF6C/jEfTlitDGMESxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9bPxjn7MDE2bfdd0FjqtuAjKglJXRHtHSOlitkrL75Z4z6LvtCbcChRWqtJy6qH0
	 fKd6RQQqjeTS1M7UqMvraUAeUDPzFp71vgmT68hKMn0O2qhwDcEurInatDQ7FJHqBc
	 WTfGlM+btxWPVil+K5bccgRxEvjVaod0ywmtU1ow=
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
Subject: [PATCH 6.11 205/214] selftests/rseq: Fix mm_cid test failure
Date: Mon, 14 Oct 2024 16:21:08 +0200
Message-ID: <20241014141052.976476446@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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



