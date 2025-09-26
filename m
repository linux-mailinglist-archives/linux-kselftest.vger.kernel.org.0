Return-Path: <linux-kselftest+bounces-42465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12534BA3B67
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 14:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5033BBA28
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E8C29B214;
	Fri, 26 Sep 2025 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIwrH/Fw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797F1EEE6;
	Fri, 26 Sep 2025 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891353; cv=none; b=ccKFpmC41e6+ESMURPKBkfQvlP/SiUjM0gjXwZMtBRSoJEDU32hWk3zfT8aukuuSooiaP+fkog+j+Oh7VbQUtys9QyTZoAbSUVkftPpROAAxqJgWRqblQBx6EzOtzmDu7cwqZRrycdptOS+9wZ/m4mHzfgpwPBZzTSc6sZ5plb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891353; c=relaxed/simple;
	bh=duSa904xzX7uTYjxszUBwrwGR3o5pCjjI0NEhThlExo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgtKXyTThTK0SGoNKfMFrG9VeY42o5Mu9EUb2gG7T+tLcNxcJ4RH+Maa0NrmNBcmw8bGa0GoErPSEGEcRpLAYs1xUeyQFqTfGH+Mc59iU/oUzZuVq5C8FIWXX4Z95PYm+OHDRMvgx0KltCrBbDM88vcJAZZQReWg+qPgzkmYldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIwrH/Fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467C7C4CEF4;
	Fri, 26 Sep 2025 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891352;
	bh=duSa904xzX7uTYjxszUBwrwGR3o5pCjjI0NEhThlExo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIwrH/FwH+7LYFdACvS1oqcYl+azT3xaZoOGIaQZlPbaYUtrM/14fw9uvvPM2LUMa
	 U0T10X4/wNwuq2T2+KbyQlPSJiqfX9/UZJF9HhbVQ9kKHH757ekObZGQsjnxhSJTM2
	 ORYD1PKdQC63B5kujlklKMPuaVbagyRm5dfu1rnfBFP30KeTsNwizF2pnEZHRKnSu9
	 /7FQRL1GJhqUq7gnAV3GvyU+h2kL/qQ1LfT3PctsoMjLFqbJhQ13ZHaH63Er7O2c7v
	 JwHzUYVGcQLk684+s9sJN+WY/iPaGIfn7Cv1iNaOdRpOq2K2fXO1bR44fIbLlfnMKz
	 4wJ4ZVHvY4Ssw==
Date: Fri, 26 Sep 2025 14:55:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next v2 0/5] Add the the capability to load HW RX
 checsum in eBPF programs
Message-ID: <aNaNVl13LV_HWbP3@lore-desk>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <87bjmy508n.fsf@cloudflare.com>
 <aNUb2rB8QAJj-aUX@lore-desk>
 <87tt0q3ik9.fsf@cloudflare.com>
 <fdb8a364-a12d-4c1f-9591-9dac3e27b321@kernel.org>
 <87ldm12zoq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+8nn4MSiO0Z4/+w5"
Content-Disposition: inline
In-Reply-To: <87ldm12zoq.fsf@cloudflare.com>


--+8nn4MSiO0Z4/+w5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Sep 26, 2025 at 01:45 PM +02, Jesper Dangaard Brouer wrote:
> > On 25/09/2025 12.58, Jakub Sitnicki wrote:
> >> On Thu, Sep 25, 2025 at 12:39 PM +02, Lorenzo Bianconi wrote:
> >>>> On Thu, Sep 25, 2025 at 11:30 AM +02, Lorenzo Bianconi wrote:
> >>>>> Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the=
 HW
> >>>>> RX cheksum results in the eBPF program binded to the NIC.
> >>>>> Implement xmo_rx_checksum callback for veth and ice drivers.
> >>>>
> >>>> What are going to do with HW RX checksum once XDP prog can access it?
> >>>
> >>> I guess there are multiple use-cases for bpf_xdp_metadata_rx_checksum=
()
> >>> kfunc. The first the I have in mind is when packets are received by a=
n af_xdp
> >>> application. In this case I think we currently do not have any way to=
 check if
> >>> the packet checksum is correct, right?
> >>> I think Jesper has other use-cases in mind, I will let him comment
> >>> here.
> >> Can you share more details on what the AF_XDP application would that
> >> info?
> >
> > Today the AF_XDP application need to verify the packet checksum, as it
> > gets raw xdp_frame packets directly from hardware (no layer in-between
> > checked this).  Getting the RX-checksum validation from hardware info
> > will be very useful for AF_XDP, as it can avoid doing this in software.
> >
> >
> >> Regarding the use cases that Jesper is trying to unlock, as things sta=
nd
> >> we don't have a way, or an agreement on how to inject/propagate even t=
he
> >> already existing NIC hints back into the network stack.
> >>=20
> >
> > This patchset have its own merits and shouldn't be connected with my
> > use-case of (optionally) including hardware offloads in the xdp_frame.
> > Sure, I obviously also want this RX-checksum added, but this patchset is
> > useful on it's own.
> >
> >> Hence my question - why do we want to expose another NIC hint to XDP
> >> that we can't consume in any useful way yet?
> >>=20
> >
> > Well here *are* useful ways to use this RX-checksum info on its own.
> > See my explanation of the DDoS use-case here[1] in other email.
> >
> > Cloudflare actually also have a concrete use-case for needing this.
> > Our XDP based Unimog[2] load-balancer (and DDoS) encapsulate all
> > packets when they are XDP_TX forwarded. The encap receiving NIC lacking
> > inner-packet checksum validation make us loose this hardware offload.
> > This would allow us to save some checksum validation or even just DDOS =
drop
> > based on hardware checksum validation prior to encap (as in [1]).
>=20
> Thanks for filling in the blanks, Jesper. That's the context that I was
> missing.
>=20
> Lorenzo, this motivaton seems worth including in the cover letter.

ack, I will do.

Regards,
Lorenzo


--+8nn4MSiO0Z4/+w5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaNaNVgAKCRA6cBh0uS2t
rL3XAQD8GN9wvWAXagWwB1Sz8I/terYM2elqSFXzjHbVzB4I9gD+K7WMUCpKHc20
3uWnZNrOOHV0R5Qjh7lK1nf04Gg9kQk=
=UrqH
-----END PGP SIGNATURE-----

--+8nn4MSiO0Z4/+w5--

