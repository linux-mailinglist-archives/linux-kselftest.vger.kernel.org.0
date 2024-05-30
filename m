Return-Path: <linux-kselftest+bounces-10915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C818D4AF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 13:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33811C22508
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D1E176182;
	Thu, 30 May 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7v3Pel/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D83B176AC5;
	Thu, 30 May 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717069506; cv=none; b=e1fFd2Cs3DUtO7KSf8KUH7HTS+Ur3rLFgNzC6goHDKZNOaGNq0N44SwqfIJ1e2d2ZhRQmHUBIHKbSJMQ/jZtJMFKsygK+1fqpvBiAyoAxkYewKgE6Nn2ypsMJlvPqhsMQiQ3bl3Epb7Llky118ZKcsS+1GB0EUvp+vwzhwkpcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717069506; c=relaxed/simple;
	bh=f9yex0Fn8UvWvmP34S99dGP6y/djloVwxdVqGVzSE3k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZwijGOJ1wqrl7rbqFVyPpCwEZiGdTYyG9denUM+rdswAy5UADyt4btDJt2rifYM8nnqL2Yh4Is61x3rVFr+AIy+N990sc1bh1iI8TRv1grLPmRJsCcCRmwlYsNKMpH+piH+ZetTCg3ZqvsA7Ra+uK0IAC+JXfAatf4cIyBSFUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7v3Pel/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717069506; x=1748605506;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f9yex0Fn8UvWvmP34S99dGP6y/djloVwxdVqGVzSE3k=;
  b=l7v3Pel/iC3wZCu8cFOes5B+pcuBfB/7S07t2VvGoz/uJc8ORG9AodDF
   sUVJUGi6X9HtCgPVeU0rt2ezcjXppVzxeuIJFfiFqmlbdBYRxCQSmtT5m
   9Rc/8huMwnZzUkUqDvonAg6PEFHkqMuFotTtkzXVTimX7LIeEP98LVvpY
   3xM59ek331TP4OixC7UGRwyAW7v42b1sUffn4uc99n6G8iWQLe8ayxG+0
   mSybbqFtBfqRlrL2FBtGVI8XLIVSUOXnUziaYhdPozSNhjtRz9pa3jjOs
   ffjxpDUIsJ6Z70076IqDwo0/lfMBamCOpTiqWn/PTNkb2CfmW29unIakR
   g==;
X-CSE-ConnectionGUID: TT3+0XZTQriQwgL5eVj4jQ==
X-CSE-MsgGUID: qO9c5xpBR4+n/Rw5M6mvbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17376467"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="17376467"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 04:45:05 -0700
X-CSE-ConnectionGUID: ga+mekW0SlS2SLZsYcnOkw==
X-CSE-MsgGUID: 543TXdKLQ5W38te2Lhk5iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="35732878"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.150])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 04:45:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 May 2024 14:44:57 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, 
    Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4 13/16] selftests/resctrl: Convert ctrlgrp & mongrp to
 pointers
In-Reply-To: <bafcfe0c-e052-426f-be0d-9bcbb4c16a62@intel.com>
Message-ID: <a14be305-67fc-7c92-3e40-0168084171d6@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com> <20240520123020.18938-14-ilpo.jarvinen@linux.intel.com> <bafcfe0c-e052-426f-be0d-9bcbb4c16a62@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1151364960-1717069497=:1113"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1151364960-1717069497=:1113
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 29 May 2024, Reinette Chatre wrote:

> Hi Ilpo,
>=20
> On 5/20/24 5:30 AM, Ilpo J=C3=A4rvinen wrote:
> > The struct resctrl_val_param has control and monitor groups as char
> > arrays but they are not supposed to be mutated within resctrl_val().
> >=20
> > Convert the ctrlgrp and mongrp char array within resctrl_val_param to
> > plain const char pointers and adjust the strlen() based checks to
> > check NULL instead.
> >=20
> > Convert !grp_name check in create_grp() into internal sanity check by
> > returning error if the caller asked to create a group but doesn't
> > provide a name for the group. The existing code already abides this by
> > only calling create_grp() if mongrp is non-NULL so the error should
> > never be returned with the current selftests (ctrlgrp is never NULL).
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >=20
> > v3:
> > - Removed wrong comment
> > - Changed grp_name check to return -1 on fail (internal sanity check)
> > ---
> >   tools/testing/selftests/resctrl/resctrl.h   |  4 ++--
> >   tools/testing/selftests/resctrl/resctrlfs.c | 15 +++++----------
> >   2 files changed, 7 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h
> > b/tools/testing/selftests/resctrl/resctrl.h
> > index 5967389038d4..a999fbc13fd3 100644
> > --- a/tools/testing/selftests/resctrl/resctrl.h
> > +++ b/tools/testing/selftests/resctrl/resctrl.h
> > @@ -91,8 +91,8 @@ struct resctrl_test {
> >    */
> >   struct resctrl_val_param {
> >   =09char=09=09*resctrl_val;
> > -=09char=09=09ctrlgrp[64];
> > -=09char=09=09mongrp[64];
> > +=09const char=09*ctrlgrp;
> > +=09const char=09*mongrp;
> >   =09char=09=09filename[64];
> >   =09unsigned long=09mask;
> >   =09int=09=09num_of_runs;
> > diff --git a/tools/testing/selftests/resctrl/resctrlfs.c
> > b/tools/testing/selftests/resctrl/resctrlfs.c
> > index a0e84157eb63..6b4448588666 100644
> > --- a/tools/testing/selftests/resctrl/resctrlfs.c
> > +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> > @@ -464,13 +464,8 @@ static int create_grp(const char *grp_name, char *=
grp,
> > const char *parent_grp)
> >   =09struct dirent *ep;
> >   =09DIR *dp;
> >   -=09/*
> > -=09 * At this point, we are guaranteed to have resctrl FS mounted and =
if
> > -=09 * length of grp_name =3D=3D 0, it means, user wants to use root co=
n_mon
> > -=09 * grp, so do nothing
> > -=09 */
> > -=09if (strlen(grp_name) =3D=3D 0)
> > -=09=09return 0;
> > +=09if (!grp_name)
> > +=09=09return -1;
>=20
> As I said during review of v2, this should not be an error. I went back t=
o
> read
> your comments and the argument that this is done for benefit of API is un=
clear
> since
> the default control group does not have a name, exactly what create_grp()
> supports
> when not returning an error in this case.

Okay, I did not know about this expectation related to the default control=
=20
group because it's not used anywhere in the selftest code that always=20
provides a ctrlgrp name.

I'll change it to return 0.

--=20
 i.

--8323328-1151364960-1717069497=:1113--

