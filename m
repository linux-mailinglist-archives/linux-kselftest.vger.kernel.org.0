Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF477CA1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjHOJOE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbjHOJNW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:13:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F602D44;
        Tue, 15 Aug 2023 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692090728; x=1723626728;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WdLLb7BFqIgd4NRwIhTND2VoPvEDMQRA+Ac2GAqNR0g=;
  b=HvHGYs47cDPiZ0Rijh14GB1GNlqLe1nN6ypHOIrGDBn48VbjiwZqnyNy
   /VuXhShf9yjgVkSJjvQYW/VIlMvLneCDemab84eNjjsIEA0Gn5kvawLN+
   dkqdqF3uDK+Kuqy2mW4uOyldChojMhTpwSs8p7EMN5FKAc+ib4veRZpp1
   E6zLnI696JlFSsDWnHHN6bVMeEuqrueWqHyg7ZJVmvVnIwux+HaLnfyiV
   HqXH+KHvXjjI+5N8+RrpF1zVclL8s+e2Bgi8RrxGPMMZJ/2ps7bmVgm0v
   3nuBus6UiE+FsH9+flAHsqrcpLgKAmtljO58NhG2A5NhirjCUipBRdFGa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372234139"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="372234139"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 02:11:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="710646371"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="710646371"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.35])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 02:11:46 -0700
Date:   Tue, 15 Aug 2023 12:11:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH 2/7] selftests/resctrl: Correct benchmark command help
In-Reply-To: <98f8dbed-5eb9-8b09-1868-5dda4162b9e3@intel.com>
Message-ID: <e7f530ac-85bb-1c9f-b3db-de735da2c22e@linux.intel.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com> <20230808091625.12760-3-ilpo.jarvinen@linux.intel.com> <98f8dbed-5eb9-8b09-1868-5dda4162b9e3@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-826644409-1692090709=:1736"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-826644409-1692090709=:1736
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 14 Aug 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> > Benchmark command must be the last argument because it consumes all the
> > remaining arguments but help misleadingly shows it as the first
> > argument. The benchmark command is also shown in quotes but it does not
> > match with the code.
> > 
> > Correct -b argument place in the help message and remove the quotes.
> > Tweak also how the options are presented by using ... notation.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/resctrl_tests.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> > index eef9e02516ad..559868b16079 100644
> > --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> > +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> > @@ -52,7 +52,7 @@ int get_vendor(void)
> >  
> >  static void cmd_help(void)
> >  {
> > -	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
> > +	printf("usage: resctrl_tests [-h] [-t test list] [-n no_of_bits] [-b benchmark_cmd [option]...]\n");
> >  	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT\n");
> 
> Considering it was documented goal of patch to use "..." notation, should
> it be done consistently by changing above line also?

Yes, I'll do that.

-- 
 i.

--8323329-826644409-1692090709=:1736--
