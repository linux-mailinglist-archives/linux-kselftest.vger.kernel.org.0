Return-Path: <linux-kselftest+bounces-29532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915C8A6B126
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 23:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5E0886BE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 22:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F5A22A818;
	Thu, 20 Mar 2025 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VoOM3OEI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB022A7EA
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510581; cv=none; b=OJNML9VmZj8oi71H6bIiXv2hjZZ4an06IB5LG/fQVmGK5TPKT7AJd6o07Q7eIMKrtRoIDF2yeIolUJ/yyKEafRq3CjqSyOEEYyOt3nuKwj5DymV6K0BjbtG0qdP+A4egnytPV3vD+SsLi16OAK5QXWwJg3Oy0gN8ENWB29e47OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510581; c=relaxed/simple;
	bh=jHUyecYfqBSkuj/RyiebN9WzmLHzCNiNfUukvDXyi9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3xIBMfZDGGyvswIm6i9qHVJ1SA5c9CWzb/6UUEyNT8re35jyhlzKsvt/M7O+4neiUGKxmFYx3uCLPUkOnIR/tRP1KnSdJBn8CC3nRYIrnyGIBbmm6pGEBBIcjPW7MbVqcYuG8AbJ1dGsndy8IOkOABhbomPiE+7eFvoHnri2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VoOM3OEI; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f7031ea11cso15100227b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742510578; x=1743115378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qn+4G/BZfte1kQZajpdgC3z6H+wA6NVBYYf22eoImB8=;
        b=VoOM3OEIlvD+S6M3S0KQmAPSCcZez/wVYCZrtShBQa7ZLMuzjPOjNkbvdO7RILoAbc
         D1FRkGbtJ1Us224W+vCenCJHZJyKifdtRRQBJ2Z9K6Il8SIqiOQWZ/znECJKKNXALsVS
         TtRrUng1d6ZAj+NkDUav9LhvupLpk8VdX2UjzvTLkcoYav5uHKObhQHiOv2k/AYDQ2Dn
         4bnX6j+rhk2fDd1QvC1kLtqSUL6vCMmUZhVucILCxSWWMj1g4QjCOT9cMQdn3DjLKELe
         leYH56s3W8QGPzGxOu4z4jG9kDXCtRpZiJTlb427FuJ5htQGGRX+ZPvRfJqcCGGTPVe8
         bCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510578; x=1743115378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qn+4G/BZfte1kQZajpdgC3z6H+wA6NVBYYf22eoImB8=;
        b=BOFJksMeTn6Df/JcIz/+B4D2sN1b82s8yjhrVDuNtfuVRr/byTlWeOkA/OpWpw+jXx
         eymVnD5WjnO/EGbkaxiGn8S8/yR8oVFSNntuEzIucrTvexKTdkoWxxNTQ/ZeKSoEdYie
         tx9eseBYl3pyFebGs/yLOb/mHoEcAixdU5WFPWd6AThN5iSemoP7bL5EjGNrJDkcLJ8K
         svXzbvuqtj7mdXITwt4jwIPHTtJG+UphZhW7Jo8+LxB7LAHUnyz/+qVuvoBzoCKX1395
         hd/mfU/Ttrlzd/XEj3sTndkYAJNcWy/SUbhTOp6eFEuxMq7kNDDlpzrBgODl0TQ4lfdU
         /GJg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2510CMSuASpaW/J4eg1gjBvy7evPTzkGzIoJB/dWYwxNjMCZ/xed55Re3ZV2gOrgZ3mLqK1naASznYO9V4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZdi58bMKTTiQ+UNSeX4QBZIMd7SyHVIKZODjj+GXQYZvQX6ia
	o6C3AGqiYyfAld3sDwYyhRwyOAx8/TICrg2hM/NkJG3KqbJe4TE6hAvqo9rARjngyzIMLcfRC2y
	+O7+jpQPZ/o/jZhXkO3nH6oI53iEDL5Dt3aDuCg==
X-Gm-Gg: ASbGncs5GjG/SDN/iWJ9qvyYORThNEhrxJnEiASK9PU6OkTayxV+qR93ZEqLV2haYfh
	B90cb+0PkMfFwig+toWJcU7efHKHt4hvhqD2jqi8Y4VUot7ZoSRu4lGp95TbgFhxFRMAoxWXTx2
	LsQQfM32wGaNdp8nNmw8XSMsUfyak=
X-Google-Smtp-Source: AGHT+IGmYWppAb1TiIqTjy/w+R69Tu+tZXikOvPPA4dXCqNye2klzCsCnnoPJTKEOwtSTNPJ9gWuo2HlZH9leRcscHA=
X-Received: by 2002:a05:690c:64c8:b0:6f4:8207:c68d with SMTP id
 00721157ae682-700babfd564mr17209397b3.3.1742510578457; Thu, 20 Mar 2025
 15:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-22-e51202b53138@rivosinc.com> <D8LFQYX4EHF8.2AJ01XL34WK0W@ventanamicro.com>
In-Reply-To: <D8LFQYX4EHF8.2AJ01XL34WK0W@ventanamicro.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 20 Mar 2025 15:42:44 -0700
X-Gm-Features: AQ5f1Jo-nHEMu5qFdaTum9uSomYqo-G7mLCiMbL1c8nby8c7DsEke_Gukp9eNFU
Message-ID: <CAKC1njTyiaBkmHvAM8VT_MG4Cdch=H9P8r3C-m-=QQEuzyrRNA@mail.gmail.com>
Subject: Re: [PATCH v12 22/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	Zong Li <zong.li@sifive.com>, linux-riscv <linux-riscv-bounces@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 3:10=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcma=
r@ventanamicro.com> wrote:
>
> 2025-03-14T14:39:41-07:00, Deepak Gupta <debug@rivosinc.com>:
> > Kernel will have to perform shadow stack operations on user shadow stac=
k.
> > Like during signal delivery and sigreturn, shadow stack token must be
> > created and validated respectively. Thus shadow stack access for kernel
> > must be enabled.
>
> Why can't kernel access the user shadow stack through an aliased WR
> mapping?

It can, although that opens up a can of worms. If this alternating
mapping is user mode
then ensuring that another threat in userspace can't write to this
address in this window
of signal handling. A kernel alternate mapping can be created, but
that can lead to all
sorts of requirements of ensuring the page is pinned down. IIRC, It
has been debated
on x86 shadow stack merge time as well on how a flaky alias mapping approac=
h can
become and weaken the threat model it is supposed to protect against.

Simply using `ssamoswap` is simple and serves the purpose. Enabling shadow =
stack
access for the kernel doesn't have any adverse effect on the kernel.

>
> > In future when kernel shadow stacks are enabled for linux kernel, it mu=
st
> > be enabled as early as possible for better coverage and prevent imbalan=
ce
> > between regular stack and shadow stack. After `relocate_enable_mmu` has
> > been done, this is as early as possible it can enabled.
> >
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > ---
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
> >       la tp, init_task
> >       la sp, init_thread_union + THREAD_SIZE
> >       addi sp, sp, -PT_SIZE_ON_STACK
> > +     li a7, SBI_EXT_FWFT
> > +     li a6, SBI_EXT_FWFT_SET
> > +     li a0, SBI_FWFT_SHADOW_STACK
> > +     li a1, 1 /* enable supervisor to access shadow stack access */
> > +     li a2, SBI_FWFT_SET_FLAG_LOCK
> > +     ecall
>
> I think the ecall can fail even on machines that have Zicfiss, so it
> would be good to disable user shadow stack if that happens.

