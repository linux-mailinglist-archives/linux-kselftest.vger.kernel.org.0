Return-Path: <linux-kselftest+bounces-25571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F8EA25C2A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 15:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E28F1882828
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0B205E0A;
	Mon,  3 Feb 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHSoTQGC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343D91FF1CE;
	Mon,  3 Feb 2025 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592468; cv=none; b=jME8IB5XSqaOUDN4aZFvFkyt7U32aVy+GJj0sm+LyQ/4OZt0RHaFsQD/1I0W5VonlANKq9caD/hCsYXJQjuZgn9KQqJow/3I4RN4Aph1mJ5LDOBs1CmJfQoik4ni1FTB8srC+wxAdOcVWCjFCNLBYS+bgBLPSFml8KPBFBCVPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592468; c=relaxed/simple;
	bh=EifYljNwSOGaeKqu0rrtfpQsay3gDaNn6WUfJyNIX9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSFeffWL0W6gSFwuUADe8aTYhOfQZF025g6wUyaGOqHSjdMvcUxufgYlJI4b5vLes1e5bxDBJKkOG6HqPbPhRbRzpNf8NP1T2UeYbP7+V8twwfSDmLbDdrISg6yrSrVtT/oze9UcuiqcEa5a62bWQmlqs+2bjuoBcRWCteeN1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHSoTQGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB79EC4CED2;
	Mon,  3 Feb 2025 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738592467;
	bh=EifYljNwSOGaeKqu0rrtfpQsay3gDaNn6WUfJyNIX9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHSoTQGChGiznZeUsDLp94YgYSOpzrjzUheUcZR7aqW7HIbxrspi/H29Qr3M1wyTZ
	 4e2+Yb4g1NM4kzJMcRBHJOwzWAOcSzP3qY5h/H3mcDY07436Ma9jRIkz4SB7b2pQQj
	 dmyRa6yHR7OwA/UIWUWIoZOBnJd80rh9m2FvJeYw4Dg9ZN82GW5vKZvuk1l829Wi7c
	 cSWpUuWLoimKy01Q/2dh+kjaq/xuW3B89I1q/XhWij9+Sd5cdV38BjeEnqvBfQeU4x
	 yKvNhWFQwoG34BdkZrOvrgN8bJJr+sFYOFRI/bRXHasJJmUcppbmhgJ7mXTD/4qZtE
	 4HMNb3JLZVjiQ==
Date: Mon, 3 Feb 2025 14:21:02 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	matttbe@kernel.org
Subject: Re: [PATCH RFC net-next] netconsole: selftest: Add test for
 fragmented messages
Message-ID: <20250203142102.GH234677@kernel.org>
References: <20250131-netcons_frag_msgs-v1-1-0de83bf2a7e6@debian.org>
 <20250203104855.GC234677@kernel.org>
 <20250203-subtle-taipan-of-realization-1c3a3f@leitao>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250203-subtle-taipan-of-realization-1c3a3f@leitao>

On Mon, Feb 03, 2025 at 03:00:37AM -0800, Breno Leitao wrote:
> Hello Simon,
>=20
> On Mon, Feb 03, 2025 at 10:48:55AM +0000, Simon Horman wrote:
> > On Fri, Jan 31, 2025 at 04:39:38AM -0800, Breno Leitao wrote:
>=20
> > > +# Validate the message, which has two messages glued together.
> > > +# unwrap them to make sure all the characters were transmitted.
> > > +# File will look like the following:
> > > +#   13,468,514729715,-,ncfrag=3D0/1135;MSG1=3DMSG2=3DMSG3=3DMSG4=3DM=
SG5=3DMSG6=3DMSG7=3DMSG8=3DMSG9=3DMSG10=3DMSG11=3DMSG12=3DMSG13=3DMSG14=3DM=
SG15=3DMSG16=3DMSG17=3DMSG18=3DMSG19=3DMSG20=3DMSG21=3DMSG22=3DMSG23=3DMSG2=
4=3DMSG25=3DMSG26=3DMSG27=3DMSG28=3DMSG29=3DMSG30=3DMSG31=3DMSG32=3DMSG33=
=3DMSG34=3DMSG35=3DMSG36=3DMSG37=3DMSG38=3DMSG39=3DMSG40=3DMSG41=3DMSG42=3D=
MSG43=3DMSG44=3DMSG45=3DMSG46=3DMSG47=3DMSG48=3DMSG49=3DMSG50=3DMSG51=3DMSG=
52=3DMSG53=3DMSG54=3DMSG55=3DMSG56=3DMSG57=3DMSG58=3DMSG59=3DMSG60=3DMSG61=
=3DMSG62=3DMSG63=3DMSG64=3DMSG65=3DMSG66=3DMSG67=3DMSG68=3DMSG69=3DMSG70=3D=
MSG71=3DMSG72=3DMSG73=3DMSG74=3DMSG75=3DMSG76=3DMSG77=3DMSG78=3DMSG79=3DMSG=
80=3DMSG81=3DMSG82=3DMSG83=3DMSG84=3DMSG85=3DMSG86=3DMSG87=3DMSG88=3DMSG89=
=3DMSG90=3DMSG91=3DMSG92=3DMSG93=3DMSG94=3DMSG95=3DMSG96=3DMSG97=3DMSG98=3D=
MSG99=3DMSG100=3DMSG101=3DMSG102=3DMSG103=3DMSG104=3DMSG105=3DMSG106=3DMSG1=
07=3DMSG108=3DMSG109=3DMSG110=3DMSG111=3DMSG112=3DMSG113=3DMSG114=3DMSG115=
=3DMSG116=3DMSG117=3DMSG118=3DMSG119=3DMSG120=3DMSG121=3DMSG122=3DMSG123=3D=
MSG124=3DMSG125=3DMSG126=3DMSG127=3DMSG128=3DMSG129=3DMSG130=3DMSG131=3DMSG=
132=3DMSG133=3DMSG134=3DMSG135=3DMSG136=3DMSG137=3DMSG138=3DMSG139=3DMSG140=
=3DMSG141=3DMSG142=3DMSG143=3DMSG144=3DMSG145=3DMSG146=3DMSG147=3DMSG148=3D=
MSG149=3DMSG150=3D: netcons_nzmJQ
> > > +#    key=3D1-2-13,468,514729715,-,ncfrag=3D967/1135;3-4-5-6-7-8-9-10=
-11-12-13-14-15-16-17-18-19-20-21-22-23-24-25-26-27-28-29-30-31-32-33-34-35=
-36-37-38-39-40-41-42-43-44-45-46-47-48-49-50-51-52-53-54-55-56-57-58-59-60-
>=20
> > I appreciate there is a value in providing the literal data.
> > But as the data is based mostly of arithmetic sequences
> > perhaps it would be nicer to express this in a more succinct way.
>=20
> First of all, thanks for the review.
>=20
> Do you mean I should simplify this comment above, to avoid the literal
> data, right?

Thanks Breno,

Yes, that is what I meant.

> > Regardless, this patch looks good to me.
>=20
> Thanks, I was a bit surprised with the tests failing on our CI, but,
> after some investigation, it doesn't seem to be caused by this change.
>=20
> https://patchwork.kernel.org/project/netdevbpf/patch/20250131-netcons_fra=
g_msgs-v1-1-0de83bf2a7e6@debian.org/
>=20
> --breno
>=20

