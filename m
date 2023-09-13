Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E1279E70A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 13:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbjIMLnu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 07:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjIMLnu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 07:43:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DAA10E6;
        Wed, 13 Sep 2023 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694605425; x=1726141425;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Eixnt6GAsbzJFCJyQ84xwHsyzH00SfvTGFmYTKJDaE4=;
  b=POjNE/ro1IrKARrKn4T8xLidWMg23qRCg/iOU3W+STwJh56NXPXSOL5v
   7d6KtnLHzJ4vUUqam2w0PdQooQpvk3+ISo1noT0DZBLvZNtTFW2fAMcwb
   vbmtcjRa7gJN2EabM4jzhZSV7s7QigBtUJx+EPnejnZScvN6Pe1i9QtoG
   Aq1pqZ4IDBnxCYyDMPYSIhbrLCQ0M80grZozzXWVw4mfxOq8wZEh2xbmg
   njiOFza4eFnmIedXqmjAnpbV0Qk0PQaZkFl2BHR5/Kp2a2lsVw8yzGLvR
   +H1kjJzjPDx9n5av5NoYyWNQICLn6f9MkXwoET/N3PIHADmYXudE6HN2h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="465006384"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="465006384"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:43:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="990885974"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="990885974"
Received: from pakurapo-mobl3.ger.corp.intel.com ([10.249.45.213])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:43:42 -0700
Date:   Wed, 13 Sep 2023 14:43:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 5/5] selftests/resctrl: Reduce failures due to outliers
 in MBA/MBM tests
In-Reply-To: <cf7439c4-f72c-a145-5a65-84ae15c5d96f@intel.com>
Message-ID: <c1518af-cc3c-3aa7-a3c-4bbfe8cc6cd@linux.intel.com>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com> <20230911111930.16088-6-ilpo.jarvinen@linux.intel.com> <cf7439c4-f72c-a145-5a65-84ae15c5d96f@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-407709756-1694605424=:1849"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-407709756-1694605424=:1849
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 12 Sep 2023, Reinette Chatre wrote:
> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
> > 5% difference upper bound for success is a bit on the low side for the
> 
> "a bit on the low side" is very vague.

The commit that introduced that 5% bound plainly admitted it's "randomly 
chosen value". At least that wasn't vague, I guess. :-)

So what I'm trying to do here is to have "randomly chosen value" replaced 
with a value that seems to work well enough based on measurements on 
a large set of platforms.

Personally, I don't care much about this, I can just ignore the failures 
due to outliers (and also reports about failing MBA/MBM test if somebody 
ever sends one to me), but if I'd be one running automated tests it would 
be annoying to have a problem like this unaddressed.

> > MBA and MBM tests. Some platforms produce outliers that are slightly
> > above that, typically 6-7%.
> > 
> > Relaxing the MBA/MBM success bound to 8% removes most of the failures
> > due those frequent outliers.
> 
> This description needs more context on what issue is being solved here.
> What does the % difference represent? How was new percentage determined?
> 
> Did you investigate why there are differences between platforms? From
> what I understand these tests measure memory bandwidth using perf and
> resctrl and then compare the difference. Are there interesting things 
> about the platforms on which the difference is higher than 5%?

Not really I think. The number just isn't that stable to always remain 
below 5% (even if it usually does).

Only systematic thing I've come across is that if I play with the read 
pattern for defeating the hw prefetcher (you've seen a patch earlier and 
it will be among the series I'll send after this one), it has an impact 
which looks more systematic across all MBM/MBA tests. But it's not what 
I'm trying now address with this patch.

> Could
> those be systems with multiple sockets (and thus multiple PMUs that need
> to be setup, reset, and read)? Can the reading of the counters be improved
> instead of relaxing the success criteria? A quick comparison between
> get_mem_bw_imc() and get_mem_bw_resctrl() makes me think that a difference
> is not surprising ... note how the PMU counters are started and reset
> (potentially on multiple sockets) at every iteration while the resctrl
> counters keep rolling and new values are just subtracted from previous.

Perhaps, I can try to look into it (add to my todo list so I won't 
forget). But in the meantime, this new value is picked using a criteria 
that looks better than "randomly chosen value". If I ever manage to 
address the outliers, the bound could be lowered again.

I'll update the changelog to explain things better.


-- 
 i.

--8323329-407709756-1694605424=:1849--
