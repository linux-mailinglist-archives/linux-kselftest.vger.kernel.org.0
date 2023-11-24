Return-Path: <linux-kselftest+bounces-530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00F67F6FBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2461EB20FC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45947168DB;
	Fri, 24 Nov 2023 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ffrt6Oid"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29CCD72;
	Fri, 24 Nov 2023 01:29:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ce656b9780so12310895ad.2;
        Fri, 24 Nov 2023 01:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818193; x=1701422993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLIiimwzrcrNYD1dsF9U+yQrKshbAqqB5tECOm0YhTQ=;
        b=Ffrt6OidjZ095PPzy5572y0on3hF6ZmKAHworJ7ffnj8r9fQG24AYJBEopF2pcbBz3
         TwvvgAFKF0vLikuFrarLZ0gYiOkwWrwZISa45MqDXIQLVgidBv3h0dqtAsBmnq5THJfz
         IK50vC8XyN6qULSp77eoWu4REOHW29tspvbi2EBwpj+cd1vD32A21Tqe4YYfSd/Xa3JU
         7NOE0BS4qkR6F/1KhlHQyWxHLXd/060WuBLJREL+wsOAxcVFLs+v302EXLYdp68rChDR
         AU1qoqy3mlYBjoqLF1aE/JlhspbSMUWuz345UbY59CqcWFw1OpEhmQavg0IEvV2X0XN1
         PUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818193; x=1701422993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLIiimwzrcrNYD1dsF9U+yQrKshbAqqB5tECOm0YhTQ=;
        b=L0rtZRffX7FJ0NGW6N0j0JiEOWMcSre7LHJfUVlng6T+nfGV9rAyKC0JQk1fGNTpgY
         69Tmxbw+jknL1KJfTMe1GpW82lzjwn/F9daRfnWR1Pa0roaFE/wkPDwtmp9GUSwr8VJS
         zxQne7N/C1WiHC/Dk1H+p6TyqtPrC9fJAeDFU76KzD+2lsDvPLi+uRZJpGZvgnGTcrsb
         OrX7WLNA/rfRd8cKvToT3rEyIItHNPu7Q7wey1d9d771vDxwJ0X2JThFRIfpLnWpjx4u
         7gBpwY2dgD6lik1EXn33bAeBF2V4AJdkOheeEiecQ3PZxTcicRA+jJi2zCHHTB0vRAfA
         m5tg==
X-Gm-Message-State: AOJu0Yy1ainR2ECpD3o6Hrvxiq5yWZ8cLKGpcCk+Ucg33ilOwNzjijUU
	ZmW1fnDBkNxdt01aH1Fi+7I2EFPgNWTLlMLa
X-Google-Smtp-Source: AGHT+IHMk3MQn2J6huzrrRDXMrjcXgTUtYLjI+ArJUElxMSH8LwysfFHwaQXJputBtE7QB9ZYQBxxQ==
X-Received: by 2002:a17:902:ea07:b0:1c9:e0f9:a676 with SMTP id s7-20020a170902ea0700b001c9e0f9a676mr1896891plg.6.1700818193070;
        Fri, 24 Nov 2023 01:29:53 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:52 -0800 (PST)
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
Subject: [PATCH net-next 28/38] selftests/net: convert test_vxlan_nolocalbypass.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:26 +0800
Message-ID: <20231124092736.3673263-29-liuhangbin@gmail.com>
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

]# ./test_vxlan_nolocalbypass.sh
TEST: localbypass enabled                                           [ OK ]
TEST: Packet received by local VXLAN device - localbypass           [ OK ]
TEST: localbypass disabled                                          [ OK ]
TEST: Packet not received by local VXLAN device - nolocalbypass     [ OK ]
TEST: localbypass enabled                                           [ OK ]
TEST: Packet received by local VXLAN device - localbypass           [ OK ]

Tests passed:   6
Tests failed:   0

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/test_vxlan_nolocalbypass.sh | 48 +++++++++----------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh b/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh
index f75212bf142c..b8805983b728 100755
--- a/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh
+++ b/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh
@@ -9,9 +9,8 @@
 # option and verifies that packets are no longer received by the second VXLAN
 # device.
 
+source lib.sh
 ret=0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 TESTS="
 	nolocalbypass
@@ -98,20 +97,19 @@ tc_check_packets()
 
 setup()
 {
-	ip netns add ns1
+	setup_ns ns1
 
-	ip -n ns1 link set dev lo up
-	ip -n ns1 address add 192.0.2.1/32 dev lo
-	ip -n ns1 address add 198.51.100.1/32 dev lo
+	ip -n $ns1 address add 192.0.2.1/32 dev lo
+	ip -n $ns1 address add 198.51.100.1/32 dev lo
 
-	ip -n ns1 link add name vx0 up type vxlan id 100 local 198.51.100.1 \
+	ip -n $ns1 link add name vx0 up type vxlan id 100 local 198.51.100.1 \
 		dstport 4789 nolearning
-	ip -n ns1 link add name vx1 up type vxlan id 100 dstport 4790
+	ip -n $ns1 link add name vx1 up type vxlan id 100 dstport 4790
 }
 
 cleanup()
 {
-	ip netns del ns1 &> /dev/null
+	cleanup_ns $ns1
 }
 
 ################################################################################
@@ -122,40 +120,40 @@ nolocalbypass()
 	local smac=00:01:02:03:04:05
 	local dmac=00:0a:0b:0c:0d:0e
 
-	run_cmd "bridge -n ns1 fdb add $dmac dev vx0 self static dst 192.0.2.1 port 4790"
+	run_cmd "bridge -n $ns1 fdb add $dmac dev vx0 self static dst 192.0.2.1 port 4790"
 
-	run_cmd "tc -n ns1 qdisc add dev vx1 clsact"
-	run_cmd "tc -n ns1 filter add dev vx1 ingress pref 1 handle 101 proto all flower src_mac $smac dst_mac $dmac action pass"
+	run_cmd "tc -n $ns1 qdisc add dev vx1 clsact"
+	run_cmd "tc -n $ns1 filter add dev vx1 ingress pref 1 handle 101 proto all flower src_mac $smac dst_mac $dmac action pass"
 
-	run_cmd "tc -n ns1 qdisc add dev lo clsact"
-	run_cmd "tc -n ns1 filter add dev lo ingress pref 1 handle 101 proto ip flower ip_proto udp dst_port 4790 action drop"
+	run_cmd "tc -n $ns1 qdisc add dev lo clsact"
+	run_cmd "tc -n $ns1 filter add dev lo ingress pref 1 handle 101 proto ip flower ip_proto udp dst_port 4790 action drop"
 
-	run_cmd "ip -n ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == true'"
+	run_cmd "ip -n $ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == true'"
 	log_test $? 0 "localbypass enabled"
 
-	run_cmd "ip netns exec ns1 mausezahn vx0 -a $smac -b $dmac -c 1 -p 100 -q"
+	run_cmd "ip netns exec $ns1 mausezahn vx0 -a $smac -b $dmac -c 1 -p 100 -q"
 
-	tc_check_packets "ns1" "dev vx1 ingress" 101 1
+	tc_check_packets "$ns1" "dev vx1 ingress" 101 1
 	log_test $? 0 "Packet received by local VXLAN device - localbypass"
 
-	run_cmd "ip -n ns1 link set dev vx0 type vxlan nolocalbypass"
+	run_cmd "ip -n $ns1 link set dev vx0 type vxlan nolocalbypass"
 
-	run_cmd "ip -n ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == false'"
+	run_cmd "ip -n $ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == false'"
 	log_test $? 0 "localbypass disabled"
 
-	run_cmd "ip netns exec ns1 mausezahn vx0 -a $smac -b $dmac -c 1 -p 100 -q"
+	run_cmd "ip netns exec $ns1 mausezahn vx0 -a $smac -b $dmac -c 1 -p 100 -q"
 
-	tc_check_packets "ns1" "dev vx1 ingress" 101 1
+	tc_check_packets "$ns1" "dev vx1 ingress" 101 1
 	log_test $? 0 "Packet not received by local VXLAN device - nolocalbypass"
 
-	run_cmd "ip -n ns1 link set dev vx0 type vxlan localbypass"
+	run_cmd "ip -n $ns1 link set dev vx0 type vxlan localbypass"
 
-	run_cmd "ip -n ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == true'"
+	run_cmd "ip -n $ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == true'"
 	log_test $? 0 "localbypass enabled"
 
-	run_cmd "ip netns exec ns1 mausezahn vx0 -a $smac -b $dmac -c 1 -p 100 -q"
+	run_cmd "ip netns exec $ns1 mausezahn vx0 -a $smac -b $dmac -c 1 -p 100 -q"
 
-	tc_check_packets "ns1" "dev vx1 ingress" 101 2
+	tc_check_packets "$ns1" "dev vx1 ingress" 101 2
 	log_test $? 0 "Packet received by local VXLAN device - localbypass"
 }
 
-- 
2.41.0


