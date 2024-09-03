Return-Path: <linux-kselftest+bounces-17039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0D96999C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 11:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70613288B29
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30E51AD244;
	Tue,  3 Sep 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+1bPYE1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8719F42D;
	Tue,  3 Sep 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357437; cv=none; b=EsP46DEzbAfRMYExtq7tqCWKE1yABEo7duskpoaNyg34QjU0yHCL/n3z99PlyyAwj5x/EjrLnJWxii1Y4U36uKXMIUW2+FT1EMKLN+dJSn1kHFitDp6ALB+8ULhFjmNdgX6U8NvsTxVg9xHOuuZ9KAwypFb+r8zq/clKwEdK8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357437; c=relaxed/simple;
	bh=Dhc0Rno5dkN4+bMHEdlsFwHGveAX8+TOxrWJYyeLK5Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HyQuuPOAoLwlbCTp7gGoz7LqfivK/600OlW5YQydRh3coPT85cdJTqwzi4XDRwvxkQnOdrLwaBIbpQJmC0aGy37nPrtQpCDELlFJD8HUu+XB4+WeH24nFyTuTDDBm8akcc52d+JVlbOjbVtyYk6yjXyCyofyM8jckJDyH7VJdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+1bPYE1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725357437; x=1756893437;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Dhc0Rno5dkN4+bMHEdlsFwHGveAX8+TOxrWJYyeLK5Q=;
  b=B+1bPYE1qFd8EENOUvNB0XsKP1quSZJA+mU/XrJr7A1HAdKwU8Xf5fsg
   FXaB1XTkNObW8KLzTWaThCWKcFU5Yr/yPUQTBBvYMjzu2x0saumzvjK+G
   Tc5fxuwduwFh2DaVqEGrCQc0/rN9mWFfb0Cjdfw+BIfJpu1XLyP9EA6Yd
   2bC6jyx20ZUYfOhUFy6/AbwjoFnAquJb+qh88nvT4FCcLg/2yUqUckBBX
   8fITMoY8sz6nhaSm7zhGO1ud5duUilaXih4b5jt6mlwtcrSPHzpUpStQx
   mkh9iOdMSm9aIjFjQTcGXO4bzFdn28VU4GsocyJ+coLMSNccSuIclu393
   A==;
X-CSE-ConnectionGUID: B96ikU3wQLy0O58A5EZtOQ==
X-CSE-MsgGUID: tKSi+rQfRASL2YOBqEO4Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24061258"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="24061258"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 02:57:16 -0700
X-CSE-ConnectionGUID: 30JnPS4CQx6Kp89jb109Bg==
X-CSE-MsgGUID: pkzHifvrR1WlwrR3jl2OLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="95654556"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.241])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 02:57:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Sep 2024 12:57:08 +0300 (EEST)
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
    Shuah Khan <shuah@kernel.org>
cc: Reinette Chatre <reinette.chatre@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>
Subject: Re: [PATCH v3 3/3] kselftest: Provide __cpuid_count() stub on non-x86
 archs
In-Reply-To: <20240829131657.1917-4-ilpo.jarvinen@linux.intel.com>
Message-ID: <474fb657-15a8-3fb1-c769-2269f772d8cd@linux.intel.com>
References: <20240829131657.1917-1-ilpo.jarvinen@linux.intel.com> <20240829131657.1917-4-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1248195342-1725357428=:1019"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1248195342-1725357428=:1019
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 29 Aug 2024, Ilpo J=C3=A4rvinen wrote:

> Building resctrl selftest fails on ARM because it uses __cpuid_count()
> that fails the build with error:
>=20
>   CC       resctrl_tests
> In file included from resctrl.h:24,
>                  from cat_test.c:11:
> In function 'arch_supports_noncont_cat',
>     inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>    74 |         __asm__ __volatile__ ("cpuid\n\t"       \
>       |         ^~~~~~~
> cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
>   301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>       |                 ^~~~~~~~~~~~~
> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>    74 |         __asm__ __volatile__ ("cpuid\n\t"       \
>       |         ^~~~~~~
> cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
>   303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>       |                 ^~~~~~~~~~~~~
>=20
> The resctrl selftest would run that code only on Intel CPUs but as is,
> the code cannot be build at all.
>=20
> Define HAVE_CPUID in lib.mk based on ARCH (x86 or x86_64). If ARCH is
> not set, acquire it using uname -m.
>=20
> Provide a stub for __cpuid_count() if HAVE_CPUID is not present to
> allow build to succeed. The stub casts its arguments to void to avoid
> causing "unused variable" or "set but not used" warnings.
>=20
> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test=
")
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
> v3:
> - Remove "empty" wording
> - Also cast input parameters to void
> - Initialize ARCH from uname -m if not set (this might allow cleaning
>   up some other makefiles but that is left as future work)
> v2:
> - Removed RFC & added Fixes and Tested-by
> - Fixed the error message's line splits
> - Noted down the reason for void casts in the stub
> ---
>  tools/testing/selftests/kselftest.h | 6 ++++++
>  tools/testing/selftests/lib.mk      | 6 ++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftest=
s/kselftest.h
> index b8967b6e29d5..9c4bfbf107f1 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -70,10 +70,16 @@
>   * have __cpuid_count().
>   */
>  #ifndef __cpuid_count
> +#ifdef HAVE_CPUID
>  #define __cpuid_count(level, count, a, b, c, d)=09=09=09=09\
>  =09__asm__ __volatile__ ("cpuid\n\t"=09=09=09=09\
>  =09=09=09      : "=3Da" (a), "=3Db" (b), "=3Dc" (c), "=3Dd" (d)=09\
>  =09=09=09      : "0" (level), "2" (count))
> +#else
> +#define __cpuid_count(level, count, a, b, c, d)=09do {=09=09=09\
> +=09(void)level; (void)count; (void)a; (void)b; (void)c; (void)d;=09\
> +} while (0)
> +#endif
>  #endif
> =20
>  /* define kselftest exit codes */
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib=
=2Emk
> index d6edcfcb5be8..8e3069926153 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -23,6 +23,8 @@ CLANG_TARGET_FLAGS_x86_64       :=3D x86_64-linux-gnu
> =20
>  # Default to host architecture if ARCH is not explicitly given.
>  ifeq ($(ARCH),)
> +ARCH :=3D $(shell uname -m 2>/dev/null || echo not)
> +ARCH :=3D $(shell echo $(ARCH) | sed -e s/i.86/x86/)
>  CLANG_TARGET_FLAGS :=3D $(shell $(CLANG) -print-target-triple)
>  else
>  CLANG_TARGET_FLAGS :=3D $(CLANG_TARGET_FLAGS_$(ARCH))
> @@ -199,6 +201,10 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
>  # Build with _GNU_SOURCE by default
>  CFLAGS +=3D -D_GNU_SOURCE=3D
> =20
> +ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> +CFLAGS +=3D -DHAVE_CPUID=3D
> +endif

Hpmf, scratch this. CFLAGS are overwritten by x86 selftest makefile so I=20
need to reorder things there before making this change.

--=20
 i.

--8323328-1248195342-1725357428=:1019--

