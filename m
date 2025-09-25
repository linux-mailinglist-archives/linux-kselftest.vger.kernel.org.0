Return-Path: <linux-kselftest+bounces-42300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6BEB9EB30
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C2B3BEC87
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FD92EF67A;
	Thu, 25 Sep 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqZBn5Bv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416E2EF654;
	Thu, 25 Sep 2025 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796419; cv=none; b=sqq3DslKPGVXOfjwsdjR1iK9XGG/1qn5ZXN0R452/WHzmBExnfueg0z2k5fRunzmNodF/bk54qKxb7NHQZv54ttUKNvVcU3cslGkqJmTvlR96y2Uldh/2XaiBXpbe//UOb0LReRxvRmkaI+Iy/tgEPPHJj/5exOT3k1M5Raogt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796419; c=relaxed/simple;
	bh=PDMt9uuhniUOM8jEKdDiRQE0PgQh6MOHr5j97EISdWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjNRyzxcezeBh9mSKfyI5DzWxUUzMy1L2//uURH+QxBIzF8G7vjbdsTvqmjwHaEGR6X3laP5SeURphhmgGXdKXnJrJRSTtoQcdX/DK+0psM1GvL6dPX7NTmcRys4ae573SJ74TsGpraAKJsBQG9eazoUjhCM9joKztuwl2y3b4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqZBn5Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C331C4CEF7;
	Thu, 25 Sep 2025 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796418;
	bh=PDMt9uuhniUOM8jEKdDiRQE0PgQh6MOHr5j97EISdWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NqZBn5BvLT7WR/F+HCrPq532SMIMBgPosaA7b9rjoVXh/k5LjjvoTs1UqVsnlnJ4p
	 2yD92v2DczIgXGD9JaSM5/KyWe/aDXrBcPiGFFOPvfCIX3y3yAqSWYfiYzIyaR3tGY
	 1ApGEVXrsCt0YDLOJ+aicKPCoFhtJWyBdiCF0XEPCYepZdy2T5vsMRf8H/rNK+5ccO
	 YEUfJWsqOxmsPRijRMqM6sGqjmzBP6MvcOE4yEndgOYo2vacrSm3yhhPGRmCur5ItV
	 Ca+ho106xw9vbXBxaX9DDsPW8C79UN76kb4NWy7UlfqLvsOINE6W63j7xIX6D4W3lE
	 ygZ6dnREk4BiA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:43 +0200
Subject: [PATCH net-next 08/15] mptcp: pm: in-kernel: rename
 'add_addr_accept_max' to 'limit_add_addr_accepted'
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-8-ad126cc47c6b@kernel.org>
References: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
In-Reply-To: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8066; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PDMt9uuhniUOM8jEKdDiRQE0PgQh6MOHr5j97EISdWc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSsW2bosQUbuwNctIYt7k0tePTxsv47YwOx/T2TmLI
 8zIzj2no5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJf3jAybE2+NW2f04QTLmtE
 Opx3GTVdFowwOvG2SmG9cKKMwvSOmYwMU6qPvNZsN1greD07UFzje87rrya/zx9br7eUOZdf4fd
 5DgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'add_addr_accept_max', which in fact represents the limit
of ADD_ADDR that can be accepted:  the limit set via 'ip mptcp limit
add_addr_accepted X' for example. It is not linked to the maximum number
of accepted ADD_ADDR.

While at it, add an additional name for the corresponding variable in
MPTCP INFO: mptcpi_limit_add_addr_accepted. Not to break the current
uAPI, the new name is added as a 'define' pointing to the former name.
This will then also help userspace devs.

No functional changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm.c             |  2 +-
 net/mptcp/pm_kernel.c      | 27 +++++++++++++++------------
 net/mptcp/protocol.h       |  4 ++--
 net/mptcp/sockopt.c        |  4 ++--
 5 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 69fc20db1c2f731d5f93cfee4e58a23119ff7a97..1c275ce96b524cf1525b80967f28b57a59c24a0f 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -50,6 +50,7 @@ struct mptcp_info {
 	__u8	mptcpi_add_addr_signal_max;
 	#define mptcpi_endp_signal_max mptcpi_add_addr_signal_max
 	__u8	mptcpi_add_addr_accepted_max;
+	#define mptcpi_limit_add_addr_accepted mptcpi_add_addr_accepted_max
 	__u32	mptcpi_flags;
 	__u32	mptcpi_token;
 	__u64	mptcpi_write_seq;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1100ba8b1ce8243de46b161fb27272c360559bc3..e13bfec50ef8403e7a446f5e008683a718c7176f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1039,7 +1039,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 			    subflows_allowed) ||
 			   !!mptcp_pm_get_endp_signal_max(msk));
 		WRITE_ONCE(pm->accept_addr,
-			   !!mptcp_pm_get_add_addr_accept_max(msk) &&
+			   !!mptcp_pm_get_limit_add_addr_accepted(msk) &&
 			   subflows_allowed);
 		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
 
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 740f0b20b941fc457831f3394c187159e9a244e8..92f7419485a82908f55563716b9c6e57f49b716b 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -21,7 +21,7 @@ struct pm_nl_pernet {
 	unsigned int		addrs;
 	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
-	unsigned int		add_addr_accept_max;
+	unsigned int		limit_add_addr_accepted;
 	unsigned int		local_addr_max;
 	unsigned int		limit_extra_subflows;
 	unsigned int		next_id;
@@ -54,13 +54,13 @@ unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_signal_max);
 
-unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	return READ_ONCE(pernet->add_addr_accept_max);
+	return READ_ONCE(pernet->limit_add_addr_accepted);
 }
-EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
+EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_add_addr_accepted);
 
 unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 {
@@ -547,16 +547,16 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int limit_extra_subflows;
-	unsigned int add_addr_accept_max;
+	unsigned int limit_add_addr_accepted;
 	struct mptcp_addr_info remote;
 	bool sf_created = false;
 	int i, nr;
 
-	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
+	limit_add_addr_accepted = mptcp_pm_get_limit_add_addr_accepted(msk);
 	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	pr_debug("accepted %d:%d remote family %d\n",
-		 msk->pm.add_addr_accepted, add_addr_accept_max,
+		 msk->pm.add_addr_accepted, limit_add_addr_accepted,
 		 msk->pm.remote.family);
 
 	remote = msk->pm.remote;
@@ -587,7 +587,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		/* add_addr_accepted is not decr for ID 0 */
 		if (remote.id)
 			msk->pm.add_addr_accepted++;
-		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+		if (msk->pm.add_addr_accepted >= limit_add_addr_accepted ||
 		    msk->pm.extra_subflows >= limit_extra_subflows)
 			WRITE_ONCE(msk->pm.accept_addr, false);
 	}
@@ -596,10 +596,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 {
 	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+		unsigned int limit_add_addr_accepted =
+			mptcp_pm_get_limit_add_addr_accepted(msk);
+
 		/* Note: if the subflow has been closed before, this
 		 * add_addr_accepted counter will not be decremented.
 		 */
-		if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+		if (--msk->pm.add_addr_accepted < limit_add_addr_accepted)
 			WRITE_ONCE(msk->pm.accept_addr, true);
 	}
 }
@@ -1282,7 +1285,7 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 	int ret;
 
 	spin_lock_bh(&pernet->lock);
-	rcv_addrs = pernet->add_addr_accept_max;
+	rcv_addrs = pernet->limit_add_addr_accepted;
 	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
 	if (ret)
 		goto unlock;
@@ -1292,7 +1295,7 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto unlock;
 
-	WRITE_ONCE(pernet->add_addr_accept_max, rcv_addrs);
+	WRITE_ONCE(pernet->limit_add_addr_accepted, rcv_addrs);
 	WRITE_ONCE(pernet->limit_extra_subflows, subflows);
 
 unlock:
@@ -1316,7 +1319,7 @@ int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 		goto fail;
 
 	if (nla_put_u32(msg, MPTCP_PM_ATTR_RCV_ADD_ADDRS,
-			READ_ONCE(pernet->add_addr_accept_max)))
+			READ_ONCE(pernet->limit_add_addr_accepted)))
 		goto fail;
 
 	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOWS,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 86c30cd6c1f2ceccba9d14ddac7e6334dd46e21b..114995e1352d02c3e0bcb29ccffcc1ac413be191 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1181,7 +1181,7 @@ void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
@@ -1203,7 +1203,7 @@ static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
 	       msk->pm.local_addr_used == 0 &&
-	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
+	       mptcp_pm_get_limit_add_addr_accepted(msk) == 0 &&
 	       msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk);
 }
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 4688e0f25d15d9363b33bdcf3ad75c8295a810e3..5ab9909dbe799bed5c59d2b1b04cc0e88e960574 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -976,8 +976,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_limit_extra_subflows(msk);
 		info->mptcpi_endp_signal_max =
 			mptcp_pm_get_endp_signal_max(msk);
-		info->mptcpi_add_addr_accepted_max =
-			mptcp_pm_get_add_addr_accept_max(msk);
+		info->mptcpi_limit_add_addr_accepted =
+			mptcp_pm_get_limit_add_addr_accepted(msk);
 		info->mptcpi_local_addr_max =
 			mptcp_pm_get_local_addr_max(msk);
 	}

-- 
2.51.0


