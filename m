Return-Path: <linux-kselftest+bounces-46896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42CC9C380
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 17:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D74E3482FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB4023EAB3;
	Tue,  2 Dec 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="fjbGkMwU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1613FC2
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693250; cv=none; b=ksL6vHEkdB22SvzibwvEzBbWh54t4Ax7FfZc5l76IENo7kOfqXz/KdcYjkebTXi5ixA66H5oPxKLq7FtqTZANhzYAqpZpF/jIu0A4G74pAEidDwJ2ytvKF9VjuV6Z2jAZ8I548Iitk5xhBqG2uppchnKGDr4uSdYhbxsRELFmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693250; c=relaxed/simple;
	bh=J7DJ/kDMELR2fLvV70hUzCnd+Gnh1kdF4bOeiqX9T/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OCxh9a8JUXGsgcYS3wSZJhA8Pw/jkSUXxTGeHqqL55xOoRBFFWP6C3vpenEZmEN+i2ENI28mTZuFyyUumgYaJu9DgDuSAITtzkPQKanBgAIV1w3t5xXEUVEHqRoUD1Ex9U0rDWeIdAjsQx+2f4VWpC+G6kFqlQxJVNuWiQLXjAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=fjbGkMwU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso52087915e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 08:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1764693247; x=1765298047; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m+HKHWRUrb5GmONn65VrE5cUKXES5UAqksV8PZTR68I=;
        b=fjbGkMwUxGcA5CVZDzoFiCcscUuvamFubWg+zD/WDM34xDHCSI0u26JgIoh2N6QvvY
         k7JGhEgja4TkprbxUMRQZECIzdxM4g3/nczKVrdTG/6HNMXyEVN9QF3BqHbKrw3Eol8Y
         8F8aPqExJIQ3TZIStHyaX8SeiXwpQsPB7PpxgeYeeFqG415gN19tvkZTlDhPN+xo2SR7
         P1guNMvLdRRY7Gk3Zy7BLLDpeYFmoLHo61hQUMCRSwfPl267D3Xklj0qcEAijt6o0ug0
         8TVN6MSpcFrlAVz1b2OPhyrKJXp1Nlj9N3fpz/r7CYChEsA9pojds86bTLcpokjldWhd
         NhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764693247; x=1765298047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+HKHWRUrb5GmONn65VrE5cUKXES5UAqksV8PZTR68I=;
        b=qrJs1NA7eLgNxKSodsB8Ih90lIZzhiDI07kMyV+EYD/I0dCE8XI9tifqFqa9kJE/yi
         plNegFWx+XXE53Wi6tzcbMR8vanLl+l+CXVXbWRuLT9xNLwj7/SOfcO8LLo4vyWMCnBd
         IF8zulyWny0FQnsELSq6rabTB5dmlgR4BbzQZel1EC2dFaPGPgw0h0P7nV/JVvPQkIEd
         OqyiSTf4Jf4MLc3Ds0LOdzmXM1kvPQ8xAYeeR/VLtv91Z2tXuxlJuYdIpmmUbjbg9c/O
         6S2CDiwoiXCTkGYAbPHsl8bx+EuAavGDJ16+KwqTSLePRkzvoyQCM0uP5LG+yZIeNXpH
         OZjg==
X-Forwarded-Encrypted: i=1; AJvYcCUBxqyQkGms9KF8tav2/uoZgC1TrNlZmxg66cUbg9TXwKjJEksIkS7oPu4C1U7Gw7dxfOIzSZNmPlXW4LbdCQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1WR5HUeDNQava+E3Oo8Cg2AT/CXbiT67nrAeugsuSidZsqzeE
	SYB0Pvwhh/oAYj9nFn07NgiynxfCfgLuVndinEhV2jzQMZfBCT5Ft24zpWozBLfE7BQ=
X-Gm-Gg: ASbGncumdsrS+XsbCd7trS6rrJUqgTqKQMF7JiMGGEcrzvJE6vjL1iJJcp7PkBXc5PC
	NrR1l26IBOCYMVsTIcfgfz9fK1Vxk2PVLKkQRsq4PlCQhaUrAAvozaN5mRJPU58WnQK8lgnnQYg
	D5Cr6aAe/IGEVpS1EWanSMCFEAoqhxG+naRjtI8ON+f/EsKk9+siXI0SO/DeYxUj3VEIIfbZMQs
	bUNhG+9CpEfIkz6rTaJ2zmOK1OL9Bo8fj7PXbHLbvBv1Z/wn4IKsx68eq4NnGM62HUqG+T2ximf
	D6Qak/ijVISUaGqdNHJYnkRxNRac4qYvkc9/pJ4ZLNoOVQyIfWGKwQp4QDUYvxt3+6FmxiFESX/
	W/77aASzEi/6YWO8AFqEQalw+sfPtdQ7EQlLJwHVH50px/8ajYLAURYVFu8CS1FgM4a7QtajCS9
	OxTUyYWaoi0JNb5v7FQITw2A/J0r11/BcJRM3YX9Nqq9Sw2yB4nPEILd1I8A==
X-Google-Smtp-Source: AGHT+IF+RCbHLwrxahRwrsJxRufDBn8yEwtGYeX5LW+8LuHPscJm0XOq5ELouo1Uq98LeD/P2yAwaw==
X-Received: by 2002:a05:600c:1f8f:b0:46e:1fb7:a1b3 with SMTP id 5b1f17b1804b1-477c01ee3camr424174565e9.23.1764693247114;
        Tue, 02 Dec 2025 08:34:07 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a4c02a2sm801545e9.2.2025.12.02.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 08:34:06 -0800 (PST)
Message-ID: <08816d1ac76019f3cc9ae427047545e08b78ea4f.camel@mandelbit.com>
Subject: Re: [RFC net-next 13/13] selftests: ovpn: add test for bound address
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Antonio Quartulli
	 <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Date: Tue, 02 Dec 2025 17:34:06 +0100
In-Reply-To: <aShhdULYMt58e2_B@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
	 <20251121002044.16071-14-antonio@openvpn.net> <aShhdULYMt58e2_B@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-27 at 15:34 +0100, Sabrina Dubroca wrote:
> 2025-11-21, 01:20:44 +0100, Antonio Quartulli wrote:
> > From: Ralf Lici <ralf@mandelbit.com>
> >=20
> > Add a selftest to verify that when a socket is bound to a local
> > address,
> > UDP traffic from ovpn is correctly routed through that address.
> >=20
> > This test extends test-bind.sh by binding to the addresses on each
> > veth
> > pair and uses tcpdump to confirm that traffic flows as expected.
>=20
> Same as the other bind scenario, the test works even if we don't bind
> to that address.

Right, will fix this test as well on the next version.

> A few small comments on the implementation:
>=20
> > @@ -547,45 +518,83 @@ static int ovpn_socket(struct ovpn_ctx *ctx,
> > sa_family_t family, int proto)
> > =C2=A0		if (setsockopt(s, SOL_SOCKET, SO_BINDTODEVICE, ctx-
> > >bind_dev,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strlen(ctx->bind_dev) + 1=
) !=3D 0) {
> > =C2=A0			perror("setsockopt for SO_BINDTODEVICE");
> > -			return -1;
> > +			goto close;
>=20
> ret isn't reset here, ovpn_socket will return a stale value.

ACK.

>=20
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > -	ret =3D bind(s, (struct sockaddr *)&local_sock, sock_len);
> > -	if (ret < 0) {
> > -		perror("cannot bind socket");
> > -		goto err_socket;
> > +	return s;
> > +close:
> > +	close(s);
> > +	return ret;
> > +}
> > +
> [...]
> > @@ -2221,6 +2228,9 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx
> > *ovpn, int argc, char *argv[])
> > =C2=A0
> > =C2=A0		ovpn->sa_family =3D AF_INET;
> > =C2=A0
> > +		ovpn->laddr =3D NULL;
> > +		ovpn->lport =3D "1";
>=20
> Why do we want lport=3D1 on the CONNECT side now?

That's a mistake. I should have set "0" to let the kernel pick an
ephemeral port.

> > +
> > =C2=A0		ret =3D ovpn_parse_new_peer(ovpn, argv[3], argv[4],
> > argv[5], argv[6],
> > =C2=A0					=C2=A0 NULL);
> > =C2=A0		if (ret < 0) {

Thanks a lot!

--=20
Ralf Lici
Mandelbit Srl

