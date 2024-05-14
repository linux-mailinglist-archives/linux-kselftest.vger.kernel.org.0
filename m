Return-Path: <linux-kselftest+bounces-10179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D998C5835
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 16:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8AE1F2180F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD0D17BB39;
	Tue, 14 May 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNn88E3q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E326AC6;
	Tue, 14 May 2024 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697851; cv=none; b=XktmwwpcuLud2BWGCHppJH+ci0xBHMtouWYgLfjsWR4WW40a0R2tH+4hS2DuWR/c5yMDT0S37yxk7FrDDvP4H5khqztRYjDcaAbAqBM/GKOggPmVZ9UkQ2dU88nR1ZAa4Hnl27oPOHCRwwfbd5HimmQ3XJG8eTxYjcrx6gyi4eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697851; c=relaxed/simple;
	bh=y6f6cP8b+wbXxgeRLntoPzUrt10oVgLSe6lqdbiAE/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiNRnUICMyUSdWqZP/6t1a/iRJmCuIt2vLSDQaagUtA0Ir+4yWGQCZIXAB2dsaVNwPsfjj5ERdBnl/yIZ0mO5ejrqynYqqfojst2HCQekYkzCdNf1Nb9coaVT112yRHHWPOkDn6fF49TsjMqHSEWtXew5HgVvGtNpBefecORbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNn88E3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54926C2BD10;
	Tue, 14 May 2024 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715697850;
	bh=y6f6cP8b+wbXxgeRLntoPzUrt10oVgLSe6lqdbiAE/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNn88E3qwlFZ8IDo6NLYz/WL2sOshJD3Uwz336B+1EH4VNtFWEZ+38K/urjlox5v4
	 +p20OpHYmetUOS7FZF3FMG+TTHQ74Py0oaqF+8nysAdUl6Q/S+A6DtPPu1CbPT0nD2
	 56JsY/sPwMcRh+UeCI85oV+CUt42T8bkE/rro8rs6hAli5pQnKnI6mikqVICbwyVtE
	 T/89KdPyIKiQM5KK3IxQEOcmODsQ6xNUdO5WbgVHnDkYF/G5O9Otq4LkDmXfqLHxwu
	 8uLS1hakZ34fk7+HjgCTmylScgB4wF6RJM2WTkGHUyuZJLNwKszxO5OW1N0yZa0b9x
	 qfcktlIO2YeRA==
Date: Tue, 14 May 2024 15:44:05 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 02/11] riscv: add ISA extensions validation
Message-ID: <20240514-ascend-joyous-a15969f703de@spud>
References: <20240429150553.625165-1-cleger@rivosinc.com>
 <20240429150553.625165-3-cleger@rivosinc.com>
 <20240429-subtext-tabby-3a1532f058a5@spud>
 <5d5febd5-d113-4e8c-9535-9e75acf23398@rivosinc.com>
 <20240430-payable-famished-6711765d5ca4@wendy>
 <e57f8b70-7981-42c1-bb04-2060054dd796@rivosinc.com>
 <20240514-sip-exclusion-014b07b01f4c@spud>
 <9d0840ff-d00a-4866-8f45-e8676f369ad6@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="77IYhpXVRVT+g+0m"
Content-Disposition: inline
In-Reply-To: <9d0840ff-d00a-4866-8f45-e8676f369ad6@rivosinc.com>


--77IYhpXVRVT+g+0m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 02:48:01PM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 14/05/2024 14:43, Conor Dooley wrote:
> > On Tue, May 14, 2024 at 09:53:08AM +0200, Cl=E9ment L=E9ger wrote:
> >>
> >>
> >> On 30/04/2024 13:44, Conor Dooley wrote:
> >>> On Tue, Apr 30, 2024 at 09:18:47AM +0200, Cl=E9ment L=E9ger wrote:
> >>>>
> >>>>
> >>>> On 30/04/2024 00:15, Conor Dooley wrote:
> >>>>> On Mon, Apr 29, 2024 at 05:04:55PM +0200, Cl=E9ment L=E9ger wrote:
> >>>>>> Since a few extensions (Zicbom/Zicboz) already needs validation and
> >>>>>> future ones will need it as well (Zc*) add a validate() callback to
> >>>>>> struct riscv_isa_ext_data. This require to rework the way extensio=
ns are
> >>>>>> parsed and split it in two phases. First phase is isa string or isa
> >>>>>> extension list parsing and consists in enabling all the extensions=
 in a
> >>>>>> temporary bitmask without any validation. The second step "resolve=
s" the
> >>>>>> final isa bitmap, handling potential missing dependencies. The mec=
hanism
> >>>>>> is quite simple and simply validate each extension described in the
> >>>>>> temporary bitmap before enabling it in the final isa bitmap. valid=
ate()
> >>>>>> callbacks can return either 0 for success, -EPROBEDEFER if extensi=
on
> >>>>>> needs to be validated again at next loop. A previous ISA bitmap is=
 kept
> >>>>>> to avoid looping mutliple times if an extension dependencies are n=
ever
> >>>>>> satisfied until we reach a stable state. In order to avoid any pot=
ential
> >>>>>> infinite looping, allow looping a maximum of the number of extensi=
on we
> >>>>>> handle. Zicboz and Zicbom extensions are modified to use this vali=
dation
> >>>>>> mechanism.
> >>>>>
> >>>>> Your reply to my last review only talked about part of my comments,
> >>>>> which is usually what you do when you're gonna implement the rest, =
but
> >>>>> you haven't.
> >>>>> I like the change you've made to shorten looping, but I'd at least =
like
> >>>>> a response to why a split is not worth doing :)
> >>>>
> >>>> Hi Conor,
> >>>>
> >>>> Missed that point since I was feeling that my solution actually
> >>>> addresses your concerns. Your argument was that there is no reason to
> >>>> loop for Zicbom/Zicboz but that would also apply to Zcf in case we a=
re
> >>>> on RV64 as well (since zcf is not supported on RV64). So for Zcf, th=
at
> >>>> would lead to using both mecanism or additional ifdefery with little=
 to
> >>>> no added value since the current solution actually solves both cases:
> >>>>
> >>>> - We don't have any extra looping if all validation callback returns=
 0
> >>>> (except the initial one on riscv_isa_ext, which is kind of unavoidab=
le).
> >>>> - Zicbom, Zicboz callbacks will be called only once (which was one of
> >>>> your concern).
> >>>>
> >>>> Adding a second kind of callback for after loop validation would only
> >>>> lead to a bunch of additional macros/ifdefery for extensions with
> >>>> validate() callback, with validate_end() or with both (ie Zcf)). For
> >>>> these reasons, I do not think there is a need for a separate mechani=
sm
> >>>> nor additional callback for such extensions except adding extra code
> >>>> with no real added functionality.
> >>>>
> >>>> AFAIK, the platform driver probing mechanism works the same, the pro=
be()
> >>>> callback is actually called even if for some reason properties are
> >>>> missing from nodes for platform devices and thus the probe() returns
> >>>> -EINVAL or whatever.
> >>>>
> >>>> Hope this answers your question,
> >>>
> >>> Yeah, pretty much I am happy with just an "it's not worth doing it"
> >>> response. Given it wasn't your first choice, I doubt you're overly ha=
ppy
> >>> with it either, but I really would like to avoid looping to closure to
> >>> sort out dependencies - particularly on the boot CPU before we bring
> >>> anyone else up, but if the code is now more proactive about breaking
> >>> out, I suppose that'll have to do :)
> >>> I kinda wish we didn't do this at all, but I think we've brought this
> >>> upon ourselves via hwprobe. I'm still on the fence as to whether thin=
gs
> >>> that are implied need to be handled in this way. I think I'll bring t=
his
> >>> up tomorrow at the weekly call, because so far it's only been you and=
 I
> >>> discussing this really and it's a policy decision that hwprobe-ists
> >>> should be involved in I think.
> >>
> >> Hi Conor,
> >>
> >> Were you able to discuss that topic ?
> >=20
> > I realised last night that I'd not got back to this thread and meant to
> > do that today (I had accidentally deleted it from my mailbox), but I had
> > a migraine this morning and so didn't.
> > I did bring it up and IIRC Palmer was of the opinion that we should try
> > our best to infer extensions.
> >=20
> >>> Implied extensions aside, I think we will eventually need this stuff
> >>> anyway, for extensions that make no sense to consider if a config opt=
ion
> >>> for a dependency is disabled.
> >>> From talking to Eric Biggers the other week about
> >>> riscv_isa_extension_available() I'm of the opinion that we need to do
> >>> better with that interface w.r.t. extension and config dependencies,
> >>> and what seems like a good idea to me at the moment is putting tests =
for
> >>> IS_ENABLED(RISCV_ISA_FOO) into these validate hooks.
> >>>
> >>> I'll try to look at the actual implementation here tomorrow.
> >>
> >> Did you found time to look at the implementation ?
> >=20
> > No, with the above excuse. I'll try to get to it today or tomorrow...
>=20
> No worries, I was on vacation and was just checking if I hadn't missed
> anything in the meantime. Take your time ;)

I forget where we talked about validation for F/V, but I chucked this
together last week in response to another thread of Andy's that was
adding some of the vector subset stuff, because I realised we don't turn
off any of the stuff that depends on vector if vector gets disabled:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=
=3Driscv-check_vector&id=3D38050c6858143f43ce2fd04e9824727a7d7731d0

What I've got there doesn't actually work for the vector subsets though,
only for vector itself, because of the probe ordering. Your validate
callback stuff should solve that issue though.

--77IYhpXVRVT+g+0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkN4tQAKCRB4tDGHoIJi
0qISAP90Cmxbqg0YPzaeFWc+C9/VvgVu9xKpX7ljk8pbm7X1owD6AnM5MtNIBLJQ
RIKtT/ATp2dDqn5rjyDfcJhTFVb4Qwk=
=e78x
-----END PGP SIGNATURE-----

--77IYhpXVRVT+g+0m--

