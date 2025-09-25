Return-Path: <linux-kselftest+bounces-42306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DFFB9EB7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE192A1933
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB492FFFB9;
	Thu, 25 Sep 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UolAGyOs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA7D2F39A4;
	Thu, 25 Sep 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796436; cv=none; b=jm9K93VBnClCCfKZtM0B9aiOxGxOFnudV7TqbqluK4CGQM5A4jaw1yeCnWtVyY4QKhzSMg4zVUGl9jYM1cYHhBj0/y91uSkswnH0Gxp508x6FUlvY1IUtZyWuo5WCU/JBcnuDLwvPUKlJ0HSQoWajPnKjIZV2R+r7uHsZKOpvLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796436; c=relaxed/simple;
	bh=dsnevKHdH5MIIquxkaznVssSxOBQWvCuNCuioeC4DQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZo3K9duXvLUxKge+/kthmm8boWZN8utnLEh97ATu/iCZyBphurGfVW965yugt2cmVaLulhdp0s0Y1xSC5PWLceNQ8yoEVYBIyjoSAEF4dIVxccMYrPhLLvfhd6L+H0n33+XwmPNVgV+Re6T/l225bmC31LJQrgwPsncNO4IDhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UolAGyOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D2AC4CEF4;
	Thu, 25 Sep 2025 10:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796435;
	bh=dsnevKHdH5MIIquxkaznVssSxOBQWvCuNCuioeC4DQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UolAGyOsHlQuDu6IeDFFwuNGSzI9fNYPVkNZquNlSkpm4VKoBx/EwfPBK7YJ/zhCu
	 GNlY8yCyVL1H283ClVQvIPkT3d8fJFT9u2O3plgsvRV3MJ4RZTL3JiUzihk2tozFhp
	 AeBaavpRy2ABYnbOr/3rEVP4A0SKrcYiNYuXIUB4dkjptxtPN/mWFeudamPgCaXD1K
	 Gpqb6MFQ1dDqkQsuQFylpcNWCoMkoEWyCVouwHga3dPrSXpsEby9iZMhHg3WfH3EFm
	 D5TZFHCGVyi1m5DhSEV5gtBGEDw4LjGy9xGxdC+tNi/6+vH7GDsXsADzAUC9A7j50B
	 2twvCkoOmjPlQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:49 +0200
Subject: [PATCH net-next 14/15] mptcp: pm: in-kernel: compare IDs instead
 of addresses
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-14-ad126cc47c6b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6703; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dsnevKHdH5MIIquxkaznVssSxOBQWvCuNCuioeC4DQE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSqVlXpoxe4LLxX1OzJYsJYVun2ZNbE67fDlrv9Jzh
 l+GDosfd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkpTEjw0mDvWwO9h3L2Gpe
 ipx+wPhNVmD5b52AT14BLNe+JdRPsmP4n7AldP2Dome9Sc3ihZwJ9X9OZf68IzIn4e2+pp2JWiu
 uMQAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When receiving an ADD_ADDR right after the 3WHS, the connection will
switch to 'fully established'. It means the MPTCP worker will be called
to treat two events, in this order: ADD_ADDR_RECEIVED, PM_ESTABLISHED.

The MPTCP endpoints cannot have the ID 0, because it is reserved to the
address and port used by the initial subflow. To be able to deal with
this case in different places, msk->mpc_endpoint_id contains the
endpoint ID linked to the initial subflow. This variable was only set
when treating the first PM_ESTABLISHED event, after ADD_ADDR_RECEIVED.
That's why in fill_local_addresses_vec(), the endpoint addresses were
compared with the one of the initial subflow, instead of only comparing
the IDs.

Instead, msk->mpc_endpoint_id is now set when treating ADD_ADDR_RECEIVED
as well, if needed, then the IDs can be compared.

To be able to do so, the code doing that is now in a dedicated helper,
and called from the functions linked to the two actions.

While at it, mptcp_endp_get_local_id() has also been moved up, next to
this new helper, because they are linked, and to be able to use it in
fill_local_addresses_vec() in the next commit.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 82 +++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 117f842fe18e44f6e887d9044c7b0bb55cbb9084..55dbf89d19b8afeb879f5307c035c855601c6b04 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -268,6 +268,46 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 	return NULL;
 }
 
+static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr)
+{
+	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
+}
+
+/* Set mpc_endpoint_id, and send MP_PRIO for ID0 if needed */
+static void mptcp_mpc_endpoint_setup(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_addr_info mpc_addr;
+	struct pm_nl_pernet *pernet;
+	bool backup = false;
+
+	/* do lazy endpoint usage accounting for the MPC subflows */
+	if (likely(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED)) ||
+	    !msk->first)
+		return;
+
+	subflow = mptcp_subflow_ctx(msk->first);
+	pernet = pm_nl_get_pernet_from_msk(msk);
+
+	mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
+	rcu_read_lock();
+	entry = __lookup_addr(pernet, &mpc_addr);
+	if (entry) {
+		__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
+		msk->mpc_endpoint_id = entry->addr.id;
+		backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	}
+	rcu_read_unlock();
+
+	/* Send MP_PRIO */
+	if (backup)
+		mptcp_pm_send_ack(msk, subflow, true, backup);
+
+	msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
+}
+
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
@@ -278,28 +318,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	bool signal_and_subflow = false;
 	struct mptcp_pm_local local;
 
-	/* do lazy endpoint usage accounting for the MPC subflows */
-	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
-		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
-		struct mptcp_pm_addr_entry *entry;
-		struct mptcp_addr_info mpc_addr;
-		bool backup = false;
-
-		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
-		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr);
-		if (entry) {
-			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
-			msk->mpc_endpoint_id = entry->addr.id;
-			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-		}
-		rcu_read_unlock();
-
-		if (backup)
-			mptcp_pm_send_ack(msk, subflow, true, backup);
-
-		msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
-	}
+	mptcp_mpc_endpoint_setup(msk);
 
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
 		 msk->pm.local_addr_used, endp_subflow_max,
@@ -396,12 +415,9 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info mpc_addr;
 	struct mptcp_pm_local *local;
 	int i = 0;
 
-	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
-
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
 		bool is_id0;
@@ -417,8 +433,7 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 		local->flags = entry->flags;
 		local->ifindex = entry->ifindex;
 
-		is_id0 = mptcp_addresses_equal(&local->addr, &mpc_addr,
-					       local->addr.port);
+		is_id0 = local->addr.id == msk->mpc_endpoint_id;
 
 		if (c_flag_case &&
 		    (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
@@ -452,12 +467,9 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	u8 endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_addr_info mpc_addr;
 	struct mptcp_pm_local *local;
 	int i = 0;
 
-	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
-
 	while (msk->pm.local_addr_used < endp_subflow_max) {
 		local = &locals[i];
 
@@ -469,8 +481,7 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
 			continue;
 
-		if (mptcp_addresses_equal(&local->addr, &mpc_addr,
-					  local->addr.port))
+		if (local->addr.id == msk->mpc_endpoint_id)
 			continue;
 
 		msk->pm.local_addr_used++;
@@ -548,6 +559,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	remote = msk->pm.remote;
 	mptcp_pm_announce_addr(msk, &remote, true);
 	mptcp_pm_addr_send_ack(msk);
+	mptcp_mpc_endpoint_setup(msk);
 
 	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
 		return;
@@ -935,12 +947,6 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
-				  const struct mptcp_addr_info *addr)
-{
-	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
-}
-
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)

-- 
2.51.0


