Return-Path: <linux-kselftest+bounces-8520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE348AB8C9
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 04:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9555281F33
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A678BEE;
	Sat, 20 Apr 2024 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO85k0jY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD3846B;
	Sat, 20 Apr 2024 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580558; cv=none; b=FhUCcYaKkRi7KrP7Vt+egqe149tiPgOkzYkK2HKmuh2bMgY415fqgtthQL7WArLP6rHTiS+Qun/lRxTTF7Zi1Y/69+RNygukNFuhv3J3hUfYDwJAYiWU60hYw06WqTN869s+nv6KcCGRsFqVirX6Id8Ff56qEznqMm7lPpt2esg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580558; c=relaxed/simple;
	bh=spQJtF/HsP8yoN5+KzKsqhBojxsYdBcRuNU80ChfsUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4yPTbEnG7E6khgjgKJ4xMrE0WGgupqnamnlMLBp+KjDFQaUACOoYWmVAvNut4K1NOYaqc2zW9HsDBqKVEt3AfU8dAesmKTaTp5kV72phuvdx8hYBJvd7IkzXpOAk2dQO+NWKAJYkm6NP85reQZQ6IMKSyKv32jh2IKkCs7NjtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO85k0jY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F575C2BD10;
	Sat, 20 Apr 2024 02:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713580557;
	bh=spQJtF/HsP8yoN5+KzKsqhBojxsYdBcRuNU80ChfsUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fO85k0jYNwJnRkR9WX02vYYauE+qjt0DhLo0OzWM0xkwF8zVh7z2uUittp4LBKUZQ
	 I9wuM5Ue8gJT8Fad2LPRIYrcdcuOhO2XyQ64R9wl43hZQhrvPY94ebI95P+Rn2AgHN
	 PnybFxwpLKMp3zi8uPndZLz+EgNVNgL3oARnEdXbGTQXriZLArfKsNffq1ts50jPa/
	 XcZTNoaQRqBempKfJp61LiTXRHUeEattCo4+2ykR3pkwud/cfrorZx5cS6SDgokhbM
	 kdRis06G2P0/h77TAlutqHblWGKcG2dO1dgr5cDDVzFFa16taQA2dxK7MAWBVOywxJ
	 KfrwF4GiZT2AQ==
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
Subject: [PATCH net-next 2/4] netlink: move extack writing helpers
Date: Fri, 19 Apr 2024 19:35:40 -0700
Message-ID: <20240420023543.3300306-3-kuba@kernel.org>
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

Next change will need them in netlink_dump_done(), pure move.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/netlink/af_netlink.c | 126 +++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index dc8c3c01d51b..c5bb09597831 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2165,6 +2165,69 @@ __nlmsg_put(struct sk_buff *skb, u32 portid, u32 seq, int type, int len, int fla
 }
 EXPORT_SYMBOL(__nlmsg_put);
 
+static size_t
+netlink_ack_tlv_len(struct netlink_sock *nlk, int err,
+		    const struct netlink_ext_ack *extack)
+{
+	size_t tlvlen;
+
+	if (!extack || !test_bit(NETLINK_F_EXT_ACK, &nlk->flags))
+		return 0;
+
+	tlvlen = 0;
+	if (extack->_msg)
+		tlvlen += nla_total_size(strlen(extack->_msg) + 1);
+	if (extack->cookie_len)
+		tlvlen += nla_total_size(extack->cookie_len);
+
+	/* Following attributes are only reported as error (not warning) */
+	if (!err)
+		return tlvlen;
+
+	if (extack->bad_attr)
+		tlvlen += nla_total_size(sizeof(u32));
+	if (extack->policy)
+		tlvlen += netlink_policy_dump_attr_size_estimate(extack->policy);
+	if (extack->miss_type)
+		tlvlen += nla_total_size(sizeof(u32));
+	if (extack->miss_nest)
+		tlvlen += nla_total_size(sizeof(u32));
+
+	return tlvlen;
+}
+
+static void
+netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
+		     struct nlmsghdr *nlh, int err,
+		     const struct netlink_ext_ack *extack)
+{
+	if (extack->_msg)
+		WARN_ON(nla_put_string(skb, NLMSGERR_ATTR_MSG, extack->_msg));
+	if (extack->cookie_len)
+		WARN_ON(nla_put(skb, NLMSGERR_ATTR_COOKIE,
+				extack->cookie_len, extack->cookie));
+
+	if (!err)
+		return;
+
+	if (extack->bad_attr &&
+	    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
+		     (u8 *)extack->bad_attr >= in_skb->data + in_skb->len))
+		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,
+				    (u8 *)extack->bad_attr - (u8 *)nlh));
+	if (extack->policy)
+		netlink_policy_dump_write_attr(skb, extack->policy,
+					       NLMSGERR_ATTR_POLICY);
+	if (extack->miss_type)
+		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_MISS_TYPE,
+				    extack->miss_type));
+	if (extack->miss_nest &&
+	    !WARN_ON((u8 *)extack->miss_nest < in_skb->data ||
+		     (u8 *)extack->miss_nest > in_skb->data + in_skb->len))
+		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_MISS_NEST,
+				    (u8 *)extack->miss_nest - (u8 *)nlh));
+}
+
 /*
  * It looks a bit ugly.
  * It would be better to create kernel thread.
@@ -2406,69 +2469,6 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(__netlink_dump_start);
 
-static size_t
-netlink_ack_tlv_len(struct netlink_sock *nlk, int err,
-		    const struct netlink_ext_ack *extack)
-{
-	size_t tlvlen;
-
-	if (!extack || !test_bit(NETLINK_F_EXT_ACK, &nlk->flags))
-		return 0;
-
-	tlvlen = 0;
-	if (extack->_msg)
-		tlvlen += nla_total_size(strlen(extack->_msg) + 1);
-	if (extack->cookie_len)
-		tlvlen += nla_total_size(extack->cookie_len);
-
-	/* Following attributes are only reported as error (not warning) */
-	if (!err)
-		return tlvlen;
-
-	if (extack->bad_attr)
-		tlvlen += nla_total_size(sizeof(u32));
-	if (extack->policy)
-		tlvlen += netlink_policy_dump_attr_size_estimate(extack->policy);
-	if (extack->miss_type)
-		tlvlen += nla_total_size(sizeof(u32));
-	if (extack->miss_nest)
-		tlvlen += nla_total_size(sizeof(u32));
-
-	return tlvlen;
-}
-
-static void
-netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
-		     struct nlmsghdr *nlh, int err,
-		     const struct netlink_ext_ack *extack)
-{
-	if (extack->_msg)
-		WARN_ON(nla_put_string(skb, NLMSGERR_ATTR_MSG, extack->_msg));
-	if (extack->cookie_len)
-		WARN_ON(nla_put(skb, NLMSGERR_ATTR_COOKIE,
-				extack->cookie_len, extack->cookie));
-
-	if (!err)
-		return;
-
-	if (extack->bad_attr &&
-	    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
-		     (u8 *)extack->bad_attr >= in_skb->data + in_skb->len))
-		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,
-				    (u8 *)extack->bad_attr - (u8 *)nlh));
-	if (extack->policy)
-		netlink_policy_dump_write_attr(skb, extack->policy,
-					       NLMSGERR_ATTR_POLICY);
-	if (extack->miss_type)
-		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_MISS_TYPE,
-				    extack->miss_type));
-	if (extack->miss_nest &&
-	    !WARN_ON((u8 *)extack->miss_nest < in_skb->data ||
-		     (u8 *)extack->miss_nest > in_skb->data + in_skb->len))
-		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_MISS_NEST,
-				    (u8 *)extack->miss_nest - (u8 *)nlh));
-}
-
 void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 		 const struct netlink_ext_ack *extack)
 {
-- 
2.44.0


