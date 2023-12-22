Return-Path: <linux-kselftest+bounces-2370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145C81CA39
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 13:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53E9B248BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8771CFAE;
	Fri, 22 Dec 2023 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THjbtFhi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871401CFA9;
	Fri, 22 Dec 2023 12:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A235CC433CA;
	Fri, 22 Dec 2023 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703249279;
	bh=J4z4ryeAmdIEiJ5t/xFfmwsRE33yFvac76E5NEAMTMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=THjbtFhizNrMpnmJGrUhBbj5h3OCR1kitdUcbYarnn0H531Sh+7ZSTH3PHHuvwJBp
	 YKWERZWj/7LL1Gfol3irv5sMCa22h9xgDEpe3JxWeyzRZvgRCIP9RWjCFNs5NpqNhb
	 bYx2ytHEXADFzXGrc9R+yTBeMG6Zm86kReJ/680ygsIsuPWMArZOhBX2azFZH6dcW0
	 nFydiVSNM+rtOw1bEKoqo5Rl5aCUHECY8f4E5zJXMjo9RwKydZ0vWu/K6X0FxIbdgm
	 lrGDUw4++6LoFcd5DArqqUfRt+mwl3kJyd2RTGVX37tIncIcLeHAWx0y+gVzGjD8n+
	 TWAOtez1HsIAA==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 22 Dec 2023 13:47:23 +0100
Subject: [PATCH net-next 2/4] mptcp: use mptcp_set_state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-2-c1eb73d6b2b2@kernel.org>
References: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-0-c1eb73d6b2b2@kernel.org>
In-Reply-To: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-0-c1eb73d6b2b2@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang.tang@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7237; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Szfc60OBI4Dmislh2cTuOLvFSjl11uypK19taAdnjus=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlhYV27EkKjyIgQ4N5uc5f68MsS1WayH2GYexXB
 A2Y37P55GGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYWFdgAKCRD2t4JPQmmg
 c3pJEADSxITwan+4i23Tq61JN9FVqwBfvCO7e89Zp++jucqbVAv6gfgYe8nHEI+HtpYadso04e5
 CrPHCNxr2bwvaQJJ3ssk71384mLOIjTnLzTmQjqvWsRFLq21nvJ5ODvScGApsRu+ebtbq2zacZK
 fBbwX39AI7gIMThEt1IDniL9+BhFrpFDbWI4BgAghYlQEvgVR1ZOgomDf22XtZYImhR4ntfvggO
 Cqky17rsdk5RLGKKzcfSZNQuZLr6s1xd1fJF2ZXY0eMUSgQRT9LtIfTucruY5P+psG0DrEp01s9
 m9WtsxCqLJw5rNKxxwrsmiLKjEsegLXSvUYSFGtNOW6HmTNUFUjO6iFrOH/27VvWH2QpWYpJXXv
 Aioaa9LbEzUpu8nDYyPm/iAIIpgd4VmoLXGTDdO0F5G/WEadqXauzew7xdAlhyrIbtnK1klM16U
 HQyGRs0lV1nmaEJK7jAQXBz7Sm1hvmrFlnuS1SKCOLoibywzdcpHL1KpllFsH9J+H6AatyyPaHI
 kasCe/2m39kxtNyVcQuTXAZZAnnk97ROqyuB5QO/5dNCiMdu7Kr4stsQJK6+UP99XVdyn2Jbm7X
 Cmn7iZPFPcFcucMbzwZ8dvri5l5OlWGCxS5uJRQm9H+xzjxwy11phKFif5VR2yVt/ofN4WQKnpE
 5k5yP0QBnQCRQvQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang.tang@linux.dev>

This patch replaces all the 'inet_sk_state_store()' calls under net/mptcp
with the new helper mptcp_set_state().

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c |  5 +++++
 net/mptcp/protocol.c   | 38 +++++++++++++++++++-------------------
 net/mptcp/subflow.c    |  2 +-
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..661c226dad18 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1048,6 +1048,11 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
+	/* We don't use mptcp_set_state() here because it needs to be called
+	 * under the msk socket lock. For the moment, that will not bring
+	 * anything more than only calling inet_sk_state_store(), because the
+	 * old status is known (TCP_CLOSE).
+	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b555bd0b425b..b43762e64dc5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -443,11 +443,11 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 
 		switch (sk->sk_state) {
 		case TCP_FIN_WAIT1:
-			inet_sk_state_store(sk, TCP_FIN_WAIT2);
+			mptcp_set_state(sk, TCP_FIN_WAIT2);
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
-			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		}
 
@@ -608,13 +608,13 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 		switch (sk->sk_state) {
 		case TCP_ESTABLISHED:
-			inet_sk_state_store(sk, TCP_CLOSE_WAIT);
+			mptcp_set_state(sk, TCP_CLOSE_WAIT);
 			break;
 		case TCP_FIN_WAIT1:
-			inet_sk_state_store(sk, TCP_CLOSING);
+			mptcp_set_state(sk, TCP_CLOSING);
 			break;
 		case TCP_FIN_WAIT2:
-			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		default:
 			/* Other states not expected */
@@ -789,7 +789,7 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	 */
 	ssk_state = inet_sk_state_load(ssk);
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-		inet_sk_state_store(sk, ssk_state);
+		mptcp_set_state(sk, ssk_state);
 	WRITE_ONCE(sk->sk_err, -err);
 
 	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
@@ -2477,7 +2477,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
 		if (sk->sk_state != TCP_ESTABLISHED ||
 		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
-			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_set_state(sk, TCP_CLOSE);
 			mptcp_close_wake_up(sk);
 		} else {
 			mptcp_start_tout_timer(sk);
@@ -2572,7 +2572,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	}
 
-	inet_sk_state_store(sk, TCP_CLOSE);
+	mptcp_set_state(sk, TCP_CLOSE);
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
@@ -2707,7 +2707,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	inet_sk_state_store(sk, TCP_CLOSE);
+	mptcp_set_state(sk, TCP_CLOSE);
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
 		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
 				  subflow, MPTCP_CF_FASTCLOSE);
@@ -2925,7 +2925,7 @@ static int mptcp_close_state(struct sock *sk)
 	int next = (int)new_state[sk->sk_state];
 	int ns = next & TCP_STATE_MASK;
 
-	inet_sk_state_store(sk, ns);
+	mptcp_set_state(sk, ns);
 
 	return next & TCP_ACTION_FIN;
 }
@@ -3036,7 +3036,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
 		mptcp_check_listen_stop(sk);
-		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_set_state(sk, TCP_CLOSE);
 		goto cleanup;
 	}
 
@@ -3079,7 +3079,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	 * state, let's not keep resources busy for no reasons
 	 */
 	if (subflows_alive == 0)
-		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_set_state(sk, TCP_CLOSE);
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
@@ -3145,7 +3145,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 		return -EBUSY;
 
 	mptcp_check_listen_stop(sk);
-	inet_sk_state_store(sk, TCP_CLOSE);
+	mptcp_set_state(sk, TCP_CLOSE);
 
 	mptcp_stop_rtx_timer(sk);
 	mptcp_stop_tout_timer(sk);
@@ -3233,7 +3233,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	/* this can't race with mptcp_close(), as the msk is
 	 * not yet exposted to user-space
 	 */
-	inet_sk_state_store(nsk, TCP_ESTABLISHED);
+	mptcp_set_state(nsk, TCP_ESTABLISHED);
 
 	/* The msk maintain a ref to each subflow in the connections list */
 	WRITE_ONCE(msk->first, ssk);
@@ -3692,7 +3692,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (IS_ERR(ssk))
 		return PTR_ERR(ssk);
 
-	inet_sk_state_store(sk, TCP_SYN_SENT);
+	mptcp_set_state(sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -3742,7 +3742,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (unlikely(err)) {
 		/* avoid leaving a dangling token in an unconnected socket */
 		mptcp_token_destroy(msk);
-		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_set_state(sk, TCP_CLOSE);
 		return err;
 	}
 
@@ -3832,13 +3832,13 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
-	inet_sk_state_store(sk, TCP_LISTEN);
+	mptcp_set_state(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
 	release_sock(ssk);
-	inet_sk_state_store(sk, inet_sk_state_load(ssk));
+	mptcp_set_state(sk, inet_sk_state_load(ssk));
 
 	if (!err) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
@@ -3898,7 +3898,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			__mptcp_close_ssk(newsk, msk->first,
 					  mptcp_subflow_ctx(msk->first), 0);
 			if (unlikely(list_is_singular(&msk->conn_list)))
-				inet_sk_state_store(newsk, TCP_CLOSE);
+				mptcp_set_state(newsk, TCP_CLOSE);
 		}
 	}
 	release_sock(newsk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6d7684c35e93..1ef28642afc4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -425,7 +425,7 @@ void __mptcp_sync_state(struct sock *sk, int state)
 
 	__mptcp_propagate_sndbuf(sk, msk->first);
 	if (sk->sk_state == TCP_SYN_SENT) {
-		inet_sk_state_store(sk, state);
+		mptcp_set_state(sk, state);
 		sk->sk_state_change(sk);
 	}
 }

-- 
2.43.0


