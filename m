Return-Path: <linux-kselftest+bounces-11973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A9B909158
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05155B28D53
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC0619CD07;
	Fri, 14 Jun 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNtvNz/F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517816D4EB;
	Fri, 14 Jun 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385353; cv=none; b=HHvFv/CKCYbSWrNLoqXcesHaobZb5fQltrmEZpPLm+nf1qa3T4Z6+xRZpkeegTej/KxZlZh4oA0BADzaVAyQvzDQetBuV7w2egIg/bvxvv2i6DXZT/UF7aCe7h29ZgEyWeqNG55vPpzS8Biu77UVikKuTFwfY9kJJxWLRHpB6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385353; c=relaxed/simple;
	bh=YZhKL9A/66/JtXeNBaJHZPe3vflt/TP5n7Ycw1491iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V6B/lG8SXMMtIRCDIEVFq8sPXQRsNyNGlXm4p0mgcsAVDpmeDkhl0eFhHI16IdUCsQS50OYwBF9BznpnncXL+14mjr2p7jSuW8mhejrI1Cj9K3D3lNiUs588c/zDN+jW//LObqEhQgAPKnjUAsW16rH6ssL0JxTsmNIQyJEv820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNtvNz/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC0FC2BD10;
	Fri, 14 Jun 2024 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718385353;
	bh=YZhKL9A/66/JtXeNBaJHZPe3vflt/TP5n7Ycw1491iQ=;
	h=From:Date:Subject:To:Cc:From;
	b=DNtvNz/Fsr5M7bREgRQH9qR24NkZ29Qno1ESJjO037HIDQQNfH/1UBQAsWlZdwtty
	 f+DFyg6fPNUPzOda5XuDhz8wCh8dYgqPbe/YQ066xq+f3AuXWp5UenvrLJFWV5h1AZ
	 jzbdIq/SeUc0fj0lNuUc6kEU4e1VEdnZOqhjjXPuVR2Ky5W3uE8VBDWneZ3e8QbT0M
	 C2L3/WzD5e45TOGI8vyuf08VJsIDibMh6Mo+jeh/+gt9H8PEyfiJ1q429HTYgf0OaH
	 GjuX2Z3HjGRK9QekfVSp94R4Zds1FQa82mXaY09FvYw/DrMyrirv09qWG9PRpAIB97
	 yRPBTAqfkFWug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Jun 2024 19:15:29 +0200
Subject: [PATCH net] selftests: mptcp: userspace_pm: fixed subtest names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-upstream-net-20240614-selftests-mptcp-uspace-pm-fixed-test-names-v1-1-460ad3edb429@kernel.org>
X-B4-Tracking: v=1; b=H4sIALB6bGYC/z2OQQrDIBRErxL+uh/UhFB6ldKF1bEVqhW/KYWQu
 1c3Xb6ZYWZ2EtQIocu0U8UnSnznDvo0kXva/ABH35mMMota9cJbkVZhE2c0/quCV2iQJpxKc4U
 3KdaBS+IQv/A8PM42QXhez5i1scGrO/WZUjEy48KVeindjuMH6kJVSJcAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9913; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YZhKL9A/66/JtXeNBaJHZPe3vflt/TP5n7Ycw1491iQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmbHrG24X5OpyXeAeAsxuyddqhL81YkDuBRmseX
 RS5SalZy92JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmx6xgAKCRD2t4JPQmmg
 czUMEADQBfsk102Kt+GlOHG+mbGMNr5bv8dSCR03oVvrlfHqnjsOhO9IL6+fQ8lbdz3ylCGfPKK
 /qPlj/ino1O6GENZ1FYWSD1QdCEWvjkSgyZmvIa4hJ2KvuQ+G9bag82rHiVFl3G2QzpCSgok6qK
 Dm5aayH6kAUosACXCHTWxJodtFZ8opcH/O0+JPS8wpGa6fM12NNgFZBPwYoOabwfHZDRZQb9riK
 FwV0CHVDKdTFnGcNXqUmc85fuG0l2P00y18lozFYxvIYwh2kX8B0dNAg/S97vh6SF1TOP5Uaj7B
 PnR/+iVA/iHnFEE+tLTKNszUo+6PGv90oeIAfhmH4XUyQYujLR035mJEipo4ykCnBF+aCsqeHFe
 2dAv6EDsf+jekzkzPHyNnKaSLOKvXXuoyEX9KSrEUc8POhPnjTa8aL57zqSwgZRUFKDjVKIDVPZ
 TSyVjPagUbL6qxkDR8sJqURRJlzirreAWkMFIdNl8seU3vraBkSZU9yp11Uw2vlOv2jgRl8msTz
 RvLyedbLfSuC47FpsZkqV3rPxjGOPTG5Dj4UciSi7Xl84KKmm8IkK+gEPwtzW3sdZ9xPc5fbZVC
 ym0MGODHtmcnYmbG1o7H0vbd1+EheYXyjgc3Fvfplfz/t1L235II4RY3gIg7nEk2Nm3GPAqKV/g
 t3OEY1FtJ6SE5tQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is important to have fixed (sub)test names in TAP, because these
names are used to identify them. If they are not fixed, tracking cannot
be done.

Some subtests from the userspace_pm selftest were using random numbers
in their names: the client and server address IDs from $RANDOM, and the
client port number randomly picked by the kernel when creating the
connection. These values have been replaced by 'client' and 'server'
words: that's even more helpful than showing random numbers. Note that
the addresses IDs are incremented and decremented in the test: +1 or -1
are then displayed in these cases.

Not to loose info that can be useful for debugging in case of issues,
these random numbers are now displayed at the beginning of the test.

Fixes: f589234e1af0 ("selftests: mptcp: userspace_pm: format subtests results in TAP")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 46 ++++++++++++++---------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 9e2981f2d7f5..9cb05978269d 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -160,10 +160,12 @@ make_connection()
 	local is_v6=$1
 	local app_port=$app4_port
 	local connect_addr="10.0.1.1"
+	local client_addr="10.0.1.2"
 	local listen_addr="0.0.0.0"
 	if [ "$is_v6" = "v6" ]
 	then
 		connect_addr="dead:beef:1::1"
+		client_addr="dead:beef:1::2"
 		listen_addr="::"
 		app_port=$app6_port
 	else
@@ -206,6 +208,7 @@ make_connection()
 		   [ "$server_serverside" = 1 ]
 	then
 		test_pass
+		print_title "Connection info: ${client_addr}:${client_port} -> ${connect_addr}:${app_port}"
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
 		mptcp_lib_result_print_all_tap
@@ -297,7 +300,7 @@ test_announce()
 	ip netns exec "$ns2"\
 	   ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id $client_addr_id dev\
 	   ns2eth1
-	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, reuse port"
+	print_test "ADD_ADDR id:client 10.0.2.2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event $server_evts $ANNOUNCED $server4_token "10.0.2.2" $client_addr_id \
 			      "$client4_port"
@@ -306,7 +309,7 @@ test_announce()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann\
 	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1
-	print_test "ADD_ADDR6 id:${client_addr_id} dead:beef:2::2 (ns2) => ns1, reuse port"
+	print_test "ADD_ADDR6 id:client dead:beef:2::2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
 			      "$client_addr_id" "$client6_port" "v6"
@@ -316,7 +319,7 @@ test_announce()
 	client_addr_id=$((client_addr_id+1))
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
 	   $client_addr_id dev ns2eth1 port $new4_port
-	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, new port"
+	print_test "ADD_ADDR id:client+1 10.0.2.2 (ns2) => ns1, new port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
 			      "$client_addr_id" "$new4_port"
@@ -327,7 +330,7 @@ test_announce()
 	# ADD_ADDR from the server to client machine reusing the subflow port
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR id:server 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$app4_port"
@@ -336,7 +339,7 @@ test_announce()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR6 id:${server_addr_id} dead:beef:2::1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR6 id:server dead:beef:2::1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
 			      "$server_addr_id" "$app6_port" "v6"
@@ -346,7 +349,7 @@ test_announce()
 	server_addr_id=$((server_addr_id+1))
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2 port $new4_port
-	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, new port"
+	print_test "ADD_ADDR id:server+1 10.0.2.1 (ns1) => ns2, new port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$new4_port"
@@ -380,7 +383,7 @@ test_remove()
 	local invalid_token=$(( client4_token - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token $invalid_token id\
 	   $client_addr_id > /dev/null 2>&1
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1, invalid token"
+	print_test "RM_ADDR id:client ns2 => ns1, invalid token"
 	local type
 	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
@@ -394,7 +397,7 @@ test_remove()
 	local invalid_id=$(( client_addr_id + 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $invalid_id > /dev/null 2>&1
-	print_test "RM_ADDR id:${invalid_id} ns2 => ns1, invalid id"
+	print_test "RM_ADDR id:client+1 ns2 => ns1, invalid id"
 	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
@@ -407,7 +410,7 @@ test_remove()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR id:client ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -416,7 +419,7 @@ test_remove()
 	client_addr_id=$(( client_addr_id - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR id:client-1 ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -424,7 +427,7 @@ test_remove()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client6_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR6 id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR6 id:client-1 ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
 
@@ -434,7 +437,7 @@ test_remove()
 	# RM_ADDR from the server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR id:server ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -443,7 +446,7 @@ test_remove()
 	server_addr_id=$(( server_addr_id - 1 ))
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR id:server-1 ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -451,7 +454,7 @@ test_remove()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server6_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR6 id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR6 id:server-1 ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
 }
@@ -479,8 +482,14 @@ verify_subflow_events()
 	local locid
 	local remid
 	local info
+	local e_dport_txt
 
-	info="${e_saddr} (${e_from}) => ${e_daddr}:${e_dport} (${e_to})"
+	# only display the fixed ports
+	if [ "${e_dport}" -ge "${app4_port}" ] && [ "${e_dport}" -le "${app6_port}" ]; then
+		e_dport_txt=":${e_dport}"
+	fi
+
+	info="${e_saddr} (${e_from}) => ${e_daddr}${e_dport_txt} (${e_to})"
 
 	if [ "$e_type" = "$SUB_ESTABLISHED" ]
 	then
@@ -766,7 +775,7 @@ test_subflows_v4_v6_mix()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR4 id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR4 id:server 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "10.0.2.1"\
 			      "$server_addr_id" "$app6_port"
@@ -861,7 +870,7 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	print_test "CREATE_LISTENER 10.0.2.2:$client4_port"
+	print_test "CREATE_LISTENER 10.0.2.2 (client port)"
 	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
@@ -878,13 +887,14 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
-	print_test "CLOSE_LISTENER 10.0.2.2:$client4_port"
+	print_test "CLOSE_LISTENER 10.0.2.2 (client port)"
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 }
 
 print_title "Make connections"
 make_connection
 make_connection "v6"
+print_title "Will be using address IDs ${client_addr_id} (client) and ${server_addr_id} (server)"
 
 test_announce
 test_remove

---
base-commit: 89aa3619d141d6cfb6040a561aebb6d99d3e2285
change-id: 20240614-upstream-net-20240614-selftests-mptcp-uspace-pm-fixed-test-names-368e312afd0b

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


