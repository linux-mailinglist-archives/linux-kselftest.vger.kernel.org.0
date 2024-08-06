Return-Path: <linux-kselftest+bounces-14889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC07949A94
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 23:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3081C220B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BC916F831;
	Tue,  6 Aug 2024 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy1CVpcL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8EE15EFA3;
	Tue,  6 Aug 2024 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981459; cv=none; b=i2ZGEDKSofYOYX/aJDtFiE4l9+79epYK7QKn4Eg9xG+HXEzO4EwqOeAAYxqQu8w+VtTr/JutpnJ2oZXdhM9AYfAy+lMHP8m71OUKU0FdoYuJL6wVxIi+ph/udj5sOXqV4p8K2c3tj7UlRmy+U8GC62a7fVdTGQFk7TpjA5kRWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981459; c=relaxed/simple;
	bh=84nFEi3lPc5MtIUXvtDAKc58M8EwB0jW2aEDiBALJW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXw4U1YVqQu7KlwZ0zAcSWVRmLkhg8VrSotAscwV+TbKwquxtUy6e1a51f9+EPCE/Y2sD+FFxQu0bnq8k+G4zxXUcZXKiuXLP3xGX/KB5BDGyA0FtoQ0tWMu4XNDZBp/sruKvND+njlknfMKBUWsQyVBqyWNro7952Hfu8R60Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy1CVpcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8055C32786;
	Tue,  6 Aug 2024 21:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722981459;
	bh=84nFEi3lPc5MtIUXvtDAKc58M8EwB0jW2aEDiBALJW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hy1CVpcLOjP9pAX4Rzl9wXim1Un1wmVYZ1A8I/tfA4QajFctZhlt14RVxdFC7GKTI
	 oSBtuDkrYBKRVyR0QOa+5IlKEGZ/kUg4oN8GL/siyqHNBhWotmdrUldV7cvMjyBm+X
	 qX+oVRugflPYe6tz0gyY54AmImIBGEnpwXrjZePIUbfbCsQOclCv7UPz984rUIJ0NR
	 6Xzv9lhnLTwKpgOhmqO3CEXQbVkmAnMis/dq1KOgJlOXhBMonH1d5n+rKt57SH4nKR
	 owjdEhAXg1Ksd+L2lj/EF2hf6DxbHj5BvzwmHHQ/XgYdhcU2iBNVus47xeI7+6Azc/
	 VpS7xNqB6Iiqw==
Date: Tue, 6 Aug 2024 22:57:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v7 9/9] selftests/clone3: Test shadow stack support
Message-ID: <18c16157-f75b-4054-af80-d0fe696d7370@sirena.org.uk>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
 <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>
 <202408052046.00BC7CBC@keescook>
 <b172c2c1-42d3-4c50-8065-9bd4ae21ffea@sirena.org.uk>
 <202408061434.1B746423@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NIL+RWQAsqNaoQw8"
Content-Disposition: inline
In-Reply-To: <202408061434.1B746423@keescook>
X-Cookie: One picture is worth 128K words.


--NIL+RWQAsqNaoQw8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2024 at 02:43:22PM -0700, Kees Cook wrote:
> On Tue, Aug 06, 2024 at 09:10:28PM +0100, Mark Brown wrote:

> > Does this help:

> > diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> > index 1755fa21e6fb..27acbdf44c5f 100644
> > --- a/arch/x86/kernel/shstk.c
> > +++ b/arch/x86/kernel/shstk.c
> > @@ -198,13 +198,14 @@ int arch_shstk_post_fork(struct task_struct *t, struct kernel_clone_args *args)
> >  	 * the token 64-bit.
> >  	 */
> >  	struct mm_struct *mm;
> > -	unsigned long addr;
> > +	unsigned long addr, ssp;

> Yes indeed! This passes now.

Ah, great - thanks!

> "Shadow stack with no token" still crashes the parent. It seems to
> crash in waitpid(). Under gdb it hangs instead, showing it's in glibc's
> __GI___wait4(). Ah, it's crashing at c3 (ret), so shadow stack problem,
> I imagine.

Yes, likely.  They are delivered as a SEGV with SEGV_CPERR.

> Does waitpid() need to be open-coded like the clone3() call too?

I wouldn't have expected so, it should just be a function call and
definitely didn't do anything funky on arm64.  It seems more likely that
we've managed to corrupt the stack or shadow stack - most likely the new
thread is still using the original shadow stack rather than the new one
and so corrupts it.  Again not immediately seeing where.  I'll have
another look tomorrow if nobody has any bright ideas before then...

--NIL+RWQAsqNaoQw8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaynEkACgkQJNaLcl1U
h9Cy+gf+LU5NjrTScUyyiJIODUpW/v7Apv1f6RaV/m1ggpX3HMfNB9zB0ogLNcsh
PVUJYEmjd6pV5sJPIRYMyjRsW01QCh2EO2Q0wAYFdq9+7oEsSFzJrEkQkbB7NGXf
9USwXJHvjnSjI+N/Dp54Ji4E2RY25cJ9A8pLM6p7wzTudNZDvjhlnKorX9YbGxNQ
lKVyi9Z1tkTIEW7QQSJiBSi1PsPwkdTpuXibrf2sAZ+PrFhcuFQVdDLsI82bFjGw
tLIRZSjJwMZAOfRUBSfymvJsYp7NXzOPefBCIL4vxmz6a2HkL6IdAuD2nYvFA1A/
vUAnzgotryebFAiVS/K3F4o6QSV1PQ==
=ER/S
-----END PGP SIGNATURE-----

--NIL+RWQAsqNaoQw8--

