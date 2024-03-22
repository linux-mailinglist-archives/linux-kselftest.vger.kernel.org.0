Return-Path: <linux-kselftest+bounces-6489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9592886BF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 13:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FD41F23C9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 12:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21B73FB8E;
	Fri, 22 Mar 2024 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUdqhDw0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF53FE35;
	Fri, 22 Mar 2024 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110149; cv=none; b=CQqYw7ApTHeuzKEqVUMqKzkfWSqihFVs+Dk3Zg4BnFcNxCWTOHKNiEbEZKNQ5QoSRenuO9dCpTtWsr7WpRuQriqzGyuRuqhaF/SLSheuoEud5gtbxPpSb7xRrLV7lXSGwj2XW9FzOcCaDgw3UGLSnZBHMHHFqK8NEkYrzhTtxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110149; c=relaxed/simple;
	bh=pMgrbmMeX+ZQ6UaBiGJMpnRuAkcA2VQDscBqz9g7k6c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d4Q+AokMGyP3mzLaiWDb1aTvn6ENvSOGKoaVSNHXHGUfIxYO3ZLX+D3TnykKUWAuJNTJeFWw5doEvwXWgxiu7iw3W3r8WrZb0sr4pYEr7DNzKNPgilkdKjVpCGjsKa7ZCNpM5THxhpqaru0f3DMduLrqy/tEzvruOW7QpTzCalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUdqhDw0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711110148; x=1742646148;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pMgrbmMeX+ZQ6UaBiGJMpnRuAkcA2VQDscBqz9g7k6c=;
  b=TUdqhDw0tx7D7KcB9OCM+tN8YMvBpjsmKYnH8EfUGyqncrUChuw1iNVk
   xU4eyVc7QUcKzVGg7n0WsYv3CkQEliS5wP0tp7FETQ9qwMF73WeJzyqac
   c1FHzwO39VPowvNun993Jd/Pjl8630EyO8qA04mopKfg6bYJpG4wFdRUK
   4qxcEp8QITK84LfmLpg6t5z+IuGF+p1GFPgyR1jIyX5SSuTNQ3XcmWzwf
   HSdsPYMh7l1OwTYVxebz6SYbnuyWSxAQcxa7xJXRLLy2pVoOoEtpDg66G
   n0cRu6zGxcn6ohaTrRBWwTZdvpp9Lw+TgRWLxBMQ5F9mzDh8f1Zv0rhx6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16881451"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="16881451"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="19454614"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.18])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 05:22:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 22 Mar 2024 14:22:19 +0200 (EET)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] selftests/resctrl: Add ->init() callback into
 resctrl_val_param
In-Reply-To: <a3d11ae1-0ea2-44d1-953c-0e9296582865@intel.com>
Message-ID: <15f0b698-adcc-9e05-90f0-082f0477a618@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com> <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com> <a3d11ae1-0ea2-44d1-953c-0e9296582865@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1967048135-1711110139=:1115"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1967048135-1711110139=:1115
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 19 Mar 2024, Reinette Chatre wrote:
> On 3/11/2024 6:52 AM, Ilpo J=C3=A4rvinen wrote:
> > The struct resctrl_val_param is there to customize behavior inside
> > resctrl_val() which is currently not used to full extent and there are
> > number of strcmp()s for test name in resctrl_val done by resctrl_val().
> >=20
> > Create ->init() hook into the struct resctrl_val_param to cleanly
> > do per test initialization.
> >=20
> > Remove also unused branches to setup paths and the related #defines.
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/cmt_test.c    |  12 ++
> >  tools/testing/selftests/resctrl/mba_test.c    |  24 +++-
> >  tools/testing/selftests/resctrl/mbm_test.c    |  24 +++-
> >  tools/testing/selftests/resctrl/resctrl.h     |   9 +-
> >  tools/testing/selftests/resctrl/resctrl_val.c | 123 ++----------------
> >  5 files changed, 75 insertions(+), 117 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing=
/selftests/resctrl/cmt_test.c
> > index 241c0b129b58..e79eca9346f3 100644
> > --- a/tools/testing/selftests/resctrl/cmt_test.c
> > +++ b/tools/testing/selftests/resctrl/cmt_test.c
> > @@ -16,6 +16,17 @@
> >  #define MAX_DIFF=09=092000000
> >  #define MAX_DIFF_PERCENT=0915
> > =20
> > +#define CON_MON_LCC_OCCUP_PATH=09=09\
> > +=09"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
> > +
> > +static int set_cmt_path(const struct resctrl_val_param *param, int dom=
ain_id)
> > +{
> > +=09sprintf(llc_occup_path,=09CON_MON_LCC_OCCUP_PATH,=09RESCTRL_PATH,
>=20
> Strangely some tab characters sneaked in above.

Ah, fixed it now. They seemed to came directly from the old code.

> > @@ -826,17 +729,11 @@ int resctrl_val(const struct resctrl_test *test,
> >  =09if (ret)
> >  =09=09goto out;
> > =20
> > -=09if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
> > -=09    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
> > -=09=09ret =3D initialize_mem_bw_imc();
> > +=09if (param->init) {
> > +=09=09ret =3D param->init(param, domain_id);
> >  =09=09if (ret)
> >  =09=09=09goto out;
> > -
> > -=09=09initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
> > -=09=09=09=09=09  domain_id, resctrl_val);
> > -=09} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> > -=09=09initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
> > -=09=09=09=09=09    domain_id, resctrl_val);
> > +=09}
> > =20
> >  =09/* Parent waits for child to be ready. */
> >  =09close(pipefd[1]);
>=20
> I am trying to make sense of what these tests are trying to do and
> it is starting to look like the monitor groups (as they are used here)
> are unnecessary.
>=20
> Looking at resctrl_val()->write_bm_pid_to_resctrl() I see that the
> control group is created with "bm_pid" written to its "tasks" file
> and then a monitor group is created as child of the control group
> with the same "bm_pid" written to its "tasks" file.
> This looks unnecessary to me because when the original control
> group is created on a system that supports monitoring then that
> control group would automatically be a monitoring group also. In
> the resctrl kernel document these different groups are termed
> "CTRL_MON" and "MON" groups respectively.
>=20
> For example, if user creates control group "c1":
> # mkdir /sys/fs/resctrl/c1
> Then, automatically it would also be a monitoring group with
> its monitoring data available from
> /sys/fs/resctrl/c1/mon_data/mon_L3_XX/*
>=20
> PIDs written to /sys/fs/resctrl/c1/tasks will have allocations
> assigned in /sys/fs/resctrl/c1/schemata and monitoring data
> /sys/fd/resctrl/c1/mon_data/mon_L3_XX/* ... it is not necessary
> to create a separate monitoring group to collect that=20
> monitoring data.
>=20
> This seems to be the discrepancy between the MBA and MBM test ...
> if I understand correctly they end up needing the same data but
> the one uses the data from the CTRL_MON group while the other
> creates a redundant child MON group to read the same data
> that is available from the CTRL_MON group.

Okay, I can look into this too. I've not looked too deeply why the=20
difference between MBA and MBM test is there.

--=20
 i.

--8323328-1967048135-1711110139=:1115--

