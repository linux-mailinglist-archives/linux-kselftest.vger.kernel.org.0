Return-Path: <linux-kselftest+bounces-1911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF5812CDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 11:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D472826C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76593BB26;
	Thu, 14 Dec 2023 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bxs93YLM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A796FBD;
	Thu, 14 Dec 2023 02:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702549524; x=1734085524;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y08OL+ZDG+251KCF02UCSALATUKZP/Mzo4boe/OL14E=;
  b=Bxs93YLM0WpOKdGF4coCaGBM0Rr83YLPoBTn5WumC8lCd8sVRIIi49Mb
   dMQcqNs1bkO7YHwNHqnQPuI9kBgcKeBvJFaH1YYZzTdwD2xmI6x/I49p8
   omlCsAeFVCexaXqqqgRKyFyswtYWNZaacETRkNmZ9SIv0T+rrljLOBz8L
   bX0MFa/D+yj0V1f1iXrR38nSkfDUYkhGeiA29/F//lj3m4A+EvWLgkPK5
   EqwBubLZRfGA4/K34UUlsLRHQSLjjJTB/dZKf4dbg1w2X3IkHH7vWjoiO
   5Ybk/cKQl3+QNEhg6xLmPn8Fdh0KasYqt+FZYVAzBc+xSIGGPhk6TUxxj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1918285"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1918285"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:25:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="844655770"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="844655770"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.38])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:25:20 -0800
Date: Thu, 14 Dec 2023 12:25:18 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 23/29] selftests/resctrl: Restore the CPU affinity
 after CAT test
In-Reply-To: <04650d92-fb80-49e2-87b7-4f9dbec922b8@intel.com>
Message-ID: <f4a42eb0-9379-74d-e765-fe37a8aa12d@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com> <20231211121826.14392-24-ilpo.jarvinen@linux.intel.com> <04650d92-fb80-49e2-87b7-4f9dbec922b8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-866747641-1702549522=:5690"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-866747641-1702549522=:5690
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Dec 2023, Reinette Chatre wrote:
> On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> > CAT test does not reset the CPU affinity after the benchmark.
> > This is relatively harmless as is because CAT test is the last
> > benchmark to run, however, more tests may be added later.
> > 
> > Store the CPU affinity the first time taskset_benchmark() is run and
> > add taskset_restore() which the test can call to reset the CPU mask to
> > its original value.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---

> > +/*
> > + * taskset_restore - Taskset PID to the earlier CPU affinity
> > + * @bm_pid:		PID that should be reset
> > + * @old_affinity:	The old CPU affinity to restore
> > + *
> > + * Return: 0 on success, < 0 on error.
> > + */
> > +int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity)
> > +{
> > +	if (sched_setaffinity(bm_pid, sizeof(*old_affinity), old_affinity)) {
> > +		ksft_perror("Unable to restore taskset");
> 
> This message is not clear to me. How about "Unable to restore CPU affinity"?

Okay, I can change that. I actually was on the edge what to with these 
because I was just trying to be consistent with the existing error message 
in taskset_benchmark(). I reasoned that because "taskset" is the userspace 
tool which the user might be familiar the original idea of using 
"taskset" might be helpful.

And now rereading what I wrote in that message, "restore taskset" does not 
sound very sensical grammarwise. :-)

-- 
 i.

--8323329-866747641-1702549522=:5690--

