Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72757E01E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 12:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjKCKjl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 06:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376757AbjKCKjk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 06:39:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FD218B;
        Fri,  3 Nov 2023 03:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699007974; x=1730543974;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pFHlGkyiDnxJZ/LgspwIqtkRXIpMKLRmkTFHZhCz9ss=;
  b=hc+itJdFF+nvOKv93aQQ7T05v8Vjiu/ir+2355495eq+16cn/szZfXlk
   dGSHIPfRXwBbFc0bIM2Ub/xxR+sV5R7JzId3F/9jppEtDS4UrfcxTfUZs
   LnnQRR4RFfF7eilEuess+rxi2nsmnSLhgRN7JzW180L8S8nxeaCc5sXzD
   1zwErwPrliFVZC4ATOwaTJNwxHV990OK6BWRfDj9Ojfsc0gPk/DJ3du6F
   Lxuu90S/VVK026zkJfXQ90r6ALf6K/xSysUWReDTp3p14XNuOWgsc+ERh
   2sEqMcXk377aPRnp6TZP0kvHR0hYE/Y5JddcjriAD6v1Tgt+sFq0bt7FY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373962988"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="373962988"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 03:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="738043985"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="738043985"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.35.38])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 03:39:31 -0700
Date:   Fri, 3 Nov 2023 12:39:29 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 23/24] selftests/resctrl: Add L2 CAT test
In-Reply-To: <8051f3ef-1126-41fb-b6cc-f48441936dd7@intel.com>
Message-ID: <2514e73e-2419-7c88-3f22-469db4b2fa25@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com> <8051f3ef-1126-41fb-b6cc-f48441936dd7@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-33433376-1699007973=:1725"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-33433376-1699007973=:1725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Nov 2023, Reinette Chatre wrote:
> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:

> > Add L2 CAT selftest. As measuring L2 misses is not easily available
> > with perf, use L3 accesses as a proxy for L2 CAT working or not.
> 
> I understand the exact measurement is not available but I do notice some
> L2 related symbolic counters when I run "perf list". l2_rqsts.all_demand_miss
> looks promising.

Okay, I was under impression that L2 misses are not available. Both based 
on what you mentioned to me half an year ago and because of what flags I 
found from the header. But I'll take another look into it.

> L3 cannot be relied on for those systems, like Apollo lake, that do
> not have an L3.

Do you happen know what perf will report for such CPUs, will it return 
L2 as LLC?

> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/cat_test.c    | 68 +++++++++++++++++--
> >  tools/testing/selftests/resctrl/resctrl.h     |  1 +
> >  .../testing/selftests/resctrl/resctrl_tests.c |  1 +
> >  3 files changed, 63 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> > index 48a96acd9e31..a9c72022bb5a 100644
> > --- a/tools/testing/selftests/resctrl/cat_test.c
> > +++ b/tools/testing/selftests/resctrl/cat_test.c
> > @@ -131,8 +131,47 @@ void cat_test_cleanup(void)
> >  	remove(RESULT_FILE_NAME);
> >  }
> >  
> > +/*
> > + * L2 CAT test measures L2 misses indirectly using L3 accesses as a proxy
> > + * because perf cannot directly provide the number of L2 misses (there are
> > + * only platform specific ways to get the number of L2 misses).
> > + *
> > + * This function sets up L3 CAT to reduce noise from other processes during
> > + * L2 CAT test.
> 
> This motivation is not clear to me. Does the same isolation used during 
> L3 CAT testing not work? I expected it to follow the same idea with the 
> L2 cache split in two, the test using one part and the rest of the 
> system using the other. Is that not enough isolation?

Isolation for L2 is done very same way as with L3 and I think it itself 
works just fine.

However, because L2 CAT selftest as is measures L3 accesses that in ideal 
world equals to L2 misses, isolating selftest related L3 accesses from the 
rest of the system should reduce noise in the # of L3 accesses. It's not 
mandatory though so if L3 CAT is not available the function just prints a 
warning about the potential noise and does setup nothing for L3.

But I'll see if I can make it use L2 misses directly so this wouldn't 
matter.

-- 
 i.

--8323329-33433376-1699007973=:1725--
