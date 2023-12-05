Return-Path: <linux-kselftest+bounces-1155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25731805A2F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30F0B211A8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C10046AF;
	Tue,  5 Dec 2023 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKtrLOuu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE468EB4;
	Tue,  5 Dec 2023 16:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AB2C433C7;
	Tue,  5 Dec 2023 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701794630;
	bh=bW3OrJbYp0bj7igkmuhy/a8fB4L68pG99Ed2bPNX7D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKtrLOuuzsIJEvtJbodeJDDqyNZhcMw2XYqVbA/dlzeiW5j6c1Oori5+rCJHBJL0N
	 AoMjz0uYXkSw2g7Egm3G9+/18GWtQxbc5E9k/FJvCclJjMJxPOapumx21dhLn15+jH
	 GWKCpCOWpqj/eG7+5kiUNq2kUFogM9pw5dVkgl19S5rs7qQ984N/WKvF4P1LskuSEz
	 TA7ajMQ+y39xuyXxZW5CAFMMjeCK7YJOS1UEsVf5RlJa1NOj/fnrXqqmWKqXj6Kwex
	 QNtVj+NDLGGaoFjVZqyp3Wx+VWsE13mUb/5lzRAqy1E4zl2EHVnyweDanvIC98LVtw
	 9TrRETeQSanYQ==
Date: Tue, 5 Dec 2023 16:43:41 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"bristot@redhat.com" <bristot@redhat.com>,
	"will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"jannh@google.com" <jannh@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFT v4 5/5] kselftest/clone3: Test shadow stack support
Message-ID: <098f5d43-e093-4316-9b86-80833c2b94ec@sirena.org.uk>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <20231128-clone3-shadow-stack-v4-5-8b28ffe4f676@kernel.org>
 <4898975452179af46f38daa6979b32ba94001419.camel@intel.com>
 <345cf31a-3663-4974-9b2a-54d2433e64a7@sirena.org.uk>
 <a6bf192a1568620826dd79124511ea61472873c8.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="geVM8gTWdCwKEGG9"
Content-Disposition: inline
In-Reply-To: <a6bf192a1568620826dd79124511ea61472873c8.camel@intel.com>
X-Cookie: I've Been Moved!


--geVM8gTWdCwKEGG9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 04:01:50PM +0000, Edgecombe, Rick P wrote:

> Hmm, I didn't realize you were planning to have the kernel support
> upstream before the libc support was in testable shape.

It's not a "could someone run it" thing - it's about trying ensure that
we get coverage from people who are just running the selftests as part
of general testing coverage rather than with the specific goal of
testing this one feature.  Even when things start to land there will be
a considerable delay before they filter out so that all the enablement
is in CI systems off the shelf and it'd be good to have coverage in that
interval.

> > What's the issue with working around the missing support?=A0 My
> > understanding was that there should be no ill effects from repeated
> > attempts to enable.=A0 We could add a check for things already being
> > enabled

> Normally the loader enables shadow stack and glibc then knows to do
> things in special ways when it is successful. If it instead manually
> enables in the app:
>  - The app can't return from main() without disabling shadow stack=A0
>    beforehand. Luckily this test directly calls exit()
>  - The app can't do longjmp()
>  - The app can't do ucontext stuff
>  - The enabling code needs to be carefully crafted (the inline problem=A0
>    you hit)

> I guess it's not a huge list, and mostly tests will run ok. But it
> doesn't seem right to add somewhat hacky shadow stack crud into generic
> tests.

Right, it's a small and fairly easily auditable list - it's more about
the app than the double enable which was what I thought your concern
was.  It's a bit annoying definitely and not something we want to do in
general but for something like this where we're adding specific coverage
for API extensions for the feature it seems like a reasonable tradeoff.

If the x86 toolchain/libc support is widely enough deployed (or you just
don't mind any missing coverage) we could use the toolchain support
there and only have the manual enable for arm64, it'd be inconsistent
but not wildly so.

> So you were planning to enable GCS in this test manually as well? How
> many tests were you planning to add it like this?

Yes, the current version of the arm64 series has the equivalent support
for GCS.  I was only planning to do this along with adding specific
coverage for shadow stacks/GCS, general stuff that doesn't have any
specific support can get covered as part of system testing with the
toolchain and libc support.

The only case beyond that I've done is some arm64 specific stress tests
which are written as standalone assembler programs, those wouldn't get
enabled by the toolchain anyway and have some chance of catching context
switch or signal handling issues should they occur.  It seemed worth it
for the few lines of assembly it takes.

--geVM8gTWdCwKEGG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvUzwACgkQJNaLcl1U
h9C+jAf+Md2bTNdvJs2oIqh+pACXbkAHBDvJZ/N1O5qY7yBLok1tIPJANG0jKFYX
6PxRyrDBuvQ47eZfaV2+7ea/+13vVBkVuPTI1503ktL8/gHGkBAfjTbpvj2Y9AOU
8SpeWDdlYSmo1F+o34hhroFMh5i1OY+l+vJ+FQaZIvcl9T/Duhe+9fe1xY5t49A5
gnCQXEDUxaLWeVb7WpcKlClGEX90GJyI94OrQ4wuIylpc98x9YQuGAiEdJcPLm+g
IK7nqgioxopCgNhdhXy8nnR8r7WQUlxW7g/MMc+3DIOhLRoegISD6zpls62PDJbQ
VF3UWrKSNa1UlF+p6OgWRKeODawTZg==
=2dm/
-----END PGP SIGNATURE-----

--geVM8gTWdCwKEGG9--

