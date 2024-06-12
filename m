Return-Path: <linux-kselftest+bounces-11742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E1904CE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 09:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EB11F24722
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EDD7404F;
	Wed, 12 Jun 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfSjfjhc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9329413;
	Wed, 12 Jun 2024 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177621; cv=none; b=i7R7qm/CMt5/66Vi6EWSjON8jsxY9d4HePLeihrvHURZGncP0Zzf+72UY8/tseLT29L7Hx+6Lqby66/MsDYWSnXDJsg1k8R+c2SIy5TOL8Kj0ePvg63fGgBgpSYKcLnWCtSbYA03nxyNvgiN3lOoXofRXV3cDuJ59038vt2Bfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177621; c=relaxed/simple;
	bh=SUfIAtDi5cgpBLZQB/Du7Hs4SYoZugQDNHll79iQU7w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jmXPkwSbygxyNiVJH6Pa/k6akS1G70H7k/ZFShoZoU7v1u2pmtWatsqTHtyJDZO2nRhlqq7I0/rk58z4SnExA4jvPEkj0mSqror6X3rqpAhIxqrFyJ9xuYuuZ1igvTXh8caNZDLWvOWX+ves5MqPXZhrZSqcRX5SATL/t8WTGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfSjfjhc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718177620; x=1749713620;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SUfIAtDi5cgpBLZQB/Du7Hs4SYoZugQDNHll79iQU7w=;
  b=HfSjfjhc0idvtlaYA3dBl9llfvSkBfshB8IsEXJo0yFgWQNhOYonCpQu
   W25shQcUg0x+UQ4aIIRcxtwFJhqkQT/bmMYYuBoo61japlCrGrbIr0SPs
   BGxTJ1SW6dnQM3rxY18AYgvqqTXSZgdaPxDo5Jh1LcPiYmdtFXbbj3Mts
   gK4931YgDtXKVFTqvn5XUy6FVoM7iRnTYMm4XVOWfwXm476Wv321zYsTi
   JKo3S9UJrapyfqDN2L4uj7jggzn6/SVeQD4+W2yCXHFUcyXTjWMD/Rmmw
   qsm/ZcaV08NFj7Wl3dH1NRjsFdOzXftGs8i8LLmqY8GZEnckW90A81NQZ
   Q==;
X-CSE-ConnectionGUID: dA/g+31YQQmoJC0NEyep4A==
X-CSE-MsgGUID: 2HWeL1TvQ4qIjLfxaBRCVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="26041609"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="26041609"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 00:33:39 -0700
X-CSE-ConnectionGUID: RgCrLq4xQ6C3yjzVbbQBkQ==
X-CSE-MsgGUID: Sp4CeumZRcu/J86gUJIRZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39592979"
Received: from unknown (HELO localhost) ([10.245.247.204])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 00:33:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 12 Jun 2024 10:33:30 +0300 (EEST)
To: Babu Moger <babu.moger@amd.com>
cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>, 
    shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    peternewman@google.com, eranian@google.com
Subject: Re: [PATCH v3] selftests/resctrl: Fix non-contiguous CBM for AMD
In-Reply-To: <96d276c11e69cfb1e29d50a12c8043555c06b404.1718144237.git.babu.moger@amd.com>
Message-ID: <dbb757c2-072c-5689-2122-157532715a63@linux.intel.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com> <96d276c11e69cfb1e29d50a12c8043555c06b404.1718144237.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1864459413-1718177611=:1312"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1864459413-1718177611=:1312
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 11 Jun 2024, Babu Moger wrote:

> The non-contiguous CBM test fails on AMD with:
> Starting L3_NONCONT_CAT test ...
> Mounting resctrl to "/sys/fs/resctrl"
> CPUID output doesn't match 'sparse_masks' file content!
> not ok 5 L3_NONCONT_CAT: test
>=20
> AMD always supports non-contiguous CBM but does not report it via CPUID.
>=20
> Fix the non-contiguous CBM test to use CPUID to discover non-contiguous
> CBM support only on Intel.
>=20
> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test=
")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
> v3: Reworked changelong.
>=20
> v2: Moved the non-contiguous CBM verification to a new function
>     arch_supports_noncont_cat.
>=20
> v1: This was part of the series
>     https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
>     Sending this as a separate fix per review comments.
> ---
>  tools/testing/selftests/resctrl/cat_test.c | 32 +++++++++++++++-------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/s=
elftests/resctrl/cat_test.c
> index d4dffc934bc3..742782438ca3 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -288,11 +288,30 @@ static int cat_run_test(const struct resctrl_test *=
test, const struct user_param
>  =09return ret;
>  }
> =20
> +static bool arch_supports_noncont_cat(const struct resctrl_test *test)
> +{
> +=09unsigned int eax, ebx, ecx, edx;
> +
> +=09/* AMD always supports non-contiguous CBM. */
> +=09if (get_vendor() =3D=3D ARCH_AMD)
> +=09=09return true;
> +
> +=09/* Intel support for non-contiguous CBM needs to be discovered. */
> +=09if (!strcmp(test->resource, "L3"))
> +=09=09__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> +=09else if (!strcmp(test->resource, "L2"))
> +=09=09__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> +=09else
> +=09=09return false;
> +
> +=09return ((ecx >> 3) & 1);
> +}
> +
>  static int noncont_cat_run_test(const struct resctrl_test *test,
>  =09=09=09=09const struct user_params *uparams)
>  {
>  =09unsigned long full_cache_mask, cont_mask, noncont_mask;
> -=09unsigned int eax, ebx, ecx, edx, sparse_masks;
> +=09unsigned int sparse_masks;
>  =09int bit_center, ret;
>  =09char schemata[64];
> =20
> @@ -301,15 +320,8 @@ static int noncont_cat_run_test(const struct resctrl=
_test *test,
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09if (!strcmp(test->resource, "L3"))
> -=09=09__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> -=09else if (!strcmp(test->resource, "L2"))
> -=09=09__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> -=09else
> -=09=09return -EINVAL;
> -
> -=09if (sparse_masks !=3D ((ecx >> 3) & 1)) {
> -=09=09ksft_print_msg("CPUID output doesn't match 'sparse_masks' file con=
tent!\n");
> +=09if (arch_supports_noncont_cat(test) !=3D sparse_masks) {
> +=09=09ksft_print_msg("Hardware and kernel differ on non-contiguous CBM s=
upport!\n");
>  =09=09return 1;
>  =09}
> =20
>=20
--8323328-1864459413-1718177611=:1312--

