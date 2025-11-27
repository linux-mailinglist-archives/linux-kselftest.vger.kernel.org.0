Return-Path: <linux-kselftest+bounces-46631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16220C8E099
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 12:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1FAA341D5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2465A32B9A6;
	Thu, 27 Nov 2025 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfjTDYge"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FCD2DF150;
	Thu, 27 Nov 2025 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242741; cv=none; b=WHA7LmAuvMRI/q1MQMxMIBwE0u7lv1+RAgbSXSNWzV0+RLjet1mnI5vcmOaNLaRLyc9z+LZKUwnIrgwJJ+cHL1HywN75AyHD62q1pfR5gwoW63UzVDFbjUnqMRXurGFs4hhkkZu8gYf9VxqBpPU/aNMly7fHtCx4DI+WUU+QSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242741; c=relaxed/simple;
	bh=klsQXQWIM/W0A3+8u+ebvJsqnxI8wgEmwKoXWgVRls8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBrLIudwTkoiy3gmlCGU02bKmGSCgApE8O1RvC1N8A2gtqTv2r2PjoSC/EHuYoBckGXxL+4Z4Cqw1N27UNUx3fS46j8plr73ZZMKAbIzSxbg5Uyah2cY0WRON9S7uwiw71N38CVFV0I+zkv3SIxyZiQzAf8w1Piust7qSKNDC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfjTDYge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B7CC4CEF8;
	Thu, 27 Nov 2025 11:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764242740;
	bh=klsQXQWIM/W0A3+8u+ebvJsqnxI8wgEmwKoXWgVRls8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bfjTDYgenpiyb2DhdPl2ZZ8I8Poy7JxyW7aGXys/GVmXe2l8W8kpCc9O35XSxpriQ
	 5cXXRLxq2F9HbjRAhDti+/b+jMjUaoASHlDtlQUVjpFzUagyn5D+CzMcv1tFIZuLie
	 XOGWT0of0wgN1HnV73xovyC5NlcXBU0ptQo2Toeh+t9yg9qGa9FnAO2BobRzqmjJ0f
	 SF/MRQm/rILAIFvmHrKVsHcXTsr5uLAoNcKuQkSCHt4bJl7Gl5Yat5pA9HiTTEkx1U
	 yvIa6239Off+I9k2Pwecgq7QrGrB6H8s9ogVZMM6uSceoTnUbl9p8Yy+XBQYxt0LKY
	 j5sFcLQOkRelg==
Date: Thu, 27 Nov 2025 12:25:37 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next] selftests: netfilter: nft_flowtable.sh: Add the
 capability to send IPv6 TCP traffic
Message-ID: <aSg1MWLUx0GyCWij@lore-desk>
References: <20251122-nft_flowtable-sh-ipv6-tcp-v1-1-4480d3c863a2@kernel.org>
 <aSgllQoIqNHIXqrs@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2PK2emLCa6m1sKgr"
Content-Disposition: inline
In-Reply-To: <aSgllQoIqNHIXqrs@horms.kernel.org>


--2PK2emLCa6m1sKgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Nov 22, 2025 at 07:41:38PM +0100, Lorenzo Bianconi wrote:
> > Introduce the capability to send TCP traffic over IPv6 to
> > nft_flowtable netfilter selftest.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../selftests/net/netfilter/nft_flowtable.sh       | 47 ++++++++++++++=
+-------
> >  1 file changed, 33 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/t=
ools/testing/selftests/net/netfilter/nft_flowtable.sh
> > index 1fbfc8ad8dcdc5db2ab1a1ea9310f655d09eee83..24b4e60b91451e7ea7f6a04=
1b0335233047c6242 100755
> > --- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
> > +++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
> > @@ -127,6 +127,8 @@ ip -net "$nsr1" addr add fee1:2::1/64 dev veth1 nod=
ad
> >  ip -net "$nsr2" addr add 192.168.10.2/24 dev veth0
> >  ip -net "$nsr2" addr add fee1:2::2/64 dev veth0 nodad
> > =20
> > +ip netns exec "$nsr1" sysctl net.ipv6.conf.all.forwarding=3D1 > /dev/n=
ull
> > +ip netns exec "$nsr2" sysctl net.ipv6.conf.all.forwarding=3D1 > /dev/n=
ull
> >  for i in 0 1; do
> >    ip netns exec "$nsr1" sysctl net.ipv4.conf.veth$i.forwarding=3D1 > /=
dev/null
> >    ip netns exec "$nsr2" sysctl net.ipv4.conf.veth$i.forwarding=3D1 > /=
dev/null
> > @@ -153,7 +155,9 @@ ip -net "$ns1" route add default via dead:1::1
> >  ip -net "$ns2" route add default via dead:2::1
> > =20
> >  ip -net "$nsr1" route add default via 192.168.10.2
> > +ip -6 -net "$nsr1" route add default via fee1:2::2
> >  ip -net "$nsr2" route add default via 192.168.10.1
> > +ip -6 -net "$nsr2" route add default via fee1:2::1
> > =20
> >  ip netns exec "$nsr1" nft -f - <<EOF
> >  table inet filter {
> > @@ -352,8 +356,9 @@ test_tcp_forwarding_ip()
> >  	local nsa=3D$1
> >  	local nsb=3D$2
> >  	local pmtu=3D$3
> > -	local dstip=3D$4
> > -	local dstport=3D$5
> > +	local proto=3D$4
> > +	local dstip=3D$5
> > +	local dstport=3D$6
> >  	local lret=3D0
> >  	local socatc
> >  	local socatl
> > @@ -363,12 +368,12 @@ test_tcp_forwarding_ip()
> >  		infile=3D"$nsin_small"
> >  	fi
> > =20
> > -	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -4 TCP-LISTEN:123=
45,reuseaddr STDIO < "$infile" > "$ns2out" &
> > +	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -${proto} TCP${pr=
oto}-LISTEN:12345,reuseaddr STDIO < "$infile" > "$ns2out" &
>=20
> Hi Lorenzo,
>=20
> Some minor nits:
>=20
> 1. This line is (and was) excessively long.
>    Maybe it can be addressed as the line is being modified anyway.
>=20
>    Flagged by checkpatch
>=20
> 2. Prior to this patch, variables on this line were enclosed in "" to
>    guard against word splitting when expansion occurs.
>    This is no longer the case.
>=20
>    Flagged by shellcheck
>=20
> >  	lpid=3D$!
> > =20
> >  	busywait 1000 listener_ready
> > =20
> > -	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -4 TCP:"$dstip":"=
$dstport" STDIO < "$infile" > "$ns1out"
> > +	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -${proto} TCP${pr=
oto}:"$dstip":"$dstport" STDIO < "$infile" > "$ns1out"
> >  	socatc=3D$?
>=20
> Likewise here.
>=20
> > =20
> >  	wait $lpid
>=20
> Otherwise this LGTM.

Hi Simon,

ack, fine. Is it ok to address them in subsequent patch or do you prefer to
address them here?
@Pablo: what do you prefer?

Regards,
Lorenzo

--2PK2emLCa6m1sKgr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaSg1MQAKCRA6cBh0uS2t
rGKLAQC521bkBKE4oBPFXY9p1BVo39UkFs8KP1qysYGPohM/GQEA8wCjhIq5DGuv
iJsBvnoothxCgO9sCvS3V4SQJKOyZwY=
=OfbJ
-----END PGP SIGNATURE-----

--2PK2emLCa6m1sKgr--

