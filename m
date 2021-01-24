Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38F301A39
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Jan 2021 07:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbhAXGhe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jan 2021 01:37:34 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:44124 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbhAXGhd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jan 2021 01:37:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UMf9zfj_1611470187;
Received: from 30.25.221.71(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UMf9zfj_1611470187)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Jan 2021 14:36:28 +0800
Subject: Re: [PATCH] x86/sgx: Allows ioctl PROVISION to execute before CREATE
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, haitao.huang@intel.com,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210118133335.98907-1-tianjia.zhang@linux.alibaba.com>
 <YAc7h3zQR06eWPhZ@google.com>
 <5037ee56-0211-f16c-3ea0-86cf8146b7f8@linux.alibaba.com>
 <YAiwA/oQkOVuTO+7@kernel.org> <YAiwrDrAsxHVowhV@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <b8e338e7-2436-dbc6-8bc5-bdfc43aed225@linux.alibaba.com>
Date:   Sun, 24 Jan 2021 14:36:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAiwrDrAsxHVowhV@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 1/21/21 6:37 AM, Jarkko Sakkinen wrote:
> On Thu, Jan 21, 2021 at 12:34:49AM +0200, Jarkko Sakkinen wrote:
>> On Wed, Jan 20, 2021 at 11:57:18AM +0800, Tianjia Zhang wrote:
>>> Hi,
>>>
>>> On 1/20/21 4:05 AM, Sean Christopherson wrote:
>>>> On Mon, Jan 18, 2021, Tianjia Zhang wrote:
>>>>> In function sgx_encl_create(), the logic of directly assigning
>>>>> value to attributes_mask determines that the call to
>>>>> SGX_IOC_ENCLAVE_PROVISION must be after the command of
>>>>> SGX_IOC_ENCLAVE_CREATE. If change this assignment statement to
>>>>> or operation, the PROVISION command can be executed earlier and
>>>>> more flexibly.
>>>>>
>>>>> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
>>>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>>>> ---
>>>>>    arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
>>>>> index f45957c05f69..0ca3fc238bc2 100644
>>>>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>>>>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>>>>> @@ -108,7 +108,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>>>>>    	encl->base = secs->base;
>>>>>    	encl->size = secs->size;
>>>>>    	encl->attributes = secs->attributes;
>>>>> -	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
>>>>> +	encl->attributes_mask |= SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
>>>>
>>>> Alternatively, move the existing code to sgx_open()?  Initializing the field
>>>> when the encl object is allocated feels more correct.
>>>>
>>>
>>>
>>> This seems like a good idea. Thanks for your suggestion. I have sent v2
>>> patch, include the next two patches.
>>
>> Did you ask from Sean about suggested-by's? Now it looks like
>> that doing these patches were originally proposed by Sean.
> 
> Please do not add tags from people *unauthentically*. I do not
> see anything from Sean to any of the patches that would suggest
> adding those tags. You are basically just stamping that to all
> patches, which he has given a code review. Can you stop doing
> this?
> 
> /Jarkko
> 

I am very sorry for the trouble caused to you, I have made improvements 
in the new patch, thanks for your suggestions.

Best regards,
Tianjia
