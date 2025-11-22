Return-Path: <linux-kselftest+bounces-46334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ACAC7D5B6
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 19:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E330534D49D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97F29AB11;
	Sat, 22 Nov 2025 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrSXPSKI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81083232785;
	Sat, 22 Nov 2025 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763836921; cv=none; b=RlRh+bjYL892/OiL3S8D44/W9tvKDS4iGPNXyMKm57m0SSLykv8bTN44JgHNQoieWdy6ibScOV5ksP+z7tjr7kKMtDUlVNh7d3SLQKJ8JN2Jjg1tEjM0U1hw2pbeprigFiUAU9QYvx3YB1hftWUdYTUFFuvoLVWkq3SS6YVszII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763836921; c=relaxed/simple;
	bh=uIGm2rcRruEdAQS5y9Pw6NgxHjIpCwoIYGfrsyQu340=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NozHUyV8x+qCyXQb+aLNNHt9QPOmDVq6TNINff8hGZUut7VQSYQOtndNywAEKXD/dOxFLqFEFqjVjT8CiJZkQPhZq1+2guQnYzzwdHFy5rwklS7zw02Qq8YT8uzssXF8zvEsvmixbZJ4jwkcBJRsOe4g6pYI5OFh/BCuu24/138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrSXPSKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474D8C4CEF5;
	Sat, 22 Nov 2025 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763836920;
	bh=uIGm2rcRruEdAQS5y9Pw6NgxHjIpCwoIYGfrsyQu340=;
	h=From:Date:Subject:To:Cc:From;
	b=VrSXPSKIooxereZMLICrvLQw82QwB01hOREtOTs31jBIo7WjqMwwgdsKmLppo++Lc
	 SaIIjkxB6me45cZcFQYqdQSEL5ipgDfWk57DX8ALzUByKv8UFLyPTKDPCtXSc2UmJS
	 pOd5aD2+QicKtcFdQXP59b7QYtIib0xIea0xstvx/48psQlBlOBwNh7E5MYe7+bVLl
	 iwWScGKWj5Oh2vD0w/ecRbcYocgHuWx2P4qo7Pc+WXr1zCl6JrsX5iwDj/yhdcj1Xs
	 Aul2ryOn9wmF51Ru5pZtNwOBLB+3wGKRr0zUFzZleJ1iT1GrEaURd2C06jVwUnEogN
	 7FL3wyZ+HCNsw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 22 Nov 2025 19:41:38 +0100
Subject: [PATCH nf-next] selftests: netfilter: nft_flowtable.sh: Add the
 capability to send IPv6 TCP traffic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251122-nft_flowtable-sh-ipv6-tcp-v1-1-4480d3c863a2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrDvgTGm0vUoRUTPRAYkhCVoQ7
 27o8i3+PyFJVEnwqU6IsmvSzRfQo4JpGfwsqLYYuOYXETN6l3u3bkcexlUwLahhN5ingI1xT8s
 tmbclKH2I4vT3f3+767oBgqd8gmsAAAA=
X-Change-ID: 20251122-nft_flowtable-sh-ipv6-tcp-76f3d28169d1
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce the capability to send TCP traffic over IPv6 to
nft_flowtable netfilter selftest.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../selftests/net/netfilter/nft_flowtable.sh       | 47 +++++++++++++++-------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 1fbfc8ad8dcdc5db2ab1a1ea9310f655d09eee83..24b4e60b91451e7ea7f6a041b0335233047c6242 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -127,6 +127,8 @@ ip -net "$nsr1" addr add fee1:2::1/64 dev veth1 nodad
 ip -net "$nsr2" addr add 192.168.10.2/24 dev veth0
 ip -net "$nsr2" addr add fee1:2::2/64 dev veth0 nodad
 
+ip netns exec "$nsr1" sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
+ip netns exec "$nsr2" sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
 for i in 0 1; do
   ip netns exec "$nsr1" sysctl net.ipv4.conf.veth$i.forwarding=1 > /dev/null
   ip netns exec "$nsr2" sysctl net.ipv4.conf.veth$i.forwarding=1 > /dev/null
@@ -153,7 +155,9 @@ ip -net "$ns1" route add default via dead:1::1
 ip -net "$ns2" route add default via dead:2::1
 
 ip -net "$nsr1" route add default via 192.168.10.2
+ip -6 -net "$nsr1" route add default via fee1:2::2
 ip -net "$nsr2" route add default via 192.168.10.1
+ip -6 -net "$nsr2" route add default via fee1:2::1
 
 ip netns exec "$nsr1" nft -f - <<EOF
 table inet filter {
@@ -352,8 +356,9 @@ test_tcp_forwarding_ip()
 	local nsa=$1
 	local nsb=$2
 	local pmtu=$3
-	local dstip=$4
-	local dstport=$5
+	local proto=$4
+	local dstip=$5
+	local dstport=$6
 	local lret=0
 	local socatc
 	local socatl
@@ -363,12 +368,12 @@ test_tcp_forwarding_ip()
 		infile="$nsin_small"
 	fi
 
-	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -4 TCP-LISTEN:12345,reuseaddr STDIO < "$infile" > "$ns2out" &
+	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -${proto} TCP${proto}-LISTEN:12345,reuseaddr STDIO < "$infile" > "$ns2out" &
 	lpid=$!
 
 	busywait 1000 listener_ready
 
-	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -4 TCP:"$dstip":"$dstport" STDIO < "$infile" > "$ns1out"
+	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -${proto} TCP${proto}:"$dstip":"$dstport" STDIO < "$infile" > "$ns1out"
 	socatc=$?
 
 	wait $lpid
@@ -394,8 +399,11 @@ test_tcp_forwarding_ip()
 test_tcp_forwarding()
 {
 	local pmtu="$3"
+	local proto="$4"
+	local dstip="$5"
+	local dstport="$6"
 
-	test_tcp_forwarding_ip "$1" "$2" "$pmtu" 10.0.2.99 12345
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu" "$proto" "$dstip" "$dstport"
 
 	return $?
 }
@@ -403,6 +411,9 @@ test_tcp_forwarding()
 test_tcp_forwarding_set_dscp()
 {
 	local pmtu="$3"
+	local proto="$4"
+	local dstip="$5"
+	local dstport="$6"
 
 ip netns exec "$nsr1" nft -f - <<EOF
 table netdev dscpmangle {
@@ -413,7 +424,7 @@ table netdev dscpmangle {
 }
 EOF
 if [ $? -eq 0 ]; then
-	test_tcp_forwarding_ip "$1" "$2" "$3" 10.0.2.99 12345
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu" "$proto" "$dstip" "$dstport"
 	check_dscp "dscp_ingress" "$pmtu"
 
 	ip netns exec "$nsr1" nft delete table netdev dscpmangle
@@ -430,7 +441,7 @@ table netdev dscpmangle {
 }
 EOF
 if [ $? -eq 0 ]; then
-	test_tcp_forwarding_ip "$1" "$2" "$pmtu"  10.0.2.99 12345
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu" "$proto" "$dstip" "$dstport"
 	check_dscp "dscp_egress" "$pmtu"
 
 	ip netns exec "$nsr1" nft delete table netdev dscpmangle
@@ -441,7 +452,7 @@ fi
 	# partial.  If flowtable really works, then both dscp-is-0 and dscp-is-cs3
 	# counters should have seen packets (before and after ft offload kicks in).
 	ip netns exec "$nsr1" nft -a insert rule inet filter forward ip dscp set cs3
-	test_tcp_forwarding_ip "$1" "$2" "$pmtu"  10.0.2.99 12345
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu" "$proto" "$dstip" "$dstport"
 	check_dscp "dscp_fwd" "$pmtu"
 }
 
@@ -455,7 +466,7 @@ test_tcp_forwarding_nat()
 
 	[ "$pmtu" -eq 0 ] && what="$what (pmtu disabled)"
 
-	test_tcp_forwarding_ip "$nsa" "$nsb" "$pmtu" 10.0.2.99 12345
+	test_tcp_forwarding_ip "$nsa" "$nsb" "$pmtu" 4 10.0.2.99 12345
 	lret=$?
 
 	if [ "$lret" -eq 0 ] ; then
@@ -465,7 +476,7 @@ test_tcp_forwarding_nat()
 			echo "PASS: flow offload for ns1/ns2 with masquerade $what"
 		fi
 
-		test_tcp_forwarding_ip "$1" "$2" "$pmtu" 10.6.6.6 1666
+		test_tcp_forwarding_ip "$1" "$2" "$pmtu" 4 10.6.6.6 1666
 		lret=$?
 		if [ "$pmtu" -eq 1 ] ;then
 			check_counters "flow offload for ns1/ns2 with dnat $what"
@@ -487,7 +498,7 @@ make_file "$nsin_small" "$filesize_small"
 # Due to MTU mismatch in both directions, all packets (except small packets like pure
 # acks) have to be handled by normal forwarding path.  Therefore, packet counters
 # are not checked.
-if test_tcp_forwarding "$ns1" "$ns2" 0; then
+if test_tcp_forwarding "$ns1" "$ns2" 0 4 10.0.2.99 12345; then
 	echo "PASS: flow offloaded for ns1/ns2"
 else
 	echo "FAIL: flow offload for ns1/ns2:" 1>&2
@@ -495,6 +506,14 @@ else
 	ret=1
 fi
 
+if test_tcp_forwarding "$ns1" "$ns2" 0 6 "[dead:2::99]" 12345; then
+	echo "PASS: IPv6 flow offloaded for ns1/ns2"
+else
+	echo "FAIL: IPv6 flow offload for ns1/ns2:" 1>&2
+	ip netns exec "$nsr1" nft list ruleset
+	ret=1
+fi
+
 # delete default route, i.e. ns2 won't be able to reach ns1 and
 # will depend on ns1 being masqueraded in nsr1.
 # expect ns1 has nsr1 address.
@@ -520,7 +539,7 @@ table ip nat {
 EOF
 
 check_dscp "dscp_none" "0"
-if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 0 ""; then
+if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 0 4 10.0.2.99 12345; then
 	echo "FAIL: flow offload for ns1/ns2 with dscp update and no pmtu discovery" 1>&2
 	exit 0
 fi
@@ -546,7 +565,7 @@ ip netns exec "$ns2" sysctl net.ipv4.ip_no_pmtu_disc=0 > /dev/null
 ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
 ip netns exec "$ns2"  nft reset counters table inet filter >/dev/null
 
-if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 1 ""; then
+if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 1 4 10.0.2.99 12345; then
 	echo "FAIL: flow offload for ns1/ns2 with dscp update and pmtu discovery" 1>&2
 	exit 0
 fi
@@ -752,7 +771,7 @@ ip -net "$ns2" route del 192.168.10.1 via 10.0.2.1
 ip -net "$ns2" route add default via 10.0.2.1
 ip -net "$ns2" route add default via dead:2::1
 
-if test_tcp_forwarding "$ns1" "$ns2" 1; then
+if test_tcp_forwarding "$ns1" "$ns2" 1 4 10.0.2.99 12345; then
 	check_counters "ipsec tunnel mode for ns1/ns2"
 else
 	echo "FAIL: ipsec tunnel mode for ns1/ns2"

---
base-commit: aa7ece8adbea8cca27594a0f80c68f6cb708326d
change-id: 20251122-nft_flowtable-sh-ipv6-tcp-76f3d28169d1

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


