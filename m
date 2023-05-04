Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922296F658A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 May 2023 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEDHNB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 May 2023 03:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjEDHNA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 May 2023 03:13:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3F61731;
        Thu,  4 May 2023 00:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683184378; x=1714720378;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qj1wck1TWKOGkDr9B7emjEC/rEymNm/6ACMT/q/Eu84=;
  b=TwUGdRlK/o1v60IG+0OAYSRCl7aatPpRvkUPL6iuLohlGtTGQ6mW3N89
   y0YT5LPP/byhxS/fVZsh7aYqHTITxkTStmJo4lvhsg6M+B7kAdOOKI3WX
   4JnaBuFJuxhf6N0bkxhn+p0F3djzfm4MFibf0vPBzkC8WcjhAVXrg4kZc
   eEk7bIfK+/LA7C+RHMf410hB9crdQElhcoy0sBGdj5rLmjV4AOIOd3Xmv
   QF8vMR7xqzY3PubIcTGj7uFQrtkRYq99ceFaM1uJNO07AUDvOtWhDUnGN
   jB74tULzEh7EZfFnbBXkr5D5RUFehwLEE+maloyRbbKrNqcljWsUvUz+W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="348896362"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="348896362"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 00:12:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="871246728"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="871246728"
Received: from sesfandi-mobl.amr.corp.intel.com (HELO [10.209.32.119]) ([10.209.32.119])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 00:12:57 -0700
Message-ID: <6d4a23ee-e30b-3b7c-f911-56b5b1d125dc@linux.intel.com>
Date:   Thu, 4 May 2023 00:12:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] virt: tdx-guest: Add Quote generation support
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Cc:     "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230413034108.1902712-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f33fe0bfb5b6e603bd259942d017076aa5e0015f.camel@intel.com>
 <dc7228c1-d37b-205a-ba81-3fc709fc51a8@linux.intel.com>
 <81c54b8e844d20fe080ddd65458a6036ee22ed33.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <81c54b8e844d20fe080ddd65458a6036ee22ed33.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kai,

On 5/1/23 5:48 AM, Huang, Kai wrote:
> On Sun, 2023-04-30 at 23:03 -0700, Sathyanarayanan Kuppuswamy wrote:
>> Hi Kai,
>>
>> On 4/28/23 6:49 AM, Huang, Kai wrote:

[...]

> 
>>
>>>
>>>> +	args.r10 = TDX_HYPERCALL_STANDARD;
>>>> +	args.r11 = TDVMCALL_GET_QUOTE;
>>>> +	args.r12 = cc_mkdec(virt_to_phys(tdquote));
> 
> Btw can we just use __pa()?  To be honest I am ignorant on the difference
> between virt_to_phys() and __pa(), i.e. when should we use which.

The following link explains the difference. 

https://lkml.indiana.edu/hypermail/linux/kernel/0607.0/1607.html

In x86 ARCH, virt_to_phys() directly calls __pa(). So both are same.

But it looks like the recommendation is to use virt_to_phys().


> 
> Also, you _may_ want to add a comment why "cc_mkdec()" is used.  By the nature
> of this TDVMCALL, it's obvious the buffer needs to be shared, and the VMM must
> check whether the buffer is actually shared, no matter whether the "shared-bit"
> is set here or not.
> 
> So to me it's just requested by the GHCI spec that we need to include the
> "shared-bit", but it _seems_ the GHCI spec doesn't explicitly say we need to do
> that because it only says "Shared buffer as input".  So looks a comment can help
> to clarify a little bit.

I will add it.

>>>
>>>> +
>>>> +/**
>>>> + * struct quote_entry - Quote request struct
>>>> + * @valid: Flag to check validity of the GetQuote request.
>>>> + * @buf: Kernel buffer to share data with VMM (size is page aligned).
>>>> + * @buf_len: Size of the buf in bytes.
>>>> + * @compl: Completion object to track completion of GetQuote request.
>>>> + */
>>>> +struct quote_entry {
>>>> +	bool valid;
>>>> +	void *buf;
>>>> +	size_t buf_len;
>>>> +	struct completion compl;
>>>> +};
>>>
>>> We have a static global @qentry below.
>>>
>>> The buffer size is a fixed size (16K), why do we need @buf_len here?
>>
>> I have added it to support buf length changes in future (like adding a
>> command line option to allow user change the GET_QUOTE_MAX_SIZE).  Also,
>> IMO, using buf_len is more readable than just using GET_QUOTE_MAX_SIZE
>> macro in all places.
>>
>>>
>>> And why do we need @valid?  It seems ...
>>
>> As a precaution against spurious event notification. I also believe that in
>> the future, event notification IRQs may be used for other purposes such as
>> vTPM or other TDVMCALL services, and that this handler may be triggered
>> without a valid GetQuote request. So, before we process the IRQ, I want to
>> make sure we have a valid buffer.
> 
> OK.  This is an shared IRQ basically, so we need to track whether we have any
> GetQuote request pending.
> 
> However I am wondering whether we need a dedicated @valid for this purpose.  If
> I read correctly, we will make sure the buffer is zero-ed when there's no
> request pending, thus can we just use some member in 'tdx_quote_hdr' to track?
> 
> For instance, per-GHCI the 'version' must be set to 1 for a valid request.  And
> I think in a foreseeable future we can also assume @in_len being the size of
> TDREPORT_STRUCT.  Can we use one of them (i.e. version) for this purpose?

IMO, it is better to track it from the guest end (with a dedicated @valid). Since
quote request buffer is shared with the VMM, we should not just rely on its value
to decide whether we have an active request. If needed, in addition to the "@valid"
check we can also include check for @version. Also, I think we will not lose much
using a "bool" value to track the quote buffer valid status.



>>>> diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-guest.h
>>>> index a6a2098c08ff..500cdfa025ad 100644
>>>> --- a/include/uapi/linux/tdx-guest.h
>>>> +++ b/include/uapi/linux/tdx-guest.h
>>>> @@ -17,6 +17,12 @@
>>>>  /* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
>>>>  #define TDX_REPORT_LEN                  1024
>>>>  
>>>> +/* TD Quote status codes */
>>>> +#define GET_QUOTE_SUCCESS               0
>>>> +#define GET_QUOTE_IN_FLIGHT             0xffffffffffffffff
>>>> +#define GET_QUOTE_ERROR                 0x8000000000000000
>>>> +#define GET_QUOTE_SERVICE_UNAVAILABLE   0x8000000000000001
>>>> +
>>>>  /**
>>>>   * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT0 IOCTL.
>>>>   *
>>>> @@ -30,6 +36,35 @@ struct tdx_report_req {
>>>>  	__u8 tdreport[TDX_REPORT_LEN];
>>>>  };
>>>>  
>>>> +/* struct tdx_quote_hdr: Format of Quote request buffer header.
>>>> + * @version: Quote format version, filled by TD.
>>>> + * @status: Status code of Quote request, filled by VMM.
>>>> + * @in_len: Length of TDREPORT, filled by TD.
>>>> + * @out_len: Length of Quote data, filled by VMM.
>>>> + * @data: Quote data on output or TDREPORT on input.
>>>> + *
>>>> + * More details of Quote data header can be found in TDX
>>>> + * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
>>>> + * section titled "TDG.VP.VMCALL<GetQuote>"
>>>> + */
>>>> +struct tdx_quote_hdr {
>>>> +	__u64 version;
>>>> +	__u64 status;
>>>> +	__u32 in_len;
>>>> +	__u32 out_len;
>>>> +	__u64 data[];
>>>> +};
>>>
>>> This structure is weird.  It's a header, but it contains the dynamic-size
>>> buffer.  If you have __data[] in this structure, then it is already a buffer for
>>> the entire Quote, no?  Then should we just call it 'struct tdx_quote'?
>>>
>>> Or do you want to remove __data[]?
>>
>> I can name it as struct tdx_quote_data
> 
> If go with route, why not just 'tdx_quote', or 'tdx_tdquote'?
> 
> Or, actually I think 'tdx_quote' (or 'tdx_tdquote') seems to be the format of
> the _true_ Quote, so perhaps we want 'struct tdx_quote_req_buf'?
> 

Since this buffer is used for both request/response, we can just use
struct tdx_quote_buf.

>>
>>>
>>>> +
>>>> +/* struct tdx_quote_req: Request struct for TDX_CMD_GET_QUOTE IOCTL.
>>>> + * @buf: Address of user buffer that includes TDREPORT. Upon successful
>>>> + *	 completion of IOCTL, output is copied back to the same buffer.
>>>
>>> This description isn't precise.  "user buffer that includes TDREPORT" doesn't
>>> tell application writer where to put the TDREPORT at all.  We need to explicitly
>>> call out the buffer starts with 'tdx_quote_hdr' followed by TDREPORT
>>> immediately.
>>
>> I have specified it in struct tdx_quote_hdr.data help content.
> 
> Perhaps I missed something but I didn't say at any place this is clearly
> documented.  The comment around @data above certainly doesn't.
> 
> Just say something like:
> 
> 	@buf: The userspace pointer which points to the
> 	      'struct tdx_quote_req_buf' (whatever the final name)
> 
>>
>>>  
>>>> + * @len: Length of the Quote buffer.
>>>> + */
>>>> +struct tdx_quote_req {
>>>> +	__u64 buf;
>>>> +	__u64 len;
>>>> +};
>>>> +
>>>>  /*
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
