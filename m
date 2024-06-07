Return-Path: <linux-kselftest+bounces-11350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FDD9000AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4A9B23DDD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B6A15B967;
	Fri,  7 Jun 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lpd2wmrQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7015B97B;
	Fri,  7 Jun 2024 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755723; cv=none; b=VJ7FdqDZ6ScMzdMpeR/2fnqSAFzp0O9DAKcnznln9v+8TqzMQ6hJuw78GJxOOrKU8UkTJBXl9f7YZy6feHry7n0rGtlMrr1+8S4s1InbCJlriSEjUFP9tVVASQNHX0tc0FRlyKaJHtnjhaQBRrrtCfVdn55/WzBZx2lsXZAjfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755723; c=relaxed/simple;
	bh=ahHJ8hO6zogJughVEF60nwoGFTdLtVu43+xKCUgoGIQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=idfOOld7TBlzL1Bh6MJaY4CTF/Srz6OH2xL+nnSea6Qdht4jfMVcN6WmWncZgvqXK4XsDsTUoGXgnaJDzXY0nC4F4aizqYYKqZd7uC7yRQJ+ZKW42OTrPTQyw+qloN93f9puH4biWsAkSDy6J0hIlbG5yAk5bvUytHXJD/yVEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lpd2wmrQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717755722; x=1749291722;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ahHJ8hO6zogJughVEF60nwoGFTdLtVu43+xKCUgoGIQ=;
  b=Lpd2wmrQv9iX7nwBR/aIjkH0UuCSDfV9fuY1dHpVOt8RYR9mqtZRzfXm
   YipLn8umA+/01AGyITE8sLZMZRPtautDpQJZ10csi2b4P0WwqfCwXZDeH
   oAYV2nrC0utehp/LlujNZhWU54zH38ZeC4SjDyBqmDUD5G8EOXf+WhkEJ
   mMXrdo1bQV1MKt0EkutyQfjQflzl4FcKFNnCtVedWg7VVPYYUywK4u6YV
   yF48F+bCFkDbEnZdcH/V0+WhzzjCsXpfa8BdqGJNdxzkepXRMQBU4I91+
   RUe/vwyOK4pXw90LKXVUsHjPzQL9aPQ1I28Hqydcu4GPCieKrosOiLRZ2
   Q==;
X-CSE-ConnectionGUID: n4rbJaRgRP+G+y4FquFLog==
X-CSE-MsgGUID: x1xj6ZQVRkieShC9gc2xRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="18322599"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="18322599"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 03:22:01 -0700
X-CSE-ConnectionGUID: nP9v+ZaATTO0i86UUU8hFQ==
X-CSE-MsgGUID: Av5Jl0VFSkigJPM84uILiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38730407"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 03:21:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Jun 2024 13:21:54 +0300 (EEST)
To: Babu Moger <babu.moger@amd.com>
cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>, 
    shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    peternewman@google.com, eranian@google.com
Subject: Re: [PATCH] selftests/resctrl: Fix noncont_cat_run_test for AMD
In-Reply-To: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
Message-ID: <475f7146-85ab-4992-5307-5dd4ab0184ee@linux.intel.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-447825242-1717755714=:1044"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-447825242-1717755714=:1044
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 5 Jun 2024, Babu Moger wrote:

> The selftest noncont_cat_run_test fails on AMD with the warnings. Reason
> is, AMD supports non contiguous CBM masks but does not report it via CPUI=
D.
>=20
> Update noncont_cat_run_test to check for the vendor when verifying CPUID.
>=20
> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test=
")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> This was part of the series
> https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
> Sending this as a separate fix per review comments.
> ---
>  tools/testing/selftests/resctrl/cat_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/s=
elftests/resctrl/cat_test.c
> index d4dffc934bc3..b2988888786e 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -308,7 +308,7 @@ static int noncont_cat_run_test(const struct resctrl_=
test *test,
>  =09else
>  =09=09return -EINVAL;
> =20
> -=09if (sparse_masks !=3D ((ecx >> 3) & 1)) {
> +=09if ((get_vendor() =3D=3D ARCH_INTEL) && sparse_masks !=3D ((ecx >> 3)=
 & 1)) {
>  =09=09ksft_print_msg("CPUID output doesn't match 'sparse_masks' file con=
tent!\n");
>  =09=09return 1;
>  =09}
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-447825242-1717755714=:1044--

