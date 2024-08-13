Return-Path: <linux-kselftest+bounces-15198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E0B94FEE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 09:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE221C20881
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 07:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E049A69DFF;
	Tue, 13 Aug 2024 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UU82zFBI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7C74063;
	Tue, 13 Aug 2024 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534766; cv=none; b=RvsMoJqYT4L9u2SJPALYq2Gqpdr0iga7ODTuqLUJ+5xBMIJw0f4f3aTisf+xZvc8iGgWLtaQCzbm3STxPA5+Lmru62GsU/qxZBGOjIprYepLXSXrSt5xzcN4b5OJ6Ttv3fVlGHHf5acvApuveZYdNOePj1IB6Dv9wn4wQAVSLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534766; c=relaxed/simple;
	bh=HudMoEVVJ9RYhASXj4oJSNLL0uNoGN5YaTa3GCUYrds=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qt0ivQRVwwaRt+GO7N4s/oC1Yh6+Ip+lRBD+3smehV9LX+lSwCDh3fQXguabpbofGySCNpOJXypRARX9OJm6XCRHuP99zB+16QxLkTSKnSjEhIRiZ5PjHEecOrHxAFrj6lmiEBuQULkNI/pCNA8QKt0LeGwFesbi1n3OErw7jyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UU82zFBI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723534765; x=1755070765;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HudMoEVVJ9RYhASXj4oJSNLL0uNoGN5YaTa3GCUYrds=;
  b=UU82zFBIIHQureH4vntQOphvXLUvw9TVh1Lz7IZsaUVi1073mELmK3Xz
   Zai1MB+Rp0EBAVIQbzmBJlNueR/6qDwgsUKLpxSHgm3iFaSnetdHfXJ7o
   Ykl0jIOBcnmeWUaRqzF2Byu4XYl6kqei+X4ZzE/D2aYRyp72zlr8fvslz
   G9rR4OaZdo0wm2f9FCljLJuHJ/lhjS4NILRIzZ7HXdcr8rXGhnarB+TON
   9evgNcNeRKLP7J97EMYSaZkeKwg0E2w6ve45XeYta4WoREEWjn2HZNs7V
   9NlwOPqWVGOOIPjntEuNktiVV+DCf7LnXBsXg2rg+UIXahj0AIfI5Pubk
   Q==;
X-CSE-ConnectionGUID: xN7gaHeSTM+mBhixaMntUw==
X-CSE-MsgGUID: nLJSAd+zR5i7cKAgodAuOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="47083394"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="47083394"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:39:24 -0700
X-CSE-ConnectionGUID: O6w8UFNVR7Wf7PeOa2Gvvg==
X-CSE-MsgGUID: OJzKQbVGR/qUe0PYgARFMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58261772"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:39:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 13 Aug 2024 10:39:16 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: Shuah Khan <skhan@linuxfoundation.org>, 
    Muhammad Usama Anjum <Usama.Anjum@collabora.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, kernel@collabora.com, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>
Subject: Re: [PATCH] selftests: resctrl: ignore builds for unsupported
 architectures
In-Reply-To: <6dd1b5ce-2ce2-4d61-beff-a100da213528@intel.com>
Message-ID: <da87fe73-c39d-8b60-753d-7735c9abf569@linux.intel.com>
References: <20240809071059.265914-1-usama.anjum@collabora.com> <d60cf782-9ab0-ed4a-0b3e-ba7a73ae8d51@linux.intel.com> <080c4692-c53c-417f-9975-0b4ced0b044c@collabora.com> <f7593344-203a-8e73-d53e-574ca511d003@linux.intel.com> <4072bf51-1d37-4595-a2fa-b72f83c8298b@linuxfoundation.org>
 <6dd1b5ce-2ce2-4d61-beff-a100da213528@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1877984724-1723534756=:963"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1877984724-1723534756=:963
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 12 Aug 2024, Reinette Chatre wrote:
> On 8/12/24 3:49 PM, Shuah Khan wrote:
> > On 8/9/24 02:45, Ilpo J=C3=A4rvinen wrote:
> > > Adding Maciej.
> > >=20
> > > On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
> > > > On 8/9/24 12:23 PM, Ilpo J=C3=A4rvinen wrote:
> > > > > On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
> > > > >=20
> > > > > > This test doesn't have support for other architectures. Altough
> > > > > > resctrl
> > > > > > is supported on x86 and ARM, but arch_supports_noncont_cat() sh=
ows
> > > > > > that
> > > > > > only x86 for AMD and Intel are supported by the test.
> > > > >=20
> > > > > One does not follow from the other. arch_supports_noncont_cat() i=
s
> > > > > only
> > > > > small part of the tests so saying "This test" based on a small su=
bset
> > > > > of
> > > > > all tests is bogus. Also, I don't see any reason why ARCH_ARM cou=
ld
> > > > > not be
> > > > > added and arch_supports_noncont_cat() adapted accordingly.
> > > > I'm not familiar with resctrl and the architectural part of it. Fee=
l
> > > > free to fix it and ignore this patch.
> > > >=20
> > > > If more things are missing than just adjusting
> > > > arch_supports_noncont_cat(), the test should be turned off until pr=
oper
> > > > support is added to the test.
> > > >=20
> > > > > > We get build
> > > > > > errors when built for ARM and ARM64.
> > > > >=20
> > > > > As this seems the real reason, please quote any errors when you u=
se
> > > > > them
> > > > > as justification so it can be reviewed if the reasoning is sound =
or
> > > > > not.
> > > >=20
> > > > =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resctrl_tests
> > > > In file included from resctrl.h:24,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from cat_test.c:11:
> > > > In function 'arch_supports_noncont_cat',
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 inlined from 'noncont_cat_run_test' at cat=
_test.c:323:6:
> > > > ../kselftest.h:74:9: error: impossible constraint in 'asm'
> > > > =C2=A0=C2=A0=C2=A0 74 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __asm__ __volatile__ ("cpuid\n\t"
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~
> > > > cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
> > > > =C2=A0=C2=A0 301 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __cpuid_count(0x10, 1, eax=
, ebx, ecx, edx);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~=
~~~~~~~~
> > > > ../kselftest.h:74:9: error: impossible constraint in 'asm'
> > > > =C2=A0=C2=A0=C2=A0 74 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __asm__ __volatile__ ("cpuid\n\t"
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~
> > > > cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
> > > > =C2=A0=C2=A0 303 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __cpuid_count(0x10, 2, eax=
, ebx, ecx, edx);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~=
~~~~~~~~
> > >=20
> > > Okay, so it's specific to lack of CPUID. This seems a kselftest commo=
n
> > > level problem to me, since __cpuid_count() is provided in kselftest.h=
=2E
> > >=20
> > > Shuah (or others), what is the intended mechanism for selftests to kn=
ow if
> > > it can be used or not since as is, it's always defined?
> > _cpuid_count() gets defined in ksefltest.h if it can't find it.
> >=20
> > As the comment says both gcc and cland probide __cpuid_count()
> >=20
> >  =C2=A0 gcc cpuid.h provides __cpuid_count() since v4.4.
> >  =C2=A0 Clang/LLVM cpuid.h provides=C2=A0 __cpuid_count() since v3.4.0.
> >=20
> > >=20
> > > I see some Makefiles use compile testing a trivial program to decide
> > > whether
> > > they build some x86_64 tests or not. Is that what should be done here=
 too,
> > > test if __cpuid_count() compiles or not (and then build some #ifdeffe=
ry
> > > based on the result of that compile testing)?
> > >=20
> >=20
> > These build errors need to be fixed instead of restricting the build> I=
n
> > some cases when the test can't be supported on an architecture then it =
is
> > okay
> > to suppress build. This is not a general solution to suppress build war=
nings
>=20
> While there is an effort to support Arm in resctrl [1], this is not curre=
ntly
> the case and the resctrl selftests as a consequence only support x86 with
> built-in assumptions that a test runs on either AMD or Intel. After the k=
ernel
> gains support
> for Arm more changes will be needed for the resctrl tests to support anot=
her
> architecture
> so I do think the most appropriate change to address this build failure i=
s to
> restrict
> resctrl tests to x86.

While ARM lacks resctrl support at the moment (the patch BTW claims=20
otherwise), this problem is general-level problem in selftests. When=20
somebody includes kselftest.h, the header provided __cpuid_count() which=20
seems to not be compilable on ARMs (even if the test itself would never=20
call it on other than when running on Intel). Some #ifdeffery is necessary=
=20
either in kselftest.h or in the test code.

> > I would recommend against adding suppress build code when it can be fix=
ed.
>=20
> I expect after resctrl fs obtains support for Arm the resctrl selftests c=
an be
> updated to support it with more fine grained architectural checks than a
> global
> enable/disable needed at this time.

That won't help to a build failure. The build would fail on ARM even if=20
there's some resctrl specific test for arch done by the test itself.

> > Let's investigate this problem to fix it properly. I don't see any arm =
and
> > arm64
> > maintainers and developers on this thread. It would be good to investig=
ate
> > to
> > see if this can be fixed.

Yes, I was hoping there would be a general level solution which would=20
provide e.g. HAS_CPUID_COUNT or an empty stub for __cpuid_count() or=20
something along those lines.

--=20
 i.

> [1] https://lore.kernel.org/lkml/20240802172853.22529-1-james.morse@arm.c=
om/

--8323328-1877984724-1723534756=:963--

