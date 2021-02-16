Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C48B31C5CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Feb 2021 04:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhBPDbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 22:31:01 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40303 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhBPDbA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 22:31:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UOk85wU_1613446213;
Received: from 30.25.189.44(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UOk85wU_1613446213)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Feb 2021 11:30:14 +0800
Subject: Re: [PATCH v3 3/5] x86/sgx: Optimize the free_cnt count in
 sgx_epc_section
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
 <20210124062907.88229-4-tianjia.zhang@linux.alibaba.com>
 <YBGlodsOaX4cWAtl@kernel.org>
 <abd77ee8-0311-1664-f3ee-6d4a9fe512b1@linux.alibaba.com>
 <YCZyVXIeeYqNK+sy@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <483f1ff9-9022-b7fc-5931-79c0c83f1289@linux.alibaba.com>
Date:   Tue, 16 Feb 2021 11:30:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCZyVXIeeYqNK+sy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2/12/21 8:19 PM, Jarkko Sakkinen wrote:
> On Thu, Feb 11, 2021 at 02:04:12PM +0800, Tianjia Zhang wrote:
>> Hi,
>>
>> Sorry for the late reply.
>>
>> On 1/28/21 1:40 AM, Jarkko Sakkinen wrote:
>>> I could bet some money that this does not bring any significant
>>> performance gain.
>>>
>>
>> Yes, this does not bring performance gains. This is not a change for
>> performance, mainly to make the value of free_cnt look more accurate.
>>
>>> On Sun, Jan 24, 2021 at 02:29:05PM +0800, Tianjia Zhang wrote:
>>>> `section->free_cnt` represents the free page in sgx_epc_section,
>>>> which is assigned once after initialization. In fact, just after the
>>>> initialization is completed, the pages are in the `init_laundry_list`
>>>> list and cannot be allocated. This needs to be recovered by EREMOVE
>>>> of function sgx_sanitize_section() before it can be used as a page
>>>> that can be allocated. The sgx_sanitize_section() will be called in
>>>> the kernel thread ksgxd.
>>>>
>>>> This patch moves the initialization of `section->free_cnt` from the
>>>> initialization function `sgx_setup_epc_section()` to the function
>>>> `sgx_sanitize_section()`, and then accumulates the count after the
>>>
>>> Use single quotes instead of hyphens.
>>>>> successful execution of EREMOVE. This seems to be more reasonable,
>>>> free_cnt will also truly reflect the allocatable free pages in EPC.
>>>>
>>>> Sined-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>>> Reviewed-by: Sean Christopherson <seanjc@google.com>
>>>> ---
>>>>    arch/x86/kernel/cpu/sgx/main.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
>>>> index 4465912174fd..e455ec7b3449 100644
>>>> --- a/arch/x86/kernel/cpu/sgx/main.c
>>>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>>>> @@ -48,6 +48,7 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
>>>>    		if (!ret) {
>>>>    			spin_lock(&section->lock);
>>>>    			list_move(&page->list, &section->page_list);
>>>> +			section->free_cnt++;
>>>>    			spin_unlock(&section->lock);
>>>
>>> Someone can try to allocate a page while sanitize process is in progress.
>>>
>>> I think it is better to keep critical sections in the form that when you
>>> leave from one, the global state is legit.
>>>
>>
>> Do you mean to move the critical section to protect the entire while loop?
>> Of course, this is also possible, sanitize is a process only needed for
>> initialization, and the possibility of conflict is very small.
>>
>> Best regards,
>> Tianjia
> 
> The big picture of this change to me, to be frank is that it's completely
> useless.
> 
> Please start with the picture.
> 
> /Jarkko
> 

I carefully considered your suggestion, and I will delete 2/5 and 3/5 in 
the next version.

Best regards,
Tianjia
