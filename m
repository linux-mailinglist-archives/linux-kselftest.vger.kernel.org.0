Return-Path: <linux-kselftest+bounces-31556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16AAA9AF2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 15:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED8E9A3F80
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E9178372;
	Thu, 24 Apr 2025 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="STPhnhl3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D541624E9
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501820; cv=none; b=CfUZyInv5HSIkaRQ9QCtOjn5qeCgn4ay0pLsd0vnkrLv1OgxHuV2drmdubu5WRApwZdrIlrXfTiovstsx3Eb/tT7kvtkoLnispa785thi+ZHfadELA6+1SHW9tJGY9zD5puV7o3js9ET7aHVacZX232JWiTyeLiicmzRfJUkwtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501820; c=relaxed/simple;
	bh=mJgp6Mchv4iv2by+fPTrmWpvDmstqIj/vVuuTYwKWrc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SdOUKYmVsJAbV67s0IU6C5iKVuHQkkfelqBvx7hqsFYg3eHduGUstmynugHhlPEPrzvb5krrWUXT3xYM09yr4dDN4Vqw0+Epzb+cYFSdnxGQGWoN1VGXy6b04TUBVFbaJpRyCo7CyV23OT9GOhNVWOnTO6LXB+rblmP7hL9nzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=STPhnhl3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3912387cf48so38078f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745501816; x=1746106616; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u72nfMy9zYS5aW9xBcDq6LESieHcry02Dg/8XEt7OSw=;
        b=STPhnhl3MTSastFv/OTSfSJnvslCvjVFt8jQhYjLvJcAvNTMw2P95yoTCq7JNMH3oB
         ZiHZePSZTKb8HQPOF2FZj7lJcheeYAM9TZI4ywWPoJDKd+qnWzhYDa3b6brXchZ2gz1A
         iOds1IBKHaBEtEMgAZHyp7VnSGreB1libYVDSk0VW24DaFN57lhhD4mNPToS/FGOySVe
         OBCN8JXd+nYE3DmFRwi/qQAIjBWxS9rSeLtljz+7N0EWc5IgDelmDHVKWrdW+BDfo+fC
         NEF2idC69hqasCOrs8POBpnilmFdiY2QJvnVbXouIESH4LHz2D50/QSNyQ8cimsa/YYW
         tMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745501816; x=1746106616;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u72nfMy9zYS5aW9xBcDq6LESieHcry02Dg/8XEt7OSw=;
        b=JBmD1+G2SfJLF/UIbz+wWA+9mBjiFxHE4TvzarzqZxsM7fO/vAuQDlPzh3YTkQfoLm
         h6sm3NLaU1T+yqfrtj+yZaw5K2lZFfkl2BEnp8SySW/pqxyyZUN20Bmjpfh8qp6Mam7T
         fnC5itFRMMcCbKubk+rcZH3kZ6n2Xp8I7u8GdesqzKOvZ5wqMqi1txceKqgw9y28gF+z
         KnDuIp5DF7ZJDmZ3tlXy3uvCsOcZMTA1J2E0Em1cuDXjqOyJo3uyqMgR+1+MqtZjgGTI
         JtepSLVbVG1Y0uhZ6wPcB44dUVi6O8bXcyUTt0eWu5N9G4DK/w3vL6wScv0gucqPvfB3
         pm4w==
X-Forwarded-Encrypted: i=1; AJvYcCUE0Eg93RttJALt3NfHp/PGdbMRdWaccvnpo5WtgGiR9cgxYRrcrelUV+Vd+ewlTYuSuaevMvUQSgBDAGDLqns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aFuWYNtqZIoJ55HuI6hdnatGHVua57sfiZyBqo67Acj1e5R2
	WS4O7oU0B4GAIvMMykCqE8elZMicJeoUs9X4tur4IXmXSkQ3Csfh8q4K5NJbp+Q=
X-Gm-Gg: ASbGnctjD6/E8rjBHpw52DEy2MRM3A7W+Zv4ZLY6hK1GnIEC9AA6o16O1NwFLQ/7jBz
	wc+1G3K/Dq7RB9z4y8LGsCSB2E63pz7D8k9WbhCXakpJKiTDqvgre+Kott4sShjSPqCH09/3CRT
	L6Lwjfa1AzQjFxlgYxG3IXNwqU/RusnobT1idMcuXAbY5G7esabbhknsHyh3CStT+baVDvMRXPo
	NLneXevWPq8dGDTBPyvLpg0MtaNxIqlj+LJd5ePU0Nn14Al/9j3EeE18yTIrjUuuWI+BD0QpsLz
	bWSV8xgBlqOxzd1OXJ+BjvQOeJY8F7cz9HDrRvyDTBZKCaXT
X-Google-Smtp-Source: AGHT+IEvTiSK1Lb+RPBdQ/DuDmeOaJEszTrN5CFCiZtbJdEyNkpwKicv/xW9sGpiPTRfU1AmU+RxSg==
X-Received: by 2002:a05:6000:2483:b0:3a0:65ab:89d5 with SMTP id ffacd0b85a97d-3a06cfaf02fmr812129f8f.15.1745501815962;
        Thu, 24 Apr 2025 06:36:55 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:b30c:ee4d:9e10:6a46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4c30d7sm2135597f8f.44.2025.04.24.06.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Apr 2025 15:36:54 +0200
Message-Id: <D9EWR3RQK0FD.3GF55KNS53YSR@ventanamicro.com>
Subject: Re: [PATCH v12 12/28] riscv: Implements arch agnostic shadow stack
 prctls
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Conor Dooley" <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Eric Biederman" <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann
 Horn" <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-12-e51202b53138@rivosinc.com>
 <D92V2NPNZYV0.136MJ2HOK48HE@ventanamicro.com>
 <aAnBmexbL4XmVxQk@debug.ba.rivosinc.com>
In-Reply-To: <aAnBmexbL4XmVxQk@debug.ba.rivosinc.com>

2025-04-23T21:44:09-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Apr 10, 2025 at 11:45:58AM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>>2025-03-14T14:39:31-07:00, Deepak Gupta <debug@rivosinc.com>:
>>> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/=
usercfi.h
>>> @@ -14,7 +15,8 @@ struct kernel_clone_args;
>>>  struct cfi_status {
>>>  	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>>> -	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 1);
>>> +	unsigned long ubcfi_locked : 1;
>>> +	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);
>>
>>The rsvd field shouldn't be necessary as the container for the bitfield
>>is 'unsigned long' sized.
>>
>>Why don't we use bools here, though?
>>It might produce a better binary and we're not hurting for struct size.
>
> If you remember one of the previous patch discussion, this goes into
> `thread_info` Don't want to bloat it. Even if we end shoving into task_st=
ruct,
> don't want to bloat that either. I can just convert it into bitmask if
> bitfields are an eyesore here.

  "unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);"

is an eyesore that defines exactly the same as the two lines alone

  unsigned long ubcfi_en : 1;
  unsigned long ubcfi_locked : 1;

That one should be removed.

If we have only 4 bits in 4/8 bytes, then bitfields do generate worse
code than 4 bools and a 0/4 byte hole.  The struct size stays the same.

I don't care much about the switch to bools, though, because this code
is not called often.

>>> @@ -262,3 +292,83 @@ void shstk_release(struct task_struct *tsk)
>>> +int arch_set_shadow_stack_status(struct task_struct *t, unsigned long =
status)
>>> +{
>>> +	/* Request is to enable shadow stack and shadow stack is not enabled =
already */
>>> +	if (enable_shstk && !is_shstk_enabled(t)) {
>>> +		/* shadow stack was allocated and enable request again
>>> +		 * no need to support such usecase and return EINVAL.
>>> +		 */
>>> +		if (is_shstk_allocated(t))
>>> +			return -EINVAL;
>>> +
>>> +		size =3D calc_shstk_size(0);
>>> +		addr =3D allocate_shadow_stack(0, size, 0, false);
>>
>>Why don't we use the userspace-allocated stack?
>>
>>I'm completely missing the design idea here...  Userspace has absolute
>>over the shadow stack pointer CSR, so we don't need to do much in Linux:
>>
>>1. interface to set up page tables with -W- PTE and
>>2. interface to control senvcfg.SSE.
>>
>>Userspace can do the rest.
>
> Design is like following:
>
> When a user task wants to enable shadow stack for itself, it has to issue
> a syscall to kernel (like this prctl). Now it can be done independently b=
y
> user task by first issuing `map_shadow_stack`, then asking kernel to ligh=
t
> up envcfg bit and eventually when return to usermode happens, it can writ=
e
> to CSR. It is no different from doing all of the above together in single
> `prctl` call. They are equivalent in that nature.
>
> Background is that x86 followed this because x86 had workloads/binaries/
> functions with (deep)recursive functions and thus by default were forced
> to always allocate shadow stack to be of the same size as data stack. To
> reduce burden on userspace for determining and then allocating same size
> (size of data stack) shadow stack, prctl would do the job of calculating
> default shadow stack size (and reduce programming error in usermode). arm=
64
> followed the suite. I don't want to find out what's the compatiblity issu=
es
> we will see and thus just following the suite (given that both approaches
> are equivalent). Take a look at static `calc_shstk_size(unsigned long siz=
e)`.
>
> Coming back to your question of why not allowing userspace to manage its
> own shadow stack. Answer is that it can manage its own shadow stack. If i=
t
> does, it just have to be aware of size its allocating for shadow stack.

It's just that userspace cannot prevent allocation of the default stack
when enabling it, which is the weird part to me.
The allocate and enable syscalls could have been nicely composable.

> There is already a patch series going on to manage this using clone3.
> https://lore.kernel.org/all/20250408-clone3-shadow-stack-v15-4-3fa245c6e3=
be@kernel.org/

A new ioctl does seem to solve most of the practical issues, thanks.

> I fully expect green thread implementations in rust/go or swapcontext
> based thread management doing this on their own.
>
> Current design is to ensure existing apps dont have to change a lot in
> userspace and by default kernel gives compatibility. Anyone else wanting
> to optimize the usage of shadow stack can do so with current design.

Right, changing rlimit_stack around shadow stack allocation is not the
most elegant way, but it does work.

>>> +int arch_lock_shadow_stack_status(struct task_struct *task,
>>> +				  unsigned long arg)
>>> +{
>>> +	/* If shtstk not supported or not enabled on task, nothing to lock he=
re */
>>> +	if (!cpu_supports_shadow_stack() ||
>>> +	    !is_shstk_enabled(task) || arg !=3D 0)
>>> +		return -EINVAL;
>>
>>The task might want to prevent shadow stack from being enabled?
>
> But Why would it want to do that? Task can simply not issue the prctl. Th=
ere
> are glibc tunables as well using which it can be disabled.

The task might do it as some last resort to prevent a buggy code from
enabling shadow stacks that would just crash.  Or whatever complicated
reason userspace can think of.

It's more the other way around.  I wonder why we're removing this option
when we don't really care what userspace does to itself.
I think it's complicating the kernel without an obvious gain.

