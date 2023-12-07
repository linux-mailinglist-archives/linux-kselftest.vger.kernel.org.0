Return-Path: <linux-kselftest+bounces-1360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E42D4808B4A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 16:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6031F2122C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0DF44382;
	Thu,  7 Dec 2023 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGxEQcGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B49019A;
	Thu,  7 Dec 2023 07:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701961396; x=1733497396;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oAuqsn7L4saZbJC5M9zu9VGIEPm+2LWdN9ym+6Wxgrc=;
  b=nGxEQcGiV01rG9dvpQZMwh/p7GTkF+o28ipmUr9GhzY1b4E4WBfmjkEy
   TWEWH5SyxWS+ghI6kZrzhgGyv8P5uPZZYUb+Ev+wcyqasX1L2RqfUSAB2
   oYYl4bmrPAej+DJB4j9xnkqfV5E+19DDHTfUyb5gFOvi+rHezn4HjOMXG
   a3YP7WXutNLO/LqZbMLmeqnBXC9wM7QSvoGnwHHulrOFBT8++BkbF5mHJ
   sI7Hci9a38XLD7Ts5NnPa4nf2/BZDXT9I6mAvnLbkI1AUAjVZGelko830
   BN8+36ph4CwV4KcZwV7L2An4tghnkuDjZ2WDwdpxnA2ierCiFhk/NAv9/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="374408758"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="374408758"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 07:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="915609992"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="915609992"
Received: from dkrupnov-mobl3.ger.corp.intel.com ([10.249.34.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 07:03:14 -0800
Date: Thu, 7 Dec 2023 17:03:11 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 17/26] selftests/resctrl: Replace file write with
 volatile variable
In-Reply-To: <6358c720-66a9-4727-a74d-b56100f01ac4@intel.com>
Message-ID: <7e373b7a-3d62-5eb1-c11f-70dd62293b97@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com> <20231120111340.7805-18-ilpo.jarvinen@linux.intel.com> <6358c720-66a9-4727-a74d-b56100f01ac4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1637657272-1701961395=:1765"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1637657272-1701961395=:1765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 28 Nov 2023, Reinette Chatre wrote:
> On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> > The fill_buf code prevents compiler optimizating the entire read loop
> > away by writing the final value of the variable into a file. While it
> > achieves the goal, writing into a file requires significant amount of
> > work within the innermost test loop and also error handling.
> > 
> > A simpler approach is to take advantage of volatile. Writing to a
> > variable through a volatile pointer is enough to prevent compiler from
> > optimizing the write away, and therefore compiler cannot remove the
> > read loop either.
> > 
> > Add a volatile 'value_sink' into resctrl_tests.c and make fill_buf to
> > write into it. As a result, the error handling in fill_buf.c can be
> > simplified.
> > 
> 
> The subject and changelog describes the need for a volatile variable.
> The patch introduces two volatile variables. Could you please elaborate
> why two volatile variables are needed?

Well, the other "volatile variable" is a pointer to a volatile variable.

I've seen gcc to kill a static volatile int so I prefer to not take 
change with its optimizer. Thus, I placed the sink into different 
compilation unit and just present a pointer to the actual "volatile" 
variable.

I guess the sink could be marked as plain int instead but this being 
trickery to begin with I don't see much value either way. It's still
a trick.

I'll alter the changelog's wording though, "a volatile variable" is
not accurate as it's "a pointer to a volatile variable".

-- 
 i.

--8323329-1637657272-1701961395=:1765--

