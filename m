Return-Path: <linux-kselftest+bounces-19654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D199CC4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E051C21BAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996561B85C2;
	Mon, 14 Oct 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gycPjT1v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608231B4F2E;
	Mon, 14 Oct 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914815; cv=none; b=Vv9vpbjvoKgu544MinZsXT7B0d27kA0t1ulHwfcfTaqTIL8sYbTwnKJr3ZRXJfiEVzJAryjECuDEZ53V84ci/55AJ97Kq/XvsaGBRS1LQz6clDfMpYscnqCE4sugY4uWBeNb3A3zOectY08puePVoicnAkjQGbOcr681vAwj/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914815; c=relaxed/simple;
	bh=kjtFYgZ14FIDwbmtNTbCdsWne2fStMUuRE5AJPp6tsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GhfxGL6XtRUVoby1ncm61UMPFSOQwu0cMjetb/xpSY53I9IYd46ULXntfVYTwBK7PeuQvb8UHMbFK1fue2TyCy2/yHPWSxvm6X6N0tEMuolUKn18GOunnaKrmW6g/QdAqq9x7uU9OhvVo+HQTU/gFyMZEopEGN9nAeSW5kIPe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gycPjT1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B00BC4CEC3;
	Mon, 14 Oct 2024 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728914815;
	bh=kjtFYgZ14FIDwbmtNTbCdsWne2fStMUuRE5AJPp6tsw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gycPjT1vQL6ApVMmyVqY38Q4oBxlRo9bj4oThG0/9/R1nBGOCvxNWc6D/HLGhD/mN
	 2dpfeCMJJUPHH5gnIIOqX79YF+a9wopX7Bmy8PCo9lF/jHW63rtlkt1NxGtIW8mQLC
	 0HYvDN9Yl5dbnPkEWrwn3XUb994SAsP052AKxqle2lo83wTC7t533ADkN7rbHvG/0D
	 R3y5LaIWFmQ+0pz35w0H6Z6puYDV9WtnHvXMmq7xu6Kf3jpe9Fofrh2ahNhjGVwgBq
	 aiYEcl3aBPuqT/+mCAdsS+p+ZkEV3y3LIWzwuRXWb4LQLenO6mN7My2BWcUSnO5FFo
	 WMCaG0pVKNbjQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 14 Oct 2024 16:06:01 +0200
Subject: [PATCH net v2 2/2] selftests: mptcp: join: test for prohibited MPC
 to port-based endp
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-net-mptcp-mpc-port-endp-v2-2-7faea8e6b6ae@kernel.org>
References: <20241014-net-mptcp-mpc-port-endp-v2-0-7faea8e6b6ae@kernel.org>
In-Reply-To: <20241014-net-mptcp-mpc-port-endp-v2-0-7faea8e6b6ae@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5370; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cGGs3/aSLVRmuw8IC+TS07d8nPl/LooYfHgyMwOfjWQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnDSV0gIkefGEx4C17dByQf64ZK2kflu701FzHU
 hzMqUvPVrqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZw0ldAAKCRD2t4JPQmmg
 c0TfEAClevPSvAxkJ1KCHe+9lEbkKZcMzJ7S5RhP6a/CIX5ZnnLLCZjPKHmyg0PFg83Nw5ZtBGW
 aG0UdxcqdTV79IxGgvTrNcHjOIw7TaY6ZvA+4sRPMQ6YFjyRmhg2Yi4BprGbKC5vyVpY4hnDw5p
 T8X8FmAaIqxuX8GpRauNFVJ+i0VljNqQJ7Wo5mlNiLvMbFYPd1Em8VCo3HWHS56BHzNeLchCv4N
 dq4LF3wkmU2quPf4kYaOqmtaYaqyfqG7lwXvqDYtF+o1vsUjZDhUqaHQcGLAWPWMjcx4VCYJ3Y3
 MAFhbYAC6D/jNdC0m0yYhoaol8a/Fg06qXCCUpmDRHduAhYlvU1vMFXW9I1sK1fpBMwS+01Y+rF
 B8fZHCkRYTGLKNNjukUXwa87hRAE7n8Lyz+iiVZflrYNfc4x6gH1JA56OP2zZ8ZM16su14/aP5n
 OuQgDK3F/osTv480dTYIDXO9ENdxd7kxsg6OqXVZceioz8AJRYV5A/sC9ORteDLTv0jk/BvKjwn
 mzMnCPbuqCq15X5wzC+KnS0DTg58/josz89/OVbg8Lpqg2CUiuTKibC2LjBbSmGHvymvsT/N3Fw
 fc7mIR4IzqiDQZ8vohRhaoaoDaaaSG1q2n38a8u+oQF10KbYHRkUJIPntkp6QXAaEC5cXN7dL6u
 k9DZ0QV4bvTqtlQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Explicitly verify that MPC connection attempts towards a port-based
signal endpoint fail with a reset.

Note that this new test is a bit different from the other ones, not
using 'run_tests'. It is then needed to add the capture capability, and
the picking the right port which have been extracted into three new
helpers. The info about the capture can also be printed from a single
point, which simplifies the exit paths in do_transfer().

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Cc: stable@vger.kernel.org
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 117 +++++++++++++++++-------
 1 file changed, 86 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e8d0a01b4144264615d92b953a69ebd934ce468e..c07e2bd3a315aac9c422fed85c3196ec46e060f7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -23,6 +23,7 @@ tmpfile=""
 cout=""
 err=""
 capout=""
+cappid=""
 ns1=""
 ns2=""
 iptables="iptables"
@@ -887,6 +888,44 @@ check_cestab()
 	fi
 }
 
+cond_start_capture()
+{
+	local ns="$1"
+
+	:> "$capout"
+
+	if $capture; then
+		local capuser capfile
+		if [ -z $SUDO_USER ]; then
+			capuser=""
+		else
+			capuser="-Z $SUDO_USER"
+		fi
+
+		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "$ns")
+
+		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
+		ip netns exec "$ns" tcpdump -i any -s 65535 -B 32768 $capuser -w "$capfile" > "$capout" 2>&1 &
+		cappid=$!
+
+		sleep 1
+	fi
+}
+
+cond_stop_capture()
+{
+	if $capture; then
+		sleep 1
+		kill $cappid
+		cat "$capout"
+	fi
+}
+
+get_port()
+{
+	echo "$((10000 + MPTCP_LIB_TEST_COUNTER - 1))"
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -894,33 +933,17 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
+	local port
 
-	local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
-	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
+	port=$(get_port)
 
 	:> "$cout"
 	:> "$sout"
-	:> "$capout"
 
-	if $capture; then
-		local capuser
-		if [ -z $SUDO_USER ] ; then
-			capuser=""
-		else
-			capuser="-Z $SUDO_USER"
-		fi
-
-		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "${listener_ns}")
-
-		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
-		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
-		cappid=$!
-
-		sleep 1
-	fi
+	cond_start_capture ${listener_ns}
 
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat -n
@@ -1007,10 +1030,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if $capture; then
-	    sleep 1
-	    kill $cappid
-	fi
+	cond_stop_capture
 
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
@@ -1026,7 +1046,6 @@ do_transfer()
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
 		cat /tmp/${connector_ns}.out
 
-		cat "$capout"
 		return 1
 	fi
 
@@ -1043,13 +1062,7 @@ do_transfer()
 	fi
 	rets=$?
 
-	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
-		cat "$capout"
-		return 0
-	fi
-
-	cat "$capout"
-	return 1
+	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
 
 make_file()
@@ -2873,6 +2886,32 @@ verify_listener_events()
 	fail_test
 }
 
+chk_mpc_endp_attempt()
+{
+	local retl=$1
+	local attempts=$2
+
+	print_check "Connect"
+
+	if [ ${retl} = 124 ]; then
+		fail_test "timeout on connect"
+	elif [ ${retl} = 0 ]; then
+		fail_test "unexpected successful connect"
+	else
+		print_ok
+
+		print_check "Attempts"
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPCapableEndpAttempt")
+		if [ -z "$count" ]; then
+			print_skip
+		elif [ "$count" != "$attempts" ]; then
+			fail_test "got ${count} MPC attempt[s] on port-based endpoint, expected ${attempts}"
+		else
+			print_ok
+		fi
+	fi
+}
+
 add_addr_ports_tests()
 {
 	# signal address with port
@@ -2963,6 +3002,22 @@ add_addr_ports_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2 2
 	fi
+
+	if reset "port-based signal endpoint must not accept mpc"; then
+		local port retl count
+		port=$(get_port)
+
+		cond_start_capture ${ns1}
+		pm_nl_add_endpoint ${ns1} 10.0.2.1 flags signal port ${port}
+		mptcp_lib_wait_local_port_listen ${ns1} ${port}
+
+		timeout 1 ip netns exec ${ns2} \
+			./mptcp_connect -t ${timeout_poll} -p $port -s MPTCP 10.0.2.1 >/dev/null 2>&1
+		retl=$?
+		cond_stop_capture
+
+		chk_mpc_endp_attempt ${retl} 1
+	fi
 }
 
 syncookies_tests()

-- 
2.45.2


