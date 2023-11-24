Return-Path: <linux-kselftest+bounces-539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C0D7F6FD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E694B21335
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3215AFC;
	Fri, 24 Nov 2023 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY+y9b8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC67170B;
	Fri, 24 Nov 2023 01:30:33 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cbe6d514cdso1210532b3a.1;
        Fri, 24 Nov 2023 01:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818232; x=1701423032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61yWsYXSnGnkanGlqLUsqddtzK+ssAWsIrdAxGtA4U8=;
        b=mY+y9b8Vu1zLc9ibTJ8JKZn8h+ZzlHXTV2wSgTB0hfF8b3hwabh5xfWbEFXRFckLCj
         u4uuPew8+k+nZBe3Tn5dedyZqZIqAytAhV8KsDFH7B0VR9sEk9tU+N4iHGfjFqHieEXw
         Ib2PJBzekRLfhgKFMO7yaOXp+to4bGFFrUpJxZ0bI/mcaQa0tuFj+8On69J3PsYNCDzR
         w2OisV0ejN4sOq8PJSym1JPQUtKsdHuG0vmR5SLkguQZjnsTLUONHW7j1DO4OTAv9XZv
         XMuPxhsGYd1Mc2lCVr+r4gLlH3q1PO5cKeBUDF+Ft8PAoRLsnaCTYXjzMxGhsFmYsfBU
         2o2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818232; x=1701423032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61yWsYXSnGnkanGlqLUsqddtzK+ssAWsIrdAxGtA4U8=;
        b=XmUlTLRC9tYoDIC4eNd2FmcvWZjWdl6OXaxuGj/LFmZshCeHVKSEbZMxvYtoyuGg78
         P53daaFniGnFBAyyqxzwihbUWQkz6GOiW3qCku8F42l9xfVWpBKyuSbaJIkOkK/Bn0Oo
         juzvKQfkB5dFBV15tvPl3KqcKIWaBFzU63mUIKIggXHb1KkCGnYIS3G1IIjS7hpNxsgA
         B07GZ5hxU57sxzb06JYPYkChJmvd8oe6TGsSF2TI6ij+ThnQIV8pMHqy+2m0nkIg2lTc
         +rDjSRE73hPkSYSxYc5UlMLKE0a2dPIIsN2aSPIEOnGUIyYNsxO1/wX3RWpP4PWMY/FT
         te/Q==
X-Gm-Message-State: AOJu0YyXqhjybtpMNuqilW0RzDYpMlcgNnZVDPMaJXIVHCe+FkgmMbxj
	aoLxEGd5bWx1xaqfDhsTh68bSUayo6/dLOhT
X-Google-Smtp-Source: AGHT+IGkd3Rr9TZ4+LpGrJWiUoFX4P3jSNgffYBSjGOtMQkqYJpGG/JxGpO4mDei9sfk9BHD3kxsUg==
X-Received: by 2002:a05:6a20:1483:b0:18b:31eb:8b66 with SMTP id o3-20020a056a20148300b0018b31eb8b66mr1878505pzi.50.1700818232017;
        Fri, 24 Nov 2023 01:30:32 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:30:31 -0800 (PST)
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
Subject: [PATCH net-next 37/38] selftests/net: convert xfrm_policy.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:35 +0800
Message-ID: <20231124092736.3673263-38-liuhangbin@gmail.com>
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

]# ./xfrm_policy.sh
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
2.41.0


