Return-Path: <linux-kselftest+bounces-19034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A08C9905D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9903F1C213F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BC52141D7;
	Fri,  4 Oct 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8TF5Opa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238E20FA95;
	Fri,  4 Oct 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051638; cv=none; b=j8RPy47ET+lcCVi+iMBd4AyqxbGn5oOJ303I9cvoyXbFHSuR8KP/fMN9+bEBUsi0f0ixikux/uF54P7AFranrnGTB8fpfZWt8AJUMIXKGPgz9Nil0ne9bRBCMvuszg2xd1ew9KggNIJpgdLx2aeV8ShTYRJXWzyQzEK4wtIhpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051638; c=relaxed/simple;
	bh=F7cWzNK/Hgdxmp1x/W631SvUiQj8lGT6Xv2d4USjyO8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bk4KjgFNzP3kdR8i+fBab5hQ56augAtBtFTDfrRfrf2mW/S1pqYsZ76FbfSTjP55aFRA1NAYIQeuJ189rzlc2Zkg14Rqa5mbBGZ8eXn84qgo+C7Pl2oWKuvpYjXcT0YqB3ivDyiocA5V7ymqQENMNtHqShmCcQ01c0hmRb1OVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8TF5Opa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728051636; x=1759587636;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F7cWzNK/Hgdxmp1x/W631SvUiQj8lGT6Xv2d4USjyO8=;
  b=E8TF5OpaDwQRh8PQfYamYfyj4/XevxUI+UyK+M8jWovqxMvGeL7dob+m
   aQ7YtgqHmqkhRbU95QkwWjboHg88FVeIQ66Tpz0Lhizg3v+xA2IQYBbGu
   hr1b/mTMOWbNQNPl0+89GDFmLR76zxdvvaoqDEmFRAxlk0Kngt334vppY
   WxlDvgfoX7U7VYlSX0WA8Ilu5jSA7PRb74+WDxZWWvZLfAmTnPaNIzz6L
   nbnfkojdhy78BxtfcWmL1UphcWz1gWleFmltInveUxNci+aQs1GqdyyR2
   EXuPcoHGlcDbVkp1PNbCRK4L5uwfbFOb7lZpc+UAapMxq3fpzzwNc1NIY
   A==;
X-CSE-ConnectionGUID: CN3QFgeRRzCuukUjUueHVw==
X-CSE-MsgGUID: ryoHwIhuT5e9MOqG2v3KlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37844421"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="37844421"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 07:20:35 -0700
X-CSE-ConnectionGUID: PWQctawlQEqABaPfO7r8LQ==
X-CSE-MsgGUID: TkGOcvxhRhSUbTVgh9CB7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="78710900"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 07:20:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 4 Oct 2024 17:20:27 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 11/13] selftests/resctrl: Use cache size to determine
 "fill_buf" buffer size
In-Reply-To: <ad51e32e5d4f8d99b691e7269e5179228e6a13a7.1726164080.git.reinette.chatre@intel.com>
Message-ID: <ea3aca92-1571-7220-6211-6424de0b21da@linux.intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com> <ad51e32e5d4f8d99b691e7269e5179228e6a13a7.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1727247519-1728051627=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1727247519-1728051627=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Sep 2024, Reinette Chatre wrote:

> By default the MBM and MBA tests use the "fill_buf" benchmark to
> read from a buffer with the goal to measure the memory bandwidth
> generated by this buffer access.
>=20
> Care should be taken when sizing the buffer used by the "fill_buf"
> benchmark. If the buffer is small enough to fit in the cache then
> it cannot be expected that the benchmark will generate much memory
> bandwidth. For example, on a system with 320MB L3 cache the existing
> hardcoded default of 250MB is insufficient.
>=20
> Use the measured cache size to determine a buffer size that can be
> expected to trigger memory access while keeping the existing default
> as minimum that has been appropriate for testing so far.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - Ensure buffer is at least double L3 cache size. (Ilpo)
> - Support user override of default buffer size. (Ilpo)
> ---
>  tools/testing/selftests/resctrl/mba_test.c | 8 +++++++-
>  tools/testing/selftests/resctrl/mbm_test.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/s=
elftests/resctrl/mba_test.c
> index 7e43056c8737..d8d9637c1951 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -182,7 +182,13 @@ static int mba_run_test(const struct resctrl_test *t=
est, const struct user_param
>  =09=09fill_buf.memflush =3D uparams->fill_buf->memflush;
>  =09=09param.fill_buf =3D &fill_buf;
>  =09} else if (!uparams->benchmark_cmd[0]) {
> -=09=09fill_buf.buf_size =3D DEFAULT_SPAN;
> +=09=09unsigned long cache_total_size =3D 0;
> +
> +=09=09ret =3D get_cache_size(uparams->cpu, "L3", &cache_total_size);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09fill_buf.buf_size =3D cache_total_size * 2 > DEFAULT_SPAN ?
> +=09=09=09=09    cache_total_size * 2 : DEFAULT_SPAN;
>  =09=09fill_buf.memflush =3D 1;
>  =09=09param.fill_buf =3D &fill_buf;
>  =09}
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/s=
elftests/resctrl/mbm_test.c
> index b1f03a73333f..7635ee6b9339 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -149,7 +149,13 @@ static int mbm_run_test(const struct resctrl_test *t=
est, const struct user_param
>  =09=09fill_buf.memflush =3D uparams->fill_buf->memflush;
>  =09=09param.fill_buf =3D &fill_buf;
>  =09} else if (!uparams->benchmark_cmd[0]) {
> -=09=09fill_buf.buf_size =3D DEFAULT_SPAN;
> +=09=09unsigned long cache_total_size =3D 0;
> +
> +=09=09ret =3D get_cache_size(uparams->cpu, "L3", &cache_total_size);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09fill_buf.buf_size =3D cache_total_size * 2 > DEFAULT_SPAN ?
> +=09=09=09=09    cache_total_size * 2 : DEFAULT_SPAN;
>  =09=09fill_buf.memflush =3D 1;
>  =09=09param.fill_buf =3D &fill_buf;
>  =09}
>=20

It has a bit of code duplication feel in it so I'd consider adding=20
something like ssize_t get_default_span() (perhaps there exists a better=20
name for it that is not "span" based). Also DEFAULT_SPAN is no longer
truly the default span.

But neither is the end of the world as is...

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.


--8323328-1727247519-1728051627=:957--

