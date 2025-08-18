Return-Path: <linux-kselftest+bounces-39216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E0AB29D3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27D84E4F5D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721FE30DEC8;
	Mon, 18 Aug 2025 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sO7VKKYX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BE30DD13;
	Mon, 18 Aug 2025 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508107; cv=none; b=TJoRfn4n7x/1jesCvVVFVAqAjexLZDd/MgTy8qAIekWd+/qXZebhMYnshB4hXuNJrOx1wJPIk17NityRW4SG0aEbF2KpwFGMTbpfDmAXePE2FCP+5WEI7gDKlya2PgQcGNV7IumHLrinb7vyMe+mo+Us0uoXz2TaW5zdoqrzodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508107; c=relaxed/simple;
	bh=sEjviTPRhYqGP5Y8/0bVLkQrZaSsat98TC4r3HprGO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uDLnAQtj6WRvI5hEx40z/1KjkNrP9nQ8Pr+jdOfLslBuOHaWXa1fhX489hTgJA3DAM5xZcxH+9WGta57RwStb3fsh32fsFZn3/5kqYDYhEOnB5MHTlr2mIkWNfx+vnF6w3jyKE2P4dluceBpPH1CkPyrRIfTI3mRuUpRavZ5FR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sO7VKKYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66478C4CEEB;
	Mon, 18 Aug 2025 09:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755508106;
	bh=sEjviTPRhYqGP5Y8/0bVLkQrZaSsat98TC4r3HprGO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sO7VKKYXEgCCrKA7UhDgHUhEK+pY+o0QLKoSaakjTSE47or7nlZ7vkHmIOyD1z5MK
	 Ifiq1B2JEmdk6nz6W3JKevN+2elv+/dvaE5yKlDU5P/b/8TB63oteFyb94ofoU/ATJ
	 R0ieqJOCS1Mh21BGGthR7gHX0UBoSSXyH113XdZ2pi8NpQseTvk/FyeZZ2Z+CO7x/h
	 1XEzczjYhvn/uEYP/sZ61EMI+mKOVCrYhQr2GdUhgl5N51mrRdFTDgbktg8ZjgPeex
	 Fkd7MtxKLibza9w7qxAxcLVk7neoj7sbV/Xiw3IPyyNGPFhady0B3PCmeYjmGsKPMk
	 5mn4SpEDW1xpg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 18 Aug 2025 11:07:34 +0200
Subject: [PATCH nf-next v6 2/2] selftests: netfilter: nft_flowtable.sh: Add
 IPIP flowtable selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-nf-flowtable-ipip-v6-2-eda90442739c@kernel.org>
References: <20250818-nf-flowtable-ipip-v6-0-eda90442739c@kernel.org>
In-Reply-To: <20250818-nf-flowtable-ipip-v6-0-eda90442739c@kernel.org>
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


