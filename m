Return-Path: <linux-kselftest+bounces-17387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F5496F11D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 12:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11B7B212D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 10:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7761C9DD8;
	Fri,  6 Sep 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HN8sxOsO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B21C870C;
	Fri,  6 Sep 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617588; cv=none; b=dr0zU69+VBvAAxxRHnVLUTv4iSrD/ud9hFzlwrbPLBby9QFqiNsUgGZTkPKbH9z6Ax1nxXajhjVPRpHhwlqIXZx74IOvuUujJzMkaHoCDuKFxzHy8pd+v0R7hENFBwspC0FQiyx9qvG1+mSMkppTz3YfB/VC8xo7iZOGXuF/J30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617588; c=relaxed/simple;
	bh=AOzfRdknj8c+nsi31JLn/lZPtI4KZvzyANranCPSipU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OCNIhEVfmZx2bcjgMVuLAHZ/h1xnNN08/m04AwcWn0WaaSxy5gBWEA265i7w+BNAonTt4xbhzHQzeD/iZjt41ZxvPN3eroeC7GkOYnUxGQuMCdodlCuqXWpIEDhf7wfVOVxiAzQYIDSMe7zsHU5uTDX0p8aKBXQLhjcFMCWS3No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HN8sxOsO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725617587; x=1757153587;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AOzfRdknj8c+nsi31JLn/lZPtI4KZvzyANranCPSipU=;
  b=HN8sxOsOe8e6EiyzHHk3ZK0udFdJ5PeauY97LjjEgy1o0OTkQHOT1mVx
   8YcRvbqnY8xvmnztiqgOUAhkLK0l1N2G3kgHiaPsAnAhPA0YyuAqNOpF2
   LjaasDnZXYKkbvseu6c2hkiB1Ta9X3UzrtPlaIJ8hgRsDFurKvriNqehT
   0h9flGauf4HsSWisMIDS54xwE7zhtkBStVc1QcGGDJZdGRDrMmD0Vw/7H
   zMqe8FCcikLqQgcXRWli0pd1Z0QUfdP+0qeTgQ3+JaBJ9mysQ8Jzbbl6e
   OsvHKyUejeVemmKitYYSLjmrHN7eM4WiG6s9b06cvtXstbkPP/paEpnC1
   A==;
X-CSE-ConnectionGUID: R4bkbdBwTlyPoNsOLZgvVA==
X-CSE-MsgGUID: rUXyInEtRxGkaaXsVoCnWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="41853522"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="41853522"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 03:13:06 -0700
X-CSE-ConnectionGUID: K6YLQIaTQimVCRSiqiv6Ew==
X-CSE-MsgGUID: Fz1N+onFQAGM/+B0EbcJYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="70701690"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 03:13:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Sep 2024 13:12:58 +0300 (EEST)
To: Shuah Khan <skhan@linuxfoundation.org>
cc: shuah@kernel.org, fenghua.yu@intel.com, 
    Reinette Chatre <reinette.chatre@intel.com>, usama.anjum@collabora.com, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests:resctrl: Fix build failure on archs without
 __cpuid_count()
In-Reply-To: <20240905180231.20920-1-skhan@linuxfoundation.org>
Message-ID: <21267ef6-6fcf-2eed-a3da-2782d1e7013a@linux.intel.com>
References: <20240905180231.20920-1-skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-47391373-1725617578=:1053"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-47391373-1725617578=:1053
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 Sep 2024, Shuah Khan wrote:

> When resctrl is built on architectures without __cpuid_count()
> support, build fails. resctrl uses __cpuid_count() defined in
> kselftest.h.
>=20
> Even though the problem is seen while building resctrl on aarch64,
> this error can be seen on any platform that doesn't support CPUID.
>=20
> CPUID is a x86/x86-64 feature and code paths with CPUID asm commands
> will fail to build on all other architectures.
>=20
> All others tests call __cpuid_count() do so from x86/x86_64 code paths
> when _i386__ or __x86_64__ are defined. resctrl is an exception.
>=20
> Fix the problem by defining __cpuid_count() only when __i386__ or
> __x86_64__ are defined in kselftest.h and changing resctrl to call
> __cpuid_count() only when __i386__ or __x86_64__ are defined.
>=20
> In file included from resctrl.h:24,
>                  from cat_test.c:11:
> In function =E2=80=98arch_supports_noncont_cat=E2=80=99,
>     inlined from =E2=80=98noncont_cat_run_test=E2=80=99 at cat_test.c:326=
:6:
> ../kselftest.h:74:9: error: impossible constraint in =E2=80=98asm=E2=80=
=99
>    74 |         __asm__ __volatile__ ("cpuid\n\t"                        =
       \
>       |         ^~~~~~~
> cat_test.c:304:17: note: in expansion of macro =E2=80=98__cpuid_count=E2=
=80=99
>   304 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>       |                 ^~~~~~~~~~~~~
> ../kselftest.h:74:9: error: impossible constraint in =E2=80=98asm=E2=80=
=99
>    74 |         __asm__ __volatile__ ("cpuid\n\t"                        =
       \
>       |         ^~~~~~~
> cat_test.c:306:17: note: in expansion of macro =E2=80=98__cpuid_count=E2=
=80=99
>   306 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>=20
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Reported-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

When the small things from Muhammad and Reinette addressed, this seems=20
okay.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Thanks for the solution.


I'm still left to wonder if the x86 selftest is supposed to clobber=20
CFLAGS? It seems that problem is orthogonal to this cpuid/resctrl problem.
I mean this question from the perspective of coherency in the entire=20
kselftest framework, lib.mk seems to want to adjust CFLAGS but those
changes will get clobbered in the case of x86 selftest.

--=20
 i.

> ---
>  tools/testing/selftests/kselftest.h        | 2 ++
>  tools/testing/selftests/resctrl/cat_test.c | 6 ++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftest=
s/kselftest.h
> index b8967b6e29d5..e195ec156859 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -61,6 +61,7 @@
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>  #endif
> =20
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
>  /*
>   * gcc cpuid.h provides __cpuid_count() since v4.4.
>   * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
> @@ -75,6 +76,7 @@
>  =09=09=09      : "=3Da" (a), "=3Db" (b), "=3Dc" (c), "=3Dd" (d)=09\
>  =09=09=09      : "0" (level), "2" (count))
>  #endif
> +#endif /* end arch */
> =20
>  /* define kselftest exit codes */
>  #define KSFT_PASS  0
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/s=
elftests/resctrl/cat_test.c
> index 742782438ca3..ae3f0fa5390b 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -290,12 +290,12 @@ static int cat_run_test(const struct resctrl_test *=
test, const struct user_param
> =20
>  static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>  {
> -=09unsigned int eax, ebx, ecx, edx;
> -
>  =09/* AMD always supports non-contiguous CBM. */
>  =09if (get_vendor() =3D=3D ARCH_AMD)
>  =09=09return true;
> =20
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
> +=09unsigned int eax, ebx, ecx, edx;
>  =09/* Intel support for non-contiguous CBM needs to be discovered. */
>  =09if (!strcmp(test->resource, "L3"))
>  =09=09__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> @@ -305,6 +305,8 @@ static bool arch_supports_noncont_cat(const struct re=
sctrl_test *test)
>  =09=09return false;
> =20
>  =09return ((ecx >> 3) & 1);
> +#endif /* end arch */
> +=09return false;
>  }
> =20
>  static int noncont_cat_run_test(const struct resctrl_test *test,
>=20
--8323328-47391373-1725617578=:1053--

