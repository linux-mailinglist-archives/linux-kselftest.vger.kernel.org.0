Return-Path: <linux-kselftest+bounces-11387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DFB900827
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015691F27333
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B395D19A29C;
	Fri,  7 Jun 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg1kMVgT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E7319AA65;
	Fri,  7 Jun 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772544; cv=none; b=QKH3XaEdlinZ+HBAjgL/Dj7blRvTOD3leoHEqsCm+g6mZ4TAbbTyYNsZP8/2A/VHGMPCzKnm5q6dLZPCAN/N71N7myr6GSSh+QM8FEfrDL3j3W6uWagOGVLhypuwWf+MhO6ddxtW+v14DZZ3y1KSiGoJxxuOkCAUpRZlGspDTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772544; c=relaxed/simple;
	bh=8tlUhkdVvZTcWOukF/NW3k0yzLel5AlJwpWFwZu6gzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jgy/jPUqDg9uNSPovp0BtX35M333hHo45z018cSuhwvyUDWl0cDEcis1e2+llWh5vRWB3yS6XFiPN6efoWU2S+QZVl0qFX1k7+67RZJrhmBfUKf3dK/+RqaqHcXcljNxKjgCXOwkTwnwEhBLTP8C5oKXC4Sh2hZ/FdYLNuqqz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg1kMVgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369F9C3277B;
	Fri,  7 Jun 2024 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772544;
	bh=8tlUhkdVvZTcWOukF/NW3k0yzLel5AlJwpWFwZu6gzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sg1kMVgTwMXjYpwi5mRNtHmrDYrZLnxgCB4A8KTAtmshKpTodpOy+YecwmEFQ7/jZ
	 HX2UjoaeOZEpryiYjTneK/c0hu5CHZHa8wcic3qWGbLkDuyq90njh7Ui8PN7rVjfpb
	 q26PBwXPQkX2eYPPfT5JcTKXMCPGkubfF1p0/ikBRKB1Mjc72QorxxhF2vCXPi3RZ+
	 SqzNRg21AqLshBNnxXxzcg7/N2NaoNti+W/fHBlkvUISkfc888kBq+l6IqAweNisgi
	 ulwMgZ3UAPTuy4cPjhTI7vA7RGwXl9LWg1ZhLGBukY/DD6Qd1fKeeUntAQkCBHYJqo
	 BRO0BfRfgxQ+Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Jun 2024 17:01:50 +0200
Subject: [PATCH net 3/4] mptcp: pm: update add_addr counters after connect
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-upstream-net-20240607-misc-fixes-v1-3-1ab9ddfa3d00@kernel.org>
References: <20240607-upstream-net-20240607-misc-fixes-v1-0-1ab9ddfa3d00@kernel.org>
In-Reply-To: <20240607-upstream-net-20240607-misc-fixes-v1-0-1ab9ddfa3d00@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 YonglongLi <liyonglong@chinatelecom.cn>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3982; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zuXyd/+by14MmL5k443XIsgq2Iec/EOQmFET7b08UhY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYyDyeZUx4kMdg4+lvbY3f/ebVuYWN8NXlYzYu
 73X2AE0OfOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmMg8gAKCRD2t4JPQmmg
 czDeD/0Zf0M1V9mn2bjRhdU2EBrWLIH3EHax9QERfZSsc8q8SZQS/3VLgFnqInFAlFtGkBOavV1
 kawZ1CRrdmCZ2UXpS3kAFePbhHc2/b2hWUlDlQyXvnwAjDfh5/jefCXa5G53salv9t8ujbg/Jir
 RHK8YqF1LqMUDcAxRXPexVLh4mcUyr1TVaq3HRqoHx8Dp5GgokQ7N8QifViAEO1Ka9/4ZOu0rsE
 n+l7qElW5stYlyFG0OdIN8XhbC7DOT0HVsL5EmRzh+TEvgTj8nRQmLbwl0yw+dEAflwLJiCv1il
 d1YkfSo+P3em+YcjEDVG1S4xPKjt7FmuDYnLhaAotaRVn/eF17bQx9w7k94fI89g/262/eyczrR
 AV4jn2Fo4El0NoZNtOYLZL0hl+GZyu7h9MEp+JM7SQPw2RDaP0E5MOra/DSZq8ETFcZ1j0G4hYO
 S3YQbJFXM5BxAb3QBsvhIIlleDx8FOyqiA7wTC+M9e+GvxfIVAQjxBFKhNifgmnNAtgT17Ykfbs
 +nnjmoTcyhW46NnoHK8tEaNvxpF5n43e8j1vtRvZyzbOPkh1koL3gD+mEBln6h+P0EU49rJaywF
 aLdPGNmH8vbg5JeE0TsgS2P4JJ/Da6FFNVq/udwku6RNRwPPEWvzJkty670jjqfZSFpLON4QYQZ
 BUmFV/91p6DTrVw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: YonglongLi <liyonglong@chinatelecom.cn>

The creation of new subflows can fail for different reasons. If no
subflow have been created using the received ADD_ADDR, the related
counters should not be updated, otherwise they will never be decremented
for events related to this ID later on.

For the moment, the number of accepted ADD_ADDR is only decremented upon
the reception of a related RM_ADDR, and only if the remote address ID is
currently being used by at least one subflow. In other words, if no
subflow can be created with the received address, the counter will not
be decremented. In this case, it is then important not to increment
pm.add_addr_accepted counter, and not to modify pm.accept_addr bit.

Note that this patch does not modify the behaviour in case of failures
later on, e.g. if the MP Join is dropped or rejected.

The "remove invalid addresses" MP Join subtest has been modified to
validate this case. The broadcast IP address is added before the "valid"
address that will be used to successfully create a subflow, and the
limit is decreased by one: without this patch, it was not possible to
create the last subflow, because:

- the broadcast address would have been accepted even if it was not
  usable: the creation of a subflow to this address results in an error,

- the limit of 2 accepted ADD_ADDR would have then been reached.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c                          | 16 ++++++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 ++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 766a8409fa67..ea9e5817b9e9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -677,6 +677,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
 	unsigned int subflows_max;
+	bool sf_created = false;
 	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
@@ -704,15 +705,18 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	if (nr == 0)
 		return;
 
-	msk->pm.add_addr_accepted++;
-	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-	    msk->pm.subflows >= subflows_max)
-		WRITE_ONCE(msk->pm.accept_addr, false);
-
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
-		__mptcp_subflow_connect(sk, &addrs[i], &remote);
+		if (__mptcp_subflow_connect(sk, &addrs[i], &remote) == 0)
+			sf_created = true;
 	spin_lock_bh(&msk->pm.lock);
+
+	if (sf_created) {
+		msk->pm.add_addr_accepted++;
+		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+		    msk->pm.subflows >= subflows_max)
+			WRITE_ONCE(msk->pm.accept_addr, false);
+	}
 }
 
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index aea314d140c9..108aeeb84ef1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2249,10 +2249,10 @@ remove_tests()
 	if reset "remove invalid addresses"; then
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
-		pm_nl_set_limits $ns2 3 3
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+		pm_nl_set_limits $ns2 2 2
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1

-- 
2.43.0


