Return-Path: <linux-kselftest+bounces-42301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8144EB9EB45
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB22189E7D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91A22FAC04;
	Thu, 25 Sep 2025 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXhi7TmU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732B2FA0DE;
	Thu, 25 Sep 2025 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796421; cv=none; b=NPRDZ3SsL4o6zkQfG+XrZxtVQ3IAMCtaQoMr+7UU1mgz0/S5b+leSBODEqt0klkDmK3Pw8CqB1t8Q2stcsiryVoXzXjMfPu4Z3PD2o4FgW23NOWrVzfPOsBH8JqbaAqae3oxuzc807usaK+LuFJgnNt2NI4X7x9YV/pwGrYtf9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796421; c=relaxed/simple;
	bh=ZQRj8VMT49bI+cSynEog0aUXFrAMDIyRfWmxcJ9koqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IFOkqgMa8CF1WwkJ8FQSzzPEBQZ67c5KEM6nkYfq6Ji1lqfCDiyW13C5dAlVQY8EzLgcIzZiRnopOdJ2YePlSI3P3lYEI0peJ6LwX1QOoP5ZkZzNIMl4T019HdhWsqy6gYZoXBNBjL7+M3v/IJnhUfKFVD0/36SRojB06H9Vfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXhi7TmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0627C113D0;
	Thu, 25 Sep 2025 10:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796421;
	bh=ZQRj8VMT49bI+cSynEog0aUXFrAMDIyRfWmxcJ9koqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KXhi7TmUrZQ7K+xDJjMUl2YQB0qRAGywkOue8W48U5KWggm6ZSuEjaaFlHhdoKpit
	 8TMNynjMq3jvfmer3i61D1Tf/ZQNAUfuKArGqDqgSrOvyxknsh5yD9UMl2zhugWxtP
	 EKcSBp+EdIUcnuScjksHKvwOWC24czBHtdZZcNmrCJD+Dsi6dN+vHdds/mDTVXQQb2
	 dE5nn4klr6KjkpjQyjjFQcfMsxunuWWqirk/Zow6xeyzb7c/teaXqyPzCLoBT3iSiq
	 e/llaDoyRq9N39Mdp4XB6Xz6QhSY5oBWfZdW8mEiQvg8j6V+iMRzd4Z2EIz+a9BYoc
	 fSRmueOre3VdA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:44 +0200
Subject: [PATCH net-next 09/15] mptcp: pm: in-kernel: rename
 'local_addr_max' to 'endp_subflow_max'
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-9-ad126cc47c6b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8809; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZQRj8VMT49bI+cSynEog0aUXFrAMDIyRfWmxcJ9koqY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSsXts5rs0fznRvb7l/tSrjvHH0oT6+2a1RSR8OZAl
 VjizhXXO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYStJSR4dUjheRbZWIRnwzn
 eadc5tuTt4Zh2uHMmbH/tQK/Jty8cZnhn5rawpVambFsvhtfvxH/1SwizxGtJ/NDf6GN4q1fs9c
 dYwYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'local_addr_max', which in fact represents the maximum
number of 'subflow' endpoints that can be used to create new subflows,
and not the number of local addresses that have been used to create
subflows.

While at it, add an additional name for the corresponding variable in
MPTCP INFO: mptcpi_endp_subflow_max. Not to break the current uAPI, the
new name is added as a 'define' pointing to the former name. This will
then also help userspace devs.

Also move the variable and function next to the other 'endp_X_max' ones.

No functional changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm.c             |  2 +-
 net/mptcp/pm_kernel.c      | 40 ++++++++++++++++++++--------------------
 net/mptcp/protocol.h       |  2 +-
 net/mptcp/sockopt.c        |  4 ++--
 5 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 1c275ce96b524cf1525b80967f28b57a59c24a0f..5ec996977b3fa2351222e6d01b814770b34348e9 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -58,6 +58,7 @@ struct mptcp_info {
 	__u64	mptcpi_rcv_nxt;
 	__u8	mptcpi_local_addr_used;
 	__u8	mptcpi_local_addr_max;
+	#define mptcpi_endp_subflow_max mptcpi_local_addr_max
 	__u8	mptcpi_csum_enabled;
 	__u32	mptcpi_retransmits;
 	__u64	mptcpi_bytes_retrans;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e13bfec50ef8403e7a446f5e008683a718c7176f..2ff1b949956834aa5c78a1fcb40087aed43225ef 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1035,7 +1035,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 		 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
 		 */
 		WRITE_ONCE(pm->work_pending,
-			   (!!mptcp_pm_get_local_addr_max(msk) &&
+			   (!!mptcp_pm_get_endp_subflow_max(msk) &&
 			    subflows_allowed) ||
 			   !!mptcp_pm_get_endp_signal_max(msk));
 		WRITE_ONCE(pm->accept_addr,
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 92f7419485a82908f55563716b9c6e57f49b716b..e62e21eb9da12a7b361049efce1ba193fcbdc572 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -21,8 +21,8 @@ struct pm_nl_pernet {
 	unsigned int		addrs;
 	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
+	unsigned int		endp_subflow_max;
 	unsigned int		limit_add_addr_accepted;
-	unsigned int		local_addr_max;
 	unsigned int		limit_extra_subflows;
 	unsigned int		next_id;
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
@@ -54,6 +54,14 @@ unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_signal_max);
 
+unsigned int mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return READ_ONCE(pernet->endp_subflow_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_subflow_max);
+
 unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
@@ -70,14 +78,6 @@ unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_extra_subflows);
 
-unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
-{
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-
-	return READ_ONCE(pernet->local_addr_max);
-}
-EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
-
 static bool lookup_subflow_by_daddr(const struct list_head *list,
 				    const struct mptcp_addr_info *daddr)
 {
@@ -276,15 +276,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	unsigned int limit_extra_subflows;
 	bool signal_and_subflow = false;
+	unsigned int endp_subflow_max;
 	unsigned int endp_signal_max;
-	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 	struct mptcp_pm_local local;
 
 	pernet = pm_nl_get_pernet(sock_net(sk));
 
 	endp_signal_max = mptcp_pm_get_endp_signal_max(msk);
-	local_addr_max = mptcp_pm_get_local_addr_max(msk);
+	endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
 	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	/* do lazy endpoint usage accounting for the MPC subflows */
@@ -311,7 +311,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	}
 
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
-		 msk->pm.local_addr_used, local_addr_max,
+		 msk->pm.local_addr_used, endp_subflow_max,
 		 msk->pm.add_addr_signaled, endp_signal_max,
 		 msk->pm.extra_subflows, limit_extra_subflows);
 
@@ -352,7 +352,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 subflow:
 	/* check if should create a new subflow */
-	while (msk->pm.local_addr_used < local_addr_max &&
+	while (msk->pm.local_addr_used < endp_subflow_max &&
 	       msk->pm.extra_subflows < limit_extra_subflows) {
 		struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 		bool fullmesh;
@@ -458,7 +458,7 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 				struct mptcp_addr_info *remote,
 				struct mptcp_pm_local *locals)
 {
-	unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
+	unsigned int endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct sock *sk = (struct sock *)msk;
 	unsigned int limit_extra_subflows;
@@ -469,7 +469,7 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
-	while (msk->pm.local_addr_used < local_addr_max) {
+	while (msk->pm.local_addr_used < endp_subflow_max) {
 		local = &locals[i];
 
 		if (!select_local_address(pernet, msk, local))
@@ -706,8 +706,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		WRITE_ONCE(pernet->endp_signal_max, addr_max + 1);
 	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-		addr_max = pernet->local_addr_max;
-		WRITE_ONCE(pernet->local_addr_max, addr_max + 1);
+		addr_max = pernet->endp_subflow_max;
+		WRITE_ONCE(pernet->endp_subflow_max, addr_max + 1);
 	}
 
 	pernet->addrs++;
@@ -1105,8 +1105,8 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		WRITE_ONCE(pernet->endp_signal_max, addr_max - 1);
 	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-		addr_max = pernet->local_addr_max;
-		WRITE_ONCE(pernet->local_addr_max, addr_max - 1);
+		addr_max = pernet->endp_subflow_max;
+		WRITE_ONCE(pernet->endp_subflow_max, addr_max - 1);
 	}
 
 	pernet->addrs--;
@@ -1189,7 +1189,7 @@ static void __flush_addrs(struct list_head *list)
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	WRITE_ONCE(pernet->endp_signal_max, 0);
-	WRITE_ONCE(pernet->local_addr_max, 0);
+	WRITE_ONCE(pernet->endp_subflow_max, 0);
 	pernet->addrs = 0;
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 114995e1352d02c3e0bcb29ccffcc1ac413be191..df8f977039d0a716e5792e3ada7eee9e075f1581 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1181,9 +1181,9 @@ void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 5ab9909dbe799bed5c59d2b1b04cc0e88e960574..92a2a274262732a345b9ab185efd7da1f0a5773a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -978,8 +978,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_endp_signal_max(msk);
 		info->mptcpi_limit_add_addr_accepted =
 			mptcp_pm_get_limit_add_addr_accepted(msk);
-		info->mptcpi_local_addr_max =
-			mptcp_pm_get_local_addr_max(msk);
+		info->mptcpi_endp_subflow_max =
+			mptcp_pm_get_endp_subflow_max(msk);
 	}
 
 	if (__mptcp_check_fallback(msk))

-- 
2.51.0


