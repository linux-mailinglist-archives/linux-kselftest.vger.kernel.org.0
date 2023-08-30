Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317C978DADA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbjH3ShR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242528AbjH3I7w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 04:59:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB32ECC9;
        Wed, 30 Aug 2023 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693385988; x=1724921988;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z8x/3nfrUutct/LzfYQeniWhx4NZGD8mqmiFRcdPHEk=;
  b=MdYEsNCxuiTqF6FphzThHQd0G2bCArAiSjRXW6xKVU19OonDWEnhghTa
   sJjEH8VXDFdGKPiHotb8+vxJk84nGUZMeCWonGNCfGMZHwdvLAf1XAlcn
   JLWU/27YRuTDAabxFDqhwEX7QEhwdgPzjpyTsymrNLa35KouJctDWba2u
   lF6ovzJRxH7HKLzdLYuv4s+sPoA52KWBWKgvL17jPIM1+ilEGyN1BTHNV
   DLMoJrAD214KTDWi7YW2aUk9AESaaShzyrYRfXCMYlfVbZ5yAmFRhstBI
   Pb/s7I8FhL6KAFJpjH0jJYMF9lrD2uY3oaZdDz3In2ols6CHLZg4EB8QT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355901947"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="355901947"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715824203"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="715824203"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.251.213.104])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:59:45 -0700
Date:   Wed, 30 Aug 2023 11:59:39 +0300 (EEST)
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
In-Reply-To: <bafde7cd-01ae-56ff-c1f5-53be610c2b10@intel.com>
Message-ID: <184bd8bb-5622-64f9-9f65-6674db935a21@linux.intel.com>
References: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com> <20230823131556.27617-6-ilpo.jarvinen@linux.intel.com> <bafde7cd-01ae-56ff-c1f5-53be610c2b10@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1703911292-1693385988=:1710"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1703911292-1693385988=:1710
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 29 Aug 2023, Reinette Chatre wrote:
> On 8/23/2023 6:15 AM, Ilpo Järvinen wrote:
> ...
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> > index bcd0d2060f81..32d23e665697 100644
> > --- a/tools/testing/selftests/resctrl/resctrl.h
> > +++ b/tools/testing/selftests/resctrl/resctrl.h
> > @@ -97,11 +100,11 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
> >  int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
> >  		    int group_fd, unsigned long flags);
> >  int run_fill_buf(size_t span, int memflush, int op, bool once);
> > -int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
> > -int mbm_bw_change(int cpu_no, char **benchmark_cmd);
> > +int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param);
> > +int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd);
> >  void tests_cleanup(void);
> >  void mbm_test_cleanup(void);
> > -int mba_schemata_change(int cpu_no, char **benchmark_cmd);
> > +int mba_schemata_change(int cpu_no, const char *const *benchmark_cmd);
> 
> Could you please use consistent spacing ("char * const" vs "char *const")?
>
> > @@ -120,7 +117,7 @@ static void run_mba_test(char **benchmark_cmd, int cpu_no)
> >  	umount_resctrlfs();
> >  }
> >  
> > -static void run_cmt_test(char **benchmark_cmd, int cpu_no)
> > +static void run_cmt_test(const char **benchmark_cmd, int cpu_no)
> >  {
> >  	int res;
> >  
> 
> Could you please elaborate why the above functions have
> "const char **" instead of "const char * const *"?

Thanks for the review!

Sure. I'll make them consistent.

> > @@ -173,11 +170,13 @@ static void run_cat_test(int cpu_no, int no_of_bits)
> >  int main(int argc, char **argv)
> >  {
> >  	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
> > -	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
> >  	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
> > -	char *benchmark_cmd[BENCHMARK_ARGS];
> > +	const char *benchmark_cmd[BENCHMARK_ARGS];
> >  	int ben_ind, ben_count, tests = 0;
> > +	char *span_str = NULL;
> >  	bool cat_test = true;
> > +	char *skip_reason;
> > +	int ret;
> >  
> >  	for (i = 0; i < argc; i++) {
> >  		if (strcmp(argv[i], "-b") == 0) {
> > @@ -257,31 +256,31 @@ int main(int argc, char **argv)
> >  			ksft_exit_fail_msg("Too long benchmark command.\n");
> >  
> >  		/* Extract benchmark command from command line. */
> > -		for (i = ben_ind; i < argc; i++) {
> > -			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];
> > -			if (strlen(argv[i]) >= BENCHMARK_ARG_SIZE - 1)
> > -				ksft_exit_fail_msg("Too long benchmark command argument.\n");
> > -			sprintf(benchmark_cmd[i - ben_ind], "%s", argv[i]);
> > -		}
> > +		for (i = 0; i < argc - ben_ind; i++)
> > +			benchmark_cmd[i] = argv[i + ben_ind];
> >  		benchmark_cmd[ben_count] = NULL;
> >  	} else {
> >  		/* If no benchmark is given by "-b" argument, use fill_buf. */
> > -		for (i = 0; i < 5; i++)
> > -			benchmark_cmd[i] = benchmark_cmd_area[i];
> > -
> > -		strcpy(benchmark_cmd[0], "fill_buf");
> > -		sprintf(benchmark_cmd[1], "%u", DEFAULT_SPAN);
> > -		strcpy(benchmark_cmd[2], "1");
> > -		strcpy(benchmark_cmd[3], "0");
> > -		strcpy(benchmark_cmd[4], "false");
> > +		benchmark_cmd[0] = "fill_buf";
> > +		ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
> > +		if (ret < 0)
> > +			ksft_exit_fail_msg("Out of memory!\n");
> > +		benchmark_cmd[1] = span_str;
> > +		benchmark_cmd[2] = "1";
> > +		benchmark_cmd[3] = "0";
> > +		benchmark_cmd[4] = "false";
> >  		benchmark_cmd[5] = NULL;
> >  	}
> >  
> > -	if (!check_resctrlfs_support())
> > -		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
> > +	if (!check_resctrlfs_support()) {
> > +		skip_reason = "resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n";
> > +		goto free_span;
> > +	}
> >  
> > -	if (umount_resctrlfs())
> > -		return ksft_exit_skip("resctrl FS unmount failed.\n");
> > +	if (umount_resctrlfs()) {
> > +		skip_reason = "resctrl FS unmount failed.\n";
> > +		goto free_span;
> > +	}
> >  
> >  	filter_dmesg();
> >  
> > @@ -299,5 +298,10 @@ int main(int argc, char **argv)
> >  	if (cat_test)
> >  		run_cat_test(cpu_no, no_of_bits);
> >  
> > +	free(span_str);
> >  	ksft_finished();
> > +
> > +free_span:
> > +	free(span_str);
> > +	return ksft_exit_skip(skip_reason);
> >  }
> 
> This is a tricky one. If I understand correctly this goto target makes
> some assumptions about the state (no test plan created yet) and exit
> reason (it has to be skipped). A temporary variable is also thrown into
> the mix.

So in the end the symmetry proved to be not as simple as was depicted 
earlier but "tricky"... I tried to warn about this and it's why I wished 
to avoid the allocation entirely. Without allocation, there would have not 
been need for the temporary variable nor adjusting the control flow with 
that label.

> Can this not be simplified by moving the snippet where
> benchmark_cmd[] is initialized to fill_buf to be just before the tests 
> are run? Perhaps right before ksft_set_plan()?

So I throw a temporary variable into the mix (has_ben) to keep track when 
benchmark_cmd needs to be initialized to the default command? It doesn't 
play well with what I've in queue after this when user parameters are 
collected into a struct which is initialized to default value by a helper 
function before any argument processing. That is, initializing the 
parameters to defaults needs to be split before and after the parameter 
parsing code.

> This may be an easier move to consider
> when the changes in patch 7 are taken into account.

Perhaps you could consider accepting my earlier approach which avoided 
the allocation entirely now that you've seen where this leads to? ...At 
least you should understand my reasoning for that on much deeper level 
now.


-- 
 i.

--8323329-1703911292-1693385988=:1710--
