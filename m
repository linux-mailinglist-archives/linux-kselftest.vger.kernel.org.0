Return-Path: <linux-kselftest+bounces-1239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350FA8067FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4FB1F217AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557715AD1;
	Wed,  6 Dec 2023 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdf+3Y1t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487701B5;
	Tue,  5 Dec 2023 23:08:41 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d9a6f756c3so1828046a34.2;
        Tue, 05 Dec 2023 23:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701846520; x=1702451320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIy8joQtaJBTGgeail0m+VYbHDRfTlxu7U27cKL7Iqs=;
        b=Pdf+3Y1ti43MWPd++3qMaqok6qnRE1qY2svwRxyN2qHiDfCIi2st6Et6jvS03pMFAa
         TpcJPMXpbe+yyB3IjtY0ri1CBGs2ev0Uai0nnsl1KmIxsxFgt0M8z3cBpHww+2YqHprv
         wMeimFy12FE8I+Vj8qyxfaUlo8P+ddWzqHrl4CreNoOJo0+HUzX+nLKZ7bIbNNvD3IAW
         J+fC+Xy/VwOf75fdcq3Qv5Sma+A+5Bb3KQ3DDNcBiNMo6x4r2e5z974CfSJUXUxX3jQy
         mxSJgoz5cr8SkABzHEyU/PxH6RyIH5vQlaxOSNY1ENWBZnPxjgArO9DyW4OYQzuJhI1A
         kvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846520; x=1702451320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIy8joQtaJBTGgeail0m+VYbHDRfTlxu7U27cKL7Iqs=;
        b=CLyLPSgjfCHSFALUW7jrfKVQViZmGmE9fKJZ9OW2sBTRFfcabQMWN2u5p7H81pLmL9
         AOj5Kf5WKxjTpkGeFC44RF8515zjNlkGrEFZPR2kD39SMbO9WNrq4AWGWDgIirxXq4D5
         bX58fLlvdWn9WDwkme2UgUNziUjvxdhB8ws48v4cCRkHO2VFT+6j4Go/WfsdJ5re6GyJ
         PJBqmdmqpj/6GWVw7sEJsqRaPe65eKQnj0sszNrlVt3t9KIVOjldrUoakU0WoPI4rpjU
         G6IudBsBai5HCatTI1W/f/egsoBVOhDQ40l/UmtVppNF3igOevwSFs0jWDd5xALsdKe2
         y/xg==
X-Gm-Message-State: AOJu0Yy9e5+HU9JSoCnGYrS3JuDiyO0nNDoV7L0BAxLGaXUNyQji2sNW
	dFzWkvqMhS+9cfQgmBgk8eeWpGdEvuldR19B
X-Google-Smtp-Source: AGHT+IHVrXiYfsCtJtqq5EMc0I7PfJDLV0xkEA4OwPdg4g2p76EsPZNBbINftw289BJMQ28uR1i06Q==
X-Received: by 2002:a05:6830:7190:b0:6af:95f9:7adc with SMTP id el16-20020a056830719000b006af95f97adcmr644684otb.14.1701846519870;
        Tue, 05 Dec 2023 23:08:39 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm10184212pgh.14.2023.12.05.23.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:08:39 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Nikishkin <vladimir@nikishkin.pw>,
	Roopa Prabhu <roopa@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 7/9] selftests/net: convert vrf_route_leaking.sh to run it in unique namespace
Date: Wed,  6 Dec 2023 15:07:59 +0800
Message-ID: <20231206070801.1691247-8-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206070801.1691247-1-liuhangbin@gmail.com>
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

 ]# ./vrf_route_leaking.sh

 ###########################################################################
 IPv4 (sym route): VRF ICMP ttl error route lookup ping
 ###########################################################################

 TEST: Basic IPv4 connectivity                                       [ OK ]
 TEST: Ping received ICMP ttl exceeded                               [ OK ]

 ...

 TEST: Basic IPv6 connectivity                                       [ OK ]
 TEST: Traceroute6 reports a hop on r1                               [ OK ]

 Tests passed:  18
 Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/vrf_route_leaking.sh        | 201 +++++++++---------
 1 file changed, 96 insertions(+), 105 deletions(-)

diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
index dedc52562b4f..2da32f4c479b 100755
--- a/tools/testing/selftests/net/vrf_route_leaking.sh
+++ b/tools/testing/selftests/net/vrf_route_leaking.sh
@@ -58,6 +58,7 @@
 # to send an ICMP error back to the source when the ttl of a packet reaches 1
 # while it is forwarded between different vrfs.
 
+source lib.sh
 VERBOSE=0
 PAUSE_ON_FAIL=no
 DEFAULT_TTYPE=sym
@@ -171,11 +172,7 @@ run_cmd_grep()
 
 cleanup()
 {
-	local ns
-
-	for ns in h1 h2 r1 r2; do
-		ip netns del $ns 2>/dev/null
-	done
+	cleanup_ns $h1 $h2 $r1 $r2
 }
 
 setup_vrf()
@@ -212,72 +209,69 @@ setup_sym()
 
 	#
 	# create nodes as namespaces
-	#
-	for ns in h1 h2 r1; do
-		ip netns add $ns
-		ip -netns $ns link set lo up
-
-		case "${ns}" in
-		h[12]) ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=0
-		       ip netns exec $ns sysctl -q -w net.ipv6.conf.all.keep_addr_on_down=1
-			;;
-		r1)    ip netns exec $ns sysctl -q -w net.ipv4.ip_forward=1
-		       ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=1
-		esac
+	setup_ns h1 h2 r1
+	for ns in $h1 $h2 $r1; do
+		if echo $ns | grep -q h[12]-; then
+			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=0
+			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.keep_addr_on_down=1
+		else
+			ip netns exec $ns sysctl -q -w net.ipv4.ip_forward=1
+			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=1
+		fi
 	done
 
 	#
 	# create interconnects
 	#
-	ip -netns h1 link add eth0 type veth peer name r1h1
-	ip -netns h1 link set r1h1 netns r1 name eth0 up
+	ip -netns $h1 link add eth0 type veth peer name r1h1
+	ip -netns $h1 link set r1h1 netns $r1 name eth0 up
 
-	ip -netns h2 link add eth0 type veth peer name r1h2
-	ip -netns h2 link set r1h2 netns r1 name eth1 up
+	ip -netns $h2 link add eth0 type veth peer name r1h2
+	ip -netns $h2 link set r1h2 netns $r1 name eth1 up
 
 	#
 	# h1
 	#
-	ip -netns h1 addr add dev eth0 ${H1_N1_IP}/24
-	ip -netns h1 -6 addr add dev eth0 ${H1_N1_IP6}/64 nodad
-	ip -netns h1 link set eth0 up
+	ip -netns $h1 addr add dev eth0 ${H1_N1_IP}/24
+	ip -netns $h1 -6 addr add dev eth0 ${H1_N1_IP6}/64 nodad
+	ip -netns $h1 link set eth0 up
 
 	# h1 to h2 via r1
-	ip -netns h1    route add ${H2_N2} via ${R1_N1_IP} dev eth0
-	ip -netns h1 -6 route add ${H2_N2_6} via "${R1_N1_IP6}" dev eth0
+	ip -netns $h1    route add ${H2_N2} via ${R1_N1_IP} dev eth0
+	ip -netns $h1 -6 route add ${H2_N2_6} via "${R1_N1_IP6}" dev eth0
 
 	#
 	# h2
 	#
-	ip -netns h2 addr add dev eth0 ${H2_N2_IP}/24
-	ip -netns h2 -6 addr add dev eth0 ${H2_N2_IP6}/64 nodad
-	ip -netns h2 link set eth0 up
+	ip -netns $h2 addr add dev eth0 ${H2_N2_IP}/24
+	ip -netns $h2 -6 addr add dev eth0 ${H2_N2_IP6}/64 nodad
+	ip -netns $h2 link set eth0 up
 
 	# h2 to h1 via r1
-	ip -netns h2 route add default via ${R1_N2_IP} dev eth0
-	ip -netns h2 -6 route add default via ${R1_N2_IP6} dev eth0
+	ip -netns $h2 route add default via ${R1_N2_IP} dev eth0
+	ip -netns $h2 -6 route add default via ${R1_N2_IP6} dev eth0
 
 	#
 	# r1
 	#
-	setup_vrf r1
-	create_vrf r1 blue 1101
-	create_vrf r1 red 1102
-	ip -netns r1 link set mtu 1400 dev eth1
-	ip -netns r1 link set eth0 vrf blue up
-	ip -netns r1 link set eth1 vrf red up
-	ip -netns r1 addr add dev eth0 ${R1_N1_IP}/24
-	ip -netns r1 -6 addr add dev eth0 ${R1_N1_IP6}/64 nodad
-	ip -netns r1 addr add dev eth1 ${R1_N2_IP}/24
-	ip -netns r1 -6 addr add dev eth1 ${R1_N2_IP6}/64 nodad
+	setup_vrf $r1
+	create_vrf $r1 blue 1101
+	create_vrf $r1 red 1102
+	ip -netns $r1 link set mtu 1400 dev eth1
+	ip -netns $r1 link set eth0 vrf blue up
+	ip -netns $r1 link set eth1 vrf red up
+	ip -netns $r1 addr add dev eth0 ${R1_N1_IP}/24
+	ip -netns $r1 -6 addr add dev eth0 ${R1_N1_IP6}/64 nodad
+	ip -netns $r1 addr add dev eth1 ${R1_N2_IP}/24
+	ip -netns $r1 -6 addr add dev eth1 ${R1_N2_IP6}/64 nodad
 
 	# Route leak from blue to red
-	ip -netns r1 route add vrf blue ${H2_N2} dev red
-	ip -netns r1 -6 route add vrf blue ${H2_N2_6} dev red
+	ip -netns $r1 route add vrf blue ${H2_N2} dev red
+	ip -netns $r1 -6 route add vrf blue ${H2_N2_6} dev red
 
 	# Route leak from red to blue
-	ip -netns r1 route add vrf red ${H1_N1} dev blue
-	ip -netns r1 -6 route add vrf red ${H1_N1_6} dev blue
+	ip -netns $r1 route add vrf red ${H1_N1} dev blue
+	ip -netns $r1 -6 route add vrf red ${H1_N1_6} dev blue
 
 
 	# Wait for ip config to settle
@@ -293,90 +287,87 @@ setup_asym()
 
 	#
 	# create nodes as namespaces
-	#
-	for ns in h1 h2 r1 r2; do
-		ip netns add $ns
-		ip -netns $ns link set lo up
-
-		case "${ns}" in
-		h[12]) ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=0
-		       ip netns exec $ns sysctl -q -w net.ipv6.conf.all.keep_addr_on_down=1
-			;;
-		r[12]) ip netns exec $ns sysctl -q -w net.ipv4.ip_forward=1
-		       ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=1
-		esac
+	setup_ns h1 h2 r1 r2
+	for ns in $h1 $h2 $r1 $r2; do
+		if echo $ns | grep -q h[12]-; then
+			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=0
+			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.keep_addr_on_down=1
+		else
+			ip netns exec $ns sysctl -q -w net.ipv4.ip_forward=1
+			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=1
+		fi
 	done
 
 	#
 	# create interconnects
 	#
-	ip -netns h1 link add eth0 type veth peer name r1h1
-	ip -netns h1 link set r1h1 netns r1 name eth0 up
+	ip -netns $h1 link add eth0 type veth peer name r1h1
+	ip -netns $h1 link set r1h1 netns $r1 name eth0 up
 
-	ip -netns h1 link add eth1 type veth peer name r2h1
-	ip -netns h1 link set r2h1 netns r2 name eth0 up
+	ip -netns $h1 link add eth1 type veth peer name r2h1
+	ip -netns $h1 link set r2h1 netns $r2 name eth0 up
 
-	ip -netns h2 link add eth0 type veth peer name r1h2
-	ip -netns h2 link set r1h2 netns r1 name eth1 up
+	ip -netns $h2 link add eth0 type veth peer name r1h2
+	ip -netns $h2 link set r1h2 netns $r1 name eth1 up
 
-	ip -netns h2 link add eth1 type veth peer name r2h2
-	ip -netns h2 link set r2h2 netns r2 name eth1 up
+	ip -netns $h2 link add eth1 type veth peer name r2h2
+	ip -netns $h2 link set r2h2 netns $r2 name eth1 up
 
 	#
 	# h1
 	#
-	ip -netns h1 link add br0 type bridge
-	ip -netns h1 link set br0 up
-	ip -netns h1 addr add dev br0 ${H1_N1_IP}/24
-	ip -netns h1 -6 addr add dev br0 ${H1_N1_IP6}/64 nodad
-	ip -netns h1 link set eth0 master br0 up
-	ip -netns h1 link set eth1 master br0 up
+	ip -netns $h1 link add br0 type bridge
+	ip -netns $h1 link set br0 up
+	ip -netns $h1 addr add dev br0 ${H1_N1_IP}/24
+	ip -netns $h1 -6 addr add dev br0 ${H1_N1_IP6}/64 nodad
+	ip -netns $h1 link set eth0 master br0 up
+	ip -netns $h1 link set eth1 master br0 up
 
 	# h1 to h2 via r1
-	ip -netns h1    route add ${H2_N2} via ${R1_N1_IP} dev br0
-	ip -netns h1 -6 route add ${H2_N2_6} via "${R1_N1_IP6}" dev br0
+	ip -netns $h1    route add ${H2_N2} via ${R1_N1_IP} dev br0
+	ip -netns $h1 -6 route add ${H2_N2_6} via "${R1_N1_IP6}" dev br0
 
 	#
 	# h2
 	#
-	ip -netns h2 link add br0 type bridge
-	ip -netns h2 link set br0 up
-	ip -netns h2 addr add dev br0 ${H2_N2_IP}/24
-	ip -netns h2 -6 addr add dev br0 ${H2_N2_IP6}/64 nodad
-	ip -netns h2 link set eth0 master br0 up
-	ip -netns h2 link set eth1 master br0 up
+	ip -netns $h2 link add br0 type bridge
+	ip -netns $h2 link set br0 up
+	ip -netns $h2 addr add dev br0 ${H2_N2_IP}/24
+	ip -netns $h2 -6 addr add dev br0 ${H2_N2_IP6}/64 nodad
+	ip -netns $h2 link set eth0 master br0 up
+	ip -netns $h2 link set eth1 master br0 up
 
 	# h2 to h1 via r2
-	ip -netns h2 route add default via ${R2_N2_IP} dev br0
-	ip -netns h2 -6 route add default via ${R2_N2_IP6} dev br0
+	ip -netns $h2 route add default via ${R2_N2_IP} dev br0
+	ip -netns $h2 -6 route add default via ${R2_N2_IP6} dev br0
 
 	#
 	# r1
 	#
-	setup_vrf r1
-	create_vrf r1 blue 1101
-	create_vrf r1 red 1102
-	ip -netns r1 link set mtu 1400 dev eth1
-	ip -netns r1 link set eth0 vrf blue up
-	ip -netns r1 link set eth1 vrf red up
-	ip -netns r1 addr add dev eth0 ${R1_N1_IP}/24
-	ip -netns r1 -6 addr add dev eth0 ${R1_N1_IP6}/64 nodad
-	ip -netns r1 addr add dev eth1 ${R1_N2_IP}/24
-	ip -netns r1 -6 addr add dev eth1 ${R1_N2_IP6}/64 nodad
+	setup_vrf $r1
+	create_vrf $r1 blue 1101
+	create_vrf $r1 red 1102
+	ip -netns $r1 link set mtu 1400 dev eth1
+	ip -netns $r1 link set eth0 vrf blue up
+	ip -netns $r1 link set eth1 vrf red up
+	ip -netns $r1 addr add dev eth0 ${R1_N1_IP}/24
+	ip -netns $r1 -6 addr add dev eth0 ${R1_N1_IP6}/64 nodad
+	ip -netns $r1 addr add dev eth1 ${R1_N2_IP}/24
+	ip -netns $r1 -6 addr add dev eth1 ${R1_N2_IP6}/64 nodad
 
 	# Route leak from blue to red
-	ip -netns r1 route add vrf blue ${H2_N2} dev red
-	ip -netns r1 -6 route add vrf blue ${H2_N2_6} dev red
+	ip -netns $r1 route add vrf blue ${H2_N2} dev red
+	ip -netns $r1 -6 route add vrf blue ${H2_N2_6} dev red
 
 	# No route leak from red to blue
 
 	#
 	# r2
 	#
-	ip -netns r2 addr add dev eth0 ${R2_N1_IP}/24
-	ip -netns r2 -6 addr add dev eth0 ${R2_N1_IP6}/64 nodad
-	ip -netns r2 addr add dev eth1 ${R2_N2_IP}/24
-	ip -netns r2 -6 addr add dev eth1 ${R2_N2_IP6}/64 nodad
+	ip -netns $r2 addr add dev eth0 ${R2_N1_IP}/24
+	ip -netns $r2 -6 addr add dev eth0 ${R2_N1_IP6}/64 nodad
+	ip -netns $r2 addr add dev eth1 ${R2_N2_IP}/24
+	ip -netns $r2 -6 addr add dev eth1 ${R2_N2_IP6}/64 nodad
 
 	# Wait for ip config to settle
 	sleep 2
@@ -384,14 +375,14 @@ setup_asym()
 
 check_connectivity()
 {
-	ip netns exec h1 ping -c1 -w1 ${H2_N2_IP} >/dev/null 2>&1
+	ip netns exec $h1 ping -c1 -w1 ${H2_N2_IP} >/dev/null 2>&1
 	log_test $? 0 "Basic IPv4 connectivity"
 	return $?
 }
 
 check_connectivity6()
 {
-	ip netns exec h1 "${ping6}" -c1 -w1 ${H2_N2_IP6} >/dev/null 2>&1
+	ip netns exec $h1 "${ping6}" -c1 -w1 ${H2_N2_IP6} >/dev/null 2>&1
 	log_test $? 0 "Basic IPv6 connectivity"
 	return $?
 }
@@ -426,7 +417,7 @@ ipv4_traceroute()
 
 	check_connectivity || return
 
-	run_cmd_grep "${R1_N1_IP}" ip netns exec h1 traceroute ${H2_N2_IP}
+	run_cmd_grep "${R1_N1_IP}" ip netns exec $h1 traceroute ${H2_N2_IP}
 	log_test $? 0 "Traceroute reports a hop on r1"
 }
 
@@ -449,7 +440,7 @@ ipv6_traceroute()
 
 	check_connectivity6 || return
 
-	run_cmd_grep "${R1_N1_IP6}" ip netns exec h1 traceroute6 ${H2_N2_IP6}
+	run_cmd_grep "${R1_N1_IP6}" ip netns exec $h1 traceroute6 ${H2_N2_IP6}
 	log_test $? 0 "Traceroute6 reports a hop on r1"
 }
 
@@ -470,7 +461,7 @@ ipv4_ping_ttl()
 
 	check_connectivity || return
 
-	run_cmd_grep "Time to live exceeded" ip netns exec h1 ping -t1 -c1 -W2 ${H2_N2_IP}
+	run_cmd_grep "Time to live exceeded" ip netns exec $h1 ping -t1 -c1 -W2 ${H2_N2_IP}
 	log_test $? 0 "Ping received ICMP ttl exceeded"
 }
 
@@ -491,7 +482,7 @@ ipv4_ping_frag()
 
 	check_connectivity || return
 
-	run_cmd_grep "Frag needed" ip netns exec h1 ping -s 1450 -Mdo -c1 -W2 ${H2_N2_IP}
+	run_cmd_grep "Frag needed" ip netns exec $h1 ping -s 1450 -Mdo -c1 -W2 ${H2_N2_IP}
 	log_test $? 0 "Ping received ICMP Frag needed"
 }
 
@@ -512,7 +503,7 @@ ipv6_ping_ttl()
 
 	check_connectivity6 || return
 
-	run_cmd_grep "Time exceeded: Hop limit" ip netns exec h1 "${ping6}" -t1 -c1 -W2 ${H2_N2_IP6}
+	run_cmd_grep "Time exceeded: Hop limit" ip netns exec $h1 "${ping6}" -t1 -c1 -W2 ${H2_N2_IP6}
 	log_test $? 0 "Ping received ICMP Hop limit"
 }
 
@@ -533,7 +524,7 @@ ipv6_ping_frag()
 
 	check_connectivity6 || return
 
-	run_cmd_grep "Packet too big" ip netns exec h1 "${ping6}" -s 1450 -Mdo -c1 -W2 ${H2_N2_IP6}
+	run_cmd_grep "Packet too big" ip netns exec $h1 "${ping6}" -s 1450 -Mdo -c1 -W2 ${H2_N2_IP6}
 	log_test $? 0 "Ping received ICMP Packet too big"
 }
 
-- 
2.43.0


