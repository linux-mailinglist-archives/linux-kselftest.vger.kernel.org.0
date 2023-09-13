Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF31479E473
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 12:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjIMKB5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 06:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjIMKB5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 06:01:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BD7198C;
        Wed, 13 Sep 2023 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694599312; x=1726135312;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xWu7IXMLYndESrsIDPkU/w6h/boIoVzFmP3NM90RAfo=;
  b=Um2rC1Ji6IGTOGWUqewqqTTUGo2FiT8Ej2Sm7DZt0NS14NPV1pY//GOS
   ms3XOueA/Cntihiu4wMVWP45IavsqeVWW5SdYFvAyhbma/7j34uNjVscA
   F+G5D7x5cDnEd6FLthzc3zoqukk6WeLT0zlKpW27QWxSiAbQD6ydXRVEP
   D/SvEkGCSn/ryhgGlODsXy2u2c28UakzDNf9U/fmvRPUMvsGa1ia/1yFP
   56GyRqP/WZZ+9FMHS3Ku7iU9ZvNwT8rVagXJK6hnc9dWTWHCy2t2e3Yu7
   lPfGAaOCO4EymUU0qKq/tVWhtpDiRem8wW0fCcKVG4f6qNNV2QFhKLFIb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378529237"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="378529237"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="834247693"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="834247693"
Received: from pakurapo-mobl3.ger.corp.intel.com ([10.249.45.213])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:01:44 -0700
Date:   Wed, 13 Sep 2023 13:01:38 +0300 (EEST)
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
In-Reply-To: <4176a620-4cec-5d57-42a3-a15c0fe3eb73@intel.com>
Message-ID: <aab4b1cc-6eb5-c324-e97e-c6699e2d165@linux.intel.com>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com> <20230911111930.16088-2-ilpo.jarvinen@linux.intel.com> <4176a620-4cec-5d57-42a3-a15c0fe3eb73@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2077064899-1694599306=:1849"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2077064899-1694599306=:1849
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 12 Sep 2023, Reinette Chatre wrote:
> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
> > Unmounting resctrl FS has been moved into the per test functions in
> > resctrl_tests.c by commit caddc0fbe495 ("selftests/resctrl: Move
> > resctrl FS mount/umount to higher level"). In case a signal (SIGINT,
> > SIGTERM, or SIGHUP) is received, the running selftest is aborted by
> > ctrlc_handler() which then unmounts resctrl fs before exiting. The
> > current section between signal_handler_register() and
> > signal_handler_unregister(), however, does not cover the entire
> > duration when resctrl FS is mounted.
> > 
> > Move signal_handler_register() and signal_handler_unregister() call
> > into the test functions in resctrl_tests.c to properly unmount resctrl
> > fs. Adjust child process kill() call in ctrlc_handler() to only be
> > invoked if the child was already forked.
> 
> Thank you for catching this.
> 
> > 
> > Fixes: caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  tools/testing/selftests/resctrl/cat_test.c    |  8 -------
> >  .../testing/selftests/resctrl/resctrl_tests.c | 24 +++++++++++++++++++
> >  tools/testing/selftests/resctrl/resctrl_val.c | 22 ++++++++---------
> >  3 files changed, 34 insertions(+), 20 deletions(-)
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
> > index 823672a20a43..3d66fbdc2df3 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> > @@ -73,8 +73,13 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
> >  
> >  	ksft_print_msg("Starting MBM BW change ...\n");
> >  
> > +	res = signal_handler_register();
> > +	if (res)
> > +		return;
> > +
> >  	res = mount_resctrlfs();
> >  	if (res) {
> > +		signal_handler_unregister();
> >  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> >  		return;
> >  	}
> > @@ -91,6 +96,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
> >  
> >  umount:
> >  	umount_resctrlfs();
> > +	signal_handler_unregister();
> >  }
> >  
> >  static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
> > @@ -99,8 +105,13 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
> >  
> >  	ksft_print_msg("Starting MBA Schemata change ...\n");
> >  
> > +	res = signal_handler_register();
> > +	if (res)
> > +		return;
> > +
> >  	res = mount_resctrlfs();
> >  	if (res) {
> > +		signal_handler_unregister();
> >  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
> >  		return;
> >  	}
> > @@ -115,6 +126,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
> >  
> >  umount:
> >  	umount_resctrlfs();
> > +	signal_handler_unregister();
> >  }
> >  
> 
> This adds more duplicated code for every test. Have you considered a
> single test setup function that can be used to mount resctrl FS and setup
> the signal handler paired with a single test teardown function?

Yes. Consolidating all these is among my not-yet submitted patches.
I just had to do a backport-friendly Fixes patch first for this.

-- 
 i.

--8323329-2077064899-1694599306=:1849--
