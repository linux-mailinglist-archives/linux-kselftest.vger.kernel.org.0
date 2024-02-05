Return-Path: <linux-kselftest+bounces-4144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1466849B77
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 14:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A64281C4D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191941CA88;
	Mon,  5 Feb 2024 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4MAs8um"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7328E02;
	Mon,  5 Feb 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138692; cv=none; b=kFJhWDcb+IAbyJROTuKxeVcSripBLVYQd2QMdoO3q58NbEMzwGpn01Znp1olq2GTjJQGIiHTjy1YL2BgRkKuEU9TpL8WSqTCqVVSMys+0kr8z6hZWRSPHgFOzikJzTMohYZK0AGzgQs73W6Cna+YjjtuSg9vabsVAuakO+wxwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138692; c=relaxed/simple;
	bh=yEqvEJTwkXLcXG/9CVVu/XT0O8e8UfNRkxY+ONUV4R4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E+Mk49nkysgcD/cHetHD4SL7rWEwIDlXi7f+x5B/Z4vj3FREirHnHDabpr5RlLaS3k4qyNdl6eFJ3B1+yXt7beXmnCORFOktNhHYgnpN1KWntFJ6Zm3pG1h4eRfeXNyWcpvA0gwVYjb2K9Vl7vyIdFsuWzEefNapWfO3Z7uSO+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4MAs8um; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707138690; x=1738674690;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yEqvEJTwkXLcXG/9CVVu/XT0O8e8UfNRkxY+ONUV4R4=;
  b=b4MAs8umWE0pAAnXmoVUWZOAQauQ1W4XBSIYh0Nr1hLxXfSXXXP12Lwj
   /YXRvbaxl+l8os1yoxE+MTIjRIwXIWaxIsoM1Y8VNdnamjjtgbzH9kfeB
   bXzBazi1Mf57v79P/O8UDrenEDk2aloYpWRJC3Og7tFJ/B509d2RtXwUY
   Z58lwWe0n7/kqgNKVNRoZBI9BN5aBYEVjt8TST3J0vAI6ICM5xZVZiC0r
   AwfG5HNkHPppv2uQRW+qorrD7I7JW2xn4iaoomRNXh1hf5rGZZ/tjJDAz
   10Nx9wp7tQOwB8YG4a8k2caI3DBrZP0R1XV9sTq+dN8l6JtAqhs+80ml3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="678000"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="678000"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:11:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1033039"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.237])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:11:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Feb 2024 15:11:22 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>, 
    shuah@kernel.org, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
In-Reply-To: <b341ecc8d1143932307708aff44ab90db3a91564.1707130307.git.maciej.wieczor-retman@intel.com>
Message-ID: <81064977-28cd-10bf-6721-c5a0916dee85@linux.intel.com>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com> <b341ecc8d1143932307708aff44ab90db3a91564.1707130307.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2116838435-1707138682=:1027"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2116838435-1707138682=:1027
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 5 Feb 2024, Maciej Wieczor-Retman wrote:

> Add tests for both L2 and L3 CAT to verify the return values
> generated by writing non-contiguous CBMs don't contradict the
> reported non-contiguous support information.
>=20
> Use a logical XOR to confirm return value of write_schemata() and
> non-contiguous CBMs support information match.
>=20
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v4:
> - Return failure instead of error on check of cpuid against sparse_masks
>   and on contiguous write_schemata fail. (Reinette)
>=20
> Changelog v3:
> - Roll back __cpuid_count part. (Reinette)
> - Update function name to read sparse_masks file.
> - Roll back get_cache_level() changes.
> - Add ksft_print_msg() to contiguous schemata write error handling
>   (Reinette).
>=20
> Changelog v2:
> - Redo the patch message. (Ilpo)
> - Tidy up __cpuid_count calls. (Ilpo)
> - Remove redundant AND in noncont_mask calculations (Ilpo)
> - Fix bit_center offset.
> - Add newline before function return. (Ilpo)
> - Group non-contiguous tests with CAT tests. (Ilpo)
> - Use a helper for reading sparse_masks file. (Ilpo)
> - Make get_cache_level() available in other source files. (Ilpo)
>=20
>  tools/testing/selftests/resctrl/cat_test.c    | 81 +++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>  .../testing/selftests/resctrl/resctrl_tests.c |  2 +
>  3 files changed, 85 insertions(+)
>=20
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/s=
elftests/resctrl/cat_test.c
> index 39fc9303b8e8..20eb978e624b 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -294,6 +294,71 @@ static int cat_run_test(const struct resctrl_test *t=
est, const struct user_param
>  =09return ret;
>  }
> =20
> +static int noncont_cat_run_test(const struct resctrl_test *test,
> +=09=09=09=09const struct user_params *uparams)
> +{
> +=09unsigned long full_cache_mask, cont_mask, noncont_mask;
> +=09unsigned int eax, ebx, ecx, edx, ret, sparse_masks;
> +=09char schemata[64];
> +=09int bit_center;
> +
> +=09/* Check to compare sparse_masks content to CPUID output. */
> +=09ret =3D resource_info_unsigned_get(test->resource, "sparse_masks", &s=
parse_masks);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09if (!strcmp(test->resource, "L3"))
> +=09=09__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> +=09else if (!strcmp(test->resource, "L2"))
> +=09=09__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> +=09else
> +=09=09return -EINVAL;
> +
> +=09if (sparse_masks !=3D ((ecx >> 3) & 1)) {
> +=09=09ksft_print_msg("CPUID output doesn't match 'sparse_masks' file con=
tent!\n");
> +=09=09return 1;
> +=09}
> +
> +=09/* Write checks initialization. */
> +=09ret =3D get_full_cbm(test->resource, &full_cache_mask);
> +=09if (ret < 0)
> +=09=09return ret;
> +=09bit_center =3D count_bits(full_cache_mask) / 2;
> +=09cont_mask =3D full_cache_mask >> bit_center;
> +
> +=09/* Contiguous mask write check. */
> +=09snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
> +=09ret =3D write_schemata("", schemata, uparams->cpu, test->resource);
> +=09if (ret) {
> +=09=09ksft_print_msg("Write of contiguous CBM failed\n");
> +=09=09return 1;
> +=09}
> +
> +=09/*
> +=09 * Non-contiguous mask write check. CBM has a 0xf hole approximately =
in the middle.
> +=09 * Output is compared with support information to catch any edge case=
 errors.
> +=09 */
> +=09noncont_mask =3D ~(0xf << (bit_center - 2)) & full_cache_mask;

To be on the safe side, I think the types could be made to match here=20
with 0xfUL to avoid sizeof(int) vs sizeof(unsigned long) related bit=20
drops in the & (although it feel somewhat theoretical given the bitmask=20
sizes we are currently seeing).

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-2116838435-1707138682=:1027--

