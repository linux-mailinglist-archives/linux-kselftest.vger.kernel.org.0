Return-Path: <linux-kselftest+bounces-42074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6838B92163
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 17:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786092A3567
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E162FE566;
	Mon, 22 Sep 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7F94CZG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2013D2B2;
	Mon, 22 Sep 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556584; cv=none; b=hbCV7dVmcmwMVhJyTzk9iTitx+TGsfjfcetXXcQbUoucAUTx2tik+VRxvrmmOxgYJKMsNHQ6agqaX3ZW8INMgjCoR4Q7LqlOxUzmVyOLT6fXsJHQ4+l+j6f89Y2uCSq1D79QGADIa8rSXaA3cTQ/fiuPqdJO8D3sXVUZNC6pdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556584; c=relaxed/simple;
	bh=A6td5LYxhItzS+7GkGUIeiplez2Gyg59sgZwyjPm6Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/+UEjhD510AkQRG7P7vkGNzSDQvFiqy/IZLfHhEDsHUlCU9Ryn6scNlSTTE0yrQTfki7fB1bByENW28eHWbTuhy43bV7vwGtgGHGlZM7oWEvxQ30l8B+in7ktBuqa/49NKwKXd/2vm2Y3SB6ZOhke4YG3DV4S2+9wD2sWbn8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7F94CZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A9AC4CEF0;
	Mon, 22 Sep 2025 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758556583;
	bh=A6td5LYxhItzS+7GkGUIeiplez2Gyg59sgZwyjPm6Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7F94CZGzy39yWMnpePBwU1gAZA6GtnNm5q+R2fJLT4HR32EAcFKOI5IJ2xzGPx8G
	 ZlR+IorUm91M5N+ibx/KQfekktoMKN4Rz6K2FVBAKMAFbQcNQV6Dsb75Gfd96BUWg5
	 eIlDggoK1y8rbZBKwwwdieyIQdnyz8spf5GVqiZgpg10zoVqkYGpWmanQWoIwojifh
	 noOvNDu7DXpWScIj3NPn8L/lXRRtyeMBEynT8PC6xERBL+K813kxbijUkLkeWg1brJ
	 7wMKAzsn/NSzP90e0Tts4xYJ5RxKUoZ8Bbh68hRndyEymRCvUAQvF2nfDTHHsA6L5p
	 A4YorxVN+bKDg==
Date: Mon, 22 Sep 2025 17:56:21 +0200
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
Subject: Re: [PATCH RFC bpf-next 2/6] net: xdp: Add xmo_rx_checksum callback
Message-ID: <aNFxpVGo7YdHKMMn@lore-desk>
References: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
 <20250920-xdp-meta-rxcksum-v1-2-35e76a8a84e7@kernel.org>
 <aNFupGy1QxlhRSUE@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oLV4KCwzri5jB3PU"
Content-Disposition: inline
In-Reply-To: <aNFupGy1QxlhRSUE@mini-arch>


--oLV4KCwzri5jB3PU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 09/20, Lorenzo Bianconi wrote:
> > Introduce xmo_rx_checksum netdev callback in order allow the eBPF
> > program bounded to the device to retrieve the RX checksum result comput=
ed
> > by the hw NIC.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  include/net/xdp.h |  6 ++++++
> >  net/core/xdp.c    | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >=20
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 6fd294fa6841d59c3d7dc4475e09e731996566b0..481b39976ac8c8d4db2de39=
055c72ba8d0d511c3 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -581,6 +581,10 @@ void xdp_attachment_setup(struct xdp_attachment_in=
fo *info,
> >  			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> >  			   bpf_xdp_metadata_rx_vlan_tag, \
> >  			   xmo_rx_vlan_tag) \
> > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > +			   bpf_xdp_metadata_rx_checksum, \
> > +			   xmo_rx_checksum)
> > =20
> >  enum xdp_rx_metadata {
> >  #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > @@ -644,6 +648,8 @@ struct xdp_metadata_ops {
> >  			       enum xdp_rss_hash_type *rss_type);
> >  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
> >  				   u16 *vlan_tci);
> > +	int	(*xmo_rx_checksum)(const struct xdp_md *ctx, u8 *ip_summed,
> > +				   u32 *cksum_meta);
> >  };
> > =20
> >  #ifdef CONFIG_NET
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 9100e160113a9a1e2cb88e7602e85c5f36a9f3b9..3edab2d5e5c7c2013b1ef98=
c949a83655eb94349 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -961,6 +961,35 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const=
 struct xdp_md *ctx,
> >  	return -EOPNOTSUPP;
> >  }
> > =20
> > +/**
> > + * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
> > + * @ctx: XDP context pointer.
> > + * @ip_summed: Return value pointer indicating checksum result.
> > + * @cksum_meta: Return value pointer indicating checksum result metada=
ta.
> > + *
> > + * In case of success, ``ip_summed`` is set to the RX checksum result.=
 Possible
> > + * values are:
> > + * ``CHECKSUM_NONE``
> > + * ``CHECKSUM_UNNECESSARY``
> > + * ``CHECKSUM_COMPLETE``
> > + * ``CHECKSUM_PARTIAL``
>=20
> What do you think about adding new UAPI enum here? Similar to
> xdp_rss_hash_type for the hash. The values can match the internal
> CHECKSUM_XXX ones with (BUILD_BUG_ONs to enforce the relationship).
> Will be a bit nicer api-wise to have an enum than an opaque u8.

ack, fine. I will fix it v1.

Regards,
Lorenzo


--oLV4KCwzri5jB3PU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaNFxpQAKCRA6cBh0uS2t
rDlFAP9f4DjX1fOKxrEiOYqDgqgqHd37X+FW2Ruk7neFu2Lh3gEAvTvJwg8PnFeY
ayPyTpytuunY9VYrc/mA8PIfy/FidgU=
=lFKD
-----END PGP SIGNATURE-----

--oLV4KCwzri5jB3PU--

