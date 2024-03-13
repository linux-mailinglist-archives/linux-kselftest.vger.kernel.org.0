Return-Path: <linux-kselftest+bounces-6301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9017587A8E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 14:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C3DB2336A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C1A43AC3;
	Wed, 13 Mar 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PreT5Nxn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916E45C16;
	Wed, 13 Mar 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338364; cv=none; b=mc2GBUc3HKWDXAJ6ALoq6OmageU8JH4IiS4PqGbN24Dub1U3hwK48UYMTzxHLgUFPbZk5xtht/hSQ839HAy4A6THs/+zx+QM20DrzMSkZOiwJt/bXs6FcszYqeX6+damSA8Jh/u66bM0aRyaJLJ7Q0ShbIyNiYlDrIpTeD9/Mm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338364; c=relaxed/simple;
	bh=8To7s1BkpoHH43Z7zCeEevEwDp5/ljmw+7PZOfYTgl8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hNoxobwlQxJ6gCaMBClMWb71WHPottemFoNENvZ/AZMMMqrNkHFQxbdAa+vWxHuhUQ3pw1ulEguPcqJ3W0Kn25rwu9eBVKVRP1yuLeGDeQYCWyn2Jo/2F8LZrJp7+7Teilh60U3/ChOQ06LN5Z8AjNMbIVeKEyQwjQ5xJY8ymAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PreT5Nxn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710338363; x=1741874363;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=8To7s1BkpoHH43Z7zCeEevEwDp5/ljmw+7PZOfYTgl8=;
  b=PreT5NxnIIb7Nazl/hkgmo7z5lSYa+/xRAXjhw3g8iEICBbhHDQa18LK
   iyUPPczM4NQ3V8GMycItEkqYmXZWN8Vb3xGYxTsaa1EaGP+Va/nTnQKM8
   uBikN957pBgDdj2k8Me5Dk5mNvQ7n6j6LOXJzYwdMLeWQWvtM9L1tkJ4B
   PDZfn3Cz1zSJ1E7uAQHQ5O3qMg1J54ZSPnL3PoJnKEJqcO4o9SGKOSBpc
   x60PCvZBJhPSUyVfwoc/neQmT6RLyNmLLzjbMOBUo+tuDCVY7sVnZpkAx
   pnPr1MqciazXjFnHIrJWkTtZYngXKIymGHDwdCS/Z4/a6umYVMMk2zm8e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16253120"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16253120"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 06:59:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="11854306"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.7])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 06:59:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 13 Mar 2024 15:59:15 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: linux-kselftest@vger.kernel.org, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, Fenghua Yu <fenghua.yu@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] selftests/resctrl: Add ->init() callback into
 resctrl_val_param
In-Reply-To: <7zhdrvbb2w2ytyhbr2pl22exkzktqhv4ykb5pht6wsefg3yfyz@72xhgz3uyawo>
Message-ID: <5105ab0f-a90e-1770-1a67-db48f74b427f@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com> <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com> <zxrd5yzgtbet3d42c77ifgu5t2guyhwbz76zhk7zhrp6hnamrb@pl72dxisxax6> <vzluzxmks6bqfszwoib72ufbanxucxk5xzilavp3wrwoh7fqxh@rugv6wcptofu>
 <511bb602-e29d-0a2c-3076-81fdd5a5955f@linux.intel.com> <7zhdrvbb2w2ytyhbr2pl22exkzktqhv4ykb5pht6wsefg3yfyz@72xhgz3uyawo>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-518787328-1710338233=:1167"
Content-ID: <cdf611ef-34ee-201b-da68-72df17a42dbd@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-518787328-1710338233=:1167
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <22bde3bc-d109-63f6-bed5-ff50d2bc2f9f@linux.intel.com>

On Wed, 13 Mar 2024, Maciej Wieczor-Retman wrote:

> On 2024-03-13 at 13:37:51 +0200, Ilpo J=E4rvinen wrote:
> >On Wed, 13 Mar 2024, Maciej Wieczor-Retman wrote:
> >> On 2024-03-13 at 11:15:30 +0100, Maciej Wieczor-Retman wrote:
> >> >On 2024-03-11 at 15:52:25 +0200, Ilpo J=E4rvinen wrote:
> >> >>diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/test=
ing/selftests/resctrl/cmt_test.c
> >> >>index 241c0b129b58..e79eca9346f3 100644
> >> >>--- a/tools/testing/selftests/resctrl/cmt_test.c
> >> >>+++ b/tools/testing/selftests/resctrl/cmt_test.c
> >> >>@@ -16,6 +16,17 @@
> >> >> #define MAX_DIFF=09=092000000
> >> >> #define MAX_DIFF_PERCENT=0915
> >> >>=20
> >> >>+#define CON_MON_LCC_OCCUP_PATH=09=09\
> >> >>+=09"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
> >> >>+
> >> >>+static int set_cmt_path(const struct resctrl_val_param *param, int =
domain_id)
> >> >>+{
> >> >>+=09sprintf(llc_occup_path,=09CON_MON_LCC_OCCUP_PATH,=09RESCTRL_PATH=
,
> >> >>+=09=09param->ctrlgrp, param->mongrp, domain_id);
> >> >>+
> >> >>+=09return 0;
> >> >>+}
> >> >>+
> >> >
> >> >Is there an option to make this function (and the set_mbm_path()) glo=
bal through
> >> >the resctrl.h?
> >> >
> >> >I'd like to use it in my SNC series [1] for looping over different no=
des and
> >> >that requires changing the paths during the measure phase of the test=
s and that
> >> >part is currently in cache.c:measure_llc_resctrl().
> >> >
> >> >Or would you suggest some other way of changing these paths in cache?
> >> >
> >>=20
> >> +forgot to add the link :b
> >>=20
> >> [1] https://lore.kernel.org/all/cover.1709721159.git.maciej.wieczor-re=
tman@intel.com/
> >
> >Perhaps ->init() should just prepare an array of filenames to read from=
=20
> >to support SNC. That would keep the filename preparations out of the=20
> >measurement period.
> >
> >It feels slightly hacky to have an array of files but I cannot think of=
=20
> >anything else that would be cleaner and would not require creating the=
=20
> >filenames during the actual test.
>=20
> So the array of names would be a part of "struct resctrl_val_param"?

This series has in independent of resctrl_val_param because resctrl_val()=
=20
itself doesn't care after the separation of generic and per test logic.=20

But that meant making it globals into the per test files which I didn't=20
like that much either. So perhaps having it in resctrl_val_param is=20
still better.

--=20
 i.

> It would have to be dynamically allocated too before running the tests.
>=20
> I kinda agree, creating filenames during measurements messes the whole
> separation idea between setup and measuring. And as you said there are li=
ke 4
> nodes max so not much memory would be wasted there.
>=20
> I can experiment with it and try to add it in my series - since it's much=
 more
> tied to SNC. Unless you see it'd better fit here then that's fine with me=
 too.

--8323328-518787328-1710338233=:1167--

