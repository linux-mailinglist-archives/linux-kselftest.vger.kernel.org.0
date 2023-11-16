Return-Path: <linux-kselftest+bounces-226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634697EE47A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 16:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171D01F24952
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3481347D3;
	Thu, 16 Nov 2023 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEJAVynU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0430653;
	Thu, 16 Nov 2023 15:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66805C433C8;
	Thu, 16 Nov 2023 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700148967;
	bh=6C/AOQWdfUU4GssUzzyFj3g9QVT/w7qFRNOlqS3TXuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEJAVynUeohXm9vE0j4lxmkxs22+mduLhGWHLSixGxPbtfq3aMf+74bEl9cUNW077
	 wnP2Gf7K3RYrEiHWA2FS3RWdS1XDV3IseFhmxVL20I6GNcjWFVuce4U6XvbfFtCFQQ
	 B5oOlDaNQ9neSxDhV2NRByiOvZmGJL94L8mg/sw5gycFj6/dW0tgW3VhaIri/GHyEa
	 ufg9P7qJDr67mP8Mp5aR7Jrbnp1haOE/JQAzP5Y8ldcwE0NjF6NzCK9U+Gu3YCnJ+T
	 CmgnWtML24xN3hm6CWTQt1Sndds5hX61RuaixHI/0Fr3mFyaIhYwAmAu/X6hjDzsyG
	 GQxSgiHoQrhjA==
Date: Thu, 16 Nov 2023 15:35:57 +0000
From: Mark Brown <broonie@kernel.org>
To: "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
Message-ID: <54d3bc9c-9890-49f0-9e9d-78ea4d0d7199@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
 <ZVTvvJTOV777UGsP@arm.com>
 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
 <ZVXvptSmmJ6MQ0dY@arm.com>
 <1bd189e0-a7dd-422c-9766-ef1c9b0d3df8@sirena.org.uk>
 <ZVYfO/yqRtuRYaJA@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uQPPwN7Bpn582Rw8"
Content-Disposition: inline
In-Reply-To: <ZVYfO/yqRtuRYaJA@arm.com>
X-Cookie: micro:


--uQPPwN7Bpn582Rw8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2023 at 01:55:07PM +0000, Szabolcs.Nagy@arm.com wrote:
> The 11/16/2023 12:33, Mark Brown wrote:
> > On Thu, Nov 16, 2023 at 10:32:06AM +0000, Szabolcs.Nagy@arm.com wrote:

> > > i guess the tricky case is stack!=0 && shadow_stack_size==0:
> > > the user may want a new shadow stack with default size logic,
> > > or (with !CLONE_VM || CLONE_VFORK) wants to use the existing
> > > shadow stack from the parent.

> > If shadow_stack_size is 0 then we're into clone() behaviour and doing
> > the default/implicit handling which is to do exactly what the above
> > describes.

> to be clear does clone with flags==CLONE_VM|CLONE_VFORK always
> use the parent shadow stack independently of the stack argument?

!CLONE_VM rather than CLONE_VM but yes, that's what the clone() and
hence current clone3() behaviour is here.

> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

There are mechanisms for disabling this...

--uQPPwN7Bpn582Rw8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVWNtwACgkQJNaLcl1U
h9A8OAf+L47MiEGy1oAQUIl/rvLWqgZ8e3qktbrm7eRIk6aacjo+7k3qdr6L7EHh
EoHwrpV3QlU1LOlZUuorSIjpKhs1FbWxUZd1Ga9NIqOl9h58OAmTJPMyGKqj1O8V
SBPrXY79ObkfEOV2W9O9KzOlTAzHbbn2Jx2SwmetnkCeAaBeIm8tU9mU/mt45Xz3
cn7H9ZbgXHYl/NbV01v8nilfK/5r07B1iyghvD8Ojwbq2QC1gXrRd+a4jzfS8Sp0
23Nx/lWmpn6PPAGl6iAUjScyWBCuklVHxAwYq1ilPPIeN/AVQOuDJ5enoQuNJcUA
eCNt8qYz4y6MmEATAyUySV/IPaEGOg==
=JqPF
-----END PGP SIGNATURE-----

--uQPPwN7Bpn582Rw8--

