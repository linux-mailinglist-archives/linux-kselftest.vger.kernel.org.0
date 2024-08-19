Return-Path: <linux-kselftest+bounces-15708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8F89574CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FB1282295
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D1B1E4EFC;
	Mon, 19 Aug 2024 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka5ojFE4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F51E4EF4;
	Mon, 19 Aug 2024 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096748; cv=none; b=Z53xjJjvpCWVL37sW0IXX9bRSasfPKqvYZbjdvLES+eNa70Kk5tgfJnRDzq4tupbukPcgwa0ASN1x3SxjNtFw9pc4BbGs/QLySFqqZs4mne64fLb+FCco5tLT0sZTXwsLxmOw9wpM8mwTbeZzcNpQe9bZzOfPzAqXpqStTXaAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096748; c=relaxed/simple;
	bh=BTC1VqrgypC0zR0a/DPftpsfqKtSqKmahpvHDAKQMXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KyQ9zV7KCIqWxTPRqPF5GI6nEmQQnrGF3n785ClXHpMW2vXi8fFyCC317V/1yymvEAsYNW0f2702Lb0bvIwcpHdh+FdDG6fmYtg0lAQvZf70pyBUeJ5xEwUSUmZg4jwKj57JkNt/kHDOKNhtiBX6iXSzeOWGrO5EOA80e4RgkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka5ojFE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCBCC4AF0E;
	Mon, 19 Aug 2024 19:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096747;
	bh=BTC1VqrgypC0zR0a/DPftpsfqKtSqKmahpvHDAKQMXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ka5ojFE474ErJ8kwIBbixpX8geY+tOEnYTHKQpE5vtuzWpabbs07VH98SJkLD1zcM
	 +3Y2GHAmx1tTPJWH3F2jVN5gDwsr93S1Ph5ClEUrpBcQr04365hvXB8APyiDw5hcz1
	 QvRnINMeBaTNq17/nRBhbNCx3s/7OGnaOeSu98MjLthNSv8doRXJwySx8OXLVOk/7E
	 p1f84gOd3sT5eJo7fw4RpV+7ZOd+3a0IuS5ZYJcXO9Gj2OgOgq8t1E5VnI8bgan8Ln
	 pJo40xQ0mRq+4AkLaq53mHrfFDlXUiUQhuMjffYP8KoksgtaCoqOW3XFpLt3lpxosX
	 4876k1lwPhJ8Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:25 +0200
Subject: [PATCH net 07/14] mptcp: pm: remove mptcp_pm_remove_subflow()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-7-38035d40de5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4749; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BTC1VqrgypC0zR0a/DPftpsfqKtSqKmahpvHDAKQMXg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DTcaXMICC6/6mJo75ZmAFgQEYtPhgQL8oxd
 sRt5BZq67OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0wAKCRD2t4JPQmmg
 c8OhD/wNmNTAqUfXbPxULsX9+aAdPC7QnqNsXRZBZc0mzpww/ik5tRr1fKvRJ/FD2iNeN81kRbA
 GCYleKQcNjv9faivL9gnJtMdRRSlSc15I7wiapBakzUXwrgoNHi+G3ecBSyH13on0/CznrMJ2fl
 Zgn45vY274IH5948XPxQ8pPrRXbYUgMkvpPivh9Mi161I17djdD64tagedzyDhMeDra3HLj+hfG
 SHYsvfliMI3x6Ah2nsmPRSZ2gGHYoruWDSTlmVuj8erMFfQJXbRA4BjugZYz4KUS5l+nf7rGH8W
 oYGlANkAOkIr8HOFkmUkJYW+wRrzQQ8n7wR0TDxhQO0zf8ri+s7OzFxddU4K2otgH53Fut3Rgx0
 8v3nl2TWo2mMUEhjmkMCvWpE+BJd5ftuqs1/GxNKdBYCnTnNnIx5DdP6ohAG+eubtcpX/qVKdI0
 9WRC8oIZFQUxSh3qHqVLS9+tC6KUQrm8AQ7KqHomq2Fb3U1nqWztIyY590fq5dBXkYkQDlGaz+V
 q5TdNvFvX3+XfBAE426KIcehpoHh7JRJBA12nN7Ywf8Sewcay+KWYWVL2j3SMrA+xpoTZ4xeic8
 G9eb0XKGvHai9+jVvvB762hB+yt/buUt97kSouHPlauWY8XepuemWSwNQ5dp6/UCajP3mQGouHk
 /I6tw8UD64R4DXw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This helper is confusing. It is in pm.c, but it is specific to the
in-kernel PM and it cannot be used by the userspace one. Also, it simply
calls one in-kernel specific function with the PM lock, while the
similar mptcp_pm_remove_addr() helper requires the PM lock.

What's left is the pr_debug(), which is not that useful, because a
similar one is present in the only function called by this helper:

  mptcp_pm_nl_rm_subflow_received()

After these modifications, this helper can be marked as 'static', and
the lock can be taken only once in mptcp_pm_flush_addrs_and_subflows().

Note that it is not a bug fix, but it will help backporting the
following commits.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 10 ----------
 net/mptcp/pm_netlink.c | 16 +++++++---------
 net/mptcp/protocol.h   |  3 ---
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 23bb89c94e90..925123e99889 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -60,16 +60,6 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	return 0;
 }
 
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list)
-{
-	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
-
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_nl_rm_subflow_received(msk, rm_list);
-	spin_unlock_bh(&msk->pm.lock);
-	return 0;
-}
-
 /* path manager event handlers */
 
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2c26696b820e..44fc1c5959ac 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -857,8 +857,8 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
 	mptcp_pm_nl_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
 }
 
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-				     const struct mptcp_rm_list *rm_list)
+static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
+					    const struct mptcp_rm_list *rm_list)
 {
 	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
@@ -1471,7 +1471,9 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		if (remove_subflow) {
-			mptcp_pm_remove_subflow(msk, &list);
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_nl_rm_subflow_received(msk, &list);
+			spin_unlock_bh(&msk->pm.lock);
 		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 			/* If the subflow has been used, but now closed */
 			spin_lock_bh(&msk->pm.lock);
@@ -1617,18 +1619,14 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 
+	spin_lock_bh(&msk->pm.lock);
 	if (alist.nr) {
-		spin_lock_bh(&msk->pm.lock);
 		msk->pm.add_addr_signaled -= alist.nr;
 		mptcp_pm_remove_addr(msk, &alist);
-		spin_unlock_bh(&msk->pm.lock);
 	}
-
 	if (slist.nr)
-		mptcp_pm_remove_subflow(msk, &slist);
-
+		mptcp_pm_nl_rm_subflow_received(msk, &slist);
 	/* Reset counters: maybe some subflows have been removed before */
-	spin_lock_bh(&msk->pm.lock);
 	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	msk->pm.local_addr_used = 0;
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 60c6b073d65f..a1c1b0ff1ce1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1026,7 +1026,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
@@ -1133,8 +1132,6 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-				     const struct mptcp_rm_list *rm_list);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);

-- 
2.45.2


