Return-Path: <linux-kselftest+bounces-12293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23A990FB5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 04:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E7628371B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 02:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4910A18AEA;
	Thu, 20 Jun 2024 02:35:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86C1E86F;
	Thu, 20 Jun 2024 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718850921; cv=none; b=hZsxzC4SaJpVoNohsmJyk1Nv7xMSs0/+XpWA/lxLLgNoo1Oz7wXAlqn4HAUbvR7vJxbO7aaupV9bmaFzmeBEraPzWYi8jVrzEorINMN5NRpMXq9M0RcKW1u5KzU07z+1WHndlrQ640p0UWAzPo0Z5IzE+bRyzVL7WfMJOSjkSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718850921; c=relaxed/simple;
	bh=3Xf6+H2T/FJwkmEgtqAMDL/X6rrcfLj9UjgwhzQ2aMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=cbTSjpRvzHRZqS27bImuHU2ya6rm8u+aOwOZIdsnXiF27o1eqi7oTRM5UqC/5yQRdje72AWFUAkH9yhPX4D9mrmDl6u9Th8ahObJkM2r1MphCSb1T8AOjCRw6wjnjEAMRMRnMl7kqVtpsen39ESFm6ewf3r6E0Fw3kTfPdTl+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.12.218] (unknown [121.237.44.152])
	by APP-05 (Coremail) with SMTP id zQCowACnrgIzlXNmuyXEEQ--.59667S2;
	Thu, 20 Jun 2024 10:34:28 +0800 (CST)
Message-ID: <426b4cba-28c2-4f47-9db5-70df477c9634@iscas.ac.cn>
Date: Thu, 20 Jun 2024 10:34:26 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] riscv: Expose orig_a0 in the user_regs_struct
 structure
To: Charlie Jenkins <charlie@rivosinc.com>
References: <cover.1718693532.git.zhouquan@iscas.ac.cn>
 <d4c7da80b72375c75836303bc744e4db9eeec218.1718693532.git.zhouquan@iscas.ac.cn>
 <ZnOARMA1I0yRoNh8@ghost>
Content-Language: en-US
From: Quan Zhou <zhouquan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, oleg@redhat.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
 shuah@kernel.org
In-Reply-To: <ZnOARMA1I0yRoNh8@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnrgIzlXNmuyXEEQ--.59667S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArWxAFWfXryUuF1rXw4DCFg_yoW5XF1DpF
	ZakwnFkF4kury8K342va15Xr1jywsxG347KrWfJ345ta4jyFW5WrnxKwn8Jrn3Ja90qFyI
	qFyagry3Aan8ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JV
	WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7IU82YLPUUUUU==
X-CM-SenderInfo: 52kr31xxdqqxpvfd2hldfou0/1tbiCQ8OBmZzQb3X9gAAsG


On 2024/6/20 09:05, Charlie Jenkins wrote:
> On Wed, Jun 19, 2024 at 10:01:27AM +0800, zhouquan@iscas.ac.cn wrote:
>> From: Quan Zhou <zhouquan@iscas.ac.cn>
>>
>> Expose orig_a0 to userspace to ensure that users can modify
>> the actual value of `a0` in the traced process through the
>> ptrace(PTRACE_SETREGSET, ...) path. Since user_regs_struct is
>> a subset of pt_regs, we also need to adjust the position of
>> the orig_a0 field in pt_regs to achieve the correct copy.
>>
>> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
>> ---
>>   arch/riscv/include/asm/ptrace.h      | 4 ++--
>>   arch/riscv/include/uapi/asm/ptrace.h | 2 ++
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
>> index b5b0adcc85c1..37f48d40ae46 100644
>> --- a/arch/riscv/include/asm/ptrace.h
>> +++ b/arch/riscv/include/asm/ptrace.h
>> @@ -45,12 +45,12 @@ struct pt_regs {
>>   	unsigned long t4;
>>   	unsigned long t5;
>>   	unsigned long t6;
>> +	/* a0 value before the syscall */
>> +	unsigned long orig_a0;
>>   	/* Supervisor/Machine CSRs */
>>   	unsigned long status;
>>   	unsigned long badaddr;
>>   	unsigned long cause;
>> -	/* a0 value before the syscall */
>> -	unsigned long orig_a0;
>>   };
>>   
>>   #define PTRACE_SYSEMU			0x1f
>> diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
>> index a38268b19c3d..3e37f80cb3e8 100644
>> --- a/arch/riscv/include/uapi/asm/ptrace.h
>> +++ b/arch/riscv/include/uapi/asm/ptrace.h
>> @@ -54,6 +54,8 @@ struct user_regs_struct {
>>   	unsigned long t4;
>>   	unsigned long t5;
>>   	unsigned long t6;
>> +	/* a0 value before the syscall */
>> +	unsigned long orig_a0;
>>   };
>>   
>>   struct __riscv_f_ext_state {
>> -- 
>> 2.34.1
>>
> This is a good addition!
>
> Since orig_a0 is no longer at the bottom of pt_regs, MAX_REG_OFFSET is
> now incorrect.
>
> Can you adjust the value of:
>
> #define MAX_REG_OFFSET offsetof(struct pt_regs, orig_a0)
>
> in arch/riscv/include/asm/ptrace.h to be:
>
> #define MAX_REG_OFFSET offsetof(struct pt_regs, cause)
>
> This is something that is very easy to miss. I think it would be
> valuable to leave a comment at the top of struct pt_regs pointing out
> that MAX_REG_OFFSET needs to be adjusted if struct pt_regs changes.
>
> - Charlie
>
Oh, good idea!  I'm sorry for missing such an important point earlier.

Once enough information is gathered from this RFC, I will include what 
you mentioned in the V1 series.

Thanks,
Quan
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


