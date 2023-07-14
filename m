Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F031753981
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 13:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbjGNLbJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 07:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjGNLbJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 07:31:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7572D79;
        Fri, 14 Jul 2023 04:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689334268; x=1720870268;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l/yPvUfnmINX3xY/ZzG9EdykIUEiq+kKl0SYFBw42DA=;
  b=YGydPW+rKFW6FbrcEpkSEmV0I1RfePl8cEexJLbI+PINU9azhediT4El
   kzocxbQiqCU1mHgKn0lrI3ZYCGzTXLiSokj0wFCIsiXujAKByGyZoOmEM
   X+tkKjUQDcR3qv0IdHs+VeUsbZBWkbFt8sKk1W+wrWIyueriFJB6gXRRl
   Luvp9VEdKbKYyqKksrvHkupbzicOQl4wNZd53vxy+bd5B3JBp2k89+3bg
   3GrYphaDkKUhvaeNDqmWyLIdyXBXZlTVTuRHOifx7k40e0c/uRqnc7qtk
   VFLA0cWaZaGiE/Z9AOLXOFe9XOLo1ZDWiOqS1IQnr76zkNwiCmN5vWO2q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365490751"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="365490751"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787823746"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="787823746"
Received: from rchauhax-mobl1.gar.corp.intel.com ([10.249.35.123])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:31:05 -0700
Date:   Fri, 14 Jul 2023 14:31:03 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/19] selftests/resctrl: Move resctrl FS mount/umount
 to higher level
In-Reply-To: <59fd7956-caf8-03de-10a5-f37036219134@intel.com>
Message-ID: <07faf1f-cde-9d3c-1f15-bbe494466abf@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com> <20230713131932.133258-7-ilpo.jarvinen@linux.intel.com> <59fd7956-caf8-03de-10a5-f37036219134@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-584909292-1689334267=:1695"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-584909292-1689334267=:1695
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 13 Jul 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> > A few places currently lack umounting resctrl FS on error paths:
> >   - cmt_resctrl_val() has multiple error paths with direct return.
> >   - cat_perf_miss_val() has multiple error paths with direct return.
> > In addition, validate_resctrl_feature_request() is called by
> > run_mbm_test() and run_mba_test(). Neither MBA nor MBM test tries to
> > umount resctrl FS.
> > 
> > Each and every test does require resctrl FS to be present already for
> > feature check. Thus, it makes sense to just mount it on higher level in
> > resctrl_tests.c and properly pair it with umount.
> > 
> > Move resctrl FS (re)mount/unmount into each test function in
> > resctrl_tests.c. Make feature validation to simply check that resctrl
> > FS is mounted.
> > 
> > Fixes: 91db4fd9019a ("selftests/resctrl: Remove duplicate codes that clear each test result file")
> 
> Could you please elaborate how this commit is the culprit?

Of course it isn't. I'm pretty sure I had some idea when that was added 
but it was before the patches were rearranged/modified, maybe I 
incorrectly thought that the cleanup functions do umount (but they don't).

I'll changed it to these:
Fixes: f1dd71982d19 ("selftests/resctrl: Skip the test if requested resctrl feature is not supported")
Fixes: 01fee6b4d1f9 ("selftests/resctrl: Add MBA test")
Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")

...however, I was also considering dropping Fixes completely because 
main() has the final umount() at the end so no lingering resctrl FS after 
tests, and inter-test issues are hard to track due to how complicated the 
code is so I'm not entirely sure if there are real issues under any 
combination of tests and all the mounting/unmounting going on).

-- 
 i.

--8323329-584909292-1689334267=:1695--
