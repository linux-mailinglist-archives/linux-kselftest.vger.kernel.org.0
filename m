Return-Path: <linux-kselftest+bounces-44584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096B9C28484
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45CA3BF2E5
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE72FD1D3;
	Sat,  1 Nov 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN9fnZT2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0DE2FD1BA;
	Sat,  1 Nov 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019837; cv=none; b=oZejTx9iWr3MdFE8stJ/Gqanh1a83vt82R2SllbteabKmk4pAySp5sn6OUcMdr29Gw98xWjo3yTYXjV6ZSPjyqFO/6DfwlrusArNt4gPXi4W+WXrzZ5d0qui/8NZuh9s9fdlujJ6wTo9kK8+naVyziY3n6SpswD41riIb7wicwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019837; c=relaxed/simple;
	bh=4FJjDaN/bzVx1rmeRAMy6ePFb5sfpEyCI2M2+OEJJcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GtlMz3F6PPKyxxjSX1lUp2ZfnohZKiC3mtKXO9X88xRiymDs8Qd802Q7mg//LAKIqxs4w1ht8LZcAZAQcQ3KF7lzbqV5+Kq6hBpu/x5ng0w85xNIgnEDcdu3qqkFXGTpu3T4xt7yqgdSxoreBfL9Z6/Oh0L7iEpWAFDApNdBNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN9fnZT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21260C4CEF1;
	Sat,  1 Nov 2025 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762019837;
	bh=4FJjDaN/bzVx1rmeRAMy6ePFb5sfpEyCI2M2+OEJJcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RN9fnZT2ECi3EqvGKkB5hqVcmQjfuxgZNt7vSK/zKp401KRWPxlBrVQ7UppPR5HSO
	 qo4LySLgtJFAqhKIy6aYziZVxYdcptedhZFaMd2pRF6dAwg4hldaoReTrq0NiWHkMd
	 6GRpaDPDFb7+EELWm/yevNbUDjhkABMixggwQyb5wyp0nStXTWF7QTse8rQA+K5ddh
	 8nTH9ZvebhY3kMn15OHtGbkyk3mFIFHpvVLpVPjRKWQGqJQ2W+vIF9ByiWDwfF4adl
	 rSRHV0ZBkyr3q3ZwrPc1FL3135IZO5KpXQ7BfzHG4V/0rfIEHWOvK3KF5zVz7Q7MuF
	 5LXE4N4Gkc97w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 01 Nov 2025 18:56:53 +0100
Subject: [PATCH net-next 3/4] selftests: mptcp: join: do_transfer: reduce
 code dup
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-3-b4166772d6bb@kernel.org>
References: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-0-b4166772d6bb@kernel.org>
In-Reply-To: <20251101-net-next-mptcp-fm-endp-nb-bind-v1-0-b4166772d6bb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4FJjDaN/bzVx1rmeRAMy6ePFb5sfpEyCI2M2+OEJJcc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZPD9wmZ83yUmYGSt+Za3eljtrtzlcOuWbNH1OmtBT4
 4h9J3KMO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZy9wQjw33LZe+YtriwvHv6
 TvNy/gxv/wYvubffWGP/e2+rfW0ld5Lhv8OlLw1V2y8GNTxiPhiSXrqxz+bcLf7D0aIu6tY7eWd
 zcwMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The same extra long commands are present twice, with small differences:
the variable for the stdin file is different.

Use new dedicated variables in one command to avoid this code
duplication.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++----------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e7a498dd5a46..4c9ee094381e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -951,6 +951,8 @@ do_transfer()
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
+	local listener_in="${sin}"
+	local connector_in="${cin}"
 	port=$(get_port)
 
 	:> "$cout"
@@ -999,16 +1001,12 @@ do_transfer()
 
 	extra_srv_args="$extra_args $extra_srv_args"
 	if [ "$test_linkfail" -gt 1 ];then
-		timeout ${timeout_test} \
-			ip netns exec ${listener_ns} \
-				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_srv_args "::" < "$sinfail" > "$sout" &
-	else
-		timeout ${timeout_test} \
-			ip netns exec ${listener_ns} \
-				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_srv_args "::" < "$sin" > "$sout" &
+		listener_in="${sinfail}"
 	fi
+	timeout ${timeout_test} \
+		ip netns exec ${listener_ns} \
+			./mptcp_connect -t ${timeout_poll} -l -p ${port} -s ${srv_proto} \
+				${extra_srv_args} "::" < "${listener_in}" > "${sout}" &
 	local spid=$!
 
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
@@ -1020,6 +1018,7 @@ do_transfer()
 				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$extra_cl_args $connect_addr < "$cin" > "$cout" &
 	elif [ "$test_linkfail" -eq 1 ] || [ "$test_linkfail" -eq 2 ];then
+		connector_in="${cinsent}"
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
@@ -1027,6 +1026,7 @@ do_transfer()
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$extra_cl_args $connect_addr > "$cout" &
 	else
+		connector_in="${cinsent}"
 		tee "$cinsent" < "$cinfail" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
@@ -1057,17 +1057,9 @@ do_transfer()
 		return 1
 	fi
 
-	if [ "$test_linkfail" -gt 1 ];then
-		check_transfer $sinfail $cout "file received by client" $trunc_size
-	else
-		check_transfer $sin $cout "file received by client" $trunc_size
-	fi
+	check_transfer $listener_in $cout "file received by client" $trunc_size
 	retc=$?
-	if [ "$test_linkfail" -eq 0 ];then
-		check_transfer $cin $sout "file received by server" $trunc_size
-	else
-		check_transfer $cinsent $sout "file received by server" $trunc_size
-	fi
+	check_transfer $connector_in $sout "file received by server" $trunc_size
 	rets=$?
 
 	[ $retc -eq 0 ] && [ $rets -eq 0 ]

-- 
2.51.0


