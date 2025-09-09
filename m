Return-Path: <linux-kselftest+bounces-41022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EBEB4A478
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586C53B34E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BBC243964;
	Tue,  9 Sep 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtMLFa8C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A324338F;
	Tue,  9 Sep 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405059; cv=none; b=T1byt788xBTciSXfd9RP8rK+hyZeEp16ALpWhgDkHc3x4AfhDOsIVDYLQkSkbcszZmmx/9DZPg9I1qUoyx8LK189Hz1PMSsQpSuC3307VvF6nxLmcTlUjbEckPZGKPYcFG2OAMaW4XD0cZO1EKHZf0nRaM9o8BDuoPWmV6e6NRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405059; c=relaxed/simple;
	bh=hheBO53S4cuD1hHV8+7z+fXYLzy/l5AiYW98zwt2iWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmGpjQXDMuaV5Pcu63L9tedLRSUS9mYw5zmVsUjtIs8FVQG2IZ8xULCb+kl4e/OW4ibGsibPcnxHTouW7g3PyFf2ZaTrOyTOpArz9CfnFxyPyridtcVmhv9VmTfWUA1r0X6ZrqQwsU8NdeFQbLcqe/Q+obNUEqONYiXSAERk/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtMLFa8C; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757405058; x=1788941058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hheBO53S4cuD1hHV8+7z+fXYLzy/l5AiYW98zwt2iWs=;
  b=BtMLFa8CxWte7EPEJYDSl4Uu4ie9Z9gzq7hGc/NXlZxpnUhewBEGr/11
   eHgNr1P4y5Eu+A97EdAUev0bYOSo4Suyi1b6fqbfn7WXmqF93LNewtam/
   ZiTJOUHpfrTK18pWCM56fu4815lECI+W6Ynd/Oon6/oWUWG7OdFNmAzd8
   vgu5JTt+AA+i4ev125ziglSSjeVM1xtR/S5Y5TrR52YaQ4YIQtGTJSq9B
   9CqGZaNEySLgcfadhhtoptzZdBlg2h1uleYHa3RSjmH49iABctMZIwbgu
   tGOCt0fNKWByloz/6jTfBPiSw8mlgZdV6BWYxucJgmdpxG/cdvyn/yU/R
   Q==;
X-CSE-ConnectionGUID: uJj9OkJMQtyXS/R0SyqiVg==
X-CSE-MsgGUID: VPoqZVzjT2u+FEV8j9uwfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="62306729"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="62306729"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 01:04:17 -0700
X-CSE-ConnectionGUID: aUhvH03JTpa8sKMWBcGqIQ==
X-CSE-MsgGUID: PJIE3vMoSSis6CmgX1wFjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="196683482"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.53])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 01:04:14 -0700
Date: Tue, 9 Sep 2025 16:04:11 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Yi Lai <yi1.lai@intel.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org, wad@chromium.org,
	luto@amacapital.net, kees@kernel.org, usama.anjum@collabora.com
Subject: Re: [PATCH] selftests/kselftest_harness: Add
 harness-selftest.expected to TEST_FILES
Message-ID: <aL/fe6xsyZCrJKIP@ly-workstation>
References: <20250815091032.802171-1-yi1.lai@intel.com>
 <20250815112711-473df6c4-d0d4-452f-9411-b72491adf2af@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815112711-473df6c4-d0d4-452f-9411-b72491adf2af@linutronix.de>

On Fri, Aug 15, 2025 at 11:28:40AM +0200, Thomas Weiﬂschuh wrote:
> On Fri, Aug 15, 2025 at 05:10:32PM +0800, Yi Lai wrote:
> > The harness-selftest.expected is not installed in INSTALL_PATH.
> > Attempting to execute harness-selftest.sh shows warning:
> > 
> > diff: ./kselftest_harness/harness-selftest.expected: No such file or
> > directory
> > 
> > Add harness-selftest.expected to TEST_FILES.
> > 
> > Signed-off-by: Yi Lai <yi1.lai@intel.com>
> 
> Fixes: df82ffc5a3c1 ("selftests: harness: Add kselftest harness selftest")
> Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Thanks!
>

Sorry for the late response. Thank you for review. I will send a v2
patch containing the fixes tag.

Regards,
Yi Lai

> > ---
> >  tools/testing/selftests/kselftest_harness/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/testing/selftests/kselftest_harness/Makefile b/tools/testing/selftests/kselftest_harness/Makefile
> > index 0617535a6ce4..d2369c01701a 100644
> > --- a/tools/testing/selftests/kselftest_harness/Makefile
> > +++ b/tools/testing/selftests/kselftest_harness/Makefile
> > @@ -2,6 +2,7 @@
> >  
> >  TEST_GEN_PROGS_EXTENDED := harness-selftest
> >  TEST_PROGS := harness-selftest.sh
> > +TEST_FILES := harness-selftest.expected
> >  EXTRA_CLEAN := harness-selftest.seen
> >  
> >  include ../lib.mk
> > -- 
> > 2.43.0
> > 

