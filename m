Return-Path: <linux-kselftest+bounces-14890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D434949B40
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 00:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7B2B21BCF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779417166E;
	Tue,  6 Aug 2024 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncaGq7La"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D9416FF48;
	Tue,  6 Aug 2024 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982890; cv=none; b=rk4eJUsvKSysvBcUI0darlfc6RT4C9QwEb4KtH8uUdnZKs/wijWvRKoNjAVSyDi7Zg8G201LWBw3SH4PUXxS9g3U6SsdcjxfNXT56zchwza49uf9mMidDmA+nWpF2vxd+B9gsNDsX56Os/27j4MAOM8GWK08rJU4X2G5Fr8scwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982890; c=relaxed/simple;
	bh=RQ8MC8iPA0tNeesOUUgHscf++izWxTr6/vNoYk9HBZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ+iRbgDqAIZmfMHgxeo6BQHeKFmSyZ2phGKToD5pAeIm0jaUFT3M4ddofxs5sG5EvJ1ePGbZrkKJrNReRHI0nR7ibFnWIP1Q59pwVjRs0jQ+ApiFRr5RSDW0hC16Y91ajHRZVPLRcfQiCERojnPBJzIbWMnR2ScOpuqn4etEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncaGq7La; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2352BC32786;
	Tue,  6 Aug 2024 22:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722982889;
	bh=RQ8MC8iPA0tNeesOUUgHscf++izWxTr6/vNoYk9HBZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncaGq7LavzoWZLa23nGybegw6iarvuorZG4YPO1pnFEiV/7z76WsrLX0J2qmYt+sY
	 meGJBaVcUkmnqWBGUT6SR+NmS7bX9RQJHvA0KpC94rt54xenhrG6TsEX/qSC2rSCiD
	 x25sOnaWiaQyHyMwADXFD3i2KnjTg943/ZTybpIr1asQrVxCXKHBDDdlprvtPVSfkO
	 LtlwQcdI0LlJQ7wcsrwvdSic+559Nj+79qEU/IBRdiARjMdTEKqykJWngCl1ofKdQu
	 SYO7gs7dONR1izbb5MnvEJM7+/2d+cxeCpPY4eqoA0RMbSnHQ9BEaQxd4w+CucAAqr
	 /zzLNoMqEH9iw==
Date: Tue, 6 Aug 2024 23:21:20 +0100
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
Message-ID: <43aa4846-1cb9-4130-80ed-12ec8219ddc0@sirena.org.uk>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
 <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>
 <202408052046.00BC7CBC@keescook>
 <b172c2c1-42d3-4c50-8065-9bd4ae21ffea@sirena.org.uk>
 <202408061434.1B746423@keescook>
 <18c16157-f75b-4054-af80-d0fe696d7370@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JWBtAVA7O6BDu6KR"
Content-Disposition: inline
In-Reply-To: <18c16157-f75b-4054-af80-d0fe696d7370@sirena.org.uk>
X-Cookie: One picture is worth 128K words.


--JWBtAVA7O6BDu6KR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2024 at 10:57:39PM +0100, Mark Brown wrote:
> On Tue, Aug 06, 2024 at 02:43:22PM -0700, Kees Cook wrote:

> > "Shadow stack with no token" still crashes the parent. It seems to
> > crash in waitpid(). Under gdb it hangs instead, showing it's in glibc's
> > __GI___wait4(). Ah, it's crashing at c3 (ret), so shadow stack problem,
> > I imagine.

> Yes, likely.  They are delivered as a SEGV with SEGV_CPERR.

> > Does waitpid() need to be open-coded like the clone3() call too?

> I wouldn't have expected so, it should just be a function call and
> definitely didn't do anything funky on arm64.  It seems more likely that
> we've managed to corrupt the stack or shadow stack - most likely the new
> thread is still using the original shadow stack rather than the new one
> and so corrupts it.  Again not immediately seeing where.  I'll have
> another look tomorrow if nobody has any bright ideas before then...

...or possibly we're delivering the signal that's generated when we fail
to validate the child's shadow stack token to the parent rather than the
child.  That logic (in shstk_post_fork()) should be shared with arm64
though so it ought to have been failing for me too.  Failure to validate
the token should look to the parent like the child immediately taking a
shadow stack fault.

--JWBtAVA7O6BDu6KR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmayoeAACgkQJNaLcl1U
h9BJlQf/WJYI/GSYFcIxEQa/58OVpxams4xQPos458IkQrcNlBzhAcZSE6THLDbW
ZV+aVtBRivo4yCZlRYgAbS8EVipaTnpaKeV6ipfDBf+x1Qr0O0FYxBFoBVPDSjM9
GUYKrIZkbhDkWxaj0KjtW0nSivQvCFaNCae2jSIZbDk3P2Nhb9mRwnM4aGI7WUiW
KlL75Lqi9U51RMO1TgeyQSuZkG0+rKTav8d8GnCx6cONC6rstEk+ncgF655szq+d
i5EWZ5jQMLQ4DXKNyFD6M2+rIxZjrzG8IXyADJfGKduXYc149mP3pNVA6fHS3uLS
tvsDkPkWRi2ZkbeDs0nbdGi1QCXnJA==
=LiK1
-----END PGP SIGNATURE-----

--JWBtAVA7O6BDu6KR--

