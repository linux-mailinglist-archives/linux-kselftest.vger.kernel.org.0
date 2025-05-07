Return-Path: <linux-kselftest+bounces-32576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0748AAE08F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 15:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB463BCDC8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06087288C8B;
	Wed,  7 May 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqTk7sbS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B44287513;
	Wed,  7 May 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623988; cv=none; b=NddmqCuDm+JLhY8RS54HvI7c9ALy9/0Ugyx+tks/TnXAX7S91R7uOXl0QmrYv7TXtuQysX/6PI4vhUDlNDu0EzFB21LM/cXEAr9HRW1+k1h0GpSy4z7On5a/r4ZBAh+H4ry8aZOkOKnB0Bac9wXz0Vx4pDAFV48mb0X+M0IP64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623988; c=relaxed/simple;
	bh=lrL7QCxkalRPHwMpen3EmwhoJvDupaoSUwDZql/gvq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu1v7nkMIXzJGadbmfbVYxPBxrDA+pCEkPow5RJYgwHxM0CyVY0prWBiEEtiUUBjjsOwe/UxjYoAVA0uJMlR/5Vwanjlb0ojxWVdR587J2CvPAPEJ/ReHaI1eKoYdpg2HCzCZwljMfzhrjrJAjOsy6lv0JnyDdR4onVzaWB3+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqTk7sbS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2279915e06eso75187715ad.1;
        Wed, 07 May 2025 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623986; x=1747228786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqHokklDt23W8knG3MI9yzmJbveoaAKaHbHiDTuVpLI=;
        b=CqTk7sbSG+wQBcncDpH+maEUkIyVLsRkgcKTY/na+r2dFnjLRZ09dr+OOB+YGX1zar
         Yar0DPoqBn5Z4+z9vWTS4SgJk0BburU+OrJ1OcmrZ+u7MokFjxsrFdtRmtXnS6aztaF1
         yXTvjToiyh0iF6RjbmHka07bXtlEONPqaKZUm4PNsVnO7xOCAwHF/FeXCbF0iBgFvubD
         3vGUOSSwXsAP4iHk2GUR2EvGgmHJIM5wKj5HJQMj4INXB7J9VEsMYCbNpdTm87INP+2a
         NAucVMl0205uFDXC9LssJxq0Ef6bpQ0Q6lOYywx4fmIv64znDmPX7AIG0YKp1D/dSoTR
         RuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623986; x=1747228786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqHokklDt23W8knG3MI9yzmJbveoaAKaHbHiDTuVpLI=;
        b=dQ27EOzPAhIhaw/6h1WD7+CXFqrA4TA+/j0GeyRNsA8LrQmb5nekPKCJsfy7RKm6j5
         8L99kPfX5c0JjGMq6x4dby+jqjZ7hxIQHmIxCu62wd6tFejRfXseRgQhwO8r9hWnitxu
         7S6B6inOE/u4p/HnXWttVbhvo2uIN7l5P6ddnU+vvxYYGFVA6NvevxOWzJ+o01iYDkIH
         RKcs9oFr8XXEtjw8xPqv33Jl+wqMjE6hr/SJvWWRgeJOr96ONpwXuNyO/lV4SP/KWMnH
         H4m2rDJJZ4xhq74ILHLEU0oKUmfcw13LhDlDdQA8phr/rCCbhIY6MR3akFr6zBGVPksg
         dJQw==
X-Forwarded-Encrypted: i=1; AJvYcCUlpnuQ4RIhFr9RJfccNtGUkZ+IQLvgFooFarnedxQQ2s2aoparYQGA5LZn1kOBVzwamwemfspBZtE/7fgkTo7p@vger.kernel.org, AJvYcCX3hV93MD3S8hPNfSr/ul2N6/vDp/6vBEgat6/bNzpx/D1bdh+tl/+BIJpiYd1twGhwS6aiJBFcmj+3qsXuGyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIV79JJAf6OpuBJcK5E2jF2m+QWel/66jz6jJAi3uPWahGJKP8
	AIWSLgGqv0Of6YgY7X+81cjKnznztQC4xlzPqpp2LDG0lB7JJQpl4Ax52gYI
X-Gm-Gg: ASbGncuoMXvPYCigF6pspMeWzQXci33Wvh0TwNYGoCRuo4zPg/395VLSYwmhjf315ud
	O1NLwhbGaUrIAI28xqkssB6CticBdaE+PTYeSVW4UUWs0iHN41gx15O5hQNRlfzcN9o5AYA9p3i
	07ZxI9zLJe4uufLoyUTo3XWP6aenJbYCCCEX8egxOFX9DePLI6iAvTJ0zqkNzFxbKgcpTNN+pCK
	Pqdu70GWrijEvsAH6j7PxVKsxjFqYbfn/PT4YawjpK5R5DpgZxERecik4uPr12PM+yZUGECqR0N
	uiVSE023ZLkQs12QKL9MqXx1zaum8+tnMxStRW6soZlgCSdAflCW8tIdGhFM
X-Google-Smtp-Source: AGHT+IFfdJWCu3m1y8Hriw4GJJRUvamR/KXJqLxjtGe0UkNbJZ3QilajvtvjyVCu5nAM7PzRiGu+qQ==
X-Received: by 2002:a17:902:db0c:b0:223:6657:5008 with SMTP id d9443c01a7336-22e5ea7c30bmr54379525ad.24.1746623986211;
        Wed, 07 May 2025 06:19:46 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5e93ee88sm17414765ad.86.2025.05.07.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:19:45 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 5/6] selftests: netfilter: remove rp_filter configuration
Date: Wed,  7 May 2025 13:18:55 +0000
Message-ID: <20250507131856.78393-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250507131856.78393-1-liuhangbin@gmail.com>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the manual rp_filter configuration, as setup_ns already sets it
appropriately by default

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


