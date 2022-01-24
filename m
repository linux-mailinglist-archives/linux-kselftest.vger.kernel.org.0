Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE6F498606
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiAXRNM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:13:12 -0500
Received: from mail.efficios.com ([167.114.26.124]:47698 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiAXRNJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:13:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BC453344FB9;
        Mon, 24 Jan 2022 12:13:08 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hVx0sovOLhv3; Mon, 24 Jan 2022 12:13:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3C161344CCB;
        Mon, 24 Jan 2022 12:13:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3C161344CCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643044385;
        bh=sizmwBrxkv/0aNCHgTVDX0QCiREspIYZ5PAY9xWn+Lw=;
        h=From:To:Date:Message-Id;
        b=qPeL9KUvQpD3oWLJJo5hgcYTtKZPF09fo9czqGdtCIwHCq8xiqgTqgmRvpdfg8t+N
         DNp/SL5i/FbTBcZbM/mcWSgFtvAgkxO3kl0e7Aao5XW1JcJ5nZ5Iy8iau1lZczSncE
         p0ur7xME6ikdJTD4Obi4pcEX3r6W8wb97tnk9l8752s9oQ8CF4FWAc96rky5Ua2Jsq
         Of3Xkc7ZTi7aZoqqECduxJXgqUqCotV+ARuXxc0LTzVH3UUVflZvuCK/bx4VtMF8CZ
         S8iqiHR3GKOFysanKXFsT9pYMlQ9d+y0Dpx9cFo6MjpyRCxzeRTkvkunWyn3gO4iUh
         cMvkJytW/bj2g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gOE1mmXpgq1W; Mon, 24 Jan 2022 12:13:05 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id E82D8345190;
        Mon, 24 Jan 2022 12:13:02 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 04/15] selftests/rseq: Remove volatile from __rseq_abi
Date:   Mon, 24 Jan 2022 12:12:42 -0500
Message-Id: <20220124171253.22072-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is done in preparation for the selftest uplift to become compatible
with glibc-2.35.

All accesses to the __rseq_abi fields are volatile, but remove the
volatile from the TLS variable declaration, otherwise we are stuck with
volatile for the upcoming rseq_get_abi() helper.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq.c | 4 ++--
 tools/testing/selftests/rseq/rseq.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index bfe1b2692ffc..1f905b60728a 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -30,7 +30,7 @@
 #include "../kselftest.h"
 #include "rseq.h"
 
-__thread volatile struct rseq_abi __rseq_abi = {
+__thread struct rseq_abi __rseq_abi = {
 	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
 };
 
@@ -92,7 +92,7 @@ int rseq_register_current_thread(void)
 		goto end;
 	}
 	if (errno != EBUSY)
-		__rseq_abi.cpu_id = RSEQ_ABI_CPU_ID_REGISTRATION_FAILED;
+		RSEQ_WRITE_ONCE(__rseq_abi.cpu_id, RSEQ_ABI_CPU_ID_REGISTRATION_FAILED);
 	ret = -1;
 	__rseq_refcount--;
 end:
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index cb6bbc53b586..d580f8e9c001 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -43,7 +43,7 @@
 #define RSEQ_INJECT_FAILED
 #endif
 
-extern __thread volatile struct rseq_abi __rseq_abi;
+extern __thread struct rseq_abi __rseq_abi;
 extern int __rseq_handled;
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
@@ -139,7 +139,7 @@ static inline uint32_t rseq_current_cpu(void)
 
 static inline void rseq_clear_rseq_cs(void)
 {
-	__rseq_abi.rseq_cs.arch.ptr = 0;
+	RSEQ_WRITE_ONCE(__rseq_abi.rseq_cs.arch.ptr, 0);
 }
 
 /*
-- 
2.17.1

