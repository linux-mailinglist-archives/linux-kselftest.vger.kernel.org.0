Return-Path: <linux-kselftest+bounces-17119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697E196BBDB
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 14:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25701285283
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 12:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823641D679F;
	Wed,  4 Sep 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKp82ci5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3EB1D3628;
	Wed,  4 Sep 2024 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452299; cv=none; b=jcagHb5UyF02Ih8EIPobU+xyPsSs5oV+2zS1jJCPlIsiu4v3bpbmUk1LWo/WYhZo0S50+/KH+aGQUIayMXB4FmG+lpZHOkJ8J9v42INpZ8R1kt3R04E3i2w9XPdV67Uo8jvJ1OGM9XqUuZ/7HBm3lpzX+nEbLtZnk+457MRoIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452299; c=relaxed/simple;
	bh=hS1vDZI+E/sQyR7KBQ5ulrse7nZgFRP6XIZZvjz2JPo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HZtaiQEWj1Usm2CQJ7yB3+Ll3f6AUGwrE66jzsG2ezlEOz0qapOiKwfPZR6hmtmn4HdZz5Z4C1kJ4Talkxb+ul21tLeJzfvLoPZ74bCO3S8oivqlHq2ZXZJQZnFvAds5mtmurY/JMnZ66cDP81Xppx8cm04YSVGRMcu9fu2vLV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKp82ci5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725452298; x=1756988298;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=hS1vDZI+E/sQyR7KBQ5ulrse7nZgFRP6XIZZvjz2JPo=;
  b=dKp82ci5iGhR7z1NqkaL+nhNK/QnaHXlTUr5025TxrJGAFpHoshIbVY0
   vwCJJrBLjv9609zIjZSxrmUfB+QiuERnR2gZxsaZkT/8UKQpW/DFygALB
   y87pMlLmo/jYUsK2XYgvfXT2PS76y3r6VmsjMX+0lYcM80GT5ZY3P97nl
   Kc5oXzEasS3V8HCpOiNhCgAjzwCGXQ3Ajqp0akc9DzgeiYbYhgTjqdDah
   U9aMvFznqAdcP2iujLsvidOnW9MRLweVHeR0Qa5kAGPHX9rtMknps4RbK
   bcJ4StFxH5MwFL4SZ+PYcxNURhFDHjpVUyaJoVUUMoegz8zrn4ddFxm/l
   w==;
X-CSE-ConnectionGUID: 1Zi5FML8TqGYGfRl5ptmpA==
X-CSE-MsgGUID: 5KTlK0h5RN+xuDWozNzYeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23910926"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="23910926"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:18:18 -0700
X-CSE-ConnectionGUID: EkZC0+IyTR6UANzxJii2hw==
X-CSE-MsgGUID: 9ysRh4nqTDCgGPwHKQAXog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="64939941"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.156])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:18:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 4 Sep 2024 15:18:09 +0300 (EEST)
To: Shuah Khan <skhan@linuxfoundation.org>
cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
    Shuah Khan <shuah@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>
Subject: Re: [PATCH v4 0/4] selftests: Fix cpuid / vendor checking build
 issues
In-Reply-To: <eadb7bc7-a093-4229-90f0-88b730087666@linuxfoundation.org>
Message-ID: <d2a4ca5c-3352-e570-687c-9d7ec90dbe33@linux.intel.com>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com> <eadb7bc7-a093-4229-90f0-88b730087666@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1417798283-1725451617=:1078"
Content-ID: <ddaec370-6888-0f3a-2cd9-96602b7bd093@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1417798283-1725451617=:1078
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f86d12c1-7ad0-f4a6-617f-28cddfeb1abc@linux.intel.com>

On Tue, 3 Sep 2024, Shuah Khan wrote:

> On 9/3/24 08:45, Ilpo J=E4rvinen wrote:
> > This series first generalizes resctrl selftest non-contiguous CAT check
> > to not assume non-AMD vendor implies Intel. Second, it improves
> > selftests such that the use of __cpuid_count() does not lead into a
> > build failure (happens at least on ARM).
> >=20
> > While ARM does not currently support resctrl features, there's an
> > ongoing work to enable resctrl support also for it on the kernel side.
> > In any case, a common header such as kselftest.h should have a proper
> > fallback in place for what it provides, thus it seems justified to fix
> > this common level problem on the common level rather than e.g.
> > disabling build for resctrl selftest for archs lacking resctrl support.
> >=20
> > I've dropped reviewed and tested by tags from the last patch in v3 due
> > to major changes into the makefile logic. So it would be helpful if
> > Muhammad could retest with this version.
> >=20
> > Acquiring ARCH in lib.mk will likely allow some cleanup into some
> > subdirectory makefiles but that is left as future work because this
> > series focuses in fixing cpuid/build.
>=20
> >=20
> > v4:
> > - New patch to reorder x86 selftest makefile to avoid clobbering CFLAGS
> >    (would cause __cpuid_count() related build fail otherwise)
> >=20
> I don't like the way this patch series is mushrooming. I am not
> convinced that changes to lib.mk and x86 Makefile are necessary.

I didn't like it either what I found from the various makefiles. I think=20
there are many things done which conflict with what lib.mk seems to try to=
=20
do.

I tried to ask in the first submission what test I should use in the=20
header file as I'm not very familiar with how arch specific is done in=20
userspace in the first place nor how it should be done within kselftest=20
framework.

> I will take a look at this to see if this can be simplified.

Sure, thanks.

--=20
 i.
--8323328-1417798283-1725451617=:1078--

