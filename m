Return-Path: <linux-kselftest+bounces-870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D10F7FE804
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11684B20EA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C20B14A94;
	Thu, 30 Nov 2023 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOA9moz0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8906D10E4;
	Wed, 29 Nov 2023 20:01:54 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d7eca548ccso309729a34.3;
        Wed, 29 Nov 2023 20:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316913; x=1701921713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crW4IQ4aOK0KScyW47FeZK389nmMITjmJignlXDkR4w=;
        b=eOA9moz0i14N+z9NT7PG6o5WKt+0EqBZkaIyztsuX4Zy7m3a1t3csE2BPyaTOLoy/s
         GI+Ml64FhVE/8iBQI79xcEse7dvUnU9kFVnIgvSIoA2l8uAE8qTu6fv1vrO6m4oonaW/
         8/+nCbQ+17abp8m+D4UN/bSNpCtMsfglS6Qf5L0Ei4DDGIIfLl6FXtrk6jQxZKNZSG15
         eCqGMk9pHVvaSiTA/QBT2xdmj0KR3pORMoszTwT/loFn5Se3J1Hor84+CWhMVhD5lgVr
         jysZqF8U6L90vELvHZSgfGc8gZrRCYt32F5sIdID22hAINiHKNG2GrLj9IJ0U1uWHKzZ
         XvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316913; x=1701921713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crW4IQ4aOK0KScyW47FeZK389nmMITjmJignlXDkR4w=;
        b=U/WerBC2fEXF++4UOtDKshdFIA9N0xdI7kZNFBvnYANm3gQ1hmOvl7SN0gTFO2nf59
         bNXGW8tPwEYaf6X2TmEp1/U/LCSo2tSTb9FWg7lccZt+4pvXiAtlyCceVNZkBehxY9O/
         Zb2W8ZyxPcwnIFUqyOGyAw1kqbTLee2tqRttWWVe+ZA/vTfQqfLDUSL3jVs9bZ5C2sM5
         N03T9ryRJObQNcSqgXIY6kVYBS+WU3WuGSq946XjJIIgTV17QlTWkzjrDq3OuxM88wD4
         by0k4aIxQbaK2ZAHZV2fp8xTkIBOv6ty9SQ8JL6FS3KDu6w2BphGWwoCGKfXBj7BYGG9
         xDGg==
X-Gm-Message-State: AOJu0YzIKjMRcNb0+lx+liooPee+MqWQMV1P0K+T0o2NKeRPOqYWsmFA
	GlvjN5HyCXkAGCr7njYlJtosVC3Fud0B6Q==
X-Google-Smtp-Source: AGHT+IEkS++rfinNZ7KHPoP4osKI2K2laGPg4trMOea4TtXPSu1CcpXEsWZqr3qM2x0/gih+5OT3Jw==
X-Received: by 2002:a05:6871:4097:b0:1f9:697a:69e1 with SMTP id kz23-20020a056871409700b001f9697a69e1mr26586035oab.16.1701316913296;
        Wed, 29 Nov 2023 20:01:53 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:01:52 -0800 (PST)
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
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 08/14] selftests/net: convert icmp_redirect.sh to run it in unique namespace
Date: Thu, 30 Nov 2023 12:00:59 +0800
Message-ID: <20231130040105.1265779-9-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130040105.1265779-1-liuhangbin@gmail.com>
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

 # ./icmp_redirect.sh

 ###########################################################################
 Legacy routing
 ###########################################################################

 TEST: IPv4: redirect exception                                      [ OK ]

 ...

 TEST: IPv4: mtu exception plus redirect                             [ OK ]
 TEST: IPv6: mtu exception plus redirect                             [ OK ]

 Tests passed:  40
 Tests failed:   0
 Tests xfailed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/icmp_redirect.sh | 182 +++++++++----------
 1 file changed, 88 insertions(+), 94 deletions(-)

diff --git a/tools/testing/selftests/net/icmp_redirect.sh b/tools/testing/selftests/net/icmp_redirect.sh
index 7b9d6e31b8e7..d6f0e449c029 100755
--- a/tools/testing/selftests/net/icmp_redirect.sh
+++ b/tools/testing/selftests/net/icmp_redirect.sh
@@ -19,6 +19,7 @@
 # Route on r1 changed to go to r2 via eth0. This causes a redirect to be sent
 # from r1 to h1 telling h1 to use r2 when talking to h2.
 
+source lib.sh
 VERBOSE=0
 PAUSE_ON_FAIL=no
 
@@ -140,11 +141,7 @@ get_linklocal()
 
 cleanup()
 {
-	local ns
-
-	for ns in h1 h2 r1 r2; do
-		ip netns del $ns 2>/dev/null
-	done
+	cleanup_ns $h1 $h2 $r1 $r2
 }
 
 create_vrf()
@@ -171,102 +168,99 @@ setup()
 
 	#
 	# create nodes as namespaces
-	#
-	for ns in h1 h2 r1 r2; do
-		ip netns add $ns
-		ip -netns $ns li set lo up
-
-		case "${ns}" in
-		h[12]) ip netns exec $ns sysctl -q -w net.ipv4.conf.all.accept_redirects=1
-		       ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=0
-		       ip netns exec $ns sysctl -q -w net.ipv6.conf.all.accept_redirects=1
-		       ip netns exec $ns sysctl -q -w net.ipv6.conf.all.keep_addr_on_down=1
-			;;
-		r[12]) ip netns exec $ns sysctl -q -w net.ipv4.ip_forward=1
-		       ip netns exec $ns sysctl -q -w net.ipv4.conf.all.send_redirects=1
-		       ip netns exec $ns sysctl -q -w net.ipv4.conf.default.rp_filter=0
-		       ip netns exec $ns sysctl -q -w net.ipv4.conf.all.rp_filter=0
-
-		       ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=1
-		       ip netns exec $ns sysctl -q -w net.ipv6.route.mtu_expires=10
-		esac
+	setup_ns h1 h2 r1 r2
+	for ns in $h1 $h2 $r1 $r2; do
+		if echo $ns | grep -q h[12]-; then
+			ip netns exec $ns sysctl -q -w net.ipv4.conf.all.accept_redirects=1
+			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=0
+			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.accept_redirects=1
+			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.keep_addr_on_down=1
+		else
+			ip netns exec $ns sysctl -q -w net.ipv4.ip_forward=1
+			ip netns exec $ns sysctl -q -w net.ipv4.conf.all.send_redirects=1
+			ip netns exec $ns sysctl -q -w net.ipv4.conf.default.rp_filter=0
+			ip netns exec $ns sysctl -q -w net.ipv4.conf.all.rp_filter=0
+
+			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=1
+			ip netns exec $ns sysctl -q -w net.ipv6.route.mtu_expires=10
+		fi
 	done
 
 	#
 	# create interconnects
 	#
-	ip -netns h1 li add eth0 type veth peer name r1h1
-	ip -netns h1 li set r1h1 netns r1 name eth0 up
+	ip -netns $h1 li add eth0 type veth peer name r1h1
+	ip -netns $h1 li set r1h1 netns $r1 name eth0 up
 
-	ip -netns h1 li add eth1 type veth peer name r2h1
-	ip -netns h1 li set r2h1 netns r2 name eth0 up
+	ip -netns $h1 li add eth1 type veth peer name r2h1
+	ip -netns $h1 li set r2h1 netns $r2 name eth0 up
 
-	ip -netns h2 li add eth0 type veth peer name r2h2
-	ip -netns h2 li set eth0 up
-	ip -netns h2 li set r2h2 netns r2 name eth2 up
+	ip -netns $h2 li add eth0 type veth peer name r2h2
+	ip -netns $h2 li set eth0 up
+	ip -netns $h2 li set r2h2 netns $r2 name eth2 up
 
-	ip -netns r1 li add eth1 type veth peer name r2r1
-	ip -netns r1 li set eth1 up
-	ip -netns r1 li set r2r1 netns r2 name eth1 up
+	ip -netns $r1 li add eth1 type veth peer name r2r1
+	ip -netns $r1 li set eth1 up
+	ip -netns $r1 li set r2r1 netns $r2 name eth1 up
 
 	#
 	# h1
 	#
 	if [ "${WITH_VRF}" = "yes" ]; then
-		create_vrf "h1"
+		create_vrf "$h1"
 		H1_VRF_ARG="vrf ${VRF}"
 		H1_PING_ARG="-I ${VRF}"
 	else
 		H1_VRF_ARG=
 		H1_PING_ARG=
 	fi
-	ip -netns h1 li add br0 type bridge
+	ip -netns $h1 li add br0 type bridge
 	if [ "${WITH_VRF}" = "yes" ]; then
-		ip -netns h1 li set br0 vrf ${VRF} up
+		ip -netns $h1 li set br0 vrf ${VRF} up
 	else
-		ip -netns h1 li set br0 up
+		ip -netns $h1 li set br0 up
 	fi
-	ip -netns h1 addr add dev br0 ${H1_N1_IP}/24
-	ip -netns h1 -6 addr add dev br0 ${H1_N1_IP6}/64 nodad
-	ip -netns h1 li set eth0 master br0 up
-	ip -netns h1 li set eth1 master br0 up
+	ip -netns $h1 addr add dev br0 ${H1_N1_IP}/24
+	ip -netns $h1 -6 addr add dev br0 ${H1_N1_IP6}/64 nodad
+	ip -netns $h1 li set eth0 master br0 up
+	ip -netns $h1 li set eth1 master br0 up
 
 	#
 	# h2
 	#
-	ip -netns h2 addr add dev eth0 ${H2_N2_IP}/24
-	ip -netns h2 ro add default via ${R2_N2_IP} dev eth0
-	ip -netns h2 -6 addr add dev eth0 ${H2_N2_IP6}/64 nodad
-	ip -netns h2 -6 ro add default via ${R2_N2_IP6} dev eth0
+	ip -netns $h2 addr add dev eth0 ${H2_N2_IP}/24
+	ip -netns $h2 ro add default via ${R2_N2_IP} dev eth0
+	ip -netns $h2 -6 addr add dev eth0 ${H2_N2_IP6}/64 nodad
+	ip -netns $h2 -6 ro add default via ${R2_N2_IP6} dev eth0
 
 	#
 	# r1
 	#
-	ip -netns r1 addr add dev eth0 ${R1_N1_IP}/24
-	ip -netns r1 -6 addr add dev eth0 ${R1_N1_IP6}/64 nodad
-	ip -netns r1 addr add dev eth1 ${R1_R2_N1_IP}/30
-	ip -netns r1 -6 addr add dev eth1 ${R1_R2_N1_IP6}/126 nodad
+	ip -netns $r1 addr add dev eth0 ${R1_N1_IP}/24
+	ip -netns $r1 -6 addr add dev eth0 ${R1_N1_IP6}/64 nodad
+	ip -netns $r1 addr add dev eth1 ${R1_R2_N1_IP}/30
+	ip -netns $r1 -6 addr add dev eth1 ${R1_R2_N1_IP6}/126 nodad
 
 	#
 	# r2
 	#
-	ip -netns r2 addr add dev eth0 ${R2_N1_IP}/24
-	ip -netns r2 -6 addr add dev eth0 ${R2_N1_IP6}/64 nodad
-	ip -netns r2 addr add dev eth1 ${R2_R1_N1_IP}/30
-	ip -netns r2 -6 addr add dev eth1 ${R2_R1_N1_IP6}/126 nodad
-	ip -netns r2 addr add dev eth2 ${R2_N2_IP}/24
-	ip -netns r2 -6 addr add dev eth2 ${R2_N2_IP6}/64 nodad
+	ip -netns $r2 addr add dev eth0 ${R2_N1_IP}/24
+	ip -netns $r2 -6 addr add dev eth0 ${R2_N1_IP6}/64 nodad
+	ip -netns $r2 addr add dev eth1 ${R2_R1_N1_IP}/30
+	ip -netns $r2 -6 addr add dev eth1 ${R2_R1_N1_IP6}/126 nodad
+	ip -netns $r2 addr add dev eth2 ${R2_N2_IP}/24
+	ip -netns $r2 -6 addr add dev eth2 ${R2_N2_IP6}/64 nodad
 
 	sleep 2
 
-	R1_LLADDR=$(get_linklocal r1 eth0)
+	R1_LLADDR=$(get_linklocal $r1 eth0)
 	if [ $? -ne 0 ]; then
 		echo "Error: Failed to get link-local address of r1's eth0"
 		exit 1
 	fi
 	log_debug "initial gateway is R1's lladdr = ${R1_LLADDR}"
 
-	R2_LLADDR=$(get_linklocal r2 eth0)
+	R2_LLADDR=$(get_linklocal $r2 eth0)
 	if [ $? -ne 0 ]; then
 		echo "Error: Failed to get link-local address of r2's eth0"
 		exit 1
@@ -278,8 +272,8 @@ change_h2_mtu()
 {
 	local mtu=$1
 
-	run_cmd ip -netns h2 li set eth0 mtu ${mtu}
-	run_cmd ip -netns r2 li set eth2 mtu ${mtu}
+	run_cmd ip -netns $h2 li set eth0 mtu ${mtu}
+	run_cmd ip -netns $r2 li set eth2 mtu ${mtu}
 }
 
 check_exception()
@@ -291,40 +285,40 @@ check_exception()
 	# From 172.16.1.101: icmp_seq=1 Redirect Host(New nexthop: 172.16.1.102)
 	if [ "$VERBOSE" = "1" ]; then
 		echo "Commands to check for exception:"
-		run_cmd ip -netns h1 ro get ${H1_VRF_ARG} ${H2_N2_IP}
-		run_cmd ip -netns h1 -6 ro get ${H1_VRF_ARG} ${H2_N2_IP6}
+		run_cmd ip -netns $h1 ro get ${H1_VRF_ARG} ${H2_N2_IP}
+		run_cmd ip -netns $h1 -6 ro get ${H1_VRF_ARG} ${H2_N2_IP6}
 	fi
 
 	if [ -n "${mtu}" ]; then
 		mtu=" mtu ${mtu}"
 	fi
 	if [ "$with_redirect" = "yes" ]; then
-		ip -netns h1 ro get ${H1_VRF_ARG} ${H2_N2_IP} | \
+		ip -netns $h1 ro get ${H1_VRF_ARG} ${H2_N2_IP} | \
 		grep -q "cache <redirected> expires [0-9]*sec${mtu}"
 	elif [ -n "${mtu}" ]; then
-		ip -netns h1 ro get ${H1_VRF_ARG} ${H2_N2_IP} | \
+		ip -netns $h1 ro get ${H1_VRF_ARG} ${H2_N2_IP} | \
 		grep -q "cache expires [0-9]*sec${mtu}"
 	else
 		# want to verify that neither mtu nor redirected appears in
 		# the route get output. The -v will wipe out the cache line
 		# if either are set so the last grep -q will not find a match
-		ip -netns h1 ro get ${H1_VRF_ARG} ${H2_N2_IP} | \
+		ip -netns $h1 ro get ${H1_VRF_ARG} ${H2_N2_IP} | \
 		grep -E -v 'mtu|redirected' | grep -q "cache"
 	fi
 	log_test $? 0 "IPv4: ${desc}" 0
 
 	# No PMTU info for test "redirect" and "mtu exception plus redirect"
 	if [ "$with_redirect" = "yes" ] && [ "$desc" != "redirect exception plus mtu" ]; then
-		ip -netns h1 -6 ro get ${H1_VRF_ARG} ${H2_N2_IP6} | \
+		ip -netns $h1 -6 ro get ${H1_VRF_ARG} ${H2_N2_IP6} | \
 		grep -v "mtu" | grep -q "${H2_N2_IP6} .*via ${R2_LLADDR} dev br0"
 	elif [ -n "${mtu}" ]; then
-		ip -netns h1 -6 ro get ${H1_VRF_ARG} ${H2_N2_IP6} | \
+		ip -netns $h1 -6 ro get ${H1_VRF_ARG} ${H2_N2_IP6} | \
 		grep -q "${mtu}"
 	else
 		# IPv6 is a bit harder. First strip out the match if it
 		# contains an mtu exception and then look for the first
 		# gateway - R1's lladdr
-		ip -netns h1 -6 ro get ${H1_VRF_ARG} ${H2_N2_IP6} | \
+		ip -netns $h1 -6 ro get ${H1_VRF_ARG} ${H2_N2_IP6} | \
 		grep -v "mtu" | grep -q "${R1_LLADDR}"
 	fi
 	log_test $? 0 "IPv6: ${desc}" 1
@@ -334,21 +328,21 @@ run_ping()
 {
 	local sz=$1
 
-	run_cmd ip netns exec h1 ping -q -M want -i 0.5 -c 10 -w 2 -s ${sz} ${H1_PING_ARG} ${H2_N2_IP}
-	run_cmd ip netns exec h1 ${ping6} -q -M want -i 0.5 -c 10 -w 2 -s ${sz} ${H1_PING_ARG} ${H2_N2_IP6}
+	run_cmd ip netns exec $h1 ping -q -M want -i 0.5 -c 10 -w 2 -s ${sz} ${H1_PING_ARG} ${H2_N2_IP}
+	run_cmd ip netns exec $h1 ${ping6} -q -M want -i 0.5 -c 10 -w 2 -s ${sz} ${H1_PING_ARG} ${H2_N2_IP6}
 }
 
 replace_route_new()
 {
 	# r1 to h2 via r2 and eth0
-	run_cmd ip -netns r1 nexthop replace id 1 via ${R2_N1_IP} dev eth0
-	run_cmd ip -netns r1 nexthop replace id 2 via ${R2_LLADDR} dev eth0
+	run_cmd ip -netns $r1 nexthop replace id 1 via ${R2_N1_IP} dev eth0
+	run_cmd ip -netns $r1 nexthop replace id 2 via ${R2_LLADDR} dev eth0
 }
 
 reset_route_new()
 {
-	run_cmd ip -netns r1 nexthop flush
-	run_cmd ip -netns h1 nexthop flush
+	run_cmd ip -netns $r1 nexthop flush
+	run_cmd ip -netns $h1 nexthop flush
 
 	initial_route_new
 }
@@ -356,34 +350,34 @@ reset_route_new()
 initial_route_new()
 {
 	# r1 to h2 via r2 and eth1
-	run_cmd ip -netns r1 nexthop add id 1 via ${R2_R1_N1_IP} dev eth1
-	run_cmd ip -netns r1 ro add ${H2_N2} nhid 1
+	run_cmd ip -netns $r1 nexthop add id 1 via ${R2_R1_N1_IP} dev eth1
+	run_cmd ip -netns $r1 ro add ${H2_N2} nhid 1
 
-	run_cmd ip -netns r1 nexthop add id 2 via ${R2_R1_N1_IP6} dev eth1
-	run_cmd ip -netns r1 -6 ro add ${H2_N2_6} nhid 2
+	run_cmd ip -netns $r1 nexthop add id 2 via ${R2_R1_N1_IP6} dev eth1
+	run_cmd ip -netns $r1 -6 ro add ${H2_N2_6} nhid 2
 
 	# h1 to h2 via r1
-	run_cmd ip -netns h1 nexthop add id 1 via ${R1_N1_IP} dev br0
-	run_cmd ip -netns h1 ro add ${H1_VRF_ARG} ${H2_N2} nhid 1
+	run_cmd ip -netns $h1 nexthop add id 1 via ${R1_N1_IP} dev br0
+	run_cmd ip -netns $h1 ro add ${H1_VRF_ARG} ${H2_N2} nhid 1
 
-	run_cmd ip -netns h1 nexthop add id 2 via ${R1_LLADDR} dev br0
-	run_cmd ip -netns h1 -6 ro add ${H1_VRF_ARG} ${H2_N2_6} nhid 2
+	run_cmd ip -netns $h1 nexthop add id 2 via ${R1_LLADDR} dev br0
+	run_cmd ip -netns $h1 -6 ro add ${H1_VRF_ARG} ${H2_N2_6} nhid 2
 }
 
 replace_route_legacy()
 {
 	# r1 to h2 via r2 and eth0
-	run_cmd ip -netns r1    ro replace ${H2_N2}   via ${R2_N1_IP}  dev eth0
-	run_cmd ip -netns r1 -6 ro replace ${H2_N2_6} via ${R2_LLADDR} dev eth0
+	run_cmd ip -netns $r1    ro replace ${H2_N2}   via ${R2_N1_IP}  dev eth0
+	run_cmd ip -netns $r1 -6 ro replace ${H2_N2_6} via ${R2_LLADDR} dev eth0
 }
 
 reset_route_legacy()
 {
-	run_cmd ip -netns r1    ro del ${H2_N2}
-	run_cmd ip -netns r1 -6 ro del ${H2_N2_6}
+	run_cmd ip -netns $r1    ro del ${H2_N2}
+	run_cmd ip -netns $r1 -6 ro del ${H2_N2_6}
 
-	run_cmd ip -netns h1    ro del ${H1_VRF_ARG} ${H2_N2}
-	run_cmd ip -netns h1 -6 ro del ${H1_VRF_ARG} ${H2_N2_6}
+	run_cmd ip -netns $h1    ro del ${H1_VRF_ARG} ${H2_N2}
+	run_cmd ip -netns $h1 -6 ro del ${H1_VRF_ARG} ${H2_N2_6}
 
 	initial_route_legacy
 }
@@ -391,22 +385,22 @@ reset_route_legacy()
 initial_route_legacy()
 {
 	# r1 to h2 via r2 and eth1
-	run_cmd ip -netns r1    ro add ${H2_N2}   via ${R2_R1_N1_IP}  dev eth1
-	run_cmd ip -netns r1 -6 ro add ${H2_N2_6} via ${R2_R1_N1_IP6} dev eth1
+	run_cmd ip -netns $r1    ro add ${H2_N2}   via ${R2_R1_N1_IP}  dev eth1
+	run_cmd ip -netns $r1 -6 ro add ${H2_N2_6} via ${R2_R1_N1_IP6} dev eth1
 
 	# h1 to h2 via r1
 	# - IPv6 redirect only works if gateway is the LLA
-	run_cmd ip -netns h1    ro add ${H1_VRF_ARG} ${H2_N2} via ${R1_N1_IP} dev br0
-	run_cmd ip -netns h1 -6 ro add ${H1_VRF_ARG} ${H2_N2_6} via ${R1_LLADDR} dev br0
+	run_cmd ip -netns $h1    ro add ${H1_VRF_ARG} ${H2_N2} via ${R1_N1_IP} dev br0
+	run_cmd ip -netns $h1 -6 ro add ${H1_VRF_ARG} ${H2_N2_6} via ${R1_LLADDR} dev br0
 }
 
 check_connectivity()
 {
 	local rc
 
-	run_cmd ip netns exec h1 ping -c1 -w1 ${H1_PING_ARG} ${H2_N2_IP}
+	run_cmd ip netns exec $h1 ping -c1 -w1 ${H1_PING_ARG} ${H2_N2_IP}
 	rc=$?
-	run_cmd ip netns exec h1 ${ping6} -c1 -w1 ${H1_PING_ARG} ${H2_N2_IP6}
+	run_cmd ip netns exec $h1 ${ping6} -c1 -w1 ${H1_PING_ARG} ${H2_N2_IP6}
 	[ $? -ne 0 ] && rc=$?
 
 	return $rc
-- 
2.41.0


