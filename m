Return-Path: <linux-kselftest+bounces-46892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D3CC9C256
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 17:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16738342B83
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1555D2820A4;
	Tue,  2 Dec 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="cX2PECCz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA2248896
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691907; cv=none; b=u/5CDSDcLKMRRzwhGNgxHGqlRgyPoyIFBy4iwQmh64spR5zwxmcktjb00b+zIVRbg8dL8lpcH53IWYzYh+nr+PxK2W3Mbadz99T0Ryv2k0H+bFGubbsib3+0kWxtjBkS6Hf6zJoj6WxaUiPNR2OPd1gFOR1e7z1qNiRr4gQxL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691907; c=relaxed/simple;
	bh=MpaVTJtPtUAYsk3NM14xKSndbkM17fv4UODqaIZAVac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eh0x+4OHT//dYMCBeE7OZ9F6hssxA0gEpEE0CnIKsFiEOG0fQeaPRQZzdUnE1XXXTP4FmYelnILGAWGMj7JUCCTS16CEn+QhmosNn5nOX+Q4EMns3PLSkfKJ/Ijx4P0GAqUtAZ/BmFyQrqaMxmvvfR2KzZYlBFU90FLmBdN8syc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=cX2PECCz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so65301705e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 08:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1764691903; x=1765296703; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cD3zkO+AVoM5XzhcnzC1nVXaPxl21yMcfmrZ0f3idFQ=;
        b=cX2PECCz3ADx21+C6JHltAqj12BF+lKBBOq5hfb6MEqxZ7GEJTmBtPE1GpFy0DAmcr
         +UySrkblhwQJa95qEeDbEy13igPQzF9wRJ6JKLsVJ8O/u9NDcxcKXB3Z9a7dPvqrOClY
         IW9mLtTcwJsq+qEdhcJfo5Auq88QGrU9tycpPemtYbRcbUdsn2kjDuJLeMlEfGyM1AXb
         Jjwk19oEnu0kX+hPZagXhm7ExCkqch+qaMXBKslJ82+4KobMTMDZSbBLDcddrXV+Uvvv
         K+QIhfDLq1kRj1Ho7ij15W6NhkFBV9FplEJy76SHZHdhgRiXFvi99IcNg57HnYPwhy9x
         W7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691903; x=1765296703;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cD3zkO+AVoM5XzhcnzC1nVXaPxl21yMcfmrZ0f3idFQ=;
        b=hD2fSDD6mLTYhHTcWynx3w9zgr+NgdT8F0EQBIvcb4nzffmXYJBJu46qzExzo9Aikb
         vODrs8zcY2ZjrLK6YCD8SqWAm1pQal9X2FXlAj9PAuo7Do1/Bxp8TyLj+IMtpUriMxYJ
         PO6VSMBpHWbp3GZOypNRHyosDAwa7jq8Sxx7cXku//lA6rhObNgKDkams9wyW3a2cwrv
         Rd0BMSiYedwONgMRX2YbjWwxuyUAtWs7XIJGFLPnD+HcGQtKYzmyguxos4p3K+fop5C6
         Nxpf86amzzBVS/oKti5AxLcXEgmCaXfz8+CWfiTUefS2/yR5nOhrl1HowERzt8/RkUuy
         ikuw==
X-Forwarded-Encrypted: i=1; AJvYcCX9nPkWQfkS2y//myAnwcJvmJ9MeqAokqR+sTJJbgC0jGov0TXkL6gYmPep0IEF6zIF1K5xktBuYl5uYV3nCWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDHYLrrL2mLMjbo4fodNQzA2mG9bjF1xXsdOz/ohF2HElLb0E
	rIXK4atD0k1agHecMNCk5nwmeSGUdxUshi7OKxeB8dHMWme8Dvo2TFxbezD68wcrOMUWbYaBSs2
	8JRCA
X-Gm-Gg: ASbGncvmTWth0E2O5NtueLUjZ4QRZdrFGMnyXeCZgZwrArXHgwgOdT2Jr2B2uXO1I7m
	vU3wsVA+qJd5r1dUcBMH/cDLJp9OurIxr8SNLIWMl3oP5w8XjjSQhxrFBtk1eh4I7ul7JsUgQku
	MGBFpyVldojI+NExeqtuLXiS0o4rA/5HadYeXVWNVRHJnn9OfInBIp2N4jm5c2R8DewJFp3ENJp
	BcxnUgsCL3LXaVf80yEn3KfDAReHebxz9QFz9A0+EXHPiwRbDQ0vyDsHH/pERnRVwrN87ib52QM
	n4qZI70I8XsSkXuLUgH22NyrSviu0Bo92NZQsqVdMO2QMWOx5OXxDg4V6j/vwRuRS7+NlB6Oeev
	kiVkNntFSA7nc3aM5YS0oPXWKurQRHsqE+J7v0lQWbmITxlJlMqvTL/CfkGQxXU5rTy8gfB3+a8
	g5t6rts1egc2IMrj2zMa1E5Ys8BinOnqYFxAsxzxJxlDpFGTj7i7Dx2yCFkA==
X-Google-Smtp-Source: AGHT+IGsC+0FCzxHVDBuR6LWRmjXxyQdIpb1kBmF8Qyse8SRB8OJX1Y/Hf88ot3VxyQDRfrF4sdGhA==
X-Received: by 2002:a05:600c:c8c:b0:471:1435:b0ea with SMTP id 5b1f17b1804b1-47904b242eemr319702185e9.24.1764691903377;
        Tue, 02 Dec 2025 08:11:43 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a396sm33495782f8f.22.2025.12.02.08.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 08:11:42 -0800 (PST)
Message-ID: <c21b6b5ef18f63e331564edf8ee7832438e163ee.camel@mandelbit.com>
Subject: Re: [RFC net-next 07/13] selftests: ovpn: check asymmetric peer-id
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Antonio Quartulli
	 <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Date: Tue, 02 Dec 2025 17:11:42 +0100
In-Reply-To: <aSeXsX7dwx1YI8Ea@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
	 <20251121002044.16071-8-antonio@openvpn.net> <aSeXsX7dwx1YI8Ea@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-27 at 01:13 +0100, Sabrina Dubroca wrote:
> 2025-11-21, 01:20:38 +0100, Antonio Quartulli wrote:
> > diff --git a/tools/testing/selftests/net/ovpn/common.sh
> > b/tools/testing/selftests/net/ovpn/common.sh
> > index b91cf17ab01f..d926413c9f16 100644
> > --- a/tools/testing/selftests/net/ovpn/common.sh
> > +++ b/tools/testing/selftests/net/ovpn/common.sh
> > @@ -75,13 +75,14 @@ add_peer() {
> > =C2=A0					data64.key
> > =C2=A0			done
> > =C2=A0		else
> > -			RADDR=3D$(awk "NR =3D=3D ${1} {print \$2}"
> > ${UDP_PEERS_FILE})
> > -			RPORT=3D$(awk "NR =3D=3D ${1} {print \$3}"
> > ${UDP_PEERS_FILE})
> > -			LPORT=3D$(awk "NR =3D=3D ${1} {print \$5}"
> > ${UDP_PEERS_FILE})
> > -			ip netns exec peer${1} ${OVPN_CLI} new_peer
> > tun${1} ${1} ${LPORT} \
> > -				${RADDR} ${RPORT}
> > -			ip netns exec peer${1} ${OVPN_CLI} new_key
> > tun${1} ${1} 1 0 ${ALG} 1 \
> > -				data64.key
> > +			TX_ID=3D$(awk "NR =3D=3D ${1} {print \$2}"
> > ${UDP_PEERS_FILE})
> > +			RADDR=3D$(awk "NR =3D=3D ${1} {print \$3}"
> > ${UDP_PEERS_FILE})
> > +			RPORT=3D$(awk "NR =3D=3D ${1} {print \$4}"
> > ${UDP_PEERS_FILE})
> > +			LPORT=3D$(awk "NR =3D=3D ${1} {print \$6}"
> > ${UDP_PEERS_FILE})
> > +			ip netns exec peer${1} ${OVPN_CLI} new_peer
> > tun${1} ${TX_ID} ${1} \
> > +				${LPORT} ${RADDR} ${RPORT}
> > +			ip netns exec peer${1} ${OVPN_CLI} new_key
> > tun${1} ${TX_ID} 1 0 \
> > +				${ALG} 1 data64.key
>=20
> IIUC, we're creating a "client" with peer_id=3D$TX_ID and tx_id=3D$ID so
> that they're flipped from what we installed on the multi-peer side?

Exactly. I can see that this part is not very clear so I'll properly
define PEER_ID and TX_ID for the clients in the next version of the
patch.

> > diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> > b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> > index 064453d16fdd..baabb4c9120e 100644
> > --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> > +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> > @@ -103,7 +103,7 @@ struct ovpn_ctx {
> > =C2=A0
> > =C2=A0	sa_family_t sa_family;
> > =C2=A0
> > -	unsigned long peer_id;
> > +	unsigned long peer_id, tx_id;
> > =C2=A0	unsigned long lport;
> > =C2=A0
> > =C2=A0	union {
> > @@ -649,6 +649,7 @@ static int ovpn_new_peer(struct ovpn_ctx *ovpn,
> > bool is_tcp)
> > =C2=A0
> > =C2=A0	attr =3D nla_nest_start(ctx->nl_msg, OVPN_A_PEER);
> > =C2=A0	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_ID, ovpn->peer_id);
> > +	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_TX_ID, ovpn->tx_id);
>=20
> So, with these changes, it's no longer possible to test a userspace
> not passing the new OVPN_A_PEER_TX_ID attribute? But I guess we could
> simulate that behavior by passing TX_ID=3D=3DID (is there still a test
> doing that?).
>=20
> Do we need to preserve some testing of the case where userspace is not
> passing the new attribute?
>=20

That's a valid concern as we're expected to still correctly handle
userspace programs that don't pass the attribute. I'll add a boolean
flag similar to FLOAT in order to extend the tests to cover this case.=20

>=20
> > =C2=A0	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_SOCKET, ovpn->socket);
> > =C2=A0
> > =C2=A0	if (!is_tcp) {
> > @@ -767,6 +768,10 @@ static int ovpn_handle_peer(struct nl_msg *msg,
> > void (*arg)__always_unused)
> > =C2=A0		fprintf(stderr, "* Peer %u\n",
> > =C2=A0			nla_get_u32(pattrs[OVPN_A_PEER_ID]));
> > =C2=A0
> > +	if (pattrs[OVPN_A_PEER_TX_ID])
> > +		fprintf(stderr, "\tTX peer ID %u\n",
> > +			nla_get_u32(pattrs[OVPN_A_PEER_TX_ID]));
> > +
> > =C2=A0	if (pattrs[OVPN_A_PEER_SOCKET_NETNSID])
> > =C2=A0		fprintf(stderr, "\tsocket NetNS ID: %d\n",
> > =C2=A0			nla_get_s32(pattrs[OVPN_A_PEER_SOCKET_NETNS
> > ID]));
> > @@ -1676,11 +1681,13 @@ static void usage(const char *cmd)
> > =C2=A0		"\tkey_file: file containing the symmetric key for
> > encryption\n");
> > =C2=A0
> > =C2=A0	fprintf(stderr,
> > -		"* new_peer <iface> <peer_id> <lport> <raddr>
> > <rport> [vpnaddr]: add new peer\n");
> > +		"* new_peer <iface> <peer_id> <tx_id> <lport>
> > <raddr> <rport> [vpnaddr]: add new peer\n");
> > =C2=A0	fprintf(stderr, "\tiface: ovpn interface name\n");
> > =C2=A0	fprintf(stderr, "\tlport: local UDP port to bind to\n");
> > =C2=A0	fprintf(stderr,
> > -		"\tpeer_id: peer ID to be used in data packets
> > to/from this peer\n");
> > +		"\tpeer_id: peer ID found in data packets received
> > from this peer\n");
> > +	fprintf(stderr,
> > +		"\ttx_id: peer ID to be used when sending to this
> > peer\n");
> > =C2=A0	fprintf(stderr, "\traddr: peer IP address\n");
> > =C2=A0	fprintf(stderr, "\trport: peer UDP port\n");
> > =C2=A0	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
> > @@ -1691,7 +1698,7 @@ static void usage(const char *cmd)
> > =C2=A0	fprintf(stderr, "\tlport: local UDP port to bind to\n");
> > =C2=A0	fprintf(stderr,
> > =C2=A0		"\tpeers_file: text file containing one peer per
> > line. Line format:\n");
> > -	fprintf(stderr, "\t\t<peer_id> <raddr> <rport>
> > <vpnaddr>\n");
> > +	fprintf(stderr, "\t\t<peer_id> <tx_id> <raddr> <rport>
> > <laddr> <lport> <vpnaddr>\n");
>=20
> Looks like this is missing similar updates for connect and listen,
> based on changes to ovpn_run_cmd and ovpn_parse_cmd_args?

Good catch, thanks.

--=20
Ralf Lici
Mandelbit Srl

