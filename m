Return-Path: <linux-kselftest+bounces-19018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C101990392
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 15:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BCB28385B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 13:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7402101A7;
	Fri,  4 Oct 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXL7uCgc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C920FAAD;
	Fri,  4 Oct 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047275; cv=none; b=FGNIbriuJjfytu+uMq6V7G51fiG8V2nrZ63mCXDjXBSLjc5e5fD9RzV/rqHySB4neXBmuLw2MT01SVsl0HH7yd/CMXtkHLMIEYBZey+v9ZMNSZPHPWHik2eYi1oAHFLiXFM/B+3jlYMGVzrTxnR/a55hzKfbwoYR88MIAPlftWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047275; c=relaxed/simple;
	bh=HbfE2h4vxKWvyg/eWGYjSKRVkib46D2fF4m5DahMOHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7BLMWXdJe7I5I/1NkD34hzr4UqizDXeWX/4Ha6Da7lHVloMYJNhCQweW5eu00I2LQYOayinpptUy7JlyR2bpQ2ii2FdMM+XvH+bnYgrxJDzcDCLjP8wDUBMtrfBgBK3MlbuwFCEZ7mrBSHXPwNWgOXP17/+qbN8GiHcsQzoNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXL7uCgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CC4C4CEC6;
	Fri,  4 Oct 2024 13:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047275;
	bh=HbfE2h4vxKWvyg/eWGYjSKRVkib46D2fF4m5DahMOHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXL7uCgcRJdTD5uPtadv/zeAPIOM3nXWZFcBCtsYSDWbL+yCwSE2oaASKHLTWC8yT
	 MgezIgpxB6qcVEEsJ3w93VX4N0XrsK/G90JwtSB1OuzMFHfnbRmmgP3NQLpSWnJ5tH
	 hYfaZQ4rzX4yozAEK69I0Iac6n7gH5/rSrjIsOpriLvV/gOXIhSVGC5fYNGxYvNdEr
	 wCoSJeMxE3xt91QmtwypraxjdH0f0sQQI19yAYLImp8Rl5SVV+XQ7iz9zvF8Wg5GaW
	 EXJCbEXwjp6b2m4Ks+1FWUpkEBGZxyTGk5lRdeu/xUrhmiYS+Px0L/RA1ZssPyQnRl
	 k8pyCrkJ+lVmQ==
Date: Fri, 4 Oct 2024 14:07:49 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] selftests: Do not skip BPF selftests by default
Message-ID: <96023ef4-fa0b-4fc2-a6a7-ac32bc777c44@sirena.org.uk>
References: <20241004095348.797020-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0C1Go1cXuSqgJ8u8"
Content-Disposition: inline
In-Reply-To: <20241004095348.797020-1-bjorn@kernel.org>
X-Cookie: A bachelor is an unaltared male.


--0C1Go1cXuSqgJ8u8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 11:53:47AM +0200, Bj=F6rn T=F6pel wrote:
> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
>=20
> This effectively is a revert of commit 7a6eb7c34a78 ("selftests: Skip
> BPF seftests by default"). At the time when this was added, BPF had
> "build time dependencies on cutting edge versions". Since then a
> number of BPF capable tests has been included in net, hid, sched_ext.
>=20
> There is no reason not to include BPF by default in the build.

The issue was always requiring a bleeding edge version of clang, not
sure if that's been relaxed yet, IIRC sometimes it required git
versions.  I have clang 20 installed here so that's not an issue for me
but given that that's not released yet it wouldn't be reasonable to
expect CI systems to install it.

There's a few other substantial issues with all of these suites now I
look, none of them build on arm64 since arm64 defconfig has
DEBUG_INFO_REDUCED=3Dy which isn't compatible with CONFIG_DEBUG_INFO_BTF
so that gets turned off and the build splats trying to read the BTF out
of the kernel binary (which is a new build dep for the selftests
too...). =20

   https://storage.kernelci.org/next/master/next-20241004/arm64/defconfig%2=
Bkselftest/gcc-12/config/

We also get a bunch of:

die__process_unit: DW_TAG_label (0xa) @ <0x58eb7> not handled!
die__process_unit: tag not supported 0xa (label)!

if we do turn enable CONFIG_DEBUG_INFO_BTF for arm64. =20

The whole thing is also broken for cross compilation with clang since
everything is assuming that CROSS_COMPILE will be set for cross builds
but that's not the case for LLVM=3D1 builds - net gives:

  BPF_PROG nat6to4.bpf.o
  BPF_PROG sample_map_ret0.bpf.o
/usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin/l=
d: /home/broonie/git/linux/tools/testing/selftests/net/libynl.a(ynl.o): Rel=
ocations in generic ELF (EM: 62)
/usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin/l=
d: /home/broonie/git/linux/tools/testing/selftests/net/libynl.a(ynl.o): Rel=
ocations in generic ELF (EM: 62)
/usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin/l=
d: /home/broonie/git/linux/tools/testing/selftests/net/libynl.a(ynl.o): Rel=
ocations in generic ELF (EM: 62)
/usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin/l=
d: /home/broonie/git/linux/tools/testing/selftests/net/libynl.a: error addi=
ng symbols: file in wrong format
  BPF_PROG sample_ret0.bpf.o
collect2: error: ld returned 1 exit status

with similar errors in libbpf for HID:

/usr/bin/aarch64-linux-gnu-ld: /home/broonie/git/linux/tools/testing/selfte=
sts/hid/tools/build/libbpf/libbpf.a(libbpf-in.o): Relocations in generic EL=
F (EM: 62)
/usr/bin/aarch64-linux-gnu-ld: /home/broonie/git/linux/tools/testing/selfte=
sts/hid/tools/build/libbpf/libbpf.a(libbpf-in.o): Relocations in generic EL=
F (EM: 62)

KernelCI is seeing failures earlier with HID:

   https://storage.kernelci.org/next/master/next-20241004/arm64/defconfig%2=
Bkselftest/gcc-12/logs/kselftest.log

and an unrelated missing dependency on libssl for net that needs to be
fixed.

--0C1Go1cXuSqgJ8u8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb/6KQACgkQJNaLcl1U
h9AHHQf+JDjGvFF361rxHw+hdwcRUWLxLvZAPuNs8ktIA5ZgxlHb+lmSm0sIMUQB
EnidDI8Vej+ZgTm/eoWr3WV/iAfOOKibzaqx9QaNCJ4UDCPDlSnqcBkAJ9QvhBYa
ucq37YdKNwPmJl1s70ppWeAWlB6k7R55Xz6PiiTwhnkiXG+7o9R0Y5UdbZKqIBJG
dZi0RhVmBGutGG47Ksrm3xSAr6JLr8qotM4hKff8fDnoGsDVquUtRLG4ucd+tYtK
9RFAtQZ5BTYX/1h7lCwz/DnmJs79Wpyey6RgDUpB0Nj15sZbPkRxS+k28SASxsTg
UK8eLqsacdzwVRB9Oii1XfOmVB628g==
=fk9l
-----END PGP SIGNATURE-----

--0C1Go1cXuSqgJ8u8--

