Return-Path: <linux-kselftest+bounces-535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E467F6FC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB1828135E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72561774E;
	Fri, 24 Nov 2023 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK/yYWzE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6FED7E;
	Fri, 24 Nov 2023 01:30:15 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cf89df1eecso12198585ad.3;
        Fri, 24 Nov 2023 01:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818215; x=1701423015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgBEaxvrc+2wbvzWK1enBc8wP3vKvHP/PM/JxL5bcMg=;
        b=XK/yYWzEAjLE5ObRWdF8RP0/bKKr5kZPNk4t4zxoqWYjicnK+xfEn1N2i4pvs9ZARo
         +z0lIraWFkI+I/uPab7ZcB+vRHPL8pJIKsEAI9DAr7Df38gQ7nCOtQaICbGyuza2Tsrv
         qJiiVLs8ks6uw6+FR/tGfQnD6r4JqwW3VS45mg/GDm5Dfm1I75X90asDCTSx9Iu0dD8a
         b4VRjTd0fBVLmkSPwDMEWFRX8xGyEVdsfEf4WHTwWLeDB3+5xVRNjZm3d+r0mBRAJoq/
         WaTRDcqlvTgmT/3Z2gCYdmcAkyNysLWBtouKX/irBhMcHnk1YjS7jEHOoRBBOqpoHuYe
         ZMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818215; x=1701423015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgBEaxvrc+2wbvzWK1enBc8wP3vKvHP/PM/JxL5bcMg=;
        b=i7xKaEYYnY2hL3FzXIs5WniRNK5nxxtswPg/t+dhhnFiui5BAHrNjHNah3e4DjcqHC
         Z1/0aEfcPzHxv9u9GdKG5RR/Ont47XD4AStuUS2Jk5+32421toY8bpeTsoYY4dJ00Z7B
         M9mUslGh3QwPEcLLENW6Gcij70TiOfMC1Ct+yBqp4cB1LFxeNFy3wcY/JYge8EhJe2pM
         n2BNuBZn3JOXL3OLs/8fKtoqR8hbtn2u1yRhG72ASMClch9Xo+evnWb8jhA261wNggdA
         gi9Vn/YQcedsFNgWMJuo2bOZHhasiekzYON1F5rwG/ZUlA2apH/uLRuPoiM30Aoa0uCH
         IQEg==
X-Gm-Message-State: AOJu0YzUs1Nrt2RlyB/b49eEoFctTOEGEg9e0Mj9+HQDBnh3/3ooQA1/
	pSqtYd+FcVwb3arIRHat9oErV6hzrQsx2rj+
X-Google-Smtp-Source: AGHT+IH0J2OY8iTKOZcW8qNuOYyyJQh+Wag3QU6ZZXWb18rSj86/HAPIr7KnztKlKZOUXmgYzQkeKg==
X-Received: by 2002:a17:902:f68e:b0:1cf:9bd1:aaea with SMTP id l14-20020a170902f68e00b001cf9bd1aaeamr2548042plg.11.1700818214700;
        Fri, 24 Nov 2023 01:30:14 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:30:13 -0800 (PST)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 33/38] selftests/net: convert vrf_route_leaking.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:31 +0800
Message-ID: <20231124092736.3673263-34-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124092736.3673263-1-liuhangbin@gmail.com>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
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
2.41.0


