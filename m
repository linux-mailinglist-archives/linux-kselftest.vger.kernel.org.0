Return-Path: <linux-kselftest+bounces-11556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE79024B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 16:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA481C21529
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB646132137;
	Mon, 10 Jun 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYiMRrg6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E5132113;
	Mon, 10 Jun 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031331; cv=none; b=SwQEcY2QggXmle+mG/oqVKp3qaLrT+26Swa/UE5rvNW9cQV+JrRZUjl8Yi5RMwQkRLOCcOmW3n6cd7iRUHU2TM+QGaaAYu9KkLQOMt3nrJ4SnxZLQRNw6tA6UPTPD7VP126QsgC7An2jYI7dVzH5nI72ezbh1HNnZeZKG0jg2M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031331; c=relaxed/simple;
	bh=l7rTorRM3FlZX0jt1oFeor2hKThshx65IHAktXp4IiA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rSGzJKxLZw2v3D3NqUoGclVPBYyrOW8wi5inmvoTWP1emvxLgwVXhlgh6xqbvHfDOC6DyiP00+Q4H6+KY4BZneRjV00o9/LrmEHLCtrAdSCnA7XCZbRy7rx/g+5jNAqdOW/jSz69N2G8B4hqnhSCZrfVeiHYo2szBHWIcw2qWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYiMRrg6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718031330; x=1749567330;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l7rTorRM3FlZX0jt1oFeor2hKThshx65IHAktXp4IiA=;
  b=ZYiMRrg625Ogq5JsZDfyAubDKFLxlBMGYeyqWWJO3siGoKHmY9qex5rz
   Dt41+GZ5qgmb3wwuW+QyaOO4CuGLzPljWXiI4M7V9Ya0vwayl/iBuwxCs
   WPW+ZjXutG8vkjZzDvadYVlk5GiJgmlwopUal8jM17EXzC6z4ZU9pY7/U
   KXBRA9qKC5CZGRz6tEIi7ZbTz0OugNCV1mfLALiDGpXtwEo4ZayHIcZk1
   1IBp1x1cCdB+/dfp3A2USnU+SNMs20mVnL2bjeqI/G6ycMQXJyrkXVKIb
   PKrA0WvzGSslsDxxKieol0tDxdU/G02DG5ZocVunwX5Lf2rnzC+VSjhwW
   Q==;
X-CSE-ConnectionGUID: D7Yil0RpSWqTR3D/JNDyUw==
X-CSE-MsgGUID: y2p3h0E0RqyZ0m/B4fPeLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="40094346"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="40094346"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 07:55:29 -0700
X-CSE-ConnectionGUID: vZ1rOx9ZThGeuoAV5ArZrw==
X-CSE-MsgGUID: NfBre3OUQCySuanRHp2kfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="44228522"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 07:55:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Jun 2024 17:55:23 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Babu Moger <babu.moger@amd.com>, Fenghua Yu <fenghua.yu@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v6 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
In-Reply-To: <3d6587a4-3e39-449b-a108-9f6893d4a405@intel.com>
Message-ID: <aac572c5-b130-9c3a-d991-7477ba552cfa@linux.intel.com>
References: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com> <20240607125316.7089-3-ilpo.jarvinen@linux.intel.com> <3d6587a4-3e39-449b-a108-9f6893d4a405@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1374148641-1718031323=:1540"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1374148641-1718031323=:1540
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 7 Jun 2024, Reinette Chatre wrote:
> On 6/7/24 5:53 AM, Ilpo J=C3=A4rvinen wrote:
> > For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that performs
> > the measurement over a duration of sleep(1) call. The memory bandwidth
> > numbers from IMC are derived over this duration. The resctrl FS derived
> > memory bandwidth, however, is calculated inside measure_vals() and only
> > takes delta between the previous value and the current one which
> > besides the actual test, also samples inter-test noise.
> >=20
> > Rework the logic in measure_vals() and get_mem_bw_imc() such that the
> > resctrl FS memory bandwidth section covers much shorter duration
> > closely matching that of the IMC perf counters to improve measurement
> > accuracy.
> >=20
> > For the second read after rewind() to return a fresh value, also
> > newline has to be consumed by the fscanf().
> >=20
> > Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Tested-by: Babu Moger <babu.moger@amd.com>
> > ---
> >=20
> > v6:
> > - Adjust closing/rollback of the IMC perf
> > - Move the comment in measure_vals() to function level
> > - Capitalize MBM
> > - binded to -> bound to
>=20
> This change does not match the patch.
>=20
> > v5:
> > - Open mem bw file once and use rewind()
> > - Read \n from the mem bw file to allow rewind to return a new value.
> > v4:
> > - Open resctrl mem bw file (twice) beforehand to avoid opening it durin=
g
> >    the test
> > v3:
> > - Don't drop Return: entry from perf_open_imc_mem_bw() func comment
> > ---
> >   tools/testing/selftests/resctrl/resctrl_val.c | 141 +++++++++++------=
-
> >   1 file changed, 91 insertions(+), 50 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/resctrl/resctrl_val.c
> > b/tools/testing/selftests/resctrl/resctrl_val.c
> > index f55f5989de72..1575c5c09ac7 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_val.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> > @@ -306,18 +306,13 @@ static void perf_close_imc_mem_bw(void)
> >   }
> >     /*
> > - * get_mem_bw_imc:=09Memory band width as reported by iMC counters
> > - * @cpu_no:=09=09CPU number that the benchmark PID is binded to
> > - * @bw_report:=09=09Bandwidth report type (reads, writes)
> > - *
> > - * Memory B/W utilized by a process on a socket can be calculated usin=
g
> > - * iMC counters. Perf events are used to read these counters.
> > + * perf_open_imc_mem_bw - Open perf fds for IMCs
> > + * @cpu_no: CPU number that the benchmark PID is bounded to
>=20
> "is bounded to" -> "is bound to"?
>=20
> Just the one nitpick from me. The patch looks good to me. Thank you
> very much.
>=20
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

I'll correct this in v7. I guess it's because I now make these corrections=
=20
"twice", once for the per patch changelog bullet and then the actual=20
change which unfortunately means my brains switch to repeated actions mode=
=20
=3D> autotype without thinking.

Earlier when I made the version changelogs only into 00/xx, I actually=20
read through the diff of diffs against the previous version in order to=20
find out what to write into the changelog. I ended up catching many error=
=20
like this in that stage. Now it's just mostly copying the pre-existing=20
entries from per patch changelogs (and less attention is obviously paid on=
=20
looking the diff of diffs because I no longer need to derive information
out of them).


--=20
 i.

--8323328-1374148641-1718031323=:1540--

