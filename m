Return-Path: <linux-kselftest+bounces-1241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF270806800
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517B21F21737
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39A115499;
	Wed,  6 Dec 2023 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3oMv3fZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19BF1A2;
	Tue,  5 Dec 2023 23:08:49 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d9cab361e2so113153a34.3;
        Tue, 05 Dec 2023 23:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701846528; x=1702451328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJNeb4hLi5JuEpvemdX0ksowJqfCcN98+SBG8eQXQhw=;
        b=C3oMv3fZ7uXrcnCvA0rGViTKXDOyDfSN4K8YXsw2n7fAEayRzE+dZfczf9SDJWoRw5
         nOV7NKSIYlHy6w1rRZFCfRbggdlx8APkM5pH/Va8HKEZcnQDdgLmbgCBBRCHXQC12hqp
         vemtt/GgEuhYp/Co3LA6C3SMlsmPbGAVPbdSuRxbutC8IMykQ8z3VXJSepPA765RbK/d
         CJF2zQngibhoI36Xs1CYRXqbnhhNRfeSE4G5S130SfrJK7IAD0Am2LgtUbCXEjEGe41W
         EecqFlYBwEAc6pkdtSCpz9ME41pEk9l9+DdGLTnTNY6Gx8+wRMbK91EGw5ZSTLUdOHlD
         PW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846528; x=1702451328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJNeb4hLi5JuEpvemdX0ksowJqfCcN98+SBG8eQXQhw=;
        b=hQ8i6o7HYQrc8pvamHegQ97LntS6fbQefd3KApF5UFtdeyXNPfXP3OA/KuyzJRhqyS
         WkD9UBwHIKtb2YYnF4FU8i7qOWeSg07wOFi6ptTcVING1vLarahPsFvNJLDGq3AvP8N0
         aM/DhXjQ7CK2QafgUXCKSBB32FYhrOjaTrE8dH8NPobBGS3/68DCwmnyu1QfD5KnieVo
         mbwwfGUKZITl46OhucMY/tpR3cKpQLpixyBc/jZ440uU7z7wW+1XLamTyrLkHiKwOJrv
         vCQY5EY56AcZQM6r9K2gJ2fY+PKp5y9AkkUuvnpR/m2IqT9pKKc4vEZlxiYI7VNKFtS8
         65iw==
X-Gm-Message-State: AOJu0YzFHYQKnVqPkNdmDdfLu0n4PBvQaenpqBBlticxWf61P5c6hMDH
	CSaB27t08mvtJ2jJGvSiJb+3GUB7ceaA342I
X-Google-Smtp-Source: AGHT+IFiFG0+cHJj+dqcCm1VCgqBCg3dhT2xGdw19+eWagYoGhyCW0oNpuot9a2uWPlaN426g7f6Fw==
X-Received: by 2002:a05:6871:d10b:b0:1fb:75c:3fe8 with SMTP id pi11-20020a056871d10b00b001fb075c3fe8mr553747oac.72.1701846528501;
        Tue, 05 Dec 2023 23:08:48 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm10184212pgh.14.2023.12.05.23.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:08:48 -0800 (PST)
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
Subject: [PATCH net-next 9/9] selftests/net: convert vrf-xfrm-tests.sh to run it in unique namespace
Date: Wed,  6 Dec 2023 15:08:01 +0800
Message-ID: <20231206070801.1691247-10-liuhangbin@gmail.com>
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

]# ./vrf-xfrm-tests.sh

No qdisc on VRF device
TEST: IPv4 no xfrm policy                                           [ OK ]
TEST: IPv6 no xfrm policy                                           [ OK ]
TEST: IPv4 xfrm policy based on address                             [ OK ]
TEST: IPv6 xfrm policy based on address                             [ OK ]
TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
TEST: IPv4 xfrm policy with xfrm device                             [ OK ]
TEST: IPv6 xfrm policy with xfrm device                             [ OK ]

netem qdisc on VRF device
TEST: IPv4 no xfrm policy                                           [ OK ]
TEST: IPv6 no xfrm policy                                           [ OK ]
TEST: IPv4 xfrm policy based on address                             [ OK ]
TEST: IPv6 xfrm policy based on address                             [ OK ]
TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
TEST: IPv4 xfrm policy with xfrm device                             [ OK ]
TEST: IPv6 xfrm policy with xfrm device                             [ OK ]

Tests passed:  14
Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/vrf-xfrm-tests.sh | 77 +++++++++----------
 1 file changed, 36 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/net/vrf-xfrm-tests.sh b/tools/testing/selftests/net/vrf-xfrm-tests.sh
index 452638ae8aed..b64dd891699d 100755
--- a/tools/testing/selftests/net/vrf-xfrm-tests.sh
+++ b/tools/testing/selftests/net/vrf-xfrm-tests.sh
@@ -3,9 +3,7 @@
 #
 # Various combinations of VRF with xfrms and qdisc.
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
+source lib.sh
 PAUSE_ON_FAIL=no
 VERBOSE=0
 ret=0
@@ -67,7 +65,7 @@ run_cmd_host1()
 		printf "    COMMAND: $cmd\n"
 	fi
 
-	out=$(eval ip netns exec host1 $cmd 2>&1)
+	out=$(eval ip netns exec $host1 $cmd 2>&1)
 	rc=$?
 	if [ "$VERBOSE" = "1" ]; then
 		if [ -n "$out" ]; then
@@ -116,9 +114,6 @@ create_ns()
 	[ -z "${addr}" ] && addr="-"
 	[ -z "${addr6}" ] && addr6="-"
 
-	ip netns add ${ns}
-
-	ip -netns ${ns} link set lo up
 	if [ "${addr}" != "-" ]; then
 		ip -netns ${ns} addr add dev lo ${addr}
 	fi
@@ -177,25 +172,25 @@ connect_ns()
 
 cleanup()
 {
-	ip netns del host1
-	ip netns del host2
+	cleanup_ns $host1 $host2
 }
 
 setup()
 {
-	create_ns "host1"
-	create_ns "host2"
+	setup_ns host1 host2
+	create_ns "$host1"
+	create_ns "$host2"
 
-	connect_ns "host1" eth0 ${HOST1_4}/24 ${HOST1_6}/64 \
-	           "host2" eth0 ${HOST2_4}/24 ${HOST2_6}/64
+	connect_ns "$host1" eth0 ${HOST1_4}/24 ${HOST1_6}/64 \
+	           "$host2" eth0 ${HOST2_4}/24 ${HOST2_6}/64
 
-	create_vrf "host1" ${VRF} ${TABLE}
-	ip -netns host1 link set dev eth0 master ${VRF}
+	create_vrf "$host1" ${VRF} ${TABLE}
+	ip -netns $host1 link set dev eth0 master ${VRF}
 }
 
 cleanup_xfrm()
 {
-	for ns in host1 host2
+	for ns in $host1 $host2
 	do
 		for x in state policy
 		do
@@ -218,57 +213,57 @@ setup_xfrm()
 	#
 
 	# host1 - IPv4 out
-	ip -netns host1 xfrm policy add \
+	ip -netns $host1 xfrm policy add \
 	  src ${h1_4} dst ${h2_4} ${devarg} dir out \
 	  tmpl src ${HOST1_4} dst ${HOST2_4} proto esp mode tunnel
 
 	# host2 - IPv4 in
-	ip -netns host2 xfrm policy add \
+	ip -netns $host2 xfrm policy add \
 	  src ${h1_4} dst ${h2_4} dir in \
 	  tmpl src ${HOST1_4} dst ${HOST2_4} proto esp mode tunnel
 
 	# host1 - IPv4 in
-	ip -netns host1 xfrm policy add \
+	ip -netns $host1 xfrm policy add \
 	  src ${h2_4} dst ${h1_4} ${devarg} dir in \
 	  tmpl src ${HOST2_4} dst ${HOST1_4} proto esp mode tunnel
 
 	# host2 - IPv4 out
-	ip -netns host2 xfrm policy add \
+	ip -netns $host2 xfrm policy add \
 	  src ${h2_4} dst ${h1_4} dir out \
 	  tmpl src ${HOST2_4} dst ${HOST1_4} proto esp mode tunnel
 
 
 	# host1 - IPv6 out
-	ip -6 -netns host1 xfrm policy add \
+	ip -6 -netns $host1 xfrm policy add \
 	  src ${h1_6} dst ${h2_6} ${devarg} dir out \
 	  tmpl src ${HOST1_6} dst ${HOST2_6} proto esp mode tunnel
 
 	# host2 - IPv6 in
-	ip -6 -netns host2 xfrm policy add \
+	ip -6 -netns $host2 xfrm policy add \
 	  src ${h1_6} dst ${h2_6} dir in \
 	  tmpl src ${HOST1_6} dst ${HOST2_6} proto esp mode tunnel
 
 	# host1 - IPv6 in
-	ip -6 -netns host1 xfrm policy add \
+	ip -6 -netns $host1 xfrm policy add \
 	  src ${h2_6} dst ${h1_6} ${devarg} dir in \
 	  tmpl src ${HOST2_6} dst ${HOST1_6} proto esp mode tunnel
 
 	# host2 - IPv6 out
-	ip -6 -netns host2 xfrm policy add \
+	ip -6 -netns $host2 xfrm policy add \
 	  src ${h2_6} dst ${h1_6} dir out \
 	  tmpl src ${HOST2_6} dst ${HOST1_6} proto esp mode tunnel
 
 	#
 	# state
 	#
-	ip -netns host1 xfrm state add src ${HOST1_4} dst ${HOST2_4} \
+	ip -netns $host1 xfrm state add src ${HOST1_4} dst ${HOST2_4} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
 	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
 	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_4} dst ${h2_4} ${devarg}
 
-	ip -netns host2 xfrm state add src ${HOST1_4} dst ${HOST2_4} \
+	ip -netns $host2 xfrm state add src ${HOST1_4} dst ${HOST2_4} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
 	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
@@ -276,14 +271,14 @@ setup_xfrm()
 	    sel src ${h1_4} dst ${h2_4}
 
 
-	ip -netns host1 xfrm state add src ${HOST2_4} dst ${HOST1_4} \
+	ip -netns $host1 xfrm state add src ${HOST2_4} dst ${HOST1_4} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
 	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
 	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_4} dst ${h1_4} ${devarg}
 
-	ip -netns host2 xfrm state add src ${HOST2_4} dst ${HOST1_4} \
+	ip -netns $host2 xfrm state add src ${HOST2_4} dst ${HOST1_4} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
 	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
@@ -291,14 +286,14 @@ setup_xfrm()
 	    sel src ${h2_4} dst ${h1_4}
 
 
-	ip -6 -netns host1 xfrm state add src ${HOST1_6} dst ${HOST2_6} \
+	ip -6 -netns $host1 xfrm state add src ${HOST1_6} dst ${HOST2_6} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
 	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
 	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_6} dst ${h2_6} ${devarg}
 
-	ip -6 -netns host2 xfrm state add src ${HOST1_6} dst ${HOST2_6} \
+	ip -6 -netns $host2 xfrm state add src ${HOST1_6} dst ${HOST2_6} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
 	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
@@ -306,14 +301,14 @@ setup_xfrm()
 	    sel src ${h1_6} dst ${h2_6}
 
 
-	ip -6 -netns host1 xfrm state add src ${HOST2_6} dst ${HOST1_6} \
+	ip -6 -netns $host1 xfrm state add src ${HOST2_6} dst ${HOST1_6} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
 	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
 	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_6} dst ${h1_6} ${devarg}
 
-	ip -6 -netns host2 xfrm state add src ${HOST2_6} dst ${HOST1_6} \
+	ip -6 -netns $host2 xfrm state add src ${HOST2_6} dst ${HOST1_6} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
 	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
@@ -323,22 +318,22 @@ setup_xfrm()
 
 cleanup_xfrm_dev()
 {
-	ip -netns host1 li del xfrm0
-	ip -netns host2 addr del ${XFRM2_4}/24 dev eth0
-	ip -netns host2 addr del ${XFRM2_6}/64 dev eth0
+	ip -netns $host1 li del xfrm0
+	ip -netns $host2 addr del ${XFRM2_4}/24 dev eth0
+	ip -netns $host2 addr del ${XFRM2_6}/64 dev eth0
 }
 
 setup_xfrm_dev()
 {
 	local vrfarg="vrf ${VRF}"
 
-	ip -netns host1 li add type xfrm dev eth0 if_id ${IF_ID}
-	ip -netns host1 li set xfrm0 ${vrfarg} up
-	ip -netns host1 addr add ${XFRM1_4}/24 dev xfrm0
-	ip -netns host1 addr add ${XFRM1_6}/64 dev xfrm0
+	ip -netns $host1 li add type xfrm dev eth0 if_id ${IF_ID}
+	ip -netns $host1 li set xfrm0 ${vrfarg} up
+	ip -netns $host1 addr add ${XFRM1_4}/24 dev xfrm0
+	ip -netns $host1 addr add ${XFRM1_6}/64 dev xfrm0
 
-	ip -netns host2 addr add ${XFRM2_4}/24 dev eth0
-	ip -netns host2 addr add ${XFRM2_6}/64 dev eth0
+	ip -netns $host2 addr add ${XFRM2_4}/24 dev eth0
+	ip -netns $host2 addr add ${XFRM2_6}/64 dev eth0
 
 	setup_xfrm ${XFRM1_4} ${XFRM2_4} ${XFRM1_6} ${XFRM2_6} "if_id ${IF_ID}"
 }
-- 
2.43.0


