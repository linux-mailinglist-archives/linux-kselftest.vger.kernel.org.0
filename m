Return-Path: <linux-kselftest+bounces-31484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74737A9A030
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 06:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689C819458E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 04:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8891C5F07;
	Thu, 24 Apr 2025 04:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZjA4nAE5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E076D1B423D
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 04:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745469856; cv=none; b=WrMoSdWBiwLtV+FeAvr9/POIVLie0KW06Z4IFZYYOpssPGLejtudb6hfEG5J/Mnj5vJaSkrOUG9izJaEXcJHp/mmNHGAcz3J4JbxqCDz8ITC1xHn3WscB4u9NNXaScQK6p/5jAyeYgDREGOfn9rOfWdK5mnXWy1VgpuTrDjtLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745469856; c=relaxed/simple;
	bh=scumeHQ1EWeXtDCiWxXsvS1GGnP6lxnjhn7+ttz3yqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ootaW36Qj61wRK6kL4U74pf6zT2PQLOpnDogqphY54frLqTwKmmAZGrIifqLg3QcLHtpo1+0LQ7ispkSsEMRBR6DGg5zIsqWwFkkkW2LPhL2WpxPZuxqtCeynddbyMoQ0d+Fql/eBr00dCGvc1VNFtK/pW4+j1aHSjyMQM0Nuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZjA4nAE5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7376e311086so668605b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 21:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745469854; x=1746074654; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d8Qiq1brGqi76YM1jZPx/K29TOoSYoqtc1NwyaTJxB8=;
        b=ZjA4nAE5C43SKeMg2lonMk0udTssP7uWcQGLa0ByW/qtijdIvBtCJFJykP47pThHrl
         uhmqJuWDfESGeJPodQLWjKUthkZOQQrTNvFswyRpSC+FNa2D8pbwV0i+vj1Sr3wkBFuE
         tmgnibOExIPfmGIgP/GatTadLh+QQUvKpZ8JMfhHOi6ub8spvTqyUB36pZAq2SD1lFrS
         a6MidcIQmCSwxDs+xz2fQ9mXiKkysadTbj1iycRBhjX+W56deBL3vIW4LM7EnWxb54RR
         pWXRq9oudnEw4nKJCH0Gh5JgtcRaapN2llz645Waw8/wZhztoYZ2M0bXJ9vU7uMO/MfJ
         6ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745469854; x=1746074654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8Qiq1brGqi76YM1jZPx/K29TOoSYoqtc1NwyaTJxB8=;
        b=f47mCajGE+JhHGVasltzxWiuC0FrQ1y4sZ3hKwhLsQDudDK6X5Gbb8/GtgBktuS/4l
         +Cn39uiTtrSHsW3vNHokHdzzG9NH8ECuH/CBn89Pbj1shVtc6JdWZOapChWz72RtOCSn
         mzmNj01s8hGn4XS8ETsYpl7kP5I7P4z9IcazfI6zkruzyIjTeO0MdgdrrhOj10zxD0tT
         Dn1RecoB5s8SXFyzYWkgvBfXzjBnaS1317neANi75QAO8bG83w4/XIJgXGnOb7bMK4Kw
         NxWQEakWRuQGZVZI9HSkZPp8KGIqo81tJduPHRPSvaiXtGhjvm2/zSzMEqG8TNjaAfqD
         pcAg==
X-Forwarded-Encrypted: i=1; AJvYcCW0uUsGQp4tsgk/lAGYjKfs2ce4fptYfgrx+/WRti784uf8YXr6Bfs6RaznEvEeAF4LPjnxG6bSUsz8ONmKols=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmpXzlcJoEjLcpPWm0W9lB0sqsVrftvlFTcEkEj3ctcz7TYO/K
	wj4CPIOins0AnNA/Lyi0vHcVGvXptGzq4+DzgFdayuwZFw6YfjrNTbQReui5eRo=
X-Gm-Gg: ASbGnctrs0nvMruRrSp1zqs1kAKn/ZVfpP8ehQOOJtRe9njyOBvhihhRoAvvN7jBj+7
	8JgCG2UOSZs7+t1rJo+N5J6o/jFRyswAFKnIDS4U65QyOXi0j99fuRr2Ca1TtFJzACRd2+Okpi7
	bC/32dzZ1R/d79SqK8f4FDjNHeZQroLIj4ds0QZ6CTwGZFe2kjP/v6UWYFTjIJDURtmIK/POX9+
	K/tk3BPauq24i7y6UkcF0knhrD5NrWgM91aUUwars0j7VkUsQGuWOzAhYQaz/Q8aOca3MaS0yFq
	gc6aUw7qywNHD8Sx9Zk91NUub4b0ALw8ozRnbz1guvK3mLqghiI=
X-Google-Smtp-Source: AGHT+IEitFVHRTgSCgRhWMe9hU5oQbZR2x7Kpm268qxNcn6QnDdeucUqxqlmgTha+1K/W91b8N7XWQ==
X-Received: by 2002:a05:6a00:2182:b0:736:73ad:365b with SMTP id d2e1a72fcca58-73e246647e4mr1767338b3a.14.1745469854052;
        Wed, 23 Apr 2025 21:44:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6aa52sm463483b3a.94.2025.04.23.21.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 21:44:13 -0700 (PDT)
Date: Wed, 23 Apr 2025 21:44:09 -0700
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
Message-ID: <aAnBmexbL4XmVxQk@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-12-e51202b53138@rivosinc.com>
 <D92V2NPNZYV0.136MJ2HOK48HE@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D92V2NPNZYV0.136MJ2HOK48HE@ventanamicro.com>

On Thu, Apr 10, 2025 at 11:45:58AM +0200, Radim Krčmář wrote:
>2025-03-14T14:39:31-07:00, Deepak Gupta <debug@rivosinc.com>:
>> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
>> @@ -14,7 +15,8 @@ struct kernel_clone_args;
>>  struct cfi_status {
>>  	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>> -	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 1);
>> +	unsigned long ubcfi_locked : 1;
>> +	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);
>
>The rsvd field shouldn't be necessary as the container for the bitfield
>is 'unsigned long' sized.
>
>Why don't we use bools here, though?
>It might produce a better binary and we're not hurting for struct size.

If you remember one of the previous patch discussion, this goes into
`thread_info` Don't want to bloat it. Even if we end shoving into task_struct,
don't want to bloat that either. I can just convert it into bitmask if
bitfields are an eyesore here.

>
>> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
>> @@ -24,6 +24,16 @@ bool is_shstk_enabled(struct task_struct *task)
>> +bool is_shstk_allocated(struct task_struct *task)
>> +{
>> +	return task->thread_info.user_cfi_state.shdw_stk_base ? true : false;
>
>I think that the following is clearer:
>
>  return task->thread_info.user_cfi_state.shdw_stk_base
>
>(Similar for all other implicit conversion ternaries.)

Hmm... noted.

>
>> @@ -42,6 +52,26 @@ void set_active_shstk(struct task_struct *task, unsigned long shstk_addr)
>> +void set_shstk_status(struct task_struct *task, bool enable)
>> +{
>> +	if (!cpu_supports_shadow_stack())
>> +		return;
>> +
>> +	task->thread_info.user_cfi_state.ubcfi_en = enable ? 1 : 0;
>> +
>> +	if (enable)
>> +		task->thread.envcfg |= ENVCFG_SSE;
>> +	else
>> +		task->thread.envcfg &= ~ENVCFG_SSE;
>> +
>> +	csr_write(CSR_ENVCFG, task->thread.envcfg);
>
>There is a new helper we could reuse for this:
>
>  envcfg_update_bits(task, ENVCFG_SSE, enable ? ENVCFG_SSE : 0);

Yeah it's in switch_to.h header. I'll think about it.

>
>> +}
>> @@ -262,3 +292,83 @@ void shstk_release(struct task_struct *tsk)
>> +int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
>> +{
>> +	/* Request is to enable shadow stack and shadow stack is not enabled already */
>> +	if (enable_shstk && !is_shstk_enabled(t)) {
>> +		/* shadow stack was allocated and enable request again
>> +		 * no need to support such usecase and return EINVAL.
>> +		 */
>> +		if (is_shstk_allocated(t))
>> +			return -EINVAL;
>> +
>> +		size = calc_shstk_size(0);
>> +		addr = allocate_shadow_stack(0, size, 0, false);
>
>Why don't we use the userspace-allocated stack?
>
>I'm completely missing the design idea here...  Userspace has absolute
>over the shadow stack pointer CSR, so we don't need to do much in Linux:
>
>1. interface to set up page tables with -W- PTE and
>2. interface to control senvcfg.SSE.
>
>Userspace can do the rest.

Design is like following:

When a user task wants to enable shadow stack for itself, it has to issue
a syscall to kernel (like this prctl). Now it can be done independently by
user task by first issuing `map_shadow_stack`, then asking kernel to light
up envcfg bit and eventually when return to usermode happens, it can write
to CSR. It is no different from doing all of the above together in single
`prctl` call. They are equivalent in that nature.

Background is that x86 followed this because x86 had workloads/binaries/
functions with (deep)recursive functions and thus by default were forced
to always allocate shadow stack to be of the same size as data stack. To
reduce burden on userspace for determining and then allocating same size
(size of data stack) shadow stack, prctl would do the job of calculating
default shadow stack size (and reduce programming error in usermode). arm64
followed the suite. I don't want to find out what's the compatiblity issues
we will see and thus just following the suite (given that both approaches
are equivalent). Take a look at static `calc_shstk_size(unsigned long size)`.

Coming back to your question of why not allowing userspace to manage its
own shadow stack. Answer is that it can manage its own shadow stack. If it
does, it just have to be aware of size its allocating for shadow stack.

There is already a patch series going on to manage this using clone3.
https://lore.kernel.org/all/20250408-clone3-shadow-stack-v15-4-3fa245c6e3be@kernel.org/

I fully expect green thread implementations in rust/go or swapcontext
based thread management doing this on their own.

Current design is to ensure existing apps dont have to change a lot in
userspace and by default kernel gives compatibility. Anyone else wanting
to optimize the usage of shadow stack can do so with current design.

- 
>
>> +int arch_lock_shadow_stack_status(struct task_struct *task,
>> +				  unsigned long arg)
>> +{
>> +	/* If shtstk not supported or not enabled on task, nothing to lock here */
>> +	if (!cpu_supports_shadow_stack() ||
>> +	    !is_shstk_enabled(task) || arg != 0)
>> +		return -EINVAL;
>
>The task might want to prevent shadow stack from being enabled?

But Why would it want to do that? Task can simply not issue the prctl. There
are glibc tunables as well using which it can be disabled.

>
>Thanks.

