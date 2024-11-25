Return-Path: <linux-kselftest+bounces-22504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9579D8604
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 14:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54C4284BDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F205B1A9B4F;
	Mon, 25 Nov 2024 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ0q2qoJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA72618D625;
	Mon, 25 Nov 2024 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540312; cv=none; b=ZNQgJrfEEjoUmyhnZGVpk8doDfNy6Pr2QfCnneNtTr7AeBEMT/nlmSR5NH+HSDwmbPiDEiwvczvqiKnUx0LKkv14EDAne+d4aRECBUjsr+wzLHkixLjkKrWUj6u//8N00plJ/sMy+lRPmPxmj2f9wSUDamvzLeiTCfFuq+DSfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540312; c=relaxed/simple;
	bh=77n7xr3tbx600Y8k4lOBNTIIJ0RxEAQqaxW7kBUCqsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n23zlh4f4rIWJJsla2HnBAZXDUjkYX/GAxDZ58L+pYJK1JJRFK82uSGh2A9m2G0CSfBs9O/lYjjWBWP5BAC8hlUYHU4XChq1c8NX7gYl03cfgrNyWIs7zBxTAnJ7LNHRFO2Kzl6WJiyEXCqCbhZbJWgS+Y8YXdZMT2wve+BJBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ0q2qoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03B5C4CECE;
	Mon, 25 Nov 2024 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732540312;
	bh=77n7xr3tbx600Y8k4lOBNTIIJ0RxEAQqaxW7kBUCqsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZ0q2qoJo9jRKJO+I3SfmVlTttF0p1AgwxhCf1SlgooF56vf8YeaxCg2ghEyOMMmT
	 +U7xBi9FzIrrBUfze98Jj55U6IzZq5w8e0Rnl2uA0d/Wem1MTj8AcPUloaJ9clj+Vm
	 LkqPO7I/TGGaYwsvne1Oijp1UcPVl35UdTSrURNNG+tpvzgHU0DQhErnywaP7OeCAM
	 ijMXtrvbSAEWck9so/iL0W+VlDZ9L9b3Dxc06pZE5Tsv3w/UvxXhsfzeSUirmtUCrj
	 YcviGFpRiI0GDFOLRG984vhhUZ0xBKkBlJ19QWTqkx49xrsM7aIUNyDxdstM2LuKk+
	 GPo61Tm+Wo5yw==
Date: Mon, 25 Nov 2024 13:11:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Jiayuan Chen <mrpre@163.com>, linux-kselftest@vger.kernel.org,
	song@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, martin.lau@linux.dev, andrii@kernel.org,
	ast@kernel.org, kpsingh@kernel.org, jolsa@kernel.org
Subject: Re: [PATCH kselftest] fix single bpf test
Message-ID: <c685c171-0d2d-4ef1-82ca-386c3a2e3df6@sirena.org.uk>
References: <20241118140608.53524-1-mrpre@163.com>
 <93d96c99-4712-4054-a36f-3c65c80ab3f8@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6obR2W6oqGidcei7"
Content-Disposition: inline
In-Reply-To: <93d96c99-4712-4054-a36f-3c65c80ab3f8@linuxfoundation.org>
X-Cookie: This bag is recyclable.


--6obR2W6oqGidcei7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 08:14:58AM -0700, Shuah Khan wrote:

> The commit 7a6eb7c34a78 went in 4 years ago? DO we have a better
> story for the LLVM tool chain to get rid of skipping bpf and sched_ext?

> Running make -C tools/testing/selftests/bpf/ gave me the following error.
> Does this mean we still can't include bpf in default run?

> make -C tools/testing/selftests/bpf/
> make: Entering directory '/linux/linux_6.12/tools/testing/selftests/bpf'
>=20
> Auto-detecting system features:
> ...                                    llvm: [ OFF ]

The toolchain is in a better place now and we can run with released LLVM
versions.  The detection above is still needed since the LLVM version
needed is a bit newer than the version needed for the kernel itself,
it's LLVM 18 for BPF, and not everyone has LLVM.

>   GEN     /linux/linux_6.12/tools/testing/selftests/bpf/tools/build/bpfto=
ol/vmlinux.h
> libbpf: failed to find '.BTF' ELF section in /linux/linux_6.12/vmlinux
> Error: failed to load BTF from /linux/linux_6.12/vmlinux: No data availab=
le
> make[1]: *** [Makefile:209: /linux/linux_6.12/tools/testing/selftests/bpf=
/tools/build/bpftool/vmlinux.h] Error 195
> make[1]: *** Deleting file '/linux/linux_6.12/tools/testing/selftests/bpf=
/tools/build/bpftool/vmlinux.h'
> make: *** [Makefile:369: /linux/linux_6.12/tools/testing/selftests/bpf/to=
ols/sbin/bpftool] Error 2
> make: Leaving directory '/linux/linux_6.12/tools/testing/selftests/bpf'

This bit still needs some attention - the build needs a kernel binary
with BTF information built in via CONFIG_DEBUG_INFO_BTF.  That is
enabled by the config fragment for BTF tests but it's not compatible
with the arm64 defconfig since that sets CONFIG_DEBUG_INFO_REDUCED which
isn't compatible with _BTF, and in general having it missing should be
handled a bit more gracefully.  I believe some of the tests would run
happily without the BTF information. =20

TBH I'm a bit surprised we even tried to do this bit with LLVM not
available...

--6obR2W6oqGidcei7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdEd5IACgkQJNaLcl1U
h9BZMQf9F1MFajh28PQz3CmjPPNAkdxl8CF86T29XnOhxrfCPKuLpZNkem5jspwO
Dg7Eu5rM36gAZyAsh+vUj+w6rsNf0XQ8cEVnXouJ98mCjjzuFZp1GKVfl3VdNEJ2
aOGpQMtck3w1ZY/pZUU++kDcXSV9p/TnOCAjOt8HBc7V2FuQtJqvyfz2H++92CVA
4HD3wrqqVtRDCd3APgApyRYm14eh37O8LUyMM4zcYDByC/orxJzq2dmuAxMdhqiM
r3bwx6MIsC2GnqsrhZ+21SFN2vMUmXdt7MRZASBq7xmE3RALj2aIe0NzCG/53nV5
6GaD8ns0JcFmbAn3gzPmJnJFd2Oj9w==
=Afir
-----END PGP SIGNATURE-----

--6obR2W6oqGidcei7--

