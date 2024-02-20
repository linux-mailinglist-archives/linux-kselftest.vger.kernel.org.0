Return-Path: <linux-kselftest+bounces-5036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C26685BEAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 15:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41C61F22E73
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197F46A8D4;
	Tue, 20 Feb 2024 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiUIugk8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671D86BB20;
	Tue, 20 Feb 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438904; cv=none; b=I8p0bI7ydx5rOoelJg9iZzfu7Fr4c6Lrix0vwGeGoyXVYmAjh3BH7V7fUMDElrpRaMAFH/QYBy3pw4DOjNQcMokzN1Bp3qrinkPfSFl3DmUOBAEt4a6RFw+AVqLSZFQtuwsGx03uL4GYL6zHfO2zTg2BQRdzUsZXti1Tq+g0jjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438904; c=relaxed/simple;
	bh=IEAY6VUhThvzKY+JFc2CbN1IsBoT7b3cE4kxZSwzYjQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L+ZuFaOzvvIK5cSDowYa9+TQVcwHcjVqSTIDhDbuaqT/w/liXgRTMr13fzhztmmZX/RHI7PTTSS9InLE1IEUhnifNnsQEcROt+UoPJtBxO02npgJkO+9enNKSNfU+zaXuO8EbnMmNVUBWGpmxLjIpCIhJ8Gig1C0kd9lfr+doZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiUIugk8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708438902; x=1739974902;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IEAY6VUhThvzKY+JFc2CbN1IsBoT7b3cE4kxZSwzYjQ=;
  b=SiUIugk8544FOnuwqJGghL5UzOx7fV3P4xb+xhAIFngxgJaT5fmA9+Av
   E6kzEzJfZdmd1RbAMKVxOfS2KT6cBIPuE2WncmoN6U9A15o2+46gsR8k+
   lR4swWfe3VDQ5w+PxZZA5PcbKmU8xjFbyIp5OHsdLEV5nE/w+88fjOgs4
   2ZhNPq/pTOWwFf1uWrfctqzlTPJDc8qu0tFootDkxHThTb7LaY9EelTae
   F75wm4N4zBKMmBNyXyWuyt8dJmvVXGrhp94dx9p/M7X3X57BrBfwgqJH6
   TPHR+AYoKpm/h7D5t2J4XhRsDwPvBt9cgDPDFC3TJiC1ggn1JE+Hx1ci5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13168008"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13168008"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:21:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4834420"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.21])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:21:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Feb 2024 16:21:32 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/resctrl: Simplify cleanup in ctrl-c
 handler
In-Reply-To: <uck6k4upde5642uarjjyoeyt76ju7f3ympqbnugnv3ufaw65k2@wdh2chxqsooo>
Message-ID: <b7b1aace-66f2-ece8-f8ba-7e323e04fa70@linux.intel.com>
References: <cover.1708434017.git.maciej.wieczor-retman@intel.com> <8c4fcfb6b4e38a0f0e400be88ecf1af0d20e12e7.1708434017.git.maciej.wieczor-retman@intel.com> <5f251bcd-a343-bb6e-a947-7605dc59f9ea@linux.intel.com>
 <uck6k4upde5642uarjjyoeyt76ju7f3ympqbnugnv3ufaw65k2@wdh2chxqsooo>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1414670152-1708438892=:1099"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1414670152-1708438892=:1099
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 20 Feb 2024, Maciej Wieczor-Retman wrote:

> On 2024-02-20 at 15:45:23 +0200, Ilpo J=E4rvinen wrote:
> >On Tue, 20 Feb 2024, Maciej Wieczor-Retman wrote:
> >
> >> Ctrl-c handler isn't aware of what test is currently running. Because =
of
> >> that it executes all cleanups even if they aren't necessary. Since the
> >> ctrl-c handler uses the sigaction system no parameters can be passed
> >> to it as function arguments.
> >>=20
> >> Add a global variable to make ctrl-c handler aware of the currently ru=
n
> >> test and only execute the correct cleanup callback.
> >>=20
> >> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> >> ---
> >>  tools/testing/selftests/resctrl/resctrl.h     |  2 ++
> >>  .../testing/selftests/resctrl/resctrl_tests.c | 20 +++++++++---------=
-
> >>  tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
> >>  3 files changed, 13 insertions(+), 11 deletions(-)
> >>=20
> >> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing=
/selftests/resctrl/resctrl.h
> >> index 0f49df4961ea..79b45cbeb628 100644
> >> --- a/tools/testing/selftests/resctrl/resctrl.h
> >> +++ b/tools/testing/selftests/resctrl/resctrl.h
> >> @@ -128,6 +128,8 @@ extern pid_t bm_pid, ppid;
> >> =20
> >>  extern char llc_occup_path[1024];
> >> =20
> >> +extern struct resctrl_test current_test;
> >
> >Why this is not just a pointer?
>=20
> I tried making this as a pointer but the 'test' in test_prepare() is of t=
ype
> 'const struct resctrl_test *' and there are warnings about dropping the c=
onst
> modifier.

Why cannot the pointer be const too? The signal handler is not supposed to=
=20
modify the contents of the resctrl_test struct.

There are two types of constness in C. One (the most commonly used one)=20
relates to immutability of the contents of the struct the pointer (or char=
=20
*) points to while the other enforces the pointer itself to remain=20
immutable. Usually, the former is what is useful and it's what you get=20
when you naturally write "const struct".

> >> +=09current_test =3D *test;
> >
> >I'd prefer to keep this internal to signal handling functions so that=20
> >either the struct resctrl_test or just the cleanup handler is passed=20
> >to signal_handler_register().
>=20
> Okay, would moving this assignment to signal_handler_register() be okay t=
hen?

Yes, that's what I'm after here. Lets keep it internal to the signal=20
handling code.

--=20
 i.

--8323328-1414670152-1708438892=:1099--

