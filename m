Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CCE4985FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244198AbiAXRNF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:13:05 -0500
Received: from mail.efficios.com ([167.114.26.124]:47596 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbiAXRND (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:13:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2179E344C4C;
        Mon, 24 Jan 2022 12:13:03 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id i_Qbh5zGsKtg; Mon, 24 Jan 2022 12:13:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E52D6344E5A;
        Mon, 24 Jan 2022 12:13:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E52D6344E5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643044382;
        bh=nncvokTdjsee5tzKxA/veggGUZZ9ULSWsY7QtAMw1Bc=;
        h=From:To:Date:Message-Id;
        b=YBsfZz9ovMERNBF6xx73c3StbzBJSefxNX4J+13TvpaTNkPFE+yAeIl0+RLJ8fydf
         nzdSeDX55Y5pYQe6kV6iMnRHCbnc15dv+lsmXV5XLrh9/tWgbUYK5Nc/sJhXtTk17s
         1Fjn1yzDzlQUw8S7dJjxeZrV58kpqj31dqRLGwznJaOapBHOSxcpYaXV/gZZ8nxYPX
         QhgUKd0AqvbeHQPYzGQTBRW1N3r8+WP3h3LpwfbB8o3n4E4hTvYW8svNsTCTyfhHCY
         T5I/jsWBbPMVGQFCasa91p8JA18DCOxNdVEcXP2Z4QMnB6iF7M2CB2g35kNS+8HljU
         +sC9CXPNpvAXQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BpyIa_w9x8Fj; Mon, 24 Jan 2022 12:13:02 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id AA6D03450BB;
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
Subject: [RFC PATCH 03/15] selftests/rseq: Remove useless assignment to cpu variable
Date:   Mon, 24 Jan 2022 12:12:41 -0500
Message-Id: <20220124171253.22072-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/param_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 699ad5f93c34..cc2cfc1da938 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -368,9 +368,7 @@ void *test_percpu_spinlock_thread(void *arg)
 		abort();
 	reps = thread_data->reps;
 	for (i = 0; i < reps; i++) {
-		int cpu = rseq_cpu_start();
-
-		cpu = rseq_this_cpu_lock(&data->lock);
+		int cpu = rseq_this_cpu_lock(&data->lock);
 		data->c[cpu].count++;
 		rseq_percpu_unlock(&data->lock, cpu);
 #ifndef BENCHMARK
-- 
2.17.1

