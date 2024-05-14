Return-Path: <linux-kselftest+bounces-10174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 207358C561E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 14:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84723B21C23
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2E6BFBB;
	Tue, 14 May 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHZuW4sr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214D66B5E;
	Tue, 14 May 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690640; cv=none; b=LEfwU0SDe/JOXlS4YyAr5bQXiRMMZLRMdQUikAFI5hvCtAwE5FQyJd8Taq/iIr11SfztWOgx6lNMS9o2JzwOBjg3hTJCoUsvHxgaoQlQAs0fXjjL7DACTUgM68NhvxQ4t7la7WJFPgjAnOT1HM5rKMesjKyFVMgrwrH4oKizQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690640; c=relaxed/simple;
	bh=frcCTz483GMnhYg7RWj0qSs/9NEH9LvHXWO5H2Yy4ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYG+XxTi2aTzB2x5jFpynWgHV1E4GbdsmIyRUdE+3eTH/HKACY35xAST5DbAhIvf2N+n/Eabjwg9Vrw+Rd6j5d/+HnM1GHL9pH9pl9EVQVKzpzIjUV6Gt618UB3TozCi/Eba7+naslobFQZCiBNCq6YRDLSoEGSV5QfOn2HSVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHZuW4sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2213C2BD10;
	Tue, 14 May 2024 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715690640;
	bh=frcCTz483GMnhYg7RWj0qSs/9NEH9LvHXWO5H2Yy4ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHZuW4srm0yCDfSbJUt5JCAxCjKy7cx7Q1H3MbIduBZqdIECmEiWfF/AXzRGjYxME
	 GW2/CRUxcrQ0bQp8yDXScoMqdoZG0/KtGNE7ImqeXvan3fS7YfUL+u14bqag6i3gzD
	 IQLtGQazfqcdl/DkfSnxxX38HL4cvm/vuT0/djBaE1+wID4tOnzwJVIBw10ppTJ9HX
	 p/xSP4MFZp8AMV/0GEAo/MsORo1RdQ3eZlmsx1m3OHYIBqUZJyv42UczQ5JPWf6Liq
	 XfyKyJ10c0bVUZns5frYAgeCGUVeoLkF7BQR7t4Q0qaEOD7XpZblYZ0iouWN5YvG2W
	 jk2uzrlyC7etw==
Date: Tue, 14 May 2024 13:43:54 +0100
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
Message-ID: <20240514-sip-exclusion-014b07b01f4c@spud>
References: <20240429150553.625165-1-cleger@rivosinc.com>
 <20240429150553.625165-3-cleger@rivosinc.com>
 <20240429-subtext-tabby-3a1532f058a5@spud>
 <5d5febd5-d113-4e8c-9535-9e75acf23398@rivosinc.com>
 <20240430-payable-famished-6711765d5ca4@wendy>
 <e57f8b70-7981-42c1-bb04-2060054dd796@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d4LtUScPc142c/dS"
Content-Disposition: inline
In-Reply-To: <e57f8b70-7981-42c1-bb04-2060054dd796@rivosinc.com>


--d4LtUScPc142c/dS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 09:53:08AM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 30/04/2024 13:44, Conor Dooley wrote:
> > On Tue, Apr 30, 2024 at 09:18:47AM +0200, Cl=E9ment L=E9ger wrote:
> >>
> >>
> >> On 30/04/2024 00:15, Conor Dooley wrote:
> >>> On Mon, Apr 29, 2024 at 05:04:55PM +0200, Cl=E9ment L=E9ger wrote:
> >>>> Since a few extensions (Zicbom/Zicboz) already needs validation and
> >>>> future ones will need it as well (Zc*) add a validate() callback to
> >>>> struct riscv_isa_ext_data. This require to rework the way extensions=
 are
> >>>> parsed and split it in two phases. First phase is isa string or isa
> >>>> extension list parsing and consists in enabling all the extensions i=
n a
> >>>> temporary bitmask without any validation. The second step "resolves"=
 the
> >>>> final isa bitmap, handling potential missing dependencies. The mecha=
nism
> >>>> is quite simple and simply validate each extension described in the
> >>>> temporary bitmap before enabling it in the final isa bitmap. validat=
e()
> >>>> callbacks can return either 0 for success, -EPROBEDEFER if extension
> >>>> needs to be validated again at next loop. A previous ISA bitmap is k=
ept
> >>>> to avoid looping mutliple times if an extension dependencies are nev=
er
> >>>> satisfied until we reach a stable state. In order to avoid any poten=
tial
> >>>> infinite looping, allow looping a maximum of the number of extension=
 we
> >>>> handle. Zicboz and Zicbom extensions are modified to use this valida=
tion
> >>>> mechanism.
> >>>
> >>> Your reply to my last review only talked about part of my comments,
> >>> which is usually what you do when you're gonna implement the rest, but
> >>> you haven't.
> >>> I like the change you've made to shorten looping, but I'd at least li=
ke
> >>> a response to why a split is not worth doing :)
> >>
> >> Hi Conor,
> >>
> >> Missed that point since I was feeling that my solution actually
> >> addresses your concerns. Your argument was that there is no reason to
> >> loop for Zicbom/Zicboz but that would also apply to Zcf in case we are
> >> on RV64 as well (since zcf is not supported on RV64). So for Zcf, that
> >> would lead to using both mecanism or additional ifdefery with little to
> >> no added value since the current solution actually solves both cases:
> >>
> >> - We don't have any extra looping if all validation callback returns 0
> >> (except the initial one on riscv_isa_ext, which is kind of unavoidable=
).
> >> - Zicbom, Zicboz callbacks will be called only once (which was one of
> >> your concern).
> >>
> >> Adding a second kind of callback for after loop validation would only
> >> lead to a bunch of additional macros/ifdefery for extensions with
> >> validate() callback, with validate_end() or with both (ie Zcf)). For
> >> these reasons, I do not think there is a need for a separate mechanism
> >> nor additional callback for such extensions except adding extra code
> >> with no real added functionality.
> >>
> >> AFAIK, the platform driver probing mechanism works the same, the probe=
()
> >> callback is actually called even if for some reason properties are
> >> missing from nodes for platform devices and thus the probe() returns
> >> -EINVAL or whatever.
> >>
> >> Hope this answers your question,
> >=20
> > Yeah, pretty much I am happy with just an "it's not worth doing it"
> > response. Given it wasn't your first choice, I doubt you're overly happy
> > with it either, but I really would like to avoid looping to closure to
> > sort out dependencies - particularly on the boot CPU before we bring
> > anyone else up, but if the code is now more proactive about breaking
> > out, I suppose that'll have to do :)
> > I kinda wish we didn't do this at all, but I think we've brought this
> > upon ourselves via hwprobe. I'm still on the fence as to whether things
> > that are implied need to be handled in this way. I think I'll bring this
> > up tomorrow at the weekly call, because so far it's only been you and I
> > discussing this really and it's a policy decision that hwprobe-ists
> > should be involved in I think.
>=20
> Hi Conor,
>=20
> Were you able to discuss that topic ?

I realised last night that I'd not got back to this thread and meant to
do that today (I had accidentally deleted it from my mailbox), but I had
a migraine this morning and so didn't.
I did bring it up and IIRC Palmer was of the opinion that we should try
our best to infer extensions.

> > Implied extensions aside, I think we will eventually need this stuff
> > anyway, for extensions that make no sense to consider if a config option
> > for a dependency is disabled.
> > From talking to Eric Biggers the other week about
> > riscv_isa_extension_available() I'm of the opinion that we need to do
> > better with that interface w.r.t. extension and config dependencies,
> > and what seems like a good idea to me at the moment is putting tests for
> > IS_ENABLED(RISCV_ISA_FOO) into these validate hooks.
> >=20
> > I'll try to look at the actual implementation here tomorrow.
>=20
> Did you found time to look at the implementation ?

No, with the above excuse. I'll try to get to it today or tomorrow...

--d4LtUScPc142c/dS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkNcigAKCRB4tDGHoIJi
0kA2AQDbZCPdb5B0I8LI5ibKy3ZRNF+UdA1ZiQXHtgoETMFd0gEA1hljHOnzoE/w
C3Pfa2PGHUyVZgXKvpMsjyz8TWUNpQE=
=uWRj
-----END PGP SIGNATURE-----

--d4LtUScPc142c/dS--

