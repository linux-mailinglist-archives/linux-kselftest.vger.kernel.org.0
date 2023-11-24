Return-Path: <linux-kselftest+bounces-519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B36F7F6FA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE061F20EFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED27156EB;
	Fri, 24 Nov 2023 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHLbIt8S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDA2D7F;
	Fri, 24 Nov 2023 01:29:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cf7a8ab047so13118875ad.1;
        Fri, 24 Nov 2023 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818147; x=1701422947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVqTF4YVunxLi6GR/e/TAK555giTbUIWEnhH2wGJuSk=;
        b=kHLbIt8SzZIHmT+cUstBpjF3vKrkBnoyZRN9n4aA0yMWjCWAxxkwwYyKzdzEKLZWMK
         9qqtnge8IPKHvKOcR7ahFbucreTl5gBiw9qF7JtP8RtK933eLjhYYayvFkR177nueBRg
         7XfK6ScR6DFBUtfKtfJoCy+/cKOV/6fVm6tC0eYCuxgbVAiJIiIPNQNSCzR2UmRQa3gx
         LCkPbtCAm3L6bH/BpdQswcl71tLT0rbWc9BIWDn0ug0CZUnjIIj/tqDmA0SR5DzaIEnr
         Xdt+KZDkeKeyFRNf6JwwPjPhZPv52sV/pXb3Ua4uILA8btO2hlapdvrLMdv3hyVZB9pr
         4oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818147; x=1701422947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVqTF4YVunxLi6GR/e/TAK555giTbUIWEnhH2wGJuSk=;
        b=REcLHCf2OCT2i9MSbolSGLNFFq8W6kdl8mm39RJkU/IT2Yl2y8TtK2yY773gl1YFpo
         pSpSDe1zNArCK2CTZZF3Gqij+xN6XIZKeID6NXNwh2TDwpjBD+sJ4yATf4xRAQrNpo/J
         3KZqy18BOAp4LTO2IZObcXWNh4DYgnq3VeDh0Wk7a0sGlLKd3fTv8/jmh/eyaIVh9lG1
         DR9UiczHGX5b3vVChnwzvQW9bxF2RkDtWrfAypA4NPWg5weFYXqIpwbCupftWDXclQwG
         O57/78jWgZiBUk70pgjgPmpaqU7dkVgyZwSF3n8glxNZODFOo9RRmwLojpIDOhtpoNyY
         1ijA==
X-Gm-Message-State: AOJu0YwrbXtI7e5FLTbiGk+0Qt8hlcwdQmuTPkxeIzq84dt8ymTefjYb
	Vvzk8olCUkWCDilBzmzPYGx+seDORXpmOiYY
X-Google-Smtp-Source: AGHT+IGcDgmG2QLzZW9IkywKH5MeLNTNyfxu61R/Qjar80/7WSBq7XJF+0NGmhArPQZCas+dvwpynQ==
X-Received: by 2002:a17:903:22c7:b0:1c8:9d32:339e with SMTP id y7-20020a17090322c700b001c89d32339emr1867147plg.50.1700818146612;
        Fri, 24 Nov 2023 01:29:06 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:06 -0800 (PST)
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
Subject: [PATCH net-next 17/38] selftests/net: convert l2tp.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:15 +0800
Message-ID: <20231124092736.3673263-18-liuhangbin@gmail.com>
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
2.41.0


