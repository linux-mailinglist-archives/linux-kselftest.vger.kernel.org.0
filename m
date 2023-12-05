Return-Path: <linux-kselftest+bounces-1144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC57980582A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D5C1C20C6E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB167E84;
	Tue,  5 Dec 2023 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY4z3Vzv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240867E81;
	Tue,  5 Dec 2023 15:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055F1C433C7;
	Tue,  5 Dec 2023 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701788745;
	bh=aap6pmp+k2anpVz8ybOF65zFnWxtExFTvx5xhqmLzhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KY4z3VzvUuPldDeBw1TVDWWHBlLtm/bPmaaxPgzbCSHLaQYi1u+lCwOb7Us/NjEcx
	 o7sD3S6iAE0kqc55CH1FJRYCDrFhE5JAnh2FSorQL9ENifCtcB2OIGfSLGSXF7VgE/
	 o8/cza+U878GauzXqR/B12Q4kYa0ZCG/YLvOstc6yG+uoqaW/dRuVIKhEkrjSzhZaX
	 JZuFrrGjzC2DWyMRSXLM0njLcgfRJhjuQfswGV2u1JFM8I7wuJhwyIQtXoneSf/wQL
	 MzPZZnBSiQNxsG7dgobcKlxmI6QUYtjnEhqQZnnA8PKsirpP69JcRC/rx3sMBgHSi6
	 kxfISKx2P9EAA==
Date: Tue, 5 Dec 2023 15:05:36 +0000
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
	"keescook@chromium.org" <keescook@chromium.org>,
	"jannh@google.com" <jannh@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v4 5/5] kselftest/clone3: Test shadow stack support
Message-ID: <345cf31a-3663-4974-9b2a-54d2433e64a7@sirena.org.uk>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <20231128-clone3-shadow-stack-v4-5-8b28ffe4f676@kernel.org>
 <4898975452179af46f38daa6979b32ba94001419.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eEFWtkuzePavFi4c"
Content-Disposition: inline
In-Reply-To: <4898975452179af46f38daa6979b32ba94001419.camel@intel.com>
X-Cookie: I've Been Moved!


--eEFWtkuzePavFi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 12:10:20AM +0000, Edgecombe, Rick P wrote:

> Without this diff, the test crashed for me on a shadow stack system:

> -static inline void enable_shadow_stack(void)
> +static inline __attribute__((always_inline)) void

doh.

> But I wonder if the clone3 test should get its shadow stack enabled the
> conventional elf bit way. So if it's all there (HW, kernel, glibc) then
> the test will run with shadow stack. Otherwise the test will run
> without shadow stack.

This creates bootstrapping issues if we do it for arm64 where nothing is
merged yet except for the model and EL3 support - in order to get any
test coverage you need to be using an OS with the libc and toolchain
support available and that's not going to be something we can rely on
for a while (and even when things are merged a lot of the CI systems use
Debian).  There is a small risk that the toolchain will generate
incompatible code if it doesn't know it's specifically targetting shadow
stacks but the toolchain people didn't seem concerned about that risk
and we've not been running into problems.

It looks x86 is in better shape here with the userspace having run ahead
of the kernel support though I'm not 100% clear if everything is fully
lined up?  -mshstk -fcf-protection appears to build fine with gcc 8 but
I'm a bit less clear on glibc and any ABI variations.

> The other reason is that the shadow stack test in the x86 selftest
> manual enabling is designed to work without a shadow stack enabled
> glibc and has to be specially crafted to work around the missing
> support. I'm not sure the more generic selftests should have to know
> how to do this. So what about something like this instead:

What's the issue with working around the missing support?  My
understanding was that there should be no ill effects from repeated
attempts to enable.  We could add a check for things already being
enabled=20

--eEFWtkuzePavFi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvPEAACgkQJNaLcl1U
h9BTUAf/XQUhFFRSCwVlzHTp8jJ+VI5Cs+r84ZiyHFlSQtaZvyox4D48jNDyd8kw
iXxMa2/lUeW/qiZ2bufzYmM8AKSuObkpZhcCj+TyprXYnvmhqscegfQjQqnqgV+b
ctpM6PGCxetylMwYUwMw83v4ZUrLua2oCnU+xdHphkC1ClZt2lH6lZXAAG5q7Qx/
E2t1mv+L/eA7qNnMGddM3PQ35AQu7mHFuPohck0pIKqvxXiQVGDRdYTLuMxlKQDG
f43kOxDHV7jSemDeF0K60+t53hVU36kE5yFUH2gqQUaksnZsTzkv1OX8Hdn/VXON
1HI0UnmxFD8fHjkg8vvOvtr3/ncfxw==
=1GHB
-----END PGP SIGNATURE-----

--eEFWtkuzePavFi4c--

