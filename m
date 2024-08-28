Return-Path: <linux-kselftest+bounces-16516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E7961F84
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB4A1C238E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884F016B752;
	Wed, 28 Aug 2024 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4XmCGIA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE41553B3;
	Wed, 28 Aug 2024 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825726; cv=none; b=GbmceofggP81zLgazkWGtUiwXP+QtqszWxLekEBg2UeiLqQYFD+7wa4PuWvYTysPPq1z9W17zDNIZ16wutZfDy1rKe/zJzjzIYBp6aeWGebWHfW1xylkOKJ83WDl61S2zuCzNW1zESM6JYkad0x5R7kY4awO8lX/hEdntOoHeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825726; c=relaxed/simple;
	bh=xdzWHXYy5hg4851VghxZtTa4uJdKioKLDBgA8yThRTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnQrFlTxidsX7Me3gtQxOYBSUOOwG+blwClU3+VVVgtZWxmF6dTL7XPwt8IllsxLvpUqk7KvVtZ/6Tf6NkPpN4EmESeomCsyCOzw5L7jtxdU9BbODD9FGBuFa+9Aty6dsGBWr902hgmSIiz04Qzjqq9UI+QCCBXzDSWRF2XGV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4XmCGIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5670CC4DDE7;
	Wed, 28 Aug 2024 06:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825726;
	bh=xdzWHXYy5hg4851VghxZtTa4uJdKioKLDBgA8yThRTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g4XmCGIA8JRCWo2DCUYF3dAOF57sHTLh3PKdvU0uaMbXqQE4clkxNDAvZYnUXRBSC
	 aHedtX18rLY16Roclo8r1/iflLswXeayKKGGRQ1j9DKvp+b4iPZFxCStUOEQ935jvi
	 eB3DGYx9EL3EAY7tOFlG3ZH6ckxRNdRvTetM3UeKCYmd33B3LRAeBDqCmFlQjDUkEk
	 otl1Ttgll38XuZy1j80GfsSbR7sFYq915Bl2jXOZxVK8ElNiNH7cODKkFhq4Tpwvme
	 TlCRw/xsEpqALHWzLAsZTbR9MQJixW+4gwVEO+cc09rIVNwBDmb0OwnHVsr9AC6ugD
	 221WWGRddZAIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:38 +0200
Subject: [PATCH net v2 15/15] selftests: mptcp: join: check re-re-adding ID
 0 signal
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-15-7f11b283fff7@kernel.org>
References: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
In-Reply-To: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3437; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xdzWHXYy5hg4851VghxZtTa4uJdKioKLDBgA8yThRTc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBI9ajw0YtF3NaFy0RSMeA+bxN34HGKoIdcx
 tY/ONk2nC+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ASAAKCRD2t4JPQmmg
 c/GkEACZ/z1eBGLnvR+vJJgv11yemk4KXWMWMssCkCIB9qwJqbW/dM+X2ffJYAP4ha1OvRlQr3e
 fib3Auiyw7F6Y1Zih31FR6DOQWL+wYl0twVDdEVHJYqwPrn7z3UOzsLwDWWnexl+ygqtBbd8k8X
 TaCPR5N5+udS9w6LfZ5SnmEVGbtUDq7ZoUKPrchSzQPPqoEaaAJA/4u3vPlXvNF0U136By+Tj7Z
 8vBmZxq0fNn2DwB5x0Ckt4Zz7QLi/NzZQa4Jfdu7vez6NCOMuYXmyeV6cAvtx2/UCGvkqXJAaw2
 D8zZiGtyj71AY4Xfw4zdWVuQ/zHQO70Rj69a9mEoVAR65saNZCD4OVJDDEBT5MNsj2596ka/67M
 2y5TyRcPzeAE30pA1rPxtbrVa1oBlkILsg0r/efXuQtC/QyxqdDhVcaYLDZnD7E6alqWZBhPxey
 kqbBNAcnkdF1YtuRzk6l1CZRfSf4jTSZ5B99EqEkyPyPLHYG+U+ObB1Ug0xbK7usAhttLMl+gYO
 vAjYbrhX9pyeymmffl1tVzZ4olGfN47IEnH3Bx/BcQn38yXCmKi4eKHGcG9MQkeuk84WbaGbWU/
 TNHWfDQf0mhFHYfDUgpPrrnDD4IKugbN/ZrHHVt26Y8yKfGWlojBayrdN66x7P+/ByO38WbWHBT
 Ai7BpuvWy6fDnjw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete re-add signal" to validate the previous
commit: when the 'signal' endpoint linked to the initial subflow (ID 0)
is re-added multiple times, it will re-send the ADD_ADDR with id 0. The
client should still be able to re-create this subflow, even if the
add_addr_accepted limit has been reached as this special address is not
considered as a new address.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
  - Make the connection longer, to have time to finish all the endpoints
    manipulations when executed in slow environments. At the end of the
    operations, the connection is killed, so it doesn't make the test
    longer. (Jakub)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 32 ++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a8ea0fe200fb..a4762c49a878 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3688,7 +3688,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		test_linkfail=4 speed=20 \
+		test_linkfail=4 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 
@@ -3717,7 +3717,17 @@ endpoint_tests()
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 3
+		chk_subflow_nr "after re-add ID 0" 3
+		chk_mptcp_info subflows 3 subflows 3
+
+		pm_nl_del_endpoint $ns1 99 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "after re-delete ID 0" 2
+		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
@@ -3727,19 +3737,19 @@ endpoint_tests()
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 0
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 5
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 3
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
-		chk_join_nr 4 4 4
-		chk_add_nr 5 5
-		chk_rm_nr 3 2 invert
+		chk_join_nr 5 5 5
+		chk_add_nr 6 6
+		chk_rm_nr 4 3 invert
 	fi
 
 	# flush and re-add

-- 
2.45.2


