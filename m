Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5378FA8C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjIAJSp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 05:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIAJSp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 05:18:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD1010D7;
        Fri,  1 Sep 2023 02:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693559922; x=1725095922;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=D8lDK6WlruDop02fINkrgVRK+gNN/TluMLV5jqq0e6E=;
  b=buMV+nWijqNnk2ys+FRYpiETixcSXxLU489xmwZe9CwjCxqJ7EW/M5TF
   MsNbngPBqhAmNuSYnPBEPK4TQ8WXKj1TVRSX5cC0UECdubrvSmUxl2HGH
   hoQZEEhLWgm+c+Kwr7l1LMFdQZCsIkg1APE+6TnJrkd+si61j3+7f80pY
   gARQay6nfnHsVq4p/u5mhjlxaZiP56wIf9XUO3hcSN9G5KK39KqDYanaZ
   3Ik61uOuO+byY/BFOYhqhN1ushRzYRv0q0Dg2MC5lS0KpX+Em7n/zgvtN
   bw43hnQMogxFodIKaxLEZj2vq69V7ooEfrdfwTkvVDBNJjzqc6wgnuBoB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="407169817"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="407169817"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 02:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805378247"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="805378247"
Received: from pboudier-mobl.ger.corp.intel.com ([10.252.47.249])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 02:18:39 -0700
Date:   Fri, 1 Sep 2023 12:18:31 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/8] selftests/resctrl: Ensure the benchmark commands
 fits to its array
In-Reply-To: <da9c1d88-73ea-b169-909c-e6e59e87c474@intel.com>
Message-ID: <cf3b8cb7-7d17-8d19-3fa1-f2a845ec946@linux.intel.com>
References: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com> <20230831110843.26719-2-ilpo.jarvinen@linux.intel.com> <da9c1d88-73ea-b169-909c-e6e59e87c474@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2046450504-1693559921=:2036"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2046450504-1693559921=:2036
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 31 Aug 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 8/31/2023 4:08 AM, Ilpo Järvinen wrote:
> > Benchmark command is copied into an array in the stack. The array is
> > BENCHMARK_ARGS items long but the command line could try to provide a
> > longer command. Argument size is also fixed by BENCHMARK_ARG_SIZE (63
> > bytes of space after fitting the terminating \0 character) and user
> > could have inputted argument longer than that.
> > 
> > Return error in case the benchmark command does not fit to the space
> > allocated for it.
> > 
> > Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> > Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> > ---
> >  tools/testing/selftests/resctrl/resctrl_tests.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> > index d511daeb6851..a9331b31c32d 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> > @@ -255,9 +255,14 @@ int main(int argc, char **argv)
> >  		return ksft_exit_skip("Not running as root. Skipping...\n");
> >  
> >  	if (has_ben) {
> > +		if (argc - ben_ind >= BENCHMARK_ARGS)
> > +			ksft_exit_fail_msg("Too long benchmark command.\n");
> > +
> >  		/* Extract benchmark command from command line. */
> >  		for (i = ben_ind; i < argc; i++) {
> >  			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];
> > +			if (strlen(argv[i]) >= BENCHMARK_ARG_SIZE - 1)
> 
> Should this perhaps be:
> 	if (strlen(argv[i]) >= BENCHMARK_ARG_SIZE)
> 
> As you note in the longest string that can be fitted should be 63 to account for
> the \0. If I understand correctly comparing with "BENCHMARK_ARG_SIZE - 1" would
> would consider a 63 byte string as invalid.

Of course, I don't know why I added that - 1 there.

-- 
 i.

--8323329-2046450504-1693559921=:2036--
