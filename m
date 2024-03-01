Return-Path: <linux-kselftest+bounces-5762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FCA86E845
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B23AB29D49
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063303FE2B;
	Fri,  1 Mar 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nmf2yNpu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB63EA95;
	Fri,  1 Mar 2024 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317148; cv=none; b=cbRc1SOsy4jMcle5DvajSBKLr4sXg/C8At14W53XwLJpAyd6MiI+tXRn2bIVGNtjwB2VTzBtsX9UGcnV+KOgEC3HAR4E11ndMSoW0z+kCCzFNOrjRwE91blMqKzzh73HSarGRp1202I3W4Q53P7vr9H21RY12A/MdTQvKkSlD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317148; c=relaxed/simple;
	bh=tHamsSu2PawSNJB14dKAoQh031PkcNlcqRe8m9+N4mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E6S57sNVpi65bDQSUfZqFOHFLQyLL2Y08lKrM8P5464p2fVbxJI6rWC/zf8y8LyRc3K9M6YJlN/u2RrqoTBLcU58PNjT14cHgnhmXT5PeU+9tMocuHPxizT29XheP7T6aPMQVfEOurIt0bJhBnRPBpkaXIJNCEKA+YxIkYfrnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nmf2yNpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218B8C43390;
	Fri,  1 Mar 2024 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317148;
	bh=tHamsSu2PawSNJB14dKAoQh031PkcNlcqRe8m9+N4mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nmf2yNpujL2CHG661S5q7iJdLcHamibB9G2a5K33DMTKqnxKmm6fOrxxfpnNcBvEr
	 9bbQdwHvUZ+Ll8fCUX3fvqeT1xX1jbgeYTB6D2Q4wzwFoypR5fldRNdyHL6c8jbhJx
	 8la90ah2+OOV565Z/3gtGHwQvoi5L8b1mAyVMhKCGZm0wFBCI+h31Hqx6YK/q6y0Kr
	 jL85E0CFl1BRdGtgKrEeTGOW2y7rdbI6lFRzQ0pgDnEmx26WQtWGrHuvYGp8SKMBVh
	 8BrQRp1CpJxBuIiAz5d8eVyCTHoOT+a2kDscxOU+CWK4449HnDrXvLe652W04zdUQH
	 FbhIKlDKrZUvQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:36 +0100
Subject: [PATCH net-next 12/15] mptcp: implement
 mptcp_userspace_pm_get_addr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-12-dc30a420b3a0@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3385; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XPYkNYFkRqDS+13nMn34SF5wNQUL95yNz7wdaGXQ2tw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv14pbx2noDI54Mo4L2YVHo34EtkFMByEi9M
 E9TS62MN92JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9QAKCRD2t4JPQmmg
 cyc1D/9R+4npbNXeI6GHXHnqxjS7MlLAgkJv6RXNzICibMNDOPUQzi/SBC0j8dCMwTka1bOqYCz
 zSRZOnNKL80pYLxVQ+qgjYYNDoo5NkbX5sRBb4Jp4BdcTSLVC/KcVxdMXqRx7HmSo1swqf7EYs9
 GxGHJc3NVLep7oq77qlaycUE0Jq452W46yFrpjvbynf7BgpKi6U6qoTBdoGl7vS+RLnKxFg1rPv
 hihfxbbAis2pst6aQfi7IjCJlTzyh5v9l2RBBk/m52m9tV7Kq/B99s4pKMe6IVf3zniuAvXlSwu
 06+Hox4O1g8uTeGrhZ498TjPW4GI3nthvQ9bg/xrPNWQaKB+dWy8EZh03lMoK8oyD6gBN1Oi4s+
 Ae6zq5rIJPLxkqDA3g2WKyPwUCDUNDU8o+8ot7FblQxb0IuoN4NLndvcdwQmk2BAYFDMLl4l4Fk
 Ks7+Sd6oseNHdk2jMxE3nZPakmHN5Pe+9su/pRBohHHWGB0dBSwiOvCSX1GXmO/CqaHB3HeFYo3
 GCRG1xQpKP5GZaRTY21AeQprLZt88xqTnwF2wjBCT/+Y0IKpvVfLUbKL/s1f6Odf2EXNi+k9kzT
 zGbUA8av9eMv9ZG/INYIFyHEuS1Krz/9MarP4CAOcJ/ewhb2nBHa5+9cSkZtCzGxZElUsX8SUSa
 rwZzz0pz/6fPSwQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch implements mptcp_userspace_pm_get_addr() to get an address
from userspace pm address list according the given 'token' and 'id'.
Use nla_get_u32() to get the u32 value of 'token', then pass it to
mptcp_token_get_sock() to get the msk. Pass 'msk' and 'id' to the helper
mptcp_userspace_pm_lookup_addr_by_id() to get the address entry. Put
this entry to userspace using mptcp_pm_nl_put_entry_info().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 76 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 20cbcb62cd8c..b9809d988693 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -638,3 +638,77 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	sock_put(sk);
 	return ret;
 }
+
+int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
+				struct genl_info *info)
+{
+	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct mptcp_pm_addr_entry addr, *entry;
+	struct net *net = sock_net(skb->sk);
+	struct mptcp_sock *msk;
+	struct sk_buff *msg;
+	int ret = -EINVAL;
+	struct sock *sk;
+	void *reply;
+
+	msk = mptcp_token_get_sock(net, nla_get_u32(token));
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+		return ret;
+	}
+
+	sk = (struct sock *)msk;
+
+	if (!mptcp_pm_is_userspace(msk)) {
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		goto out;
+	}
+
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		goto out;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
+				  info->genlhdr->cmd);
+	if (!reply) {
+		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
+		ret = -EMSGSIZE;
+		goto fail;
+	}
+
+	lock_sock(sk);
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
+	if (!entry) {
+		GENL_SET_ERR_MSG(info, "address not found");
+		ret = -EINVAL;
+		goto unlock_fail;
+	}
+
+	ret = mptcp_nl_fill_addr(msg, entry);
+	if (ret)
+		goto unlock_fail;
+
+	genlmsg_end(msg, reply);
+	ret = genlmsg_reply(msg, info);
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+	sock_put(sk);
+	return ret;
+
+unlock_fail:
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+fail:
+	nlmsg_free(msg);
+out:
+	sock_put(sk);
+	return ret;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 69338a6c040f..bf708ddbef5f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1047,6 +1047,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
+int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
+				struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {

-- 
2.43.0


