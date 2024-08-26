Return-Path: <linux-kselftest+bounces-16297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3335995F5C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDED21F23538
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF54197A7B;
	Mon, 26 Aug 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbdAQDQi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF881197A66;
	Mon, 26 Aug 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687974; cv=none; b=qe1bCloluTPDuc5XxiB1uEiSB5NWh4b83r2E5zXlMtJjhmajOuyigFDjLaDFIOf8YBw3dxTNJc/hD36xLlEuWKFZC2PxEqBBdgTPKBTRNAy2SQaBGJepB1SZPwdZek/vaw4+rnYHAgPV6xt2uzX58ijdnR7fSQRifTnJ0FnAP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687974; c=relaxed/simple;
	bh=p0kyHCAmBWmo++X4fkmrWosQeS0ZfREeOzPeG1DHAbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3N1FMv5qBW9wUzcF8BRSLuehcWHijD2owVDrkPvhW0/4wJ2tIp04VUB1PoVT5R1xuRxJYN8rR4xVagwhhAWHDZOUvHg6FrJ0AoygBrB4hwSy1VXRPq7brteZ0WtThj2JeDRbCrwdVOH9Sc7VI6X4tKNVG1YYJxiatw85Wf0dNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbdAQDQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65491C4DDE5;
	Mon, 26 Aug 2024 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687973;
	bh=p0kyHCAmBWmo++X4fkmrWosQeS0ZfREeOzPeG1DHAbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TbdAQDQiryI0/yk0vN5GEeYhx1ekGso+Hh1oarWs4rrxhky5k1GAosdXiY/bpty09
	 CzZReXDSIkfLBWFekRpxcUEX26H7S6XpNt/XJsmr4gQnaJPQdgSQ1XjyPGtL8a9M/J
	 vjT3FtaJl017dVRFuKzihJBtBcp8QCvmtTtIp44ED25Caz4cqnvHCqfxz90BPTaWCp
	 KaElbfO2wEIOhVFDtSF8ZSHRyIdT9cn4VLFGHsCBVJ9cqyv5xpA4Vrlp06hIT5LP7g
	 T4YMxmNHnJyxNwu/rLkhJ3r3gu5jXWo+erdTSSqkDR2+LPd9ltP4mFt8BwiQtUfBlF
	 BwMW1GuxLr5dg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:02 +0200
Subject: [PATCH net 03/15] selftests: mptcp: join: check removing ID 0
 endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-3-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=p0kyHCAmBWmo++X4fkmrWosQeS0ZfREeOzPeG1DHAbs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZWXs417NozfGuopBXKoHLVFs5XV8DYFr61J
 suDYKkM4aSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 czOYD/9WVbhgQjmdS7iWv7QF9zpcDiSix1W6uwlnVNgJokIANQkrfbxEPHeddjygEwz9Cf98YTC
 pGWA2faBAI7T8eHv6x3aeulMrk17n6zdbHUgtyrz3WWqqv6xAtDl9ox2dVJj7tpg6PygM+wpCrm
 FYLYxADhWc3x3PKSDKVI42UonJeS3T659t148d63+t59RSZ8PgKTrjF8lZglSMkefTFrE/1+ZkQ
 0ZdOzH88CHpeAf7dkewZctnsJ2zTzTIDVnBlm+mGkDgO1z5Gji9v1L0y9qMPNMpYAJPH2RdwUAg
 ybDA8/xRZusvYrfYmxuGCWcs52Z0x3yWnjY7IrOIYZjOnl5yBq6cBziVrGN7NC2A866dMu+yKHo
 5ro84/o1NBVGlbsE6Uv/9hhJpQmRVyItW5peVFgxcK45+vORdD1er7LpcbI5Mzqz1hy6wLVE3aq
 UvNrXNlS/p0/FMcYjN2/aYe2nmx9+T+8Dr9FGRrBha6YV51ZCI+jVhl9RjmqMCSTLH+T7M3w7kS
 MxfXWkbusyhp+3hT/zI4ReE6GJTo4iNWfkLqVDu972zGZtWlcEdDrf/WEmVp5WbG63CPf7O4tYA
 TSlXEjbg9uM9Mp8po3z2Umoq21NrTxVILd0YERqwWILBDWv2/2ymB8aSaMjQQSDxrxt+O8syN3U
 dGyPa41KcH8nNiA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Removing the endpoint linked to the initial subflow should trigger a
RM_ADDR for the right ID, and the removal of the subflow. That's what is
now being verified in the "delete and re-add" test.

Note that removing the initial subflow will not decrement the 'subflows'
counters, which corresponds to the *additional* subflows. On the other
hand, when the same endpoint is re-added, it will increment this
counter, as it will be seen as an additional subflow this time.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 89e553e0e0c2..d2dd48a539c5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3575,8 +3575,9 @@ endpoint_tests()
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 0 3
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
@@ -3585,17 +3586,17 @@ endpoint_tests()
 		wait_mpj $ns2
 		pm_nl_check_endpoint "creation" \
 			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
-		chk_subflow_nr "before delete" 2
+		chk_subflow_nr "before delete id 2" 2
 		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
-		chk_subflow_nr "after delete" 1
+		chk_subflow_nr "after delete id 2" 1
 		chk_mptcp_info subflows 0 subflows 0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 2
+		chk_subflow_nr "after re-add id 2" 2
 		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
@@ -3610,10 +3611,20 @@ endpoint_tests()
 		chk_subflow_nr "after no reject" 3
 		chk_mptcp_info subflows 2 subflows 2
 
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		sleep 0.5
+		chk_subflow_nr "after delete id 0" 2
+		chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "after re-add id 0" 3
+		chk_mptcp_info subflows 3 subflows 3
+
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 3 3 3
-		chk_rm_nr 1 1
+		chk_join_nr 4 4 4
+		chk_rm_nr 2 2
 	fi
 
 	# remove and re-add

-- 
2.45.2


