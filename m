Return-Path: <linux-kselftest+bounces-19699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A7499DC21
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 04:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DA32833D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0377C157A6B;
	Tue, 15 Oct 2024 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAVxhODn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11F21364;
	Tue, 15 Oct 2024 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728958552; cv=none; b=r0MAWqd/TYdhddkqgGXt1Tc+uDl6El5hsuEk0xI5zjP8jQj7fd48W3VV3WI2i8HZqTUW2UyEvYrnUuuhzTS78tqbIR9MHwMMgaoP2tkmvwNg9d3SRb1X/pI17gXOW0lU+i3agKQbw1+ZWpLaGIBrGI+mZqCUxgWlM/YX7DKbGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728958552; c=relaxed/simple;
	bh=zj+yKT66Ya6lE8e0vnuh5UqbKInuSzhnI7Xg6h665bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtTvetEwlvy8ZsAmNwcQr02/GY4AvtbkDLB4GtiYTx1OGVzOnt1M4n3IYq/nOv5L4j3uxcfY2wvrpzrOwYpooLhVB0vTkDA9Y2IniAQnRVnsVzyhLhToJdmQQAo2KKy6g0RlC1Zm/nZxImaOQf92RDMtxXyJzQhfDfPaWdT8sXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAVxhODn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7384FC4CEC7;
	Tue, 15 Oct 2024 02:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728958552;
	bh=zj+yKT66Ya6lE8e0vnuh5UqbKInuSzhnI7Xg6h665bc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pAVxhODn/epIL4ZAHa1mqm+0EvAFdiIKLAHgRb8EeTeYRlzGp2hki6/gQu9q9/ZK/
	 L32dYXlMN/0H4hTby7cwdCQK4ruiQglk1nAC6YYFkANsAi5FZvESPkfbaAYbtTUWlU
	 F4jd+j9P8RoeD4ew/6b5kSmqAsNNcn8XjaDGKN/9MMnEEPT3zo7+AEEN0iHD2HGhVl
	 wc/xLoieYSW7Ulmw4JJrJwBir2vUwJZxb8URdvUubbM75dGd7VSZcd3dJgA6C4mdkR
	 O+oFPwSNpOLdgVKws1nCnU/yM50BHZwS3zTVB2hebvwesey8NSepoEP+jeHh1lnXZw
	 uL1/nKKDSKzlg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99e3b3a411so432484366b.0;
        Mon, 14 Oct 2024 19:15:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0d30itF6sasuryfdrhJqvAPwyv248s5ZjwOaCCjbM6JYiGLRnJHnr3kZb34Ov/Pz3EipUnUlHqVtlySM=@vger.kernel.org, AJvYcCXCJhb7Ma3tXpmCkO/KaavAn86YIQsZsWzJ3/q0wOiDhEmT1NSL1asDFBrfq2x+fOjU18XWM3cZHzhEJeGbBI3O@vger.kernel.org
X-Gm-Message-State: AOJu0YyWY+HBk6oBvjykpM0l1J2O8vonpXJMrDt/yj+3rteZK8tKxai8
	BAhqTEXbqgaJEijyckWr2yoJjs/ndIYq50HcWHT2phH3eW6a07Q/EnATbqjE7jQ5kndm1MxDFuT
	n4TOnrX+O4/bsbq5WADZg6x0U7lQ=
X-Google-Smtp-Source: AGHT+IHB9ev+VUIapJ7FJ/lYxOacP14DRgTA+8WKy/oS+q4Ei90J54hQUfqyaSpYCMxhQAA7jAhetAjk7RTHQwBSNdc=
X-Received: by 2002:a17:907:7204:b0:a99:6958:a8ba with SMTP id
 a640c23a62f3a-a99a10ede1emr1682134466b.12.1728958550924; Mon, 14 Oct 2024
 19:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de> <20241014-kunit-loongarch-v1-1-1699b2ad6099@linutronix.de>
In-Reply-To: <20241014-kunit-loongarch-v1-1-1699b2ad6099@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 15 Oct 2024 10:15:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4GvYVphn+srVFEdPboxCz-z04vXa-=e5ptJpdJZgPp=g@mail.gmail.com>
Message-ID: <CAAhV-H4GvYVphn+srVFEdPboxCz-z04vXa-=e5ptJpdJZgPp=g@mail.gmail.com>
Subject: Re: [PATCH 1/4] LoongArch: Don't crash in stack_top() for tasks
 without vDSO
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: WANG Xuerui <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

I can take this patch to the loongarch tree, but I think others should
get upstream via kselftests tree?

Huacai

On Mon, Oct 14, 2024 at 7:36=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Not all tasks have a vDSO mapped, for example kthreads never do.
> If such a task ever ends up calling stack_top(), it will derefence the
> NULL vdso pointer and crash.
>
> This can for example happen when using kunit:
>
>         [<9000000000203874>] stack_top+0x58/0xa8
>         [<90000000002956cc>] arch_pick_mmap_layout+0x164/0x220
>         [<90000000003c284c>] kunit_vm_mmap_init+0x108/0x12c
>         [<90000000003c1fbc>] __kunit_add_resource+0x38/0x8c
>         [<90000000003c2704>] kunit_vm_mmap+0x88/0xc8
>         [<9000000000410b14>] usercopy_test_init+0xbc/0x25c
>         [<90000000003c1db4>] kunit_try_run_case+0x5c/0x184
>         [<90000000003c3d54>] kunit_generic_run_threadfn_adapter+0x24/0x48
>         [<900000000022e4bc>] kthread+0xc8/0xd4
>         [<9000000000200ce8>] ret_from_kernel_thread+0xc/0xa4
>
> Fixes: 803b0fc5c3f2 ("LoongArch: Add process management")
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/loongarch/kernel/process.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/proc=
ess.c
> index f2ff8b5d591e4fd638109d2c98d75543c01a112c..6e58f65455c7ca3eae2e88ed8=
52c8655a6701e5c 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -293,13 +293,15 @@ unsigned long stack_top(void)
>  {
>         unsigned long top =3D TASK_SIZE & PAGE_MASK;
>
> -       /* Space for the VDSO & data page */
> -       top -=3D PAGE_ALIGN(current->thread.vdso->size);
> -       top -=3D VVAR_SIZE;
> -
> -       /* Space to randomize the VDSO base */
> -       if (current->flags & PF_RANDOMIZE)
> -               top -=3D VDSO_RANDOMIZE_SIZE;
> +       if (current->thread.vdso) {
> +               /* Space for the VDSO & data page */
> +               top -=3D PAGE_ALIGN(current->thread.vdso->size);
> +               top -=3D VVAR_SIZE;
> +
> +               /* Space to randomize the VDSO base */
> +               if (current->flags & PF_RANDOMIZE)
> +                       top -=3D VDSO_RANDOMIZE_SIZE;
> +       }
>
>         return top;
>  }
>
> --
> 2.47.0
>

