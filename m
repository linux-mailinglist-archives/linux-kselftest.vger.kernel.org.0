Return-Path: <linux-kselftest+bounces-15713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B179574E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2923A281DA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C8D1EB4BE;
	Mon, 19 Aug 2024 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgPcAxw3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A591EB4AE;
	Mon, 19 Aug 2024 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096764; cv=none; b=FL+fALye2jBCT15nb2kLPIX/Bza5coavWplNmvQeobFzQftfHFcAaOUMNiYuJUgIZItA/atzuApyMwrHn8zhruZXZYLGYSjPnA9QygtjoNi2GDOWLDIDO99tB1mo+2CJuX5NiH/ffSHU3AXrO4639IODSVg8vv5Nno4lnL4vlkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096764; c=relaxed/simple;
	bh=l4iKnwGhhsDMn8htcpUOxdszoLQDZFdyQCl5kbQWUFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxGBNFS9XsqIsKVKKgnoBfLTjR7C6tpOqwJ1xZV+GZMv/q2EzyDX53tWuN+rlr3fux9+lAdyw95+foDIgAJDdnUuBAglHLcb04LAgZLU3wvYErKWDz2yQZ8jxOVIIJ6TyiB6EBWKtOaXYUI40Hb5wZG0P90mSqDw4wgJn052lXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgPcAxw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739FEC4AF11;
	Mon, 19 Aug 2024 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096764;
	bh=l4iKnwGhhsDMn8htcpUOxdszoLQDZFdyQCl5kbQWUFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lgPcAxw3qoCSAzYT24ZvnovIOK7wNktRjNcYEr6O+mDcOln7NF1hKHrSQDtIp+dwl
	 3cJ9m0aZJMf91718UrILuF1ghKyFcMlavOQ7cWCVv0r0QSGaZnTjaw3CZUGHlZAAFL
	 q+G7oex+h7fvFVJDx6VC8a1W11IB2keuyUJEoZ8B2ACiXvcsrJkf0CZ0uwgVLWAR/e
	 6VfJXeidO8TYvGCubFH5wFhD6hl+rzYNjnIZYmyLLeWV0EUZP5MuX5exPfOqL/zDia
	 M9Xx4ElPO03DlYu74LkZuB/gbiG9LQr9AJSvHGGo8ngjyXHTdqRnqP8vg+FIBd9Pk0
	 Nw6U3fvEe3osg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:30 +0200
Subject: [PATCH net 12/14] mptcp: pm: fullmesh: select the right ID later
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-12-38035d40de5b@kernel.org>
References: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
In-Reply-To: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=l4iKnwGhhsDMn8htcpUOxdszoLQDZFdyQCl5kbQWUFE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DTY162plzd1LsvGwrZ1VIf7yOI1Ub0FAQko
 GMRiHAOlraJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0wAKCRD2t4JPQmmg
 cwivD/9imuKIhyv87CMIvPd+ZTZu8rB3zJaltXFudDU2tkC2/QfIMGzSOsJdzGUQvCn1C+uFeWv
 YSbKujUdFSYZ4Detq6YhvYtbnES3i2EFIjiATjsiADNhKO72RhSdCkb6OnqDhv+R+X5jJckxyog
 YhbIcKb8MxYuypnb05wnUuT/X5sm0lUdSadkRxIWJLQS/Ezw90fIquUd9E/MNNWLi5d6+fiJooN
 V3nTD79OKs/my1351dTZJ8T19HUlDa5CicuX1De36r+uKshc+cxSGba/cMOyq3CqFJlI6lfeC2H
 1d4C0vx19NmQVakU3mWwMADCrhmOW9zO6Cus9SD2izriGS3Xol5SKmgIdZlrmKVZkseErzw+zKt
 MMQmaKc5Jj4iYnB3gKCtbFM810ybC4omX1kLo5xq1ixLs4inQPHLCHwWVe61tzj6JP8+qTaligd
 tUKmXUEi5v6yOzoNfC2gyWPF7ZrGoYs/Lyx89hW/Y7nC/jud4R/F/ytcNx3fLW2O2c6XvcLN6ds
 zVXsnVJvIPcbvxox7budfV5ZnacC9UB2RiYVq0VScUteDJ8GWf1mi58BZ0UnytHpVs4i3vucjkJ
 OONZlagAZx615TyotjUtF7JWgDt2NwQaD1PDxL8Pyl7Um33D2NPF4U0NWnJlz08w49tuOWcNgMB
 BKQUQQBo67Ibjuw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When reacting upon the reception of an ADD_ADDR, the in-kernel PM first
looks for fullmesh endpoints. If there are some, it will pick them,
using their entry ID.

It should set the ID 0 when using the endpoint corresponding to the
initial subflow, it is a special case imposed by the MPTCP specs.

Note that msk->mpc_endpoint_id might not be set when receiving the first
ADD_ADDR from the server. So better to compare the addresses.

Fixes: 1a0d6136c5f0 ("mptcp: local addresses fullmesh")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d0a80f537fc3..a2e37ab1c40f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -636,6 +636,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
@@ -643,6 +644,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
@@ -653,7 +656,13 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
-			addrs[i++] = entry->addr;
+			addrs[i] = entry->addr;
+
+			/* Special case for ID0: set the correct ID */
+			if (mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+				addrs[i].id = 0;
+
+			i++;
 		}
 	}
 	rcu_read_unlock();

-- 
2.45.2


