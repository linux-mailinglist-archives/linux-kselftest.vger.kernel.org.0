Return-Path: <linux-kselftest+bounces-5914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E85871C2A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C4C1C22B21
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB3D5EE96;
	Tue,  5 Mar 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUs2RpwV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6E65EE9D;
	Tue,  5 Mar 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635397; cv=none; b=l42YLZF/jIMz9yVzobNcWGuBsqZbkUm0HwXsaXQcRYnLSNai2to/yYeT3fC/e+cowaMCiqAXSmIzMFMRvq1fOZe6899J8fs0ujvuQUCdx9mJCYoK5P7ldLddesAiHNSEjM5R7koOmwH7t+dbVAoPkq0b68zLLDuZTnPrgOD9DbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635397; c=relaxed/simple;
	bh=mhEfkC/t/wPrEz+EOr1rK/8ja/vlTW/cYAWnHPnxTiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApizjUc8KPF8Job4lK/UZj5/BXC1pdMBK4g5RqmyRorPtny68qBoXD95EPD7LJ6q/dOXhrDHMZrgq4DpA2/aYy5tL3I3LHTfRdO8hBQj2G/B/1yEypIoC71pyMJwcpLc8BVgc9DzAMSX3fFjbK2jAVGkZufnD3Xn5fnKLoLv3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUs2RpwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B456FC43394;
	Tue,  5 Mar 2024 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635396;
	bh=mhEfkC/t/wPrEz+EOr1rK/8ja/vlTW/cYAWnHPnxTiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dUs2RpwVPluC3v2nQLtFMSD1LzEkTToNs14rk3yxqG/58IM7xjq/JpuKLp2pebVKd
	 qGIWQWDcvJQVnQ4yzoqvpurVRU2HmmruvF9yq5gdi99HoJ9kP51OR3Xcy4rCOwv/eX
	 hZM5/Hb5iLCgoK7sVoleD0pZhV7Sk9S4I+ZqHFSd1vKI1mrqCZd4tkXiinaVQQLGvu
	 4Ja9f1A9fbPLj78dL9ZoTm6Oixmg+/TasfA3xpVnQS9MnWMliE0oTgvBA4W68qBivd
	 HWtEueaXSSBlFJVRFJAHtGQJiZpSThbvqeEYWw5//8JYCuRa6ZgZzB93Ckpyx93HFG
	 ginEqjBGfCqnw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:39 +0100
Subject: [PATCH net-next 09/13] selftests: mptcp: connect: fix shellcheck
 warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-9-66618ea5504e@kernel.org>
References: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8890; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mhEfkC/t/wPrEz+EOr1rK/8ja/vlTW/cYAWnHPnxTiU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vcdgEurjfbnQKQLryjP1a9CVEg3Om3P7ySvs
 sRaqFKUQ0uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HQAKCRD2t4JPQmmg
 c5ueD/9/0p9NqkHWcrVooeck2APBzjFYUe60AVj/8GuZM8sSrvPqAmF4Dpje9dU7Beh5l5SyDVN
 qdsPgyxepW3PLrhr0Wl6eaj0MHIdVas45LgPa/GaGAXAcM4YRoBYiYroA6CEHHXiMEIs6PQu3Bd
 H0NR9vJa01oqBLLOHeqgjDygLaYfBZ1jKAR9QHR2jxMCNcnJKYHB7eeYOqYf/PTCIUA1T0neuiv
 oEOza7fK9J8DYv/2sjyh97Re/DGhoHQEoTd+tsAb3rSdgLk3G3F+HK1lQsQCP/RYQ5uzkoIJRIK
 kE6eM9O0wyg919OEj+43MJz7R5DUN7zmXY0ANNM8m6Rqdn9iyzHBu39w2Tv48h8DDT59YNBVcE4
 byx7huVrap/B7nOEALNyKeVFlnwyuOeuUCvY5kS/PTkq3HFuu6Orjh9d5s4KH0dEglr+ze1SwKk
 qfeVkegLEqAEN6PB+B4njub6AptDYmcGHhsZ/A2/80f2j/x//ROVStUuN0nIHL0SGvxYpMOfN+L
 mEvwPHCGiamIrXqIP76oEvpeQWj8tn9O0OC6ebFnJRjhYti/TW7XHm6lCAur07Wz1pZ7FxjcgSZ
 QQVwRZfOHB1FNbBulc1vwap8vzFi/Q8JfmzZKqbSvGLv0mfwECKN60tS3sGVaTnWrW48RKHwY3t
 0gU/ndFd8b+QJqg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

shellcheck recently helped to prevent issues. It is then good to fix the
other harmless issues in order to spot "real" ones later.

Here, two categories of warnings are now ignored:

- SC2317: Command appears to be unreachable. The cleanup() function is
  invoked indirectly via the EXIT trap.

- SC2086: Double quote to prevent globbing and word splitting. This is
  recommended, but the current usage is correct and there is no need to
  do all these modifications to be compliant with this rule.

For the modifications:

  - SC2034: ksft_skip appears unused.
  - SC2181: Check exit code directly with e.g. 'if mycmd;', not
            indirectly with $?.
  - SC2004: $/${} is unnecessary on arithmetic variables.
  - SC2155: Declare and assign separately to avoid masking return
            values.
  - SC2166: Prefer [ p ] && [ q ] as [ p -a q ] is not well defined.
  - SC2059: Don't use variables in the printf format string. Use printf
            '..%s..' "$foo".

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 76 +++++++++++++---------
 1 file changed, 47 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b53ae64ec08c..0ca2960c9099 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,6 +1,11 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 time_start=$(date +%s)
@@ -13,7 +18,6 @@ sout=""
 cin_disconnect=""
 cin=""
 cout=""
-ksft_skip=4
 capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
@@ -129,6 +133,8 @@ ns4=""
 TEST_COUNT=0
 TEST_GROUP=""
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	rm -f "$cin_disconnect" "$cout_disconnect"
@@ -211,8 +217,9 @@ set_ethtool_flags() {
 	local dev="$2"
 	local flags="$3"
 
-	ip netns exec $ns ethtool -K $dev $flags 2>/dev/null
-	[ $? -eq 0 ] && echo "INFO: set $ns dev $dev: ethtool -K $flags"
+	if ip netns exec $ns ethtool -K $dev $flags 2>/dev/null; then
+		echo "INFO: set $ns dev $dev: ethtool -K $flags"
+	fi
 }
 
 set_random_ethtool_flags() {
@@ -307,7 +314,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+$TEST_COUNT))
+	port=$((10000+TEST_COUNT))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -365,12 +372,18 @@ do_transfer()
 			nstat -n
 	fi
 
-	local stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	local stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	local stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	local stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	local stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
-	local stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+	local stat_synrx_last_l
+	local stat_ackrx_last_l
+	local stat_cookietx_last
+	local stat_cookierx_last
+	local stat_csum_err_s
+	local stat_csum_err_c
+	stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
+	stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
+	stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
+	stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
+	stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -433,11 +446,16 @@ do_transfer()
 	mptcp_lib_check_transfer $cin $sout "file received by server"
 	rets=$?
 
-	local stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	local stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	local stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	local stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	local stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	local stat_synrx_now_l
+	local stat_ackrx_now_l
+	local stat_cookietx_now
+	local stat_cookierx_now
+	local stat_ooo_now
+	stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
+	stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
+	stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
+	stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -446,8 +464,8 @@ do_transfer()
 	cookies=${cookies##*=}
 
 	if [ ${cl_proto} = "MPTCP" ] && [ ${srv_proto} = "MPTCP" ]; then
-		expect_synrx=$((stat_synrx_last_l+$connect_per_transfer))
-		expect_ackrx=$((stat_ackrx_last_l+$connect_per_transfer))
+		expect_synrx=$((stat_synrx_last_l+connect_per_transfer))
+		expect_ackrx=$((stat_ackrx_last_l+connect_per_transfer))
 	fi
 
 	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
@@ -455,7 +473,7 @@ do_transfer()
 			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
 		retc=1
 	fi
-	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} -a ${stat_ooo_now} -eq 0 ]; then
+	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
 			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
 				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
@@ -466,18 +484,20 @@ do_transfer()
 	fi
 
 	if $checksum; then
-		local csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
-		local csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+		local csum_err_s
+		local csum_err_c
+		csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
+		csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
 
 		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
 		if [ $csum_err_s_nr -gt 0 ]; then
-			printf "[ FAIL ]\nserver got $csum_err_s_nr data checksum error[s]"
+			printf "[ FAIL ]\nserver got %d data checksum error[s]" ${csum_err_s_nr}
 			rets=1
 		fi
 
 		local csum_err_c_nr=$((csum_err_c - stat_csum_err_c))
 		if [ $csum_err_c_nr -gt 0 ]; then
-			printf "[ FAIL ]\nclient got $csum_err_c_nr data checksum error[s]"
+			printf "[ FAIL ]\nclient got %d data checksum error[s]" ${csum_err_c_nr}
 			retc=1
 		fi
 	fi
@@ -645,7 +665,7 @@ run_test_transparent()
 		return
 	fi
 
-ip netns exec "$listener_ns" nft -f /dev/stdin <<"EOF"
+	if ! ip netns exec "$listener_ns" nft -f /dev/stdin <<"EOF"
 flush ruleset
 table inet mangle {
 	chain divert {
@@ -656,7 +676,7 @@ table inet mangle {
 	}
 }
 EOF
-	if [ $? -ne 0 ]; then
+	then
 		echo "SKIP: $msg, could not load nft ruleset"
 		mptcp_lib_fail_if_expected_feature "nft rules"
 		mptcp_lib_result_skip "${TEST_GROUP}"
@@ -671,8 +691,7 @@ EOF
 		local_addr="0.0.0.0"
 	fi
 
-	ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100
-	if [ $? -ne 0 ]; then
+	if ! ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		echo "SKIP: $msg, ip $r6flag rule failed"
 		mptcp_lib_fail_if_expected_feature "ip rule"
@@ -680,8 +699,7 @@ EOF
 		return
 	fi
 
-	ip -net "$listener_ns" route add local $local_addr/0 dev lo table 100
-	if [ $? -ne 0 ]; then
+	if ! ip -net "$listener_ns" route add local $local_addr/0 dev lo table 100; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
 		echo "SKIP: $msg, ip route add local $local_addr failed"
@@ -844,7 +862,7 @@ stop_if_error "Could not even run ping tests"
 echo -n "INFO: Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
 
-reorder_delay=$(($tc_delay / 4))
+reorder_delay=$((tc_delay / 4))
 
 if [ -z "${tc_reorder}" ]; then
 	reorder1=$((RANDOM%10))

-- 
2.43.0


