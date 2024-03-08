Return-Path: <linux-kselftest+bounces-6118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2737C876CC2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D113A2830D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D00604B6;
	Fri,  8 Mar 2024 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLCh61mM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4486604B5;
	Fri,  8 Mar 2024 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935825; cv=none; b=gzN1dq7JkAswGeY9mZGICHY3p8zuEK4RC3xod2pcNoUscwdgbfkrgOMIUsbSUad/fArosg0l+lL2yy5CzCSFsLeTYj0hti9m4R1+gMFtW+r0wbgwkHrdgG9BNwe8XhSRMZ2mmwLLQr9KdQrps3LZmBcqIEFLEdBQgZ2ZO1FA8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935825; c=relaxed/simple;
	bh=i1l1HeZAQJKXmN37TV6fUvmIfHotoheRGwDNA5lNhgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcQMzn8jjtcU904phJ3O5Tq/p2KLf9/fWoPGeFSuy4f4sjjxi1JK/NwKygepP2E4R3pmxxSvSoprHqFOdJhkeVKpJhKNMnI819jDFGm9QN+ujYS5yUOIRmFfjPhmvrHOjgaYg5HaeC/u4stgugHs+MvqontvIwqjOyQed4JtRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLCh61mM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306B4C43390;
	Fri,  8 Mar 2024 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935825;
	bh=i1l1HeZAQJKXmN37TV6fUvmIfHotoheRGwDNA5lNhgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NLCh61mMTdUSKZ7QjtgAhknuxjLcmd+KvjaezpU2SinkMisFO9Zy8uP5FyEFR/TaJ
	 ecGEAWgEtdy6qYPr4/Snn4gxuLDYCo2fWfirgXd82151VWX1p95eiXe5Ay4nDQ+pKZ
	 xCt+WyffVYh3nlwXIWUyZl8pKF3PcVu7r6BmcZ7nZKyi0mGF/UTilvgJHeBMAVSpU/
	 5fff1hGsWPmWTbSFCXVb1tfBKz71qFBLCurQf9qW6k+m7oBLYiMK/KSAPvEIjXw7BC
	 ZnwfexR/6a8lIS+1gMhfR/c+buzA7clXJvj1NWptZ54uAeAjy+C8WuGXrnHw1Y0yz1
	 YMxc1/muQHruw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:08 +0100
Subject: [PATCH net-next 01/15] selftests: mptcp: print all error messages
 to stdout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-1-4f42c347b653@kernel.org>
References: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
In-Reply-To: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3871; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4ZsgBrZv+LBpKaiW/nO4hYLCEY/5jrgsAIGaAf+PH0A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJjpjp4iYCmsZT4/EH+TG5UZfnW19z3sjOd
 evHhRBTbnKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 cw8yD/9b78omiFAYv7ns/4yDYj9wbjZM5EeBFNXbB1Cvh39gHqfIyMIQnMpLqWbQTyN79MlRiZP
 41HcsSAL1fnvhJObS2eKRPZgDx+8rnB0BQRICEVZQ9Ulo8PiqJyHU7ASxdsqpoMYvyy1g3zGRbe
 50aUpTrm5GygdNPQTsS43pXaC1jKORf5mHxdZ0gcvZNSKfhLm6XLZ+KnCKQZrD6RtP1Fc8/4WpR
 3BcmFtImCJIdWxr/0FTN1a5Dz5eROAI3FCwOOmpgrW1aaVOsY4sIkLSnGe6iC6jX8aA1DyG3GN0
 GA3MOvHEQN5uzEa8Pwovj0XZQd9EUIe37YPGphjVnKztQk0GpXPfH5+lJOqrvX8/r/AlVwhfqTS
 b5EM4VEjq1m8iFSIf9+zNCMVZCjOKzq74x4wNjX3G2EzQZNKM9m956bpGeEYb7gGEnHRVnN7eLm
 2+0YwEwll3YE/t0MkcKB3YAAG5g4/IdAzwy/Voqfwq2IndPbfLuTpqozDzdi5z52RAH7nM6mgn9
 RjWjtf9k2tscufZlq6RDSegOKdcex6ZUbItEIYNdzunn9MHcQI0paTyWTRr6XfxLfYnBQ0uts4k
 VN/e6J9cWV5yX2Reab6OQxfZ9sseNr4nOyhKxJkxVW9gD7mEiwgsRxCiNqrx1R/S534uPVhcZsn
 Ym+WH0Olkvt7Wtg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Some error messages are printed to stderr while the others are printed
to 'stdout'. As part of the unification, this patch drop "1>&2" to let
all errors messages are printed to 'stdout'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 +++++-----
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 11 ++++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0ca2960c9099..679e366c8f6b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -294,7 +294,7 @@ do_ping()
 	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null || rc=1
 
 	if [ $rc -ne 0 ] ; then
-		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
+		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]"
 		ret=1
 
 		return 1
@@ -470,13 +470,13 @@ do_transfer()
 
 	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
 		printf "[ FAIL ] lower MPC SYN rx (%d) than expected (%d)\n" \
-			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
+			"${stat_synrx_now_l}" "${expect_synrx}"
 		retc=1
 	fi
 	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
 			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
-				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
+				"${stat_ackrx_now_l}" "${expect_ackrx}"
 			rets=1
 		else
 			printf "[ Note ] fallback due to TCP OoO"
@@ -721,7 +721,7 @@ EOF
 	ip -net "$listener_ns" route del local $local_addr/0 dev lo table 100
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: $msg, mptcp connection error" 1>&2
+		echo "FAIL: $msg, mptcp connection error"
 		ret=$lret
 		return 1
 	fi
@@ -810,7 +810,7 @@ log_if_error()
 	local msg="$1"
 
 	if [ ${ret} -ne 0 ]; then
-		echo "FAIL: ${msg}" 1>&2
+		echo "FAIL: ${msg}"
 
 		final_ret=${ret}
 		ret=0
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 6ed4aa32222f..7c70b52e63c6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -103,7 +103,8 @@ check_mark()
 	local v
 	for v in $values; do
 		if [ $v -ne 0 ]; then
-			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
+			echo "FAIL: got $tables $values in ns $ns," \
+			     "not 0 - not all expected packets marked"
 			ret=1
 			return 1
 		fi
@@ -162,7 +163,7 @@ do_transfer()
 	local rets=$?
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo " client exit code $retc, server $rets" 1>&2
+		echo " client exit code $retc, server $rets"
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
 
@@ -221,7 +222,7 @@ do_mptcp_sockopt_tests()
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
+		echo "FAIL: SOL_MPTCP getsockopt"
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
@@ -232,7 +233,7 @@ do_mptcp_sockopt_tests()
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
+		echo "FAIL: SOL_MPTCP getsockopt (ipv6)"
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
@@ -263,7 +264,7 @@ do_tcpinq_test()
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $*" 1>&2
+		echo "FAIL: mptcp_inq $*"
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi

-- 
2.43.0


