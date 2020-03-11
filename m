Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD58181FAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 18:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgCKRil (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 13:38:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:22480 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbgCKRil (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 13:38:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 10:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="261211208"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2020 10:38:39 -0700
Message-ID: <04c252f59062450e14642fcbef4b85845f6a7427.camel@intel.com>
Subject: Re: [PATCH V1 11/13] selftests/resctrl: Change Cache Quality
 Monitoring (CQM) test
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Mar 2020 10:33:52 -0700
In-Reply-To: <e7c85e35-9efb-77da-a33f-dd9447a6cf07@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
         <26086dda86f062bba4116878a012a553503924b2.1583657204.git.sai.praneeth.prakhya@intel.com>
         <e7bd79cf-4da8-7a61-ac09-4d124315fa93@intel.com>
         <cf8fbdebd8096900d47a97f0e23a852d94df257a.camel@intel.com>
         <e7c85e35-9efb-77da-a33f-dd9447a6cf07@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On Wed, 2020-03-11 at 10:19 -0700, Reinette Chatre wrote:
> Hi Sai,
> 
> On 3/10/2020 7:46 PM, Sai Praneeth Prakhya wrote:
> > On Tue, 2020-03-10 at 15:18 -0700, Reinette Chatre wrote:
> > > On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
> > > >  		.mum_resctrlfs	= 0,
> > > >  		.filename	= RESULT_FILE_NAME,
> > > > -		.mask		= ~(long_mask << n) & long_mask,
> > > > -		.span		= cache_size * n / count_of_bits,
> > > >  		.num_of_runs	= 0,
> > > > -		.setup		= cqm_setup,
> > > > +		.setup		= cqm_setup
> > > >  	};
> > > > +	int ret;
> > > > +	char schemata[64];
> > > > +	unsigned long long_mask;
> > > >  
> > > > -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
> > > > -		sprintf(benchmark_cmd[1], "%lu", param.span);
> > > > +	ret = remount_resctrlfs(1);
> > > > +	if (ret)
> > > > +		return ret;
> > > 
> > > Here resctrl is remounted and followed by some changes to the root
> > > group's schemata. That is followed by a call to resctrl_val that
> > > attempts to remount resctrl again that will undo all the configurations
> > > inbetween.
> > 
> > No, it wouldn't because mum_resctrlfs is 0. When resctrl FS is already
> > mounted
> > and mum_resctrlfs is 0, then remount_resctrlfs() is a noop.
> > 
> 
> I missed that. Thank you.
> 
> fyi ... when I tried these tests I encountered the following error
> related to unmounting:
> 
> [SNIP]
> ok Write schema "L3:1=7fff" to resctrl FS
> ok Write schema "L3:1=ffff" to resctrl FS
> ok Write schema "L3:1=1ffff" to resctrl FS
> ok Write schema "L3:1=3ffff" to resctrl FS
> # Unable to umount resctrl: Device or resource busy
> # Results are displayed in (Bytes)
> ok CQM: diff within 5% for mask 1
> # alloc_llc_cache_size: 2883584
> # avg_llc_occu_resc: 2973696
> ok CQM: diff within 5% for mask 3
> [SNIP]
> 
> This seems to originate from resctrl_val() that forces an unmount but if
> that fails the error is not propagated.

Yes, that's right and it's a good test. I didn't encounter this issue during
my testing because I wasn't using resctrl FS from other terminals (I think you
were using resctrl FS from other terminal and hence resctrl_test was unable to
unmount it).

I think the error should not be propagated because unmounting resctrl FS
shouldn't stop us from checking the results. If measuring values reports an
error then we shouldn't check for results.

> > > > diff --git a/tools/testing/selftests/resctrl/resctrl_val.c
> > > > b/tools/testing/selftests/resctrl/resctrl_val.c
> > > > index 271cb5c976f5..c59fad6cb9b0 100644
> > > > --- a/tools/testing/selftests/resctrl/resctrl_val.c
> > > > +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> > > > @@ -705,29 +705,21 @@ int resctrl_val(char **benchmark_cmd, struct
> > > > resctrl_val_param *param)
> > > >  		goto out;
> > > >  	}
> > > >  
> > > > -	/* Give benchmark enough time to fully run */
> > > > -	sleep(1);
> > > > -
> > > >  	/* Test runs until the callback setup() tells the test to
> > > > stop. */
> > > >  	while (1) {
> > > > +		ret = param->setup(param);
> > > > +		if (ret) {
> > > > +			ret = 0;
> > > > +			break;
> > > > +		}
> > > > +
> > > > +		/* Measure vals sleeps for a second */
> > > >  		if ((strcmp(resctrl_val, "mbm") == 0) ||
> > > >  		    (strcmp(resctrl_val, "mba") == 0)) {
> > > > -			ret = param->setup(param);
> > > > -			if (ret) {
> > > > -				ret = 0;
> > > > -				break;
> > > > -			}
> > > > -
> 
> (I refer to the above snippet in my comment below)
> 
> > > >  			ret = measure_vals(param, &bw_resc_start);
> > > >  			if (ret)
> > > >  				break;
> > > >  		} else if (strcmp(resctrl_val, "cqm") == 0) {
> > > > -			ret = param->setup(param);
> > > > -			if (ret) {
> > > > -				ret = 0;
> > > > -				break;
> > > > -			}
> > > > -			sleep(1);
> > > >  			ret = measure_cache_vals(param, bm_pid);
> > > >  			if (ret)
> > > >  				break;
> > > 
> > > This change affects not just the cache monitoring test. Could this
> > > change be extracted into its own patch to be clear what is done here and
> > > how it impacts the other tests?
> > 
> > This change shouldn't impact other tests (i.e. CAT) because CAT will not
> > call
> > resctrl_val().
> 
> I was referring to the snippet above that seems to impact the "mbm" and
> "mba" tests by moving the call to "param->setup" for the them.

Ok.. makes sense. Sure! I will make it into separate patch.

Regards,
Sai

