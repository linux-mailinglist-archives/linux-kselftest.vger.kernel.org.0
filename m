Return-Path: <linux-kselftest+bounces-11098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FC8D7C2B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 09:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E976D1F22A1C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 07:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0153A29F;
	Mon,  3 Jun 2024 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4z3CfQ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A093FBB7;
	Mon,  3 Jun 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398464; cv=none; b=uSmI5PJpxQCt30Ya8TSfW0Te6gXoZYMAeBnD5gQSGjrBiud6OtPdFeUSAdJboZ4/aNstPp5oRNPkktsg4qCtLkEesXjhsXV0G8LYrXyPd+ImTw9pBocLv+o9vY1WIKlAieHfke1IJwtLyUe22KOc+JLqylS275FaNMe5NY9qTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398464; c=relaxed/simple;
	bh=7bLHus1w4I0H00CVIohqk6b85k/ALsgSRLOtf5tu+uU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u64GwLH+UuGLYFW7ziSEOaOe809NY3SvUSaxfqfTlJ5oxEHMyfyqPzVggyqoK+5mTz6UnAnod00qDZBgDj8OVteNNJHcMZaK7KEDn47rgpto8QdzbCpjkfGBNgNHX8W9MnqgQCgvfOwICV102AD3pdvUO8lnlCVUgQvlTA7Y9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4z3CfQ1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717398463; x=1748934463;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=7bLHus1w4I0H00CVIohqk6b85k/ALsgSRLOtf5tu+uU=;
  b=f4z3CfQ12yfETHx0+A4x0O8urVO8235SeTFcLIkXiqLnOnswtE/246Qz
   BMyP7sNw+ICYIEIBYOHAVjWiHx8P7mhQavVo0fSqn8nXlhzycjcXHPxkY
   KUaqV2q6marqhkKHXn1V+j/dNMOBRy9n/oX0cvrB6TP1jvW5PwWFSA/jw
   nwIFVGh2EQK3aRtfyVQh0KIaxjmADF8yv1yPbZxkT8pxZJnl2oR3VGrF/
   CdeEnKNB1hTLPpeOQkfqbT2w4BWAat1fH3zSdBZMwGaBjqNRfc2MjDSTb
   wW8DiMtm0iLF/3NzlwtK2VWqCDPValM7p40O60KyUHtKyxzSfk50KxvnZ
   A==;
X-CSE-ConnectionGUID: agH3RbLKRWyxe+ScTyPJdg==
X-CSE-MsgGUID: +zg/HxqBTPawhQoUXfyeRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14037704"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="14037704"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:07:43 -0700
X-CSE-ConnectionGUID: ImDIemN4Rem3g8ch1zyFRw==
X-CSE-MsgGUID: vU+cfdDfRAWGPzKCN0G5Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="36871007"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.161])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:07:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 3 Jun 2024 10:07:35 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, 
    Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v5 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
In-Reply-To: <f6b1cf5f-b282-4a52-b09a-ac01ff5a6144@intel.com>
Message-ID: <a8f550a2-b9f0-5656-e8e4-bafc977c4dac@linux.intel.com>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com> <20240531131142.1716-3-ilpo.jarvinen@linux.intel.com> <f6b1cf5f-b282-4a52-b09a-ac01ff5a6144@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-673171939-1717398144=:1529"
Content-ID: <0fbd535e-c7be-3209-6627-5908e1495f37@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-673171939-1717398144=:1529
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <3143f12d-da6e-7a86-8815-6930cb9d94db@linux.intel.com>

On Fri, 31 May 2024, Reinette Chatre wrote:
> On 5/31/24 6:11 AM, Ilpo J=E4rvinen wrote:
> > For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that performs
> > the measurement over a duration of sleep(1) call. The memory bandwidth
> > numbers from IMC are derived over this duration. The resctrl FS derived
> > memory bandwidth, however, is calculated inside measure_vals() and only
> > takes delta between the previous value and the current one which
> > besides the actual test, also samples inter-test noise.
> >=20
> > Rework the logic in measure_vals() and get_mem_bw_imc() such that the
> > resctrl FS memory bandwidth section covers much shorter duration
> > closely matching that of the IMC perf counters to improve measurement
> > accuracy.
> >=20
> > For the second read after rewind() to return a fresh value, also
> > newline has to be consumed by the fscanf().
> >=20
> > Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >=20
> > v5:
> > - Open mem bw file once and use rewind()
> > - Read \n from the mem bw file to allow rewind to return a new value.
> > v4:
> > - Open resctrl mem bw file (twice) beforehand to avoid opening it durin=
g
> >    the test
> > v3:
> > - Don't drop Return: entry from perf_open_imc_mem_bw() func comment
> > ---
> >   tools/testing/selftests/resctrl/resctrl_val.c | 115 ++++++++++++-----=
-
> >   1 file changed, 80 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/resctrl/resctrl_val.c
> > b/tools/testing/selftests/resctrl/resctrl_val.c
> > index f55f5989de72..6231275a6e6c 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_val.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_val.c

> >   @@ -616,13 +645,17 @@ static void initialize_llc_occu_resctrl(const c=
har
> > *ctrlgrp, const char *mongrp,
> >   }
> >     static int measure_vals(const struct user_params *uparams,
> > -=09=09=09struct resctrl_val_param *param,
> > -=09=09=09unsigned long *bw_resc_start)
> > +=09=09=09struct resctrl_val_param *param)
> >   {
> > -=09unsigned long bw_resc, bw_resc_end;
> > +=09unsigned long bw_resc, bw_resc_start, bw_resc_end;
> > +=09FILE *mem_bw_fp;
> >   =09float bw_imc;
> >   =09int ret;
> >   +=09mem_bw_fp =3D open_mem_bw_resctrl(mbm_total_path);
> > +=09if (!mem_bw_fp)
> > +=09=09return -1;
> > +
>=20
> The comment below seems to refer to the resctrl measurement
> that starts with the above snippet. Any reason why this snippet
> is above the comment that follows since the comment seems to
> apply to it?

No particular reason. I've made the comment a function one now which=20
seemed better placement for it.

> >   =09/*
> >   =09 * Measure memory bandwidth from resctrl and from
> >   =09 * another source which is perf imc value or could

> > @@ -630,22 +663,35 @@ static int measure_vals(const struct user_params
> > *uparams,
> >   =09 * Compare the two values to validate resctrl value.
> >   =09 * It takes 1sec to measure the data.
> >   =09 */
> > -=09ret =3D get_mem_bw_imc(uparams->cpu, param->bw_report, &bw_imc);
> > +=09ret =3D perf_open_imc_mem_bw(uparams->cpu);
> >   =09if (ret < 0)
> > -=09=09return ret;
> > +=09=09goto close_fp;
> >   -=09ret =3D get_mem_bw_resctrl(&bw_resc_end);
> > +=09ret =3D get_mem_bw_resctrl(mem_bw_fp, &bw_resc_start);
> >   =09if (ret < 0)
> > -=09=09return ret;
> > +=09=09goto close_fp;
>=20
> perf_close_imc_mem_bw() seems to be missing from error path?
>=20
> Symmetrical code is easier to understand. Looks like
> perf_close_imc_mem_bw() stayed behind in get_mem_bw_imc() but I think
> it would make things easier if get_mem_bw_imc() no longer calls
> perf_close_imc_mem_bw() but instead leave that to the one that
> calls perf_open_imc_mem_bw().

Okay yeah, it makes things more tractable.

--=20
 i.
--8323328-673171939-1717398144=:1529--

