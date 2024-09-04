Return-Path: <linux-kselftest+bounces-17122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561D896BD38
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 14:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C47B2813E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC811DA627;
	Wed,  4 Sep 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6AmiEMz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F411DA102;
	Wed,  4 Sep 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454460; cv=none; b=UqZvSzfUaQh0SSSET4Xt30HpmFDIF5HVtIWUS5fJzSNIYOvZOe3ib4HbtfcHvsmiwnyxMNfxxGv5oGj888QJ41sVSSvZWwArdxAxlLzJVt+ZnSYOH643fOZ68O1zL+taSP4xVLBDC49Zjr4utwZ8vW3cckEgJpSTpzraHEyVHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454460; c=relaxed/simple;
	bh=7n0HW1ku8m0qS9mQNKzVpudzf5X0oCBJHVMHUxY77Bo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g0hnLm1fCTL6KjHJp0EUpESRgs20Ww8NUL+vKuv/M5yRb0O02raYe+PiR5RsvZAtgf69Fnc9Aq4YkT9HQFwge5Cyju5vWq8tFmcuVYGdKDfbzPpw8xe8a/KhwAEiD4Sf3/YgXYDSIdmtioXKrYxU4bJinkNelDDRcGrZoOnLcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6AmiEMz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725454458; x=1756990458;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=7n0HW1ku8m0qS9mQNKzVpudzf5X0oCBJHVMHUxY77Bo=;
  b=d6AmiEMzaArdRsXk8aXDsi+3C3nsVGV1nW+JqTQeLR0vO6eoRvlaICyM
   DRA4z/M5zd8e4IXv+9g4V2WO9py2/pgzwnx2uHM8BtUCEu5n8u7ewmi1T
   At+kPpltuH70LXMKc/zf32pew5qnyHd4GEqb+RRVdeKd1Q22zH1gHWLJ3
   Rqvi7nOppSyZwEleVJ3NMttwhkXKpProlEvPOYuM0Q/cVbn0IB4rFv9Pr
   HT09yWZRfEyspgL62Arp9r6QVUzoRxCRGMyMEik7AsKKtkztAOnzoKToT
   pQSfutwmzwyEC2PP6kVAq3bXUn3oLguatlJou57Y/fmck+z5Q3qfG1jxI
   w==;
X-CSE-ConnectionGUID: F3YFjhbXTFObePSdLSdeRw==
X-CSE-MsgGUID: +7OW0YwNT+KMZMAtXL5hrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35500035"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="35500035"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:54:17 -0700
X-CSE-ConnectionGUID: zQ6bjgPeTYiB1EaCyrqWqw==
X-CSE-MsgGUID: vhu3W/l2QASSq8P7R9u9rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65250961"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.156])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:54:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 4 Sep 2024 15:54:10 +0300 (EEST)
To: Shuah Khan <skhan@linuxfoundation.org>
cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
    Shuah Khan <shuah@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>
Subject: Re: [PATCH v4 0/4] selftests: Fix cpuid / vendor checking build
 issues
In-Reply-To: <b4b7147f-64cf-4244-a896-07a88f08d0f1@linuxfoundation.org>
Message-ID: <d8ffc136-876b-db3f-fc87-a1442e53a451@linux.intel.com>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com> <eadb7bc7-a093-4229-90f0-88b730087666@linuxfoundation.org> <d2a4ca5c-3352-e570-687c-9d7ec90dbe33@linux.intel.com> <b4b7147f-64cf-4244-a896-07a88f08d0f1@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1103726541-1725453948=:1078"
Content-ID: <4f3725b3-8dee-ec78-c7eb-39fd72a4d8b2@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1103726541-1725453948=:1078
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a15f53e5-8ea7-8adf-2573-ac31a10dcaf1@linux.intel.com>

On Wed, 4 Sep 2024, Shuah Khan wrote:

> On 9/4/24 06:18, Ilpo J=E4rvinen wrote:
> > On Tue, 3 Sep 2024, Shuah Khan wrote:
> >=20
> > > On 9/3/24 08:45, Ilpo J=E4rvinen wrote:
> > > > This series first generalizes resctrl selftest non-contiguous CAT c=
heck
> > > > to not assume non-AMD vendor implies Intel. Second, it improves
> > > > selftests such that the use of __cpuid_count() does not lead into a
> > > > build failure (happens at least on ARM).
> > > >=20
> > > > While ARM does not currently support resctrl features, there's an
> > > > ongoing work to enable resctrl support also for it on the kernel si=
de.
> > > > In any case, a common header such as kselftest.h should have a prop=
er
> > > > fallback in place for what it provides, thus it seems justified to =
fix
> > > > this common level problem on the common level rather than e.g.
> > > > disabling build for resctrl selftest for archs lacking resctrl supp=
ort.
> > > >=20
> > > > I've dropped reviewed and tested by tags from the last patch in v3 =
due
> > > > to major changes into the makefile logic. So it would be helpful if
> > > > Muhammad could retest with this version.
> > > >=20
> > > > Acquiring ARCH in lib.mk will likely allow some cleanup into some
> > > > subdirectory makefiles but that is left as future work because this
> > > > series focuses in fixing cpuid/build.
> > >=20
> > > >=20
> > > > v4:
> > > > - New patch to reorder x86 selftest makefile to avoid clobbering CF=
LAGS
> > > >     (would cause __cpuid_count() related build fail otherwise)
> > > >=20
> > > I don't like the way this patch series is mushrooming. I am not
> > > convinced that changes to lib.mk and x86 Makefile are necessary.
> >=20
> > I didn't like it either what I found from the various makefiles. I thin=
k
> > there are many things done which conflict with what lib.mk seems to try=
 to
> > do.
> >=20
>=20
> Some of it by desig. lib.mk offers framework for common things. There
> are provisions to override like in the case of x86, powerpc. lib.mk
> tries to be flexible as well.
>=20
> > I tried to ask in the first submission what test I should use in the
> > header file as I'm not very familiar with how arch specific is done in
> > userspace in the first place nor how it should be done within kselftest
> > framework.
> >=20
>=20
> Thoughts on cpuid:
>=20
> - It is x86 specific. Moving this to kselftest.h was done to avoid
>   duplicate. However now we are running into arm64/arm compile
>   errors due to this which need addressing one way or the other.
>=20
> I have some ideas on how to solve this - but I need answers to
> the following questions.
>=20
> This is a question for you and Usama.
>=20
> - Does resctrl run on arm64/arm and what's the output?
> - Can all other tests in resctrl other tests except
>   noncont_cat_run_test?
> - If so send me the output.

Hi Shuah,

As mentioned in my coverletter above, resctrl does not currently support=20
arm but there's an ongoing work to add arm support. On kernel side it=20
requires major refactoring to move non-arch specific stuff out from=20
arch/x86 so has (predictably) taken long time.

The resctrl selftests are mostly written in arch independent way (*) but=20
there's also a way to limit a test only to CPUs from a particular vendor.
And now this noncont_cat_run_test needs to use cpuid only on Intel CPUs=20
(to read the supported flag), it's not needed even on AMD CPUs as they=20
always support non-contiguous CAT bitmask.

So to summarize, it would be possible to disable resctrl test for non-x86=
=20
but it does not address the underlying problem with cpuid which will just=
=20
come back later I think.

Alternatively, if there's some a good way in C code to do ifdeffery around=
=20
that cpuid call, I could make that too, but I need to know which symbol to=
=20
use for that ifdef.

(*) The cache topology may make some selftest unusable on new archs but=20
not the selftest code itself.


--=20
 i.
--8323328-1103726541-1725453948=:1078--

