Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90F27E1CEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 10:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjKFJGv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 04:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjKFJGv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 04:06:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6351DAF;
        Mon,  6 Nov 2023 01:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699261608; x=1730797608;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Et3VphZHOW2gSvu5TwXj5UcWM9P97Nz561SCyvw7zLk=;
  b=ll0p2p1fYNb9LB/F7koknBAGhRJPWJCvUoPJDFuG2MfGQ+rRNwh3uGwg
   eHCWScjFp002+2Zvj8f3/ZhUmpK+7nd8GggbqUkwj8gjIm/14q+dM/eBJ
   GdqHU8VldukXX/wyIaiJatAcvpAru1col+NVFCUk00r7yPgrDlXKXaqP/
   B3qp2FxU+i9CcLFR/VniFrZ32ZOhvJaQo8j2FxmaE3tC/r9ZDs4fPV49j
   +uJmrUPOKCGr6X4mn+/WILOM8JT8+HA7ZZcIA6vb61fojKGvq2HYuf4RY
   Q7D0EFEOnq4CpThcio9a+WFZfYCPrz4aQeb0f19XeCbv2s4AAAXfcDcRQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="392103758"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="392103758"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="797246366"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="797246366"
Received: from rmstoi-mobl.ger.corp.intel.com ([10.251.216.76])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:06:45 -0800
Date:   Mon, 6 Nov 2023 11:06:38 +0200 (EET)
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
In-Reply-To: <ace11119-8de6-4e68-a966-431ccfa14b9d@intel.com>
Message-ID: <d672de6e-9631-d8a8-b5e9-d1a1506cb16f@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-18-ilpo.jarvinen@linux.intel.com> <d22a4ce2-9e81-4d65-8381-e5ab5fa706ed@intel.com> <2e266bb-653f-2fe2-9dbc-db8388f6aff1@linux.intel.com>
 <ace11119-8de6-4e68-a966-431ccfa14b9d@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1846128115-1699261607=:1852"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1846128115-1699261607=:1852
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 3 Nov 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 11/3/2023 4:24 AM, Ilpo Järvinen wrote:
> > On Thu, 2 Nov 2023, Reinette Chatre wrote:
> >> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> >>
> >>> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> >>> index d3bf4368341e..5157a3f74fee 100644
> >>> --- a/tools/testing/selftests/resctrl/mba_test.c
> >>> +++ b/tools/testing/selftests/resctrl/mba_test.c
> >>> @@ -141,13 +141,13 @@ void mba_test_cleanup(void)
> >>>  	remove(RESULT_FILE_NAME);
> >>>  }
> >>>  
> >>> -int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
> >>> +int mba_schemata_change(const struct user_params *uparams)
> >>>  {
> >>>  	struct resctrl_val_param param = {
> >>>  		.resctrl_val	= MBA_STR,
> >>>  		.ctrlgrp	= "c1",
> >>>  		.mongrp		= "m1",
> >>> -		.cpu_no		= cpu_no,
> >>> +		.cpu_no		= uparams->cpu,
> >>>  		.filename	= RESULT_FILE_NAME,
> >>>  		.bw_report	= "reads",
> >>>  		.setup		= mba_setup
> >>> @@ -156,7 +156,7 @@ int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
> >>>  
> >>>  	remove(RESULT_FILE_NAME);
> >>>  
> >>> -	ret = resctrl_val(benchmark_cmd, &param);
> >>> +	ret = resctrl_val(uparams->benchmark_cmd, &param);
> >>>  	if (ret)
> >>>  		goto out;
> >>>  
> >>
> >> How about a new member of struct resctrl_val_param that points to 
> >> uparams? That would remove cpu_no from resctrl_val_param
> >> and have everything available when a test needs to run ... not copying
> >> some user parameters into struct resctrl_val_param and passing
> >> others as parameters.
> > 
> > I'm a bit allergic to adding more stuff into resctrl_val_param. It seems 
> > a structure where random stuff has been thrown at just because it exists.
> > In general, your point is very valid though because the members of 
> > resctrl_val_param should be auditted through to see how many of them are 
> > even useful after adding uparams and struct resctrl_test.
> > 
> > I could get rid of copying parameters from uparams to params and just 
> > passing uparams instead of benchmark_cmd into resctrl_val(). Would you be 
> > okay with that?
> 
> I am ok with that. I assume this implies that cpu_no will be removed from
> resctrl_val_param?

Yes.

-- 
 i.

> > Oh, and I really should rename resctrl_val() one day to something more 
> > meaningful too. :-) (but it won't be part of this series and will likely 
> > be another conflicty nightmare because resctrl_val_param too needs to 
> > be renamed...).
> 
> "Naming only" changes that are not part of something more substantive are not
> very appealing though.
> 
> Reinette
> 
--8323329-1846128115-1699261607=:1852--
