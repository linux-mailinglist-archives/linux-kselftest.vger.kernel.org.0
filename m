Return-Path: <linux-kselftest+bounces-16300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4207795F5CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35FD28356C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA52198E89;
	Mon, 26 Aug 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdfjhA8I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD66194A66;
	Mon, 26 Aug 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687984; cv=none; b=ZkKb9h5lLmlBmOWp5oU0Gq9vVp+9qmrVw8TpyUd5ZFUkoTCcYbKYC7YyWmYA/IzmvdXqR4D2vL8YAaRp9+rJrgE0IwwiLrNGEib1G0cG3vrvjuNSNYVWTQXlkwEVjR187ne8Yx0dHQkY+Sx8cG7BL+9+43ko2nby5gN41xHvacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687984; c=relaxed/simple;
	bh=evwo6kbXTHDvZL769kxqmKta9GRw5JkELgYU6vCVGTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CAgxWsUAO6Tocte+7je1iaPslq9OD7oWEC/7r6ciyVIRf5gff6a7QH9AiQWfFFy7hVavy1rmgFSf38xyK6fns0FANnGjzmdJYI6L/RZxKE8gZiZriH4kqRMzo2jjrJl4GVI/HPN/SnVR8Rv+b4xedei1fg9l5wxvLdRiv4OW2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdfjhA8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03358C52FFB;
	Mon, 26 Aug 2024 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687984;
	bh=evwo6kbXTHDvZL769kxqmKta9GRw5JkELgYU6vCVGTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rdfjhA8IFap889T4R0aqp6ytsL80CZR2hG2R9NJJHrsU1NSo5ebNTDF74aBBEmGnb
	 rhJ4RW8JjjYSLheFTwr1WggpanVQ3z2RKiP30LEHK8mZ8VP5PYdb69dIIXjXsXTZgG
	 APp/Z06jbg6gv8KCBRFMkwgsC9CPkhzPyGjgJNOscvnwyYh+i9AduqK2w/cqM+Rols
	 b4DNlcdopxxppp4I6nviybG25BrS99d4hDvsmQdLsOEZhJzDWA21/DMUHt6VylkdGF
	 gJVKZdMjwYrDXowbTl4T/Rdxm4TXQhDMfOstugTj9N42j7B9982BfTGeyGIbLbHFMI
	 TBJlcHpxNQ5sw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:05 +0200
Subject: [PATCH net 06/15] mptcp: pm: reset MPC endp ID when re-added
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-6-8cd6c87d1d6d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2747; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=evwo6kbXTHDvZL769kxqmKta9GRw5JkELgYU6vCVGTE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZWYkb3Qht76vaqFIznBJhEkvbhiRhVBBksC
 favBpVW/LeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 c4qbEADpqnsFuioTV8gsm6wgxr/41NoGprPllcop9cJXy3NnvBRBkdQRxnyJfzA/F72gWrLJs4A
 5wX0L40SEyGMmh7PiOYX6LyTZkablCgGDoTk3KA8xr0F53u/x7jk5EvlFXK91F/RsW6Fhdhtj/o
 xI0yuqXZBu0cJc1ygwWf1TV9BvQ/Pt7hABne+EEaYz9GIsOszDQA9J5Ez47rCHvoPXDk9BaUIui
 JAyrgLDbYMkjZUmwSdKlfekQH9vRWo9d21/08L8EEK+KTr0KRoQm9wZIAYOv5vlDnN4jIJo9LoX
 xOhGuCauvnjLLIqToDvFF9uP8fomplCCjbwm9BZQu6ygJNLoemqol5G5Fwy/V7OS/ONrJlaylws
 a1caqStuRVGqfiwLg7V6EzifDCtdugXNgxLtJBwrncI7hMjFbvEgxpJs47ckX0BpY6sa+0ijgcf
 oaBQE+C0d4OfPT30d/HqB10jyRKE9XYn5IO1TWeANqsoc9gON1Ocy73i/ZsyaSnuKJ4yWw9aK2Q
 8RrCT2H0sht1oHyIcTISr3SDc2HC55MjFKahs4AknwhpaokmAwzvJgLOIH1hMNqrakotpblgKLD
 2RTiGJv6V31evoS1g04TflH+wo3frSGD//0VC12RbrbEnL66CQibZ6vKadmjkXyXQAL7DpYoW57
 Flw03PKO+6KerFw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial subflow has a special local ID: 0. It is specific per
connection.

When a global endpoint is deleted and re-added later, it can have a
different ID -- most services managing the endpoints automatically don't
force the ID to be the same as before. It is then important to track
these modifications to be consistent with the ID being used for the
address used by the initial subflow, not to confuse the other peer or to
send the ID 0 for the wrong address.

Now when removing an endpoint, msk->mpc_endpoint_id is reset if it
corresponds to this endpoint. When adding a new endpoint, the same
variable is updated if the address match the one of the initial subflow.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0c91d961f51f..75c8aede7026 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1318,20 +1318,27 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
 	return pm_nl_get_pernet(genl_info_net(info));
 }
 
-static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
+static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
+					       struct mptcp_addr_info *addr)
 {
 	struct mptcp_sock *msk;
 	long s_slot = 0, s_num = 0;
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
+		struct mptcp_addr_info mpc_addr;
 
 		if (!READ_ONCE(msk->fully_established) ||
 		    mptcp_pm_is_userspace(msk))
 			goto next;
 
+		/* if the endp linked to the init sf is re-added with a != ID */
+		mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
+		if (mptcp_addresses_equal(addr, &mpc_addr, addr->port))
+			msk->mpc_endpoint_id = addr->id;
 		mptcp_pm_create_subflow_or_signal_addr(msk);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
@@ -1404,7 +1411,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out_free;
 	}
 
-	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk));
+	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk), &entry->addr);
 	return 0;
 
 out_free:
@@ -1525,6 +1532,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 			spin_unlock_bh(&msk->pm.lock);
 		}
 
+		if (msk->mpc_endpoint_id == entry->addr.id)
+			msk->mpc_endpoint_id = 0;
 		release_sock(sk);
 
 next:

-- 
2.45.2


