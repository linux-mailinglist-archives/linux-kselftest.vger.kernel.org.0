Return-Path: <linux-kselftest+bounces-15532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C5A954E1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83441283DB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1FF1BD4F9;
	Fri, 16 Aug 2024 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHDI3Iow"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D44174C;
	Fri, 16 Aug 2024 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823213; cv=none; b=AX7bbk3a+MaR5ZdPlpUSNVwZe1jAlhUU0QNVwnQZRsjAOT3l2gpLO0QJeyhgv4phSmQqJkubx2Y6Ky+LZP7KKfP9hiRkvu7fIRuvouBsYTRRbJfDtCJzrAvrEBpANdOljek1LT6ung6ctIHe9dATVj0/aADqlm+/5Sf8J9HQpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823213; c=relaxed/simple;
	bh=khe3LAqRTBXkg/xOZDsIuZ3z2/5LuF9nx82ZOACmpy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD7y4q3+WFxXBaPjaGgxgXWQr3RLaSjX9qNUylB362cfHCHT5v8aIJOeC+I/eCeHCgLMv1/6vxVZwwoEPlslpvgVdgZBx2kG6rt8l7WK0JIDrKR9d/pTjYuEdwtSCYq8rbAtV18TXilG1bJMES3RfAfPoPW5NsRP2n5NUA+ETEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHDI3Iow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC49BC32782;
	Fri, 16 Aug 2024 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723823213;
	bh=khe3LAqRTBXkg/xOZDsIuZ3z2/5LuF9nx82ZOACmpy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHDI3Iow44IDjO76bnHlQj4gB9eHSqo2o41C5hMg/wlSpDeGTirJx+whKITWh3EQ4
	 HqfHlJum8w+fSPmRpCFTwYhYaswEBa8Pb7qahZnxN4lg41jgyqZsMz8koMvnnqt+HT
	 3YhDv6TvdRpYcoMs+D+5ghBbqsJtR5yrgQ1SqJy13r+YfleK0LeQffSDnyQueA5BY3
	 5eHBliqR78jNoDsBXEOx8q/cx8rmdg/9e9nRLW4v8OCP/6esfn9CbjOrRMMvNo0tV+
	 2RFy9GPuemQYuFrMRVvSNDUx1aEV1Ft6Sqp+7rs1aWEfx3VqvkyUSRw71dfuIlD8q6
	 qd9xCp25RM/OA==
Date: Fri, 16 Aug 2024 16:46:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
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
	"jannh@google.com" <jannh@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Message-ID: <fc40c53d-341f-4e2f-b9a4-49f380a1e926@sirena.org.uk>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
 <Zr8RfoHZYRWem1K9@arm.com>
 <c644d64b-f7d0-47de-b5ba-ae2ac1b46e1b@sirena.org.uk>
 <Zr9wSa2Yyq-MCWVq@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tz22ON7LlS6KlPwD"
Content-Disposition: inline
In-Reply-To: <Zr9wSa2Yyq-MCWVq@arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--tz22ON7LlS6KlPwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 04:29:13PM +0100, Catalin Marinas wrote:
> On Fri, Aug 16, 2024 at 11:51:57AM +0100, Mark Brown wrote:

> > I change back to parsing the token in the parent but I don't want to end
> > up in a cycle of bouncing between the two implementations depending on
> > who's reviewed the most recent version.

> You and others spent a lot more time looking at shadow stacks than me.
> I'm not necessarily asking to change stuff but rather understand the
> choices made.

I'm a little ambivalent on this - on the one hand accessing the child's
memory is not a thing of great beauty but on the other hand it does
make the !CLONE_VM case more solid.  My general instinct is that the
ugliness is less of an issue than the "oh, there's a gap there" stuff
with the !CLONE_VM case since it's more "why are we doing that?" than
"we missed this".

--tz22ON7LlS6KlPwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/dGQACgkQJNaLcl1U
h9Aidgf/bvyrKKGDFaxkcgk4tQYzc9Q70ntcTlMGCpLmtx7dyWyNgZza79PgnzWl
D3bweg9N16BogBXR4u9v4pRqgLUVEIQTjfL++FxnTz5F1qWUj9S29rL66Q8SE5wa
asTPjSkzUAsFfd2C8EPrbTe6CSJ3ormhklEZgC54A3WNmKqnCUHveR/yDO8gUNM/
L73E3URlVVDkvlw5ovx2pQUpGsc0Q/MbNDol0i6+LYoYkUjFMSYnIzuobGQFoJcN
rK2BpTWtAivljJkx5cF/CcGSWAOd+r2wB6olBwTccLRJKjiBmwMyREMn9u8zn9aL
x9tmqHnB6652+Jt6ODV2DMjyffA4HQ==
=w3LP
-----END PGP SIGNATURE-----

--tz22ON7LlS6KlPwD--

