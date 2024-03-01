Return-Path: <linux-kselftest+bounces-5754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A0986E827
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAB81F22FF5
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EB93BB23;
	Fri,  1 Mar 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgY/IR6k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B263BB21;
	Fri,  1 Mar 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317124; cv=none; b=qhWlyUWdr6fj0uk50EbgvLA3pYFnBrUri+QNO/Cusx9QNLACtpC6FyDps19G5ENqkVlSy6rq+6D+6NJwhJ25AvopiVyTdHNZmRRhQNe4hzP/rU/mrtk0V+llhYYQ5iihFi4k1MksfFwFWIqj5ixmmKrg/6/queXRVaATbh6K9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317124; c=relaxed/simple;
	bh=wTNLhVtGoV4ze+fIYMOM7sxbJFFWejuuzNnN9RQXZ6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XACZjUEpvxsAxuCo/5xqo2x6p4UQWkZB2lTuiT3omHpayUoWbamS+9WS8LpnMR8F2sLF0c4i+gSMzPs09HhwXw0tZ9LORSMrAU2NrEuudaM078zk6wQbLfSd3Yy+c7CZbAYUE8VJGYT+p1GkYrYViIY47x5Y90QrocraIUPR3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgY/IR6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94A1C43390;
	Fri,  1 Mar 2024 18:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317124;
	bh=wTNLhVtGoV4ze+fIYMOM7sxbJFFWejuuzNnN9RQXZ6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BgY/IR6knG5JPt1plb++/g2/xbWhydWrDRhmNsBFBr2oc4b8PTuSEQVPO/yVg055j
	 il55nf6L/l2/CH5+S//SwoqvYjVq7yE4KxyYL3aYGZ+FQoKKIpdJzJOEI1/0wjfiWp
	 wp+HhSZtKqmwMQyMZgt2Rpcm5L+EngoNqRez8+BcxJihwB01g0yHpXZBYUNlQ0fteb
	 YKV2InvljnWEyojlGuE13ATJBfQbcCpT9QoS3RPBl3zbF+Bw9OETf2kNyXatzZboil
	 OJjGj+uPm0OKzflW+R103VXpDyV+DVVelpN3pstFJqXnso0BXmd6bpBOmnH9Rs20cV
	 2fkZIkpuDAcSQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:28 +0100
Subject: [PATCH net-next 04/15] mptcp: add token for get-addr in yaml
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-4-dc30a420b3a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3262; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MtlF9xRmcwFi9Km9WSgOTuDFuVjLVFk9I1/xuUhE2Ao=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv0nW6PXRVfJh6Uq5hPPjIxpQId6iEyiF3u9
 KKR18JjC8CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9AAKCRD2t4JPQmmg
 cy7MEADkZr+/SOv7/ekJ2zg6eU0zFGPNsuwRKvruhBg1XYsUi9Pki4zhlz4NKqCpweabc+sP7EO
 j6ncKk6s2TJuInE70nLtYGu3ErvO4+z/1o+ekerbOUwotu8cOiEI7OcYflBr5vhAAkXyvIxUBdq
 ycI58RY/iwYUNYQZgYrMSmVa5AHDE0i+DfgkEkb//JWv3FR2RcknCsdnUYgQ7Wi/jqvy9X5hJd6
 7FDwt0HLi/FwbsCFsdzCws+gihZbkKyoe10PxOFjeMZekoc55m7E80wGGwgBXq6J/FaDZCKua0+
 wsQo7FpzhoTp9wjGZMB47C24DoOsrLZ03uZrZz25fvL6nH+kdMdzECmu6XW21hvqf733hqiwEph
 U1QLuYHZFZKrIT1WCHZVAWRPbtJmlMglzoBSMxRtWP6b6kTCMxmFoKX/LHOnx9BRrwgy/2IOISE
 f/CKngKX/VLuU+kOiQOQFJBc0bUlihzIDoi7gUieVadvFLKtGbU9NgQ2oqHpnuh8BQaLIAelC0T
 ylaoAyIdq9kwTrt6mJEpG6K0V2bt3ROCj/aASZ7hdUBRN0PmjhL3FGaszo+uLCfcVZsSj4ULVSk
 +AMQ5vnBP+pynMvUsKsd7RlIudXuY6oOc4bIWNrKV67e/KqENltkvF4iFnyZoAer8IplgsbT26P
 MCOaCJB7RmO3hCQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds token parameter together with addr in get-addr section in
mptcp_pm.yaml, then use the following commands to update mptcp_pm_gen.c
and mptcp_pm_gen.h:

./tools/net/ynl/ynl-gen-c.py --mode kernel \
        --spec Documentation/netlink/specs/mptcp_pm.yaml --source \
        -o net/mptcp/mptcp_pm_gen.c
./tools/net/ynl/ynl-gen-c.py --mode kernel \
        --spec Documentation/netlink/specs/mptcp_pm.yaml --header \
        -o net/mptcp/mptcp_pm_gen.h

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 3 ++-
 net/mptcp/mptcp_pm_gen.c                  | 7 ++++---
 net/mptcp/mptcp_pm_gen.h                  | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 49f90cfb4698..af525ed29792 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -292,13 +292,14 @@ operations:
     -
       name: get-addr
       doc: Get endpoint information
-      attribute-set: endpoint
+      attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
       do: &get-addr-attrs
         request:
           attributes:
            - addr
+           - token
         reply:
           attributes:
            - addr
diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
index 670da7822e6c..c30a2a90a192 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -32,8 +32,9 @@ const struct nla_policy mptcp_pm_del_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1]
 };
 
 /* MPTCP_PM_CMD_GET_ADDR - do */
-const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1] = {
-	[MPTCP_PM_ENDPOINT_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ATTR_TOKEN + 1] = {
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
 };
 
 /* MPTCP_PM_CMD_FLUSH_ADDRS - do */
@@ -110,7 +111,7 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
 		.doit		= mptcp_pm_nl_get_addr_doit,
 		.dumpit		= mptcp_pm_nl_get_addr_dumpit,
 		.policy		= mptcp_pm_get_addr_nl_policy,
-		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
+		.maxattr	= MPTCP_PM_ATTR_TOKEN,
 		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
diff --git a/net/mptcp/mptcp_pm_gen.h b/net/mptcp/mptcp_pm_gen.h
index ac9fc7225b6a..e24258f6f819 100644
--- a/net/mptcp/mptcp_pm_gen.h
+++ b/net/mptcp/mptcp_pm_gen.h
@@ -18,7 +18,7 @@ extern const struct nla_policy mptcp_pm_add_addr_nl_policy[MPTCP_PM_ENDPOINT_ADD
 
 extern const struct nla_policy mptcp_pm_del_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1];
 
-extern const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1];
+extern const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ATTR_TOKEN + 1];
 
 extern const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1];
 

-- 
2.43.0


