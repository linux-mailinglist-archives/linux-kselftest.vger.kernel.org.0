Return-Path: <linux-kselftest+bounces-19702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB299DE18
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 08:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DA7B2173D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 06:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC32D189B82;
	Tue, 15 Oct 2024 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMHCvaTi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920BA188721;
	Tue, 15 Oct 2024 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973321; cv=none; b=jf9ubu8gB8Rg6zwAZjknmZyzSSKOwwDJmXePNJjOfl2TIpTaxTvhXQtUz8RV3I+5Xy52zvrrmOXhhKl8aURc557gqm6sCTbRkD2i3R3Hok4nRS5VQ83aGmm17TYgNITf4Lj/XdFPM0RllsIUeVT27+M52UzI6ZL5z41xh2Nq6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973321; c=relaxed/simple;
	bh=r5ep8hIPLUp2ScoS8ec6XyMv9qekWzYDO4+6DZumzBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B360GmrQCXEJojDPfooL6ZM0soqLVAT1RcJf6xb3jbOJhCKV7eWVynAJq7tKF7db/+ed6nnEGNqC87JpkcDHoaOJTlkuHuN6Mdg771y+RF0V+mMdjFXosvP8tP6oVSfkyhYz1YYgl08eXnRbdW/430QaAO1Vn/QKMCaJi7nsOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMHCvaTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFF2C4AF0B;
	Tue, 15 Oct 2024 06:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728973321;
	bh=r5ep8hIPLUp2ScoS8ec6XyMv9qekWzYDO4+6DZumzBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MMHCvaTiithCmF4iISJ01BpIykfMiZ1jTLPl52MadFMosF35ki0T5JBc3rtKJmCJd
	 /GH+0/01QPfjGX92liEykNHxvDNauURUc1G5ffhBIjnXf1tn/UkXktWZ8SKLNsP+Z+
	 In+gaVprZuEBnXVMfGicqNBnGxhI0J3jGL13TKdEk8eTMduf8uaWT099q6TbyiTYjj
	 eN7pHTQDEKJ+Rtptm/baBzuY+ubxpcgOnfzoGRZZ0dF3w94hisdiG2DfDNVxjvuKeA
	 SUeaFYrQAZQvMRIfm5y0/JqunHwWNepnfIkAq709OikXvsBqCOO/7SoMs4nrIfRFjn
	 a4B6dxMVJM+Zw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so6596015a12.2;
        Mon, 14 Oct 2024 23:22:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKGEmuNLHYfWS9eXJQLzlJAWcRjJm+0pjFD16zG35pG4nZYgu4oZ6CLLz1xswMPaznNoHBxC9XvKTgdGU=@vger.kernel.org, AJvYcCW8r40xFDFWVt3o/ly4TLKVa8IYqcJuXGEJ/GWkcHWzVGMqQG0I5ICLzUO0nCRVtE45HYOMAxrdOf96Ivcpc774@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi2Ocq79xajVLMKqzqnPr1oTKlBgs+WIv1NnbS89W2/uAJ6v7+
	KHtRY7001yU5Wnx0taVv6TZsIFBTKGiLOnu4wtS+743Yirl3act6UvPfNovaFiiBEQ1ANS4c3Ia
	B2lmXDjkg4gjuNethoewAk+cXpv0=
X-Google-Smtp-Source: AGHT+IEAHX0yv7nr41knRcL/+W4g7qIAlul1M/cWLQg0bRbep2uEoaWBGSQFmWwljmm7lhuCdCGyCBV4ZVTl7N15/qM=
X-Received: by 2002:a17:907:9722:b0:a9a:1f:12db with SMTP id
 a640c23a62f3a-a9a001f259fmr740373466b.16.1728973319696; Mon, 14 Oct 2024
 23:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
 <20241014-kunit-loongarch-v1-1-1699b2ad6099@linutronix.de>
 <CAAhV-H4GvYVphn+srVFEdPboxCz-z04vXa-=e5ptJpdJZgPp=g@mail.gmail.com> <20241015080942-1c451e52-39b4-473d-9919-6b03dbfb7008@linutronix.de>
In-Reply-To: <20241015080942-1c451e52-39b4-473d-9919-6b03dbfb7008@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 15 Oct 2024 14:21:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5COGAgav6-u2oxMDnET466TiA61Zz00Uav-2JnKwkT9w@mail.gmail.com>
Message-ID: <CAAhV-H5COGAgav6-u2oxMDnET466TiA61Zz00Uav-2JnKwkT9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] LoongArch: Don't crash in stack_top() for tasks
 without vDSO
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	maobibo <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:14=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Hi Huacai,
>
> On Tue, Oct 15, 2024 at 10:15:39AM +0800, Huacai Chen wrote:
> > I can take this patch to the loongarch tree, but I think others should
> > get upstream via kselftests tree?
>
> Yes, sounds good.
> Could you take a look at patches 2 and 4, too?

Bibo is more familiar with those, so +CC Bibo.
This one is queued in the loongarch tree. Thanks.

Huacai

>
> Thanks,
> Thomas
>
> > On Mon, Oct 14, 2024 at 7:36=E2=80=AFPM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > >
> > > Not all tasks have a vDSO mapped, for example kthreads never do.
> > > If such a task ever ends up calling stack_top(), it will derefence th=
e
> > > NULL vdso pointer and crash.
> > >
> > > This can for example happen when using kunit:
> > >
> > >         [<9000000000203874>] stack_top+0x58/0xa8
> > >         [<90000000002956cc>] arch_pick_mmap_layout+0x164/0x220
> > >         [<90000000003c284c>] kunit_vm_mmap_init+0x108/0x12c
> > >         [<90000000003c1fbc>] __kunit_add_resource+0x38/0x8c
> > >         [<90000000003c2704>] kunit_vm_mmap+0x88/0xc8
> > >         [<9000000000410b14>] usercopy_test_init+0xbc/0x25c
> > >         [<90000000003c1db4>] kunit_try_run_case+0x5c/0x184
> > >         [<90000000003c3d54>] kunit_generic_run_threadfn_adapter+0x24/=
0x48
> > >         [<900000000022e4bc>] kthread+0xc8/0xd4
> > >         [<9000000000200ce8>] ret_from_kernel_thread+0xc/0xa4
> > >
> > > Fixes: 803b0fc5c3f2 ("LoongArch: Add process management")
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de=
>
> > > ---
> > >  arch/loongarch/kernel/process.c | 16 +++++++++-------
> > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/=
process.c
> > > index f2ff8b5d591e4fd638109d2c98d75543c01a112c..6e58f65455c7ca3eae2e8=
8ed852c8655a6701e5c 100644
> > > --- a/arch/loongarch/kernel/process.c
> > > +++ b/arch/loongarch/kernel/process.c
> > > @@ -293,13 +293,15 @@ unsigned long stack_top(void)
> > >  {
> > >         unsigned long top =3D TASK_SIZE & PAGE_MASK;
> > >
> > > -       /* Space for the VDSO & data page */
> > > -       top -=3D PAGE_ALIGN(current->thread.vdso->size);
> > > -       top -=3D VVAR_SIZE;
> > > -
> > > -       /* Space to randomize the VDSO base */
> > > -       if (current->flags & PF_RANDOMIZE)
> > > -               top -=3D VDSO_RANDOMIZE_SIZE;
> > > +       if (current->thread.vdso) {
> > > +               /* Space for the VDSO & data page */
> > > +               top -=3D PAGE_ALIGN(current->thread.vdso->size);
> > > +               top -=3D VVAR_SIZE;
> > > +
> > > +               /* Space to randomize the VDSO base */
> > > +               if (current->flags & PF_RANDOMIZE)
> > > +                       top -=3D VDSO_RANDOMIZE_SIZE;
> > > +       }
> > >
> > >         return top;
> > >  }
> > >
> > > --
> > > 2.47.0
> > >

