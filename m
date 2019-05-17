Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D54B72196E
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2019 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfEQN5G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 May 2019 09:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728920AbfEQN5F (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 May 2019 09:57:05 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4C120873;
        Fri, 17 May 2019 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558101424;
        bh=GykiXS/2dOvX6tWCzLuVJ+9+sTQOOXsEsCcwgosON8U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=t7X8C7Ez4y7p5NOEBpIBgX4C+ZHPnMEJuO6m1lyUGnp294RuzzXIM8/f859bCFEaZ
         /u4+qS1l/7LLAKWdx2UMwZHtsyUSVs2BXaEo24NRzuEpkssL7p5YqUNVn14kXmqU0h
         SPTlzoXmwIVi8qc2zcSrVv2ECwDmojDBIUlUR3oQ=
Subject: Re: [PATCH v3] selftests/x86: Support Atom for syscall_arg_fault test
To:     "Tong, Bo" <bo.tong@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>
References: <1555657855-31855-1-git-send-email-bo.tong@intel.com>
 <263afb6f-48dc-fbe7-5b13-13ce3f322ecc@kernel.org>
 <D6542591582C6645851595B3517A02963F16F195@shsmsx102.ccr.corp.intel.com>
From:   shuah <shuah@kernel.org>
Message-ID: <9e3e4e85-d1d8-a72f-d820-96f4fad9f23b@kernel.org>
Date:   Fri, 17 May 2019 07:56:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <D6542591582C6645851595B3517A02963F16F195@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Bo,

On 5/17/19 1:02 AM, Tong, Bo wrote:
> Is this patch going to be merged? Or still any blocking issue there?
> 
> Thanks,
> Bo
> 
> -----Original Message-----
> From: shuah [mailto:shuah@kernel.org]
> Sent: Friday, April 19, 2019 10:05 PM
> To: Tong, Bo <bo.tong@intel.com>; luto@kernel.org; x86@kernel.org
> Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; skhan@linuxfoundation.org; shuah@kernel.org
> Subject: Re: [PATCH v3] selftests/x86: Support Atom for syscall_arg_fault test
> 
> On 4/19/19 1:10 AM, Tong Bo wrote:
>> Atom-based CPUs trigger stack fault when invoke 32-bit SYSENTER
>> instruction with invalid register values. So we also need SIGBUS handling in this case.
>>
>> Following is assembly when the fault exception happens.
>>
>> (gdb) disassemble $eip
>> Dump of assembler code for function __kernel_vsyscall:
>>      0xf7fd8fe0 <+0>:     push   %ecx
>>      0xf7fd8fe1 <+1>:     push   %edx
>>      0xf7fd8fe2 <+2>:     push   %ebp
>>      0xf7fd8fe3 <+3>:     mov    %esp,%ebp
>>      0xf7fd8fe5 <+5>:     sysenter
>>      0xf7fd8fe7 <+7>:     int    $0x80
>> => 0xf7fd8fe9 <+9>:     pop    %ebp
>>      0xf7fd8fea <+10>:    pop    %edx
>>      0xf7fd8feb <+11>:    pop    %ecx
>>      0xf7fd8fec <+12>:    ret
>> End of assembler dump.
>>
>> According to Intel SDM, this could also be a Stack Segment Fault(#SS,
>> 12), except a normal Page Fault(#PF, 14). Especially, in section 6.9
>> of Vol.3A, both stack and page faults are within the 10th(lowest
>> priority) class, and as it said, "exceptions within each class are
>> implementation-dependent and may vary from processor to processor".
>> It's expected for processors like Intel Atom to trigger stack
>> fault(SIGBUS), while we get page fault(SIGSEGV) from common Core processors.
>>
>> Signed-off-by: Tong Bo <bo.tong@intel.com>
>> Acked-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>    tools/testing/selftests/x86/syscall_arg_fault.c | 10 ++++++++--
>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c
>> b/tools/testing/selftests/x86/syscall_arg_fault.c
>> index 7db4fc9..d2548401 100644
>> --- a/tools/testing/selftests/x86/syscall_arg_fault.c
>> +++ b/tools/testing/selftests/x86/syscall_arg_fault.c
>> @@ -43,7 +43,7 @@ static sigjmp_buf jmpbuf;
>>    
>>    static volatile sig_atomic_t n_errs;
>>    
>> -static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
>> +static void sigsegv_or_sigbus(int sig, siginfo_t *info, void
>> +*ctx_void)
>>    {
>>    	ucontext_t *ctx = (ucontext_t*)ctx_void;
>>    
>> @@ -73,7 +73,13 @@ int main()
>>    	if (sigaltstack(&stack, NULL) != 0)
>>    		err(1, "sigaltstack");
>>    
>> -	sethandler(SIGSEGV, sigsegv, SA_ONSTACK);
>> +	sethandler(SIGSEGV, sigsegv_or_sigbus, SA_ONSTACK);
>> +	/*
>> +	 * The actual exception can vary.  On Atom CPUs, we get #SS
>> +	 * instead of #PF when the vDSO fails to access the stack when
>> +	 * ESP is too close to 2^32, and #SS causes SIGBUS.
>> +	 */
>> +	sethandler(SIGBUS, sigsegv_or_sigbus, SA_ONSTACK);
>>    	sethandler(SIGILL, sigill, SA_ONSTACK);
>>    
>>    	/*
>>
> 
> In case there is a dependency on x86 tree, here is my Ack
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 

Looks like it got left behind in the confusion of which tree.

I will apply this to my tree.

thanks,
-- Shuah
