Return-Path: <linux-kselftest+bounces-16938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6C968514
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2340DB25C62
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB39A184539;
	Mon,  2 Sep 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R17NAG79"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFFE184536;
	Mon,  2 Sep 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273972; cv=none; b=THKFg21VqGX8BeXInZbE/Z6g9Ra2okO3wQyYqgPVuGpYoJQr9j6AgrzrrZqSx/3w9ByLqaG+lURkIMB5bhN7MAdLSV6yMaLOkYkQiY7z3h+YR3XwCIp1ZX17CH8VufU+R18ZBSYYLFX7mWLOzVBLNaOX9rny3wKlVkbXFQxEdkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273972; c=relaxed/simple;
	bh=gtOynYXakywMfVUFTn0bOS/Grvyo5lnBc4FmJT1+Y3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9GudbwnIgKfaEROiW5C4JozpSPcJSGVfjBayyTZG32FU0MHqNvOJMbnU3OsXqONrD/P9V+jmROtUAthZGQqUgLZW6jWwJNRBKfPQYQL4pYBTBcAmPLvIXaqSE6hRtHFioXrWX2Qhz7L5MubysCYqZmdXDZvlgQx1zynsc9XwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R17NAG79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80314C4CEC9;
	Mon,  2 Sep 2024 10:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273972;
	bh=gtOynYXakywMfVUFTn0bOS/Grvyo5lnBc4FmJT1+Y3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R17NAG79BhIg/acf0XwNnhwzlNUHgJ9rSn7GXGTYZ6NiJEOvGNloMcmmx6IDk4Oor
	 jAgZ8yU1MHuJ9KyFo2Y3aAaJHKeh6xjj/a8rqSYYn9bUNOyWuLklQrd7XG21BXwN2s
	 28MpGBILyLg1qhGTZ6qvvsbt5b1aApIJp4ALbphe8id6bLKSCOqZYB78twW30yc/Gg
	 AapUbOt94EuNVKCWJZ6KZduyasJ8Nust23FdBL8YhpqCP8opOVR5TiaXOyYq1vg0l7
	 05RHuMkUhaznrMH2C7R9rk5L95ghsoGpUK3+oob1SgkqI0t7t3+hykTh3LaI9DPAI1
	 QNyHmN5MR61KQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 12:45:52 +0200
Subject: [PATCH net-next 01/11] mptcp: pm: rename helpers linked to 'flush'
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-1-d3e0f3773b90@kernel.org>
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gtOynYXakywMfVUFTn0bOS/Grvyo5lnBc4FmJT1+Y3c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1ZdtdErTwaasD/SSNXBmVwt8ZrM41S4mFKXrM
 s7ePiRtC6WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbQAKCRD2t4JPQmmg
 c0U/EAC3d2wePLTVhrIWDfWFt1+zBpCyWXpf1IfvK4Q5ios3slRaEBUVDhzQ0lwQriaEFF4vuen
 2YHy15w6OkMDVrmIKLRnbXzuunFfWKv3eDmuEWNdUnvp63M2Pi/R1SEmuBo9wwNd4LJi8nMyu3/
 rOfhrA6ThMNqFo3Ilb3+9XKxCbvFjhGuNOCgseMzkiu1xRYWaDpQNeo/k8plz6JdlmMaOftaWjR
 YfJWLS3Dr+egvZbUu2jAPuxiGaLWuJX/AL+aeWKgDkeTIWaN5ZRj/DgbIqbYRTHIbywJaszZXSs
 jrHz0/khuICq4uDfIRKQ0s5ziqUo6TeceX3J8Zf1Bw1AkUima2pcQ0Dm+xl7mLdpTTavCp8+ZfJ
 Ggqls5zGvkmhSaojveyE1u6f9PWmbfC7qQ6YKwKRKWwLAZHE82iHYZhtmoP8pJJNyfkOv43O7Za
 CQ1IxifcxyjWz33u9I8whgh1l9uvpQjKJuSJl5Gd9henDqE2Z6T4+5bmPTB/TKQ0BBEqDPn6kXx
 Rlj669mJHYYKnclYmnBlgvkpT2aPBuAA7/jQbi++stI1/3joyA/ULDF0KmJBKXLyKMKUblqGpRW
 ki/0Q59lJHeLhJSt5pIJZEuO9nWjEEVNv5LGwvhI3bPRnRpehUm7meIbC69X8ws4KoHPyWzW1qH
 YdirCllTgihMwbA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Rename all the helpers specific to the flushing operations to make it
clear that the intention is to flush all created subflows, and remove
all announced addresses, not just a specific selection.

That way, it is easier to understand why the id_avail_bitmap and
local_addr_used are reset at the end.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f891bc714668..275959581586 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1672,8 +1672,8 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 }
 
 /* Called from the in-kernel PM only */
-static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					       struct list_head *rm_list)
+static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
+					      struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
@@ -1701,8 +1701,8 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_nl_remove_addrs_list(struct net *net,
-				       struct list_head *rm_list)
+static void mptcp_nl_flush_addrs_list(struct net *net,
+				      struct list_head *rm_list)
 {
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
@@ -1715,7 +1715,7 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 
 		if (!mptcp_pm_is_userspace(msk)) {
 			lock_sock(sk);
-			mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
+			mptcp_pm_flush_addrs_and_subflows(msk, rm_list);
 			release_sock(sk);
 		}
 
@@ -1756,7 +1756,7 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
+	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
 	return 0;

-- 
2.45.2


