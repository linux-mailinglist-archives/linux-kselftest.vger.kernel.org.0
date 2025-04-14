Return-Path: <linux-kselftest+bounces-30662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8917EA87BED
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFF91890D64
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE225A62C;
	Mon, 14 Apr 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbhNFdSV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166323BCFF;
	Mon, 14 Apr 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623179; cv=none; b=pTRVnmcHw3mRnc4cATwrkmXuz572zS2oXVP8aqC7gadf+AV+oQ+4YRuIukGRZc7Fr32Mj5wpyNEvMkRmyLkRMYXORwM/VGLJ6KgKbccqrcClb+0gQaoeHQD3r8uWFJr3v2Ot1xFYRXf35g2dZub7wHul+BnMnWWqAncddRdiYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623179; c=relaxed/simple;
	bh=MXGyvauWR7hdCFbdpnb8C9G/eWPT7x86k+zPV0A+984=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKl1PpDOPM2uI1jrjuY8W3pWZhqfJC+f8/S8PL/jQs/1BjVOOruXWWqSF7ySAtY+jdS1VykOTSb/RXWTAICdFuvtzX3X1jYEvfAM3wPzcCHSy7qZp7V/4QVP+/FUG2ZFOCLtQe7Eqq6y8w5jZrgLUvNllhXeeSou4kMdNAy7Pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbhNFdSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5E0C4CEED;
	Mon, 14 Apr 2025 09:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744623177;
	bh=MXGyvauWR7hdCFbdpnb8C9G/eWPT7x86k+zPV0A+984=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hbhNFdSV8kABsf5D4Qjri5nSpVC9+Jf+g90KlCLzzQ/LMxYGrnoKLqoeJAaFulS93
	 dFJKCUydC+RTLjGdsAi6PXTP2nrXBMYrlV8M9J8Bz5zxHxUqUZmt7fcOYfo5RCqdIX
	 kaee8ihfSS/Q0WZYraqVpAoREFi5h83oqyIp0PkWIpPGEOUEsOveAiEBDL65nudFMF
	 tnuTiXTR5stVI3hbyeI2BZpR6FGHuMCFLK40LSuvnsbXeAF20ZQI7xosF29HBRCYiJ
	 dt9zgIHLqxhdxweqwxrpL4/OzB4ec3wz0xibzuir84/99qVwjB1oELwa/5fpm39eGx
	 htSx0wneK0NHA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac298c8fa50so656105666b.1;
        Mon, 14 Apr 2025 02:32:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeyKHx/6fk62lIVWW4sHsFvJPLVH0IksA7s5VmPUdXXlzZ8m2H5PoyQukW7qgcWnPo96buz2j4ZF1fEQ==@vger.kernel.org, AJvYcCVIpOh4X7vorXNfR++K3p7uNE3+LxWOF1ijcvfRINU9ENOdiyJGj9Le0pW5LYOrGo/VskMXQcMGUg6tBqQ=@vger.kernel.org, AJvYcCVNfoCTWKv2Gu04b48Py9eniFVcet3JyWeEUW8jFsaeo3jpBQ3YmTMoaHK8d7nMQk/A4aD5oumCWY+HhInIrMZg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+aAEynz3DW/qa+9YRKH8GUehxWNxMG2XpcYy5ELf/NNJTAgZ1
	KwZoq1+ld7fRLpJu8YMydcMDxQZjLbgwu8bLgKnXA/d1Gf6YscioCW5FHMYpRqUcujZ76wn3CTy
	2Bzhbk8c0kPO2U3MJ78+ezKn5gHA=
X-Google-Smtp-Source: AGHT+IE6oqapf7uPGjMyrFVoZqRSgFk52dCfJT/XY+kOPKOvImRcDbthuS74AJC1lCwp8CymEUWbpJbR+NEQCuyKI3A=
X-Received: by 2002:a17:907:7f0d:b0:ac7:ecfc:e5fa with SMTP id
 a640c23a62f3a-acad36d507fmr1127064466b.54.1744623176419; Mon, 14 Apr 2025
 02:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414-kunit-mips-v2-0-4cf01e1a29e6@linutronix.de> <20250414-kunit-mips-v2-1-4cf01e1a29e6@linutronix.de>
In-Reply-To: <20250414-kunit-mips-v2-1-4cf01e1a29e6@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 14 Apr 2025 17:32:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7p9TWLEYjv2K-sXUD9roMBJtkbjyq6NCEnyavG9PnWKw@mail.gmail.com>
X-Gm-Features: ATxdqUFAEPOV8iwFq4021hOP27K4Ju4vtYxFFGuG_1cymdKonhLPKJpHuKsPXlQ
Message-ID: <CAAhV-H7p9TWLEYjv2K-sXUD9roMBJtkbjyq6NCEnyavG9PnWKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MIPS: Don't crash in stack_top() for tasks without
 ABI or vDSO
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Mon, Apr 14, 2025 at 4:29=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Not all tasks have an ABI associated or vDSO mapped,
> for example kthreads never do.
> If such a task ever ends up calling stack_top(), it will derefence the
> NULL vdso pointer and crash.
>
> This can for example happen when using kunit:
>
>     mips_stack_top+0x28/0xc0
>     arch_pick_mmap_layout+0x190/0x220
>     kunit_vm_mmap_init+0xf8/0x138
>     __kunit_add_resource+0x40/0xa8
>     kunit_vm_mmap+0x88/0xd8
>     usercopy_test_init+0xb8/0x240
>     kunit_try_run_case+0x5c/0x1a8
>     kunit_generic_run_threadfn_adapter+0x28/0x50
>     kthread+0x118/0x240
>     ret_from_kernel_thread+0x14/0x1c
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/mips/kernel/process.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index b630604c577f9ff3f2493b0f254363e499c8318c..66343cb6c1737c4217ddd8a2c=
3ca244fac0ef8a5 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -690,9 +690,11 @@ unsigned long mips_stack_top(void)
>         }
>
>         /* Space for the VDSO, data page & GIC user page */
> -       top -=3D PAGE_ALIGN(current->thread.abi->vdso->size);
> -       top -=3D PAGE_SIZE;
> -       top -=3D mips_gic_present() ? PAGE_SIZE : 0;
> +       if (current->thread.abi) {
> +               top -=3D PAGE_ALIGN(current->thread.abi->vdso->size);
> +               top -=3D PAGE_SIZE;
> +               top -=3D mips_gic_present() ? PAGE_SIZE : 0;
> +       }
I think the below code should also exist only when VDSO exists.

        if (current->flags & PF_RANDOMIZE)
                top -=3D VDSO_RANDOMIZE_SIZE;

Huacai

>
>         /* Space for cache colour alignment */
>         if (cpu_has_dc_aliases)
>
> --
> 2.49.0
>
>

