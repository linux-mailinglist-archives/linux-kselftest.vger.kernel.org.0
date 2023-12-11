Return-Path: <linux-kselftest+bounces-1507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCDD80C5FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2031C20A5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9DE225D7;
	Mon, 11 Dec 2023 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbC35G7u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A7FFF;
	Mon, 11 Dec 2023 02:09:48 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35d6c5f9579so13757185ab.0;
        Mon, 11 Dec 2023 02:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289388; x=1702894188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W12fJd62omLyBmltMev2hQYyXXbgzymU47Kl8i67noU=;
        b=CbC35G7uzcMajEwJyl92/ElVoOO9xXq01+WuJXKYHj1Ji/QrcbaXRNE7AzzVuNJyfK
         8j5QRUm3ONi13zCHGYxeRRN0sqKS3Z+hUpozsskA1Xf6B34sW8TKrZnhO6WMq/bO+6iB
         UfysBwGXBpYTjyQZzWdTZGykWGq4TbHpieRvHBLJSeEnHXKQMHHr6DtDAWKt1R8OPuvh
         XbzmLB3SeFYkxBxurRr4g/eMir5xFNVfd6UjScMH9SinaSj4OmC3/tVSRrFCfOWJl/kq
         thOYStw1S/Z+bQKQB/ThTfsZxON4Budd5HHzg8BgmW6sdg4YFQbC2a2xqAFSWkeItHlB
         zjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289388; x=1702894188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W12fJd62omLyBmltMev2hQYyXXbgzymU47Kl8i67noU=;
        b=bOzRfU3iGq2gBJpaIGT3IW9Rcw+vZet6pPbZZt93MbQvr07j6HPPxhP+5eR60C5cSj
         UQEklYfonFSUho362omda0i5NQD8NnA24Gq2As5EpBJ4PjTtajfqct0NGcYkwXAaA7wN
         bbB4UNXg8Grx90o05Gh7AbA3g/4El3CSuLmv5EgiTP1lipTeZjDiXR+lu5KWWyr/N0Sj
         0kexBCT720dpzZR+jr6ejFf+s1gwC/r6NttpwLy7YXpN4Yy4+ma6gZkkiUWzc7htt9KF
         nUnH2qnR99Wz9j9l/VM+xzkQuDKZx7iYxv0J+q8Nexlb0sBbQ0+h4zd2YQ/+8CNez/2Q
         rxVQ==
X-Gm-Message-State: AOJu0YyTAoCaWFRzjJNR9xCbSsjsrlfQdHxEBhRMu/ZGjN2XMEnwKq64
	qevgURnY1ovBXuJ95ai8W8mu5asguHRHrtMJ
X-Google-Smtp-Source: AGHT+IE8LwZ/eMPjTBZsMCkQTbl4WzSsGDhsHB/qaj1G7sTEYtNVPticGTyBvikz5koSi/39mYfRcA==
X-Received: by 2002:a05:6e02:20c8:b0:35d:5027:bc4c with SMTP id 8-20020a056e0220c800b0035d5027bc4cmr5914517ilq.17.1702289387737;
        Mon, 11 Dec 2023 02:09:47 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5151733pgv.37.2023.12.11.02.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:09:47 -0800 (PST)
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
Subject: [PATCH net-next 04/13] selftests/net: convert srv6_end_dt6_l3vpn_test.sh to run it in unique namespace
Date: Mon, 11 Dec 2023 18:09:16 +0800
Message-ID: <20231211100925.3249265-5-liuhangbin@gmail.com>
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

 ]# ./srv6_end_dt6_l3vpn_test.sh

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
 .../selftests/net/srv6_end_dt6_l3vpn_test.sh  | 46 +++++++++----------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
index b9b06ef80d88..e408406d8489 100755
--- a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
@@ -164,8 +164,7 @@
 # +---------------------------------------------------+
 #
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source lib.sh
 
 readonly LOCALSID_TABLE_ID=90
 readonly IPv6_RT_NETWORK=fd00
@@ -220,26 +219,22 @@ cleanup()
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
+	local id=$1
+	eval local nsname=\${rt_${id}}
 
-	ip netns add ${nsname}
-	ip link set veth-rt-${rt} netns ${nsname}
-	ip -netns ${nsname} link set veth-rt-${rt} name veth0
+	ip link set veth-rt-${id} netns ${nsname}
+	ip -netns ${nsname} link set veth-rt-${id} name veth0
 
 	ip netns exec ${nsname} sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec ${nsname} sysctl -wq net.ipv6.conf.default.accept_dad=0
 
-	ip -netns ${nsname} addr add ${IPv6_RT_NETWORK}::${rt}/64 dev veth0 nodad
+	ip -netns ${nsname} addr add ${IPv6_RT_NETWORK}::${id}/64 dev veth0 nodad
 	ip -netns ${nsname} link set veth0 up
 	ip -netns ${nsname} link set lo up
 
@@ -248,22 +243,20 @@ setup_rt_networking()
 
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
 
 	# set the networking for the host
-	ip netns add ${hsname}
-
 	ip netns exec ${hsname} sysctl -wq net.ipv6.conf.all.accept_dad=0
 	ip netns exec ${hsname} sysctl -wq net.ipv6.conf.default.accept_dad=0
 
 	ip -netns ${hsname} link add veth0 type veth peer name ${rtveth}
 	ip -netns ${hsname} link set ${rtveth} netns ${rtname}
-	ip -netns ${hsname} addr add ${IPv6_HS_NETWORK}::${hs}/64 dev veth0 nodad
+	ip -netns ${hsname} addr add ${IPv6_HS_NETWORK}::${hid}/64 dev veth0 nodad
 	ip -netns ${hsname} link set veth0 up
 	ip -netns ${hsname} link set lo up
 
@@ -293,10 +286,8 @@ setup_vpn_config()
 	local rtdst=$4
 	local tid=$5
 
-	local hssrc_name=hs-t${tid}-${hssrc}
-	local hsdst_name=hs-t${tid}-${hsdst}
-	local rtsrc_name=rt-${rtsrc}
-	local rtdst_name=rt-${rtdst}
+	eval local rtsrc_name=\${rt_${rtsrc}}
+	eval local rtdst_name=\${rt_${rtdst}}
 	local rtveth=veth-t${tid}
 	local vpn_sid=${VPN_LOCATOR_SERVICE}:${hssrc}${hsdst}:${tid}::6006
 
@@ -331,18 +322,21 @@ setup()
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
 
@@ -361,8 +355,9 @@ check_rt_connectivity()
 {
 	local rtsrc=$1
 	local rtdst=$2
+	eval local nsname=\${rt_${rtsrc}}
 
-	ip netns exec rt-${rtsrc} ping -c 1 -W 1 ${IPv6_RT_NETWORK}::${rtdst} \
+	ip netns exec ${nsname} ping -c 1 -W 1 ${IPv6_RT_NETWORK}::${rtdst} \
 		>/dev/null 2>&1
 }
 
@@ -380,8 +375,9 @@ check_hs_connectivity()
 	local hssrc=$1
 	local hsdst=$2
 	local tid=$3
+	eval local nsname=\${hs_t${tid}_${hssrc}}
 
-	ip netns exec hs-t${tid}-${hssrc} ping -c 1 -W ${PING_TIMEOUT_SEC} \
+	ip netns exec ${nsname} ping -c 1 -W ${PING_TIMEOUT_SEC} \
 		${IPv6_HS_NETWORK}::${hsdst} >/dev/null 2>&1
 }
 
-- 
2.43.0


