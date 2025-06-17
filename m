Return-Path: <linux-kselftest+bounces-35192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F83DADC498
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 10:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CF67AB44C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178CB28F51A;
	Tue, 17 Jun 2025 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B631/Nn/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05128A406;
	Tue, 17 Jun 2025 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148452; cv=none; b=mjCUZwI4Z17xZ1v3V3tJokQ7jIybzmiQYQdZgWGVX/qPQmyaeCdixr+lnYkl14xQHN+tUb/zU5FM5kLJtaCHj3cJ/P/zPhgcocK9+XKkBJT+LbdEKPd2Px/wMfQvbY4qORUazevl+QJN+0Q7KJOK427faH1IGm0Zv7iQLsQtaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148452; c=relaxed/simple;
	bh=Ev+wfPjNp3+1OpBLuAzKgLGnCgCxFvUoz+LDbZgxvhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szE3E80BwcHHsLkLit7h0TAaMLToQNJy8L60xjfwqH4e/yM3XPF3vxhFHRyixX2F6cIDTXzLQ+bcRs4cnDdslhQdfT1ztZpvxZOacyqOZCF99lrg5vyAlXmrLzDoQLgkJtygkq+eN0j+LL6y0MOOlMhuTQHYWYfhmR7pUObMrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B631/Nn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AAAC4CEED;
	Tue, 17 Jun 2025 08:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750148451;
	bh=Ev+wfPjNp3+1OpBLuAzKgLGnCgCxFvUoz+LDbZgxvhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B631/Nn/cy/bQXrqyd3ei8DtsMgnXhazeRqQkZSn3r7+4lFyU0dJ4K3/kANNBgW14
	 /IJk4Gx0bP0iS4dwvfIQj/C7rSqJ1xRIrO1eJBE+sGKiNzbGYJZndyChvFT2H3pfTR
	 Zd8ykZVTdGMrugCfPhV8yQCfQOgFTHhuCaagmPg3p9spWAZWH8JcVcjrvJLyXJBLb+
	 /0tZQC+vNyMXUuUQiu4AS6wK0l3AVvSV49BW/c6iKoi/SifkiZBzzWftpWbk6nmDtT
	 091bccuhSLNxXP9ymwB0935kN97KX4RL4xxNNodZJJ1sEXkF6Xi92CCYH6TuZLCftn
	 L3+3O7dapRE3A==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so11150843a12.3;
        Tue, 17 Jun 2025 01:20:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgLb88huYwDisJWgf11K0lhWVd47c9CfUvtQsWhQaZUkZHJDpwTXJtvVVwDUmbNohvQBquHfzRPinH4qkHfq6y@vger.kernel.org, AJvYcCWcfbkwRzWtxtSS3KkMoDrKSBlNuu/aZqYetGa03ICJYyWMN/exZXfpod6L4SUeHWZMJ4gZIYX6Co838g==@vger.kernel.org, AJvYcCXgh1YqNnQ7h6/wb+MIfFLWvaH8KiU7ENSqc2fDwLfkIZUMCBPOSSYD4mVJfilEfoqp0ddwDcE/7I4h3Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQKMyhU06gnvRnyDMq0NHP9bevbo9zL5Yi2T5Wx9RyLuH34+59
	S5YfUJAQCZYzhiTQls9VDSw/W8mfLSNG8CDK7i6IHOSzr31tjYwGXDc2zr6dY7NeqsM+YSf6TOg
	Z8+enWPdNylavCz054ISF+4sFb9lPpvo=
X-Google-Smtp-Source: AGHT+IGCY996UEycX3rPs/EXwjI2oXNCo8GiIM3kOQg1rxmp+0q/+J/gPPFAcdHzYME/kA8NqX297i+ePyR0A3UBcQk=
X-Received: by 2002:a05:6402:40c3:b0:602:ef0a:cef8 with SMTP id
 4fb4d7f45d1cf-608d09c0ademr9953300a12.18.1750148450032; Tue, 17 Jun 2025
 01:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-kunit-mips-v4-0-1d8997fb2ae4@linutronix.de> <20250611-kunit-mips-v4-1-1d8997fb2ae4@linutronix.de>
In-Reply-To: <20250611-kunit-mips-v4-1-1d8997fb2ae4@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 17 Jun 2025 16:20:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H42T9gE99HWx8xg_Te7CTvahJrTR0WF=pX94jauPKkW-Q@mail.gmail.com>
X-Gm-Features: AX0GCFszQjuGTwZ5dXKkObFTNt0vTANijboW7ch2caZ1wYDoEtdyzvT3RCBSrUk
Message-ID: <CAAhV-H42T9gE99HWx8xg_Te7CTvahJrTR0WF=pX94jauPKkW-Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] MIPS: Don't crash in stack_top() for tasks without
 ABI or vDSO
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Wed, Jun 11, 2025 at 7:28=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Not all tasks have an ABI associated or vDSO mapped,
> for example kthreads never do.
> If such a task ever ends up calling stack_top(), it will derefence the
> NULL ABI pointer and crash.
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
> Only dereference the ABI point if it is set.
>
> The GIC page is also included as it is specific to the vDSO.
> Also move the randomization adjustment into the same conditional.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>  arch/mips/kernel/process.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index b630604c577f9ff3f2493b0f254363e499c8318c..02aa6a04a21da437909eeac4f=
149155cc298f5b5 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -690,18 +690,20 @@ unsigned long mips_stack_top(void)
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
> +
> +               /* Space to randomize the VDSO base */
> +               if (current->flags & PF_RANDOMIZE)
> +                       top -=3D VDSO_RANDOMIZE_SIZE;
> +       }
>
>         /* Space for cache colour alignment */
>         if (cpu_has_dc_aliases)
>                 top -=3D shm_align_mask + 1;
>
> -       /* Space to randomize the VDSO base */
> -       if (current->flags & PF_RANDOMIZE)
> -               top -=3D VDSO_RANDOMIZE_SIZE;
> -
>         return top;
>  }
>
>
> --
> 2.49.0
>

