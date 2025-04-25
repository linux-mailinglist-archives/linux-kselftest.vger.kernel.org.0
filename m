Return-Path: <linux-kselftest+bounces-31637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3BBA9C7A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 13:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523DC4E27F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 11:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C2242D7E;
	Fri, 25 Apr 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nC71upXE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51A16A956
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580724; cv=none; b=pXbd5/0jdU/73z63lqypUGbk2000GONmc5xMVBMUDwzlpiYTnb010cqyfqTsBwkkXSCfuzEbpwGCzQmMWADkMYkI8urFu3vZa54zYOdWSd3hELW++0707LnycrEkV62nITPI7jQCJosv244Ml5DHNF5WfyBZFMNRwyEIFrU0+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580724; c=relaxed/simple;
	bh=tbQyKo4jaOy1juoYPQAD0Q8i7LmRUVL3n5icrYDONY4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=rFcDWO/s+kDX06zLT+W83WiI5krDUsxn85GdERTMoskvFoLw+e4SHQSsfJrhbtopJQambt6zSm/haFzmi+5pCNj1yt5nzIui/IiXjqh58OMFJNGeauibOsZf8qwDeMoijvcBb80V8JMDNRPXE3PK3mqO0OMi3WFSxrSxO3vm+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nC71upXE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ceeb85ab2so1350875e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 04:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745580721; x=1746185521; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDHnSfsfm8Pky45upkoSAPit3VP8lTu/pCNcAlnlmqU=;
        b=nC71upXEFo0TOkILhACrGqNe9/cvRrSTUNbqpxdmdkJbfKElwlLSIKPgcZxHavm/Mz
         vD2vA3cWo0YroCHgnGGAgxlawrmcihlRa1r64UAdvAx39EHDZyk1IiXgXOrj06S/LpfG
         V7CCYpAZFYWumEp8LakcQy1UajLtfI4Us+6YEQ+W4roYWmC/OBJ6DeOcya/JEcnB4Y24
         PynLKhAroyF8uxsuEyLom1pawAeB9/3FBk/x2tn3EaTaN5mDeDdzFPrb54CgSLc7cFOk
         fKzHD+y6mIK35J+D0cT7kRDNOHRzLDfYufc+It7U3X6i1XGpyZTLjexOBMSVPBS4R+Ur
         PjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745580721; x=1746185521;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gDHnSfsfm8Pky45upkoSAPit3VP8lTu/pCNcAlnlmqU=;
        b=X3EhbgR37P310fyyq2BKAJOYe2LDR/jkPU0Eg61n8jVTHcNkQbr7zFxI2ab8vW05Ed
         wbzbcZFvDlJkKjpV/VNM3/Y6/7GYG2DLiqCI106ONgThyeiLm7wDpDfLGgqQVYysr/vd
         omj6NiFIF7OxarThBzpN925jhtyyXKbBtZtF4899Ia3v+Sh9S867I0iMN7Nci0Pi/uvr
         Ejdtv11SuhM4/dx4ZZ6JSaKXK3dzgLEJ5m7OJRRp5I5/oc+MRbYUyrwPyyXwaBEoa4EC
         soTLAQNP8rqgBG6qFBXDlv1oBu5VDBixrNKzZ6SYFS0BqszHtuosjqUD2saNez9UYqPd
         c2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq39U+KRrlM5u5i6h7G4YZNvrizJq08j2l/iotGi9yXDM4/oPz2bN2O8J6AkwBMKZtdjbpg37HCK3tPwsewZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqVYgoWh4RxkckkhQTUj6Lvbwr2I9vfx/FzlGUAvOppsFIWmpW
	SKXFatHW/7N6CVdyNCjwdGaN4A7Uj0xWSh0+e/gZKcm+i7vf3EP8Cfr9SgAUynI=
X-Gm-Gg: ASbGncuKrOI5VU/w4ihLOW3wWzVMszRwAJTv+zO/2qvmp4hjbcnaflpcdzjQr0bj5rg
	zVTiSBkkpGg3NybXrloov+VP46LoqgmNc8ELcuyi57ZodjrSgX894EK8YzOa1zh/mmpvfkjC+3A
	r06l+14GTuE1a71tuTUcmHOsxWVNxRcfyNk381bv4+oNtWwq2T4TTK5cJZjm9axewv69UyeoWN0
	MBggd9x1qJv4GefNabKtoKeT0qerUjgAMv19DECzIQv+Fn6bxx9YTdduL+FVAW2lrrJBELaxQLq
	SEOlEKnBTj2TsTJQOVyZp8I0yzhzoTZ/ILcFZ8fR4laYjFe9
X-Google-Smtp-Source: AGHT+IHRqf93ViQDABDgGhAB9vrTQizaMXk/z0DioGF+r4Jf0pl8X7PBzUSEYnMZMSBPSRe+pddQCw==
X-Received: by 2002:a05:6000:420a:b0:3a0:6bd0:a4b0 with SMTP id ffacd0b85a97d-3a074e0e122mr528393f8f.2.1745580720995;
        Fri, 25 Apr 2025 04:32:00 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:84a3:2b0a:bdb8:ce08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5d479sm2137879f8f.92.2025.04.25.04.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 04:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Apr 2025 13:32:00 +0200
Message-Id: <D9FOQ0C9HMIR.17FERF6F7C8LR@ventanamicro.com>
Subject: Re: [PATCH v12 05/28] riscv: usercfi state for task and
 save/restore of CSR_SSP on trap entry/exit
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
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "Zong Li"
 <zong.li@sifive.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
 <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>
 <aAmEnK0vSgZZOORL@debug.ba.rivosinc.com>
 <D9EV1K8ZQQJR.20CRTYLQBN9UE@ventanamicro.com>
 <aAp9D7txw8y9WL5m@debug.ba.rivosinc.com>
In-Reply-To: <aAp9D7txw8y9WL5m@debug.ba.rivosinc.com>

2025-04-24T11:03:59-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Apr 24, 2025 at 02:16:32PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>>2025-04-23T17:23:56-07:00, Deepak Gupta <debug@rivosinc.com>:
>>> On Thu, Apr 10, 2025 at 01:04:39PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 w=
rote:
>>>>2025-03-14T14:39:24-07:00, Deepak Gupta <debug@rivosinc.com>:
>>>>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>>>> @@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
>>>>>
>>>>>  	REG_L s0, TASK_TI_USER_SP(tp)
>>>>>  	csrrc s1, CSR_STATUS, t0
>>>>> +	/*
>>>>> +	 * If previous mode was U, capture shadow stack pointer and save it=
 away
>>>>> +	 * Zero CSR_SSP at the same time for sanitization.
>>>>> +	 */
>>>>> +	ALTERNATIVE("nop; nop; nop; nop",
>>>>> +				__stringify(			\
>>>>> +				andi s2, s1, SR_SPP;	\
>>>>> +				bnez s2, skip_ssp_save;	\
>>>>> +				csrrw s2, CSR_SSP, x0;	\
>>>>> +				REG_S s2, TASK_TI_USER_SSP(tp); \
>>>>> +				skip_ssp_save:),
>>>>> +				0,
>>>>> +				RISCV_ISA_EXT_ZICFISS,
>>>>> +				CONFIG_RISCV_USER_CFI)
>>>>
>>>>(I'd prefer this closer to the user_sp and kernel_sp swap, it's breakin=
g
>>>> the flow here.  We also already know if we've returned from userspace
>>>> or not even without SR_SPP, but reusing the information might tangle
>>>> the logic.)
>>>
>>> If CSR_SCRATCH was 0, then we would be coming from kernel else flow goe=
s
>>> to `.Lsave_context`. If we were coming from kernel mode, then eventuall=
y
>>> flow merges to `.Lsave_context`.
>>>
>>> So we will be saving CSR_SSP on all kernel -- > kernel trap handling. T=
hat
>>> would be unnecessary. IIRC, this was one of the first review comments i=
n
>>> early RFC series of these patch series (to not touch CSR_SSP un-necessa=
rily)
>>>
>>> We can avoid that by ensuring when we branch by determining if we are c=
oming
>>> from user to something like `.Lsave_ssp` which eventually merges into
>>> ".Lsave_context". And if we were coming from kernel then we would branc=
h to
>>> `.Lsave_context` and thus skipping ssp save logic. But # of branches it
>>> introduces in early exception handling is equivalent to what current pa=
tches
>>> do. So I don't see any value in doing that.
>>>
>>> Let me know if I am missing something.
>>
>>Right, it's hard to avoid the extra branches.
>>
>>I think we could modify the entry point (STVEC), so we start at
>>different paths based on kernel/userspace trap and only jump once to the
>>common code, like:
>>
>>  SYM_CODE_START(handle_exception_kernel)
>>    /* kernel setup magic */
>>    j handle_exception_common
>>  SYM_CODE_START(handle_exception_user)
>>    /* userspace setup magic */
>>  handle_exception_common:
>
> Hmm... This can be done. But then it would require to constantly modify `=
stvec`
> When you're going back to user mode, you would have to write `stvec` with=
 addr
> of `handle_exception_user`.

We'd just be writing STVEC instead of SSCRATCH, probably at the very
same places.
It's possible that some micro-architectures will be disturbed more by
writing STVEC than SSCRATCH, though, so it's not an easy change to make.

>                             But then you can easily get a NMI. It can bec=
ome
> ugly. Needs much more thought and on first glance feels error prone.

Yeah, the M-mode Linux adds a lot of fun.  I don't see support for the
Smrnmi extension, so unlucky NMIs should be fatal even now.

