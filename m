Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF6976EF68
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 18:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbjHCQ2E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 12:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbjHCQ15 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 12:27:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C408E3C02
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 09:27:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so11696805e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691080072; x=1691684872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyY2zV5vJaOIfyB4fQkW5n9NhYmmuO2ZPGVSyZVmtMg=;
        b=qbePPPfnLE5E4qAH1BV1jZ3I2w0UFqw7GHg+qcz81lgnRyzwbkr4gOfO3r/MN/07JP
         yK0ubEgcerqoCtTP6BIAtvJNzs1BqO+Yz8yj/nK+QDjNb28KWk1ZpUWQyVhWhk1oZqH+
         WtjKMxfH6f3mJCOZ4ce95a6nIzJyG1Wqa3l4eX4eOpQeP8Zy/jgtFGHcTsw6YzQj/NgO
         qOOIRvzNowKD0Vd1RXXtzJ0cfJJihEcTN7BmEK70n0y9wejojrxytcA6ZShYWqJPq2Fo
         ziPpAKOfqzI3O8fyFW6KS4CjDEoG/h2IsFFr9pH39JZmvRfogLjMzpLbYUfMM71MPHDB
         4haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080072; x=1691684872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyY2zV5vJaOIfyB4fQkW5n9NhYmmuO2ZPGVSyZVmtMg=;
        b=SrnfG4qiZ5aDxYz69k567uYrcAr2IlwUP7/Sb6nz9vwhL7eS7hUNOsqkTM+gIspYXX
         Ifica8OlgM8cIJ0+oD/yS1wHVDxMZ0uQTYRxKog1hOGfavKFAjpuW+Tr1rdhnPX8K3YA
         Xqdt0FHv7BuJbfbVf3qz2V/VgI3H5Mj2cy0GP1Bq4lzRLU4hRHL8aaaBlGsZqNEp9XPg
         5bOa4mIFRXKSjIYeyxrwLNCB/39gJjl5vv8FCVin8xhJKhxhPb+A3VNh1YSNaUEXOtmU
         UCL191OV6cO8EvWVryTnuR2FV4dE79zxeds57LWyknrG8Z0oyHjBA+yEqtzQpegRgxt/
         7+8w==
X-Gm-Message-State: ABy/qLZh6XccBbRFSqxYj/90sg081JNFLHrz5kPw/6PLSQgZe5iGPnHU
        mbh1VLC2Hg/1bQxgsHIz5v132g==
X-Google-Smtp-Source: APBJJlFOUzY4WZSRiAxXYt14cKpFQXdsNaYdRrHkNPWzcIugEnJx/GRXshHYrzwhcSV1nJLZnuS4cg==
X-Received: by 2002:adf:f490:0:b0:315:a74c:f627 with SMTP id l16-20020adff490000000b00315a74cf627mr7639736wro.16.1691080072198;
        Thu, 03 Aug 2023 09:27:52 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm253167wrs.30.2023.08.03.09.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:27:51 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 03 Aug 2023 18:27:30 +0200
Subject: [PATCH net 4/4] mptcp: fix disconnect vs accept race
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-4-6671b1ab11cc@tessares.net>
References: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
In-Reply-To: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org, Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6350;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=aKcow2E15Tjek3grxJIpgMFsqze4hMw1QTBvn16JVm8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBky9WCZ/PIlkegmWQ+oRn1/er9lZ7+r/US1BaBo
 xry6wrvOpyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMvVggAKCRD2t4JPQmmg
 c6r+EADDM4nK4HHbE8VttqzJEu2kc7hBHUe/O1+iQPG3XmqMkMORrSJP1OjRnmYV0NBnKGARiKJ
 /drfsn60O8gpJoMpBhOuoWhUvlXaWNTURDne8QvBuY+b04dhjLQ/K4+im9U0FQiPDRC7JMbtu/N
 VRdEBWbcSVTcLPrxqtXljnPYlpXxAGQU0UAoYA0phciVxwJkRCbXnl3pcRZqH4DW+L71cIxAGpk
 dcuuzpfXakNQ4NwWvg1kMYhgM74q9DVuVRhsvOFgfouWWg4eYk2KZBN0hF09wYUapzilA56mN0P
 o0dYXp0+OohL2LG5BzeyAjFyC/LSNbHrxkUgbR/Q2s/bQlR+OBtW74z8JrR3dq5v9ovYwxAGjLn
 Hm51kzqOkgIg8n45zIgF9X7vLzwTY04kdRmsA+kKrXen0hQlrCRS9wWGy+PIiVtXJTWS9d7D4LH
 mztuedwS5jh4zK77CJQGydo2XCwvqe3cpR5+RdsSTvXfNUa5HhCCE8n8sJM62BbNCe4bXpLg0sE
 DhBUkMig9XxKur3bdZmrdF+NE9rqmLWmn9LDbs7RfPs+4a1pXL0RWLDeFdwMSzB6QT1ST8oJPPt
 lRWH8NfWhlbwrbglyp3pMK3TRtAsgoiQefToVlOc/vzh03SIwGz40Ih4PJF41EM9c1PXCAsqLFJ
 +qc+0oELhN/D9jA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

Despite commit 0ad529d9fd2b ("mptcp: fix possible divide by zero in
recvmsg()"), the mptcp protocol is still prone to a race between
disconnect() (or shutdown) and accept.

The root cause is that the mentioned commit checks the msk-level
flag, but mptcp_stream_accept() does acquire the msk-level lock,
as it can rely directly on the first subflow lock.

As reported by Christoph than can lead to a race where an msk
socket is accepted after that mptcp_subflow_queue_clean() releases
the listener socket lock and just before it takes destructive
actions leading to the following splat:

BUG: kernel NULL pointer dereference, address: 0000000000000012
PGD 5a4ca067 P4D 5a4ca067 PUD 37d4c067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 2 PID: 10955 Comm: syz-executor.5 Not tainted 6.5.0-rc1-gdc7b257ee5dd #37
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:mptcp_stream_accept+0x1ee/0x2f0 include/net/inet_sock.h:330
Code: 0a 09 00 48 8b 1b 4c 39 e3 74 07 e8 bc 7c 7f fe eb a1 e8 b5 7c 7f fe 4c 8b 6c 24 08 eb 05 e8 a9 7c 7f fe 49 8b 85 d8 09 00 00 <0f> b6 40 12 88 44 24 07 0f b6 6c 24 07 bf 07 00 00 00 89 ee e8 89
RSP: 0018:ffffc90000d07dc0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888037e8d020 RCX: ffff88803b093300
RDX: 0000000000000000 RSI: ffffffff833822c5 RDI: ffffffff8333896a
RBP: 0000607f82031520 R08: ffff88803b093300 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000003e83 R12: ffff888037e8d020
R13: ffff888037e8c680 R14: ffff888009af7900 R15: ffff888009af6880
FS:  00007fc26d708640(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000012 CR3: 0000000066bc5001 CR4: 0000000000370ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_accept+0x1ae/0x260 net/socket.c:1872
 __sys_accept4+0x9b/0x110 net/socket.c:1913
 __do_sys_accept4 net/socket.c:1954 [inline]
 __se_sys_accept4 net/socket.c:1951 [inline]
 __x64_sys_accept4+0x20/0x30 net/socket.c:1951
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x47/0xa0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Address the issue by temporary removing the pending request socket
from the accept queue, so that racing accept() can't touch them.

After depleting the msk - the ssk still exists, as plain TCP sockets,
re-insert them into the accept queue, so that later inet_csk_listen_stop()
will complete the tcp socket disposal.

Fixes: 2a6a870e44dd ("mptcp: stops worker on unaccepted sockets at listener close")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/423
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  | 60 ++++++++++++++++++++++++++--------------------------
 2 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 37fbe22e2433..ba2a873a4d2e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -325,7 +325,6 @@ struct mptcp_sock {
 	u32		subflow_id;
 	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
-	struct mptcp_sock	*dl_next;
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9ee3b7abbaf6..94ae7dd01c65 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1793,34 +1793,21 @@ static void subflow_state_change(struct sock *sk)
 void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)
 {
 	struct request_sock_queue *queue = &inet_csk(listener_ssk)->icsk_accept_queue;
-	struct mptcp_sock *msk, *next, *head = NULL;
-	struct request_sock *req;
-	struct sock *sk;
+	struct request_sock *req, *head, *tail;
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk, *ssk;
 
-	/* build a list of all unaccepted mptcp sockets */
+	/* Due to lock dependencies no relevant lock can be acquired under rskq_lock.
+	 * Splice the req list, so that accept() can not reach the pending ssk after
+	 * the listener socket is released below.
+	 */
 	spin_lock_bh(&queue->rskq_lock);
-	for (req = queue->rskq_accept_head; req; req = req->dl_next) {
-		struct mptcp_subflow_context *subflow;
-		struct sock *ssk = req->sk;
-
-		if (!sk_is_mptcp(ssk))
-			continue;
-
-		subflow = mptcp_subflow_ctx(ssk);
-		if (!subflow || !subflow->conn)
-			continue;
-
-		/* skip if already in list */
-		sk = subflow->conn;
-		msk = mptcp_sk(sk);
-		if (msk->dl_next || msk == head)
-			continue;
-
-		sock_hold(sk);
-		msk->dl_next = head;
-		head = msk;
-	}
+	head = queue->rskq_accept_head;
+	tail = queue->rskq_accept_tail;
+	queue->rskq_accept_head = NULL;
+	queue->rskq_accept_tail = NULL;
 	spin_unlock_bh(&queue->rskq_lock);
+
 	if (!head)
 		return;
 
@@ -1829,13 +1816,19 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 	 */
 	release_sock(listener_ssk);
 
-	for (msk = head; msk; msk = next) {
-		sk = (struct sock *)msk;
+	for (req = head; req; req = req->dl_next) {
+		ssk = req->sk;
+		if (!sk_is_mptcp(ssk))
+			continue;
+
+		subflow = mptcp_subflow_ctx(ssk);
+		if (!subflow || !subflow->conn)
+			continue;
+
+		sk = subflow->conn;
+		sock_hold(sk);
 
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
-		next = msk->dl_next;
-		msk->dl_next = NULL;
-
 		__mptcp_unaccepted_force_close(sk);
 		release_sock(sk);
 
@@ -1859,6 +1852,13 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 
 	/* we are still under the listener msk socket lock */
 	lock_sock_nested(listener_ssk, SINGLE_DEPTH_NESTING);
+
+	/* restore the listener queue, to let the TCP code clean it up */
+	spin_lock_bh(&queue->rskq_lock);
+	WARN_ON_ONCE(queue->rskq_accept_head);
+	queue->rskq_accept_head = head;
+	queue->rskq_accept_tail = tail;
+	spin_unlock_bh(&queue->rskq_lock);
 }
 
 static int subflow_ulp_init(struct sock *sk)

-- 
2.40.1

