Return-Path: <linux-kselftest+bounces-31652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B238FA9CE5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 18:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042A1188A7AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713641A3152;
	Fri, 25 Apr 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="h5bB/9FH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC71A2557
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599164; cv=none; b=Hin0PGE8Horik9SBifFx1VBf2N6NnmCjBrWRAude6ThU4ZFkyWEVdj3w1C9YpNJkBAwS4esjYMmqhOF0p/44JudONAWV4wCEJxAjLBJGx7KeAypfh8MzkmH/5EEIWx5ToPKcb7gCIT2Olxq5Nrtc9Pwni2plk8It2gbnM9+BhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599164; c=relaxed/simple;
	bh=qkCd8/HmV6AfmTU+1hru+x2meizjAEoGcJvos3klyC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6LA6XQ4mPTpBVpscGWwNU3XGRyCBqKd+l4M2fqaEjy5Iq0i6CAE8Mf98iLNt693kwhGT+90xJKiZqvlDkB7qF5CIqYxSUvlJZBn0VhXBLklQD6HuRgeDipcw0aV931DCSLuc7LasSYn3L2aHNs+6Qi0Ns2ECWT8klxJKn+BN3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=h5bB/9FH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c33ac23edso24669085ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745599162; x=1746203962; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uObhd6griCLVRMAdAUyHQB5JJqltVnuTe7FYQAThLL4=;
        b=h5bB/9FH3uuFQB9MGVTFRuKmBfYMZdnWjj+zXWRTiOZToLNMdi+oX2MEW6t/ZPmpHl
         GK73pGy/PVb8Si66FZz5Eggh9C//4G65TVGNbv3fntfkXlfc0s129oVt105q+Cu/CRpb
         tFgk+8ge7Nb+LoWbSpKZ6lYgW4UZ7SkwTY4Fo0YkFowVFL4l2sYOvu+0dznaZqAwJx8R
         bjcvRsADqsfd5g4IFp8kTTsUuYraRKKQxPOecO4EVAgr0w6lVTaVfvr1qPD6oA6FmfDY
         gNmgDyjMTHFINntIJeebAXPqCkWqkdPr9JyZPeXeLQZ5pF5swa7F5BKEbsqj94LmDd0g
         NngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745599162; x=1746203962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uObhd6griCLVRMAdAUyHQB5JJqltVnuTe7FYQAThLL4=;
        b=lPP5ovYwbXsHjpjqyP4BG7NG6QdzRYTrlvPe+YDlQJdLupxb4FyrZU3WR28ZRLDFVw
         VHVqlfbKmMNn2KiO9QJhXa+l8a4/WNahS9obrTPdmyksqIELeEhUnaslMMsbI5riviZ9
         Qj8m6nqHeBA20pYcocb1R4o8+pNvqJg6J9qHoMNkh57BRqYtW7805rUPYqDIdZWrfto7
         KMdOgBsIX08NXmJYnqUPGOAENIgsYYkvnhsl9yIsio25csvhyAOtq46AsomjOs4dLlgl
         fQIF93yOR4cfg+bcMGU4TlkJmRNiFht+Ox4uFu0VLJQJw5OPk03hOLmsGr6KHQWzgTXE
         JhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Y3VZPCS2mAWDbTDGiSnYMdvOK/Zo+sHqGkHL04lV/eHmO7uG/XamsbSXvUtKMLqwo1nqDyC2kDjex1i+VEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDofrHQ1Q8PPPG0wMVRMtv5yyZoq1YsQi9b6mTJmHmg3qb8hu
	jKFMO8TGQPo0HDRslbZPz+E2a5gw36j4wzaCHOU1MgNr5uhUO8l2CFj5DS+x58Q=
X-Gm-Gg: ASbGncuaiiJjDWvs51eMyzhwSwyIqqSvQY87BNJs//wIUwF7bacvL+sN9IFn+ykc5EY
	uE4TZmeULO4k+6ANK2tEetCpKi99Bis7P6vJNthVMDI1rXGbXAYGgVqvYDXIbBMTwt8+lUlihoF
	B4L/E7+KJcBnwSLhDVEDaapmAJjz2jFkM6sT6kc7Z5XWutazNbBFLxE5gIOazR9TzP8BY7ZqPur
	QrDmkOdKkxdGld65cuVXXRGAk8TW+e9aTnqRUgcLEco4C0VfZtsxe16RJV3RqJEQ7CxbKljqOPX
	CJC42FYOx1FMYN3TdPlXf9uWrD8mCrMuSXhnY2J68g0/2VDpRMg=
X-Google-Smtp-Source: AGHT+IFNazEr6ZYOzQGCXjgc58dYoHgOgILSppSPlOaxKyAejkPiwQZrkFFar4hARLXGCzwX+g5Izw==
X-Received: by 2002:a17:903:40c9:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-22dbf4db64dmr47389315ad.5.1745599161894;
        Fri, 25 Apr 2025 09:39:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51028basm34556395ad.196.2025.04.25.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:39:21 -0700 (PDT)
Date: Fri, 25 Apr 2025 09:39:18 -0700
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
Message-ID: <aAu6toR4VkcPMTlH@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-12-e51202b53138@rivosinc.com>
 <D92V2NPNZYV0.136MJ2HOK48HE@ventanamicro.com>
 <aAnBmexbL4XmVxQk@debug.ba.rivosinc.com>
 <D9EWR3RQK0FD.3GF55KNS53YSR@ventanamicro.com>
 <aAp_87-Xr6gn_hD7@debug.ba.rivosinc.com>
 <D9FOY8JACYTH.1FU7ZTEHFC5NI@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9FOY8JACYTH.1FU7ZTEHFC5NI@ventanamicro.com>

On Fri, Apr 25, 2025 at 01:42:44PM +0200, Radim Krčmář wrote:
>2025-04-24T11:16:19-07:00, Deepak Gupta <debug@rivosinc.com>:
>> On Thu, Apr 24, 2025 at 03:36:54PM +0200, Radim Krčmář wrote:
>>>2025-04-23T21:44:09-07:00, Deepak Gupta <debug@rivosinc.com>:
>>>> On Thu, Apr 10, 2025 at 11:45:58AM +0200, Radim Krčmář wrote:
>>>>>2025-03-14T14:39:31-07:00, Deepak Gupta <debug@rivosinc.com>:
>>>>>> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
>>>>>> @@ -14,7 +15,8 @@ struct kernel_clone_args;
>>>>>>  struct cfi_status {
>>>>>>  	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>>>>>> -	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 1);
>>>>>> +	unsigned long ubcfi_locked : 1;
>>>>>> +	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);
>>>>>
>>>>>The rsvd field shouldn't be necessary as the container for the bitfield
>>>>>is 'unsigned long' sized.
>>>>>
>>>>>Why don't we use bools here, though?
>>>>>It might produce a better binary and we're not hurting for struct size.
>>>>
>>>> If you remember one of the previous patch discussion, this goes into
>>>> `thread_info` Don't want to bloat it. Even if we end shoving into task_struct,
>>>> don't want to bloat that either. I can just convert it into bitmask if
>>>> bitfields are an eyesore here.
>>>
>>>  "unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);"
>>>
>>>is an eyesore that defines exactly the same as the two lines alone
>>>
>>>  unsigned long ubcfi_en : 1;
>>>  unsigned long ubcfi_locked : 1;
>>>
>>>That one should be removed.
>>>
>>>If we have only 4 bits in 4/8 bytes, then bitfields do generate worse
>>>code than 4 bools and a 0/4 byte hole.  The struct size stays the same.
>>>
>>>I don't care much about the switch to bools, though, because this code
>>>is not called often.
>>
>> I'll remove the bitfields, have single `unsigned long cfi_control_state`
>> And do `#define RISCV_UBCFI_EN 1` and so on.
>
>I might have seemed too much against the bitfieds, sorry.  I am against
>the rsvd fields, because it is a pointless cognitive overhead and even
>this series already had a bug in them.

Aah got it.

>
>#defines should generate the same code as bitfields (worse than bools),
>so the source code is really a matter of personal preference.
>(I do prefer bitfields.)
>
>>>>>> @@ -262,3 +292,83 @@ void shstk_release(struct task_struct *tsk)
>>>>>> +int arch_lock_shadow_stack_status(struct task_struct *task,
>>>>>> +				  unsigned long arg)
>>>>>> +{
>>>>>> +	/* If shtstk not supported or not enabled on task, nothing to lock here */
>>>>>> +	if (!cpu_supports_shadow_stack() ||
>>>>>> +	    !is_shstk_enabled(task) || arg != 0)
>>>>>> +		return -EINVAL;
>>>>>
>>>>>The task might want to prevent shadow stack from being enabled?
>>>>
>>>> But Why would it want to do that? Task can simply not issue the prctl. There
>>>> are glibc tunables as well using which it can be disabled.
>>>
>>>The task might do it as some last resort to prevent a buggy code from
>>>enabling shadow stacks that would just crash.  Or whatever complicated
>>>reason userspace can think of.
>>>
>>>It's more the other way around.  I wonder why we're removing this option
>>>when we don't really care what userspace does to itself.
>>>I think it's complicating the kernel without an obvious gain.
>>
>> It just feels wierd. There isn't anything like this for other features lit-up
>> via envcfg. Does hwprobe allow this on per-task basis? I'll look into it.
>
>I think PMM doesn't allow to lock and the rest don't seem configurable
>from userspace.
>
>It's not that important and we hopefully won't be breaking any userspace
>if we decided to allow it later, so I'm fine with this version.

