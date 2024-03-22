Return-Path: <linux-kselftest+bounces-6488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9068886BE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 13:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF1A1C22C75
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA24087F;
	Fri, 22 Mar 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXuTkTtG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006283FE5F;
	Fri, 22 Mar 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109496; cv=none; b=bPeAUdaHZ9BwPP4pPAAo16DjDIpZGg4a/90dL2gnaegLGZm4jmYXMz/301Z4lEMpcohgBVCznxw5qoWEL0UgJdPTGWg00tPSwnd59MpCY6cRGqzBl3O8bN7GnKUnhN34CRozfSAsfGJJ0yMzn06Z4Zc022HLJfjcg9XGh9khXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109496; c=relaxed/simple;
	bh=l0cx1LvrVM/uchJN7ZfC/+aKq/dZS79/LkCiMoIM0T4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YHA0fjE5HPTzc+RMcM/mFPDCJuRTF0zrpmXh6kpe+HsNYIj9JdtzVYlf47HBzj5J3OOuXMU4iqBnSxEvHxiNs2kft0O47h3URE3UsqH8JDHuynGepItWcA+/KiH5L6Itmm4M2pR+Fj7pHwTPmuDtUV+rT8IOoQLgl8K4y3q9bYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXuTkTtG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711109495; x=1742645495;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l0cx1LvrVM/uchJN7ZfC/+aKq/dZS79/LkCiMoIM0T4=;
  b=cXuTkTtGlbQIut9XbAygXeCEk9g3v5Ts1rEKiIPH3kEB1vtUZ0xV+CND
   olM0f1nhqP6pNcDk1HzdWdEbGsjnr4S+07IFNALUmKnUE4c1HsVobG/5N
   s/IRYxhF/rMKGtbOcF3eYAkvV2vCA5uvshG5PAZ7NRvjXf24OKbNtCohY
   3FmNe5HBeUVqza2Kg0U03Ye6qG8IAyARMVDlWsxMvv1E7+m/PYCF6jHY9
   RiqzCUZIYZRJfMdpS2HFENkZx1STcsAgLlrDfs/o2hTAGMi89FuOd78dN
   oRirkM4JRmPFFB8a107ccrTbjdB8oJmLaL6J/5scax9eNd8XiBMtyY+4o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9943216"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="9943216"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="14938103"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.18])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:11:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 22 Mar 2024 14:11:26 +0200 (EET)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/13] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
In-Reply-To: <fe5c0d10-a57c-4a3a-ae30-a7cfa93bc3e8@intel.com>
Message-ID: <f214c635-500f-43ea-fce8-0a7083bc1606@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com> <20240311135230.7007-3-ilpo.jarvinen@linux.intel.com> <fe5c0d10-a57c-4a3a-ae30-a7cfa93bc3e8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1924357458-1711109486=:1115"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1924357458-1711109486=:1115
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 19 Mar 2024, Reinette Chatre wrote:
> On 3/11/2024 6:52 AM, Ilpo J=C3=A4rvinen wrote:
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
>=20
> Thank you very much for doing this.
>=20
> > Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/resctrl_val.c | 72 +++++++++++++------
> >  1 file changed, 50 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/test=
ing/selftests/resctrl/resctrl_val.c
> > index 36139cba7be8..4df2cd738f88 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_val.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_val.c

> > -static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
> > +static int perf_open_imc_mem_bw(int cpu_no)
> >  {
> > -=09float reads, writes, of_mul_read, of_mul_write;
> >  =09int imc, j, ret;
> > =20
> > -=09/* Start all iMC counters to log values (both read and write) */
> > -=09reads =3D 0, writes =3D 0, of_mul_read =3D 1, of_mul_write =3D 1;
> >  =09for (imc =3D 0; imc < imcs; imc++) {
> >  =09=09for (j =3D 0; j < 2; j++) {
> >  =09=09=09ret =3D open_perf_event(imc, cpu_no, j);
> >  =09=09=09if (ret)
> >  =09=09=09=09return -1;
> >  =09=09}
>=20
> I'm feeling more strongly that this inner loop makes the code harder to
> understand and unwinding it would make it easier to understand.

Okay, I'll unwind them in the first patch.

> >  =09}
> > +}
> > +
> > +/*
> > + * get_mem_bw_imc - Memory band width as reported by iMC counters
> > + * @bw_report:=09=09Bandwidth report type (reads, writes)
> > + *
> > + * Memory B/W utilized by a process on a socket can be calculated usin=
g
> > + * iMC counters. Perf events are used to read these counters.
>=20
> In the above there are three variations of the same: "band width", "Bandw=
idth",
> and "B/W". Please just use one and use it consistently.

Okay but I'll do that in a separate patch because these are just the=20
"removed" lines above, the diff is more messy than the actual change=20
here as is often the case with this kind of split function refactoring=20
because the diff algorithm fails to pair the lines optimally from=20
human-readed PoV.

> > + * Return: =3D 0 on success. < 0 on failure.
> > + */
> > +static int get_mem_bw_imc(char *bw_report, float *bw_imc)
> > +{
> > +=09float reads, writes, of_mul_read, of_mul_write;
> > +=09int imc, j;
> > +
> > +=09/* Start all iMC counters to log values (both read and write) */
> > +=09reads =3D 0, writes =3D 0, of_mul_read =3D 1, of_mul_write =3D 1;
> > =20
> >  =09/*
> >  =09 * Get results which are stored in struct type imc_counter_config

> > @@ -696,7 +725,6 @@ int resctrl_val(const struct resctrl_test *test,
> >  =09=09struct resctrl_val_param *param)
> >  {
> >  =09char *resctrl_val =3D param->resctrl_val;
> > -=09unsigned long bw_resc_start =3D 0;
>=20
> In the current implementation the first iteration's starting measurement
> is, as seen above, 0 ... which makes the first measurement unreliable
> and dropped for both the MBA and MBM tests. In this enhancement, the
> first measurement is no longer skewed so much so I wonder if this enhance=
ment
> can be expanded to the analysis phase where first measurement no longer
> needs to be dropped?

In ideal world, yes, but I'll have to check the raw numbers. My general=20
feel is that the numbers tend to converge slowly with more iterations=20
being run so the first iteration might still be "off" by quite much (this=
=20
is definitely the case with CAT tests iterations but I'm not entirely sure=
=20
any more how it is with other selftests).

Thanks for the review.

--=20
 i.

--8323328-1924357458-1711109486=:1115--

