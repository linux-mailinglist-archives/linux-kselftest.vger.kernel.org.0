Return-Path: <linux-kselftest+bounces-19035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906809905EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B758A1C20D52
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3932A215F6B;
	Fri,  4 Oct 2024 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/Iq1FxQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE0A1B7E9;
	Fri,  4 Oct 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051802; cv=none; b=eYL2Ycf3vGsdsV2e8Vu8bVsd9zuaDSLY+D7AN+ZtuWhSnEJlxtOg9Ja/jGba+wUXzG4YbNuJiUp+MhVyrl4qVDXrLs2CgsPjcBHCg3gy7FzQ554o93VvCBlLs+mD18h0XQ+LJJ8zuOQ2rEiC/uRaCKI+i7IPfMXhFAV2R1+AUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051802; c=relaxed/simple;
	bh=0Whr7Iiiz7JTv4iwA1dRvewJcTvZDGDXgwnUjPWvl5Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hMlt2L9BJ/rBlOTEZjjiMADC3hUWd9ptQr7emoQNKs8YAj/8XWNXIJCGFJ/8Pdzj2HpH8s1KoC55uzd7n3TduXERDzg0hqP7Nu2emfi4hYwHjH+Ju/rEqJS17K1eqllCAHmLlSMt3pqJdHFpA4qgSF6WweFazUqPkTagbIaIcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/Iq1FxQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728051801; x=1759587801;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0Whr7Iiiz7JTv4iwA1dRvewJcTvZDGDXgwnUjPWvl5Q=;
  b=X/Iq1FxQfFUyh7L9MpmOZWp+sUO17Nn6HDx/NiTyCaJy89BfxOB9GAu1
   fgA9qUhUe2kJ97dkgQ7Alagd72bN0TXA+1eif4N95tf3p13ZypjdLi2hi
   ZWy4Lhz44IOI6hyKMrenBU0rnqquIToFyGBA+TLH+C8Hd5mShVCykiaHl
   p9hhzYt80uyTaVeYgADnl1pRo+j7Wy8mv6+ks1AA/X3LKWCgUqv8BnrYy
   ikOC3J8+mF46KBaLqXj/mR+lvujnrh6TV6Z4q/71/pKtdducK4BTsAV3n
   ls1P16L0muM4QW08PRO5W08+GVsX4jU7G8X07utVtTkkQSzh7uVVw3U3a
   Q==;
X-CSE-ConnectionGUID: 3TFZyVC3RXevjnRF2oRjnQ==
X-CSE-MsgGUID: o7ChRlSjRA6KomDPdd8Xiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37844905"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="37844905"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 07:23:20 -0700
X-CSE-ConnectionGUID: NTNlezLZSxSGcR2JKlgWqA==
X-CSE-MsgGUID: QyOuXLnnQuCNJzx0aclTvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74830288"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 07:23:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 4 Oct 2024 17:23:13 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 12/13] selftests/resctrl: Do not compare performance
 counters and resctrl at low bandwidth
In-Reply-To: <955545d3377afc359d7b8b3915455bfdfc0d6605.1726164080.git.reinette.chatre@intel.com>
Message-ID: <b728c9c2-49a3-50b8-433a-b38e47a25303@linux.intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com> <955545d3377afc359d7b8b3915455bfdfc0d6605.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1344179437-1728051793=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1344179437-1728051793=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Sep 2024, Reinette Chatre wrote:

> The MBA test incrementally throttles memory bandwidth, each time
> followed by a comparison between the memory bandwidth observed
> by the performance counters and resctrl respectively.
>=20
> While a comparison between performance counters and resctrl is
> generally appropriate, they do not have an identical view of
> memory bandwidth. For example RAS features or memory performance
> features that generate memory traffic may drive accesses that are
> counted differently by performance counters and MBM respectively,
> for instance generating "overhead" traffic which is not counted
> against any specific RMID. As a ratio, this different view of memory
> bandwidth becomes more apparent at low memory bandwidths.
>=20
> It is not practical to enable/disable the various features that
> may generate memory bandwidth to give performance counters and
> resctrl an identical view. Instead, do not compare performance
> counters and resctrl view of memory bandwidth when the memory
> bandwidth is low.
>=20
> Bandwidth throttling behaves differently across platforms
> so it is not appropriate to drop measurement data simply based
> on the throttling level. Instead, use a threshold of 750MiB
> that has been observed to support adequate comparison between
> performance counters and resctrl.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - Fix code alignment and spacing.
> - Modify flow to use "continue" instead of "break" now that
>   earlier changes decreases throttling.
> - Expand comment of define to elaborate causes of discrepancy
>   between performance counters and MBM.
> ---
>  tools/testing/selftests/resctrl/mba_test.c |  7 +++++++
>  tools/testing/selftests/resctrl/resctrl.h  | 10 ++++++++++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/s=
elftests/resctrl/mba_test.c
> index d8d9637c1951..5c6063d0a77c 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -98,6 +98,13 @@ static bool show_mba_info(unsigned long *bw_imc, unsig=
ned long *bw_resc)
> =20
>  =09=09avg_bw_imc =3D sum_bw_imc / (NUM_OF_RUNS - 1);
>  =09=09avg_bw_resc =3D sum_bw_resc / (NUM_OF_RUNS - 1);
> +=09=09if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc < THROTTLE_THRE=
SHOLD) {
> +=09=09=09ksft_print_msg("Bandwidth below threshold (%d MiB). Dropping re=
sults from MBA schemata %u.\n",
> +=09=09=09=09       THROTTLE_THRESHOLD,
> +=09=09=09=09       ALLOCATION_MIN + ALLOCATION_STEP * allocation);
> +=09=09=09continue;
> +=09=09}
> +
>  =09=09avg_diff =3D (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>  =09=09avg_diff_per =3D (int)(avg_diff * 100);
> =20
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/se=
lftests/resctrl/resctrl.h
> index dc01dc75cba5..eb151ac74938 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -43,6 +43,16 @@
> =20
>  #define DEFAULT_SPAN=09=09(250 * MB)
> =20
> +/*
> + * Memory bandwidth (in MiB) below which the bandwidth comparisons
> + * between iMC and resctrl are considered unreliable. For example RAS
> + * features or memory performance features that generate memory traffic
> + * may drive accesses that are counted differently by performance counte=
rs
> + * and MBM respectively, for instance generating "overhead" traffic whic=
h
> + * is not counted against any specific RMID.
> + */
> +#define THROTTLE_THRESHOLD=09750
> +
>  /*
>   * fill_buf_param:=09"fill_buf" benchmark parameters
>   * @buf_size:=09=09Size (in bytes) of buffer used in benchmark.
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1344179437-1728051793=:957--

