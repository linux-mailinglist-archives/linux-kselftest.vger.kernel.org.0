Return-Path: <linux-kselftest+bounces-21599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C190B9C0214
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 11:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558B8B214EB
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 10:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0141CC8A3;
	Thu,  7 Nov 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cZo9a6rt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055618A95A;
	Thu,  7 Nov 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974626; cv=none; b=CWQImo1fD+FOZLBEOB8YXgpc9FPteSlTEXlDihbeo4QCsCiAn+4CPEOXLctFLDFPwtL3iw/a0Dus7LdNDrTxSxPvDwLCwMe7gMfFxLcxx+0qhyK5GgSZBtCnpDHKbeqFTihRP63heSFcfxHDrhi+hYSmHDTCPpUcA82qexTtLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974626; c=relaxed/simple;
	bh=HYqpfkxWr8Ow+kzaQlf5o2ZYlR1fWsx2LF3jRjZQ3KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkHYgOtDeL8Jrq4V3Zw1vbyg93+VpIY2CyiUaqgYgrzoJr5QAiNkr4/jMlcQ1hM1qP/XlO0l/3/B3EsjAuxDyYO4pGCpEiLgWfX2bs/sv72IzxqrQPThhwpdEaBzGVRE6TdsWYgwDvsrUwjZEEA8ehNvIujLktM6H0RPWprFJWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cZo9a6rt; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D80911140169;
	Thu,  7 Nov 2024 05:17:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 07 Nov 2024 05:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730974623; x=1731061023; bh=KjDtng++x7uyEf8mWVjV7R093gpo4RXOMpk
	X6BeUddU=; b=cZo9a6rte/z3zCHt3WD2jhdgJdP0TV5GrHZztq0IeOfkKgqmhqB
	wgX+MY950SPiLqz2mdi4vEBNpCPBrGNtbVch6GU/QA8+wESqsXCkbOondJCcsFYX
	XJ5sOEnKYziN1xQixdNRl1x5OL0SrYhcjSwXTcvZyn/eIHteK1Fy31JEUy8HwULQ
	DJCR/cei3Xnn08AyAmtckDyFoBsXxW0FwVwIv4Yu4mb/f+cqXPhZXIYnes6FkWFR
	BpzJ2UcJ726KvkvwHOevKXu+/MT7VfglHeT/+LLMAH8yLPNa8pjxb9jIA1ZyRr2x
	cyPVlWoSQtTV9cL1N5rhNmtcPLrn9ftPpkg==
X-ME-Sender: <xms:n5MsZyTt_CEokYqbBmg3agBFJimaFFqEgbLEwYAa2aA0zVAL83eSug>
    <xme:n5MsZ3xs5dJDbOESozmvjn4QJLEnbMjaFhWRi-qZrDC9JiHkJj7LbNSTANlNWAj1S
    oCZ_myU6Hoxxq8>
X-ME-Received: <xmr:n5MsZ_3w1myQgAJ11Y312oxtfohYMOgsOy3jrlSZ9_3e1BkpEPEVK3CpNlQlEkJ63738P1xeJMYrtzADVLFv2gUbcFc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggddugecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:n5MsZ-BVJ0jxsWX_L1TDRQucHy6GMvHUjyOMpscGpUWgOT-6aSLRYA>
    <xmx:n5MsZ7iUqraKpSgab--TjUXS_KfTO5ngSMYQDXwLif-7_mOjXw2jbw>
    <xmx:n5MsZ6o-xTItRL50HeffFJbRnhySUAmjJN9Fink-N2XLugm0lWdQJA>
    <xmx:n5MsZ-j7nXeJdV3t8HTZmVAO9Nf4oJ5E5Md2j-VN0-F5sZ9Ljk8Abw>
    <xmx:n5MsZwbFP6onITfVoGkleazzRe8m8J8l5QtVBs4KIKiTKGvWHYhSIE4G>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 05:17:02 -0500 (EST)
Date: Thu, 7 Nov 2024 12:16:59 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, linux-kselftest@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	horms@kernel.org, gnault@redhat.com
Subject: Re: [PATCH net-next v9] net: ipv4: Cache pmtu for all packet paths
 if multipath enabled
Message-ID: <ZyyTm45HwJvrgnNu@shredder>
References: <20241107093629.311800-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107093629.311800-1-deliran@verdict.gg>

On Thu, Nov 07, 2024 at 09:36:24AM +0000, Vladimir Vdovin wrote:
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
> +	pmtu_a_R1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R1)"
> +	pmtu_a_R2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R2)"
> +

In addition to the removal of 'fail=0' that you already mentioned, also
need to flip the error messages:

> +	check_pmtu_value "1500" "${pmtu_a_R1}" "exceeding MTU (veth_A-R2)" || return 1

s/veth_A-R2/veth_A-R1/

> +	check_pmtu_value "1500" "${pmtu_a_R2}" "exceeding MTU (veth_A-R1)" || return 1

s/veth_A-R1/veth_A-R2/

> +}
> +
>  usage() {
>  	echo
>  	echo "$0 [OPTIONS] [TEST]..."
> 
> base-commit: 66600fac7a984dea4ae095411f644770b2561ede
> -- 
> 2.43.5
> 

