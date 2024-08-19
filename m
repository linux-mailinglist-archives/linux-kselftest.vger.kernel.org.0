Return-Path: <linux-kselftest+bounces-15709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF79574D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC673B23C06
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAC61E4F1B;
	Mon, 19 Aug 2024 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0uqG0m0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1261E4F19;
	Mon, 19 Aug 2024 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096751; cv=none; b=BxsNFTXodo3r2G8hUsQJDcM3d8XE/WYc7u8fQqTE2rnqF/9cVfYO7kNkeaB/epm1a4q9M6G9AkbJSe1fqvXHA+nPGOIDHiNKwZscIh0hlX/dAsXhr4iyiJXvl9Wwa71BSi5paa+k6d7OMeNC/Aw53MiQ8vOAVOGnGFhKHmN38UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096751; c=relaxed/simple;
	bh=G/T4Zoev04V5Byavsl//HLV2kTVTfPniskd8/ZHW86Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjjb5JbZZtFwk8qI0hCOaOQVBThZPxGgSGlVvSCsKl+NujPiS58ZTiWb2oHJpQt4ik3ieioww3Q5VzaXHB5vpcI4mtKE5BYKuki4s1VXNUfSlVJhXCFBqPgwnAK4AQ7jgz2g6PMyGAc4zGd4nAzPTlNAmFndb0LiH5Euk3/wMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0uqG0m0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B67C4AF12;
	Mon, 19 Aug 2024 19:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096751;
	bh=G/T4Zoev04V5Byavsl//HLV2kTVTfPniskd8/ZHW86Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q0uqG0m0IUpNhyG929qvup+lc9FVQEs0VSCyCrtEIiXaP7n3Z3Z0lUnfgmjEMk+G5
	 88OuAprl0PtLPEwIc5WMB2Kuhb4d0/xPNLGEqUOq0dcaDNv2qM5zm33IbMMO0PuzVL
	 h2220jWC2x+ZEVhDI+inXQ2ap+Rqw9DxlYibO67o/mgLiEPWwdSUxd2JL+9AqGDGzV
	 VeppmhbkRznZUnOcuQuBgYknVGfp2VxoskPiOoXRnfbNfkz/ltgWsnvn1vNlZT9N6T
	 8NLsq9iMcNA7emchFSLEaNqdiQeEUhzStlt3u75qA4BPMKfGCe0l5zLbylFU5pMvTC
	 tH1P9oMTZANKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:26 +0200
Subject: [PATCH net 08/14] mptcp: pm: only mark 'subflow' endp as available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-8-38035d40de5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4100; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=G/T4Zoev04V5Byavsl//HLV2kTVTfPniskd8/ZHW86Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DTkO3PlNozNZFdOi1GAiidS4XawGoebuqLt
 j9wB2mCnqiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0wAKCRD2t4JPQmmg
 c8F/D/oDlBGFJ2DnRGImot1TksWV42Jc8J25ZO1xBnsr0sK/sQ4F7QpwPIs1yEKplmlAchoeor5
 D/67BAWq6mFINfaHee1V6AxSzgcYOXK7HmgNCk4SQs9YQF2foJfCpCobAOreZg/B8vmhB5+9oen
 JZSGdFfMJJpvPzu655m5t6Ws0JucOhGHXxYp5HcI3FcIkI/iA0u6k5A+cv7GFbxlkg16ytC3tMJ
 2fbJeIk5s/FM/bbHYIlgU3H+ym6xgZxQwjK8JrTSBdYml0U+npSRaqQ4NWk/OuRcfzng8yAjD68
 KUyGYURdmIgZ+d0zAx9nNGtUQ8JjhCLxNR6Wc0yyE5CPDtiw3Cu+DZizJS6rNQiRjpTrDbRk+TR
 7+x4XZv9B8usjzDvsNAeQGYw1LNMZl0kqZknO44k6kA759popa+YSZezchG7ajbabfc6YuaCXZK
 xF7UE1ef2q4Iqlrgk3W4am5MTt+7h00JI1zZIva+wVJLgR9g/iMVBtQZjCexhtshHXOXYqPl7kD
 MEudqCfJ2X0IDMhKzfWf78EwUeHgG8Tj2WF2Nm0qyh/JaBEj0wSlHeQMO5v/fW49vY9uEAn6Ctm
 qKvcoAA3/e0gQrquSzvmjA0mSco5nu2VKf9sQb03lEKEbdfuL3B2t0c97SSr9lCXTfoxOyMJnBX
 ogm6aSGiV1smlOA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Adding the following warning ...

  WARN_ON_ONCE(msk->pm.local_addr_used == 0)

... before decrementing the local_addr_used counter helped to find a bug
when running the "remove single address" subtest from the mptcp_join.sh
selftests.

Removing a 'signal' endpoint will trigger the removal of all subflows
linked to this endpoint via mptcp_pm_nl_rm_addr_or_subflow() with
rm_type == MPTCP_MIB_RMSUBFLOW. This will decrement the local_addr_used
counter, which is wrong in this case because this counter is linked to
'subflow' endpoints, and here it is a 'signal' endpoint that is being
removed.

Now, the counter is decremented, only if the ID is being used outside
of mptcp_pm_nl_rm_addr_or_subflow(), only for 'subflow' endpoints, and
if the ID is not 0 -- local_addr_used is not taking into account these
ones. This marking of the ID as being available, and the decrement is
done no matter if a subflow using this ID is currently available,
because the subflow could have been closed before.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 44fc1c5959ac..4cf7cc851f80 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -833,10 +833,10 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
-		if (rm_type == MPTCP_MIB_RMSUBFLOW)
-			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
-		else if (rm_type == MPTCP_MIB_RMADDR)
+
+		if (rm_type == MPTCP_MIB_RMADDR)
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
+
 		if (!removed)
 			continue;
 
@@ -846,8 +846,6 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
-		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
-			msk->pm.local_addr_used--;
 		}
 	}
 }
@@ -1441,6 +1439,14 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)
+{
+	/* If it was marked as used, and not ID 0, decrement local_addr_used */
+	if (!__test_and_set_bit(id ? : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap) &&
+	    id && !WARN_ON_ONCE(msk->pm.local_addr_used == 0))
+		msk->pm.local_addr_used--;
+}
+
 static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   const struct mptcp_pm_addr_entry *entry)
 {
@@ -1474,11 +1480,11 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 			spin_lock_bh(&msk->pm.lock);
 			mptcp_pm_nl_rm_subflow_received(msk, &list);
 			spin_unlock_bh(&msk->pm.lock);
-		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-			/* If the subflow has been used, but now closed */
+		}
+
+		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 			spin_lock_bh(&msk->pm.lock);
-			if (!__test_and_set_bit(entry->addr.id, msk->pm.id_avail_bitmap))
-				msk->pm.local_addr_used--;
+			__mark_subflow_endp_available(msk, list.ids[0]);
 			spin_unlock_bh(&msk->pm.lock);
 		}
 
@@ -1516,6 +1522,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
 		mptcp_pm_nl_rm_subflow_received(msk, &list);
+		__mark_subflow_endp_available(msk, 0);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 
@@ -1917,6 +1924,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	__mark_subflow_endp_available(msk, list.ids[0]);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 	spin_unlock_bh(&msk->pm.lock);
 }

-- 
2.45.2


