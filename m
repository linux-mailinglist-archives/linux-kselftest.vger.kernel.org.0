Return-Path: <linux-kselftest+bounces-9995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7B8C2034
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F4CB20B8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D50415FA9E;
	Fri, 10 May 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G80e5Oqq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A415F3FA;
	Fri, 10 May 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331973; cv=none; b=NVqVBS09cjuLBzk6qe20frcs6wz1JxWfBxfmbDcR8OrPeWeRMO183M6c3t3gKRdzZjjHexLPONDktTifiqtwRe/tHnHQdlS21aReC2y1lOzLjUVtpwvSKQGuDW8LE2kqjNYnKGEFj5Ir8YQXWAd5cMOKTTz1HNOB5BdAkRn24B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331973; c=relaxed/simple;
	bh=tyOpBmlZ85nCkdfKTZECuSTS0sZ3YHanLOh3xffjebU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jiDs2nWK278e7YX/q1lwJxSLJKycTi0YpJjNGIuANxJodGt+n5thrMmrUWz/UMUub69nHEm+p88N1D26di1FKTbdi+fkEmrVv8hP5xRlYUmk3oT3ZKSK6yoZmkpiAYyVU/TKTQhEiCGGIm19BuoPSobFmr4QiBFZoVAUyf34qRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G80e5Oqq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715331972; x=1746867972;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tyOpBmlZ85nCkdfKTZECuSTS0sZ3YHanLOh3xffjebU=;
  b=G80e5OqquGOiabDwQcV1Ko1KWdZDbJukPzwUffB0Nvuw4d6WuokNgMxc
   B4HL9XPGFs03o5Ex11SZ8dRaPdSp9gw8ksHx3GriAMYpv13CpGnusgnfE
   kiS2zJlLsVWXy8Lu6DYeu7K+9Xlvw7oULrjGGp0SDaVOpiAFa7dBRyePc
   6NhkTd0eKlPIqxO3Bh5qoE0IzPn1LRHJV0HYa0HJBZwS76rBEU64hmw6A
   gWMjIDov164jlfvSLO7IvMYJDVbhKcDwu+i6iqQM8kA1OGtevTT1h7GNr
   n4aS9OTg4jua6ZKpL39SArTvCyIrOATlbW4cEtuUpg65QVWDBz1e3kOfi
   g==;
X-CSE-ConnectionGUID: KlByoO9qTFai4siKmh5pHA==
X-CSE-MsgGUID: eXbAVDKbQY2VgkdCxeEY1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28787495"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="28787495"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:06:11 -0700
X-CSE-ConnectionGUID: 8dhvWpM1RzesBRtyYX+qZw==
X-CSE-MsgGUID: zCuMT0YoSkORMG+6wyH4og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34067748"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:06:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 May 2024 12:06:02 +0300 (EEST)
To: John Hubbard <jhubbard@nvidia.com>
cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, 
    Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
In-Reply-To: <20240508190254.266892-1-jhubbard@nvidia.com>
Message-ID: <c1e834d6-266d-d8bb-4e85-cdc440ddcb31@linux.intel.com>
References: <20240508190254.266892-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1600665862-1715331962=:1562"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1600665862-1715331962=:1562
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 8 May 2024, John Hubbard wrote:

> When building with clang, via:
>=20
>     make LLVM=3D1 -C tools/testing/selftests
>=20
> ...two types of warnings occur:
>=20
>     warning: absolute value function 'abs' given an argument of type
>     'long' but has parameter of type 'int' which may cause truncation of
>     value
>=20
>     warning: taking the absolute value of unsigned type 'unsigned long'
>     has no effect
>=20
> Fix these by:
>=20
> a) using labs() in place of abs(), when long integers are involved, and
>=20
> b) Change to use signed integer data types, in places where subtraction
>    is used (and could end up with negative values).
>=20
> c) Remove a duplicate abs() call in cmt_test.c.

In general, instead of filename, it's better to refer to the actual=20
function in this kind of description. And in this particular case,=20
cmt_test.c could be replaced with "the CMT selftest" which is more=20
descriptive and still unambiguous.

> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Thank you.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  tools/testing/selftests/resctrl/cmt_test.c | 4 ++--
>  tools/testing/selftests/resctrl/mba_test.c | 2 +-
>  tools/testing/selftests/resctrl/mbm_test.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/s=
elftests/resctrl/cmt_test.c
> index a81f91222a89..05a241519ae8 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc_va=
l, int no_of_bits,
>  =09int ret;
> =20
>  =09avg_llc_val =3D sum_llc_val / num_of_runs;
> -=09avg_diff =3D (long)abs(cache_span - avg_llc_val);
> +=09avg_diff =3D (long)(cache_span - avg_llc_val);
>  =09diff_percent =3D ((float)cache_span - avg_llc_val) / cache_span * 100=
;
> =20
>  =09ret =3D platform && abs((int)diff_percent) > max_diff_percent &&
> -=09      abs(avg_diff) > max_diff;
> +=09      labs(avg_diff) > max_diff;
> =20
>  =09ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>  =09=09       ret ? "Fail:" : "Pass:", max_diff_percent);
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/s=
elftests/resctrl/mba_test.c
> index 7946e32e85c8..5fffbc9ff6a4 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -60,7 +60,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsign=
ed long *bw_resc)
>  =09/* Memory bandwidth from 100% down to 10% */
>  =09for (allocation =3D 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
>  =09     allocation++) {
> -=09=09unsigned long avg_bw_imc, avg_bw_resc;
> +=09=09long avg_bw_imc, avg_bw_resc;
>  =09=09unsigned long sum_bw_imc =3D 0, sum_bw_resc =3D 0;
>  =09=09int avg_diff_per;
>  =09=09float avg_diff;
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/s=
elftests/resctrl/mbm_test.c
> index d67ffa3ec63a..a4c3ea49b0e8 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -17,7 +17,7 @@
>  static int
>  show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>  {
> -=09unsigned long avg_bw_imc =3D 0, avg_bw_resc =3D 0;
> +=09long avg_bw_imc =3D 0, avg_bw_resc =3D 0;
>  =09unsigned long sum_bw_imc =3D 0, sum_bw_resc =3D 0;
>  =09int runs, ret, avg_diff_per;
>  =09float avg_diff =3D 0;
>=20
> base-commit: 45db3ab70092637967967bfd8e6144017638563c
> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
> prerequisite-patch-id: 8d96c4b8c3ed6d9ea2588ef7f594ae0f9f83c279
>=20
--8323328-1600665862-1715331962=:1562--

