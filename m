Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5D5FCA43
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJLSL6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 14:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJLSL5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 14:11:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87088DED19;
        Wed, 12 Oct 2022 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665598316; x=1697134316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qgFUurzL+QlDsqQsQhjjS0FK/bFClVnNfpHEO/UpWnk=;
  b=Yv9XDlHP7vSvIPJW3XoSpZTq90Ho/EuddU+lX21OSN6DUkMEDYC746ap
   qEdPbKNWOfNbpDDV28S8nR8FHVE/YIz67QTJmw2Gn5fju2lOiwhzkZyPL
   qcK7/gLrphs+nE0MwhmFHwScW9+x7sqTfkxJBGQMubLJGe3UXbXW+IZ/0
   EWVV0HOVUlRd+okgC1XOmbO+qYAb8fU937SPyWyertoq6bee0fusk8AoW
   +exKFcyS4pLTT10buHsqBpdM8oUpoTLu2jwYhCdaZKC6983ZyOP/Yo0/6
   j5EjKandV/zmLbwIuxlorS/2HbkF7xGvwZ9JvRteSztyP+VTS8x+JTqm1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="391175717"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="391175717"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 11:11:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="689777127"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="689777127"
Received: from jbrolli1-mobl.amr.corp.intel.com (HELO [10.212.174.189]) ([10.212.174.189])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 11:11:55 -0700
Message-ID: <f951a29a-edad-89a7-cf04-c87fdfa9ba5e@linux.intel.com>
Date:   Wed, 12 Oct 2022 11:11:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v14 1/3] x86/tdx: Make __tdx_module_call() usable in
 driver module
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
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
References: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220928215535.26527-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y0aUb3n7ouaeAt2a@zn.tnic>
 <acc212d6-782b-a398-825a-212849beba00@linux.intel.com>
 <Y0bOtzlrkKzHmQVZ@zn.tnic>
 <6759025f-fc08-74f0-efd7-2331110dec0c@linux.intel.com>
 <Y0bqA8+Xi1kLchxh@kroah.com>
 <62ef9740-64f0-ee60-71fa-80cc90da435c@linux.intel.com>
 <Y0b4zrOTU6adb0xi@kroah.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Y0b4zrOTU6adb0xi@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/12/22 10:26 AM, Greg Kroah-Hartman wrote:
> On Wed, Oct 12, 2022 at 10:13:50AM -0700, Sathyanarayanan Kuppuswamy wrote:
>> Hi,
>>
>> On 10/12/22 9:23 AM, Greg Kroah-Hartman wrote:
>>> On Wed, Oct 12, 2022 at 08:44:04AM -0700, Sathyanarayanan Kuppuswamy wrote:
>>>>
>>>>
>>>> On 10/12/22 7:27 AM, Borislav Petkov wrote:
>>>>> On Wed, Oct 12, 2022 at 06:35:56AM -0700, Sathyanarayanan Kuppuswamy wrote:
>>>>>> So we should create a new wrapper for this use case or use
>>>>>
>>>>> Yes, you got it - a new wrapper pls.
>>>>
>>>> Ok. I will add a new wrapper to get the TDREPORT. 
>>>>
>>>> +/*
>>>>
>>>> + * Add a wrapper for TDG.MR.REPORT TDCALL. It is used in TDX guest
>>>>
>>>> + * driver module to get the TDREPORT.
>>>>
>>>> + */
>>>>
>>>> +long tdx_mcall_get_report(void *reportdata, void *tdreport, u8 subtype)
>>>
>>> Why "long"?
>>
>> We used long because __tdx_module_call() call returns u64 value.
> 
> Great, then use u64 please.  Or if you are returning negative errors,
> use s64 to be specific.
> 
>> Alternatively, we can also check for return value of __tdx_module_call() here
>> and return 0/-EIO as return values. In this case we can change return value
>> to int.
> 
> That would make more sense, right?

Yes. I will change it as mentioned above.

> 
>>>
>>> Why void *?  Don't you have real types for these?
>>
>> We use these buffers as an intermediary to transfer data between userspace and
>> the TDX module. In the kernel we don't consume these datas. So we did not define
>> the type of the data.
> 
> Then these are userspace pointers?  Why are they not marked as such?

They are not userspace pointers. Since we need to pass physical addresses of reportdata
and tdreport buffers to the TDX Module, we cannot directly use userspace pointers. So
we allocate these intermediary buffers in the TDX guest driver and use it to copy the
data from/to user pointers. 

> 
> thanks,
> 
> greg k-h

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
