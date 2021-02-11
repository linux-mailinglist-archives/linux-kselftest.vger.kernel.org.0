Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C87318526
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 07:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhBKGQH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 01:16:07 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:46330 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhBKGQF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 01:16:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UOPaBHJ_1613024116;
Received: from 30.27.210.10(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UOPaBHJ_1613024116)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Feb 2021 14:15:17 +0800
Subject: Re: [PATCH v4 2/5] x86/sgx: Reduce the locking range in
 sgx_sanitize_section()
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
 <20210201132653.35690-3-tianjia.zhang@linux.alibaba.com>
 <YBnLaEz0hi/s9T8X@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <ef2fb93a-819a-fb67-b3d0-b0aa5a7e62bf@linux.alibaba.com>
Date:   Thu, 11 Feb 2021 14:15:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBnLaEz0hi/s9T8X@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2/3/21 6:00 AM, Jarkko Sakkinen wrote:
> On Mon, Feb 01, 2021 at 09:26:50PM +0800, Tianjia Zhang wrote:
>> The spin lock of sgx_epc_section only locks the page_list. The
>> EREMOVE operation and init_laundry_list is not necessary in the
>> protection range of the spin lock. This patch reduces the lock
>> range of the spin lock in the function sgx_sanitize_section()
>> and only protects the operation of the page_list.
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> I'm not confident that this change has any practical value.
> 
> /Jarkko
> 

As a process executed during initialization, this optimization effect 
may not be obvious. If possible, this critical area can be moved outside 
to protect the entire while loop.

Best regards,
Tianjia
>> ---
>>   arch/x86/kernel/cpu/sgx/main.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
>> index c519fc5f6948..4465912174fd 100644
>> --- a/arch/x86/kernel/cpu/sgx/main.c
>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>> @@ -41,20 +41,17 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
>>   		if (kthread_should_stop())
>>   			return;
>>   
>> -		/* needed for access to ->page_list: */
>> -		spin_lock(&section->lock);
>> -
>>   		page = list_first_entry(&section->init_laundry_list,
>>   					struct sgx_epc_page, list);
>>   
>>   		ret = __eremove(sgx_get_epc_virt_addr(page));
>> -		if (!ret)
>> +		if (!ret) {
>> +			spin_lock(&section->lock);
>>   			list_move(&page->list, &section->page_list);
>> -		else
>> +			spin_unlock(&section->lock);
>> +		} else
>>   			list_move_tail(&page->list, &dirty);
>>   
>> -		spin_unlock(&section->lock);
>> -
>>   		cond_resched();
>>   	}
>>   
>> -- 
>> 2.19.1.3.ge56e4f7
>>
>>
