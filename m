Return-Path: <linux-kselftest+bounces-15705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390B09574BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CDE281CEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2D1E211D;
	Mon, 19 Aug 2024 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt64JPBo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11641E211B;
	Mon, 19 Aug 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096739; cv=none; b=qY/wMukFzj3nRS29Lfn/T4t05/xah28Afh9j2FrWgjiYcYU4usVOJJ7pPWiDyAmBYGXJ8ZNBytmJx18aSeYDBawbNSX3zwuVxnzoVlTA8PNQhG8HOXzpnW3VC6ICJ2KEL7H/NDUNXCq8HGMJrzVs+svM3D8f7F1H0712F80HUQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096739; c=relaxed/simple;
	bh=KyL1tUwzalesCFQEM6xvcAjmyyEPD5yGT+YavTU6wv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jTe4jzFycey3bKrrjFFv6oTbzirIi1Iv0kLE2gNqctJ9/pUwVW62G0/vXtHw6TEAJ1Uu6d5aOjLGkdSAtuKRvrqGzVAhzFpd9ywOf7aQLWXJRYdx6Gu55Vhy4yafj7mFqGdtdu/NlvHZQySl6se2PvIjlbwZnRbIcOM2KAKe7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt64JPBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282DCC32782;
	Mon, 19 Aug 2024 19:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096738;
	bh=KyL1tUwzalesCFQEM6xvcAjmyyEPD5yGT+YavTU6wv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dt64JPBowDSrJzTtJC606z+1MxranD32jWE+cfBp0kfCjz/lXb5qDOe80J8kXqTCw
	 N5fnDy1Jhm43Kf2zrPWWjbvi1JvssFBgw1HrkpWESFrArOE2qFFlDkt/fAr7yBTb4u
	 pKqjlUsU6lltAVeGf/I4ATWpqTf6giaGRowUrBBtCCTdyARCsH+cq5d7ePAcTZmPSS
	 QTXgjCauxPR/0nMX69OcGZy4WiTkaCBk0+U5oD5nTUP/eHdS67Jy3lmIbknOoa7UFO
	 cFPLsoWV7Oganl7yAEunCn+/uBytF7ZLjjWR9ix9656vk5R6ZUY1F5mE1AJ7ATrkOQ
	 JyBfdx/ljHrEA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:22 +0200
Subject: [PATCH net 04/14] selftests: mptcp: join: check re-using ID of
 closed subflow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-4-38035d40de5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3051; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KyL1tUwzalesCFQEM6xvcAjmyyEPD5yGT+YavTU6wv4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DSw3YsLw4l+9VZXlEaeIGDqXqFnijOr7WUY
 4E4NoHMvfyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0gAKCRD2t4JPQmmg
 c7+MD/oCRfzXefVY9gyVcQDTFoixW/fNHOENIGdacb6XLbe/zzxUbJyHsqruG1UVPMdhhoaKuDk
 BxD/d5gtTw/QNOGGAEfkFJRZGc5K2/l+48N2GnitP+ygKyrHROJx6mOMYL+6Xr4f5UssxpYp4XB
 H5I6rsqvpaTP+5K6ENm235fziumgE0ehLSOI1S2bbvqRDdldE3VahA6J/D05Nkpb5mtdMfG/BWf
 /v9ewQJQ36IlvsGK7feURoGC/pIK+S2VMVd/WrY9U2dbp1O2GDM8AhL69wHP0mCviaq9mCqTv5N
 9Z3okQZBlj9oGh7lZbdaeZhbKH3T+IqeuXxATmZORJwiEQ0fdUaMYL2b3GeOcL7njv8K9FGjIfK
 wPsz/aiEhwdo2a4xxAsVVb9V3AGwgoL4GPQ/SWbsYgkWrzDeKwWMfVW3+ZjGEr9LyhHDKhG4EsL
 QtNq9VLa2beXalLN974fRX+GI3on2CFVp3UENcfRMHBPlEASFFhYPJJmaC4vY8/BwVFAzHBtA7r
 YTLE3roEupItItt4JTt/3y2h4hDOTV8AQOOXeGOfkbyGhjaeU8O5PbzqEVwIoO0UQqOoZ7lk6FQ
 zmDp4kVJMQK99C+zgbR2YnJuEWkWW2+Y2kJ8ssawmD6yR/8SQjAsWAApACDmXtxVk8Crk7Mq5wK
 zl/FPmh63717/Hg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete and re-add" to validate the previous commit. A
new 'subflow' endpoint is added, but the subflow request will be
rejected. The result is that no subflow will be established from this
address.

Later, the endpoint is removed and re-added after having cleared the
firewall rule. Before the previous commit, the client would not have
been able to create this new subflow.

While at it, extra checks have been added to validate the expected
numbers of MPJ and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 27 ++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 25077ccf31d2..fbb0174145ad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -436,9 +436,10 @@ reset_with_tcp_filter()
 	local ns="${!1}"
 	local src="${2}"
 	local target="${3}"
+	local chain="${4:-INPUT}"
 
 	if ! ip netns exec "${ns}" ${iptables} \
-			-A INPUT \
+			-A "${chain}" \
 			-s "${src}" \
 			-p tcp \
 			-j "${target}"; then
@@ -3571,10 +3572,10 @@ endpoint_tests()
 		mptcp_lib_kill_wait $tests_pid
 	fi
 
-	if reset "delete and re-add" &&
+	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
@@ -3591,11 +3592,27 @@ endpoint_tests()
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 2
 		chk_mptcp_info subflows 1 subflows 1
+
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_attempt_fail $ns2
+		chk_subflow_nr "after new reject" 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "after no reject" 3
+		chk_mptcp_info subflows 2 subflows 2
+
 		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 3 3 3
+		chk_rm_nr 1 1
 	fi
 
 	# remove and re-add

-- 
2.45.2


