Return-Path: <linux-kselftest+bounces-329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18647F17C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 16:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8601228213A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 15:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451B51C29C;
	Mon, 20 Nov 2023 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFGlYdyZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257451C299;
	Mon, 20 Nov 2023 15:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8761EC433C7;
	Mon, 20 Nov 2023 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700495281;
	bh=Pqf0n0WeWapO2rexMfY7DVUbXOQsxxnsm5OV8uzP0l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFGlYdyZ4aooQny7HpcVdwiEhDOv+NfyxvwJDl5MhddiGZMQcQfPexiJQG5vduf+2
	 e6usNZrsf9DQAJavs1p0ZasnPuxM7z42rQB5u3DPzTMUV8hocsdghKfYkL/wCemVHA
	 AEQwyTdHo9DB50LPO9wiYjrKDkMo361uqixSnd4x7QE1PrBQVguNmxViYJQj8xC4L/
	 QoK060hByDKtkmW7XJLgEWlg/5Pr+2adCARB2Fn0/mW3E7XBWGvOghm/6LwqcTkwFj
	 ezh6zPw5NfemTc8o89g3ZOSALWluWZsI5q2KhV3AXoOz9UaKggQprcdsb35h3npn1y
	 ZM6/+pcUkOJwA==
Date: Mon, 20 Nov 2023 15:47:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
Message-ID: <fde30e5a-f795-46ed-9dd8-9370c4f0aae8@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-5-b613f8681155@kernel.org>
 <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
 <ZVfXTmVestrAwIkN@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3acFUUbMZ6fZyK3o"
Content-Disposition: inline
In-Reply-To: <ZVfXTmVestrAwIkN@debug.ba.rivosinc.com>
X-Cookie: <Manoj> I *like* the chicken


--3acFUUbMZ6fZyK3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 17, 2023 at 01:12:46PM -0800, Deepak Gupta wrote:
> On Tue, Nov 14, 2023 at 11:11:58PM +0000, Edgecombe, Rick P wrote:

> > It seems like there will be a need for some generic method of checking
> > if shadow stack is enabled. Maybe a more generic compiler
> > intrinsic/builtin or glibc API (something unrelated to SSP)?

> Exposing a new file under procfs would be useful?
> Something like "/proc/sys/vm/user_shadow_stack_supported"

> `map_shadow_stack` can return MAP_FAILED for other reasons.
> I think `kselftests` are fine but I don't want people to pick up this
> as test code and run with it in production :-)

> So kernel providing a way to indicate whether it supports shadow stack
> mappings in user mode via procfs would be useful and arch agnostic.

I can see that might be useful for some higher level code that wants to
tune the size and nothing else.  I'd be tempted to do it through adding
a tuneable for the maximum default shadow stack size (x86 currently uses
4G) just so it's *vaguely* useful rather than just a file.  I question
the utility of that but just a plain file doesn't feel quite idiomatic.

In any case it feels like it's off topic for this series and should be
done separately.

--3acFUUbMZ6fZyK3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbf6cACgkQJNaLcl1U
h9Ak7wf8CA50MceuP83I2frKM1LB7rUjimAktBhZrwl5FbVW7GLI9WxpLtXZ4Gce
6+H6sDQmMtCmAiYmwZG214ZNu95rQr8HUxQCVs8WY7Ir3h9U02/MNpcaIXswd1oe
kbT14fSM/GGsA+uSKGkbuXMSQAONUKNC7iNF6R52pKZs4J4clVxxylydo47OFrDD
/EkwidMFHpPlsJkv48ETgjih58pssM9+B/oBIP1RlwmS4sgPshT9+wyEGnFjs83O
susJUcqp61pP6dV2CQN1YRfvGWo+vsZ6ByHLKOrOM9SEVJAm01FzzwYPEyRhXj+S
FxAsuQ+E51GZknCUfOkBnAjqeuY8hw==
=L/Yb
-----END PGP SIGNATURE-----

--3acFUUbMZ6fZyK3o--

