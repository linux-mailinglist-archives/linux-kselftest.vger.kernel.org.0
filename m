Return-Path: <linux-kselftest+bounces-14154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B412393B2E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD57E1C237E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C1215B111;
	Wed, 24 Jul 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pibr8zHD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE615A87F;
	Wed, 24 Jul 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832086; cv=none; b=ijPlWInHuRcvPXJob9zU1SYgak0DHCNIX98RV2rO4Q3DvnfbcgDu+3LxpkSwEpzd4BsEpm17+h3ESL/2rvPVCz+aFjZWx+giiA1hEFny0RCFQ4lZuQ9uoIMCWMSK3EkhEddvqX10dv3cjbq3C/jW81PZWAcrKJZWgsqjESh2+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832086; c=relaxed/simple;
	bh=XzeVJUuzHIFtxs2o38S7UW9QkcHvr2am4417a1C2ObA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uL9ELLtw1jExxVXl+T1eLjIimRSZ3VG9bvVXS3smiBfLR6ktsRdOg9jWwtBr2fa1dBzzVDpYAM1C99m/kM6FdprbQFzUgRQhrxpC2AoB1NLAF1t5idu0bhWZaEfKJ+K01WfDaffcnyKCQCxYNBTV1Sy4/EslC5//2sRRUzY3oRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pibr8zHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B6BC32781;
	Wed, 24 Jul 2024 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721832085;
	bh=XzeVJUuzHIFtxs2o38S7UW9QkcHvr2am4417a1C2ObA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pibr8zHD0g17ROeTOSoSP6yJ9Wnhf5u6pn1sOYZqFxWwdIz7peygMJvcAv1jpsaPU
	 YmsYdGfre7jRoV4vnz449kI8sqmuRvmf60Bsulhftf0LAawcuzXXj62TylczMqr0Nu
	 XvoaSWzQgDLQRMJKxT+a3xncO5PxRNW2RqBBgGo0QwxYSeX+Y9HNMgPcPHv7jWXW//
	 kdMj+n80aj6AhBheaLo9edFt6y3lRtxHGwwTmJCwOvVX895/SAPUMh2s7uPJvSctab
	 1EXs88rJ4PUzvSJQoLO6U4FPDtkgOfJ+pUfpRrR8fp/m49lHxcicImze1ENQc2MRDf
	 migjq72xBAcXQ==
Date: Wed, 24 Jul 2024 07:41:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, shuah@kernel.org,
 arefev@swemel.ru, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Alexander Duyck
 <alexander.duyck@gmail.com>
Subject: Re: [PATCH net] virtio: fix GSO with frames unaligned to size
Message-ID: <20240724074123.614feaa4@kernel.org>
In-Reply-To: <CAF=yD-LJ+-S4gC9EVo6ijJTGjR6KfPMNPrpxoffgoQBFpo8GNQ@mail.gmail.com>
References: <20240723223109.2196886-1-kuba@kernel.org>
	<CAF=yD-LJ+-S4gC9EVo6ijJTGjR6KfPMNPrpxoffgoQBFpo8GNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jul 2024 23:48:24 -0400 Willem de Bruijn wrote:
> On Tue, Jul 23, 2024 at 3:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > The commit under fixes added a questionable check to
> > virtio_net_hdr_to_skb(). I'm guessing the check was supposed
> > to protect from csum offset being outside of a segment
> > (especially if len is not multiple of segment size).
> >
> > The condition can't be right, tho, as it breaks previously
> > working sending of GSO frames with only one segment
> > (i.e. when gso_size <=3D len we silently ignore the GSO
> > request and send a single non-GSO frame).
> >
> > Fix the logic and move it to the GSO part. =20
>=20
> I missed the previous patch. Should we revert that and create a new
> fix against the original issue?

We can, no strong preference.

> Normally the checksum start + offset should always be in the header,
> so not even part of gso_size. So needed need not be related to
> gso_size.
>=20
> The exception to this is UDP fragmentation offload, I suppose. As
> there the network and transport headers are part of the UFO payload.
>=20
> But even for the normal TSO and USO cases we cannot verify in
> virtio_net_hdr_to_skb that the csum_start + csum_off passed from
> userspace are really pointing into the transport header.
>=20
> For SKB_GSO_UDP_L4 I added a minimal check that csum_off must be
> offsetof(struct udphdr, check). We can arguably tighten these csum_off
> for all requests, as only UDP and TCP offsets are valid. But no such
> simple check exists for csum_start. This requires full packet parsing,
> which we don't do until skb_gso_segment.
>=20
> One option may be to test csum_start in tcp_gso_segment and
> udp_gso_fragment and fail segmentation when it points not where
> expected.

That should work, I think.
Should we still check the segment boundaries, tho?
A bit worrying to have packets floating around the stack with clearly
broken csum offset. At the same time maybe the modulo isn't free..

> Btw, do we have a better idea what exact packet triggered this
> WARN_ON_ONCE in skb_checksum_help? Usually, more interesting than the
> skb_dump of the segment that reached the WARN is the skb_dump at the
> time of virtio_net_hdr_to_skb, along with the vnet_hdr.

I don't have any extra info, beyond what's in the commit message :(
Note that the syzbot report says 6.7, too.
Denis, can you comment? Do you have a repro?

> > This has been caught by net/tap and net/psock_send.sh tests. =20
>=20
> That's very nice!
>=20
> > Fixes: e269d79c7d35 ("net: missing check virtio")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org> =20
>=20
> > +               if (csum_needed) {
> > +                       unsigned int p_rem, p_size;
> > +
> > +                       p_size =3D gso_size;
> > +                       p_rem =3D (skb->len - nh_off) % gso_size;
> > +                       if (p_rem)
> > +                               p_size =3D p_rem;
> > +
> > +                       /* Make sure csum still within packet after GSO=
 */
> > +                       if (p_size + nh_off < csum_needed)
> > +                               return -EINVAL;
> > +               }
> > + =20
>=20
> A check could even go in the below branch.
>=20
> The warning apparently was not that csum_needed is outside the segment
> entirely, but that the segment is non-linear and csum_start points in
> the non-linear part (offset >=3D skb_headlen(skb)).

Yes, I don't think the fix actually fixed the quoted warning :/
I decided to redo what it seem to have intended to fix in an un-broken
way, but the underlying issue is different.

> I don't think we should be playing SKBFL_SHARED_FRAG tricks to trigger
> linearization, to be clear.
>=20
> We also cannot just silence the WARN and trust that the stack detects
> these bad packets and drops them (as ip_do_fragment does), as they
> might end up not in ip_do_fragment, but in a device ndo_start_xmit.
>=20
> >                 /* Too small packets are not really GSO ones. */
> >                 if (skb->len - nh_off > gso_size) {
> >                         shinfo->gso_size =3D gso_size;



