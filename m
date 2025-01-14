Return-Path: <linux-kselftest+bounces-24498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB38A10F4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E9718824ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F42225414;
	Tue, 14 Jan 2025 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5loTSv/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F220E331;
	Tue, 14 Jan 2025 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877815; cv=none; b=P/7GAE3Bv94d7ZWm02QJceb1AXKDlZDpUmdjC8M6p+WqhS4eNUplJhM5m250lJ419ZX8cT6SoR6Yj5HMxm3spMtlw7+o6xlx1UCg/drOeW/Ls4JUxhEwhkAX6DjoShWKg/9pPuyqAU8w3xAaFP60KtAlr2TSOb0Y6AUZX6PK0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877815; c=relaxed/simple;
	bh=w65k6xWKRGI7/vKkidtlHojt0YJMPssm/vQtmg+j0tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d2bmltkmTyd7hqdyrF9y2FMKwl/x0sl1uhLWzunN4bJpxspxnmD6tUSN5n28Vv50OSMjQvpnsDDNwtT6sodDrovyVdc/RWqxXqFBbKkXCUyMp1nz42k4jeJPB3CKMxXEQhPBu+n62o9ExlbR36iHpSAb/XpUl/Y4VMo3DYUUsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5loTSv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC00EC4CEE6;
	Tue, 14 Jan 2025 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877814;
	bh=w65k6xWKRGI7/vKkidtlHojt0YJMPssm/vQtmg+j0tU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G5loTSv/Up+7fYpSsc7gloijv9DaEGSZlisNeG/najYR+0uf5SKuU8IN/nyeZbNkN
	 s2U8eYAHSMpIcSivSLvMMxhicmcvCTqUaNDptQRQC7pxS5IIfJI+sukifqKG1/SW9l
	 n3DCIzGmEF89bWIbReYQh6iwGRGhyfWtTOCXL930O+dR6TnrqrgXn4PxvPmmhUM2wY
	 PVM8W/dAPtedOSkP86OzMo44D1n8Omw/OZGOJcfl8zaxQbHuV4tFOPakjpPeT+ZgYl
	 pKSUlkhKXKxYWm9sLeDeMh38DIUxXWXBDx0w8rovFksS7fdDxr7zPacx7SdlwEupld
	 /cW4JcRbODp7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Jan 2025 19:03:13 +0100
Subject: [PATCH net-next 3/6] selftests: mptcp: move stats info in case of
 errors to lib.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-net-next-mptcp-st-more-debug-err-v1-3-2ffb16a6cf35@kernel.org>
References: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
In-Reply-To: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5947; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=w65k6xWKRGI7/vKkidtlHojt0YJMPssm/vQtmg+j0tU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqboQdSYXyyo7TSphAlafnMjtTqYg2wZiVKvs
 f2u46l08deJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4am6AAKCRD2t4JPQmmg
 c5uiEADUnFzfXXi99WG5sIeiJ6keQey9ReeKMnX1B3wZjRc/3NV19HkSuqCiviKtVmbIqvwKb8+
 jchAQ+WQ1LeFz4aNbg7t7ZFK0GS5X5n+qZcORJh3alE5SmZLfLmEcaLFeoCUOLnRgjqcotykz1J
 JT9jYUSOnceYLPkXG2/26M7aVL++RUtZH2+KPCHto0x+qqdvrAVQi8GJstMJVaPqBcEwDfP2ymE
 gkxekRuFcsZVgKhg+tn6r6gNrxaHPyLIo3Fjt4MJPOeDjou+vTIHPyXaGKzfCUmUAGWsgP7wXO4
 Kmo1yLoy3kxWlNWCaHC/gpI9Lp9a+JEJnkRJ+FP2fgi/gxdo0MdZhwoW9mP1qDvPZtpodZK7ihW
 KGmhKKTYQkmWLQnKUNaXKoTcWLMoL9Nfaj88lFtXkMdcCV+YvQKKw2gXpqsq7bsHvC/nVfYaiQB
 PUzyB7A+80dsBPNFan/zBO8y6Yn+6OZ9P+LR8744G4ABscHWeK1Gn7symYbHNGwVUKtU1KEX3bC
 PIs5HAv7lswLzCuYRSV7Lc4aGYWvNG86L+Q+ziaVD8+q8Een+dgt6b4SDeG+myrVAxe4Q982fhd
 O8gU0x1+Il7pfxGdNxMcaTJ5yOSjFgABUqXkUh8tmAWgZFEtYLXc8QZHYq5B4BSssy3qz4h7m8h
 wBjUfb+lypnSxqg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few MPTCP selftests are using the same code to print stats in case of
error. This code can then be moved to mptcp_lib.sh.

No behaviour changes intended, except to print the error in red and to
stderr, like most error messages.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  8 ++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  9 ++-------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 21 +++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  8 ++------
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  8 ++------
 5 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b48b4e56826a9cfdb3501242b707ae2ebe29b220..bfdaecd0a6a0564020530345daf91bed296bc15c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -445,12 +445,8 @@ do_transfer()
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
-		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
-		cat /tmp/${listener_ns}.out
-		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
-		[ ${listener_ns} != ${connector_ns} ] && cat /tmp/${connector_ns}.out
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
+			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
 
 		echo
 		cat "$capout"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c07e2bd3a315aac9c422fed85c3196ec46e060f7..13a3b68181ee14eb628a858e5738094c3c936b74 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1039,13 +1039,8 @@ do_transfer()
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		fail_test "client exit code $retc, server $rets"
-		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
-		cat /tmp/${listener_ns}.out
-		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
-		cat /tmp/${connector_ns}.out
-
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
+			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
 		return 1
 	fi
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 975d4d4c862afff2e685e86dc08a892dbd09d783..91a1d3b76e664bd95fc36310ac2e2c89bfba1aa1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -107,6 +107,27 @@ mptcp_lib_pr_info() {
 	mptcp_lib_print_info "INFO: ${*}"
 }
 
+# $1-2: listener/connector ns ; $3 port ; $4-5 listener/connector stat file
+mptcp_lib_pr_err_stats() {
+	local lns="${1}"
+	local cns="${2}"
+	local port="${3}"
+	local lstat="${4}"
+	local cstat="${5}"
+
+	echo -en "${MPTCP_LIB_COLOR_RED}"
+	{
+		printf "\nnetns %s (listener) socket stat for %d:\n" "${lns}" "${port}"
+		ip netns exec "${lns}" ss -Menita -o "sport = :${port}"
+		cat "${lstat}"
+
+		printf "\nnetns %s (connector) socket stat for %d:\n" "${cns}" "${port}"
+		ip netns exec "${cns}" ss -Menita -o "dport = :${port}"
+		[ "${lstat}" != "${cstat}" ] && cat "${cstat}"
+	} 1>&2
+	echo -en "${MPTCP_LIB_COLOR_RESET}"
+}
+
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
 # a test is not being skipped by mistake.
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 9a78bfdc3d5e27fdf6859d34f8d313bd08dd4457..418a903c3a4d396bd733bf8b6f68b1447d4d1de3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -202,12 +202,8 @@ do_transfer()
 	print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
-		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
-		cat /tmp/${listener_ns}.out
-		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
-		cat /tmp/${connector_ns}.out
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
+			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
 
 		mptcp_lib_result_fail "transfer ${ip}"
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e98e5907d52c2d0e9c0152efda82176861905cf1..9c2a415976cbf7a0b56cd4b2fbdd36c9e1ef3c8c 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -204,12 +204,8 @@ do_transfer()
 	fi
 
 	mptcp_lib_pr_fail "client exit code $retc, server $rets"
-	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
-	ip netns exec ${ns3} ss -Menita 1>&2 -o "sport = :$port"
-	cat /tmp/${ns3}.out
-	echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
-	ip netns exec ${ns1} ss -Menita 1>&2 -o "dport = :$port"
-	cat /tmp/${ns1}.out
+	mptcp_lib_pr_err_stats "${ns3}" "${ns1}" "${port}" \
+		"/tmp/${ns3}.out" "/tmp/${ns1}.out"
 	ls -l $sin $cout
 	ls -l $cin $sout
 

-- 
2.47.1


