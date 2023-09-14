Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB847A0B37
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 19:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjINRFs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 13:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjINRFr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 13:05:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA801FE1;
        Thu, 14 Sep 2023 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694711143; x=1726247143;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tUD1/z6POA3IUtdx5XVzuwR95oUWZZa4NLHp9FWHlmg=;
  b=YFqSbA3zGe4A/P3zZ0C0Z1h8S0GA8lrUpOU2v8GbDN6ICTAibRpPlVPB
   WlsFuWqGQqmSpKh2KePaa9nmaQj0G1NTKecxEtANkTPsOStzxM9Mkqo3M
   4yTstizEJk3T/yu9a3G0eXxrwBEf7d5YGa4SvsdWw5ziDJkLq7hc9T4DT
   +1BSFZoSTnc1i0dgDjJJXjg3U8ib2TCKPfDfw/tVHpwn7LJiOJ6I0HBrD
   zhsqMsjri6PmuAj79wNhP8Ehr1r4Dfg1hmonOTYtQZNBok2dbU5CeqzHx
   W4tYjGZg0HBEmjYsw0SldI5vdNvBKC/JWaiD2puqmSOY6ELUftq2i3Ty3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369315210"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="369315210"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="773950069"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="773950069"
Received: from skolhe-mobl1.ger.corp.intel.com ([10.252.36.254])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:05:07 -0700
Date:   Thu, 14 Sep 2023 20:05:05 +0300 (EEST)
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
Subject: Re: [PATCH 1/5] selftests/resctrl: Extend signal handler coverage
 to unmount on receiving signal
In-Reply-To: <b32f4bd1-9e99-3daa-9d39-8f241b41170c@intel.com>
Message-ID: <52478b0-15e6-9072-df34-612ec0ebfa@linux.intel.com>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com> <20230911111930.16088-2-ilpo.jarvinen@linux.intel.com> <4176a620-4cec-5d57-42a3-a15c0fe3eb73@intel.com> <aab4b1cc-6eb5-c324-e97e-c6699e2d165@linux.intel.com> <d6cc3829-9b7d-6a0b-c734-c33f6a66959c@intel.com>
 <9dfe761f-6779-44c6-c227-5175d53ac25@linux.intel.com> <b32f4bd1-9e99-3daa-9d39-8f241b41170c@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-256835453-1694711109=:1814"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-256835453-1694711109=:1814
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 Sep 2023, Reinette Chatre wrote:
> On 9/14/2023 3:16 AM, Ilpo Järvinen wrote:
> > On Wed, 13 Sep 2023, Reinette Chatre wrote:
> >> On 9/13/2023 3:01 AM, Ilpo Järvinen wrote:
> >>> On Tue, 12 Sep 2023, Reinette Chatre wrote:
> >>>> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
> >>>>> Unmounting resctrl FS has been moved into the per test functions in
> >>>>> resctrl_tests.c by commit caddc0fbe495 ("selftests/resctrl: Move
> >>>>> resctrl FS mount/umount to higher level"). In case a signal (SIGINT,
> >>>>> SIGTERM, or SIGHUP) is received, the running selftest is aborted by
> >>>>> ctrlc_handler() which then unmounts resctrl fs before exiting. The
> >>>>> current section between signal_handler_register() and
> >>>>> signal_handler_unregister(), however, does not cover the entire
> >>>>> duration when resctrl FS is mounted.
> >>>>>
> >>>>> Move signal_handler_register() and signal_handler_unregister() call
> >>>>> into the test functions in resctrl_tests.c to properly unmount resctrl
> >>>>> fs. Adjust child process kill() call in ctrlc_handler() to only be
> >>>>> invoked if the child was already forked.
> >>>>
> >>>> Thank you for catching this.
> >>>>
> >>>>>
> >>>>> Fixes: caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")
> >>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >>>>> Cc: <stable@vger.kernel.org>
> >>>>> ---
> >>>>>  tools/testing/selftests/resctrl/cat_test.c    |  8 -------
> >>>>>  .../testing/selftests/resctrl/resctrl_tests.c | 24 +++++++++++++++++++
> >>>>>  tools/testing/selftests/resctrl/resctrl_val.c | 22 ++++++++---------
> >>>>>  3 files changed, 34 insertions(+), 20 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> >>>>> index 97b87285ab2a..224ba8544d8a 100644
> >>>>> --- a/tools/testing/selftests/resctrl/cat_test.c
> >>>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
> >>>>> @@ -167,12 +167,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> >>>>>  		strcpy(param.filename, RESULT_FILE_NAME1);
> >>>>>  		param.num_of_runs = 0;
> >>>>>  		param.cpu_no = sibling_cpu_no;
> >>>>> -	} else {
> >>>>> -		ret = signal_handler_register();
> >>>>> -		if (ret) {
> >>>>> -			kill(bm_pid, SIGKILL);
> >>>>> -			goto out;
> >>>>> -		}
> >>>>>  	}
> >>>>>  
> >>>>>  	remove(param.filename);
> >>>>> @@ -209,10 +203,8 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> >>>>>  		}
> >>>>>  		close(pipefd[0]);
> >>>>>  		kill(bm_pid, SIGKILL);
> >>>>> -		signal_handler_unregister();
> >>>>>  	}
> >>>>>  
> >>>>> -out:
> >>>>>  	cat_test_cleanup();
> >>>>>  
> >>>>>  	return ret;
> >>>>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> >>>>> index 823672a20a43..3d66fbdc2df3 100644
> >>>>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> >>>>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> >>>>> @@ -73,8 +73,13 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
> >>>>>  
> >>>>>  	ksft_print_msg("Starting MBM BW change ...\n");
> >>>>>  
> >>>>> +	res = signal_handler_register();
> >>>>> +	if (res)
> >>>>> +		return;
> >>>>> +
> >>>>>  	res = mount_resctrlfs();
> >>>>>  	if (res) {
> >>>>> +		signal_handler_unregister();
> >>>>>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> >>>>>  		return;
> >>>>>  	}
> >>>>> @@ -91,6 +96,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
> >>>>>  
> >>>>>  umount:
> >>>>>  	umount_resctrlfs();
> >>>>> +	signal_handler_unregister();
> >>>>>  }
> >>>>>  
> >>>>>  static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
> >>>>> @@ -99,8 +105,13 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
> >>>>>  
> >>>>>  	ksft_print_msg("Starting MBA Schemata change ...\n");
> >>>>>  
> >>>>> +	res = signal_handler_register();
> >>>>> +	if (res)
> >>>>> +		return;
> >>>>> +
> >>>>>  	res = mount_resctrlfs();
> >>>>>  	if (res) {
> >>>>> +		signal_handler_unregister();
> >>>>>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> >>>>>  		return;
> >>>>>  	}
> >>>>> @@ -115,6 +126,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
> >>>>>  
> >>>>>  umount:
> >>>>>  	umount_resctrlfs();
> >>>>> +	signal_handler_unregister();
> >>>>>  }
> >>>>>  
> >>>>
> >>>> This adds more duplicated code for every test. Have you considered a
> >>>> single test setup function that can be used to mount resctrl FS and setup
> >>>> the signal handler paired with a single test teardown function?
> >>>
> >>> Yes. Consolidating all these is among my not-yet submitted patches.
> >>> I just had to do a backport-friendly Fixes patch first for this.
> >>>
> >>
> >> Could you please help me understand how the duplicate calls are more
> >> backport friendly?
> > 
> > Hi,
> > 
> > It's simply because the refactoring that has to be done to be able to 
> > introduce the generalized test framework is much more invasive and far 
> > reaching than this patch. Essentially, all the call signatures of the test 
> > functions need to match and the feature checks need to be done in new per 
> > test functions too. This is the diffstat of those changes alone:
> > 
> >  tools/testing/selftests/resctrl/cat_test.c      |  21 +++--
> >  tools/testing/selftests/resctrl/cmt_test.c      |  26 +++--
> >  tools/testing/selftests/resctrl/mba_test.c      |  20 +++-
> >  tools/testing/selftests/resctrl/mbm_test.c      |  20 +++-
> >  tools/testing/selftests/resctrl/resctrl.h       |  43 ++++++++-
> >  tools/testing/selftests/resctrl/resctrl_tests.c | 220 +++++++++++++++----------------------------
> >  tools/testing/selftests/resctrl/resctrlfs.c     |   5 +
> > 
> > (tools/testing/selftests/resctrl/resctrl_tests.c --- part would 
> > be slightly less if I'd reorder this patch but that only 24 lines off as 
> > per diffstat of this patch).
> > 
> > But that's not all.... To be able to push the generalized test framework 
> > to stable, you need to also count in the benchmark cmd changes which 
> > worked towards making the call signatures identical. So here's the 
> > diffstat for that series for quick reference:
> > 
> >  tools/testing/selftests/resctrl/cache.c       |   5 +-
> >  tools/testing/selftests/resctrl/cat_test.c    |  13 +--
> >  tools/testing/selftests/resctrl/cmt_test.c    |  34 ++++--
> >  tools/testing/selftests/resctrl/mba_test.c    |   4 +-
> >  tools/testing/selftests/resctrl/mbm_test.c    |   7 +-
> >  tools/testing/selftests/resctrl/resctrl.h     |  16 +--
> >  .../testing/selftests/resctrl/resctrl_tests.c | 100 ++++++++----------
> >  tools/testing/selftests/resctrl/resctrl_val.c |  10 +-
> > 
> > That's ~500 lines changed vs ~50 so it's a magnitude worse and much less 
> > localized.
> > 
> > And rest assured, I did not like introducing the duplicated calls any more 
> > than you do (I did not write the generalized test framework for nothing, 
> > after all) but the way taken in this patch seemed the most reasonable 
> > option under these circumstances.
> > 
> 
> hmmm ... I did not expect that a total refactoring would be needed.
> 
> I was thinking about a change from this:
> 
> 
> 	testX(...) 
> 	{
> 	
> 		res = signal_handler_register();
> 		/* error handling */
> 		res = mount_resctrlfs();
> 		/* error handling */
> 		
> 		/* test */
> 
> 		unmount_resctrlfs();
> 		signal_handler_register();
> 
> 	}
> 
> 
> to this:
> 
> 
> 	int test_setup(...)
> 	{
> 		res = signal_handler_register();
> 		/* error handling */
> 		res = mount_resctrlfs();
> 		/* error handling */
> 	}
> 
> 
> 	void test_cleanup(...)
> 	{
> 		unmount_resctrlfs();
> 		signal_handler_register();
> 	}
> 
> 
> 	testX(...)
> 	{
> 
> 		res = test_setup(..);
> 		/* error handling */
> 
> 		/* test */
> 
> 		test_cleanup();
> 	}
> 
> I expect this to also support the bigger refactoring.

Okay, I'll do so then.

However, having already written the generic run_single_test() function 
that is part of the generic test framework, I definitely don't feel those 
helpers would be that helpful for it. It more feels like they'd make the 
flow less obvious by adding those two extra calls there but that's of 
course matter of taste.


-- 
 i.

--8323329-256835453-1694711109=:1814--
