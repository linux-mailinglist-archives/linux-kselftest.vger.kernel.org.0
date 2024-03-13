Return-Path: <linux-kselftest+bounces-6299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1618087A724
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 12:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F18B22B6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 11:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B7A3F8D4;
	Wed, 13 Mar 2024 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PE963hp2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B32629C;
	Wed, 13 Mar 2024 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329881; cv=none; b=Bt9fWc1HSWBnbWTtvm7Li2QAPgoFwCYSsB7CtjrORzk4/++Y8DwLkI3x82Y+b9h4YIX0LS28wvxOHDFCsXSeIH4YCZvGAoE+ELQBO/HE3xBrQOT+HrquVF6eTyU8xFhG1cnKYSHBvQjSgV3KyWGPn/nC6KhC2zdy0sPUNqqsmD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329881; c=relaxed/simple;
	bh=Qa7ll0GyaGUvz7Usuw8YD3mUQgOjcuJgigdKi3gJ5Bw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y+XXVsm+Y5/DvctMzuKRqZUaAuu+Xd5fIFiAA8oVt1EVvpFXjcbgE/h6Zp8HAUJi+Vxv22M16/PhJT1VV3z3s/RaAKH0EFa9A5E+cPodw2wL0FYbtmqTpNUgNb8Sm+hKDySv6zXBQyAKDGMRZk6T3gTJCxkckCmQotUlMF6OsSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PE963hp2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710329881; x=1741865881;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Qa7ll0GyaGUvz7Usuw8YD3mUQgOjcuJgigdKi3gJ5Bw=;
  b=PE963hp2jhrdHAVP82a8wAvH7RIs22phuj778FRoSvzaOG5594B8wjM7
   d3iQ1Av84h1ltKExsCeu7Qlk7MhX7FMmpue54CBnLsE3/x4oYavAIeYqx
   5iAkD5UEV/V2epwswP/0unKJ4alf5AMcebXPNMfcXoVKAV4QRnMq3UE7R
   kU9i0nyxtI8xQ1urUqp7AFCC2ttMvaM55bfew3sHK2QE35ELlzUWtwMul
   Tp75+7o3rno2kFyMfXqn+Zm5EmH/KKIgdTIKKz0cd6AQfq5cvVHaujcBo
   3UuiGr4ZQ72TFnUWb3PmnnjMRJ8ieRadX1ti+OUU6yjy91WL3mmDZsacY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5017713"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="5017713"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16547029"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.7])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:37:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 13 Mar 2024 13:37:51 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: linux-kselftest@vger.kernel.org, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, Fenghua Yu <fenghua.yu@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] selftests/resctrl: Add ->init() callback into
 resctrl_val_param
In-Reply-To: <vzluzxmks6bqfszwoib72ufbanxucxk5xzilavp3wrwoh7fqxh@rugv6wcptofu>
Message-ID: <511bb602-e29d-0a2c-3076-81fdd5a5955f@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com> <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com> <zxrd5yzgtbet3d42c77ifgu5t2guyhwbz76zhk7zhrp6hnamrb@pl72dxisxax6> <vzluzxmks6bqfszwoib72ufbanxucxk5xzilavp3wrwoh7fqxh@rugv6wcptofu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1018063897-1710329871=:1167"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1018063897-1710329871=:1167
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 13 Mar 2024, Maciej Wieczor-Retman wrote:
> On 2024-03-13 at 11:15:30 +0100, Maciej Wieczor-Retman wrote:
> >On 2024-03-11 at 15:52:25 +0200, Ilpo J=E4rvinen wrote:
> >>diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing=
/selftests/resctrl/cmt_test.c
> >>index 241c0b129b58..e79eca9346f3 100644
> >>--- a/tools/testing/selftests/resctrl/cmt_test.c
> >>+++ b/tools/testing/selftests/resctrl/cmt_test.c
> >>@@ -16,6 +16,17 @@
> >> #define MAX_DIFF=09=092000000
> >> #define MAX_DIFF_PERCENT=0915
> >>=20
> >>+#define CON_MON_LCC_OCCUP_PATH=09=09\
> >>+=09"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
> >>+
> >>+static int set_cmt_path(const struct resctrl_val_param *param, int dom=
ain_id)
> >>+{
> >>+=09sprintf(llc_occup_path,=09CON_MON_LCC_OCCUP_PATH,=09RESCTRL_PATH,
> >>+=09=09param->ctrlgrp, param->mongrp, domain_id);
> >>+
> >>+=09return 0;
> >>+}
> >>+
> >
> >Is there an option to make this function (and the set_mbm_path()) global=
 through
> >the resctrl.h?
> >
> >I'd like to use it in my SNC series [1] for looping over different nodes=
 and
> >that requires changing the paths during the measure phase of the tests a=
nd that
> >part is currently in cache.c:measure_llc_resctrl().
> >
> >Or would you suggest some other way of changing these paths in cache?
> >
>=20
> +forgot to add the link :b
>=20
> [1] https://lore.kernel.org/all/cover.1709721159.git.maciej.wieczor-retma=
n@intel.com/

Perhaps ->init() should just prepare an array of filenames to read from=20
to support SNC. That would keep the filename preparations out of the=20
measurement period.

It feels slightly hacky to have an array of files but I cannot think of=20
anything else that would be cleaner and would not require creating the=20
filenames during the actual test.


--=20
 i.

--8323328-1018063897-1710329871=:1167--

