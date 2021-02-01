Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6459630A822
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Feb 2021 13:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhBAM4s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Feb 2021 07:56:48 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:42581 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231584AbhBAM4o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Feb 2021 07:56:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UNa.ooL_1612184152;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UNa.ooL_1612184152)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 20:55:53 +0800
Subject: Re: [PATCH v3 4/5] x86/sgx: Allows ioctl PROVISION to execute before
 CREATE
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
 <20210124062907.88229-5-tianjia.zhang@linux.alibaba.com>
 <YBVefNF9x4mQRpSB@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <478a3f95-c11e-ea37-2a80-c0976c7a189e@linux.alibaba.com>
Date:   Mon, 1 Feb 2021 20:55:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBVefNF9x4mQRpSB@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 1/30/21 9:26 PM, Jarkko Sakkinen wrote:
> On Sun, Jan 24, 2021 at 02:29:06PM +0800, Tianjia Zhang wrote:
>> In the function sgx_create_enclave(), the direct assignment
>> operation of attributes_mask determines that the ioctl PROVISION
>> operation must be executed after the ioctl CREATE operation,
>> which will limit the flexibility of sgx developers.
>>
>> This patch takes the assignment of `attributes_mask` from the
>> function sgx_create_enclave() has been moved to the function
>> sgx_open() to avoid this restriction.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> The commit message should explicit that the API behaviour changes
> as the result. Please don't use hyphens in quoting.
> 
> /Jarkko
> 

Will be improved in the next version.

Best regards,
Tianjia

>> ---
>>   arch/x86/kernel/cpu/sgx/driver.c | 1 +
>>   arch/x86/kernel/cpu/sgx/ioctl.c  | 1 -
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
>> index f2eac41bb4ff..fba0d0bfe976 100644
>> --- a/arch/x86/kernel/cpu/sgx/driver.c
>> +++ b/arch/x86/kernel/cpu/sgx/driver.c
>> @@ -36,6 +36,7 @@ static int sgx_open(struct inode *inode, struct file *file)
>>   		return ret;
>>   	}
>>   
>> +	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
>>   	file->private_data = encl;
>>   
>>   	return 0;
>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
>> index 90a5caf76939..1c6ecf9fbeff 100644
>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>> @@ -109,7 +109,6 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>>   	encl->base = secs->base;
>>   	encl->size = secs->size;
>>   	encl->attributes = secs->attributes;
>> -	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
>>   
>>   	/* Set only after completion, as encl->lock has not been taken. */
>>   	set_bit(SGX_ENCL_CREATED, &encl->flags);
>> -- 
>> 2.19.1.3.ge56e4f7
>>
>>
