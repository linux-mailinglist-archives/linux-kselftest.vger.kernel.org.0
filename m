Return-Path: <linux-kselftest+bounces-16939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2271A968519
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45361F23CAA
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AB61865E9;
	Mon,  2 Sep 2024 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIF8V7Rn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771418594A;
	Mon,  2 Sep 2024 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273975; cv=none; b=dgyc4UYbsQunX0ANoyl3RkCUvz6cF8i7/0XIRMM8mFkFAJSN4PWMho0tI1f//ZIMdbnpDopMjT2/kvCT9BmV1PWibyEGqA0PGwUMziUZV9Homb3+r1smdutDAEisO+k5QbaUtTKLKqJjis94qyHobm90EjbDMYDG89f/rYlnaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273975; c=relaxed/simple;
	bh=uPXJ7emMKa+5QN/1bld1ruCPBaqlm+m4AQY7UI+VWnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwuI9FLiU1LtWqhDVGqJywEZ/xnldTemm/XhIoH69Ldt14LKW2JyTwJl5zVF4UGZMsgxCia5xtiBnE6ErX00QoiP6IwYab+797sBm9CyXScuSoA3I0TU95EQaDKObhTs76xTr9iaxaG5JoaV1VdUi9n4bXDTBnTiO8+B4bLsZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIF8V7Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9170BC4CEC2;
	Mon,  2 Sep 2024 10:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273975;
	bh=uPXJ7emMKa+5QN/1bld1ruCPBaqlm+m4AQY7UI+VWnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BIF8V7RnGXVVnolPwQxdpzNyhzp1FxeW6lc848mBpEH8TxpEzgSuTh5saq6X9dniE
	 eyaxHoP57Hl76lb7hK3jPo87qExk2TofWNBTeS802qYpQD7yrKo2ljHK6ZPa6P351j
	 NT6TXDr1dHzsemzc531dh9T6Vb/S+OF74l6XVG1N0iQHgrv+QKzA8cBgK+Kn3zyfk5
	 T5iGh1gGuVUq2fubTCn5XmnGprxRP+60Tx1Ht64Cn25k6z5RphSG+2hvlWW3f4mpKI
	 LgPeXCbSgJIPU1rkPsBLpTeOKuee3ftz0XxnBpo+CZ2xvhhgakH6QyBPkPzN2+QFYB
	 pINNFscB8whnA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 12:45:53 +0200
Subject: [PATCH net-next 02/11] mptcp: pm: reduce entries iterations on
 connect
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-2-d3e0f3773b90@kernel.org>
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=15519; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uPXJ7emMKa+5QN/1bld1ruCPBaqlm+m4AQY7UI+VWnw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1ZdtCT81seJNcho6yQWSdHOYZDIlwZfV2nDdT
 +cX61hQO7OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbQAKCRD2t4JPQmmg
 c1xcEADJURpj7QA4cbVjviuIjEg0SjAs/Gd8XkWfzjyR4ZI8/zySu71jJchcdWZfSDI20NylR7/
 S4umYY9/RQ4ALjvKOTUVdUC0EX4Qvqcw+8ih32KW/+Bc0uUN8vSiwkX9lGyoTGPeJh3MjWF51Iy
 Vf60zpFKvOePm+SGnuGY5C4UFLZTRUAPahB82skHgTOohFZZyL2wwAGPwPnyZY0dH73lbzlXWFa
 IrEMrZwVuCIZgFcoOOPsgkxYHbGUE7ifPKY8AZeejfzV2A3miadyYse3slBFfbDbxv209WHBY/a
 T+BYHwgZ1094IQWJwV8ZKaXEq1mBfzLS7+n8P6PKvxm3Q0A1LRshrpOopfVag/85Rzn0bPJLV/1
 W67OKCjy3AizSW161an3qWBYYvNb7GFE1XWRX7gi+hDVOHfimbd0afSvYLGOesw9iDCufK4tYhd
 w8qToHf/dM0xrbB6WqvC2Wt7VkobDFdI8m5iFyjsQwpviB9Zg5083TicJgNouenZXbh05nl0Bnx
 CkeZFAMB8Qoph5PHmFsEufQhgxxddMY8OSk6OBPM6Flg9ZvueFzk7q6B+vmM6eH35zF50g8Dm2x
 ccHRGjQfgsVwW98pvWeFCI5Eq1T+e20KsX87X2kwK1WaAZJ+rBT0QL3fkXZgjRYFfsh31VnifGm
 d/feOTWnSIBN8sg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

__mptcp_subflow_connect() is currently called from the path-managers,
which have all the required information to create subflows. No need to
call the PM again to re-iterate over the list of entries with RCU lock
to get more info.

Instead, it is possible to pass a mptcp_pm_addr_entry structure, instead
of a mptcp_addr_info one. The former contains the ifindex and the flags
that are required when creating the new subflow.

This is a partial revert of commit ee285257a9c1 ("mptcp: drop flags and
ifindex arguments").

While at it, the local ID can also be set if it is known and 0, to avoid
having to set it in the 'rebuild_header' hook, which will cause a new
iteration of the endpoint entries.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 11 --------
 net/mptcp/pm_netlink.c   | 66 ++++++++++++++++++------------------------------
 net/mptcp/pm_userspace.c | 40 ++++++++++-------------------
 net/mptcp/protocol.h     | 16 +++++-------
 net/mptcp/subflow.c      | 29 +++++++++++++--------
 5 files changed, 62 insertions(+), 100 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 37f6dbcd8434..620264c75dc2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -430,17 +430,6 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
-					 u8 *flags, int *ifindex)
-{
-	*flags = 0;
-	*ifindex = 0;
-
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
-	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
-}
-
 int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 275959581586..62a42f7ee7cb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -149,7 +149,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 static bool
 select_local_address(const struct pm_nl_pernet *pernet,
 		     const struct mptcp_sock *msk,
-		     struct mptcp_pm_addr_entry *new_entry)
+		     struct mptcp_pm_local *new_local)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool found = false;
@@ -164,7 +164,9 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
 			continue;
 
-		*new_entry = *entry;
+		new_local->addr = entry->addr;
+		new_local->flags = entry->flags;
+		new_local->ifindex = entry->ifindex;
 		found = true;
 		break;
 	}
@@ -175,7 +177,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 
 static bool
 select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
-		      struct mptcp_pm_addr_entry *new_entry)
+		     struct mptcp_pm_local *new_local)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool found = false;
@@ -193,7 +195,9 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 
-		*new_entry = *entry;
+		new_local->addr = entry->addr;
+		new_local->flags = entry->flags;
+		new_local->ifindex = entry->ifindex;
 		found = true;
 		break;
 	}
@@ -524,11 +528,11 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry local;
 	unsigned int add_addr_signal_max;
 	bool signal_and_subflow = false;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
+	struct mptcp_pm_local local;
 	unsigned int subflows_max;
 
 	pernet = pm_nl_get_pernet(sock_net(sk));
@@ -629,7 +633,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
+			__mptcp_subflow_connect(sk, &local, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -650,7 +654,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
  */
 static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 					     struct mptcp_addr_info *remote,
-					     struct mptcp_addr_info *addrs)
+					     struct mptcp_pm_local *locals)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
@@ -673,13 +677,15 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			continue;
 
 		if (msk->pm.subflows < subflows_max) {
-			msk->pm.subflows++;
-			addrs[i] = entry->addr;
+			locals[i].addr = entry->addr;
+			locals[i].flags = entry->flags;
+			locals[i].ifindex = entry->ifindex;
 
 			/* Special case for ID0: set the correct ID */
-			if (mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
-				addrs[i].id = 0;
+			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
+				locals[i].addr.id = 0;
 
+			msk->pm.subflows++;
 			i++;
 		}
 	}
@@ -689,21 +695,19 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	 * 'IPADDRANY' local address
 	 */
 	if (!i) {
-		struct mptcp_addr_info local;
-
-		memset(&local, 0, sizeof(local));
-		local.family =
+		memset(&locals[i], 0, sizeof(locals[i]));
+		locals[i].addr.family =
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			       remote->family == AF_INET6 &&
 			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
 #endif
 			       remote->family;
 
-		if (!mptcp_pm_addr_families_match(sk, &local, remote))
+		if (!mptcp_pm_addr_families_match(sk, &locals[i].addr, remote))
 			return 0;
 
 		msk->pm.subflows++;
-		addrs[i++] = local;
+		i++;
 	}
 
 	return i;
@@ -711,7 +715,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
-	struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
+	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
@@ -740,13 +744,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
-	nr = fill_local_addresses_vec(msk, &remote, addrs);
+	nr = fill_local_addresses_vec(msk, &remote, locals);
 	if (nr == 0)
 		return;
 
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
-		if (__mptcp_subflow_connect(sk, &addrs[i], &remote) == 0)
+		if (__mptcp_subflow_connect(sk, &locals[i], &remote) == 0)
 			sf_created = true;
 	spin_lock_bh(&msk->pm.lock);
 
@@ -1433,28 +1437,6 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
-					    u8 *flags, int *ifindex)
-{
-	struct mptcp_pm_addr_entry *entry;
-	struct sock *sk = (struct sock *)msk;
-	struct net *net = sock_net(sk);
-
-	/* No entries with ID 0 */
-	if (id == 0)
-		return 0;
-
-	rcu_read_lock();
-	entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
-	if (entry) {
-		*flags = entry->flags;
-		*ifindex = entry->ifindex;
-	}
-	rcu_read_unlock();
-
-	return 0;
-}
-
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr)
 {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8eaa9fbe3e34..2cceded3a83a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -119,23 +119,6 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
-int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
-						   unsigned int id,
-						   u8 *flags, int *ifindex)
-{
-	struct mptcp_pm_addr_entry *match;
-
-	spin_lock_bh(&msk->pm.lock);
-	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
-	spin_unlock_bh(&msk->pm.lock);
-	if (match) {
-		*flags = match->flags;
-		*ifindex = match->ifindex;
-	}
-
-	return 0;
-}
-
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
@@ -352,8 +335,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_pm_addr_entry local = { 0 };
+	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
+	struct mptcp_pm_local local;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
@@ -379,18 +363,18 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_entry(laddr, info, true, &local);
+	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
 
-	if (local.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
 		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		err = -EINVAL;
 		goto create_err;
 	}
-	local.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
+	entry.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
@@ -398,27 +382,29 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	if (!mptcp_pm_addr_families_match(sk, &local.addr, &addr_r)) {
+	if (!mptcp_pm_addr_families_match(sk, &entry.addr, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
 		err = -EINVAL;
 		goto create_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto create_err;
 	}
 
+	local.addr = entry.addr;
+	local.flags = entry.flags;
+	local.ifindex = entry.ifindex;
+
 	lock_sock(sk);
-
-	err = __mptcp_subflow_connect(sk, &local.addr, &addr_r);
-
+	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
 	if (err)
-		mptcp_userspace_pm_delete_local_addr(msk, &local);
+		mptcp_userspace_pm_delete_local_addr(msk, &entry);
 	else
 		msk->pm.subflows++;
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3735b20f2626..bf03bff9ac44 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -236,6 +236,12 @@ struct mptcp_pm_data {
 	struct mptcp_rm_list rm_list_rx;
 };
 
+struct mptcp_pm_local {
+	struct mptcp_addr_info	addr;
+	u8			flags;
+	int			ifindex;
+};
+
 struct mptcp_pm_addr_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
@@ -719,7 +725,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 				struct socket **new_sock);
@@ -1014,14 +1020,6 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
-					 unsigned int id,
-					 u8 *flags, int *ifindex);
-int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
-					    u8 *flags, int *ifindex);
-int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
-						   unsigned int id,
-						   u8 *flags, int *ifindex);
 int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 064ab3235893..0796122c9467 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1565,26 +1565,24 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 #endif
 }
 
-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 			    const struct mptcp_addr_info *remote)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
+	int local_id = local->addr.id;
 	struct sockaddr_storage addr;
 	int remote_id = remote->id;
-	int local_id = loc->id;
 	int err = -ENOTCONN;
 	struct socket *sf;
 	struct sock *ssk;
 	u32 remote_token;
 	int addrlen;
-	int ifindex;
-	u8 flags;
 
 	if (!mptcp_is_fully_established(sk))
 		goto err_out;
 
-	err = mptcp_subflow_create_socket(sk, loc->family, &sf);
+	err = mptcp_subflow_create_socket(sk, local->addr.family, &sf);
 	if (err)
 		goto err_out;
 
@@ -1594,23 +1592,32 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 		get_random_bytes(&subflow->local_nonce, sizeof(u32));
 	} while (!subflow->local_nonce);
 
-	if (local_id)
+	/* if 'IPADDRANY', the ID will be set later, after the routing */
+	if (local->addr.family == AF_INET) {
+		if (!local->addr.addr.s_addr)
+			local_id = -1;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	} else if (sk->sk_family == AF_INET6) {
+		if (ipv6_addr_any(&local->addr.addr6))
+			local_id = -1;
+#endif
+	}
+
+	if (local_id >= 0)
 		subflow_set_local_id(subflow, local_id);
 
-	mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
-					     &flags, &ifindex);
 	subflow->remote_key_valid = 1;
 	subflow->remote_key = READ_ONCE(msk->remote_key);
 	subflow->local_key = READ_ONCE(msk->local_key);
 	subflow->token = msk->token;
-	mptcp_info2sockaddr(loc, &addr, ssk->sk_family);
+	mptcp_info2sockaddr(&local->addr, &addr, ssk->sk_family);
 
 	addrlen = sizeof(struct sockaddr_in);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (addr.ss_family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	ssk->sk_bound_dev_if = ifindex;
+	ssk->sk_bound_dev_if = local->ifindex;
 	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
 	if (err)
 		goto failed;
@@ -1621,7 +1628,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	subflow->remote_token = remote_token;
 	WRITE_ONCE(subflow->remote_id, remote_id);
 	subflow->request_join = 1;
-	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	subflow->request_bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	subflow->subflow_id = msk->subflow_id++;
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 

-- 
2.45.2


