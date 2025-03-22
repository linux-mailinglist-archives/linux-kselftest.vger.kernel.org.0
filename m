Return-Path: <linux-kselftest+bounces-29601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65CA6C8BD
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 10:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC00461E68
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83AD1EF099;
	Sat, 22 Mar 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKBkVP1S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EDC189906;
	Sat, 22 Mar 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635837; cv=none; b=K9ZCifyQDuWrrmaeDfIsSE5I5f/CNqyQQkm1F0ikScv3BI0TuQHCSiVznnDvd17gNivn9GNkaqMDiamZ/Ul6GHlGEF7gaGQ6ixZjcYY7BvN6143FYfGQlISKvAqnXPimMRz7SnaR6WhWDOoyGxdJ8G9IEvy165NBQ/dsh55lthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635837; c=relaxed/simple;
	bh=i8jhyyhbNnA4yBKbEn2ulgGZm9nMPIaIcmhOUCi0wQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeDDUpNg2tcNbxGZBKLr4KW2CpmZe/e5VFHEFirMdtP8QFCpPf3dVwg7UZpE4JbQ3YWg+xS8gClQValQjQv9XWAf8y3LWfVvW50MosNjqd6bS/83qH3GuxH2K9yXGXj+ydwY3KZl4/zgFzLTDmjTO8GM5e9HWyxBDpNV9j02nGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKBkVP1S; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so6516057a91.3;
        Sat, 22 Mar 2025 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742635835; x=1743240635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYlKZE9UJnaRT7kMVH6+xaMxoSeKZ6SzIVE9oWOvkzc=;
        b=BKBkVP1S0DCKyprOn9uUD0bqoUIAYQJ9pfKjD2Tgtmm8tKBoOLb2dHTaHs1FCaN1/9
         zdxwrmCuOmr7wf++S8GeXJFoo91wp51G5FxnqYUcjnfUahk2CmDIj7FR84dTMlhnulbO
         A5l109HxbMB0XCpqtJlZiuqwIM2frITBYiiqNZXWjW76pyTcjYORweYmMKT26LBSHi08
         xrR2M6blMrVajhD4Qljm3gmUbVYE8zuUF0xMBEge69BBwyhkOJI6z4uKtOgfPlTJaNLg
         /siN3B+lk5E2+e5DXoWk8dENcI9fJ0gzBa+SbJGY7u+mvoHo3f6pHc1TdSTukLLnSXEm
         IOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742635835; x=1743240635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYlKZE9UJnaRT7kMVH6+xaMxoSeKZ6SzIVE9oWOvkzc=;
        b=jZoWBgHX83v8Bi11nqmRjfrDh1TRU30rKdZxsFxRIKklU34DFSE/I4dVkKof8fX4ZW
         r/OUumyUSBin0WYB/kXyPVkf7CF+whTUOm8aeE5mPvEVP0ZKMLRjxKuIe6HpPgFz2jvB
         3jinsWvWSfEyHhnd1e9lsRjgE+dOxopct4gAstuMvmbgwErIjWw2x6HwmVMA4Zk9ztAv
         S11Y3y0hQ10jF30lldlW02iGWwrpNx5lROT5IICug/rU40LmMKS+WLyaSJsKtbyjyudT
         VJ2eQb+OtoOZiEStoFUJ0Lyiw6tYQB9AYGbtoPb66zBxPJ5+pz3D9U/80O074r/aY+AQ
         CJmw==
X-Forwarded-Encrypted: i=1; AJvYcCUHaXEP/VHcgOnBb0Hv4KnEYv2860JDoun3wyYTiwxdyEYHogl65gtAN7OB3GlVBpkUbMF+xw5bIDZg8kA=@vger.kernel.org, AJvYcCUs/X8/j+lXzZnuH04RNFnIfWPGiHvckSWYl/6timNiNPcuKmiToPMBGRligR/nNRnEMIYezcdT+Hm5XvYx+hCL@vger.kernel.org
X-Gm-Message-State: AOJu0YwykjDWgx/L7NsXuAXKqPTi71jEHifSsf2g4GMglyLBJB38x8z4
	skZ9EzJ8qGCA91J8uhuxTa4+EnLFT6tQW3C5QgvSLEPGy2wdV438wKgl3bbLG8E=
X-Gm-Gg: ASbGncveMmbNOo2+0KCJjyp0sUNXRuxMmKLU6MS5FDC39actxX+nQeXRRxjCVZCvlAU
	PP90rh8Kuye0QbG+go49REP0lddK5wKjB7pVn7mnn15z0cNTJZhyRve4ANNfUEm+T8Q3lBeK+AE
	nLGBE5E+UGX+Ra25yb6LkmRlGbWsL0/eG8jNb1AL35zKLNshKeKoOze4jI1Tu4mSr+5U2AuyTs7
	wal7rNvfRY4rLA/gY6/aal1cqRAIQedBCo4g9lhAP/Iyv3yzJHM2BdhKlb/456GFXOEhgsN5elG
	f8xe4puoT9gp6FiZ/pf31tBz1/F6b7JDrurQKfDF9Q3STDWSAw/nu+/+wac/g7DG
X-Google-Smtp-Source: AGHT+IFFoDgW94IqMFuD5xPsW2g+L36vxjn2Z1ZQrVDMoaXROPEGQvlatPJle7KLNzW0K4vOSv9koA==
X-Received: by 2002:a17:90b:2b8b:b0:2ff:6608:78e2 with SMTP id 98e67ed59e1d1-3030feaf364mr10992263a91.16.1742635835020;
        Sat, 22 Mar 2025 02:30:35 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf58c24esm8452440a91.20.2025.03.22.02.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 02:30:34 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>,
	wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv5 net-next 1/2] wireguard: selftests: convert iptables to nft
Date: Sat, 22 Mar 2025 09:30:15 +0000
Message-ID: <20250322093016.16631-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250322093016.16631-1-liuhangbin@gmail.com>
References: <20250322093016.16631-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iptabels to nft as it is the replacement for iptables, which is used
by default in most releases.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/wireguard/netns.sh | 29 ++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
index 55500f901fbc..8b840fef90af 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -75,6 +75,11 @@ pp ip netns add $netns1
 pp ip netns add $netns2
 ip0 link set up dev lo
 
+# init nft tables
+n0 nft add table ip wgtest
+n1 nft add table ip wgtest
+n2 nft add table ip wgtest
+
 ip0 link add dev wg0 type wireguard
 ip0 link set wg0 netns $netns1
 ip0 link add dev wg0 type wireguard
@@ -196,13 +201,14 @@ ip1 link set wg0 mtu 1300
 ip2 link set wg0 mtu 1300
 n1 wg set wg0 peer "$pub2" endpoint 127.0.0.1:2
 n2 wg set wg0 peer "$pub1" endpoint 127.0.0.1:1
-n0 iptables -A INPUT -m length --length 1360 -j DROP
+n0 nft add chain ip wgtest INPUT { type filter hook input priority filter \; policy accept \; }
+n0 nft add rule ip wgtest INPUT meta length 1360 drop
 n1 ip route add 192.168.241.2/32 dev wg0 mtu 1299
 n2 ip route add 192.168.241.1/32 dev wg0 mtu 1299
 n2 ping -c 1 -W 1 -s 1269 192.168.241.1
 n2 ip route delete 192.168.241.1/32 dev wg0 mtu 1299
 n1 ip route delete 192.168.241.2/32 dev wg0 mtu 1299
-n0 iptables -F INPUT
+n0 nft flush table ip wgtest
 
 ip1 link set wg0 mtu $orig_mtu
 ip2 link set wg0 mtu $orig_mtu
@@ -335,7 +341,8 @@ n0 bash -c 'printf 1 > /proc/sys/net/ipv4/ip_forward'
 [[ -e /proc/sys/net/netfilter/nf_conntrack_udp_timeout ]] || modprobe nf_conntrack
 n0 bash -c 'printf 2 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout'
 n0 bash -c 'printf 2 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout_stream'
-n0 iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -d 10.0.0.0/24 -j SNAT --to 10.0.0.1
+n0 nft add chain ip wgtest POSTROUTING { type nat hook postrouting priority srcnat\; policy accept \; }
+n0 nft add rule ip wgtest POSTROUTING ip saddr 192.168.1.0/24 ip daddr 10.0.0.0/24 snat to 10.0.0.1
 
 n1 wg set wg0 peer "$pub2" endpoint 10.0.0.100:2 persistent-keepalive 1
 n1 ping -W 1 -c 1 192.168.241.2
@@ -349,10 +356,11 @@ n1 wg set wg0 peer "$pub2" persistent-keepalive 0
 # Test that sk_bound_dev_if works
 n1 ping -I wg0 -c 1 -W 1 192.168.241.2
 # What about when the mark changes and the packet must be rerouted?
-n1 iptables -t mangle -I OUTPUT -j MARK --set-xmark 1
+n1 nft add chain ip wgtest OUTPUT { type route hook output priority mangle\; policy accept \; }
+n1 nft add rule ip wgtest OUTPUT meta mark set 0x1
 n1 ping -c 1 -W 1 192.168.241.2 # First the boring case
 n1 ping -I wg0 -c 1 -W 1 192.168.241.2 # Then the sk_bound_dev_if case
-n1 iptables -t mangle -D OUTPUT -j MARK --set-xmark 1
+n1 nft flush table ip wgtest
 
 # Test that onion routing works, even when it loops
 n1 wg set wg0 peer "$pub3" allowed-ips 192.168.242.2/32 endpoint 192.168.241.2:5
@@ -386,16 +394,17 @@ n1 ping -W 1 -c 100 -f 192.168.99.7
 n1 ping -W 1 -c 100 -f abab::1111
 
 # Have ns2 NAT into wg0 packets from ns0, but return an icmp error along the right route.
-n2 iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -d 192.168.241.0/24 -j SNAT --to 192.168.241.2
-n0 iptables -t filter -A INPUT \! -s 10.0.0.0/24 -i vethrs -j DROP # Manual rpfilter just to be explicit.
+n2 nft add chain ip wgtest POSTROUTING { type nat hook postrouting priority srcnat\; policy accept \; }
+n2 nft add rule ip wgtest POSTROUTING ip saddr 10.0.0.0/24 ip daddr 192.168.241.0/24 snat to 192.168.241.2
+n0 nft add chain ip wgtest INPUT { type filter hook input priority filter \; policy accept \; }
+n0 nft add rule ip wgtest INPUT iifname "vethrs" ip saddr != 10.0.0.0/24 drop
 n2 bash -c 'printf 1 > /proc/sys/net/ipv4/ip_forward'
 ip0 -4 route add 192.168.241.1 via 10.0.0.100
 n2 wg set wg0 peer "$pub1" remove
 [[ $(! n0 ping -W 1 -c 1 192.168.241.1 || false) == *"From 10.0.0.100 icmp_seq=1 Destination Host Unreachable"* ]]
 
-n0 iptables -t nat -F
-n0 iptables -t filter -F
-n2 iptables -t nat -F
+n0 nft flush table ip wgtest
+n2 nft flush table ip wgtest
 ip0 link del vethrc
 ip0 link del vethrs
 ip1 link del wg0
-- 
2.46.0


