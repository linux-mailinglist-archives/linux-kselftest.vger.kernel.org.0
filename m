Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C4C318528
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 07:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhBKGSA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 01:18:00 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:8275 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhBKGR6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 01:17:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UOPAVzo_1613024232;
Received: from 30.27.210.10(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UOPAVzo_1613024232)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Feb 2021 14:17:13 +0800
Subject: Re: [PATCH v4 5/5] x86/sgx: Remove redundant if conditions in
 sgx_encl_create
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210201132653.35690-1-tianjia.zhang@linux.alibaba.com>
 <20210201132653.35690-6-tianjia.zhang@linux.alibaba.com>
 <YBnMeT32niwOW0K2@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <5b48cbcb-4ef2-9c18-29cc-ef3f30d37180@linux.alibaba.com>
Date:   Thu, 11 Feb 2021 14:17:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBnMeT32niwOW0K2@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2/3/21 6:04 AM, Jarkko Sakkinen wrote:
> On Mon, Feb 01, 2021 at 09:26:53PM +0800, Tianjia Zhang wrote:
>> In this scenario, there is no case where va_page is NULL, and
>> the error has been checked. The if condition statement here is
> 
> if-condition, i.e. dash missing
> 

Will do in the next patch.

Thanks,
Tianjia

>> redundant, so remove the condition detection.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   arch/x86/kernel/cpu/sgx/ioctl.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
>> index 1c6ecf9fbeff..719c21cca569 100644
>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>> @@ -66,9 +66,10 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>>   	va_page = sgx_encl_grow(encl);
>>   	if (IS_ERR(va_page))
>>   		return PTR_ERR(va_page);
>> -	else if (va_page)
>> -		list_add(&va_page->list, &encl->va_pages);
>> -	/* else the tail page of the VA page list had free slots. */
>> +	if (!va_page)
>> +		return -EIO;
>> +
>> +	list_add(&va_page->list, &encl->va_pages);
>>   
>>   	/* The extra page goes to SECS. */
>>   	encl_size = secs->size + PAGE_SIZE;
>> -- 
>> 2.19.1.3.ge56e4f7
>>
>>
> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> /Jarkko
> 
