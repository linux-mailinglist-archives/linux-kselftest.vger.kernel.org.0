Return-Path: <linux-kselftest+bounces-19161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB639932FD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C5528313A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5A1DA2E5;
	Mon,  7 Oct 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4c60YB/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC21D4152;
	Mon,  7 Oct 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318105; cv=none; b=cb0fp2EdwNwS92Q7QlKRT/AFTz6EwvBP4/rbFz2uRzlr+5Yjw3lghmeFCMNKSHLSVWgKN6M1S6zzKCFtBnudTyB9JhskToDLEdZ5JfD81czyYhA5mdz22Bh0xmHuQnCj2NWhrZmNOECrtAcY6Oe1eUo7DR6cK6LWp4xM57BwDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318105; c=relaxed/simple;
	bh=PoWOtQj6nr9yo/vCoJ1K+oh816ywT+jG0OzA4+bxEvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTRIacSZ9rijZeP3SMdoYkOkMaPX4t71EZOYgNbV/XGXL8xH8JHWicAenNB/InErqkDir5YBGbOrKULVVg/KJ9VyVXC0LqxWcvoplLSn1G4z09Nfe7M80eZOLkDSAcEY1rjRT/PBsm+bI4sK17SqSWL8pMVx71q7vvHisH66cw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4c60YB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E6DC4CEC6;
	Mon,  7 Oct 2024 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728318105;
	bh=PoWOtQj6nr9yo/vCoJ1K+oh816ywT+jG0OzA4+bxEvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4c60YB/3QXa3mURnfXL8Ghv/b6KAgZmA2FrqRnKW8h4XQIysndHls9cl89GK2UJI
	 +fQF0ig4Jt+4Sg4XSbRrhyMD5Nj7fao2ipJT0Lp3bray3rnjJrNJ9igw3z2QAT8ney
	 IXB1ExI6sxdOlBNw8FCufB+FiriiVxjDRSwYHUXAaldJYU/qsbwvGNIE0BmPlgTOHP
	 dgi8ggs14XXIpDtt0iJ9NwbgHRippzrwajCbBQapPZTWB2kgrJ0LzxnAJfZ2aneBgn
	 cWtYSj+8EuxHwY1lBTENiwUfvmhuCjvK881WNPTnnUoBfxQY+iU0/rtQZocWA5kjNx
	 Jto0n4hRkqxww==
Date: Mon, 7 Oct 2024 17:20:21 +0100
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
Message-ID: <ZwQKRe7iIzZjjEQd@finisterre.sirena.org.uk>
References: <20241007073133.989166-1-bjorn@kernel.org>
 <ZwQBqlG6MShCkNrU@finisterre.sirena.org.uk>
 <87r08rnbra.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mdbUJb1cNu8O2f9z"
Content-Disposition: inline
In-Reply-To: <87r08rnbra.fsf@all.your.base.are.belong.to.us>
X-Cookie: Editing is a rewording activity.


--mdbUJb1cNu8O2f9z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 06:00:57PM +0200, Bj=F6rn T=F6pel wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Mon, Oct 07, 2024 at 09:31:32AM +0200, Bj=F6rn T=F6pel wrote:

> >   CLNG-BPF create_dsq.bpf.o
> > In file included from create_dsq.bpf.c:9:
> > /home/broonie/git/linux/tools/sched_ext/include/scx/common.bpf.h:33:17:=
 error: use of undeclared identifier 'SCX_DSQ_FLAG_BUILTIN'
> >    33 |         _Static_assert(SCX_DSQ_FLAG_BUILTIN,
> >       |                        ^

> This is most likely due to incorrect VMLINUX_BTF_PATHS, so that
> vmlinux.h is incorrectly generated. Try grepping for
> SCX_DSQ_FLAG_BUILTIN in vmlinux.h.

Yeah, it's not in the generated files:

broonie@finisterre:~/git/linux$ grep SCX_DSQ_FLAG_BUILTIN ./tools/testing/s=
elftests/sched_ext/build/include/vmlinux.h ./tools/testing/selftests/sched_=
ext/build/obj/bpftool/vmlinux.h
broonie@finisterre:~/git/linux$=20

I didn't actually build a kernel, if the build system needs a kernel
it's just silently not detected that it's missing?

--mdbUJb1cNu8O2f9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcECkUACgkQJNaLcl1U
h9BY3AgAhgSd/gtJOHhPdgDJdlWHAcccsg0/qZNJNyUwqLK62pnBWJtCXAN3P1ur
6wfsjd2wIRRomHekliWei8/9wsP3Ag+/uUSMbeczP7xDAouuwtPUZlDDjQq8hMrk
2bSTZmTIa2qpjrrfKJRLsX5RDGziW+Q6C3A4hSSa5+l2Ys1lU9Z4rr96eMzoDvTM
sAyppbbqUPHE59Wqn2L8vHA4qO9ODaYc+VmEZkZPOS661nN9pcImXFu9jd3sbquR
ZhCA5Jzmj83gP2U4rmSlhWna45c+io68Nd5Zf7ZrdFYceR5VFPkKWRry+a/N/bPg
JuUBz8uQVlPVg5VsbFNnqbcT+b+SGw==
=AxkR
-----END PGP SIGNATURE-----

--mdbUJb1cNu8O2f9z--

