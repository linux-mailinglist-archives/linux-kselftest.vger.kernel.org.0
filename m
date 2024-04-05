Return-Path: <linux-kselftest+bounces-7264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2039A899B4A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB054283BE1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B48A16C84F;
	Fri,  5 Apr 2024 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki+bNMTx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A116C84C;
	Fri,  5 Apr 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314361; cv=none; b=bE3+mBi/JQVAI08ecfcuZEgzQWKsa2edmr+nCRRi9mkoVyOonk+awTM3ofAaW1RMHRoLGTH+29wf7L41M+Q5gzx+ZNQio3ihh6pGtArqiKR8zM1orCGAr+Ct2NAPZCpTB9Hih4cSGOQ7j+tpZDuj1wi+if13QGkJ9I86CXTmd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314361; c=relaxed/simple;
	bh=sqEcY9subOu+shrD8qPfY1vzojQ+5OSJgB0mGYORrSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LBOEdTkPvp3++qS4n5/rChe8t3lqXahcsICSF7+gf446xjlTzVXhc0HvC5xO3f5FAkTs5smS0CzrRwzuokS4cGLkbKzCWDmHwNb4Asil+/av741m8XbSD6rzWzNnpVeZsG6/qPIOtHmGKPs3PV3n5jp9ngusAzonY/15TkfmHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki+bNMTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CB1C43394;
	Fri,  5 Apr 2024 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314360;
	bh=sqEcY9subOu+shrD8qPfY1vzojQ+5OSJgB0mGYORrSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ki+bNMTxbWVCW0odv61Sn/deuvvvFA1bmCiRGAsN+HXQhxHPnSVlDPqEKmqZ+QCoF
	 FckvNecapYUxzdkwut3IMf2OzA3RW0ThjtCes+9yLTr2T6bTWacgoge+ewFsol3pAJ
	 ng0RtErFTL7BO0Wgh6ND9kxr3OR1GHwH99zloQFcjhgT5StFFeMuc2EYQkIG3lrrD6
	 Sjjpw9edGgg4qkWdychOB8d4h2Azn+z1tn7fNCrWl7YXvTXWqL4l3cNx4FSaEBi1tx
	 8TNHf3S0md6qT9w7UEGvCo39SndtPdA9h+YL5PKkqj9htXogbvVpL6HwNAZtucceea
	 ywSw1+MoxfUIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 12:52:09 +0200
Subject: [PATCH net-next 05/11] selftests: mptcp: add
 {get,format}_endpoint(s) helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-5-eabc9b960966@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11129; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YRoZ+sXiGSaIhqmdWi6B71t+bOturpL6AYnxqOWpiTs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD9flEwtPtcLCOz7Nynjm0ZbDcboQXWV39EBUX
 pohWrn5k4OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/X5QAKCRD2t4JPQmmg
 c9vGEADfZVvrvLk5jLhs/7Eht4BxRNbbXWSmvRz6PmSocFxilm6ijgnALzY6os3Xe1m5BTdXtel
 902IbRl1HILLvCw1BoXy8b7UbLjTZbZwB64DrAfj4RVEERmqVFgivothunPAhnkMgt5GfFgzDTT
 v39fw1hOsgmrqh+G37z5aicUov/c1NbphjE23DbPckEG4YyBJPoT5LoYeDjM1UnKoNbF/f2HunN
 r4JIXO6cRlVbZZ44PR/Ad5t7geLKlOjU+6aCiVQnR4MJ0Vwk54kmys8tuE6CcH2Vcom6r5sGVFY
 T8bgmIyNkFNevkNy5RouPQ8+F6tsP8vfiY2jCNVMYc8xTQja9Tk0q9OXOZUElxjm2aSS/boasZx
 YRMWYpCdajV3no5j8Nksj8KleOn61Sne0Kl+w6vQGJEclMQmbQv12ojxKvq8QUVKZPRk+sfM1/b
 fleZ7DwPPinWLTbW/DGtccr5+5LQVn/RTwjd2KbeMdZvu1lfyzFCo9axI3tFXrqYnywPzhg8DMF
 gcrfUwFCeFG6GMb0YrYiHZIfkClvo2RJe8KkEK+dTS3bVwKz8oO9uPQCrCJMCHVOUklCY/isyav
 Ib9w/aFvFrT+4Z2wGbp3mxajSH6L6EkOjkpZ/ze+YZiGh5xodoO14G0aCT/HaU81gKVoZ83yquP
 K5XDAyQO/ILR7fw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The output formats of 'ip mptcp' commands are much different from that
of 'pm_nl_ctl' commands.

This patch adds a new helper format_endpoints() to format the outputs of
'ip mptcp' and 'pm_nl_ctl' with 'endpoints' arguments to hide these
differences.

A new helper named get_endpoint() has also been added to show a specific
endpoint identified by the given address ID, similar to mptcp_join.sh's
pm_nl_show_endpoints() helper, but showing all entries.

Use these two helpers in mptcp_join.sh and pm_netlink.sh to replace all
'pm_nl_ctl get' commands and outputs of 'pm_nl_ctl dump/get'.

Suggested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  32 ++------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  35 ++++++++
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 102 ++++++++++++++----------
 3 files changed, 98 insertions(+), 71 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 62fcfeaa3430..d48da81daa06 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -712,12 +712,9 @@ pm_nl_check_endpoint()
 	local ns=$2
 	local addr=$3
 	local _flags=""
-	local flags
 	local _port
-	local port
 	local dev
 	local _id
-	local id
 
 	print_check "${msg}"
 
@@ -725,48 +722,29 @@ pm_nl_check_endpoint()
 	while [ -n "$1" ]; do
 		if [ $1 = "flags" ]; then
 			_flags=$2
-			[ -n "$_flags" ]; flags="flags $_flags"
 			shift
 		elif [ $1 = "dev" ]; then
-			[ -n "$2" ]; dev="dev $2"
+			[ -n "$2" ]; dev="$2"
 			shift
 		elif [ $1 = "id" ]; then
 			_id=$2
-			[ -n "$_id" ]; id="id $_id"
 			shift
 		elif [ $1 = "port" ]; then
 			_port=$2
-			[ -n "$_port" ]; port=" port $_port"
 			shift
 		fi
 
 		shift
 	done
 
-	if [ -z "$id" ]; then
+	if [ -z "${_id}" ]; then
 		test_fail "bad test - missing endpoint id"
 		return
 	fi
 
-	if mptcp_lib_is_ip_mptcp; then
-		# get line and trim trailing whitespace
-		line=$(ip -n $ns mptcp endpoint show $id)
-		line="${line% }"
-		# the dump order is: address id flags port dev
-		[ -n "$addr" ] && expected_line="$addr"
-		expected_line+=" $id"
-		[ -n "$_flags" ] && expected_line+=" ${_flags//","/" "}"
-		[ -n "$dev" ] && expected_line+=" $dev"
-		[ -n "$port" ] && expected_line+=" $port"
-	else
-		line=$(ip netns exec $ns ./pm_nl_ctl get $_id)
-		# the dump order is: id flags dev address port
-		expected_line="$id"
-		[ -n "$flags" ] && expected_line+=" $flags"
-		[ -n "$dev" ] && expected_line+=" $dev"
-		[ -n "$addr" ] && expected_line+=" $addr"
-		[ -n "$_port" ] && expected_line+=" $_port"
-	fi
+	line=$(mptcp_lib_pm_nl_get_endpoint "${ns}" "${_id}")
+	expected_line=$(mptcp_lib_pm_nl_format_endpoints \
+		"${_id},${addr},${_flags//","/" "},${dev},${_port}")
 	if [ "$line" = "$expected_line" ]; then
 		print_ok
 	else
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ca01d949fad8..4fabb0091940 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -520,3 +520,38 @@ mptcp_lib_set_ip_mptcp() {
 mptcp_lib_is_ip_mptcp() {
 	[ "${MPTCP_LIB_IP_MPTCP}" = "1" ]
 }
+
+# format: <id>,<ip>,<flags>,<dev>
+mptcp_lib_pm_nl_format_endpoints() {
+	local entry id ip flags dev port
+
+	for entry in "${@}"; do
+		IFS=, read -r id ip flags dev port <<< "${entry}"
+		if mptcp_lib_is_ip_mptcp; then
+			echo -n "${ip}"
+			[ -n "${port}" ] && echo -n " port ${port}"
+			echo -n " id ${id}"
+			[ -n "${flags}" ] && echo -n " ${flags}"
+			[ -n "${dev}" ] && echo -n " dev ${dev}"
+			echo " " # always a space at the end
+		else
+			echo -n "id ${id}"
+			echo -n " flags ${flags//" "/","}"
+			[ -n "${dev}" ] && echo -n " dev ${dev}"
+			echo -n " ${ip}"
+			[ -n "${port}" ] && echo -n " ${port}"
+			echo ""
+		fi
+	done
+}
+
+mptcp_lib_pm_nl_get_endpoint() {
+	local ns=${1}
+	local id=${2}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns}" mptcp endpoint show id "${id}"
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl get "${id}"
+	fi
+}
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index d672d1e5d470..234b88eba0cb 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -66,6 +66,15 @@ get_limits() {
 	fi
 }
 
+format_endpoints() {
+	mptcp_lib_pm_nl_format_endpoints "${@}"
+}
+
+get_endpoint() {
+	# shellcheck disable=SC2317 # invoked indirectly
+	mptcp_lib_pm_nl_get_endpoint "${ns1}" "${@}"
+}
+
 check()
 {
 	local cmd="$1"
@@ -97,43 +106,44 @@ fi
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
-check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1" "simple add/get addr"
+check "get_endpoint 1" "$(format_endpoints "1,10.0.1.1")" "simple add/get addr"
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 2 flags subflow dev lo 10.0.1.2
-id 3 flags signal,backup 10.0.1.3" "dump addrs"
+	"$(format_endpoints "1,10.0.1.1" \
+			    "2,10.0.1.2,subflow,lo" \
+			    "3,10.0.1.3,signal backup")" "dump addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl del 2
-check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
+check "get_endpoint 2" "" "simple del addr"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3" "dump addrs after del"
+	"$(format_endpoints "1,10.0.1.1" \
+			    "3,10.0.1.3,signal backup")" "dump addrs after del"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
+check "get_endpoint 4" "" "duplicate addr"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4" "id addr increment"
+check "get_endpoint 4" "$(format_endpoints "4,10.0.1.4,signal")" "id addr increment"
 
 for i in $(seq 5 9); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
 done
-check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9" "hard addr limit"
-check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
+check "get_endpoint 9" "$(format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
+check "get_endpoint 10" "" "above hard addr limit"
 
 ip netns exec $ns1 ./pm_nl_ctl del 9
 for i in $(seq 10 255); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
 	ip netns exec $ns1 ./pm_nl_ctl del $i
 done
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3
-id 4 flags signal 10.0.1.4
-id 5 flags signal 10.0.1.5
-id 6 flags signal 10.0.1.6
-id 7 flags signal 10.0.1.7
-id 8 flags signal 10.0.1.8" "id limit"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(format_endpoints "1,10.0.1.1" \
+			    "3,10.0.1.3,signal backup" \
+			    "4,10.0.1.4,signal" \
+			    "5,10.0.1.5,signal" \
+			    "6,10.0.1.6,signal" \
+			    "7,10.0.1.7,signal" \
+			    "8,10.0.1.8,signal")" "id limit"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
@@ -156,14 +166,15 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.5 id 254
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.6
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.7
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
-id 2 flags  10.0.1.2
-id 3 flags  10.0.1.7
-id 4 flags  10.0.1.8
-id 100 flags  10.0.1.3
-id 101 flags  10.0.1.4
-id 254 flags  10.0.1.5
-id 255 flags  10.0.1.6" "set ids"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(format_endpoints "1,10.0.1.1" \
+			    "2,10.0.1.2" \
+			    "3,10.0.1.7" \
+			    "4,10.0.1.8" \
+			    "100,10.0.1.3" \
+			    "101,10.0.1.4" \
+			    "254,10.0.1.5" \
+			    "255,10.0.1.6")" "set ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
@@ -174,36 +185,39 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.6
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.7
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.0.1
-id 2 flags  10.0.0.4
-id 3 flags  10.0.0.6
-id 4 flags  10.0.0.7
-id 5 flags  10.0.0.8
-id 253 flags  10.0.0.5
-id 254 flags  10.0.0.2
-id 255 flags  10.0.0.3" "wrap-around ids"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(format_endpoints "1,10.0.0.1" \
+			    "2,10.0.0.4" \
+			    "3,10.0.0.6" \
+			    "4,10.0.0.7" \
+			    "5,10.0.0.8" \
+			    "253,10.0.0.5" \
+			    "254,10.0.0.2" \
+			    "255,10.0.0.3")" "wrap-around ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup 10.0.1.1" "set flags (backup)"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow backup")" \
+	"set flags (backup)"
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nobackup)"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow")" \
+	"          (nobackup)"
 
 # fullmesh support has been added later
 ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh 2>/dev/null
 if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,fullmesh 10.0.1.1" "          (fullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"$(format_endpoints "1,10.0.1.1,subflow fullmesh")" \
+		"          (fullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nofullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow")" \
+		"          (nofullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"$(format_endpoints "1,10.0.1.1,subflow backup fullmesh")" \
+		"          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"

-- 
2.43.0


