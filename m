Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5898608536
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Oct 2022 08:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJVGmZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Oct 2022 02:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJVGmX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Oct 2022 02:42:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E982A520A;
        Fri, 21 Oct 2022 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666420942; x=1697956942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q2Sryo3FNr3ZccmOfEjnDpCgO5RRQ/r8uLrfFTtqk6g=;
  b=ezS+wYaadCblCOJCFQGbdFf4Ky1FP53Th2DQBnh78TumGIaRwM4hli+H
   47kvUnU79O2uS9iav5QURsksCqaz1MQj7q79RN4j3itgXOGeOORVLhNvU
   WZvmuvm9Gxy/LGoVfTxU6lgXERWuJz2PwVDi/WR115XAL13YWuRwYO5Rg
   SOLdC6YN2NykZV39LQfQUcgsW4/mlI3/+LexsOQEUucV+mRkII8VkPBDx
   14kIZJxxD7q+h7kJqKdFdxguAdOmzwl492E2zuerZ+PkbC5oZo/rShoZG
   hsGENmFEN/BWQt+RCcJIlsvpFODdMRiLhFGgdlvGDKYqW3HL6ayakOOVh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="307153843"
X-IronPort-AV: E=Sophos;i="5.95,204,1661842800"; 
   d="scan'208";a="307153843"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 23:42:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="693983375"
X-IronPort-AV: E=Sophos;i="5.95,204,1661842800"; 
   d="scan'208";a="693983375"
Received: from bmoore-mobl1.amr.corp.intel.com (HELO [10.252.130.138]) ([10.252.130.138])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 23:42:21 -0700
Message-ID: <01ac3648-0d89-5c78-42e9-c43d4ef64925@linux.intel.com>
Date:   Fri, 21 Oct 2022 23:42:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1De4IyAB6n2qs4V@kroah.com>
 <34ef18d6-69f8-853a-d1ba-7023822e17ff@linux.intel.com>
 <Y1Iimg0WItgIGq6/@kroah.com>
 <13adfc8d-8118-2fd7-3a66-98dfbf8037a9@linux.intel.com>
 <Y1OIHjFp2r58fDPI@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Y1OIHjFp2r58fDPI@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/21/22 11:05 PM, Greg Kroah-Hartman wrote:
> On Fri, Oct 21, 2022 at 04:51:34PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> Hi Greg,
>>
>> On 10/20/22 9:39 PM, Greg Kroah-Hartman wrote:
>>>>>> +#ifdef MODULE
>>>>>> +static const struct x86_cpu_id tdx_guest_ids[] = {
>>>>>> +	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
>>>>>> +	{}
>>>>>> +};
>>>>>> +MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>>>>>> +#endif
>>>>> Why the #ifdef?  Should not be needed, right?
>>>> I have added it to fix the following warning reported by 0-day.
>>>>
>>>> https://lore.kernel.org/lkml/202209211607.tCtTWKbV-lkp@intel.com/
>>>>
>>>> It is related to nullifying the MODULE_DEVICE_TABLE in #ifndef MODULE
>>>> case in linux/module.h.
>>> Then fix it properly, by correctly using that structure no matter what.
>>> You don't do that here...
>>
>> I think we can use __maybe_unused attribute to fix this warning like
>> mentioned below. Are you fine with it?
>>
>> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
>> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
>> @@ -118,13 +118,11 @@ static void __exit tdx_guest_exit(void)
>>  }
>>  module_exit(tdx_guest_exit);
>>  
>> -#ifdef MODULE
>> -static const struct x86_cpu_id tdx_guest_ids[] = {
>> +static const struct x86_cpu_id __maybe_unused tdx_guest_ids[] = {
>>         X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
>>         {}
>>  };
>>  MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>> -#endif
>>
>> Solution 2:
>> -----------
>>
>> We can also modify the code to use this structure in all cases like
>> below. But it requires me to use slower x86_match_cpu() in place of 
>> cpu_feature_enabled() which I think is unnecessary.
>>
>> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
>> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
>> @@ -103,9 +103,15 @@ static struct miscdevice tdx_misc_dev = {
>>         .fops = &tdx_guest_fops,
>>  };
>>  
>> +static const struct x86_cpu_id tdx_guest_ids[] = {
>> +       X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>> +
>>  static int __init tdx_guest_init(void)
>>  {
>> -       if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +       if (!x86_match_cpu(tdx_guest_ids))
> 
> Please use this as it's what all other users of the x86cpu module device

Ok. I will use it.

> table code uses, right?

Not all, but most of them use the above model. 

Following two drivers seems to use __maybe_unused method.

./drivers/cpufreq/acpi-cpufreq.c
./drivers/char/hw_random/via-rng.c

and following two drivers uses #ifdef MODULE method.

./arch/x86/kvm/vmx/vmx.c
./arch/x86/kvm/svm/svm.c


> 
> And what is the "speed" difference here?  Is is measurable and where

> does it matter?

Speed difference does not really matter in init code. So I am fine
with using this approach.

> 
> thanks,
> 
> greg k-h

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
