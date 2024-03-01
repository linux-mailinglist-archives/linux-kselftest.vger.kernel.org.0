Return-Path: <linux-kselftest+bounces-5752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4C086E82D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262BFB26C28
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C726F3A1A8;
	Fri,  1 Mar 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZGU6REx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9508C39FEF;
	Fri,  1 Mar 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317118; cv=none; b=P4gPn6BeuG23H70wFmp5Gpq5cH2gd9yg1l+hYS9+GJNavnN/97FvoKobzYZ3E3l9cKfztEztRpqQM8mTC17Az60WH9d7YwekLVRo77m3xQUWFzxHpWQ3oQKLTln1zRhhXf1HAZ7IAudp45JzuWbhUXm30otjsWWD6yhGmspw2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317118; c=relaxed/simple;
	bh=eScPtd27k6a2RMCsmgXPa3fVzwLEszi4ZWB1Hb7/NkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcUSFlHzYZNEwulHyYKJ09+B2ntfo3hJtTjF88zik9qT2LhyISpLFYS1UeNyktJsoWurljfZq/qOjkBlERtvUfB2F35zZnePVuGenCX700cCPPTYylM34pk479FM8vcLZWkxXg/v745/on9AORvI1ejc8AF3RDT8aCtLXdPZBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZGU6REx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6AEC43390;
	Fri,  1 Mar 2024 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317118;
	bh=eScPtd27k6a2RMCsmgXPa3fVzwLEszi4ZWB1Hb7/NkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OZGU6RExEJhoQaXKKrHO6opllpxZlqOmnKeDFyfBsBXFPvoMnhKmvK5QAWCIRsBz8
	 9dX8pOrXMO6v5WmlZHnrzI61e982AYzOb3ET3z1tGSG3jsiB6luFRi/8macRJpB5k4
	 bMtnxoAiLjrzROxDJlz6687h5aKh+C2s8nUCTvZ4DzgKJ+Ggx6k9kCYGVBqwI1mwvi
	 iZ+wpD561/TYl5OdnrhZH8Zu5KBtKohgQSEMvIhYRjjwFxd2nMjKJL3nIHuyvcnriU
	 YPuP6Pug+mRngtiXbSbvcM+UafxxUVE4FVTZCjIAOZfZicuqaIImQ7uBvHsLWB6ndz
	 uOYSZyOTudOvw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:26 +0100
Subject: [PATCH net-next 02/15] mptcp: export mptcp_genl_family &
 mptcp_nl_fill_addr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-2-dc30a420b3a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2543; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wqCWze8v4zdWHeq1IXu4TPUkM/xqaWNcPQAM2nOwuyA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv0RAbW8CCvneg/shfdH2PXLY/tcVDkWkLXx
 uFkaYeBueKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9AAKCRD2t4JPQmmg
 c7vPD/wKT3FbQK5LVP6HMMrXdtrBBUGk5t2G08+0nnwmajDd2WcJGkplj/orpRVTDrFbkUjUoxa
 1mRkI+oAlFYo7jjFfED582DL/D6xsvXI+i6q7BOSUsGR0+5af3yalAiNwgBLjWddPztSKLIQD1T
 iVTPhC2s7Pxp0QpAeFW1UGEkvB0RRJ+/6lbFOwN6YDyumZ/uldoozkmepaxMRCBlR20YWBDYGDX
 L8fgmlL36ay6hl8c0rv20olMOE/+wbtW4jhVVclspFFfA6w8lnj3WsErL6B136eSc3D77HHgFxB
 i1wGUevJST699DXvSurmY0Pja3IkPmzgMUfzDkv/lDo+fgIQB49CC1qrfsIZD7tiS/ZHFvWhQPO
 k68EdlO3MxFZdKM1GTwlPekgfT8Hv8ObMvJD88khxjq9PXomQ4/VP+PU3gaW1Ssb2I4jynO4t9q
 xLndkbGszDTSo7z31CAdkhU1rOvfqPQVJZyaAeh2Mx11mE68JNnZm+tQ0/df0oTe0ke2n/4D3UD
 Ar0Q1FSnK3YUML2Qf7lzkqpomcxvpRwFbloIjsprXNkWGevtVAl8nnuDm4jD3n4yYp325btOOsk
 +ufsdutiZH9YJPd/QSRgGey2cC7lel023XR8rgXIhvWYrIejlo3ISNPlvrGTgguQPJMZ6ZxpTE6
 6/Ptx6JbkC98AOw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch exports struct mptcp_genl_family and mptcp_nl_fill_addr() helper
to allow them can be used in pm_userspace.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 9 +++------
 net/mptcp/protocol.h   | 4 ++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 80c537659922..e8cb887561e0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -18,9 +18,6 @@
 #include "protocol.h"
 #include "mib.h"
 
-/* forward declaration */
-static struct genl_family mptcp_genl_family;
-
 static int pm_nl_pernet_id;
 
 struct mptcp_pm_add_entry {
@@ -1636,8 +1633,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static int mptcp_nl_fill_addr(struct sk_buff *skb,
-			      struct mptcp_pm_addr_entry *entry)
+int mptcp_nl_fill_addr(struct sk_buff *skb,
+		       struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_addr_info *addr = &entry->addr;
 	struct nlattr *attr;
@@ -2281,7 +2278,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	nlmsg_free(skb);
 }
 
-static struct genl_family mptcp_genl_family __ro_after_init = {
+struct genl_family mptcp_genl_family __ro_after_init = {
 	.name		= MPTCP_PM_NAME,
 	.version	= MPTCP_PM_VER,
 	.netnsok	= true,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b85d1a8d111b..d70fb3bf5076 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -343,6 +343,8 @@ struct mptcp_sock {
 #define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)			\
 	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
 
+extern struct genl_family mptcp_genl_family;
+
 static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 {
 	sock_owned_by_me((const struct sock *)msk);
@@ -974,6 +976,8 @@ void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflo
 				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
+int mptcp_nl_fill_addr(struct sk_buff *skb,
+		       struct mptcp_pm_addr_entry *entry);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {

-- 
2.43.0


