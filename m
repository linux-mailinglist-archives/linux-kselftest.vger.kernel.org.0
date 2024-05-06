Return-Path: <linux-kselftest+bounces-9509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460CB8BCA43
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 11:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694911C20FFA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310701422B8;
	Mon,  6 May 2024 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlWFbY2i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9F1422A5;
	Mon,  6 May 2024 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714986491; cv=none; b=bcuwoYwDYQPsZTJeNdQ5qAtVCvzVIEOgaT5AXO1R4Tr/EuxQDNBzpoqg6pDX6wt2PR5tPLv+dPFBXbMUtbP1i6TtZL6hQEZB+92M6QwszuiHUT0irCeIw/lSNvaWhXNVeRAEoCkEiaYRwaD9IvxFQIsjC/ZFE+kVtYa3bX88SPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714986491; c=relaxed/simple;
	bh=DJFAb48flUOaIKrGIcEOoLa7PZxItSUWyxVPt3RrdEQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xl72jl6Pd80BxPrqR7PInJAdxHLiv7jpMl6jXNykzFnanOqCDhGetX7SsSb9c7UwsNs69M5PqDUOzovGwgj0Fx8RcHOjMMjM1+tOq7pABrEYpGYYfePCPa+Xk3eUbYbjbFLWIB9idtwpBkOX13fC6kjhZk1wlUj6SIqz8BkUFmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlWFbY2i; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714986489; x=1746522489;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=DJFAb48flUOaIKrGIcEOoLa7PZxItSUWyxVPt3RrdEQ=;
  b=UlWFbY2i8Ajr0krrBNPGq9h+LIUgAj7hZPA1TAfRwvRrZUStA4OSNZPZ
   mfP8Sq2CQLzpua184cIGrlGQcx+xABjYekhSDPgivCt8ZpVJu2lbg3Bui
   QSl6EN88wbdtjJyHB3S+v4IzHrR1lH6Ljfq0vEHRAELRyT2w12sJ9vK6E
   AlmxTdG3Ph82IsTBz7nfQoI8cI4y9AIKyPo5g+p8JCHlbuH+/wJEgma45
   eeAuFTYEcCNskaimUUD/oa0IfB18qSxJgcWncdBVB7oVbSFsYMJSEGKzJ
   UtKujpM4SF2XJGcoSDYVrQeFp05rJOkMnDRHl5n+1tQyMAKyMC5tZpNpE
   A==;
X-CSE-ConnectionGUID: hB4d89iyTYKdCrCx6zTKNA==
X-CSE-MsgGUID: PJtQ6c3fR2etSMXuSut5gA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14508060"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="14508060"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:08:08 -0700
X-CSE-ConnectionGUID: k8ITO01gQfSkX3H3SFK3XQ==
X-CSE-MsgGUID: r2to3QFHTWug0UPqDwrTMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59297461"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:08:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 May 2024 12:07:57 +0300 (EEST)
To: John Hubbard <jhubbard@nvidia.com>
cc: Reinette Chatre <reinette.chatre@intel.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst <kernel@valentinobst.de>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
In-Reply-To: <b88e73ea-d3f6-42d0-b9e0-f97665546178@nvidia.com>
Message-ID: <d46b81df-e018-a9bd-1550-31c825c487cf@linux.intel.com>
References: <20240503023209.80787-1-jhubbard@nvidia.com> <793bd068-c3b4-6330-41a4-bea597b1d820@linux.intel.com> <f908ba74-86c0-409c-854d-9da5f3917b05@nvidia.com> <26f3effc-6ea1-4670-a301-76df3a710fa9@intel.com>
 <b88e73ea-d3f6-42d0-b9e0-f97665546178@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-626839963-1714985487=:1111"
Content-ID: <1eef3c65-1a10-d09b-efb0-b3996dc9e99e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-626839963-1714985487=:1111
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <910e6218-dd94-5978-7fc6-1c35ae67c9cd@linux.intel.com>

On Fri, 3 May 2024, John Hubbard wrote:

> On 5/3/24 11:37 AM, Reinette Chatre wrote:
> > On 5/3/2024 9:52 AM, John Hubbard wrote:
> > > On 5/3/24 1:00 AM, Ilpo J=E4rvinen wrote:
> > > > On Thu, 2 May 2024, John Hubbard wrote:
> > > ...
> > > > > diff --git a/tools/testing/selftests/resctrl/mbm_test.c
> > > > > b/tools/testing/selftests/resctrl/mbm_test.c
> > > > > index d67ffa3ec63a..c873793d016d 100644
> > > > > --- a/tools/testing/selftests/resctrl/mbm_test.c
> > > > > +++ b/tools/testing/selftests/resctrl/mbm_test.c
> > > > > @@ -33,7 +33,7 @@ show_bw_info(unsigned long *bw_imc, unsigned lo=
ng
> > > > > *bw_resc, size_t span)
> > > > >  =A0 =A0=A0=A0=A0=A0 avg_bw_imc =3D sum_bw_imc / 4;
> > > > >  =A0=A0=A0=A0=A0 avg_bw_resc =3D sum_bw_resc / 4;
> > > > > -=A0=A0=A0 avg_diff =3D (float)labs(avg_bw_resc - avg_bw_imc) / a=
vg_bw_imc;
> > > > > +=A0=A0=A0 avg_diff =3D (float)(avg_bw_resc - avg_bw_imc) / avg_b=
w_imc;
> > > > >  =A0=A0=A0=A0=A0 avg_diff_per =3D (int)(avg_diff * 100);
> > > > >  =A0 =A0=A0=A0=A0=A0 ret =3D avg_diff_per > MAX_DIFF_PERCENT;
> > > >=20
> > > > But how are these two cases same after your change when you ended u=
p
> > > > removing taking the absolute value entirely?
> > >=20
> > > All of the arguments are unsigned integers, so all arithmetic results
> > > are interpreted as unsigned, so taking the absolute value of that is
> > > always a no-op.

(I see there's a better patch posted already but since there are a few=20
incorrect claims in this discussion, I'll do for the record type of=20
reply.)

This discussion now went to a tangent about the warning. My main point is=
=20
that logic is not correct after removing labs().

I also disagree with the claim that using labs() on unsigned value is=20
no-op because labs() takes long so unsigned is just forced into signed=20
when calling which is why the warning triggers but it's very misleading=20
warning (see below).

> > It does not seem as though clang can see when values have been casted.
> > I tried to do so explicitly with a:
> >   =09avg_diff =3D labs((long)avg_bw_resc - avg_bw_imc) / (float)avg_bw_=
imc;
>
> The subtraction result will get promoted to an unsigned long, before bein=
g
> passed into labs(3).
>
> > But that still triggers:
> > warning: taking the absolute value of unsigned type 'unsigned long' has=
 no
> > effect [-Wabsolute-value]
>=20
> As expected, yes.

That error message isn't factually correct:

        unsigned long a =3D LONG_MAX;
        long b;

        a +=3D 2;
        b =3D (long)a;
        printf("%llu %lli %lli\n", a, b, labs(a));

Prints (at least when built with gcc):

9223372036854775809 -9223372036854775807 9223372036854775807

labs(LONG_MAX + 1) won't work though since it's not positively presentable=
=20
with long and the value is left untouched.

--=20
 i.
--8323328-626839963-1714985487=:1111--

