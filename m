Return-Path: <linux-kselftest+bounces-19178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FDB99377D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 21:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60B3B2298A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 19:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496D1DE3A2;
	Mon,  7 Oct 2024 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHKuWIrt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95411D131B;
	Mon,  7 Oct 2024 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329847; cv=none; b=BXtR7Fpwlidjp24ggrE+NIuwoJ9hSYgKagxIoQmF8fb05fy4Sd2euBPv5EiUSPaiMeQFVET91rEDkw1aZzMZCujoo7J45dafh/twjVffGbt1KnbNQBfl6VK7vo4yyVbL8Q6S4sxLKbhL5iGdKY+RlmuwCh1ktl/acIWXuh/3ksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329847; c=relaxed/simple;
	bh=A9OyLPY9DW1/5r91rpnNC1afVdx3Cj+2xoi5YvvORmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blePe0JK+ldsN8PC+7rI5jvw5rp35oRWTQX26rItJS6voW52+2XePyA3GCejuhYzNw37bdv6e0p5gS2/QvLHF096MoOwA2T3LvOzV44W3naXQNLbet4+k+bxz/TBX+6yvC+/U3ShEMn3hLmeN7CQ6iYQvWhfSQt3rTf14duVE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHKuWIrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FA7C4CEC7;
	Mon,  7 Oct 2024 19:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728329846;
	bh=A9OyLPY9DW1/5r91rpnNC1afVdx3Cj+2xoi5YvvORmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHKuWIrtowbQC268R9KcD0OMgpg3cYrxT/I04IKLrYqWAYFIM9ZIwTKyvMrP2uvrZ
	 YH3EKYt0P/gky8Am8KlzevtFQ5zumLRqbzKWDMwXvE7ATGesnHEk0Po9+0CQG9qO/o
	 NTYvZmWNKfx7wZvGKtTK3D0Qm2PuoIfmfr1Q/NamQ1rrcxN+pot1JF3mrsPlVlxEWU
	 pfCROnB5pYyzBxZkkwyGDUQxU6FDR080EBi4pGqofS9tTSTaKFphR2r1SIZjQzpylX
	 9S9M3qxe32Jc/CLHGVoy1dljHTRA8SDb+jlfPJY2v2fzLLuyCs9MbTTwHIx4kYntYv
	 dXj7oJzXfPyGQ==
Date: Mon, 7 Oct 2024 20:37:21 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] selftests: sched_ext: Add sched_ext as proper
 selftest target
Message-ID: <ZwQ4cTh85xuPuxnx@finisterre.sirena.org.uk>
References: <20241007073133.989166-1-bjorn@kernel.org>
 <ZwQBqlG6MShCkNrU@finisterre.sirena.org.uk>
 <87r08rnbra.fsf@all.your.base.are.belong.to.us>
 <ZwQKRe7iIzZjjEQd@finisterre.sirena.org.uk>
 <87msjfn9oz.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cswsmIXpifTmYM4u"
Content-Disposition: inline
In-Reply-To: <87msjfn9oz.fsf@all.your.base.are.belong.to.us>
X-Cookie: Editing is a rewording activity.


--cswsmIXpifTmYM4u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 06:45:32PM +0200, Bj=F6rn T=F6pel wrote:
> Mark Brown <broonie@kernel.org> writes:

> > I didn't actually build a kernel, if the build system needs a kernel
> > it's just silently not detected that it's missing?

> It tries to find a kernel with BTF:
>   | VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                       =
             \
>   |                      $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux) =
           \
>   |                      ../../../../vmlinux                             =
           \
>   |                      /sys/kernel/btf/vmlinux                         =
           \
>   |                      /boot/vmlinux-$(shell uname -r)

> Similar to all the other selftests using BPF.

> (Oh, and at some point the BPF parts should be in lib.mk...)

Ah, that'll have found my host kernel.  There should probably be some
sort of check that it's at least targeting the correct architecture
since this *will* go wrong.

--cswsmIXpifTmYM4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcEOHAACgkQJNaLcl1U
h9AatQf/YyAIJ0omN6Wss/9SRbF4My0yTn3/KGAOgJpqptaAKcXqNdr6Pz5MEXJ2
uWV647EdwqUdo/yxeTgTwihqkXgjWyFIKIZf77E+05oCOedQNXuT9FaJN89SVopR
eMySUcORpVSGJnIWt8+ekFSZ5IY/Z72asITub3gS2lv5sRrGfZH6PfNdmU0EXeJD
29nEKx9j3RPMYlXab0kZXiyCdOFeUVlas+7HB/HNCrilUlwywpbzB6SU5ZC5cltv
NwLSqbzkCzUQ7ezkmNFQ0FelOQqoPjwnE2hg+1HzzNmZvaOXI6u9eYyv8Jb4Kpnj
NwIrH8Nub6PsrcUiIrKKemQ2EKZZQA==
=8Upo
-----END PGP SIGNATURE-----

--cswsmIXpifTmYM4u--

