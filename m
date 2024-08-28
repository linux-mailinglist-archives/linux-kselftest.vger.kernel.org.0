Return-Path: <linux-kselftest+bounces-16507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A89B3961F5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C05287BD4
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D11615B103;
	Wed, 28 Aug 2024 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5/+9co/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970C15B0F8;
	Wed, 28 Aug 2024 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825696; cv=none; b=suN+ApDwzVnB8mYfZB6Yhf8vY3wt9cdcJE8Tv8b8MgwsnYE5iMThFW2j2FBrSktvUeCv1oQE/SJXqx7fvCSTfkvR1PFdlSwH0VWRnuqG+lzcJKdvspLm0F5nCbi8V8+mEwl6cQn7ACVIonGduN87UlP9lObg2tJoSbk9NslJKOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825696; c=relaxed/simple;
	bh=T6SFDsF5FaPC6VnjZh/IuWMsfOwbCw+rgAtK7pLX1uA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYq31yiORDBJY2CRN0Vc3bBfZ1+JPkFhFmLLYvc/RwggY6xxKwEQhYnNZwzFVHKKE0fUYzY4j9VyBRCdmoeGp6HVpKadwy7cuYDmvDyspbN1xlHBc8D4W3+dy2a3qnvxK+PZdhRUr/EOFNfDNxXaQWPT+Ogp8GnuCNV/u3902AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5/+9co/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E591AC4AF62;
	Wed, 28 Aug 2024 06:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825695;
	bh=T6SFDsF5FaPC6VnjZh/IuWMsfOwbCw+rgAtK7pLX1uA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t5/+9co/gV0YO2WLAruhndG/wOpT9etFhmi+3SiPOfQk9hCox6SnxgJAkFMUB6HSh
	 GRwffqlaL6bMnnNfZrJZ1az2244KHzp7G7lvXz/CNBz475ME28nqDk9nJCjW0YR6TP
	 Rf7obIKZGO+ZBzO/wrp8z/A7/Tt/kQh/YP7LEE/p6NSX/gwZfkZMecY3GDxZgPNWne
	 pvfEID61OcrDz49iXl7nIKJ1wmv3y89Yhr2/C8Pza76McuIN8xfFm1SyUeUIz/t1H+
	 oBUlp/ABQtEHBwaoSnRQA4NNSuaS3dDxpO+7oXfL1ZqeLLnCAd+DNUHj7CIyIa/z82
	 ovukok9SzT9Eg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:29 +0200
Subject: [PATCH net v2 06/15] mptcp: pm: reset MPC endp ID when re-added
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-6-7f11b283fff7@kernel.org>
References: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
In-Reply-To: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
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
 h=from:subject:message-id; bh=T6SFDsF5FaPC6VnjZh/IuWMsfOwbCw+rgAtK7pLX1uA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBHf3U/OHnlSa2s01CAn3boHlTP4WK6fCLGL
 7tRG5y5/OiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 c3uqEADLkUX4Pl7IWwDTnTj5NRMOFvsQAHofmOuct3dFVF32hYaTAsIeFtdnGPvxEgnhvu+SFfN
 gmXfoO0LXo1LN0cPeH8ilICezFeKseR3zM6UVZJ13Hl85McC5ZvmFH7sqvd3A7YUG1KKlXZtjat
 jfEAgzZsPkhsV8ECsRQlaKQwrDIr6hFWmzM4Vg1S6+JB1vdhpHc/lBzReZeER/lidcclnvjOEG7
 jgsT/Ae+ZKat0MApLg/JQ0fAk14yphU8byoQRGHi1I8FhtNPYAOPzZ7OTVcJ3tk7DCgnNPhujmw
 tnFW9/SY+mgClxyzxGnlBQlkY3CE/wpLJTHek1+TNoFjCVzZSJernqX/CTN8q/AehWUPHJZTK8u
 BSQD/3c6UhBCjIQnbn+nf8nAllUIS3csfE9IIony+B73VgU7YWe/3Nitvnzsi85nEbluz0HwYlq
 c2tETm8Q7sU6WFoX5Mvypqsk4aqXd+evnxRs0vvhpEt1PQdGNxoaeSwm49Ez2p3bqfOjuDLSzKs
 U/hKqjaKyVdhx49/BJiCNqVe1pOazauLLOHT5eURbcM+msV0HDjBh1JhwYaUyq75pdhKryTAcP3
 HCmw5K9L3eZQLUbszBqonweR35psNx0ftv305H/ynPAoPEG36XV5tmdGAhbCqzTKS7/W+w1tVar
 RDekbZRJOrZE8Zg==
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
index 0134b6273c54..5a84a55e37cc 100644
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


