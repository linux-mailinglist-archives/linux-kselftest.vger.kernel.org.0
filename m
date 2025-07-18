Return-Path: <linux-kselftest+bounces-37556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9CB0A0BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 12:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8455A6C83
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425912BD587;
	Fri, 18 Jul 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6+8K4R/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAB2BD020;
	Fri, 18 Jul 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834697; cv=none; b=cHTdh/rdihcSTQPVWunkpGBMV7dZceBMKbji0hrdyQwl7r0Sev8u44p41ZDXTKkFb9WAfaXt4WM0hV+R1uwvzyNz8RL6NTacXNuClNLn6fKCsAwMH5xAvlF85P0jIJuqzlT3fMu/E2aH+0kSDprMJGwr023vfjM9IS7ofG5TOW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834697; c=relaxed/simple;
	bh=sEjviTPRhYqGP5Y8/0bVLkQrZaSsat98TC4r3HprGO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OdXsJy4I1c9htD4jcnTm8LC/MyA1dZSKRD8Ez9fjQIg2ca7PBkWVP7BVJfb3ZttlJfeMU0fZ4X9ZOBJ/1jtsUQ/2wdNSHZMsxBd7AB7jhYvI+2xjKs6Vxay856Yhi375EgH9eCF8G2vS5Z1dPhpnTmcLhCSFYYM7n+rQ8FKwmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6+8K4R/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957EAC4CEEB;
	Fri, 18 Jul 2025 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752834696;
	bh=sEjviTPRhYqGP5Y8/0bVLkQrZaSsat98TC4r3HprGO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P6+8K4R/aQiAHJZcENTDsDygl+XhTW70pt2TM5h3mBsROKox48eAJ8mx5URZHNBdD
	 8gwymPTLu2ei7dPFyoU6sOsDBnNNGgju9ZYJUzQ7BgYpgZZrLX8RMax0lADS2hVRGx
	 +CHIGLl1QZ47VmtpvVrJj1dJ2a1Z6DE+KWUCWjVEIqa1tATXHX0TUzuaA8QbOr3g9h
	 BZ9h1QgbyF3wZOaqrqdP9SYhIE+e+pGl1jbGQM43TKiUP3pTk++YPGK9TxpfdVl4s4
	 D2YwkCQ4npPQEPW4y8FYftlyU2DcFSIAfyHm/qhWypktf0JR5M6zBH+bUyoXDLP9Sv
	 ZIGZsvyx6HCAQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 18 Jul 2025 12:31:07 +0200
Subject: [PATCH nf-next v4 2/2] selftests: netfilter: nft_flowtable.sh: Add
 IPIP flowtable selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-nf-flowtable-ipip-v4-2-f8bb1c18b986@kernel.org>
References: <20250718-nf-flowtable-ipip-v4-0-f8bb1c18b986@kernel.org>
In-Reply-To: <20250718-nf-flowtable-ipip-v4-0-f8bb1c18b986@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce specific selftest for IPIP flowtable SW acceleration in
nft_flowtable.sh

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../selftests/net/netfilter/nft_flowtable.sh       | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index a4ee5496f2a17cedf1ee71214397012c7906650f..d1c9d3eeda2c9874008f9d6de6cabaabea79b9fb 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -519,6 +519,44 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 ""; then
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
+# Restore the previous configuration
+ip -net "$nsr1" route change default via 192.168.10.2
+ip -net "$nsr2" route change default via 192.168.10.1
+ip -net "$ns2" route del default via 10.0.2.1
+}
+
 # Another test:
 # Add bridge interface br0 to Router1, with NAT enabled.
 test_bridge() {
@@ -604,6 +642,8 @@ ip -net "$nsr1" addr add dead:1::1/64 dev veth0 nodad
 ip -net "$nsr1" link set up dev veth0
 }
 
+test_ipip
+
 test_bridge
 
 KEY_SHA="0x"$(ps -af | sha1sum | cut -d " " -f 1)

-- 
2.50.1


