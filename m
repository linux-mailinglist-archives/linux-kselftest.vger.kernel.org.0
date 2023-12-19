Return-Path: <linux-kselftest+bounces-2241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8957E819265
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 22:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F09B288B57
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03013A8DB;
	Tue, 19 Dec 2023 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuDvY7y+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A343C6A6;
	Tue, 19 Dec 2023 21:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4271EC433CB;
	Tue, 19 Dec 2023 21:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703021901;
	bh=8Zn/iQVfoK4WIL45SvwHhkDsI7IJQsZYNrWnNX4iYfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HuDvY7y+npE2BYFAUTGUmPTqoqv1kQMFubqpoOMTHEw94/UgqfarMZzqIiU292UCR
	 oTwpXDOt1LH+RBBpPCu1RGziPoGXjlBTH3BCDP1Jhxst0EE58gKfPwljzajMSC7eV0
	 MjM3FCS8WxleAUTw3W/ttmaeCDWe5lXkWt9B70wbCscQ/c34zvHC+Gv9ZV4a5uH3Qp
	 esBH+U6iYGdlWkdNPrxus/UvWPjqL6R+3kRgYoyxc9/mM3LKsNl/cn2FG6S++8yqSA
	 7m2TAmhODtgAxL3wJ4yyeRV2YpPbzi87RKfd7sV7nqpLCyhhVZBedXlmUEsSaOMo7X
	 Z6Hzp7bdMGGGA==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 19 Dec 2023 22:31:04 +0100
Subject: [PATCH net-next 1/4] mptcp: don't overwrite sock_ops in
 mptcp_is_tcpsk()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-v1-1-2b13bedfcaf8@kernel.org>
References: <20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-v1-0-2b13bedfcaf8@kernel.org>
In-Reply-To: <20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-v1-0-2b13bedfcaf8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5762; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=v4M3WEJtEY7LyvLuXHxK426HlsZ0UnL0hBK4mmkBBmM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlgg1GSxhyd+Jy3SU8214jmetGhy6hxnoL0WzJj
 F0ZIO/6uleJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYINRgAKCRD2t4JPQmmg
 c4eqEAC5G8QY+40kuyodpRXOK2hthefXhY9PWnUYLMK3OWk0kSxOo6+Yq1WiEOGKFgBmNKzjX/m
 a214ydCa+XPU8Gb61k6UoJdNUQzjxdMIB4NJVHgQuvHxK5IM1wSqdlegxfel+6zyKN5yKjiUjs8
 AT8uijfxfKekhF5OoM0qoZ2ddLh3sWw4EyEiqvVReBcpdlZlzSLIXXcm4fsnkTaBj7paPujid39
 RgmZ+9R1189GME94H4E8rLb/HFkLBVc9N7X7EMXPC59TAG03psJi0biEuXhMwtbfBagMPyS9t2k
 GfvkFccygiuR4V3DOVXsyEMyQW5No/VFVEsGvnz0vuUrhawUxzx8vSiI7dLv0K2gqC2GKtct0mC
 8wqeKYt6Sih7PhM+FhFYwDnpzDekAjVYuOjsF4qfFcYeY4K3k96J4xB8BKvNessUljRKfwA16zD
 kNGdRMvAjhFj+9amHHHrqujggIRFUhTiKD//xBqZ4/VUIQ4uiBs7XSA5NnUqPA36q85NmQjIWGA
 aDbXAdIxhj5BXSQAKtbIBEk0OGqMwyJNV4pp8HrixqJbmx6QObj4xBrg3BwohjiKMyyn+ZwT5A1
 cw4BCHZlTBBHj2WG95mXgxdy8S1bhjjJm7SbriqRVn4jdVBk31YFa9OCy9d/wFF6usHpvvwvjaN
 uAXWkYP9KQEU4lg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Davide Caratti <dcaratti@redhat.com>

Eric Dumazet suggests:

 > The fact that mptcp_is_tcpsk() was able to write over sock->ops was a
 > bit strange to me.
 > mptcp_is_tcpsk() should answer a question, with a read-only argument.

re-factor code to avoid overwriting sock_ops inside that function. Also,
change the helper name to reflect the semantics and to disambiguate from
its dual, sk_is_mptcp(). While at it, collapse mptcp_stream_accept() and
mptcp_accept() into a single function, where fallback / non-fallback are
separated into a single sk_is_mptcp() conditional.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/432
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 108 +++++++++++++++++++++------------------------------
 1 file changed, 44 insertions(+), 64 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bc81ea53a049..5cbbd1221030 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -55,28 +55,14 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->wnd_end);
 }
 
-static bool mptcp_is_tcpsk(struct sock *sk)
+static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 {
-	struct socket *sock = sk->sk_socket;
-
-	if (unlikely(sk->sk_prot == &tcp_prot)) {
-		/* we are being invoked after mptcp_accept() has
-		 * accepted a non-mp-capable flow: sk is a tcp_sk,
-		 * not an mptcp one.
-		 *
-		 * Hand the socket over to tcp so all further socket ops
-		 * bypass mptcp.
-		 */
-		WRITE_ONCE(sock->ops, &inet_stream_ops);
-		return true;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	} else if (unlikely(sk->sk_prot == &tcpv6_prot)) {
-		WRITE_ONCE(sock->ops, &inet6_stream_ops);
-		return true;
+	if (sk->sk_prot == &tcpv6_prot)
+		return &inet6_stream_ops;
 #endif
-	}
-
-	return false;
+	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
+	return &inet_stream_ops;
 }
 
 static int __mptcp_socket_create(struct mptcp_sock *msk)
@@ -3258,44 +3244,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 }
 
-static struct sock *mptcp_accept(struct sock *ssk, int flags, int *err,
-				 bool kern)
-{
-	struct sock *newsk;
-
-	pr_debug("ssk=%p, listener=%p", ssk, mptcp_subflow_ctx(ssk));
-	newsk = inet_csk_accept(ssk, flags, err, kern);
-	if (!newsk)
-		return NULL;
-
-	pr_debug("newsk=%p, subflow is mptcp=%d", newsk, sk_is_mptcp(newsk));
-	if (sk_is_mptcp(newsk)) {
-		struct mptcp_subflow_context *subflow;
-		struct sock *new_mptcp_sock;
-
-		subflow = mptcp_subflow_ctx(newsk);
-		new_mptcp_sock = subflow->conn;
-
-		/* is_mptcp should be false if subflow->conn is missing, see
-		 * subflow_syn_recv_sock()
-		 */
-		if (WARN_ON_ONCE(!new_mptcp_sock)) {
-			tcp_sk(newsk)->is_mptcp = 0;
-			goto out;
-		}
-
-		newsk = new_mptcp_sock;
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
-	} else {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
-	}
-
-out:
-	newsk->sk_kern_sock = kern;
-	return newsk;
-}
-
 void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3739,7 +3687,6 @@ static struct proto mptcp_prot = {
 	.connect	= mptcp_connect,
 	.disconnect	= mptcp_disconnect,
 	.close		= mptcp_close,
-	.accept		= mptcp_accept,
 	.setsockopt	= mptcp_setsockopt,
 	.getsockopt	= mptcp_getsockopt,
 	.shutdown	= mptcp_shutdown,
@@ -3849,18 +3796,36 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	if (!ssk)
 		return -EINVAL;
 
-	newsk = mptcp_accept(ssk, flags, &err, kern);
+	pr_debug("ssk=%p, listener=%p", ssk, mptcp_subflow_ctx(ssk));
+	newsk = inet_csk_accept(ssk, flags, &err, kern);
 	if (!newsk)
 		return err;
 
-	lock_sock(newsk);
-
-	__inet_accept(sock, newsock, newsk);
-	if (!mptcp_is_tcpsk(newsock->sk)) {
-		struct mptcp_sock *msk = mptcp_sk(newsk);
+	pr_debug("newsk=%p, subflow is mptcp=%d", newsk, sk_is_mptcp(newsk));
+	if (sk_is_mptcp(newsk)) {
 		struct mptcp_subflow_context *subflow;
+		struct sock *new_mptcp_sock;
+
+		subflow = mptcp_subflow_ctx(newsk);
+		new_mptcp_sock = subflow->conn;
+
+		/* is_mptcp should be false if subflow->conn is missing, see
+		 * subflow_syn_recv_sock()
+		 */
+		if (WARN_ON_ONCE(!new_mptcp_sock)) {
+			tcp_sk(newsk)->is_mptcp = 0;
+			goto tcpfallback;
+		}
+
+		newsk = new_mptcp_sock;
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
+
+		newsk->sk_kern_sock = kern;
+		lock_sock(newsk);
+		__inet_accept(sock, newsock, newsk);
 
 		set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
+		msk = mptcp_sk(newsk);
 		msk->in_accept_queue = 0;
 
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
@@ -3882,6 +3847,21 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			if (unlikely(list_is_singular(&msk->conn_list)))
 				inet_sk_state_store(newsk, TCP_CLOSE);
 		}
+	} else {
+		MPTCP_INC_STATS(sock_net(ssk),
+				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
+tcpfallback:
+		newsk->sk_kern_sock = kern;
+		lock_sock(newsk);
+		__inet_accept(sock, newsock, newsk);
+		/* we are being invoked after accepting a non-mp-capable
+		 * flow: sk is a tcp_sk, not an mptcp one.
+		 *
+		 * Hand the socket over to tcp so all further socket ops
+		 * bypass mptcp.
+		 */
+		WRITE_ONCE(newsock->sk->sk_socket->ops,
+			   mptcp_fallback_tcp_ops(newsock->sk));
 	}
 	release_sock(newsk);
 

-- 
2.40.1


