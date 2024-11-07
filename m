Return-Path: <linux-kselftest+bounces-21589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD389BFCC6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 03:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570F31F22808
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61EF69D31;
	Thu,  7 Nov 2024 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nolhQjdT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479F3FE4;
	Thu,  7 Nov 2024 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730948094; cv=none; b=tl1Jiz439uHPjqqlXc1MBP1b62jvBqVNUdji3foZaugPacT9/uz14j1bdap6PhkY9oKWjBnRe0V0TBBDBqKLyg9/NDlo5l8YPccbGV7pmQaqDAb9dGETSBdoC1zypHqaFQbzXaYXq4F7LkRTAVgz/nP8yV2oVHQ/fB7/awwS5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730948094; c=relaxed/simple;
	bh=l/ocFLDpfyJVwQEoJDaHuZiPX6X5+43tiVrRMmQmtFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T43scGnAKjI90LyLOp2EKzYs4PuNJEbvIM8VO6UsN6j1ZEdOCN7EIttL0jeuEQSQU+18pAsWBFPR4899l75e4kHQYz5Rb9GygokvHkEGo48+Lg3J8Bs+1njTqPqTj5/As5xYnJfpbb0/SKqSKSIchUX4FBS7Wz/Phh20Nct7auM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nolhQjdT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2110a622d76so3881995ad.3;
        Wed, 06 Nov 2024 18:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730948092; x=1731552892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kXUgljRAh0gr52NTMyiqOJGETbvRr4tGYCjS3T7hbU4=;
        b=nolhQjdTep9SvfunsHm+BoLovCO+q/k1Vauk9lu4cafIju8ZBQknHsi3689S8WmWPN
         V6+B1jbHG0d23ODx32aZiOXDaPIkL+oyFg2y5cmbEAY/sUQIW1tGPgYdWUbdr5j+X50P
         68ZfkmzRM63g7awdOMWFvXd2gPGuyDnka4D/APaj9hgSzIghm1o2bbJROb0LMgYURL11
         wbvhJ+NXN6KpXnZF8sAELJ93pLImXyIncBNEeOlvfnkyz24VMup2O9U3crMZcN3t4fKA
         coh9LetMqq9aXkRSz0otYX6gwgLVLpe8lfN5IyyfZKmpaEohyXasalwPCLsjO49uFerc
         WbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730948092; x=1731552892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXUgljRAh0gr52NTMyiqOJGETbvRr4tGYCjS3T7hbU4=;
        b=txRr/My6sZalXdr+CwAkmaEo9I7IL629ZuDxrrW2fOsg5K4Es404oedjeQEQ6yUoPe
         tY0biktpMyHrcXUQONIznE69gObJoexYXIil7Q0eO4N/D4vK9K42FjW/In2Arlome8D0
         E0tLRFvO+Iw8W8ed40a4AW6JMeQzBQbhT0qGOUli5DhaIVM4iCKOj0toOwHX+uQ9ArVQ
         FPNaHq/XQSlut26Gp2yc9lQrYMqs16t1jHTrmbYV64LnbG7fr90KbAlxXvA8LoBZoTx9
         t20Bs1mIYq4cFF/Uv6piIlrgC1geTtoDj6wGQeISqqOhjc5xHUCtWpm9R11Zpm7GdRiO
         VcJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnA2D/IKMas3l5CgdIZ30vWP6tB5Qm8BdwMj8pNe4uL0L1invcE51heRgizN5meqLGBcNjWGxPPlKo8zM=@vger.kernel.org, AJvYcCWQDxowYl1r1oNwWctIaSrAgWP0FIdQXxZgmH7L8xs/5QBO9bLMQ+Z17EClBcizqW7s9aXQ9qHhVrXP5M9n3TvA@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtDSL0GlQhjO+ORmwiiYP+KpQHkdTAegBsi9plasPGUjevVTm
	JlomnLVP5feOlq8j/8cQCDPbgTl3V9bxIxj5C3xW5RI5iOUGLkMkA73M24qnskQ=
X-Google-Smtp-Source: AGHT+IHvh3IYq+Pk+cmQrRzRR2//8ZHBrqmgQAH00s2k4zSSPfdKFWQy6LEZZKd5gwHxfEhFKXPnUA==
X-Received: by 2002:a17:903:189:b0:20f:c225:f28c with SMTP id d9443c01a7336-210c6c9417amr568555575ad.52.1730948092394;
        Wed, 06 Nov 2024 18:54:52 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177de041dsm1910365ad.103.2024.11.06.18.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:54:51 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] selftests: wireguards: use nft by default
Date: Thu,  7 Nov 2024 02:54:38 +0000
Message-ID: <20241107025438.3766-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use nft by default if it's supported, as nft is the replacement for iptables,
which is used by default in some releases. Additionally, iptables is dropped
in some releases.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
CC nft developers to see if there are any easier configurations,
as I'm not very familiar with nft commands.
---
 tools/testing/selftests/wireguard/netns.sh | 63 ++++++++++++++++++----
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
index 405ff262ca93..4e29c1a7003c 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -44,6 +44,7 @@ sleep() { read -t "$1" -N 1 || true; }
 waitiperf() { pretty "${1//*-}" "wait for iperf:${3:-5201} pid $2"; while [[ $(ss -N "$1" -tlpH "sport = ${3:-5201}") != *\"iperf3\",pid=$2,fd=* ]]; do sleep 0.1; done; }
 waitncatudp() { pretty "${1//*-}" "wait for udp:1111 pid $2"; while [[ $(ss -N "$1" -ulpH 'sport = 1111') != *\"ncat\",pid=$2,fd=* ]]; do sleep 0.1; done; }
 waitiface() { pretty "${1//*-}" "wait for $2 to come up"; ip netns exec "$1" bash -c "while [[ \$(< \"/sys/class/net/$2/operstate\") != up ]]; do read -t .1 -N 0 || true; done;"; }
+use_nft() { nft --version &> /dev/null; }
 
 cleanup() {
 	set +e
@@ -196,13 +197,23 @@ ip1 link set wg0 mtu 1300
 ip2 link set wg0 mtu 1300
 n1 wg set wg0 peer "$pub2" endpoint 127.0.0.1:2
 n2 wg set wg0 peer "$pub1" endpoint 127.0.0.1:1
-n0 iptables -A INPUT -m length --length 1360 -j DROP
+if use_nft; then
+	n0 nft add table inet filter
+	n0 nft add chain inet filter INPUT { type filter hook input priority filter \; policy accept \; }
+	n0 nft add rule inet filter INPUT meta length 1360 counter drop
+else
+	n0 iptables -A INPUT -m length --length 1360 -j DROP
+fi
 n1 ip route add 192.168.241.2/32 dev wg0 mtu 1299
 n2 ip route add 192.168.241.1/32 dev wg0 mtu 1299
 n2 ping -c 1 -W 1 -s 1269 192.168.241.1
 n2 ip route delete 192.168.241.1/32 dev wg0 mtu 1299
 n1 ip route delete 192.168.241.2/32 dev wg0 mtu 1299
-n0 iptables -F INPUT
+if use_nft; then
+	n0 nft delete table inet filter
+else
+	n0 iptables -F INPUT
+fi
 
 ip1 link set wg0 mtu $orig_mtu
 ip2 link set wg0 mtu $orig_mtu
@@ -334,7 +345,13 @@ waitiface $netns2 veths
 n0 bash -c 'printf 1 > /proc/sys/net/ipv4/ip_forward'
 n0 bash -c 'printf 2 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout'
 n0 bash -c 'printf 2 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout_stream'
-n0 iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -d 10.0.0.0/24 -j SNAT --to 10.0.0.1
+if use_nft; then
+	n0 nft add table inet nat
+	n0 nft add chain inet nat POSTROUTING { type nat hook postrouting priority srcnat\; policy accept \; }
+	n0 nft add rule inet nat POSTROUTING ip saddr 192.168.1.0/24 ip daddr 10.0.0.0/24 counter snat to 10.0.0.1
+else
+	n0 iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -d 10.0.0.0/24 -j SNAT --to 10.0.0.1
+fi
 
 n1 wg set wg0 peer "$pub2" endpoint 10.0.0.100:2 persistent-keepalive 1
 n1 ping -W 1 -c 1 192.168.241.2
@@ -348,10 +365,20 @@ n1 wg set wg0 peer "$pub2" persistent-keepalive 0
 # Test that sk_bound_dev_if works
 n1 ping -I wg0 -c 1 -W 1 192.168.241.2
 # What about when the mark changes and the packet must be rerouted?
-n1 iptables -t mangle -I OUTPUT -j MARK --set-xmark 1
+if use_nft; then
+	n1 nft add table inet mangle
+	n1 nft add chain inet mangle OUTPUT { type route hook output priority mangle\; policy accept \; }
+	n1 nft add rule inet mangle OUTPUT counter meta mark set 0x1
+else
+	n1 iptables -t mangle -I OUTPUT -j MARK --set-xmark 1
+fi
 n1 ping -c 1 -W 1 192.168.241.2 # First the boring case
 n1 ping -I wg0 -c 1 -W 1 192.168.241.2 # Then the sk_bound_dev_if case
-n1 iptables -t mangle -D OUTPUT -j MARK --set-xmark 1
+if use_nft; then
+	n1 nft delete table inet mangle
+else
+	n1 iptables -t mangle -D OUTPUT -j MARK --set-xmark 1
+fi
 
 # Test that onion routing works, even when it loops
 n1 wg set wg0 peer "$pub3" allowed-ips 192.168.242.2/32 endpoint 192.168.241.2:5
@@ -385,16 +412,32 @@ n1 ping -W 1 -c 100 -f 192.168.99.7
 n1 ping -W 1 -c 100 -f abab::1111
 
 # Have ns2 NAT into wg0 packets from ns0, but return an icmp error along the right route.
-n2 iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -d 192.168.241.0/24 -j SNAT --to 192.168.241.2
-n0 iptables -t filter -A INPUT \! -s 10.0.0.0/24 -i vethrs -j DROP # Manual rpfilter just to be explicit.
+if use_nft; then
+	n2 nft add table inet nat
+	n2 nft add chain inet nat POSTROUTING { type nat hook postrouting priority srcnat\; policy accept \; }
+	n2 nft add rule inet nat POSTROUTING ip saddr 10.0.0.0/24 ip daddr 192.168.241.0/24 counter snat to 192.168.241.2
+
+	n0 nft add table inet filter
+	n0 nft add chain inet filter INPUT { type filter hook input priority filter \; policy accept \; }
+	n0 nft add rule inet filter INPUT iifname "vethrs" ip saddr != 10.0.0.0/24 counter drop
+else
+	n2 iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -d 192.168.241.0/24 -j SNAT --to 192.168.241.2
+	n0 iptables -t filter -A INPUT \! -s 10.0.0.0/24 -i vethrs -j DROP # Manual rpfilter just to be explicit.
+fi
 n2 bash -c 'printf 1 > /proc/sys/net/ipv4/ip_forward'
 ip0 -4 route add 192.168.241.1 via 10.0.0.100
 n2 wg set wg0 peer "$pub1" remove
 [[ $(! n0 ping -W 1 -c 1 192.168.241.1 || false) == *"From 10.0.0.100 icmp_seq=1 Destination Host Unreachable"* ]]
 
-n0 iptables -t nat -F
-n0 iptables -t filter -F
-n2 iptables -t nat -F
+if use_nft; then
+	n0 nft delete table inet nat
+	n0 nft delete table inet filter
+	n2 nft delete table inet nat
+else
+	n0 iptables -t nat -F
+	n0 iptables -t filter -F
+	n2 iptables -t nat -F
+fi
 ip0 link del vethrc
 ip0 link del vethrs
 ip1 link del wg0
-- 
2.46.0


