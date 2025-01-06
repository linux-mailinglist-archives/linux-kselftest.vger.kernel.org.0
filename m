Return-Path: <linux-kselftest+bounces-23939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACB0A0206F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 09:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDDD1638D3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28B61D89F0;
	Mon,  6 Jan 2025 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGK7oBNH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BDB1A2631;
	Mon,  6 Jan 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151066; cv=none; b=M19Pk8WNyOwFO7FrRFH22d7Q9q6UcnsczH2AUSTFsD414T8b6lx+n29/JBz6j756a5YLFvpVyNv0r2ssNRTTWRSV6wTV9MkPAFBp72mJ8CQoQcGhw1YsNDd7WsxudtvJCGqjz60Gt2JJ5bB3E7G8SSBnBx+KVQiUxH8rZFy3NY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151066; c=relaxed/simple;
	bh=LKxm8dLW5jrrtlfgHgYORSlmS4PbVo1Xj5j5FWeMogY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYb0bunrET7n0tDp8Iig/6K2FFc0DIVmeMBjNi6ha7bAPuzwkpl17bnc/b/2wZXXB2RIo/AldwFsB8BHVPcz19Mv/1yINbzBimwkxPo+IpYmrB+kkSAbhviJHZ2WH+v9F3dJL0iPLXe6nSkvutaqkZCtrLqUwaYl0kbXchmwbUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGK7oBNH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2164b662090so175892775ad.1;
        Mon, 06 Jan 2025 00:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736151064; x=1736755864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnm8/1ru5mWA8QP24vCMz+S2YuEXrjIdcwPRZfDzES0=;
        b=MGK7oBNHsIKU50P98249DlUew1MDhDzIhItEQVF9ExPXiKFBefNhhmOSzMJ04GeKRG
         3I5yVCCtBh+GSiq01p9kzJB+RVNEXpik7fWhKL0GouhCn7+pYI/2eOrF0Ugc68nDJGP5
         /CgbbGuO7+JuT1rQqWz3B8xLvUJFczakiS46xL4mCE1yhoyfCowAfthpkQAujER6GIkp
         yNWwHj7PR71nqztet0OALHZh/RqPdwAr1E04u6oR35NKQBN+qd7K8Cp5O+qnmnO8yGUo
         CYN/duQMEF5BzU8PNTaeQqLwsA28ZeiKVDBoJnuWBrUuz14cwfU4Ipe3bfIITSnLNniz
         xKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736151064; x=1736755864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnm8/1ru5mWA8QP24vCMz+S2YuEXrjIdcwPRZfDzES0=;
        b=oKcqLTe/PR4OQ/icsFQ4sYkAw5+xxkhKTmRi1otpkG4mgCEZTIrBd+NsctNQ37L8GD
         OyZ1sZRhtUnHw/tHaUuR8GnBNSqfecKynOF270oTef27dgohxvXjlT7RNNOLpGY9Y0JR
         n3PlNhSehxgNwyAhSe1BHhE3JO7qSqNqFOEdT6O/NbMfiZjPBOVYyuZ7yUVJCXLJ4PES
         d0el2Y5ReFe/C8OPDnHw8fD2A4VR/MPruzP4ZE8uZ1CklW2KYhaMwV29bpTVY6G8u4J8
         DAtdd1go9xSSUijTIpGO+bpFdS+c1oZPaM3kuuGK4f5Ke/SZGnH8adbV6f+WFPwNyTcr
         x4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5XzRjmU37Hr3oQJRTHD5m3FMFnPJp3NGlu0vq4x7tMJBtuczCEOzhcG39ycwd/zR8B0TFIJ0Z5IbZuNYU7WmQ@vger.kernel.org, AJvYcCWLceGFnYbbAtrrcJyEme4hh1urZVDS9E66YEus3XFMpAoTn4LwtRe8K/tsBU8JGxhQnwH3iimnD7mJUFBk@vger.kernel.org, AJvYcCXaK8OmtTgpiUidyUvm4PN2wuMNiLkQTKECGnQ1AdaZyhO8z3a1iKXyprce/FDDqOVAQic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRwscbNziU8ie5nFNIxlO2bEntnmWUNSxc9tjb8TVzXbCI/ZR
	mgkSCR+lFMPvNYsHJPEf6BqY7Jd3tE04yFu0stYr3Oxbd14tUOS5n04lyQ==
X-Gm-Gg: ASbGncsJX0yS4irDt1714OwcozcfrPH4ApXPOK+ZLos0bG13J5+k9oeBY6swRKMb9x5
	h9ka8JmDblzNok/90VfddydhNmyhgQTLj4hg4Gx3fGUjxXxregQXxKmJ/4RvRP2SUipoLeHepZ3
	CkvOEREEDYV866eYnFdjmuTio7/zocPbwnj9eYxramQS/zr2NPHBYFyUhie3h1FHbWkp/rTkbZr
	617ZfGxZBRltcungHNObOt2yofiDD6M4td5Z2qAFrC9955K0rV6iuAX8CqT3hY/fqa+4LhyTT4p
X-Google-Smtp-Source: AGHT+IF9J4WZwXUUDanCj4p2aJeSviCqzCuKbMZU0vMQD/WyTGbYs8vjN7TCz1zOkBjzv4JP8Wr2Kw==
X-Received: by 2002:a05:6a00:6387:b0:72b:5a7a:e5a6 with SMTP id d2e1a72fcca58-72b5a7ae7edmr20980424b3a.26.1736151063865;
        Mon, 06 Jan 2025 00:11:03 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad835469sm31910429b3a.60.2025.01.06.00.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 00:11:03 -0800 (PST)
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
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 RESEND net-next 1/2] selftests: wireguards: convert iptables to nft
Date: Mon,  6 Jan 2025 08:10:42 +0000
Message-ID: <20250106081043.2073169-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250106081043.2073169-1-liuhangbin@gmail.com>
References: <20250106081043.2073169-1-liuhangbin@gmail.com>
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
index 55500f901fbc..4032384e6747 100755
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
+n0 nft add rule ip wgtest INPUT meta length 1360 counter drop
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
+n0 nft add rule ip wgtest POSTROUTING ip saddr 192.168.1.0/24 ip daddr 10.0.0.0/24 counter snat to 10.0.0.1
 
 n1 wg set wg0 peer "$pub2" endpoint 10.0.0.100:2 persistent-keepalive 1
 n1 ping -W 1 -c 1 192.168.241.2
@@ -349,10 +356,11 @@ n1 wg set wg0 peer "$pub2" persistent-keepalive 0
 # Test that sk_bound_dev_if works
 n1 ping -I wg0 -c 1 -W 1 192.168.241.2
 # What about when the mark changes and the packet must be rerouted?
-n1 iptables -t mangle -I OUTPUT -j MARK --set-xmark 1
+n1 nft add chain ip wgtest OUTPUT { type route hook output priority mangle\; policy accept \; }
+n1 nft add rule ip wgtest OUTPUT counter meta mark set 0x1
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
+n2 nft add rule ip wgtest POSTROUTING ip saddr 10.0.0.0/24 ip daddr 192.168.241.0/24 counter snat to 192.168.241.2
+n0 nft add chain ip wgtest INPUT { type filter hook input priority filter \; policy accept \; }
+n0 nft add rule ip wgtest INPUT iifname "vethrs" ip saddr != 10.0.0.0/24 counter drop
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


