Return-Path: <linux-kselftest+bounces-4796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE53856C6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183BE2825A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1013A250;
	Thu, 15 Feb 2024 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYLlcY6M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5C413A248;
	Thu, 15 Feb 2024 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021544; cv=none; b=V/+B7nyP9qX3V9a3unknPxtFbnnL8BsttT3gXrS1dgP4uOqfXySfLQ+pB221HlrLlIx3HZalWJuUMrsFHSByjJZpBF1P2RB74sJnZBnLYcpyeTXl24uk/A0NCQicvuj/4ddg7g/WziZslCjPrEgLq2zx51a7T9sszqYDSGk2PWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021544; c=relaxed/simple;
	bh=TLNtJSmJT4K3/W4FxZHb8No2F0zaMpy2B5q0q484CfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rUFQDXvcXaGv4yoVYoKu5QeEmOM+bPVKhVhEZyvnxRZ95ht4OmAlj5QcTI06J4qpzhyBDyB2og3zw3+RQa/vIXDe0Gzkdg31mxROwhJ/Om0ppal9Zys0FiYQQsfRIMQ8jtzsVUFpniLohfIYxEhb0acSRGP3sqLw6orcIf9qemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYLlcY6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093D5C43394;
	Thu, 15 Feb 2024 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021544;
	bh=TLNtJSmJT4K3/W4FxZHb8No2F0zaMpy2B5q0q484CfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XYLlcY6MyhsZbb6WGDBU8WYMdjSg1OrXlIK4q3CZzwpx+oF5vzc2QY7qpCimPOQ4L
	 ssLuBHPHbEgv3QQmO1a2ohFwK2ARsI/GoztmEyNLyrtE9kDXV1MW4mi0hZARJ8DkIJ
	 aC+AdexVSPAOfhcJY26f4rRuB5MT4WbwEcMdGSbsnJO+wrQPAfwufXsbDG2lE2SHAM
	 V53obrPomwSI6NCS5ypJpmX3ENHIcncrU1BMHKTRuDTcnehijUuDmehLwoXrMUM5m/
	 6k5mIRxjkIy3CdHSotbC4rgX3DLY0LipEmgPT+ZBvLLb/TiQqUciIcX7QNnNzXgpWU
	 PfsLdAA1+T1JA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:29 +0100
Subject: [PATCH net 02/13] mptcp: add needs_id for netlink appending addr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-2-8c01a55d8f6a@kernel.org>
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3209; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=iuITD/hKkENPzn19h1Lnm4q3SQB2KOC2z7d4DpfDq0k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcckP2ZdgSCyKKwvr7D2wVc1WxBIQH7PGWrY
 LW1QcUH5pGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHAAKCRD2t4JPQmmg
 czzLEACrCQivCeCBiu2GXkiATG3dUET+CAxtWT/5ds+eqKL80ySow+PoZyycqE+oQeCn6BgDbwC
 uSNtOh7wFay5QtvJmNm8IsDzMM/lj+JPx/zF/hIX1MdQUerYp96YsOsHLdREqH+Ob4BXjMZPCz0
 yV2q9ohUXvFtMBmkfeYoxI4bG9tU3um2n+p3hE98QOWIOFYhZ5bZ3alOP/dZnjHZYxu6K0WRCiM
 Ff2EDKRGtdBmVkwpdUQORL5RB7YwrwmBQMXEvD0LZG0quWCMj3hYM/4crTeZDJfFdqY8KEWnTLf
 22UspRBBlCM0cvN83uVviZvtfuYeQS96eXtko+b+3sCUEVsGWvmPMmYMw2Rjg9j1ZMYyDQz6PVq
 3Yk2YLTFb8I030Li/5DMlgc2oiONLDTO4WoY1zRCItj2Wq0NjK3+fKInqMXo22gWS2W2lpKlMQ/
 xLlPHg/+60JCVBx2k07t2jLZa71sY/3e6kG3UrMePD0qrqfucKGRUMv5d2rz4nvG0dUux+/l4X7
 CoLBFdQTp55AhdEllowADKPe6njYBPVa9bfx7ItAJGBcHDFOQZtH84AHqpj6LtZCPTMHCUOqSoW
 qXEFeRZ/oLOK0DgkWOMgKxbDdfTt8ouR+AHk1cAmEL6P/j/csD1gprLnIESwM37NiuYgoyyjzEN
 //9OiObr3/fuouA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Just the same as userspace PM, a new parameter needs_id is added for
in-kernel PM mptcp_pm_nl_append_new_local_addr() too.

Add a new helper mptcp_pm_has_addr_attr_id() to check whether an address
ID is set from PM or not.

In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
needs_it.

Fixes: efd5a4c04e18 ("mptcp: add the address ID assignment bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 287a60381eae..a24c9128dee9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -901,7 +901,8 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry)
+					     struct mptcp_pm_addr_entry *entry,
+					     bool needs_id)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -949,7 +950,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && needs_id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -960,7 +961,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id)
+	if (!entry->addr.id && needs_id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -1092,7 +1093,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1285,6 +1286,18 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 	return 0;
 }
 
+static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
+				      struct genl_info *info)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+
+	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
+					 mptcp_pm_address_nl_policy, info->extack) &&
+	    tb[MPTCP_PM_ADDR_ATTR_ID])
+		return true;
+	return false;
+}
+
 int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
@@ -1326,7 +1339,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
+						!mptcp_pm_has_addr_attr_id(attr, info));
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;

-- 
2.43.0


