Return-Path: <linux-kselftest+bounces-16296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4D795F5BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E01D1C2207A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD31195F04;
	Mon, 26 Aug 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffEk+RJ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA4B1946B0;
	Mon, 26 Aug 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687971; cv=none; b=A4dRo1BmVR3/MGVZ6maVsxPYpveTEak/8ChWQrjP1lZFl90YR52bxktVQTAv9J25dDF/+kf5nWMf0J2oH0A0slMODqO2VFoDE9fSvFL6P+Sdyx2wh1faUhrjr+zJWl5KkR5Ghe8zjJl1KMY5npJsmHRb8gtY9P0vavlVVt+SxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687971; c=relaxed/simple;
	bh=s1yss0paMK4upnZxrl0r9CGRCoeHOS6+86NQ8h7dypU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hYFew/cyKo5HwFjODmGlT103O1gnPIPCw0WyKG58MIaTAG+iRcAYmupFMSDTxgY2dIZfoJWDl5x8Xl51ph2Ib/lxQ0j2TgGoPYqeFqI2t+GF9xQ4nuSgdZK6Dn0phjyv38dvIeLHzlrewpo4CEkLVsWB9KR4Y9d+v4EQ8cNNFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffEk+RJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D420DC52FFB;
	Mon, 26 Aug 2024 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687969;
	bh=s1yss0paMK4upnZxrl0r9CGRCoeHOS6+86NQ8h7dypU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ffEk+RJ/cE50lRUI7Ns7xq+LzWLcf9sSFeIW7lqSBa92NgOc05GESb2xPEVz+jInR
	 b7WiiV/mOuRbiWzJ93lS0z58heIOmxUb3ho5aN3xvk15DRmaNyuPrEqqKtNZIeffou
	 yNd93xWrNDr97dyKPrIFkXYMlVxoKertwNirKI9D3U/KPhAcm1ttF0sGZFr/MYMaLl
	 QD+OM11Q0qFy4CIHmN0hz04ET77ZtcNe//uhKa80rkQeLHughMJDCJHRMptjLEadMO
	 /b9Cj1nUsjdg2ZhK77Or9YOnBHdGg3U3IGpYN9ZzUQQ0KM+mHkGBYbYbWwBfMPiqus
	 QPzToIX3dwaCQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:01 +0200
Subject: [PATCH net 02/15] mptcp: pm: fix RM_ADDR ID for the initial
 subflow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-2-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5041; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=s1yss0paMK4upnZxrl0r9CGRCoeHOS6+86NQ8h7dypU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZWgDx4oVOXW3KVTZdQq5DLNgm/h6fcYUdUR
 I5Nl4MHmh2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 c6QcD/4nJ9n2ITXkCPmY9TGzXAu7epOBH1A2i0YjLQELrLqtdzQCkNoD+959fIb6yHv3a480KyD
 razQeRwpezXraa/OWFVXHkk+AIZ634+FMVVfARiyVuTFpN/h6xwyRyC6weLuWLXt07yI4zT4XDc
 SRCbaW+ZYckAP6Gy46B2eRAqUCtrDrudJq438oUyBEM7O/6KDa+p364KbrZJUaAwK/Oz52o3p0Q
 ocM6CGzcUYrILDww6kwmUptpzAeXe+aUlTxaTjZ085p6j2/GJMyv1uOTEVt1BiDA0A7iCaREGwW
 MVtN2QvT70GtX+BUgj7KUeaBHbBLT+7trPrsVf4YHQEHDRVr7xhiEFlseZYmaAPTQttcEhu8uPn
 1m13hgJnUUP9jDl7/VTt22/bU+xDUZStdrnTeeb3J/8Wa0Gl/k+UXUn1NnLb8vFBdDybempn3m5
 mS38J++RraFZU+CETLxpkurDTcl/5FXD3QRe0kazQ4Cg2Wfl4jq6GDstW/xrkmfhx9fb7cuFgwz
 7S4+K92oygY7X5HrnqHDT6oR+HlWwOw9awKVmTG3X+2Yn9m+vpDrYgXV1+NfqXcPWGSIvft043P
 DHVDvn9gRy1vE7N1WxbOk8SQ5X59bf/0O8aNo+z6i0lgxAgG3te33il6CSt1W/wUvzGYp+Yupvu
 QAyMUGEeqRHKyfQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial subflow has a special local ID: 0. When an endpoint is being
deleted, it is then important to check if its address is not linked to
the initial subflow to send the right ID.

If there was an endpoint linked to the initial subflow, msk's
mpc_endpoint_id field will be set. We can then use this info when an
endpoint is being removed to see if it is linked to the initial subflow.

So now, the correct IDs are passed to mptcp_pm_nl_rm_addr_or_subflow(),
it is no longer needed to use mptcp_local_id_match().

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9ee68ab4665e..042cd65d974a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -800,11 +800,6 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
-static bool mptcp_local_id_match(const struct mptcp_sock *msk, u8 local_id, u8 id)
-{
-	return local_id == id || (!local_id && msk->mpc_endpoint_id == id);
-}
-
 static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 					   const struct mptcp_rm_list *rm_list,
 					   enum linux_mptcp_mib_field rm_type)
@@ -839,7 +834,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
-			if (rm_type == MPTCP_MIB_RMSUBFLOW && !mptcp_local_id_match(msk, id, rm_id))
+			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
 				continue;
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
@@ -1448,6 +1443,12 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 	return false;
 }
 
+static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr)
+{
+	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
+}
+
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
@@ -1455,7 +1456,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	struct mptcp_rm_list list = { .nr = 0 };
 	bool ret;
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
@@ -1482,14 +1483,12 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   const struct mptcp_pm_addr_entry *entry)
 {
 	const struct mptcp_addr_info *addr = &entry->addr;
-	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_rm_list list = { .nr = 1 };
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
 	pr_debug("remove_id=%d", addr->id);
 
-	list.ids[list.nr++] = addr->id;
-
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		bool remove_subflow;
@@ -1507,6 +1506,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
+		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
 		if (remove_subflow) {
 			spin_lock_bh(&msk->pm.lock);
 			mptcp_pm_nl_rm_subflow_received(msk, &list);
@@ -1613,6 +1613,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+/* Called from the userspace PM only */
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
@@ -1641,6 +1642,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
+/* Called from the in-kernel PM only */
 static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					       struct list_head *rm_list)
 {
@@ -1650,11 +1652,11 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	list_for_each_entry(entry, rm_list, list) {
 		if (slist.nr < MPTCP_RM_IDS_MAX &&
 		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
-			slist.ids[slist.nr++] = entry->addr.id;
+			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
 		    remove_anno_list_by_saddr(msk, &entry->addr))
-			alist.ids[alist.nr++] = entry->addr.id;
+			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 	}
 
 	spin_lock_bh(&msk->pm.lock);
@@ -1951,7 +1953,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 
-	list.ids[list.nr++] = addr->id;
+	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);

-- 
2.45.2


