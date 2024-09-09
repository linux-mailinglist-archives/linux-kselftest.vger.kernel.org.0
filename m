Return-Path: <linux-kselftest+bounces-17513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224119711B5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46DC7B23CAC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2543F1B1511;
	Mon,  9 Sep 2024 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfgEEqbr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020304A1D;
	Mon,  9 Sep 2024 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869605; cv=none; b=oB1qqJjbPt6W+LEQ8sywNfIujdfDF2vQLjAXPnTS8ejecNBcuEfKkGAw/gaUbvwdjho5E3FkHOX85kPooJ0+wh+jVUvvtYVEYX6BBUiYgLf26beDyX8w6igO0PlFeKz4zWz44oPdnUDJiqJ2Xg7R1kAZkqeUZQGnOB8FYqocG18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869605; c=relaxed/simple;
	bh=MVL8uSiv4H6d8aAzZvcrDZfw5iP5Jdgx3/mHm8To2Tw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=adMNA3OtSSG6NO1onj5+Z+EqAzuK/+cv/M81c8mtwMysbOzEUAVACstaQ4MV46FkWKtlCaQCcxrPKgErr98GXv13womOiTtf+tbELMGYIz5mMpe6H4q/Duoilj1Y+9/kNFWYaa2XZQhMN2AKBtbkU8WinLXDLFjylhacJao0CEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfgEEqbr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725869603; x=1757405603;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MVL8uSiv4H6d8aAzZvcrDZfw5iP5Jdgx3/mHm8To2Tw=;
  b=nfgEEqbrQxeZfa8h8mJSFhLAlryzem/tv2l1wR4wRuasSUxU1NUGIctF
   0ojhxDkr2qnvRLuCwPjMDwFIW9KJhbtoWMwz18/eTEk/a0FUIhZKBef14
   lwcXfEYkNqN6fJ6i3f3w8KMdhC/pn+MJk/GsjAZ0PPKAhbJ/6pp6YYqi0
   h6RLOhs0xFxmr3zr44XElsUK7GpjqgiaLOVddNoFGJWTeNRL3YYBdiDGu
   GMEh0bsYmZung4vPjMxvpRrHTuwwSzsb6Vzotx41qFun84K3eJJCGn0lV
   x3s6waOZLZIJSZ/NVrXNR+zuFzc1iY0HMO2YzwKfhVhXTfi09Xcc6YAl3
   Q==;
X-CSE-ConnectionGUID: 5SAlcr+ARQiE3faqBIv+1g==
X-CSE-MsgGUID: 2aviwsKQSR6HRTnBWySd+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="13436049"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="13436049"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:13:22 -0700
X-CSE-ConnectionGUID: 510FffOISEayvvtFIG3GJw==
X-CSE-MsgGUID: ANyXW6DPTgChDNgWqmL+Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="71156822"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO localhost) ([10.245.245.60])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:13:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Sep 2024 11:13:13 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] selftests/resctrl: Do not compare performance counters
 and resctrl at low bandwidth
In-Reply-To: <a2c7baf1-1c69-45a5-8755-38d152d33fae@intel.com>
Message-ID: <ded15734-f112-e03c-a26a-6ba3a41ca905@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <9bbefa3b9a62319698907d10e8b78f1b999c311b.1724970211.git.reinette.chatre@intel.com> <5d063290-9da4-c9ca-e5c5-cb0083d7483f@linux.intel.com> <87e4788c-6407-41a8-b201-e3f05064e5a6@intel.com>
 <238af9fe-0d7b-9bc1-9923-35ef74aad360@linux.intel.com> <9b2da518-89ce-4f9b-92f2-d317ed892886@intel.com> <1903ac13-5c9c-ef8d-78e0-417ac34a971b@linux.intel.com> <43b71606-be6a-495f-bec7-279bb812d4c8@intel.com> <c3aa4289-40aa-c158-8fde-8a35a6002783@linux.intel.com>
 <a2c7baf1-1c69-45a5-8755-38d152d33fae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1741678480-1725869593=:1029"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1741678480-1725869593=:1029
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 6 Sep 2024, Reinette Chatre wrote:
> On 9/6/24 1:44 AM, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 5 Sep 2024, Reinette Chatre wrote:
> > > On 9/5/24 4:45 AM, Ilpo J=C3=A4rvinen wrote:
> > > > On Wed, 4 Sep 2024, Reinette Chatre wrote:
> > > > > On 9/4/24 4:43 AM, Ilpo J=C3=A4rvinen wrote:
> > > > > > On Fri, 30 Aug 2024, Reinette Chatre wrote:
> > > > > > > On 8/30/24 4:42 AM, Ilpo J=C3=A4rvinen wrote:
> > > > > > > > On Thu, 29 Aug 2024, Reinette Chatre wrote:
> > > > > > > >=20
> > > > > > > > > The MBA test incrementally throttles memory bandwidth, ea=
ch
> > > > > > > > > time
> > > > > > > > > followed by a comparison between the memory bandwidth obs=
erved
> > > > > > > > > by the performance counters and resctrl respectively.
> > > > > > > > >=20
> > > > > > > > > While a comparison between performance counters and resct=
rl is
> > > > > > > > > generally appropriate, they do not have an identical view=
 of
> > > > > > > > > memory bandwidth. For example RAS features or memory
> > > > > > > > > performance
> > > > > > > > > features that generate memory traffic may drive accesses =
that
> > > > > > > > > are
> > > > > > > > > counted differently by performance counters and MBM
> > > > > > > > > respectively,
> > > > > > > > > for instance generating "overhead" traffic which is not
> > > > > > > > > counted
> > > > > > > > > against any specific RMID. As a ratio, this different vie=
w of
> > > > > > > > > memory
> > > > > > > > > bandwidth becomes more apparent at low memory bandwidths.
> > > > > > > >=20
> > > > > > > > Interesting.
> > > > > > > >=20
> > > > > > > > I did some time back prototype with a change to MBM test su=
ch
> > > > > > > > that
> > > > > > > > instead
> > > > > > > > of using once=3Dfalse I changed fill_buf to be able to run =
N
> > > > > > > > passes
> > > > > > > > through
> > > > > > > > the buffer which allowed me to know how many reads were
> > > > > > > > performed by
> > > > > > > > the
> > > > > > > > benchmark. This yielded numerical difference between all th=
ose 3
> > > > > > > > values
> > > > > > > > (# of reads, MBM, perf) which also varied from arch to anot=
her
> > > > > > > > so it
> > > > > > > > didn't end up making an usable test.
> > > > > > > >=20
> > > > > > > > I guess I now have an explanation for at least a part of th=
e
> > > > > > > > differences.
> > > > > > > >=20
> > > > > > > > > It is not practical to enable/disable the various feature=
s
> > > > > > > > > that
> > > > > > > > > may generate memory bandwidth to give performance counter=
s and
> > > > > > > > > resctrl an identical view. Instead, do not compare perfor=
mance
> > > > > > > > > counters and resctrl view of memory bandwidth when the me=
mory
> > > > > > > > > bandwidth is low.
> > > > > > > > >=20
> > > > > > > > > Bandwidth throttling behaves differently across platforms
> > > > > > > > > so it is not appropriate to drop measurement data simply =
based
> > > > > > > > > on the throttling level. Instead, use a threshold of 750M=
iB
> > > > > > > > > that has been observed to support adequate comparison bet=
ween
> > > > > > > > > performance counters and resctrl.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com=
>
> > > > > > > > > ---
> > > > > > > > >      tools/testing/selftests/resctrl/mba_test.c | 7 +++++=
++
> > > > > > > > >      tools/testing/selftests/resctrl/resctrl.h  | 6 +++++=
+
> > > > > > > > >      2 files changed, 13 insertions(+)
> > > > > > > > >=20
> > > > > > > > > diff --git a/tools/testing/selftests/resctrl/mba_test.c
> > > > > > > > > b/tools/testing/selftests/resctrl/mba_test.c
> > > > > > > > > index cad473b81a64..204b9ac4b108 100644
> > > > > > > > > --- a/tools/testing/selftests/resctrl/mba_test.c
> > > > > > > > > +++ b/tools/testing/selftests/resctrl/mba_test.c
> > > > > > > > > @@ -96,6 +96,13 @@ static bool show_mba_info(unsigned lon=
g
> > > > > > > > > *bw_imc,
> > > > > > > > > unsigned long *bw_resc)
> > > > > > > > >        =09=09avg_bw_imc =3D sum_bw_imc / (NUM_OF_RUNS - 1=
);
> > > > > > > > >      =09=09avg_bw_resc =3D sum_bw_resc / (NUM_OF_RUNS - 1=
);
> > > > > > > > > +=09=09if (avg_bw_imc < THROTTLE_THRESHOLD ||
> > > > > > > > > avg_bw_resc <
> > > > > > > > > THROTTLE_THRESHOLD) {
> > > > > > > > > +=09=09=09ksft_print_msg("Bandwidth below
> > > > > > > > > threshold (%d
> > > > > > > > > MiB).
> > > > > > > > > Dropping results from MBA schemata %u.\n",
> > > > > > > > > +=09=09=09=09=09THROTTLE_THRESHOLD,
> > > > > > > > > +=09=09=09=09=09ALLOCATION_MAX -
> > > > > > > > > ALLOCATION_STEP *
> > > > > > > > > allocation);
> > > > > > > >=20
> > > > > > > > The second one too should be %d.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > hmmm ... I intended to have it be consistent with the
> > > > > > > ksft_print_msg()
> > > > > > > that
> > > > > > > follows. Perhaps allocation can be made unsigned instead?
> > > > > >=20
> > > > > > If you go that way, then it would be good to make the related
> > > > > > defines
> > > > > > and
> > > > > > allocation in mba_setup() unsigned too, although the latter is =
a bit
> > > > > > scary
> > > > >=20
> > > > > Sure, will look into that.
> > > > >=20
> > > > > > because it does allocation -=3D ALLOCATION_STEP which could und=
erflow
> > > > > > if
> > > > > > the
> > > > > > defines are ever changed.
> > > > > >=20
> > > > >=20
> > > > > Is this not already covered in the following check:
> > > > > =09if (allocation < ALLOCATION_MIN || allocation >
> > > > > ALLOCATION_MAX)
> > > > > =09=09return END_OF_TESTS;
> > > > >=20
> > > > > We are talking about hardcoded constants though.
> > > >=20
> > > > Borderline yes. It is "covered" by the allocation > ALLOCATION_MAX =
but
> > > > it's also very non-intuitive to let the value underflow and then ch=
eck
> > > > for
> > > > that with the > operator.
> > >=20
> > > My understanding is that this is the traditional way of checking over=
flow
> > > (or more accurately wraparound). There are several examples of this
> > > pattern
> > > in the kernel and it is also the pattern that I understand Linus refe=
rred
> > > to as "traditional" in [1]. Even the compiler's intrinsic overflow
> > > checkers
> > > do checking in this way (perform the subtraction and then check if it
> > > overflowed) [2].
> >=20
> > Fair enough. I've never come across that kind of claim before.
> >=20
> > > > You're correct that they're constants so one would need to tweak th=
e
> > > > source to end up into this condition in the first place.
> > > >=20
> > > > Perhaps I'm being overly pendantic here but I in general don't like
> > > > leaving trappy and non-obvious logic like that lying around because=
 one
> > > > day one of such will come back biting.
> > >=20
> > > It is not clear to me what is "trappy" about this. The current checks=
 will
> > > catch the wraparound if somebody changes ALLOCATION_STEP in your scen=
ario,
> > > no?
> > >=20
> > > > So, if a variable is unsigned and we ever do subtraction (or adding
> > > > negative numbers to it), I'd prefer additional check to prevent eve=
r
> > > > underflowing it unexpectedly. Or leave them signed.
> > >=20
> > > To support checking at the time of subtraction we either need to chan=
ge
> > > the
> > > flow of that function since it cannot exit with failure if that
> > > subtraction
> > > fails because of overflow/wraparound, or we need to introduce more st=
ate
> > > that
> > > will be an additional check that the existing
> > > "if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)"
> > > would have caught anyway.
> > >=20
> > > In either case, to do this checking at the time of subtraction the id=
eal
> > > way
> > > would be to use check_sub_overflow() ... but it again does exactly wh=
at
> > > you find to be non-intuitive since the implementation in
> > > tools/include/linux/overflow.h uses the gcc intrinsics that does
> > > subtraction
> > > first and then checks if overflow occurred.
> >=20
> > It's trappy because by glance, that check looks unnecessary since
> > allocation starts from max and goes downwards. Also worth to note,
> > the check is not immediately after the decrement but done on the next
> > iteration.
>=20
> Right. This is probably what causes most confusion.
>=20
> Considering that, what do you think of below that avoids wraparound entir=
ely:
>=20
> ---8<---
> From: Reinette Chatre <reinette.chatre@intel.com>
> Subject: [PATCH] selftests/resctrl: Make wraparound handling obvious
>=20
> Within mba_setup() the programmed bandwidth delay value starts
> at the maximum (100, or rather ALLOCATION_MAX) and progresses
> towards ALLOCATION_MIN by decrementing with ALLOCATION_STEP.
>=20
> The programmed bandwidth delay should never be negative, so
> representing it with an unsigned int is most appropriate. This
> may introduce confusion because of the "allocation > ALLOCATION_MAX"
> check used to check wraparound of the subtraction.
>=20
> Modify the mba_setup() flow to start at the minimum, ALLOCATION_MIN,
> and incrementally, with ALLOCATION_STEP steps, adjust the
> bandwidth delay value. This avoids wraparound while making the purpose
> of "allocation > ALLOCATION_MAX" clear and eliminates the
> need for the "allocation < ALLOCATION_MIN" check.
>=20
> Reported-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - New patch
> ---
>  tools/testing/selftests/resctrl/mba_test.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/mba_test.c
> b/tools/testing/selftests/resctrl/mba_test.c
> index ab8496a4925b..947d5699f0c8 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -39,7 +39,8 @@ static int mba_setup(const struct resctrl_test *test,
>  =09=09     const struct user_params *uparams,
>  =09=09     struct resctrl_val_param *p)
>  {
> -=09static int runs_per_allocation, allocation =3D 100;
> +=09static unsigned int allocation =3D ALLOCATION_MIN;
> +=09static int runs_per_allocation =3D 0;
>  =09char allocation_str[64];
>  =09int ret;
>  @@ -50,7 +51,7 @@ static int mba_setup(const struct resctrl_test *test,
>  =09if (runs_per_allocation++ !=3D 0)
>  =09=09return 0;
>  -=09if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
> +=09if (allocation > ALLOCATION_MAX)
>  =09=09return END_OF_TESTS;
>   =09sprintf(allocation_str, "%d", allocation);
> @@ -59,7 +60,7 @@ static int mba_setup(const struct resctrl_test *test,
>  =09if (ret < 0)
>  =09=09return ret;
>  -=09allocation -=3D ALLOCATION_STEP;
> +=09allocation +=3D ALLOCATION_STEP;
>   =09return 0;
>  }
> @@ -72,8 +73,9 @@ static int mba_measure(const struct user_params *uparam=
s,
>   static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc=
)
>  {
> -=09int allocation, runs;
> +=09unsigned int allocation;
>  =09bool ret =3D false;
> +=09int runs;
>   =09ksft_print_msg("Results are displayed in (MB)\n");
>  =09/* Memory bandwidth from 100% down to 10% */
> @@ -103,7 +105,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsi=
gned
> long *bw_resc)
>  =09=09=09       avg_diff_per > MAX_DIFF_PERCENT ?
>  =09=09=09       "Fail:" : "Pass:",
>  =09=09=09       MAX_DIFF_PERCENT,
> -=09=09=09       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
> +=09=09=09       ALLOCATION_MIN + ALLOCATION_STEP * allocation);
>   =09=09ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
>  =09=09ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);

Looks fine.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

>=20
>=20
> >=20
> > The risk here is that somebody removes allocation > ALLOCATION_MAX chec=
k.
> >=20
> > Something called check_sub_overflow() is not subject to a similar risk
> > regardless of what operations occur inside it.
>=20
> Reinette
>=20

--8323328-1741678480-1725869593=:1029--

