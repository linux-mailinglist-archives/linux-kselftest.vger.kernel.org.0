Return-Path: <linux-kselftest+bounces-538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5467F6FD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129BC281C36
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28A61772D;
	Fri, 24 Nov 2023 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTTxFE8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8775BD7E;
	Fri, 24 Nov 2023 01:30:28 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfa71b6029so1505475ad.1;
        Fri, 24 Nov 2023 01:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818227; x=1701423027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lICGImIE5QPzZcV5jTeHNXXYF+F46SMqD6db1vLgX20=;
        b=BTTxFE8yRSu7PjK1Qmbs0GquP3lheKAHHmRfUiKUUZz9UJOKx0oi7UR9I8VVDnHuuC
         O7btNLsGEycrsnfw6BljnhwMfVQl5jPL1pel1IDo8y06zOAi+H4IgaUNlZ1AxWzrv6R7
         t/GyMk5rVbAvtpGAYeGZRE8yqRRZCsfhCgRyTReUjXUKcumu8qwHkQXPphBtb4KEo4Lb
         yduPS7kNi+/qe7K/sadlWouUpV027QP2t5j7PWvD3J6DHoKu2qRS6V6QlIw2kLweOu5u
         tkQ7g7Ky17+oJ3G9DTql32Z9a5aa2EIr+7idGdo4KY2Tq/Gq7YXLoZkJ363/ho29aq6e
         /6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818227; x=1701423027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lICGImIE5QPzZcV5jTeHNXXYF+F46SMqD6db1vLgX20=;
        b=gwbsoSR3qDbvlf4gJP9nG7SLkXBgG+0HMd5CnH4lWK8xsDyRFXEX0yELHna2bsl21O
         +4wojysXbA4zzSL96Qo/HV86pZFzke92mD5vGHcaAEvlCS/aOqoV/BtRU6h5lh2vvi4S
         6qRuLQHuJDM7wMour23TERO7ksMsE7DF1OZvQqwvx4WfudxdCFP44ezx8p5xPEBTZiRO
         YB7qD8fVJx6/CpaIBkxfTZE9GL2vOFA7YDsjwJ06FsS2AuGAbJwmKERtNS2HEOhykMzQ
         8t/XfG1tVG0P8FPvVpl1qkk3CRILSm6a0pt1WTzz//fIIWosveDrvHQMq3NlOyvJz/VU
         xkQQ==
X-Gm-Message-State: AOJu0YwEZbPh8KV8bpSpUsAuZG5yOKYOg59+Lgetyrwhfwj4pDU9BlqD
	ihW/DAxfIPMV4E8PEl7dbgP7hCQg5rEgi6bo
X-Google-Smtp-Source: AGHT+IGsDzikwLLnc4OLlkR8SQCGFlkswo6PGasZMHx938Pnhs3QHHiVZkPSEnV6W2pKQKjEdNyDhQ==
X-Received: by 2002:a17:903:2303:b0:1cf:9400:d840 with SMTP id d3-20020a170903230300b001cf9400d840mr2134441plh.52.1700818227601;
        Fri, 24 Nov 2023 01:30:27 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:30:26 -0800 (PST)
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
Subject: [PATCH net-next 36/38] selftests/net: convert traceroute.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:34 +0800
Message-ID: <20231124092736.3673263-37-liuhangbin@gmail.com>
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

]# ./traceroute.sh
TEST: IPV6 traceroute                                               [ OK ]
TEST: IPV4 traceroute                                               [ OK ]

Tests passed:   2
Tests failed:   0

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
2.41.0


