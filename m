Return-Path: <linux-kselftest+bounces-130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B097EC2FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 13:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F00280F74
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E778D168C2;
	Wed, 15 Nov 2023 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbCPss0q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41CE156F3;
	Wed, 15 Nov 2023 12:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C82C433C7;
	Wed, 15 Nov 2023 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700052800;
	bh=gcFqBYw8PXGO0sV0s5kjBNpQqfZ58F4h29SX//oQGIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbCPss0qRiZubn7E0ZPkBxNyntffhhRLA7M5bjDO4PkW0C4TjlMl+Q54z22HUWq99
	 FE1r77hwcX1dEUf71IezL52SBh7gzsAN/2gsGxUFtZ0h/jwG4E0HNiG00G7a46Gn36
	 j6eMCtYs/C4fKYKFgUwmQ2huEudAL9S4/mZtnNGGjd43K2MCVQkPpKF51l6bZYou2N
	 AjLPZM640fz91gAXy6x6GMJfe/l+JpZrYHVVpE+AXe6aoNK39V1E/jAR8g31dc4KBJ
	 zdXf/YkYsaT8YzyfguiO+/QpxyKRugT9z0QCPmI7geTcTC2ZNlr7Kp1NsDKq3iw2DZ
	 0cXvVBKTMX7IA==
Date: Wed, 15 Nov 2023 12:53:10 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"bristot@redhat.com" <bristot@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"jannh@google.com" <jannh@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"Pandey, Sunil K" <sunil.k.pandey@intel.com>
Subject: Re: [PATCH RFC RFT v2 5/5] kselftest/clone3: Test shadow stack
 support
Message-ID: <7f2f36a7-e299-4eb1-8ef4-11c08181fe27@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-5-b613f8681155@kernel.org>
 <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ZWyp9FLjuhAqq+o"
Content-Disposition: inline
In-Reply-To: <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
X-Cookie: For internal use only.


--3ZWyp9FLjuhAqq+o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:11:58PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-11-14 at 20:05 +0000, Mark Brown wrote:

> > +=A0=A0=A0=A0=A0=A0=A0shadow_stack =3D syscall(__NR_map_shadow_stack, 0,
> > getpagesize(), 0);

> Hmm, x86 fails this call if user shadow stack is not supported in the
> HW or the kernel, but doesn't care if it is enabled on the thread or
> not. If shadow stack is not enabled (or not yet enabled), shadow stacks
> are allowed to be mapped. Should it fail if shadow stack is not yet
> enabled?

> Since shadow stack is per thread, map_shadow_stack could still be
> called on another thread that has it enabled. Basically I don't think
> blocking it will reduce the possible states the kernel has to handle.

Indeed - I would expect map_shadow_stack() to always succeed if the
system supports it since it could reasonably be called as part of the
preparation for enabling it and even if someone calls it and never
actually uses the resulting memory there's no more harm to that than
any other memory allocation.  The arm64 code wasn't explicitly caring if
we actually had GCS enabled when we clone and just alloacating the stack
if requested which on reflection is more just an opportunity for users
to mess up than something we usefully want to support.

> The traditional way to check if shadow stack is enabled on x86 is the
> check for a non zero return from the _get_ssp() intrinsic:
> https://gcc.gnu.org/onlinedocs/gcc-9.2.0/gcc/x86-control-flow-protection-=
intrinsics.html

> It seems like there will be a need for some generic method of checking
> if shadow stack is enabled. Maybe a more generic compiler
> intrinsic/builtin or glibc API (something unrelated to SSP)?

Some sort of feature check in libc would be nice, yes.  That said since
we really want the tests to run on systems without libc support for the
feature (if only as a bootstrapping thing) we'll need to open code
anyway.  I'll add code to startup which ensures the feature is enabled,
we can't rely on it for detection without pain though since it's
possible that we might have features locked by the startup code.

--3ZWyp9FLjuhAqq+o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVUvzYACgkQJNaLcl1U
h9AOXAf8C7LO3zDmvMkVUGlWN+N+fpmKG4F/msloRjDssP4TlUtLbV/KiDUMXa/S
5WejIQQwD8ajc4nPg4zOXp4hwfdADWgI/9f+csVwADFrOth5eZqgRqTcfvdm1Arx
9YffT2zBfx0ga6x5T4ToC0ywneZTzSR4inXbHrGEZtUsxToSbxqO9wWPgjgrF/Rr
YQ8Ni6rAw2u/n2N7UngWU62zkCQ51NZBOGs56+N52tCTCUwFqdMGi5nlaUpqNZk9
bePpU3yf/8FdQ1J+bIBzj9wFDQRY8I6RcUarTm2DdL3IH6YPiNYyiOSVF7I5To40
I4svtiH5xfPhHF2HbE0A7iz0Kt2EqA==
=3hkW
-----END PGP SIGNATURE-----

--3ZWyp9FLjuhAqq+o--

