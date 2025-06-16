Return-Path: <linux-kselftest+bounces-35141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208DADB97D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 21:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043753B4984
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121E528A1C6;
	Mon, 16 Jun 2025 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="MlAR+TVO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928C28937D;
	Mon, 16 Jun 2025 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101657; cv=none; b=onAep6RSUO44VFjdHWTUmGUw36SE+YbogzOdssGLJkNaCepju9yEzwbBzVHO1faO2Jtmc4b97Mafx/ytLNqSjuIuMuhZPMTnee7siX7ZBx3PYiwwWw7KEwu3EXo3WEJwNYxLbYiZdizozTYygZ26y3E4Y51LIAlhC/BwkZq8cBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101657; c=relaxed/simple;
	bh=axNIAB/C6jkDTgjQBx60qehyaTss7JGdiBObM6fIxF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o74JPrv5B6p6HG67LPmft89+3iwLubdRezJuCa0A//o2cMsKDfpUDFL2XmIKRCAi7oC3NTvmUNyT+LuXuEcCZBZT2kI6/58TVs8y6KFSZNkfPgNUPM3955k1H7f2+JPyOcGullFBQ5RmgNK7QDVowLVfk3aq2ubNXHAmi3rz2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=MlAR+TVO; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1750101647; x=1750706447; i=christian@heusel.eu;
	bh=vWAwD/gglL+XzNx4ZE+OLzKqaXpxiSmNcafe/8jSO5U=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MlAR+TVORkUBc1M50CPILIc1WVlvKcCedsR4Ol7SKNWOssKzTwBkw1tfKav1pDX8
	 TRisLZqgXvsltp+Ji+lAxxk2E0OkzFq5Ja9ORm8DvhLTJ3nk6Fl9yoyqFlXsS6wZE
	 iz6gVoWEmnFYmgJ0RNirrB5jtHguBNBMTojzJAgUdmMO9ZLur3y8DnKC/eg9pfOZc
	 OGzbzrYdVyDYCvJxxUN5Y23kfrxc71PYcYn5R84G7pC9DhkAj6gi18N6SoScsadpt
	 SN2vLCJWtppn6kU7t31+up/jt8LW2dWJ/x+KdE++Ve8UtONx60ybmullxSDWo5YJG
	 qX7K0XEryWDcuNBX9w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.66.155]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N8G6I-1unIRg0e9Y-00rsbO; Mon, 16 Jun 2025 21:14:44 +0200
Date: Mon, 16 Jun 2025 21:14:39 +0200
From: Christian Heusel <christian@heusel.eu>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: clang-built-linux <llvm@lists.linux.dev>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>, lorenzo.stoakes@oracle.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, jackmanb@google.com
Subject: Re: clang: selftests/mm gup_longterm error while loading shared
 libraries liburing.so.2 cannot open shared object file No such file or
 directory
Message-ID: <7c101fe5-7c73-4916-a832-d656511eeab8@heusel.eu>
References: <CA+G9fYssELHcYKwgGNBMLrfeKZa9swGdLrH7gxqzd4P0kaOiZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ifj2fqs4sl63qpb"
Content-Disposition: inline
In-Reply-To: <CA+G9fYssELHcYKwgGNBMLrfeKZa9swGdLrH7gxqzd4P0kaOiZg@mail.gmail.com>
X-Provags-ID: V03:K1:pjn8XBlqfHHtOY72HbeSefm8Rf/7BdJhV7MoRC2aUUryDa1n66a
 ABaLBzLk0y3//12UpZsoLd2/LKAlG9KBi9+UfpGW1NB1E/3kYYr1okeWMICCXaPk10z25wk
 GmSIrqflP0XnNLS4DmSUQg3QxPN8t3E7zLo0OnvqUzvhV+I+6SkuGhs8lYECSwJnbPpzeab
 45uKoJ8iPPQWFWScrd/Zg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SlavsgczDwk=;IWiRp/j7s5zo6lFg0OjNh6OQePo
 Kb514vk/gPWqumXbDt/bzWIm02m4PPP2eKDzOSXGiBL6rl6aOwQE6Op58/QAFLy+s2pq6QDIq
 8BWeBAkGbRW3KCiPPfhALunLnEf2lxczNRfbL4r+cLarqspbYjp6NgS37prto2kJpyCGsbNlT
 GmtyS5B1RmrZeDphIzohK+UrppNn7AwUHLEX/+vqiMoU0SWSnmMwPxcUj/fOxNRsS36EyOxsS
 r7IxkFHbhUE2TszaK/ywUFch6KBN/t8SX0FQl9YgCU4CNW2SEXFPdcS6e5cpm5wxyuI/wxt+V
 9CbSyXvgH9EZPZ4/BBbU6DSS8DapKjK11UO4G/Ge7s88jkJ12I3hjmq85K4rk/ydlE3M4tnzU
 PzuPGjUHqUms42JZUIWBI8yLAXUUmUgTdjex/+jSmfsC270EgDBzQ7WeFcHm5XOtfiNIEVFcE
 2sc2m6t8ZY0fYRPLi/IvPo+P6XONXC1PR8kOqb2qYwdrMXPFp8l/RT5j8GE2g2c/Fx5Bn06d0
 xjcZ5wbHTlFsErb7RIs2xohoQaGTt5B0vMZOCiaDlcu+qsGPpGWd1bjvuujOOXbyBgqZEMkoU
 fahSHFlcdMEr5zGbljwyjL+7PUv9PP7Sh6SaqkX8yZ73lYacz/xrQr67mflLIfANJ1jn+WRTE
 ROv3ksG4YvLQQey+NotUQVrBjf1f4OJOHBXgYkS2aavfFnGzdY8GxFJc7W6tR2rEIiCVRkHpD
 x8OVkXd+turOhdWwGo8FHHduyJctkYX7PLjHfLAkycX3zOmbnWpuFpG8oKqZVr/MKDtcFTHr4
 WplNw/Vn610zQ/c75pQRJSU4oQAbdA6fkgZDyawW4N4isT3hVf67PN6u7Q+RpGrE6TE1De4Dx
 Oxf5TojYBgYrvTEhcLMcicxeKqOkNFq2BP5fsljEc4BEJ2KQlk3y/ZuFhjaAZ85uSXEoxWV2Q
 PaMsO87ankUosuwGEhp6SHAJdOp9NLdUuqR7l53WC0uCTcGU/Zg1BkD0BKiIMayL6nxpmgx/Z
 p9bbm/MVjd9w6PnOVCyaEwnGnmymGvgED+6Uw2sbU2xws/1AT7bN+0Hx74qigdGbx9Ba1WpYi
 9zR/b8bv8uZjBXOaA78UAOyQzWaEJLUqTc254JWfBs1bblwAbdeFlzmgo7pgxs2vYpJ9TTFsT
 DqBj/uk4s5ehBi67PjxnTzg3PdUBfQaGQ3NiDJmUGR+GyHujiadVv+6uqEWkPp9+VTvwJGmmU
 +Hk9QIkzCkTV4ufFoQAf2E/F475ATXvAmwOWveIDCsr76m/uYXHHDEFQsaUVwGrGJfZQJj9s6
 vf2pV5BnnAfhLqILvjfiMIdmZTfMxD+ftqk7020mo4PpbIKfKkBkYHp0IlwmiS7Yz2SkqAUAT
 DrwX4ENd7pU8NOiTvLJXIQPYx38qHSaqRvpIz0a4iyW89WLlDu8WzkkFzd


--2ifj2fqs4sl63qpb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: clang: selftests/mm gup_longterm error while loading shared
 libraries liburing.so.2 cannot open shared object file No such file or
 directory
MIME-Version: 1.0

On 25/06/16 11:02PM, Naresh Kamboju wrote:
> The following test regressions noticed while running selftests/mm gup_lon=
gterm
> test cases on Dragonboard-845c, Dragonboard-410c, rock-pi-4, qemu-arm64 a=
nd
> qemu-x86_64 this build have required selftest/mm/configs included and too=
lchain
> is clang nightly.
>=20
> Regressions found on Dragonboard-845c, Dragonboard-410c, rock-pi-4,
> qemu-arm64 and qemu-x86_64
>   -  selftests mm gup_longterm fails
>=20
> Regression Analysis:
>  - New regression? Yes
>  - Reproducibility? Yes
>=20
> Test regression: selftests mm gup_longterm error while loading shared
> libraries liburing.so.2 cannot open shared object file No such file or
> directory
> Test regression: selftests mm cow error while loading shared libraries
> liburing.so.2 cannot open shared object file No such file or directory

These do not really look like kernel regressions, rather like a bug in
the userspace testing tool =F0=9F=A4=94 Could it be that the tests were not
rebuilt for the new liburing or that the dependency is not installed in
the test environment?

> Test regression: selftests mm mlock-random-test exit=3D139
> Test regression: selftests mm pagemap_ioctl exit=3D1
> Test regression: selftests mm guard_regions file hole_punch
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
>=20
> ## Test log
> Linux version 6.15.0-next-20250606 (tuxmake@tuxmake) (Debian clang
> version 21.0.0 (++20250602112323+c5a56f74fef7-1~exp1~20250602112342.1487),
> Debian LLD 21.0.0) #1 SMP PREEMPT @1749190532
>=20
> running ./gup_longterm
> ----------------------
> ./gup_longterm: error while loading shared libraries: liburing.so.2:
> cannot open shared object file: No such file or directory
> [FAIL]
>  not ok 14 gup_longterm # exit=3D127
>=20
> ./cow: error while loading shared libraries: liburing.so.2: cannot
> open shared object file: No such file or directory
> [FAIL]
> not ok 50 cow # exit=3D127
>=20
> running ./mlock-random-test
> ---------------------------
> TAP version 13
> 1..2
> [  311.408456] traps: mlock-random-te[21661] general protection fault
> ip:7f63210dbf0f sp:7ffdff6fca28 error:0 in
> libc.so.6[adf0f,7f6321056000+165000]
> [FAIL]
> not ok 23 mlock-random-test # exit=3D139
>=20
> running ./pagemap_ioctl
>=20
> ...
> ok 53 Huge page testing: only two middle pages dirty
> ok 54 # SKIP Hugetlb shmem testing: all new pages must not be written (di=
rty)
> ok 55 # SKIP Hugetlb shmem testing: all pages must be written (dirty)
> ok 56 # SKIP Hugetlb shmem testing: all pages dirty other than first
> and the last one
> ok 57 # SKIP Hugetlb shmem testing: PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_W=
PASYNC
> ok 58 # SKIP Hugetlb shmem testing: only middle page dirty
> ok 59 # SKIP Hugetlb shmem testing: only two middle pages dirty
> ok 60 # SKIP Hugetlb mem testing: all new pages must not be written (dirt=
y)
> ok 61 # SKIP Hugetlb mem testing: all pages must be written (dirty)
> ok 62 # SKIP Hugetlb mem testing: all pages dirty other than first and
> the last one
> ok 63 # SKIP Hugetlb mem testing: PM_SCAN_WP_MATCHING |
> PM_SCAN_CHECK_WPASYNC[  241.731600] run_vmtests.sh (456): drop_caches:
> 3
> ok 64 # SKIP Hugetlb mem testing: only middle page dirty
> ok 65 # SKIP Hugetlb mem testing: only two middle pages dirty
> Bail out! uffd-test creation failed 12 Cannot allocate memory
> 12 skipped test(s) detected. Consider enabling relevant config options
> to improve coverage.
> Planned tests !=3D run tests (115 !=3D 65)
> Totals: pass:53 fail:0 xfail:0 xpass:0 skip:12 error:0
> [FAIL]
> # not ok 48 pagemap_ioctl # exit=3D1
>=20
> running ./guard-regions
> ...
> RUN           guard_regions.file.hole_punch ...
> guard-regions.c:1905:hole_punch:Expected madvise(&ptr[3 * page_size],
> 4 * page_size, MADV_REMOVE) (-1) =3D=3D 0 (0)
> hole_punch: Test terminated by assertion
>          FAIL  guard_regions.file.hole_punch
> not ok 80 guard_regions.file.hole_punch
>=20
>=20
> ## Source
> * Kernel version: 6.16.0-rc2
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next=
/linux-next.git
> * Git sha: 050f8ad7b58d9079455af171ac279c4b9b828c11
> * Git describe: next-20250616
> * Project details:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250616/
> * Architectures: arm64, x86_64
> * Test environments: Dragonboard-845c, Dragonboard-410c,  rock-pi-4,
> qemu-arm64, qemu-x86_64 and x86
> * Toolchains: clang nightly
> * Kconfigs: selftest/mm/config+defconfig+
>=20
> ## Test
> * Test log: https://qa-reports.linaro.org/api/testruns/28766026/log_file/
> * Test log 2: https://qa-reports.linaro.org/api/testruns/28743077/log_fil=
e/
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250616/kself=
test-mm/mm_run_vmtests_sh_gup_longterm/
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0=
viPHafKAe0u89drIv5fcwu2/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0viPHafKAe0u89d=
rIv5fcwu2/config
>=20
>=20
> ## Steps to reproduce
>   - tuxrun \
>    --runtime podman \
>    --device qemu-x86_64 \
>    --boot-args rw  \
>    --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0wm=
Vl0eHb9koWyQYC7myXjpX/bzImage
> \
>    --rootfs https://storage.tuxboot.com/debian/20250605/trixie/amd64/root=
fs.ext4.xz
> \
>    --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0w=
mVl0eHb9koWyQYC7myXjpX/modules.tar.xz
> /usr/ \
>    --parameters MODULES_PATH=3D/usr/ \
>    --parameters
> SQUAD_URL=3Dhttps://qa-reports.linaro.org//api/submit/lkft/linux-next-mas=
ter/next-20250616/env/
> \
>    --parameters SKIPFILE=3Dskipfile-lkft.yaml \
>    --parameters
> KSELFTEST=3Dhttps://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0wm=
Vl0eHb9koWyQYC7myXjpX/kselftest.tar.xz
> \
>    --image docker.io/linaro/tuxrun-dispatcher:v1.2.2 \
>    --tests kselftest-mm \
>    --timeouts boot=3D15
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org
>=20

--2ifj2fqs4sl63qpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhQbR4ACgkQwEfU8yi1
JYXNhBAA4J8IfYyoS8afSaTdCPF1zLiPorF6mZuTwefTndUd//Zm6nOhBHsU4KsV
YQDbZUMUV0IGXSZ0leI7mb4TVVg+y1Xn4p35uNKfykilbUpuXZz/y4toLJMuFG73
abD+pXJQK9bGnZOeTocm45uwbeUnAq4VcwPaI2vAmaIXZkde1ca4G9gXonk077au
rko4E9+W2gCHNKoNqsVrJ5BRTGrxAKkWKYMiO1TuIhodrNmLikk+vmyR68hVY4bl
TcYp1BDhioojMtP/4KwgXY1e1jbUvGDdG/rrRiPYEWNiVNx33LsTu/o0Hj8SbxgA
cFPJM5UiSPY0Yy9jVGgoTjcIU4Il1PsH4kscqvneaXpKEkGk/SP0l57xUmc87+S8
MtA5IC72mwxVbOgtPEqBcbpT6Q7HvFlTVEZSwfFcJk6wW7cbMJjKFCEPm1lR1sqK
Pcii1RpfY8iSAeXcDu7t0PjAR1/W+2SzfrVdXrgteaFR+MJDPjPxyocEjrS+59jT
FIwOBTg836WK1382cwXplao891izLPG4A3oLZhPUNKucadmRHlODJlSvOnZGxOFJ
+Xlkh01E2yHt/wUTmYG04gDEuA9GU9Ile50LBsntFQpH2wbYVtPM7GS3VBOyRhvE
iXtUBSHyWH3bH5nmkc7mgmd5iVlQGWmPRYgzPYv+XDddgyiz0fo=
=w13D
-----END PGP SIGNATURE-----

--2ifj2fqs4sl63qpb--

