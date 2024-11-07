Return-Path: <linux-kselftest+bounces-21595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD379C00E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 10:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495821C21614
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033AC1DF99F;
	Thu,  7 Nov 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="awK5+qr4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166DD194ACF;
	Thu,  7 Nov 2024 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970859; cv=none; b=TsEOlbQEiKt1FQs0B7rrVbm8pCrEnqZSJQBNhNbaiBzvS71feBEyu9WRwT44z3wX/JtF7RH7yRMBZSEwf4mol3orgQDdjJK5721frePRr+YeutkoQTkZqqjZBU+Mopl+LlOHQXnuuwJhHrgX2aiGnq3htHrY2qxInSJ7H841DEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970859; c=relaxed/simple;
	bh=dBnYIq502zMVsyq0uatRnoVEE+yQENT9Zt1omk4lYJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csKt4BdmMKrpa2eiIJhcFJuoH9ghjl0J+OEjW/NvDEhJ6+HQR7jGcavDokWqhVslQRiKUL1hz+y6H6qkmTuVBETDgf8NzrBZFOpMrx5kEyAEpPiBvvIW8kLAyDXzYdUAcjfd5/2kyeT3l5qoJCMQCzm3qmrDzqlI1n11sy5ksVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=awK5+qr4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F1641380391;
	Thu,  7 Nov 2024 04:14:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 07 Nov 2024 04:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730970856; x=1731057256; bh=UVVys8cK8r99yXLUwC33/W0C1OEMDsWowc+
	d+GobAPU=; b=awK5+qr4E11Fi5E34detT5LFxOUq692OhBocGYABEKY5WFl5I5j
	YpLXVkWLi7O3Tqu5YfWSSI4HEMIdSNrCPKSsuicuqDTv/jINoGTILNh1QlTc5wb7
	vCUekHYMTY4UTL+MkhXZNUICAO9Xaa6uXtHFCCtf4kRozs4vFvrRPauHG5o088l3
	RQG1VPxH83733ayRa63MYm14YBp4g6eH6t8KoYjEE0kG4RoJt7FpLsHB+bJc3+J4
	9Pd3fEgUg2Vvn0tBfLhdSWJx8EyzBVuOiyu35PukvFeA6LK2Y8434DFpMikgT5YP
	UACCTvIzjhGWmofhQlYhBhpyc0RhAx9jyPQ==
X-ME-Sender: <xms:54QsZzDAptP3LqguuKjmR6PEH5GiNSalsaOCbpL5ZVnSyhhARI7RVQ>
    <xme:54QsZ5gQ4QKs5U86KcgoiHlNKBQTDnbV3u8fyBE7dIDwWldFeWXcysUo5HuUwzPJm
    RFOMDeyI7jvQOs>
X-ME-Received: <xmr:54QsZ-n4PIJmB3zNcal6wYOh1sjcu5Z_ZPJ-8RoHXPylTmCNAWs6EkHtseVmt1xfzExmTwqvB7MUOIzTbEhJk6ICqX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceo
    ihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvghrnhepvddufeevke
    ehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughosh
    gthhdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopeguvghlihhrrghnsehvvghrughitghtrdhgghdprhgtphhtthhopehnvghtug
    gvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegushgrhhgvrhhnsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvg
    htpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihes
    rhgvughhrghtrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:54QsZ1y9RgVk0MrMfI4uANFHNeEI44sgpvfM8ah0CSb3pRMQASfsKQ>
    <xmx:54QsZ4QMU2IG1PeyKEZ4UdMlexBc2HzfClJ1QLbCz98ogbsMa_bozg>
    <xmx:54QsZ4aIMf0wl1FkGJ_ek9NKrUX3J_r9XYdDrK0DxUgo-QQligvcsw>
    <xmx:54QsZ5QW5dB-8BV4sZYXIYGhDOHt-gqHFGeIlXU__M9nTSYKbiANLQ>
    <xmx:6IQsZ9LHZVmRLWfGmx6nsBi7tREAB15ExtnTcVLJRq3-JuxkshED1oRm>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 04:14:14 -0500 (EST)
Date: Thu, 7 Nov 2024 11:14:11 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, linux-kselftest@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	horms@kernel.org, gnault@redhat.com
Subject: Re: [PATCH net-next v8] net: ipv4: Cache pmtu for all packet paths
 if multipath enabled
Message-ID: <ZyyE473qDbLiPgx7@shredder>
References: <20241106133012.289861-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106133012.289861-1-deliran@verdict.gg>

On Wed, Nov 06, 2024 at 01:30:07PM +0000, Vladimir Vdovin wrote:
> +test_pmtu_ipv4_mp_exceptions() {
> +	setup namespaces routing multipath || return $ksft_skip
> +
> +	trace "${ns_a}"  veth_A-R1    "${ns_r1}" veth_R1-A \
> +	      "${ns_r1}" veth_R1-B    "${ns_b}"  veth_B-R1 \
> +	      "${ns_a}"  veth_A-R2    "${ns_r2}" veth_R2-A \
> +	      "${ns_r2}" veth_R2-B    "${ns_b}"  veth_B-R2
> +
> +	# Set up initial MTU values
> +	mtu "${ns_a}"  veth_A-R1 2000
> +	mtu "${ns_r1}" veth_R1-A 2000
> +	mtu "${ns_r1}" veth_R1-B 1500
> +	mtu "${ns_b}"  veth_B-R1 1500
> +
> +	mtu "${ns_a}"  veth_A-R2 2000
> +	mtu "${ns_r2}" veth_R2-A 2000
> +	mtu "${ns_r2}" veth_R2-B 1500
> +	mtu "${ns_b}"  veth_B-R2 1500
> +
> +	fail=0
> +
> +	# Ping and expect two nexthop exceptions for two routes in nh group
> +	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${host4_b_addr}"
> +
> +	# Do route lookup before checking cached exceptions.
> +	# The following commands are needed for dst entries to be cached
> +	# in both paths exceptions and therefore dumped to user space
> +	# Check that exceptions have been created with the correct PMTU
> +	pmtu="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R1)"
> +	pmtu="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R2)"

This overrides the first PMTU

> +
> +	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R2)" || return 1
> +	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R1)" || return 1
> +
> +	return ${fail}

And "fail" does not seem to be used anymore.

Can you squash the following diff to v9?

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 9e34b54d9c15..1b4d4c598d66 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -2396,22 +2396,14 @@ test_pmtu_ipv4_mp_exceptions() {
 	mtu "${ns_r2}" veth_R2-B 1500
 	mtu "${ns_b}"  veth_B-R2 1500
 
-	fail=0
-
 	# Ping and expect two nexthop exceptions for two routes in nh group
 	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${host4_b_addr}"
 
-	# Do route lookup before checking cached exceptions.
-	# The following commands are needed for dst entries to be cached
-	# in both paths exceptions and therefore dumped to user space
 	# Check that exceptions have been created with the correct PMTU
 	pmtu="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R1)"
+	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R1)" || return 1
 	pmtu="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R2)"
-
 	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R2)" || return 1
-	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R1)" || return 1
-
-	return ${fail}
 }
 
 usage() {

