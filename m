Return-Path: <linux-kselftest+bounces-42536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF06BA5CC8
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03394C6D73
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9FA2D97A0;
	Sat, 27 Sep 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YID/ekxJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA52D94A8;
	Sat, 27 Sep 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966070; cv=none; b=K2MI3tk++5Grou/1gudu7HntThxhe4sVh42/TvIoX7YV5mumJjfqU/jNNm0RbDi+Cb2Mn99hx3hxxWfTKxJJuJbyl3ggZiYF7qwFEHiL8Bv9OlLzDcz/3KbKGbqtg22GJzklPLvnvZmjC/YRFyBXPrFGoBOV8QLTlEKzQlBC9VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966070; c=relaxed/simple;
	bh=DuR/n0MAhNOdVdW7cbtGYlCwhUUWqMCY1IxaSFB1xto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEPhy1Z3JqKPdvNnSTbwNczoPRXycZvPLHQoBPwKAegIpBkcsI0fQAVvIpxAwWYElidD3aNs35eh1WHV3wf8VD8wUm+LlZuD7EAjAVqXts4qDT9lL9h3WtAWcbuXzAoujeOMESdrAXxrfmdUVdJhU/BLqqo7xeZYVx26ec7wu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YID/ekxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9289EC113CF;
	Sat, 27 Sep 2025 09:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758966070;
	bh=DuR/n0MAhNOdVdW7cbtGYlCwhUUWqMCY1IxaSFB1xto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YID/ekxJBq4AuQY5qqMfEo7RMton9JujOB8PjWdEKoZpp2cQ01xM3v6wfesMP+oyE
	 Of1RF/F3pLmZUy8lBuCzjux4/KB6aidg9dIdo2In/leaFmRQImKXumHoF39HsaYw3D
	 UVrqPVZsTwBuu75zWEZFKXrauWQs1B1j1CkUNA7/08PEDLwaJgX0lIHYKnpD/WJm9T
	 31UnWmLyNfnuC6CoWLcAOOWIjHkYAHztMnuTY40NDP7qtZahlSUBgLXCRAJlYGrQ+n
	 m2Jy5TdZxaPYPKJR4cY66MiQdxOnRCLgGf0oKNSZf5BosV9IA7lMZZux1iSaFz+xf/
	 drA5gZGJqlC1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Sep 2025 11:40:40 +0200
Subject: [PATCH net-next 4/8] mptcp: introduce the mptcp_init_skb helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-net-next-mptcp-rcv-path-imp-v1-4-5da266aa9c1a@kernel.org>
References: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
In-Reply-To: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3172; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=a6n+Svpd0CKjvMgJKQmYqY6PoYH398y5gIFNbgE5hm4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKub1SY1zE1bs5MHv6bif+tDPgPz9demSHs8fXN8wbdP
 2dfdmVc7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZgIzxZGhjezok2M90T9mKdr
 uTw8TVNhv33NSbnTO/cUF8i5CMjPv8fwv9SUza91y/6XLOv8dksHPTV6qCT0Oq8012n+pI55CYL
 CrAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Factor out all the skb initialization step in a new helper and
use it. Note that this change moves the MPTCP CB initialization
earlier: we can do such step as soon as the skb leaves the
subflow socket receive queues.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f994e7f45f7b96c280708d7a29c1423a91e4cfee..832782e23740d22acda608966c29516666c9b111 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -326,27 +326,11 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 		mptcp_rcvbuf_grow(sk);
 }
 
-static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
-			     struct sk_buff *skb, unsigned int offset,
-			     size_t copy_len)
+static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
+			   int copy_len)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	struct sock *sk = (struct sock *)msk;
-	struct sk_buff *tail;
-	bool has_rxtstamp;
-
-	__skb_unlink(skb, &ssk->sk_receive_queue);
-
-	skb_ext_reset(skb);
-	skb_orphan(skb);
-
-	/* try to fetch required memory from subflow */
-	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		goto drop;
-	}
-
-	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
@@ -358,6 +342,24 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
+	__skb_unlink(skb, &ssk->sk_receive_queue);
+
+	skb_ext_reset(skb);
+	skb_dst_drop(skb);
+}
+
+static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
+{
+	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *tail;
+
+	/* try to fetch required memory from subflow */
+	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		goto drop;
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -678,7 +680,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			ret = __mptcp_move_skb(msk, ssk, skb, offset, len) || ret;
+			mptcp_init_skb(ssk, skb, offset, len);
+			skb_orphan(skb);
+			ret = __mptcp_move_skb(sk, skb) || ret;
 			seq += len;
 
 			if (unlikely(map_remaining < len)) {

-- 
2.51.0


