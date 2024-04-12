Return-Path: <linux-kselftest+bounces-7800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A958A2FD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA322828DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D127281AB6;
	Fri, 12 Apr 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZNzmJfN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA04595B;
	Fri, 12 Apr 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929682; cv=none; b=AojPeTwOeMz7K25GJx/0GNPmuCIXFDdxj/ueXY4eOapbkULFnDwVYEbD1H9zdDsS7AgwA3vYlZHcHc7VRCuLMlBBC176JzyPIMS3q9hF/oL/KRaieE739JdgyN+rr+x7rxmR7A5AfAcl22SKac4WfGLPu46+FskFG4/xTKsdjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929682; c=relaxed/simple;
	bh=jTwXUL+Jb61z7k7YskX8hNpOWjVZtyVivG500GHqgkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0u9xxDAfQDgp+rzo+Uewb2bzDMIsYx239Hgh77CYkxGeT23wbPfEb6F9S7Go6lUkG+m5w7ejIXPA7JE6/X4HGckdvHECR9fJH0GdH7vpJu8+gDJkN3NYNTb90Fc3Myx7+fC4ZPwnnPVEk8ltJe0XgNxdgoI91hCixdMWK0WqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZNzmJfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D840DC113CC;
	Fri, 12 Apr 2024 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929682;
	bh=jTwXUL+Jb61z7k7YskX8hNpOWjVZtyVivG500GHqgkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tZNzmJfNwzE+YryryT4N32kxwl5pwiOEWcO4pkdD8sq9UgwvG6sueinugOKD3xoQY
	 SgbMFQHXrTVALLO+KwZxN2eGbpgXDz9lVtB+jHo8I/pWz8zKU25YXQ6faNeGje2juc
	 EddRqsf+2Ah/LchxC68jGepb+PvVppMRf8LaRksoIJ4j8R2JgUbzulRUJplI5/PXFr
	 MhIQsmegfCxPNMA5R/hB4o06Tpxrevudllhkl/84Fdp3p99l6DbXEM6LvjeRIJ0tU3
	 I32AGk5XXxLHpAo4FDEPQUKRGv9oW1zGTxBlwrwSaDuA22Z6wousfCYaLatr/UK2xJ
	 OrUGAxdItsU4g==
Date: Fri, 12 Apr 2024 06:48:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 6/6] selftests: net: exercise page pool
 reporting via netlink
Message-ID: <20240412064800.0530e984@kernel.org>
In-Reply-To: <874jc7ezia.fsf@nvidia.com>
References: <20240411012815.174400-1-kuba@kernel.org>
	<20240411012815.174400-7-kuba@kernel.org>
	<874jc7ezia.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Apr 2024 10:20:47 +0200 Petr Machata wrote:
> > +    def up(self):
> > +        ip("link set dev {} up".format(self.ifname))
> > +
> > +    def down(self):
> > +        ip("link set dev {} down".format(self.ifname)) =20
>=20
> Yeah, what I meant by integration pain with LNST the other day was
> basically this. You end up rewriting the iproute2 API in Python.
> But it is what it is.

Yes, I wasn't sure where to make it a local helper in the test or=20
a method of the class. I also don't think we should wrap too much but
I was worried someone will give me feedback in the opposite direction :)

Let me make it a local helper in the test.

I should probably move to format strings, too, not sure now what made=20
me use .format().

> > +        ksft_eq(len(attached), 1)
> > +        ksft_eq(len(undetached), 1)
> > +
> > +        # Free the old page and the old pp is gone
> > +        nsim.dfs_write("pp_hold", "n")
> > +        # Freeing check is once a second so we may need to retry
> > +        for i in range(50):
> > +            pp_list =3D nf.page_pool_get({}, dump=3DTrue)
> > +            pp_list =3D [pp for pp in pp_list if pp.get("ifindex") =3D=
=3D nsim.ifindex]
> > +            if len(pp_list) =3D=3D 1:
> > +                break
> > +            time.sleep(0.05)
> > +        ksft_eq(len(pp_list), 1) =20
>=20
> Yeah, I don't know if busywait / slowwait sort of a helper is practical
> to write in Python. No idea how to go about it. But the bash experience
> shows it would useful fairly often.

If I wrap:

            pp_list =3D nf.page_pool_get({}, dump=3DTrue)
            pp_list =3D [pp for pp in pp_list if pp.get("ifindex") =3D=3D n=
sim.ifindex]

into a helper, I can probably pass the condition in as a lambda =F0=9F=A4=
=94=EF=B8=8F
Let me try..

