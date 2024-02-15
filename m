Return-Path: <linux-kselftest+bounces-4799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB752856C7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1EC1C21DED
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA66913AA53;
	Thu, 15 Feb 2024 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCTe4gVp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E213AA4B;
	Thu, 15 Feb 2024 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021554; cv=none; b=HaFZxdRYkjF3VmwyGoxMXsc1KTS777qFf3JSlEh/cM+9m5Djb1ZhTXCdikAWHTAN7deNLWHMJ8UvrGi8nNsgPGn+mEIoht4cZmu6ix1960H3MBjv0yW4Bi5L8lSsSDGG70cnFRQVINJBrIsTJvbzwMkOBPVW6AnaMBpLdB7gpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021554; c=relaxed/simple;
	bh=oQx74ogq8XEWhaDeCHKcAvhTLzjLFWuQ3CeAwMCbB/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sG1S54HCd+G795QWw7bTDf4yUo/FDu/PL/GCZ5JB39e1tEq/C6jzT9+Xaf3O1RS5GgL1+o6Y/hZREKfhSaufcDyfzr8i8R/YXH/l/buabKPR3kSWBtMc7FeXBX9B15MewObbVWlCi7/iThSqBhob4SVI1lDFfZHW5yxfqpmoZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCTe4gVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E495C433F1;
	Thu, 15 Feb 2024 18:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021554;
	bh=oQx74ogq8XEWhaDeCHKcAvhTLzjLFWuQ3CeAwMCbB/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rCTe4gVp3CgS+5NYJZPr8ydUw7L3eNImhP1pM3nXsljdmr7vQTt5G13VGoUxkJOZG
	 GpE9m4KEb/6rFifYRfV5YnV6zqzFRYM6tYEpvkB08CV1iLkMf3lt9n21UO8I5yRWaj
	 DFY7cvTDmfqh25od7keu8vgT/8nfXa5eVLv112XPZFf9kZnoOzYsz/nJySITFxt3hx
	 AqfKossX4NslglEexcO0dExXsBEIB0xJ2cHYPeyUjOjfwyZTBwE85X7X0ylkbm+vt1
	 SnNCbpMDMuApQWMT/iyohC3AbD+7waZPDqEL3ItlmO4JENvN8apNqbW7uGgY0lzFy1
	 68dCT1yp9qlmw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:32 +0100
Subject: [PATCH net 05/13] mptcp: fix data races on remote_id
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-5-8c01a55d8f6a@kernel.org>
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3453; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Phzggd1e3xH9VcpIMW2JwQ4VlATGqfBwFCcy2ByLV7k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcc5DkIVpcVyJl8wBeZ/NcTkynzax2nJW0c/
 DoLIIyEekGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHAAKCRD2t4JPQmmg
 c82OD/4xprG1PGn0dVQ5wAZz0Pt56+fB/JkibVoLaGb448l91a7iJJCAs0BW3CxGW2KdxjbSKLZ
 geqGcWFges6Hv3MpOr/Iklulh10dsdWBKf9pYTt5fj8miEgtV9VJcJBb8TP0ec2wzlXv745vZim
 dcK+cxLtxVa8ulu5tJULQkdVehYPTDdNU1a+u4ujKgot4sIPDSn1Twk3QSbYxRyOv1JqTZ4Clla
 Y3GDLj+WPAT38Qx9Ayapb6l0Y9j6pX3+qR7bAgyXyK75m0cjP00UOH9+C7ekmwRdZqVOzDcAJC5
 ArKPNcrVjXKaYNsj6jDQeYnKJ5S+sSI320PwzQCUuXMYmmLqmI4MJkX+AhNWXSj8CWKEpDkit6B
 pj6doKqX1/iFLhxfI42twmMNGOGLANGjLyXl8S0kr2uKEF/p8/5wOZejEHyHfFdl04m+rWU9kda
 WA2qjDdq+VlGGNhJ4xpxZ8AP4OykPEzR6lLf4oYgNrUMrwLlPbb2EeSkwD//MKn/hymcxG9t8lE
 xZ+i5hhdZKYASKtNtuHJzyWYcYWar3/UBnNEo89Z9RrkJbH3vSXIfw2tzxG0+sAF2fDpCr8Z/o7
 MbKNpN7EVQSMTsInf7sc/tPir4tCYtwABMCeI01//JD9tmATYW23r1vH4zsraaEBs6XSrIYYBL5
 LSJubHk7NEqp4zA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Similar to the previous patch, address the data race on
remote_id, adding the suitable ONCE annotations.

Fixes: bedee0b56113 ("mptcp: address lookup improvements")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 8 ++++----
 net/mptcp/subflow.c    | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 912e25077437..ed6983af1ab2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -443,7 +443,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			remote_address((struct sock_common *)ssk, &addrs[i]);
-			addrs[i].id = subflow->remote_id;
+			addrs[i].id = READ_ONCE(subflow->remote_id);
 			if (deny_id0 && !addrs[i].id)
 				continue;
 
@@ -799,18 +799,18 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+			u8 remote_id = READ_ONCE(subflow->remote_id);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
-			if (rm_type == MPTCP_MIB_RMADDR && subflow->remote_id != rm_id)
+			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW && !mptcp_local_id_match(msk, id, rm_id))
 				continue;
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
-				 i, rm_id, id, subflow->remote_id,
-				 msk->mpc_endpoint_id);
+				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 015184bbf06c..71ba86246ff8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -535,7 +535,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->backup = mp_opt.backup;
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
-		subflow->remote_id = mp_opt.join_id;
+		WRITE_ONCE(subflow->remote_id, mp_opt.join_id);
 		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
 			 subflow, subflow->thmac, subflow->remote_nonce,
 			 subflow->backup);
@@ -1567,7 +1567,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
-	subflow->remote_id = remote_id;
+	WRITE_ONCE(subflow->remote_id, remote_id);
 	subflow->request_join = 1;
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	subflow->subflow_id = msk->subflow_id++;
@@ -1974,7 +1974,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->fully_established = 1;
 		new_ctx->remote_key_valid = 1;
 		new_ctx->backup = subflow_req->backup;
-		new_ctx->remote_id = subflow_req->remote_id;
+		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
 		new_ctx->thmac = subflow_req->thmac;
 

-- 
2.43.0


