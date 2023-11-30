Return-Path: <linux-kselftest+bounces-873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F97FE809
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740091C20E60
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C58154BF;
	Thu, 30 Nov 2023 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WECQ0Zhj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1530B10CB;
	Wed, 29 Nov 2023 20:02:08 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d84ddd642fso327263a34.0;
        Wed, 29 Nov 2023 20:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316927; x=1701921727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+snsdkeFNTrHHlU7siXlQO8lyLNwfSOi5ZFQJu7MSnE=;
        b=WECQ0ZhjwXBIMFR8zgiu183CUO4w3z6AAGbvwlfrsFezRVgKknHjkZZBivnloYGl4e
         gS/ihOM/vMGKdJ+ZsvOPOmv0OuGc66oBO8k8SDEhMVO3GjnfSiOtozf+s1oN7MV2Vapm
         GARlF5j40p2XxKIBrY+sr9bQUl0blg545c5LRH4p+SXMj3lRFG6nZsauWHklsBrDM8KE
         5/e5x111PsdtjmUVZLG0iSmzCE9wS20WhkeiR8jpDznDUH8nGWIH60rgASu9bnHSSeho
         J2IbgkRLQbZ0tGl9nElkJeseeOeCxgpsCUPukpt4hGNbnOM6ISTOOogh5hqo9EfI3JGv
         N+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316927; x=1701921727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+snsdkeFNTrHHlU7siXlQO8lyLNwfSOi5ZFQJu7MSnE=;
        b=kCDUEKSJrRfRj1iEHt2QjWV90Xyz8bo3J5voob7WVJGVeTpRVXO9U5o2g0mnBYCjCL
         W1/TlHqnUrwDgN8bfyC/1j3NhT5hc2i5OtlcQDZOZJkKtYpeBOIfmsScIK+5xVNq8WB1
         iHyjqAHmdGaIXbPMnkVmk/SuRjFAH3yd8hwqPbTGpxjTispyFUxzZUYqaRIgvzZ5b+Zj
         wYDnQfiIAu2wqWQ6bfGbQMAryGXB7Xh7WTUGKDl6Ww+26MRoPDYd3tS3RuJkU5W5xRAL
         KlN19+tl3TVZwudgwTDw7cf5d626L27k6jOK+YJzWmoArMceyE9+0QtRzJz+9o5hqvB3
         pslQ==
X-Gm-Message-State: AOJu0YzO3D26BU8Bcf9HHYjTnuYw2pAks3TTpueinCpN+Xvfv1eAXcUn
	mTDKFs94E7gx2lxp55Xmrd3XkIAsVW+PCg==
X-Google-Smtp-Source: AGHT+IF73sBji6NyOHndkkaZSZz5U+2iR3Se148x4RkdASNf6Gb5rQHWHlCEvgUbIrJJ8cFtg2VQfA==
X-Received: by 2002:a05:6870:9f08:b0:1fa:1738:85dd with SMTP id xl8-20020a0568709f0800b001fa173885ddmr21807441oab.57.1701316926879;
        Wed, 29 Nov 2023 20:02:06 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:02:06 -0800 (PST)
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
Subject: [PATCHv2 net-next 11/14] selftests/net: convert l2tp.sh to run it in unique namespace
Date: Thu, 30 Nov 2023 12:01:02 +0800
Message-ID: <20231130040105.1265779-12-liuhangbin@gmail.com>
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


