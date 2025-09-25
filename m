Return-Path: <linux-kselftest+bounces-42293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824BCB9EAEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9294A1BC7410
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A282F068F;
	Thu, 25 Sep 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUJqI38a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65BB2EFDAB;
	Thu, 25 Sep 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796398; cv=none; b=GMkjZ4uMyv1GNuxjCfIg0p9/1k4aBb2CxRANbK0RotrHvFRskzzo4DkB+9wxzakTwglmkK2n75fc47RymT/MpxQ3S4tD4DFiO8w08wVLpyxVMa5crvi2sCqzACra1GEmcCspAchBH/xk6iXB6A0fYbikhDZdYcZFWovaKRrmtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796398; c=relaxed/simple;
	bh=U6dovWEEvoN6nCJ0beF/XXCDsfv33Ju2yJUlCQUfl2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQoRxWjpkqsBKaPm3tZ5G3ZtPELdytiHKfIfoDoFnXHgDyGFneZNI/ozxSsWJYtMdzeQPa5ZDazZk4h4iKT1YlL5b6Ef6RPStBb26uu9ZTfqDZdtzdHNp/gmZHaiXmOg+fpgRNCfYfzOmixBgkER9mtXQ5JnBRCGDytx6g1/1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUJqI38a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD3FC113CF;
	Thu, 25 Sep 2025 10:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796398;
	bh=U6dovWEEvoN6nCJ0beF/XXCDsfv33Ju2yJUlCQUfl2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XUJqI38aMpaEBO8iMeqyBQIGgome86rcUNU3GGdGUlm7B/RvQet+uiZ+/E1/tdiHo
	 sSIBU23YuJ7s+oOWKqGIpXoUwGqi/56Hmq8xp6n+WqKt/G2vCHynPLp1ZrzATzsbYO
	 d5Y29h1UFqWMGkx7DxVz+1eaUWpxxCz0Wx4CrwWVWBV+v6Y3P7bs/d4qS6+fekue0S
	 mJOZTLx+sW9dcoHfrAZ3HBi+DtDm6QsCTUor1bw3xEAA8gnB75tZjSzqSMAB2hmMuE
	 ABN3+tpraHzgqODQ8K9Az0WX6fZRzIZiUmOTfsPa5+OlBEYILxVMcJjCLdtOlwCIFG
	 Zni7BiQXm/8Tg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:36 +0200
Subject: [PATCH net-next 01/15] mptcp: pm: in-kernel: usable client side
 with C-flag
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-1-ad126cc47c6b@kernel.org>
References: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
In-Reply-To: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6147; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=U6dovWEEvoN6nCJ0beF/XXCDsfv33Ju2yJUlCQUfl2I=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSgXF5ZgH/oj/2zo3v52dQ2DnJ5b/Zz2eTnMUmM2ru
 4rDUdK6o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLuvxkZNr24ZrhSPTvTmWti
 yCWR8DVpsombOsOjCno5VLqr558uYmR4xq77y+vpRx/1u3xLT/zfe8Dg+u2EprL7gaU9z/w/Hb/
 OCgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When servers set the C-flag in their MP_CAPABLE to tell clients not to
create subflows to the initial address and port, clients will likely not
use their other endpoints. That's because the in-kernel path-manager
uses the 'subflow' endpoints to create subflows only to the initial
address and port.

If the limits have not been modified to accept ADD_ADDR, the client
doesn't try to establish new subflows. If the limits accept ADD_ADDR,
the routing routes will be used to select the source IP.

The C-flag is typically set when the server is operating behind a legacy
Layer 4 load balancer, or using anycast IP address. Clients having their
different 'subflow' endpoints setup, don't end up creating multiple
subflows as expected, and causing some deployment issues.

A special case is then added here: when servers set the C-flag in the
MPC and directly sends an ADD_ADDR, this single ADD_ADDR is accepted.
The 'subflows' endpoints will then be used with this new remote IP and
port. This exception is only allowed when the ADD_ADDR is sent
immediately after the 3WHS, and makes the client switching to the 'fully
established' mode. After that, 'select_local_address()' will not be able
to find any subflows, because 'id_avail_bitmap' will be filled in
mptcp_pm_create_subflow_or_signal_addr(), when switching to 'fully
established' mode.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/536
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c        |  7 +++++--
 net/mptcp/pm_kernel.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h  |  8 ++++++++
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 204e1f61212e2be77a8476f024b59be67d04b80a..584cab90aa6eff4c01cdf4ca4d3dce8894829920 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -637,9 +637,12 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	/* id0 should not have a different address */
+	/* - id0 should not have a different address
+	 * - special case for C-flag: linked to fill_local_addresses_vec()
+	 */
 	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
-		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
+		   (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
+		    !mptcp_pm_add_addr_c_flag_case(msk))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 667803d72b643a0bb98365003b136c53f2a9a975..8c46493a0835b0e2d5e70950662ae6e845393777 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -389,10 +389,12 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
+	bool c_flag_case;
 	int i = 0;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
@@ -405,12 +407,27 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			continue;
 
 		if (msk->pm.subflows < subflows_max) {
+			bool is_id0;
+
 			locals[i].addr = entry->addr;
 			locals[i].flags = entry->flags;
 			locals[i].ifindex = entry->ifindex;
 
+			is_id0 = mptcp_addresses_equal(&locals[i].addr,
+						       &mpc_addr,
+						       locals[i].addr.port);
+
+			if (c_flag_case &&
+			    (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+				__clear_bit(locals[i].addr.id,
+					    msk->pm.id_avail_bitmap);
+
+				if (!is_id0)
+					msk->pm.local_addr_used++;
+			}
+
 			/* Special case for ID0: set the correct ID */
-			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
+			if (is_id0)
 				locals[i].addr.id = 0;
 
 			msk->pm.subflows++;
@@ -419,6 +436,37 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	}
 	rcu_read_unlock();
 
+	/* Special case: peer sets the C flag, accept one ADD_ADDR if default
+	 * limits are used -- accepting no ADD_ADDR -- and use subflow endpoints
+	 */
+	if (!i && c_flag_case) {
+		unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
+
+		while (msk->pm.local_addr_used < local_addr_max &&
+		       msk->pm.subflows < subflows_max) {
+			struct mptcp_pm_local *local = &locals[i];
+
+			if (!select_local_address(pernet, msk, local))
+				break;
+
+			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+
+			if (!mptcp_pm_addr_families_match(sk, &local->addr,
+							  remote))
+				continue;
+
+			if (mptcp_addresses_equal(&local->addr, &mpc_addr,
+						  local->addr.port))
+				continue;
+
+			msk->pm.local_addr_used++;
+			msk->pm.subflows++;
+			i++;
+		}
+
+		return i;
+	}
+
 	/* If the array is empty, fill in the single
 	 * 'IPADDRANY' local address
 	 */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a1787a1344ac1bbeefdb4548740d6aef980b79e7..cbe54331e5c745989af50409d9cb79c6d90a8201 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1199,6 +1199,14 @@ static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
+	       msk->pm.local_addr_used == 0 &&
+	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
+	       msk->pm.subflows < mptcp_pm_get_subflows_max(msk);
+}
+
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
 static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)

-- 
2.51.0


