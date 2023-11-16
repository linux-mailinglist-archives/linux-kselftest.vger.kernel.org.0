Return-Path: <linux-kselftest+bounces-231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A737E7EE6E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 19:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDAB28107E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 18:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1A817C9;
	Thu, 16 Nov 2023 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pma9qkeR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2163A4;
	Thu, 16 Nov 2023 18:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869CDC433C7;
	Thu, 16 Nov 2023 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700160077;
	bh=axDloRwFo8G9keDVvfti1AbZSDYwXXFVtTtUR/GsIhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pma9qkeRVPQcWRu3uBsdtKvpuVIgNSNViUMZuUAsPzW0fPCAwJupH64Rorn1lXigY
	 oaSevdGsXzgdUA358FZmo3L3HdiGxwBi4lzyktHO6ps8ysOMJduDj1QhTP5VAYpkUk
	 r4jpy7BB/GULp/bmBvJ/VYwJK9ImBUMhB/XaYQCa7gHHQ+wT9qvjCrG0pqpBcrjdH8
	 kA2/xCGko6HFcbNsf1vbFrliwyVvLF9DQ+lKv+ukKtXX2dKDbOOibJN2URvD1vF6o3
	 WTWoD98qttsiSQhb09vJTJvaiFrjRcq+wSM/iKMaTgDRshlU5vr22WTT9su8wzPKcj
	 RueF5t/2ZQovg==
Date: Thu, 16 Nov 2023 18:41:08 +0000
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
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
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
Message-ID: <eebf054b-7e0e-4732-8d8c-718073ec32ed@sirena.org.uk>
References: <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
 <ZVTvvJTOV777UGsP@arm.com>
 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
 <ZVXvptSmmJ6MQ0dY@arm.com>
 <1bd189e0-a7dd-422c-9766-ef1c9b0d3df8@sirena.org.uk>
 <ZVYfO/yqRtuRYaJA@arm.com>
 <54d3bc9c-9890-49f0-9e9d-78ea4d0d7199@sirena.org.uk>
 <9ce63f824b768f9635e55150815ee614fdee1d73.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6jnoQqzq7uwk9KbQ"
Content-Disposition: inline
In-Reply-To: <9ce63f824b768f9635e55150815ee614fdee1d73.camel@intel.com>
X-Cookie: micro:


--6jnoQqzq7uwk9KbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2023 at 06:11:17PM +0000, Edgecombe, Rick P wrote:

> Now that I've thought about it more, removing the CLONE_VFORK part of
> the logic has several downsides. It is a little extra work to create
> and unmap a shadow stack for an operation that is supposed to be this
> limited fast thing.

It does rather feel like it's defeating the point of the thing.

> It also will change the SSP(let me know if anyone has a general term we
> can use) for the child. So if you have like:

SSP seems fine, we're already using shadow stack here.

> What about a CLONE_NEW_SHSTK for clone3 that forces a new shadow stack?
> So keep the existing logic, but the new flag can override the logic for
> !CLONE_VM and CLONE_VFORK if the caller wants. The behavior of
> shadow_stack_size is then simple. 0 means use default size, !0 means
> use the passed size. No need to overload and tie up args->stack.

That does seem like it cuts through the ambiguous cases.  If we go for
that it feels like we should require the flag when specifying a size,
just to be sure that everything is clear.  Though having said that we
could just always allocate a shadow stack if a size is specified
regardless of the flags, requiring people who want non-default behaviour
to have some idea what stack size they want.  I don't think I have
strong opinons between having the new flag or always allocating a stack
if a size is specified.

--6jnoQqzq7uwk9KbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVWYkMACgkQJNaLcl1U
h9AnPQf+OrS9UnpK/M86Qe+eZ528KWBeQ9RRfz6xqRg0c/kGK8aPqBjZTcIlGNKo
d+yKeTyTrlEaJLLd7jod/7KrOJjsYSDVokQXwODuLjTZYQJpPzJaHqXs/7gTrCHl
bi7ce8CTK1y0SBanxfqk+uhy+26/tXCuF6DEytoY4dTwOn88k+L2ol0D17BeqHmm
7jLLDyvzl8FSLnksehEldYXRveieFSWJB2zODhPtQvRwbzsymNPkEXN+oVvCxiTh
kIFOodspI8EmbIDryfo9U0xzfbaYTgg+2tB9C36LVNTg6idLgi6eeAB0nFk7+6x6
kVKeD4/4OM8Gtp9VErF0qo5dP468EQ==
=Iru+
-----END PGP SIGNATURE-----

--6jnoQqzq7uwk9KbQ--

