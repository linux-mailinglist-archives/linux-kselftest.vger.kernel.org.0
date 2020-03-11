Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E83D181F19
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 18:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgCKRTV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 13:19:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:51236 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbgCKRTU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 13:19:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 10:19:20 -0700
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="277454902"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.23.31]) ([10.251.23.31])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Mar 2020 10:19:19 -0700
Subject: Re: [PATCH V1 11/13] selftests/resctrl: Change Cache Quality
 Monitoring (CQM) test
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
 <26086dda86f062bba4116878a012a553503924b2.1583657204.git.sai.praneeth.prakhya@intel.com>
 <e7bd79cf-4da8-7a61-ac09-4d124315fa93@intel.com>
 <cf8fbdebd8096900d47a97f0e23a852d94df257a.camel@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e7c85e35-9efb-77da-a33f-dd9447a6cf07@intel.com>
Date:   Wed, 11 Mar 2020 10:19:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cf8fbdebd8096900d47a97f0e23a852d94df257a.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 3/10/2020 7:46 PM, Sai Praneeth Prakhya wrote:
> On Tue, 2020-03-10 at 15:18 -0700, Reinette Chatre wrote:
>> On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
>>>  		.mum_resctrlfs	= 0,
>>>  		.filename	= RESULT_FILE_NAME,
>>> -		.mask		= ~(long_mask << n) & long_mask,
>>> -		.span		= cache_size * n / count_of_bits,
>>>  		.num_of_runs	= 0,
>>> -		.setup		= cqm_setup,
>>> +		.setup		= cqm_setup
>>>  	};
>>> +	int ret;
>>> +	char schemata[64];
>>> +	unsigned long long_mask;
>>>  
>>> -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
>>> -		sprintf(benchmark_cmd[1], "%lu", param.span);
>>> +	ret = remount_resctrlfs(1);
>>> +	if (ret)
>>> +		return ret;
>>
>> Here resctrl is remounted and followed by some changes to the root
>> group's schemata. That is followed by a call to resctrl_val that
>> attempts to remount resctrl again that will undo all the configurations
>> inbetween.
> 
> No, it wouldn't because mum_resctrlfs is 0. When resctrl FS is already mounted
> and mum_resctrlfs is 0, then remount_resctrlfs() is a noop.
> 

I missed that. Thank you.

fyi ... when I tried these tests I encountered the following error
related to unmounting:

[SNIP]
ok Write schema "L3:1=7fff" to resctrl FS
ok Write schema "L3:1=ffff" to resctrl FS
ok Write schema "L3:1=1ffff" to resctrl FS
ok Write schema "L3:1=3ffff" to resctrl FS
# Unable to umount resctrl: Device or resource busy
# Results are displayed in (Bytes)
ok CQM: diff within 5% for mask 1
# alloc_llc_cache_size: 2883584
# avg_llc_occu_resc: 2973696
ok CQM: diff within 5% for mask 3
[SNIP]

This seems to originate from resctrl_val() that forces an unmount but if
that fails the error is not propagated.

>>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c
>>> b/tools/testing/selftests/resctrl/resctrl_val.c
>>> index 271cb5c976f5..c59fad6cb9b0 100644
>>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>>> @@ -705,29 +705,21 @@ int resctrl_val(char **benchmark_cmd, struct
>>> resctrl_val_param *param)
>>>  		goto out;
>>>  	}
>>>  
>>> -	/* Give benchmark enough time to fully run */
>>> -	sleep(1);
>>> -
>>>  	/* Test runs until the callback setup() tells the test to stop. */
>>>  	while (1) {
>>> +		ret = param->setup(param);
>>> +		if (ret) {
>>> +			ret = 0;
>>> +			break;
>>> +		}
>>> +
>>> +		/* Measure vals sleeps for a second */
>>>  		if ((strcmp(resctrl_val, "mbm") == 0) ||
>>>  		    (strcmp(resctrl_val, "mba") == 0)) {
>>> -			ret = param->setup(param);
>>> -			if (ret) {
>>> -				ret = 0;
>>> -				break;
>>> -			}
>>> -

(I refer to the above snippet in my comment below)

>>>  			ret = measure_vals(param, &bw_resc_start);
>>>  			if (ret)
>>>  				break;
>>>  		} else if (strcmp(resctrl_val, "cqm") == 0) {
>>> -			ret = param->setup(param);
>>> -			if (ret) {
>>> -				ret = 0;
>>> -				break;
>>> -			}
>>> -			sleep(1);
>>>  			ret = measure_cache_vals(param, bm_pid);
>>>  			if (ret)
>>>  				break;
>>
>> This change affects not just the cache monitoring test. Could this
>> change be extracted into its own patch to be clear what is done here and
>> how it impacts the other tests?
> 
> This change shouldn't impact other tests (i.e. CAT) because CAT will not call
> resctrl_val().

I was referring to the snippet above that seems to impact the "mbm" and
"mba" tests by moving the call to "param->setup" for the them.

> 
>>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c
>>> b/tools/testing/selftests/resctrl/resctrlfs.c
>>> index 52452bb0178a..bd81a13ff9df 100644
>>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>>> @@ -365,11 +365,7 @@ void run_benchmark(int signum, siginfo_t *info, void
>>> *ucontext)
>>>  		memflush =  atoi(benchmark_cmd[3]);
>>>  		operation = atoi(benchmark_cmd[4]);
>>>  		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
>>> -
>>> -		if (strcmp(resctrl_val, "cqm") != 0)
>>> -			buffer_span = span * MB;
>>> -		else
>>> -			buffer_span = span;
>>> +		buffer_span = span * MB;
>>
>> This change seems to change the buffer_span used by the other tests. It
>> is not obvious why this change is made to other tests while this commit
>> intends to focus on the cache monitoring test. Perhaps this can be split
>> into a separate patch to make this clear?
> 

Got it. Thank you.


Reinette

