Return-Path: <linux-kselftest+bounces-6536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4409788A6D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 16:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E980A324557
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 15:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98FE131E31;
	Mon, 25 Mar 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+pqa6jw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391D84D1B;
	Mon, 25 Mar 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372100; cv=none; b=XqaPO11HRhS/gE8g4Pc2S5GyoTLaAxb7P0nNmuzb7zTATtoNrk0EFtFkzOykVaZB9RNjBEhOvE5JXTIXuCblHjXdsR5NC9X/g0lTXGLhd1wHwof1i0bPxlRO6Jsg9+EO2nTRc3/hl3BrkOOXl/+OXAg4jpbjAi94uDTXBIQbB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372100; c=relaxed/simple;
	bh=4PI/TUfF/UJPyeIEUcIHtre7UdX4Ew/J+I0lCMM5Ric=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X/ysvkgKBPmsmElfI9LE7ghrzPhFtljcOI04PThVMHx+80c5+dgX3PRdIpnv9wuVQjKgLs5hfOHi/rynnDz9Ki0recTkGe1dyf6OFfWg4sIAmBNt28iIK9SDq6ArOocJa03Ma1d4sUjLrRa0a2F3kiqiU8eZ45Mat0zTCjZOv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+pqa6jw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711372099; x=1742908099;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4PI/TUfF/UJPyeIEUcIHtre7UdX4Ew/J+I0lCMM5Ric=;
  b=h+pqa6jwXsCB49Huxjo+mVuO5sbBlBmfiahEGCfYrmNuvoDfdIkKIkg7
   s0b5W8ibNxT171rH5pCYo8mYM9aklLHqf/8LlpEQEX01YFbNTdxURXqVM
   ir1k5dC1ktyrvC9oN8gMHcsp2AMI6MRMDSnREcUyPz0LCJoJUslmh9Gk7
   dlkitJ8RFSfY7QFSo2Qz8Skv70Y4qAtryG3rRMbxdoOCURyGYhmbABGRw
   JcyewYoKzZtHyax7ibjPX2fYPswclqm17TiI6DHPwQa57ls6mbaXV467R
   SpjZTxjdBTVvITX4d9QjjYyap4HwRrTvWwikzmD7p60vmxPv4P3292ySr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6267212"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6267212"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="20146773"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.19])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:08:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 25 Mar 2024 15:08:09 +0200 (EET)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/13] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
In-Reply-To: <0910f9ed-2312-46b7-9c64-2982709da3d8@intel.com>
Message-ID: <10baa8db-3143-fdd4-49a8-0298db90cc4f@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com> <20240311135230.7007-3-ilpo.jarvinen@linux.intel.com> <fe5c0d10-a57c-4a3a-ae30-a7cfa93bc3e8@intel.com> <f214c635-500f-43ea-fce8-0a7083bc1606@linux.intel.com>
 <0910f9ed-2312-46b7-9c64-2982709da3d8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1681402267-1711372089=:1020"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1681402267-1711372089=:1020
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Mar 2024, Reinette Chatre wrote:
> On 3/22/2024 5:11 AM, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 19 Mar 2024, Reinette Chatre wrote:
> >> On 3/11/2024 6:52 AM, Ilpo J=C3=A4rvinen wrote:

> >>> + * Return: =3D 0 on success. < 0 on failure.
> >>> + */
> >>> +static int get_mem_bw_imc(char *bw_report, float *bw_imc)
> >>> +{
> >>> +=09float reads, writes, of_mul_read, of_mul_write;
> >>> +=09int imc, j;
> >>> +
> >>> +=09/* Start all iMC counters to log values (both read and write) */
> >>> +=09reads =3D 0, writes =3D 0, of_mul_read =3D 1, of_mul_write =3D 1;
> >>> =20
> >>>  =09/*
> >>>  =09 * Get results which are stored in struct type imc_counter_config
> >=20
> >>> @@ -696,7 +725,6 @@ int resctrl_val(const struct resctrl_test *test,
> >>>  =09=09struct resctrl_val_param *param)
> >>>  {
> >>>  =09char *resctrl_val =3D param->resctrl_val;
> >>> -=09unsigned long bw_resc_start =3D 0;
> >>
> >> In the current implementation the first iteration's starting measureme=
nt
> >> is, as seen above, 0 ... which makes the first measurement unreliable
> >> and dropped for both the MBA and MBM tests. In this enhancement, the
> >> first measurement is no longer skewed so much so I wonder if this enha=
ncement
> >> can be expanded to the analysis phase where first measurement no longe=
r
> >> needs to be dropped?
> >=20
> > In ideal world, yes, but I'll have to check the raw numbers. My general=
=20
> > feel is that the numbers tend to converge slowly with more iterations=
=20
> > being run so the first iteration might still be "off" by quite much (th=
is=20
> > is definitely the case with CAT tests iterations but I'm not entirely s=
ure=20
> > any more how it is with other selftests).
>=20
> >From what I can tell the CAT test is not dropping any results. It looks
> to me that any "settling" is and should be handled in the test before
> the data collection starts.

It doesn't, but the "settling" is there in the raw numbers. I've=20
considered adding warm-up test(s) before the actual runs to improve the=20
situation but there's just so many thing still to do...

--=20
 i.

--8323328-1681402267-1711372089=:1020--

