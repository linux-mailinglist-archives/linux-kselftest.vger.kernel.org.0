Return-Path: <linux-kselftest+bounces-25809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54CA28532
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 09:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB4A162C08
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 08:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0CE21E082;
	Wed,  5 Feb 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ny74doJY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7E20F09B;
	Wed,  5 Feb 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742475; cv=none; b=PcZdHFHDbNmNSAT9EE1Pdx7imD/OYlsXJfxnwr9oCvcU1m419/d3EiXeEPibfiFwMgk+z9TrIilgq/VuYorbcikcvyO6X9VDe0I857S5eus5b8nX7BqAbSjhOPMqwSNL3IIhqH6NBUKn5N1vll35LEgy2aN4KX9A9VM7R5j1WdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742475; c=relaxed/simple;
	bh=PZxSw3Qx5xrSNt+DmWTtEzUB743uXmGf1Th0hTyKLVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=guh78IGvqkGqduLwNS/GyboCVJIXfuS+u1wzh46udH6t0430BFgtMVr+PnNo0oZOq+Qpx9V4q1JxoTA2t8cJ8lPjnA3PrH3DNFunDVRzAAiAwVdlOwl6gMU/+O3WZXFbqXSpIExD5bVUVr+Lj9R1rogn0oXOcpVrxqH7D92Hkd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ny74doJY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5153RdGg023244;
	Wed, 5 Feb 2025 08:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bOs4F1
	guHHqNrzvFjHfrQeyiX4mioKjmu810B8ZxCGs=; b=ny74doJY2hNQ4KMY13Hgd3
	nHzBAvUBIIqTNvbozMYQBObyqxEXs692t8PM9a10v2cqxNE7FTmjqZCAYz9B7uMR
	PKU517KCdf+GVxddHHahm+AeEd0t9t0OEcAA+ZC9h4W4pewsrjIVmo+/XZ8FHvlw
	anHYj2XOK74WtVq7T34xjCQjtt4lRkHoWArzAmC3lMxcMETEPnNfFFdEk/LqnymV
	Vavn/cE1UQ7K79NdBhlY6SY7kfneCQ1AYApPZ0hUwEe3Vu94Cvwbln8fVU4Mv9+N
	EJVhkVGWkPYDgqQm3SS5Bq8doODiygggL3bbVuw0Iytq+XvVIy5dS/nLuEUOdT3A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kn62mb89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 08:00:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51552l7S006543;
	Wed, 5 Feb 2025 08:00:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekfmyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 08:00:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51580cmP28639734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 08:00:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6EF32004D;
	Wed,  5 Feb 2025 08:00:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5FDB20043;
	Wed,  5 Feb 2025 08:00:38 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Feb 2025 08:00:38 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tools/nolibc: add support for 32-bit s390
In-Reply-To: <20250122-nolibc-s390-v1-2-8c765f00e871@weissschuh.net>
 ("Thomas
	=?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Wed, 22 Jan 2025 19:43:46
 +0100")
References: <20250122-nolibc-s390-v1-0-8c765f00e871@weissschuh.net>
	<20250122-nolibc-s390-v1-2-8c765f00e871@weissschuh.net>
Date: Wed, 05 Feb 2025 09:00:38 +0100
Message-ID: <yt9dcyfwyg61.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sMzxKwR5HNgp8wdiEespP8iHnp6i67M7
X-Proofpoint-ORIG-GUID: sMzxKwR5HNgp8wdiEespP8iHnp6i67M7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_03,2025-02-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050063

Hi Thomas,

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:

> 32-bit s390 is very close to the existing 64-bit implementation.
>
> Some special handling is necessary as there is neither LLVM nor
> QEMU support. Also the kernel itself can not build natively for 32-bit
> s390, so instead the test program is executed with a 64-bit kernel.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/arch-s390.h            | 5 +++++
>  tools/include/nolibc/arch.h                 | 2 +-
>  tools/testing/selftests/nolibc/Makefile     | 5 +++++
>  tools/testing/selftests/nolibc/run-tests.sh | 7 ++++++-
>  4 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch=
-s390.h
> index f9ab83a219b8a2d5e53b0b303d8bf0bf78280d5f..3f2fb00ca101cc052f3b794b7=
43e9e5734fe5a77 100644
> --- a/tools/include/nolibc/arch-s390.h
> +++ b/tools/include/nolibc/arch-s390.h
> @@ -143,8 +143,13 @@
>  void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_prot=
ector _start(void)
>  {
>  	__asm__ volatile (
> +#ifdef __s390x__
>  		"lgr	%r2, %r15\n"          /* save stack pointer to %r2, as arg1 of _s=
tart_c */
>  		"aghi	%r15, -160\n"         /* allocate new stackframe                =
        */
> +#else
> +		"lr	%r2, %r15\n"
> +		"ahi	%r15, -160\n"
> +#endif

compat mode is using a stack size of 96 bytes, so the ahi above needs to
be adjusted.

>  		"xc	0(8,%r15), 0(%r15)\n" /* clear backchain                          =
      */
>  		"brasl	%r14, _start_c\n"     /* transfer to c runtime                 =
         */
>  	);
> diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
> index c8f4e5d3add9eb5b8a438900c084dc0449fcfbd6..8a2c143c0fba288147e5a7bf9=
db38ffb08367616 100644
> --- a/tools/include/nolibc/arch.h
> +++ b/tools/include/nolibc/arch.h
> @@ -29,7 +29,7 @@
>  #include "arch-powerpc.h"
>  #elif defined(__riscv)
>  #include "arch-riscv.h"
> -#elif defined(__s390x__)
> +#elif defined(__s390x__) || defined(__s390__)
>  #include "arch-s390.h"
>  #elif defined(__loongarch__)
>  #include "arch-loongarch.h"
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/self=
tests/nolibc/Makefile
> index dad0d9fd7702f8dc9a9a552cda5305f8973c5469..dc5cf19dd74389336b619e15e=
07f1c635241b7d7 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -72,6 +72,7 @@ IMAGE_riscv      =3D arch/riscv/boot/Image
>  IMAGE_riscv32    =3D arch/riscv/boot/Image
>  IMAGE_riscv64    =3D arch/riscv/boot/Image
>  IMAGE_s390x      =3D arch/s390/boot/bzImage
> +IMAGE_s390       =3D arch/s390/boot/bzImage
>  IMAGE_loongarch  =3D arch/loongarch/boot/vmlinuz.efi
>  IMAGE            =3D $(objtree)/$(IMAGE_$(XARCH))
>  IMAGE_NAME       =3D $(notdir $(IMAGE))
> @@ -91,6 +92,7 @@ DEFCONFIG_riscv      =3D defconfig
>  DEFCONFIG_riscv32    =3D rv32_defconfig
>  DEFCONFIG_riscv64    =3D defconfig
>  DEFCONFIG_s390x      =3D defconfig
> +DEFCONFIG_s390       =3D defconfig compat.config
>  DEFCONFIG_loongarch  =3D defconfig
>  DEFCONFIG            =3D $(DEFCONFIG_$(XARCH))
>=20=20
> @@ -112,6 +114,7 @@ QEMU_ARCH_riscv      =3D riscv64
>  QEMU_ARCH_riscv32    =3D riscv32
>  QEMU_ARCH_riscv64    =3D riscv64
>  QEMU_ARCH_s390x      =3D s390x
> +QEMU_ARCH_s390       =3D s390x
>  QEMU_ARCH_loongarch  =3D loongarch64
>  QEMU_ARCH            =3D $(QEMU_ARCH_$(XARCH))
>=20=20
> @@ -140,6 +143,7 @@ QEMU_ARGS_riscv      =3D -M virt -append "console=3Dt=
tyS0 panic=3D-1 $(TEST:%=3DNOLIBC_T
>  QEMU_ARGS_riscv32    =3D -M virt -append "console=3DttyS0 panic=3D-1 $(T=
EST:%=3DNOLIBC_TEST=3D%)"
>  QEMU_ARGS_riscv64    =3D -M virt -append "console=3DttyS0 panic=3D-1 $(T=
EST:%=3DNOLIBC_TEST=3D%)"
>  QEMU_ARGS_s390x      =3D -M s390-ccw-virtio -append "console=3DttyS0 pan=
ic=3D-1 $(TEST:%=3DNOLIBC_TEST=3D%)"
> +QEMU_ARGS_s390       =3D -M s390-ccw-virtio -append "console=3DttyS0 pan=
ic=3D-1 $(TEST:%=3DNOLIBC_TEST=3D%)"
>  QEMU_ARGS_loongarch  =3D -M virt -append "console=3DttyS0,115200 panic=
=3D-1 $(TEST:%=3DNOLIBC_TEST=3D%)"
>  QEMU_ARGS            =3D -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $=
(QEMU_ARGS_EXTRA)
>=20=20
> @@ -158,6 +162,7 @@ CFLAGS_ppc =3D -m32 -mbig-endian -mno-vsx $(call cc-o=
ption,-mmultiple)
>  CFLAGS_ppc64 =3D -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
>  CFLAGS_ppc64le =3D -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=
=3Delfv2)
>  CFLAGS_s390x =3D -m64
> +CFLAGS_s390 =3D -m31
>  CFLAGS_mips32le =3D -EL -mabi=3D32 -fPIC
>  CFLAGS_mips32be =3D -EB -mabi=3D32
>  CFLAGS_STACKPROTECTOR ?=3D $(call cc-option,-mstack-protector-guard=3Dgl=
obal $(call cc-option,-fstack-protector-all))
> diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/=
selftests/nolibc/run-tests.sh
> index fe4d48cc054abb1e922b31aa7b6a2395aaf61f5f..79874f669b2a364ad1cb2399b=
4ebbab5ec6c9de9 100755
> --- a/tools/testing/selftests/nolibc/run-tests.sh
> +++ b/tools/testing/selftests/nolibc/run-tests.sh
> @@ -17,7 +17,7 @@ perform_download=3D0
>  test_mode=3Dsystem
>  werror=3D1
>  llvm=3D
> -archs=3D"i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv=
32 riscv64 s390x loongarch"
> +archs=3D"i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv=
32 riscv64 s390x s390 loongarch"
>=20=20
>  TEMP=3D$(getopt -o 'j:d:c:b:a:m:pelh' -n "$0" -- "$@")
>=20=20
> @@ -171,6 +171,11 @@ test_arch() {
>  			exit 1
>  	esac
>  	printf '%-15s' "$arch:"
> +	if [ "$arch" =3D "s390" ] && ([ "$llvm" =3D "1" ] || [ "$test_mode" =3D=
 "user" ]); then
> +		echo "Unsupported configuration"
> +		return
> +	fi
> +
>  	swallow_output "${MAKE[@]}" CFLAGS_EXTRA=3D"$CFLAGS_EXTRA" defconfig "$=
test_target" V=3D1
>  	cp run.out run.out."${arch}"
>  	"${MAKE[@]}" report | grep passed

