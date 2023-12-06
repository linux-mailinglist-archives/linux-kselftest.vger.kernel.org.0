Return-Path: <linux-kselftest+bounces-1236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D108067F6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3893D1C211FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506C7134C2;
	Wed,  6 Dec 2023 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d59iZDDY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6E4D40;
	Tue,  5 Dec 2023 23:08:27 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1fb37f25399so1793253fac.1;
        Tue, 05 Dec 2023 23:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701846506; x=1702451306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ARreR6Yv2veEfwLOeod09N+s7xxsaFdv0+RonK3vfw=;
        b=d59iZDDYioOTM7HPGsaWdBbKWeVyZKDHLe64WP5gATacAEeRvS2WAx7ouRNf+sXADs
         FTpiSxZN+dQGvz05Ul0dhiT61L6Qru+0RJJIWG4VcEVFuF5U10nLo1/OR6e+l1xv9a5P
         ZwiTGB2Osf3Oa9GCRMZjfE6aw2ZlVM9UZGJWxUN97/azENz3uogn0UPlfb1vIhA8eqxk
         txxYCSWN0n/InNE40B414CpL2oY1T6HjWPIRqFJu/Xw7vQ4xOf9vgGtmRNrspz2M6VXB
         2zqEodtYRhIPT3TNk3CSxRKrXSEI2np9oQF8bqM3Uq66V57qyxLkdcTRndA9FDUTo8e4
         tByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846506; x=1702451306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ARreR6Yv2veEfwLOeod09N+s7xxsaFdv0+RonK3vfw=;
        b=g5S/gZEsR3baqn7ZW70UfwqxQusw2r9ZYuSB+Gxpnn6aC3oAr5e3dl5NaOW+X07Vfw
         hWL0HawKbZgl+NolIwTiV+JlUJU2HV533Irr43apF/ix4ciWErpNWflg1UFFSeCxxUlP
         yFphV80Yfb2TCXtJZgEUUXMXXQkSbyS0TnmoQT/Q6xCUvxu++iH/rU/CnD0w5KU1mz7/
         INX6kq1FcOKeQTwYVGT933zuFAgH8nvmA6EoFtSVDKwsutOD8Bfm1twD871rUKfPHG3M
         hHbQvrWdK6ttNjzthVxig+uenAJLmULZkKkUijk1HwVx3tyJKjveSz+1H/EP6alLh3V+
         Yi9g==
X-Gm-Message-State: AOJu0YyyVdQBJMnB0aF5kf4j6rHRhgtM7k0xTnEzoO24Afrpteu6i4Rg
	JVvVmnUGSAZkjTdiBzOM53AAKKrombyGORRm
X-Google-Smtp-Source: AGHT+IFTqoAMgYq13gfzi4yvhvdcR4X3IfJBFU8KOFDeRSoAsEQM5xx+XT/XP//aq7YztaSAa+ZKTg==
X-Received: by 2002:a05:6870:1649:b0:1fb:75a:7790 with SMTP id c9-20020a056870164900b001fb075a7790mr530307oae.65.1701846506392;
        Tue, 05 Dec 2023 23:08:26 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm10184212pgh.14.2023.12.05.23.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:08:25 -0800 (PST)
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
Subject: [PATCH net-next 4/9] selftests/net: convert test_vxlan_nolocalbypass.sh to run it in unique namespace
Date: Wed,  6 Dec 2023 15:07:56 +0800
Message-ID: <20231206070801.1691247-5-liuhangbin@gmail.com>
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

]# ./test_vxlan_nolocalbypass.sh
TEST: localbypass enabled                                           [ OK ]
TEST: Packet received by local VXLAN device - localbypass           [ OK ]
TEST: localbypass disabled                                          [ OK ]
TEST: Packet not received by local VXLAN device - nolocalbypass     [ OK ]
TEST: localbypass enabled                                           [ OK ]
TEST: Packet received by local VXLAN device - localbypass           [ OK ]

Tests passed:   6
Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
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
2.43.0


