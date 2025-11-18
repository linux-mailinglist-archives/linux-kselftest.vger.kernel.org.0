Return-Path: <linux-kselftest+bounces-45835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B17C67EF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C6A9368388
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274C302170;
	Tue, 18 Nov 2025 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWYmSAy4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E953054FB;
	Tue, 18 Nov 2025 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450469; cv=none; b=IizgaAr4GbJ5L6MYtJG1Pc0fwVbqx0CKintB+dY48+Akciww9cQdHygHsUzCkHRsmwDEE1/1CTENrmKSiNzV8kTu3+kwJCZ/PweRD9TeUnuvW5lDdYZqriz/Zb83KwfoRJzWm1lgoUChJaguMZlEpNjxcQs4PIXWbEjeDXF96ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450469; c=relaxed/simple;
	bh=0a6/8rnHNn57RmGXD2EZpUaGZXFBqyj0ObQOsLA7f54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuvdwrVpjuVHbrZlqPLaAiVFJNVEwXICA6KE33/ebvdPP8qhxmQ3okxUCyv3TLAj+7tXX4XHTPCcgzKtBSd8kre3OddXbmSe6sz9PR7d4AgSyyPrQ4opmKlOzzREjFgPocmvK2r3fxzjRWvHcZf+Hg5J0swlEkZFWos35vMI7xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWYmSAy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6217CC4CEFB;
	Tue, 18 Nov 2025 07:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450468;
	bh=0a6/8rnHNn57RmGXD2EZpUaGZXFBqyj0ObQOsLA7f54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fWYmSAy4RoNtTS5JehgJO224e7WNUWBVj5G7gvsa7ODcqF0sSJ3n8a/D/DTP8qFeb
	 xZctFsGqSNtTXwIyLw8kc2YxqFxObIHXotx+1ZQO6wuwYBlFBtUfE1KHEfR1FnnSof
	 dMv2iAX68fE/jKlQD6EA0fBPbDN0/Kf1MYFTUgRSZK20HtFCSOmA54Ftd59vjs13nm
	 LFrgNZ0J/zWQc/sFvdBuNViTnmeX52U2Gj0UkicJZGKc/JyduLc2N7nlIl5WWsmmPg
	 9zI+GyhtnWNxrbDeNwV+llJFHnGPA0W/NK3EINn5eUHGZl3kQSUSzghGO2aI6aNsKi
	 V77AZxyrw70gw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Nov 2025 08:20:23 +0100
Subject: [PATCH net 05/11] mptcp: decouple mptcp fastclose from tcp close
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-5-806d3781c95f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3431; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Unlz0Bz9w0VHPBv08/cN2Wx5a4HVMduuZjoVpOrpiPM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5Lzvbbr4z+Z39MvTh+c6bKgKE2dJ3VLWWPtkrck1+
 beZeRP1O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACay7zAjw8PCQ/teJThET1Yu
 FT2a6bnQvuO6227Xuq4C89wpDSdelTL8z5rB3fhx7ovW3SKPX2Vq+34SihL/+TOiR0rs4c2b69t
 W8wAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

With the current fastclose implementation, the mptcp_do_fastclose()
helper is in charge of two distinct actions: send the fastclose reset
and cleanup the subflows.

Formally decouple the two steps, ensuring that mptcp explicitly closes
all the subflows after the mentioned helper.

This will make the upcoming fix simpler, and allows dropping the 2nd
argument from mptcp_destroy_common(). The Fixes tag is then the same as
in the next commit to help with the backports.

Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 13 +++++++++----
 net/mptcp/protocol.h |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6f0e8f670d83..c59246c1fde6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2808,7 +2808,11 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_close_subflow(sk);
 
 	if (mptcp_close_tout_expired(sk)) {
+		struct mptcp_subflow_context *subflow, *tmp;
+
 		mptcp_do_fastclose(sk);
+		mptcp_for_each_subflow_safe(msk, subflow, tmp)
+			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
 		mptcp_close_wake_up(sk);
 	}
 
@@ -3233,7 +3237,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
 	 */
-	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+	mptcp_do_fastclose(sk);
+	mptcp_destroy_common(msk);
 
 	/* The first subflow is already in TCP_CLOSE status, the following
 	 * can't overlap with a fallback anymore
@@ -3412,7 +3417,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
+void mptcp_destroy_common(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -3421,7 +3426,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 
 	/* join list will be eventually flushed (with rst) at sock lock release time */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
+		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, 0);
 
 	__skb_queue_purge(&sk->sk_receive_queue);
 	skb_rbtree_purge(&msk->out_of_order_queue);
@@ -3439,7 +3444,7 @@ static void mptcp_destroy(struct sock *sk)
 
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
-	mptcp_destroy_common(msk, 0);
+	mptcp_destroy_common(msk);
 	sk_sockets_allocated_dec(sk);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5575ef64ea31..6ca97096607c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -977,7 +977,7 @@ static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
 	local_bh_enable();
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags);
+void mptcp_destroy_common(struct mptcp_sock *msk);
 
 #define MPTCP_TOKEN_MAX_RETRIES	4
 

-- 
2.51.0


