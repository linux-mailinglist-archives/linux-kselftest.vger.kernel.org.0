Return-Path: <linux-kselftest+bounces-45671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9532C5ED5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13220366C0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB9C34D391;
	Fri, 14 Nov 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hko6eBnl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3034D383;
	Fri, 14 Nov 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143964; cv=none; b=jrZp+0CxH83XMoYJLIVbOrkgoa/pfg04MNSdEkoxGXUVwOkMQhOubzB/qDYJNZIz9pVask7Vl7Syfcim6+wKf/q1cK4Suv3mSseaCwLzbUv286rWBJUJ0d4eiCsaB+Cx5m5g/lo47pAIY8M7mV/Dv0/wPKJPukovKC1+szSVUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143964; c=relaxed/simple;
	bh=FEOSCr2hMTBDDkz3/20oFIn06yOc0640jfd06Qv+9K4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRMGt9Jhtsh0ZN8U04E6k1cbviW2QhDuCY1cNMclt8BcOnDXU+1MSe/v/c/5U4fNR1CRvv3JmcDcRI+Zn64sn1/qd6VJCNiGfRD0PmUh67Iiyvp9YiHSyeImNxPgG16j8pEi5J8KyKRuwYTX8lG9scTuK66bKX2t0rYDt5/4VSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hko6eBnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C21AC113D0;
	Fri, 14 Nov 2025 18:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143964;
	bh=FEOSCr2hMTBDDkz3/20oFIn06yOc0640jfd06Qv+9K4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hko6eBnlhvBs27rmxVov+yL1ypJ1chy3nFm3FVxgMFDsRiNqYoSuKQ64bOPh32NET
	 vAlYRiZW8vo8oKgTc69iXNJmaGXuS9fzvau1gdPLldq82T9zpFyOUOqWahTb98EFNN
	 dn4BlZVQ9A8dBuJUFl1+xl0+EidjtoeN24bngBn4MoC9WtgsbGEwQtOTLFRg0wUrwF
	 XJtfLyA3UpO9Bb/y2zlk2Ib35L10UoIsiRz5D/KGSqeYgl6p5id91VHbrSPRwIkrYs
	 2QS5MqMQXVjmI513oFyb/HnngQTHz+LY5OuarWT5sHj6rJMKtKqp18Kbk3FWYkR8PZ
	 f0FHrh95FuY/w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Nov 2025 19:12:12 +0100
Subject: [PATCH net-next 8/8] selftests: mptcp: get stats just before
 timing out
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-8-863cb04e1b7b@kernel.org>
References: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
In-Reply-To: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10625; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FEOSCr2hMTBDDkz3/20oFIn06yOc0640jfd06Qv+9K4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLFC1m8Ax/qnrlQL1QknMit6Dp5s2+FSaf98sXccrccj
 lrwvOvpKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmIiGFMNfiZtls8+q/ZHVm7WX
 LcG85P6U204lEzqXXWvbKlQ3lz/GneF/TNtnXZXI6FnWb0qatU9F+SXtC/t+6OGXny51HHbnb4v
 zAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, some debugging happened around a test that was timing out. The
stats were showing connections being closed which was confusing because
the closing state was caused by the timeout stopping the transfer.

To avoid such confusion, the timeout is no longer done per mptcp_connect
process, but separately. In case of timeout, the stats are now printed,
then the apps are killed.

The stats will still be printed after the kill, but that's fine, and
this might even be useful, just in case. Timeout should be exceptional.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 26 +++++++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 34 +++++++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 13 +++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 26 +++++++++++------
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 29 +++++++++++-------
 5 files changed, 86 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index e0bfd9b4730c..a6447f7a31fe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -393,27 +393,35 @@ do_transfer()
 		mptcp_lib_nstat_init "${connector_ns}"
 	fi
 
-	timeout ${timeout_test} \
-		ip netns exec ${listener_ns} \
-			./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-				$extra_args $local_addr < "$sin" > "$sout" &
+	ip netns exec ${listener_ns} \
+		./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+			$extra_args $local_addr < "$sin" > "$sout" &
 	local spid=$!
 
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
 	start=$(date +%s%3N)
-	timeout ${timeout_test} \
-		ip netns exec ${connector_ns} \
-			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-				$extra_args $connect_addr < "$cin" > "$cout" &
+	ip netns exec ${connector_ns} \
+		./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+			$extra_args $connect_addr < "$cin" > "$cout" &
 	local cpid=$!
 
+	mptcp_lib_wait_timeout "${timeout_test}" "${listener_ns}" \
+		"${connector_ns}" "${port}" "${cpid}" "${spid}" &
+	local timeout_pid=$!
+
 	wait $cpid
 	local retc=$?
 	wait $spid
 	local rets=$?
 
+	if kill -0 $timeout_pid; then
+		# Finished before the timeout: kill the background job
+		mptcp_lib_kill_group_wait $timeout_pid
+		timeout_pid=0
+	fi
+
 	local stop
 	stop=$(date +%s%3N)
 
@@ -433,7 +441,7 @@ do_transfer()
 	local duration
 	duration=$((stop-start))
 	printf "(duration %05sms) " "${duration}"
-	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
+	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ] || [ ${timeout_pid} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
 		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 54bac074f184..be61612f68fe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1024,38 +1024,38 @@ do_transfer()
 	if [ "$test_linkfail" -gt 1 ];then
 		listener_in="${sinfail}"
 	fi
-	timeout ${timeout_test} \
-		ip netns exec ${listener_ns} \
-			./mptcp_connect -t ${timeout_poll} -l -p ${port} -s ${srv_proto} \
-				${extra_srv_args} "${bind_addr}" < "${listener_in}" > "${sout}" &
+	ip netns exec ${listener_ns} \
+		./mptcp_connect -t ${timeout_poll} -l -p ${port} -s ${srv_proto} \
+			${extra_srv_args} "${bind_addr}" < "${listener_in}" > "${sout}" &
 	local spid=$!
 
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	extra_cl_args="$extra_args $extra_cl_args"
 	if [ "$test_linkfail" -eq 0 ];then
-		timeout ${timeout_test} \
-			ip netns exec ${connector_ns} \
-				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$extra_cl_args $connect_addr < "$cin" > "$cout" &
+		ip netns exec ${connector_ns} \
+			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+				$extra_cl_args $connect_addr < "$cin" > "$cout" &
 	elif [ "$test_linkfail" -eq 1 ] || [ "$test_linkfail" -eq 2 ];then
 		connector_in="${cinsent}"
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
 			tee "$cinsent" | \
-			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$extra_cl_args $connect_addr > "$cout" &
 	else
 		connector_in="${cinsent}"
 		tee "$cinsent" < "$cinfail" | \
-			timeout ${timeout_test} \
-				ip netns exec ${connector_ns} \
-					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$extra_cl_args $connect_addr > "$cout" &
+			ip netns exec ${connector_ns} \
+				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$extra_cl_args $connect_addr > "$cout" &
 	fi
 	local cpid=$!
 
+	mptcp_lib_wait_timeout "${timeout_test}" "${listener_ns}" \
+		"${connector_ns}" "${port}" "${cpid}" "${spid}" &
+	local timeout_pid=$!
+
 	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
 	check_cestab $listener_ns $connector_ns
 
@@ -1064,12 +1064,18 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	if kill -0 $timeout_pid; then
+		# Finished before the timeout: kill the background job
+		mptcp_lib_kill_group_wait $timeout_pid
+		timeout_pid=0
+	fi
+
 	cond_stop_capture
 
 	mptcp_lib_nstat_get "${listener_ns}"
 	mptcp_lib_nstat_get "${connector_ns}"
 
-	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
+	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ] || [ ${timeout_pid} -ne 0 ]; then
 		fail_test "client exit code $retc, server $rets"
 		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 		return 1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 91ec75ddcb96..5fea7e7df628 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -350,6 +350,19 @@ mptcp_lib_evts_get_info() {
 		mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
 
+mptcp_lib_wait_timeout() {
+	local timeout_test="${1}"
+	local listener_ns="${2}"
+	local connector_ns="${3}"
+	local port="${4}"
+	shift 4 # rest are PIDs
+
+	sleep "${timeout_test}"
+	mptcp_lib_print_err "timeout"
+	mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
+	kill "${@}" 2>/dev/null
+}
+
 # $1: PID
 mptcp_lib_kill_wait() {
 	[ "${1}" -eq 0 ] && return 0
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 6cde7429104b..ab8bce06b262 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -172,31 +172,39 @@ do_transfer()
 	mptcp_lib_nstat_init "${listener_ns}"
 	mptcp_lib_nstat_init "${connector_ns}"
 
-	timeout ${timeout_test} \
-		ip netns exec ${listener_ns} \
-			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
-				${local_addr} < "$sin" > "$sout" &
+	ip netns exec ${listener_ns} \
+		$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
+			${local_addr} < "$sin" > "$sout" &
 	local spid=$!
 
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
-	timeout ${timeout_test} \
-		ip netns exec ${connector_ns} \
-			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
-				$connect_addr < "$cin" > "$cout" &
+	ip netns exec ${connector_ns} \
+		$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
+			$connect_addr < "$cin" > "$cout" &
 
 	local cpid=$!
 
+	mptcp_lib_wait_timeout "${timeout_test}" "${listener_ns}" \
+		"${connector_ns}" "${port}" "${cpid}" "${spid}" &
+	local timeout_pid=$!
+
 	wait $cpid
 	local retc=$?
 	wait $spid
 	local rets=$?
 
+	if kill -0 $timeout_pid; then
+		# Finished before the timeout: kill the background job
+		mptcp_lib_kill_group_wait $timeout_pid
+		timeout_pid=0
+	fi
+
 	mptcp_lib_nstat_get "${listener_ns}"
 	mptcp_lib_nstat_get "${connector_ns}"
 
 	print_title "Transfer ${ip:2}"
-	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
+	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ] || [ ${timeout_pid} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
 		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 503cb59571a4..806aaa7d2d61 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -158,25 +158,33 @@ do_transfer()
 	mptcp_lib_nstat_init "${ns3}"
 	mptcp_lib_nstat_init "${ns1}"
 
-	timeout ${timeout_test} \
-		ip netns exec ${ns3} \
-			./mptcp_connect -jt ${timeout_poll} -l -p $port -T $max_time \
-				0.0.0.0 < "$sin" > "$sout" &
+	ip netns exec ${ns3} \
+		./mptcp_connect -jt ${timeout_poll} -l -p $port -T $max_time \
+			0.0.0.0 < "$sin" > "$sout" &
 	local spid=$!
 
 	mptcp_lib_wait_local_port_listen "${ns3}" "${port}"
 
-	timeout ${timeout_test} \
-		ip netns exec ${ns1} \
-			./mptcp_connect -jt ${timeout_poll} -p $port -T $max_time \
-				10.0.3.3 < "$cin" > "$cout" &
+	ip netns exec ${ns1} \
+		./mptcp_connect -jt ${timeout_poll} -p $port -T $max_time \
+			10.0.3.3 < "$cin" > "$cout" &
 	local cpid=$!
 
+	mptcp_lib_wait_timeout "${timeout_test}" "${ns3}" "${ns1}" "${port}" \
+		"${cpid}" "${spid}" &
+	local timeout_pid=$!
+
 	wait $cpid
 	local retc=$?
 	wait $spid
 	local rets=$?
 
+	if kill -0 $timeout_pid; then
+		# Finished before the timeout: kill the background job
+		mptcp_lib_kill_group_wait $timeout_pid
+		timeout_pid=0
+	fi
+
 	if $capture; then
 		sleep 1
 		kill ${cappid_listener}
@@ -191,8 +199,9 @@ do_transfer()
 	cmp $cin $sout > /dev/null 2>&1
 	local cmpc=$?
 
-	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
-	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
+	if [ $retc -eq 0 ] && [ $rets -eq 0 ] &&
+	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ] &&
+	   [ $timeout_pid -eq 0 ]; then
 		printf "%-16s" " max $max_time "
 		mptcp_lib_pr_ok
 		cat "$capout"

-- 
2.51.0


