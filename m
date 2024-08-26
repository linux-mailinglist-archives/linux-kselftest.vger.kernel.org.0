Return-Path: <linux-kselftest+bounces-16306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E5795F5E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE0E1C21E3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1D5199EA7;
	Mon, 26 Aug 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwnIhBW2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C34AEEA;
	Mon, 26 Aug 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688006; cv=none; b=IQZFqCCVs8SkY8GmQuu6SUVLEt4yKtiNNRvaHIXbDm3w/kW3lu01JjnR0fk8N04dXGR1+YTojzHcnkDVP4S4sw5r5krxfEzUM5NNJcEeVOdAfZuR7J5cFQycP8pjV0GbpZIY6fXqay4uHyJXkpRneHYxuptaZLsrolM8CmoKZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688006; c=relaxed/simple;
	bh=DRU08/X2Z++25vJpUMrkICDjD03cejj1cIlvXeD6xgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P50/rg2ZcA0nw4dVGiyPSIPNCQdXCE9FtejKSPcIdc4DYUSR99IJ0xcJvB9IXFP3u4K3w3RA8stjSeYnpNikn9oVi76NVBT77GFpsU/0mfM2T+Me09B8bNsFWmlM+q69WKGIHufOD0bGoGuKfc6zoKdFU+09DXHu5hn8g/DzaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwnIhBW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7C7C4DE18;
	Mon, 26 Aug 2024 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688006;
	bh=DRU08/X2Z++25vJpUMrkICDjD03cejj1cIlvXeD6xgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MwnIhBW2bFmtVsjy3NFHNSBMpcclqoPSHOLfa98HdSuxA+lYbSkrtmh4M4eRCwhUa
	 plgFVgUMTEQk56Yq/u2XgBlm/9G5oJgSbUyuwnyjNqRyPKtgk0uGYRs1yXwv1Q8JQk
	 1lLQsMQ6HOirxXJln81CtVxQF3x0UmTxnsyOz8fA4wq3g1gALXHlzY18M/dq/2zbyA
	 uFuyQPgwfW6f88+TnzwADW/8BcH4FBZliWxZGp1tTRWBo3pZzZGkdzx5wiaTaE3APy
	 WWQHCTSCJbo+0KGdZnK5PXnvNEILRlOts52faihPn4yj5pJlYqughpuNA7ovmYZ969
	 5wi6c/hkrMFiQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:11 +0200
Subject: [PATCH net 12/15] mptcp: avoid duplicated SUB_CLOSED events
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-12-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2774; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DRU08/X2Z++25vJpUMrkICDjD03cejj1cIlvXeD6xgM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZWh9sPB3KjkgOA8EIPl5a/iOvwqEnQEC+r6
 TiX/Hv/XLaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 c+qVD/9HWpsg31NqbSZr6SXsn8lecJaLM/PQ/gPwCBvkK6XHfbJ2j4Yu32YYj/1/j+dGlkuUUSS
 hWzbi5ic889C9bZyutB+QkNE7L08KXjZundCfgxj26swU9JyZp3MYHlOuOD9tv/7xJaVyetMd/U
 wQxHV/hT+XVBd69uczxKqLNa+W7alXciZk4fyRk2MOqxGb84U6yRtir2LVgziueA9oGmhwZs9dA
 oAEP7r2VRxKVN78qoPnbeK1S2hF3B4Xq/MutWLEtZP9HVkY6SzlQ2NJZr7j0dLJ7caa2SbxqRtO
 UY+ZlkplRLKnlMol1LTC1WE4hGmgdwLIXKmuUSDuAMCS7NNy3+woy7YBLY2s8KGMpa9QXYljTd+
 qQGTdUxpL6qtvhm2AGpvRWSSZOyU42gN86a1dyVYH5Ubcj7qjdDv2ZpLCaaFRYOXkjpZ5iEudkR
 AuvSWeBdzSNqOvfIMGVWJnZ2v6BImX0cTwMWsLUrU9kRzGub/ykO7uI8EIJ/r9WYTmWAmmHx5D4
 Q0Wg/why59xqV46YO3gDrasZfSBOn4OXwbC6K/p6DjZo1paItRAcYDzod21K7GX/G4V6P/ihya2
 o508x29qr1k16J4OxJjlI2fRp+8u66rQUA4hNGuvT1tomde1jad8GOmJjeaWuItzCVAoZya6Vs8
 FkSVSg7bebjGLCg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial subflow might have already been closed, but still in the
connection list. When the worker is instructed to close the subflows
that have been marked as closed, it might then try to close the initial
subflow again.

 A consequence of that is that the SUB_CLOSED event can be seen twice:

  # ip mptcp endpoint
  1.1.1.1 id 1 subflow dev eth0
  2.2.2.2 id 2 subflow dev eth1

  # ip mptcp monitor &
  [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9

  # ip mptcp endpoint delete id 1
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9

The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
second one from __mptcp_close_subflow().

To avoid doing the post-closed processing twice, the subflow is now
marked as closed the first time.

Note that it is not enough to check if we are dealing with the first
subflow and check its sk_state: the subflow might have been reset or
closed before calling mptcp_close_ssk().

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Cc: stable@vger.kernel.org
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0d536b183a6c..931172382aa0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2508,6 +2508,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	/* The first subflow can already be closed and still in the list */
+	if (subflow->close_event_done)
+		return;
+
+	subflow->close_event_done = true;
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a1c1b0ff1ce1..7e934ce0e4ff 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -524,7 +524,8 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 10;
+		close_event_done : 1,       /* has done the post-closed part */
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;

-- 
2.45.2


