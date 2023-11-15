Return-Path: <linux-kselftest+bounces-174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B707ECAAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 19:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0661C208FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE929D0E;
	Wed, 15 Nov 2023 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsmEj/L6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599326AC8;
	Wed, 15 Nov 2023 18:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B93FC433C8;
	Wed, 15 Nov 2023 18:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700073836;
	bh=Jf1pHHRRqyFoJrFcKBLJXZi9kYmA9sn0zKRsvTYeN9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XsmEj/L6owfl4Q4us64Fe207eympvsyfuTyF2EFkC5fMypx8x7hX+Nu+WtmRy6P7o
	 vL+ErFVnalcapwhsCuboN+UbPQg/Q1YJ0wjdl9326hv62K1B4Dz44nEDUe9d4Sc8I+
	 ttk8gVz8Av+XgvRLBGLryPFxAO/2+wI9MEF77VjBWxB0TBXLSDNAGhBKXu2gRLk62n
	 7CsjxKZG8FolkApx0gMQSqtOts/0dxvlIFp/FtsDSOrx6lhGM2MvmW3AsHRfI4WbhB
	 eWuHir/SH9qYR3lDkRv64kmeL0aCF9NX9+gJQorcgnyipZGYFTIpCcFizBpPuRC4Q3
	 WcI5drfP9Qbqw==
Date: Wed, 15 Nov 2023 18:43:47 +0000
From: Mark Brown <broonie@kernel.org>
To: "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
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
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Message-ID: <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
 <ZVTvvJTOV777UGsP@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jREq/r+U2+vimSwN"
Content-Disposition: inline
In-Reply-To: <ZVTvvJTOV777UGsP@arm.com>
X-Cookie: For internal use only.


--jREq/r+U2+vimSwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2023 at 04:20:12PM +0000, Szabolcs.Nagy@arm.com wrote:
> The 11/15/2023 12:36, Mark Brown wrote:
> > On Wed, Nov 15, 2023 at 12:45:45AM +0000, Edgecombe, Rick P wrote:
> > > On Tue, 2023-11-14 at 20:05 +0000, Mark Brown wrote:

> > > > +               if (size < 8)
> > > > +                       return (unsigned long)ERR_PTR(-EINVAL);

> > > What is the intention here? The check in map_shadow_stack is to leave
> > > space for the token, but here there is no token.

> > It was to ensure that there is sufficient space for at least one entry
> > on the stack.

> end marker token (0) needs it i guess.

x86 doesn't currently have end markers.  Actually, that's a point -
should we add a flag for specifying the use of end markers here?
There's code in my map_shadow_stack() implementation for arm64 which
does that.

> otherwise 0 size would be fine: the child may not execute
> a call instruction at all.

Well, a size of specifically zero will result in a fallback to implicit
allocation/sizing of the stack as things stand so this is specifically
the case where a size has been specified but is smaller than a single
entry.

> > > I think for CLONE_VM we should not require a non-zero size. Speaking of
> > > CLONE_VM we should probably be clear on what the expected behavior is
> > > for situations when a new shadow stack is not usually allocated.
> > > !CLONE_VM || CLONE_VFORK will use the existing shadow stack. Should we
> > > require shadow_stack_size be zero in this case, or just ignore it? I'd
> > > lean towards requiring it to be zero so userspace doesn't pass garbage
> > > in that we have to accommodate later. What we could possibly need to do
> > > around that though, I'm not sure. What do you think?

> > Yes, requiring it to be zero in that case makes sense I think.

> i think the condition is "no specified separate stack for
> the child (stack==0 || stack==sp)".

> CLONE_VFORK does not imply that the existing stack will be
> used (a stack for the child can be specified, i think both
> glibc and musl do this in posix_spawn).

That also works as a check I think, though it requires the arch to check
for the stack==sp case - I hadn't been aware of the posix_spawn() usage,
the above checks Rick suggested just follow the handling for implicit
allocation we have currently.

--jREq/r+U2+vimSwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVVEWIACgkQJNaLcl1U
h9AoYwf/cojm+qZcxUY7dfJP7DC47qY+/XzUzkkr087SF7m5CJpUJMr7YDw+IqHs
rSmaGhkeV2BLjb3e4P0UV4bD2pEgfheDGAqNGa5n9fDoQ6O1METyrDUPXco6PZVG
lOcLQ/YWO5m8CddEWltolbnnkBasA3UDTXCkkiOtYs+B8d1N7m1XfpA4RGaul3uI
L5IcslIwekmr1A5mfqcjeRvw3sh9qesVzDLOkWiTrbfLnPFzzU3aCYej18HttKJ3
4DbBiTpvPnO0bgIMTGT5CL9CXEolecng5cEoZV3CtorIcycMj7hzaftvqC5ezkXB
bkm9dunYL/0h1w7pJZ2wxk3h2Tg/ww==
=p7qF
-----END PGP SIGNATURE-----

--jREq/r+U2+vimSwN--

