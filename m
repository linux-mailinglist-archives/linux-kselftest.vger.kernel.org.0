Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596776752C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 11:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjATKuD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 05:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjATKuB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 05:50:01 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6A58F
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 02:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674211800; x=1705747800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yDfXRh62CXOhxwkokMUICkJH6hx8gFfOCEE7kFzoojM=;
  b=LgIRTpPmVrqnNbH7h78XyEC2ON4aOLbYMVGOGEg8otUF3eK7lNTFEtmp
   4blMU8QbanxX5nPd81vkmGOgdbg9qFcO90W7uI1j0lisrYRWG6g25sqG4
   lMNJjzuE2Hmpe3EPMM/juepB5vyfTi1RmPqvcQpV/23hdKE77XU9HkABZ
   2u7hYzI0OasrKsQHSyBFL0wBX43Ai8als+4Qqq0y/wHJGs0BLtV2czMn1
   G+pKlRcUg54tyaFBvmISRJdPJFQmw+kHPkBJyUj/FI35mr1g+n/OuSwsQ
   hagr+MKc7LF692jQSHCudYs3o1CVnlpS/lCdTTpzLg+Kh3m5/YBScvIKo
   w==;
X-IronPort-AV: E=Sophos;i="5.97,232,1669046400"; 
   d="scan'208";a="219701726"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2023 18:49:57 +0800
IronPort-SDR: rcepM6KJF/2tHxXXrzAFspjanpHE+fTxQ/I/VVwqRsP+wdiTno35j6a65nBM01mKB8rLmNs3te
 Zp7OTNPCCb+6NssZ8zx4zrQ1VtFLWRhTohFnceeae6+HBRX13sm8SR31kH+6O/H0G/U+4B5PEa
 apw7whNx6y5myeVBWHRofholyUFTbbiM2RIluy1zUr7jVV513eDTCT5kQrNsXiPw2Cg9/N3jMh
 qz8vo7SVCX/+i8OHnlbYa2FZyH6uYdVUJYQYqffgsncHDZjkZ5T+TRdt5B87fY4GD+pqBWCUap
 deE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2023 02:01:51 -0800
IronPort-SDR: 2r9DCTmxZ+wJhyQYpPZJA594iDUkLRZGuyWFIABXb6aZc0XJkAO+jQrwK3RKmcZpaTXkItRv/u
 gPBN35lYs4jj2wLPS2Rd7JWjAN9o94m+oG05g90tW2Xxx2LziRVT/hQsxmis/K65Ok2E0+4sQZ
 QdE0uANou63w8PbGzkSpJLajzczaLhcG86ebsrf8HTYUEuGvorzJVaYvz682oq9OUIdCKg5t0v
 JsmRglW4md2IQJrnfNXkFWXHcddT074jpASlFXkAhzp5LBUgpuX65rGEuQPldTaPqFhd7ikkDx
 WgI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2023 02:49:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nyx8j2bDfz1Rwt8
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 02:49:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674211795; x=1676803796; bh=yDfXRh62CXOhxwkokMUICkJH6hx8gFfOCEE
        7kFzoojM=; b=IKIlu8sKhW69D9kmzWqNRa5wDX/WdgQiojQQf/8grzSmBWVsoK1
        5III3ooowvXfG04nsLri3yaRhGHrDvgq4ZoxNZKR4KNFdPaLZZb4Oa9EbfVrNDIO
        CqQ6+MFx4cyY5E3H0YpdPcvzvndxVSxJFgy4P5nDoU66e/ShAlBZLzaWpyKlhRpl
        rOQlD8GIYj9b3HI+mLR6qpbv8zMoYPheOxSWdCKlvVoWrKERIoI2ibqqNxm96Dqf
        IPxZ1NbREKyaTJQ4K5TK/AN0wytLoRVuIUiKg+x/Kx+s8WxlDFoUWMvGuyVIZz72
        5wh9dvs6nAFwb0pLdLQHKQULZPRK2CZXR8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YubodKjaHckY for <linux-kselftest@vger.kernel.org>;
        Fri, 20 Jan 2023 02:49:55 -0800 (PST)
Received: from [10.225.163.44] (unknown [10.225.163.44])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nyx8d0FFgz1RvLy;
        Fri, 20 Jan 2023 02:49:52 -0800 (PST)
Message-ID: <a324b292-8e3f-686e-ee6f-846fd7678192@opensource.wdc.com>
Date:   Fri, 20 Jan 2023 19:49:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] ptrace,syscall_user_dispatch: Implement Syscall User
 Dispatch Suspension
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org,
        adobriyan@gmail.com, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
References: <20230118201055.147228-1-gregory.price@memverge.com>
 <20230118201055.147228-2-gregory.price@memverge.com>
 <Y8prnDT0YUhEzI8+@hirez.programming.kicks-ass.net>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y8prnDT0YUhEzI8+@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/20/23 19:23, Peter Zijlstra wrote:
> On Wed, Jan 18, 2023 at 03:10:53PM -0500, Gregory Price wrote:
>> Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
>> modify Syscall User Dispatch to suspend interception when enabled.
>>
>> This is modeled after the SUSPEND_SECCOMP feature, which suspends
>> SECCOMP interposition.  Without doing this, software like CRIU will
>> inject system calls into a process and be intercepted by Syscall
>> User Dispatch, either causing a crash (due to blocked signals) or
>> the delivery of those signals to a ptracer (not the intended behavior).
>>
>> Since Syscall User Dispatch is not a privileged feature, a check
>> for permissions is not required, however attempting to set this
>> option when CONFIG_CHECKPOINT_RESTORE it not supported should be
>> disallowed, as its intended use is checkpoint/resume.
>>
>> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> 
> One small nit -- see below, otherwise:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
>> ---
>>  include/linux/ptrace.h               | 2 ++
>>  include/uapi/linux/ptrace.h          | 6 +++++-
>>  kernel/entry/syscall_user_dispatch.c | 5 +++++
>>  kernel/ptrace.c                      | 5 +++++
>>  4 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
>> index eaaef3ffec22..461ae5c99d57 100644
>> --- a/include/linux/ptrace.h
>> +++ b/include/linux/ptrace.h
>> @@ -45,6 +45,8 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
>>  
>>  #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
>>  #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
>> +#define PT_SUSPEND_SYSCALL_USER_DISPATCH \
>> +	(PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH << PT_OPT_FLAG_SHIFT)
>>  
>>  extern long arch_ptrace(struct task_struct *child, long request,
>>  			unsigned long addr, unsigned long data);
>> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
>> index 195ae64a8c87..ba9e3f19a22c 100644
>> --- a/include/uapi/linux/ptrace.h
>> +++ b/include/uapi/linux/ptrace.h
>> @@ -146,9 +146,13 @@ struct ptrace_rseq_configuration {
>>  /* eventless options */
>>  #define PTRACE_O_EXITKILL		(1 << 20)
>>  #define PTRACE_O_SUSPEND_SECCOMP	(1 << 21)
>> +#define PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH	(1 << 22)
>>  
>>  #define PTRACE_O_MASK		(\
>> -	0x000000ff | PTRACE_O_EXITKILL | PTRACE_O_SUSPEND_SECCOMP)
>> +	0x000000ff | \
>> +	PTRACE_O_EXITKILL | \
>> +	PTRACE_O_SUSPEND_SECCOMP | \
>> +	PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)
>>  
>>  #include <asm/ptrace.h>
>>  
>> diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
>> index 0b6379adff6b..7607f4598dd8 100644
>> --- a/kernel/entry/syscall_user_dispatch.c
>> +++ b/kernel/entry/syscall_user_dispatch.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/uaccess.h>
>>  #include <linux/signal.h>
>>  #include <linux/elf.h>
>> +#include <linux/ptrace.h>
>>  
>>  #include <linux/sched/signal.h>
>>  #include <linux/sched/task_stack.h>
>> @@ -36,6 +37,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
>>  	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
>>  	char state;
>>  
>> +	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
>> +		unlikely(current->ptrace & PT_SUSPEND_SYSCALL_USER_DISPATCH))
> 
> Align with the '(' pleaase.
> 
>> +		return false;
>> +
>>  	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
>>  		return false;
>>  
>> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
>> index 54482193e1ed..a6ad815bd4be 100644
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -370,6 +370,11 @@ static int check_ptrace_options(unsigned long data)
>>  	if (data & ~(unsigned long)PTRACE_O_MASK)
>>  		return -EINVAL;
>>  
>> +	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)) {
>> +		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTART))

Why not one if with a && ?

>> +			return -EINVAL;
>> +	}
>> +
>>  	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
>>  		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
>>  		    !IS_ENABLED(CONFIG_SECCOMP))
>> -- 
>> 2.39.0
>>

-- 
Damien Le Moal
Western Digital Research

