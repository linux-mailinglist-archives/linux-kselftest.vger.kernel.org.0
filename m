Return-Path: <linux-kselftest+bounces-47295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89200CAF271
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 08:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C303E3008BC7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE532877FE;
	Tue,  9 Dec 2025 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwNIe1QP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8C296BCD;
	Tue,  9 Dec 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265770; cv=none; b=QmAB/DJRc+B5EH8pVk9C2gfN1DvuEpNFSUvwODTcalSxLTMGfTpaEBcmUiXWidZnY17LfWQCXRZbNEJveshuAA2sHmZA7GBFM2NYwymSTUMWZNz9XGYhxPCAoD+zw4bfY9JkUPGNb1ZtkykPr4ZE8NdD5HP8APgySnaXI3rQowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265770; c=relaxed/simple;
	bh=VjDGUTom6je4dVzwHm2KOd5tgoOEnl0QV5kY0rsBtfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMvxU9V1JXaDff8P3kgzyL3LknKTdyaEXhqPB2Bea4ioiqdeV/4XD//QCjM2Dr8XBXXqdidF87+ptBKS626QX/Qyz02y+DoCEiMEePpp8M+/gu24865U2yYK9q2tUuxgT1CYkmWRIsgwu4pwIFJfGPyTTDYAzRHrM3e0qCV9PRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwNIe1QP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76672C4CEFB;
	Tue,  9 Dec 2025 07:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765265769;
	bh=VjDGUTom6je4dVzwHm2KOd5tgoOEnl0QV5kY0rsBtfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dwNIe1QP7aUfee4HmmJU/eK0s8d7qwhrXdv3oJcNnN65kmjSXJg/M8s+GsP2hxWGQ
	 WtQSYtCfE8MXJZzR+3LQqQk06CNfmvZEPk+I7qMqyYM5k66N3n98RwbnNc86kUFKqT
	 wG2ThU80u0j0tybip3nnSxxrhjGXP+fakbS/qhZqfLYi/7JRpUbUEFzpKKGG9/yCX9
	 M9F2YDRzRfJ/Cq8h3fKQButt0Jj2kbwQIq9Apflv7tF0Jzx8fj5oXtQukPZ1DI+XQO
	 Zn0iG5WLHdsp5GKBkt0vegXD5r56mBcxxE3n0gOjvzhmKJfOf08OLIy0V3PYrCd9S5
	 6odAddYESHboQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 09 Dec 2025 08:35:34 +0100
Subject: [PATCH nf-next v2 4/4] selftests: netfilter: nft_flowtable.sh: Add
 IP6IP6 flowtable selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-b4-flowtable-offload-ip6ip6-v2-4-44817f1be5c6@kernel.org>
References: <20251209-b4-flowtable-offload-ip6ip6-v2-0-44817f1be5c6@kernel.org>
In-Reply-To: <20251209-b4-flowtable-offload-ip6ip6-v2-0-44817f1be5c6@kernel.org>
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
index 24b4e60b91451e7ea7f6a041b0335233047c6242..bc98baba56c638cad35478109a3776d6d93c34a8 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -590,16 +590,28 @@ ip -net "$nsr1" link set tun0 up
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
 
@@ -609,28 +621,51 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IPIP tunnel"; then
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
@@ -638,10 +673,19 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IPIP tunnel over vlan"; then
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


