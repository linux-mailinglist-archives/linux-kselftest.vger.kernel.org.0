Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB47B1CDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 14:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjI1MrM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 08:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjI1MrL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 08:47:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4037019E;
        Thu, 28 Sep 2023 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695905229; x=1727441229;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Byl01cFrQx9oQOYesoBsrY936BxPxrlv+/gmqrA8pro=;
  b=A2gvs3pp8XJr4OzyOrTTsJgs9NvhXalGOdoznjfk2Mri5Xze7bDtzueh
   SWFRBvK7IxG5eXI/wz+dJlwiL4+I0mimtSlpVntqdqciGU+kM6Om9H8Ih
   6F1XcFDDcrKOFsoTvRLpowTFzkADZhvNnQnAbR9tSleNURENdKvCZcQsX
   wNijT2UWvUAxjjHk6hwNadjJUyKTHPqEt365d9jCX4UjKmPwAsDtDZ06U
   WC6x5r1J1HZN/2x298t3/5uMJnIOZ70ZCoCbFzmaTl6zkveZTIz9bVgcy
   lh+CYDd1ViGPli8HberYTyNexOZOiGuC8jygPkDSVMfisCg9kt3ygJ1rL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="372404717"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="372404717"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 05:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="752949843"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="752949843"
Received: from vshampor-mobl2.ger.corp.intel.com ([10.249.33.15])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 05:47:05 -0700
Date:   Thu, 28 Sep 2023 15:47:03 +0300 (EEST)
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
Subject: Re: [PATCH v2 1/6] selftests/resctrl: Extend signal handler coverage
 to unmount on receiving signal
In-Reply-To: <d2d94def-742d-7661-3632-b9f7e4996415@intel.com>
Message-ID: <19f893e4-45e3-4e8f-c22-13241d5ff467@linux.intel.com>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com> <20230915154438.82931-2-ilpo.jarvinen@linux.intel.com> <d2d94def-742d-7661-3632-b9f7e4996415@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-677402910-1695905227=:1701"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-677402910-1695905227=:1701
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 26 Sep 2023, Reinette Chatre wrote:
> On 9/15/2023 8:44 AM, Ilpo Järvinen wrote:
> > Unmounting resctrl FS has been moved into the per test functions in
> > resctrl_tests.c by commit caddc0fbe495 ("selftests/resctrl: Move
> > resctrl FS mount/umount to higher level"). In case a signal (SIGINT,
> > SIGTERM, or SIGHUP) is received, the running selftest is aborted by
> > ctrlc_handler() which then unmounts resctrl fs before exiting. The
> > current section between signal_handler_register() and
> > signal_handler_unregister(), however, does not cover the entire
> > duration when resctrl FS is mounted.
> > 
> > Move signal_handler_register() and signal_handler_unregister() calls
> > from per test files into resctrl_tests.c to properly unmount resctrl
> > fs. In order to not add signal_handler_register()/unregister() n times,
> > create helpers test_prepare() and test_cleanup().
> > 
> > Adjust child process kill() call in ctrlc_handler() to only be invoked
> > if the child was already forked.
> > 
> > Fixes: caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  tools/testing/selftests/resctrl/cat_test.c    |  8 ---
> >  .../testing/selftests/resctrl/resctrl_tests.c | 65 +++++++++++--------
> >  tools/testing/selftests/resctrl/resctrl_val.c | 22 +++----
> >  3 files changed, 48 insertions(+), 47 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> > index 97b87285ab2a..224ba8544d8a 100644
> > --- a/tools/testing/selftests/resctrl/cat_test.c
> > +++ b/tools/testing/selftests/resctrl/cat_test.c
> > @@ -167,12 +167,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> >  		strcpy(param.filename, RESULT_FILE_NAME1);
> >  		param.num_of_runs = 0;
> >  		param.cpu_no = sibling_cpu_no;
> > -	} else {
> > -		ret = signal_handler_register();
> > -		if (ret) {
> > -			kill(bm_pid, SIGKILL);
> > -			goto out;
> > -		}
> >  	}
> >  
> >  	remove(param.filename);
> > @@ -209,10 +203,8 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> >  		}
> >  		close(pipefd[0]);
> >  		kill(bm_pid, SIGKILL);
> > -		signal_handler_unregister();
> >  	}
> >  
> > -out:
> >  	cat_test_cleanup();
> >  
> >  	return ret;
> > diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> > index 823672a20a43..524ba83d7568 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> > @@ -67,21 +67,41 @@ void tests_cleanup(void)
> >  	cat_test_cleanup();
> >  }
> >  
> > -static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
> > +static int test_prepare()
> >  {
> >  	int res;
> >  
> > -	ksft_print_msg("Starting MBM BW change ...\n");
> > +	res = signal_handler_register();
> > +	if (res)
> > +		return res;
> >  	res = mount_resctrlfs();
> >  	if (res) {
> > +		signal_handler_unregister();
> >  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> > -		return;
> > +		return res;
> >  	}
> > +	return 0;
> > +}
> > +
> > +static void test_cleanup()
> > +{
> > +	umount_resctrlfs();
> > +	signal_handler_unregister();
> > +}
> 
> Thank you for adding these.
> 
> > +
> > +static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
> > +{
> > +	int res;
> > +
> > +	ksft_print_msg("Starting MBM BW change ...\n");
> > +
> > +	if (test_prepare())
> > +		return;
> >  
> 
> I am not sure about this. With this exit the kselftest machinery is not
> aware of the test passing or failing. I wonder if there should not rather
> be a "goto" here that triggers ksft_test_result()?

Yes, ksft_test_result() is needed here (I forgot to add it).

> This needs some more 
> thought though. First, with this change test_prepare() officially gains
> responsibility to determine if a failure is transient (just a single test
> fails) or permanent (no use trying any other tests if this fails). For
> the former it would then be up to the caller to call ksft_test_result()
> and for the latter test_prepare() will call ksft_exit_fail_msg().

Well, I didn't initially have test_prepare() at all but all this was 
within the test functions (which will be consolidated to a single function 
by the series that comes after the two series are done + one patch from 
Maciej).

I was just trying to do what was done previously but it seems I forgot to 
handle the result status on signal reg fail path.

TBH, I wouldn't mind if also the signal reg fail is just up'ed to 
ksft_exit_fail_msg(). I don't think it can ever fail with the parameters 
given to it so its error handling feels pretty much dead-code (unless some 
crazy thing such as apparmor does something out of the blue, I don't know 
if apparmor has capability override sigaction() but I've seen apparmor to
create errors that from the surface make no sense whatsoever comparable
to this case).

So basically this discussion is now about what to do with the mount 
failing which already does _exit() before this patch (and possibly some
hypotethical, new prepare code after the consolidation work which also
will have some impact and I believe we might actually want to kill 
test_prepare() at that point anyway).

> Second, that SNC warning may be an inconvenience with a new goto. Here
> it may be ok to print that message before the test failure?

I don't follow what you're referring to with "that SNC warning". To the 
"Intel CMT may be inaccurate ..." one?

> >  	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
> >  		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
> > -		goto umount;
> > +		goto cleanup;
> >  	}
> >  
> >  	res = mbm_bw_change(cpu_no, benchmark_cmd);
> > @@ -89,8 +109,8 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
> >  	if ((get_vendor() == ARCH_INTEL) && res)
> >  		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> >  
> > -umount:
> > -	umount_resctrlfs();
> > +cleanup:
> > +	test_cleanup();
> >  }
> >  
> >  static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
> > @@ -99,22 +119,19 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
> >  
> >  	ksft_print_msg("Starting MBA Schemata change ...\n");
> >  
> > -	res = mount_resctrlfs();
> > -	if (res) {
> > -		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> > +	if (test_prepare())
> >  		return;
> > -	}
> >  
> >  	if (!validate_resctrl_feature_request(MBA_STR) || (get_vendor() != ARCH_INTEL)) {
> >  		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
> > -		goto umount;
> > +		goto cleanup;
> >  	}
> >  
> >  	res = mba_schemata_change(cpu_no, benchmark_cmd);
> >  	ksft_test_result(!res, "MBA: schemata change\n");
> >  
> > -umount:
> > -	umount_resctrlfs();
> > +cleanup:
> > +	test_cleanup();
> >  }
> >  
> >  static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
> > @@ -123,15 +140,12 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
> >  
> >  	ksft_print_msg("Starting CMT test ...\n");
> >  
> > -	res = mount_resctrlfs();
> > -	if (res) {
> > -		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> > +	if (test_prepare())
> >  		return;
> > -	}
> >  
> >  	if (!validate_resctrl_feature_request(CMT_STR)) {
> >  		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
> > -		goto umount;
> > +		goto cleanup;
> >  	}
> >  
> >  	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
> > @@ -139,8 +153,8 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
> >  	if ((get_vendor() == ARCH_INTEL) && res)
> >  		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> >  
> > -umount:
> > -	umount_resctrlfs();
> > +cleanup:
> > +	test_cleanup();
> >  }
> >  
> >  static void run_cat_test(int cpu_no, int no_of_bits)
> > @@ -149,22 +163,19 @@ static void run_cat_test(int cpu_no, int no_of_bits)
> >  
> >  	ksft_print_msg("Starting CAT test ...\n");
> >  
> > -	res = mount_resctrlfs();
> > -	if (res) {
> > -		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> > +	if (test_prepare())
> >  		return;
> > -	}
> >  
> >  	if (!validate_resctrl_feature_request(CAT_STR)) {
> >  		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
> > -		goto umount;
> > +		goto cleanup;
> >  	}
> >  
> >  	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
> >  	ksft_test_result(!res, "CAT: test\n");
> >  
> > -umount:
> > -	umount_resctrlfs();
> > +cleanup:
> > +	test_cleanup();
> >  }
> >  
> >  int main(int argc, char **argv)
> > diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> > index 51963a6f2186..a9fe61133119 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_val.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> > @@ -468,7 +468,9 @@ pid_t bm_pid, ppid;
> >  
> >  void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
> >  {
> > -	kill(bm_pid, SIGKILL);
> > +	/* Only kill child after bm_pid is set after fork() */
> > +	if (bm_pid)
> > +		kill(bm_pid, SIGKILL);
> >  	umount_resctrlfs();
> >  	tests_cleanup();
> >  	ksft_print_msg("Ending\n\n");
> > @@ -485,6 +487,8 @@ int signal_handler_register(void)
> >  	struct sigaction sigact;
> >  	int ret = 0;
> >  
> > +	bm_pid = 0;
> > +
> 
> Since this is an initialization fix in this area ... what
> do you think of also initializing sigact? It could just be
> a change to
> 	struct sigaction sigact = {};
> 
> This will prevent registering a signal handler with 
> uninitialized sa_flags.

Nice catch. It seems quite bad bug, I'll add another patch to fix it.

Thanks once again for your reviews! I'll also address the changelog 
improvements you mentioned against the other patches.


-- 
 i.

--8323329-677402910-1695905227=:1701--
