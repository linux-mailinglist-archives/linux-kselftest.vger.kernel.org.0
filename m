Return-Path: <linux-kselftest+bounces-17168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED6096C7AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCAD1C228CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F931E633C;
	Wed,  4 Sep 2024 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uigwwhzu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B3A84A27;
	Wed,  4 Sep 2024 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478827; cv=none; b=GrPcr9Ml3YDPuZs8LXyisgYUqfSdCiDwKbAJLW7bk0Jr7sVmI0KP2ndagGsJ+sNxqqUiCo6aY8oilfkYll433U5FmOy3y7SUB0SiHqxRYyBSrFvKmKAmqNPDGJzrT4KUXffs1Om+MWRu5vNDT1O34edT4c9d41Vv8mF6QU0osnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478827; c=relaxed/simple;
	bh=SNWThRPwlDfNqRuJUF0l0Cucyp1v3Y0fdsPK5rvXCb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCJgchbYN1OEV2E9mNalQN1sqlnivdG/6jOXPWUDgA1CHceH72ZEVqyPQWnkrKA1cs0GQaIZVI4vNDa9iXxCEd4XOhOOQGiZQsLTVjOerUoxHc0ZE2wVMq6drRwqdb+lxc6VMAx8FvLLKN9vVNmvrmFpGvHJByvgcNdH0CNL1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uigwwhzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6A2C4CEC2;
	Wed,  4 Sep 2024 19:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725478827;
	bh=SNWThRPwlDfNqRuJUF0l0Cucyp1v3Y0fdsPK5rvXCb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uigwwhzukT8ghyuZIfZuEvFg0TKDrnJ1D503QzCWBc+wnnqydbeAuCfzaxgcn/5np
	 kQdMFkniC8RpGC0GMFsyJ2nME55IwBl9jyjxmkqhLjzldenfuuQHlHNoO1sVNWqXKL
	 Xt06MplJSNzlfViqRt3WoDJLT447IKLdY3zKrEPpRC1lcShRNSzHIZ4SC1afd6hf3S
	 e8WRHzhCRAgxcUrgpFSesK1ifvsRQWAV9Wxn+gjVHzo1z8+RS3rL6tCe7R7xhmZfiR
	 UtGZwrWceeqBJPweXpHEWtGq1vff2Pw2CGGHMGYHVDo6EaU71ogahMSGWFrSQGni+q
	 iVUJG7HdwlYMA==
Date: Wed, 4 Sep 2024 12:40:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] selftests: mptcp: add time per subtests in
 TAP output
Message-ID: <20240904124025.3ec84142@kernel.org>
In-Reply-To: <559e1458-b593-44c7-92b1-6946c57496c5@kernel.org>
References: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
	<20240903162217.07c366c9@kernel.org>
	<559e1458-b593-44c7-92b1-6946c57496c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Sep 2024 18:15:09 +0200 Matthieu Baerts wrote:
> > Best I could come up with is:
> >=20
> > diff --git a/contest/remote/vmksft-p.py b/contest/remote/vmksft-p.py
> > index fe9e87abdb5c..a37245bd5b30 100755
> > --- a/contest/remote/vmksft-p.py
> > +++ b/contest/remote/vmksft-p.py
> > @@ -73,7 +73,7 @@ group3 testV skip
> >      tests =3D []
> >      nested_tests =3D False
> > =20
> > -    result_re =3D re.compile(r"(not )?ok (\d+)( -)? ([^#]*[^ ])( # )?(=
[^ ].*)?$")
> > +    result_re =3D re.compile(r"(not )?ok (\d+)( -)? ([^#]*[^ ])( +# )?=
([^ ].*)?$") =20
>=20
> Looks good to me. While at it, we can add a '+' for the spaces after the
> '#':
>=20
>   ( +# +)

=F0=9F=91=8D=EF=B8=8F

> I see you didn't commit the previous modification. I can open a PR if it
> helps.

I was just playing with the regexps in the interpreter. If you could
send a PR that'd perfect.

> >      time_re =3D re.compile(r"time=3D(\d+)ms")
> > =20
> >      for line in full_run.split('\n'):
> >=20
> > Thoughts? =20
>=20
> In my v2, I will also strip these trailing whitespaces in the selftests,
> they don't need to be there.

Up to you - it doesn't violate the KTAP format and the visual alignment
is nice. But it may trip up more regexps..

