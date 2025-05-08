Return-Path: <linux-kselftest+bounces-32650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A3BAAF579
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 10:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89B51BA1FBF
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 08:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC04B227BA9;
	Thu,  8 May 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4xTVuGb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0E224B01;
	Thu,  8 May 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692405; cv=none; b=jyrD6f6cch+CXNgCD30lHBZDtNRq+tMK69BWjUmg9H6VSqQRtofg4qSyTjyGiqp47OrHY2T8rWjumgda6n7I1j13pAHjoXqe0bf8cWXiIgGd2mS7UBOBiJuuFjlAqa7GwjxquLGXJdsm7kOWtwMvSm9IkNPqDrTT0EwqPqqmFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692405; c=relaxed/simple;
	bh=ETlGTGZHi9yyVZwTgQhE71uDuRQAwdt3Q5McNadhQ6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pa/FfQXmwZahM+Q2VSv85wAslwGg0wedwIC+pj3ArG2dsJkX/qIMsjDC19Jxxg9LNEvfG254tghMek3vx2RL9SCID8FpXosdr79ivEqZAmFQkjfSPm+yXaziKULU65gDClur5xgstEHgtipY7ySSrHNr+PtpQ6VBJt6hvFAxqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4xTVuGb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso777736b3a.2;
        Thu, 08 May 2025 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746692403; x=1747297203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E06alhez4ALhFESu7WKcH3IlmMsagNxhNEJVtOJuRfc=;
        b=m4xTVuGbgiWhLB+nu7u1TJlAhGSjyTOhqv9udWuRnKlzdJmS0jMu0Dz0QtqT8mcws8
         dRTINh89RtfoKt//eRHU+lmzaB638y9G+MMTIOD+vRXP6UagZI008wxC9H/c8lB0n5Rb
         SLMPRiK/EZYir7Gq8DnQx/Wx7EFJOVXA23CgndJAHNnc95E8GVc86Zl06/bmcltp1Vy8
         Inqbfq7D3EwvJ3896v0eTLNz1ZRbR+UPyRLYCmhSR8bHmX2UA9wGiuXRUZT6NPfGNgub
         +SqMW12nJng3OEgTUlAB4UGQL+S0hzfTPktDjcOv0qPRuWkUWgcMvJvEdAlkUraDrcs5
         bztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692403; x=1747297203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E06alhez4ALhFESu7WKcH3IlmMsagNxhNEJVtOJuRfc=;
        b=Mb/VquZgX5rknYYUE/ozyrMRu2vTHVMaoDkzmAfbxF/NoJE5DwjreRf7EVuvixCDDr
         tx1ZrhqGVrASKogeCXLm1m3vMNk8NqtnFYA7Ys72v5rnZ+tDRIMlgElC0XmizGjkuBcQ
         QduR7tLSI1DaENZHDKalFxkY28mAI6AhZmBbmpth2GEx4TDCe7na7swNK8FshyJjvXW5
         hY0cJPjCYpsY5WJDOC1knkrbHsQLDMWlYTAox3aeWDN3p0PM6h7uz3qttNKV8GmFEVxA
         pVatsabO7JXlm2LpGZzJbPtB+7ffGU53dYJm9+4z3Y9jINh1s5WdMOiz8A97s5egmy12
         PXxw==
X-Forwarded-Encrypted: i=1; AJvYcCW0qN9cD+RXFyMdhC0b43Q/41nE0czMq72UFH7d/3OEu9BWMYAmXpeCUQon1JfG/+eLUD/+hpWfpdK4NCtPvbE=@vger.kernel.org, AJvYcCWzgzM68hGao7VdROrGqD+M2wKoNqfSVqeim9ih4Xbtl1VFfbSHWJ/oJHsQjQ/G0xNBphMDxFY7Lydld70foX4o@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+2zZBdGyQKoTqW4CaOeCyiDuP7en79oySkSykN8CWEf6Uv5M
	iEJY99FNxvDhWngfOSzd97FW52cyWpZt+EmR9Hno6v+p+T9b9kQ2Po/IFxEurN0=
X-Gm-Gg: ASbGncuv6v6aiq+T6xw7fgdYuZPlAXmOrUDrAc3ZRGyRontOYpKT/J7g30ONSsQo2gu
	ueH0KZlqxoMyjf6ingUy+UDwowqjhY2RBmwNrONHaUf2+EUsvwwirdVswy8xjnu7HAIvHlJWG2V
	f/6O1lmIdSAL1so243PiKLGlbKpjB+IiRSZTRLT5oZKmcNvGRaygZ9c7gJdi4bpfSxy3YHrJ1vs
	G8QbGsrEZPJM9HrpW7EeLvD2qcM7J0YUg8y6/B0AF+KJjWsP8h3oLIVRGiuhI6n3qsF4Y+AKcWd
	EImhM25K6qRHLAmVle5a+pIQbFvd/2ynhp/4dQOrirmA8b38idKZyCB1DNUn
X-Google-Smtp-Source: AGHT+IEeiqwCWO6vGjah9C04bfTFRzhZ6KvgVsDlBsuERnKsxYZfsx3JJkDvtmIGO6gF3ieAb5Rkpw==
X-Received: by 2002:a05:6a20:3d8e:b0:1f5:8678:1820 with SMTP id adf61e73a8af0-2148b81ec77mr10235054637.12.1746692403062;
        Thu, 08 May 2025 01:20:03 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7406a36c523sm10907408b3a.144.2025.05.08.01.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:20:02 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCHv2 net-next 5/6] selftests: netfilter: remove rp_filter configuration
Date: Thu,  8 May 2025 08:19:09 +0000
Message-ID: <20250508081910.84216-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250508081910.84216-1-liuhangbin@gmail.com>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the rp_filter configuration in netfilter lib, as setup_ns already
sets it appropriately by default

Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/netfilter/br_netfilter.sh    |  3 ---
 .../selftests/net/netfilter/bridge_brouter.sh  |  2 --
 .../selftests/net/netfilter/conntrack_vrf.sh   |  3 ---
 tools/testing/selftests/net/netfilter/ipvs.sh  |  6 ------
 .../testing/selftests/net/netfilter/nft_fib.sh |  2 --
 .../selftests/net/netfilter/nft_nat_zones.sh   |  2 --
 tools/testing/selftests/net/netfilter/rpath.sh | 18 +++++-------------
 7 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/br_netfilter.sh b/tools/testing/selftests/net/netfilter/br_netfilter.sh
index 1559ba275105..011de8763094 100755
--- a/tools/testing/selftests/net/netfilter/br_netfilter.sh
+++ b/tools/testing/selftests/net/netfilter/br_netfilter.sh
@@ -60,9 +60,6 @@ bcast_ping()
 	done
 }
 
-ip netns exec "$ns0" sysctl -q net.ipv4.conf.all.rp_filter=0
-ip netns exec "$ns0" sysctl -q net.ipv4.conf.default.rp_filter=0
-
 if ! ip link add veth1 netns "$ns0" type veth peer name eth0 netns "$ns1"; then
 	echo "SKIP: Can't create veth device"
 	exit $ksft_skip
diff --git a/tools/testing/selftests/net/netfilter/bridge_brouter.sh b/tools/testing/selftests/net/netfilter/bridge_brouter.sh
index 2549b6590693..ea76f2bc2f59 100755
--- a/tools/testing/selftests/net/netfilter/bridge_brouter.sh
+++ b/tools/testing/selftests/net/netfilter/bridge_brouter.sh
@@ -22,8 +22,6 @@ trap cleanup EXIT
 
 setup_ns nsbr ns1 ns2
 
-ip netns exec "$nsbr" sysctl -q net.ipv4.conf.default.rp_filter=0
-ip netns exec "$nsbr" sysctl -q net.ipv4.conf.all.rp_filter=0
 if ! ip link add veth0 netns "$nsbr" type veth peer name eth0 netns "$ns1"; then
 	echo "SKIP: Can't create veth device"
 	exit $ksft_skip
diff --git a/tools/testing/selftests/net/netfilter/conntrack_vrf.sh b/tools/testing/selftests/net/netfilter/conntrack_vrf.sh
index e95ecb37c2b1..025b58f2ae91 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_vrf.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_vrf.sh
@@ -52,9 +52,6 @@ trap cleanup EXIT
 
 setup_ns ns0 ns1
 
-ip netns exec "$ns0" sysctl -q -w net.ipv4.conf.default.rp_filter=0
-ip netns exec "$ns0" sysctl -q -w net.ipv4.conf.all.rp_filter=0
-ip netns exec "$ns0" sysctl -q -w net.ipv4.conf.all.rp_filter=0
 ip netns exec "$ns0" sysctl -q -w net.ipv4.conf.all.forwarding=1
 
 if ! ip link add veth0 netns "$ns0" type veth peer name veth0 netns "$ns1" > /dev/null 2>&1; then
diff --git a/tools/testing/selftests/net/netfilter/ipvs.sh b/tools/testing/selftests/net/netfilter/ipvs.sh
index d3edb16cd4b3..6af2ea3ad6b8 100755
--- a/tools/testing/selftests/net/netfilter/ipvs.sh
+++ b/tools/testing/selftests/net/netfilter/ipvs.sh
@@ -129,9 +129,6 @@ test_dr() {
 	# avoid incorrect arp response
 	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.arp_ignore=1
 	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.arp_announce=2
-	# avoid reverse route lookup
-	ip netns exec "${ns2}" sysctl -qw  net.ipv4.conf.all.rp_filter=0
-	ip netns exec "${ns2}" sysctl -qw  net.ipv4.conf.veth21.rp_filter=0
 	ip netns exec "${ns2}" ip addr add "${vip_v4}/32" dev lo:1
 
 	test_service
@@ -167,9 +164,6 @@ test_tun() {
 	ip netns exec "${ns2}" ip link set tunl0 up
 	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.arp_ignore=1
 	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.arp_announce=2
-	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.rp_filter=0
-	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.tunl0.rp_filter=0
-	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.veth21.rp_filter=0
 	ip netns exec "${ns2}" ip addr add "${vip_v4}/32" dev lo:1
 
 	test_service
diff --git a/tools/testing/selftests/net/netfilter/nft_fib.sh b/tools/testing/selftests/net/netfilter/nft_fib.sh
index ea47dd246a08..82780b39277c 100755
--- a/tools/testing/selftests/net/netfilter/nft_fib.sh
+++ b/tools/testing/selftests/net/netfilter/nft_fib.sh
@@ -167,8 +167,6 @@ test_ping() {
 ip netns exec "$nsrouter" sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
 ip netns exec "$nsrouter" sysctl net.ipv4.conf.veth0.forwarding=1 > /dev/null
 ip netns exec "$nsrouter" sysctl net.ipv4.conf.veth1.forwarding=1 > /dev/null
-ip netns exec "$nsrouter" sysctl net.ipv4.conf.all.rp_filter=0 > /dev/null
-ip netns exec "$nsrouter" sysctl net.ipv4.conf.veth0.rp_filter=0 > /dev/null
 
 test_ping 10.0.2.1 dead:2::1 || exit 1
 check_drops || exit 1
diff --git a/tools/testing/selftests/net/netfilter/nft_nat_zones.sh b/tools/testing/selftests/net/netfilter/nft_nat_zones.sh
index 3b81d88bdde3..9f200f80253a 100755
--- a/tools/testing/selftests/net/netfilter/nft_nat_zones.sh
+++ b/tools/testing/selftests/net/netfilter/nft_nat_zones.sh
@@ -88,7 +88,6 @@ for i in $(seq 1 "$maxclients");do
   echo netns exec "$cl" sysctl -q net.ipv4.tcp_syn_retries=2
   echo netns exec "$gw" ip link set "veth$i" up
   echo netns exec "$gw" sysctl -q net.ipv4.conf.veth"$i".arp_ignore=2
-  echo netns exec "$gw" sysctl -q net.ipv4.conf.veth"$i".rp_filter=0
 
   # clients have same IP addresses.
   echo netns exec "$cl" ip addr add 10.1.0.3/24 dev eth0
@@ -178,7 +177,6 @@ fi
 
 ip netns exec "$gw" sysctl -q net.ipv4.conf.all.forwarding=1 > /dev/null
 ip netns exec "$gw" sysctl -q net.ipv6.conf.all.forwarding=1 > /dev/null
-ip netns exec "$gw" sysctl -q net.ipv4.conf.all.rp_filter=0 >/dev/null
 
 # useful for debugging: allows to use 'ping' from clients to gateway.
 ip netns exec "$gw" sysctl -q net.ipv4.fwmark_reflect=1 > /dev/null
diff --git a/tools/testing/selftests/net/netfilter/rpath.sh b/tools/testing/selftests/net/netfilter/rpath.sh
index 86ec4e68594d..24ad41d526d9 100755
--- a/tools/testing/selftests/net/netfilter/rpath.sh
+++ b/tools/testing/selftests/net/netfilter/rpath.sh
@@ -1,8 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-# return code to signal skipped test
-ksft_skip=4
+source lib.sh
 
 # search for legacy iptables (it uses the xtables extensions
 if iptables-legacy --version >/dev/null 2>&1; then
@@ -32,17 +31,10 @@ if [ -z "$iptables$ip6tables$nft" ]; then
 	exit $ksft_skip
 fi
 
-sfx=$(mktemp -u "XXXXXXXX")
-ns1="ns1-$sfx"
-ns2="ns2-$sfx"
-trap "ip netns del $ns1; ip netns del $ns2" EXIT
-
-# create two netns, disable rp_filter in ns2 and
-# keep IPv6 address when moving into VRF
-ip netns add "$ns1"
-ip netns add "$ns2"
-ip netns exec "$ns2" sysctl -q net.ipv4.conf.all.rp_filter=0
-ip netns exec "$ns2" sysctl -q net.ipv4.conf.default.rp_filter=0
+trap cleanup_all_ns EXIT
+
+# create two netns, keep IPv6 address when moving into VRF
+setup_ns ns1 ns2
 ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.keep_addr_on_down=1
 
 # a standard connection between the netns, should not trigger rp filter
-- 
2.46.0


