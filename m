Return-Path: <linux-kselftest+bounces-40853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7011DB45CC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5267B1C838BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB52302142;
	Fri,  5 Sep 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4sp4gpf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A062FB0B2;
	Fri,  5 Sep 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087012; cv=none; b=KmYsfLa0m6JnuG2YjV2BX2IzGu2PGJS9l6WZhy/YhvqblI2glBtghyS7wNBsl+GiW+fckotgLFzDYGE6LUK+QdwbAzpRoiTvbJ6kpR81lUyW0CX0CgMLwMwNbMXrDdSkDa6YmZF90s9JrsvJ2hT6p6GiuP+9uWaa42Cf9LElqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087012; c=relaxed/simple;
	bh=4kRUO/9jXo8X9s/nzE/lUlckvZsyrWBNGB44GH9GDQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVo34Pf2NnsL81fSCn3mYvH2QDK48uZ7csggQhjY9LjwnaXU9wCS266UHbSxgaubbdciBcdHgm5+Lkozh0JsD3pHzMuY2sTlGxD8yRx7UxI6OruLVft0SVC9GhlmPigTUkddk6reodgKUVxmP/E3qZ7I4uBESSSjtfLtSxCtq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4sp4gpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D989C4CEF1;
	Fri,  5 Sep 2025 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757087011;
	bh=4kRUO/9jXo8X9s/nzE/lUlckvZsyrWBNGB44GH9GDQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4sp4gpfU2PExUYTCIwD5e3+oChKnpLSLcTrkQQpldrDPO54uE0/IBizlbPLVR25M
	 iPWUIDyIx4j57STdvwliY0Nqhb/5ffB+Wb2QJ639ogUNLzJhlFDDx4yiiEaclbgDxw
	 794Cjqjt9pMs2wTCOGFwm7RnDnWRHkbsM7q0q4KZ3JDpIHUoLftx9qfhA14NHHsiLq
	 yOdhYbG/InrcZt+filmTbsWyZyDAzGVYirfxL5Iu+xMBkKBxYIqxJo7Ko8EemOG5HW
	 jWs8gresg4IQfxfMDo94hMo/sDoqsHSxF2gH5N0rp42euvwPytkn4WCLIU5w6sqfRC
	 oCR8/MhB3L0/Q==
Date: Fri, 5 Sep 2025 16:43:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
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
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v20 4/8] fork: Add shadow stack support to clone3()
Message-ID: <0ff8b70e-283f-4d56-8bab-bcae11cd5bdb@sirena.org.uk>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
 <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>
 <20250905-nutria-befund-2f3e92003734@brauner>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H+cLuqqTYYiGS0aY"
Content-Disposition: inline
In-Reply-To: <20250905-nutria-befund-2f3e92003734@brauner>
X-Cookie: He who laughs, lasts.


--H+cLuqqTYYiGS0aY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2025 at 05:21:59PM +0200, Christian Brauner wrote:
> On Tue, Sep 02, 2025 at 11:21:48AM +0100, Mark Brown wrote:

> > +		.shadow_stack_token	= args.shadow_stack_token,

> I'm not sure why this has to be named "shadow_stack_token" I think
> that's just confusing and we should just call it "shadow_stack" and be
> done with it. It's also a bit long of a field name imho.

I'm not hugely attached to the name, if you want to rename that's
perfectly fine by me.  My thinking was that there's a potential
confusion with it being a pointer to the base of the shadow stack by
comparison with the existing "stack" but I do agree that the resulting
name is quite long and if someone does actually get confused they should
discover the problem fairly rapidly in testing.  ss_token would shorter
but the abbreviation is less clear, whatever name you prefer is fine by
me.

> I have a kernel-6.18.clone3 branch
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=kernel-6.18.clone3
> because there's another cross-arch cleanup that cleans up copy_thread(),
> copy_sighand(), and copy_process() and - surprisingly - also adds
> clone3() support for nios2...

> Anyway, if you just want me to slap it on top of that branch then I can
> simply rename while applying so no need to resend in that case.

That would be amazing, I'm totally happy with you doing that.  If I do
need to rebase and resend let me know.

It's probably worth mentioning that the RISC-V shadow stack support was
getting near to being merged, if that ends up being OK for this release
(it's not been posted yet though) there might be some cross tree merge
needed or something.

--H+cLuqqTYYiGS0aY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi7BRoACgkQJNaLcl1U
h9DGtQgAhZoW07nRePXYFKl87wwVwrLw08jemTnqtO8iIwqJMDNZEtFsM5vbI2FW
lKJ10vTz+GBynt/YFq15g3Pn8G8KpqbZH1cV1bCNCdGlBhnvJ5YwHHkV0iPyMIEF
iux5PzpYcf8755igN1mvHtyML4T70gHywSjqrxyPDHz4nghBgG+CL/se/cINsvH5
/WKmPvi9PFxa+oVCJoaveyqV8ZmwkhXq+80bUTUJkERlvAA1kusK6eyxbdyJfhp9
0kLEXnMFRaGbzlO5tRp//EZNVIoYDPQI929EQoISPYLlyZv8iwpqS2u8abSjdChm
+kkS+dg4X5lNLaH7OmnLyyI2YycU3A==
=LTFu
-----END PGP SIGNATURE-----

--H+cLuqqTYYiGS0aY--

