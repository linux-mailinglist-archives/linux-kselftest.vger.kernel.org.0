Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599197E022C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 12:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346919AbjKCLY6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 07:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346918AbjKCLY6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 07:24:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480D8134;
        Fri,  3 Nov 2023 04:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699010692; x=1730546692;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EExSE5kMyxSHF8UhIPZ9SnLdv7qwCLGarLJ+9vT1VuA=;
  b=jaxhAuAXTdDLYy2Ym8nu1a4NdLZslrrZxTvBIfvCjiECYyrmkMBpEvLn
   uQvHvhZlsktFh9frvuYjt3GdAIL0pnum3+uARKRjG8D/0Xaa3foAfKvyz
   YzRacNcCnH4qeWjJbHh/CPi4uvOR6eGUfpL5G2u01q2JYcp3Gzdhm1aUY
   2MsZmRnv8QCUDx+xMlzaFRHqAWlpqOFvDSZqXXb7bK2eobQ+l4Iasbzmj
   tMemi4YXl+ez5DPavUcEzZigdS97k/TEBSaiyxPi8gdIrCnaA0DfNS1RF
   RiCADA8EwxZq5LOARR9YjUQAQQOSOR0XkpAzucilAy1mZmYAwf4qwbezE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="379328287"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="379328287"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 04:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="905312869"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="905312869"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.35.38])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 04:24:49 -0700
Date:   Fri, 3 Nov 2023 13:24:47 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/24] selftests/resctrl: Create struct for input
 parameter
In-Reply-To: <d22a4ce2-9e81-4d65-8381-e5ab5fa706ed@intel.com>
Message-ID: <2e266bb-653f-2fe2-9dbc-db8388f6aff1@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-18-ilpo.jarvinen@linux.intel.com> <d22a4ce2-9e81-4d65-8381-e5ab5fa706ed@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1829071547-1699010691=:1725"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1829071547-1699010691=:1725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Nov 2023, Reinette Chatre wrote:
> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> 
> > diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> > index d3bf4368341e..5157a3f74fee 100644
> > --- a/tools/testing/selftests/resctrl/mba_test.c
> > +++ b/tools/testing/selftests/resctrl/mba_test.c
> > @@ -141,13 +141,13 @@ void mba_test_cleanup(void)
> >  	remove(RESULT_FILE_NAME);
> >  }
> >  
> > -int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
> > +int mba_schemata_change(const struct user_params *uparams)
> >  {
> >  	struct resctrl_val_param param = {
> >  		.resctrl_val	= MBA_STR,
> >  		.ctrlgrp	= "c1",
> >  		.mongrp		= "m1",
> > -		.cpu_no		= cpu_no,
> > +		.cpu_no		= uparams->cpu,
> >  		.filename	= RESULT_FILE_NAME,
> >  		.bw_report	= "reads",
> >  		.setup		= mba_setup
> > @@ -156,7 +156,7 @@ int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
> >  
> >  	remove(RESULT_FILE_NAME);
> >  
> > -	ret = resctrl_val(benchmark_cmd, &param);
> > +	ret = resctrl_val(uparams->benchmark_cmd, &param);
> >  	if (ret)
> >  		goto out;
> >  
> 
> How about a new member of struct resctrl_val_param that points to 
> uparams? That would remove cpu_no from resctrl_val_param
> and have everything available when a test needs to run ... not copying
> some user parameters into struct resctrl_val_param and passing
> others as parameters.

I'm a bit allergic to adding more stuff into resctrl_val_param. It seems 
a structure where random stuff has been thrown at just because it exists.
In general, your point is very valid though because the members of 
resctrl_val_param should be auditted through to see how many of them are 
even useful after adding uparams and struct resctrl_test.

I could get rid of copying parameters from uparams to params and just 
passing uparams instead of benchmark_cmd into resctrl_val(). Would you be 
okay with that?

Oh, and I really should rename resctrl_val() one day to something more 
meaningful too. :-) (but it won't be part of this series and will likely 
be another conflicty nightmare because resctrl_val_param too needs to 
be renamed...).

-- 
 i.

--8323329-1829071547-1699010691=:1725--
