Return-Path: <linux-kselftest+bounces-45832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89375C67E5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DB2C829166
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC351301718;
	Tue, 18 Nov 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJp7fqsl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C33016EF;
	Tue, 18 Nov 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450460; cv=none; b=qzWixsAbz1DlTh1lVq5I3Ayixndp6/XMnBzgObuHR0egoBweHSZwae8rGylah/z518f+/Fq3SRsAetORSaJqc/jgbd6qrxRQIyqEVfbnL8oi3GAkR4BUTLZFOc7UjcuZOlsRBPdI1BpgT6OWFsNZkfXe6xaCS9o2CUxmGn02Xnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450460; c=relaxed/simple;
	bh=H+7z3LlqAEaoG8+SZgoVpEBuA0hMlOA03G0LG84/a/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jPFZKQ4kQskdop+YHrivpOBxV20ifBX6b0gyonTXrDb0oGcaMm1A9YHSRkvlAILIM8IJEGLe3FjG3HyxsnRHBB2DiZKFQXH2+ZARPV+W22jtqk1/PddO4XY9oxYl5fhfXLo6XzIvRARwOWB25+pnQT2r4S1aiDD6v0FuSlSgsjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJp7fqsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855DEC116B1;
	Tue, 18 Nov 2025 07:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450460;
	bh=H+7z3LlqAEaoG8+SZgoVpEBuA0hMlOA03G0LG84/a/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TJp7fqslfG5XAkOKK3ocQResSMpmZ7BheKL2NITJ9nnAnB23IkFLjwx778Enq/nBg
	 YZaIbDF9hOYzR9QlRu/6dcWM8iuQVB7l9UQg2k4NfHWTGbXhSH4PKfL8purwywYMmU
	 b02QWqaDYWnyn8hgq2eS1obHUYSDWdfnMT56mSlwqCkYxRPkLmq+Srbri0oqIT6cek
	 9TuRXusgvUkGnC+Wrth9Wj/hfIZCyCCrSV8d7jV9pnlINcauDUi2X7cFdadelbHNVG
	 1B7T/nspCNjFmRVo2zk9UCq80wW5cWwNgGkMPmJLYWZ5xynGgSVwp0aod9j+bwKmuf
	 bRD+Lr/Y2GjJQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Nov 2025 08:20:20 +0100
Subject: [PATCH net 02/11] mptcp: avoid unneeded subflow-level drops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-2-806d3781c95f@kernel.org>
References: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
In-Reply-To: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3731; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0qNYQ3jMQIEkmU+vOfYLEB/lSkVygBbnIQV+tu4DGjk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5NzTNM6uaZ/Vt0Zbx1P1dvdEtwlhF9/l3rde3JJQN
 78g7MbJjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInk/2dkOFenIJO1a27z2eop
 NcXaurpXl79UTlZfyrb6mOQXDp4FlxgZDnR3Tsn5c/DX9/R/13a9+sBmeshtw//8rgshOS+qPRZ
 bsQIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The rcv window is shared among all the subflows. Currently, MPTCP sync
the TCP-level rcv window with the MPTCP one at tcp_transmit_skb() time.

The above means that incoming data may sporadically observe outdated
TCP-level rcv window and being wrongly dropped by TCP.

Address the issue checking for the edge condition before queuing the
data at TCP level, and eventually syncing the rcv window as needed.

Note that the issue is actually present from the very first MPTCP
implementation, but backports older than the blamed commit below will
range from impossible to useless.

Before:

  $ nstat -n; sleep 1; nstat -z TcpExtBeyondWindow
  TcpExtBeyondWindow              14                 0.0

After:

  $ nstat -n; sleep 1; nstat -z TcpExtBeyondWindow
  TcpExtBeyondWindow              0                  0.0

Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 31 +++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a63bd00807d..f24ae7d40e88 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1044,6 +1044,31 @@ static void __mptcp_snd_una_update(struct mptcp_sock *msk, u64 new_snd_una)
 	WRITE_ONCE(msk->snd_una, new_snd_una);
 }
 
+static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
+			struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct tcp_sock *tp = tcp_sk(ssk);
+	u64 mptcp_rcv_wnd;
+
+	/* Avoid touching extra cachelines if TCP is going to accept this
+	 * skb without filling the TCP-level window even with a possibly
+	 * outdated mptcp-level rwin.
+	 */
+	if (!skb->len || skb->len < tcp_receive_window(tp))
+		return;
+
+	mptcp_rcv_wnd = atomic64_read(&msk->rcv_wnd_sent);
+	if (!after64(mptcp_rcv_wnd, subflow->rcv_wnd_sent))
+		return;
+
+	/* Some other subflow grew the mptcp-level rwin since rcv_wup,
+	 * resync.
+	 */
+	tp->rcv_wnd += mptcp_rcv_wnd - subflow->rcv_wnd_sent;
+	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
+}
+
 static void ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
 			   struct mptcp_options_received *mp_opt)
@@ -1211,6 +1236,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (mp_opt.use_ack)
 		ack_update_msk(msk, sk, &mp_opt);
+	rwin_update(msk, sk, skb);
 
 	/* Zero-data-length packets are dropped by the caller and not
 	 * propagated to the MPTCP layer, so the skb extension does not
@@ -1297,6 +1323,10 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 
 	if (rcv_wnd_new != rcv_wnd_old) {
 raise_win:
+		/* The msk-level rcv wnd is after the tcp level one,
+		 * sync the latter.
+		 */
+		rcv_wnd_new = rcv_wnd_old;
 		win = rcv_wnd_old - ack_seq;
 		tp->rcv_wnd = min_t(u64, win, U32_MAX);
 		new_win = tp->rcv_wnd;
@@ -1320,6 +1350,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 
 update_wspace:
 	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
+	subflow->rcv_wnd_sent = rcv_wnd_new;
 }
 
 static void mptcp_track_rwin(struct tcp_sock *tp)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 379a88e14e8d..5575ef64ea31 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -509,6 +509,7 @@ struct mptcp_subflow_context {
 	u64	remote_key;
 	u64	idsn;
 	u64	map_seq;
+	u64	rcv_wnd_sent;
 	u32	snd_isn;
 	u32	token;
 	u32	rel_write_seq;

-- 
2.51.0


