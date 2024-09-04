Return-Path: <linux-kselftest+bounces-17117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C985A96BB53
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 13:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6F1B20F5F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED57E1CF28F;
	Wed,  4 Sep 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nn/CohUF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F4188590;
	Wed,  4 Sep 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451044; cv=none; b=rZmwgCMpDYotqnEMGkoAn2NrsoMQJAYHjtmuILUdnADZoPm7nyvzTWvzBv5UW7QeAf+YR9XYrtKEZhLKgtAY0MLHMJUW2IpcjiUjYX1x+LjLN3ecfwLh0BskytOUa4gzu9BNsWG/OOjrvQncXIuJllWotkgwxgplPduP7N/6SHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451044; c=relaxed/simple;
	bh=lNt5gOwS/0xQEALus/kYCZWiZkV73AMpxY2dBb/jQZI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HpvnNcG+mtehh65cu4B+W/NFUJ/gJWoeSDcyKTrktnXVLWyYlRIyTGUHTrq5yYBsDQ65lCrcU6LKDhEK5JmMDZfzfFs5EV0Vp+qVlEraefHxc6K6M/RHEelC8HDOuwbrnrmPzxsfAmGSQCrNTokBQC/8M9PVDyTVnJ87fSexK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nn/CohUF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725451043; x=1756987043;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=lNt5gOwS/0xQEALus/kYCZWiZkV73AMpxY2dBb/jQZI=;
  b=Nn/CohUF1yiafHcpYPVq89MatCkn/LWP1W7iG6LEc+JU7XXviYpZEWm8
   pQLRiTDi6/fL00Fo7hYprAd040Z3QYVluHjnKF+F5Ix8vUn5nwdfVpq/y
   IwhF+SOeSXlO5ANLdl5S6LDKAB1AbloxpBhnoA4GF9izWfKMHDpa4sFPa
   o0SoMZPqZMlihQaIye/kBO9JaHDrV+lxICP5zR8OMJL48bV+B67rbntKv
   YRhR8WHIn5UudUMT3iByNCSe9pM/wJfrc/1WrWHm+FzYJm8nWXxgNv8HP
   PqbmV6347y4LLw2tE0qf4UfvNfV0+wqAc0BUELeQPHntPxiAxZyOsp115
   A==;
X-CSE-ConnectionGUID: pZHuf24MSvmbFJsut0Y3Pw==
X-CSE-MsgGUID: XjsrvHmxRi6Qpe4iCx4CMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35466861"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="35466861"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:57:21 -0700
X-CSE-ConnectionGUID: KPMHL4eNReKpntN8gZoV1g==
X-CSE-MsgGUID: HU3oowf5TH+Hwh0AAzYypA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="95977133"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.156])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:57:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 4 Sep 2024 14:57:14 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] selftests/resctrl: Ensure measurements skip
 initialization of default benchmark
In-Reply-To: <0ae6d28f-0646-48b2-a4e7-17e2d14f6dd5@intel.com>
Message-ID: <85a11091-3c61-2d8b-28d4-2a251f3b8ffe@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <a0fe2be86f3e868a5f908ac4f2c76e71b4d08d4f.1724970211.git.reinette.chatre@intel.com> <3add783b-74cf-23c0-a301-aa203efdd0f6@linux.intel.com> <0ae6d28f-0646-48b2-a4e7-17e2d14f6dd5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-81240387-1725450426=:1078"
Content-ID: <6d68d189-778d-b1fc-2ec1-8e6b23bbf64b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-81240387-1725450426=:1078
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <902070af-5bff-ad8e-0ef1-00b542291daf@linux.intel.com>

On Fri, 30 Aug 2024, Reinette Chatre wrote:
>=20
> Thank you for taking a look.
>=20
> On 8/30/24 3:56 AM, Ilpo J=E4rvinen wrote:
> > On Thu, 29 Aug 2024, Reinette Chatre wrote:
> >=20
>=20
> ...
>=20
> > > @@ -684,11 +622,13 @@ int resctrl_val(const struct resctrl_test *test=
,
> > >   =09=09const char * const *benchmark_cmd,
> > >   =09=09struct resctrl_val_param *param)
> > >   {
> > > -=09struct sigaction sigact;
> > > -=09int ret =3D 0, pipefd[2];
> > > -=09char pipe_message =3D 0;
> > > -=09union sigval value;
> > > -=09int domain_id;
> > > +=09int domain_id, operation =3D 0, memflush =3D 1;
> > > +=09size_t span =3D DEFAULT_SPAN;
> > > +=09unsigned char *buf =3D NULL;
> > > +=09cpu_set_t old_affinity;
> > > +=09bool once =3D false;
> > > +=09int ret =3D 0;
> > > +=09pid_t ppid;
> > >     =09if (strcmp(param->filename, "") =3D=3D 0)
> > >   =09=09sprintf(param->filename, "stdio");
> > > @@ -699,111 +639,80 @@ int resctrl_val(const struct resctrl_test *tes=
t,
> > >   =09=09return ret;
> > >   =09}
> > >   -=09/*
> > > -=09 * If benchmark wasn't successfully started by child, then child
> > > should
> > > -=09 * kill parent, so save parent's pid
> > > -=09 */
> > >   =09ppid =3D getpid();
> > >   -=09if (pipe(pipefd)) {
> > > -=09=09ksft_perror("Unable to create pipe");
> > > +=09/* Taskset test to specified CPU. */
> > > +=09ret =3D taskset_benchmark(ppid, uparams->cpu, &old_affinity);
> >=20
> > Previously only CPU affinity for bm_pid was set but now it's set before
> > fork(). Quickly checking the Internet, it seems that CPU affinity gets
> > inherited on fork() so now both processes will have the same affinity
> > which might make the other process to interfere with the measurement.
>=20
> Setting the affinity is intended to ensure that the buffer preparation
> occurs in the same topology as where the runtime portion will run.
> This preparation is done before the work to be measured starts.
>=20
> This does tie in with the association with the resctrl group and I
> will elaborate more below ...

Okay, that's useful to retain but thinking this further, now we're also=20
going do non-trivial amount of work in between the setup and the test by=20
forking. I guess that doesn't matter for memflush =3D true case but might b=
e=20
meaningful for the memflush =3D false case that seems to be there to allow=
=20
keeping caches hot (I personally haven't thought how to use "caches hot"=20
test but we do have that capability by the fact that memflush paremeter=20
exists).=20

> > > +=09if (ret)
> > > +=09=09return ret;
> > >   -=09=09return -1;
> > > +=09/* Write test to specified control & monitoring group in resctrl =
FS.
> > > */
> > > +=09ret =3D write_bm_pid_to_resctrl(ppid, param->ctrlgrp, param->mong=
rp);
> >=20
> > Previously, this was done for bm_pid but now it's done for the parent. =
I'm
> > not sure how inheritance goes with resctrl on fork(), will the forked P=
ID
> > get added to the list of PIDs or not? You probably know the answer :-).
>=20
> Yes. A process fork()ed will land in the same resctrl group as its parent=
=2E
>=20
> > Neither behavior, however, seems to result in the intended behavior as =
we
> > either get interfering processes (if inherited) or no desired resctrl
> > setup for the benchmark process.
>=20
> There are two processes to consider in the resource group, the parent (th=
at
> sets up the buffer and does the measurements) and the child (that runs th=
e
> workload to be measured). Thanks to your commit da50de0a92f3
> ("selftests/resctrl:
> Calculate resctrl FS derived mem bw over sleep(1) only") the parent
> will be sleeping while the child runs its workload and there is no
> other interference I am aware of. The only additional measurements
> that I can see would be the work needed to actually start and stop the
> measurements and from what I can tell this falls into the noise.
>=20
> Please do keep in mind that the performance counters used, iMC, cannot
> actually
> be bound to a single CPU since it is a per-socket PMU. The measurements h=
ave
> thus never been as fine grained as the code pretends it to be.

I was thinking if I should note the amount of work is small. Maybe it's=20
fine to leave that noise there and I'm just overly cautious :-), when I=20
used to do networking research in the past life, I wanted to eliminate as
much noise sources so I guess it comes from that background.

--=20
 i.
--8323328-81240387-1725450426=:1078--

