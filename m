Return-Path: <linux-kselftest+bounces-133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F11397EC66D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD06B20AB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DB92FC31;
	Wed, 15 Nov 2023 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6SzQQ0G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525AA2EAE1;
	Wed, 15 Nov 2023 14:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB44C433C8;
	Wed, 15 Nov 2023 14:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700060115;
	bh=3Hec5autMPLguh8WZx+203t12eHE86qIIse3+7N4Kvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6SzQQ0G957ck8KHrzlQOTYnntTKs8MwjFGJMmRKGC7hPamKt8OlQ6F9+86ZzMhyU
	 nj3lMflcXZh4jS3z36pttITWlU1IZ9UjQ9vlLW/phvpmUsFzMZ/uwdjY2OBOUVNJQN
	 8t2y6wepVtLl71kdjMpogDP+yfDFuaNZ+NUEXDuJi9DlXHYuCDLEEoUNw8ZftTLN/M
	 6bfcmMPHzJMfblKhLNKwcshgnpf1jY4QT7uU/f8SONKYq2daZj2JTLulzhfpoooCpH
	 ZOQ/g2b02rgekfNQH/8l9hYvR7wu3HxrkudVastN0wl9I5bEqfVwAumA7YT/mRxxd1
	 zcDnhpy2whkTQ==
Date: Wed, 15 Nov 2023 14:55:06 +0000
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
	"david@redhat.com" <david@redhat.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"jannh@google.com" <jannh@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFC RFT v2 1/5] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Message-ID: <6176c556-ae24-40b2-a785-73a1b705bd28@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-1-b613f8681155@kernel.org>
 <837fec017b9709eb42d35e9608c24619613ed221.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YCYkPF8mAZ480WWM"
Content-Disposition: inline
In-Reply-To: <837fec017b9709eb42d35e9608c24619613ed221.camel@intel.com>
X-Cookie: For internal use only.


--YCYkPF8mAZ480WWM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:22:16PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-11-14 at 20:05 +0000, Mark Brown wrote:
> > +config ARCH_HAS_USER_SHADOW_STACK
> > +=A0=A0=A0=A0=A0=A0=A0bool
> > +=A0=A0=A0=A0=A0=A0=A0help
> > +=A0=A0=A0=A0=A0=A0=A0=A0 The architecture has hardware support for use=
rspace shadow
> > call
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 stacks (eg, x86 CET, arm64 GCS, RISC-V Zis=
slpcfi).

> I feel like normally a patch like this should come with the second
> feature that gets enabled. (i.e. arm or riscv). Especially since the
> comment lists currently unsupported features. I think something like
> this got nixed by an x86 maintainer earlier, but that was before these
> other features were getting pushed.

> I don't have a strong objection to having it ahead of the other
> features though and it is nice to remove X86 defines out of core code.

Given that the GCS patches are on the list and relatively
uncontroversial it does seem reasonable to carry this - I'm only able to
test this in the context of having both serieses applied!

--YCYkPF8mAZ480WWM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVU28oACgkQJNaLcl1U
h9DyAQf9GRBwhEiEgVLxI3kug+WUZcvONEYVJZ5fMLw6R9ADbrEdd/BO/yeXfOyj
evXebqzsGZ8ilEgFdLNwsIntmqUTrkTU1DNCMfBDqQgFfRiSHD+UbwAPhuatNPFx
EKTiPfnCOoaywRuyt+Ez6GMxiDnjHnHC0CfJvGVAmOd+0HbXktLBjjZfFnaTwlbJ
VwVG9ePaLmKUji7Z9kVgdfOQg+l8ZBL6c2ynP0Cj9ylBdQjzRYojCvtJqif67aC6
tCzVm5wXo9LiGGYQPLH1JGo0GRTYNmkIehC0epVU7Pp7cH+NZ6VqxIbZTVtn8wEr
z8ycWQQAl/uEwLfSI4rkKJcmru32cg==
=Gc4i
-----END PGP SIGNATURE-----

--YCYkPF8mAZ480WWM--

