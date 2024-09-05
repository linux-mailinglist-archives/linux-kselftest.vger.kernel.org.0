Return-Path: <linux-kselftest+bounces-17218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A93296D76F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6531C22E70
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719714F10E;
	Thu,  5 Sep 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICH7sHrh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB392F44;
	Thu,  5 Sep 2024 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536732; cv=none; b=B8NhqlqX7Wb3ThNZDrno9jcidOovW1hAFkguAP7JKN2gn5dP5w+VeZw180DWivPioylZHAfCL9VXxLzfDjb5XbHRqOZP+9gFTWKGEeyFDqecSM8NRf3H1YyjRYSx6FsrxUohYHCbqtl0becK5Rh3j15H1ACeR5AzkdZjSdy26lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536732; c=relaxed/simple;
	bh=rsuvjsq9yWHaIiio6rzcDd8xhCNMkYPGUiBKzB/0y+g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Nn/NrGOR8b2Mt3rKlYM8sgFpxY9KFNQq0gUHxvcixcVZhEyfrufd8EKoQKLG7XyWZBkXOAfWKOiar4RblPgorBXjQZ9tHqiyvovXyk6Pblg+q8vVOXfOcFeeRY+D/9Gwjjb9AoTxIZ5DU/hhRABtaSROUwhThVyvrGXmQbXMoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICH7sHrh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725536731; x=1757072731;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rsuvjsq9yWHaIiio6rzcDd8xhCNMkYPGUiBKzB/0y+g=;
  b=ICH7sHrhJ4sG3Uzy7AulkqjsALFLw64bxujvc7uFPITgIwKla9fFqd+f
   /QbvGAaZcWXhBcS/DcJBeD/t+WQ3SYEqB5MupJvMt12e8+DHImXjOUba8
   Q6wvykRpEYyC1QIgWLYNqkOxbQSxZsl0kIB1mP6ssE3VmkW8liyMtiTG4
   0/9a9scCl75B0L2cgOwBE3n46dc8OCimics0Ipkw2mYG/tXPBrYKXraXA
   ybl1V+6bHErBR6QCsa31kbXe457Tu7vKrQ8M3IqM0cKcV+xlcfnbsoWER
   J9A73OIbfidQEJKF4t8SAzGVOaZ/XpRhmXc+9so4A3VkbZdU7634cpMwh
   g==;
X-CSE-ConnectionGUID: F96GqnQYRtGmDwiSoKKsDg==
X-CSE-MsgGUID: lE02CT3WSdStvhr9BxgVEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24363107"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24363107"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 04:45:30 -0700
X-CSE-ConnectionGUID: YlqjkjloTr+cUw0WoYUkeg==
X-CSE-MsgGUID: h/GzFp4bQhetKRN0mThWtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="66119017"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.31])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 04:45:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Sep 2024 14:45:21 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] selftests/resctrl: Do not compare performance counters
 and resctrl at low bandwidth
In-Reply-To: <9b2da518-89ce-4f9b-92f2-d317ed892886@intel.com>
Message-ID: <1903ac13-5c9c-ef8d-78e0-417ac34a971b@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <9bbefa3b9a62319698907d10e8b78f1b999c311b.1724970211.git.reinette.chatre@intel.com> <5d063290-9da4-c9ca-e5c5-cb0083d7483f@linux.intel.com> <87e4788c-6407-41a8-b201-e3f05064e5a6@intel.com>
 <238af9fe-0d7b-9bc1-9923-35ef74aad360@linux.intel.com> <9b2da518-89ce-4f9b-92f2-d317ed892886@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1594777459-1725536721=:1411"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1594777459-1725536721=:1411
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 4 Sep 2024, Reinette Chatre wrote:
> On 9/4/24 4:43 AM, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 30 Aug 2024, Reinette Chatre wrote:
> > > On 8/30/24 4:42 AM, Ilpo J=C3=A4rvinen wrote:
> > > > On Thu, 29 Aug 2024, Reinette Chatre wrote:
> > > >=20
> > > > > The MBA test incrementally throttles memory bandwidth, each time
> > > > > followed by a comparison between the memory bandwidth observed
> > > > > by the performance counters and resctrl respectively.
> > > > >=20
> > > > > While a comparison between performance counters and resctrl is
> > > > > generally appropriate, they do not have an identical view of
> > > > > memory bandwidth. For example RAS features or memory performance
> > > > > features that generate memory traffic may drive accesses that are
> > > > > counted differently by performance counters and MBM respectively,
> > > > > for instance generating "overhead" traffic which is not counted
> > > > > against any specific RMID. As a ratio, this different view of mem=
ory
> > > > > bandwidth becomes more apparent at low memory bandwidths.
> > > >=20
> > > > Interesting.
> > > >=20
> > > > I did some time back prototype with a change to MBM test such that
> > > > instead
> > > > of using once=3Dfalse I changed fill_buf to be able to run N passes
> > > > through
> > > > the buffer which allowed me to know how many reads were performed b=
y the
> > > > benchmark. This yielded numerical difference between all those 3 va=
lues
> > > > (# of reads, MBM, perf) which also varied from arch to another so i=
t
> > > > didn't end up making an usable test.
> > > >=20
> > > > I guess I now have an explanation for at least a part of the
> > > > differences.
> > > >=20
> > > > > It is not practical to enable/disable the various features that
> > > > > may generate memory bandwidth to give performance counters and
> > > > > resctrl an identical view. Instead, do not compare performance
> > > > > counters and resctrl view of memory bandwidth when the memory
> > > > > bandwidth is low.
> > > > >=20
> > > > > Bandwidth throttling behaves differently across platforms
> > > > > so it is not appropriate to drop measurement data simply based
> > > > > on the throttling level. Instead, use a threshold of 750MiB
> > > > > that has been observed to support adequate comparison between
> > > > > performance counters and resctrl.
> > > > >=20
> > > > > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > > > > ---
> > > > >    tools/testing/selftests/resctrl/mba_test.c | 7 +++++++
> > > > >    tools/testing/selftests/resctrl/resctrl.h  | 6 ++++++
> > > > >    2 files changed, 13 insertions(+)
> > > > >=20
> > > > > diff --git a/tools/testing/selftests/resctrl/mba_test.c
> > > > > b/tools/testing/selftests/resctrl/mba_test.c
> > > > > index cad473b81a64..204b9ac4b108 100644
> > > > > --- a/tools/testing/selftests/resctrl/mba_test.c
> > > > > +++ b/tools/testing/selftests/resctrl/mba_test.c
> > > > > @@ -96,6 +96,13 @@ static bool show_mba_info(unsigned long *bw_im=
c,
> > > > > unsigned long *bw_resc)
> > > > >      =09=09avg_bw_imc =3D sum_bw_imc / (NUM_OF_RUNS - 1);
> > > > >    =09=09avg_bw_resc =3D sum_bw_resc / (NUM_OF_RUNS - 1);
> > > > > +=09=09if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc <
> > > > > THROTTLE_THRESHOLD) {
> > > > > +=09=09=09ksft_print_msg("Bandwidth below threshold (%d
> > > > > MiB).
> > > > > Dropping results from MBA schemata %u.\n",
> > > > > +=09=09=09=09=09THROTTLE_THRESHOLD,
> > > > > +=09=09=09=09=09ALLOCATION_MAX -
> > > > > ALLOCATION_STEP *
> > > > > allocation);
> > > >=20
> > > > The second one too should be %d.
> > > >=20
> > >=20
> > > hmmm ... I intended to have it be consistent with the ksft_print_msg(=
)
> > > that
> > > follows. Perhaps allocation can be made unsigned instead?
> >=20
> > If you go that way, then it would be good to make the related defines a=
nd
> > allocation in mba_setup() unsigned too, although the latter is a bit sc=
ary
>=20
> Sure, will look into that.
>=20
> > because it does allocation -=3D ALLOCATION_STEP which could underflow i=
f the
> > defines are ever changed.
> >=20
>=20
> Is this not already covered in the following check:
> =09if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
> =09=09return END_OF_TESTS;
>=20
> We are talking about hardcoded constants though.

Borderline yes. It is "covered" by the allocation > ALLOCATION_MAX but=20
it's also very non-intuitive to let the value underflow and then check for=
=20
that with the > operator.

You're correct that they're constants so one would need to tweak the=20
source to end up into this condition in the first place.

Perhaps I'm being overly pendantic here but I in general don't like=20
leaving trappy and non-obvious logic like that lying around because one=20
day one of such will come back biting.

So, if a variable is unsigned and we ever do subtraction (or adding=20
negative numbers to it), I'd prefer additional check to prevent ever=20
underflowing it unexpectedly. Or leave them signed.

--=20
 i.

--8323328-1594777459-1725536721=:1411--

