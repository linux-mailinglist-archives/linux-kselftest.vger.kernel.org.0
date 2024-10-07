Return-Path: <linux-kselftest+bounces-19156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1D9931AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 17:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDB41C23609
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0EC1D95A3;
	Mon,  7 Oct 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9adUiYl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB65B1D7E3D;
	Mon,  7 Oct 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315821; cv=none; b=C4Jl21S0NGzFr+cDkV+/V6Wyc/Vsv0m6mmBpRlviLDbIIl2V0MCGorXLkpL8iq4ShqUw7z8iHEtay01njvxBDTMhPu0pjIq/R8MIktpHuISOS2Laik2t1iwqy2ZDxmWrl6K9pZibkjRZGWOpWc9LODaXVoej2eh17A8bUDXC0hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315821; c=relaxed/simple;
	bh=AhsZq1BsiII0roJalW8IMhJQxXPA+0/dIC/qxDCsip8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYASMuyPFkboIlRaOIFvlIx1g6pF0NtfNKPmJcqdV3r3T++pxdzMARfQJJIAW70Zu7vTYK0D7ubzxtpb4oqb4lGuBLmuHhWv/RTveCG/7zl047K3CITEEM9a88rl6348atWFqOoqbhiSOJIh5dCjLxnxfJHBn/EOC5wiG3rUCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9adUiYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE75DC4CEC7;
	Mon,  7 Oct 2024 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728315821;
	bh=AhsZq1BsiII0roJalW8IMhJQxXPA+0/dIC/qxDCsip8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9adUiYl58rRZbT3kDUBY17RMvFVmouBxn0VmyNNzJWlJRSW/CMXs8+fGBEbXejri
	 4qvJulkvLjZSGMjWVCfg2JE6gFEfyEx6vXkX0TD/hKV+WiPfwyWSvK0hcJZOVyOqvB
	 cixv2XPtCiH5gV+QbdzfbCmQb8JnJhzlwtapr6T2ZA9PuU/2VW/w/uGKh3daOjqvcB
	 /vtTRvaZ9T5oR0UYUOHFMxHGbKHWUTIr3hC5gc85EiEJci8myOCNZdfXoCgr1N7SVy
	 W2jzN4bKPbf30tk3F2HquhENaQbSkq6PZfzqyFZAl2PIas00qRs0ep2XUXUkyAb2yj
	 Kcdlb9C8Sz9AQ==
Date: Mon, 7 Oct 2024 16:43:38 +0100
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
Message-ID: <ZwQBqlG6MShCkNrU@finisterre.sirena.org.uk>
References: <20241007073133.989166-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RQTX0C3QpGBx/Yar"
Content-Disposition: inline
In-Reply-To: <20241007073133.989166-1-bjorn@kernel.org>
X-Cookie: Editing is a rewording activity.


--RQTX0C3QpGBx/Yar
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 09:31:32AM +0200, Bj=F6rn T=F6pel wrote:

> When building the kselftest suite, e.g.:

>   make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- \
>     SKIP_TARGETS=3D"" O=3D/output/foo -C tools/testing/selftests install

> The expectation is that the sched_ext is included, cross-built, and
> placed into /output/foo.

When building for arm64 with this applied on top of mainline or -next
I'm seeing:

   make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -C tools/testing/se=
lftests TARGETS=3Dsched_ext SKIP_TARGETS=3D"

give

  CLNG-BPF create_dsq.bpf.o
In file included from create_dsq.bpf.c:9:
/home/broonie/git/linux/tools/sched_ext/include/scx/common.bpf.h:33:17: err=
or: use of undeclared identifier 'SCX_DSQ_FLAG_BUILTIN'
   33 |         _Static_assert(SCX_DSQ_FLAG_BUILTIN,
      |                        ^

and more (my system clang is clang 20).  It's also failing with a native
x86_64 build in the same way.  I've run "make headers_install", it looks
like clang is not getting told about the copy of the headers installed
in ./usr/include:

clang -g -D__TARGET_ARCH_x86 -mlittle-endian -I/home/broonie/git/linux/tool=
s/testing/selftests/sched_ext/include -I/home/broonie/git/linux/tools/testi=
ng/selftests/sched_ext/include/bpf-compat -I/home/broonie/git/linux/tools/t=
esting/selftests/sched_ext/build/include -I/home/broonie/git/linux/tools/in=
clude/uapi -I/home/broonie/git/linux/tools/sched_ext/include -I/home/brooni=
e/git/linux/include -idirafter /usr/lib/llvm-20/lib/clang/20/include -idira=
fter /usr/local/include -idirafter /usr/include/x86_64-linux-gnu -idirafter=
 /usr/include  -Wall -Wno-compare-distinct-pointer-types -Wno-incompatible-=
function-pointer-types -O2 -mcpu=3Dv3 -target bpf -c create_dsq.bpf.c -o /h=
ome/broonie/git/linux/tools/testing/selftests/sched_ext/build/obj/sched_ext=
/create_dsq.bpf.o

> Add CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
> selftest. Also, remove some variables that were unused by the
> Makefile.

> +ifneq ($(CROSS_COMPILE),)
> +DEFAULT_BPFTOOL :=3D $(OUTPUT_DIR)/host/sbin/bpftool
> +HOST_OBJ_DIR :=3D $(OBJ_DIR)/host/bpftool
> +HOST_LIBBPF_OUTPUT :=3D $(OBJ_DIR)/host/libbpf/
> +HOST_LIBBPF_DESTDIR :=3D $(OUTPUT_DIR)/host/
> +HOST_DESTDIR :=3D $(OUTPUT_DIR)/host/
> +else
> +DEFAULT_BPFTOOL :=3D $(OUTPUT_DIR)/sbin/bpftool
> +HOST_OBJ_DIR :=3D $(OBJ_DIR)/bpftool
> +HOST_LIBBPF_OUTPUT :=3D $(OBJ_DIR)/libbpf/
> +HOST_LIBBPF_DESTDIR :=3D $(OUTPUT_DIR)/
> +HOST_DESTDIR :=3D $(OUTPUT_DIR)/
> +endif

This won't detect a cross compile when building using LLVM as that
doesn't need to set CROSS_COMPILE, it can use the same binaries for all
targets.  There's runes in the Makefile for the mm selftests for
identifying the target architecture, though actually I'm wondering if
it's worth just always building the host copy and never having to worry
if the target build is a cross build or not?  It's obvious overhead in
the native case though if we actually need the target copy.

--RQTX0C3QpGBx/Yar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcEAakACgkQJNaLcl1U
h9An1wf9HtCpL0qKu0Mw8tfGrwi5hcoQz4t6Hk0itley1H29WYnc2QdzBCtkJ23x
XqySN35gxSHfydFAIZmO7/OZA6pBn5Ip1hp0F4BL7HpwsV5ee4mUI3DryMAkRIYX
DZGQRcUPa+638ozn/Q6QPgfBt61GlgvJQJJKkF3tzuG12ky7+9flumeFjogWkCoB
FSA6Cmh3rrDbSEuCaSeylc60Xq0vaxZmj3xTtwuoAvQbdD+JI9b5PTA3PYgrL8JR
rG/Msmf/++9rlZK3zn9O0U/H4OXt9J6A2BEd+79oc2ZVLnfzi8ajqH/NG+XkZZBC
hibi6Md/pXB2ZNbvaYQw+iRkck7Tlg==
=xhLq
-----END PGP SIGNATURE-----

--RQTX0C3QpGBx/Yar--

