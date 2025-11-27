Return-Path: <linux-kselftest+bounces-46627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A213C8DE6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54743AC035
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68344329C6E;
	Thu, 27 Nov 2025 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="bJrarUWJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oJeAtDbJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941C23BD06;
	Thu, 27 Nov 2025 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241774; cv=none; b=ZISvZzLpylC0YVI/5cFArQ9e9YmFMlCYwFBI6aLE/qrY/I7vurAKGJddpR9i07HjBxgN7PqLaqFaWBaMNopp0jjzyxF0Qgyq3wwAI3NEsE/YF9Ps9p9ZfkkE6StM+cOwDCD5yrim2ihQWbiL/IzGuXoAPd7rb916f6vmaog5buE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241774; c=relaxed/simple;
	bh=HBPnwioyysik1KSHJ7jG8VR1p2biBBHYePsgtvfZ6qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdcpkZ6P9ZO9kWuBTTqMXlpv5rtDsScAFj4MDtOA5HZdfka3qJOuh3kpnkif+WY4ekql2qwLcsfmSqCfi3xG3h8nHVvb6C5OHtcUrUjT3ifns8GH6kuWwwhFITDKH9h/Mj01AqSBZWmQeBfjxp/OkWX0ohwedi/GRjq4pmc7NRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=bJrarUWJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oJeAtDbJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 02EF4EC03AC;
	Thu, 27 Nov 2025 06:09:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 27 Nov 2025 06:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764241769; x=
	1764328169; bh=Xen6Uk5R0BrN/oza2Bb5kJydq0dK+0j/BjCVJqGOwZo=; b=b
	JrarUWJ84ZFyo9PsZNWjoMGFEOdMeCqC5ac73XlrZ5h2GXEqbeh122UQlpkAzLp6
	GujYH0sQM+Op1VuLNmNiCA9lFSls0aBKgbBy1oL6hlBjO1lsCUmLj8ZPL4DIrplL
	cYXmudQK6maj2FdNeND4pQh2tWk9mzky3erg9vSZSkMe4LknsKaY06XSlGA2Yi+F
	X195AxR0EwvAE4TBn+koqsJ8c/5RjkW3UQszXLpjOUm1NPjmOKQnXCTccf17qxCF
	fEcOBzqw+lEJpQjc4D2Zvun3L1g+Kco/yTYnseUA/DhWmOlQamtYo2pef/lnOP6Q
	wIvVPDSQXVK2rEglU6MYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764241769; x=1764328169; bh=Xen6Uk5R0BrN/oza2Bb5kJydq0dK+0j/BjC
	VJqGOwZo=; b=oJeAtDbJZa6/HrtHz5TFKBJYn0BHYpWe+Y4Ex42bKNoSzoqAKgl
	unDwHFVpJwu2AIZuf3aHRNLeXZ+jEOf/6tc7B2LvKkj6fTiDyr+rYgY+tJ84w81f
	1oXtOqN4syO5BER5zQ+yrmL+Dg2nZewgW5SQHswil73N/uZ29P7z23J4LLuqjl9/
	nkxI5mPytlztw1KQgucGuIai5WytEMsTnf6OSduR3SMSK0qkF2Z8jMicgAEh60D1
	yXxS2XNcCXO+AGreVS9eqrr6Yc18izDVNC52hh8AY6wJWhM280HA5WkF7MWgsFEn
	QUvX2esCURjgwqnH4EiLeSczCH4SQ4Gy1SQ==
X-ME-Sender: <xms:aTEoaXaKy2aYaj22khIpJcKUFR-49HLFaO9Yt-mvluuc0qnuiWlJyg>
    <xme:aTEoaftnxX-yWx_FS_n5pv6PJ3OySehqWkwnDZbH8yxdWs2ELppOew3XpTVI4B9Pq
    Zo-NwnUgoELcSCvsp7woSs1XVUjduC8jcDVUoDuUO-AZ3DsEfWMHfI>
X-ME-Received: <xmr:aTEoaROXUq6fEFD29ENGPL9s6ZA0rMoY1pgAn_hL1d7LfFqqDrdf_gigkeYN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeejtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhgrlhhfsehmrghnuggvlhgsihhtrdgtohhmpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:aTEoae6DmbuMluHgx_vuOIuQprgb83iicrjKs5Cf8TftiXjKSF7QnQ>
    <xmx:aTEoafR2Vd4brsL3DGaiFUX6tgrut8RaAtZ_UbvkcG9Z50_tPuxOMQ>
    <xmx:aTEoaTDiALNOUl-lNbcp5E3EFODvLlDImbw5NwmzSy2dr2az8q-V3Q>
    <xmx:aTEoaXFKGxLn6mFlZDG1JtX1Fwh_XW4sDyPkwv_cJnxVEtXGiZmmvQ>
    <xmx:aTEoaWSgivJQpMPvUdjMNP8BrGW_fjl_fIXfd7K5Mb-PIK9ozxoe1hwd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 06:09:29 -0500 (EST)
Date: Thu, 27 Nov 2025 12:09:27 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC net-next 08/13] selftests: ovpn: add test for the FW mark
 feature
Message-ID: <aSgxZ0Z6eDWS0vva@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
 <20251121002044.16071-9-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121002044.16071-9-antonio@openvpn.net>

2025-11-21, 01:20:39 +0100, Antonio Quartulli wrote:
> diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> index baabb4c9120e..4df596d29b8c 100644
> --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> @@ -1693,12 +1705,13 @@ static void usage(const char *cmd)
>  	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
>  
>  	fprintf(stderr,
> -		"* new_multi_peer <iface> <lport> <peers_file>: add multiple peers as listed in the file\n");
> +		"* new_multi_peer <iface> <lport> <peers_file> [mark]: add multiple peers as listed in the file\n");
>  	fprintf(stderr, "\tiface: ovpn interface name\n");
>  	fprintf(stderr, "\tlport: local UDP port to bind to\n");
>  	fprintf(stderr,
>  		"\tpeers_file: text file containing one peer per line. Line format:\n");
> -	fprintf(stderr, "\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr>\n");
> +	fprintf(stderr, "\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr> [mark]\n");

This line should be dropped, this patch doesn't have the corresponding
change to parse mark while we're looping over the lines of peers_file.


> diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
> new file mode 100755
> index 000000000000..a4bfe938118d
> --- /dev/null
> +++ b/tools/testing/selftests/net/ovpn/test-mark.sh
[...]
> +for p in $(seq 1 3); do
> +	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
> +	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p} + 9)) 60 120
> +done
> +
> +sleep 1
> +
> +for p in $(seq 1 3); do
> +	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3 5.5.5.$((${p} + 1))

Any reason this ping (and the final one) uses -s 3000 while the one we
expect to fail doesn't?

> +done
> +
> +echo "Adding an nftables drop rule based on mark value ${MARK}"
> +ip netns exec peer0 nft flush ruleset
> +ip netns exec peer0 nft 'add table inet filter'
> +ip netns exec peer0 nft 'add chain inet filter output { type filter hook output priority 0; policy accept; }'
> +ip netns exec peer0 nft add rule inet filter output meta mark == ${MARK} counter drop
> +
> +DROP_COUNTER=$(ip netns exec peer0 nft list chain inet filter output | sed -n 's/.*packets \([0-9]*\).*/\1/p')
> +sleep 1
> +
> +# ping should fail
> +for p in $(seq 1 3); do
> +	PING_OUTPUT=$(ip netns exec peer0 ping -qfc 500 -w 1 5.5.5.$((p+1)) 2>&1) && exit 1

nit: inconsistent syntax for p+1 compared to the other pings ($((p+1)) vs $((${p} + 1)))

> +	echo "${PING_OUTPUT}"
> +	LOST_PACKETS=$(echo "$PING_OUTPUT" | grep 'packets transmitted' | awk '{ print $1 }')
> +	# increment the drop counter by the amount of lost packets
> +	DROP_COUNTER=$(($DROP_COUNTER+$LOST_PACKETS))
> +done
> +
> +# check if the final nft counter matches our counter
> +TOTAL_COUNT=$(ip netns exec peer0 nft list chain inet filter output | sed -n 's/.*packets \([0-9]*\).*/\1/p')
> +[ ${DROP_COUNTER} -eq ${TOTAL_COUNT} ] || exit 1

Maybe add something like
    echo "Expected ${TOTAL_COUNT} drops, got ${DROP_COUNTER}"
if we're failing at this stage?

> +
> +echo "Removing the drop rule"
> +ip netns exec peer0 nft flush ruleset
> +sleep 1
> +
> +for p in $(seq 1 3); do
> +	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3 5.5.5.$((${p} + 1))
> +done
> +
> +cleanup
> +
> +modprobe -r ovpn || true

-- 
Sabrina

