Return-Path: <linux-kselftest+bounces-7268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5A7899B56
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D9928119B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F5616D4E5;
	Fri,  5 Apr 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY4bZt3G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF716D4DD;
	Fri,  5 Apr 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314373; cv=none; b=XrVco6IHZRriyvNYZUjZDuuGsyU5ffe1w0Mbaf00lka0sty1HB8onpqb/jyUu06tevNM70jFlsu6HzD3K1ebHwz4flp1ejqPc8x8sM2jIbklrbxqmcXUgWfpbx6dL/iIRt5MkN1Ep5d6FMUqlenP8UD5NA5sevoeXxocSJRAvG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314373; c=relaxed/simple;
	bh=pTGLSwia1x5RE5RIuTY9QpArinZBbEncrL36CaVw3uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yqs3VVk9+ink6ZIGaiq0n2FkiikK0t+gOsxqH3XU3urGJdRVPIfFGgzkMHrtucohL8eSS9xE3Gglk9qgquei54xi54bWf4Nx6bJGAzpzUSmCyqYZPqGY3hiAx9KpYYKxwEzhfl0AyBQS6LJwBId9ak3vV9wBmIMAFah55v1gjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY4bZt3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2914DC433B1;
	Fri,  5 Apr 2024 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314372;
	bh=pTGLSwia1x5RE5RIuTY9QpArinZBbEncrL36CaVw3uw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UY4bZt3GB1fpvpe6pFrKY+B7UbTHiVU//i2GjeZPmo5FXEBXZzcrEZfEGynUS4S36
	 33cSvixg+zcVCSJDDU6Ve1dwEVg+Rk4b5eXbiobRLGs8avC3FHH5l5iFD/0PZyTntM
	 yPVD2XG2KAdM7JJIe3YEbN40rq88ZGwrMcpJ3B325/czOKVoQvEwXNzB3nEWpEvKhg
	 uHyHC6rVfX/HyFGJX0pVIiqL+o3MYibdg1ZpkBIssQ4+/WiN3Q6jLRMjGt7By7ymFv
	 vPhuqDuyO+4Bfm+UQsB3yQgbj28SdJ4h5K9Y3tRBHoaSdCl+hRC6dB5ywyXhDAY08a
	 XvpmJOBxRmCjQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 12:52:13 +0200
Subject: [PATCH net-next 09/11] selftests: mptcp: use pm_nl endpoint ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-9-eabc9b960966@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10639; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SGo6zAcWNTK/FHCff6+pHMfSVpRcpIIH8pR0briaxJs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD9fmmwUptLYcgjWbSqsyrxo0M4h35XU4oN1iX
 qDm7qy5gqmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/X5gAKCRD2t4JPQmmg
 c8jWD/9QBlyD7dDra6lvtr1bJ30/AZmfYaX9Hpg6XsUonjzh79Jz3lK0dSMAho3QLj5dqrvHRH7
 Hxos7oOWvL6rUgiolVVo4NAFCxcMWWvsXrda/lmHWzKJ5PJ6eks3KM8H6VJjrNIeWXZVZPDN9oG
 FE4gDstps4+ZFTGHg3I5BjxzYmGT/sFjfyDauMoPH6HEGEIzX0YeY1Y/liySAgxeyaikfdF0+29
 sfDwmdGWzavIsmMqTbKDbvarFvj9MDkVkuRknRZ/HPbQ8ZEjoPTzt9LOMH/Oh2rB0UGpVY7Xg6u
 PdLuAI7BeujAplvaKRWh4qbRA6S6Avt1v1vf57dKNTypuu5LET2Fdzu3OeXWFA8Mj/C7H62BrPU
 Bdle4P3rriIPBnWSQIzwbocgJRz6SetWSywMu4ypTEt6tLbGDaXN7jUHE4k7o9RU7u+jYvO8t8C
 xuTQdHYn1GrLn1p+RWxcMqjkds3AaEYo30aRgAY/WUkG0zGUj6xC2HG/J86P/01Czd1LKkTkGG6
 ff2tkWlaumxSXU93hSrkzVkWjI0XsJch8nARPjO8QVCsPn15NsT2J0QplkT/Y9B4STdK9lGZjpX
 5IsqycVEFwtjPKd/sdQK42com2gdk+vYidWrSfnG23GARSx3xYwHjYPQRJLybOMcTnmKrYX0/Or
 xalCPrtC6f+HMxw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Use those newly added pm_nl endpoint ops helpers to replace all 'pm_nl_ctl'
commands with 'limits', 'add', 'del', 'flush', 'show' and 'set' arguments
in scripts mptcp_sockopt.sh and simult_flows.sh.

In pm_netlink.sh, add wrappers of there helpers to make the function names
shorter. Then use the wrappers to replace all 'pm_nl_ctl' commands.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  12 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 132 +++++++++++++--------
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   6 +-
 3 files changed, 89 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e2d70c18786e..36e81383f0e2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -58,15 +58,15 @@ init()
 		# let $ns2 reach any $ns1 address from any interface
 		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
 
-		ip netns exec $ns1 ./pm_nl_ctl add 10.0.$i.1 flags signal
-		ip netns exec $ns1 ./pm_nl_ctl add dead:beef:$i::1 flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns1}" "10.0.${i}.1" flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns1}" "dead:beef:${i}::1" flags signal
 
-		ip netns exec $ns2 ./pm_nl_ctl add 10.0.$i.2 flags signal
-		ip netns exec $ns2 ./pm_nl_ctl add dead:beef:$i::2 flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns2}" "10.0.${i}.2" flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns2}" "dead:beef:${i}::2" flags signal
 	done
 
-	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
+	mptcp_lib_pm_nl_set_limits "${ns2}" 8 8
 
 	add_mark_rules $ns1 1
 	add_mark_rules $ns2 2
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index e27a731bd765..b3adb39a7d3d 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -86,6 +86,36 @@ change_address() {
 	fi
 }
 
+set_limits()
+{
+	mptcp_lib_pm_nl_set_limits "${ns1}" "${@}"
+}
+
+add_endpoint()
+{
+	mptcp_lib_pm_nl_add_endpoint "${ns1}" "${@}"
+}
+
+del_endpoint()
+{
+	mptcp_lib_pm_nl_del_endpoint "${ns1}" "${@}"
+}
+
+flush_endpoint()
+{
+	mptcp_lib_pm_nl_flush_endpoint "${ns1}"
+}
+
+show_endpoints()
+{
+	mptcp_lib_pm_nl_show_endpoints "${ns1}"
+}
+
+change_endpoint()
+{
+	mptcp_lib_pm_nl_change_endpoint "${ns1}" "${@}"
+}
+
 check()
 {
 	local cmd="$1"
@@ -107,47 +137,47 @@ check()
 	fi
 }
 
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
+check "show_endpoints" "" "defaults addr list"
 
 default_limits="$(get_limits)"
 if mptcp_lib_expect_all_features; then
 	check "get_limits" "$(format_limits 0 2)" "defaults limits"
 fi
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
+add_endpoint 10.0.1.1
+add_endpoint 10.0.1.2 flags subflow dev lo
+add_endpoint 10.0.1.3 flags signal,backup
 check "get_endpoint 1" "$(format_endpoints "1,10.0.1.1")" "simple add/get addr"
 
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "2,10.0.1.2,subflow,lo" \
 			    "3,10.0.1.3,signal backup")" "dump addrs"
 
-ip netns exec $ns1 ./pm_nl_ctl del 2
+del_endpoint 2
 check "get_endpoint 2" "" "simple del addr"
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "3,10.0.1.3,signal backup")" "dump addrs after del"
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
+add_endpoint 10.0.1.3 2>/dev/null
 check "get_endpoint 4" "" "duplicate addr"
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
+add_endpoint 10.0.1.4 flags signal
 check "get_endpoint 4" "$(format_endpoints "4,10.0.1.4,signal")" "id addr increment"
 
 for i in $(seq 5 9); do
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
+	add_endpoint "10.0.1.${i}" flags signal >/dev/null 2>&1
 done
 check "get_endpoint 9" "$(format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
 check "get_endpoint 10" "" "above hard addr limit"
 
-ip netns exec $ns1 ./pm_nl_ctl del 9
+del_endpoint 9
 for i in $(seq 10 255); do
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
-	ip netns exec $ns1 ./pm_nl_ctl del $i
+	add_endpoint 10.0.0.9 id "${i}"
+	del_endpoint "${i}"
 done
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "3,10.0.1.3,signal backup" \
 			    "4,10.0.1.4,signal" \
@@ -156,28 +186,28 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 			    "7,10.0.1.7,signal" \
 			    "8,10.0.1.8,signal")" "id limit"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
+flush_endpoint
+check "show_endpoints" "" "flush addrs"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 9 1 2>/dev/null
+set_limits 9 1 2>/dev/null
 check "get_limits" "${default_limits}" "rcv addrs above hard limit"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
+set_limits 1 9 2>/dev/null
 check "get_limits" "${default_limits}" "subflows above hard limit"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+set_limits 8 8
 check "get_limits" "$(format_limits 8 8)" "set limits"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 id 100
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.5 id 254
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.6
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.7
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+flush_endpoint
+add_endpoint 10.0.1.1
+add_endpoint 10.0.1.2
+add_endpoint 10.0.1.3 id 100
+add_endpoint 10.0.1.4
+add_endpoint 10.0.1.5 id 254
+add_endpoint 10.0.1.6
+add_endpoint 10.0.1.7
+add_endpoint 10.0.1.8
+check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "2,10.0.1.2" \
 			    "3,10.0.1.7" \
@@ -187,16 +217,16 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 			    "254,10.0.1.5" \
 			    "255,10.0.1.6")" "set ids"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.2 id 254
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.3
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.4
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.6
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.7
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+flush_endpoint
+add_endpoint 10.0.0.1
+add_endpoint 10.0.0.2 id 254
+add_endpoint 10.0.0.3
+add_endpoint 10.0.0.4
+add_endpoint 10.0.0.5 id 253
+add_endpoint 10.0.0.6
+add_endpoint 10.0.0.7
+add_endpoint 10.0.0.8
+check "show_endpoints" \
 	"$(format_endpoints "1,10.0.0.1" \
 			    "2,10.0.0.4" \
 			    "3,10.0.0.6" \
@@ -206,28 +236,26 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 			    "254,10.0.0.2" \
 			    "255,10.0.0.3")" "wrap-around ids"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
+flush_endpoint
+add_endpoint 10.0.1.1 flags subflow
 change_address 10.0.1.1 backup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow backup")" \
+check "show_endpoints" "$(format_endpoints "1,10.0.1.1,subflow backup")" \
 	"set flags (backup)"
 change_address 10.0.1.1 nobackup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow")" \
+check "show_endpoints" "$(format_endpoints "1,10.0.1.1,subflow")" \
 	"          (nobackup)"
 
 # fullmesh support has been added later
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh 2>/dev/null
-if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
+change_endpoint 1 fullmesh 2>/dev/null
+if show_endpoints | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-		"$(format_endpoints "1,10.0.1.1,subflow fullmesh")" \
+	check "show_endpoints" "$(format_endpoints "1,10.0.1.1,subflow fullmesh")" \
 		"          (fullmesh)"
-	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow")" \
+	change_endpoint 1 nofullmesh
+	check "show_endpoints" "$(format_endpoints "1,10.0.1.1,subflow")" \
 		"          (nofullmesh)"
-	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-		"$(format_endpoints "1,10.0.1.1,subflow backup fullmesh")" \
+	change_endpoint 1 backup,fullmesh
+	check "show_endpoints" "$(format_endpoints "1,10.0.1.1,subflow backup fullmesh")" \
 		"          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 4e6d8fc56b38..3ebb2fb12c8a 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -85,8 +85,8 @@ setup()
 	ip -net "$ns1" route add default via 10.0.2.2 metric 101
 	ip -net "$ns1" route add default via dead:beef:2::2 metric 101
 
-	ip netns exec "$ns1" ./pm_nl_ctl limits 1 1
-	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
+	mptcp_lib_pm_nl_set_limits "${ns1}" 1 1
+	mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.2.1 dev ns1eth2 flags subflow
 
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
@@ -108,7 +108,7 @@ setup()
 	ip -net "$ns3" route add default via 10.0.3.2
 	ip -net "$ns3" route add default via dead:beef:3::2
 
-	ip netns exec "$ns3" ./pm_nl_ctl limits 1 1
+	mptcp_lib_pm_nl_set_limits "${ns3}" 1 1
 
 	# debug build can slow down measurably the test program
 	# we use quite tight time limit on the run-time, to ensure

-- 
2.43.0


