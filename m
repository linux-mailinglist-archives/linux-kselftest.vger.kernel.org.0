Return-Path: <linux-kselftest+bounces-4798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AFC856C77
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075AB1F21A18
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BE413AA2F;
	Thu, 15 Feb 2024 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8nXVTuH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A613AA29;
	Thu, 15 Feb 2024 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021551; cv=none; b=KuGeM0+4BfZ/v3gJdIt2oHI/Gve7JUjwbYHlGaN08z0vEz+9U7JgfreTSni0ZQfIZ97ieC51/GEa1/QW9gYgoyRlqP1b+CNIEXO4wckRBGHnOllcud/iE77W1ABSlHjET2KDxEwED3+dZ3HYvXPfPtIYVDE2y0+j/7+6aLh8m4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021551; c=relaxed/simple;
	bh=OHtghzBpai6zL2VBEImfx8tJSSEJN0SuOVGpf6g87y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e1HmhzD+jFdMpH3fIUcednxKn9ndSuAmxEjNAeM1yO9cl8Ee6x+MuJANx/uQCnysv5sjKVA5cOCrVkRI1Z7CaFCxfgrRWPYZ3+7/HB1Uc5Me/n8fQbOw6pgUtnK1AYRIqRDZ3p1OC6nUw604VrBdUdBTt+tyT2C3w7m3uSJdRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8nXVTuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD19C433C7;
	Thu, 15 Feb 2024 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021550;
	bh=OHtghzBpai6zL2VBEImfx8tJSSEJN0SuOVGpf6g87y8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d8nXVTuHEcmJc0wuMqrJT9PEUe0JeYBdXolJvpe/onsVgYTiZXl7OdcTKZW8ifJbW
	 2tVN3tUxqfFl0xsnub+tdaR5LqAx/rUwEJ1NFtLsYYPfUJZrJRpWSpt/iJHcj9d9yG
	 laoHgmL8BF5JddBolcPRKkuFIjayD+KYnL6xwf6iSqZZ5AMiHGDn4AgfevJPGyL3Lp
	 dHjrTUuE+p8eTSWyWGAsOLq6rxwNErIFghDz++rt3Mi4RGwKRIqlrtKE1M9WbJ9Bzr
	 mve1wBi6NS0s4wPo+90KMvskpssw4+UAgZg8MOTBLaa/QtPHPUCp/DRzS6Wpic/Vq8
	 +E6zjd6ljI2Ag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:31 +0100
Subject: [PATCH net 04/13] mptcp: fix data races on local_id
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-4-8c01a55d8f6a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7176; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=quJW5M/2G3Dvm2MZlUXMbs6cwclKCNyj5WPf/FoK3+8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlccY2QNT2m5csL7F4Hv6Z6DwUiZ5TLSiT8mE
 7GCwk7wb8CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHAAKCRD2t4JPQmmg
 c1yPEADXvkRaowUNS1xsIgh5+vrKxrhXCwkih+1XPBw/1XTjLXcxo+i8/Pr0hJTxoc5kYCAH3g+
 NXrnZmhTa6QhySQc05+jJKKDi7Eqjuz1uYMa3LzoklvX18qAmS7Vt8HU8qZUMgSCYwXmYj6Yto2
 Mcee9p6oycYOaF/LzOc8K136wNoUp7pels/MsgEwnaZ7EjqKJa9J0ZU2uaOojBf2OqmLPA19sgu
 4j2LfMgoOeVCWwdnGofrwxRqfdCRjVQpConMrvHnCXgM1EpvCdbZXEUZL/rQL4jaDcqNh13FpCj
 ubQDTtReTKiKu6+e9r+39OQ4zHdsuscyFSh/2b0FN4cFMkicTPQ51mXfQfpBnuoiJ7JxmrCkyIw
 VUgoZRTrkbCJHlvoMxaOYSELfOHqCyTM2+G5/nzllThDhgB4imjlC5OZtoNF5evC/VowozMnMtb
 dS6EuSnBnHKfKGhWuX2qTxyFCFhaNmK+iNFABYt6A7qiYjANaeVSm3sMExpi97JrYDDenJosTw5
 4FEN5wi2POdV+9kgzohs2AFg2NW9Sr4GXUheNlK+AGUeFo8hDmseGb67EPfXCpz0d3+d4hHbOlq
 0nPN+WyDyV8Ky3+5nxdtTcQsZYbuuQ/NcmnGRPPikqSSwhrV5W7oQBw80OmbBeevUJO7wNZJn2F
 aH0AMEViEYUJkSg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The local address id is accessed lockless by the NL PM, add
all the required ONCE annotation. There is a caveat: the local
id can be initialized late in the subflow life-cycle, and its
validity is controlled by the local_id_valid flag.

Remove such flag and encode the validity in the local_id field
itself with negative value before initialization. That allows
accessing the field consistently with a single read operation.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/diag.c         |  2 +-
 net/mptcp/pm_netlink.c   |  6 +++---
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.c     |  2 +-
 net/mptcp/protocol.h     | 15 ++++++++++++---
 net/mptcp/subflow.c      |  9 +++++----
 6 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index e57c5f47f035..6ff6f14674aa 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -65,7 +65,7 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 			sf->map_data_len) ||
 	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_FLAGS, flags) ||
 	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_REM, sf->remote_id) ||
-	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_LOC, sf->local_id)) {
+	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_LOC, subflow_get_local_id(sf))) {
 		err = -EMSGSIZE;
 		goto nla_failure;
 	}
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a24c9128dee9..912e25077437 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -800,7 +800,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
-			u8 id = subflow->local_id;
+			u8 id = subflow_get_local_id(subflow);
 
 			if (rm_type == MPTCP_MIB_RMADDR && subflow->remote_id != rm_id)
 				continue;
@@ -809,7 +809,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
-				 i, rm_id, subflow->local_id, subflow->remote_id,
+				 i, rm_id, id, subflow->remote_id,
 				 msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
@@ -1994,7 +1994,7 @@ static int mptcp_event_add_subflow(struct sk_buff *skb, const struct sock *ssk)
 	if (WARN_ON_ONCE(!sf))
 		return -EINVAL;
 
-	if (nla_put_u8(skb, MPTCP_ATTR_LOC_ID, sf->local_id))
+	if (nla_put_u8(skb, MPTCP_ATTR_LOC_ID, subflow_get_local_id(sf)))
 		return -EMSGSIZE;
 
 	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, sf->remote_id))
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e582b3b2d174..d396a5973429 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -234,7 +234,7 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 
 	lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
-		if (subflow->local_id == 0) {
+		if (READ_ONCE(subflow->local_id) == 0) {
 			has_id_0 = true;
 			break;
 		}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8ef2927ebca2..948606a537da 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -85,7 +85,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	subflow->subflow_id = msk->subflow_id++;
 
 	/* This is the first subflow, always with id 0 */
-	subflow->local_id_valid = 1;
+	WRITE_ONCE(subflow->local_id, 0);
 	mptcp_sock_graft(msk->first, sk->sk_socket);
 	iput(SOCK_INODE(ssock));
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ed50f2015dc3..631a7f445f34 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -491,10 +491,9 @@ struct mptcp_subflow_context {
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
-		local_id_valid : 1, /* local_id is correctly initialized */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 9;
+		__unused : 10;
 	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;
@@ -505,7 +504,7 @@ struct mptcp_subflow_context {
 		u8	hmac[MPTCPOPT_HMAC_LEN]; /* MPJ subflow only */
 		u64	iasn;	    /* initial ack sequence number, MPC subflows only */
 	};
-	u8	local_id;
+	s16	local_id;	    /* if negative not initialized yet */
 	u8	remote_id;
 	u8	reset_seen:1;
 	u8	reset_transient:1;
@@ -556,6 +555,7 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 {
 	memset(&subflow->reset, 0, sizeof(subflow->reset));
 	subflow->request_mptcp = 1;
+	WRITE_ONCE(subflow->local_id, -1);
 }
 
 static inline u64
@@ -1022,6 +1022,15 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
+static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
+{
+	int local_id = READ_ONCE(subflow->local_id);
+
+	if (local_id < 0)
+		return 0;
+	return local_id;
+}
+
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c34ecadee120..015184bbf06c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -577,8 +577,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 static void subflow_set_local_id(struct mptcp_subflow_context *subflow, int local_id)
 {
-	subflow->local_id = local_id;
-	subflow->local_id_valid = 1;
+	WARN_ON_ONCE(local_id < 0 || local_id > 255);
+	WRITE_ONCE(subflow->local_id, local_id);
 }
 
 static int subflow_chk_local_id(struct sock *sk)
@@ -587,7 +587,7 @@ static int subflow_chk_local_id(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	int err;
 
-	if (likely(subflow->local_id_valid))
+	if (likely(subflow->local_id >= 0))
 		return 0;
 
 	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
@@ -1731,6 +1731,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
 	pr_debug("subflow=%p", ctx);
 
 	ctx->tcp_sock = sk;
+	WRITE_ONCE(ctx->local_id, -1);
 
 	return ctx;
 }
@@ -1966,7 +1967,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->idsn = subflow_req->idsn;
 
 		/* this is the first subflow, id is always 0 */
-		new_ctx->local_id_valid = 1;
+		subflow_set_local_id(new_ctx, 0);
 	} else if (subflow_req->mp_join) {
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->mp_join = 1;

-- 
2.43.0


