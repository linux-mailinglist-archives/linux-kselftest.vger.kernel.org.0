Return-Path: <linux-kselftest+bounces-23290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E221C9F02EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 04:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD7A188C16C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 03:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F0155C8C;
	Fri, 13 Dec 2024 03:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6FEX4AQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A062AD14;
	Fri, 13 Dec 2024 03:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734059324; cv=none; b=cUj5/HVnmT/bFmDOntPftOaunoEeCiT37GfzPcLxRdkGUZbUy0Z+Hoi6H9jwDcvwQEEG/wdPorEOPo/oI97QRX9gqrQQXcIsIb/25A/BxGvuYYvUvpyoSl0/D93zsMr1CwXpvQDXM+rJBGvBNMEaduZJep/lsNBiw8hPwLr0gRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734059324; c=relaxed/simple;
	bh=R2r5VR1MZp+C1ee1II+6AGWnQlsMAilEj+o98HzaGw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBpYZThvX9yy3kzBKQqJSxUV75drQfe9Seo4dyZP2cBy1ege5ZOytH8d0T1XsJUPQf0EtwrK9pjC1hCKVppI0ohrHotIVlRjbon5qvONtQQWvyApOWMGzVa9tW6AsuLg6vMNYGQmFausw/XWhRjM++44t7HJ+cTD/U9H909cH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6FEX4AQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728e3826211so1101309b3a.0;
        Thu, 12 Dec 2024 19:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734059321; x=1734664121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0141D1DdQp+tsQaVYpbPLhhiaLXBax7oWjUoMQDleTk=;
        b=U6FEX4AQvxjq+gE1E8/r4vXaR7/1N8hGKyZLaxlJmCeQVH8RyOBGEBzWRi2dJ2rsbj
         Ma2/FkPua/yBQaj7GS+cYgpIWucCqCxvrOXWIKDvstFifmFZ6oAHqBhnX/9AMYvSLyeV
         rOrENA2lnytmM9hOIkxtn3fvw+O6rm4Z3slTFqsiwFERnkpMLOZBe+YGo/kPh9aUjuEF
         OEIc+8Mz68hjPTUlHf3D137z6hrqYxihCy3PKS+GNrVgSvtz1IUGkMU3MYLHE+mZrl0q
         Cbs6nYLCUK6OfGoOkATi9/X8nVzqmgYYUY6lvbKME0KbpQvuP5BHyheW6Fwfz5f4aa/K
         qoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734059321; x=1734664121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0141D1DdQp+tsQaVYpbPLhhiaLXBax7oWjUoMQDleTk=;
        b=Xj6Vyr06ToQ6HfZoUHlyDPLzsA+C7bsW/1QMrc+/mEEQawuSP+rulTatodbTAi3xFy
         ZteccqjphvRF8jCODXSc31Wwnd7ikCu75Ik4rbMSI5AXLhiWiYXbMxQQxq+3wvd+yw0p
         Da31q7kko6VAhKGgk4gv6y7o2Q692hpPSwqObimH8uKYBwypSO2jKx9lJIF3yA2UGCpt
         bO8T7zoRoCfpQs4uWbs4vYP1nOw+hDtMcryypiIG35bV8XCWvw0LH+wCwIpdI1pjJBJP
         P6sQkP+P/8Q1j7RlHYgbs9q53NC6hZwgkYglz513COydKUUu9YWHi7sFiBXeTALcOrUc
         svPA==
X-Forwarded-Encrypted: i=1; AJvYcCWFIolE1mtICmXUsIkypZiRNzHGkAKWiENoZ5iNeMP88wcZ5oQRjM9NOcse+XDbJ6ZqlBY=@vger.kernel.org, AJvYcCWIwQ7X+m8FfPVDEb0qVKXfUGelHLX+i4qF0oKH/TSgwTGVu8A/shRwZy9mm58EqOXUbH/3f4qGHMbeN+aH@vger.kernel.org, AJvYcCXRhGdFiPNWHXHPCGfLcNrQ0IUm/W50sezFTtQb+dNt/9lJJcgDfxsve0LUsqT/og4SUWtCI4qQrQ0ZPSqzWBE6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4QsULW57aZUEcI+SCj/J9ZGp4iY6TY4F060DaoYbMJxJJ739
	EeYepTwkfySd1z+GjlkrXbiYnxTa3wk0Fn7Li9Gwjxt398MhYuzXgR2xfwvQ
X-Gm-Gg: ASbGncutS0TMLpDquXmbjCFTzgBiqpddVZFndjsM2pvWRLo1f6w2nUbbUY30RTqmGde
	o11Cupy7+7S5jf1bdwPF3ZKBl62DPQ7wUksr0T7CKQa/hftrmDalW8Snzz3CM4zLXfskEq58mJn
	k9IIHTDJixwa5/AU2T+iSjSU5rlQBIfn3QlSqiIBsRNrB8YrjL1SZgSBbPINj346PvvrTe/nk19
	B60go7s/ljzsO5hI6VQo7MiazZZKOpLifG07nR3X8jSIV6LXh4vUgjoo4IIw4EZqJqkKxO01nCD
X-Google-Smtp-Source: AGHT+IFwaEuEiShZQ9EkuL8vY+d6WcX6D011mfQ4qPyaC5++3ym4cXTj0vAYHMiFa2f9bs1njfKT+A==
X-Received: by 2002:a05:6a00:23cb:b0:725:456e:76e with SMTP id d2e1a72fcca58-7290c161ab8mr1563610b3a.6.1734059321482;
        Thu, 12 Dec 2024 19:08:41 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e4b13545sm9152783b3a.126.2024.12.12.19.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:08:41 -0800 (PST)
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
Subject: [PATCHv3 net-next 1/2] selftests: wireguards: convert iptables to nft
Date: Fri, 13 Dec 2024 03:08:18 +0000
Message-ID: <20241213030819.49987-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241213030819.49987-1-liuhangbin@gmail.com>
References: <20241213030819.49987-1-liuhangbin@gmail.com>
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
2.39.5 (Apple Git-154)


