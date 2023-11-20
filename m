Return-Path: <linux-kselftest+bounces-331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C77F1836
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 17:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256881F25151
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38F01DDFC;
	Mon, 20 Nov 2023 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVeHwi+2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1A1DDD1;
	Mon, 20 Nov 2023 16:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C76C433C8;
	Mon, 20 Nov 2023 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700496675;
	bh=l4r0Zimkl2LX+9IdnFYB72JaaxPTIHzvY5B+YteFh1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVeHwi+2Hgj/MxBohgdl7uWfeCXEx0zHDkNp3GoXfAlPyCNdXjhISc08To2mAWpsg
	 Ka9agmJfeGTq2PwGP7qlDGL2YLoNjtaLlnd2RdQFk74FLmg3ZXJw8OYrOFjOCYjVDK
	 jbbYKoWmyAwlnJ8SS28QkFVQZQu0D4d1lJTGkwE/CcJfi/xh9choFN3jLPEeJkjln+
	 a8d5Q5l2VC6gcFdSM1pZijn63wQgEPhxjx2bpDgcdb9YbWkH4365hcYI5QfOxgcuRs
	 baqdvbxxy2MiR/8bVvBENWqGlzB0zRWDLaLwc1eAK6LbUaC2QOh7tGPbYAcZ3zxuu5
	 AZLFtTkfi6SiA==
Date: Mon, 20 Nov 2023 16:11:05 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"bristot@redhat.com" <bristot@redhat.com>,
	"will@kernel.org" <will@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"jannh@google.com" <jannh@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Pandey, Sunil K" <sunil.k.pandey@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Message-ID: <0f7747d2-f2ee-4e3e-be70-231673365339@sirena.org.uk>
References: <ZVTvvJTOV777UGsP@arm.com>
 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
 <ZVXvptSmmJ6MQ0dY@arm.com>
 <1bd189e0-a7dd-422c-9766-ef1c9b0d3df8@sirena.org.uk>
 <ZVYfO/yqRtuRYaJA@arm.com>
 <54d3bc9c-9890-49f0-9e9d-78ea4d0d7199@sirena.org.uk>
 <9ce63f824b768f9635e55150815ee614fdee1d73.camel@intel.com>
 <eebf054b-7e0e-4732-8d8c-718073ec32ed@sirena.org.uk>
 <2f92f798a1807679d193fa19b217486f57398163.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oHaoulzZJbn3kFex"
Content-Disposition: inline
In-Reply-To: <2f92f798a1807679d193fa19b217486f57398163.camel@intel.com>
X-Cookie: <Manoj> I *like* the chicken


--oHaoulzZJbn3kFex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 17, 2023 at 05:43:26PM +0000, Edgecombe, Rick P wrote:

> Either of those seem fine to me, but it would be nice to get it vetted
> by the libc folks before committing. I'd maybe lean towards the one you
> suggested without the new flag.

I'll go with just taking the stack size as a parameter then, less
validation, hopefully the userspace people will be OK with that - I
agree it'd be best to get their buy in.

--oHaoulzZJbn3kFex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbhRkACgkQJNaLcl1U
h9Cdrwf+PmZcxRd9PuAOMhD/6WyXjzTrfyyd7VVQcWto1Pi1mU7ex1a6Z6PPdldx
ICSc5ltzExGle1le1oPaux2tfECZmEUwesny78lyH61HNVLzpbnIwYgxf5gqug9l
/vSYnX2H2VhdXPnpkBoDWi6u0efw2aBYZiKvFCtTh+KOTOYCAsgGGevgtX0f2yKv
qn9eYcl8tN9LAwSLf9wzCs3hLPo1AS4RcxZwfsUaqEonFBtdHPx5jAFqXKkF7lc0
uU3bhzZF5mtnggRUWxTeQ9vzAPe57SywrWklzQNVj1OgRR/vthYZagsDCoLr/MjS
yCc4JkHAq5fDXpziU7O62hNi5nofMg==
=V1wv
-----END PGP SIGNATURE-----

--oHaoulzZJbn3kFex--

