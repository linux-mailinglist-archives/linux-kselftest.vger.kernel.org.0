Return-Path: <linux-kselftest+bounces-10679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A878CE8B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7051C20F3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62E130A7E;
	Fri, 24 May 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkLHv8Pk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12D130A7A;
	Fri, 24 May 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568279; cv=none; b=WhU0lm9s8OazYKj+xX9OmRaYLY/TJhLeVRUc2FTNAaPTL+9G5wlf6xiOrX7sxLrhwxHiXiGGFY6lirCouhhSZFan24ryUl6b9IhwaYqJBxsXnJF19HrOohMedED0dStXIC95pmjj5oC5QH3doOjJTwosFyrvl3AJP6dXq6i/pYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568279; c=relaxed/simple;
	bh=Qqr2iBCRG6XI9ufgkFxNFbP4uEkYYEK3OUdo+52EU5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sggQlA9YpatIh8I+UU6jnMe2lf3X82v5MEvOaihX9cMWo2Dkp2Et5rcm/fZNBtEpgATtkhnl4RMqf6hYvyq16/FTiSoDRAsxWCMQC9o35BWIALA7pwBGoA1QB3v09pZpZtwOJ6qJQBnQHrY4/0UBoW0FKVhessMYW/p2zfVYybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkLHv8Pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF83C32782;
	Fri, 24 May 2024 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716568279;
	bh=Qqr2iBCRG6XI9ufgkFxNFbP4uEkYYEK3OUdo+52EU5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZkLHv8Pkxn9mUY1HnezEPGJrpbRVXwMsJKsLmhps7nNgbLnZlHPJ2COZpcYc9DmOy
	 My3NvyHfjvsXK7AIjTX0QaRzlVeMebK7oKI/+Cjx2imHnCJSN8rzalz/+RbJ2m708v
	 COTEHrmlM0UVpnXInU7aqauuglaUhUHHdT+evF5awhF82hHpNu83hCrsqE0gFIRLqX
	 N3/WsfxQaDZTs0nTsVtpWx/7IcsKZQ/R0m0rYfLoMG6/oQ5I/I674IxDIjoXLIAFSw
	 pTnJ2J21xPQp2eRmyqx0JYzVxSZxSYFZVryxUL0IGs8IySkScXLuZJyTcg1TYFXn+O
	 eU81odHgpO5JQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 18:30:59 +0200
Subject: [PATCH net 4/4] selftests: mptcp: join: mark 'fail' tests as flaky
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-4-a352362f3f8e@kernel.org>
References: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-0-a352362f3f8e@kernel.org>
In-Reply-To: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-0-a352362f3f8e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1492; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Qqr2iBCRG6XI9ufgkFxNFbP4uEkYYEK3OUdo+52EU5k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUMDIBXYVVB2frHAK+KWc1s+dBlNhOBQI503dG
 bU6GUd31Z2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlDAyAAKCRD2t4JPQmmg
 c8PxEACbtIqm+60nrixYuPj6dYq4NRlkY8bPpYQrEXeHdCrQ6Vk2slfEFCEnDvou0cJ1usAFtWq
 MGeyoOvTeECoRrkZagFQEoMqrnFu+HeAR28qMbifCBuQCYhZS52vb8tD/xL8SiRrkN/jrDNg0JM
 bXQc5gUH04tNcfOzfzt9Vu5AeinUN38pmcgb7ajIMnBVTuh0Hpz15imOX9yAWThfDeJ4q9zJBh1
 CSDQNLAoEdxQdpQogCgFWKApNu5t+E9PzSXVkhfJrs25+Ls3fOzyinVa4gFx0YHZHOQW4UWYJIb
 YBd+CO9Yyv/k29CRo3jZIzBk8egSrXYFvbvW82Fr1lSoLOqtVZS78jsViYS6xuKCPyyBYc9pqnm
 pfz9q7XEb1bZzebJyPaf3NNJi8zR0MntQFOFNRvDWWeP6pjAlNFeIG3G0HB2rS0UvHezsdMKvut
 aD2cy1UUKz4Kcdy2NpMEceslq+rPMNrWiq59FR/3kBODVhtIpZ8bOaQDYgyrJ6j8JG0bh87Jq+a
 9AaQeZX4XC8lcxh/rcRVsnnJO91g9YTiGKiGHSt/4CZWkLVMRY0Ny5eDPKGdouLv1PKJrpiWO3w
 9AN6s3koBl/TMVHqERKd4t5btpFremb0YjLE5hB+zq+IK20uEKymobrYKN7rl0bTGqkc2ozkMTd
 AfWPlHr+CsBemXQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These tests are rarely unstable. It depends on the CI running the tests,
especially if it is also busy doing other tasks in parallel, and if a
debug kernel config is being used.

It looks like this issue is sometimes present with the NetDev CI. While
this is being investigated, the tests are marked as flaky not to create
noises on such CIs.

Fixes: b6e074e171bc ("selftests: mptcp: add infinite map testcase")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/491
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b869b46823d7..2b66c5fa71eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3101,6 +3101,7 @@ fail_tests()
 {
 	# single subflow
 	if reset_with_fail "Infinite map" 1; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=128 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
@@ -3109,6 +3110,7 @@ fail_tests()
 
 	# multiple subflows
 	if reset_with_fail "MP_FAIL MP_RST" 2; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5ms
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1

-- 
2.43.0


