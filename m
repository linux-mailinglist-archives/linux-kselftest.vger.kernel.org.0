Return-Path: <linux-kselftest+bounces-5910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30152871C1E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45171F252EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B18F5D73E;
	Tue,  5 Mar 2024 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbAg9mAq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F55D47B;
	Tue,  5 Mar 2024 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635381; cv=none; b=qcT7QTOTk1TkPa8chXyV1wT7nKghtET8/CXiPqlMXK66Xi4jia8a6MIZ+rB+e0HdM76SZTqdL9y0/KegkiOgh8zOyaGibHaqRI+R+D6Cj1JRCwge67MCeS+txJM/eHh1f/qk0Au0C9/9bT1U6JvtkPVhLo3YnZ43N9CRRCT7phU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635381; c=relaxed/simple;
	bh=wW8p8oB3gTE6slrGFZ/w3mTgo4yTKJtX7Hrikeg1Iwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXRKDyrR4Kh4HDbPqD08y0TsQP/PtKhOncpHqPX3OnTHyn7zFm+qqyDhQXkcHHtDRfSjvBkmoDWkKZJ5sqOxmFRO5AxP2ZH391wT5+0BtFaIAYs3gHbZNJHWcda2fbtOCGSZhtGoHHtlSVcoqyAM8XeTWsDWSaVS5KAzLCLW76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbAg9mAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29EBC43394;
	Tue,  5 Mar 2024 10:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635380;
	bh=wW8p8oB3gTE6slrGFZ/w3mTgo4yTKJtX7Hrikeg1Iwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RbAg9mAqO6vdWIFSOloHNZJXgsqqtas5ZcWtp/VtfrcbTCEE/+S4yMP9IzqjiwRSj
	 QLrIVuq0NnEljP6UOHG9p2c/uMk8wfTIni0WLUCTFTvxQJ8a4axQVYekR93W4XzkuA
	 d5jSP+mpwUsPzyCrm54zFXiVeg2gtdaWfgnU0laVgyLBg3N91k5vdbt7le1oOwwuCX
	 7EV6KZyn+PKJ92mmCclNCTOHdxUN+chmGqsjFTXIFz8P+JYjyhgY60Z1RNeaZRqW9U
	 Vzb22/iZdTiaNrZBOCQrbRh6RTvHaJxQqUC4rM6UXwPw3g+r7+DFfElqcyRevoObXe
	 2Nu3bNmapSZTQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:35 +0100
Subject: [PATCH net-next 05/13] selftests: mptcp: add
 mptcp_lib_ns_init/exit helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-5-66618ea5504e@kernel.org>
References: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9784; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Bg5ox4Jc4FZkVFd+s/ohOUxx5S47ZL35oo6wIvq4SDg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vccIC1hR8S52sHLC5oC3U00ggBDNvoYX6CMv
 aqp8QEJaYqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HAAKCRD2t4JPQmmg
 c5jlD/9gTPkcwQOdks2C2b9alx2sVJge+ZJqauy8y/obPDj05Py8iQG3cXDuY62NxPPYdvrWg0k
 FqDUU8Rf6yusVXRYYmuOltikphW0m/zxxtptG2auHd3kSNTR4tAGriBxuugh16b/vYcVngX6Vy8
 5tt0+9fDdrxg42vTgCi6VkgF6Vu041GqBNY5+m6B3/JcReGOcTvs2P8YA5qRUh+BW81dXjOlNO5
 ijaQAgLw9hFumrYemfiNN9vE7q8eW43WzrLaCvqMr/Ge33X6RSKyVyH/FqoSeWubvszAgq9OZGY
 yMcMD0M28Qj0KHdy3T0szweZAQU+/DcKbz4pw3KFITt7XZT1HnK7pkldBlZzmqWN8a2Y5G7MtGd
 pHKJrf+JG3lysZ3P0crPFyEJXuLCh8fpn+EeVxl9FQmzOaOHJk5dq3j6jzi7bWeiehdalBbyQKQ
 yiabvFU0qTji350pJgBLF49xRkOfcLJiGghfRWlDnnFBWedMXgUe5UGQwhEkXlaQ3sUCq/xAtlA
 Y5hI04NB3yU4I/rlyXVlzDZEJLVE/ckrCeGaQwv1zO1zgbMswyXR3gKZvc7hxc2ME26We9D9AdU
 Euf3Irp9LoYxE4CtlOVxZ3LJUVN6QQrXb3LLMPcD35jGG+MoX1Un3NWk8nO/7IG8tcpNHzORbqW
 E7tjgae4xG4dkXA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Add helpers mptcp_lib_ns_init() and mptcp_lib_ns_exit() in mptcp_lib.sh
to initialize and delete the given namespaces. Then every test script
can invoke these helpers and use all namespaces.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh          |  9 +++------
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 23 +++++++++-------------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 11 ++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 22 +++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 17 ++++++----------
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  9 +++------
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 16 +++++----------
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 14 ++++---------
 8 files changed, 54 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index e42603be03f3..0ee93915bccb 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -3,9 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns="ns1-$rndh"
+ns=""
 ksft_skip=4
 test_cnt=1
 timeout_poll=30
@@ -30,7 +28,7 @@ cleanup()
 {
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
-	ip netns del $ns
+	mptcp_lib_ns_exit "${ns}"
 }
 
 mptcp_lib_check_mptcp
@@ -214,8 +212,7 @@ wait_connected()
 }
 
 trap cleanup EXIT
-ip netns add $ns
-ip -n $ns link set dev lo up
+mptcp_lib_ns_init ns
 
 echo "a" | \
 	timeout ${timeout_test} \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b609649311f6..92f6260ba9f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -121,12 +121,10 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
-ns4="ns4-$rndh"
+ns1=""
+ns2=""
+ns3=""
+ns4=""
 
 TEST_COUNT=0
 TEST_GROUP=""
@@ -140,9 +138,9 @@ cleanup()
 
 	local netns
 	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
-		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
 	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}" "${ns4}"
 }
 
 mptcp_lib_check_mptcp
@@ -158,10 +156,7 @@ cin_disconnect="$cin".disconnect
 cout_disconnect="$cout".disconnect
 trap cleanup EXIT
 
-for i in "$ns1" "$ns2" "$ns3" "$ns4";do
-	ip netns add $i || exit $ksft_skip
-	ip -net $i link set lo up
-done
+mptcp_lib_ns_init ns1 ns2 ns3 ns4
 
 #  "$ns1"              ns2                    ns3                     ns4
 # ns1eth2    ns2eth1   ns2eth3      ns3eth2   ns3eth4       ns4eth3
@@ -251,8 +246,8 @@ fi
 
 check_mptcp_disabled()
 {
-	local disabled_ns="ns_disabled-$rndh"
-	ip netns add ${disabled_ns} || exit $ksft_skip
+	local disabled_ns
+	mptcp_lib_ns_init disabled_ns
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
@@ -266,7 +261,7 @@ check_mptcp_disabled()
 	local err=0
 	LC_ALL=C ip netns exec ${disabled_ns} ./mptcp_connect -p 10000 -s MPTCP 127.0.0.1 < "$cin" 2>&1 | \
 		grep -q "^socket: Protocol not available$" && err=1
-	ip netns delete ${disabled_ns}
+	mptcp_lib_ns_exit "${disabled_ns}"
 
 	if [ ${err} -eq 0 ]; then
 		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[ FAIL ]"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index aedc5698f26a..612470244c58 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -86,17 +86,10 @@ init_partial()
 {
 	capout=$(mktemp)
 
-	local sec rndh
-	sec=$(date +%s)
-	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-
-	ns1="ns1-$rndh"
-	ns2="ns2-$rndh"
+	mptcp_lib_ns_init ns1 ns2
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
-		ip netns add $netns || exit $ksft_skip
-		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
@@ -147,9 +140,9 @@ cleanup_partial()
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
-		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
 	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}"
 }
 
 init() {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ed86bb0bab49..2fcf31277e28 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -396,3 +396,25 @@ mptcp_lib_check_output() {
 		return 1
 	fi
 }
+
+mptcp_lib_ns_init() {
+	local sec rndh
+
+	sec=$(date +%s)
+	rndh=$(printf %x "${sec}")-$(mktemp -u XXXXXX)
+
+	local netns
+	for netns in "${@}"; do
+		eval "${netns}=${netns}-${rndh}"
+
+		ip netns add "${!netns}" || exit ${KSFT_SKIP}
+		ip -net "${!netns}" link set lo up
+	done
+}
+
+mptcp_lib_ns_exit() {
+	local netns
+	for netns in "${@}"; do
+		ip netns del "${netns}"
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index fd7de1b3dc55..5fa5fa8cab71 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -14,11 +14,9 @@ timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
 ip6tables="ip6tables"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns_sbox="ns_sbox-$rndh"
+ns1=""
+ns2=""
+ns_sbox=""
 
 add_mark_rules()
 {
@@ -40,10 +38,10 @@ add_mark_rules()
 
 init()
 {
+	mptcp_lib_ns_init ns1 ns2 ns_sbox
+
 	local netns
 	for netns in "$ns1" "$ns2" "$ns_sbox";do
-		ip netns add $netns || exit $ksft_skip
-		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
@@ -79,10 +77,7 @@ init()
 
 cleanup()
 {
-	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox"; do
-		ip netns del $netns
-	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns_sbox}"
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
 }
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 1ec9d8622fc9..30ec0ec3d68f 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -24,15 +24,13 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+ns1=""
 err=$(mktemp)
 
 cleanup()
 {
 	rm -f $err
-	ip netns del $ns1
+	mptcp_lib_ns_exit "${ns1}"
 }
 
 mptcp_lib_check_mptcp
@@ -40,8 +38,7 @@ mptcp_lib_check_tools ip
 
 trap cleanup EXIT
 
-ip netns add $ns1 || exit $ksft_skip
-ip -net $ns1 link set lo up
+mptcp_lib_ns_init ns1
 ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 3d08116500a4..2aeebb80da07 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -3,11 +3,9 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+ns1=""
+ns2=""
+ns3=""
 capture=false
 ksft_skip=4
 timeout_poll=30
@@ -36,10 +34,7 @@ cleanup()
 	rm -f "$large" "$small"
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3";do
-		ip netns del $netns
-	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}"
 }
 
 mptcp_lib_check_mptcp
@@ -65,9 +60,8 @@ setup()
 
 	trap cleanup EXIT
 
+	mptcp_lib_ns_init ns1 ns2 ns3
 	for i in "$ns1" "$ns2" "$ns3";do
-		ip netns add $i || exit $ksft_skip
-		ip -net $i link set lo up
 		ip netns exec $i sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $i sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 629fc5d0ecc5..e3092696d2de 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -50,10 +50,8 @@ app6_port=50004
 client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
-sec=$(date +%s)
-rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
+ns1=""
+ns2=""
 ret=0
 test_name=""
 
@@ -118,10 +116,7 @@ cleanup()
 		mptcp_lib_kill_wait $pid
 	done
 
-	local netns
-	for netns in "$ns1" "$ns2" ;do
-		ip netns del "$netns"
-	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}"
 
 	rm -rf $file $client_evts $server_evts
 
@@ -131,9 +126,8 @@ cleanup()
 trap cleanup EXIT
 
 # Create and configure network namespaces for testing
+mptcp_lib_ns_init ns1 ns2
 for i in "$ns1" "$ns2" ;do
-	ip netns add "$i" || exit 1
-	ip -net "$i" link set lo up
 	ip netns exec "$i" sysctl -q net.mptcp.enabled=1
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done

-- 
2.43.0


