Return-Path: <linux-kselftest+bounces-42438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E282BA21B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 02:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6061B4C4E07
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 00:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083A1BC58;
	Fri, 26 Sep 2025 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYbg8P+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6EF41AAC;
	Fri, 26 Sep 2025 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758847466; cv=none; b=XYyUjr04nxEUrxUrgQTwath1dBkT/9kJE8BOFTS2hj5m9Hml+ucSbTU7aaAp66Zk9nu0Wcpy9ps4F8GeBeBHQv9Ty5xlKP5nblDKP98Up9Gnen67f/P1HHaZCrXpkNTHaCCOex8Q4LRLwuY4MchDe/vV9pm84Qf2XuH9wQFKQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758847466; c=relaxed/simple;
	bh=8EHTqyyVT8V2rSv9sFT+vRqsC+aiKGrtiaHCp2wsEnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4FYgzgq/E4O15mXg+xMre7xfLXLKQWml56XyZvqlHiZW/AQOxiVFxORPxGZ85g7wBazTrNDBkxuK5bH33HLvgIil8C7SA4mUzX/7rA+e+MWc7/dPOLi31XRpqQNBEJ6X29lC4K7kCMa0gfNq5OGecJdKJuXX+ZpkBSxvY52Fgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYbg8P+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEF8C4CEF0;
	Fri, 26 Sep 2025 00:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758847465;
	bh=8EHTqyyVT8V2rSv9sFT+vRqsC+aiKGrtiaHCp2wsEnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYbg8P+VMnfDAmfFvFBfMB7RgFSGpcJcENDUTYJYEqW9klZ/XRoW5VWRcc9hc4RAt
	 cuFznzSeQuS9djb+jeNKZdGHsmhSdvrUrHroQMOHNR7OxkUZv9sg0TVNZ3gn0Sag1Y
	 mdyV+uX3G2QsFa9pLsc6g/KpidHgnaRO03bIDbYxRJ7gmSfHkreUGd11ZAiTSpqVnK
	 +Ty56MFXA9zQcKz6H6/o8j5KQf219jkVJb+Ts2Ulgl0hnYRlIjjj/bsClGDUrfgB3h
	 JeHFEMZ8cgXCsDa8WhrdsMFG29oDUfE8MkpGSA98KN8r9YS2g1YVCgD9ZFWPgkpp1b
	 q13YADjlsPyAw==
Date: Fri, 26 Sep 2025 01:44:19 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
	"nsz@port70.net" <nsz@port70.net>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dalias@libc.org" <dalias@libc.org>,
	"jeffxu@google.com" <jeffxu@google.com>,
	"will@kernel.org" <will@kernel.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"codonell@redhat.com" <codonell@redhat.com>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Message-ID: <604190c7-5931-4e74-a1c9-467e52d3001b@sirena.org.uk>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
 <8aab0f36-52ad-4fd6-98c3-bcdba45dbe16@sirena.org.uk>
 <ac0ceb09ffaeb1f0925b61ed1b82ee6475df2368.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A/R+sHCzHj56QgUT"
Content-Disposition: inline
In-Reply-To: <ac0ceb09ffaeb1f0925b61ed1b82ee6475df2368.camel@intel.com>
X-Cookie: Take your Senator to lunch this week.


--A/R+sHCzHj56QgUT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:58:01PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2025-09-26 at 00:22 +0100, Mark Brown wrote:

> > I think those were around the use of alt stacks, which we don't
> > currently do for shadow stacks at all because we couldn't figure out
> > those edge cases.  Possibly there's others as well, though - the alt
> > stacks issues dominated discussion a bit.

> For longjmp, IIRC there were some plans to search for a token on the targ=
et
> stack and use it, which seems somewhat at odds with the quick efficient j=
ump
> that longjmp() gets usually used for. But it also doesn't solve the probl=
em of
> taking a signal while you are unwinding.

Yeah, that all seemed very unclear to me.

> Like say you do calls all the way to the end of a shadow stack, and it's =
about
> to overflow. Then the thread swaps to another shadow stack. If you longjm=
p back
> to the original stack you will have to transition to the end of the first=
 stack
> as you unwind. If at that point the thread gets a signal, it would overfl=
ow the
> shadow stack. This is a subtle difference in behavior compared to non-sha=
dow
> stack. You also need to know that nothing else could consume that token o=
n that
> stack in the meantime. So doing it safely is not nearly as simple as norm=
al
> longjmp().

> Anyway, I think you don't need alt shadow stack to hit that. Just normal
> userspace threading?

Ah, the backtrack through a pivot case - yes, I don't think anyone had a
good story for how that was going to work sensibly without making the
stack writable.  Sorry, I'd written off that case as entirely so it didn't
cross my mind.

> > > As far as re-using allocated shadow stacks, there is always the optio=
n to enable
> > > WRSS (or similar) to write the shadow stack as well as longjmp at wil=
l.

> > That's obviously a substantial downgrade in security though.

> I don't know about substantial, but I'd love to hear some offensive secur=
ity
> persons analysis. There definitely was a school of thought though, that s=
hadow
> stack should be turned on as widely as possible. If we need WRSS to make =
that
> happen in a sane way, you could argue there is sort of a security at scale
> benefit.

I agree it seems clearly better from a security point of view to have
writable shadow stacks than none at all, I don't think there's much
argument there other than the concerns about the memory consumption and
performance tradeoffs.

> > > But for automatic thread created shadow stacks, there is no need to a=
llow
> > > userspace to unmap a shadow stack, so the automatically created stack=
s could
> > > simply be msealed on creation and unmapped from the kernel. For a lot=
 of apps
> > > (most?) this would work perfectly fine.

> > Indeed, we should be able to just do that if we're mseal()ing system
> > mappings I think - most likely anything that has a problem with it
> > probably already has a problem the existing mseal() stuff.  Yet another
> > reason we should be factoring more of this code out into the generic
> > code, like I say I'll try to look at that.

> Agree. But for the mseal stuff, I think you would want to have map_shadow=
_stack
> not available.

That seems like something userspace could enforce with existing security
mechanisms?  I can imagine a system might want different policies for
different programs.

> > I think the important thing from a kernel ABI point of view is to give
> > userspace the tools to do whatever it wants and get out of the way, and
> > that ideally this should include options that don't just make the shadow
> > stack writable since that's a substantial step down in protection.

> Yes I hear that. But also try to avoid creating maintenance issues by add=
ing
> features that didn't turn out to be useful. It sounds like we agree that =
we need
> more proof that this will work out in the long run.

Yes, we need at least some buy in from userspace.

> > That said your option 2 is already supported with the existing clone3()
> > on both arm64 and x86_64, policy for switching between that and kernel
> > managed stacks could be set by restricting the writable stacks flag on
> > the enable prctl(), and/or restricting map_shadow_stack().

> You mean userspace could already re-use shadow stacks if they enable writ=
able
> shadow stacks? Yes I agree.

Yes, exactly.

> > > This RFC seems to be going down the path of addressing one edge case =
at a time.
> > > Alone it's fine, but I'd rather punt these types of usages to (2) by =
default.=20

> > For me this is in the category of "oh, of course you should be able to
> > do that" where it feels like an obvious usability thing than an edge
> > case.

> True. I guess I was thinking more about the stack unwinding. Badly phrase=
d,
> sorry.

I'm completely with you on stack unwinding over pivot stuff, I wasn't
imagining we could address that.  There's so many landmines there that
we'd need a super solid story before doing anything specific to that
case.

--A/R+sHCzHj56QgUT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjV4eIACgkQJNaLcl1U
h9DHTgf/f4tSxFTnVI4O8vF1sNsgpSWdCPgLFDFEkHzstxue18M7OOSA56I9l2aV
ygiokn9rp6N1qftLP3GR36irfjVxLrM1PF+3oqbLJCtnngZ1No4JiNeyGE59fNwX
ifQ5hLF96aWsc+O2uzFADQ1AFeeMjJeVfFYqcCtnbDsUSdn7E/YDLN+S1MFtdGyx
c3+5vagLCiPmHKTN99oDEagV9NBAK/PjqR3k+hu3kGyQ+z4xeMoPxMsHR2NaXJPu
Eu6fujx6KkwGrgH/WGzMj9QA82L0ZR5qYBl/a06l/RKds7TZGlHSSWs3JL+/zAhj
fZOBv8+/nRREYi4EKB12mliRRUuLKA==
=5j/V
-----END PGP SIGNATURE-----

--A/R+sHCzHj56QgUT--

