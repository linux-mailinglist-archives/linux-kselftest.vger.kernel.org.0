Return-Path: <linux-kselftest+bounces-47240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 404FDCABA4C
	for <lists+linux-kselftest@lfdr.de>; Sun, 07 Dec 2025 22:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16CED3001B9C
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Dec 2025 21:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5D2DCF47;
	Sun,  7 Dec 2025 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCIpBbu9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F432D8DA4;
	Sun,  7 Dec 2025 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765144509; cv=none; b=UqnJyFsm/L71sYSBm310yfHtJs+aXbvSz8/kPa3ueBRVI1E98EH20KNJ6Mtee1MI8tbh9hCe6NeYM8lo3H7AGSWOGMH+AcuD46yATAofb0nfK65pKvMHu/cUW2ishHQNX8shy4yUAKdaS9bvg56bhXSaabcBsGZfzK6BB49NXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765144509; c=relaxed/simple;
	bh=ifK/LaHPNtOnVBGvaz4T+mPIkp7m9v1XbXWTdT3KCKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTQ+xeGqLvGHYqntizhSpDg6l3mOf6ehNw4zfrWvcw9XT/5Mpwihst6XRo5kx1d8WO0LBSbLtAKqWeeh1fb2zGUuRNjN3IxijvP7dn5fRkgC116dW9MFLZQz6R9TFUcTK7l+tzCtJKDrhXR3XEFp0GXpVhT4IDBlVVHdbmWiuK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCIpBbu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8D1C4CEFB;
	Sun,  7 Dec 2025 21:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765144505;
	bh=ifK/LaHPNtOnVBGvaz4T+mPIkp7m9v1XbXWTdT3KCKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCIpBbu9Yoq/NmfnZma0dFQue1dQE+K4H4mnQl1IKPmsaLZhNRYGqIwLKCTeHMep7
	 VOjui8/lhXaVBhdzMMaZvW7jt4OqP6a9EFiEl1mZaRgX+kcaDoGG1dzDZAjlSSbKwc
	 V1DZXq+zfMs5I/yIhHoUPzWqH6xv1+cTQlV0UbKYhvRA0gny0w83ZIQ0+7dNxT/t3y
	 Ek9gMaAl5ZGf2gM5QsPOv1oY8pg6yxe6RaQtxiZ0a3z2r5hnHCAwmDiBdXSeqdgrw2
	 /Dk2eR5NnPk4nWSx1Tp7uzNEat9dkIQR4l9Mi183be4EPOJC6/D6khmT9MWkrusFo+
	 i7z9rMnDp7IJg==
Date: Sun, 7 Dec 2025 22:55:02 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next 0/5] Add IP6IP6 flowtable SW acceleration
Message-ID: <aTX3tncSC5GqW-ES@lore-desk>
References: <20251207-b4-flowtable-offload-ip6ip6-v1-0-18e3ab7f748c@kernel.org>
 <20251207130654.698001f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A86Dlecj8/P/xSwD"
Content-Disposition: inline
In-Reply-To: <20251207130654.698001f3@kernel.org>


--A86Dlecj8/P/xSwD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 07 Dec 2025 17:06:40 +0100 Lorenzo Bianconi wrote:
> > Introduce SW acceleration for IP6IP6 tunnels in the netfilter flowtable
> > infrastructure.
>=20
> tc-testing build fails with this:
>=20
> net/netfilter/nf_flow_table_ip.c: In function =E2=80=98nf_flow_ip6_tunnel=
_proto=E2=80=99:
> net/netfilter/nf_flow_table_ip.c:370:42: error: =E2=80=98inet6_protos=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98inet_=
protos=E2=80=99?
>   370 |                 ipprot =3D rcu_dereference(inet6_protos[nexthdr]);
>       |                                          ^~~~~~~~~~~~
> ./include/linux/rcupdate.h:532:17: note: in definition of macro =E2=80=98=
__rcu_dereference_check=E2=80=99
>   532 |         typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
>       |                 ^
> ./include/linux/rcupdate.h:770:28: note: in expansion of macro =E2=80=98r=
cu_dereference_check=E2=80=99
>   770 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>       |                            ^~~~~~~~~~~~~~~~~~~~~
> net/netfilter/nf_flow_table_ip.c:370:26: note: in expansion of macro =E2=
=80=98rcu_dereference=E2=80=99
>   370 |                 ipprot =3D rcu_dereference(inet6_protos[nexthdr]);
>       |                          ^~~~~~~~~~~~~~~
> net/netfilter/nf_flow_table_ip.c:370:42: note: each undeclared identifier=
 is reported only once for each function it appears in
>   370 |                 ipprot =3D rcu_dereference(inet6_protos[nexthdr]);
>       |                                          ^~~~~~~~~~~~
> ./include/linux/rcupdate.h:532:17: note: in definition of macro =E2=80=98=
__rcu_dereference_check=E2=80=99
>   532 |         typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
>       |                 ^
> ./include/linux/rcupdate.h:770:28: note: in expansion of macro =E2=80=98r=
cu_dereference_check=E2=80=99
>   770 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>       |                            ^~~~~~~~~~~~~~~~~~~~~
> net/netfilter/nf_flow_table_ip.c:370:26: note: in expansion of macro =E2=
=80=98rcu_dereference=E2=80=99
>   370 |                 ipprot =3D rcu_dereference(inet6_protos[nexthdr]);
>       |                          ^~~~~~~~~~~~~~~
> net/netfilter/nf_flow_table_ip.c:374:27: error: invalid use of undefined =
type =E2=80=98const struct inet6_protocol=E2=80=99
>   374 |                 if (ipprot->flags & INET6_PROTO_FINAL) {
>       |                           ^~
> net/netfilter/nf_flow_table_ip.c:374:37: error: =E2=80=98INET6_PROTO_FINA=
L=E2=80=99 undeclared (first use in this function)
>   374 |                 if (ipprot->flags & INET6_PROTO_FINAL) {
>       |                                     ^~~~~~~~~~~~~~~~~
> net/netfilter/nf_flow_table_ip.c:383:29: error: invalid use of undefined =
type =E2=80=98const struct inet6_protocol=E2=80=99
>   383 |                 ret =3D ipprot->handler(skb);
>       |                             ^~

Hi Jakub,

I guess CONFIG_IPV6 is not enabled, right? I will fix it.

Regards,
Lorenzo

--A86Dlecj8/P/xSwD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaTX3tgAKCRA6cBh0uS2t
rKvBAQC3nSIcXG//ue7XnInEvT78oqm+x7qbcxw2kmR6dTRMXAEA5KpQfNU3bH1M
+8Qf+cFSNh+JDtcJV42xrT3uHId16Qs=
=RZle
-----END PGP SIGNATURE-----

--A86Dlecj8/P/xSwD--

