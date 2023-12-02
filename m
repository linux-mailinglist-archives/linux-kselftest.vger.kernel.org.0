Return-Path: <linux-kselftest+bounces-1014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B8B8019DC
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBEC1C20BFE
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306107495;
	Sat,  2 Dec 2023 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxKAyEnb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3FF9D;
	Fri,  1 Dec 2023 18:02:12 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35cb61de347so9535445ab.1;
        Fri, 01 Dec 2023 18:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482531; x=1702087331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EOjmtVrxuzi2crkh2MK85UXJun0XPKP0WVErSFOfaE=;
        b=AxKAyEnbUUvrFH6ag18g1m7fRG6gB1MGWnCkxCGPB6qmSf3uQ9+6E+jylcjEA/5X3c
         DLVnZWzgcVCJEubOV1UHpQDPu7qYZiCMXUzcSOyUFXcglOoUqMd1opw0xjyO9Z6LZ8Rc
         FjNqUHX/Er0bCQRL0IlW6mpePkpagjsiciQP0fUJ5p4gI3zsIjnlfwbB7TkHyZ9lJia2
         NMOWdPm5eQvKtRBPlBokB2enw0f9uKTo6hTvDRrRA6m55osnVzB9cBTUQlXkokbD2Jnf
         Gsz7Gws/pXBCeg0uNG6DBd053UZOpoNXP82EqIYppmhXiENS+ZEfIxmX/toA1JT3dxXH
         aEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482531; x=1702087331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EOjmtVrxuzi2crkh2MK85UXJun0XPKP0WVErSFOfaE=;
        b=FS7S9LIE6oT0x364+rEvWc+ean8uw6Gh9DfVO1O/PaokrQCtZNxloEXppKjg5yEI0l
         V8k40vcAvZM2uouTA1s8yWNgec4UGd5cDS4tLQtuzLfw1TxJ+kHFoOVtrNoBOL2rZuQr
         gIS4dTGS1q2FuzpxiYf/Z/5McFtuoui7/E8bTAvLu8y0fUGvswAt6e1kAjVYpdtMRW4g
         ZxWQWjeQn6AS3jO2xcSz//W+K7KvvrceIjlpu5EoM4IPY7NAPy/qBx4jLv4nnNH+xNvy
         ro4QTrmZZ2zwFKSl6HkPiCLjZ9QJ6FRNU1bS0jvA9hi2wh4+LFuwTw8cA6GIxkXUBCDL
         TJ9w==
X-Gm-Message-State: AOJu0Ywho6+h2unYwdU6mA8TyPkIfaZwlm/b9g6ZIojD/gEr8Q6zboDt
	knb2u8Od4mcAWQUYUXcEAAhmE6N7by/O70r2
X-Google-Smtp-Source: AGHT+IElaN+NQe2uzgiAjSSbbQ01W5Vb2URmyU/KHDig5uzZKTJZdZg8cASdzHJ9e+40oOPlLnnqNQ==
X-Received: by 2002:a05:6e02:f52:b0:35d:5895:1d1b with SMTP id y18-20020a056e020f5200b0035d58951d1bmr606302ilj.24.1701482530941;
        Fri, 01 Dec 2023 18:02:10 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:02:10 -0800 (PST)
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
Subject: [PATCHv3 net-next 11/14] selftests/net: convert l2tp.sh to run it in unique namespace
Date: Sat,  2 Dec 2023 10:01:07 +0800
Message-ID: <20231202020110.362433-12-liuhangbin@gmail.com>
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

]# ./l2tp.sh
TEST: IPv4 basic L2TP tunnel                                        [ OK ]
TEST: IPv4 route through L2TP tunnel                                [ OK ]
TEST: IPv6 basic L2TP tunnel                                        [ OK ]
TEST: IPv6 route through L2TP tunnel                                [ OK ]
TEST: IPv4 basic L2TP tunnel - with IPsec                           [ OK ]
TEST: IPv4 route through L2TP tunnel - with IPsec                   [ OK ]
TEST: IPv6 basic L2TP tunnel - with IPsec                           [ OK ]
TEST: IPv6 route through L2TP tunnel - with IPsec                   [ OK ]
TEST: IPv4 basic L2TP tunnel                                        [ OK ]
TEST: IPv4 route through L2TP tunnel                                [ OK ]
TEST: IPv6 basic L2TP tunnel - with IPsec                           [ OK ]
TEST: IPv6 route through L2TP tunnel - with IPsec                   [ OK ]
TEST: IPv4 basic L2TP tunnel - after IPsec teardown                 [ OK ]
TEST: IPv4 route through L2TP tunnel - after IPsec teardown         [ OK ]
TEST: IPv6 basic L2TP tunnel - after IPsec teardown                 [ OK ]
TEST: IPv6 route through L2TP tunnel - after IPsec teardown         [ OK ]

Tests passed:  16
Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Reviewed-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/l2tp.sh | 130 +++++++++++++---------------
 1 file changed, 62 insertions(+), 68 deletions(-)

diff --git a/tools/testing/selftests/net/l2tp.sh b/tools/testing/selftests/net/l2tp.sh
index 5782433886fc..88de7166c8ae 100755
--- a/tools/testing/selftests/net/l2tp.sh
+++ b/tools/testing/selftests/net/l2tp.sh
@@ -13,6 +13,7 @@
 #                10.1.1.1    |            |   10.1.2.1
 #              2001:db8:1::1 |            | 2001:db8:2::1
 
+source lib.sh
 VERBOSE=0
 PAUSE_ON_FAIL=no
 
@@ -80,9 +81,6 @@ create_ns()
 	[ -z "${addr}" ] && addr="-"
 	[ -z "${addr6}" ] && addr6="-"
 
-	ip netns add ${ns}
-
-	ip -netns ${ns} link set lo up
 	if [ "${addr}" != "-" ]; then
 		ip -netns ${ns} addr add dev lo ${addr}
 	fi
@@ -133,12 +131,7 @@ connect_ns()
 
 cleanup()
 {
-	local ns
-
-	for ns in host-1 host-2 router
-	do
-		ip netns del ${ns} 2>/dev/null
-	done
+	cleanup_ns $host_1 $host_2 $router
 }
 
 setup_l2tp_ipv4()
@@ -146,28 +139,28 @@ setup_l2tp_ipv4()
 	#
 	# configure l2tpv3 tunnel on host-1
 	#
-	ip -netns host-1 l2tp add tunnel tunnel_id 1041 peer_tunnel_id 1042 \
+	ip -netns $host_1 l2tp add tunnel tunnel_id 1041 peer_tunnel_id 1042 \
 			 encap ip local 10.1.1.1 remote 10.1.2.1
-	ip -netns host-1 l2tp add session name l2tp4 tunnel_id 1041 \
+	ip -netns $host_1 l2tp add session name l2tp4 tunnel_id 1041 \
 			 session_id 1041 peer_session_id 1042
-	ip -netns host-1 link set dev l2tp4 up
-	ip -netns host-1 addr add dev l2tp4 172.16.1.1 peer 172.16.1.2
+	ip -netns $host_1 link set dev l2tp4 up
+	ip -netns $host_1 addr add dev l2tp4 172.16.1.1 peer 172.16.1.2
 
 	#
 	# configure l2tpv3 tunnel on host-2
 	#
-	ip -netns host-2 l2tp add tunnel tunnel_id 1042 peer_tunnel_id 1041 \
+	ip -netns $host_2 l2tp add tunnel tunnel_id 1042 peer_tunnel_id 1041 \
 			 encap ip local 10.1.2.1 remote 10.1.1.1
-	ip -netns host-2 l2tp add session name l2tp4 tunnel_id 1042 \
+	ip -netns $host_2 l2tp add session name l2tp4 tunnel_id 1042 \
 			 session_id 1042 peer_session_id 1041
-	ip -netns host-2 link set dev l2tp4 up
-	ip -netns host-2 addr add dev l2tp4 172.16.1.2 peer 172.16.1.1
+	ip -netns $host_2 link set dev l2tp4 up
+	ip -netns $host_2 addr add dev l2tp4 172.16.1.2 peer 172.16.1.1
 
 	#
 	# add routes to loopback addresses
 	#
-	ip -netns host-1 ro add 172.16.101.2/32 via 172.16.1.2
-	ip -netns host-2 ro add 172.16.101.1/32 via 172.16.1.1
+	ip -netns $host_1 ro add 172.16.101.2/32 via 172.16.1.2
+	ip -netns $host_2 ro add 172.16.101.1/32 via 172.16.1.1
 }
 
 setup_l2tp_ipv6()
@@ -175,28 +168,28 @@ setup_l2tp_ipv6()
 	#
 	# configure l2tpv3 tunnel on host-1
 	#
-	ip -netns host-1 l2tp add tunnel tunnel_id 1061 peer_tunnel_id 1062 \
+	ip -netns $host_1 l2tp add tunnel tunnel_id 1061 peer_tunnel_id 1062 \
 			 encap ip local 2001:db8:1::1 remote 2001:db8:2::1
-	ip -netns host-1 l2tp add session name l2tp6 tunnel_id 1061 \
+	ip -netns $host_1 l2tp add session name l2tp6 tunnel_id 1061 \
 			 session_id 1061 peer_session_id 1062
-	ip -netns host-1 link set dev l2tp6 up
-	ip -netns host-1 addr add dev l2tp6 fc00:1::1 peer fc00:1::2
+	ip -netns $host_1 link set dev l2tp6 up
+	ip -netns $host_1 addr add dev l2tp6 fc00:1::1 peer fc00:1::2
 
 	#
 	# configure l2tpv3 tunnel on host-2
 	#
-	ip -netns host-2 l2tp add tunnel tunnel_id 1062 peer_tunnel_id 1061 \
+	ip -netns $host_2 l2tp add tunnel tunnel_id 1062 peer_tunnel_id 1061 \
 			 encap ip local 2001:db8:2::1 remote 2001:db8:1::1
-	ip -netns host-2 l2tp add session name l2tp6 tunnel_id 1062 \
+	ip -netns $host_2 l2tp add session name l2tp6 tunnel_id 1062 \
 			 session_id 1062 peer_session_id 1061
-	ip -netns host-2 link set dev l2tp6 up
-	ip -netns host-2 addr add dev l2tp6 fc00:1::2 peer fc00:1::1
+	ip -netns $host_2 link set dev l2tp6 up
+	ip -netns $host_2 addr add dev l2tp6 fc00:1::2 peer fc00:1::1
 
 	#
 	# add routes to loopback addresses
 	#
-	ip -netns host-1 -6 ro add fc00:101::2/128 via fc00:1::2
-	ip -netns host-2 -6 ro add fc00:101::1/128 via fc00:1::1
+	ip -netns $host_1 -6 ro add fc00:101::2/128 via fc00:1::2
+	ip -netns $host_2 -6 ro add fc00:101::1/128 via fc00:1::1
 }
 
 setup()
@@ -205,21 +198,22 @@ setup()
 	cleanup
 
 	set -e
-	create_ns host-1 172.16.101.1/32 fc00:101::1/128
-	create_ns host-2 172.16.101.2/32 fc00:101::2/128
-	create_ns router
+	setup_ns host_1 host_2 router
+	create_ns $host_1 172.16.101.1/32 fc00:101::1/128
+	create_ns $host_2 172.16.101.2/32 fc00:101::2/128
+	create_ns $router
 
-	connect_ns host-1 eth0 10.1.1.1/24 2001:db8:1::1/64 \
-	           router eth1 10.1.1.2/24 2001:db8:1::2/64
+	connect_ns $host_1 eth0 10.1.1.1/24 2001:db8:1::1/64 \
+	           $router eth1 10.1.1.2/24 2001:db8:1::2/64
 
-	connect_ns host-2 eth0 10.1.2.1/24 2001:db8:2::1/64 \
-	           router eth2 10.1.2.2/24 2001:db8:2::2/64
+	connect_ns $host_2 eth0 10.1.2.1/24 2001:db8:2::1/64 \
+	           $router eth2 10.1.2.2/24 2001:db8:2::2/64
 
-	ip -netns host-1 ro add 10.1.2.0/24 via 10.1.1.2
-	ip -netns host-1 -6 ro add 2001:db8:2::/64 via 2001:db8:1::2
+	ip -netns $host_1 ro add 10.1.2.0/24 via 10.1.1.2
+	ip -netns $host_1 -6 ro add 2001:db8:2::/64 via 2001:db8:1::2
 
-	ip -netns host-2 ro add 10.1.1.0/24 via 10.1.2.2
-	ip -netns host-2 -6 ro add 2001:db8:1::/64 via 2001:db8:2::2
+	ip -netns $host_2 ro add 10.1.1.0/24 via 10.1.2.2
+	ip -netns $host_2 -6 ro add 2001:db8:1::/64 via 2001:db8:2::2
 
 	setup_l2tp_ipv4
 	setup_l2tp_ipv6
@@ -231,38 +225,38 @@ setup_ipsec()
 	#
 	# IPv4
 	#
-	run_cmd host-1 ip xfrm policy add \
+	run_cmd $host_1 ip xfrm policy add \
 		src 10.1.1.1 dst 10.1.2.1 dir out \
 		tmpl proto esp mode transport
 
-	run_cmd host-1 ip xfrm policy add \
+	run_cmd $host_1 ip xfrm policy add \
 		src 10.1.2.1 dst 10.1.1.1 dir in \
 		tmpl proto esp mode transport
 
-	run_cmd host-2 ip xfrm policy add \
+	run_cmd $host_2 ip xfrm policy add \
 		src 10.1.1.1 dst 10.1.2.1 dir in \
 		tmpl proto esp mode transport
 
-	run_cmd host-2 ip xfrm policy add \
+	run_cmd $host_2 ip xfrm policy add \
 		src 10.1.2.1 dst 10.1.1.1 dir out \
 		tmpl proto esp mode transport
 
-	ip -netns host-1 xfrm state add \
+	ip -netns $host_1 xfrm state add \
 		src 10.1.1.1 dst 10.1.2.1 \
 		spi 0x1000 proto esp aead 'rfc4106(gcm(aes))' \
 		0x0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f 128 mode transport
 
-	ip -netns host-1 xfrm state add \
+	ip -netns $host_1 xfrm state add \
 		src 10.1.2.1 dst 10.1.1.1 \
 		spi 0x1001 proto esp aead 'rfc4106(gcm(aes))' \
 		0x0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f 128 mode transport
 
-	ip -netns host-2 xfrm state add \
+	ip -netns $host_2 xfrm state add \
 		src 10.1.1.1 dst 10.1.2.1 \
 		spi 0x1000 proto esp aead 'rfc4106(gcm(aes))' \
 		0x0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f 128 mode transport
 
-	ip -netns host-2 xfrm state add \
+	ip -netns $host_2 xfrm state add \
 		src 10.1.2.1 dst 10.1.1.1 \
 		spi 0x1001 proto esp aead 'rfc4106(gcm(aes))' \
 		0x0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f 128 mode transport
@@ -270,38 +264,38 @@ setup_ipsec()
 	#
 	# IPV6
 	#
-	run_cmd host-1 ip -6 xfrm policy add \
+	run_cmd $host_1 ip -6 xfrm policy add \
 		src 2001:db8:1::1 dst 2001:db8:2::1 dir out \
 		tmpl proto esp mode transport
 
-	run_cmd host-1 ip -6 xfrm policy add \
+	run_cmd $host_1 ip -6 xfrm policy add \
 		src 2001:db8:2::1 dst 2001:db8:1::1 dir in \
 		tmpl proto esp mode transport
 
-	run_cmd host-2 ip -6 xfrm policy add \
+	run_cmd $host_2 ip -6 xfrm policy add \
 		src 2001:db8:1::1 dst 2001:db8:2::1 dir in \
 		tmpl proto esp mode transport
 
-	run_cmd host-2 ip -6 xfrm policy add \
+	run_cmd $host_2 ip -6 xfrm policy add \
 		src 2001:db8:2::1 dst 2001:db8:1::1 dir out \
 		tmpl proto esp mode transport
 
-	ip -netns host-1 -6 xfrm state add \
+	ip -netns $host_1 -6 xfrm state add \
 		src 2001:db8:1::1 dst 2001:db8:2::1 \
 		spi 0x1000 proto esp aead 'rfc4106(gcm(aes))' \
 		0x0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f 128 mode transport
 
-	ip -netns host-1 -6 xfrm state add \
+	ip -netns $host_1 -6 xfrm state add \
 		src 2001:db8:2::1 dst 2001:db8:1::1 \
 		spi 0x1001 proto esp aead 'rfc4106(gcm(aes))' \
 		0x0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f 128 mode transport
 
-	ip -netns host-2 -6 xfrm state add \
+	ip -netns $host_2 -6 xfrm state add \
 		src 2001:db8:1::1 dst 2001:db8:2::1 \
 		spi 0x1000 proto esp aead 'rfc4106(gcm(aes))' \
 		0x0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f 128 mode transport
 
-	ip -netns host-2 -6 xfrm state add \
+	ip -netns $host_2 -6 xfrm state add \
 		src 2001:db8:2::1 dst 2001:db8:1::1 \
 		spi 0x1001 proto esp aead 'rfc4106(gcm(aes))' \
 		0x0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f 128 mode transport
@@ -309,10 +303,10 @@ setup_ipsec()
 
 teardown_ipsec()
 {
-	run_cmd host-1 ip xfrm state flush
-	run_cmd host-1 ip xfrm policy flush
-	run_cmd host-2 ip xfrm state flush
-	run_cmd host-2 ip xfrm policy flush
+	run_cmd $host_1 ip xfrm state flush
+	run_cmd $host_1 ip xfrm policy flush
+	run_cmd $host_2 ip xfrm state flush
+	run_cmd $host_2 ip xfrm policy flush
 }
 
 ################################################################################
@@ -322,16 +316,16 @@ run_ping()
 {
 	local desc="$1"
 
-	run_cmd host-1 ping -c1 -w1 172.16.1.2
+	run_cmd $host_1 ping -c1 -w1 172.16.1.2
 	log_test $? 0 "IPv4 basic L2TP tunnel ${desc}"
 
-	run_cmd host-1 ping -c1 -w1 -I 172.16.101.1 172.16.101.2
+	run_cmd $host_1 ping -c1 -w1 -I 172.16.101.1 172.16.101.2
 	log_test $? 0 "IPv4 route through L2TP tunnel ${desc}"
 
-	run_cmd host-1 ${ping6} -c1 -w1 fc00:1::2
+	run_cmd $host_1 ${ping6} -c1 -w1 fc00:1::2
 	log_test $? 0 "IPv6 basic L2TP tunnel ${desc}"
 
-	run_cmd host-1 ${ping6} -c1 -w1 -I fc00:101::1 fc00:101::2
+	run_cmd $host_1 ${ping6} -c1 -w1 -I fc00:101::1 fc00:101::2
 	log_test $? 0 "IPv6 route through L2TP tunnel ${desc}"
 }
 
@@ -344,16 +338,16 @@ run_tests()
 
 	setup_ipsec
 	run_ping "- with IPsec"
-	run_cmd host-1 ping -c1 -w1 172.16.1.2
+	run_cmd $host_1 ping -c1 -w1 172.16.1.2
 	log_test $? 0 "IPv4 basic L2TP tunnel ${desc}"
 
-	run_cmd host-1 ping -c1 -w1 -I 172.16.101.1 172.16.101.2
+	run_cmd $host_1 ping -c1 -w1 -I 172.16.101.1 172.16.101.2
 	log_test $? 0 "IPv4 route through L2TP tunnel ${desc}"
 
-	run_cmd host-1 ${ping6} -c1 -w1 fc00:1::2
+	run_cmd $host_1 ${ping6} -c1 -w1 fc00:1::2
 	log_test $? 0 "IPv6 basic L2TP tunnel - with IPsec"
 
-	run_cmd host-1 ${ping6} -c1 -w1 -I fc00:101::1 fc00:101::2
+	run_cmd $host_1 ${ping6} -c1 -w1 -I fc00:101::1 fc00:101::2
 	log_test $? 0 "IPv6 route through L2TP tunnel - with IPsec"
 
 	teardown_ipsec
-- 
2.43.0


