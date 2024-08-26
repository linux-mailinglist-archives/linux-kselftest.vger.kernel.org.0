Return-Path: <linux-kselftest+bounces-16308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D56095F5F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6561F21D3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DD819B3C3;
	Mon, 26 Aug 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evCq5GcZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880551957F0;
	Mon, 26 Aug 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688013; cv=none; b=LAYlqwla5g0PHD1aCMKGYvsUXEZKo4ETs1TSTVSWKvI/AlSDfZoCpM8NC6ZOawAbye+uw+ZEwd+RevrrpUGREuMmdc9+2d6RO4Js5KSYfcl+FcHmbxgf70umM5PneYqRqKMCrlsuAZeVziCqewcCclHTj9eGNCKTEEr0IIiD5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688013; c=relaxed/simple;
	bh=HGVeSxEulKGiClhby5tzwf1iAGyaIukOorl21Lj+wJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vmfd2ebzctSoLqQyN4lbNRAmWLosNhQ1/rfMBZdWQrVl38cMIUsiqzq0D5sc6IZuDQXz7gv19jqkcG5P1Alt3WzKE9pJZG5Ut8QEZM6r1d5fkCDaw/PS5TwgHZpvXGHHOaVLWM5UL7hIyxdyBLUuZwVBufnaNHBNew/8Av3y+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evCq5GcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09559C4DDF5;
	Mon, 26 Aug 2024 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688013;
	bh=HGVeSxEulKGiClhby5tzwf1iAGyaIukOorl21Lj+wJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=evCq5GcZgDEaReWkuPWgSdSox2U+siWUvVEkYx0QbpDfLOrapnwlfeRtdvD9kZRQd
	 cAfM4hiZb7C6E6THP7WFYW1qqIp8Wsd3e2YcqQBf2O4jsmr6AWc76i6fqkrXjMhSCL
	 6NaLZ2QpDN7Q7CrJAc1XZCKREwuQiIFyYhK7WTlur5GN1Jar0m5C+cH/Ftbn6BLooy
	 n42p3gkMxcrSCDYuMGMZlxqd4hVqNvVwh0y3tEoEZRYkcwF4GFMhqbx+0wf2Of31PO
	 OqbsIYlRpJlQIEpeS9JaiAzmTqSxZ11Z2D1/B3rgVjQ69CQFK4MlMnR0gWjI/JEkVL
	 /X75Em1wgTLHA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:13 +0200
Subject: [PATCH net 14/15] mptcp: pm: ADD_ADDR 0 is not a new address
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-14-8cd6c87d1d6d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3331; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HGVeSxEulKGiClhby5tzwf1iAGyaIukOorl21Lj+wJQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZWN0lGhwYo2NLKz+xXFYlkCtxV23bPFves4
 hykP412UISJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 c18xD/0ZPHtQSOGIz6dWWtxiDac50V0cDztoUx1rkMEU3VX6gQ1d6I1UZSODUFnnSIkAQTUabHq
 EdsQBxokbnBeURQ6tSw46/nQt7OO4F9y0ep9proja6L5t4FNHexDjrfQ7/IPMQDBbqFUkM4ZFR4
 mRP+OgCVJn7lY5rZwVUqWwmHyBpt44Gt4Eysnter+HLrhExeJQujbZ0HvsKLL3O4lP7XaYMoqoE
 AW3/F7LDDsQ3PJL48WtZvdJ0H7kYULFkhGuCU2NV3wj8I3dWLD81obP6oFeyXj2nhJSVZSDebsC
 uzmtBNhx3jE3yNP0uZKfQEK+/69MtnzWUK9SxIT5/DvvHcKCLQ2R8ot/1sC5K1k9UYDBsxwt0sq
 J5B8SdQaIP/6H/tQz8/VyBgsLVRkaSTMb6u+GT3NoClRgfeLqSZM6Obrsh1oQCuCr69u4l6zhxj
 IvtnwtpYi8wXMSiq3Hse5HnwuNpuNcV5ZPBOTKRQSwh011RU1n3zCiUA0TplB36TDmu/vMlRV3J
 XvGUB7E0pZP6OjOFLwVUYRPB+1XRV4MZqyFK1axmxNlAdWOQ7Mr+nIXwYqTemS+W1vPhyOOdPkg
 kYVCebg+Np/lg2S6BmwuGbIMoU0ERxMl/pKuX+a/MI1YG5rsEBfUNFUhRNziVKj9KcgRkvYYLjP
 DLEUdd+On8R1Ung==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The ADD_ADDR 0 with the address from the initial subflow should not be
considered as a new address: this is not something new. If the host
receives it, it simply means that the address is available again.

When receiving an ADD_ADDR for the ID 0, the PM already doesn't consider
it as new by not incrementing the 'add_addr_accepted' counter. But the
'accept_addr' might not be set if the limit has already been reached:
this can be bypassed in this case. But before, it is important to check
that this ADD_ADDR for the ID 0 is for the same address as the initial
subflow. If not, it is not something that should happen, and the
ADD_ADDR can be ignored.

Note that if an ADD_ADDR is received while there is already a subflow
opened using the same address, this ADD_ADDR is ignored as well. It
means that if multiple ADD_ADDR for ID 0 are received, there will not be
any duplicated subflows created by the client.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 4 +++-
 net/mptcp/pm_netlink.c | 9 +++++++++
 net/mptcp/protocol.h   | 2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3e6e0f5510bb..445a9b445971 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -226,7 +226,9 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	} else if (!READ_ONCE(pm->accept_addr)) {
+	/* id0 should not have a different address */
+	} else if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
+		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 591ae2ffb4dd..b5ff78464950 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -760,6 +760,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	}
 }
 
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote)
+{
+	struct mptcp_addr_info mpc_remote;
+
+	remote_address((struct sock_common *)msk, &mpc_remote);
+	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
+}
+
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e934ce0e4ff..b6100cc23cf4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -993,6 +993,8 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote);
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);

-- 
2.45.2


