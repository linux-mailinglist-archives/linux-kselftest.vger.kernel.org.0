Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1CF6ED0D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjDXO6l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjDXO6l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 10:58:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F89D7680;
        Mon, 24 Apr 2023 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682348320; x=1713884320;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=yDWaktabYWFGQaXIwUoOQB61kNKDGmTqY21HhUuRI5Q=;
  b=iqKeGJxYGnqDUNU8LEj9nAcZKniSTPlhkWLDJqf5e7voTaHYoxETLk9P
   oxh8VXcD/hPN6p2bfXIa/igtyB6MVJOxT2kOQZuXpWf0L4czO0rvVhc2t
   Nowo5ztdtOxRCiKg4BdyDll7T2H1Or1wA6nhSa/PfXu/l+eJabNiTSbh4
   Ycqkj7TeWtU7kThAnM7SSbcsE94GhhnlO6i07S+40i9N/YTNK2qIZ/Wpl
   RtLg/IYtJ3PRCox7hT55reJF/Kvi4RMz8hCIOJvcgZDRq8IssfjF3WVSu
   M6E4trJ7yBfXJjrym30mIc8UW/DSogzeO3q60vgvE0FdFdoVXmGUdm00k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="326082453"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="326082453"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 07:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="693106347"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="693106347"
Received: from wlwpo-8.amr.corp.intel.com ([10.251.215.143])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 07:58:36 -0700
Date:   Mon, 24 Apr 2023 17:58:34 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v2 03/24] selftests/resctrl: Move resctrl FS mount/umount
 to higher level
In-Reply-To: <74cab34d-767c-aa10-807d-3cbab7907ca9@intel.com>
Message-ID: <85166db-cf39-5ddd-ba9c-add78e6144e9@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-4-ilpo.jarvinen@linux.intel.com> <74cab34d-767c-aa10-807d-3cbab7907ca9@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1579805254-1682334295=:2038"
Content-ID: <f4b5cc3-ee69-a0a8-54e-7f93afc47d4b@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1579805254-1682334295=:2038
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <a1e1e5cb-27cc-a359-716-75b3f424e5e8@linux.intel.com>

On Fri, 21 Apr 2023, Reinette Chatre wrote:
> On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> > A few places currently lack umounting resctrl FS on error paths.
> 
> You mention "A few places" (plural). In the patch I do see that
> cmt_resctrl_val() is missing an unmount. Where are the other places?

- cmt_resctrl_val() has multiple error paths with direct return.
- cat_perf_miss_val() has multiple error paths with direct return.

In addition, validate_resctrl_feature_request() is called by 
run_mbm_test() and run_mba_test(). Neither MBA nor MBM test tries to 
umount resctrl FS.

I improved the changelog accordingly.

While doing this, I took a more careful look into how it can result in 
problems and I think the only way is through PARENT_EXIT() because main 
has the umount in the end (and the remounting trickery kinda seems to 
work even if it was hard to track).

Fixing the PARENT_EXIT() problem required yet another change which I add
in v3.

As the only failure I could think of is because of PARENT_EXIT(), I 
removed Fixes tags from this change and put one into the PARENT_EXIT() 
umount fix. So this change will just be part of the move towards more 
tractable resctrl FS handling, not a fix anymore.

In the end, after some reshuffling, I ended up having 5 changes related to
this:

selftests/resctrl: Remove mum_resctrlfs from struct resctrl_val_param
selftests/resctrl: Refactor remount_resctrl(bool mum_resctrlfs) to mount_resctrl()
selftests/resctrl: Move resctrl FS mount/umount to higher level
selftests/resctrl: Unmount resctrl FS before starting the first test
selftests/resctrl: Unmount resctrl FS if child fails to run benchmark

> > diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> > index af71b2141271..426d11189a99 100644
> > --- a/tools/testing/selftests/resctrl/cmt_test.c
> > +++ b/tools/testing/selftests/resctrl/cmt_test.c
> > @@ -86,10 +86,6 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
> >  
> >  	cache_size = 0;
> >  
> > -	ret = remount_resctrlfs(true);
> > -	if (ret)
> > -		return ret;
> > -
> >  	if (!validate_resctrl_feature_request(CMT_STR))
> >  		return -1;
> >  
> > diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> > index 9b9751206e1c..5c9ed52b69f2 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> > @@ -77,9 +77,15 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
> >  
> >  	ksft_print_msg("Starting MBM BW change ...\n");
> >  
> > +	res = remount_resctrlfs(false);
> 
> I think that should be remount_resctrlfs(true).

> Please note that any of  the tests could be 
> run separately from the command line and thus each test need to ensure a clean
> environment, it cannot assume that (a) user space provided it with a 
> clean and/or  unmounted resctrl or (b) that any test was run before it.

I think I got tripped by the level of complexity here and trying to split 
patch to minimal parts. I was somehow thinking that 
remount_resctrlfs(false) would return error if resctrl fs is already 
mounted.

I've now changed this to pass true instead even if the argument is removed 
by the other change.

-- 
 i.
--8323329-1579805254-1682334295=:2038--
