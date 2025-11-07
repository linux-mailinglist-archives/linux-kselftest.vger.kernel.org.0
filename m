Return-Path: <linux-kselftest+bounces-45083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4264BC3FAEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 12:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9893BADEF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79A431E10C;
	Fri,  7 Nov 2025 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTZ9qq47"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991112C9D;
	Fri,  7 Nov 2025 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514120; cv=none; b=SLpNqWo6FJupUgQMi31JNMqbnAMVk0mH6W74fcE4M6Dk6g3XNjIDB+2lyuasgBRRIlL9mxQx9P2EIXRe/rMfO1DvLlpUgSkjrLs8Qxb5t8BRBdChfASnCFkVfiZEIISm2ZR8zwAvkgVY/hHB4d49Fd6vusyfLuzIdzVjCZ3v/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514120; c=relaxed/simple;
	bh=5cj/A6jWTg9CGeFaP8lNPT4RwIIpZv9heQuMi37eu44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TUWRLYV3N+ZLTU2B1mm+utEt7xkEWvfHFRLNghGbLOjH7m09oWeoCotLkp538swKxkcSH5deLXUGTfifIK769t7SAXpE1toWVasO++Xex7jm+EZW4B9Q05FEUpOr/q8CDFYEBGue4myClc8eqxNhqyLjemvrSx2ZcGy2y3Lyr2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTZ9qq47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0D5C19422;
	Fri,  7 Nov 2025 11:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762514120;
	bh=5cj/A6jWTg9CGeFaP8lNPT4RwIIpZv9heQuMi37eu44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hTZ9qq47bRR2pKXRMjQ4i6dugsXMQQQxWRlKu3UQpQ4BbeF6OBfwEjpPyPXtsvKN6
	 bWkjtKmgt49+LmsL6MEAwuTR8u3YEoAE/Fa23md0mRP+pgE2hCoNONEee0XsNQdpjo
	 T7Dl9uPdwBnj7uYJI/I38B1Bbx39qfc+CL2YPe6wQ6BEjhWb5QfRe9FCKQVYWga5Ps
	 YUWyt+8zs5BF52LHTJJvHo5DhG+bA1G47gGQcQWJ5iVDQmUjXSXD5NOTOfbfdix+0b
	 Zy7FjNjif/bcl4dUf0vRrodvvu0Gx0pxsG3VrV83XmjL6Z9u2Zb0U9fpZSIIvI/Z1Q
	 oaJuJmj/z6Uhg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 07 Nov 2025 12:14:48 +0100
Subject: [PATCH nf-next v9 3/3] selftests: netfilter: nft_flowtable.sh: Add
 IPIP flowtable selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-nf-flowtable-ipip-v9-3-7cbc4090dfcb@kernel.org>
References: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
In-Reply-To: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Phil Sutter <phil@nwl.cc>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce specific selftest for IPIP flowtable SW acceleration in
nft_flowtable.sh

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../selftests/net/netfilter/nft_flowtable.sh       | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 45832df982950c2164dcb6637497870f0d3daefe..1fbfc8ad8dcdc5db2ab1a1ea9310f655d09eee83 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -558,6 +558,73 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 ""; then
 	ip netns exec "$nsr1" nft list ruleset
 fi
 
+# IPIP tunnel test:
+# Add IPIP tunnel interfaces and check flowtable acceleration.
+test_ipip() {
+if ! ip -net "$nsr1" link add name tun0 type ipip \
+     local 192.168.10.1 remote 192.168.10.2 >/dev/null;then
+	echo "SKIP: could not add ipip tunnel"
+	[ "$ret" -eq 0 ] && ret=$ksft_skip
+	return
+fi
+ip -net "$nsr1" link set tun0 up
+ip -net "$nsr1" addr add 192.168.100.1/24 dev tun0
+ip netns exec "$nsr1" sysctl net.ipv4.conf.tun0.forwarding=1 > /dev/null
+
+ip -net "$nsr2" link add name tun0 type ipip local 192.168.10.2 remote 192.168.10.1
+ip -net "$nsr2" link set tun0 up
+ip -net "$nsr2" addr add 192.168.100.2/24 dev tun0
+ip netns exec "$nsr2" sysctl net.ipv4.conf.tun0.forwarding=1 > /dev/null
+
+ip -net "$nsr1" route change default via 192.168.100.2
+ip -net "$nsr2" route change default via 192.168.100.1
+ip -net "$ns2" route add default via 10.0.2.1
+
+ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun0 accept'
+ip netns exec "$nsr1" nft -a insert rule inet filter forward \
+	'meta oif "veth0" tcp sport 12345 ct mark set 1 flow add @f1 counter name routed_repl accept'
+
+if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IPIP tunnel"; then
+	echo "FAIL: flow offload for ns1/ns2 with IPIP tunnel" 1>&2
+	ip netns exec "$nsr1" nft list ruleset
+	ret=1
+fi
+
+# Create vlan tagged devices for IPIP traffic.
+ip -net "$nsr1" link add link veth1 name veth1.10 type vlan id 10
+ip -net "$nsr1" link set veth1.10 up
+ip -net "$nsr1" addr add 192.168.20.1/24 dev veth1.10
+ip netns exec "$nsr1" sysctl net.ipv4.conf.veth1/10.forwarding=1 > /dev/null
+ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif veth1.10 accept'
+ip -net "$nsr1" link add name tun1 type ipip local 192.168.20.1 remote 192.168.20.2
+ip -net "$nsr1" link set tun1 up
+ip -net "$nsr1" addr add 192.168.200.1/24 dev tun1
+ip -net "$nsr1" route change default via 192.168.200.2
+ip netns exec "$nsr1" sysctl net.ipv4.conf.tun1.forwarding=1 > /dev/null
+ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun1 accept'
+
+ip -net "$nsr2" link add link veth0 name veth0.10 type vlan id 10
+ip -net "$nsr2" link set veth0.10 up
+ip -net "$nsr2" addr add 192.168.20.2/24 dev veth0.10
+ip netns exec "$nsr2" sysctl net.ipv4.conf.veth0/10.forwarding=1 > /dev/null
+ip -net "$nsr2" link add name tun1 type ipip local 192.168.20.2 remote 192.168.20.1
+ip -net "$nsr2" link set tun1 up
+ip -net "$nsr2" addr add 192.168.200.2/24 dev tun1
+ip -net "$nsr2" route change default via 192.168.200.1
+ip netns exec "$nsr2" sysctl net.ipv4.conf.tun1.forwarding=1 > /dev/null
+
+if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IPIP tunnel over vlan"; then
+	echo "FAIL: flow offload for ns1/ns2 with IPIP tunnel over vlan" 1>&2
+	ip netns exec "$nsr1" nft list ruleset
+	ret=1
+fi
+
+# Restore the previous configuration
+ip -net "$nsr1" route change default via 192.168.10.2
+ip -net "$nsr2" route change default via 192.168.10.1
+ip -net "$ns2" route del default via 10.0.2.1
+}
+
 # Another test:
 # Add bridge interface br0 to Router1, with NAT enabled.
 test_bridge() {
@@ -643,6 +710,8 @@ ip -net "$nsr1" addr add dead:1::1/64 dev veth0 nodad
 ip -net "$nsr1" link set up dev veth0
 }
 
+test_ipip
+
 test_bridge
 
 KEY_SHA="0x"$(ps -af | sha1sum | cut -d " " -f 1)

-- 
2.51.1


