Return-Path: <linux-kselftest+bounces-1466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D505C80B13B
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 02:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AA41F21248
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 01:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E947FB;
	Sat,  9 Dec 2023 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI+MJlPw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409A664E;
	Sat,  9 Dec 2023 01:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB824C433C8;
	Sat,  9 Dec 2023 01:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702084019;
	bh=b6IjCysQyxVJK9x8nj1AYEYR5XOXnTtkuZQSQ08vHNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VI+MJlPwo53axFeWk1xMCwtjB2HzkUa86ouwE+WAHMXJxsW8IZ8MrMKC1fLFLUWdp
	 tZz88EUXQ3jCxD1yqhnjciQsIfJ27ShL2N4wg1jLi5Gpn0XdSKMv2eSD9xUYBOvGdm
	 T3VsQWakNryOkdDG16ABIhRDryPSd5kmdCsm9oeOsHRYolWO9XJzZgYjXWNqWk0hDY
	 pL5R/E3hfC2Iij067Dl5XASdEQ1cWnRYUGjG4SwjdrYs0cr++bz2jOEtUXeTsB8Ql2
	 VkEIjaPS0oGFD2wU11DDnrdaIxqS+5RAjQ54y6ijn9Gy13/kNjAeOZTmHfDuD3pyZT
	 PRAm4wHuV9iXw==
Date: Sat, 9 Dec 2023 01:06:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Robert O'Callahan <robert@ocallahan.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
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
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFT v4 0/5] fork: Support shadow stacks in clone3()
Message-ID: <ZXO9sPEtVEuaTx/p@finisterre.sirena.org.uk>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <CAOp6jLY8aEFOOqe4ADkgeACvat+07_F_Xj963FhyXkF+0F5Pqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9+v5nyrr2oNDi4Pq"
Content-Disposition: inline
In-Reply-To: <CAOp6jLY8aEFOOqe4ADkgeACvat+07_F_Xj963FhyXkF+0F5Pqw@mail.gmail.com>
X-Cookie: You might have mail.


--9+v5nyrr2oNDi4Pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 09, 2023 at 01:59:16PM +1300, Robert O'Callahan wrote:

> overriding clone_args::shadow_stack_size to zero in the call to
> clone3(), instead having the replay task call map_shadow_stack() to
> put the the shadow stack in the right place, and then setting its SSP
> via ptrace. Will that work?

That should work with the interface in the current series, yes.

--9+v5nyrr2oNDi4Pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVzva8ACgkQJNaLcl1U
h9CLYAf/elahxJ0+6pGU/W2cE2bLlKd8hf7OxZlCjvCjqdNNIcfk1AT5m6hhowGw
8vrXEALM0eN8d9SNyPCdHgdEC9p/qA0SC5AEoYNVb7XNtaBhalLMXRI7YryryF93
nxul+HAYJrhYxsGrFzpirjb2QiOkLkvGLE7Fvyfvb+z9cserDUUww/LSHsocaPdr
AE/G/jNrdAEMMbXqdNDdOeiS3of8qPtcN1rXi6z1MItAHBn+6ml9NOnlQrGlxkd1
WE6Wwm28fdfukIzBys0i7AjdUSn/d7xk0+vWDjF4I+A/2Lt0tFuH7XC6OR9yGy3v
Fil+OidV+GMhhDfWW6Ym9nLIt3W8Bg==
=VQz8
-----END PGP SIGNATURE-----

--9+v5nyrr2oNDi4Pq--

