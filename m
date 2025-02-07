Return-Path: <linux-kselftest+bounces-26059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABCCA2D0DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 23:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0233616D146
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 22:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683EB1D8A16;
	Fri,  7 Feb 2025 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jHhTxFEx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A9D1D515B
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968258; cv=none; b=Nc63B47Y2F3nTZ9XGp2u9LjkqcNknmuTUXCYgIgElazZ/o8Oz4uEdr939s6OhCRyOwwc/aH3rQN1XiG7CpUJE+efjkrjF0zM/d3/ut6CGrdL7mwSiNtQ9i/fjR7O/BD5/nZnZQOU2dLyNGms6mzyBtr0ZuuqR2FmW/1R+nF/foA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968258; c=relaxed/simple;
	bh=BKd51xQGZZ4Gqq3HzT1bsS3JNQF+dVtvOyP2185nGbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTb7FFr7T/mlAH7ctH/ZODnTg2jeXFuidymr/0SQanqXXoSEft3zfmgL8ubDunSqhisc1zwCMsIA5/tr6B2h6bDfIY3F6sEv0XLkf4z98/DwXQXWCVLRUDlopE4+Rok2CNCn25hvacKuKTwTOZH0baZLuMyOtbrWxeVo5aXv3Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jHhTxFEx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa0f222530so4449024a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 14:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738968255; x=1739573055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2ipDsFh+4Wi6+DfKBkgvbX5MRHqphXmotwjlbhmRh4=;
        b=jHhTxFExduXYPEeCSR1AkECffBNHSVsANRuMsv3hdU8pw1TP4r7tdhVLWaJ7kFx0tw
         fbuBeLTrIIhHIAfVXwnMmFfy2+Bw653qkelq8YHFzcHxRkz7A05mm96ugf+84flI0HfL
         7njB9tFx3VEq0OLqeNiaCcp6tgKrZejvz9i6KVlLc566FO6u6C9E5OAoyaFUCnTxU3n0
         +SbDnf62y3EzGZ34x5RckTxXbWo+lZE9caW0awgOkFYtquNHT5Zfp8jHYhv9+22phEHr
         46cP5acHZAsBdNTPhyuIulMiHfFgkZJ5bUUilQCpW9ESxZX+ccUTGE3XCFnSO0mLhaPn
         s0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738968255; x=1739573055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2ipDsFh+4Wi6+DfKBkgvbX5MRHqphXmotwjlbhmRh4=;
        b=Vxx72IG7WdUVuv1FpQHqCBUlQCvgo8j7xO2pVc5efIaSc5jMvZDL68NIf6zYW5J4Ck
         4QYdlpbCbKbAXpmrkSblMmuf5jzDHTnweZZnPRnAuBgSD+EP+3+yUbq0LXAqlTIcMzkC
         QJoITwkgEtzZyuBbQm0LwXsjKuf543c1hUNlst7Yc0FuF0pSBMaUqssQeTJp8cqCcNGs
         wEVncM+dUqHbCDr35OWP4qDR4pIHSu50D4g9ZM6alMR7urqG/0PpbKU9D0879klaYwBH
         dOm/yfG/fiNpTtWv7Qj9MGcjPstG3fOr+bRqJXcQbPWgzhFt6T/GpyL3EowN2jlogkKU
         ioPA==
X-Forwarded-Encrypted: i=1; AJvYcCVD0GWHyENTNl9q5qW5nYiB42EPAtve1R/4yerBS1thEsDuQoWcaE3WHN2O7ZtmHseEM8hlQmiD+0Z4Bfo8rDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3rs5XUHv9x7IfW72K9AwHuLtPvRbwThfpD3aiMINJ+K8ccOH
	RriiNx+dxA9rWH9kAafTOVBRinTa4evf/i8XF7TZZ0liLzfa9RCLi7rH0ozHMKI=
X-Gm-Gg: ASbGnctw60nA5csL8wYcpZkYdzuG6HoTpFMubab6+5H3Ls61IlmrmAOdhi3qf4qU7SQ
	wRLiiIdgrTXZg3OcWl3FmkV5SY4vQ/V38xxY0Jx1aU+2W7o7CjNMtj+hBOdx+FCOvAbUX6on6rd
	X4j1hkzQWAqhjBOSj6Ubd9CrjV3V8Mgdd/DIfnn534tmjrm6wv5oWU3k6YKNkXPZe1+Vk++0/r9
	7iYKCGbNpBKhwY/K/II5ISN9ZU0D0FjR2U4QYcoYevF2GeeX5T0HFaAAkNunQ3Y3EJL27zfoRTE
	/uKclxrm3yR91FFNnZ1r/1uzOA==
X-Google-Smtp-Source: AGHT+IH0ObGSX9Z5Li4uWD9lYbrpJL6WiQ/fR0RPEu4WFLYzu4KaceG7QOyaNMgDiAsQ/fdeHHOGVA==
X-Received: by 2002:a17:90b:19d8:b0:2ee:6d04:9dac with SMTP id 98e67ed59e1d1-2fa243f02dcmr6699334a91.32.1738968254644;
        Fri, 07 Feb 2025 14:44:14 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9bf6f268fsm5069384a91.0.2025.02.07.14.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 14:44:14 -0800 (PST)
Date: Fri, 7 Feb 2025 14:44:10 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH v9 01/26] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Message-ID: <Z6aMuuXMQAu7Tcvm@debug.ba.rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
 <20250204-v5_user_cfi_series-v9-1-b37a49c5205c@rivosinc.com>
 <6543c6b6-da86-4c10-9b8c-e5fe6f6f7da9@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6543c6b6-da86-4c10-9b8c-e5fe6f6f7da9@suse.cz>

On Fri, Feb 07, 2025 at 10:27:10AM +0100, Vlastimil Babka wrote:
>On 2/5/25 02:21, Deepak Gupta wrote:
>> VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
>
>I see that arm GCS uses VM_HIGH_ARCH_6.

Stale commit message. I thought I had fixed it.
Sorry about that, will fix it.

>
>> VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
>
>And RISC-V doesn't define it at all, not even in this patchset, or did I
>miss it somewhere?
>
>> stack). In case architecture doesn't implement shadow stack, it's VM_NONE
>> Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
>> or not.
>
>This looks like an unfinished sentence. As if it was to continue with "...
>will allow us to ..." what?
>
>I'm not against a helper but this changelog is rather confusing and also
>code in arch/x86 and arch/arm64 isn't converted to the helper but testing
>VM_SHADOW_STACK still.

Yes I didn't pay attention during rebase, will update the commit message.
>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> ---
>>  mm/gup.c  |  2 +-
>>  mm/mmap.c |  2 +-
>>  mm/vma.h  | 10 +++++++---
>>  3 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 3883b307780e..8c64f3ff34ab 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -1291,7 +1291,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>>  		    !writable_file_mapping_allowed(vma, gup_flags))
>>  			return -EFAULT;
>>
>> -		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
>> +		if (!(vm_flags & VM_WRITE) || is_shadow_stack_vma(vm_flags)) {
>>  			if (!(gup_flags & FOLL_FORCE))
>>  				return -EFAULT;
>>  			/*
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index cda01071c7b1..7b6be4eec35d 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -648,7 +648,7 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
>>   */
>>  static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
>>  {
>> -	if (vm_flags & VM_SHADOW_STACK)
>> +	if (is_shadow_stack_vma(vm_flags))
>>  		return PAGE_SIZE;
>>
>>  	return 0;
>> diff --git a/mm/vma.h b/mm/vma.h
>> index a2e8710b8c47..47482a25f5c3 100644
>> --- a/mm/vma.h
>> +++ b/mm/vma.h
>> @@ -278,7 +278,7 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
>>  }
>>
>>  /*
>> - * These three helpers classifies VMAs for virtual memory accounting.
>> + * These four helpers classifies VMAs for virtual memory accounting.
>>   */
>>
>>  /*
>> @@ -289,6 +289,11 @@ static inline bool is_exec_mapping(vm_flags_t flags)
>>  	return (flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC;
>>  }
>>
>> +static inline bool is_shadow_stack_vma(vm_flags_t vm_flags)
>> +{
>> +	return !!(vm_flags & VM_SHADOW_STACK);
>> +}
>> +
>>  /*
>>   * Stack area (including shadow stacks)
>>   *
>> @@ -297,7 +302,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
>>   */
>>  static inline bool is_stack_mapping(vm_flags_t flags)
>>  {
>> -	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
>> +	return ((flags & VM_STACK) == VM_STACK) || is_shadow_stack_vma(flags);
>>  }
>>
>>  /*
>> @@ -308,7 +313,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
>>  	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
>>  }
>>
>> -
>>  static inline void vma_iter_config(struct vma_iterator *vmi,
>>  		unsigned long index, unsigned long last)
>>  {
>>
>

