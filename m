Return-Path: <linux-kselftest+bounces-19036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C4990610
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AE2281357
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14945217329;
	Fri,  4 Oct 2024 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGywVOPk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973F69D2B;
	Fri,  4 Oct 2024 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052157; cv=none; b=SPaTA7pM5vuNzLojkISQnbziEc9uOcDvUyIb+Nr5NLopxbXAMQQLpz0q6+BSNFF9NNgJ1R5ujwik5fmi0Po6lu/j4TapuBjA0PlzOQuB9z1ReX/E2YOX/IHKrytKyzHaWKIcnTiVYkaHZvpTN7ME8VA0S9go7RQWGbkdo3chdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052157; c=relaxed/simple;
	bh=+xJ2e/2ZWeA2xZeTvHj9oDcCGL8RxqZ9NDAt5mhkv8I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kUp5QqgTbipJNnRuVm/HPu2B0TN4XMadehuY912mnlwgX1kQmYnWjDMO7aK5UzOLiUT9+pXOMVvuiKgugCAMGeAsOdL7c/5NEXb0NF9UM/JBZ6cDhfwYw3OYzi0IRvgPDtGfW7j4p8R4q/FEgoIs+v1YCIZ8UnMS8g3pgNzprwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGywVOPk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728052156; x=1759588156;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+xJ2e/2ZWeA2xZeTvHj9oDcCGL8RxqZ9NDAt5mhkv8I=;
  b=bGywVOPkGmL1HuyUn1Xgu7P1M/bBfRUM+L3hPZyI2X45yxrtLOqDxKF+
   IXVU5j4MmAPxaiPl4fOhox/+2eik31I8SAKF01YEfTRXRqeuh9VNsrLHG
   KOxygB+fDHKT1wk6EfD7Pey9wTncfxE+7+fBpcusCfjXmiNqTsqk0GGGN
   db4g+vgCEZwQEZJpTbUG3oFo+dNkC8/UlGjV+CIgnkOIeEkvx8n8aYQT3
   EAM9XrbtIPnik/evKwyCNlRh9txgKdwZdKrEXaVwlOjEFwh+hmQzGiIL+
   OZ6WWqfdaeQJAU0G9UzkFUwxZY75RYvvl+ORBkoMYGmQjqJYJSlIbOILS
   w==;
X-CSE-ConnectionGUID: OA7Y+dNFTPWXUs0gRiEqvA==
X-CSE-MsgGUID: MukXreDzSiq0RPG9IJEtZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="38669397"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="38669397"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 07:29:15 -0700
X-CSE-ConnectionGUID: A3RpAHD/SjquMhedKXwYvg==
X-CSE-MsgGUID: K32YuJU8Q66NtVYrhmta8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="112199240"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 07:29:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 4 Oct 2024 17:29:09 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 13/13] selftests/resctrl: Keep results from first test
 run
In-Reply-To: <46200b49e874c69a05538b813852af0e1eeeea4c.1726164080.git.reinette.chatre@intel.com>
Message-ID: <45af2a8c-517d-8f0d-137d-ad0f3f6a3c68@linux.intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com> <46200b49e874c69a05538b813852af0e1eeeea4c.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1904508778-1728052149=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1904508778-1728052149=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Sep 2024, Reinette Chatre wrote:

> The resctrl selftests drop the results from every first test run
> to avoid (per comment) "inaccurate due to monitoring setup transition
> phase" data. Previously inaccurate data resulted from workloads needing
> some time to "settle" and also the measurements themselves to
> account for earlier measurements to measure across needed timeframe.
>=20
> commit da50de0a92f3 ("selftests/resctrl: Calculate resctrl FS derived mem
> bw over sleep(1) only")
>=20
> ensured that measurements accurately measure just the time frame of
> interest. The default "fill_buf" benchmark since separated the buffer
> prepare phase from the benchmark run phase reducing the need for the
> tests themselves to accommodate the benchmark's "settle" time.
>=20
> With these enhancements there are no remaining portions needing
> to "settle" and the first test run can contribute to measurements.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - Remove comment about needing results from first run removed.
> - Fix existing incorrect spacing while changing line.
> ---
>  tools/testing/selftests/resctrl/cmt_test.c |  5 ++---
>  tools/testing/selftests/resctrl/mba_test.c | 10 +++-------
>  tools/testing/selftests/resctrl/mbm_test.c | 10 +++-------
>  3 files changed, 8 insertions(+), 17 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/s=
elftests/resctrl/cmt_test.c
> index a7effe76b419..d4b85d144985 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -99,14 +99,13 @@ static int check_results(struct resctrl_val_param *pa=
ram, size_t span, int no_of
>  =09=09}
> =20
>  =09=09/* Field 3 is llc occ resc value */
> -=09=09if (runs > 0)
> -=09=09=09sum_llc_occu_resc +=3D strtoul(token_array[3], NULL, 0);
> +=09=09sum_llc_occu_resc +=3D strtoul(token_array[3], NULL, 0);
>  =09=09runs++;
>  =09}
>  =09fclose(fp);
> =20
>  =09return show_results_info(sum_llc_occu_resc, no_of_bits, span,
> -=09=09=09=09 MAX_DIFF, MAX_DIFF_PERCENT, runs - 1, true);
> +=09=09=09=09 MAX_DIFF, MAX_DIFF_PERCENT, runs, true);
>  }
> =20
>  static void cmt_test_cleanup(void)
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/s=
elftests/resctrl/mba_test.c
> index 5c6063d0a77c..89c2446b9f80 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -86,18 +86,14 @@ static bool show_mba_info(unsigned long *bw_imc, unsi=
gned long *bw_resc)
>  =09=09int avg_diff_per;
>  =09=09float avg_diff;
> =20
> -=09=09/*
> -=09=09 * The first run is discarded due to inaccurate value from
> -=09=09 * phase transition.
> -=09=09 */
> -=09=09for (runs =3D NUM_OF_RUNS * allocation + 1;
> +=09=09for (runs =3D NUM_OF_RUNS * allocation;
>  =09=09     runs < NUM_OF_RUNS * allocation + NUM_OF_RUNS ; runs++) {
>  =09=09=09sum_bw_imc +=3D bw_imc[runs];
>  =09=09=09sum_bw_resc +=3D bw_resc[runs];
>  =09=09}
> =20
> -=09=09avg_bw_imc =3D sum_bw_imc / (NUM_OF_RUNS - 1);
> -=09=09avg_bw_resc =3D sum_bw_resc / (NUM_OF_RUNS - 1);
> +=09=09avg_bw_imc =3D sum_bw_imc / NUM_OF_RUNS;
> +=09=09avg_bw_resc =3D sum_bw_resc / NUM_OF_RUNS;
>  =09=09if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc < THROTTLE_THRE=
SHOLD) {
>  =09=09=09ksft_print_msg("Bandwidth below threshold (%d MiB). Dropping re=
sults from MBA schemata %u.\n",
>  =09=09=09=09       THROTTLE_THRESHOLD,
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/s=
elftests/resctrl/mbm_test.c
> index 7635ee6b9339..8c818e292dce 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -22,17 +22,13 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw=
_resc, size_t span)
>  =09int runs, ret, avg_diff_per;
>  =09float avg_diff =3D 0;
> =20
> -=09/*
> -=09 * Discard the first value which is inaccurate due to monitoring setu=
p
> -=09 * transition phase.
> -=09 */
> -=09for (runs =3D 1; runs < NUM_OF_RUNS ; runs++) {
> +=09for (runs =3D 0; runs < NUM_OF_RUNS; runs++) {
>  =09=09sum_bw_imc +=3D bw_imc[runs];
>  =09=09sum_bw_resc +=3D bw_resc[runs];
>  =09}
> =20
> -=09avg_bw_imc =3D sum_bw_imc / 4;
> -=09avg_bw_resc =3D sum_bw_resc / 4;
> +=09avg_bw_imc =3D sum_bw_imc / NUM_OF_RUNS;
> +=09avg_bw_resc =3D sum_bw_resc / NUM_OF_RUNS;
>  =09avg_diff =3D (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>  =09avg_diff_per =3D (int)(avg_diff * 100);

While the patch itself is fine, I notice the code has this magic number=20
gem too:

        unsigned long bw_imc[1024], bw_resc[1024];

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-1904508778-1728052149=:957--

