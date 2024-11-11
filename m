Return-Path: <linux-kselftest+bounces-21755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7D19C3777
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 05:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A500B1F21002
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 04:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035AA12EBDB;
	Mon, 11 Nov 2024 04:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsVtSAjT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648C3E47B;
	Mon, 11 Nov 2024 04:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298759; cv=none; b=piHEfbIdXYpH62yIDQnhY5VX6x8HBddKYzSSxdUM0d5iNx2vYC32cEeAwukxPowlNWqFIWkYqbOUeN3nGMgoFoHcioLAM/SOqXwPrWJF0nqZpD6k8Z2hC2PhdB1g4N6fXB4iTHeACgjje5H3DLlqUZoU4ZUQThAV+KLKVdPA9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298759; c=relaxed/simple;
	bh=3zNEk1RHfDs0/4BxH1nL5UqMRVRCYZGXggiJ4hvUKfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jtSk13dO+ATmn+gi4y3CwrEb3y45GYuSdeE87RWK+Xn/hpYSvDeSjaqd6NMVTN+6uEaFcbDR1GOyElcCzPAkF2pzkKnpSqnOt+AFzsYUH21snSrH3Lg0ngrRf+oHf9rRHJcvnW+wj3Uj6KO37Ud7N6H9TRu7z6Z+tXwvmJI50UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsVtSAjT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7240fa50694so2820460b3a.1;
        Sun, 10 Nov 2024 20:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731298757; x=1731903557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kfYr0e+lfSP5A5S7yQYeLHhETZcSLDUVzUjAyoz5V4=;
        b=YsVtSAjTXcFQDBiKMjfjecZ5PKCz//iwOqP91qVe5fy0oyxH84np+MF2U0vcPs4Fr7
         MKsjDJpxO4isuqR0dlx4R31tAh65KnlxhAIF98MXU/q3v1iFBfz5ieXPeOkTlMz+Q9W9
         ivAEvprm9cnPvmCr54AlzMqTfOKjFJ3i1z2mguiCHLex/DsKMAEqXBRd/UdTCJcaMSL5
         41iBbyiDBrnyXyHwlBzdrdQ91jxfuzpE/+Gln7WQtp1LVBStoQn2rcjuzeaAVlce3vC/
         0CASJW6Y8PMCc50zBxcR+dIo6MLr8fJLxaxeoPB/ylhZj5oP4jzkIMcEXIv78PZEI2dp
         /Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298757; x=1731903557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kfYr0e+lfSP5A5S7yQYeLHhETZcSLDUVzUjAyoz5V4=;
        b=GSZtWaQnu8zJOoC3Hpkx0YyJSQGS5I8mwKNmw8KhgKiIn9esbmFDr0B0uwoFMcwb13
         FE26IayHXfp1MY3VeH1HaNk2WtNrrPNzg6tONmvyN9fXnlqayrstU5D0GfKOahZwPRg+
         kV9/+C6BdIlaLIu0Nhdr/oZAauysPWZECz4J5RmeMun2iaxdY06C7je/9XDM64OzWSeA
         UM1Vbui0ann6IIpdmdb/twQwXnsJHXMoZ/Fx4Ev/HLLXtpPpkvXqp/kvGyfyR/02G2/f
         a6gBKmpe6oJtCK74s95lxe+FBHbdAThnPZaF0tRyFPZcjMBQfsg04xvErZuEtVrNWTyR
         G5vg==
X-Forwarded-Encrypted: i=1; AJvYcCV/kP11VCotiIZlJJDsiO0BEvseM/Jx7kPaL+qRnWX7h3DYhYcrRk6/SN2/6jHV5FH+4cFPy2PmIugxF2WLJ7NH@vger.kernel.org, AJvYcCWsbR3IpuQ2zPUjej4nRkcrpSDS/rcpBXFOC+5b/a5LJQ3uX5qANUMtETG+VveAv/zUGxIl6T5M8DqX/NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjxEEuAv/4nY73EvU6MA0xPQe2A+RQvp3hrQHwjQDr5l3gk0Nl
	HnljDrdtfTkfLDUE1yycD+V6z3ExsXCJYNwPvVUMUfmhnKl9hyB3iGlXhgoGNq6Z1A==
X-Google-Smtp-Source: AGHT+IF/Oz2jJGRqfqTHsKPVq3hRoDvVlN+qOnlYNHsdLV1V8ulh0CgVqEmmwxZX+osclR1I9VSBoQ==
X-Received: by 2002:a05:6a20:c890:b0:1db:e328:dd13 with SMTP id adf61e73a8af0-1dc2294ae47mr15124117637.11.1731298757269;
        Sun, 10 Nov 2024 20:19:17 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a62bd09sm9635460a91.46.2024.11.10.20.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:19:16 -0800 (PST)
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
Subject: [PATCHv2 net-next] selftests: wireguards: use nft by default
Date: Mon, 11 Nov 2024 04:19:02 +0000
Message-ID: <20241111041902.25814-1-liuhangbin@gmail.com>
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
v2: use one nft table for testing (Phil Sutter)
---
 tools/testing/selftests/wireguard/netns.sh | 63 ++++++++++++++++++----
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
index 405ff262ca93..be4e3b13ed22 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -44,6 +44,7 @@ sleep() { read -t "$1" -N 1 || true; }
 waitiperf() { pretty "${1//*-}" "wait for iperf:${3:-5201} pid $2"; while [[ $(ss -N "$1" -tlpH "sport = ${3:-5201}") != *\"iperf3\",pid=$2,fd=* ]]; do sleep 0.1; done; }
 waitncatudp() { pretty "${1//*-}" "wait for udp:1111 pid $2"; while [[ $(ss -N "$1" -ulpH 'sport = 1111') != *\"ncat\",pid=$2,fd=* ]]; do sleep 0.1; done; }
 waitiface() { pretty "${1//*-}" "wait for $2 to come up"; ip netns exec "$1" bash -c "while [[ \$(< \"/sys/class/net/$2/operstate\") != up ]]; do read -t .1 -N 0 || true; done;"; }
+use_nft() { nft --version &> /dev/null; }
 
 cleanup() {
 	set +e
@@ -75,6 +76,12 @@ pp ip netns add $netns1
 pp ip netns add $netns2
 ip0 link set up dev lo
 
+if use_nft; then
+	n0 nft add table ip wgtest
+	n1 nft add table ip wgtest
+	n2 nft add table ip wgtest
+fi
+
 ip0 link add dev wg0 type wireguard
 ip0 link set wg0 netns $netns1
 ip0 link add dev wg0 type wireguard
@@ -196,13 +203,22 @@ ip1 link set wg0 mtu 1300
 ip2 link set wg0 mtu 1300
 n1 wg set wg0 peer "$pub2" endpoint 127.0.0.1:2
 n2 wg set wg0 peer "$pub1" endpoint 127.0.0.1:1
-n0 iptables -A INPUT -m length --length 1360 -j DROP
+if use_nft; then
+	n0 nft add chain ip wgtest INPUT { type filter hook input priority filter \; policy accept \; }
+	n0 nft add rule ip wgtest INPUT meta length 1360 counter drop
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
+	n0 nft flush table ip wgtest
+else
+	n0 iptables -F INPUT
+fi
 
 ip1 link set wg0 mtu $orig_mtu
 ip2 link set wg0 mtu $orig_mtu
@@ -334,7 +350,12 @@ waitiface $netns2 veths
 n0 bash -c 'printf 1 > /proc/sys/net/ipv4/ip_forward'
 n0 bash -c 'printf 2 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout'
 n0 bash -c 'printf 2 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout_stream'
-n0 iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -d 10.0.0.0/24 -j SNAT --to 10.0.0.1
+if use_nft; then
+	n0 nft add chain ip wgtest POSTROUTING { type nat hook postrouting priority srcnat\; policy accept \; }
+	n0 nft add rule ip wgtest POSTROUTING ip saddr 192.168.1.0/24 ip daddr 10.0.0.0/24 counter snat to 10.0.0.1
+else
+	n0 iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -d 10.0.0.0/24 -j SNAT --to 10.0.0.1
+fi
 
 n1 wg set wg0 peer "$pub2" endpoint 10.0.0.100:2 persistent-keepalive 1
 n1 ping -W 1 -c 1 192.168.241.2
@@ -348,10 +369,19 @@ n1 wg set wg0 peer "$pub2" persistent-keepalive 0
 # Test that sk_bound_dev_if works
 n1 ping -I wg0 -c 1 -W 1 192.168.241.2
 # What about when the mark changes and the packet must be rerouted?
-n1 iptables -t mangle -I OUTPUT -j MARK --set-xmark 1
+if use_nft; then
+	n1 nft add chain ip wgtest OUTPUT { type route hook output priority mangle\; policy accept \; }
+	n1 nft add rule ip wgtest OUTPUT counter meta mark set 0x1
+else
+	n1 iptables -t mangle -I OUTPUT -j MARK --set-xmark 1
+fi
 n1 ping -c 1 -W 1 192.168.241.2 # First the boring case
 n1 ping -I wg0 -c 1 -W 1 192.168.241.2 # Then the sk_bound_dev_if case
-n1 iptables -t mangle -D OUTPUT -j MARK --set-xmark 1
+if use_nft; then
+	n1 nft flush table ip wgtest
+else
+	n1 iptables -t mangle -D OUTPUT -j MARK --set-xmark 1
+fi
 
 # Test that onion routing works, even when it loops
 n1 wg set wg0 peer "$pub3" allowed-ips 192.168.242.2/32 endpoint 192.168.241.2:5
@@ -385,16 +415,29 @@ n1 ping -W 1 -c 100 -f 192.168.99.7
 n1 ping -W 1 -c 100 -f abab::1111
 
 # Have ns2 NAT into wg0 packets from ns0, but return an icmp error along the right route.
-n2 iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -d 192.168.241.0/24 -j SNAT --to 192.168.241.2
-n0 iptables -t filter -A INPUT \! -s 10.0.0.0/24 -i vethrs -j DROP # Manual rpfilter just to be explicit.
+if use_nft; then
+	n2 nft add chain ip wgtest POSTROUTING { type nat hook postrouting priority srcnat\; policy accept \; }
+	n2 nft add rule ip wgtest POSTROUTING ip saddr 10.0.0.0/24 ip daddr 192.168.241.0/24 counter snat to 192.168.241.2
+
+	n0 nft add chain ip wgtest INPUT { type filter hook input priority filter \; policy accept \; }
+	n0 nft add rule ip wgtest INPUT iifname "vethrs" ip saddr != 10.0.0.0/24 counter drop
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
+	n0 nft flush table ip wgtest
+	n2 nft flush table ip wgtest
+else
+	n0 iptables -t nat -F
+	n0 iptables -t filter -F
+	n2 iptables -t nat -F
+fi
 ip0 link del vethrc
 ip0 link del vethrs
 ip1 link del wg0
-- 
2.39.5 (Apple Git-154)


