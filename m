Return-Path: <linux-kselftest+bounces-17125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7103296BE19
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2901F2875EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9AA1D88CC;
	Wed,  4 Sep 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USMo9+KP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9B91D79B2;
	Wed,  4 Sep 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455876; cv=none; b=mV9evBliTf/jky0mhL4tYucpLIwyvtkJogOZXSXkeCmmhBqq15yjQ90nbVMrxbc1NpXsQVMyDDBHunUS7SZ1YzvHHf9wNf9Z7YqIbKieXoPH06aPebhywH+vCJzZ7BU4RoXp/VNMK+dXejclqVgZg4LtdM1O5NDmxoi1zQ4MZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455876; c=relaxed/simple;
	bh=nUptJL6/XR54C3Hp+eaQt0VxwCOwPEOvgDGy8AIHJtY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U0tzQt72KzrupEG/xlVpEM0m+NsdYgWPDMMSTr5N+dNF+s3/KxG0hTGDcYdppHecOQmzL/AozF/6vHx+z88SMdOFEpxnfbYoBza6Vxsn05fZN2IAmBfoGHOhwJV1znrpos32S81/MFkcYg5rwTLrq6RPevXE8VZ+rCmuHtLir/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USMo9+KP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725455875; x=1756991875;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=nUptJL6/XR54C3Hp+eaQt0VxwCOwPEOvgDGy8AIHJtY=;
  b=USMo9+KPIqXTxa7MNTABgKNGTrkdAg36qs5kPrsmxlYwsooOcJ7uDseb
   mJ3ycTO+cQyKcyT3ebximPYC11+xNPYQtgUbi+g21OFYgeqtiHRuW8KTj
   MWR+GFaglEqwxius8XhKboHslXHM07r3yt8nki5uFd9fmr/tfLeWsSV/1
   UHKDERE5LaGhGxY14nTDIgIMtzEkEwc1pomwyV8fYgiyBFD7AoHrQU+dH
   VsYI4knIOcnzpVwjVBljq2OQ/IKk6KDaEV+pkeCzx1sryf2ql4PbWxXrq
   SzZjghjKv8kavs/t/hPy7zZYaUNEJxPqxAw9+xRBsY5KxptjKOJmg6ln7
   Q==;
X-CSE-ConnectionGUID: 3l7XVeF5Tpqg2Tf1StZahA==
X-CSE-MsgGUID: 7UuNTumGSdeuN8H1rbGCTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="23980447"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="23980447"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 06:17:54 -0700
X-CSE-ConnectionGUID: eIkT+GRaRGOerEUvbxGzeg==
X-CSE-MsgGUID: Wk5Xy4jmQN+/nHSl5TLB+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65992723"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.156])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 06:17:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 4 Sep 2024 16:17:46 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
    Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>
Subject: Re: [PATCH v4 3/4] selftests/x86: don't clobber CFLAGS
In-Reply-To: <611d1e93-6f64-4eb5-a054-4d92f076de41@intel.com>
Message-ID: <dd430042-7f3c-d495-0fc6-d65e88aaa4b8@linux.intel.com>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com> <20240903144528.46811-4-ilpo.jarvinen@linux.intel.com> <611d1e93-6f64-4eb5-a054-4d92f076de41@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1515136098-1725453076=:1078"
Content-ID: <aaf4f14c-01bb-3d45-abe1-168a725f2fed@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1515136098-1725453076=:1078
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e1d2db08-4e7b-cf29-6f7c-9209b3dac95e@linux.intel.com>

On Tue, 3 Sep 2024, Reinette Chatre wrote:
> On 9/3/24 7:45 AM, Ilpo J=E4rvinen wrote:
> > The x86 selftests makefile clobbers CFLAGS preventing lib.mk from
> > making the necessary adjustments into CFLAGS. This would lead to a
> > build failure after upcoming change which wants to add -DHAVE_CPUID=3D
> > into CFLAGS.
> >=20
> > Reorder CFLAGS initialization in x86 selftest. Place the constant part
> > of CFLAGS initialization before inclusion of lib.mk but leave adding
> > KHDR_INCLUDES into CFLAGS into the existing position because
> > KHDR_INCLUDES might be generated inside lib.mk.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> > v4:
> > - New patch
> >=20
> >   tools/testing/selftests/x86/Makefile | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/x86/Makefile
> > b/tools/testing/selftests/x86/Makefile
> > index 5c8757a25998..88a6576de92f 100644
> > --- a/tools/testing/selftests/x86/Makefile
> > +++ b/tools/testing/selftests/x86/Makefile
> > @@ -1,4 +1,6 @@
> >   # SPDX-License-Identifier: GPL-2.0
> > +CFLAGS :=3D -O2 -g -std=3Dgnu99 -pthread -Wall
> > +
> >   all:
> >     include ../lib.mk
> > @@ -35,7 +37,7 @@ BINARIES_64 :=3D $(TARGETS_C_64BIT_ALL:%=3D%_64)
> >   BINARIES_32 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
> >   BINARIES_64 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
> >   -CFLAGS :=3D -O2 -g -std=3Dgnu99 -pthread -Wall $(KHDR_INCLUDES)
> > +CFLAGS +=3D $(KHDR_INCLUDES)
> >     # call32_from_64 in thunks.S uses absolute addresses.
> >   ifeq ($(CAN_BUILD_WITH_NOPIE),1)
>=20
> These changes are becoming less obvious to me. The first two
> red flags are:
> - Most other top level Makefiles assign KHDR_INCLUDES to CFLAGS
>   *before* including lib.mk

Most toplevel makefiles assigned CFLAGS before including lib.mk so x86=20
selftest was an exception overwriting CFLAGS after including lib.mk.
That looks like a real problem/bug and you don't seem to contest lib.mk=20
having the right to alter CFLAGS. So I'm still convinced this patch is
necessary independent of the cpuid/resctrl selftest issue.

I believe most of those Makefile are _buggy_ wrt. KHDR_INCLUDES but I=20
don't care where $(KHDR_INCLUDES) goes, it's irrelevant for the problem
I'm trying to solve which is the CFLAGS clobber. ...I just didn't want to
add yet another problem by moving KHDR_INCLUDES before including lib.mk.=20
I'm fine with leaving that can of worms for somebody else to sort out :-).

> - What current Makefiles do matches the guidance from
>   Documentation/dev-tools/kselftest.rst as per example (verbatim copy):
>     CFLAGS =3D $(KHDR_INCLUDES)
>     TEST_GEN_PROGS :=3D close_range_test
>     include ../lib.mk

I'm not objecting moving the entire CFLAGS line before including lib.mk
in the x86 selftests makefile if that is what you'd want me to do?

> Looking closer it is not clear to me why lib.mk sets KHDR_INCLUDES.

So are you suggesting the commit a52540522c95 ("selftests/landlock: Fix=20
out-of-tree builds") added it for no reason? The commit message indicates
it was added on purpose but I don't fully understand what "to other test=20
collections when building in their directory" means.

> As I understand the usage is intended to be:
>   make TARGETS=3D"target" -C tools/testing/selftests
> This means that it is tools/testing/selftests/Makefile that will
> run first and it ensures that KHDR_INCLUDES is set and supports
> the usage documented in Documentation/dev-tools/kselftest.rst
>=20
> One usage that a change like in this patch could support is
> for users to be able to run "make" from within the test
> directory self ... but considering the current KHDR_INCLUDES
> custom this does not seem to be supported? (but we cannot
> know which tests/users rely on this behavior)

Perhaps "when building in their directory" is exactly that?

I don't doubt the makefiles are very full of problems.

> Looking further I also noticed that
> tools/testing/selftests/Makefile even sets ARCH (but does
> not export it). When considering the next patch it almost looks
> like what is missing is for tools/testing/selftests/Makefile to
> "export ARCH" ... but that potentially impacts the Makefiles that
> do manipulation of ARCH.

The ARCH handling in various Makefiles is another mess.

> I initially started to look at this because of the
> resctrl impact, but I clearly am not familiar enough
> with the kselftest build files to understand the
> impacts nor provide guidance. I do hope the kselftest
> folks can help here.

Luckily this seems to have caught Shuah attention now so hopefully we've=20
soon some reasonable resolution to ARCH dependent building and code=20
fragments so each selftest doesn't need to come up their own way of=20
handling it. :-)

--=20
 i.
--8323328-1515136098-1725453076=:1078--

