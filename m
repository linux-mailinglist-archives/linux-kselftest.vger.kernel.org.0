Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8A216086
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 22:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGFUtq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 16:49:46 -0400
Received: from mail.efficios.com ([167.114.26.124]:57052 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgGFUtp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 16:49:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B6C5C2DCBC2;
        Mon,  6 Jul 2020 16:49:44 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZWQUH0zUNbht; Mon,  6 Jul 2020 16:49:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 35EAC2DCCBF;
        Mon,  6 Jul 2020 16:49:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 35EAC2DCCBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594068584;
        bh=mnMMKvJaOAN7AlfDW7S7IlXwHCI9soK/a0/c/Zir58M=;
        h=From:To:Date:Message-Id;
        b=efnws94pwSMtS/IAS5Ys121F4Iq0KkCiCQgYcjiDsebUjlu6LXkPm9zpyge1fMqPv
         9nQd/m9xFhZdjfHt09PE4YdZFXpRUysulFSKGtxJiFGQt0WJvoAAyA5kpzyrcTXF49
         7sBqxwZT49TCWK+pYyRF3XbxL9x1ATX+FoViBCvI0MRSyrTai+lJf7HOyB8+FCASkF
         T+MPqNjCmWJNJ+hprRVDdzAWKUc3EVs1h65dEysJLOiFRsOXnK4xgxnGLg+xT52nJz
         XEWqPNi6KMWbw7cM2ah1xYQJcMM0Pbqx1leWRmlLRMEQoI1tF5hCte7ygzCBjCdbFs
         SdYo2KTPeLw4w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wTGn1GJVJk5q; Mon,  6 Jul 2020 16:49:44 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id BD4512DCDA9;
        Mon,  6 Jul 2020 16:49:42 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH for 5.8 4/4] rseq: selftests: Expect reliable cpu_id field
Date:   Mon,  6 Jul 2020 16:49:13 -0400
Message-Id: <20200706204913.20347-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The rseq selftests should discover whether the kernel implements the
RSEQ_FLAG_RELIABLE_CPU_ID flag, which indicates that the
__rseq_abi.cpu_id field is reliable.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Paul Turner <pjt@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Neel Natu <neelnatu@google.com>
Cc: linux-api@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/rseq/rseq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 7159eb777fd3..55f1edb0649c 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -73,6 +73,11 @@ static int sys_rseq(volatile struct rseq *rseq_abi, uint32_t rseq_len,
 	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
 }
 
+static bool rseq_reliable_cpu_id(void)
+{
+	return sys_rseq(NULL, 0, RSEQ_FLAG_RELIABLE_CPU_ID, 0) == 0;
+}
+
 int rseq_register_current_thread(void)
 {
 	int rc, ret = 0;
@@ -87,7 +92,8 @@ int rseq_register_current_thread(void)
 	}
 	if (__rseq_refcount++)
 		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
+		      RSEQ_FLAG_REGISTER | RSEQ_FLAG_RELIABLE_CPU_ID, RSEQ_SIG);
 	if (!rc) {
 		assert(rseq_current_cpu_raw() >= 0);
 		goto end;
@@ -96,6 +102,8 @@ int rseq_register_current_thread(void)
 		__rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
 	ret = -1;
 	__rseq_refcount--;
+	if (errno == EINVAL && !rseq_reliable_cpu_id())
+		fprintf(stderr, "Error: rseq does not provide a reliable cpu_id field.\n");
 end:
 	signal_restore(oldset);
 	return ret;
-- 
2.17.1

