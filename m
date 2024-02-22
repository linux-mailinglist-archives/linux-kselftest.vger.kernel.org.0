Return-Path: <linux-kselftest+bounces-5277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA2585F56B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 11:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5AE1C234F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9BB39AC2;
	Thu, 22 Feb 2024 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feNqPlSB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D93E493;
	Thu, 22 Feb 2024 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596840; cv=none; b=DIbD2jieqFQ9VCy0n42vPYAsyHWvMbQ5zy3Qv8eo9KUMTB6qimznpKz7pp/cw5ivl7dm7j+k4lgwzrZPxChVLPTEft5QbkCYGWHNLTFtv6O/6n8OWWUFEY4td+cgA2CYsdFfk6uxwUJ+LDEHjKxXHFYCcuOj6wm3A6t5jT8eD3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596840; c=relaxed/simple;
	bh=Lhz2AqoIMkXphBZI972Ssa/mwT4KCllOKyWHciLNGxg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N+XalRNXXy56csNAAAMwxF0gJlBxYbzf4+ZuV2XcBlxBAcQ0bIlM3XSbPmhPuegQZ1YnBl/14DDt0uebv/w2ytQ+eL1GFXipWcNDKAMNrnoT/aqqTvr3BQAA3+8CezI5K0q0bCJCdFwjYyM68VdoM5u0JJ14iCCjlGM/BhW2Tkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feNqPlSB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708596839; x=1740132839;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lhz2AqoIMkXphBZI972Ssa/mwT4KCllOKyWHciLNGxg=;
  b=feNqPlSBVG1FtdTIc8mIFTyQ4DPu2me/OvyPuxBeCRUfKMNykeeIT9Hy
   9LpCK3vJK2ygh4XLT96PY0DY9j3HaZGbOHnIciXytFWTxoYnaffJ2vF5H
   ZcPeOWN5KrplkXmsKqtq9rO+ScPG6JJdPWlt+2ZHt38RCkzCPl0jvVVwX
   m24U6yHJlQLgHXjszpZH8nr+46WMpEpPsi6VBurmqqmGRJcQ/+s5US/Ws
   YGyVoquw3EUvogSW5V92lVYmlGzjiQa/PGsgucbT8duM0m5OxCpPqQn9g
   zanBTwEZd9A7bnykQRMhYbgs5vOVsxWVqFoMsqRoTfDJNhtKvA+NsoAo1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2951225"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2951225"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:13:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="827526207"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="827526207"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:13:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Feb 2024 12:13:50 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/3] selftests/resctrl: Simplify cleanup in ctrl-c
 handler
In-Reply-To: <c472e478-eaf1-0003-cf2d-c861e620fce2@linux.intel.com>
Message-ID: <064e7069-9ed7-b7b2-b0e9-3e730cca39ff@linux.intel.com>
References: <cover.1708596015.git.maciej.wieczor-retman@intel.com> <3a6639cd338a706bd2ed341aa6c717e1e79cc1f0.1708596015.git.maciej.wieczor-retman@intel.com> <c472e478-eaf1-0003-cf2d-c861e620fce2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2000140883-1708596830=:1961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2000140883-1708596830=:1961
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Feb 2024, Ilpo J=E4rvinen wrote:

> On Thu, 22 Feb 2024, Maciej Wieczor-Retman wrote:
>=20
> > Ctrl-c handler isn't aware of what test is currently running. Because o=
f
> > that it executes all cleanups even if they aren't necessary. Since the
> > ctrl-c handler uses the sa_sigaction system no parameters can be passed
> > to it as function arguments.
> >=20
> > Add a global variable to make ctrl-c handler aware of the currently run
> > test and only execute the correct cleanup callback.
> >=20
> > Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> > ---

> > diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/test=
ing/selftests/resctrl/resctrl_val.c
> > index 5a49f07a6c85..d572815436f3 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_val.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> > @@ -62,6 +62,7 @@ struct imc_counter_config {
> >  static char mbm_total_path[1024];
> >  static int imcs;
> >  static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
> > +const struct resctrl_test *current_test;
>=20
> static const struct
>=20
> >  void membw_initialize_perf_event_attr(int i, int j)
> >  {
> > @@ -472,7 +473,7 @@ void ctrlc_handler(int signum, siginfo_t *info, voi=
d *ptr)
> >  =09if (bm_pid)
> >  =09=09kill(bm_pid, SIGKILL);
> >  =09umount_resctrlfs();
> > -=09tests_cleanup();
> > +=09current_test->cleanup();
>=20
> These calls should have if (current_test->cleanup()) guard. Isn't the=20

Err, if (current_test->cleanup) is what I meant.

> non-contiguous already test w/o the cleanup function?
>=20
> Other than those two, this looked okay.

--=20
 i.

--8323328-2000140883-1708596830=:1961--

