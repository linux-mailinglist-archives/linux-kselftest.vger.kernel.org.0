Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A64047018A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 14:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhLJN3Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 08:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbhLJN3Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 08:29:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31285C0617A1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 05:25:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 17342CE2AD8
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 13:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99101C341DB;
        Fri, 10 Dec 2021 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639142744;
        bh=4HnH3TdACgt7zDqkVttFbztqQ7VRnhIfSlUrKPzKZVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=osCU0IbgC/cIa7rHLTOo6WT2tAKBzfuepfkv8FOsTUsg8P7LJ+iwhbfXgXUn4oAzj
         M0zOw22W4LjZxqjwcwStn00kOPnaOi+JtibYOuBCv3IZ61Nq8F/zRmi6ZyGBadqzfP
         CVFsZXLrjOHiFIR5f6+4zN0JGzRvRtWsW5WgsroQZuLbo3/UbrEz+diFcHJ/oXQxG0
         cc2rCsCKuw3BYvOMOT25odOyxHmBiNotzrKPMHR5hMIIvu9b91MWBnwW8q+XBuh4SR
         U2ZA0TLgUvLZkz99fIVVIticgfIZT2mWozYwfeYCmoE82o0bhHRgS64sxkGU8MJmQs
         VnxUW/nOLt8KA==
Date:   Fri, 10 Dec 2021 13:25:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 06/37] kselftest/arm64: Add a test program to exercise
 the syscall ABI
Message-ID: <YbNVUklLMeR6uzm2@sirena.org.uk>
References: <20211115152835.3212149-1-broonie@kernel.org>
 <20211115152835.3212149-7-broonie@kernel.org>
 <YbI3ZfhOO+M5L/9V@arm.com>
 <YbJVPGqADH/cadaU@sirena.org.uk>
 <YbMphO6wwXz54yjB@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qeo3l7me56RjvCyj"
Content-Disposition: inline
In-Reply-To: <YbMphO6wwXz54yjB@arm.com>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Qeo3l7me56RjvCyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 10, 2021 at 10:18:44AM +0000, Catalin Marinas wrote:
> On Thu, Dec 09, 2021 at 07:13:00PM +0000, Mark Brown wrote:
> > On Thu, Dec 09, 2021 at 05:05:41PM +0000, Catalin Marinas wrote:

> > > Nitpick: I think GPL-2.0 is sufficient (i.e. no '-only' suffix), thou=
gh
> > > about a quarter seem to use the -only variant.

> > Yeah, it's that because it's the default for kernel stuff.  Easier to
> > make it restrictive and then relax later?

> My point was that IIUC GPL-2.0 is equivalent to GPL-2.0-only (not to be
> confused with GPL-2.0+). Anyway, it's fine by me to keep the -only if
> you want. It seems that we have nearly the same amount of both
> throughout the kernel.

Ah, I see - I think the thing with -only is to avoid any ambiguity and
confusion about what's meant.  I'll leave it as is.

> > > A downside with forcing zero is that it may prevent us from some
> > > optimisations in the future. Currently we do an sve_user_discard() on
> > > the syscall entry path and disable SVE but we could instead do this o=
nly
> > > on context switch or when the kernel used Neon.

> > Yes, this is limiting our options for performance work since we need to
> > at least take the cost of zeroing the non-shared state on every syscall,
> > though there's still options for choosing not to disable SVE all the
> > time (I've got a patch already I need to do a bit more work on).=20

> Some people seem to be pretty sensitive to the syscall latency, so I'd
> like to keep the option to optimise this path if it bites us.

If that's what we decide then we should probably just go ahead and start
taking advantage of it, we do have hardware rolling out imminently so
people will benefit and the sooner we start doing this the less chance
there is that it'll end up an ABI implicitly.

> > The
> > currently documented behaviour is in line with AAPCS here so you do have
> > to wonder how likely it is that someone will rely on the zeroing.  On
> > the other hand anything like only zeroing the state on context switch
> > would mean that it's more likely that userspace bugs with something
> > forgetting that the state might be cleared will be intermittent and most
> > likely hard to reproduce which will make people miserable.  There's a
> > good chance that bugs will be wrong answers rather than something more
> > immediate like a fault which really doesn't help there.

> If we eventually optimise this path, we could add an option to
> force-zero the SVE regs on syscall for debugging purposes. But even
> without this, such software may run into problems. By AAPCS, if the
> callee doesn't take any SVE arguments, it doesn't need to preserve any
> of the registers, though it may choose to. Let's take a gettimeofday
> libc call, it may or may not end up in the kernel. When it's handled by
> the vDSO, all the SVE regs are preserved but not when doing the syscall.
> Something like a futex call would be even less predictable.

Not just that but also the fact that most syscalls go through a library
of some kind which could quite happily use some floating point register
for something before or after performing the actual syscall.  Like I
said above I'm not personally convinced that risks are practical ones
and there's fairly clear benefits.

--Qeo3l7me56RjvCyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGzVVEACgkQJNaLcl1U
h9BPjAf+J67xTLYEQsrSmblLIXQjzDo+idX9v+xlgLAfFvF3rQNYBlFKE2Nx8g2o
bmQKW168QbL5CFDfbML7TbkG3jXYzDFSstaZcw9XXcZ8iPumq58rLxa6fx1wfjjn
YqeOPBxrk7dPS7fyOSwzMnNGKvlkHfnnGTnRTCVs+oACeL2cxKHcqx6GUoFs9ITe
vncByTrUep+/9vqEi10DhfgjI7Lbnyq95+WhEv+u42Xi0zk7kg3ByI5pV5JdHjZM
fn7rwMwX7yyGnuBForLi5VWtDkt3A6RL/HerEZZgRmdNLGVZ9EWCG6SbPoVuEAmi
XtC5atWfGPISz/wdrDiEoN2EaFiPjw==
=SnaW
-----END PGP SIGNATURE-----

--Qeo3l7me56RjvCyj--
