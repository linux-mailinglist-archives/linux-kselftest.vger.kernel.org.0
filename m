Return-Path: <linux-kselftest+bounces-46807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61426C97B5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 14:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778453A3764
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0463731AF1A;
	Mon,  1 Dec 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo7SHJAM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61B31A056;
	Mon,  1 Dec 2025 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596746; cv=none; b=ZnoRj3B7UkaeGrVh+N6zp1xXKaBBXeMxwrmN8trL4xvxFHM50Af9Fg7Vih+iHWuOQI/BXEu24TNDW5hUDyQRbd2yqaKDTN6ofpAC1gEb2fUgDHiQr547qRoSF4y+hvFZRR3jOpAXPt0Bq0Et12YN4HBE6S7eix9CbCOivLo8pWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596746; c=relaxed/simple;
	bh=uf1IVAK+4qXnG1e2iSB6f8OKCY+QuyeTE2vUwglOFvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U18DFeysxZ+aXnMQgnpf11hkadISkDN97bDzO96x8lh2ZbvhcsJIhE/miu/hGOnX4zuCu9SO/AhMN2MDefpLWKcl0hAZlwFwT1lRyHox9rF1/oKmVTV0LmOtGPpIPYgTNNaEPVRl6Pumngq8W+bC07APzsd1G8xI+5GXM/AyBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo7SHJAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D78FC4CEF1;
	Mon,  1 Dec 2025 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764596746;
	bh=uf1IVAK+4qXnG1e2iSB6f8OKCY+QuyeTE2vUwglOFvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bo7SHJAMSCClG/S7BHOqzW1O6QyHJbLxCrPxizG7BCGoS5wVC12r3bSYvCAG1dBOx
	 Ud79kznZ+uJKICwBX05TIiaJeqImKg0XqnZhO4Df8Hw6/8nfUfLu6q6c1aG0ZrGV8q
	 pTIsXHrr9K4yd+DAYoWb5jgRZ8pITY0nRyvXF6pD8K2agavDxdZinBioCUgCiGNlqZ
	 IyR74KO41psuWhLb9Gi7bEZy/CHSChazM/GyVH6fU4X34JEDc/9RqRi2iQ1Tg0tBW3
	 1QuA4LDYAMQsCg8i6wqtYW4wbeFQjZ5ex6pD+jyK0g6QSzw0p39eFWTTFHQ2BkUCjs
	 NCtuqBtuTfghA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 01 Dec 2025 14:45:16 +0100
Subject: [PATCH RFC nf-next 4/4] selftests: netfilter: nft_flowtable.sh:
 Add IP6IP6 flowtable selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-flowtable-offload-ip6ip6-v1-4-1dabf534c074@kernel.org>
References: <20251201-flowtable-offload-ip6ip6-v1-0-1dabf534c074@kernel.org>
In-Reply-To: <20251201-flowtable-offload-ip6ip6-v1-0-1dabf534c074@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Similar to IPIP, introduce specific selftest for IP6IP6 flowtable SW
acceleration in nft_flowtable.sh

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../selftests/net/netfilter/nft_flowtable.sh       | 62 ++++++++++++++++++----
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index a68bc882fa4ec0175d8db3df8337bb5fe6c42e26..14d7f67715edc17ee1917913a3d0f417215200ba 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -592,16 +592,28 @@ ip -net "$nsr1" link set tun0 up
 ip -net "$nsr1" addr add 192.168.100.1/24 dev tun0
 ip netns exec "$nsr1" sysctl net.ipv4.conf.tun0.forwarding=1 > /dev/null
 
+ip -net "$nsr1" link add name tun6 type ip6tnl local fee1:2::1 remote fee1:2::2
+ip -net "$nsr1" link set tun6 up
+ip -net "$nsr1" addr add fee1:3::1/64 dev tun6 nodad
+
 ip -net "$nsr2" link add name tun0 type ipip local 192.168.10.2 remote 192.168.10.1
 ip -net "$nsr2" link set tun0 up
 ip -net "$nsr2" addr add 192.168.100.2/24 dev tun0
 ip netns exec "$nsr2" sysctl net.ipv4.conf.tun0.forwarding=1 > /dev/null
 
+ip -net "$nsr2" link add name tun6 type ip6tnl local fee1:2::2 remote fee1:2::1
+ip -net "$nsr2" link set tun6 up
+ip -net "$nsr2" addr add fee1:3::2/64 dev tun6 nodad
+
 ip -net "$nsr1" route change default via 192.168.100.2
 ip -net "$nsr2" route change default via 192.168.100.1
+ip -6 -net "$nsr1" route change default via fee1:3::2
+ip -6 -net "$nsr2" route change default via fee1:3::1
 ip -net "$ns2" route add default via 10.0.2.1
+ip -6 -net "$ns2" route add default via dead:2::1
 
 ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun0 accept'
+ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun6 accept'
 ip netns exec "$nsr1" nft -a insert rule inet filter forward \
 	'meta oif "veth0" tcp sport 12345 ct mark set 1 flow add @f1 counter name routed_repl accept'
 
@@ -611,28 +623,51 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IPIP tunnel"; then
 	ret=1
 fi
 
+if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
+	echo "PASS: flow offload for ns1/ns2 IP6IP6 tunnel"
+else
+	echo "FAIL: flow offload for ns1/ns2 with IP6IP6 tunnel" 1>&2
+	ip netns exec "$nsr1" nft list ruleset
+	ret=1
+fi
+
 # Create vlan tagged devices for IPIP traffic.
 ip -net "$nsr1" link add link veth1 name veth1.10 type vlan id 10
 ip -net "$nsr1" link set veth1.10 up
 ip -net "$nsr1" addr add 192.168.20.1/24 dev veth1.10
+ip -net "$nsr1" addr add fee1:4::1/64 dev veth1.10 nodad
 ip netns exec "$nsr1" sysctl net.ipv4.conf.veth1/10.forwarding=1 > /dev/null
 ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif veth1.10 accept'
-ip -net "$nsr1" link add name tun1 type ipip local 192.168.20.1 remote 192.168.20.2
-ip -net "$nsr1" link set tun1 up
-ip -net "$nsr1" addr add 192.168.200.1/24 dev tun1
+
+ip -net "$nsr1" link add name tun0.10 type ipip local 192.168.20.1 remote 192.168.20.2
+ip -net "$nsr1" link set tun0.10 up
+ip -net "$nsr1" addr add 192.168.200.1/24 dev tun0.10
 ip -net "$nsr1" route change default via 192.168.200.2
-ip netns exec "$nsr1" sysctl net.ipv4.conf.tun1.forwarding=1 > /dev/null
-ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun1 accept'
+ip netns exec "$nsr1" sysctl net.ipv4.conf.tun0/10.forwarding=1 > /dev/null
+ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun0.10 accept'
+
+ip -net "$nsr1" link add name tun6.10 type ip6tnl local fee1:4::1 remote fee1:4::2
+ip -net "$nsr1" link set tun6.10 up
+ip -net "$nsr1" addr add fee1:5::1/64 dev tun6.10 nodad
+ip -6 -net "$nsr1" route change default via fee1:5::2
+ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun6.10 accept'
 
 ip -net "$nsr2" link add link veth0 name veth0.10 type vlan id 10
 ip -net "$nsr2" link set veth0.10 up
 ip -net "$nsr2" addr add 192.168.20.2/24 dev veth0.10
+ip -net "$nsr2" addr add fee1:4::2/64 dev veth0.10 nodad
 ip netns exec "$nsr2" sysctl net.ipv4.conf.veth0/10.forwarding=1 > /dev/null
-ip -net "$nsr2" link add name tun1 type ipip local 192.168.20.2 remote 192.168.20.1
-ip -net "$nsr2" link set tun1 up
-ip -net "$nsr2" addr add 192.168.200.2/24 dev tun1
+
+ip -net "$nsr2" link add name tun0.10 type ipip local 192.168.20.2 remote 192.168.20.1
+ip -net "$nsr2" link set tun0.10 up
+ip -net "$nsr2" addr add 192.168.200.2/24 dev tun0.10
 ip -net "$nsr2" route change default via 192.168.200.1
-ip netns exec "$nsr2" sysctl net.ipv4.conf.tun1.forwarding=1 > /dev/null
+ip netns exec "$nsr2" sysctl net.ipv4.conf.tun0/10.forwarding=1 > /dev/null
+
+ip -net "$nsr2" link add name tun6.10 type ip6tnl local fee1:4::2 remote fee1:4::1
+ip -net "$nsr2" link set tun6.10 up
+ip -net "$nsr2" addr add fee1:5::2/64 dev tun6.10 nodad
+ip -6 -net "$nsr2" route change default via fee1:5::1
 
 if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IPIP tunnel over vlan"; then
 	echo "FAIL: flow offload for ns1/ns2 with IPIP tunnel over vlan" 1>&2
@@ -640,10 +675,19 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IPIP tunnel over vlan"; then
 	ret=1
 fi
 
+if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
+	echo "PASS: flow offload for ns1/ns2 IP6IP6 tunnel over vlan"
+else
+	echo "FAIL: flow offload for ns1/ns2 with IP6IP6 tunnel over vlan" 1>&2
+	ip netns exec "$nsr1" nft list ruleset
+	ret=1
+fi
+
 # Restore the previous configuration
 ip -net "$nsr1" route change default via 192.168.10.2
 ip -net "$nsr2" route change default via 192.168.10.1
 ip -net "$ns2" route del default via 10.0.2.1
+ip -6 -net "$ns2" route del default via dead:2::1
 }
 
 # Another test:

-- 
2.52.0


