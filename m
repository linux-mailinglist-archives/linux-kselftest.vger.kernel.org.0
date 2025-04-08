Return-Path: <linux-kselftest+bounces-30339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB514A7F79C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 10:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B221897500
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E6E264610;
	Tue,  8 Apr 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG6qFarC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64732641E9;
	Tue,  8 Apr 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744100243; cv=none; b=H0y4KEwLTEQtJt1MlntBMqvgAVNnF4vHYjeI2/DcXUxPdO8OH7ZVtmVH0ZSFbiUI8jSvWClJvj6RoDOi2oSXv1jomFcHzdHcKr0pGhnuDIFxjfrR6+Pdj04AD7uC3Ra5egq1l/OoRDIB0KMl7Z+f8y48fIyl73Hw/856ib1zUMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744100243; c=relaxed/simple;
	bh=2csU+79UdMjWyhK9Iv2wecuNUMlZMFfRyVTWj9zto78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOPQUkgYb5kt8kq4dSIUEKB1Lh9OIcNmvhkAHVObR/gByRIl7zusvaVXLxrOAW44xwWuLwUisXN/1yiOwlhAK9nA2zNmoTyHfbyRws3akuQMy1vM0wTX1nXV1GBJr8uvBCB574KP2ZSjeZN0cNZ3EoLidkb0OOQGYe3ke/6hktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG6qFarC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225477548e1so48765295ad.0;
        Tue, 08 Apr 2025 01:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744100237; x=1744705037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7d+kcHAwN3g2veRIP35/Cx+qKGOfglBxZ9UJox5e0Y=;
        b=mG6qFarCOby/Zj+J+e5XgFHNyPJZoueeXj8uEHLsp8vZkgXf+YzGFegrVFwAL5/oJK
         LJj2se3lFy1OyfeV824Qjti6ls/Nj/enXpYLa3grxS3K7XN9Pg0jJiRmoDaWPF/f0Lsk
         AiNGCBBQCNVqPV9BhSwTeh6HvMHlGFLmN5s9h1ca34Y9YHAWXsd18c0eTTj/ZEC9hRvp
         kKk6BRQnx3GnF1iboDV5U6cxyH/5IubbEdGcUiRfAcbNW2NIWcvO6YP1EHtODROMWPhq
         QRCrl343NIy3MNUJlc/5JtrmNQlJbIAj5Bl1ILKKu4TKIY8VT24a2+9AvW10bbcKyB4v
         nSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744100237; x=1744705037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7d+kcHAwN3g2veRIP35/Cx+qKGOfglBxZ9UJox5e0Y=;
        b=NHq9+ZVNObiPn1y/O4g3Pg0KubRGAZWkAypQfqUJ2JOeyIkcwmCk/sYKmvjMRaWXpT
         A6xUVKU4GVfLo74ROKI5RHFe48DVyeFzArg3vcJo6m7Rp6gCOgbz+qC38z31FL9ImMdS
         a0p29t6rUQa/MTEXRDEgXywnYvpgZZN/MceyioJrwbmyoKjFRGcSnoftKAEQ6BjvwuG1
         EcYJBb1kdiB9On7Q2UaI4LaKaaoB6BVqSc3sgjmPYa7sX/fhB4WOMe3okvjwSd/ctfQy
         bXCffFLsQnkxpy7DvCh3E9BXXS17kHYC2kI2mNr6DRxFb8fOQ3KMp1gITCnKUik34YPG
         zhZA==
X-Forwarded-Encrypted: i=1; AJvYcCUEpGHCgxnXyhTNFquFuvFMMiIcz2eQe7GtgrXumGE8nl74wWPFCGP9ahNi1Qp7GtqTEbx7UlWMPRX49T8=@vger.kernel.org, AJvYcCUzjE0PzSh083jxWfRDLIRdE5LCLWIrSDoDHo7jrcM5uBrrqX2/HzMco+K19hb5oSkq0VCFi9YfrovERlvOkV9i@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsCvq+ckAv4PL+Qzbn0ms607Te6HdLvXwiJI3zZV6AEMjW7WU
	wnORMTEJ7qjW4ECahc3UFwNR+g3lYUkuvI3x9dmMBEFjKufE+DBdZSNTockqml8=
X-Gm-Gg: ASbGncuwHT9TMcoAc+FY1D8KV4AeuiSBO06/AVMCS1nHxxNXdnW1BLqukV0UkoQKN4v
	nNfs9mm21luBUVWB3yVB8QhlIQFisybjnzJ8nOIhPsZachYxgwK3Mx9qB9+YRt0bc5fwDGj241i
	lFhEXSc0N1Dz5bm+mgFdxBJ0qU34Bbv+Kdt47zkewNNmzbRuI7ljXlZxEKS2t5Jf7VwyQgz05oz
	VwrDNl3QtNP4amIFl3vdT65nYRqZaNkIG8PYXx0l/HziWpCoBWImsIeB+Dnle2iBHWncnHTmH1g
	KsuGLpXuERtdilEP3921IIDn85EvGv1AUOJF3fjFrMlyDkeZZqpwy6sxu6YwKReH26yNMA==
X-Google-Smtp-Source: AGHT+IFhbmP2Y/X1Y+SFXIUub7l0AG/Zk7maUw6wnkw48Kd+ctJdyuBAxMTAkuTD1VllYRNhyEWJ+A==
X-Received: by 2002:a17:902:e809:b0:220:cb1a:da5 with SMTP id d9443c01a7336-22a8a8cec34mr230595595ad.40.1744100236572;
        Tue, 08 Apr 2025 01:17:16 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ada20sm94319535ad.46.2025.04.08.01.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:17:16 -0700 (PDT)
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
Subject: [PATCHv6 net-next 1/2] wireguard: selftests: convert iptables to nft
Date: Tue,  8 Apr 2025 08:16:51 +0000
Message-ID: <20250408081652.1330-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250408081652.1330-1-liuhangbin@gmail.com>
References: <20250408081652.1330-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the selftest to nft as it is the replacement for iptables, which
is used by default in most releases.

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


