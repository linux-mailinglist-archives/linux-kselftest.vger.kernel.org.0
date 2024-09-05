Return-Path: <linux-kselftest+bounces-17217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B014D96D703
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B76A2829E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB061991AC;
	Thu,  5 Sep 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3FJA1v3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33199194C6F;
	Thu,  5 Sep 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535513; cv=none; b=Pbkry7UAWWOlgAMxDYVPK6ak2pPVuLTEox2eXlr3U5ArCh/QPth3wcHf1D1E3sEAzweauuIs4DU1woWNEcATAuHA+7r7UvSMxtN0sCnbDt1NrFeMJ0+BpnBNAkJK0YDli1qWRBhtS301mErUCt4zsX5dTln7tLelJFUuHN/LTu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535513; c=relaxed/simple;
	bh=x86yLT2tuptwSdTBSR4vFuTdA8qSsYK7cgeR+z74JoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdyUlVYgWdZ1OsUkQ+nGguVNC+OWf1iPxbdYEjWgowSoC0ncQ0b8SyFFZhmOHlVyki5vdU7bZdgMmFltBhtklL0OG5T+t7v84MwVqLp41iDruW8Yd0Er7gO5Lzwkluxkbvh+Xr7G+tSDaA1VMeYNO4xnuBEGP3g/jFvNFrQzjqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3FJA1v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97230C4CEC7;
	Thu,  5 Sep 2024 11:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725535512;
	bh=x86yLT2tuptwSdTBSR4vFuTdA8qSsYK7cgeR+z74JoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3FJA1v3ATNflHSNkYFakiyPSgmwOuI1L7okJAy5ZK76EoIkf5TM9ajrme0d8x+5L
	 z5EAP78+55YezXemqkS+/uRDNCK0Bb1whP0oGC8uyDwMVbiYUPTNNS3RTm5meFwLls
	 W2tnXIaoZ3jEqy8oTPYSpbkDYrb6R0ht1D6TBZyXaxoKBD0e+HKQZ58uDc/82uB9WP
	 TMUDkw8PzNmy3wPWYSUB7CvfVQ7kVo73S2S7tFK83EG80IK/+UclENTtRGA+NvKobn
	 WYD0B1q71D21ODbSM20CcnMvpqLGgmCfWWRYs3qr+VFDBT+5JLvihw7CBNIO6HpWql
	 wI+H2zzyQig1g==
Date: Thu, 5 Sep 2024 12:25:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
	oleg@redhat.com, mingo@kernel.org, tglx@linutronix.de,
	mark.rutland@arm.com, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
	aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, sj@kernel.org
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
Message-ID: <6d026325-30cf-49aa-b3cb-da31a7713ce4@sirena.org.uk>
References: <20240822121415.3589190-1-dev.jain@arm.com>
 <20240822121415.3589190-2-dev.jain@arm.com>
 <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
 <42d0fa4b-eb67-42fd-a8e1-05d159d0d52f@arm.com>
 <806e4be0-4b1f-4818-806f-a844d952d54e@arm.com>
 <fff2b685-a7a5-4260-a293-f2abf55d9ce4@linuxfoundation.org>
 <514713eb-235c-40ee-8c25-f1f3e1ca7f7a@arm.com>
 <d5dc1bd9-4473-405f-99fc-192691f41c4f@linuxfoundation.org>
 <0b3af60f-0449-48a1-b228-f26618b9d50a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wPXU4iFI09jGqHnf"
Content-Disposition: inline
In-Reply-To: <0b3af60f-0449-48a1-b228-f26618b9d50a@arm.com>
X-Cookie: The horror... the horror!


--wPXU4iFI09jGqHnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 11:26:02AM +0530, Dev Jain wrote:
> On 9/4/24 22:35, Shuah Khan wrote:

> > So who does the backports whenevenr something changes? You are adding
> > work where as the automated process would just work without this
> > change. It doesn't matter if there is another test that changed
> > the name.

I thought git was supposed to have some ability to try to cope with
renames, though heuristic based?  It does seem to work sometimes.  TBH
I'm also not sure how frequent an issue backporting fixes to this one
test is going to be, it's had a couple of minor fixes for warnings in
the past few years and the last substantial update was in 2021.

> >=20
> > If this new test has no relation to sigaltstack, then why are you
> > changing
> > and renaming the sigaltstack directory?

> Because the functionality I am testing is of signals, and signals are a
> superset
> of sigaltstack. Still, I can think of a compromise, if semantically you w=
ant

I do tend to agree here, it seems neater to merge things and from the
point of view of running the tests in CI it's nice to not have too many
tiny suites, they create runtime overhead.

> to
> consider the new test as not testing signals, but a specific syscall
> "sigaction"
> and its interaction with blocking of signals, how about naming the new
> directory "sigaction"?

That's not going to scale amazingly if we test any other aspects of
signals...  I'd just call it "signal" and if it's not possible to get
the merge done just leave the sigaltstack suite as it is.

--wPXU4iFI09jGqHnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbZlRIACgkQJNaLcl1U
h9Dx9Af/Qq2dGkh9bK9FpyiYKYIQJ1kZRRew4MomSgFtMpgrUhYkwPZ5afpf/Rk6
MpGW4TkRbtORO3OUSGZAKFYEU1HjkxRYWRM0Rd+jsXw333GRZbuZDqKxKI8Wx4Yw
DAkraiEwoX7z7YSW3oYAB7IAzKoTcQZ3L5nY8WtOzyRlMiRozTrTWWwCTyUetqc+
qkJhaLIJiv3rV0gbZl5XZjxe8VhF7IKv6FE0Mfmra8fgb4/kiKkpB3qKrA9xWdDi
595i1dVMyely2LrESJrcOIP1LSzArt/vrTVLYkSa73xGqQKlHTYr0lTO7GpyFzEJ
3XCVnd4DAuKw3+x6ZfJbM8rk7MeitA==
=LUPA
-----END PGP SIGNATURE-----

--wPXU4iFI09jGqHnf--

