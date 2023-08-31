Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1A978E6F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 09:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbjHaHLC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 03:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjHaHLC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 03:11:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC9C1A3;
        Thu, 31 Aug 2023 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693465859; x=1725001859;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SzKdAVYBLY0YDQE3G67bb12fs6eFndaHZqE5UfXB1fs=;
  b=QPHXretBttD0D/ZjfKSv3/jPpV7K5YSQVCdePVjNvpCwsF4fNd5PjIIJ
   VFbXTVgt2zCG/ae8E0oEUl/4EsFZSdb8xfsbiCvpyBqgmRwFYjKprAbqZ
   5toU0sfst/5TqhoimoTLjfEOpegT6VDj8njIuJ+B5u0dgQFl5fQtLGufA
   vH6cAH14uhhPVK3EqHR9Tk8y79xLFuSqOR940jXcVuZTBvOsKbZ2nsVr4
   rZqcdViqkm/7OTh8mUw1Ycvor7CsGWRc2d/fviCmX4pbQN9lNiQ5v1tWb
   4B7GjgTfFrOF1KQQtoQWbUhV4YDGuFN9xN5/VkHir+0KEsAeRzZm/bTsi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="442204695"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="442204695"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 00:10:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="739376185"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="739376185"
Received: from pshishpo-mobl1.ger.corp.intel.com ([10.251.214.20])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 00:10:56 -0700
Date:   Thu, 31 Aug 2023 10:10:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v3 5/7] selftests/resctrl: Make benchmark command const
 and build it with pointers
In-Reply-To: <159d8e07-cab7-9430-b83f-9c6de4d519d4@intel.com>
Message-ID: <3e557a15-25a-7588-cd13-843806728f@linux.intel.com>
References: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com> <20230823131556.27617-6-ilpo.jarvinen@linux.intel.com> <bafde7cd-01ae-56ff-c1f5-53be610c2b10@intel.com> <184bd8bb-5622-64f9-9f65-6674db935a21@linux.intel.com>
 <159d8e07-cab7-9430-b83f-9c6de4d519d4@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-904006381-1693465858=:1673"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-904006381-1693465858=:1673
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 30 Aug 2023, Reinette Chatre wrote:
> On 8/30/2023 1:59 AM, Ilpo Järvinen wrote:
> > On Tue, 29 Aug 2023, Reinette Chatre wrote:
> >> This is a tricky one. If I understand correctly this goto target makes
> >> some assumptions about the state (no test plan created yet) and exit
> >> reason (it has to be skipped). A temporary variable is also thrown into
> >> the mix.
> > 
> > So in the end the symmetry proved to be not as simple as was depicted 
> > earlier but "tricky"... I tried to warn about this and it's why I wished 
> > to avoid the allocation entirely. Without allocation, there would have not 
> > been need for the temporary variable nor adjusting the control flow with 
> > that label.
> 
> hmmm ... I do not see why an allocation forces the use of a temporary
> variable and a change in control (more below).
> 
> >> Can this not be simplified by moving the snippet where
> >> benchmark_cmd[] is initialized to fill_buf to be just before the tests 
> >> are run? Perhaps right before ksft_set_plan()?
> > 
> > So I throw a temporary variable into the mix (has_ben) to keep track when 
> > benchmark_cmd needs to be initialized to the default command? It doesn't 
> > play well with what I've in queue after this when user parameters are 
> > collected into a struct which is initialized to default value by a helper 
> > function before any argument processing. That is, initializing the 
> > parameters to defaults needs to be split before and after the parameter 
> > parsing code.
> 
> No new temporary variable is needed. Of course, I do not have insight into
> what is further down in your queue but based on this work I do think it
> can be simplified. Since code is easier to consider, the snippet below
> applies on top of this series and shows what I was proposing:

Okay, I'll use the approach you proposed. It'll prevent moving all
initialization of the default values before the argument parsing code 
which I would have wanted to do (in a patch that is not part of this 
series but it's not an end of the world).

-- 
 i.


> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index ae9001ef7b0a..8033eabb9aa8 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -170,11 +170,10 @@ static void run_cat_test(int cpu_no, int no_of_bits)
>  int main(int argc, char **argv)
>  {
>  	bool mbm_test = true, mba_test = true, cmt_test = true;
> +	const char *benchmark_cmd[BENCHMARK_ARGS] = {};
>  	int c, cpu_no = 1, i, no_of_bits = 0;
> -	const char *benchmark_cmd[BENCHMARK_ARGS];
>  	char *span_str = NULL;
>  	bool cat_test = true;
> -	char *skip_reason;
>  	int tests = 0;
>  	int ret;
>  
> @@ -247,17 +246,6 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	/* If no benchmark is given by "-b" argument, use fill_buf. */
> -	benchmark_cmd[0] = "fill_buf";
> -	ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
> -	if (ret < 0)
> -		ksft_exit_fail_msg("Out of memory!\n");
> -	benchmark_cmd[1] = span_str;
> -	benchmark_cmd[2] = "1";
> -	benchmark_cmd[3] = "0";
> -	benchmark_cmd[4] = "false";
> -	benchmark_cmd[5] = NULL;
> -
>  last_arg:
>  
>  	ksft_print_header();
> @@ -267,23 +255,30 @@ int main(int argc, char **argv)
>  	 * 1. We write to resctrl FS
>  	 * 2. We execute perf commands
>  	 */
> -	if (geteuid() != 0) {
> -		skip_reason = "Not running as root. Skipping...\n";
> -		goto free_span;
> -	}
> +	if (geteuid() != 0)
> +		return ksft_exit_skip("Not running as root. Skipping...\n");
>  
> -	if (!check_resctrlfs_support()) {
> -		skip_reason = "resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n";
> -		goto free_span;
> -	}
> +	if (!check_resctrlfs_support())
> +		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
>  
> -	if (umount_resctrlfs()) {
> -		skip_reason = "resctrl FS unmount failed.\n";
> -		goto free_span;
> -	}
> +	if (umount_resctrlfs())
> +		return ksft_exit_skip("resctrl FS unmount failed.\n");
>  
>  	filter_dmesg();
>  
> +	if (!benchmark_cmd[0]) {
> +		/* If no benchmark is given by "-b" argument, use fill_buf. */
> +		benchmark_cmd[0] = "fill_buf";
> +		ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
> +		if (ret < 0)
> +			ksft_exit_fail_msg("Out of memory!\n");
> +		benchmark_cmd[1] = span_str;
> +		benchmark_cmd[2] = "1";
> +		benchmark_cmd[3] = "0";
> +		benchmark_cmd[4] = "false";
> +		benchmark_cmd[5] = NULL;
> +	}
> +
>  	ksft_set_plan(tests ? : 4);
>  
>  	if (mbm_test)
> @@ -300,8 +295,4 @@ int main(int argc, char **argv)
>  
>  	free(span_str);
>  	ksft_finished();
> -
> -free_span:
> -	free(span_str);
> -	return ksft_exit_skip(skip_reason);
>  }
> 
--8323329-904006381-1693465858=:1673--
