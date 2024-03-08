Return-Path: <linux-kselftest+bounces-6124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DCE876CD5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA391C219B4
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EBB61688;
	Fri,  8 Mar 2024 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rit7KkAy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BAD604AE;
	Fri,  8 Mar 2024 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935847; cv=none; b=nKmiRuckE7EQL8CK8JXlyrdEjanwnRz4OzBsj5LKASnAwbIm2ce/8CJqHcxMT7Xp5ZJUbAtHXRVuLNcARu5lkLo8/okomZxinwtKlVVYk6lIwCVsdOxjKpArwZv+JqMoQQ8JjFdpaMLR8QDY9kDJ4Fz5swLlyg0Pg+azlmeWfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935847; c=relaxed/simple;
	bh=k3pO3hnLCW/alnlqIUwAbF2UvgKeQHQuP8aHNnAk8HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hPToTKiyZokKWVL2NLC9xYqiezIPr0Zm/SxQLyMc6BFsMUgb2eFV244a6u6TFyzWgEnoq9vVaJ09wit+7vZ3cRBvGYa4blg+DZWz0QuWudhvAPz4wNPNe4UMnnN1Qz2QPtJ2MXvlQ2wq18ZeUs+0xCjTNbW05Pquz178u8BaYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rit7KkAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D95C433C7;
	Fri,  8 Mar 2024 22:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935847;
	bh=k3pO3hnLCW/alnlqIUwAbF2UvgKeQHQuP8aHNnAk8HM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rit7KkAy9BK0mjHDy3Ao4UFqmYdKbae3cu0tBaAjCNo9uyF3/m8tvNGj2BuLFWTBF
	 +KUaa2Z3RvISXynO8MOFv/D0znIYzH+R+gH9v9j7gMA6c8tczf5/nOVKEsYxQ8w8TR
	 0w2kSynFZVN8+UUBeOtPbrSwCRjWrWq8d8VheGsXayDxoWiQk4n64lgxuofEqH7cfI
	 8Vxm2qLVJ9o+i/J/QqVMQlJMU/UVbvZvxU3+9ZBN5owUg17xkp/71uvGz3E3dnr7xE
	 PNm05XPBzPJH+iTYyDuAWhYwli8t5dGAPg7D0dkYKXfr3GTyMdRjsrk4JpMxUl0AGy
	 IIz2F/ml6VGdA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:14 +0100
Subject: [PATCH net-next 07/15] selftests: mptcp: print test results with
 counters
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-7-4f42c347b653@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8730; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DjHe3xAzBiAiqIyC1BiWr2qIGtMGUJkKvi+FFhkNfuE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJjcM0NGUIHMzJGAVkeGA3DIxFJyj7gawsv
 3XX62rlWzyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 c9tMD/0ZoZIZoVlJLVbfldNJalShseMQTSvsfEysN5Ot6e+4TX8nVJN0mlJTyRyAMr2KjsRnO9x
 OBFi+FNV+Dgfr4+NjyMTy2PMo0Zy9uHnZsEYvElGQcrn4oc2+f98B2PY3jSQYeihADgae+9z4aq
 CUbzwZTt7/2/qlS7XI4116Pc/CXz/WkkAidZbvqhvvPTIhMC/g7/S+nQSyiko2gyS76BWghkRL8
 Pf7S8Lkv212452IF4nCYmm9WXOhKR3ESj2EqDC5l5Kt0ay+GcoMwrZn/NJthVDxA6Rew5R0c2Jv
 Pmn30DeWiPfAfLn7w6tGpNIF2ftE9CepT9A+5VG+PvW+9pfYYD/LCX6g8zw1h4X6lmuAcrG3Jek
 gOu4tb28MlC6/T1jegfIbwKZAiv0zG3n2hII9xre2v0fqduiQ3YranQzg8iIja9xnrHCSyC5Nf1
 g2I2/M0NMes62LL1jcdbqIdNcFXg/dmZ+/LKs36twfjGFLU/VjDSPtP6+d4ZZp0knrolXcaekNF
 cIwD3LUrwOTRP2bzzj6V8EnAfpfOVOlCIUhcBTcPAu+amQvcvusKZyR9fhYpA5EcBdLLvLeN8tS
 arnugFwNjSkx2ArXjbRkW3q3Go6c8GlOu4gVtLAQSC3iS79skVK+4VYtcnpALM+3jhWadHUFVLN
 aZp0j8XHn0Hxlyg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper mptcp_lib_print_title(), a wrapper of
mptcp_lib_inc_test_counter() and mptcp_lib_pr_title_counter(), to
print out test counter in each test result and increase the counter.
Use this helper to print out test counters for every tests in diag.sh,
mptcp_connect.sh, mptcp_sockopt.sh, pm_netlink.sh, simult_flows.sh,
and userspace_pm.sh.

diag.sh:

01 no msk on netns creation                          [  ok  ]
02 listen match for dport 10000                      [  ok  ]
03 listen match for sport 10000                      [  ok  ]
04 listen match for saddr and sport                  [  ok  ]
05 all listen sockets                                [  ok  ]

mptcp_connect.sh:

01 New MPTCP socket can be blocked via sysctl                       [ OK ]
02 Validating network environment with pings                        [ OK ]
INFO: Using loss of 0.85% delay 31 ms reorder .. with delay 7ms on ns3eth4
03 ns1 MPTCP -> ns1 (10.0.1.1:10000  ) MPTCP     (duration    69ms) [ OK ]
04 ns1 MPTCP -> ns1 (10.0.1.1:10001  ) TCP       (duration    20ms) [ OK ]
05 ns1 TCP   -> ns1 (10.0.1.1:10002  ) MPTCP     (duration    16ms) [ OK ]

mptcp_sockopt.sh:

01 Transfer v4                                       [ OK ]
02 Mark v4                                           [ OK ]
03 Transfer v6                                       [ OK ]
04 Mark v6                                           [ OK ]
05 SOL_MPTCP sockopt v4                              [ OK ]

pm_netlink.sh:

01 defaults addr list                                [ OK ]
02 simple add/get addr                               [ OK ]
03 dump addrs                                        [ OK ]
04 simple del addr                                   [ OK ]
05 dump addrs after del                              [ OK ]

simult_flows.sh:

01 balanced bwidth                                     7391 max 8456 [ OK ]
02 balanced bwidth - reverse direction                 7403 max 8456 [ OK ]
03 balanced bwidth with unbalanced delay               7429 max 8456 [ OK ]
04 balanced bwidth with unbalanced delay - reverse ... 7485 max 8456 [ OK ]
05 unbalanced bwidth                                   7549 max 8456 [ OK ]

userspace_pm.sh:

01 Created network namespaces ns1, ns2                               [ OK ]
INFO: Make connections
02 Established IPv4 MPTCP Connection ns2 => ns1                      [ OK ]
03 Established IPv6 MPTCP Connection ns2 => ns1                      [ OK ]
INFO: Announce tests
04 ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token                     [ OK ]
05 ADD_ADDR id:67 10.0.2.2 (ns2) => ns1, reuse port                  [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 6 ++----
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 5 +++--
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 7 ++++---
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 4 +++-
 6 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index b63510ce2327..4ffdd415e670 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -54,7 +54,7 @@ __chk_nr()
 
 	nr=$(eval $command)
 
-	printf "%-50s" "$msg"
+	mptcp_lib_print_title "$msg"
 	if [ "$nr" != "$expected" ]; then
 		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			echo "[ skip ] Feature probably not supported"
@@ -68,7 +68,6 @@ __chk_nr()
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 }
 
 __chk_msk_nr()
@@ -113,7 +112,7 @@ wait_msk_nr()
 		sleep 1
 	done
 
-	printf "%-50s" "$msg"
+	mptcp_lib_print_title "$msg"
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
@@ -126,7 +125,6 @@ wait_msk_nr()
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 }
 
 chk_msk_fallback_nr()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 915faee77e25..bbda37d6514f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -249,7 +249,8 @@ fi
 
 print_larger_title() {
 	# here we don't have the time, a bit longer for the alignment
-	printf "%-69s" "${@}"
+	MPTCP_LIB_TEST_FORMAT="%02u %-69s" \
+		mptcp_lib_print_title "${@}"
 }
 
 check_mptcp_disabled()
@@ -320,7 +321,6 @@ do_transfer()
 	local extra_args="$7"
 
 	port=$((port + 1))
-	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
@@ -347,7 +347,7 @@ do_transfer()
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
 	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
-	printf "%-50s" "${result_msg}"
+	mptcp_lib_print_title "${result_msg}"
 
 	if $capture; then
 		local capuser
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 17b36c1312f4..19d0ac31b6a9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -115,7 +115,7 @@ check_mark()
 
 print_title()
 {
-	printf "%-50s" "${@}"
+	mptcp_lib_print_title "${@}"
 }
 
 do_transfer()
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 427fc5c70b3c..5b9bc25dfef4 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -53,7 +53,7 @@ check()
 	local msg="$3"
 	local rc=0
 
-	printf "%-50s" "$msg"
+	mptcp_lib_print_title "$msg"
 	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
 	if [ ${rc} -eq 2 ]; then
 		mptcp_lib_result_fail "${msg} # error ${rc}"
@@ -189,7 +189,8 @@ subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"
-		printf "%-50s%s\n" "${st}" "[SKIP]"
+		mptcp_lib_print_title "${st}"
+		echo "[SKIP]"
 		mptcp_lib_result_skip "${st}"
 	done
 fi
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 3ad663e38c42..b7549d9364d6 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -14,6 +14,8 @@ ns3=""
 capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
+# a bit more space: because we have more to display
+MPTCP_LIB_TEST_FORMAT="%02u %-60s"
 ret=0
 bail=0
 slack=50
@@ -126,7 +128,6 @@ do_transfer()
 	local max_time=$3
 	local port
 	port=$((10000+MPTCP_LIB_TEST_COUNTER))
-	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 
 	:> "$cout"
 	:> "$sout"
@@ -238,7 +239,7 @@ run_test()
 	# completion (see mptcp_connect): 200ms on each side, add some slack
 	time=$((time + 400 + slack))
 
-	printf "%-60s" "$msg"
+	mptcp_lib_print_title "$msg"
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
@@ -248,7 +249,7 @@ run_test()
 	fi
 
 	msg+=" - reverse direction"
-	printf "%-60s" "${msg}"
+	mptcp_lib_print_title "${msg}"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b0cce8f065d8..ca238592baee 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -54,6 +54,8 @@ ns1=""
 ns2=""
 ret=0
 test_name=""
+# a bit more space: because we have more to display
+MPTCP_LIB_TEST_FORMAT="%02u %-68s"
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -69,7 +71,7 @@ print_test()
 {
 	test_name="${1}"
 
-	_printf "%-68s" "${test_name}"
+	mptcp_lib_print_title "${test_name}"
 }
 
 print_results()

-- 
2.43.0


