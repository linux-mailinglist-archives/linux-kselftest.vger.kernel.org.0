Return-Path: <linux-kselftest+bounces-2185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2278184C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0016C1F268CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D662B13FE9;
	Tue, 19 Dec 2023 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5ahzdRa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303A1426B;
	Tue, 19 Dec 2023 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58d18c224c7so2672918eaf.2;
        Tue, 19 Dec 2023 01:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979368; x=1703584168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gnGTazMYDP2LaFiCvzMYscNqHB3XeHRTsf1tloUUig=;
        b=E5ahzdRaZTJOULOG1RNfmxJjcFPhwOptcsd5J+vzNsB56SxCvbOOLfb4DcRt988l2c
         J+fGoIbPP3rAboO0mcAS3ZdaVWRPvFfPc9MX0ob1I08AJvHoBJNyS7AuozyaYSK/XiFz
         gMY2o20vU2ef+seTcJfCbyo4L+FzNmxojbgmx/QjZMF8rW7xE1oT8C18Rybw4BfOIq/H
         VTX5X7/bHH5rnzgAquvifYn9yyhQTayPXCR8y9Sdvm83NgxngJ5A1my8gwxDn4zScnMw
         llDf1MFYMXwtLlZWzu7UkoZ3GD7FIKaBjD0lBKml1lQuk1Lh3WrvRcguViwP8VOMfaiv
         WaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979368; x=1703584168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gnGTazMYDP2LaFiCvzMYscNqHB3XeHRTsf1tloUUig=;
        b=tDcbaHuaom7mqFUVrvyRK+4Ac8AFxfjrG5xMixq61y4rl1r7nmsmKeNJUzfcF3GuOH
         clzBDfrcdmYqrGME6tgPcWuFHPtVRKAbmyBrsktIv44HVBUoVqsF90d9Ov+/V4W6RwkA
         92Pzytaqlqa98qqrXh0f7+wMriAQsrEXuZxIkdNzVHLnq9j1gLOkIHmFlF235z19hH+I
         uR9AMz0EFihTEayh/t0YOcwOUlCVvJ53+3LAOUm0r9Zm5Swz8jLtA/t86wzAq9Ga5RP9
         WCgt2x5jcMgMNzPCanoz8J1Rg0l/IR0kOfvu+QgXmQSuCftIm9ywfy2ihZAoDRpX2WPb
         zz9Q==
X-Gm-Message-State: AOJu0Yy/cBZQWi/5Ivnuw6QP03wKv1D+9oQmvHzUcV8BJYluC4EiqVlh
	NeFYJOAZ6TU+/Vf4gnN0Kz/OkCvLFv2onE2YCJ0=
X-Google-Smtp-Source: AGHT+IE1ftuQqgtthA3a9u+wcnAkBGZPGf2pLe8tg1VSxCtTIwouz9WC5Bgro4DUlZINUUnIIVkB9Q==
X-Received: by 2002:a05:6359:71c1:b0:170:2493:11fa with SMTP id uf1-20020a05635971c100b00170249311famr9295948rwb.50.1702979368185;
        Tue, 19 Dec 2023 01:49:28 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ds17-20020a17090b08d100b0028b21d24ba6sm1076276pjb.15.2023.12.19.01.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:49:27 -0800 (PST)
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
	Florian Westphal <fw@strlen.de>,
	Martin KaFai Lau <kafai@fb.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 5/8] selftests/net: convert xfrm_policy.sh to run it in unique namespace
Date: Tue, 19 Dec 2023 17:48:53 +0800
Message-ID: <20231219094856.1740079-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219094856.1740079-1-liuhangbin@gmail.com>
References: <20231219094856.1740079-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

 # ./xfrm_policy.sh
 PASS: policy before exception matches
 PASS: ping to .254 bypassed ipsec tunnel (exceptions)
 PASS: direct policy matches (exceptions)
 PASS: policy matches (exceptions)
 PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies)
 PASS: direct policy matches (exceptions and block policies)
 PASS: policy matches (exceptions and block policies)
 PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies after hresh changes)
 PASS: direct policy matches (exceptions and block policies after hresh changes)
 PASS: policy matches (exceptions and block policies after hresh changes)
 PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies after hthresh change in ns3)
 PASS: direct policy matches (exceptions and block policies after hthresh change in ns3)
 PASS: policy matches (exceptions and block policies after hthresh change in ns3)
 PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies after htresh change to normal)
 PASS: direct policy matches (exceptions and block policies after htresh change to normal)
 PASS: policy matches (exceptions and block policies after htresh change to normal)
 PASS: policies with repeated htresh change

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/xfrm_policy.sh | 138 ++++++++++-----------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/tools/testing/selftests/net/xfrm_policy.sh b/tools/testing/selftests/net/xfrm_policy.sh
index bdf450eaf60c..457789530645 100755
--- a/tools/testing/selftests/net/xfrm_policy.sh
+++ b/tools/testing/selftests/net/xfrm_policy.sh
@@ -18,8 +18,7 @@
 # ns1: ping 10.0.2.254: does NOT pass via ipsec tunnel (exception)
 # ns2: ping 10.0.1.254: does NOT pass via ipsec tunnel (exception)
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source lib.sh
 ret=0
 policy_checks_ok=1
 
@@ -204,24 +203,24 @@ check_xfrm() {
 	ip=$2
 	local lret=0
 
-	ip netns exec ns1 ping -q -c 1 10.0.2.$ip > /dev/null
+	ip netns exec ${ns[1]} ping -q -c 1 10.0.2.$ip > /dev/null
 
-	check_ipt_policy_count ns3
+	check_ipt_policy_count ${ns[3]}
 	if [ $? -ne $rval ] ; then
 		lret=1
 	fi
-	check_ipt_policy_count ns4
+	check_ipt_policy_count ${ns[4]}
 	if [ $? -ne $rval ] ; then
 		lret=1
 	fi
 
-	ip netns exec ns2 ping -q -c 1 10.0.1.$ip > /dev/null
+	ip netns exec ${ns[2]} ping -q -c 1 10.0.1.$ip > /dev/null
 
-	check_ipt_policy_count ns3
+	check_ipt_policy_count ${ns[3]}
 	if [ $? -ne $rval ] ; then
 		lret=1
 	fi
-	check_ipt_policy_count ns4
+	check_ipt_policy_count ${ns[4]}
 	if [ $? -ne $rval ] ; then
 		lret=1
 	fi
@@ -270,11 +269,11 @@ check_hthresh_repeat()
 	i=0
 
 	for i in $(seq 1 10);do
-		ip -net ns1 xfrm policy update src e000:0001::0000 dst ff01::0014:0000:0001 dir in tmpl src :: dst :: proto esp mode tunnel priority 100 action allow || break
-		ip -net ns1 xfrm policy set hthresh6 0 28 || break
+		ip -net ${ns[1]} xfrm policy update src e000:0001::0000 dst ff01::0014:0000:0001 dir in tmpl src :: dst :: proto esp mode tunnel priority 100 action allow || break
+		ip -net ${ns[1]} xfrm policy set hthresh6 0 28 || break
 
-		ip -net ns1 xfrm policy update src e000:0001::0000 dst ff01::01 dir in tmpl src :: dst :: proto esp mode tunnel priority 100 action allow || break
-		ip -net ns1 xfrm policy set hthresh6 0 28 || break
+		ip -net ${ns[1]} xfrm policy update src e000:0001::0000 dst ff01::01 dir in tmpl src :: dst :: proto esp mode tunnel priority 100 action allow || break
+		ip -net ${ns[1]} xfrm policy set hthresh6 0 28 || break
 	done
 
 	if [ $i -ne 10 ] ;then
@@ -347,79 +346,80 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-for i in 1 2 3 4; do
-    ip netns add ns$i
-    ip -net ns$i link set lo up
-done
+setup_ns ns1 ns2 ns3 ns4
+ns[1]=$ns1
+ns[2]=$ns2
+ns[3]=$ns3
+ns[4]=$ns4
 
 DEV=veth0
-ip link add $DEV netns ns1 type veth peer name eth1 netns ns3
-ip link add $DEV netns ns2 type veth peer name eth1 netns ns4
+ip link add $DEV netns ${ns[1]} type veth peer name eth1 netns ${ns[3]}
+ip link add $DEV netns ${ns[2]} type veth peer name eth1 netns ${ns[4]}
 
-ip link add $DEV netns ns3 type veth peer name veth0 netns ns4
+ip link add $DEV netns ${ns[3]} type veth peer name veth0 netns ${ns[4]}
 
 DEV=veth0
 for i in 1 2; do
-    ip -net ns$i link set $DEV up
-    ip -net ns$i addr add 10.0.$i.2/24 dev $DEV
-    ip -net ns$i addr add dead:$i::2/64 dev $DEV
-
-    ip -net ns$i addr add 10.0.$i.253 dev $DEV
-    ip -net ns$i addr add 10.0.$i.254 dev $DEV
-    ip -net ns$i addr add dead:$i::fd dev $DEV
-    ip -net ns$i addr add dead:$i::fe dev $DEV
+    ip -net ${ns[$i]} link set $DEV up
+    ip -net ${ns[$i]} addr add 10.0.$i.2/24 dev $DEV
+    ip -net ${ns[$i]} addr add dead:$i::2/64 dev $DEV
+
+    ip -net ${ns[$i]} addr add 10.0.$i.253 dev $DEV
+    ip -net ${ns[$i]} addr add 10.0.$i.254 dev $DEV
+    ip -net ${ns[$i]} addr add dead:$i::fd dev $DEV
+    ip -net ${ns[$i]} addr add dead:$i::fe dev $DEV
 done
 
 for i in 3 4; do
-ip -net ns$i link set eth1 up
-ip -net ns$i link set veth0 up
+    ip -net ${ns[$i]} link set eth1 up
+    ip -net ${ns[$i]} link set veth0 up
 done
 
-ip -net ns1 route add default via 10.0.1.1
-ip -net ns2 route add default via 10.0.2.1
+ip -net ${ns[1]} route add default via 10.0.1.1
+ip -net ${ns[2]} route add default via 10.0.2.1
 
-ip -net ns3 addr add 10.0.1.1/24 dev eth1
-ip -net ns3 addr add 10.0.3.1/24 dev veth0
-ip -net ns3 addr add 2001:1::1/64 dev eth1
-ip -net ns3 addr add 2001:3::1/64 dev veth0
+ip -net ${ns[3]} addr add 10.0.1.1/24 dev eth1
+ip -net ${ns[3]} addr add 10.0.3.1/24 dev veth0
+ip -net ${ns[3]} addr add 2001:1::1/64 dev eth1
+ip -net ${ns[3]} addr add 2001:3::1/64 dev veth0
 
-ip -net ns3 route add default via 10.0.3.10
+ip -net ${ns[3]} route add default via 10.0.3.10
 
-ip -net ns4 addr add 10.0.2.1/24 dev eth1
-ip -net ns4 addr add 10.0.3.10/24 dev veth0
-ip -net ns4 addr add 2001:2::1/64 dev eth1
-ip -net ns4 addr add 2001:3::10/64 dev veth0
-ip -net ns4 route add default via 10.0.3.1
+ip -net ${ns[4]} addr add 10.0.2.1/24 dev eth1
+ip -net ${ns[4]} addr add 10.0.3.10/24 dev veth0
+ip -net ${ns[4]} addr add 2001:2::1/64 dev eth1
+ip -net ${ns[4]} addr add 2001:3::10/64 dev veth0
+ip -net ${ns[4]} route add default via 10.0.3.1
 
 for j in 4 6; do
 	for i in 3 4;do
-		ip netns exec ns$i sysctl net.ipv$j.conf.eth1.forwarding=1 > /dev/null
-		ip netns exec ns$i sysctl net.ipv$j.conf.veth0.forwarding=1 > /dev/null
+		ip netns exec ${ns[$i]} sysctl net.ipv$j.conf.eth1.forwarding=1 > /dev/null
+		ip netns exec ${ns[$i]} sysctl net.ipv$j.conf.veth0.forwarding=1 > /dev/null
 	done
 done
 
 # abuse iptables rule counter to check if ping matches a policy
-ip netns exec ns3 iptables -p icmp -A FORWARD -m policy --dir out --pol ipsec
-ip netns exec ns4 iptables -p icmp -A FORWARD -m policy --dir out --pol ipsec
+ip netns exec ${ns[3]} iptables -p icmp -A FORWARD -m policy --dir out --pol ipsec
+ip netns exec ${ns[4]} iptables -p icmp -A FORWARD -m policy --dir out --pol ipsec
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not insert iptables rule"
-	for i in 1 2 3 4;do ip netns del ns$i;done
+	cleanup_ns $ns1 $ns2 $ns3 $ns4
 	exit $ksft_skip
 fi
 
 #          localip  remoteip  localnet    remotenet
-do_esp ns3 10.0.3.1 10.0.3.10 10.0.1.0/24 10.0.2.0/24 $SPI1 $SPI2
-do_esp ns3 dead:3::1 dead:3::10 dead:1::/64 dead:2::/64 $SPI1 $SPI2
-do_esp ns4 10.0.3.10 10.0.3.1 10.0.2.0/24 10.0.1.0/24 $SPI2 $SPI1
-do_esp ns4 dead:3::10 dead:3::1 dead:2::/64 dead:1::/64 $SPI2 $SPI1
+do_esp ${ns[3]} 10.0.3.1 10.0.3.10 10.0.1.0/24 10.0.2.0/24 $SPI1 $SPI2
+do_esp ${ns[3]} dead:3::1 dead:3::10 dead:1::/64 dead:2::/64 $SPI1 $SPI2
+do_esp ${ns[4]} 10.0.3.10 10.0.3.1 10.0.2.0/24 10.0.1.0/24 $SPI2 $SPI1
+do_esp ${ns[4]} dead:3::10 dead:3::1 dead:2::/64 dead:1::/64 $SPI2 $SPI1
 
-do_dummies4 ns3
-do_dummies6 ns4
+do_dummies4 ${ns[3]}
+do_dummies6 ${ns[4]}
 
-do_esp_policy_get_check ns3 10.0.1.0/24 10.0.2.0/24
-do_esp_policy_get_check ns4 10.0.2.0/24 10.0.1.0/24
-do_esp_policy_get_check ns3 dead:1::/64 dead:2::/64
-do_esp_policy_get_check ns4 dead:2::/64 dead:1::/64
+do_esp_policy_get_check ${ns[3]} 10.0.1.0/24 10.0.2.0/24
+do_esp_policy_get_check ${ns[4]} 10.0.2.0/24 10.0.1.0/24
+do_esp_policy_get_check ${ns[3]} dead:1::/64 dead:2::/64
+do_esp_policy_get_check ${ns[4]} dead:2::/64 dead:1::/64
 
 # ping to .254 should use ipsec, exception is not installed.
 check_xfrm 1 254
@@ -432,11 +432,11 @@ fi
 
 # installs exceptions
 #                localip  remoteip   encryptdst  plaindst
-do_exception ns3 10.0.3.1 10.0.3.10 10.0.2.253 10.0.2.240/28
-do_exception ns4 10.0.3.10 10.0.3.1 10.0.1.253 10.0.1.240/28
+do_exception ${ns[3]} 10.0.3.1 10.0.3.10 10.0.2.253 10.0.2.240/28
+do_exception ${ns[4]} 10.0.3.10 10.0.3.1 10.0.1.253 10.0.1.240/28
 
-do_exception ns3 dead:3::1 dead:3::10 dead:2::fd  dead:2:f0::/96
-do_exception ns4 dead:3::10 dead:3::1 dead:1::fd  dead:1:f0::/96
+do_exception ${ns[3]} dead:3::1 dead:3::10 dead:2::fd  dead:2:f0::/96
+do_exception ${ns[4]} dead:3::10 dead:3::1 dead:1::fd  dead:1:f0::/96
 
 check_exceptions "exceptions"
 if [ $? -ne 0 ]; then
@@ -444,14 +444,14 @@ if [ $? -ne 0 ]; then
 fi
 
 # insert block policies with adjacent/overlapping netmasks
-do_overlap ns3
+do_overlap ${ns[3]}
 
 check_exceptions "exceptions and block policies"
 if [ $? -ne 0 ]; then
 	ret=1
 fi
 
-for n in ns3 ns4;do
+for n in ${ns[3]} ${ns[4]};do
 	ip -net $n xfrm policy set hthresh4 28 24 hthresh6 126 125
 	sleep $((RANDOM%5))
 done
@@ -459,19 +459,19 @@ done
 check_exceptions "exceptions and block policies after hresh changes"
 
 # full flush of policy db, check everything gets freed incl. internal meta data
-ip -net ns3 xfrm policy flush
+ip -net ${ns[3]} xfrm policy flush
 
-do_esp_policy ns3 10.0.3.1 10.0.3.10 10.0.1.0/24 10.0.2.0/24
-do_exception ns3 10.0.3.1 10.0.3.10 10.0.2.253 10.0.2.240/28
+do_esp_policy ${ns[3]} 10.0.3.1 10.0.3.10 10.0.1.0/24 10.0.2.0/24
+do_exception ${ns[3]} 10.0.3.1 10.0.3.10 10.0.2.253 10.0.2.240/28
 
 # move inexact policies to hash table
-ip -net ns3 xfrm policy set hthresh4 16 16
+ip -net ${ns[3]} xfrm policy set hthresh4 16 16
 
 sleep $((RANDOM%5))
 check_exceptions "exceptions and block policies after hthresh change in ns3"
 
 # restore original hthresh settings -- move policies back to tables
-for n in ns3 ns4;do
+for n in ${ns[3]} ${ns[4]};do
 	ip -net $n xfrm policy set hthresh4 32 32 hthresh6 128 128
 	sleep $((RANDOM%5))
 done
@@ -479,8 +479,8 @@ check_exceptions "exceptions and block policies after htresh change to normal"
 
 check_hthresh_repeat "policies with repeated htresh change"
 
-check_random_order ns3 "policies inserted in random order"
+check_random_order ${ns[3]} "policies inserted in random order"
 
-for i in 1 2 3 4;do ip netns del ns$i;done
+cleanup_ns $ns1 $ns2 $ns3 $ns4
 
 exit $ret
-- 
2.43.0


