Return-Path: <linux-kselftest+bounces-14308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7C793DE9C
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 12:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D19AB22736
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB957D40D;
	Sat, 27 Jul 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mqmi80Z+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653A7D3E4;
	Sat, 27 Jul 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722074623; cv=none; b=H4GsYOCUMRGAprVQl82HExPlof4Z7jPZP7Zb4czPLiAfXpLJuoi1JSzt35w6gvAT/JQISMaQ+pJxnhgQyOCmXN2Vn/gAW5Tb7mTkBeW3NnJPlJ1iIsxG7PL0n7yAfiBoZVQHsRLG8RFUZG9yVOY+2XWBfAtvJvJs5L71VwziNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722074623; c=relaxed/simple;
	bh=3eBeJjC4t1puEN/DFkciKEIb9P2a1z/Rqf7oJB53lzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQL35Q7gxKERfKwS2sYqyC1w85Nginl0CeURb4GSD0pmcMbQWzaT3dcqn/kA93t2AbxqwgXM6VlTTrD7rZftsdE808J/jJw1mqjwBl1Ec2FUVcx7Dq9ipQpuRYXJHpdyZIsYqr7i+gHtorKqiuF7/lUuXB/7izvKZPzwkkY+3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mqmi80Z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC07C32786;
	Sat, 27 Jul 2024 10:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722074622;
	bh=3eBeJjC4t1puEN/DFkciKEIb9P2a1z/Rqf7oJB53lzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mqmi80Z+YcU/hMOVO9dxBKFa7YmZ+uZKhxDHD6ImR9OWBcl9jtYA32hoBsm2f/v8u
	 iw7OzS8ihbYN4bNU7cDWQVCB8f4uqHtOvc1yBZTNpOR9tlj+iLW5Yc02JAx8NK/Xzr
	 ddb6MNMHybIUn7wCiQlb3tSD/eTn/hXVdrAMTHz01ZmoAPE6FaamXnU2UcRqEotCh+
	 9/cE+iVPT8LuxG9rojFw3ZKD5La0Ibkb+50gabk0vhB4ulaEUUvSrwtDeLoGZxcxjo
	 JdUpc6KAH8EjBBDdVrw66QJ0YxSi0xzK13qgZmkzmTqHWGKvH4Rp4Pdj+lPqgj3ZSo
	 rVgRzdGRSKwoA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:28 +0200
Subject: [PATCH net 6/7] mptcp: pm: fix backup support in signal endpoints
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-6-f50b31604cf1@kernel.org>
References: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
In-Reply-To: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5482; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3eBeJjC4t1puEN/DFkciKEIb9P2a1z/Rqf7oJB53lzY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMXm48IiIoe9TbUuJLqVBqHwCV4EWiQHsBIjZ
 oqKlwv1wDKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTF5gAKCRD2t4JPQmmg
 c+upEACoj2je6IWxQFx+/Dtzy1HWILngsJ9yAq/LzaEXW7yz7bG6SHpGCu8ad2/KpOOc0R8e+1K
 mh/u+KbGedjxmArJgxoxf/TOucdQNW8jKnwvpnDQAedPE53p/5/h5gKkeVZZfgRBjzWYZe7p3MK
 r4xkPJeanEPuL4uiwylcDJw/MdbKOvRLJmxI1XSZ/9hLU2gNvD4hn5ZuZuPPgnyxEm1vx1FGNGs
 SWLiChvFUUoOjJqwecb9UqBVFCduzt1Eh8zidElb5P10FgX5/kwH3YhanaQ2wio+rb3QOTQ1pxQ
 dv/McdigEHDcxBjioiFIjBUNJRvErdKHT0hcVygEeoUDEPpknhf6ce1IVXJXe3Htd3OgqJVzsvI
 51NuIQSpORum2JawUAaxdi/Aibqjx6PY6GUiEtk7gQwMtA9Yn1gg6Dsvly/q3fIK3kJbK2xStfK
 Rfiq4YH2vZiHHtG+FLVIJyr4x2Gnounc3Aa1XkHg4++6jULdN9DXHw3Qw02wSAGmDlPK5a8ezOp
 9R26ak+c2UR5skCY24l63xvxM/Dn4vnv3auoxd4r4RgNl+77F1HGDMQ4RMorkQblwe3Ez0aWfcO
 7GxaxXZVl3Tl0ElilMLnU90U3e4BimLXb7U512D1kJmYNE1oitcrwYwpotxeol4fYCggArwKyoF
 uPEX06czsp8cnMg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

There was a support for signal endpoints, but only when the endpoint's
flag was changed during a connection. If an endpoint with the signal and
backup was already present, the MP_JOIN reply was not containing the
backup flag as expected.

That's confusing to have this inconsistent behaviour. On the other hand,
the infrastructure to set the backup flag in the SYN + ACK + MP_JOIN was
already there, it was just never set before. Now when requesting the
local ID from the path-manager, the backup status is also requested.

Note that when the userspace PM is used, the backup flag can be set if
the local address was already used before with a backup flag, e.g. if
the address was announced with the 'backup' flag, or a subflow was
created with the 'backup' flag.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/507
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 12 ++++++++++++
 net/mptcp/pm_netlink.c   | 18 ++++++++++++++++++
 net/mptcp/pm_userspace.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h     |  3 +++
 net/mptcp/subflow.c      |  3 +++
 5 files changed, 54 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 55406720c607..23bb89c94e90 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -426,6 +426,18 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, &skc_local);
 }
 
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
+{
+	struct mptcp_addr_info skc_local;
+
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
+
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_is_backup(msk, &skc_local);
+
+	return mptcp_pm_nl_is_backup(msk, &skc_local);
+}
+
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
 					 u8 *flags, int *ifindex)
 {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 59527335c68e..85346db71d0f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1101,6 +1101,24 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	return ret;
 }
 
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	struct mptcp_pm_addr_entry *entry;
+	bool backup = false;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return backup;
+}
+
 #define MPTCP_PM_CMD_GRP_OFFSET       0
 #define MPTCP_PM_EV_GRP_OFFSET        1
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f0a4590506c6..8eaa9fbe3e34 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -165,6 +165,24 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
 }
 
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	bool backup = false;
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, skc, false)) {
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
+	return backup;
+}
+
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b8b25124e7de..60c6b073d65f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1109,6 +1109,9 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index be406197b1c4..0e4b5bfbeaa1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -100,6 +100,7 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
 
 	return msk;
 }
@@ -620,6 +621,8 @@ static int subflow_chk_local_id(struct sock *sk)
 		return err;
 
 	subflow_set_local_id(subflow, err);
+	subflow->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)sk);
+
 	return 0;
 }
 

-- 
2.45.2


