Return-Path: <linux-kselftest+bounces-44582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85FFC2847E
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CAA3AE437
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D562FB630;
	Sat,  1 Nov 2025 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rauTwZ4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4F2FB610;
	Sat,  1 Nov 2025 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019832; cv=none; b=UZjiRsUlM+hFKz8Qb9ySc8Xp21PFVCKX5BSsogpoQp7TI9u0E6u29fT95z5Jh6KWHTxBOKwCT/0H9MWmU1Negs278Dx5siWEEaWQ1I60TXR557zm+ZzvbQschYRs/wM62yl7CF6v/xpv4Dj2V9xlVbtkELDsJ0UhMgh2VIomKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019832; c=relaxed/simple;
	bh=Vla5Q77FG456x0fXBCmps8Q8V1m829UbW1rFyOYi7zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYdpSdPskbtA+qpUcvmCbMqsFiOZNW3fw5tuHRYH9TttnC1SYbSWzxZY4FwCg93Y9qcwomk6Rs3ohtyYOdpGlXQxRK4KUmaBw+sM8K6kwPD0g9FBrXZFNyleNarOsSWsUvrVaNSgYWQYFcyVtjJYcVBrnQ8Qp0/1QreK6dT3vCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rauTwZ4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045F6C116C6;
	Sat,  1 Nov 2025 17:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762019832;
	bh=Vla5Q77FG456x0fXBCmps8Q8V1m829UbW1rFyOYi7zk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rauTwZ4JZj1/4H9hu+TYOPwuN0gMuUBt2aKkFBnRkxo/wIVGMwI7cdbgoaebRC8bb
	 OnZxahOBwvLwHKDVYboNyhsTRQP9khIKMGqVknUcncJ7H38PZp25otJmE64nu6FUO6
	 q7P5k+PGiVpvywOEf2S9xSBvSpe9t3PIh3RTWI742eKFPC8IVSQYf5wq6xDTVvuYNH
	 a+csMis3HOGV0TxF6k4eJKPLXaKmPhBtbUKM+xAQ7VI0w4KsA4kPAgJJHxjO+nmLuo
	 YO7DxY05IjaHCWX/D7eRckuOaEh8IgO+81GjPWPQxuQksqigFaKBEHmwyX6R/OWyJc
	 NrqbVuRgWjG0Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 01 Nov 2025 18:56:51 +0100
Subject: [PATCH net-next 1/4] mptcp: pm: in-kernel: record fullmesh endp nb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-1-b4166772d6bb@kernel.org>
References: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-0-b4166772d6bb@kernel.org>
In-Reply-To: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-0-b4166772d6bb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5303; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Vla5Q77FG456x0fXBCmps8Q8V1m829UbW1rFyOYi7zk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZPN8wa5ifO6W6t7QgI/vw7xNGT1ID+I9x6KeHXlqX+
 S1o+fKwjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImwX2D4Kx2y2+HsN+5tGs/7
 F7nOfbw8//HS3pX/bO20Zba9MyiqtGf4H+ZzamNwHN9j60MOmXZPFx53fetgcHRtq1F94KzTzQe
 6WQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of iterating over all endpoints, under RCU read lock, just to
check if one of them as the fullmesh flag, we can keep a counter of
fullmesh endpoint, similar to what is done with the other flags.

This counter is now checked, before iterating over all endpoints.

Similar to the other counters, this new one is also exposed. A userspace
app can then know when it is being used in a fullmesh mode, with
potentially (too) many subflows.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |  3 ++-
 net/mptcp/pm_kernel.c      | 38 +++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h       |  1 +
 net/mptcp/sockopt.c        |  2 ++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 87cfab874e24..04eea6d1d0a9 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -70,7 +70,8 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_acked;
 	__u8	mptcpi_subflows_total;
 	__u8	mptcpi_endp_laminar_max;
-	__u8	reserved[2];
+	__u8	mptcpi_endp_fullmesh_max;
+	__u8	reserved;
 	__u32	mptcpi_last_data_sent;
 	__u32	mptcpi_last_data_recv;
 	__u32	mptcpi_last_ack_recv;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 2ae95476dba3..e2918c68ff02 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -22,6 +22,7 @@ struct pm_nl_pernet {
 	u8			endp_signal_max;
 	u8			endp_subflow_max;
 	u8			endp_laminar_max;
+	u8			endp_fullmesh_max;
 	u8			limit_add_addr_accepted;
 	u8			limit_extra_subflows;
 	u8			next_id;
@@ -70,6 +71,14 @@ u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_laminar_max);
 
+u8 mptcp_pm_get_endp_fullmesh_max(const struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return READ_ONCE(pernet->endp_fullmesh_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_fullmesh_max);
+
 u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
@@ -603,9 +612,12 @@ fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 	int i;
 
 	/* If there is at least one MPTCP endpoint with a fullmesh flag */
-	i = fill_local_addresses_vec_fullmesh(msk, remote, locals, c_flag_case);
-	if (i)
-		return i;
+	if (mptcp_pm_get_endp_fullmesh_max(msk)) {
+		i = fill_local_addresses_vec_fullmesh(msk, remote, locals,
+						      c_flag_case);
+		if (i)
+			return i;
+	}
 
 	/* If there is at least one MPTCP endpoint with a laminar flag */
 	if (mptcp_pm_get_endp_laminar_max(msk))
@@ -790,6 +802,10 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		addr_max = pernet->endp_laminar_max;
 		WRITE_ONCE(pernet->endp_laminar_max, addr_max + 1);
 	}
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+		addr_max = pernet->endp_fullmesh_max;
+		WRITE_ONCE(pernet->endp_fullmesh_max, addr_max + 1);
+	}
 
 	pernet->endpoints++;
 	if (!entry->addr.port)
@@ -1187,6 +1203,10 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		addr_max = pernet->endp_laminar_max;
 		WRITE_ONCE(pernet->endp_laminar_max, addr_max - 1);
 	}
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+		addr_max = pernet->endp_fullmesh_max;
+		WRITE_ONCE(pernet->endp_fullmesh_max, addr_max - 1);
+	}
 
 	pernet->endpoints--;
 	list_del_rcu(&entry->list);
@@ -1502,6 +1522,18 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	changed = (local->flags ^ entry->flags) & mask;
 	entry->flags = (entry->flags & ~mask) | (local->flags & mask);
 	*local = *entry;
+
+	if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+		u8 addr_max = pernet->endp_fullmesh_max;
+
+		if (entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
+			addr_max++;
+		else
+			addr_max--;
+
+		WRITE_ONCE(pernet->endp_fullmesh_max, addr_max);
+	}
+
 	spin_unlock_bh(&pernet->lock);
 
 	mptcp_pm_nl_set_flags_all(net, local, changed);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 379a88e14e8d..9a3429175758 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1183,6 +1183,7 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_endp_fullmesh_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a28a48385885..de90a2897d2d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -982,6 +982,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_endp_subflow_max(msk);
 		info->mptcpi_endp_laminar_max =
 			mptcp_pm_get_endp_laminar_max(msk);
+		info->mptcpi_endp_fullmesh_max =
+			mptcp_pm_get_endp_fullmesh_max(msk);
 	}
 
 	if (__mptcp_check_fallback(msk))

-- 
2.51.0


