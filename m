Return-Path: <linux-kselftest+bounces-15545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E547954F8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF71A28358E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780571C0DD5;
	Fri, 16 Aug 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMOpXLB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA66F2F8;
	Fri, 16 Aug 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828023; cv=none; b=lUhxNjDq1YtkMd9/B1+3ZVZqJhTEOHu2OSgs2yTKnY/bdKVrp7SB3/mYP8rUHAKrMSLd0AeLkHib4OZKmURB3YcDAlaPLSLmJoSC9i0XVs0B0XLfO/emCNpE2Sa4w8q/M/jgykZ6GrUXCBgNAzml0YGmAXf4DJgruuPF29A/GD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828023; c=relaxed/simple;
	bh=cBPLEF3zCKTbQhJvwlculw6gNfUQGkEmwhR1JIaGaQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnUgjlu9ph2QVp/tPx4FuPE+DD+NxNQ09fCQQHAjkDZ3VpkmVG9FtCy1kJIgcPmU8gZpvHXN+tnnGyUJH7870fHm5FLLi01wRbVEtJKsAGf8mCwb94GjOyvqB1T6HkIE2SA/0RY36o91bjCCfqP9varwvle8NUwcnJryKo2JMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMOpXLB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26414C32782;
	Fri, 16 Aug 2024 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828022;
	bh=cBPLEF3zCKTbQhJvwlculw6gNfUQGkEmwhR1JIaGaQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMOpXLB1N7TB4TZLj/r07zoDqiI1fI7SglBcTgEOmmYQsOhRjdSZIZ9L1buvsz2d1
	 s6YmxlMpUSCuDO70uXrRzBXNI16eoN04Eec/IXXkrN8TX+/AER/YGIw1XI5lVUY12E
	 nl9RH7KLj2fqJQdJeO6XdmzPkboMgz4w/Zih5jk5uXYkLb+CvvCdTCqTcC42QXtBNS
	 ASwdbZEEoWvF4KCIobfWZTdomFilLghf79HjslM2yBxwNSvyB18LH/qs+eLh5HsMqf
	 qpR+7/EqzpX8gOvgtoC/r6O5ZptiZd4WGfUKjSRwwdBzIMLWPzRPQ+qO9gnNQXgqj+
	 roRSsoHx9dyfg==
Date: Fri, 16 Aug 2024 18:06:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
Message-ID: <e8d933e7-b7d9-40ce-99cf-9c9743224fb2@sirena.org.uk>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
 <Zr8RfoHZYRWem1K9@arm.com>
 <23a8838adda28b03b3db77e135934e2da0599d0f.camel@intel.com>
 <Zr9yiH6DP0IPac-H@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UIBvWWovVRRPNtvr"
Content-Disposition: inline
In-Reply-To: <Zr9yiH6DP0IPac-H@arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--UIBvWWovVRRPNtvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 04:38:48PM +0100, Catalin Marinas wrote:
> On Fri, Aug 16, 2024 at 02:52:28PM +0000, Edgecombe, Rick P wrote:

> > On the x86 side, we don't have a shadow stack access CMPXCHG. We will have to
> > GUP and do a normal CMPXCHG off of the direct map to handle it fully properly in
> > any case (CLONE_VM or not).

> I guess we could do the same here and for the arm64 gcs_consume_token().
> Basically get_user_page_vma_remote() gives us the page together with the
> vma that you mentioned needs checking. We can then do a cmpxchg directly
> on the page_address(). It's probably faster anyway than doing GUP twice.

There was some complication with get_user_page_vma_remote() while I was
working on an earlier version which meant I didn't use it, though with
adding checking of VMAs perhaps whatever it was isn't such an issue any
more.

--UIBvWWovVRRPNtvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/hy0ACgkQJNaLcl1U
h9DldAf8DS8Ejfxqga0UxFSoE4tm2vigdnhdHImkIWsPP3br0lXDTtzWQW+PCffU
ew6w0t4n53D0/iwgTUXznmNQ+dWTQe222Mp/mZZHZVT1bsKzQreV0AGljZ7UxP8v
z7w3/IjQPVz/xJtPErsDbBOKcSNUkgLDx22cQTn6kF0kRpG6z1Cf+A7TDXm3jyIT
iSIyGmIqi4/u/BBHKx2wKT5jm1o8nPEVw7ImZTkKDKVGh1yNCn9KKLkA6YEFluD8
fmHH9f6HlzMsJQTAUnWV8dgX2Xn3CNgidXnUH67O3duNL0GJUrAgQea0PD6m7azu
g1aisKemp+biqJTccPgu/7jarPOj5Q==
=b7S2
-----END PGP SIGNATURE-----

--UIBvWWovVRRPNtvr--

