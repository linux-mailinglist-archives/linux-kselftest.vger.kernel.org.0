Return-Path: <linux-kselftest+bounces-15520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A3954DA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8758E1C20A5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCAA1BDAB3;
	Fri, 16 Aug 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjdbBVJp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F51BDAAD;
	Fri, 16 Aug 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822227; cv=none; b=MQ0XXUCWcnPLfZKSONBqCTo3KQwUBuzI+4hDy8BVjHYA5v8y0qoinmVedu/2DTad/BiQcRw0l8+aGGWHnPZ1KH4B5wQa87bDO6x5a1KP32UjvvoVe70d0slyJbDXUxaTWOdWZvSuj4yUqf2bQm6oIBW8gGxEv3qEtCA3Fpjq6MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822227; c=relaxed/simple;
	bh=LWGbzLpyETnBRqwphz7gxGjYuNlPh1cIsjf+lfSYjEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epfS/7rlSx5/k8Jw1S9dRKdLvKu7Vn1tykom6vxQs2SWaPASmD9DusdDKPTuovS4ixaEtUY15R+gQqXXtQDjot/bE7RC1pbqV36rXXkfdlTNRE2xFCaY9k1B3Xyg74vLC2kwXGJBbvu5u9Drueud8XXnc3GdKwNXyonjyOOpxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjdbBVJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AF3C4AF0F;
	Fri, 16 Aug 2024 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723822225;
	bh=LWGbzLpyETnBRqwphz7gxGjYuNlPh1cIsjf+lfSYjEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjdbBVJpufxzC+FFVxe2a+35ICRE2fu7ax6imUEtsMkaYK+gh3L3ih9BJMzQNW71u
	 bjzMmXAMyCGDNP/D9f36DAN1CoUJp6pTP7wRYpLs+9LusBkRmzq2CXcg6oyu4OcWDC
	 f/Qkm8O4XUiuMDg79rKXD+gz9EZwzBKhTITuYdJmfVAJPZawtnmHJaOP43zC1u8IqH
	 dcMXNj3ZWgIo75HTVcOuK7TIzBbesZmchl2pHj7lBixV2e+recR0mWCVbyUCdE2cYx
	 RzpN+wC6A4mruZQRnwD59yELRQ6l1+Tza27wITJwb9SEeDyWkJGAEyAtPHmQStsw5G
	 FII3EBwBxgNjw==
Date: Fri, 16 Aug 2024 16:30:15 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"jannh@google.com" <jannh@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Message-ID: <067b890c-b879-4188-b428-cfadcc524630@sirena.org.uk>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
 <Zr8RfoHZYRWem1K9@arm.com>
 <23a8838adda28b03b3db77e135934e2da0599d0f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XMbsgiyxkQfL09qn"
Content-Disposition: inline
In-Reply-To: <23a8838adda28b03b3db77e135934e2da0599d0f.camel@intel.com>
X-Cookie: A Smith & Wesson beats four aces.


--XMbsgiyxkQfL09qn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 02:52:28PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2024-08-16 at 09:44 +0100, Catalin Marinas wrote:

> > BTW, since it's the parent setting up the shadow stack in its own
> > address space before forking, I think at least the read can avoid
> > access_remote_vm() and we could do it earlier, even before the new
> > process is created.

> Hmm. Makes sense. It's a bit racy since the parent could consume that token from
> another thread, but it would be a race in any case.

So it sounds like we might be coming round to this?  I've got a new
version that verifies the VM_SHADOW_STACK good to go but if we're going
to switch back to consuming the token in the parent context I may as
well do that.  Like I said in the other mail I'd rather not flip flop
on this.

--XMbsgiyxkQfL09qn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/cIYACgkQJNaLcl1U
h9D34gf9GXMroaXQKpe5nlYm3IY9GNvM+l4jjBgwq9p03z6n9vk5v6eT+EWFhy+d
6j/OFxhUBG/XYaFCQjapAL0M6Xdbxc6P2JHLl6hebfit+VpOBFfbuXIVXZmEYJyR
nUW7i+hBh3L+HXK3p0nTVF34yhNmxSeyI1aC16Fw2gQkjHNhQXhQi3Rqf1coUJIe
F7m5dtzQzGgIdHy5S15aXkCkyt/KhX4V6HhTT/+NWBkJcbF++yrThjWEGD9WkVTR
J2oKEmR1Aa2tq8PZGxZbf7rI6XbpC1Su5ILbNlxP2UZa6lSUJG8C/73zSatR+z5x
LK+Ccl2jR6jI2dpiHMPvOzO9nvwkLQ==
=tCun
-----END PGP SIGNATURE-----

--XMbsgiyxkQfL09qn--

