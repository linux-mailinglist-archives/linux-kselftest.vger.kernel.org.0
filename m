Return-Path: <linux-kselftest+bounces-1797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5218109DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 07:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD94B1C20AF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4FDDB5;
	Wed, 13 Dec 2023 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzstRaQF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C093DB;
	Tue, 12 Dec 2023 22:09:20 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6d089bc4e1aso2417438b3a.0;
        Tue, 12 Dec 2023 22:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702447759; x=1703052559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjnW/dH8VanoQdWRjA4AB5VadbfNMRGd/bNplBHdrE4=;
        b=MzstRaQFL+2c8dly4R5e8lEsYAJgnufqJ0ago0q8B6CqBMMG3qpR8tERBPFgbZbDT5
         jXR061mvcZrPdWTA1OS5pfhD8THiY96Ic2qBYOSnfxUf4yv9P6Cxa7a6Y7T6GjoVCX37
         1GPOEXj4kkmaOsQ8X+x1x5BFHYBLylnbG+IR7zuYBdhFTwWBY5MkGOWNqp+DGP6ifY8d
         gChQapapFUR9esKyreTeIy1Bspxbs6yOi2n7XGcUSiVxwObOUPtSRtessPs3dIfni/8D
         wO9s4wMa9YYTWYBr/2oxebE5HtbxMOM1Ut4T/w1595V/0suGj1nR8k56wjdZ13zg7s3O
         ofUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447759; x=1703052559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjnW/dH8VanoQdWRjA4AB5VadbfNMRGd/bNplBHdrE4=;
        b=cVMXyU1mocicz3T/IkmzZ4Esr4/ZOV7+saWL05++caGSstze7+ReW2mDwy9cLav57E
         5QF+9EquKoA5Ohr9gCQI6xdM0aU6A04UGlaHeB51Q5SIPepbqamz4/dlt0O5UXGM6jYB
         9PVjYb9mYY4PfFi1iuQar1xxR0etL7xM8UcREVliB62oH0ZCr4IgGjoqd6971ZnRQEFz
         9SsdHEf5vesetrRhze+V28qZNTWXY07sqcxLvnuy09uNgxNHItCFHnLqnM3st7BB1Yxf
         SQYRhDxQsrosyubqV3Mqq6zwl5ltYx42hbZCrXeVx919qXhxjbm9yRsX3D4KBmYN0wfu
         jB1A==
X-Gm-Message-State: AOJu0YwvbDcx9MdwTKuJqmHpIwmEFXyhsbM+dRWhDzFJmjRT5I0dKlaw
	ReQf960ddvkGquKxkx9byYCkLbdJ236EjyXIK6Q=
X-Google-Smtp-Source: AGHT+IE4lYIKfKSmNRyzfd1FilQYhkjJqEdE1QsdBAN2+xcQIO6/ZX8aa4/a0oE5RoqpdGUHV3ty7g==
X-Received: by 2002:a05:6a20:3d89:b0:190:7b07:b7e4 with SMTP id s9-20020a056a203d8900b001907b07b7e4mr8373395pzi.10.1702447759107;
        Tue, 12 Dec 2023 22:09:19 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kq9-20020a056a004b0900b006cef5e5a968sm6890084pfb.201.2023.12.12.22.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:09:18 -0800 (PST)
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
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Amit Cohen <amcohen@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 03/13] selftests/net: convert srv6_end_dt4_l3vpn_test.sh to run it in unique namespace
Date: Wed, 13 Dec 2023 14:08:46 +0800
Message-ID: <20231213060856.4030084-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213060856.4030084-1-liuhangbin@gmail.com>
References: <20231213060856.4030084-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the name \${rt-${rt}} may make reader confuse, convert the variable
hs/rt in setup_rt/hs to hid, rid. Here is the test result after conversion.

 ]# ./srv6_end_dt4_l3vpn_test.sh

 ################################################################################
 TEST SECTION: IPv6 routers connectivity test
 ################################################################################

     TEST: Routers connectivity: rt-1 -> rt-2                            [ OK ]

     TEST: Routers connectivity: rt-2 -> rt-1                            [ OK ]
 ...
     TEST: Hosts isolation: hs-t200-4 -X-> hs-t100-2                     [ OK ]

 Tests passed:  18
 Tests failed:   0

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh  | 48 ++++++++-----------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
index f96282362811..79fb81e63c59 100755
--- a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
@@ -163,8 +163,7 @@
 # +---------------------------------------------------+
 #
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source lib.sh
 
 readonly LOCALSID_TABLE_ID=90
 readonly IPv6_RT_NETWORK=fd00
@@ -219,27 +218,22 @@ cleanup()
 	ip link del veth-rt-1 2>/dev/null || true
 	ip link del veth-rt-2 2>/dev/null || true
 
-	# destroy routers rt-* and hosts hs-*
-	for ns in $(ip netns show | grep -E 'rt-*|hs-*'); do
-		ip netns del ${ns} || true
-	done
+	cleanup_all_ns
 }
 
 # Setup the basic networking for the routers
 setup_rt_networking()
 {
-	local rt=$1
-	local nsname=rt-${rt}
-
-	ip netns add ${nsname}
+	local id=$1
+	eval local nsname=\${rt_${id}}
 
 	ip netns exec ${nsname} sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec ${nsname} sysctl -wq net.ipv6.conf.default.accept_dad=0
 
-	ip link set veth-rt-${rt} netns ${nsname}
-	ip -netns ${nsname} link set veth-rt-${rt} name veth0
+	ip link set veth-rt-${id} netns ${nsname}
+	ip -netns ${nsname} link set veth-rt-${id} name veth0
 
-	ip -netns ${nsname} addr add ${IPv6_RT_NETWORK}::${rt}/64 dev veth0 nodad
+	ip -netns ${nsname} addr add ${IPv6_RT_NETWORK}::${id}/64 dev veth0 nodad
 	ip -netns ${nsname} link set veth0 up
 	ip -netns ${nsname} link set lo up
 
@@ -249,16 +243,13 @@ setup_rt_networking()
 
 setup_hs()
 {
-	local hs=$1
-	local rt=$2
+	local hid=$1
+	local rid=$2
 	local tid=$3
-	local hsname=hs-t${tid}-${hs}
-	local rtname=rt-${rt}
+	eval local hsname=\${hs_t${tid}_${hid}}
+	eval local rtname=\${rt_${rid}}
 	local rtveth=veth-t${tid}
 
-	# set the networking for the host
-	ip netns add ${hsname}
-
 	# disable the rp_filter otherwise the kernel gets confused about how
 	# to route decap ipv4 packets.
 	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
@@ -266,7 +257,7 @@ setup_hs()
 
 	ip -netns ${hsname} link add veth0 type veth peer name ${rtveth}
 	ip -netns ${hsname} link set ${rtveth} netns ${rtname}
-	ip -netns ${hsname} addr add ${IPv4_HS_NETWORK}.${hs}/24 dev veth0
+	ip -netns ${hsname} addr add ${IPv4_HS_NETWORK}.${hid}/24 dev veth0
 	ip -netns ${hsname} link set veth0 up
 	ip -netns ${hsname} link set lo up
 
@@ -293,10 +284,8 @@ setup_vpn_config()
 	local rtdst=$4
 	local tid=$5
 
-	local hssrc_name=hs-t${tid}-${hssrc}
-	local hsdst_name=hs-t${tid}-${hsdst}
-	local rtsrc_name=rt-${rtsrc}
-	local rtdst_name=rt-${rtdst}
+	eval local rtsrc_name=\${rt_${rtsrc}}
+	eval local rtdst_name=\${rt_${rtdst}}
 	local vpn_sid=${VPN_LOCATOR_SERVICE}:${hssrc}${hsdst}:${tid}::6004
 
 	# set the encap route for encapsulating packets which arrive from the
@@ -328,18 +317,21 @@ setup()
 {
 	ip link add veth-rt-1 type veth peer name veth-rt-2
 	# setup the networking for router rt-1 and router rt-2
+	setup_ns rt_1 rt_2
 	setup_rt_networking 1
 	setup_rt_networking 2
 
 	# setup two hosts for the tenant 100.
 	#  - host hs-1 is directly connected to the router rt-1;
 	#  - host hs-2 is directly connected to the router rt-2.
+	setup_ns hs_t100_1 hs_t100_2
 	setup_hs 1 1 100  #args: host router tenant
 	setup_hs 2 2 100
 
 	# setup two hosts for the tenant 200
 	#  - host hs-3 is directly connected to the router rt-1;
 	#  - host hs-4 is directly connected to the router rt-2.
+	setup_ns hs_t200_3 hs_t200_4
 	setup_hs 3 1 200
 	setup_hs 4 2 200
 
@@ -358,8 +350,9 @@ check_rt_connectivity()
 {
 	local rtsrc=$1
 	local rtdst=$2
+	eval local nsname=\${rt_${rtsrc}}
 
-	ip netns exec rt-${rtsrc} ping -c 1 -W 1 ${IPv6_RT_NETWORK}::${rtdst} \
+	ip netns exec ${nsname} ping -c 1 -W 1 ${IPv6_RT_NETWORK}::${rtdst} \
 		>/dev/null 2>&1
 }
 
@@ -377,8 +370,9 @@ check_hs_connectivity()
 	local hssrc=$1
 	local hsdst=$2
 	local tid=$3
+	eval local nsname=\${hs_t${tid}_${hssrc}}
 
-	ip netns exec hs-t${tid}-${hssrc} ping -c 1 -W ${PING_TIMEOUT_SEC} \
+	ip netns exec ${nsname} ping -c 1 -W ${PING_TIMEOUT_SEC} \
 		${IPv4_HS_NETWORK}.${hsdst} >/dev/null 2>&1
 }
 
-- 
2.43.0


