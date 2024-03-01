Return-Path: <linux-kselftest+bounces-5755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2636186E82F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E042DB2626A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B89E3C47B;
	Fri,  1 Mar 2024 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k79Tnt2S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BAB3C46C;
	Fri,  1 Mar 2024 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317128; cv=none; b=iwW6AOZxsCh0YF0ckQp5FnmXTBhdBhGQBuj7jcWWYNYNuJ/t01w9ynThwHo+AzC0lfx2PhQLK1uaeGj7bdJ5va3K0XJVS4XMyehpYgyiuqr2Xjr5Ri2KQLXHnM+XcnQ5jvtbE8OzsD1jVwhr2S1YEbeLChzNjbyXOYpkZUsiTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317128; c=relaxed/simple;
	bh=MCwwm/uaOZTKaQ3CJuZ7Aqth/dw3YVtxCaMEr2Vs0mM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQMQIgPQVvYYSAFxOQAIu3JEUEgAGONcmKAooqJKaEvbpFnD2Kj23boOQrAcbK00sp2UJi0DtFha7esWhQEZ1r340NZKOr53ijr1P8n4uy76kpB2Tla5SaYTVrhJCUHfU+rZT9Kn4fdGOXYOTrkjIqF9RCi+DDASBTbM9jIQgm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k79Tnt2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DE4C433F1;
	Fri,  1 Mar 2024 18:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317127;
	bh=MCwwm/uaOZTKaQ3CJuZ7Aqth/dw3YVtxCaMEr2Vs0mM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k79Tnt2ShXxnBeAoXK/KEb6ktRUwk23q3/OlVtfVVY8zOrotSi+uTDf3paXQ8g0zk
	 rvgYfixa7Aj+3vhSsyc8DoZCUTI3ZmWIt4e02ZJmpySKF1pmgpko52JIgsKtuDmY4H
	 bsaphPJdwk66Ahz6AAXe0h1A5o3zez6gOu941qCMwRBl7NPB5Wup4oOCe5dBxT2NNu
	 t+IfUqh4Wl+UAxTv8m86hA+AXX1Q87dIgPevzQUPbt+uHGPGjjJgQP2c0DT7apl1Is
	 9bAs7QdQMEgyDtScbe2BwL8rV+f+tDhlTWhz2keahfyU5ixq3r3z68inc0EJ0BBGqK
	 pMnmiQqJRHUag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:29 +0100
Subject: [PATCH net-next 05/15] mptcp: dump addrs in userspace pm list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-5-dc30a420b3a0@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3274; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oj+WD2Qiz2y+QGN1F1vEBEbF15PvF2ufVBuTbZM1LxY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv0inT7v7SM31h5ojK6U8VeKvmWj657GgeD/
 vCK/3so8ciJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9AAKCRD2t4JPQmmg
 c+OAEACR+XRPTwiSXfGepQu9Lkq9UWoH/krsqtdkgyBo7VbNhPyyBbsyzEcElTqN101HIjcMFB3
 dv9L8Q6ndQvyL9pcBJoa4e8OybOz5wG+oNBEYHGjhg5qlE61pZvz/ctGdidNUY4CIbRUFwuRWwg
 S14FvS3HftztNvKY1pn8MTXsmDwmSbLY+WHdjo6I96FoKY2in2V7pleHY961Kl5L4Z9KpBOe9Rd
 5gtteNfjiCn3u8ziqmm++8agycNbGk64/gS1CMwU2jnAmX/kL28LeRLpe1NAmJXWOqm4iPkkEGO
 F57D133OG1PJOV+YSbLqRGLFrYbi8QrJDy4ayu8c2WeMaV7a/u29hH2tASgkADxBCA+o78WpDJ3
 CWLVMlbHXT19ulPT4SfnQstSfcje9p/DEFShoVqLN3bDSec/ZHjntAUeUoSreO5pzsX/8n2dxqO
 w2SYmUVxC6UX1snE+Xd3hCrvgEsx6MBWmyn0MpFYl0hF4TtC/Mn46aFrsJ6l0qb3AW10KtHPjXi
 e8W32dbMFAGqqVVoTeOifFtXEFfnjDBOUnJpz+qxotxN2ZOTu9COIZ7L/H0j7oxMPbNky5DY+qV
 C3HHek/RU7MBRgJBWyVP7XkYRwkdHNW/dujX1ps5UTO09trsPhNDxc9aVaziovzyZQBP0TfpWTA
 X7wxR9bgZx6e/Tg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch renames mptcp_pm_nl_get_addr_dumpit() as a dedicated in-kernel
netlink PM dump addrs function mptcp_pm_nl_dump_addr(), and invoke a newly
added wrapper mptcp_pm_dump_addr() in mptcp_pm_nl_get_addr_dumpit().

Invoke in-kernel PM dump addrs function mptcp_pm_nl_dump_addr() or
userspace PM dump addrs function mptcp_userspace_pm_dump_addr() based on
whether the token parameter is passed in or not in the wrapper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         |  9 +++++++++
 net/mptcp/pm_netlink.c | 10 ++++++++--
 net/mptcp/protocol.h   |  3 +++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 53e0b08b1123..193198cec74a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -441,6 +441,15 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 }
 
+int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_dump_addr(msg, cb);
+	return mptcp_pm_nl_dump_addr(msg, cb);
+}
+
 int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
 		       struct mptcp_pm_addr_entry *loc,
 		       struct mptcp_pm_addr_entry *rem, u8 bkup)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8cb887561e0..5fae35b6b305 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1722,8 +1722,8 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
+int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+			  struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1765,6 +1765,12 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	return mptcp_pm_dump_addr(msg, cb);
+}
+
 static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 {
 	struct nlattr *attr = info->attrs[id];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ab9c8004eb56..69338a6c040f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1042,6 +1042,9 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
+int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
 

-- 
2.43.0


