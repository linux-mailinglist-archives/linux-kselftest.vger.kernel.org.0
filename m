Return-Path: <linux-kselftest+bounces-42295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E607B9EB06
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99B61BC7C4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D302F60A0;
	Thu, 25 Sep 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ibg79sS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975302F5A30;
	Thu, 25 Sep 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796404; cv=none; b=SpNL/qBIdDwpDQIgFnGsDyUg6RS1UL45tSZpExYiHMkBQrZfsGE7D6K9tjLRlevBqdjx+T8j1fupaVrhQkm4aekUbOg4FbM5ssr2/li6NorREat9tOQQasKQhrpMVMc9Tz4mBvUJa7mNpNHIqd+GWj+ZmtlWFRzIlvQNU026ArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796404; c=relaxed/simple;
	bh=1YswCZArMoSnckSBCESwAGR8ARwncPEfUz2MMr47ZXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUkbwCQ3S7gLQx81ZG68o3kaH5FMEfkEgXylXAsLQlLNeEPfwp4AQziDBurL13HqEEpbh+Cr6JiQ97eXvU3MOkAnkWFC+bAgePcBuM3d+UiPZ4hVIVFjohcPhyMNBJ7Uw9SZQ7W5QkvQCq0SBF2tKkOyhB18keEa6Mhg7zmtPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ibg79sS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD284C4CEF0;
	Thu, 25 Sep 2025 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796404;
	bh=1YswCZArMoSnckSBCESwAGR8ARwncPEfUz2MMr47ZXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ibg79sS4PzdcsWvnRHovKa4Me91vwr2N3IqIx/Mw+RbyQyfVw5i+0KTkiNKzQcaOf
	 SSrcF+JETuaFMy/M7mQfYwcWffhUTFNwYPhjyjNlr000XYnU0zMZ9bSe9VJ9Y4e4w4
	 xJZ1kW3dlaF2qJ5jFG5CsBgn4bJXPciN7fJnwiZITZyIQrnXhrFKmeCIlJP6xNAguG
	 O361rXFedeMN534/wg4PIPSsQAFBTFpDc+AwbIb9NzHrKb/jz86tYfu+3SWVVY/Mer
	 4LItjwk6C0i3FRZsjQ2fl2P76wR9Lcu+IoIp4leYGjQ/ZO7GJDGqzOM6APT6HjRgss
	 AMKn/n+L6Belg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:38 +0200
Subject: [PATCH net-next 03/15] mptcp: pm: in-kernel: refactor
 fill_local_addresses_vec
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-3-ad126cc47c6b@kernel.org>
References: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
In-Reply-To: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7187; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1YswCZArMoSnckSBCESwAGR8ARwncPEfUz2MMr47ZXc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSoWW72II4jdN86zwnep97tLCL7+/Kc/d+PHErsl/L
 wpKH1t+qKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAibjWMDL0rE6+JbJrxMXPy
 jXWxzr8Cj/7Ws45aMCP3iPS07+JM+88z/FNvig95x5P1NebNxrKles8dY5ZsZhGZnH3LVsds8t7
 nt/kB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this modification, this function was quite long with many levels
of indentations.

Each case can be split in a dedicated function: fullmesh, C flag, any.

No functional changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 199 +++++++++++++++++++++++++++++---------------------
 1 file changed, 116 insertions(+), 83 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 8c46493a0835b0e2d5e70950662ae6e845393777..c8f2af2277c2c28bc7ad393bc4ef8507ddd3a875 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -377,116 +377,149 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
-/* Fill all the local addresses into the array addrs[],
- * and return the array size.
- */
-static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
-					     struct mptcp_addr_info *remote,
-					     struct mptcp_pm_local *locals)
+static unsigned int
+fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *remote,
+				  struct mptcp_pm_local *locals,
+				  bool c_flag_case)
 {
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	unsigned int subflows_max = mptcp_pm_get_subflows_max(msk);
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_addr_info mpc_addr;
-	struct pm_nl_pernet *pernet;
-	unsigned int subflows_max;
-	bool c_flag_case;
+	struct mptcp_pm_local *local;
 	int i = 0;
 
-	pernet = pm_nl_get_pernet_from_msk(msk);
-	subflows_max = mptcp_pm_get_subflows_max(msk);
-	c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
-
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		bool is_id0;
+
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			continue;
 
 		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
 			continue;
 
-		if (msk->pm.subflows < subflows_max) {
-			bool is_id0;
+		local = &locals[i];
+		local->addr = entry->addr;
+		local->flags = entry->flags;
+		local->ifindex = entry->ifindex;
 
-			locals[i].addr = entry->addr;
-			locals[i].flags = entry->flags;
-			locals[i].ifindex = entry->ifindex;
+		is_id0 = mptcp_addresses_equal(&local->addr, &mpc_addr,
+					       local->addr.port);
 
-			is_id0 = mptcp_addresses_equal(&locals[i].addr,
-						       &mpc_addr,
-						       locals[i].addr.port);
+		if (c_flag_case &&
+		    (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 
-			if (c_flag_case &&
-			    (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
-				__clear_bit(locals[i].addr.id,
-					    msk->pm.id_avail_bitmap);
-
-				if (!is_id0)
-					msk->pm.local_addr_used++;
-			}
-
-			/* Special case for ID0: set the correct ID */
-			if (is_id0)
-				locals[i].addr.id = 0;
-
-			msk->pm.subflows++;
-			i++;
+			if (!is_id0)
+				msk->pm.local_addr_used++;
 		}
+
+		/* Special case for ID0: set the correct ID */
+		if (is_id0)
+			local->addr.id = 0;
+
+		msk->pm.subflows++;
+		i++;
+
+		if (msk->pm.subflows >= subflows_max)
+			break;
 	}
 	rcu_read_unlock();
 
+	return i;
+}
+
+static unsigned int
+fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
+				struct mptcp_addr_info *remote,
+				struct mptcp_pm_local *locals)
+{
+	unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	unsigned int subflows_max = mptcp_pm_get_subflows_max(msk);
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_addr_info mpc_addr;
+	struct mptcp_pm_local *local;
+	int i = 0;
+
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
+	while (msk->pm.local_addr_used < local_addr_max) {
+		local = &locals[i];
+
+		if (!select_local_address(pernet, msk, local))
+			break;
+
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+
+		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
+			continue;
+
+		if (mptcp_addresses_equal(&local->addr, &mpc_addr,
+					  local->addr.port))
+			continue;
+
+		msk->pm.local_addr_used++;
+		msk->pm.subflows++;
+		i++;
+
+		if (msk->pm.subflows >= subflows_max)
+			break;
+	}
+
+	return i;
+}
+
+static unsigned int
+fill_local_address_any(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
+		       struct mptcp_pm_local *local)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	memset(local, 0, sizeof(*local));
+	local->addr.family =
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+			remote->family == AF_INET6 &&
+			ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
+#endif
+			remote->family;
+
+	if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
+		return 0;
+
+	msk->pm.subflows++;
+
+	return 1;
+}
+
+/* Fill all the local addresses into the array addrs[],
+ * and return the array size.
+ */
+static unsigned int
+fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
+			 struct mptcp_pm_local *locals)
+{
+	bool c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
+	int i;
+
+	/* If there is at least one MPTCP endpoint with a fullmesh flag */
+	i = fill_local_addresses_vec_fullmesh(msk, remote, locals, c_flag_case);
+	if (i)
+		return i;
+
 	/* Special case: peer sets the C flag, accept one ADD_ADDR if default
 	 * limits are used -- accepting no ADD_ADDR -- and use subflow endpoints
 	 */
-	if (!i && c_flag_case) {
-		unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
+	if (c_flag_case)
+		return fill_local_addresses_vec_c_flag(msk, remote, locals);
 
-		while (msk->pm.local_addr_used < local_addr_max &&
-		       msk->pm.subflows < subflows_max) {
-			struct mptcp_pm_local *local = &locals[i];
-
-			if (!select_local_address(pernet, msk, local))
-				break;
-
-			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-
-			if (!mptcp_pm_addr_families_match(sk, &local->addr,
-							  remote))
-				continue;
-
-			if (mptcp_addresses_equal(&local->addr, &mpc_addr,
-						  local->addr.port))
-				continue;
-
-			msk->pm.local_addr_used++;
-			msk->pm.subflows++;
-			i++;
-		}
-
-		return i;
-	}
-
-	/* If the array is empty, fill in the single
-	 * 'IPADDRANY' local address
-	 */
-	if (!i) {
-		memset(&locals[i], 0, sizeof(locals[i]));
-		locals[i].addr.family =
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-			       remote->family == AF_INET6 &&
-			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
-#endif
-			       remote->family;
-
-		if (!mptcp_pm_addr_families_match(sk, &locals[i].addr, remote))
-			return 0;
-
-		msk->pm.subflows++;
-		i++;
-	}
-
-	return i;
+	/* No special case: fill in the single 'IPADDRANY' local address */
+	return fill_local_address_any(msk, remote, &locals[0]);
 }
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)

-- 
2.51.0


