Return-Path: <linux-kselftest+bounces-10916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF38D4B1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 13:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA8828282E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 11:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6AE17E446;
	Thu, 30 May 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IT2yQxNG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD317276E;
	Thu, 30 May 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070185; cv=none; b=r95p+ag+paQdhe5SgCsV1ZWqoSHlXT0QAGn5lg/UvVBkFpygQfbQFlpltwoh0f+yIDOf3Z/q0QEq90CLzqF6XeAYb6sF8QlUIBlqq7Cu6pyl6PzxadymlEDFkIICBLtIHmZdRydZBVuI5XLflEl4b448EkkMkoPuGtY948MU8Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070185; c=relaxed/simple;
	bh=Kf5urJElw/MAhUVK6/I8Nf7RBE+hhlvwpip9R7CJZmE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fA9YRBF2xWhKVVgpTRXjCuHMMnNZRXiIQVojVot51irdkQk0182hpXw5Dtu3zyZ+m4FGZ4W9fJTep5jn5I+vcMLEkS+UMOhMjheR0pBzonkUusOkIQezUx8HhsmCSCOt6OZJRzhwjZUW+FDZk+TjiSB8nzkm8RpM1PmOkbphtpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IT2yQxNG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717070184; x=1748606184;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Kf5urJElw/MAhUVK6/I8Nf7RBE+hhlvwpip9R7CJZmE=;
  b=IT2yQxNGZWx7Gvo0VyBfCIqCPb/nIFFDiHFlOa2t2tuYZNImqMBrDoVc
   ci63FwJd0Xat2PbpMhBC9UCMKoGa6Qs7BmbFlUhI6ATcDEDQyGPe/R4hS
   N7zudVI4R7qoCZqAeNYL5VXawL4A7fhL86RNkQw55DS3QtpPgbKvQehXt
   epUF0wXzbTyqe82hTnN7lBOhKHRIxZnQcwUi7eJb21ARc7n5xgDvXOdUt
   e43fGUo4yozK9I84mwWSwZDyAr4JcPuuCrTJq6GF+erKF/7hWvGxNNkw5
   0ZZcb/2ry/lLzZROfPuuILGSgtJmFK+yOrDltpB+UyGzqnjYcaHE3hf3o
   Q==;
X-CSE-ConnectionGUID: J7oc/xn/Thyu0cyerwuWSQ==
X-CSE-MsgGUID: TZcXRTluTOSxcCHLFI9OwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13730237"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="13730237"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 04:56:23 -0700
X-CSE-ConnectionGUID: r51jObzNTHqgQUsRGGP9+g==
X-CSE-MsgGUID: SuG7wB0TQZGU8VkEhESf8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="40325621"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.150])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 04:56:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 May 2024 14:56:16 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, 
    Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4 14/16] selftests/resctrl: Remove mongrp from MBA
 test
In-Reply-To: <f2a8e8ad-311c-4302-a200-03fc9f02b20b@intel.com>
Message-ID: <feec5ce3-cad9-6ace-3588-67e7da9641d6@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com> <20240520123020.18938-15-ilpo.jarvinen@linux.intel.com> <f2a8e8ad-311c-4302-a200-03fc9f02b20b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1244305515-1717062694=:1113"
Content-ID: <ad75cbad-443e-d9d9-5090-23354f3468f7@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1244305515-1717062694=:1113
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <dc718522-6640-a0a6-7777-2864c166fa6f@linux.intel.com>

On Wed, 29 May 2024, Reinette Chatre wrote:
> On 5/20/24 5:30 AM, Ilpo J=E4rvinen wrote:
> > Nothing during MBA test uses mongrp even if it has been defined ever
> > since the introduction of the MBA test in the commit 01fee6b4d1f9
> > ("selftests/resctrl: Add MBA test").
> >=20
> > Remove the mongrp from MBA test.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >   tools/testing/selftests/resctrl/mba_test.c | 1 -
> >   1 file changed, 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/resctrl/mba_test.c
> > b/tools/testing/selftests/resctrl/mba_test.c
> > index 9c9a4f22e529..5e0b1e794295 100644
> > --- a/tools/testing/selftests/resctrl/mba_test.c
> > +++ b/tools/testing/selftests/resctrl/mba_test.c
> > @@ -166,7 +166,6 @@ static int mba_run_test(const struct resctrl_test *=
test,
> > const struct user_param
> >   =09struct resctrl_val_param param =3D {
> >   =09=09.resctrl_val=09=3D MBA_STR,
> >   =09=09.ctrlgrp=09=3D "c1",
> > -=09=09.mongrp=09=09=3D "m1",
> >   =09=09.filename=09=3D RESULT_FILE_NAME,
> >   =09=09.init=09=09=3D mba_init,
> >   =09=09.setup=09=09=3D mba_setup,
>=20
> This may explain the unexpected checks that are removed in final patch?

While possible, I just have gotten a feeling that not much thought has=20
been put on generality until now. Because of that, the solution had always=
=20
been adding new ifs, no matter the place, instead of thinking how to=20
parametrize things properly instead. It has lead to fully overlapping=20
checks, dead code, and incomplete error handling which is hopefully now=20
slowly getting less and less.

> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

--=20
 i.
--8323328-1244305515-1717062694=:1113--

