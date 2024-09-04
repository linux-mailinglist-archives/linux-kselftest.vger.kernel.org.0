Return-Path: <linux-kselftest+bounces-17115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A482696BB24
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A731C2140C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE91D1738;
	Wed,  4 Sep 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkSmSRhm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854371D0152;
	Wed,  4 Sep 2024 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450218; cv=none; b=t54Xp+eqEYKXOsK4XJNvLGkfLBZ/+V4JJ5DF/V4hlSIgN0WEN8FsgSy+5+EQf8q7FjwhBeeGPOvwc6FyDSSPzzwJgnZY3Akut/gSY7ISPCpPQeTFFa42eGnxQX2blvT4b7mQaapkAjadrhWW9KHSe/ByyW8WLahdZxepRuhUZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450218; c=relaxed/simple;
	bh=zjBVlk/yhOGOzS0iRcRzsA/N7g9eaUNjYYAjn87yIBo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GQ+fu8ourSFWTdF1goEra8jWOBR+HNHwsL4b5KTC5Z5mzhIU4cr29ZE8j6WOmAfIuLSKBSgMn7Lu70Yxd5gBPinZD/jglBButhnIhhvOrZhgCJfxH0C4SNmH1UWedrUKdljOkdY4aZ6T2gsDkwz8AB+hB0LK7mh1W9xwAfffYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkSmSRhm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725450217; x=1756986217;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=zjBVlk/yhOGOzS0iRcRzsA/N7g9eaUNjYYAjn87yIBo=;
  b=KkSmSRhmzBcnc+4W6NEJos9TNWfxfWqcYWhiJjfYE2IxG5eHLnupszgB
   Kfi/mRg2cVV5eV5uqjTxkOwguhLZOXuKcTuBO/HZ98anbd4TSykeovOOu
   aE79f3lpCbesfPsUFtVOnDMdaFxsPH38nZvtZj1dfOzK5AK0M2ijgo71/
   2swXarALGCfgo2yFmi5TevqVw7BkCIRAyW7Qak+n8hUhAUqhvfjdoeFdo
   +KAt7+o1oim6NY+osPyUXQLXqrN0+PgVVr2lQD5Uyo42S3yxMQtoXPZA1
   LUCiOX2+YMlkd2P2qzlv09QM0LMClfZ6BBdEI1S696iA2KY/lD7ojXL6o
   w==;
X-CSE-ConnectionGUID: +T+v42QwRcOjcxnjywk2sA==
X-CSE-MsgGUID: tO5geDBIREWN2rznI53Z4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27894314"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="27894314"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:43:36 -0700
X-CSE-ConnectionGUID: kLu/NAGeRBaO/vmjB1Bmnw==
X-CSE-MsgGUID: 9BLEMdrLSE+jaqkM+WggBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65292060"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO localhost) ([10.245.245.156])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:43:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 4 Sep 2024 14:43:28 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] selftests/resctrl: Do not compare performance counters
 and resctrl at low bandwidth
In-Reply-To: <87e4788c-6407-41a8-b201-e3f05064e5a6@intel.com>
Message-ID: <238af9fe-0d7b-9bc1-9923-35ef74aad360@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <9bbefa3b9a62319698907d10e8b78f1b999c311b.1724970211.git.reinette.chatre@intel.com> <5d063290-9da4-c9ca-e5c5-cb0083d7483f@linux.intel.com> <87e4788c-6407-41a8-b201-e3f05064e5a6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1106607153-1725450011=:1078"
Content-ID: <47ad0aa6-92de-96b5-688f-b4750b4f37a4@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1106607153-1725450011=:1078
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <726c93e7-1667-4717-c878-2a0e88a600cf@linux.intel.com>

On Fri, 30 Aug 2024, Reinette Chatre wrote:
> On 8/30/24 4:42 AM, Ilpo J=E4rvinen wrote:
> > On Thu, 29 Aug 2024, Reinette Chatre wrote:
> >=20
> > > The MBA test incrementally throttles memory bandwidth, each time
> > > followed by a comparison between the memory bandwidth observed
> > > by the performance counters and resctrl respectively.
> > >=20
> > > While a comparison between performance counters and resctrl is
> > > generally appropriate, they do not have an identical view of
> > > memory bandwidth. For example RAS features or memory performance
> > > features that generate memory traffic may drive accesses that are
> > > counted differently by performance counters and MBM respectively,
> > > for instance generating "overhead" traffic which is not counted
> > > against any specific RMID. As a ratio, this different view of memory
> > > bandwidth becomes more apparent at low memory bandwidths.
> >=20
> > Interesting.
> >=20
> > I did some time back prototype with a change to MBM test such that inst=
ead
> > of using once=3Dfalse I changed fill_buf to be able to run N passes thr=
ough
> > the buffer which allowed me to know how many reads were performed by th=
e
> > benchmark. This yielded numerical difference between all those 3 values
> > (# of reads, MBM, perf) which also varied from arch to another so it
> > didn't end up making an usable test.
> >=20
> > I guess I now have an explanation for at least a part of the difference=
s.
> >=20
> > > It is not practical to enable/disable the various features that
> > > may generate memory bandwidth to give performance counters and
> > > resctrl an identical view. Instead, do not compare performance
> > > counters and resctrl view of memory bandwidth when the memory
> > > bandwidth is low.
> > >=20
> > > Bandwidth throttling behaves differently across platforms
> > > so it is not appropriate to drop measurement data simply based
> > > on the throttling level. Instead, use a threshold of 750MiB
> > > that has been observed to support adequate comparison between
> > > performance counters and resctrl.
> > >=20
> > > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > > ---
> > >   tools/testing/selftests/resctrl/mba_test.c | 7 +++++++
> > >   tools/testing/selftests/resctrl/resctrl.h  | 6 ++++++
> > >   2 files changed, 13 insertions(+)
> > >=20
> > > diff --git a/tools/testing/selftests/resctrl/mba_test.c
> > > b/tools/testing/selftests/resctrl/mba_test.c
> > > index cad473b81a64..204b9ac4b108 100644
> > > --- a/tools/testing/selftests/resctrl/mba_test.c
> > > +++ b/tools/testing/selftests/resctrl/mba_test.c
> > > @@ -96,6 +96,13 @@ static bool show_mba_info(unsigned long *bw_imc,
> > > unsigned long *bw_resc)
> > >     =09=09avg_bw_imc =3D sum_bw_imc / (NUM_OF_RUNS - 1);
> > >   =09=09avg_bw_resc =3D sum_bw_resc / (NUM_OF_RUNS - 1);
> > > +=09=09if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc <
> > > THROTTLE_THRESHOLD) {
> > > +=09=09=09ksft_print_msg("Bandwidth below threshold (%d MiB).
> > > Dropping results from MBA schemata %u.\n",
> > > +=09=09=09=09=09THROTTLE_THRESHOLD,
> > > +=09=09=09=09=09ALLOCATION_MAX - ALLOCATION_STEP *
> > > allocation);
> >=20
> > The second one too should be %d.
> >=20
>=20
> hmmm ... I intended to have it be consistent with the ksft_print_msg() th=
at
> follows. Perhaps allocation can be made unsigned instead?

If you go that way, then it would be good to make the related defines and=
=20
allocation in mba_setup() unsigned too, although the latter is a bit scary=
=20
because it does allocation -=3D ALLOCATION_STEP which could underflow if th=
e=20
defines are ever changed.

--=20
 i.
--8323328-1106607153-1725450011=:1078--

