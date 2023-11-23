Return-Path: <linux-kselftest+bounces-479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE53A7F5DEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 12:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8051E281B7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8134E23744;
	Thu, 23 Nov 2023 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/nHMHVA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B922F0A;
	Thu, 23 Nov 2023 11:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FE0C433C7;
	Thu, 23 Nov 2023 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700739476;
	bh=dfH7JLtcaLOZ5kG93bZ9K1NDFAoPQb3niVTAkrcwM6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/nHMHVA2T8YyXHLsQiPMBTNfyPVqZEU3c+ddYbEKGySp9U1JL38kfmY8FVar5+TH
	 BoUk8QeM1GlbxOEeCVj/UDEQdYrG2z+v27SVKZqKqXMFhjH7KFShqf5SlnHcY/ZSHf
	 PcQ1b5ZKg/7AFGzBF+5MCSmvxsp9EaOgUyIN9vlvNH74GzUCl2jrA1LltMAhy70rT0
	 Q3WbjdlWMVTAugc/4S2UKhZkEKDKasuoDm3KThIq0SqSMBWBTSMXtlukkS8lwySK8/
	 +U7hsj2iP7B0SEin0j0nLKNDcwgTTSgsaO4efB+mUJcsPJCgVyC1J5sTRybku9YHvC
	 GZoQiTFQp+nLg==
Date: Thu, 23 Nov 2023 11:37:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, "H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	nd@arm.com
Subject: Re: [PATCH RFT v3 0/5] fork: Support shadow stacks in clone3()
Message-ID: <ZV85khoUcFyKhQ+w@finisterre.sirena.org.uk>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231121-urlaub-motivieren-c9d7ee1a6058@brauner>
 <ZVyg0WgILK35xjBn@arm.com>
 <ZVzWRIA9AfXHeWMW@finisterre.sirena.org.uk>
 <20231123-geflattert-mausklick-63d8ebcacffb@brauner>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ifsxvz+P4lhF/q6b"
Content-Disposition: inline
In-Reply-To: <20231123-geflattert-mausklick-63d8ebcacffb@brauner>
X-Cookie: Slow day.  Practice crawling.


--Ifsxvz+P4lhF/q6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 23, 2023 at 11:10:24AM +0100, Christian Brauner wrote:
> On Tue, Nov 21, 2023 at 04:09:40PM +0000, Mark Brown wrote:
> > On Tue, Nov 21, 2023 at 12:21:37PM +0000, Szabolcs Nagy wrote:
> > > The 11/21/2023 11:17, Christian Brauner wrote:

> > > > (2) With what other interfaces is implicit allocation and deallocation
> > > >     not consistent? I don't understand this argument. The kernel creates
> > > >     a shadow stack as a security measure to store return addresses. It
> > > >     seems to me exactly that the kernel should implicitly allocate and
> > > >     deallocate the shadow stack and not have userspace muck around with
> > > >     its size?

...

> > The inconsistency here is with the management of the standard stack -
> > with the standard stack userspace passes an already allocated address
> > range to the kernel.  A constant tension during review of the shadow
> > stack interfaces has been that shadow stack memory is userspace memory
> > but the security constraints mean that we've come down on the side of
> > having a custom allocation syscall for it instead of using flags on
> > mmap() and friends like people often expect, and now having it allocated
> > as part of clone3().  The aim is to highlight that this difference is

> So you have two interfaces for allocating a shadow stack. The first one
> is to explicitly alloc a shadow stack via the map_shadow_stack(). The
> second one is an implicit allocation during clone3() and you want to
> allow explicitly influencing that.

Yes.  Shadow stacks are also allocated when the inital call to enable
shadow stacks is done, the clone()/clone3() behaviour is to implicitly
allocate when a thread is created by a thread that itself has shadow
stacks enabled (so we avoid gaps in coverage).

> > feature (hence the RFT in the subject line) - Rick Edgecombe did the x86
> > work.  The arm64 code is still in review, the userspace interface is
> > very similar to that for x86 and there doesn't seem to be any
> > controversy there which makes me expect that a change is likely.  Unlike
> > x86 we only have a spec and virtual implementations at present, there's
> > no immintent hardware, so we're taking our time with making sure that
> > everything is working well.  Deepak Gupta (in CC) has been reviewing the
> > series from the point of view of RISC-V.  I think we're all fairly well
> > aligned on the requirements here.

> I'm still not enthusiastic that we only have one implementation for this
> in the kernel. What's the harm in waiting until the arm patches are
> merged? This shouldn't result in chicken and egg: if the implementations
> are sufficiently similar then we can do an appropriate clone3()
> extension.

The main thing would be that it would mean that people doing userspace
enablement based on the merged x86 support can't use the stack size
control.  It's not the end of the world if that has to wait a bit, it's
a bit of a detail thing, but it would make life easier, I guess the
userspace people can let us know if it's starting to be a real hassle
and we can reevaulate if that happens.

It's also currently a dependency for the arm64 code so it'd be good to
at least get ageement that assuming nothing comes up in testing the
patches can go in along with the arm64 series, removing the dependency
and then adding it as an incremental thing would be a hassle.  It's
likely that the arm64 series will be held out of tree for a while to as
more complete userspace support is built up and validated so things
might be sitting for a while - we don't have hardware right now so we
can be cautious with the testing.

--Ifsxvz+P4lhF/q6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVfOZEACgkQJNaLcl1U
h9As+gf+Pxhf4DP4/Gc70QKkmbV/StXWUr7/NSbwvfFW4+t5Zwvb/WUg8ny2X2HW
aSy4S2PsFjDbFCJqzm5MOCM7N6eTbOE0mtMj2A4SO6F/bms1pcyypX92AdXW9ZCX
eEHjaW3XEZZVRuiDW4qyjnr65pdzjdzu4HFqDOpqDIOitEykecpRHsipNOSp1pLm
7dNprMnhBi+XQaBnZD6OGuQFFy7vuQ/7uPSxSZ2YNm3alEj7aIFwDuIef86d2C7S
zPGkKy06taKf1tN4lLQDoyev3Lzm+Ho/iPh0b9isQ6g8+v7js/jvcKibVnGViJ/c
WU3wuqpTgZ8lZwwlUkAVWYGqrP7LPQ==
=KbKk
-----END PGP SIGNATURE-----

--Ifsxvz+P4lhF/q6b--

