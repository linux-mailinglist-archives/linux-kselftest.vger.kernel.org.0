Return-Path: <linux-kselftest+bounces-15549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D279954FDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393AD28762D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0DE1BE22D;
	Fri, 16 Aug 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwDWNcbf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A252F62;
	Fri, 16 Aug 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828646; cv=none; b=YZrgl4uL8lQXP8NaQ3M1s6HhNK664fox/cNHhfqajhItJ9fZbXNtlHgf8MsGEyJWKFi4X2fU8NhRXM3iyAD3ujK8KUL4zVoOKwbLhlzP+fR+A1efguHNCNJf6OvyRWOUEjU96Mc0NUbljRprQvRGJ5Ftv1oKHoYL98Mehd3EiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828646; c=relaxed/simple;
	bh=f6rhxUbGkna0A4tQqq0M7QOGZpze5pUfC7gMEiQv5pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu/uwDqigOrEBe4Mqu1UYQ277hnhaKY4oS5Nyss3NqPKiBsDDcRUHUYHeCJYR1xOMUaXn4gALYOhu/ZkedBHjdz1IGJAl+ywVo6o+9Gcz7Kga3v5AM4/FwdjPKBQDGC6f71fvuGzoolCAgkM3yWwzUslWOcn6L80ndH4A2VBkas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwDWNcbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBDAC32782;
	Fri, 16 Aug 2024 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828646;
	bh=f6rhxUbGkna0A4tQqq0M7QOGZpze5pUfC7gMEiQv5pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwDWNcbf0WhAKB/1Sey3fhK9Unh+hORFNV6xSrJclhBN39jfXtwlpUdDFMILdEbJ9
	 6pUrndOsuQlFY6IcBdl7UkprPWLQSNqihWoQuG4evj2PVlSIsbKCgprxzCOfBqUJQO
	 ee0ahc8v+PiWiEU0DoAxqlVU4/SI7wgV9m939/e7Jw7lCSKuRTFRlWWCGB1gxvjEV7
	 2gSQwADXIxo/p+KilC+oao8i8PIY7G8QduXJtBl+IhgJ7bXIzuuzA6JKsQWEsovKbq
	 E90tx0qpazFUzgnZUtxpuqIDz4wRUXD3FQFACkuuQTurgFtEsGIx1q1E0a1dOPPzeu
	 6+A9oRcRFZDzQ==
Date: Fri, 16 Aug 2024 18:17:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
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
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Message-ID: <830e96b4-8e35-4b80-a32f-1b500febaee5@sirena.org.uk>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
 <CAG48ez2z5bRdKNddG+kEGz9A_m=66r38OHjyg6CapFTcjT9aRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I/XN2wQCb9TUbBWS"
Content-Disposition: inline
In-Reply-To: <CAG48ez2z5bRdKNddG+kEGz9A_m=66r38OHjyg6CapFTcjT9aRg@mail.gmail.com>
X-Cookie: A Smith & Wesson beats four aces.


--I/XN2wQCb9TUbBWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 07:08:09PM +0200, Jann Horn wrote:

> Yeah, having a FOLL_FORCE write in clone3 would be a weakness for
> userspace CFI and probably make it possible to violate mseal()
> restrictions that are supposed to enforce that address space regions
> are read-only.

Note that this will only happen for shadow stack pages (with the new
version) and only for a valid token at the specific address.  mseal()ing
a shadow stack to be read only is hopefully not going to go terribly
well for userspace.

> Though, did anyone in the thread yet suggest that you could do this
> before the child process has fully materialized but after the child MM
> has been set up? Somewhere in copy_process() between copy_mm() and the
> "/* No more failure paths after this point. */" comment?

Yes, I'e got a version that does that waiting to go pending some
discussion on if we even do the check for the token in the child mm.

--I/XN2wQCb9TUbBWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/iZwACgkQJNaLcl1U
h9Ak9Qf9HJIADvs9ieo6Jr3RV46KHtcZIzFxA9BCkPw8LpBAJ59KlPIeeT0xaxEj
sDNNXkqoaBWXl0DS6WIl+5XhvpfINtoiXEo5C+/iqZLaRsIrEfWCmS8zz8H9serN
md71fk+NTzJs33AlSZ/IN/lO4uxLvgPHKXtiTaWLw+Wml1Ft2KPAzcRG39L2tJdx
P9Gz/XwzpxLkFalXTL46VOvsDwBHXIgbIVaehb160+HjfAFA9Rf9fI1Geq4Rb3BT
mB3iCoXjExtw6e5pJqSqb5NzdT8yfDsGkApTnFYulyBpofGGvpGkZH0wOir5+FqE
LeAqMTG3sOCju9kxOu/8UEs3LSE6gA==
=GX/V
-----END PGP SIGNATURE-----

--I/XN2wQCb9TUbBWS--

