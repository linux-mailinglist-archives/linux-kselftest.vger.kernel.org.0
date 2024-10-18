Return-Path: <linux-kselftest+bounces-20123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2419A3978
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 11:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142E81F242E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 09:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF03119048F;
	Fri, 18 Oct 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ye7RdNq1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD119004B;
	Fri, 18 Oct 2024 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242534; cv=none; b=dQ6VqJ42coGsJIEKjhLvhuyWXK69DiTEuDKnQIR8pTYumiqEwo6t2IG1babK7yq+oJrClbO5daeHk/0OzrK3eZnKWHoQpY8C+feTb2RKo2p4e3T21bLohcOXBuy41kSW9WHtaJ2M0W31yiO0U2/oRQXOHVyPQFzgioDfyDEDl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242534; c=relaxed/simple;
	bh=5YQ1hKbZy6xIUDVJBqJ7zEGyrybFRGod1J6/RupqD5k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FbgNnS2nNBR4KeBmp5gjgmb+9QjEkCB+oSlhsJltDq1TQWxDpYYbuWkwYFvachLRi3+C0K27tvfDNjqGcZSoit3SD2gJjD818pm8UKx+E1YE8LGlnhtoqsabWQxd/XG+3sLSwLAGSP4x9wnm+yw8ZvMQsRm6jxMg0fyfZBie+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ye7RdNq1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729242533; x=1760778533;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5YQ1hKbZy6xIUDVJBqJ7zEGyrybFRGod1J6/RupqD5k=;
  b=Ye7RdNq16Dd0ehxZiEzWwpRyEKdWVSZvpwkcj2goeMi+PzjzKhGpaWre
   6SLiug1UOzClM3uz1W0pAO7fDJIqx3YIRfLYDUA8+odnuiIaVS6koZfj4
   uoaDUcHGAHJFyfewC3WUXeZNGB3k0oqNv7hTJaf40o4+mZcDJRoJtXs4L
   Z8NqA/fR8rdSFGa/vSX2+9wWaSiRCzzNovIW8ilhCPaL5rPUGJVTRTabC
   lZdKkm2T2PSd2YK7zLg72vITsZDS8OQMyRlPCA+zPUIzZ9inyP0CySB8u
   ULx/5/T7EwHOrfZR5Ej8P77NIov4syFd9fTereHbI1z5Y8nd65ZpQmm3w
   g==;
X-CSE-ConnectionGUID: 5N1Ix0IxQJ+srvi3KVl0RA==
X-CSE-MsgGUID: KAlSHMkRQF6mmXKOOWoIyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28974954"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="28974954"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 02:08:53 -0700
X-CSE-ConnectionGUID: LENDyPVVQvOBSPSc6KCg+g==
X-CSE-MsgGUID: WvR2SGNPRKWwdnUkf9uS2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="116270570"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 02:08:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Oct 2024 12:08:45 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 15/15] selftests/resctrl: Replace magic constants used
 as array size
In-Reply-To: <4d4887b0359bfd4094871f34aa8b06e2efee6043.1729218182.git.reinette.chatre@intel.com>
Message-ID: <805a7c70-9a0b-a50a-3985-895f9d2c5fd4@linux.intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com> <4d4887b0359bfd4094871f34aa8b06e2efee6043.1729218182.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1957712913-1729242525=:1141"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1957712913-1729242525=:1141
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 Oct 2024, Reinette Chatre wrote:

> The Memory Bandwidth Allocation (MBA) test iterates through all possible
> MBA allocations, from 10% (ALLOCATION_MIN) to 100% (ALLOCATION_MAX) with
> increments of 10% (ALLOCATION_STEP) at each iteration. During each
> iteration the test measures the actual memory bandwidth NUM_OF_RUNS times
> to determine the impact of MBA on actual memory bandwidth.
>=20
> After the MBA test completes all the memory bandwidth measurements are
> parsed into an array. One array for resctrl Memory Bandwidth Monitoring
> (MBM) measurements and one array for the Integrated Memory Controller
> (iMC) measurements. Each array has a hardcoded size of 1024 that is
> large enough to hold the current test data, but this hardcoded value make=
s
> the implementation difficult to understand. It will not be clear that thi=
s
> array needs to be reconsidered if any of the test parameters are changed.
>=20
> Replace the magic constant as array size with the test parameters the
> array size depends on.
>=20
> Reported-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Closes: https://lore.kernel.org/all/45af2a8c-517d-8f0d-137d-ad0f3f6a3c68@=
linux.intel.com/
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
> Changes since V2:
> - New patch.
> ---
>  tools/testing/selftests/resctrl/mba_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/s=
elftests/resctrl/mba_test.c
> index 4e6645b172e3..536d9089d2f6 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -127,8 +127,9 @@ static bool show_mba_info(unsigned long *bw_imc, unsi=
gned long *bw_resc)
> =20
>  static int check_results(void)
>  {
> +=09unsigned long bw_resc[NUM_OF_RUNS * ALLOCATION_MAX / ALLOCATION_STEP]=
;
> +=09unsigned long bw_imc[NUM_OF_RUNS * ALLOCATION_MAX / ALLOCATION_STEP];
>  =09char *token_array[8], output[] =3D RESULT_FILE_NAME, temp[512];
> -=09unsigned long bw_imc[1024], bw_resc[1024];
>  =09int runs;
>  =09FILE *fp;
> =20
>=20
--8323328-1957712913-1729242525=:1141--

