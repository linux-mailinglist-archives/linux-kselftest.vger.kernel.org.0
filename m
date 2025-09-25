Return-Path: <linux-kselftest+bounces-42308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C61B9EC4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387FC16F228
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74822EC560;
	Thu, 25 Sep 2025 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKXhTHjE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CF2EC0AC;
	Thu, 25 Sep 2025 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796764; cv=none; b=rBDxfhTOoAalLWEgfOLM6gQOT5DMRev+kFi5UfC1HGTOMYqxVRBYOqbyOfJdiPCZK7nqrfHQMcNEAz9nrnM1qlEeXdLngqXwL7Geg44SvF3BvAM5WOhZ7NT7vMn/YLOZV+osmaBeiSdomAlpGqq2Dqy3sKLDOGyQDFIz2H3JiR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796764; c=relaxed/simple;
	bh=g18JgraaDXQ/oZPpU5mVP33VVHpCJok0REx5NF6LgqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mudY+eXKg7oqKMo7lh+wF9yZyUvdG7Ajl5o++MoXuE9wi50jK+aRdBYN/NE6y1Z0rxpXgblw7qqee0vtAQPBXxzq45nTNrc+4CxQShbJ7rt++UMn7OgSkST56/We7EXyRcXv3afXL6N1jtTIMqPzEFt3t2AtmuIEes+7b76Nqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKXhTHjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA35C4CEF0;
	Thu, 25 Sep 2025 10:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796764;
	bh=g18JgraaDXQ/oZPpU5mVP33VVHpCJok0REx5NF6LgqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKXhTHjETOvq14sfdXOnYO/XPyREda+Xof8NIxesa1wK++Y+AF/pBjUJRPjQ7Klrg
	 ibEwOX0BTX90jLJiZ90hpp12fuLC4rHrIDEYe7I37QYHBVT774PvvkNZa5lSnXoWNO
	 WsXWfc93zU+BHT2JLvIunUNcBvf/76R+7s9DIliluN2GZf/VSIhq3muZcbCA1Ukvkv
	 m82vLO5h14ZDC9w3/mCcQavvYsUS9EzW5d7Kuq/Ez4Pj6YM23MQH5Fh8UyP24/q1cp
	 KsJsjSeLEqVdeZ7MmmaA/G1sRlEgFIdSD4iJLvapVawjdCc593d6Rr/svIdggbTs/J
	 T9+DmrMol1iKw==
Date: Thu, 25 Sep 2025 12:39:22 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 0/5] Add the the capability to load HW RX
 checsum in eBPF programs
Message-ID: <aNUb2rB8QAJj-aUX@lore-desk>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <87bjmy508n.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xqGe+akQ3uuJExgr"
Content-Disposition: inline
In-Reply-To: <87bjmy508n.fsf@cloudflare.com>


--xqGe+akQ3uuJExgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Sep 25, 2025 at 11:30 AM +02, Lorenzo Bianconi wrote:
> > Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
> > RX cheksum results in the eBPF program binded to the NIC.
> > Implement xmo_rx_checksum callback for veth and ice drivers.
>=20
> What are going to do with HW RX checksum once XDP prog can access it?

Hi Jakub,

I guess there are multiple use-cases for bpf_xdp_metadata_rx_checksum()
kfunc. The first the I have in mind is when packets are received by an af_x=
dp
application. In this case I think we currently do not have any way to check=
 if
the packet checksum is correct, right?
I think Jesper has other use-cases in mind, I will let him comment here.

Regards,
Lorenzo

--xqGe+akQ3uuJExgr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaNUb2gAKCRA6cBh0uS2t
rCnmAQClyqHTRR/OnmcLAfApMAw6CE3qQxlQol1aJ4trzcdQsAD8DnOXx8cahwg9
sjufYTjctpEZ5iSYR7AA4n6xB5OW9AQ=
=frL2
-----END PGP SIGNATURE-----

--xqGe+akQ3uuJExgr--

