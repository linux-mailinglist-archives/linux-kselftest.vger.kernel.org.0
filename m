Return-Path: <linux-kselftest+bounces-16504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1F2961F4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277A41F2572F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53A158A00;
	Wed, 28 Aug 2024 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebgrqZ58"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AABD15884A;
	Wed, 28 Aug 2024 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825686; cv=none; b=IMxw16Y60sdpTqF6VhEnZS4vArZUUum42DUAP0H8bTb9bna2OM1AqpQOuLFuHBKNg8JcagYM87sBxyBRIGKXr5ABafLjqXJHtpc9fEvf0BSbPH4eSGddnuhC0cTDMLWgblYwY+5DEMfO8D5d9Zv6a2kkvYwb3HHUJfOpOAkIHno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825686; c=relaxed/simple;
	bh=rspq5cltJ5/aifzNjtqUEMqUuelynLyRkb8+PcXCIe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XcPKg3SkXmfusw2NfOpe0jIHPhwVzT38PbwLmkLwYAdu81fw66m+25XFAUF9CFUC7ykXh9zGmmCMlNmx/GNyBhPDKYzqdimPVyMcjtCEHNC5holoE9vRsNFXWXpn5KRfCL4YC42fi8sBXED4bRnqnT7S6La8q1Me6IBS0TrJ2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebgrqZ58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E3CC4AF5F;
	Wed, 28 Aug 2024 06:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825685;
	bh=rspq5cltJ5/aifzNjtqUEMqUuelynLyRkb8+PcXCIe4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ebgrqZ58tUl7ggI5/sAk+G+otME3m/HgV7LdCFdG61VnRUsmrDUipRFYgmDKNM44G
	 /Q3AI257ggdFFN5vh1TfTePRZjo8p0/mLpgIN20R6VPJETesvxITKzTTgBd0ROy2eb
	 391CWXKxmHDkJKSQnfd4lXo0FKXNhse1ZvoZ4IG2Y9gdiaFuwL9lA5h01HEsUDUyvX
	 XterDaKD2GGitvUt3byiRcraFhm5Z6piqWleIbJ5wfLGfRKFRDoB3K7KZigKQBfJmy
	 92Sx9iugY60p6mVc7kpxZXaf4jjFRrnipNd5IhMv9pzstPIDzeHIzjTb9zDtenRgDo
	 xWSqRWsHqpBPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:26 +0200
Subject: [PATCH net v2 03/15] selftests: mptcp: join: check removing ID 0
 endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-3-7f11b283fff7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rspq5cltJ5/aifzNjtqUEMqUuelynLyRkb8+PcXCIe4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBHNmtrl15+KSCwAF7mPxDMRkoEedQFvv/1v
 Q+mvyldXYOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 c+tREACpBRV5wpmC/d7ezjr3zKn9PjveOcI7LVbO7GbqaFXnd1VVgcH9o/5V9LAI7tv8AQX1VN/
 85o+TtIb773GjkPV1gj/+LzFVH9UZdmWYFPJWQ9pLutScwvgjFJMrhr4uvxJ8DAhh47ZjaiwVwU
 EhmeXNfrl/3r6WZWLG4W5BJm2Resg0qKJx/wNkcXHcyB+kqrC7EWgD5qPWMtZ6oIMtGPUHV8rGg
 f4dIWrOn65cGJLAAV8xHwq0Cx2U7S2DJ+gy8AqAk/vtv7CdLryNs34rlsdtgsjW8P2ndwvHQ5SZ
 r0ugJ7/ejXhC7WDjGI5CLtBbdieGu4b2SkDPzjPTaxiEBxbNTQBXGx3bbSczS4XGVPXJCTTbF3A
 ujzzmMRf0nT3J0IfDSR+7+C0WD/DLnlv3dF0xuSfUNsTHa3xGOyVF07rI8f6vw39smFkxDEeXmQ
 i0CqJHqA1xnXt5jZ4hCGFgyQzM8JUsjRq3rvt9t6vM15hcm43YSD0c9s+ayLAs/c5l+faflyxbW
 UgUW1gXEhEWq8CPGy7GE5MCzjaLZUIxdIsMqJsmrW7jHNwRV/XGa7mh8y/44GPcG4PynK4c86Xc
 RWRs703oAyJ6JYWgO1uWAsAmPMQBl71s/0R/1pRNs0PgXSAiU8MGXxUWLWUKLfP/kyLbiu++iOg
 Rt3qB5J4Xq0m81A==
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
index 264040a760c6..8b4529ff15e5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3572,8 +3572,9 @@ endpoint_tests()
 
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
@@ -3582,17 +3583,17 @@ endpoint_tests()
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
@@ -3607,10 +3608,20 @@ endpoint_tests()
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


