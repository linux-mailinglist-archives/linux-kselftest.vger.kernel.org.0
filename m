Return-Path: <linux-kselftest+bounces-45831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35983C67EC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66EBD4F65DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13B42FFF99;
	Tue, 18 Nov 2025 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErKtVkne"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFE02FFDF0;
	Tue, 18 Nov 2025 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450457; cv=none; b=FtFHpJXSIjypU4FERdxyPHVb0gEFD6V3AXO/TYGxn2dv+OLu/n6vU9mRvyczD8cooniVL/FWATWn8/uLuIIZ3ecRC147pNlwsNwDdYX2bm4Wkm68nKgUaA2JvRdFeDc2G8Aq8Yz19lMWkWwYYOAabQ1fyYPmq+6nGWNAyEt07y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450457; c=relaxed/simple;
	bh=7RQrEW1CfmBda2GkqQbYPBiwe4jx2dSDSaRxEgqyLBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cH25ZqFJeIrXqU7b8+ERZ+AwCbWc58nyDuPzrTIlGyCgj4KMnZ+NShVCljcPP2jm4nic3h/kdGkzTTLB6SNYxifyL93rFbu5VHjGyik5D55QhkOwDg8cJR1nqhCDpOhlXipiE4T9RIBUQPZ5X+Tf6n99DvJdAfN0u2Sbx/byCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErKtVkne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920C7C4CEFB;
	Tue, 18 Nov 2025 07:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450457;
	bh=7RQrEW1CfmBda2GkqQbYPBiwe4jx2dSDSaRxEgqyLBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ErKtVknetW2qEYsqnCUFV+OAAPRpFYwZPlzqejdpKq6apKFIzhjEAOq37iOhMri8z
	 TyPOpo77lWNoOAOR9dAE7B8TVNcl91AwIGUJNt4hIbBAi6ru5k8b3yM/WGY2ks582h
	 npmy7Te1fL/yMOB51qsvGqRwivKRIwGOJ7eiHmD/c/JZZRbylJ8AvK2JJTBZ2oK7R9
	 dtbODscE2xjfY+O/fev8OmkreJmis9nm+TcBnBWI/+n1wM8Vr+axAwTyYQ/+LmiH/u
	 jRSv97bZoMoYuOpDYHXIZseW40o/XJ50txDbbAJtPcAk8Ij7syoCYBHlDJOIPlU8UU
	 HieDS+GaqgbCA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Nov 2025 08:20:19 +0100
Subject: [PATCH net 01/11] mptcp: fix ack generation for fallback msk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-1-806d3781c95f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lc7FDuUKuHm3lzaRCFNaKyj2lL5wrR+1cMxKKPMz0ls=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5NxuXAwO/WBq0PLe7dIF2WvGVxRMEnMjEiR/Tc97x
 hvZJ3iio5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJ+vYwMnwzOGR5Z/v/BGyeL
 j8vZmWrY3VtvLVzz9Cef3tq5D+tiCxj+ZwcnbdOa9HH6qkVrtG+9zPkSV/HpS77GDtfXv8Mm7q3
 4zw4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

mptcp_cleanup_rbuf() needs to know the last most recent, mptcp-level
rcv_wnd sent, and such information is tracked into the msk->old_wspace
field, updated at ack transmission time by mptcp_write_options().

Fallback socket do not add any mptcp options, such helper is never
invoked, and msk->old_wspace value remain stale. That in turn makes
ack generation at recvmsg() time quite random.

Address the issue ensuring mptcp_write_options() is invoked even for
fallback sockets, and just update the needed info in such a case.

The issue went unnoticed for a long time, as mptcp currently overshots
the fallback socket receive buffer autotune significantly. It is going
to change in the near future.

Fixes: e3859603ba13 ("mptcp: better msk receive window updates")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/594
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1103b3341a70..8a63bd00807d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -838,8 +838,11 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	opts->suboptions = 0;
 
+	/* Force later mptcp_write_options(), but do not use any actual
+	 * option space.
+	 */
 	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
-		return false;
+		return true;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
@@ -1319,6 +1322,20 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
 }
 
+static void mptcp_track_rwin(struct tcp_sock *tp)
+{
+	const struct sock *ssk = (const struct sock *)tp;
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+
+	if (!ssk)
+		return;
+
+	subflow = mptcp_subflow_ctx(ssk);
+	msk = mptcp_sk(subflow->conn);
+	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
+}
+
 __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
 {
 	struct csum_pseudo_header header;
@@ -1611,6 +1628,10 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 				      opts->reset_transient,
 				      opts->reset_reason);
 		return;
+	} else if (unlikely(!opts->suboptions)) {
+		/* Fallback to TCP */
+		mptcp_track_rwin(tp);
+		return;
 	}
 
 	if (OPTION_MPTCP_PRIO & opts->suboptions) {

-- 
2.51.0


