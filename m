Return-Path: <linux-kselftest+bounces-17219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C171096D7FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 14:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A1C1F2467F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962D619D06B;
	Thu,  5 Sep 2024 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZg8amQC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C919ADBB;
	Thu,  5 Sep 2024 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538241; cv=none; b=csLEtWTEyK9MdmzpbymNgEOcSazssfjr488S+Gx1xlMBXHcViwM23p0+QY19/2m6nt4sRIH9KW6rZYUbjXQVj/XWufzbOfJ9pHDuiW9HH/wcGYOrdwL4Lyc1BmxrhVBcsqLg1bwGieaqtQ01sfEd3K8LMSKlBOyUUKgLWeevf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538241; c=relaxed/simple;
	bh=Y5YauDm1aJKiushd8sUfegx+qyj0cP2ABdG0ky7tors=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EHgMspChJFemPvPC5Vlt5+swBHr5YMvkBp+nrNdlwK3ARM0EtJQ3lDcJVuCCP+tZREWBecKchYbqn3ScKvgB6otowphDwF6U65SBUSeC6iFj5TRV43yaNA/Dwf4EZj+jqfWroQxHS6fa+7LJIQ7eq01YGvFkD8K309xzDzQT+Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZg8amQC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725538240; x=1757074240;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y5YauDm1aJKiushd8sUfegx+qyj0cP2ABdG0ky7tors=;
  b=nZg8amQCZKY8dIwK3Io2jp0e27MGeyGtx6dHU4Uf+o2v8c5uOFmcQuTi
   RAowd4/NdSFj6szgqCwItrixXXo6QA7YcINP3kPzLxQiewc/5oH7Wqqrk
   4TmynOaKYT79A0BXXTgj69yWSQDm1KguoBpmHJ6o63C/GOHAx/AJrDmjm
   VatzZ3c9cXw3s74c7u5pdWjv9lFuOwF7evly6GJDTHFyxuhnlSBXrNdKq
   FstNcN5xXFc0Z3Z8v7WM0dDu6y2DyPh6cEIdD4gcIY9hmSrb7d9CJu/9d
   gdWhattYyRg5TgtyukB32bmcDlkbzaMCWKghZ6NC+SSwD3lwelbGyF4oV
   g==;
X-CSE-ConnectionGUID: 0i7Fjds0Rf2TQBAQ/WexAg==
X-CSE-MsgGUID: kkSgs8h0Q52Tysye46lkQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27170856"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="27170856"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:10:37 -0700
X-CSE-ConnectionGUID: vazeR913SECH+bFbC/1U6g==
X-CSE-MsgGUID: w5lOfYErRCmRZgi+WkKp1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70198858"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.31])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:10:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Sep 2024 15:10:29 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] selftests/resctrl: Ensure measurements skip
 initialization of default benchmark
In-Reply-To: <156ad739-3f80-456f-92df-74da9266dca0@intel.com>
Message-ID: <da06ea9d-5081-b81f-5d2b-28200527f419@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <a0fe2be86f3e868a5f908ac4f2c76e71b4d08d4f.1724970211.git.reinette.chatre@intel.com> <3add783b-74cf-23c0-a301-aa203efdd0f6@linux.intel.com> <0ae6d28f-0646-48b2-a4e7-17e2d14f6dd5@intel.com>
 <85a11091-3c61-2d8b-28d4-2a251f3b8ffe@linux.intel.com> <156ad739-3f80-456f-92df-74da9266dca0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1758549309-1725538229=:1411"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1758549309-1725538229=:1411
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 4 Sep 2024, Reinette Chatre wrote:
> On 9/4/24 4:57 AM, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 30 Aug 2024, Reinette Chatre wrote:
> > > On 8/30/24 3:56 AM, Ilpo J=C3=A4rvinen wrote:
> > > > On Thu, 29 Aug 2024, Reinette Chatre wrote:

> > > > > @@ -699,111 +639,80 @@ int resctrl_val(const struct resctrl_test
> > > > > *test,
> > > > >    =09=09return ret;
> > > > >    =09}
> > > > >    -=09/*
> > > > > -=09 * If benchmark wasn't successfully started by child, then
> > > > > child
> > > > > should
> > > > > -=09 * kill parent, so save parent's pid
> > > > > -=09 */
> > > > >    =09ppid =3D getpid();
> > > > >    -=09if (pipe(pipefd)) {
> > > > > -=09=09ksft_perror("Unable to create pipe");
> > > > > +=09/* Taskset test to specified CPU. */
> > > > > +=09ret =3D taskset_benchmark(ppid, uparams->cpu, &old_affinity);
> > > >=20
> > > > Previously only CPU affinity for bm_pid was set but now it's set be=
fore
> > > > fork(). Quickly checking the Internet, it seems that CPU affinity g=
ets
> > > > inherited on fork() so now both processes will have the same affini=
ty
> > > > which might make the other process to interfere with the measuremen=
t.
> > >=20
> > > Setting the affinity is intended to ensure that the buffer preparatio=
n
> > > occurs in the same topology as where the runtime portion will run.
> > > This preparation is done before the work to be measured starts.
> > >=20
> > > This does tie in with the association with the resctrl group and I
> > > will elaborate more below ...
> >=20
> > Okay, that's useful to retain but thinking this further, now we're also
> > going do non-trivial amount of work in between the setup and the test b=
y
>=20
> Could you please elaborate how the amount of work during setup can be an
> issue? I have been focused on the measurements that are done afterwards
> that do have clear boundaries from what I can tell.

Well, you used it as a justification: "Setting the affinity is intended=20
to ensure that the buffer preparation occurs in the same topology as where=
=20
the runtime portion will run." So I assumed you had some expectations about=
=20
"preparations" done outside of those "clear boundaries" but now you seem
to take entirely opposite stance?

fork() quite heavy operation as it has to copy various things including=20
the address space which you just made to contain a huge mem blob. :-)

BTW, perhaps we could use some lighter weighted fork variant in the=20
resctrl selftests, the processes don't really need to be that separated=20
to justify using full fork() (and custom benchmarks will do execvp()).

> > forking. I guess that doesn't matter for memflush =3D true case but mig=
ht be
> > meaningful for the memflush =3D false case that seems to be there to al=
low
> > keeping caches hot (I personally haven't thought how to use "caches hot=
"
> > test but we do have that capability by the fact that memflush paremeter
> > exists).
>=20
> I believe that memflush =3D true will always be needed/used by the tests
> relying on memory bandwidth measurement since that reduces cache hits dur=
ing
> measurement phase and avoids the additional guessing on how long the work=
load
> should be run before reliable/consistent measurements can start.
>
> Thinking about the memflush =3D false case I now think that we should use=
 that
> for the CMT test. The buffer is allocated and initialized while the task
> is configured with appropriate allocation limits so there should not be a
> reason to flush the buffer from the cache. In fact, flushing the cache
> introduces
> the requirement to guess the workload's "settle" time (time to allocate t=
he
> buffer
> into the cache again) before its occupancy can be measured. As a quick te=
st I
> set memflush =3D false on one system and it brought down the average diff
> between
> the cache portion size and the occupancy counts. I'll try it out on a few=
 more
> systems to confirm.

Oh great!

I've not really figured out the logic used in the old CMT test because=20
there was the rewrite for it in the series I started to upstream some of=20
these improvements from. But I was unable to rebase successfully that=20
rewrite either because somebody had used a non-publically available tree=20
as a basis for it so I never did even have time to understand what even=20
the rewritten test did thanks to the very complex diff.

> > > > Neither behavior, however, seems to result in the intended behavior=
 as
> > > > we
> > > > either get interfering processes (if inherited) or no desired resct=
rl
> > > > setup for the benchmark process.
> > >=20
> > > There are two processes to consider in the resource group, the parent
> > > (that
> > > sets up the buffer and does the measurements) and the child (that run=
s the
> > > workload to be measured). Thanks to your commit da50de0a92f3
> > > ("selftests/resctrl:
> > > Calculate resctrl FS derived mem bw over sleep(1) only") the parent
> > > will be sleeping while the child runs its workload and there is no
> > > other interference I am aware of. The only additional measurements
> > > that I can see would be the work needed to actually start and stop th=
e
> > > measurements and from what I can tell this falls into the noise.
> > >=20
> > > Please do keep in mind that the performance counters used, iMC, canno=
t
> > > actually
> > > be bound to a single CPU since it is a per-socket PMU. The measuremen=
ts
> > > have
> > > thus never been as fine grained as the code pretends it to be.
> >=20
> > I was thinking if I should note the amount of work is small. Maybe it's
> > fine to leave that noise there and I'm just overly cautious :-), when I
> > used to do networking research in the past life, I wanted to eliminate =
as
> > much noise sources so I guess it comes from that background.
>=20
> The goal of these tests are to verify *resctrl*, these are not intended t=
o be
> hardware validation tests. I think it would be better for resctrl if more=
 time
> is spent on functional tests of resctrl than these performance tests.

This sounds so easy... (no offence) :-) If only there wouldn't be the=20
black boxes and we'd have good and fine-grained ways to instrument it,
it would be so much easier to realize non-statistical means to do=20
functional tests.

--=20
 i.

--8323328-1758549309-1725538229=:1411--

