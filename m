Return-Path: <linux-kselftest+bounces-17386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B156E96F0BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 12:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDBC1F213C9
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98B17ADEE;
	Fri,  6 Sep 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YetnY13a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5217BBE;
	Fri,  6 Sep 2024 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616866; cv=none; b=d1mT3A426UoetvtYvfpZKc+nx3Z9xiujDpPs1aJl0tYbQb+YIDvsot/lvbfSeB1Ll50YWh8WFB6n4FoC45edH6yCfSzMyJt3Mcj9zPU4iMOrpOmTNOsfFLKpMSAZ8g3U1fnEDAth/WppiBCM+ykysRl00oxhoomLK38bISjdFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616866; c=relaxed/simple;
	bh=y5FN4ge44j0gv9OBIR5T6s08Rk+7t/u0NzS8UB2UeOE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fw8Lfvt3VtLFR/Bz3T/NbceCUjls9e73YRRo+Pi0T7YgDmJ6LX7Jbf/HpVPaO3zsqELImtzMRQ1AmtROuDO2D7B8PBHiryYFOnnrqGDUgHXt38xMEHZQJcqSgqPLphcFO4irjXm/Phi4Vm5jciE0af71GaNO+WGAINAeUzziFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YetnY13a; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725616864; x=1757152864;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=y5FN4ge44j0gv9OBIR5T6s08Rk+7t/u0NzS8UB2UeOE=;
  b=YetnY13aTaaQLR9psjWdEYJY6kLmxovIti02PPTTM6qH4t+yJTh4ZK9A
   qHsBYbI0XBEzSdGG3ZeP+E7oPgk4mxF60g/gmYl1PR7ka1kaoVoH16G1g
   EcJFBwj1RyIPPx11aAoF282b80mKDcVIkro2Dlm2t24zSp2R8G0TRb0Sc
   QqY6NErlqCb9zvrLi4vIfqUXKSU659T830NENGeixpEo8qUUFhpuBq+6s
   tNBhH37oukexkJk1UMMoGES4JN2YYWdnMiQdYGdE8rQgMKgW73cL6BQAe
   jtA//Do5bmXtFNhP9xjigacWx5n5rXNOANfCZDvWlp4D63mrT019q8UgC
   Q==;
X-CSE-ConnectionGUID: D1qZjZF0QkOJnc0YeVkZ0g==
X-CSE-MsgGUID: tbBkXngmTpWs0OAZ1TsaDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="23928060"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="23928060"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 03:01:03 -0700
X-CSE-ConnectionGUID: fxy1c9oTT1igr0Cm4xxQ6g==
X-CSE-MsgGUID: qsOysuyATLm2O0WayY1/3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="65560454"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 03:00:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Sep 2024 13:00:56 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] selftests/resctrl: Ensure measurements skip
 initialization of default benchmark
In-Reply-To: <86ca3bcd-de60-4784-8a32-8df360a4ceda@intel.com>
Message-ID: <0e5078b5-509f-38ef-fa71-821c5f7b5944@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <a0fe2be86f3e868a5f908ac4f2c76e71b4d08d4f.1724970211.git.reinette.chatre@intel.com> <3add783b-74cf-23c0-a301-aa203efdd0f6@linux.intel.com> <0ae6d28f-0646-48b2-a4e7-17e2d14f6dd5@intel.com>
 <85a11091-3c61-2d8b-28d4-2a251f3b8ffe@linux.intel.com> <156ad739-3f80-456f-92df-74da9266dca0@intel.com> <da06ea9d-5081-b81f-5d2b-28200527f419@linux.intel.com> <86ca3bcd-de60-4784-8a32-8df360a4ceda@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-714735873-1725612378=:1053"
Content-ID: <57118787-d7ca-9627-424b-77e28366dcf4@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-714735873-1725612378=:1053
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e9f85364-5298-4346-9944-be622c623583@linux.intel.com>

On Thu, 5 Sep 2024, Reinette Chatre wrote:
> On 9/5/24 5:10 AM, Ilpo J=E4rvinen wrote:
> > On Wed, 4 Sep 2024, Reinette Chatre wrote:
> > > On 9/4/24 4:57 AM, Ilpo J=E4rvinen wrote:
> > > > On Fri, 30 Aug 2024, Reinette Chatre wrote:
> > > > > On 8/30/24 3:56 AM, Ilpo J=E4rvinen wrote:
> > > > > > On Thu, 29 Aug 2024, Reinette Chatre wrote:
> >=20
> > > > > > > @@ -699,111 +639,80 @@ int resctrl_val(const struct resctrl_t=
est
> > > > > > > *test,
> > > > > > >     =09=09return ret;
> > > > > > >     =09}
> > > > > > >     -=09/*
> > > > > > > -=09 * If benchmark wasn't successfully started by child, the=
n
> > > > > > > child
> > > > > > > should
> > > > > > > -=09 * kill parent, so save parent's pid
> > > > > > > -=09 */
> > > > > > >     =09ppid =3D getpid();
> > > > > > >     -=09if (pipe(pipefd)) {
> > > > > > > -=09=09ksft_perror("Unable to create pipe");
> > > > > > > +=09/* Taskset test to specified CPU. */
> > > > > > > +=09ret =3D taskset_benchmark(ppid, uparams->cpu, &old_affini=
ty);
> > > > > >=20
> > > > > > Previously only CPU affinity for bm_pid was set but now it's se=
t
> > > > > > before
> > > > > > fork(). Quickly checking the Internet, it seems that CPU affini=
ty
> > > > > > gets
> > > > > > inherited on fork() so now both processes will have the same
> > > > > > affinity
> > > > > > which might make the other process to interfere with the
> > > > > > measurement.
> > > > >=20
> > > > > Setting the affinity is intended to ensure that the buffer prepar=
ation
> > > > > occurs in the same topology as where the runtime portion will run=
=2E
> > > > > This preparation is done before the work to be measured starts.
> > > > >=20
> > > > > This does tie in with the association with the resctrl group and =
I
> > > > > will elaborate more below ...
> > > >=20
> > > > Okay, that's useful to retain but thinking this further, now we're =
also
> > > > going do non-trivial amount of work in between the setup and the te=
st by
> > >=20
> > > Could you please elaborate how the amount of work during setup can be=
 an
> > > issue? I have been focused on the measurements that are done afterwar=
ds
> > > that do have clear boundaries from what I can tell.
> >=20
> > Well, you used it as a justification: "Setting the affinity is intended
> > to ensure that the buffer preparation occurs in the same topology as wh=
ere
> > the runtime portion will run." So I assumed you had some expectations a=
bout
> > "preparations" done outside of those "clear boundaries" but now you see=
m
> > to take entirely opposite stance?
>=20
> I do not follow you here. With the "clear boundaries" I meant the
> measurements and associated variables that have  a clear start/init and
> stop/read while the other task sleeps. Yes, preparations are done outside
> of this since that should not be measured.

Of course the preparations are not measured (at least not after this
patch :-)).

But that's not what I meant. You said the preparations are to be done=20
using the same topology as the test but if it's outside of the measurement=
=20
period, the topology during preparations only matters if you make some
hidden assumption that some state carries from preparations to the actual=
=20
test. If no state carry-over is assumed, the topology during preparations
is not important. So which way it is? Is the topology during preparations=
=20
important or not?

You used the topology argument to justify why both parent and child are=20
now in the same resctrl group unlike before when only the actual test was.

> You stated "now we're also going
> do non-trivial amount of work in between the setup and the test" ...
> could you clarify what the problem is with this? Before this work
> the "non-trivial amount of work" (for "fill_buf") was done as part of the
> test with (wrong) guesses about how long it takes. This work aims to impr=
ove
> this.

I understand why you're trying to do with this change.

However, I was trying to say that before preparations occurred right=20
before the test which is no longer the case because there's fork() in=20
between.

Does that extra work impact the state carry-over from preparations to the=
=20
test?

> > fork() quite heavy operation as it has to copy various things including
> > the address space which you just made to contain a huge mem blob. :-)
>=20
> As highlighted in a comment found in the patch, the kernel uses copy-on-w=
rite
> and all tests only read from the buffer after fork().

Write test is possible using -b fill_buf ... as mentioned in comments to=20
the other patch.

> > BTW, perhaps we could use some lighter weighted fork variant in the
> > resctrl selftests, the processes don't really need to be that separated
> > to justify using full fork() (and custom benchmarks will do execvp()).
>=20
> Are you thinking about pthreads? It is not clear to me that this is
> necessary. It is also not clear to me what problem you are describing tha=
t
> needs this solution. When I understand that better it will be easier to
> discuss solutions.

I was trying to say I see advantage of retaining the address space which
is not possible with fork(), so perhaps using clone() with CLONE_VM would=
=20
be useful and maybe some other flags too. I think this would solve the=20
write test case.

> > > > I was thinking if I should note the amount of work is small. Maybe =
it's
> > > > fine to leave that noise there and I'm just overly cautious :-), wh=
en I
> > > > used to do networking research in the past life, I wanted to elimin=
ate
> > > > as
> > > > much noise sources so I guess it comes from that background.
> > >=20
> > > The goal of these tests are to verify *resctrl*, these are not intend=
ed to
> > > be
> > > hardware validation tests. I think it would be better for resctrl if =
more
> > > time
> > > is spent on functional tests of resctrl than these performance tests.
> >=20
> > This sounds so easy... (no offence) :-) If only there wouldn't be the
> > black boxes and we'd have good and fine-grained ways to instrument it,
> > it would be so much easier to realize non-statistical means to do
> > functional tests.
> >=20
>=20
> To me functional tests of resctrl indeed sounds easier. Tests can interac=
t
> with the
> resctrl interface to ensure it works as expected ... test the boundaries
> of user input to the various files, test task movement between groups, te=
st
> moving of
> monitor groups, test assigning CPUs to resource groups, ensure the "mode"=
 of a
> resource group can be changed and behaves as expected (for example, share=
d vs
> exclusive),
> ensure changes to one file are reflected in others, like changing schemat=
a is
> reflected
> in "size" and "bit_usage", etc. etc. These are all tests of *resctrl* tha=
t
> supports
> development and can be used to verify all is well as major changes (that =
we
> are seeing
> more and more of) are made to the kernel subsystem. None of this is "blac=
k
> box" and
> is all deterministic with obvious pass/fail. This can be made even more
> reliable with
> not just checking of resctrl files but see if changes via resctrl is refl=
ected
> in MSRs
> as expected.

Okay, I get it now, you meant testing the kernel-userspace interfaces=20
and with using MSRs as a further validation step to test kernel-HW=20
interface too.

I'll probably take a look at this when I've some spare time what I can=20
come up with.

--=20
 i.
--8323328-714735873-1725612378=:1053--

