Return-Path: <linux-kselftest+bounces-42072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299E9B92146
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06852A36DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ADA30BB8F;
	Mon, 22 Sep 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqQf93gW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31D44C63;
	Mon, 22 Sep 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556529; cv=none; b=DORS3MaBInVn8va8WdiWVaRJd+LiKwn5EcLMwV5BW3VggLFYMeZJTJ1paL3kvh0lIfRdTgDOKtSAAzcY1hIPpEcEpIMru8uulqhM1PRO8c1/RZhe3HJ+KG3+Rw1C5WGO+MJcft7A9xzRW20JRri4tKN3t3kY3wgfkCZy2X7E0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556529; c=relaxed/simple;
	bh=Onf3CcsEJl0ngxXMEOYfC15DjUX6QEH0Zyjt05mjWVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpiSD3ue2TdwAC2wF1tUpucM7ZK1nKUPpWOvVQS8q2QCWlDaXAETfJswac0KzTWCdx8qv48dyJ9ifh1L/EO3bcZ3HlDt6i6Nw+dHykrF4AHLS76K/Ks0oLuc/1cwGexa+aCm4ClJqiVA2e99l6wiJU8odGMqTtcLxuc0JonsHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqQf93gW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19994C4CEF0;
	Mon, 22 Sep 2025 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758556527;
	bh=Onf3CcsEJl0ngxXMEOYfC15DjUX6QEH0Zyjt05mjWVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqQf93gWSxKJStGz129YFX6KAQwrxTlN5QqPXhCPOyO3gDva8XoByKeTQzuv5anyr
	 zLtDABiPBw0iutIDE1ciQelQjDWj4pbHa94uLii2EtmR9LqJDYeZRqdthdLta6AvRo
	 /EFlKzIzi/GUIZfQ8DUscmCVWOzfHs6zo7BE8gk6ZWHDnuMuZAVFE+LJ8dzaAkh+u5
	 dyExzz37ACD7g3U75rBi6hH87mw1VetRNWkuixHOj+LaFNL7R0GlZ5pp86Mq9pI1ud
	 2Gi+QytZJ8Gc2HxWLMaiSQMTa0z9j5lqR8rXoFtgVnMh/0EPxrbRbm5VMvO9R6OOWM
	 wcMPEAeusSm0w==
Date: Mon, 22 Sep 2025 17:55:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 1/6] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aNFxbVqzM1VhxD_G@lore-desk>
References: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
 <20250920-xdp-meta-rxcksum-v1-1-35e76a8a84e7@kernel.org>
 <aNFtljcYeLK3uVo3@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bRMqdsBuSfWUVEkl"
Content-Disposition: inline
In-Reply-To: <aNFtljcYeLK3uVo3@mini-arch>


--bRMqdsBuSfWUVEkl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 22, Stanislav Fomichev wrote:
> On 09/20, Lorenzo Bianconi wrote:
> > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > checksum will be use by devices capable of exposing receive checksum
> > result via bpf_xdp_metadata_rx_checksum().
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/netlink/specs/netdev.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee35=
48098b0c933fd39a4 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -61,6 +61,11 @@ definitions:
> >          doc: |
> >            Device is capable of exposing receive packet VLAN tag via
> >            bpf_xdp_metadata_rx_vlan_tag().
> > +      -
> > +        name: checksum
> > +        doc: |
> > +          Device is capable of exposing receive checksum result via
> > +          bpf_xdp_metadata_rx_checksum().
> >    -
> >      type: flags
> >      name: xsk-flags
>=20
> nit: let's fold it into patch 2? Will be easier to git blame the
> feature..

ack, I will do it posting a proper series.

Regards,
Lorenzo

--bRMqdsBuSfWUVEkl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaNFxbQAKCRA6cBh0uS2t
rNMHAQCZQ8ZRjtV8RUnz2vY6o7/MqAASpGYpoP/69OTl9wjz7QEA0EogEhTfo2Hk
xMcNGq1A1zWlgoqIzDCE3KQhy/c4BgA=
=RRWF
-----END PGP SIGNATURE-----

--bRMqdsBuSfWUVEkl--

