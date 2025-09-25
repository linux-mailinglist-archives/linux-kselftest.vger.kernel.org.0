Return-Path: <linux-kselftest+bounces-42305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C24CDB9EB69
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB0A3A800C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1BB2FF658;
	Thu, 25 Sep 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4HGrN/1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4C2FF15E;
	Thu, 25 Sep 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796433; cv=none; b=hPH4TyTlxcuqHWgT6UQjtqqeksOz6BWjDuL8kur8YOlicmj7l6N9oHX3ZgwyP7COt3r2mNQfnrd3UoNX5qxlHZxxE1sSPifZVQ4HSMwsfkL1g2vPvpUtjnwZTRh5R/cCa3xEORStXkZETlZjpgHumCYUq3ldGWvMkB3Dn3TbqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796433; c=relaxed/simple;
	bh=44rzxtTfxaA41HeZVH+JQ2ortDOfjGH+UAXRCx6P6j4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIKyWVXNXSnsE4Cgtmwjuw7rpNPfaOLXPMu//Q+T6ovP/HFQLPHV6Fwrv+ZoFPaAWMM41nGASuZwgERpPadX/MclNw/tj3HlLAEqfDZfoIyGX4xXM+uO7xfYnRlcVjLH8aJMFE9IC1tgvi4ThuOLZG1wKKbcVVRaRI7QPhXDsLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4HGrN/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71672C113CF;
	Thu, 25 Sep 2025 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796432;
	bh=44rzxtTfxaA41HeZVH+JQ2ortDOfjGH+UAXRCx6P6j4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V4HGrN/1DFloZ/b41DOAyrVHbAERopItjyKk6VQFIhtdlc9kOjA6W4Ga38zz7vNrY
	 fHTSuCP3tsXtZ+lp1//T6XqyBfmX6eOb+c15PaRFCpUWgfdUzmhK1kimJhKOzdQtK2
	 v7i9wouomRKpwslp6jMJCrDJkPpE1fpdWkzbse829m9tfhFXDMzPF4b4upBQPsnXi0
	 oj9CkmbDsADyna1Xb1wvMuSbXDB1hFpKlbEr5E459G8ptTOKlDyZ1xCTXCbnzeL7iE
	 iWSkRRTjop/z6mhb/owOUsO9acc6h/k14Riog/f44u6FHHSgbst1Vl/OYEeasm7EkF
	 P1woFN+1WeG2g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:48 +0200
Subject: [PATCH net-next 13/15] mptcp: pm: in-kernel: reduce pernet struct
 size
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-13-ad126cc47c6b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9439; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=44rzxtTfxaA41HeZVH+JQ2ortDOfjGH+UAXRCx6P6j4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSqWs/6S4/d6C1YVXFxqyrTz0edmm4+weJZF8dpf+7
 hJiuJi8tKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiT9IZ/krdNGiecflUw9cV
 l9gaZ9tNOJym8byjeQlr96oDMQEV/5UZGabZPv730fdqotfG4pj94WkmdWYZz4ST3r95xqjCWrN
 DmhkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

All the 'unsigned int' variables from the 'pm_nl_pernet' structure are
bounded to MPTCP_PM_ADDR_MAX, currently set to 8. The endpoint ID is
also bounded by the protocol to 8-bit. MPTCP_PM_ADDR_MAX, if extended
later, will never over 8-bit.

So no need to use 'unsigned int' variables, 'u8' is enough.

Note that the exposed counters in MPTCP_INFO are already limited to
8-bit, same for pm->extra_subflows, and others. So it seems even better
to limit them to 8-bit.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 59 ++++++++++++++++++++-------------------------------
 net/mptcp/protocol.h  |  8 +++----
 2 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 0e1e99e72950f2432b33610047bc4aa68c5e75af..117f842fe18e44f6e887d9044c7b0bb55cbb9084 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -18,12 +18,12 @@ struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
 	struct list_head	endp_list;
-	unsigned int		endpoints;
-	unsigned int		endp_signal_max;
-	unsigned int		endp_subflow_max;
-	unsigned int		limit_add_addr_accepted;
-	unsigned int		limit_extra_subflows;
-	unsigned int		next_id;
+	u8			endpoints;
+	u8			endp_signal_max;
+	u8			endp_subflow_max;
+	u8			limit_add_addr_accepted;
+	u8			limit_extra_subflows;
+	u8			next_id;
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 };
 
@@ -45,7 +45,7 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
 	return pm_nl_get_pernet(genl_info_net(info));
 }
 
-unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
+u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
 {
 	const struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
@@ -53,7 +53,7 @@ unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_signal_max);
 
-unsigned int mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk)
+u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
@@ -61,7 +61,7 @@ unsigned int mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_subflow_max);
 
-unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
+u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
@@ -69,7 +69,7 @@ unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_add_addr_accepted);
 
-unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
+u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
@@ -185,15 +185,13 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			       struct mptcp_addr_info *local,
 			       struct mptcp_addr_info *addrs)
 {
+	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
 	DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct sock *sk = (struct sock *)msk, *ssk;
 	struct mptcp_subflow_context *subflow;
-	unsigned int limit_extra_subflows;
 	int i = 0;
 
-	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
-
 	/* Forbid creation of new subflows matching existing ones, possibly
 	 * already created by incoming ADD_ADDR
 	 */
@@ -272,20 +270,14 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	u8 endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
+	u8 endp_signal_max = mptcp_pm_get_endp_signal_max(msk);
 	struct sock *sk = (struct sock *)msk;
-	unsigned int limit_extra_subflows;
 	bool signal_and_subflow = false;
-	unsigned int endp_subflow_max;
-	unsigned int endp_signal_max;
-	struct pm_nl_pernet *pernet;
 	struct mptcp_pm_local local;
 
-	pernet = pm_nl_get_pernet(sock_net(sk));
-
-	endp_signal_max = mptcp_pm_get_endp_signal_max(msk);
-	endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
-	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
-
 	/* do lazy endpoint usage accounting for the MPC subflows */
 	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
@@ -400,16 +392,15 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 				  struct mptcp_pm_local *locals,
 				  bool c_flag_case)
 {
+	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
-	unsigned int limit_extra_subflows;
 	struct mptcp_addr_info mpc_addr;
 	struct mptcp_pm_local *local;
 	int i = 0;
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
-	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
@@ -457,16 +448,15 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 				struct mptcp_addr_info *remote,
 				struct mptcp_pm_local *locals)
 {
-	unsigned int endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
+	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	u8 endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
 	struct sock *sk = (struct sock *)msk;
-	unsigned int limit_extra_subflows;
 	struct mptcp_addr_info mpc_addr;
 	struct mptcp_pm_local *local;
 	int i = 0;
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
-	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	while (msk->pm.local_addr_used < endp_subflow_max) {
 		local = &locals[i];
@@ -543,17 +533,14 @@ fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
+	u8 limit_add_addr_accepted = mptcp_pm_get_limit_add_addr_accepted(msk);
+	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
-	unsigned int limit_extra_subflows;
-	unsigned int limit_add_addr_accepted;
 	struct mptcp_addr_info remote;
 	bool sf_created = false;
 	int i, nr;
 
-	limit_add_addr_accepted = mptcp_pm_get_limit_add_addr_accepted(msk);
-	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
-
 	pr_debug("accepted %d:%d remote family %d\n",
 		 msk->pm.add_addr_accepted, limit_add_addr_accepted,
 		 msk->pm.remote.family);
@@ -595,7 +582,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 {
 	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
-		unsigned int limit_add_addr_accepted =
+		u8 limit_add_addr_accepted =
 			mptcp_pm_get_limit_add_addr_accepted(msk);
 
 		/* Note: if the subflow has been closed before, this
@@ -626,8 +613,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     bool needs_id, bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
-	unsigned int addr_max;
 	int ret = -EINVAL;
+	u8 addr_max;
 
 	spin_lock_bh(&pernet->lock);
 	/* to keep the code simple, don't do IDR-like allocation for address ID,
@@ -1072,8 +1059,8 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
-	unsigned int addr_max;
 	struct nlattr *attr;
+	u8 addr_max;
 	int ret;
 
 	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index df8f977039d0a716e5792e3ada7eee9e075f1581..0cd3333cafafad19a8c2c8ea302265af9f27a8bf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1180,10 +1180,10 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)

-- 
2.51.0


