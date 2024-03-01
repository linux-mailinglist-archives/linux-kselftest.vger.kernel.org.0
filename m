Return-Path: <linux-kselftest+bounces-5761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 743E186E83E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43921C21A64
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383453F9D3;
	Fri,  1 Mar 2024 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXBjRdJs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4EE3F9C7;
	Fri,  1 Mar 2024 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317146; cv=none; b=SXY/acuxrayTMMRcficutyJAoc5fLOoAWZOtPnwcwNY9iTGaEjHJ9t43oGowsp7OE7HjuVcaRpwjnWkEzJ9H7LKQAK0dNQlk87hzFU0uvKmXUMjMYWi51zYW2FVXdyok1b0Gins/U+po9YsE+D8uRqu+1mbTXvNJiCxy5gF7+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317146; c=relaxed/simple;
	bh=z/5POAELw1PHTkVL0aqXKZ5amRaEjiv/LOrcYZGujqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGhjyEmfAD+3x3Jn/WV6K9KRJYc0wEIV+daUHrsTOqsnknuOE6xLDV6/kWDtT/DkekWfZeFYtJU+NEe6LW+rjD/qQU/Hmi2DuUyGAbJhnyOBy1vu/PQ+GVhUujF91XdOIEZYz9y5i7LOyjtkkBaXT6bqvIwWRcdPQXoM9rZysWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXBjRdJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A2FC433F1;
	Fri,  1 Mar 2024 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317145;
	bh=z/5POAELw1PHTkVL0aqXKZ5amRaEjiv/LOrcYZGujqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pXBjRdJsjTX2aMxgusbAG43/sFVEVjmA/oF5b4FcGeSye8BdxfabE0RqGdqt1+LFZ
	 BWJhS8bV1pATTKQ+6nGWjq5NtC8vX3jBV5R4k6m4nr7uT90eKGpBJCnN+2BKFdJ7ds
	 ZxYTS0iHOQaapvsli3BT/oD8NNyB0YOOky9sdHEXLXQxEyK4tvAKxE00iKKQru+yxO
	 nN3ihxMyfkP92IpQm4RxqnNWXNDurENgCkrhp+Li1i/+XbZ+KeuN7OSqU58jlSQSh2
	 sSwfH1Hm9M+p1a5R758Nv5emRXWQmr/+jCYEW4XnPDphLWWQJ1cTj+T39XkcysHinP
	 0dhykl4z98WKQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:35 +0100
Subject: [PATCH net-next 11/15] mptcp: add userspace_pm_lookup_addr_by_id
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-11-dc30a420b3a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2595; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=U2czlffcBsy4JlpV9GrJ3SPQqb0W1M1Z+QVuJlygMyU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv1DXnxGU86u3wUasNTA8QFyoFvBQucpOmXZ
 1v1MjR1e2CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9QAKCRD2t4JPQmmg
 cwByEADlh9JuiXdIH3gjlDlCDPYGEdHxapyKQXxIXXRBmgUrOJhHthPWmshqMr6AXAW+yl/mAgD
 VkFTZQolxOCP85yq8GDJQezz39PzT4tSvcEu9tPg7ZHQB23NuZS4pct7Luw+yt52cc/nMu93CH9
 KY8sTo6XxVYlEs7SfBAPRkn56wZdoUyRuRRPy3/D7LaqREm5w2//cSTAoIhlCWkCo3voG1kjr8I
 QmD7TWIA48hSP60Ngq/5ltiFIZI44AIcGcX6k55psYp9oK7Fb7UBq0GipGl9O+aUpCgV2EKo9B4
 6E50oCTa8tBOxthFkn6xAj+pZ+v8rXw/my4pAnoVY5cTbdnQBgmTN1EFN4lbwkmDA0UIhbz3rmT
 UTmGBXvu/R5Xl9QUsnMsMTvploHuRwyVotQ8oEgI6uvWf9zBDF5ybvOHSW7PclDaoFL4hDWfcXr
 QunqEwFiB5XJ1BKN7Mvh78u3C+FXiNC0rTtHAZbkz/Gah91eNSKgqOw0eMy9m9x8KRkxkgl25bR
 r9pV8NY+LF5Ugz1G2PdhK27XRs+v/3VVN8SxkCrFUPw1gOUSHwZW+T1AHxpVMXfuMqA+WqGuEyP
 YqEllHkGiVp1QqHYU1O+0GmZlb6BSx3U1JCD5ZFU+2M8geJ16d0OgA+SC+q8STkr68WMHs0hgEh
 12VbdYyuu/Rxy0Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3bd13e94b568..20cbcb62cd8c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -106,19 +106,26 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -261,7 +268,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -298,13 +305,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);

-- 
2.43.0


