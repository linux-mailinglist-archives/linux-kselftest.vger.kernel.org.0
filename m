Return-Path: <linux-kselftest+bounces-16261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EEA95EEB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 12:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5749B281C44
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838B414D6ED;
	Mon, 26 Aug 2024 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4g3zboW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A3149DE8;
	Mon, 26 Aug 2024 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669101; cv=none; b=pXIabPUJoP9IqA0fiuuWngm/fODD7inywiQmWza2g+7kry4vwMx57ZQa5r3gpUINaPo3iBsHXUpclatjdGOSlk7Jvn5ZQa+SIyP3+fnZN7d3V+4s+tnyvDNA42+hJbqXiRvJgNRvDMIyv1GwW54aPU4Zgq5lT4IKN8MOt1O7uio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669101; c=relaxed/simple;
	bh=WTWzvtlUpISk0FlzyPLUn1JHhHWyrpidRbuVnrf+I9o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m7Imcu2k51fFfrjh8BS34Stm8mmN1aLwwcmKCrp1EzAwsqTXteQ2Eqat4yZ9wzPyL/usTziHfgy4XDSDiTvEdH0jctY1guElWRJsfGSsu5Lhi9Nqg1M7nKUH55/uv3ebfi2byKwEwyXxdqr75TQrRzSDr2Vp0MjrI+YWfV1mgSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4g3zboW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724669099; x=1756205099;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=WTWzvtlUpISk0FlzyPLUn1JHhHWyrpidRbuVnrf+I9o=;
  b=B4g3zboWQ0H1/GtX3A7XZ5Zpz0No+b3/VxklC3W2zK0xusB8J58tjiLd
   Vp7r4cnrn4gKhe4X+OCTgmwDpQZT7x8zYe1wVpSiT5Bnj+apF68al5gW1
   8Q9tymoy/Aa14YvYPX75uGMRBPErPjjUMVUpVjzkrQJvNwgOvAVWEtCzp
   Ti/LmRqypsUXcazjoMQq5/fkr09+2toiKPEPWfzkU5ZrOdGT6evTLZQV0
   jJToV8ua3FqMs4FxKhmEIzyEOg4A5fwNz0o30ft8TtfmF8EI4QHF4d+nV
   e4saYEqeREVF7Y+lAgOeUv5mQRtD2xvQLvIt4TssK6Nl928+mfc73dVJw
   w==;
X-CSE-ConnectionGUID: HoOeTlP6TySfNEFCj5DcRw==
X-CSE-MsgGUID: Xz+W1wknQSOC4h+fIfksow==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22670578"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="22670578"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:44:59 -0700
X-CSE-ConnectionGUID: mu0A8UPCTB+oTgK0ua+wVg==
X-CSE-MsgGUID: 9KIgFfJWSIurBtPDVzDPgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="66644552"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:44:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Aug 2024 13:44:52 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
    Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 3/3] kselftest: Provide __cpuid_count() stub on non-x86
 archs
In-Reply-To: <d25ef936-4cf4-42f7-bccc-54b8e7e590d1@intel.com>
Message-ID: <0e315405-6b69-bde6-0f3c-aba0086c11dd@linux.intel.com>
References: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com> <20240822081114.4695-4-ilpo.jarvinen@linux.intel.com> <cd09f5e0-2353-4223-b02c-aa8461c1dbe5@intel.com> <3f75d979-44f9-6386-85df-e45214f7da7e@linux.intel.com>
 <d25ef936-4cf4-42f7-bccc-54b8e7e590d1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-89352010-1724663584=:1013"
Content-ID: <ee26608b-a366-5462-82b1-2d507cf7b668@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-89352010-1724663584=:1013
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e8c13bb7-effb-337d-aaaa-ddde7f87f46d@linux.intel.com>

On Fri, 23 Aug 2024, Reinette Chatre wrote:
> On 8/23/24 3:47 AM, Ilpo J=E4rvinen wrote:
> > On Thu, 22 Aug 2024, Reinette Chatre wrote:
> > > On 8/22/24 1:11 AM, Ilpo J=E4rvinen wrote:
> > > > Building resctrl selftest fails on ARM because it uses __cpuid_coun=
t()
> > > > that fails the build with error:
> > > >=20
> > > >     CC       resctrl_tests
> > > > In file included from resctrl.h:24,
> > > >                    from cat_test.c:11:
> > > > In function 'arch_supports_noncont_cat',
> > > >       inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
> > > > ../kselftest.h:74:9: error: impossible constraint in 'asm'
> > > >      74 |         __asm__ __volatile__ ("cpuid\n\t"       \
> > > >         |         ^~~~~~~
> > > > cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
> > > >     301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx=
);
> > > >         |                 ^~~~~~~~~~~~~
> > > > ../kselftest.h:74:9: error: impossible constraint in 'asm'
> > > >      74 |         __asm__ __volatile__ ("cpuid\n\t"       \
> > > >         |         ^~~~~~~
> > > > cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
> > > >     303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx=
);
> > > >         |                 ^~~~~~~~~~~~~
> > > >=20
> > > > The resctrl selftest would run that code only on Intel CPUs but
> > > > as is, the code cannot be build at all.
> > > >=20
> > > > Provide an empty stub for __cpuid_count() if it is not supported to
> > > > allow build to succeed. The stub casts its arguments to void to avo=
id
> > > > causing variable unused warnings.
> > > >=20
> > > > Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CA=
T
> > > > test")
> > > > Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > > Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > > ---
> > > >=20
> > > > v2:
> > > > - Removed RFC & added Fixes and Tested-by
> > > > - Fixed the error message's line splits
> > > > - Noted down the reason for void casts in the stub
> > > > ---
> > > >    tools/testing/selftests/kselftest.h | 6 ++++++
> > > >    tools/testing/selftests/lib.mk      | 4 ++++
> > > >    2 files changed, 10 insertions(+)
> > > >=20
> > > > diff --git a/tools/testing/selftests/kselftest.h
> > > > b/tools/testing/selftests/kselftest.h
> > > > index b8967b6e29d5..71593add1b39 100644
> > > > --- a/tools/testing/selftests/kselftest.h
> > > > +++ b/tools/testing/selftests/kselftest.h
> > > > @@ -70,10 +70,16 @@
> > > >     * have __cpuid_count().
> > > >     */
> > > >    #ifndef __cpuid_count
> > > > +#ifdef HAVE_CPUID
> > > >    #define __cpuid_count(level, count, a, b, c, d)
> > > > \
> > > >    =09__asm__ __volatile__ ("cpuid\n\t"
> > > > \
> > > >    =09=09=09      : "=3Da" (a), "=3Db" (b), "=3Dc" (c), "=3Dd" (d)
> > > > \
> > > >    =09=09=09      : "0" (level), "2" (count))
> > > > +#else
> > > > +#define __cpuid_count(level, count, a, b, c, d)=09do {
> > > > \
> > > > +=09(void)a; (void)b; (void)c; (void)d;=09=09=09=09\
> > >=20
> > > The changelog states that this casting to void is done to avoid unuse=
d
> > > variable warnings.
> > > It is thus unexpected that not all parameters obtain the same casting
> > > treatment. It looks
> > > to me as though this only targets the resctrl selftest usage where th=
e
> > > "level"
> > > and "count"
> > > parameters are constants.
> >=20
> > The reason is entirely separate from what resctrl selftest expects.
> > a-d are output parameters for __cpuid_count(), they need this treatment
> > because they are typically not initialized but set by __cpuid_count() s=
o
> > if __cpuid_count() is doing literally nothing, nothing touches those
> > four variables leading to unused variable warning.
> >=20
> > > This is intended as a general kselftest solution so
> > > I believe
> > > that all parameters would need this casting to handle the cases where
> > > "level"
> > > and/or
> > > "count" are variables.
> >=20
> > No, the same issue does not exist for input parameters because it would=
 be
> > a valid warning. Passing uninitialized (and thus unused) input variable
> > is wrong so the calling logic is wrong. Thus, I don't see how the same
> > error could ever occur in a legitimate case for those two parameters.
>=20
> If I understand correctly, the scenarios below are legitimate cases and
> will produce compile warnings with this patch applied. It is not obvious
> to me that the calling logic is wrong in these cases. If the output
> parameters get special treatment to avoid compile warnings, should input
> parameters not also?
>=20
> scenario 1:
> =09unsigned int level =3D 0x10, count =3D 1;
> =09unsigned int a, b, c, d;
>=20
> =09__cpuid_count(level, count, a, b, c ,d);
>=20
> Above produces "unused variable" warnings for level and count.
>=20
> scenario 2:
> =09unsigned int level, count, a, b, c, d;
>=20
> =09level =3D 0x10;
> =09count =3D 1;
> =09__cpuid_count(level, count, a, b, c ,d);
>=20
> Above produces "set but not used" warnings for level and count.

Ah, so you meant a different warning. Yes, I'll add void casts for=20
those input parameters as well to avoid this.

> The changelog states that the goal of this change is to produce an
> empty stub. To me this creates expectation of what we are used to
> and expect from if it would be an actual empty stub. For example,
> static inline void __cpuid_count(unsigned level, unsigned count,
> =09=09=09=09 unsigned int a, unsigned b,
> =09=09=09=09 unsigned int c, unsigned d) { }

For void functions, yes. But if it would return int, it wouldn't be=20
literally "empty", that is, it is still be empty stub but does something=20
so a very literal interpretation of "empty" is flawed anyway. But I can=20
drop empty word from there, "stub" seems enough for the purpose.

If you on the other hand meant macros cannot be called "stub", what should=
=20
they be called if not "stub"?

> > > > +} while (0)
> > > > +#endif
> > > >    #endif
> > > >      /* define kselftest exit codes */
> > > > diff --git a/tools/testing/selftests/lib.mk
> > > > b/tools/testing/selftests/lib.mk
> > > > index d6edcfcb5be8..236db9b24037 100644
> > > > --- a/tools/testing/selftests/lib.mk
> > > > +++ b/tools/testing/selftests/lib.mk
> > > > @@ -199,6 +199,10 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_di=
r)
> > > >    # Build with _GNU_SOURCE by default
> > > >    CFLAGS +=3D -D_GNU_SOURCE=3D
> > > >    +ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> > > > +CFLAGS +=3D -DHAVE_CPUID=3D
> > > > +endif
> > >=20
> > > My earlier comment [1] when this work started remains. This technique
> > > depends
> > > on environment passing ARCH, which cannot be guaranteed. Looking at o=
ther
> > > usages of ARCH in the kselftest Makefiles it seems that the pattern i=
s to
> > > initialize ARCH with "uname -m" if unset.
> > >=20
> > > > +
> > > >    # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
> > > >    # make USERCFLAGS=3D-Werror USERLDFLAGS=3D-static
> > > >    CFLAGS +=3D $(USERCFLAGS)
> > >=20
> > > Reinette
> > >=20
> > > [1]
> > > https://lore.kernel.org/lkml/db16db55-5f68-484f-ba9f-3312b41bf426@int=
el.com/
> >=20
> > Ah, sorry. I'd missed that comment because it started mid-paragraph.
>=20
> Where are comments required to start?

Obviously it's not a requirement, but I'd put each recommendation into own=
=20
paragraph to maximize likelihoods its not missed. Despite the paragraph=20
containing answers to two different questions, my mind I only registered=20
the answer for the trivial program question. Again, I'm sorry about that.

--=20
 i.
--8323328-89352010-1724663584=:1013--

