Return-Path: <linux-kselftest+bounces-28762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC14A5CF34
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5EF3B096E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0919263C61;
	Tue, 11 Mar 2025 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="wPwTR1Um"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C8F26389C;
	Tue, 11 Mar 2025 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720959; cv=none; b=el9UkBPZax2ooiRwikhx09EqUFlH6qgOCnjzT92iq6v5xO9pql8lT8/8OX3P5xtaKOR+JF4NKYfug6/MypSjHGbfwZqv6XVmwpoqbeFYFtwYaX+SBPTfFYJ7ymzuss3I/QbiknzRGfmNbMypStJnTuzUpjYymdTiKLQzoAvhc+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720959; c=relaxed/simple;
	bh=w+JhsikmwiG9BJHG0zBvlbeA61nZNgJQLsM1kzPmrJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjrZ8R4tS3aCZycnnYl0k0IHrgjfVTTQB+vw8WsEuLhhp/W1/ZH+QPRT+wYmK501UOCWAY9zCJFqS6NaDwpJZ5ZAn3vPWClXBD4rZ2HVQzbzcWcJPzeTxI/6BFO/3R5zmLpBVI7GoAN77NzFw/nYhl0v4WltghjD75A+GEZkbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=wPwTR1Um; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1741720951;
	bh=w+JhsikmwiG9BJHG0zBvlbeA61nZNgJQLsM1kzPmrJY=;
	h=From:To:Cc:Subject:Date:From;
	b=wPwTR1UmGZknpyzwjGHYZDzMyH1IAmHfksvo12ZQPoLaw3Zvui1ptjgukg6GuPNTr
	 RH1j9LCHGgKjSwh/cMGaWxehBYSqfjMZvMsc0D7WAaqpjuUyR7Cy60MgGMRgBv7AML
	 n+UXLpcMrDgxdx4O90G4n/N2Kvr7z+F+SDxa1vaKXKxtw7eh9tQDzwYjX5LmWwkG57
	 A3QTj0Kdx/Ojegd4qmQSjaCq5qdq0r12S8VIb4xqoC1S8Dnhz+n+t0+b6xmqsBNsvt
	 sT1jsM0avymVj8RMe3hJUuCbwD2GjsKKQ9Qpw63DP51Z8vGyzO1BmBFeLSDkhcBoCP
	 epX/eZIWejtPw==
Received: from laptop-mjeanson.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4ZC3Yg0YZgz1Jlh;
	Tue, 11 Mar 2025 15:22:31 -0400 (EDT)
From: Michael Jeanson <mjeanson@efficios.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] rseq/selftests: ensure the rseq abi TLS is actually 1024 bytes
Date: Tue, 11 Mar 2025 15:21:45 -0400
Message-ID: <20250311192222.323453-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding the aligned(1024) attribute to the definition of __rseq_abi did
not increase its size to 1024, for this attribute to impact the size of
__rseq_abi it would need to be added to the declaration of 'struct
rseq_abi'. We only want to increase the size of the TLS allocation to
ensure registration will succeed with future extended ABI. Use a union
with a dummy member to ensure we allocate 1024 bytes.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index f6156790c3b4..aa9ae866bc1a 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -71,9 +71,20 @@ static int rseq_ownership;
 /* Original struct rseq allocation size is 32 bytes. */
 #define ORIG_RSEQ_ALLOC_SIZE		32
 
+/*
+ * Use a union to ensure we allocate a TLS area of 1024 bytes to accomodate an
+ * rseq registration that is larger than the current rseq ABI.
+ */
+union rseq {
+	struct rseq_abi abi;
+	char dummy[RSEQ_THREAD_AREA_ALLOC_SIZE];
+};
+
 static
-__thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"), aligned(RSEQ_THREAD_AREA_ALLOC_SIZE))) = {
-	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
+__thread union rseq __rseq __attribute__((tls_model("initial-exec"))) = {
+	.abi = {
+		.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
+	},
 };
 
 static int sys_rseq(struct rseq_abi *rseq_abi, uint32_t rseq_len,
@@ -149,7 +160,7 @@ int rseq_register_current_thread(void)
 		/* Treat libc's ownership as a successful registration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq.abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
 	if (rc) {
 		/*
 		 * After at least one thread has registered successfully
@@ -183,7 +194,7 @@ int rseq_unregister_current_thread(void)
 		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, get_rseq_min_alloc_size(), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq.abi, get_rseq_min_alloc_size(), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (rc)
 		return -1;
 	return 0;
@@ -249,7 +260,7 @@ void rseq_init(void)
 	rseq_ownership = 1;
 
 	/* Calculate the offset of the rseq area from the thread pointer. */
-	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
+	rseq_offset = (void *)&__rseq.abi - rseq_thread_pointer();
 
 	/* rseq flags are deprecated, always set to 0. */
 	rseq_flags = 0;
-- 
2.43.0


