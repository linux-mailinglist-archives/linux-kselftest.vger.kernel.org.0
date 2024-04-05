Return-Path: <linux-kselftest+bounces-7261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D96899B40
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2B6283BDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B731D16C43A;
	Fri,  5 Apr 2024 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5xvw+K+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E416ABC8;
	Fri,  5 Apr 2024 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314351; cv=none; b=XKCX3V05ff6CBmm0MyaAq5zHKWE2gOZO6Y6P4ASq6BPzkQFGRGF79Do0nrfHKfNOAzb4+6Ia2txbrL5B/5gOr5L9h3/milQxT1lDdhwkOSD5IdzoBiu3uazO1vC53HTMtTxoOkFxkaKP/dg9iJIsqANkwpv6c1m03gYaVfHat+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314351; c=relaxed/simple;
	bh=v2tpouPNyjZ1b8U4PDYegy9K1DvLXeUhvyBIxPTZtjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eozTqajKvlBnnMH4wXbBu6SWpLSOjHrqXFrhNzsLs/f0F072lx0+UPxaZAEhRxR4lYR+OzybnA0iR9NRn/jVMhN/rv4gEs997AvaigI/8xMW044pns3O5iNKNk/HyHd6KHlzOaBs921OsloLvAVFurqX5pMYFaX3QAnT0yTeR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5xvw+K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ED1C43399;
	Fri,  5 Apr 2024 10:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314351;
	bh=v2tpouPNyjZ1b8U4PDYegy9K1DvLXeUhvyBIxPTZtjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K5xvw+K+vFNxbn/7hr+3V0jLqG71tLIsQTp8a+BBGP4PNZKO+VnrRwf6T72T6UklM
	 iZCjezmPJMJ+x6FHoS/WPUXKE2wZHNAQMn3Dm5ZjpDeNXMSblpdeHo3XJJdUrIv9Oe
	 IKfMVq17Bn2023BtDrvU3ziyTUljbuVpvC5OdePoR2lWml3QXEHMP93QUX21mS+Hq0
	 k86+hrnFyBQCKqXRcio43EO09cKf+G/X/05bEhYDmbt70Vg5g83b9FqeIobaPPR/UZ
	 CA53yZDCdqoWKEfv6biKZmqRWuy4M5avbOjjY2DgtRNIlM9Z8d+dYIm7ugXgjSRIkQ
	 9yAVxwCfYk8lA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 12:52:06 +0200
Subject: [PATCH net-next 02/11] selftests: mptcp: add ms units for tc-netem
 delay
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-2-eabc9b960966@kernel.org>
References: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
In-Reply-To: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IB5nicQTGbW0wPqnxC6mBPr/+Em2SJVyWc/UESeeex4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD9flQUJwVIqulu5DfBX+mevThsUesOltYArXS
 /+54t/PaWeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/X5QAKCRD2t4JPQmmg
 cwfGD/wLc/g3nigR/s+Sqt83I+ZbVaJHIaAfJPaF7Xitbl5ZwxPkKZc48deHnCg4ZNxPr+MLJ1u
 Lb4olbkYfdFr9TvGBW++zhK7hoZPJiCJIL2NyG6dAJ8aYKTvexeRCXnBrOhuX+UEFg5ppxlYcW4
 AS7K1utsBWdppVSHn4vOy5JgauieUHnxPj4Mpfs9Q0vDuL2bBD1F7mZTJxCq97GoSxhq1NPcxHP
 faISwUY+q3+RW5E5SB9poNku0BS1rioJfi4FZWyzat0++WB7Yp4Pnha1BVhVkd5o4+lDkcaTX69
 7qrFMJAqn1wDjKdO0Sdw3Bcp20Zu19kuqRZxfUKnqgjQq868VIqbs/YbK1i0kW07rQNtAe+jJWQ
 FgMuJiF/rqGrT9ZczB10CdKAyAUrNbnnFywhrPIB5tOOtOombf43zLn4IZ8uU6Tpje9MWN6meSP
 AibBaPIToq75LVs4uQDuB3q06VUvz470vtBSMmjPOSRDHhPbL6fyF0vr5AvNeuzf5ZG13oJTAlF
 nlOM0YTfS3hR319V3Ig5u3zI1mnjMFJeW1gv+sXqeP49rbbxNVg+ZjZ5QutBQ+XI87+lVpaOmNq
 WP/ISGLHZAnWFw4ZgkonNN2MXDMbvJ0ONWVun8i7Omd4aL+Ap8z20uzO2oKGED2rtWyvSNnvhwV
 DuJumWowvezilBw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

'delay 1' in tc-netem is confusing, not sure if it's a delay of 1 second or
1 millisecond. This patch explicitly adds millisecond units to make these
commands clearer.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 6 +++---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5a95798eb40a..73a2131e6da2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -125,8 +125,8 @@ init_shapers()
 {
 	local i
 	for i in $(seq 1 4); do
-		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1
-		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1
+		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1ms
+		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1ms
 	done
 }
 
@@ -3212,7 +3212,7 @@ fail_tests()
 
 	# multiple subflows
 	if reset_with_fail "MP_FAIL MP_RST" 2; then
-		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5
+		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5ms
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 497141c49ccd..4e6d8fc56b38 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -216,8 +216,8 @@ run_test()
 	shift 4
 	local msg=$*
 
-	[ $delay1 -gt 0 ] && delay1="delay $delay1" || delay1=""
-	[ $delay2 -gt 0 ] && delay2="delay $delay2" || delay2=""
+	[ $delay1 -gt 0 ] && delay1="delay ${delay1}ms" || delay1=""
+	[ $delay2 -gt 0 ] && delay2="delay ${delay2}ms" || delay2=""
 
 	for dev in ns1eth1 ns1eth2; do
 		tc -n $ns1 qdisc del dev $dev root >/dev/null 2>&1

-- 
2.43.0


