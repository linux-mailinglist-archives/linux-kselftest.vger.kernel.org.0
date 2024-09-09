Return-Path: <linux-kselftest+bounces-17520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD59719FE
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 14:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6651C22D13
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F001B7904;
	Mon,  9 Sep 2024 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwMhmnhN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C341B81C7;
	Mon,  9 Sep 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886381; cv=none; b=C9vRq/c5P8z/Nu+9L3V+lAZVCT+ak/DEWSC1Jt+dT5Xqh6OxepIF9oQJ4bMRM/g8WwrbrjEoxBZHVjI7qNRh0wYslgzcpKwWX+VEuTgRe9L3u/PgBPKKOoo3LzeLS+8do5E15gi2H8hMzDpiK7DdsKVe4nhavFFnpGcgrJf2BYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886381; c=relaxed/simple;
	bh=7nv1PLXPaH11yhcv951on+oerPpfcq1MzqcNeXBAFHQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bYJjyACFa120D6JSmUURH7gDgrr8M7iXa5h2BqKx9KUAT7b1rCIfmEi8oshbXs/hMRVOqln73BvVzCOWVLOAyVbVuzyduqRgRHyeE/LsNzqAHI4PBAzWFvs7iC5Wl82TuwJ+UoTNOfbDGzEPkx0Mtt4EJgBXok9DX5lNT0MYGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwMhmnhN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725886380; x=1757422380;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7nv1PLXPaH11yhcv951on+oerPpfcq1MzqcNeXBAFHQ=;
  b=HwMhmnhNErfxSkK3g+W2qZ5CnyBZUL650nofSc0FLMLoyv6K/c64XRHl
   u5os2ULJwxS2Zamx1WY26xrlrDRQwXglR2tpcekxYJ1D3G3xDkVVjoArJ
   QPiS3FD8Z3lXAduKvUaHZvgyJXAKziUQFsHjetUYHq5vzOT4MmbRY1QN7
   chj/TE7yJL8g2Bnk9ZihFf475+7jnEOI/WvzqO6hzUrIdhEtU3YB8K9lk
   35Wq7CuASa7VfkX8xL94JXHJIjD7dDzT0Nmvln9xekVtVAdfgNvC8bRqC
   GCxxqGpUBz4kiGmvZhtGEEUMKeEXzFnBVnbEPQWgi4dsbwsB77dN1w4vP
   w==;
X-CSE-ConnectionGUID: zxycrpQlS+2WYykpGAFhJA==
X-CSE-MsgGUID: yhv4SP6HR/KjOUKYBMfJRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24773876"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24773876"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:52:58 -0700
X-CSE-ConnectionGUID: LfECcp0xRWKduoy5d4AYTw==
X-CSE-MsgGUID: 34cuTLk9TbGzBNkCVgrZeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="66445004"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.60])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 05:52:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Sep 2024 15:52:49 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] selftests/resctrl: Ensure measurements skip
 initialization of default benchmark
In-Reply-To: <3325de04-6e59-4c7a-ae44-c245c8edb93f@intel.com>
Message-ID: <ccc7579f-2633-adda-2a8e-235021c5c785@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <a0fe2be86f3e868a5f908ac4f2c76e71b4d08d4f.1724970211.git.reinette.chatre@intel.com> <3add783b-74cf-23c0-a301-aa203efdd0f6@linux.intel.com> <0ae6d28f-0646-48b2-a4e7-17e2d14f6dd5@intel.com>
 <85a11091-3c61-2d8b-28d4-2a251f3b8ffe@linux.intel.com> <156ad739-3f80-456f-92df-74da9266dca0@intel.com> <da06ea9d-5081-b81f-5d2b-28200527f419@linux.intel.com> <86ca3bcd-de60-4784-8a32-8df360a4ceda@intel.com> <0e5078b5-509f-38ef-fa71-821c5f7b5944@linux.intel.com>
 <3325de04-6e59-4c7a-ae44-c245c8edb93f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1286384385-1725886369=:1029"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1286384385-1725886369=:1029
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 6 Sep 2024, Reinette Chatre wrote:
> On 9/6/24 3:00 AM, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 5 Sep 2024, Reinette Chatre wrote:
> > > On 9/5/24 5:10 AM, Ilpo J=C3=A4rvinen wrote:
> > > > On Wed, 4 Sep 2024, Reinette Chatre wrote:
> > > > > On 9/4/24 4:57 AM, Ilpo J=C3=A4rvinen wrote:
> > > > > > On Fri, 30 Aug 2024, Reinette Chatre wrote:
> > > > > > > On 8/30/24 3:56 AM, Ilpo J=C3=A4rvinen wrote:
> > > > > > > > On Thu, 29 Aug 2024, Reinette Chatre wrote:
> > > >=20
> > > > > > > > > @@ -699,111 +639,80 @@ int resctrl_val(const struct
> > > > > > > > > resctrl_test
> > > > > > > > > *test,
> > > > > > > > >      =09=09return ret;
> > > > > > > > >      =09}
> > > > > > > > >      -=09/*
> > > > > > > > > -=09 * If benchmark wasn't successfully started by child,
> > > > > > > > > then
> > > > > > > > > child
> > > > > > > > > should
> > > > > > > > > -=09 * kill parent, so save parent's pid
> > > > > > > > > -=09 */
> > > > > > > > >      =09ppid =3D getpid();
> > > > > > > > >      -=09if (pipe(pipefd)) {
> > > > > > > > > -=09=09ksft_perror("Unable to create pipe");
> > > > > > > > > +=09/* Taskset test to specified CPU. */
> > > > > > > > > +=09ret =3D taskset_benchmark(ppid, uparams->cpu,
> > > > > > > > > &old_affinity);
> > > > > > > >=20
> > > > > > > > Previously only CPU affinity for bm_pid was set but now it'=
s set
> > > > > > > > before
> > > > > > > > fork(). Quickly checking the Internet, it seems that CPU
> > > > > > > > affinity
> > > > > > > > gets
> > > > > > > > inherited on fork() so now both processes will have the sam=
e
> > > > > > > > affinity
> > > > > > > > which might make the other process to interfere with the
> > > > > > > > measurement.
> > > > > > >=20
> > > > > > > Setting the affinity is intended to ensure that the buffer
> > > > > > > preparation
> > > > > > > occurs in the same topology as where the runtime portion will=
 run.
> > > > > > > This preparation is done before the work to be measured start=
s.
> > > > > > >=20
> > > > > > > This does tie in with the association with the resctrl group =
and I
> > > > > > > will elaborate more below ...
> > > > > >=20
> > > > > > Okay, that's useful to retain but thinking this further, now we=
're
> > > > > > also
> > > > > > going do non-trivial amount of work in between the setup and th=
e
> > > > > > test by
> > > > >=20
> > > > > Could you please elaborate how the amount of work during setup ca=
n be
> > > > > an
> > > > > issue? I have been focused on the measurements that are done
> > > > > afterwards
> > > > > that do have clear boundaries from what I can tell.
> > > >=20
> > > > Well, you used it as a justification: "Setting the affinity is inte=
nded
> > > > to ensure that the buffer preparation occurs in the same topology a=
s
> > > > where
> > > > the runtime portion will run." So I assumed you had some expectatio=
ns
> > > > about
> > > > "preparations" done outside of those "clear boundaries" but now you=
 seem
> > > > to take entirely opposite stance?
> > >=20
> > > I do not follow you here. With the "clear boundaries" I meant the
> > > measurements and associated variables that have  a clear start/init a=
nd
> > > stop/read while the other task sleeps. Yes, preparations are done out=
side
> > > of this since that should not be measured.
> >=20
> > Of course the preparations are not measured (at least not after this
> > patch :-)).
> >=20
> > But that's not what I meant. You said the preparations are to be done
> > using the same topology as the test but if it's outside of the measurem=
ent
> > period, the topology during preparations only matters if you make some
> > hidden assumption that some state carries from preparations to the actu=
al
> > test. If no state carry-over is assumed, the topology during preparatio=
ns
> > is not important. So which way it is? Is the topology during preparatio=
ns
> > important or not?
>=20
> Topology during preparations is important.
>=20
> In the CMT test this is more relevant with the transition to using
> memflush =3D false. The preparation phase and measure phase uses the same
> cache alloc configuration and just as importantly, the same monitoring
> configuration. During preparation the cache portion that will be
> used during measurement will be filled with the contents of the buffer.
> During measurement it will be the same cache portion into which any new r=
eads
> will be allocated and measured. In fact, the preparation phase will thus =
form
> part of the measurement. If preparation was done with different
> configuration, then I see a problem whether memflush =3D true as well as =
when
> memflush =3D false. In the case of memflush =3D true it will have the fam=
iliar
> issue of the test needing to "guess" the workload settle time. In the cas=
e
> of memflush =3D false the buffer will remain allocated into the cache por=
tion
> used during preparation phase, when the workload runs it will read the
> data from a cache portion that does not belong to it and since it does
> not need to allocate into its own cache portion its LLC occupancy counts =
will
> not be accurate (the LLC occupancy associated with the buffer will be
> attributed
> to prepare portion).
>=20
> I am not familiar with the details of memory allocation but as I understa=
nd
> Linux does attempt to satisfy memory requests from the node to which the
> requesting CPU is assigned. For the MBM and MBA tests I thus believe it i=
s
> important to allocate the memory from where it will be used. I have
> encountered
> systems where CPU0 and CPU1 are on different sockets and by default the
> workload
> is set to run on CPU1. If the preparation phase runs on CPU0 then it may =
be
> that memory could be allocated from a different NUMA node than where the
> workload will
> be running. By doing preparation within the same topology as what the
> workload will be running I believe that memory will be allocated appropri=
ate
> to workload and thus result in more reliable measurements.
>=20
> >=20
> > You used the topology argument to justify why both parent and child are
> > now in the same resctrl group unlike before when only the actual test w=
as.
> >=20
> > > You stated "now we're also going
> > > do non-trivial amount of work in between the setup and the test" ...
> > > could you clarify what the problem is with this? Before this work
> > > the "non-trivial amount of work" (for "fill_buf") was done as part of=
 the
> > > test with (wrong) guesses about how long it takes. This work aims to
> > > improve
> > > this.
> >=20
> > I understand why you're trying to do with this change.
> >=20
> > However, I was trying to say that before preparations occurred right
> > before the test which is no longer the case because there's fork() in
> > between.
>=20
> If by "test" you mean the measurement phase then in the case of "fill_buf=
"
> preparations only now reliably occur before the measurement. Original beh=
avior
> is maintained with user provided benchmark.
>=20
> >=20
> > Does that extra work impact the state carry-over from preparations to t=
he
> > test?
>=20
> It is not clear to me what extra work or state you are referring to.
>=20
> >=20
> > > > fork() quite heavy operation as it has to copy various things inclu=
ding
> > > > the address space which you just made to contain a huge mem blob. :=
-)
> > >=20
> > > As highlighted in a comment found in the patch, the kernel uses
> > > copy-on-write
> > > and all tests only read from the buffer after fork().
> >=20
> > Write test is possible using -b fill_buf ... as mentioned in comments t=
o
> > the other patch.
>=20
> Yes, it is theoretically possible, but looking closer it is not supported=
=2E
> Note
> how measure_mem_bw() is always called with hardcoded "reads". Reading thr=
ough
> the history of commits I do not believe modifying fill_buf parameters was
> ever intended to be a use case for the "-b" parameter. It seems intended
> to provide an alternate benchmark to fill_buf.
>=20
> I am not interested in adding support for the write test because I do not=
 see
> how it helps us to improve resctrl subsystem health. Considering that
> nobody has ever complained about the write test being broken I think all
> that dead code should just be removed instead.
>=20
> I prefer the focus be on the health of the resctrl subsystem instead of
> additional
> hardware performance testing. I do not think it is energy well spent to
> further
> tune these performance tests unless it benefits resctrl subsystem health.
> These
> performance tests are difficult to maintain and I have not yet seen how t=
hey
> benefit the resctrl subsystem.
>=20
> > > > BTW, perhaps we could use some lighter weighted fork variant in the
> > > > resctrl selftests, the processes don't really need to be that separ=
ated
> > > > to justify using full fork() (and custom benchmarks will do execvp(=
)).
> > >=20
> > > Are you thinking about pthreads? It is not clear to me that this is
> > > necessary. It is also not clear to me what problem you are describing=
 that
> > > needs this solution. When I understand that better it will be easier =
to
> > > discuss solutions.
> >=20
> > I was trying to say I see advantage of retaining the address space whic=
h
> > is not possible with fork(), so perhaps using clone() with CLONE_VM wou=
ld
> > be useful and maybe some other flags too. I think this would solve the
> > write test case.
>=20
> clone() brings with it the complexity of needing to manage the child's
> stack. This again aims for a performance improvement. What does this fix?
> What is the benefit to resctrl health? I would prefer that our energy
> instead be focused on improving resctrl subsystem health.

Fair enough.

--=20
 i.

--8323328-1286384385-1725886369=:1029--

