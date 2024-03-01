Return-Path: <linux-kselftest+bounces-5753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A449786E823
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D101C22B39
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A6A39FFD;
	Fri,  1 Mar 2024 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBL3jIEM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC43AC25;
	Fri,  1 Mar 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317122; cv=none; b=ZPA+e0nx1WBHWsTH0fYrolcwjriuM2CQhxmp2hGZRv79oEjnZdi+7FFjFN8O0dYwgsikQCjjAQdP4oQSPByPv8X1aPdh2xRjmscXEK2JwshhTEdor3F0fJvyBIOtEIQzM3Rg1oFn/sXj6DC/1cml9X4DZFdlHB1qLAAuPpXgxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317122; c=relaxed/simple;
	bh=2J2ip4Xxu7bYBw1bsYGLEY/qmSglztaVCRJZDa8cTFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIxKWBIY6cW/Kycx99G5WQEIboobVTma1Tk9VxujkTto99e8Pye1mo8osCGrDgJWlVhyyvKKImRDHL47C23fu2DDUxaSPlaukDti3OGAUzOpbQcVhuUUOKbRX2Bcb9Z6XE+juJ7GEN/C3GCpnvcEa+2/ad09yMsNyGlzYgHyIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBL3jIEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E06C433C7;
	Fri,  1 Mar 2024 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317121;
	bh=2J2ip4Xxu7bYBw1bsYGLEY/qmSglztaVCRJZDa8cTFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EBL3jIEMDupJt9hn+0oMCPPa+NAKGt32Zvd+ptBOUooQjGWN7+3nQxpnJTi3C4vah
	 EUrC5AYcN9qYSAyaom1hP3OWNkDGpco1iOL/+HPqymvTgfpOQdbITve62rLQnYzBXw
	 d1ToOYhMG74oYVunmZ9YG12YmSgOMp6viWjH+VKTYYhNIz4Tht+mcn48VC6tsKjw3E
	 aD2FZ5Iptqq2B6F5mB/KlMqdb772j0LDq9thNPFlEnKfAKH9bx3h9KkCmYMsq5ml9g
	 tgwBNcXXRUbL9n8sO5PdZ2VF3piakXkgzYcv3DR11wWa9LNGPwe4588LB8iwR3Xi0P
	 D54ez0Eg53G+Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:27 +0100
Subject: [PATCH net-next 03/15] mptcp: implement
 mptcp_userspace_pm_dump_addr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-3-dc30a420b3a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3ItNwH55x/xaZ+UgJN8s9oLJOd5rmW4EkNP6do8rk9A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv06y6c4NEIWAkCUt6adgLqaRXfjgFtRrupc
 RFHEMFnP8aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9AAKCRD2t4JPQmmg
 c+MtEACwhMfbqpbW7+htXjcxOM3D2r+x3zW5A0+BdS4NXpHXkLKKvSQxufbUHaJm8knD2QsGgGM
 4mX7eAH/ZJFn+VkY+KcEhCf3dnFBIUu/Y7TpwufUddTViKMrFDya3s6hWv+MNBw8aKOLB6U0e2e
 JmpNyP/WDnZSIqUMB3Kfur32DZ5NcLRZT9ymLsRx6RxFbNgbj7ZZA+ijTuDE1suwqs7jr6NFJUj
 CuJKWkfFHso8HnJNci3AryGXnMZZQFXnAiHUvEec5+y6BYcj9uyxc+Gp4gKEq5Il5V0ABkdJqSU
 cOihZsWTtFBLS6yDWj5ui1mf7zAynKtzLI4dD6Jivw0zbG9qoZs0AfwbXyUZQnXGpJ5KpzzjxtZ
 YI3zctcbXjI+W+Eb5QCFtSi2OQUl2GGbIW+EM+i7VWXrbpuNCTFpwIM/4MCjAsXsfjvOf8i7aqf
 9MXBwOf9mhFkXEpPZutBYK9L9dPB0hLkqhEbt74yp95EZm2bPMZ2E47o7QFXKHuwOp8SdfQIU0Z
 Q6bOc74yyOaRNAigjRtnB+Zm2IrEQ+vZuXJQMxjBE4RWfgTfZF94Ozly+AG/9gbW47EPn452Z3/
 ENAe9iB1En6HvqbBDtms2Hik0qjCT7io1pTo/kpX2DhpcRvrJjSiGsX3eywBWRZAbCI06wuu99i
 Y4YZe5ED3dkCb/A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch implements mptcp_userspace_pm_dump_addr() to dump addresses
from userspace pm address list. Use mptcp_token_get_sock() to get the
msk from the given token, if userspace PM is enabled in it, traverse
each address entry in address list, put every entry to userspace using
mptcp_pm_nl_put_entry_msg().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index bc97cc30f013..d6b7be3afbe5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -572,3 +572,63 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb)
+{
+	struct id_bitmap {
+		DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
+	} *bitmap;
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net *net = sock_net(msg->sk);
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_sock *msk;
+	struct nlattr *token;
+	int ret = -EINVAL;
+	struct sock *sk;
+	void *hdr;
+
+	bitmap = (struct id_bitmap *)cb->ctx;
+	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
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
+	lock_sock(sk);
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (test_bit(entry->addr.id, bitmap->map))
+			continue;
+
+		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+		if (!hdr)
+			break;
+
+		if (mptcp_nl_fill_addr(msg, entry) < 0) {
+			genlmsg_cancel(msg, hdr);
+			break;
+		}
+
+		__set_bit(entry->addr.id, bitmap->map);
+		genlmsg_end(msg, hdr);
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+	ret = msg->len;
+
+out:
+	sock_put(sk);
+	return ret;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d70fb3bf5076..ab9c8004eb56 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1042,6 +1042,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {

-- 
2.43.0


