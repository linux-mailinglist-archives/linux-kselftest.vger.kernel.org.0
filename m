Return-Path: <linux-kselftest+bounces-518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E447F6FA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2121F20ED2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C647C14F8F;
	Fri, 24 Nov 2023 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8RWT4Hb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D306D72;
	Fri, 24 Nov 2023 01:29:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfaaa79766so635665ad.3;
        Fri, 24 Nov 2023 01:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818142; x=1701422942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amArwxxrzmtfVm4bGr68TTYOGSTObdfgy46qG455eG0=;
        b=U8RWT4HbBhGnPy0YHt3f3Nh44v8b3XfhJ+jfBqQs6V8lzfFRweGSlojxw/dLBpYGZb
         IsAI7GRQI9p8g4jYhyNMAuj532OuJRq27itoSI5QAix9/IMZ23eAkgYJdbbuAquZG0Pu
         i8ds3tlj6uexOeZJmjm8/ZLCWgj7jElZi4U7ebbaTahx9vh9PxqBBCRIhZpdWnl+KNN2
         dB1vgU4t4dtOqDOLYCJ5WuMMAtwynLyS5lf7npnb3RDdEOb0I3Wt5/6DdxK8fixwwZDh
         BRV9TAOw7H3aD8jrazyE+kMFEdEn0U8LdT9Y/1t6wSrDMb7oSIWj3jL6YIQ4SYjFYPBd
         3lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818142; x=1701422942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amArwxxrzmtfVm4bGr68TTYOGSTObdfgy46qG455eG0=;
        b=XK5fLdekkWy8NXSagvVCXSL3hDzhUTk1LEOKTjWlRCPHNAjogunz7JvCOdGPZ2YMuc
         j9xj2KtFH6dU1TxEAZyk9zcbuS8602rPlCW7j6L8lggigB1vnBxqZKlIrYvwuCVEgaK3
         b/JQ4bk40D3I5Inv4lsvas4RKUzSvVOE1c0lI8XRUt7N8Oq1fDTJB2tVM+VloAbz/Xpr
         5ONR4g84g0ogfa1DA6F+sutLLj9zpiv89D36+LHZl48QKt33qepe7dc2zCcpZP6yrS5w
         bdoybhfKNrPI1LC3pXb3uKCoRIIxJcrNDvi4hhtaJ39mZarH/FswFeH76NlZrfMcopkn
         hJdQ==
X-Gm-Message-State: AOJu0YwII7lXT5NozlHByrUZAjPu0IkzRYCJ0+TRWnlPon0vC34FBwW2
	yRDsZX2fVhDRr1kMjn0rQLIfleC7RNtl5vT2
X-Google-Smtp-Source: AGHT+IHVncfDgRkryhRxf7v6dgVOiDgnvBXO8AphrGxRbhw7YJ26IFI+lrTv5KnG+Ze+fINJAAiDnA==
X-Received: by 2002:a17:902:bb8c:b0:1cc:5ed4:7b4c with SMTP id m12-20020a170902bb8c00b001cc5ed47b4cmr2032685pls.35.1700818142343;
        Fri, 24 Nov 2023 01:29:02 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:01 -0800 (PST)
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
Subject: [PATCH net-next 16/38] selftests/net: convert ioam6.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:14 +0800
Message-ID: <20231124092736.3673263-17-liuhangbin@gmail.com>
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

]# ./ioam6.sh

--------------------------------------------------------------------------
OUTPUT tests
--------------------------------------------------------------------------
TEST: Unknown IOAM namespace (inline mode)                          [ OK ]
TEST: Unknown IOAM namespace (encap mode)                           [ OK ]
TEST: Missing trace room (inline mode)                              [ OK ]
TEST: Missing trace room (encap mode)                               [ OK ]
TEST: Trace type with bit 0 only (inline mode)                      [ OK ]
...
TEST: Full supported trace (encap mode)                             [ OK ]

--------------------------------------------------------------------------
GLOBAL tests
--------------------------------------------------------------------------
TEST: Forward - Full supported trace (inline mode)                  [ OK ]
TEST: Forward - Full supported trace (encap mode)                   [ OK ]

- Tests passed: 88
- Tests failed: 0

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/ioam6.sh | 247 +++++++++++++--------------
 1 file changed, 121 insertions(+), 126 deletions(-)

diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
index 4ceb401da1bf..c2ea3ed43a93 100755
--- a/tools/testing/selftests/net/ioam6.sh
+++ b/tools/testing/selftests/net/ioam6.sh
@@ -117,8 +117,7 @@
 #        | Schema Data         |                                     |
 #        +-----------------------------------------------------------+
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source lib.sh
 
 ################################################################################
 #                                                                              #
@@ -195,32 +194,32 @@ TESTS_GLOBAL="
 
 check_kernel_compatibility()
 {
-  ip netns add ioam-tmp-node
-  ip link add name veth0 netns ioam-tmp-node type veth \
-         peer name veth1 netns ioam-tmp-node
+  setup_ns ioam_tmp_node
+  ip link add name veth0 netns $ioam_tmp_node type veth \
+         peer name veth1 netns $ioam_tmp_node
 
-  ip -netns ioam-tmp-node link set veth0 up
-  ip -netns ioam-tmp-node link set veth1 up
+  ip -netns $ioam_tmp_node link set veth0 up
+  ip -netns $ioam_tmp_node link set veth1 up
 
-  ip -netns ioam-tmp-node ioam namespace add 0
+  ip -netns $ioam_tmp_node ioam namespace add 0
   ns_ad=$?
 
-  ip -netns ioam-tmp-node ioam namespace show | grep -q "namespace 0"
+  ip -netns $ioam_tmp_node ioam namespace show | grep -q "namespace 0"
   ns_sh=$?
 
   if [[ $ns_ad != 0 || $ns_sh != 0 ]]
   then
     echo "SKIP: kernel version probably too old, missing ioam support"
     ip link del veth0 2>/dev/null || true
-    ip netns del ioam-tmp-node || true
+    ip netns del $ioam_tmp_node || true
     exit $ksft_skip
   fi
 
-  ip -netns ioam-tmp-node route add db02::/64 encap ioam6 mode inline \
+  ip -netns $ioam_tmp_node route add db02::/64 encap ioam6 mode inline \
          trace prealloc type 0x800000 ns 0 size 4 dev veth0
   tr_ad=$?
 
-  ip -netns ioam-tmp-node -6 route | grep -q "encap ioam6"
+  ip -netns $ioam_tmp_node -6 route | grep -q "encap ioam6"
   tr_sh=$?
 
   if [[ $tr_ad != 0 || $tr_sh != 0 ]]
@@ -228,12 +227,12 @@ check_kernel_compatibility()
     echo "SKIP: cannot attach an ioam trace to a route, did you compile" \
          "without CONFIG_IPV6_IOAM6_LWTUNNEL?"
     ip link del veth0 2>/dev/null || true
-    ip netns del ioam-tmp-node || true
+    ip netns del $ioam_tmp_node || true
     exit $ksft_skip
   fi
 
   ip link del veth0 2>/dev/null || true
-  ip netns del ioam-tmp-node || true
+  ip netns del $ioam_tmp_node || true
 
   lsmod | grep -q "ip6_tunnel"
   ip6tnl_loaded=$?
@@ -265,9 +264,7 @@ cleanup()
   ip link del ioam-veth-alpha 2>/dev/null || true
   ip link del ioam-veth-gamma 2>/dev/null || true
 
-  ip netns del ioam-node-alpha || true
-  ip netns del ioam-node-beta || true
-  ip netns del ioam-node-gamma || true
+  cleanup_ns $ioam_node_alpha $ioam_node_beta $ioam_node_gamma
 
   if [ $ip6tnl_loaded != 0 ]
   then
@@ -277,69 +274,67 @@ cleanup()
 
 setup()
 {
-  ip netns add ioam-node-alpha
-  ip netns add ioam-node-beta
-  ip netns add ioam-node-gamma
-
-  ip link add name ioam-veth-alpha netns ioam-node-alpha type veth \
-         peer name ioam-veth-betaL netns ioam-node-beta
-  ip link add name ioam-veth-betaR netns ioam-node-beta type veth \
-         peer name ioam-veth-gamma netns ioam-node-gamma
-
-  ip -netns ioam-node-alpha link set ioam-veth-alpha name veth0
-  ip -netns ioam-node-beta link set ioam-veth-betaL name veth0
-  ip -netns ioam-node-beta link set ioam-veth-betaR name veth1
-  ip -netns ioam-node-gamma link set ioam-veth-gamma name veth0
-
-  ip -netns ioam-node-alpha addr add db01::2/64 dev veth0
-  ip -netns ioam-node-alpha link set veth0 up
-  ip -netns ioam-node-alpha link set lo up
-  ip -netns ioam-node-alpha route add db02::/64 via db01::1 dev veth0
-  ip -netns ioam-node-alpha route del db01::/64
-  ip -netns ioam-node-alpha route add db01::/64 dev veth0
-
-  ip -netns ioam-node-beta addr add db01::1/64 dev veth0
-  ip -netns ioam-node-beta addr add db02::1/64 dev veth1
-  ip -netns ioam-node-beta link set veth0 up
-  ip -netns ioam-node-beta link set veth1 up
-  ip -netns ioam-node-beta link set lo up
-
-  ip -netns ioam-node-gamma addr add db02::2/64 dev veth0
-  ip -netns ioam-node-gamma link set veth0 up
-  ip -netns ioam-node-gamma link set lo up
-  ip -netns ioam-node-gamma route add db01::/64 via db02::1 dev veth0
+  setup_ns ioam_node_alpha ioam_node_beta ioam_node_gamma
+
+  ip link add name ioam-veth-alpha netns $ioam_node_alpha type veth \
+         peer name ioam-veth-betaL netns $ioam_node_beta
+  ip link add name ioam-veth-betaR netns $ioam_node_beta type veth \
+         peer name ioam-veth-gamma netns $ioam_node_gamma
+
+  ip -netns $ioam_node_alpha link set ioam-veth-alpha name veth0
+  ip -netns $ioam_node_beta link set ioam-veth-betaL name veth0
+  ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1
+  ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0
+
+  ip -netns $ioam_node_alpha addr add db01::2/64 dev veth0
+  ip -netns $ioam_node_alpha link set veth0 up
+  ip -netns $ioam_node_alpha link set lo up
+  ip -netns $ioam_node_alpha route add db02::/64 via db01::1 dev veth0
+  ip -netns $ioam_node_alpha route del db01::/64
+  ip -netns $ioam_node_alpha route add db01::/64 dev veth0
+
+  ip -netns $ioam_node_beta addr add db01::1/64 dev veth0
+  ip -netns $ioam_node_beta addr add db02::1/64 dev veth1
+  ip -netns $ioam_node_beta link set veth0 up
+  ip -netns $ioam_node_beta link set veth1 up
+  ip -netns $ioam_node_beta link set lo up
+
+  ip -netns $ioam_node_gamma addr add db02::2/64 dev veth0
+  ip -netns $ioam_node_gamma link set veth0 up
+  ip -netns $ioam_node_gamma link set lo up
+  ip -netns $ioam_node_gamma route add db01::/64 via db02::1 dev veth0
 
   # - IOAM config -
-  ip netns exec ioam-node-alpha sysctl -wq net.ipv6.ioam6_id=${ALPHA[0]}
-  ip netns exec ioam-node-alpha sysctl -wq net.ipv6.ioam6_id_wide=${ALPHA[1]}
-  ip netns exec ioam-node-alpha sysctl -wq net.ipv6.conf.veth0.ioam6_id=${ALPHA[4]}
-  ip netns exec ioam-node-alpha sysctl -wq net.ipv6.conf.veth0.ioam6_id_wide=${ALPHA[5]}
-  ip -netns ioam-node-alpha ioam namespace add 123 data ${ALPHA[6]} wide ${ALPHA[7]}
-  ip -netns ioam-node-alpha ioam schema add ${ALPHA[8]} "${ALPHA[9]}"
-  ip -netns ioam-node-alpha ioam namespace set 123 schema ${ALPHA[8]}
-
-  ip netns exec ioam-node-beta sysctl -wq net.ipv6.conf.all.forwarding=1
-  ip netns exec ioam-node-beta sysctl -wq net.ipv6.ioam6_id=${BETA[0]}
-  ip netns exec ioam-node-beta sysctl -wq net.ipv6.ioam6_id_wide=${BETA[1]}
-  ip netns exec ioam-node-beta sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1
-  ip netns exec ioam-node-beta sysctl -wq net.ipv6.conf.veth0.ioam6_id=${BETA[2]}
-  ip netns exec ioam-node-beta sysctl -wq net.ipv6.conf.veth0.ioam6_id_wide=${BETA[3]}
-  ip netns exec ioam-node-beta sysctl -wq net.ipv6.conf.veth1.ioam6_id=${BETA[4]}
-  ip netns exec ioam-node-beta sysctl -wq net.ipv6.conf.veth1.ioam6_id_wide=${BETA[5]}
-  ip -netns ioam-node-beta ioam namespace add 123 data ${BETA[6]} wide ${BETA[7]}
-  ip -netns ioam-node-beta ioam schema add ${BETA[8]} "${BETA[9]}"
-  ip -netns ioam-node-beta ioam namespace set 123 schema ${BETA[8]}
-
-  ip netns exec ioam-node-gamma sysctl -wq net.ipv6.ioam6_id=${GAMMA[0]}
-  ip netns exec ioam-node-gamma sysctl -wq net.ipv6.ioam6_id_wide=${GAMMA[1]}
-  ip netns exec ioam-node-gamma sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1
-  ip netns exec ioam-node-gamma sysctl -wq net.ipv6.conf.veth0.ioam6_id=${GAMMA[2]}
-  ip netns exec ioam-node-gamma sysctl -wq net.ipv6.conf.veth0.ioam6_id_wide=${GAMMA[3]}
-  ip -netns ioam-node-gamma ioam namespace add 123 data ${GAMMA[6]} wide ${GAMMA[7]}
+  ip netns exec $ioam_node_alpha sysctl -wq net.ipv6.ioam6_id=${ALPHA[0]}
+  ip netns exec $ioam_node_alpha sysctl -wq net.ipv6.ioam6_id_wide=${ALPHA[1]}
+  ip netns exec $ioam_node_alpha sysctl -wq net.ipv6.conf.veth0.ioam6_id=${ALPHA[4]}
+  ip netns exec $ioam_node_alpha sysctl -wq net.ipv6.conf.veth0.ioam6_id_wide=${ALPHA[5]}
+  ip -netns $ioam_node_alpha ioam namespace add 123 data ${ALPHA[6]} wide ${ALPHA[7]}
+  ip -netns $ioam_node_alpha ioam schema add ${ALPHA[8]} "${ALPHA[9]}"
+  ip -netns $ioam_node_alpha ioam namespace set 123 schema ${ALPHA[8]}
+
+  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.all.forwarding=1
+  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.ioam6_id=${BETA[0]}
+  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.ioam6_id_wide=${BETA[1]}
+  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1
+  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth0.ioam6_id=${BETA[2]}
+  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth0.ioam6_id_wide=${BETA[3]}
+  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth1.ioam6_id=${BETA[4]}
+  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth1.ioam6_id_wide=${BETA[5]}
+  ip -netns $ioam_node_beta ioam namespace add 123 data ${BETA[6]} wide ${BETA[7]}
+  ip -netns $ioam_node_beta ioam schema add ${BETA[8]} "${BETA[9]}"
+  ip -netns $ioam_node_beta ioam namespace set 123 schema ${BETA[8]}
+
+  ip netns exec $ioam_node_gamma sysctl -wq net.ipv6.ioam6_id=${GAMMA[0]}
+  ip netns exec $ioam_node_gamma sysctl -wq net.ipv6.ioam6_id_wide=${GAMMA[1]}
+  ip netns exec $ioam_node_gamma sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1
+  ip netns exec $ioam_node_gamma sysctl -wq net.ipv6.conf.veth0.ioam6_id=${GAMMA[2]}
+  ip netns exec $ioam_node_gamma sysctl -wq net.ipv6.conf.veth0.ioam6_id_wide=${GAMMA[3]}
+  ip -netns $ioam_node_gamma ioam namespace add 123 data ${GAMMA[6]} wide ${GAMMA[7]}
 
   sleep 1
 
-  ip netns exec ioam-node-alpha ping6 -c 5 -W 1 db02::2 &>/dev/null
+  ip netns exec $ioam_node_alpha ping6 -c 5 -W 1 db02::2 &>/dev/null
   if [ $? != 0 ]
   then
     echo "Setup FAILED"
@@ -412,7 +407,7 @@ run()
   echo
 
   # set OUTPUT settings
-  ip netns exec ioam-node-beta sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=0
+  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=0
 
   for t in $TESTS_OUTPUT
   do
@@ -421,8 +416,8 @@ run()
   done
 
   # clean OUTPUT settings
-  ip netns exec ioam-node-beta sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1
-  ip -netns ioam-node-alpha route change db01::/64 dev veth0
+  ip netns exec $ioam_node_beta sysctl -wq net.ipv6.conf.veth0.ioam6_enabled=1
+  ip -netns $ioam_node_alpha route change db01::/64 dev veth0
 
 
   echo
@@ -433,7 +428,7 @@ run()
   echo
 
   # set INPUT settings
-  ip -netns ioam-node-alpha ioam namespace del 123
+  ip -netns $ioam_node_alpha ioam namespace del 123
 
   for t in $TESTS_INPUT
   do
@@ -442,10 +437,10 @@ run()
   done
 
   # clean INPUT settings
-  ip -netns ioam-node-alpha ioam namespace add 123 \
+  ip -netns $ioam_node_alpha ioam namespace add 123 \
          data ${ALPHA[6]} wide ${ALPHA[7]}
-  ip -netns ioam-node-alpha ioam namespace set 123 schema ${ALPHA[8]}
-  ip -netns ioam-node-alpha route change db01::/64 dev veth0
+  ip -netns $ioam_node_alpha ioam namespace set 123 schema ${ALPHA[8]}
+  ip -netns $ioam_node_alpha route change db01::/64 dev veth0
 
   echo
   printf "%0.s-" {1..74}
@@ -488,15 +483,15 @@ out_undef_ns()
   local desc="Unknown IOAM namespace"
 
   [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 up
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
 
-  ip -netns ioam-node-alpha route change db01::/64 encap ioam6 mode $mode \
+  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
          trace prealloc type 0x800000 ns 0 size 4 dev veth0
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" ioam-node-alpha ioam-node-beta \
+  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
          db01::2 db01::1 veth0 0x800000 0
 
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 down
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
 
 out_no_room()
@@ -508,15 +503,15 @@ out_no_room()
   local desc="Missing trace room"
 
   [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 up
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
 
-  ip -netns ioam-node-alpha route change db01::/64 encap ioam6 mode $mode \
+  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
          trace prealloc type 0xc00000 ns 123 size 4 dev veth0
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" ioam-node-alpha ioam-node-beta \
+  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
          db01::2 db01::1 veth0 0xc00000 123
 
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 down
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
 
 out_bits()
@@ -532,11 +527,11 @@ out_bits()
   bit2size[22]=$(( $tmp + ${#ALPHA[9]} + ((4 - (${#ALPHA[9]} % 4)) % 4) ))
 
   [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 up
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
 
   for i in {0..22}
   do
-    ip -netns ioam-node-alpha route change db01::/64 encap ioam6 mode $mode \
+    ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
            trace prealloc type ${bit2type[$i]} ns 123 size ${bit2size[$i]} \
            dev veth0 &>/dev/null
 
@@ -554,12 +549,12 @@ out_bits()
         log_test_failed "$descr"
       fi
     else
-	run_test "out_bit$i" "$descr ($1 mode)" ioam-node-alpha \
-           ioam-node-beta db01::2 db01::1 veth0 ${bit2type[$i]} 123
+	run_test "out_bit$i" "$descr ($1 mode)" $ioam_node_alpha \
+           $ioam_node_beta db01::2 db01::1 veth0 ${bit2type[$i]} 123
     fi
   done
 
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 down
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 
   bit2size[22]=$tmp
 }
@@ -573,15 +568,15 @@ out_full_supp_trace()
   local desc="Full supported trace"
 
   [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 up
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
 
-  ip -netns ioam-node-alpha route change db01::/64 encap ioam6 mode $mode \
+  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
          trace prealloc type 0xfff002 ns 123 size 100 dev veth0
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" ioam-node-alpha ioam-node-beta \
+  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
          db01::2 db01::1 veth0 0xfff002 123
 
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 down
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
 
 
@@ -603,15 +598,15 @@ in_undef_ns()
   local desc="Unknown IOAM namespace"
 
   [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 up
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
 
-  ip -netns ioam-node-alpha route change db01::/64 encap ioam6 mode $mode \
+  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
          trace prealloc type 0x800000 ns 0 size 4 dev veth0
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" ioam-node-alpha ioam-node-beta \
+  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
          db01::2 db01::1 veth0 0x800000 0
 
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 down
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
 
 in_no_room()
@@ -623,15 +618,15 @@ in_no_room()
   local desc="Missing trace room"
 
   [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 up
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
 
-  ip -netns ioam-node-alpha route change db01::/64 encap ioam6 mode $mode \
+  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
          trace prealloc type 0xc00000 ns 123 size 4 dev veth0
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" ioam-node-alpha ioam-node-beta \
+  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
          db01::2 db01::1 veth0 0xc00000 123
 
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 down
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
 
 in_bits()
@@ -647,19 +642,19 @@ in_bits()
   bit2size[22]=$(( $tmp + ${#BETA[9]} + ((4 - (${#BETA[9]} % 4)) % 4) ))
 
   [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 up
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
 
   for i in {0..11} {22..22}
   do
-    ip -netns ioam-node-alpha route change db01::/64 encap ioam6 mode $mode \
+    ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
            trace prealloc type ${bit2type[$i]} ns 123 size ${bit2size[$i]} \
            dev veth0
 
-    run_test "in_bit$i" "${desc/<n>/$i} ($1 mode)" ioam-node-alpha \
-           ioam-node-beta db01::2 db01::1 veth0 ${bit2type[$i]} 123
+    run_test "in_bit$i" "${desc/<n>/$i} ($1 mode)" $ioam_node_alpha \
+           $ioam_node_beta db01::2 db01::1 veth0 ${bit2type[$i]} 123
   done
 
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 down
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 
   bit2size[22]=$tmp
 }
@@ -675,22 +670,22 @@ in_oflag()
   # Exception:
   #   Here, we need the sender to set the Overflow flag. For that, we will add
   #   back the IOAM namespace that was previously configured on the sender.
-  ip -netns ioam-node-alpha ioam namespace add 123
+  ip -netns $ioam_node_alpha ioam namespace add 123
 
   [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 up
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
 
-  ip -netns ioam-node-alpha route change db01::/64 encap ioam6 mode $mode \
+  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
          trace prealloc type 0xc00000 ns 123 size 4 dev veth0
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" ioam-node-alpha ioam-node-beta \
+  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
          db01::2 db01::1 veth0 0xc00000 123
 
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 down
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 
   # And we clean the exception for this test to get things back to normal for
   # other INPUT tests
-  ip -netns ioam-node-alpha ioam namespace del 123
+  ip -netns $ioam_node_alpha ioam namespace del 123
 }
 
 in_full_supp_trace()
@@ -702,15 +697,15 @@ in_full_supp_trace()
   local desc="Full supported trace"
 
   [ "$1" = "encap" ] && mode="$1 tundst db01::1" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 up
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 up
 
-  ip -netns ioam-node-alpha route change db01::/64 encap ioam6 mode $mode \
+  ip -netns $ioam_node_alpha route change db01::/64 encap ioam6 mode $mode \
          trace prealloc type 0xfff002 ns 123 size 80 dev veth0
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" ioam-node-alpha ioam-node-beta \
+  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
          db01::2 db01::1 veth0 0xfff002 123
 
-  [ "$1" = "encap" ] && ip -netns ioam-node-beta link set ip6tnl0 down
+  [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
 
 
@@ -730,15 +725,15 @@ fwd_full_supp_trace()
   local desc="Forward - Full supported trace"
 
   [ "$1" = "encap" ] && mode="$1 tundst db02::2" || mode="$1"
-  [ "$1" = "encap" ] && ip -netns ioam-node-gamma link set ip6tnl0 up
+  [ "$1" = "encap" ] && ip -netns $ioam_node_gamma link set ip6tnl0 up
 
-  ip -netns ioam-node-alpha route change db02::/64 encap ioam6 mode $mode \
+  ip -netns $ioam_node_alpha route change db02::/64 encap ioam6 mode $mode \
          trace prealloc type 0xfff002 ns 123 size 244 via db01::1 dev veth0
 
-  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" ioam-node-alpha ioam-node-gamma \
+  run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_gamma \
          db01::2 db02::2 veth0 0xfff002 123
 
-  [ "$1" = "encap" ] && ip -netns ioam-node-gamma link set ip6tnl0 down
+  [ "$1" = "encap" ] && ip -netns $ioam_node_gamma link set ip6tnl0 down
 }
 
 
-- 
2.41.0


