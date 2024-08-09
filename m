Return-Path: <linux-kselftest+bounces-15062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547DF94CC95
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 10:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54CF1F238B9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E2618E047;
	Fri,  9 Aug 2024 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKomwMlS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8546219E1;
	Fri,  9 Aug 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193159; cv=none; b=hzTHx9LbkYbhd9AM7jMwPPpzOyxHSkCHWlD9L0ET779LfZjSkKmZGrAP+arvs0vu9kq2TMSEFj7vhUJW6xatVdbA4fCZyjUYciOn42L1P3UkwBuYiI/UtIDzBnTmLRBhCU0eWaLy2yIsnN7DCdHnwt6bLp91d0Vj67E1Knjc9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193159; c=relaxed/simple;
	bh=wEhcj53DkrlZmffVI00o4H9SljxYA7hs7RXC4Jh+eTw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rRTyHxqNqEiBubfs6D29pPe1iwrzdkkMh2Qj2zJFDbSJ7wk34shl+xrTk0+LsoOdb5A60SwkttRe/wtncSmRDBlYB59RNd10/nKjabJm+7zNeCfn9TSK9XNg+489IifZ+TkOM4L6AKyN/VWHYtr86wmQisDd0VDgXNUen2yu28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKomwMlS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723193158; x=1754729158;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=wEhcj53DkrlZmffVI00o4H9SljxYA7hs7RXC4Jh+eTw=;
  b=XKomwMlSehdviTSyeLzWhtki1tJscinnJ2LOGUHitxqYPfae12ERMuWz
   WEws7ALLe8RNFnSuzE1v7e6n/3qBQBqV1/RkbBOxrx9I3AaavOzSwY6/E
   HYDoW5VIMwFUjAeqT4Ub0ZdyHPCmJVIiPh8BdDgmwh0Q3iTHr5C7DmQT0
   akHPz9+vv6GsRrFmh5Bs8G1cz1UxZxpy+pxi6XzLzOelse30YE3qbxocm
   TVhILjsKvWtAZEj81wp8uQhC9zD1K8NWsTM/qI5S3tI1yFxAAdaKc/9Vi
   PRn3QQ7QxaPDGZo4r9aBN9BhQAf/PEl1cuPdBTZhY0aPqnewfjOGfOucD
   Q==;
X-CSE-ConnectionGUID: DLz+7GDMQNKHrweEz2x+yg==
X-CSE-MsgGUID: ZoqlrVNcQBmFUs3Ganfc/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32505126"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="32505126"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:45:57 -0700
X-CSE-ConnectionGUID: opBM65RkRL+uosEHDpSRDw==
X-CSE-MsgGUID: QOAfpaoASRm4xvWeXWQ0fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57161883"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.119])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:45:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Aug 2024 11:45:50 +0300 (EEST)
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
cc: Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, kernel@collabora.com, 
    Shuah Khan <skhan@linuxfoundation.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>
Subject: Re: [PATCH] selftests: resctrl: ignore builds for unsupported
 architectures
In-Reply-To: <080c4692-c53c-417f-9975-0b4ced0b044c@collabora.com>
Message-ID: <f7593344-203a-8e73-d53e-574ca511d003@linux.intel.com>
References: <20240809071059.265914-1-usama.anjum@collabora.com> <d60cf782-9ab0-ed4a-0b3e-ba7a73ae8d51@linux.intel.com> <080c4692-c53c-417f-9975-0b4ced0b044c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-280030225-1723192289=:1401"
Content-ID: <e640bbdd-99ee-22b9-28b0-2dfdef844a94@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-280030225-1723192289=:1401
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <961a97e4-08a8-5b5e-d23b-d78ff5216cdc@linux.intel.com>

Adding Maciej.

On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
> On 8/9/24 12:23 PM, Ilpo J=E4rvinen wrote:
> > On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
> >=20
> >> This test doesn't have support for other architectures. Altough resctr=
l
> >> is supported on x86 and ARM, but arch_supports_noncont_cat() shows tha=
t
> >> only x86 for AMD and Intel are supported by the test.
> >=20
> > One does not follow from the other. arch_supports_noncont_cat() is only=
=20
> > small part of the tests so saying "This test" based on a small subset o=
f=20
> > all tests is bogus. Also, I don't see any reason why ARCH_ARM could not=
 be=20
> > added and arch_supports_noncont_cat() adapted accordingly.
> I'm not familiar with resctrl and the architectural part of it. Feel
> free to fix it and ignore this patch.
>=20
> If more things are missing than just adjusting
> arch_supports_noncont_cat(), the test should be turned off until proper
> support is added to the test.
>
> >> We get build
> >> errors when built for ARM and ARM64.
> >=20
> > As this seems the real reason, please quote any errors when you use the=
m=20
> > as justification so it can be reviewed if the reasoning is sound or not=
=2E
>=20
>   CC       resctrl_tests
> In file included from resctrl.h:24,
>                  from cat_test.c:11:
> In function 'arch_supports_noncont_cat',
>     inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>    74 |         __asm__ __volatile__ ("cpuid\n\t"
>        \
>       |         ^~~~~~~
> cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
>   301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>       |                 ^~~~~~~~~~~~~
> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>    74 |         __asm__ __volatile__ ("cpuid\n\t"
>        \
>       |         ^~~~~~~
> cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
>   303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>       |                 ^~~~~~~~~~~~~

Okay, so it's specific to lack of CPUID. This seems a kselftest common=20
level problem to me, since __cpuid_count() is provided in kselftest.h.

Shuah (or others), what is the intended mechanism for selftests to know if=
=20
it can be used or not since as is, it's always defined?

I see some Makefiles use compile testing a trivial program to decide whethe=
r=20
they build some x86_64 tests or not. Is that what should be done here too,=
=20
test if __cpuid_count() compiles or not (and then build some #ifdeffery=20
based on the result of that compile testing)?

--=20
 i.
--8323328-280030225-1723192289=:1401--

