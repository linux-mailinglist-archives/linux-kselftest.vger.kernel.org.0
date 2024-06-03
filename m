Return-Path: <linux-kselftest+bounces-11115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B3B8D8615
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 17:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF14281C9C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6312FF73;
	Mon,  3 Jun 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ3CYvko"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2711EF1A;
	Mon,  3 Jun 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428757; cv=none; b=B63aQh2uM2j8z1rlvviSVaxEdAg5TQoiY9uDGMdCpTD66PhZLa2OYS1qMnD7XN52DEL3YG1eB4I+pXpueJKSt2PFVS68S0w3TymbMqXH+JNIpwFyHSUxhzKubQzA7YJA+ou4M2xncXVRvpFAjRAnYnJQwpHOtKMeDXSm1O4TuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428757; c=relaxed/simple;
	bh=q4oMvhBk1KUtZfzGp4xFNoiHbYTq2R2RFWXRAm7gEIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9xJ73HZulkDm10lk3kZSyjO7MdLKMFIp3CJUul+vYsZtdx+HYBWv664VJ33PXY53W7mf1FkWskiAvx3KvmcSubo5Vf9B6z4XLr/ZJ7XtiFMwm+HtqIZUy2GzmRhvW0CEzxwZ06yCGVl8phv+YyGmQOp+AVZ4nOYFsRBk3esQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ3CYvko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9563EC2BD10;
	Mon,  3 Jun 2024 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717428757;
	bh=q4oMvhBk1KUtZfzGp4xFNoiHbYTq2R2RFWXRAm7gEIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQ3CYvkoed4OsodNkOOI4ar7YyO8scOxmVRmL0iGhN/hBCO0WtqknKQ0lZSyScNsz
	 PB0dZg2Tc8Skvf+4YhW5x7P59xBfwV5cVrOB5b7R6H076cDR1I9xmSdHBWpydPn3ke
	 T1pZA51NGcAF/zHSZOL6dZ5t461Yp9sqAc70Rdw85VzBiTItI3BxDYZb9lPKzaTyY3
	 hDpAVxjrta8A9R5r4nDbss3Q1mJ+59bpQK8RaPzAYmc3V/93NG9mZt/GDUbrWcXrMM
	 D9WxB5G8JI92oPPDW4IpLX+cyOZAZO8PECRB70bBR3W2L0Z0RLsTHjDd/ysi670E94
	 PjH8GJmvn4+sA==
Date: Mon, 3 Jun 2024 16:32:30 +0100
From: Mark Brown <broonie@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>, sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v2 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang
 builds
Message-ID: <306eebf8-bb5d-4e1a-9fa3-ad3f4ea11b9c@sirena.org.uk>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-2-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LwQaHvdHhiWHyo0G"
Content-Disposition: inline
In-Reply-To: <20240531183751.100541-2-jhubbard@nvidia.com>
X-Cookie: Don't let your status become too quo!


--LwQaHvdHhiWHyo0G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 11:37:50AM -0700, John Hubbard wrote:
> The kselftests may be built in a couple different ways:
>     make LLVM=3D1
>     make CC=3Dclang
>=20
> In order to handle both cases, set LLVM=3D1 if CC=3Dclang. That way,the r=
est
> of lib.mk, and any Makefiles that include lib.mk, can base decisions
> solely on whether or not LLVM is set.

ICBW but I believe there are still some architectures with clang but not
lld support where there's a use case for using CC=3Dclang.

--LwQaHvdHhiWHyo0G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZd4g4ACgkQJNaLcl1U
h9BEXQf/WsN/S/yg0X/HYWR3Takul1/6IMH2x/VHC82HyAOKMHvVPItAmDPw0ZM1
ubOFi/vRuKTuThZO95BKg8SSMDBty71Hwo8MZCtps7cjrK+3OUXr46IDJNXcu2dN
6CcRlPBSSJUJG1FcrcgjezJ+KWSJJPbuTkpr+baKpKN4AHdHjIwM/D2v1xWwZDaR
rt6c0R43kWKBhKRDXaNgbebxbvb7abFK1rnzkZs6W+7Xh0jTf3+GFerai7sF5oKs
4a0oPQqX3QGDJmndGAvi5uSIQAxHN6m0afLd3FCH4/Vn0NvTu5e0hsd/RJk8A9R1
u+L6RzjaMPkL2SNIYUL4T8Q1fBas7A==
=wAUi
-----END PGP SIGNATURE-----

--LwQaHvdHhiWHyo0G--

