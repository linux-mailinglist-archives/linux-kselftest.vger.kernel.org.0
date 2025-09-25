Return-Path: <linux-kselftest+bounces-42434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F63BA1F50
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 01:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0C41890C84
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 23:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D22EBB90;
	Thu, 25 Sep 2025 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeFONP/5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13B2D24B4;
	Thu, 25 Sep 2025 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842554; cv=none; b=lpUUpF4Y3ABVTIaY4MJRM+JeSB6UzCaXMlEK1/mJX/Bs6yUD5UkVZK1HSdxRGw+8I4OGFONPyaBPtBL9q28p5O0gjaHcs8rJ2t8dTrsBr7OEOFqHdKelgbB5ujIb94STg62IFCRJQFqAaEO9bKEwnOoTq1oyFa2uLXa+iH9eqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842554; c=relaxed/simple;
	bh=+WTWMCHkEyBrLBMR6p4juPfS3tWXmetpxCoSqXQBQWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWnRscxDUqxayW5bAwWJCFcH4MLyFQxMvfKIlk2kM+jjGFidZKnC61TSggInlrYLkJFvJGdXFEkprwVErwIOqNqzoCl3e3KixvE0gAGv/cC49KT987hig55gt65AB3U0oYlFsnxeGzMGAxX7j5XqEQlJPuSghvLVcNWk+VoHYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeFONP/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDF5C4CEF0;
	Thu, 25 Sep 2025 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758842553;
	bh=+WTWMCHkEyBrLBMR6p4juPfS3tWXmetpxCoSqXQBQWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SeFONP/50tqDlP6GppaVQ69zUZAlagDe6hFS2C61MR+xN/CRq+PNq/1Jh4jqMC+oM
	 4on2JMP1S2HbnENUCs7mbeGwuDVe/ETnmQ3I3NaT9lXcO7pzsqniPSwRlDgtNURU1T
	 aR6JmQi7j4UBdyVRtDBMYqf2X75jrfE9ClzkTdEp2/2njaKSa0j+AOztqdlhte27as
	 Y750FHwf53mSyY9rhcVLvCqh0L/tsbDuOhPXAfUF4UHV88maksfvccAl9lbXQfHZ/q
	 sg4PZ4hwSpV6DPEVpbekZOg8u5Cl2qgF2gp/GeTxDJ+G/Zu0jfeUSFqDGhNH6ByK35
	 PlyxnsQOaa+6A==
Date: Fri, 26 Sep 2025 00:22:24 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
	"nsz@port70.net" <nsz@port70.net>,
	"dalias@libc.org" <dalias@libc.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"jeffxu@google.com" <jeffxu@google.com>,
	"codonell@redhat.com" <codonell@redhat.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Message-ID: <8aab0f36-52ad-4fd6-98c3-bcdba45dbe16@sirena.org.uk>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rIZPmzQlvkyadnwb"
Content-Disposition: inline
In-Reply-To: <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
X-Cookie: Shipping not included.


--rIZPmzQlvkyadnwb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 08:40:56PM +0000, Edgecombe, Rick P wrote:

> Security-wise, it seems reasonable that if you are leaving a shadow stack=
, that
> you could leave a token behind. But for the userspace scheme to back up t=
he SSP
> by doing a longjmp() or similar I have some doubts. IIRC there were some =
cross
> stack edge cases that we never figured out how to handle.

I think those were around the use of alt stacks, which we don't
currently do for shadow stacks at all because we couldn't figure out
those edge cases.  Possibly there's others as well, though - the alt
stacks issues dominated discussion a bit.

AFAICT those issues exist anyway, if userspace is already unwinding as
part of thread exit then they'll exercise that code though perhaps be
saved from any issues by virtue of not actually doing any function
calls.  Anything that actually does a longjmp() with the intent to
continue will do so more thoroughly.

> As far as re-using allocated shadow stacks, there is always the option to=
 enable
> WRSS (or similar) to write the shadow stack as well as longjmp at will.

That's obviously a substantial downgrade in security though.

> I think we should see a fuller solution from the glibc side before adding=
 new
> kernel features like this. (apologies if I missed it). I wonder if we are

I agree that we want to see some userspace code here, I'm hoping this
can be used for prototyping.  Yury has some code for the clone3() part
of things in glibc on arm64 already, hopefully that can be extended to
include the shadow stack in the thread stack cache.

> building something that will have an extremely complicated set of rules f=
or what
> types of stack operations should be expected to work.

I think restricted more than complex?

> Sort of related, I think we might think about msealing shadow stacks, whi=
ch will
> have trouble with a lot of these user managed shadow stack schemes. The r=
eason
> is that as long as shadow stacks can be unmapped while a thread is on the=
m (say
> a sleeping thread), a new shadow stack can be allocated in the same place=
 with a
> token. Then a second thread can consume the token and possibly corrupt the
> shadow stack for the other thread with it's own calls. I don't know how
> realistic it is in practice, but it's something that guard gaps can't tot=
ally
> prevent.

> But for automatic thread created shadow stacks, there is no need to allow
> userspace to unmap a shadow stack, so the automatically created stacks co=
uld
> simply be msealed on creation and unmapped from the kernel. For a lot of =
apps
> (most?) this would work perfectly fine.

Indeed, we should be able to just do that if we're mseal()ing system
mappings I think - most likely anything that has a problem with it
probably already has a problem the existing mseal() stuff.  Yet another
reason we should be factoring more of this code out into the generic
code, like I say I'll try to look at that.

I do wonder if anyone would bother with those attacks if they've got
enough control over the process to do them, but equally a lot of this is
about how things chain together.

> I think we don't want 100 modes of shadow stack. If we have two, I'd thin=
k:
> 1. Msealed, simple more locked down kernel allocated shadow stack. Limite=
d or
> none user space managed shadow stacks.
> 2. WRSS enabled, clone3-preferred max compatibility shadow stack. Longjmp=
 via
> token writes and don't even have to think about taking signals while unwi=
nding
> across stacks, or whatever other edge case.

I think the important thing from a kernel ABI point of view is to give
userspace the tools to do whatever it wants and get out of the way, and
that ideally this should include options that don't just make the shadow
stack writable since that's a substantial step down in protection.

That said your option 2 is already supported with the existing clone3()
on both arm64 and x86_64, policy for switching between that and kernel
managed stacks could be set by restricting the writable stacks flag on
the enable prctl(), and/or restricting map_shadow_stack().

> This RFC seems to be going down the path of addressing one edge case at a=
 time.
> Alone it's fine, but I'd rather punt these types of usages to (2) by defa=
ult.=20

For me this is in the category of "oh, of course you should be able to
do that" where it feels like an obvious usability thing than an edge
case.

--rIZPmzQlvkyadnwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjVzq8ACgkQJNaLcl1U
h9C/Zgf/YsaHKL3IuYJT4bELuSPoXHSsli0e8DMjfJmAPL6TPeun+wwdBJMlfGWn
HViXRmQZswZOv+8Ok0G9IVXgBeuudF8GpWm+F+6TEk4pY9rZi9KSzLKdCx/SA82+
b8eM8e2F9L2wwS4tFRilzt8EXTxqXBewa7qKd/PQPl2pr0601GooqXL2eSigqkuJ
j/GRDiW75d5IaVlPRKgt552V26sydmaOdeecWXrqAj1BTH0R3y/xkzT5g2/oTU6B
XZ8AFGDLHKe2Wu9HNwCHzte0E8Tzbjnrphjl0s8S2kkKq97AImKNJQ7XyE3IxoFi
DDIGVgk6Q47ah6wmOzEglPl4gRIvCQ==
=FhTh
-----END PGP SIGNATURE-----

--rIZPmzQlvkyadnwb--

