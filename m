Return-Path: <linux-kselftest+bounces-17377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E096EE76
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 10:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9F3282AC8
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 08:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C457158523;
	Fri,  6 Sep 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcXOh/ZS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE32BE6C;
	Fri,  6 Sep 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612298; cv=none; b=VTZ/6DUjXTEf4E64cAVL2qWYHZzrv0qXZjIilD2XZN5lhgToH9gz3htBZU6aMzUxOtnWcMr0irnnXj6mNyQMoOZrFSXacwWyrsqtHQdpXqEiUtNZfXc7A+oyNFV9ZCCYHXKpo1b/XkINuUd61SBdhDz+cOjvbKwtMAawYHv4PtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612298; c=relaxed/simple;
	bh=Do3eogBIraN2nqI3zYsHTW0qBnw6yjfECUNnh11v5/0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JbcoNo9GcMxpt3N3P3WGFU4EJSk6a4/lN2iwGbF3IDHYbQVmpCyZNpsxD3oLfribbK0IqXGhc+o2XBy1C2sjeVwb787FNaEetxImX2vEIRsohGcVA3pWW6hxOcM5P6fRjfZpRz15NeMy4q2ujVsuKBVMG+QW/Ho1XRbOHg5pmHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcXOh/ZS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725612296; x=1757148296;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Do3eogBIraN2nqI3zYsHTW0qBnw6yjfECUNnh11v5/0=;
  b=lcXOh/ZSBu3ZdFb9LiDUog464EFSAESWNp7vGE6YEOLD1BhcnsypU9k+
   22yO9RBV8fj0LIp++QlJ4fHvXfcouyQZN4baiNIrz3Xv5CYpsnbb1vGnt
   Fhc4VACP3uexPjkZW5Bj/DR7CUOA7Zh/dKubN30vMx9+n6x8BoHnwgBgx
   j4l+JO5AilsTQzEgJa2YpTkMDSqSNLbg850NHUfNrg07ysIQ8ITTdFHFs
   xooDadnZhk4ObPGhHz6DLEdPvH8ZkN0l3RjASXfy4nZlF2UxtXwgsoThq
   tDTz4WK4jo1PY6owg5MkWv/aJh/dSiF4aGLEqZaG/WDDHrkYRgSrAcNpB
   Q==;
X-CSE-ConnectionGUID: oNIBhgsLScCu8bH90+wg2w==
X-CSE-MsgGUID: LG40UaDXSNeJE3FQK6nnLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24519453"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="24519453"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 01:44:56 -0700
X-CSE-ConnectionGUID: e+d0lGLyS9u7XVBU85y1sQ==
X-CSE-MsgGUID: yNIZMS5RTu6xOXT5V/A+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="66126590"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 01:44:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Sep 2024 11:44:48 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] selftests/resctrl: Do not compare performance counters
 and resctrl at low bandwidth
In-Reply-To: <43b71606-be6a-495f-bec7-279bb812d4c8@intel.com>
Message-ID: <c3aa4289-40aa-c158-8fde-8a35a6002783@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <9bbefa3b9a62319698907d10e8b78f1b999c311b.1724970211.git.reinette.chatre@intel.com> <5d063290-9da4-c9ca-e5c5-cb0083d7483f@linux.intel.com> <87e4788c-6407-41a8-b201-e3f05064e5a6@intel.com>
 <238af9fe-0d7b-9bc1-9923-35ef74aad360@linux.intel.com> <9b2da518-89ce-4f9b-92f2-d317ed892886@intel.com> <1903ac13-5c9c-ef8d-78e0-417ac34a971b@linux.intel.com> <43b71606-be6a-495f-bec7-279bb812d4c8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1988363065-1725612288=:1053"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1988363065-1725612288=:1053
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 Sep 2024, Reinette Chatre wrote:
> On 9/5/24 4:45 AM, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 4 Sep 2024, Reinette Chatre wrote:
> > > On 9/4/24 4:43 AM, Ilpo J=C3=A4rvinen wrote:
> > > > On Fri, 30 Aug 2024, Reinette Chatre wrote:
> > > > > On 8/30/24 4:42 AM, Ilpo J=C3=A4rvinen wrote:
> > > > > > On Thu, 29 Aug 2024, Reinette Chatre wrote:
> > > > > >=20
> > > > > > > The MBA test incrementally throttles memory bandwidth, each t=
ime
> > > > > > > followed by a comparison between the memory bandwidth observe=
d
> > > > > > > by the performance counters and resctrl respectively.
> > > > > > >=20
> > > > > > > While a comparison between performance counters and resctrl i=
s
> > > > > > > generally appropriate, they do not have an identical view of
> > > > > > > memory bandwidth. For example RAS features or memory performa=
nce
> > > > > > > features that generate memory traffic may drive accesses that=
 are
> > > > > > > counted differently by performance counters and MBM respectiv=
ely,
> > > > > > > for instance generating "overhead" traffic which is not count=
ed
> > > > > > > against any specific RMID. As a ratio, this different view of
> > > > > > > memory
> > > > > > > bandwidth becomes more apparent at low memory bandwidths.
> > > > > >=20
> > > > > > Interesting.
> > > > > >=20
> > > > > > I did some time back prototype with a change to MBM test such t=
hat
> > > > > > instead
> > > > > > of using once=3Dfalse I changed fill_buf to be able to run N pa=
sses
> > > > > > through
> > > > > > the buffer which allowed me to know how many reads were perform=
ed by
> > > > > > the
> > > > > > benchmark. This yielded numerical difference between all those =
3
> > > > > > values
> > > > > > (# of reads, MBM, perf) which also varied from arch to another =
so it
> > > > > > didn't end up making an usable test.
> > > > > >=20
> > > > > > I guess I now have an explanation for at least a part of the
> > > > > > differences.
> > > > > >=20
> > > > > > > It is not practical to enable/disable the various features th=
at
> > > > > > > may generate memory bandwidth to give performance counters an=
d
> > > > > > > resctrl an identical view. Instead, do not compare performanc=
e
> > > > > > > counters and resctrl view of memory bandwidth when the memory
> > > > > > > bandwidth is low.
> > > > > > >=20
> > > > > > > Bandwidth throttling behaves differently across platforms
> > > > > > > so it is not appropriate to drop measurement data simply base=
d
> > > > > > > on the throttling level. Instead, use a threshold of 750MiB
> > > > > > > that has been observed to support adequate comparison between
> > > > > > > performance counters and resctrl.
> > > > > > >=20
> > > > > > > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > > > > > > ---
> > > > > > >     tools/testing/selftests/resctrl/mba_test.c | 7 +++++++
> > > > > > >     tools/testing/selftests/resctrl/resctrl.h  | 6 ++++++
> > > > > > >     2 files changed, 13 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/tools/testing/selftests/resctrl/mba_test.c
> > > > > > > b/tools/testing/selftests/resctrl/mba_test.c
> > > > > > > index cad473b81a64..204b9ac4b108 100644
> > > > > > > --- a/tools/testing/selftests/resctrl/mba_test.c
> > > > > > > +++ b/tools/testing/selftests/resctrl/mba_test.c
> > > > > > > @@ -96,6 +96,13 @@ static bool show_mba_info(unsigned long
> > > > > > > *bw_imc,
> > > > > > > unsigned long *bw_resc)
> > > > > > >       =09=09avg_bw_imc =3D sum_bw_imc / (NUM_OF_RUNS - 1);
> > > > > > >     =09=09avg_bw_resc =3D sum_bw_resc / (NUM_OF_RUNS - 1);
> > > > > > > +=09=09if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc <
> > > > > > > THROTTLE_THRESHOLD) {
> > > > > > > +=09=09=09ksft_print_msg("Bandwidth below threshold (%d
> > > > > > > MiB).
> > > > > > > Dropping results from MBA schemata %u.\n",
> > > > > > > +=09=09=09=09=09THROTTLE_THRESHOLD,
> > > > > > > +=09=09=09=09=09ALLOCATION_MAX -
> > > > > > > ALLOCATION_STEP *
> > > > > > > allocation);
> > > > > >=20
> > > > > > The second one too should be %d.
> > > > > >=20
> > > > >=20
> > > > > hmmm ... I intended to have it be consistent with the ksft_print_=
msg()
> > > > > that
> > > > > follows. Perhaps allocation can be made unsigned instead?
> > > >=20
> > > > If you go that way, then it would be good to make the related defin=
es
> > > > and
> > > > allocation in mba_setup() unsigned too, although the latter is a bi=
t
> > > > scary
> > >=20
> > > Sure, will look into that.
> > >=20
> > > > because it does allocation -=3D ALLOCATION_STEP which could underfl=
ow if
> > > > the
> > > > defines are ever changed.
> > > >=20
> > >=20
> > > Is this not already covered in the following check:
> > > =09if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
> > > =09=09return END_OF_TESTS;
> > >=20
> > > We are talking about hardcoded constants though.
> >=20
> > Borderline yes. It is "covered" by the allocation > ALLOCATION_MAX but
> > it's also very non-intuitive to let the value underflow and then check =
for
> > that with the > operator.
>=20
> My understanding is that this is the traditional way of checking overflow
> (or more accurately wraparound). There are several examples of this patte=
rn
> in the kernel and it is also the pattern that I understand Linus referred
> to as "traditional" in [1]. Even the compiler's intrinsic overflow checke=
rs
> do checking in this way (perform the subtraction and then check if it
> overflowed) [2].

Fair enough. I've never come across that kind of claim before.

> > You're correct that they're constants so one would need to tweak the
> > source to end up into this condition in the first place.
> >=20
> > Perhaps I'm being overly pendantic here but I in general don't like
> > leaving trappy and non-obvious logic like that lying around because one
> > day one of such will come back biting.
>=20
> It is not clear to me what is "trappy" about this. The current checks wil=
l
> catch the wraparound if somebody changes ALLOCATION_STEP in your scenario=
, no?
>
> > So, if a variable is unsigned and we ever do subtraction (or adding
> > negative numbers to it), I'd prefer additional check to prevent ever
> > underflowing it unexpectedly. Or leave them signed.
>=20
> To support checking at the time of subtraction we either need to change t=
he
> flow of that function since it cannot exit with failure if that subtracti=
on
> fails because of overflow/wraparound, or we need to introduce more state =
that
> will be an additional check that the existing
> "if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)"
> would have caught anyway.
>=20
> In either case, to do this checking at the time of subtraction the ideal =
way
> would be to use check_sub_overflow() ... but it again does exactly what
> you find to be non-intuitive since the implementation in
> tools/include/linux/overflow.h uses the gcc intrinsics that does subtract=
ion
> first and then checks if overflow occurred.

It's trappy because by glance, that check looks unnecessary since=20
allocation starts from max and goes downwards. Also worth to note,
the check is not immediately after the decrement but done on the next=20
iteration.

The risk here is that somebody removes allocation > ALLOCATION_MAX check.

Something called check_sub_overflow() is not subject to a similar risk=20
regardless of what operations occur inside it.

> It is not clear to me what problem you are aiming to solve here. If the
> major concern is that the current logic is not obvious, perhaps it can
> be clarified with a comment as below:
>=20
>  =09if (runs_per_allocation++ !=3D 0)
>  =09=09return 0;
>  +=09/*
> +=09 * Do not attempt allocation outside valid range. Safeguard
> +=09 * against any potential wraparound caused by subtraction.
> +=09 */
>  =09if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
>  =09=09return END_OF_TESTS;

That would probably help but then it seems Linus is against such attempts
and considers this hole in the cheese (i.e., representing something that=20
is clearly a negative number with a positive number) "traditional".

--=20
 i.

--8323328-1988363065-1725612288=:1053--

