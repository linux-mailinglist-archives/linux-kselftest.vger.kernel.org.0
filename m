Return-Path: <linux-kselftest+bounces-5763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A235C86E847
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21011C2456E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F7441C9D;
	Fri,  1 Mar 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb6KLFwz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275EB4AEE3;
	Fri,  1 Mar 2024 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317152; cv=none; b=ZQjz1YaVihHjOCPmZ1iW2NeF4x3YVIDzorCSCSUvID/1l4BbC/zsPfdy2SvoWP4VcjiR+fTFHzo/LIAW5oMjH3EePStf6kjEvKc8LoTxNYlaF89GzDLaPcNf8FwNr7/pP1MPqI5YHbPj2s0TooDBsAsRn/gT84S/IEJPsfSniVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317152; c=relaxed/simple;
	bh=ftxWlvSkyud4JIR0kHVv+D1eaBJrq53jEN4m1t5wNmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPdgjcUsXNew2IZ/HYw6FUvO5bib3L7QFuPOyRg2qJ+0iw/xpha3MffVPCHdtyHzy/9S2TTcJoiVbQL12C3d2u26yZDgBvUiqZGvAFuUw/LwtOTB563kDsiFCNUtte0+vwPgRAymP0dwalRpG+HW+jXvjq/NL5yMuSHYVfNk7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb6KLFwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277E9C433F1;
	Fri,  1 Mar 2024 18:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317151;
	bh=ftxWlvSkyud4JIR0kHVv+D1eaBJrq53jEN4m1t5wNmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mb6KLFwzppaCk202Z4xfKBuoC6NfaivMwcKdi1p3avxGd7G2Y2Z2/B5OGYsMFf2Ej
	 /A5JiNvdKXfgqTsQ/S1wQCeNjuKWEVntw5scRK6UpDe3FsJk+j7dIX5ai3k+RshQgx
	 JUU/qXmQLd52J0cULQ+5vSTaApPlAgXMQTJQxBmNSop7lKgTl6onYkL0X4+d46cRqr
	 i06ee2kzEXKCYB2H0aAYOIsQgdeikxTABbWyJqNtKOAii0Uo7MKDLs09X8tMdaxD/8
	 2hWd/iGzpWURgKozflsVGDyj5GedLgO2948kdBVhvLm5+8ZJIibq3Y6eWu/uK2V3T2
	 V4F4nm7rJ/0Nw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:37 +0100
Subject: [PATCH net-next 13/15] mptcp: get addr in userspace pm list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-13-dc30a420b3a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kWrNtSIvcuktz5WQJgULwtb+VPOtTG0YHa/xJdB0O+E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv1HEblhPOiq8/DzZwl5AJz9GirvRxq3Ajkv
 IFLOmauDk6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9QAKCRD2t4JPQmmg
 cxeDD/98ij393Txa86ah0ySNUhx1S1MCisDTw8MC6dA6Aww4ElVxTDCH6xtIq12foeWKibFHoKn
 G0BCLgbDyCS8slPnw/oSvfq/1tKx7OJTYWq0R9IbSb11/E8HjJ3qOe81pO1SMZ3NXwJy30pZNe0
 HE+1E9+nY5TaPZAZ8KKjyiHMLkueEZZpDBF5ryV92kyU4Mdz+GZyzYM+1ph3bjINxSVB4mcVZLN
 Bjl2MU0oYvYVEOWpBssxZ+j1Fdw1a10E3lHGZPjmhZs5ztfBbamVfJC4JloiO5ktuLYqIYsAilP
 E7mq+xs/pNIzUBz3hKEDzvBMxdWoza74HiHVTtxF/QJthPKofaxe0uoJAMf7LCmvQDuR+vDpuXD
 8SJ7qf6g6MI/CtxzF41ngRy3neAE7mgzN1hdG2G2gYyQIDu1KHg7cMv6ivHeBIebJTjMTSn/8Y+
 f7FbtNlB0WYMqpoBBLGQh7Xznzhd5kFVtF6YwO58jW6INsZNstVrIq0GZ8pr50WyCWJRYQp6iXN
 K5cAv2EGHwoU1hdsYrEgBTJNgs1RYtPnOF7cx+fMAh7taQvz8W50lOsGK6dxzoWA10NUVyJND5M
 K64kAksDd43UDaCLABF3BI5txGTN7Ydlgr1pDi9Es9FgTXa5g4ybSDZyZKGSpBeR2J4139QC5EW
 iOCFZHVjGp8lBZw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch renames mptcp_pm_nl_get_addr_doit() as a dedicated in-kernel
netlink PM get addr function mptcp_pm_nl_get_addr(). and invoke a new
wrapper mptcp_pm_get_addr() in mptcp_pm_nl_get_addr_doit.

If a token is gotten in the wrapper, that means a userspace PM is used.
So invoke mptcp_userspace_pm_get_addr() to get addr in userspace PM list.
Otherwise, invoke mptcp_pm_nl_get_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 7 +++++++
 net/mptcp/pm_netlink.c | 7 ++++++-
 net/mptcp/protocol.h   | 2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 193198cec74a..b4bdd92a5648 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -441,6 +441,13 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 }
 
+int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_get_addr(skb, info);
+	return mptcp_pm_nl_get_addr(skb, info);
+}
+
 int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5fae35b6b305..16f8bd47f4b8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1672,7 +1672,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1722,6 +1722,11 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_get_addr(skb, info);
+}
+
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bf708ddbef5f..264b73a8b48a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1047,6 +1047,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
+int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info);
 

-- 
2.43.0


