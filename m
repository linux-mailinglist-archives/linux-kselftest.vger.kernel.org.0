Return-Path: <linux-kselftest+bounces-537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB57F6FD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC35B20F5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0523E16431;
	Fri, 24 Nov 2023 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHooGcja"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83650D7F;
	Fri, 24 Nov 2023 01:30:24 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ce627400f6so13031575ad.2;
        Fri, 24 Nov 2023 01:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818223; x=1701423023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Lckay/HtxJvYk20Sz6eHqjUTG4whsfccrg2IMN0yDM=;
        b=NHooGcja9Ilgxbmy6LpWRKqiTbKgV5AgoZmDai8kHwN9+hLwXX7OYSEEzTtiX4Tktp
         FJlNaL6/kU39DqDV4clJwXVN2sDyx/n8JwzY9U2FKBxBkmn0Fep2csR2/6Z3MitCJDQ5
         dgT1KUBJT1FcfyJODPS3o1GgmVpGwwOSPg3gV1AO/QheJvqjy1Cy4of7kluYHO06Osb/
         dylA/7ifdvEPpfu/fQ9P0gxyRd06phbcmSTnIk+vdmv1JdCIAgvgGWSFJJ9eJDtszAKk
         m3ZKRKU7kp3eNPhyjIxgYzY6toD4PwMq+/Jhaqsyxr4QJBzUpFRm/pQw84yKBQvx3fcS
         Uo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818223; x=1701423023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lckay/HtxJvYk20Sz6eHqjUTG4whsfccrg2IMN0yDM=;
        b=NM0Tr8T3gvTdH0oimedwRveWn8jZmfrb5VChA5cAQEZAtbN+gBAbfeuFiBlOFcJvmO
         Fy+k9s0jcvSdoi4VQVjitkRSiFtNfcRhUC23XQz/dIEo7pn8eM+k9H1bnoXmKIBWEUHV
         LWMaXAVd/ARQXTG0LOpxHxQtIjOFhOp2PPH2w2xTDC9QF8Pz9KvUP/f/UTX9LKdiuzAf
         bMYQyOH5uUEGg3Z47hp73sWttGMRPcdo4Q9eU9ny4IQ0CetrsGP4JxmCB1CS1eFKTx6f
         AZpl3MQEl+2X8daqxhpP2l8Qm8XlCOZsmsC4VAnpdzvaj7/Dkrd1OTs4/M+LPMLb5Xq9
         ALZw==
X-Gm-Message-State: AOJu0Yw4p9ZInKsVNusotZi5G7mIXGnZoLuMjE/OnXX2TH6QvoV8wRWH
	oXDhekPsy+rTLwB/kJFaUmQuLkQxh4c9//22
X-Google-Smtp-Source: AGHT+IElVB0vRQh/O6qlAcz/6+D6svgGa8Ed17kwPVZOC0PC22WjHFIGOnlfbYTrICvF/562QCaSYQ==
X-Received: by 2002:a17:903:2352:b0:1cf:636f:1c14 with SMTP id c18-20020a170903235200b001cf636f1c14mr2325379plh.0.1700818223198;
        Fri, 24 Nov 2023 01:30:23 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:30:22 -0800 (PST)
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
Subject: [PATCH net-next 35/38] selftests/net: convert vrf-xfrm-tests.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:33 +0800
Message-ID: <20231124092736.3673263-36-liuhangbin@gmail.com>
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
2.41.0


