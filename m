Return-Path: <linux-kselftest+bounces-30830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFECAA89712
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 10:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7B13A7978
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600C41DE4CE;
	Tue, 15 Apr 2025 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BID48Jc4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B61C9B9B;
	Tue, 15 Apr 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706866; cv=none; b=QEBLC+FTxbTojpYB81xpZaJCwWwFdDLvzu1IJpxl0uaXNHHBW1aMWUQlJyzS9bGhiKkga8p6KQ1kJgtlLRHvwStiABV20syIS5KI7CvF6y49GQdMagZmeBYNyXmYd+PXbXbkB0tneTGCne41AAAsCsQHUOdz+xbse1atRnK4UMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706866; c=relaxed/simple;
	bh=rCkQaiV8UvXZZucXLcojjy+jRldKKp9rj/zIIx3mUcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mupNxTb/uheSlxqIdQBeapF6DmyfUT0tUKBKxjAb7OrQvxn+dVi5omFypKM0hLix9KbBLJHJztcVLn98TOwhY1KRSClh5dBetMuWZh5B/a3i4QGN9TvKk4zxrQPaQX9TuSevO4lhRK+XIjOV87Bl1u9R/JJo/Su0jducOyFf5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BID48Jc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4FDC4CEE9;
	Tue, 15 Apr 2025 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744706865;
	bh=rCkQaiV8UvXZZucXLcojjy+jRldKKp9rj/zIIx3mUcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BID48Jc49LHTZ1e1fkby0OWl7Oe8Ldt8kVabt6gCDQjf5E29z7zKgiZztk20aCpdz
	 Rbk1TO62AoAN5E6wLjKmsrtqACu37msR2CPFUoOq+eRZxtE6BHIIL/qYekhoCk0RzS
	 C5kl1SjOZnoZOV5M21zGerkxFowbKwyFqDOyPUqCeRlqyGcymrEsOv3DUDYvygEMW9
	 XE9YDa/8kPh2AeroewtYFWRyb3kpx76vwxtdYA5KkhrwgP7ux/P5IlrWzNhqfR5d++
	 iDCZ0WdWfyYhjEGErGDlhMvpsLw6qnRU5xx+F4GO7ZkHyi21AXD9RWTHZEdjoqV1/j
	 HIi0bo+kgwlgw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so9210749a12.0;
        Tue, 15 Apr 2025 01:47:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVig85Qb6XZbUPaMAiHwWGjDt2aI87TouoDPBzc+VyMUw/Ob83q7+tx08jFwpoxhTsgmc3bbkR2QGgFIWRX7ib@vger.kernel.org, AJvYcCWb4TnH/7BQDcADyTjOfbe5bM9yFS9Pts+hU6crJP1eVcJz5Yp0GbG9QmO6awC6iQe5R+2n6cJwX9hojLQ=@vger.kernel.org, AJvYcCXpZso0GtWNPdMZadlJmg9H1dl6s4INxWkVEDmlO7Islk39f7ww1Q/+1nxPbaHmCy20UAoIoW/si7ns0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmE5zcnUYx1ttKXNf8dUbdWKLobE8MKUivh5FnKTgisz/UhUu3
	29dGyaxroSPNhbCffOg5uSK9xuNbe8B9sQffbKPe3U9QQrH+ZKZnzdErP/W2QVD66Rth3UYQ6Jp
	HA1UnY/oQMxU3rT7m8KNT5NFXhxQ=
X-Google-Smtp-Source: AGHT+IGGGp4mD43KUIHTnp6qprRyupvO+rjVcFQNkbhkl5DWOmFNSNrWDn0Ycc+UUCRvlHnlaxWm/lqhAeEBj4G3WcI=
X-Received: by 2002:a17:906:dc94:b0:ac7:3a23:569c with SMTP id
 a640c23a62f3a-acad34468e4mr1593829966b.1.1744706864187; Tue, 15 Apr 2025
 01:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-kunit-mips-v3-0-4ec2461b5a7e@linutronix.de> <20250415-kunit-mips-v3-1-4ec2461b5a7e@linutronix.de>
In-Reply-To: <20250415-kunit-mips-v3-1-4ec2461b5a7e@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 15 Apr 2025 16:47:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5b8ePEkCyECax37BOiqu57ZVRt_FHt11ijbPgsty+r=A@mail.gmail.com>
X-Gm-Features: ATxdqUFuEM48gRpDnFeEggn2BIbSPZXdcbVAh9Rsa0I8PR7GkoEkvAFVvvabfxk
Message-ID: <CAAhV-H5b8ePEkCyECax37BOiqu57ZVRt_FHt11ijbPgsty+r=A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] MIPS: Don't crash in stack_top() for tasks without
 ABI or vDSO
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Tue, Apr 15, 2025 at 3:10=E2=80=AFPM Thomas Wei=C3=9Fschuh
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
> Also move the randomization adjustment into the same conditional.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
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
I'm not sure, but maybe this line has nothing to do with VDSO.

Huacai

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

