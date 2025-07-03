Return-Path: <linux-kselftest+bounces-36436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 473D3AF7718
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69001CA077A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A922E9ED7;
	Thu,  3 Jul 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhOJVEuz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A22E7F05;
	Thu,  3 Jul 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552216; cv=none; b=HRecLmNVjtwgPvzvs1U6OM4+6YpZ6jd3eOGXoReERBIfT9VOFfsjQjhAN/cH4YMxtTw/YqsyCQLwY4ALayZueDD5wtoBQdogE6xofMAkW74SReA/vb1HThW90Q+/kq1ktZLdybMDz9MBo3UUHeR8HC8gNOtYMe4bAfOsC50VtIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552216; c=relaxed/simple;
	bh=Z+KvS/dxZP26cr6F6SDuJm7LA9twCDJWcy1WXdpB8xU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bq+7K5Oh2111d1MsH6/pL0obG/TqZdvhoximO3S7m8KSysxxWD86uWjLV411rAsT5/g0/IlootyfPwEeQ5mwq5RMlDkCb8kfydwdoJD+KcIwdsGDJC8BprSxiuFk5enrm2bIAxGQXOP3ZjcfX67yrgABs9SleLf6wMp3Uvidd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhOJVEuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43913C4CEED;
	Thu,  3 Jul 2025 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751552215;
	bh=Z+KvS/dxZP26cr6F6SDuJm7LA9twCDJWcy1WXdpB8xU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KhOJVEuznJ1wqT+0SQw4lmkmZ+tr7yk8JaHHmApuIzFPOGyFmlx4ApXr7i7475qdY
	 k41e3tbCK/y9gSQQJmTl5emyt0WnAS5YgdmB8TLELBu8nJkNL0AEKNZOXR2ZPPl/B8
	 Gili6xy3GUAbUSbG7scQsC5rQUEQkl+7UUUdw3zKw6AT0Ah2R2/YqJB9nQySOikhyZ
	 AFSZhN1VlJv3hFthIZg5EbmMrhzrASheUWh+W3Xrd7hQEaRIhMqx6DUSQJPo3pL+W7
	 8Ko4J0faOZVi2eeVr7abvmHOAj3O7NADOByvtH5BXvoHetvpRgS6q5l86JtMfwoUqB
	 lUC49pJ7E3dIw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 03 Jul 2025 16:16:03 +0200
Subject: [PATCH nf-next v3 2/2] selftests: netfilter: nft_flowtable.sh: Add
 IPIP flowtable selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-nf-flowtable-ipip-v3-2-880afd319b9f@kernel.org>
References: <20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org>
In-Reply-To: <20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
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
2.50.0


