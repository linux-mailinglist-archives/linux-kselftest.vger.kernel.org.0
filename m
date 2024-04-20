Return-Path: <linux-kselftest+bounces-8519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452A98AB8C7
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 04:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7681A1C20A56
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A356FD0;
	Sat, 20 Apr 2024 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKcDwhyU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F36FB0;
	Sat, 20 Apr 2024 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580557; cv=none; b=C6zXWYr/FED7CKGbXCO+BpPDP+VzB5H4MHYfGTVtVncVyXzjY93ovmozRoFEleTVMtNLklr+102NttTRuiOPci/6v9V2uMsP7oEEcIdNkc2K1+tiVJm3OkyPgSCYSttgWugRmQaFeuuWIST8m6JqsDUAM1xtRVZB6AcrdSS6kzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580557; c=relaxed/simple;
	bh=9s0PpQWr+QekpYHM80WK83YbLRvMu+xsycegi6JRwoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlB9mJbtP0MhgZfaoIbhh2e1Au7cIb8QoQ7qvsn1v0yvPMEyoFtCPDkQkv3KDPkuoZcJ6z3klRyIvSFbTnb+ZtUGqhNq71S0N8Gcmtp+V5E8F+S5vYGgWuoITPRr/f9ns/oJHKTOT0vdGefFDMY8p8TiVTxsQv0liaYeDVpZ0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKcDwhyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E504C32782;
	Sat, 20 Apr 2024 02:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713580557;
	bh=9s0PpQWr+QekpYHM80WK83YbLRvMu+xsycegi6JRwoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKcDwhyUtlxyE2rnnvzoQcaDVaXqUWzTl97q1c2w5WX2M7MfJubVJawK/52xtyBSt
	 3pGkhgA8cYX15LriihvFCyqQE1Psqi8nsBzh9cYvWb1ZmdVdZGF914N0acEwLAxnUc
	 OjRYz+g1tvc3QU+idpW+wb0LpzwpMfARXaVpjU/f0Y4fk3MzpOdzL2WdIKQh/Z9N/5
	 flw2bA24Kwv2wk+7yX7sSbsJaYIWYHvBpW8vD6idkVkRTkiTjCFU57iHl7t6p41+0l
	 GRryejlcvFh6wmjci7CmymRn/t2sz8cWV5ScN3fEBjMLXJRaH5ZI0oKMV+oBhJf5QX
	 uhwaEDnHWaMZg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	amritha.nambiar@intel.com,
	linux-kselftest@vger.kernel.org,
	dsahern@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/4] netdev: support dumping a single netdev in qstats
Date: Fri, 19 Apr 2024 19:35:39 -0700
Message-ID: <20240420023543.3300306-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420023543.3300306-1-kuba@kernel.org>
References: <20240420023543.3300306-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having to filter the right ifindex in the tests is a bit tedious.
Add support for dumping qstats for a single ifindex.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml |  1 +
 net/core/netdev-genl-gen.c              |  1 +
 net/core/netdev-genl.c                  | 52 ++++++++++++++++++-------
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 76352dbd2be4..679c4130707c 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -486,6 +486,7 @@ name: netdev
       dump:
         request:
           attributes:
+            - ifindex
             - scope
         reply:
           attributes:
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 8d8ace9ef87f..8350a0afa9ec 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -70,6 +70,7 @@ static const struct nla_policy netdev_napi_get_dump_nl_policy[NETDEV_A_NAPI_IFIN
 
 /* NETDEV_CMD_QSTATS_GET - dump */
 static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTATS_SCOPE + 1] = {
+	[NETDEV_A_QSTATS_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 	[NETDEV_A_QSTATS_SCOPE] = NLA_POLICY_MASK(NLA_UINT, 0x1),
 };
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 7004b3399c2b..dd6510f2c652 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -639,6 +639,24 @@ netdev_nl_stats_by_netdev(struct net_device *netdev, struct sk_buff *rsp,
 	return -EMSGSIZE;
 }
 
+static int
+netdev_nl_qstats_get_dump_one(struct net_device *netdev, unsigned int scope,
+			      struct sk_buff *skb, const struct genl_info *info,
+			      struct netdev_nl_dump_ctx *ctx)
+{
+	if (!netdev->stat_ops)
+		return 0;
+
+	switch (scope) {
+	case 0:
+		return netdev_nl_stats_by_netdev(netdev, skb, info);
+	case NETDEV_QSTATS_SCOPE_QUEUE:
+		return netdev_nl_stats_by_queue(netdev, skb, info, ctx);
+	}
+
+	return -EINVAL;	/* Should not happen, per netlink policy */
+}
+
 int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
@@ -646,6 +664,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	const struct genl_info *info = genl_info_dump(cb);
 	struct net *net = sock_net(skb->sk);
 	struct net_device *netdev;
+	unsigned int ifindex;
 	unsigned int scope;
 	int err = 0;
 
@@ -653,21 +672,28 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	if (info->attrs[NETDEV_A_QSTATS_SCOPE])
 		scope = nla_get_uint(info->attrs[NETDEV_A_QSTATS_SCOPE]);
 
-	rtnl_lock();
-	for_each_netdev_dump(net, netdev, ctx->ifindex) {
-		if (!netdev->stat_ops)
-			continue;
+	ifindex = 0;
+	if (info->attrs[NETDEV_A_QSTATS_IFINDEX])
+		ifindex = nla_get_u32(info->attrs[NETDEV_A_QSTATS_IFINDEX]);
 
-		switch (scope) {
-		case 0:
-			err = netdev_nl_stats_by_netdev(netdev, skb, info);
-			break;
-		case NETDEV_QSTATS_SCOPE_QUEUE:
-			err = netdev_nl_stats_by_queue(netdev, skb, info, ctx);
-			break;
+	rtnl_lock();
+	if (ifindex) {
+		netdev = __dev_get_by_index(net, ifindex);
+		if (netdev && netdev->stat_ops) {
+			err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
+							    info, ctx);
+		} else {
+			NL_SET_BAD_ATTR(info->extack,
+					info->attrs[NETDEV_A_QSTATS_IFINDEX]);
+			err = netdev ? -EOPNOTSUPP : -ENODEV;
+		}
+	} else {
+		for_each_netdev_dump(net, netdev, ctx->ifindex) {
+			err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
+							    info, ctx);
+			if (err < 0)
+				break;
 		}
-		if (err < 0)
-			break;
 	}
 	rtnl_unlock();
 
-- 
2.44.0


