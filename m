Return-Path: <linux-kselftest+bounces-6125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22532876CD9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE93282183
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3892626DA;
	Fri,  8 Mar 2024 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A93w+COl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC98626CB;
	Fri,  8 Mar 2024 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935850; cv=none; b=WKx5dmvnw1Lo2TWTyZxR9aknZwjPIIghfC+9FQ/nL6S42CpTHES/RGc4MPKjTS0QyJcTL1zLoBgQKqdBQaJmQ63o4xDn4kBU9XmOpaXqWd4FryNyDM2zRQ4dp1xOSWY1p9qPvpsfqL+vmmiikyE91QIuHHfmcD+bZFQV5Zz88Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935850; c=relaxed/simple;
	bh=q3m/d7yCdtsrxUydsniJZyBpMcyHpEysCb+mRWQJC8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LsfToHMp9sqcQxpk5PyUcU6zuBG87D5sEreJzmBkSaeZMM8VyqbwyHXlC6NfuhO4wyNkexyGG6XkzRuKcXmXDRr5t8SxeoxagY3l4T3CNtyVDetTy1B5E8JsrA4b0+gkIW8LTvYU2AOqScB1K/QUQyMViVhAlykcaKeZ57pmHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A93w+COl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917A8C43394;
	Fri,  8 Mar 2024 22:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935850;
	bh=q3m/d7yCdtsrxUydsniJZyBpMcyHpEysCb+mRWQJC8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A93w+COlV9Um2obv67LxtdSuKBVSjQlUDgOCf/PpxNp2T2egrD5XtB3pwscF+dqLd
	 2xtS/t0taJosVRNItSbN6Ye8v4DOK5gstF9MDfTt6AGNQGC19CYmvLmkxjURrXZU+B
	 G4VYx3I8Tr3cS93Psv+J8E/8Ygb3jotb7+Qosgmy9uIhkPcmZvUJvHNzIeLKSropVq
	 stM5ZqYx5R10a0D5YZKTpKWnVSJ6XoDSo7Kt9GU2HBGMywTefVCO6UgKrs1FWpRqOV
	 ZpkEP99YIztJBEQSpx+DtHRH7ckSN3xQxT2PljqpM9sTQXlGd72ng1bVhlxiPGgOkg
	 5EBBp7R+gM2MA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:15 +0100
Subject: [PATCH net-next 08/15] selftests: mptcp: use += operator to append
 strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-8-4f42c347b653@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8534; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1BDUdqInfX3BPSCLx67+D/8WGffyV6zeq++VeSyyKik=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJDFCBKmrkYRDFq5auLmcO5dLo665i3Zsdm
 V0reLO26KeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 cyfZD/wPHc+pgzHmhEDxOAQhumjxGAH/xgPY8K3hoTc+Gu4pEPfVzg0j7BPWrKQ77+pi/ZKBsb0
 0hkCSLP3X2XUkPYB3L9QGvqqOQrzHZQAaI9kK3nbVz85H7MTNUs2Bsh0xKvNgqkx+aH0xovxpBU
 YLHv0tu4pE7zblv5mTM97q8iz0glladGv+KWfAe8wTtYBApk22bKzprws3TtB45eghuTBsMFoC+
 I3A+hidF8UG/6Nk0kjmT0i5keeCllAyBaOC5pTevLrK9v0Q1/YwbfZlAO6YkXHltt4qM/P3lhcK
 DHUOyHh9oUOB7dtAEv9tigwbuvMMIATXr0jrXwdqxBzjqUEvU9HAjBPxMIE8qxLiillISshvb0R
 q7r5Soyh3Cw5l1rJa9NBsj01x3o0XnIgyF5rFnZAVH2zBab5LlrVKq5+Sor8re2EvOYrZc4xnoH
 p5sezWzemsI1uUEZXlQBMfRAbJqEuzKl/MAv9i3i/xWdel8JZm7qw7VMzLn/jVnpG3li6QTJGVt
 xHn58erXRaSVCyWCBMqCX4Ko1LzDm5KgeoTqrPyMnnSjbR9ruckMAUX+BllG6FSiPFox4HpcwEJ
 +76TMEzPoE/daOtM2cT5suZp1p73LueqnpCFM7+J5jSODxy40geP2T1nHHhpvcSD3yAa1U2d484
 tBuLhRki9kG4V2w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses addition assignment operator (+=) to append strings
instead of duplicating the variable name in mptcp_connect.sh and
mptcp_join.sh.

This can make the statements shorter.

Note: in mptcp_connect.sh, add a local variable extra in do_transfer to
save the various extra warning logs, using += to append it. And add a
new variable tc_info to save various tc info, also using += to append it.
This can make the code more readable and prepare for the next commit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 53 ++++++++++++----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 30 ++++++------
 2 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index bbda37d6514f..78098546ddd3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -323,15 +323,15 @@ do_transfer()
 	port=$((port + 1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
-		extra_args="$extra_args -R $rcvbuf"
+		extra_args+=" -R $rcvbuf"
 	fi
 
 	if [ "$sndbuf" -gt 0 ]; then
-		extra_args="$extra_args -S $sndbuf"
+		extra_args+=" -S $sndbuf"
 	fi
 
 	if [ -n "$testmode" ]; then
-		extra_args="$extra_args -m $testmode"
+		extra_args+=" -m $testmode"
 	fi
 
 	if [ -n "$extra_args" ] && $options_log; then
@@ -451,6 +451,7 @@ do_transfer()
 	mptcp_lib_check_transfer $cin $sout "file received by server"
 	rets=$?
 
+	local extra=""
 	local stat_synrx_now_l
 	local stat_ackrx_now_l
 	local stat_cookietx_now
@@ -484,7 +485,7 @@ do_transfer()
 				"${stat_ackrx_now_l}" "${expect_ackrx}"
 			rets=1
 		else
-			printf "[ Note ] fallback due to TCP OoO"
+			extra+=" [ Note ] fallback due to TCP OoO"
 		fi
 	fi
 
@@ -507,39 +508,41 @@ do_transfer()
 		fi
 	fi
 
-	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
-		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
-	else
-		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
-	fi
-
 	if [ $cookies -eq 2 ];then
 		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
-			printf " WARN: CookieSent: did not advance"
+			extra+=" WARN: CookieSent: did not advance"
 		fi
 		if [ $stat_cookierx_last -ge $stat_cookierx_now ] ;then
-			printf " WARN: CookieRecv: did not advance"
+			extra+=" WARN: CookieRecv: did not advance"
 		fi
 	else
 		if [ $stat_cookietx_last -ne $stat_cookietx_now ] ;then
-			printf " WARN: CookieSent: changed"
+			extra+=" WARN: CookieSent: changed"
 		fi
 		if [ $stat_cookierx_last -ne $stat_cookierx_now ] ;then
-			printf " WARN: CookieRecv: changed"
+			extra+=" WARN: CookieRecv: changed"
 		fi
 	fi
 
 	if [ ${stat_synrx_now_l} -gt ${expect_synrx} ]; then
-		printf " WARN: SYNRX: expect %d, got %d (probably retransmissions)" \
-			"${expect_synrx}" "${stat_synrx_now_l}"
+		extra+=" WARN: SYNRX: expect ${expect_synrx},"
+		extra+=" got ${stat_synrx_now_l} (probably retransmissions)"
 	fi
 	if [ ${stat_ackrx_now_l} -gt ${expect_ackrx} ]; then
-		printf " WARN: ACKRX: expect %d, got %d (probably retransmissions)" \
-			"${expect_ackrx}" "${stat_ackrx_now_l}"
+		extra+=" WARN: ACKRX: expect ${expect_ackrx},"
+		extra+=" got ${stat_ackrx_now_l} (probably retransmissions)"
+	fi
+
+	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
+		printf "[ OK ]%s\n" "${extra:1}"
+		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
+	else
+		if [ -n "${extra}" ]; then
+			printf "%s\n" "${extra:1}"
+		fi
+		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
 	fi
 
-	echo
 	cat "$capout"
 	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
@@ -865,8 +868,8 @@ stop_if_error "Could not even run ping tests"
 echo "[ OK ]"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
-echo -n "INFO: Using loss of $tc_loss "
-test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
+tc_info="loss of $tc_loss "
+test "$tc_delay" -gt 0 && tc_info+="delay $tc_delay ms "
 
 reorder_delay=$((tc_delay / 4))
 
@@ -877,17 +880,17 @@ if [ -z "${tc_reorder}" ]; then
 
 	if [ $reorder_delay -gt 0 ] && [ $reorder1 -lt 100 ] && [ $reorder2 -gt 0 ]; then
 		tc_reorder="reorder ${reorder1}% ${reorder2}%"
-		echo -n "$tc_reorder with delay ${reorder_delay}ms "
+		tc_info+="$tc_reorder with delay ${reorder_delay}ms "
 	fi
 elif [ "$tc_reorder" = "0" ];then
 	tc_reorder=""
 elif [ "$reorder_delay" -gt 0 ];then
 	# reordering requires some delay
 	tc_reorder="reorder $tc_reorder"
-	echo -n "$tc_reorder with delay ${reorder_delay}ms "
+	tc_info+="$tc_reorder with delay ${reorder_delay}ms "
 fi
 
-echo "on ns3eth4"
+echo "INFO: Using ${tc_info}on ns3eth4"
 
 tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms $tc_reorder
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2f34e2b9a1c4..d2969eec36d5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -754,18 +754,18 @@ pm_nl_check_endpoint()
 		line="${line% }"
 		# the dump order is: address id flags port dev
 		[ -n "$addr" ] && expected_line="$addr"
-		expected_line="$expected_line $id"
-		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
-		[ -n "$dev" ] && expected_line="$expected_line $dev"
-		[ -n "$port" ] && expected_line="$expected_line $port"
+		expected_line+=" $id"
+		[ -n "$_flags" ] && expected_line+=" ${_flags//","/" "}"
+		[ -n "$dev" ] && expected_line+=" $dev"
+		[ -n "$port" ] && expected_line+=" $port"
 	else
 		line=$(ip netns exec $ns ./pm_nl_ctl get $_id)
 		# the dump order is: id flags dev address port
 		expected_line="$id"
-		[ -n "$flags" ] && expected_line="$expected_line $flags"
-		[ -n "$dev" ] && expected_line="$expected_line $dev"
-		[ -n "$addr" ] && expected_line="$expected_line $addr"
-		[ -n "$_port" ] && expected_line="$expected_line $_port"
+		[ -n "$flags" ] && expected_line+=" $flags"
+		[ -n "$dev" ] && expected_line+=" $dev"
+		[ -n "$addr" ] && expected_line+=" $addr"
+		[ -n "$_port" ] && expected_line+=" $_port"
 	fi
 	if [ "$line" = "$expected_line" ]; then
 		print_ok
@@ -1216,7 +1216,7 @@ chk_csum_nr()
 	print_check "sum"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns1" ]; then
-		extra_msg="$extra_msg ns1=$count"
+		extra_msg+=" ns1=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1229,7 +1229,7 @@ chk_csum_nr()
 	print_check "csum"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns2" ]; then
-		extra_msg="$extra_msg ns2=$count"
+		extra_msg+=" ns2=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1273,7 +1273,7 @@ chk_fail_nr()
 	print_check "ftx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ "$count" != "$fail_tx" ]; then
-		extra_msg="$extra_msg,tx=$count"
+		extra_msg+=",tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1287,7 +1287,7 @@ chk_fail_nr()
 	print_check "failrx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ "$count" != "$fail_rx" ]; then
-		extra_msg="$extra_msg,rx=$count"
+		extra_msg+=",rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1322,7 +1322,7 @@ chk_fclose_nr()
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_tx" ]; then
-		extra_msg="$extra_msg,tx=$count"
+		extra_msg+=",tx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 	else
 		print_ok
@@ -1333,7 +1333,7 @@ chk_fclose_nr()
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_rx" ]; then
-		extra_msg="$extra_msg,rx=$count"
+		extra_msg+=",rx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 	else
 		print_ok
@@ -1702,7 +1702,7 @@ chk_rm_nr()
 		count=$((count + cnt))
 		if [ "$count" != "$rm_subflow_nr" ]; then
 			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
-			extra_msg="$extra_msg simult"
+			extra_msg+=" simult"
 		fi
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then

-- 
2.43.0


