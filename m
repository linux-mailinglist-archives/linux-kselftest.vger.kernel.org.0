Return-Path: <linux-kselftest+bounces-16141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04AD95CAC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 12:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BA228405A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D459187563;
	Fri, 23 Aug 2024 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibkeJOep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2A13D521;
	Fri, 23 Aug 2024 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410081; cv=none; b=Ka3M4TYHy+lAoj9/1JoUaWezzRQnSwbjGvuXtkopieaAEWUHJ+Yvnz6TTsEH41utnL1j0jFaCIRy81Dak+eTca1zJ/dfJfPTasqbpaLMRxrTau+eVp2Geom7ZfuLywW1kPgNyvGQUQNJKUonDsqM+eGfZuNvkNfNoFJYjp73tck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410081; c=relaxed/simple;
	bh=NKm3f1B9QJ6K69xxHvh7IgtXJY+ohX6aX8m8wLn6acU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GHnse7EalOTmIHnUBZMW03GzqmPtPMMRv315jmuAjiXCVxANJhYHLtte3q4AvPxiImeVA/b7ilGrw9rbYNSAXf2MGqesYxhwK4rBUQqnv2vU9PJXQ/5DAmfEie5n8YE+V9IRO+VgCbBbcKJ9EZafDcvzcUh74B6Y50ndFH9oO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibkeJOep; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724410079; x=1755946079;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=NKm3f1B9QJ6K69xxHvh7IgtXJY+ohX6aX8m8wLn6acU=;
  b=ibkeJOep4an6MlghVnhbHorUzTXDSxAf77Bo/OfLI3QiGOdosEuAIpKF
   d+Td0TsqCc72OiPA3zHppliAk03UBRi+yYgnhyGgZvWs/QkhT6Riwr7xL
   70pL2RjcvbumQWA9A9vQ8NbscSVfWfKMTmEI2Ut95c9UGNrc0PBPn6UYI
   TpiGXdtXME0l5w6NsLQCMLReYHxJB1Jrs4m/Y+hS+fQjRJKe2vGg1i7M5
   Rlefj5l03VwBubx5+V6z0LgZ/cPG76UTFkoIn8mW+tCqgLFAZSNin4SjW
   +Sq3ZxvGYERWHHULgczB3tRs9P5khDSFwtUXbAsItEzLO74E6oVYbX2F/
   g==;
X-CSE-ConnectionGUID: u3Fs8ddgSrSjQt97crT28A==
X-CSE-MsgGUID: mqmkBf7aSWeWKnH2Eia70Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22394220"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="22394220"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 03:47:58 -0700
X-CSE-ConnectionGUID: ddgtkcR0TCGB+IRDQ/XVzw==
X-CSE-MsgGUID: 0DsskcZgShOrlbVorBl7sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="65969012"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.2])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 03:47:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Aug 2024 13:47:51 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
    Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 3/3] kselftest: Provide __cpuid_count() stub on non-x86
 archs
In-Reply-To: <cd09f5e0-2353-4223-b02c-aa8461c1dbe5@intel.com>
Message-ID: <3f75d979-44f9-6386-85df-e45214f7da7e@linux.intel.com>
References: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com> <20240822081114.4695-4-ilpo.jarvinen@linux.intel.com> <cd09f5e0-2353-4223-b02c-aa8461c1dbe5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1295042213-1724410012=:2230"
Content-ID: <3f24d78d-0267-2b58-a6a0-321fe52b826b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1295042213-1724410012=:2230
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <b1624f03-7646-ddf5-677a-9ae3886cbdc7@linux.intel.com>

On Thu, 22 Aug 2024, Reinette Chatre wrote:

> Hi Ilpo,
>=20
> On 8/22/24 1:11 AM, Ilpo J=E4rvinen wrote:
> > Building resctrl selftest fails on ARM because it uses __cpuid_count()
> > that fails the build with error:
> >=20
> >    CC       resctrl_tests
> > In file included from resctrl.h:24,
> >                   from cat_test.c:11:
> > In function 'arch_supports_noncont_cat',
> >      inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
> > ../kselftest.h:74:9: error: impossible constraint in 'asm'
> >     74 |         __asm__ __volatile__ ("cpuid\n\t"       \
> >        |         ^~~~~~~
> > cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
> >    301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> >        |                 ^~~~~~~~~~~~~
> > ../kselftest.h:74:9: error: impossible constraint in 'asm'
> >     74 |         __asm__ __volatile__ ("cpuid\n\t"       \
> >        |         ^~~~~~~
> > cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
> >    303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> >        |                 ^~~~~~~~~~~~~
> >=20
> > The resctrl selftest would run that code only on Intel CPUs but
> > as is, the code cannot be build at all.
> >=20
> > Provide an empty stub for __cpuid_count() if it is not supported to
> > allow build to succeed. The stub casts its arguments to void to avoid
> > causing variable unused warnings.
> >=20
> > Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT te=
st")
> > Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> >=20
> > v2:
> > - Removed RFC & added Fixes and Tested-by
> > - Fixed the error message's line splits
> > - Noted down the reason for void casts in the stub
> > ---
> >   tools/testing/selftests/kselftest.h | 6 ++++++
> >   tools/testing/selftests/lib.mk      | 4 ++++
> >   2 files changed, 10 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/kselftest.h
> > b/tools/testing/selftests/kselftest.h
> > index b8967b6e29d5..71593add1b39 100644
> > --- a/tools/testing/selftests/kselftest.h
> > +++ b/tools/testing/selftests/kselftest.h
> > @@ -70,10 +70,16 @@
> >    * have __cpuid_count().
> >    */
> >   #ifndef __cpuid_count
> > +#ifdef HAVE_CPUID
> >   #define __cpuid_count(level, count, a, b, c, d)
> > \
> >   =09__asm__ __volatile__ ("cpuid\n\t"=09=09=09=09\
> >   =09=09=09      : "=3Da" (a), "=3Db" (b), "=3Dc" (c), "=3Dd" (d)=09\
> >   =09=09=09      : "0" (level), "2" (count))
> > +#else
> > +#define __cpuid_count(level, count, a, b, c, d)=09do {
> > \
> > +=09(void)a; (void)b; (void)c; (void)d;=09=09=09=09\
>=20
> The changelog states that this casting to void is done to avoid unused
> variable warnings.
> It is thus unexpected that not all parameters obtain the same casting
> treatment. It looks
> to me as though this only targets the resctrl selftest usage where the "l=
evel"
> and "count"
> parameters are constants.

The reason is entirely separate from what resctrl selftest expects.=20
a-d are output parameters for __cpuid_count(), they need this treatment=20
because they are typically not initialized but set by __cpuid_count() so=20
if __cpuid_count() is doing literally nothing, nothing touches those=20
four variables leading to unused variable warning.

> This is intended as a general kselftest solution so
> I believe
> that all parameters would need this casting to handle the cases where "le=
vel"
> and/or
> "count" are variables.

No, the same issue does not exist for input parameters because it would be=
=20
a valid warning. Passing uninitialized (and thus unused) input variable=20
is wrong so the calling logic is wrong. Thus, I don't see how the same=20
error could ever occur in a legitimate case for those two parameters.

> > +} while (0)
> > +#endif
> >   #endif
> >     /* define kselftest exit codes */
> > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/l=
ib.mk
> > index d6edcfcb5be8..236db9b24037 100644
> > --- a/tools/testing/selftests/lib.mk
> > +++ b/tools/testing/selftests/lib.mk
> > @@ -199,6 +199,10 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
> >   # Build with _GNU_SOURCE by default
> >   CFLAGS +=3D -D_GNU_SOURCE=3D
> >   +ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> > +CFLAGS +=3D -DHAVE_CPUID=3D
> > +endif
>=20
> My earlier comment [1] when this work started remains. This technique dep=
ends
> on environment passing ARCH, which cannot be guaranteed. Looking at other
> usages of ARCH in the kselftest Makefiles it seems that the pattern is to
> initialize ARCH with "uname -m" if unset.
>=20
> > +
> >   # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
> >   # make USERCFLAGS=3D-Werror USERLDFLAGS=3D-static
> >   CFLAGS +=3D $(USERCFLAGS)
>=20
> Reinette
>=20
> [1]
> https://lore.kernel.org/lkml/db16db55-5f68-484f-ba9f-3312b41bf426@intel.c=
om/

Ah, sorry. I'd missed that comment because it started mid-paragraph.

I wonder if I can safely touch ARCH or if there are caveats and it would=20
be better to use some other makefile variable.

--=20
 i.
--8323328-1295042213-1724410012=:2230--

