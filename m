Return-Path: <linux-kselftest+bounces-46596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1668C8C696
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 01:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9493A6F93
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FB954654;
	Thu, 27 Nov 2025 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="H8jWnAO6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HT683tKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08CD3FBA7;
	Thu, 27 Nov 2025 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764202425; cv=none; b=mVbTKRpv2j4lMfBnxP8I3deti1AhSUWwz/ro4uKxNGGx+A8F1w5Uvt0iW94zwMD+abnnzO8P4e8l9POfzqOZgGNu6sXeu6hZ5QAAV/qCeabXmKD1oEMeKpOxyIAMgGUXnDu7zDip4wEw2m+budsbzGnXwpUbKvHdpMNJ82TnFVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764202425; c=relaxed/simple;
	bh=GUOcb88AY8JEoO4WchKej0jtVcO4dD47lu0oAZqHQ7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYBOci+BZ2ngclNMgjbGGVsWCp8l8UKoeYkGvJr2Qv+4U5hMToi1O8tqj4z/dOyjxx+Mp7E84SnNKXzEB50lvB5Uoa3AAAdw/VRKlXhCnXsdrzTJ/TVNJ+LhT1T5dVvhpOOSjhmjUnSRlfAlwwFIys2WqK3JA2M9/JWl/3qKZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=H8jWnAO6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HT683tKC; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BDB481D0013F;
	Wed, 26 Nov 2025 19:13:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 26 Nov 2025 19:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764202420; x=
	1764288820; bh=/OCQpu8LbBoJ3Ap4le197jNM1y1bW7w3PIGHBYpNjBU=; b=H
	8jWnAO6xmBRJhdeksZBLvgN4Nj39fzI53NQoUJiA0hU2YhH/jSCZ2S+qgCrBPxUu
	gNaOWc/3IcgwwniAc7vxQUcS/WoocaUTDUKOzRBccC1jhBTm7imA4tN0OlRauyaN
	TJ74jsIwYDM/PhU2ZyavZmCPhaaVeVd6NNUuBrZJxE4Q/hr8MtljW2ivYTsC7B+m
	R+TsVJf8EUIYKtXIz/2vBnZFy5pa4IDh8kfitd1BhlMHfCJ1lav1YyBX1cR9EEmQ
	ReuOSXpfRhFbME/71RF3q4JxmNzjY/i1f1UqUZdtN5JRXduxtSeRxaDrmkNR1xkv
	julKoEhq/tpVGt/a8lk0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764202420; x=1764288820; bh=/OCQpu8LbBoJ3Ap4le197jNM1y1bW7w3PIG
	HBYpNjBU=; b=HT683tKC+qzI5CNXMkfRV/cX8ArWrI8RKbCV6llNfhJS2TTxGzX
	Li3cUSOiiTqOmt+lVX6IhDMEMY9kBryhihAsfGoyS9CpnfkCNydxVAFXtKmAyGyM
	T1xb4cJc32phKNgoT1QW7XznN3/QCXBTQJYHsGYXYk4pk5+001Cds+w2ADfCFzVo
	6Nl1DKDhRFs3N75D86IdRB2PmFcQCsgLaMK4ylj4gSCuYwVW1DF0I1zeCEublwGp
	QCVKCE+dCDdr3Arxf+TUixnE63m5up+PSn359JlY4Xf0a4nhvQK6HPocSu/VIa0w
	PT7YXTJI6ZkwS5EnezTOeiIgYAqqT3DmXLQ==
X-ME-Sender: <xms:tJcnad5WsUXAF8UGNCMe-KpZYJa0lkUufdmlrSG_38mdbtjAxZ34Cg>
    <xme:tJcnaUPgIn31hEeKv6qqLu2w8q6cAAo3cYuP8fpP7477g9Zz8A3ZyW62Bi9aFrB_T
    s2hPSXVzbOfc_iiGIEvzQLjlqjvoYqFhEP5fliePCYGO-Rf1CBHeRJV>
X-ME-Received: <xmr:tJcnabt9j9tCfQoYUPQ9LKzpGxBLPDOhQvHD79Wmnu0R2TxPqQX7MhYW_Z8Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehjeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:tJcnaXapogjotsW6QGv_4Tv55SYqXwZYmxKo3zVLADrKCskz3KGGuA>
    <xmx:tJcnadyhUmwbLHnLMvcWYo7kHJHKsg9q78CinzUcdDOuwtJCKYJCsw>
    <xmx:tJcnafiWOFp8roMeBHmt9qDFvUOYuIWBLBk9JZvw0GLyzoB2lWIvLA>
    <xmx:tJcnaZnznmnLEbFTKPler4-30W_CfUteHENWXEqRn8mLQZgpmedfcw>
    <xmx:tJcnacxoEVF3QVRrH3snoSwB3b9gVvoab6KZGjnH30TjR8ES1Ty1UENi>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 19:13:39 -0500 (EST)
Date: Thu, 27 Nov 2025 01:13:37 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC net-next 07/13] selftests: ovpn: check asymmetric peer-id
Message-ID: <aSeXsX7dwx1YI8Ea@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
 <20251121002044.16071-8-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121002044.16071-8-antonio@openvpn.net>

2025-11-21, 01:20:38 +0100, Antonio Quartulli wrote:
> diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
> index b91cf17ab01f..d926413c9f16 100644
> --- a/tools/testing/selftests/net/ovpn/common.sh
> +++ b/tools/testing/selftests/net/ovpn/common.sh
> @@ -75,13 +75,14 @@ add_peer() {
>  					data64.key
>  			done
>  		else
> -			RADDR=$(awk "NR == ${1} {print \$2}" ${UDP_PEERS_FILE})
> -			RPORT=$(awk "NR == ${1} {print \$3}" ${UDP_PEERS_FILE})
> -			LPORT=$(awk "NR == ${1} {print \$5}" ${UDP_PEERS_FILE})
> -			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} ${1} ${LPORT} \
> -				${RADDR} ${RPORT}
> -			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} ${1} 1 0 ${ALG} 1 \
> -				data64.key
> +			TX_ID=$(awk "NR == ${1} {print \$2}" ${UDP_PEERS_FILE})
> +			RADDR=$(awk "NR == ${1} {print \$3}" ${UDP_PEERS_FILE})
> +			RPORT=$(awk "NR == ${1} {print \$4}" ${UDP_PEERS_FILE})
> +			LPORT=$(awk "NR == ${1} {print \$6}" ${UDP_PEERS_FILE})
> +			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} ${TX_ID} ${1} \
> +				${LPORT} ${RADDR} ${RPORT}
> +			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} ${TX_ID} 1 0 \
> +				${ALG} 1 data64.key

IIUC, we're creating a "client" with peer_id=$TX_ID and tx_id=$ID so
that they're flipped from what we installed on the multi-peer side?


> diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> index 064453d16fdd..baabb4c9120e 100644
> --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> @@ -103,7 +103,7 @@ struct ovpn_ctx {
>  
>  	sa_family_t sa_family;
>  
> -	unsigned long peer_id;
> +	unsigned long peer_id, tx_id;
>  	unsigned long lport;
>  
>  	union {
> @@ -649,6 +649,7 @@ static int ovpn_new_peer(struct ovpn_ctx *ovpn, bool is_tcp)
>  
>  	attr = nla_nest_start(ctx->nl_msg, OVPN_A_PEER);
>  	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_ID, ovpn->peer_id);
> +	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_TX_ID, ovpn->tx_id);

So, with these changes, it's no longer possible to test a userspace
not passing the new OVPN_A_PEER_TX_ID attribute? But I guess we could
simulate that behavior by passing TX_ID==ID (is there still a test
doing that?).

Do we need to preserve some testing of the case where userspace is not
passing the new attribute?


>  	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_SOCKET, ovpn->socket);
>  
>  	if (!is_tcp) {
> @@ -767,6 +768,10 @@ static int ovpn_handle_peer(struct nl_msg *msg, void (*arg)__always_unused)
>  		fprintf(stderr, "* Peer %u\n",
>  			nla_get_u32(pattrs[OVPN_A_PEER_ID]));
>  
> +	if (pattrs[OVPN_A_PEER_TX_ID])
> +		fprintf(stderr, "\tTX peer ID %u\n",
> +			nla_get_u32(pattrs[OVPN_A_PEER_TX_ID]));
> +
>  	if (pattrs[OVPN_A_PEER_SOCKET_NETNSID])
>  		fprintf(stderr, "\tsocket NetNS ID: %d\n",
>  			nla_get_s32(pattrs[OVPN_A_PEER_SOCKET_NETNSID]));
> @@ -1676,11 +1681,13 @@ static void usage(const char *cmd)
>  		"\tkey_file: file containing the symmetric key for encryption\n");
>  
>  	fprintf(stderr,
> -		"* new_peer <iface> <peer_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
> +		"* new_peer <iface> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
>  	fprintf(stderr, "\tiface: ovpn interface name\n");
>  	fprintf(stderr, "\tlport: local UDP port to bind to\n");
>  	fprintf(stderr,
> -		"\tpeer_id: peer ID to be used in data packets to/from this peer\n");
> +		"\tpeer_id: peer ID found in data packets received from this peer\n");
> +	fprintf(stderr,
> +		"\ttx_id: peer ID to be used when sending to this peer\n");
>  	fprintf(stderr, "\traddr: peer IP address\n");
>  	fprintf(stderr, "\trport: peer UDP port\n");
>  	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
> @@ -1691,7 +1698,7 @@ static void usage(const char *cmd)
>  	fprintf(stderr, "\tlport: local UDP port to bind to\n");
>  	fprintf(stderr,
>  		"\tpeers_file: text file containing one peer per line. Line format:\n");
> -	fprintf(stderr, "\t\t<peer_id> <raddr> <rport> <vpnaddr>\n");
> +	fprintf(stderr, "\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr>\n");

Looks like this is missing similar updates for connect and listen,
based on changes to ovpn_run_cmd and ovpn_parse_cmd_args?

-- 
Sabrina

