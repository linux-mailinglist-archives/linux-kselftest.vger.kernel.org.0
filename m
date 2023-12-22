Return-Path: <linux-kselftest+bounces-2369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8C381CA35
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 13:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7891C21D36
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3805199CE;
	Fri, 22 Dec 2023 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saxW8+r7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE745199A4;
	Fri, 22 Dec 2023 12:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C096FC433C7;
	Fri, 22 Dec 2023 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703249276;
	bh=Ze9OuTUPPQuwSORQ5olDV5NtSpN0MXCRryR2org4ckM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=saxW8+r7+h4liTrpPhkXIM06wCH4VwzmQK30WkXJ/x1Rsp+Y+GVPoF6cVFBOyZYwe
	 ia8BPIP1Wn1J1sMGzCtLZVmbep8RM3Ho1P8bsxIWHlv21EO5EAVyRpXPTroDIYn4+L
	 XujUtcKa+g6pk4Zj7paSa9yvOkODDC1JNuf4Qse92Sc8wTbSSMvGUUHYC9adRRoGSt
	 io8XwyoNtBcVAMDUsTeuKW2hNws9jTVFSqvxDNrLvzQ4sekyAC4P4Ce1ycrwW3LZGG
	 qvHcJKJh31uarIU8n6QMMH8ddnx8/Bp+r7t3eWBv8CGAVkvQpCoMEB/CRZSLlYBUzZ
	 jFhwGAnTjf5yA==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 22 Dec 2023 13:47:22 +0100
Subject: [PATCH net-next 1/4] mptcp: add CurrEstab MIB counter support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-1-c1eb73d6b2b2@kernel.org>
References: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-0-c1eb73d6b2b2@kernel.org>
In-Reply-To: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-0-c1eb73d6b2b2@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang.tang@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3643; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=miW/XKSOuytVFgSjsknCqPk/EdhcvF+o8LQ0qEUhzHM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlhYV2xMgM8JYyWpD2nO4dP3ilGQatzBVoxPF+l
 txotzEs9fiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYWFdgAKCRD2t4JPQmmg
 c2jDD/43Z35uViCyLlDUo8YuyNyQuZmvZIKc6asc5G9f7G5EYriZQ48i64CC75s9Z5dofAsLNQJ
 BEI3pHI+DX1+11r4nj6tEm/p2vkFfvGBVHBrGGVEpvKdcQ7v6n89mshYvLisVqp5trZcMN7wVQL
 /J1OYTb4pcIwyoBhAJXM1yX5dBP59Vo8ptG7Vj8lTNCEWGW/2R4lAY49I+Pojo7FxzgXGdDeStO
 79vU8sD98hmzAmfLY+QtQFa1dpWELxgnaOFBKBUu+JqprRcE7BTLsbDCuHJWK5ot/B4F9npS0+b
 CW4T0hjS6XHtVG7iGU5DLl8wLuj41zULPc3c0DvLdiThpF6zWXoTWRyxv3/zphHljsdv14SLbTT
 OvFVcB1tl8rOa5sHzSYxNZ0bqlrOJNgZrmWnOM9sYDBohzVlRPsKs4wqwMiD0RVJzLMpyMlowyb
 gYzcXt2aBKLKn1Vw8j/F3TjHdnDYIVZsRWtze6eTpncNRTXowkaFboqUaZl5OTAxtL+XvA8qcIb
 OHgNrsOUHi6IFhHyCk/+JFdaFVDsEoHJb1LuDYEdY6JKLcPJK7L4RnyuePO5KVZXBcYVYy0qfxg
 h+NNCxyeuKCIpSFiWKc/9JMnK74viMRQSGG+b7A2RmXfj7kfb/9fSVbXaQRmSWSp6AEGQKgHklP
 pFwxtYhQZtw4U2A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang.tang@linux.dev>

Add a new MIB counter named MPTCP_MIB_CURRESTAB to count current
established MPTCP connections, similar to TCP_MIB_CURRESTAB. This is
useful to quickly list the number of MPTCP connections without having to
iterate over all of them.

This patch adds a new helper function mptcp_set_state(): if the state
switches from or to ESTABLISHED state, this newly added counter is
incremented. This helper is going to be used in the following patch.

Similar to MPTCP_INC_STATS(), a new helper called MPTCP_DEC_STATS() is
also needed to decrement a MIB counter.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  8 ++++++++
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 4 files changed, 28 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index a0990c365a2e..c30405e76833 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -66,6 +66,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvWndShared", MPTCP_MIB_RCVWNDSHARED),
 	SNMP_MIB_ITEM("RcvWndConflictUpdate", MPTCP_MIB_RCVWNDCONFLICTUPDATE),
 	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
+	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index cae71d947252..dd7fd1f246b5 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -65,6 +65,7 @@ enum linux_mptcp_mib_field {
 					 * conflict with another subflow while updating msk rcv wnd
 					 */
 	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
+	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
 	__MPTCP_MIB_MAX
 };
 
@@ -95,4 +96,11 @@ static inline void __MPTCP_INC_STATS(struct net *net,
 		__SNMP_INC_STATS(net->mib.mptcp_statistics, field);
 }
 
+static inline void MPTCP_DEC_STATS(struct net *net,
+				   enum linux_mptcp_mib_field field)
+{
+	if (likely(net->mib.mptcp_statistics))
+		SNMP_DEC_STATS(net->mib.mptcp_statistics, field);
+}
+
 bool mptcp_mib_alloc(struct net *net);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5cd5c3f535a8..b555bd0b425b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2885,6 +2885,24 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 	release_sock(ssk);
 }
 
+void mptcp_set_state(struct sock *sk, int state)
+{
+	int oldstate = sk->sk_state;
+
+	switch (state) {
+	case TCP_ESTABLISHED:
+		if (oldstate != TCP_ESTABLISHED)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
+		break;
+
+	default:
+		if (oldstate == TCP_ESTABLISHED)
+			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
+	}
+
+	inet_sk_state_store(sk, state);
+}
+
 static const unsigned char new_state[16] = {
 	/* current state:     new state:      action:	*/
 	[0 /* (Invalid) */] = TCP_CLOSE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1240268f9e9e..3517f2d24a22 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -641,6 +641,7 @@ bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
+void mptcp_set_state(struct sock *sk, int state);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);

-- 
2.43.0


