Return-Path: <linux-kselftest+bounces-1506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33F080C5F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94DE281A75
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E4B22335;
	Mon, 11 Dec 2023 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqxmJI34"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423B2E4;
	Mon, 11 Dec 2023 02:09:45 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f060e059a3so3285947fac.1;
        Mon, 11 Dec 2023 02:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289384; x=1702894184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjnW/dH8VanoQdWRjA4AB5VadbfNMRGd/bNplBHdrE4=;
        b=cqxmJI3481w2rL/FRuZv9Utn9wvzDVM+s2MDzITf6X4GzkdJrlEjHsbvn6wf0+9OI0
         twkcfSRr88HXtrkLgu5OZEbBXpduVELgvvgtoOF9qyFj/WC4qQ6Ou4krCzPl90Jr/IdA
         mADf8WMzSY8xYVtCOhuC/BpGlTXb9PJbMGon4Jqc/rRt4BDKyHSuMq2bF+8JU/TgUAX1
         fZZDzBJUt03HVtUPRTp4OZTdRo+JW3W/fwsy8f97JzOCvlIQrJELwCDgaAn3o5X3umTu
         Wxv20LqVroB5ePTx+XO2Q6rwKuQUFEzoZc3l/JmIdIbN6HP8ZYU/uvz4bDn2MbV0WLsY
         vKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289384; x=1702894184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjnW/dH8VanoQdWRjA4AB5VadbfNMRGd/bNplBHdrE4=;
        b=OUN4bPOGgP6ngrC3JFkyhuRval7B3Ev6oAeubGyIvPdEh15e+S+mYf5FFAWaAaMr97
         eR4E+jycA3z0nnabRHEtqccFqg4O4zVSaeEjTkHm+Drfic9+KX0NqS5Fwdtai5kQAX7O
         DhH0Fi41/wSdQqoFBvQOCQy/LC3lUjsp1PDeeKYFLyvEq6fX2N5WA0t6NNEJbCze2yqr
         j9EOKu9Pvq5CE6wFdaMgH+7SCLkK1z0eoP/x/h/OJJUgm3uSou7zpaOZ/nJLIHn6eDX/
         1kmdsS49zr/DrYSuS/mADHktSd4eEBr3UNRW8o8eqD1HUd1eoVxQAPO9V6DUW9pdgLME
         PgvQ==
X-Gm-Message-State: AOJu0Yxv4MYZlLv63rMFgZp6ZJcNX7ydap4d5GZigFcQH5GKadq93up+
	aNlOi1NEb6nezUCvzHkancfGlumrv2xhkIjr
X-Google-Smtp-Source: AGHT+IGShs00O/JKc9PL7o7OjJiS/LD5Eic0LsffO12BP/gYOs8y87KJs1WRJP3qocNwVAwrGc6yQA==
X-Received: by 2002:a05:6870:e40c:b0:1fb:75c:4010 with SMTP id n12-20020a056870e40c00b001fb075c4010mr5792588oag.112.1702289383866;
        Mon, 11 Dec 2023 02:09:43 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5151733pgv.37.2023.12.11.02.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:09:42 -0800 (PST)
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
Subject: [PATCH net-next 03/13] selftests/net: convert srv6_end_dt4_l3vpn_test.sh to run it in unique namespace
Date: Mon, 11 Dec 2023 18:09:15 +0800
Message-ID: <20231211100925.3249265-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211100925.3249265-1-liuhangbin@gmail.com>
References: <20231211100925.3249265-1-liuhangbin@gmail.com>
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


