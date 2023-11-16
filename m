Return-Path: <linux-kselftest+bounces-229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE47EE688
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 19:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C061B20C71
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378AD35896;
	Thu, 16 Nov 2023 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAviU7ju"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C754655C;
	Thu, 16 Nov 2023 18:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408A5C433C8;
	Thu, 16 Nov 2023 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700158458;
	bh=fU9UbtrsIqmGuD7XgmjRY/5d5B/QYSrBZgF4IZZYGTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tAviU7jubktNs951PoKcGBu4o5sD3xt8QsVKXloraDS99HD4ozv6XhqsV2PXFtK+S
	 R1It3k0KIsLumPM77URN6Yrq1mQ7y25JL04zaPvM75PjvZDufW9ls45UOoxokroHak
	 Vv9RUij8AiP5+wTpq0Z4ZgcO3r5WFBAKAjkWXpUha97JiWHO0kciorfu59zd6ufLjq
	 ryC6wk0hbWkL71gJ4xT+QZizLMqFjqQaI6bUBrnbO+J2lZ6JgIA+srmG1cOALOAdAn
	 dTin/yRPGTktcUWlHlF6RM5EXwjZ4dknmbaWN5vOY2rQQoHxWvtZsdVjS/2v/xhklk
	 NrB/wrQeykMtg==
Date: Thu, 16 Nov 2023 18:14:09 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
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
	"Pandey, Sunil K" <sunil.k.pandey@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Message-ID: <2b4b935e-aea1-4283-a459-5d6004b24b28@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
 <ZVTvvJTOV777UGsP@arm.com>
 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="15rJUYEsjrHhwsZm"
Content-Disposition: inline
In-Reply-To: <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
X-Cookie: micro:


--15rJUYEsjrHhwsZm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 12:52:09AM +0000, Edgecombe, Rick P wrote:
> On Wed, 2023-11-15 at 18:43 +0000, Mark Brown wrote:
> > > end marker token (0) needs it i guess.

> > x86 doesn't currently have end markers.=A0 Actually, that's a point -
> > should we add a flag for specifying the use of end markers here?
> > There's code in my map_shadow_stack() implementation for arm64 which
> > does that.

> Hmm, I guess there isn't a way to pass a flag for the initial exec
> stack? So probably it should just mirror that behavior. Unless you
> think a lot of people would like to skip the default behavior.

I don't really know that anyone would particularly want to use a flag on
arm64, I was more thinking for the benefit of x86 where any termination
record would be a change.  It's certainly easier to not have flags so
I'm more than happy to leave things as they are, there's nothing
stopping further extensions of the ABI if we decide we want them later.

> And of course we don't have a marker on x86 (TODO with alt shadow
> stacks). We could still check for size < 8 if we want it to be a
> universal thing.

It does seem simpler, size < 8 is all edge case.

--15rJUYEsjrHhwsZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVWW/AACgkQJNaLcl1U
h9CzZQf/dIUyUF/fRB2YA6pvIXvNE5ZU2z1Domwxa98+bLpNitJrcbiBgQGOxFZb
ryxcalGm1nhzTbcyGM45iJQb48ageOjQEVGr2ztoKX8bVsRBNCfCSWEATPhSAi0r
ek28N2U9wEVNiQyoYaDztE7wMABEihBZLacKKYSsQ8tSyLfcJOU7o3FN9DdVx316
GfkPWEC2uSTgHvZozm66MUoP1n+GIFobMATYrdtxu2LI65rjrP5YxmMe5/c7TqB2
3b2ctcgr3SiKHg+rOl4rxmYR1nlACbJnE9sF4NZv6BYIgTYaze9EHizu44+Usm2N
we2gOehM/hZyskUKxv/NvW7skuQl2w==
=zUsz
-----END PGP SIGNATURE-----

--15rJUYEsjrHhwsZm--

