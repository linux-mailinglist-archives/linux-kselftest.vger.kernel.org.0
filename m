Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8870D182051
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 19:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgCKSD0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 14:03:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:21410 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbgCKSD0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 14:03:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:03:24 -0700
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="277469185"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.23.31]) ([10.251.23.31])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Mar 2020 11:03:26 -0700
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
 <e7c85e35-9efb-77da-a33f-dd9447a6cf07@intel.com>
 <04c252f59062450e14642fcbef4b85845f6a7427.camel@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e0bada87-9464-2d08-c4cb-751e30866585@intel.com>
Date:   Wed, 11 Mar 2020 11:03:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <04c252f59062450e14642fcbef4b85845f6a7427.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 3/11/2020 10:33 AM, Sai Praneeth Prakhya wrote:
> On Wed, 2020-03-11 at 10:19 -0700, Reinette Chatre wrote:
>> On 3/10/2020 7:46 PM, Sai Praneeth Prakhya wrote:
>>> On Tue, 2020-03-10 at 15:18 -0700, Reinette Chatre wrote:
>>>> On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
>>>>>  		.mum_resctrlfs	= 0,
>>>>>  		.filename	= RESULT_FILE_NAME,
>>>>> -		.mask		= ~(long_mask << n) & long_mask,
>>>>> -		.span		= cache_size * n / count_of_bits,
>>>>>  		.num_of_runs	= 0,
>>>>> -		.setup		= cqm_setup,
>>>>> +		.setup		= cqm_setup
>>>>>  	};
>>>>> +	int ret;
>>>>> +	char schemata[64];
>>>>> +	unsigned long long_mask;
>>>>>  
>>>>> -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
>>>>> -		sprintf(benchmark_cmd[1], "%lu", param.span);
>>>>> +	ret = remount_resctrlfs(1);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>
>>>> Here resctrl is remounted and followed by some changes to the root
>>>> group's schemata. That is followed by a call to resctrl_val that
>>>> attempts to remount resctrl again that will undo all the configurations
>>>> inbetween.
>>>
>>> No, it wouldn't because mum_resctrlfs is 0. When resctrl FS is already
>>> mounted
>>> and mum_resctrlfs is 0, then remount_resctrlfs() is a noop.
>>>
>>
>> I missed that. Thank you.
>>
>> fyi ... when I tried these tests I encountered the following error
>> related to unmounting:
>>
>> [SNIP]
>> ok Write schema "L3:1=7fff" to resctrl FS
>> ok Write schema "L3:1=ffff" to resctrl FS
>> ok Write schema "L3:1=1ffff" to resctrl FS
>> ok Write schema "L3:1=3ffff" to resctrl FS
>> # Unable to umount resctrl: Device or resource busy
>> # Results are displayed in (Bytes)
>> ok CQM: diff within 5% for mask 1
>> # alloc_llc_cache_size: 2883584
>> # avg_llc_occu_resc: 2973696
>> ok CQM: diff within 5% for mask 3
>> [SNIP]
>>
>> This seems to originate from resctrl_val() that forces an unmount but if
>> that fails the error is not propagated.
> 
> Yes, that's right and it's a good test. I didn't encounter this issue during
> my testing because I wasn't using resctrl FS from other terminals (I think you
> were using resctrl FS from other terminal and hence resctrl_test was unable to
> unmount it).

I was not explicitly testing for this but this may have been the case.

As a sidenote ... could remount_resctrlfs() be called consistently? It
seems to switch between being called with true/false and 1/0. Since its
parameter type is boolean using true/false seems most appropriate.

> I think the error should not be propagated because unmounting resctrl FS
> shouldn't stop us from checking the results. If measuring values reports an
> error then we shouldn't check for results.

This sounds right. It is inconsistent though ... the CQM test unmounts
resctrl after it is run but the CAT test does not. Looking closer the
CAT test seems to leave its artifacts around in resctrl and this should
be cleaned up.

I am not sure about the expectations here. Unmounting resctrl after a
test is run is indeed the easiest to clean up and may be ok. It may be a
surprise to the user though. Perhaps there can be a snippet in the
README that warns people about this?

Thank you very much

Reinette
