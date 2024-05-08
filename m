Return-Path: <linux-kselftest+bounces-9690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503098BF7E6
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 10:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07429282F4C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02FB3AC10;
	Wed,  8 May 2024 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiVhMn8+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3F3B1AA;
	Wed,  8 May 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155227; cv=none; b=qIeStoF3szDnuPdghe9ipBsVqNQTFbGHpnaKEud4J49d1AQqUgUT7nbZH6CLRIze/aA5P/PQPZRyyPwxKlzdw/zwV+0Nbe7xQ4mOe8Se+feP6D5pA+GzN06ulJPx/80e8d06OIuqxyUi24MlNYYs93zVlYT3njGi10CHBWf+z5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155227; c=relaxed/simple;
	bh=A/AkggmDRJWYn/SaPI9yF1hBn4xncSCYULCuBbRnXZY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s2xr8v2YSpW7GZXxoQvEA++Nq0BKPbuZONk/TYR7B/sEEeYFvaqCHAdWr/W3DfKQpCK0cRxTQI9aiVkYMqLI3DCC7QKqylw7jx87mNDf29FVQLZNkOLqODTam/rkvP0+HM8FqOxipRcEJxicFw11F+lHkA2cUQ1lqwNzxL/VPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiVhMn8+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715155225; x=1746691225;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A/AkggmDRJWYn/SaPI9yF1hBn4xncSCYULCuBbRnXZY=;
  b=hiVhMn8+9b9G9wGAwoIcaGEaTnSCe5R0LFiDAqNvwHViEW5UGP5GFW3+
   Mqz+vdgDPeI9RkJ7IOKyKKT45DRtKkGR1o+rIWByKBvbbHr629b/H/TV0
   iuJlUpRSTqn0Zua3HGxSGlv5mfUnoBBOTqDAVSCQidEckGLr+v/YYtpDo
   mMFf1jTgE1sDV2jSwWvqUYk62lKTt4jKbY7NCZebW1+avz/Yc5vs13lq0
   d1Hw4zM5nZKw1w8pIloRIBXuzpLRLnaPkuzLcDLd74xIbJU+ZP2/Kju78
   4g3v5j3s4h8LbHdesQjvC7KuutOEJB+WVOzuVhHP6gA1hxkt6HzzXkIsS
   g==;
X-CSE-ConnectionGUID: gU+gLjugT9GfnR+NHO7bxA==
X-CSE-MsgGUID: T9wVPM0RSr+uYjzwWh/9mA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11157644"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="11157644"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:00:25 -0700
X-CSE-ConnectionGUID: nJHE1sCIRDu17P/5vHb2Bg==
X-CSE-MsgGUID: tDH/Dr3jRKOveu8r6SwhHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33362348"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.80])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:00:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 May 2024 11:00:15 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
    Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst <kernel@valentinobst.de>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/resctrl: fix clang build warnings related
 to abs(), labs() calls
In-Reply-To: <076d9990-6253-438d-bc92-70eba6dfbca9@intel.com>
Message-ID: <7d4d8a31-00db-c7ba-aa8f-0483c8d93700@linux.intel.com>
References: <20240503234051.21217-1-jhubbard@nvidia.com> <9ae11dcb-62e8-4361-9f78-971d4c6e6054@intel.com> <997d7fe0-46c8-4b38-824d-083ab29f54ce@nvidia.com> <d67f4f57-4e9a-4715-b6dd-7b83a240b7dd@intel.com> <7dd4b09e-b9ba-459d-bfa4-150e712f54bc@nvidia.com>
 <076d9990-6253-438d-bc92-70eba6dfbca9@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1785506523-1715155215=:3164"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1785506523-1715155215=:3164
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 May 2024, Reinette Chatre wrote:

> Hi John,
>=20
> On 5/7/2024 6:25 PM, John Hubbard wrote:
> > On 5/7/24 6:21 PM, Reinette Chatre wrote:
> >> Hi John,
> > ...
> >>
> >> The following (what was in v1) looks good to me. What am I missing?
> >>
> >> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testin=
g/selftests/resctrl/cmt_test.c
> >> index a81f91222a89..05a241519ae8 100644
> >> --- a/tools/testing/selftests/resctrl/cmt_test.c
> >> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> >> @@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc=
_val, int no_of_bits,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avg_llc_val =3D sum_llc_val / nu=
m_of_runs;
> >> -=C2=A0=C2=A0=C2=A0 avg_diff =3D (long)abs(cache_span - avg_llc_val);
> >> +=C2=A0=C2=A0=C2=A0 avg_diff =3D (long)(cache_span - avg_llc_val);
> >=20
> > This deletes the abs() call, because I incorrectly let clang's warning
> > lead me to believe that the abs() call was a no-op. But both you and Il=
po
> > pointed out that the math breaks if you do that.
>=20
> To me the extra abs() was unnecessary anyway ...
>=20
> >=20
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 diff_percent =3D ((float)cache_span - a=
vg_llc_val) / cache_span * 100;
> >> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D platform && abs((int)dif=
f_percent) > max_diff_percent &&
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abs(avg_diff) =
> max_diff;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 labs(avg_diff)=
 > max_diff;
> >=20
>=20
> .. because it is repeated here.

Yes, there are two *abs() calls in this function.

In this case is okay to remove the first one since it didn't remove=20
absolute value completely, whereas in the MBA/MBM cases v1 removed *abs()=
=20
call entirely which was wrong thing to do.

I explicitly noted in my v1 comment that this CMT change is okay but the=20
other two were not.

--=20
 i.

--8323328-1785506523-1715155215=:3164--

