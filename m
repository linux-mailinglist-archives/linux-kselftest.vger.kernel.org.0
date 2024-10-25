Return-Path: <linux-kselftest+bounces-20669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95589B049A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 15:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA9BB2389C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F871FB899;
	Fri, 25 Oct 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0cW141T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4F1F7552;
	Fri, 25 Oct 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864377; cv=none; b=mc5XQPNRYNqQOEHZSpL9WHNNCe2KAtpMZkKrZ1C/O2hQyWRaXA4lrxiQXmSmoCe7O4wfgEn1ActD/AjFUxL7O/29C1xA51uUyWYg1nIhyzutLKl2VvJqg7C8haaC+2RXHY9vjpc+r/maYYK/D8WzY9IQbV10Qg/YyC0C9PuvtNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864377; c=relaxed/simple;
	bh=Otuk169JgvALi3dcSk3ILvTu9+tdSveHqUUqJ0I2Hgg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jCbGPN8TnGZlwnhbZGK9baJeU/T3P3IIT4QtnWxLv3f21PIGWOnjf1G4ZYD55NeSc8z0bbKDYqw/ixy1VulKzalr3cfZYpDYppHR8pkY9Zui0tzgxi1uQyStXPWAoQl9v/YHXExpxXYpwhOxd85mVu37aaBbO2IJ/PqPkT0YYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0cW141T; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729864375; x=1761400375;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Otuk169JgvALi3dcSk3ILvTu9+tdSveHqUUqJ0I2Hgg=;
  b=W0cW141ThRxjr1aaK/OLwS48CTjUeumnfFTmZMwvvpHP1HnArC9UPno7
   3SCNxBge/mRt70smuhCasfbGVJBd01pCGFmym7wM2Dnvq34Oi4i+zYhdx
   2tSkcHc3pFPe1B9M5xmpgBrbJQ2xx0ZU3YAoNSjoeasL6GDeUSc7A9IFF
   7qbiyNdicnrSepG7EnPoe/gtcyc+FMPcUd98h+ivbY6CN3M0ohubloUcU
   3JFftO1SVP+YQY3ck/fMTPoUcCmLJJgDLpe2eRmUtF6OXZNFwOD8mNggZ
   GCN9h4Roxk5oqjbdr6rZ5V97Br8E+1FjCePBfesMhPdNKBVg+6Tocpz3y
   w==;
X-CSE-ConnectionGUID: 7c21IgfKQNO9iEBJ5bUIlg==
X-CSE-MsgGUID: fliMqv+xQP+j/tJ0LrSgkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29752285"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29752285"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:52:54 -0700
X-CSE-ConnectionGUID: y8UTfgYkS1GKW6WFqb5gEQ==
X-CSE-MsgGUID: z2SOPP2pQMq5hhBS5fRbDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81231135"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:52:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 16:52:48 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 02/15] selftests/resctrl: Print accurate buffer size
 as part of MBM results
In-Reply-To: <e48adb71c8213ff80833201c0cfe2cdfb041e39a.1729804024.git.reinette.chatre@intel.com>
Message-ID: <f2d1c465-a76f-b356-9389-91aefa03ddda@linux.intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com> <e48adb71c8213ff80833201c0cfe2cdfb041e39a.1729804024.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-888830759-1729864368=:946"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-888830759-1729864368=:946
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Oct 2024, Reinette Chatre wrote:

> By default the MBM test uses the "fill_buf" benchmark to keep reading
> from a buffer with size DEFAULT_SPAN while measuring memory bandwidth.
> User space can provide an alternate benchmark or amend the size of
> the buffer "fill_buf" should use.
>=20
> Analysis of the MBM measurements do not require that a buffer be used
> and thus do not require knowing the size of the buffer if it was used
> during testing. Even so, the buffer size is printed as informational
> as part of the MBM test results. What is printed as buffer size is
> hardcoded as DEFAULT_SPAN, even if the test relied on another benchmark
> (that may or may not use a buffer) or if user space amended the buffer
> size.
>=20
> Ensure that accurate buffer size is printed when using "fill_buf"
> benchmark and omit the buffer size information if another benchmark
> is used.
>=20
> Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> ---
> Backporting is not recommended. Backporting this fix will be
> a challenge with all the refactoring done since then. This issue
> does not impact default tests and there is no sign that
> folks run these tests with anything but the defaults. This issue is
> also minor since it does not impact actual test runs or results,
> just the information printed during a test run.
>=20
> Changes since V3:
> - Ensure string parsing handles case when user provides "". (Ilpo)
> - Fix error returned. (Ilpo)
>=20
> Changes since V2:
> - Make user input checks more robust. (Ilpo)
>=20
> Changes since V1:
> - New patch.
> ---
>  tools/testing/selftests/resctrl/mbm_test.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/s=
elftests/resctrl/mbm_test.c
> index 6b5a3b52d861..cf08ba5e314e 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -40,7 +40,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_r=
esc, size_t span)
>  =09ksft_print_msg("%s Check MBM diff within %d%%\n",
>  =09=09       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
>  =09ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
> -=09ksft_print_msg("Span (MB): %zu\n", span / MB);
> +=09if (span)
> +=09=09ksft_print_msg("Span (MB): %zu\n", span / MB);
>  =09ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
>  =09ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
> =20
> @@ -138,15 +139,26 @@ static int mbm_run_test(const struct resctrl_test *=
test, const struct user_param
>  =09=09.setup=09=09=3D mbm_setup,
>  =09=09.measure=09=3D mbm_measure,
>  =09};
> +=09char *endptr =3D NULL;
> +=09size_t span =3D 0;
>  =09int ret;
> =20
>  =09remove(RESULT_FILE_NAME);
> =20
> +=09if (uparams->benchmark_cmd[0] && strcmp(uparams->benchmark_cmd[0], "f=
ill_buf") =3D=3D 0) {
> +=09=09if (uparams->benchmark_cmd[1] && *uparams->benchmark_cmd[1] !=3D '=
\0') {
> +=09=09=09errno =3D 0;
> +=09=09=09span =3D strtoul(uparams->benchmark_cmd[1], &endptr, 10);
> +=09=09=09if (errno || *endptr !=3D '\0')
> +=09=09=09=09return -EINVAL;
> +=09=09}
> +=09}
> +
>  =09ret =3D resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09ret =3D check_results(DEFAULT_SPAN);
> +=09ret =3D check_results(span);
>  =09if (ret && (get_vendor() =3D=3D ARCH_INTEL))
>  =09=09ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clusteri=
ng is enabled. Check BIOS configuration.\n");
> =20
>=20
--8323328-888830759-1729864368=:946--

