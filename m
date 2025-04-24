Return-Path: <linux-kselftest+bounces-31597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C9A9B611
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 20:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8549B7A43B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491D028F511;
	Thu, 24 Apr 2025 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NOK+8qnl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292AD28CF65
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518587; cv=none; b=drBqRUMdHslHSDl76a3TfrCD+pFwHrmh36iTCqJLYmCyKfm2tSiT1gDzpzlkhSuIJzhx1mZbfzTGbCCTjqpbBM8bCZ1S3K8QJNQMQWVZ/FCdYf1Sfd6kjw06N0is2BK6y2HFe300ggtaJWyP04/+0VEOC97Cl4oNivT+MLA0qzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518587; c=relaxed/simple;
	bh=xwIJYlS8Mxej9Ue36QIm4SREbYsNaNZe158F8eJvF30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5M26V+uzJlOm4DiPvewrl7rf5J2oM8VFtUMqD79Ai9QhdAeOMadHxho/LZ8qxmF19J6fxdQxsr3cANsDZKVQNPq9kwkpVKaszKb8cxACfvaM+5+ajvAQEdU09nxTH1Meh3Fd37W77FuqnVRUPjjLP2YsF2LutSTD0KB80hMrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NOK+8qnl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736b0c68092so1161782b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745518583; x=1746123383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T9sHYezjUq6l/x/6C81DhRiO6Hkx3zNHx6RVEna5xiI=;
        b=NOK+8qnltocl7IjsIDqxYetNVinHbSt9qBQwhXvmJSzZm/Uj/A+EmAwPtIXsueGmIj
         m+XPDNBpYdajzutI+CSSyCjBf7HjgMqFV5tzTuvVtSkIK3eBz59mRmxbiO0UBJytArVJ
         JwbIsuvj2ZoNoLvKSqPlotq7uiV3tqPJhkh+4datkYvfGhyOgDt7kMovCVzgiIpfstBk
         S4v/2M/Ds4YsAEEEQlfryl2sv4S/tt+DeE3VGGSG3emgoJpBwato5wcWUETazw8nIdLn
         z56G++pZ3eW8WcfzbpGHR4a8Rf5DIByZE1/v3D4yk7znJHeBdY590OLcMTSOC9jC4C69
         3d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745518583; x=1746123383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9sHYezjUq6l/x/6C81DhRiO6Hkx3zNHx6RVEna5xiI=;
        b=kuCg/2g4nVpYQKJgEYLetdoLSlZC4J5f02M8YYPHhQTs2MLVOHAbxWLidkfjq1BQIP
         s/huPPNdT5WeXTWv211TZ7FMR9N9VyOiy8vnLEUQ5YmxVQjMCB2fbidn6DHp7roKKSR+
         MUlAcAPaCCPsEw0Y7tjdrU/MrrlddEqEdKIYTdvrkoWkds4opTZeFRzcpQjsC/r6PS+M
         xSInLigLoxeb0B6Ye9/Z7X0cqDqlRfzdy+PFJW7ffXxr1SwOdmW7YwOUrsvNTBp4W91P
         3nnNq5n1ls1h2s6qhp2rfAXHX9sj0UXejvfnoprmgH66ObLHoLY6MuzJEBHMAqPGBKW6
         WAVg==
X-Forwarded-Encrypted: i=1; AJvYcCUEL1DLBZ/nm32EYCE8ZzZqG2n82s5q4iR14wyqeTqUJvEekr8haCEpmajPtRn/35B+x21LYPuwrMufY5xflIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1NtanEXiH9LQ47b7GjWWcViF3HGiBDMtRJcyyTGky3YYIDQ0
	3D6LfwNeTuZk1Aek43Nj0IIbVLATDGddxrMCTd1oG2a3lJMRnMiLz/KBs7RZFZ0=
X-Gm-Gg: ASbGncthGFlOmYnJiJ13A1SydBJDLrfaQiis4+Uz8bTbub+Ojwjcmbtsd1AnLPjcfb4
	CNozIlg8QsvvWZaSPF3I0XCRygU5Vy5Be9B8KIk4FTE7BofaKFgyVt+53ziyT4m7ZZilrgumIrK
	Fh5dvAFY+p259Ekk13Fhq4FvBNaxxnxs+Po4VSCx5IJVIJQeuLJhi1EoQ6jhB0K6SEIrY4Ktu59
	8ijTJycypXucoQgQYDm6XLuNRqN8xCMs9Do1DFhNC7RcmS3Trh60qvpr1G3ovd1glYGg9g/jo1d
	ce3RKhdTw037CJO/avE8v7VRFuXk3OdOLoXj6i5MCHFFZ2n/K/Y=
X-Google-Smtp-Source: AGHT+IF0jVzUPU4VWGuVNQ17BhULhOztKBekv2BW5HkIJsQ1IRCAo1z8B5DG3h77AtgqUMysW+802Q==
X-Received: by 2002:aa7:9315:0:b0:736:9e40:13b1 with SMTP id d2e1a72fcca58-73e24ae7b45mr5236452b3a.23.1745518583417;
        Thu, 24 Apr 2025 11:16:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e259414c7sm1783697b3a.62.2025.04.24.11.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 11:16:23 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:16:19 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v12 12/28] riscv: Implements arch agnostic shadow stack
 prctls
Message-ID: <aAp_87-Xr6gn_hD7@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-12-e51202b53138@rivosinc.com>
 <D92V2NPNZYV0.136MJ2HOK48HE@ventanamicro.com>
 <aAnBmexbL4XmVxQk@debug.ba.rivosinc.com>
 <D9EWR3RQK0FD.3GF55KNS53YSR@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9EWR3RQK0FD.3GF55KNS53YSR@ventanamicro.com>

On Thu, Apr 24, 2025 at 03:36:54PM +0200, Radim Krčmář wrote:
>2025-04-23T21:44:09-07:00, Deepak Gupta <debug@rivosinc.com>:
>> On Thu, Apr 10, 2025 at 11:45:58AM +0200, Radim Krčmář wrote:
>>>2025-03-14T14:39:31-07:00, Deepak Gupta <debug@rivosinc.com>:
>>>> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
>>>> @@ -14,7 +15,8 @@ struct kernel_clone_args;
>>>>  struct cfi_status {
>>>>  	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>>>> -	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 1);
>>>> +	unsigned long ubcfi_locked : 1;
>>>> +	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);
>>>
>>>The rsvd field shouldn't be necessary as the container for the bitfield
>>>is 'unsigned long' sized.
>>>
>>>Why don't we use bools here, though?
>>>It might produce a better binary and we're not hurting for struct size.
>>
>> If you remember one of the previous patch discussion, this goes into
>> `thread_info` Don't want to bloat it. Even if we end shoving into task_struct,
>> don't want to bloat that either. I can just convert it into bitmask if
>> bitfields are an eyesore here.
>
>  "unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);"
>
>is an eyesore that defines exactly the same as the two lines alone
>
>  unsigned long ubcfi_en : 1;
>  unsigned long ubcfi_locked : 1;
>
>That one should be removed.
>
>If we have only 4 bits in 4/8 bytes, then bitfields do generate worse
>code than 4 bools and a 0/4 byte hole.  The struct size stays the same.
>
>I don't care much about the switch to bools, though, because this code
>is not called often.

I'll remove the bitfields, have single `unsigned long cfi_control_state`
And do `#define RISCV_UBCFI_EN 1` and so on.
>
>>>> @@ -262,3 +292,83 @@ void shstk_release(struct task_struct *tsk)
>>>> +int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
>>>> +{
>>>> +	/* Request is to enable shadow stack and shadow stack is not enabled already */
>>>> +	if (enable_shstk && !is_shstk_enabled(t)) {
>>>> +		/* shadow stack was allocated and enable request again
>>>> +		 * no need to support such usecase and return EINVAL.
>>>> +		 */
>>>> +		if (is_shstk_allocated(t))
>>>> +			return -EINVAL;
>>>> +
>>>> +		size = calc_shstk_size(0);
>>>> +		addr = allocate_shadow_stack(0, size, 0, false);
>>>
>>>Why don't we use the userspace-allocated stack?
>>>
>>>I'm completely missing the design idea here...  Userspace has absolute
>>>over the shadow stack pointer CSR, so we don't need to do much in Linux:
>>>
>>>1. interface to set up page tables with -W- PTE and
>>>2. interface to control senvcfg.SSE.
>>>
>>>Userspace can do the rest.
>>
>> Design is like following:
>>
>> When a user task wants to enable shadow stack for itself, it has to issue
>> a syscall to kernel (like this prctl). Now it can be done independently by
>> user task by first issuing `map_shadow_stack`, then asking kernel to light
>> up envcfg bit and eventually when return to usermode happens, it can write
>> to CSR. It is no different from doing all of the above together in single
>> `prctl` call. They are equivalent in that nature.
>>
>> Background is that x86 followed this because x86 had workloads/binaries/
>> functions with (deep)recursive functions and thus by default were forced
>> to always allocate shadow stack to be of the same size as data stack. To
>> reduce burden on userspace for determining and then allocating same size
>> (size of data stack) shadow stack, prctl would do the job of calculating
>> default shadow stack size (and reduce programming error in usermode). arm64
>> followed the suite. I don't want to find out what's the compatiblity issues
>> we will see and thus just following the suite (given that both approaches
>> are equivalent). Take a look at static `calc_shstk_size(unsigned long size)`.
>>
>> Coming back to your question of why not allowing userspace to manage its
>> own shadow stack. Answer is that it can manage its own shadow stack. If it
>> does, it just have to be aware of size its allocating for shadow stack.
>
>It's just that userspace cannot prevent allocation of the default stack
>when enabling it, which is the weird part to me.
>The allocate and enable syscalls could have been nicely composable.
>
>> There is already a patch series going on to manage this using clone3.
>> https://lore.kernel.org/all/20250408-clone3-shadow-stack-v15-4-3fa245c6e3be@kernel.org/
>
>A new ioctl does seem to solve most of the practical issues, thanks.
>
>> I fully expect green thread implementations in rust/go or swapcontext
>> based thread management doing this on their own.
>>
>> Current design is to ensure existing apps dont have to change a lot in
>> userspace and by default kernel gives compatibility. Anyone else wanting
>> to optimize the usage of shadow stack can do so with current design.
>
>Right, changing rlimit_stack around shadow stack allocation is not the
>most elegant way, but it does work.
>
>>>> +int arch_lock_shadow_stack_status(struct task_struct *task,
>>>> +				  unsigned long arg)
>>>> +{
>>>> +	/* If shtstk not supported or not enabled on task, nothing to lock here */
>>>> +	if (!cpu_supports_shadow_stack() ||
>>>> +	    !is_shstk_enabled(task) || arg != 0)
>>>> +		return -EINVAL;
>>>
>>>The task might want to prevent shadow stack from being enabled?
>>
>> But Why would it want to do that? Task can simply not issue the prctl. There
>> are glibc tunables as well using which it can be disabled.
>
>The task might do it as some last resort to prevent a buggy code from
>enabling shadow stacks that would just crash.  Or whatever complicated
>reason userspace can think of.
>
>It's more the other way around.  I wonder why we're removing this option
>when we don't really care what userspace does to itself.
>I think it's complicating the kernel without an obvious gain.

It just feels wierd. There isn't anything like this for other features lit-up
via envcfg. Does hwprobe allow this on per-task basis? I'll look into it.


