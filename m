Return-Path: <linux-kselftest+bounces-33833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2001AAC46BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 05:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA4318946E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 03:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14E19F11B;
	Tue, 27 May 2025 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO8d4bnx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98172DCBF0;
	Tue, 27 May 2025 03:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748316415; cv=none; b=sFgQCin97Xh7T+yum2Mq04vSBg1Ejac4WHk5I3Ip6Hxsilao1gF+ogzA5IoDM5SzC9HpeADmlT0Dw0+srZ6vcmCBRK4HJ5VsHqYzazaZ9LE+sqK5FopEieWnDflMyeJjVEZYsobyxoNKGEF6UIQAtvqXswXj4TUicA940aKAEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748316415; c=relaxed/simple;
	bh=2csU+79UdMjWyhK9Iv2wecuNUMlZMFfRyVTWj9zto78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXEcHVFQQXrIajYLwAaedgqhgs3+H33k8QagMeOKkLoSM9wB9QaTzEvM12leMU2+fDpMeKOe9mWB6xWX9SgFm5XhaHcIIH1O3cRqclIBMpi4uL/USXsJbpe0w7b9vE5gWR/VIU0+mEviHy7BkMNUuJP+pk5g8OMiRGfDL6IWU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO8d4bnx; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso1818110b3a.2;
        Mon, 26 May 2025 20:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748316412; x=1748921212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7d+kcHAwN3g2veRIP35/Cx+qKGOfglBxZ9UJox5e0Y=;
        b=NO8d4bnxAnL+F9I7p7nytSORxtmNci75CCI1a1s+tUtLZbyatiuAr15v/kkd9SeJ55
         DEZKFHPNpsVrkJfQvaVkamHyhj4RoWvDZxG1oe/WQjQAeC+gDzOHYBiinolPfjE9VqU3
         PcxbH3sSyVWTJenXpAYmRsLNMnhOO0/hWRB00hxsk6Sprn5Q8j5i8kOegT5RtzbNsjVR
         QpesjezLLIOJioVhzj36NYt3I2Z61H/dGHjfsT0E4zQEpemItDZ1QT6WBHkuVQJL717V
         7apll/tJq9ybv28tqfDj4nmvZ/4kVxfAPL1iv3+aqlUirt7hN1Ww/J50zZegZ/QwJdW6
         /E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748316412; x=1748921212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7d+kcHAwN3g2veRIP35/Cx+qKGOfglBxZ9UJox5e0Y=;
        b=LHvYqjRcyTEXjn/yPox8f8GxYC9ZNCywY8eez2uRZXWlU/b7baWlFDl/WBQlS3vmJ1
         WDh3NOaJSb/Y9eHSz5KW8Q47hmPOTDJ2D3lsd+WFs6DPHX45V+nrGeaEigRq1E7DYtPE
         2dBYIARGRku1vwTKXVxFDM/MHSV4ynpXdVAdgPm3etHXnqxn6Dy4QPxphX5827qC9PFk
         t3vpcN+yJGkQ/N+he2ZQevckqWJfXUceFU8G5kqy4XKWe5WnJNSpBas/SVt4bPgXA50S
         Lzoh52NBQOR6DE7J46lY8i/XssBVR3tVx6JSMO1c3/AYsJzkA3jV7mJ8Z2/4MXtVEXcv
         XVqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlfM858ory/6jPGKzOLcGL+WA3/iX4sRjpk73dzUQEJ/k8kExNf4ug6o6d/E+hDDqGi75+ZbheVGZ/b3c=@vger.kernel.org, AJvYcCWMKdnYsXpb/UoeVfmk+ExS1g7+S5stZf1+eEZ6DZlEmoPx7od2iBgy+axl5stCfDG28F4EM6Hpqgjqk/MND5ND@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/KVFI7WBiFYtRdtzCtIBM38TS+as524kiI3oCVg7jvPuyTO8
	+94Qikd/51q/3s7eVGdUplUAmTRB3gMlzIEFx8BMKhA1hG0zq8BQR7hpsTD5uyqXQEpGWg==
X-Gm-Gg: ASbGnctZV8JPaUCRD5/0A4sW92yFtitgcNmC5zUXRJwrLzT+ZkL3kL4Y7JQnseptVix
	VNzNuuo940K8Ur84V0ESkM7S3OONp6dFbB5PJxc+JZNlt5DOcuknhZ0nbEZdOUsdyRsGQsV4ZKw
	JQ+9vinARlnVRR/McWJTRwSpOy07nT4TxJLNGp9DT0132IPBqADiJqaT/s/wUeTGn1b9UPlzbpY
	ZWowe6I1InBxWI53CACeBDMrvuVJL07yI8kUKuq8CygNY0/22xd1mea3xYXu9RZkQqszGd3CeQu
	qMTeot2KqcBCZF5obgUANx/mYSDxumnx9pDMHPgIFGLNO6HQ3GFJGXD+oA/z8HfWRPwxGqT/qO9
	4zWPqIw==
X-Google-Smtp-Source: AGHT+IGm5Z446VlQptWidK7f486g8CKnUCNZzW4L3XG0SUf3L5vvYXvByrkhOdRBa0b00ccZqaQmJg==
X-Received: by 2002:a05:6a00:1383:b0:742:da7c:3f27 with SMTP id d2e1a72fcca58-745fdb4c492mr16903913b3a.0.1748316412177;
        Mon, 26 May 2025 20:26:52 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74622b3b481sm865926b3a.131.2025.05.26.20.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 20:26:51 -0700 (PDT)
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
Subject: [PATCHv7 RESEND wireguard 1/2] wireguard: selftests: convert iptables to nft
Date: Tue, 27 May 2025 03:26:34 +0000
Message-ID: <20250527032635.10361-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250527032635.10361-1-liuhangbin@gmail.com>
References: <20250527032635.10361-1-liuhangbin@gmail.com>
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


