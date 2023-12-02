Return-Path: <linux-kselftest+bounces-1010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8B8019D4
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F007BB20FF4
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FE74696;
	Sat,  2 Dec 2023 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeVdLM/v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961F10F4;
	Fri,  1 Dec 2023 18:01:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d048c171d6so10673235ad.1;
        Fri, 01 Dec 2023 18:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482512; x=1702087312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2SE293zCnBr6dFCk4R67vWSvJhfGut1iF0Lrn4ODYc=;
        b=SeVdLM/viododOVesq/HwBWHTa6QYrVil22iCFuq/n5RtXK+Cvw4HmSZ4dTjK/4rUg
         Qicz9fJOHA9NxI93kc5mhjU/ZdXfkycZI4rd/LB/QLbyiC7kxVpI9/byP0NalPMuuf9X
         K64udKyJBdQu1I8Jhnwd6NZsc4XlSGs3qyJgDtRIl22geegspul0v6iVPrHOQiWbfOJS
         /Ym89VbpaGZJ2t8i6cui8cvjq2+XDdphiieOIbIdtz6DM4cLfyUaPsywtxq1XGlrXDSW
         +kKulCwjYbqSAWsQ4OEbAP3sQGa2RRzwZmdHV6KQLFx+tsYSawz1rc/CuyCzwK8vQJUX
         31tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482512; x=1702087312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2SE293zCnBr6dFCk4R67vWSvJhfGut1iF0Lrn4ODYc=;
        b=Sy7gRFuxFzKPfE/fnK8F92bTkgjE877PW4HIF8NXMGEY7G2p/ZXCg0Gqx5WTSollPG
         wGWXinNB2HSuAlTMbm9Uz+IuJF4zqaC9tq1tMDo6s5SY68tHcfjcrcOUT8qV+Xiiy0TE
         xAVHF5HQuWUFpasJ94fHKfbn+N6IxR+jSNNOJkgT3Ae97ydBLyMhEXUhq8L0DvUVxccE
         RXKoMFIRP5wiJhGwoAe4VI8vdhfNJfSanFgUaFDnQoojM3qSb6wqanLTmBF/M9avClzO
         630dRb76HzAifPbLkkye0z0K0g2UGxlxDbpt9x57yplbH7GIMITck13G9VQ7ya0Q23M5
         qO1g==
X-Gm-Message-State: AOJu0Yx+13UzXX8UWWQK73tTzQm29icoG+7X2iXrASHWPXnKQGl+Usfv
	sBuLEGL9IG2Yb+LfExxt+E5KrDROLfGi1Qjq
X-Google-Smtp-Source: AGHT+IGiXpqI1NqGgLTCjr+OXnF5OgBFApAlWrRp6o6+A5J6OVCyIBy99+Hec8YwS18SttojXNgQ4Q==
X-Received: by 2002:a17:902:968d:b0:1d0:6ffd:9e25 with SMTP id n13-20020a170902968d00b001d06ffd9e25mr510020plp.119.1701482512202;
        Fri, 01 Dec 2023 18:01:52 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:01:51 -0800 (PST)
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
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	James Chapman <jchapman@katalix.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 07/14] selftests/net: convert traceroute.sh to run it in unique namespace
Date: Sat,  2 Dec 2023 10:01:03 +0800
Message-ID: <20231202020110.362433-8-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202020110.362433-1-liuhangbin@gmail.com>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

]# ./traceroute.sh
TEST: IPV6 traceroute                                               [ OK ]
TEST: IPV4 traceroute                                               [ OK ]

Tests passed:   2
Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/traceroute.sh | 82 ++++++++++-------------
 1 file changed, 36 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
index de9ca97abc30..282f14760940 100755
--- a/tools/testing/selftests/net/traceroute.sh
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -4,6 +4,7 @@
 # Run traceroute/traceroute6 tests
 #
 
+source lib.sh
 VERBOSE=0
 PAUSE_ON_FAIL=no
 
@@ -69,9 +70,6 @@ create_ns()
 	[ -z "${addr}" ] && addr="-"
 	[ -z "${addr6}" ] && addr6="-"
 
-	ip netns add ${ns}
-
-	ip netns exec ${ns} ip link set lo up
 	if [ "${addr}" != "-" ]; then
 		ip netns exec ${ns} ip addr add dev lo ${addr}
 	fi
@@ -160,12 +158,7 @@ connect_ns()
 
 cleanup_traceroute6()
 {
-	local ns
-
-	for ns in host-1 host-2 router-1 router-2
-	do
-		ip netns del ${ns} 2>/dev/null
-	done
+	cleanup_ns $h1 $h2 $r1 $r2
 }
 
 setup_traceroute6()
@@ -176,33 +169,34 @@ setup_traceroute6()
 	cleanup_traceroute6
 
 	set -e
-	create_ns host-1
-	create_ns host-2
-	create_ns router-1
-	create_ns router-2
+	setup_ns h1 h2 r1 r2
+	create_ns $h1
+	create_ns $h2
+	create_ns $r1
+	create_ns $r2
 
 	# Setup N3
-	connect_ns router-2 eth3 - 2000:103::2/64 host-2 eth3 - 2000:103::4/64
-	ip netns exec host-2 ip route add default via 2000:103::2
+	connect_ns $r2 eth3 - 2000:103::2/64 $h2 eth3 - 2000:103::4/64
+	ip netns exec $h2 ip route add default via 2000:103::2
 
 	# Setup N2
-	connect_ns router-1 eth2 - 2000:102::1/64 router-2 eth2 - 2000:102::2/64
-	ip netns exec router-1 ip route add default via 2000:102::2
+	connect_ns $r1 eth2 - 2000:102::1/64 $r2 eth2 - 2000:102::2/64
+	ip netns exec $r1 ip route add default via 2000:102::2
 
 	# Setup N1. host-1 and router-2 connect to a bridge in router-1.
-	ip netns exec router-1 ip link add name ${brdev} type bridge
-	ip netns exec router-1 ip link set ${brdev} up
-	ip netns exec router-1 ip addr add 2000:101::1/64 dev ${brdev}
+	ip netns exec $r1 ip link add name ${brdev} type bridge
+	ip netns exec $r1 ip link set ${brdev} up
+	ip netns exec $r1 ip addr add 2000:101::1/64 dev ${brdev}
 
-	connect_ns host-1 eth0 - 2000:101::3/64 router-1 eth0 - -
-	ip netns exec router-1 ip link set dev eth0 master ${brdev}
-	ip netns exec host-1 ip route add default via 2000:101::1
+	connect_ns $h1 eth0 - 2000:101::3/64 $r1 eth0 - -
+	ip netns exec $r1 ip link set dev eth0 master ${brdev}
+	ip netns exec $h1 ip route add default via 2000:101::1
 
-	connect_ns router-2 eth1 - 2000:101::2/64 router-1 eth1 - -
-	ip netns exec router-1 ip link set dev eth1 master ${brdev}
+	connect_ns $r2 eth1 - 2000:101::2/64 $r1 eth1 - -
+	ip netns exec $r1 ip link set dev eth1 master ${brdev}
 
 	# Prime the network
-	ip netns exec host-1 ping6 -c5 2000:103::4 >/dev/null 2>&1
+	ip netns exec $h1 ping6 -c5 2000:103::4 >/dev/null 2>&1
 
 	set +e
 }
@@ -217,7 +211,7 @@ run_traceroute6()
 	setup_traceroute6
 
 	# traceroute6 host-2 from host-1 (expects 2000:102::2)
-	run_cmd host-1 "traceroute6 2000:103::4 | grep -q 2000:102::2"
+	run_cmd $h1 "traceroute6 2000:103::4 | grep -q 2000:102::2"
 	log_test $? 0 "IPV6 traceroute"
 
 	cleanup_traceroute6
@@ -240,12 +234,7 @@ run_traceroute6()
 
 cleanup_traceroute()
 {
-	local ns
-
-	for ns in host-1 host-2 router
-	do
-		ip netns del ${ns} 2>/dev/null
-	done
+	cleanup_ns $h1 $h2 $router
 }
 
 setup_traceroute()
@@ -254,24 +243,25 @@ setup_traceroute()
 	cleanup_traceroute
 
 	set -e
-	create_ns host-1
-	create_ns host-2
-	create_ns router
+	setup_ns h1 h2 router
+	create_ns $h1
+	create_ns $h2
+	create_ns $router
 
-	connect_ns host-1 eth0 1.0.1.3/24 - \
-	           router eth1 1.0.3.1/24 -
-	ip netns exec host-1 ip route add default via 1.0.1.1
+	connect_ns $h1 eth0 1.0.1.3/24 - \
+	           $router eth1 1.0.3.1/24 -
+	ip netns exec $h1 ip route add default via 1.0.1.1
 
-	ip netns exec router ip addr add 1.0.1.1/24 dev eth1
-	ip netns exec router sysctl -qw \
+	ip netns exec $router ip addr add 1.0.1.1/24 dev eth1
+	ip netns exec $router sysctl -qw \
 				net.ipv4.icmp_errors_use_inbound_ifaddr=1
 
-	connect_ns host-2 eth0 1.0.2.4/24 - \
-	           router eth2 1.0.2.1/24 -
-	ip netns exec host-2 ip route add default via 1.0.2.1
+	connect_ns $h2 eth0 1.0.2.4/24 - \
+	           $router eth2 1.0.2.1/24 -
+	ip netns exec $h2 ip route add default via 1.0.2.1
 
 	# Prime the network
-	ip netns exec host-1 ping -c5 1.0.2.4 >/dev/null 2>&1
+	ip netns exec $h1 ping -c5 1.0.2.4 >/dev/null 2>&1
 
 	set +e
 }
@@ -286,7 +276,7 @@ run_traceroute()
 	setup_traceroute
 
 	# traceroute host-2 from host-1 (expects 1.0.1.1). Takes a while.
-	run_cmd host-1 "traceroute 1.0.2.4 | grep -q 1.0.1.1"
+	run_cmd $h1 "traceroute 1.0.2.4 | grep -q 1.0.1.1"
 	log_test $? 0 "IPV4 traceroute"
 
 	cleanup_traceroute
-- 
2.43.0


