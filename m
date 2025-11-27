Return-Path: <linux-kselftest+bounces-46677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 533E0C90495
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 23:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 476A84E275A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9322F311954;
	Thu, 27 Nov 2025 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp5JguR/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C5311C3C;
	Thu, 27 Nov 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764282121; cv=none; b=fdF7THdAAd/MnrpGaeYazdgbokZyaj0cgYL0AaR+pIdrXrLv+lNmrZIKAnApcmByvguiD9X9WYzBjkWeMPBj84ii0Ms7qYBGcMTLIv48dD8rjoUtrl3AtLUlwyucaYbsfH6zoWjQTBTNTreyY2eehwkUs6ztW7o0NVl4K7qmtWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764282121; c=relaxed/simple;
	bh=BzEMECmzgVJDJoiQhj621xYOXsdnWnXY9xcYY4dEQQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o/ELXpIbL8izB2080KfhTlPfzNs2okFxROwUoiX2iM2Tl5knl0tRwkgvPcWLyqKPl0Qg1WY/Mc7S71tuJllyMu6ug3TZeaSdWjb23pxDxRydyaAxiSbQVCyayEwJpFbO07w5M5jc465szDRejufvjR/zwAFBzC/Lf1da7XGnrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp5JguR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C250C4CEF8;
	Thu, 27 Nov 2025 22:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764282119;
	bh=BzEMECmzgVJDJoiQhj621xYOXsdnWnXY9xcYY4dEQQM=;
	h=From:Date:Subject:To:Cc:From;
	b=Kp5JguR/NR/pJGcDLRqAzxS9wKFUSB7l8OLBFu8Co09P/ME/NF87lsdJO2M930tBq
	 vAxiM2j54D2egRUnqzDPR0bNtYSpqcYd6v1hbhRZF7ywzL9WkDbT2TV19tQ2MFqR/5
	 65Aoxn5bV3ehDVq9hdaw27JFNSgbtqwnk9okqVdH0GOW2AKHck1L7XqnRIm9yj7o15
	 RpmtGXLulPyfYHkNHbNlOcoGw+Kg6woOX1raDxCTmz9EMunv5M9gtvTm6rlMv+22xi
	 xUWEFWuMw1DtAq0WSbI27QBrvFGTU8sbO4sA8TeaMfWrT7bgBqMqffzUXqhFoyXDea
	 7QPLQukhgIFnw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 27 Nov 2025 23:21:43 +0100
Subject: [PATCH nf-next v2] selftests: netfilter: nft_flowtable.sh: Add the
 capability to send IPv6 TCP traffic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-nft_flowtable-sh-ipv6-tcp-v2-1-c4162e5ee014@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7RhasCIr72GIQTqFiaQlbVM1h
 LtbOYHL95L//gqBPFOAtljBU+LAzmaQhwKGqbcjIevMIEt5EkJKtCbezexesX/MhGFCXpLCOCx
 4VqbSshHqogXk/eLJ8Htv37rME4fo/Ge/SuJn/6kmgQLruil1NTSq6uX1Sd7SfHR+hG7bti8eR
 ugOwwAAAA==
X-Change-ID: 20251122-nft_flowtable-sh-ipv6-tcp-76f3d28169d1
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce the capability to send TCP traffic over IPv6 to
nft_flowtable netfilter selftest.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Fix checkpatch warnings
- Add TCP test for IPv6 IPsec traffic
- Link to v1: https://lore.kernel.org/r/20251122-nft_flowtable-sh-ipv6-tcp-v1-1-4480d3c863a2@kernel.org
---
 .../selftests/net/netfilter/nft_flowtable.sh       | 57 ++++++++++++++++------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 1fbfc8ad8dcdc5db2ab1a1ea9310f655d09eee83..a68bc882fa4ec0175d8db3df8337bb5fe6c42e26 100755
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
@@ -363,12 +368,14 @@ test_tcp_forwarding_ip()
 		infile="$nsin_small"
 	fi
 
-	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -4 TCP-LISTEN:12345,reuseaddr STDIO < "$infile" > "$ns2out" &
+	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -${proto} \
+            TCP"${proto}"-LISTEN:12345,reuseaddr STDIO < "$infile" > "$ns2out" &
 	lpid=$!
 
 	busywait 1000 listener_ready
 
-	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -4 TCP:"$dstip":"$dstport" STDIO < "$infile" > "$ns1out"
+	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -${proto} \
+            TCP"${proto}":"$dstip":"$dstport" STDIO < "$infile" > "$ns1out"
 	socatc=$?
 
 	wait $lpid
@@ -394,8 +401,11 @@ test_tcp_forwarding_ip()
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
@@ -403,6 +413,9 @@ test_tcp_forwarding()
 test_tcp_forwarding_set_dscp()
 {
 	local pmtu="$3"
+	local proto="$4"
+	local dstip="$5"
+	local dstport="$6"
 
 ip netns exec "$nsr1" nft -f - <<EOF
 table netdev dscpmangle {
@@ -413,7 +426,7 @@ table netdev dscpmangle {
 }
 EOF
 if [ $? -eq 0 ]; then
-	test_tcp_forwarding_ip "$1" "$2" "$3" 10.0.2.99 12345
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu" "$proto" "$dstip" "$dstport"
 	check_dscp "dscp_ingress" "$pmtu"
 
 	ip netns exec "$nsr1" nft delete table netdev dscpmangle
@@ -430,7 +443,7 @@ table netdev dscpmangle {
 }
 EOF
 if [ $? -eq 0 ]; then
-	test_tcp_forwarding_ip "$1" "$2" "$pmtu"  10.0.2.99 12345
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu" "$proto" "$dstip" "$dstport"
 	check_dscp "dscp_egress" "$pmtu"
 
 	ip netns exec "$nsr1" nft delete table netdev dscpmangle
@@ -441,7 +454,7 @@ fi
 	# partial.  If flowtable really works, then both dscp-is-0 and dscp-is-cs3
 	# counters should have seen packets (before and after ft offload kicks in).
 	ip netns exec "$nsr1" nft -a insert rule inet filter forward ip dscp set cs3
-	test_tcp_forwarding_ip "$1" "$2" "$pmtu"  10.0.2.99 12345
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu" "$proto" "$dstip" "$dstport"
 	check_dscp "dscp_fwd" "$pmtu"
 }
 
@@ -455,7 +468,7 @@ test_tcp_forwarding_nat()
 
 	[ "$pmtu" -eq 0 ] && what="$what (pmtu disabled)"
 
-	test_tcp_forwarding_ip "$nsa" "$nsb" "$pmtu" 10.0.2.99 12345
+	test_tcp_forwarding_ip "$nsa" "$nsb" "$pmtu" 4 10.0.2.99 12345
 	lret=$?
 
 	if [ "$lret" -eq 0 ] ; then
@@ -465,7 +478,7 @@ test_tcp_forwarding_nat()
 			echo "PASS: flow offload for ns1/ns2 with masquerade $what"
 		fi
 
-		test_tcp_forwarding_ip "$1" "$2" "$pmtu" 10.6.6.6 1666
+		test_tcp_forwarding_ip "$1" "$2" "$pmtu" 4 10.6.6.6 1666
 		lret=$?
 		if [ "$pmtu" -eq 1 ] ;then
 			check_counters "flow offload for ns1/ns2 with dnat $what"
@@ -487,7 +500,7 @@ make_file "$nsin_small" "$filesize_small"
 # Due to MTU mismatch in both directions, all packets (except small packets like pure
 # acks) have to be handled by normal forwarding path.  Therefore, packet counters
 # are not checked.
-if test_tcp_forwarding "$ns1" "$ns2" 0; then
+if test_tcp_forwarding "$ns1" "$ns2" 0 4 10.0.2.99 12345; then
 	echo "PASS: flow offloaded for ns1/ns2"
 else
 	echo "FAIL: flow offload for ns1/ns2:" 1>&2
@@ -495,6 +508,14 @@ else
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
@@ -520,7 +541,7 @@ table ip nat {
 EOF
 
 check_dscp "dscp_none" "0"
-if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 0 ""; then
+if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 0 4 10.0.2.99 12345; then
 	echo "FAIL: flow offload for ns1/ns2 with dscp update and no pmtu discovery" 1>&2
 	exit 0
 fi
@@ -546,7 +567,7 @@ ip netns exec "$ns2" sysctl net.ipv4.ip_no_pmtu_disc=0 > /dev/null
 ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
 ip netns exec "$ns2"  nft reset counters table inet filter >/dev/null
 
-if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 1 ""; then
+if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 1 4 10.0.2.99 12345; then
 	echo "FAIL: flow offload for ns1/ns2 with dscp update and pmtu discovery" 1>&2
 	exit 0
 fi
@@ -752,7 +773,7 @@ ip -net "$ns2" route del 192.168.10.1 via 10.0.2.1
 ip -net "$ns2" route add default via 10.0.2.1
 ip -net "$ns2" route add default via dead:2::1
 
-if test_tcp_forwarding "$ns1" "$ns2" 1; then
+if test_tcp_forwarding "$ns1" "$ns2" 1 4 10.0.2.99 12345; then
 	check_counters "ipsec tunnel mode for ns1/ns2"
 else
 	echo "FAIL: ipsec tunnel mode for ns1/ns2"
@@ -760,6 +781,14 @@ else
 	ip netns exec "$nsr1" cat /proc/net/xfrm_stat 1>&2
 fi
 
+if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
+	check_counters "IPv6 ipsec tunnel mode for ns1/ns2"
+else
+	echo "FAIL: IPv6 ipsec tunnel mode for ns1/ns2"
+	ip netns exec "$nsr1" nft list ruleset 1>&2
+	ip netns exec "$nsr1" cat /proc/net/xfrm_stat 1>&2
+fi
+
 if [ "$1" = "" ]; then
 	low=1280
 	mtu=$((65536 - low))

---
base-commit: b044de87bae07a50b2d99d9acfea5a4323da95ed
change-id: 20251122-nft_flowtable-sh-ipv6-tcp-76f3d28169d1

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


