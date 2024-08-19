Return-Path: <linux-kselftest+bounces-15715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE129574EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45831F21F4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EBF201258;
	Mon, 19 Aug 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te+T++sB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A020124E;
	Mon, 19 Aug 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096770; cv=none; b=Kkdb+C30XorSwYU8zPG3o0he53eg2bfC6IpbsKFuXr6ef5GOuv8Y+ALE4l7flqfnAgSkT/jHoQwlT3YaR8XtUM6zklOINnJqAe0yznrA9Xrc27KqJqnInuJaQGpoV9/SF5QWm0DhbKpuurOYcWoDGXGpBWsbt/TdL1PCp24pFH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096770; c=relaxed/simple;
	bh=S/G3H+zWXhU4Ysa/76xvg601REXC5HLy4Uhd8tkcCIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g78GsheATKD7Q7cIgk2XMX//ggrqaxnzLxUj0pfPZh8BLCeURvKB0/OdYfvlBErcfzodPvTwR3O2z2059Ld3gtNmv70TW8E0uMmRXXCHOuO97Q+RfFmwLAr6DYAIhTKTeYVlkBNYmzYv3WizrdI65AEyKzAOfhuu4CosME8zbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te+T++sB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910A9C4AF13;
	Mon, 19 Aug 2024 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096770;
	bh=S/G3H+zWXhU4Ysa/76xvg601REXC5HLy4Uhd8tkcCIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Te+T++sBuBbkjdkdu+lo0RsreBVV1B0VE4LauCftSKVImsnXk+qHZ/ZW3W++kT1BE
	 Jt09DP8+JS0okm1S1+FXCjfLAJ07wMJUlcSdKDfhZTKG0ZgdgLAw1Kjy6E0R9LInp5
	 j+RtlSUeaEvtimHfup4u6+xo8SQd5ehVhbwrEpER4y0g+pEd8yAllBDfisiwBSyDMr
	 e+tFTIva7mH4v+dN+2z79sLrnHcSwGOyev82dwJ68T/3pjcU9VWRJdmSQC6Mejx4uf
	 /PQzUKDsfSMpVRm5szAhrOa723shz2nuPHYzMVqjFutahtunt8m1gUrWu3hC8sWl6C
	 wUCloFAs2VaJQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:32 +0200
Subject: [PATCH net 14/14] mptcp: pm: avoid possible UaF when selecting
 endp
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-14-38035d40de5b@kernel.org>
References: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
In-Reply-To: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5507; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S/G3H+zWXhU4Ysa/76xvg601REXC5HLy4Uhd8tkcCIY=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGbDoNOjBCnpnGhGTWSMeyQztma46JXJb2M0L5L5ZU+o5onq/
 okCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmw6DTAAoJEPa3gk9CaaBzMbUP/A3d
 MfwJcEXPb1VeckKa35cNxanJVUG6ocURH8bqw1oDbR76hX7BYgcu2Chbd+FGwOGgeegCkOIlyXi
 5J/a1cHkrYyFOTXy1AnhP8SqtHOzF+/NG1Wn1Rb+M0g4EIxry5ly2dEBN4WwcFHwt6/bNZ6IP/p
 q+4N7jY0VCNsgNLyCM+kv9E+bqGKN4GHz1h0pcYyGBcGd5+JFStu0EyZc/s/sy3tn/8Zpp2cZnh
 8X4i52eV1lAEvmz4Cly6tkK27hipVDU7L5vcfxnsXi1Nk9tHtGS6XoEiqYiwHQJTx/nn1Zw7Vud
 5q/+Q3IAb3D3J3lEB6ky/n0IVSPKDrR55mZs4Y+UVUUGAK1SNNtj+HTM0tLz6U7a0cYaQize84k
 Zaks5McUTgBoap1lqIPMBREC5y59Uu+43g7iGRQ6Q5+GXdGjOLJQQeMGiJ9BswTxMkxe+5cNE0+
 6eHJOpDVSpE3FdzMTUWbP/kXP+aOJtFZBD8GcjlL0WdY/Y8+NTt21SzPABKZEp9WH8qehFVcY3o
 tZbDo25HLD3udEFQlhAoC66KK5j6HRiSCLi74axmZQQP1lnyAQWvHTltQTGoQuEuvBM7UHri1mG
 WnNWPiYPDJhkc5wgSobo0QG1Z0W4gpRQ561pDKcHd9UY7nv+m9Plx5GUHYLGF+aBLWITzyngeL/
 yhwAp
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

select_local_address() and select_signal_address() both select an
endpoint entry from the list inside an RCU protected section, but return
a reference to it, to be read later on. If the entry is dereferenced
after the RCU unlock, reading info could cause a Use-after-Free.

A simple solution is to copy the required info while inside the RCU
protected section to avoid any risk of UaF later. The address ID might
need to be modified later to handle the ID0 case later, so a copy seems
OK to deal with.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/45cd30d3-7710-491c-ae4d-a1368c00beb1@redhat.com
Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a2e37ab1c40f..3e4ad801786f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -143,11 +143,13 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 	return false;
 }
 
-static struct mptcp_pm_addr_entry *
+static bool
 select_local_address(const struct pm_nl_pernet *pernet,
-		     const struct mptcp_sock *msk)
+		     const struct mptcp_sock *msk,
+		     struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	msk_owned_by_me(msk);
 
@@ -159,17 +161,21 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
 			continue;
 
-		ret = entry;
+		*new_entry = *entry;
+		found = true;
 		break;
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
-static struct mptcp_pm_addr_entry *
-select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
+static bool
+select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
+		      struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	rcu_read_lock();
 	/* do not keep any additional per socket state, just signal
@@ -184,11 +190,13 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 
-		ret = entry;
+		*new_entry = *entry;
+		found = true;
 		break;
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
@@ -512,9 +520,10 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry local;
 	unsigned int add_addr_signal_max;
+	bool signal_and_subflow = false;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
@@ -565,23 +574,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		local = select_signal_address(pernet, msk);
-		if (!local)
+		if (!select_signal_address(pernet, msk, &local))
 			goto subflow;
 
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
 			return;
 
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
-		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
-		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
-			signal_and_subflow = local;
+		if (local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = true;
 	}
 
 subflow:
@@ -592,26 +600,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		bool fullmesh;
 		int i, nr;
 
-		if (signal_and_subflow) {
-			local = signal_and_subflow;
-			signal_and_subflow = NULL;
-		} else {
-			local = select_local_address(pernet, msk);
-			if (!local)
-				break;
-		}
+		if (signal_and_subflow)
+			signal_and_subflow = false;
+		else if (!select_local_address(pernet, msk, &local))
+			break;
 
-		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
+		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
 		msk->pm.local_addr_used++;
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
 			continue;
 
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);

-- 
2.45.2


