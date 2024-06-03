Return-Path: <linux-kselftest+bounces-11097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D38D7C1D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 09:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22F91F22A23
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 07:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6745839FE5;
	Mon,  3 Jun 2024 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="W/Dd/5SR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845838DE1;
	Mon,  3 Jun 2024 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398220; cv=none; b=kiN1nG4zlD3AQGVrspreCwJgjSOb5yJMwIUZxRSVCsqhTZFl4sPVGZBwRxGKrWY35ZzluxZgghvCTgfF6HqtzUeNVnIvMp+E262h3CvezrC29F9wJ43gNS98WMhSe5TP3UZBhHK3ipBT6MUb+1Uad8f2XsVkBGf+or4DJgvu1ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398220; c=relaxed/simple;
	bh=UwiT9i7QKsZeFRnVhCPkDUyFUr4Bjhk57FjXtm5j1L8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kubhAyAyxHq81bQPnGxK0kYZvht0NgaHq+rvL9ZRk2Q1tWGNP433hH/C78hqkRmjPcEe/+vpjwv09eMaRTqFH18AXQUwVmQ8iLusP4w2Ah4qE90v5SnvMwL34gJCRXfXgbIt8YfphRAwZ2eOfLeBtsPoTpS72no/SpfgE5Y3CTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=W/Dd/5SR; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3F25987D4F;
	Mon,  3 Jun 2024 09:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717398210;
	bh=/5tiGd5pGdf6aZEybqPPhF21h6T2J0vgCrJD+FKGjZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W/Dd/5SREWKMPK4oEMy7v3+vjc7htmpgltzvc24TyZeC/d0uQCMiH3On1ma/nhhhw
	 BRP5coF/heAHFGGShfQHcOa7BT7fsRJZdRsSbGqcN4btXWfXHTKjJ7buhoCeVAh0+D
	 14nUnNLwV9vxJMHogss93VcC+RZcpROMNSwI0GY32yZfh6Q212xWSTXdMgOM5zyya/
	 SCYRQW2fFagpmaHgl3qtLl0jsewviYa9dzsfh1XrHJpthuoaYCBmVK/51iCmHJ+pMS
	 p+N+Kcja8rPf50ghynmCs+WRtWu2qcsPjyIEfaG2hpNNYlG2A99UjL5g0uX/26P34N
	 n66RaXV365N4w==
Date: Mon, 3 Jun 2024 09:03:27 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>, Nikita
 Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Arvid Brodin <Arvid.Brodin@xdin.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, "Ricardo B. Marliere" <ricardo@marliere.net>,
 Casper Andersson <casper.casan@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Geliang Tang <tanggeliang@kylinos.cn>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: hsr: Extend the hsr_redbox.sh test to use
 fixed MAC addresses
Message-ID: <20240603090327.44d43f53@wsk>
In-Reply-To: <ZlfXmDN-W1dZRYQL@Laptop-X1>
References: <20240529142232.2625747-1-lukma@denx.de>
	<20240529142232.2625747-2-lukma@denx.de>
	<ZlfXmDN-W1dZRYQL@Laptop-X1>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z8W=oEaNQY.U9rvg.vX2APw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/z8W=oEaNQY.U9rvg.vX2APw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Hangbin,

> On Wed, May 29, 2024 at 04:22:32PM +0200, Lukasz Majewski wrote:
> > Fixed MAC addresses help with debugging as last four bytes identify
> > the network namespace.
> >=20
> > Moreover, it allows to mimic the real life setup with for example
> > bridge having the same MAC address on each port.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  tools/testing/selftests/net/hsr/hsr_redbox.sh | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/net/hsr/hsr_redbox.sh
> > b/tools/testing/selftests/net/hsr/hsr_redbox.sh index
> > 1f36785347c0..998103502d5d 100755 ---
> > a/tools/testing/selftests/net/hsr/hsr_redbox.sh +++
> > b/tools/testing/selftests/net/hsr/hsr_redbox.sh @@ -96,6 +96,21 @@
> > setup_hsr_interfaces() ip -n "${ns4}" link set ns4eth1 up
> >  	ip -n "${ns5}" link set ns5eth1 up
> > =20
> > +	ip -net "$ns1" link set address 00:11:22:00:01:01 dev
> > ns1eth1
> > +	ip -net "$ns1" link set address 00:11:22:00:01:02 dev
> > ns1eth2 +
> > +	ip -net "$ns2" link set address 00:11:22:00:02:01 dev
> > ns2eth1
> > +	ip -net "$ns2" link set address 00:11:22:00:02:02 dev
> > ns2eth2
> > +	ip -net "$ns2" link set address 00:11:22:00:02:03 dev
> > ns2eth3 +
> > +	ip -net "$ns3" link set address 00:11:22:00:03:11 dev
> > ns3eth1
> > +	ip -net "$ns3" link set address 00:11:22:00:03:11 dev
> > ns3eth2
> > +	ip -net "$ns3" link set address 00:11:22:00:03:11 dev
> > ns3eth3
> > +	ip -net "$ns3" link set address 00:11:22:00:03:11 dev
> > ns3br1 =20
>=20
> The ns3's mac addresses are same, is it a copy-paste error?
>=20

No, it is to mimic the switch behaviour.

> BTW, please add the target tree for the patch, e.g.
>=20
> [PATCH net-next]

Ok.

>=20
> Thanks
> Hangbin




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/z8W=oEaNQY.U9rvg.vX2APw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZdar8ACgkQAR8vZIA0
zr3YeAgAx49HYhwsbFX+W79el/XYDzgWltp7XpxTRGWmi5/Aed3UdY+Ym5KfoziB
HOMZWYInj0H8Gx+85e9kgObLHv/0bDQGbpu19uBzmsrk6Scv7H9vqgZaSQzzpPT+
041vngmHhdknG39xDN+AgT1OOZt95N7gAM7qZqD72bohRxhcJ6BSh7REdyG9kSv4
Ow1KkBky9aKQCnATC2RQBVxL5ex3QKINpiGIeMYbhiVIpTDINU7Rl3U+Fj0aOgW1
wtuD8a28UVBnmkXFs3aVB3N8DPBgVwmSKR/yJHGzCcTJEWLHjwrjX7u2F/ogZSmI
k4Gwyja4rojDvqrA84zQy8ol83z75g==
=iEHT
-----END PGP SIGNATURE-----

--Sig_/z8W=oEaNQY.U9rvg.vX2APw--

