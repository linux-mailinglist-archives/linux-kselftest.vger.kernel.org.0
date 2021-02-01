Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD430A68B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Feb 2021 12:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhBAL3f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Feb 2021 06:29:35 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35516 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229495AbhBAL3a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Feb 2021 06:29:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UNaSvLm_1612178922;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UNaSvLm_1612178922)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 19:28:43 +0800
Subject: Re: [PATCH v3 1/5] selftests/x86: Simplify the code to get vdso base
 address in sgx
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <YA8KJXkLRnaDot58@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <f8f699ba-cc43-4904-f8c8-c4f2781269a5@linux.alibaba.com>
Date:   Mon, 1 Feb 2021 19:28:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YA8KJXkLRnaDot58@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 1/26/21 2:12 AM, Jarkko Sakkinen wrote:
> What the short summary is saying now, is that this commit would make the
> existing code to use vDSO base address. It's already doing that.
> 
> You could instead just "Use getauxval() to simplify the code".
> 
> Also, I'd prefer to properly use upper and lower case letter, e.g.  vDSO
> instead of vdso.
> 
> Reply-To:
> In-Reply-To: <20210124062907.88229-2-tianjia.zhang@linux.alibaba.com>
> 
> On Sun, Jan 24, 2021 at 02:29:03PM +0800, Tianjia Zhang wrote:
>> This patch uses the library function `getauxval(AT_SYSINFO_EHDR)`
>> instead of the custom function `vdso_get_base_addr` to obtain the
> 
> Use either double or single quotation mark instead of hyphen.
> 
>> base address of vDSO, which will simplify the code implementation.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> This needs to be imperative form, e.g. "Simplify the code implemntation
> by using getauxval() instead of a custom function."
> 
>> ---
>>   tools/testing/selftests/sgx/main.c | 24 ++++--------------------
>>   1 file changed, 4 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
>> index 724cec700926..365d01dea67b 100644
>> --- a/tools/testing/selftests/sgx/main.c
>> +++ b/tools/testing/selftests/sgx/main.c
>> @@ -15,6 +15,7 @@
>>   #include <sys/stat.h>
>>   #include <sys/time.h>
>>   #include <sys/types.h>
>> +#include <sys/auxv.h>
>>   #include "defines.h"
>>   #include "main.h"
>>   #include "../kselftest.h"
>> @@ -28,24 +29,6 @@ struct vdso_symtab {
>>   	Elf64_Word *elf_hashtab;
>>   };
>>   
>> -static void *vdso_get_base_addr(char *envp[])
>> -{
>> -	Elf64_auxv_t *auxv;
>> -	int i;
>> -
>> -	for (i = 0; envp[i]; i++)
>> -		;
>> -
>> -	auxv = (Elf64_auxv_t *)&envp[i + 1];
>> -
>> -	for (i = 0; auxv[i].a_type != AT_NULL; i++) {
>> -		if (auxv[i].a_type == AT_SYSINFO_EHDR)
>> -			return (void *)auxv[i].a_un.a_val;
>> -	}
>> -
>> -	return NULL;
>> -}
>> -
>>   static Elf64_Dyn *vdso_get_dyntab(void *addr)
>>   {
>>   	Elf64_Ehdr *ehdr = addr;
>> @@ -162,7 +145,7 @@ static int user_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r
>>   	return 0;
>>   }
>>   
>> -int main(int argc, char *argv[], char *envp[])
>> +int main(int argc, char *argv[])
>>   {
>>   	struct sgx_enclave_run run;
>>   	struct vdso_symtab symtab;
>> @@ -203,7 +186,8 @@ int main(int argc, char *argv[], char *envp[])
>>   	memset(&run, 0, sizeof(run));
>>   	run.tcs = encl.encl_base;
>>   
>> -	addr = vdso_get_base_addr(envp);
>> +	/* Get vDSO base address */
>> +	addr = (void *)(uintptr_t)getauxval(AT_SYSINFO_EHDR);
> 
> You could just case the result the result directly to void *.
> 
>>   	if (!addr)
>>   		goto err;
>>   
>> -- 
>> 2.19.1.3.ge56e4f7
>>
>>
> 
> /Jarkko
> 

Thanks for your suggestions, I will fix it in the v4 patchset.

Best regards,
Tianjia
