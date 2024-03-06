Return-Path: <linux-kselftest+bounces-5982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9578732DA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24521C21291
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38055FBB8;
	Wed,  6 Mar 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az0ALyXl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA2E5FBAB;
	Wed,  6 Mar 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718198; cv=none; b=dgfBmifafS9kmFLh4BnnGfZ6r2vRwYBAyHMetpmMJ2eqPkB+vvZGloPB0ahwoVSahi0yoAJe9Ul6cu3mTR0CfnBTUrImOIHI1u28+hRhvJ+YOA6Z+KjJKaltbh5WQTJSwc9Ge0JdSq2FBBlXFbHdZE3u/ShJNpMw1Y4/gtgXv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718198; c=relaxed/simple;
	bh=h/VZLKhjhjaHcJbRLzKduep2+IDHaU3oweibSHMsMj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BE7pYlwTjotdHMPAvu0edLSkK08zQ551vTK+vtHlB9dSA03gPcP1Wk8ErKfIAOawZFrU2r/FOEl0ti5kidVpGF3lM4wzTfiJIMWT04tmer3Tqe3KlExj7wartZdCNGDbni1FJpXYYUFdUlwTw2eteE3JZcyQgwWDBsmkDoPGM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az0ALyXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16D2C43390;
	Wed,  6 Mar 2024 09:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718198;
	bh=h/VZLKhjhjaHcJbRLzKduep2+IDHaU3oweibSHMsMj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=az0ALyXlaQhZWo67iLo2zF5TVtQrT2DAPnSoHz3KWj4fXFHduJ84nvrVQqWEvIclK
	 YPMDCy3+ToL815ciiI8tcdb9uGplBgB9F+VcOItEoM0KdXcUPp8Nq4C/cDgWfZupl0
	 +Iwp8pWpx8NKSGrPps6pF7+R47s7jMTRMzMQRJfqFl3qE3wA9lsvCPBk6EBRt9UWzp
	 QG2PXbFl9vphiLvSy9QApfTo18ttdQX0zHszy9wDvKfvLAdk5F1s4CrvqfUW47QvnA
	 sQOtuVr1zaiZ91HII1icxVKPDkccPPqblFUDVmVizLcORWpg4ntJ7YOLiQJIrbGnXa
	 T7EQu/tRWQ0ew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Mar 2024 10:42:53 +0100
Subject: [PATCH net-next v2 04/12] selftests: mptcp: add
 mptcp_lib_ns_init/exit helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-4-bc79e6e5e6a0@kernel.org>
References: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
In-Reply-To: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9777; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5At38CF31nE2LwBoZR2dw2grFUK3bN1RjaV3Ay5an3M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6DqmfV+eb0emny+gjSK5yN67nNLfXmBVaka8z
 c+54ZPCC/2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pgAKCRD2t4JPQmmg
 c8UqD/99Y3TZOkI+tVuDIkFwcgsdJyL8QjH47RVnLP0BKmdmUE9D55yveRqZARLj8K2ULgd4p25
 fM1/5fGJKrAl0zOOH8JjWoeeD5+L7G2HBSZHbyJI4bTrbKJ7e6T6x6VNFIXqjcuCxjZSmJE0qL+
 wU8upSi0ZmDgUpTm2pvLioAa+wWee9qsFwDjrVFs4foTu6GTukPMu/WYXo9iaO13RZ6NW/bsgz2
 mJAB/daWVXKCyY4LqGT2dJoJh6Jlq9iazyRB6lAfds8eRUlSNOt5Bw6eUz+Np7clPZ8eAMJBKWs
 bZMa0zQTKzw84wSZVrix1n2HZ0+j9gMd0WYB6i8/QaVQ0uURQ/C9oxIxmeOQBbK8XeD0zl79RXf
 HEhSww6FL85v0LVX53IPUfjn7u2MU/C7hJvhkPXcmmX4uIftFHquuKyP07YWtoSSzC6d1czIluk
 6mJX2Bbjv894R5aruZZbzvx0E8Iv/PQ7sUMMinyCCugTX4dgXc84Ox8aggpI3ZrESuAjenejoxk
 y9xGEjxgma9nnlFWIoAs5kr7Oc4wqZkOFHD7fLg8L3ZOGVSbaGdv7Uy/f6ttUO8fBWIoLhM3G/m
 VZeEM+0JqV3GQ+dThGra/sD2GDvPZafr7S2+gSqZJ3lADjr1oe7MzmdlY6kUUcgrjyafDIr/zCr
 SI1XtFseKfDwIXQ==
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
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 21 ++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 17 ++++++----------
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  9 +++------
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 16 +++++----------
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 14 ++++---------
 8 files changed, 53 insertions(+), 67 deletions(-)

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
index b1fe354cfe96..17d609368603 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -373,3 +373,24 @@ mptcp_lib_check_tools() {
 		esac
 	done
 }
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


