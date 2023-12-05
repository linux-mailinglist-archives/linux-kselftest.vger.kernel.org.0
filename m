Return-Path: <linux-kselftest+bounces-1151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352F9805919
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6291C20FF9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB9D68EA7;
	Tue,  5 Dec 2023 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGyeU7Qv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90395F1EE;
	Tue,  5 Dec 2023 15:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF6DC433CA;
	Tue,  5 Dec 2023 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701791488;
	bh=cRtFwqVwGM/L5ElETR7/boeZZkQBM/dk1tSxRXa+SjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGyeU7QvMB9+MJb48ISbSvf4giVhpNA1dzt2x0ApFyux9D1hNyJs59V5235TZ2GG4
	 YmmscdTAvjHB2f/Dzabq6WldhzjojX/lu0bKk4lcksWKzdLuGoTrT7fvHU9LKRoqKD
	 S6fN3oMu6fGnXMPU4L/vZ6F9j9IuH35Qz5dhWGCkgVvbhBxiXlzpMFRGcGhkI0e2WY
	 ZE++rhJDKQDduO5iCBtpGGCA7cUvKwqeWnAIZbSrOqwWlHJRndZ6IL6Q7Lsq2ZPYiE
	 JTczBH9TsKFE66ZbfxdXRr6dqYK61eoQAS9hDwYl5X2RGRoSpJ3NNZMHrCdoArncrG
	 56cJ50OFSADtw==
Date: Tue, 5 Dec 2023 15:51:19 +0000
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
	"keescook@chromium.org" <keescook@chromium.org>,
	"jannh@google.com" <jannh@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v4 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ed665d6f-66b0-4eeb-8cf8-db852e017d6a@sirena.org.uk>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <20231128-clone3-shadow-stack-v4-2-8b28ffe4f676@kernel.org>
 <61f80d032c6a630dd641c9b598b37c2eb40d51e8.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ofW00QD6kVu0wbQR"
Content-Disposition: inline
In-Reply-To: <61f80d032c6a630dd641c9b598b37c2eb40d51e8.camel@intel.com>
X-Cookie: I've Been Moved!


--ofW00QD6kVu0wbQR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 12:26:57AM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-11-28 at 18:22 +0000, Mark Brown wrote:

> > -=A0=A0=A0=A0=A0=A0=A0size =3D adjust_shstk_size(stack_size);
> > +=A0=A0=A0=A0=A0=A0=A0size =3D adjust_shstk_size(size);
> > =A0=A0=A0=A0=A0=A0=A0=A0addr =3D alloc_shstk(0, size, 0, false);

> Hmm. I didn't test this, but in the copy_process(), copy_mm() happens
> before this point. So the shadow stack would get mapped in current's MM
> (i.e. the parent). So in the !CLONE_VM case with shadow_stack_size!=3D0
> the SSP in the child will be updated to an area that is not mapped in
> the child. I think we need to pass tsk->mm into alloc_shstk(). But such
> an exotic clone usage does give me pause, regarding whether all of this
> is premature.

Hrm, right.  And we then can't use do_mmap() either.  I'd be somewhat
tempted to disallow that specific case for now rather than deal with it
though that's not really in the spirit of just always following what the
user asked for.

--ofW00QD6kVu0wbQR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvRvYACgkQJNaLcl1U
h9DXGQf6AvheyqUPcMw3T4JTt1lwn5bDs4oC7fZ63uO+BX16gGSEx73amHIyNaGv
p+FtTHrVU1xQTu+Bh5L5QjW68t6061HLlHW0E+RoX9HlyW4v6GsBwzHxAYfp1eNw
zce0c49OZQlgDA42/CH/PbejjX8H1a3jlwW+zIxwHNDqWs8pe+pEaZ/jEhLLUQ1W
vJGRdn/PtZRKo7APLWn3uTOUGUbI9hXU/XQvJwKEo3DvNbYkezmTGe8ExIBkWQV3
5oecmztnkjUiARHVRvyxW3vjbljlNxG4ECGlrpchrZgpeanmraDINzcWNnwYIBHE
lP5fF9Y4DIiSj/DAO0BKEO0x5wgfCw==
=1erK
-----END PGP SIGNATURE-----

--ofW00QD6kVu0wbQR--

