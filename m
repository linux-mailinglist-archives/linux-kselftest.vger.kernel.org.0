Return-Path: <linux-kselftest+bounces-46716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE889C935DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 02:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48A73A61C9
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 01:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026271A3164;
	Sat, 29 Nov 2025 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0c4lMc29"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985263B2BA;
	Sat, 29 Nov 2025 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764379429; cv=none; b=iXnp44rhrOV0OpXuKzM5R3CLTF449+bqFj/vxvhMm96I7YHig181i/G1OW1jrPbGMjZysRuwYgWBuQcB/xsfZzzKn3peS6oNv2jcssoyOH8GeTffGrccUDXgzk9ZjiPNNEx57zJ4WH3KFXiLZbFGQFzw+PjfVoaeL+pbxfoel5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764379429; c=relaxed/simple;
	bh=3DB/lS3cdqDF4hvYSuy4XZkp1HptZ/15iqPssPrilmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KcanVceqxZi9Bj5HsJTP0kLRJ5BoNJKbMLEaSD5f7zz63GuWEkJKIuhRxE4mymAk9C8qvkjXXwsYdJLHrx/7bEK0lsmbQzxFDzVp6yV6T/YZ+OkCNE0lGcJVuDgppIKmdcs+fXR9y2S5vDdKb7UyGhsUG1ICMMQkEnsfK12xE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0c4lMc29; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=53E0G82pgnvNhQZpI30DkZrOp4ENPQ3MuOnLmG1XVrs=;
	b=0c4lMc29CO52ECz0mKzqfuCd7m49AwR8bZp9YLDE/QGBv7CkLdmOdz3RgGUms0MDXHvTTGvZS
	YO1A+vLnNbKNabY+AEFbMyLZnNSVKmheNcYwOIfM/mYLV77OK5AvcuhrUQjyi///ANGLu/4SazV
	k6kL+BI+hOphLzRmesOzVDM=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dJC6h6kx6zcZyW;
	Sat, 29 Nov 2025 09:21:16 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id D9B4E180481;
	Sat, 29 Nov 2025 09:23:36 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Nov 2025 09:23:35 +0800
Message-ID: <0e65df65-c454-df7f-0685-42e9c0f0f9e3@huawei.com>
Date: Sat, 29 Nov 2025 09:23:34 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v8 11/12] arm64: entry: Convert to generic entry
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <oleg@redhat.com>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <luto@kernel.org>, <shuah@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <charlie@rivosinc.com>,
	<akpm@linux-foundation.org>, <ldv@strace.io>, <macro@orcam.me.uk>,
	<deller@gmx.de>, <mark.rutland@arm.com>, <efault@gmx.de>, <song@kernel.org>,
	<mbenes@suse.cz>, <ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <pengcan@kylinos.cn>,
	<dvyukov@google.com>, <kmal@cock.li>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20251126071446.3234218-1-ruanjinjie@huawei.com>
 <20251126071446.3234218-12-ruanjinjie@huawei.com>
 <c6cf8755-34d0-468d-99c4-ac6d266f9efb@arm.com>
 <bfdd914c-4c3a-9af7-d530-f57f3532c3d5@huawei.com>
 <8c55c2a1-995e-44a1-8d48-b7d794f5176f@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <8c55c2a1-995e-44a1-8d48-b7d794f5176f@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/11/28 21:32, Kevin Brodsky wrote:
> On 28/11/2025 04:34, Jinjie Ruan wrote:
>>
>> On 2025/11/27 21:31, Kevin Brodsky wrote:
>>> On 26/11/2025 08:14, Jinjie Ruan wrote:
>>>> Currently, x86, Riscv, Loongarch use the generic entry which makes
>>>> maintainers' work easier and codes more elegant. arm64 has already
>>>> switched to the generic IRQ entry, so completely convert arm64 to use
>>>> the generic entry infrastructure from kernel/entry/*.
>>>>
>>>> The changes are below:
>>>>  - Remove TIF_SYSCALL_* flag, _TIF_WORK_MASK, _TIF_SYSCALL_WORK,
>>> _TIF_WORK_MASK is now removed in patch 1.
>>>
>>>>    and remove has_syscall_work(), as _TIF_SYSCALL_WORK is equal with
>>>>    SYSCALL_WORK_ENTER.
>>>>
>>>> [...]
>>>>
>>>> +static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
>>>> +							    int step)
>>>> +{
>>>> +	unsigned long saved_reg;
>>>> +	int regno;
>>>> +
>>>> +	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_EXIT, &regno);
>>>> +	if (!step) {
>>> A difference I noticed here is that the generic report_single_step()
>>> always returns false if SYSCALL_EMU is set. I don't know if the
>>> combination of SYSCALL_EMU and SINGLESTEP is meaningful, but if it is
>>> then I think that's a behaviour change.
>> commit 64eb35f701f0 ("ptrace: Migrate TIF_SYSCALL_EMU to use
>> SYSCALL_WORK flag") has changed the following code:
>>
>> Therefore, the original logic returns false in these cases for
>> report_single_step() :
>>
>> - Only _TIF_SYSCALL_EMU is set.
>>
>> - Both _TIF_SINGLESTEP and _TIF_SYSCALL_EMU are set.
>>
>> - Neither TIF_SINGLESTEP nor _TIF_SYSCALL_EMU is set;
>>
>>
>>     #define SYSEMU_STEP    (_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)
>>
>>     static inline bool report_single_step(unsigned long ti_work)
>>     {
>>        return (ti_work & SYSEMU_STEP) == _TIF_SINGLESTEP;
>>     }
> 
> The code did look different before this commit, but AFAICT it was
> functionally equivalent w.r.t. SYSEMU / SINGLESTEP.
> 
>> I think the "returns false if SYSCALL_EMU is set" behaviour is correct
>> according to the Man's Manual， both PTRACE_SYSEMU and
>> PTRACE_SYSEMU_SINGLESTEP need to report the syscal only once on syscall
>> entry.
>>
>>     “For PTRACE_SYSEMU, continue and stop on entry to the next
>>       system call, which will not be executed.  See the
>>       documentation on syscall-stops below.  For
>>       PTRACE_SYSEMU_SINGLESTEP, do the same but also singlestep
>>       if not a system call. “
> 
> That seems sensible (based on my very limited understanding of SYSEMU),
> nevertheless it is not what arm64 currently does AFAIU. To follow the



> same logic as the rest, this change should be made in a separate patch.

Right, and the man page description seems to match the comments of the
report_single_step() function.

"74 /*
 75  * If SYSCALL_EMU is set, then the only reason to report is when
 76  * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
 77  * instruction has been already reported in
syscall_enter_from_user_mode().
 78  */
"

> 
>> Link：https://man7.org/linux/man-pages/man2/ptrace.2.html
>>
>>>> [...]
>>>>
>>>>  #define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
>>>>  #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
>>>>  #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
>>>> -#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
>>>> -#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
>>>> -#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
>>>> -#define TIF_SECCOMP		11	/* syscall secure computing */
>>>> -#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
>>>> +#define TIF_SECCOMP		11      /* syscall secure computing */
>>>> +#define TIF_SYSCALL_EMU		12      /* syscall emulation active */
>>> These seem to have reappeared in v8 for some reason?
>> v8 add "ARCH_SYSCALL_WORK_EXIT" to be defined as "SECCOMP | SYSCALL_EMU"
>>   to keep the arm64 behaviour unchanged as mentioned in v7.
> 
> Ah then that is where the issue is, I missed that: surely switching to
> generic entry means that we are using SYSCALL_WORK_BIT_* rather than
> TIF_* for all these flags?

I think they may be the same thing as you mentioned in v7，neither
SYSCALL_WORK_EXIT nor report_single_step() excluded SYSCALL_EMU, maybe
we should clarify them for arm64 together in a separate patch.

1、"The generic report_single_step() always returns false if SYSCALL_EMU
is set."

2、"
     > -void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
     > -{
     > -	unsigned long flags = read_thread_flags();
     > -
     > -	rseq_syscall(regs);
     > -
     > -	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)

     I believe switching to the generic function introduces a change
     here: syscall_exit_work() is only called if a flag in
SYSCALL_WORK_EXIT is set, and this set does not include SYSCALL_EMU and
    SECCOMP. Practically this means that audit_syscall_exit() will no
    longer be called if only SECCOMP and/or SYSCALL_EMU is set.

   It doesn't feel like a major behaviour change, but it should be
   pointed out."

> 
> - Kevin
> 

