Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD87E1D89
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjKFJxO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 04:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFJxN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 04:53:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B9A3;
        Mon,  6 Nov 2023 01:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699264390; x=1730800390;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=w08lRPNH6ZK1k76vPMfOyD8BbdFJ5Jy/OeoxGWaGkCw=;
  b=T4OC7uAcjwMMnWpr+2PjiWxQcWnN3vfesVvl7rBwTr9sfj2zlcZb99AM
   EEBCMGgzpxXnWiNsxEJWyz9Zmkmi6uLjpXr2Nyrl7seUTxwWRZcv6W2Cv
   qDKVbTAyyTwwZhW4gM+4ZwWSBUYFhxCB7NC0IiU4gXB1ZHxfcnmJrbAAK
   XJUS1IEX16Q1d890FIa7XVejsR9xPS2nFMo4lBvUM9GavMJSt8Xj2x10T
   MK6MNYcaQK3PrAyjeDYA3MzZCaD46yi3FyghkIOHQYNDiAtMFLAwSkqdf
   EjRYoBcLDbasAzdpv+KyXPce/I0WusEFhq+tYPWIEKBbJpttxQt+TfLOb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="379633093"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="379633093"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="879377743"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="879377743"
Received: from rmstoi-mobl.ger.corp.intel.com ([10.251.216.76])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:53:07 -0800
Date:   Mon, 6 Nov 2023 11:53:04 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 23/24] selftests/resctrl: Add L2 CAT test
In-Reply-To: <48c6795b-554a-4019-bb8d-a2ca0f6fbb2b@intel.com>
Message-ID: <4008929-d12b-793e-dce8-eb5ba03b4ebb@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com> <8051f3ef-1126-41fb-b6cc-f48441936dd7@intel.com> <2514e73e-2419-7c88-3f22-469db4b2fa25@linux.intel.com>
 <48c6795b-554a-4019-bb8d-a2ca0f6fbb2b@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-237017318-1699263426=:1852"
Content-ID: <d9d4c84-4d6-e036-f13b-d62c8991be1e@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-237017318-1699263426=:1852
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <d5a4ace7-ae8a-bfb1-293a-1c1f89c71662@linux.intel.com>

On Fri, 3 Nov 2023, Reinette Chatre wrote:
> On 11/3/2023 3:39 AM, Ilpo Järvinen wrote:
> > On Thu, 2 Nov 2023, Reinette Chatre wrote:
> >> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> > 
> >>> Add L2 CAT selftest. As measuring L2 misses is not easily available
> >>> with perf, use L3 accesses as a proxy for L2 CAT working or not.
> >>
> >> I understand the exact measurement is not available but I do notice some
> >> L2 related symbolic counters when I run "perf list". l2_rqsts.all_demand_miss
> >> looks promising.
> > 
> > Okay, I was under impression that L2 misses are not available. Both based 
> > on what you mentioned to me half an year ago and because of what flags I 
> > found from the header. But I'll take another look into it.
> 
> You are correct that when I did L2 testing a long time ago I used
> the model specific L2 miss counts. I was hoping that things have improved
> so that model specific counters are not needed, as you have tried here.
> I found the l2_rqsts symbol while looking for alternatives but I am not
> familiar enough with perf to know how these symbolic names are mapped.
> I was hoping that they could be a simple drop-in replacement to
> experiment with.

According to perf_event_open() manpage, mapping those symbolic names 
requires libpfm so this would add a library dependency?

> >>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >>> ---
> >>>  tools/testing/selftests/resctrl/cat_test.c    | 68 +++++++++++++++++--
> >>>  tools/testing/selftests/resctrl/resctrl.h     |  1 +
> >>>  .../testing/selftests/resctrl/resctrl_tests.c |  1 +
> >>>  3 files changed, 63 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> >>> index 48a96acd9e31..a9c72022bb5a 100644
> >>> --- a/tools/testing/selftests/resctrl/cat_test.c
> >>> +++ b/tools/testing/selftests/resctrl/cat_test.c
> >>> @@ -131,8 +131,47 @@ void cat_test_cleanup(void)
> >>>  	remove(RESULT_FILE_NAME);
> >>>  }
> >>>  
> >>> +/*
> >>> + * L2 CAT test measures L2 misses indirectly using L3 accesses as a proxy
> >>> + * because perf cannot directly provide the number of L2 misses (there are
> >>> + * only platform specific ways to get the number of L2 misses).
> >>> + *
> >>> + * This function sets up L3 CAT to reduce noise from other processes during
> >>> + * L2 CAT test.
> >>
> >> This motivation is not clear to me. Does the same isolation used during 
> >> L3 CAT testing not work? I expected it to follow the same idea with the 
> >> L2 cache split in two, the test using one part and the rest of the 
> >> system using the other. Is that not enough isolation?
> > 
> > Isolation for L2 is done very same way as with L3 and I think it itself 
> > works just fine.
> > 
> > However, because L2 CAT selftest as is measures L3 accesses that in ideal 
> > world equals to L2 misses, isolating selftest related L3 accesses from the 
> > rest of the system should reduce noise in the # of L3 accesses. It's not 
> > mandatory though so if L3 CAT is not available the function just prints a 
> > warning about the potential noise and does setup nothing for L3.
> 
> This is not clear to me. If the read misses L2 and then accesses L3 then
> it should not matter which part of L3 cache the work is isolated to. 
> What noise do you have in mind?

The way it is currently done is to measure L3 accesses. If something else 
runs at the same time as the CAT selftest, it can do mem accesses that 
cause L3 accesses which is noise in the # of L3 accesses number since 
those accesses were unrelated to the L2 CAT selftest.

-- 
 i.
--8323329-237017318-1699263426=:1852--
