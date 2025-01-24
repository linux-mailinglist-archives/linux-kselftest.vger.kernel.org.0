Return-Path: <linux-kselftest+bounces-25064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023B8A1AF06
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 04:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C1F18874CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 03:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00491D5CDD;
	Fri, 24 Jan 2025 03:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Th/U/Mc7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F21EA65
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737689209; cv=none; b=i8Wi413i6blRIB/nAOXKD1Mh3ttOHclIRJBCEzamZuQl+vUojk78KLlQCXhq/DnDius45qIa4HM+BEvxoiHTnzrqkDapb346P2IUHVGVAR6Bw5vwlC0R6DtqikHuUpu72bLk1RtJBG5RroBPambKcVqNq+iWES53gQLzg93ejLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737689209; c=relaxed/simple;
	bh=tU2QzktmPdlYAOQVknfO8sr/6ZNOUzyHr3Z6kwiTXOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efDgMoCa+CN436cagkqqEDg/yXtQ/evUtPVcPo6yzN9zAD2bmJJAaOF4R1RhVp9dqg+fC7h8/H4oUXvFesU2Th4rO89/YytnV5jkFMHrYfRlyR/N6L9QIFZ3T6esUzZsZSTu1d6qbaHoOSH29I0EqMQ+ZR6466/2CS6LtBAuf7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Th/U/Mc7; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e2aa8d5e3so892609a34.2
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 19:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737689207; x=1738294007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wYF9SYVPXBWNDoppVRqkp4GObHclaiBorKPLUibZhw=;
        b=Th/U/Mc71LQSRM0LOKGShmVw79HpErnHpIEXwwhSu+sC50mL16dTPHLAt4xUl5u47A
         V1EtX4GlyVJGlVRlcQNlfgsYtsAaIhUJiL1/tFgYG6uGkS3+UoHgj+i/JJDLH4khErIJ
         hl6vLLAEwwOI6HMUOj3WU5jNySuiBKEVcFkouDAt47Pw0uZ2lHO2SA3LK94S12XftsEU
         HdfqxySVzPOK+DqWL+smg0kgXOjgOq0X7bJmiF3bhUR8R5VOuO8mCnSw/KkwBxkcrjwc
         cqxsMCORI5x/AAylS3/3mf87N4koksvUNaxnPTc+7QkaOzFtPUIgUcd/UPAO6s6v97w/
         nBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737689207; x=1738294007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wYF9SYVPXBWNDoppVRqkp4GObHclaiBorKPLUibZhw=;
        b=cqUxNrJUFlvLUyP4G7HBDrlG9tL5QpmqBNqSYxZm2Vo0KlNgJeEBfWzldoaUjDGW4S
         TslvCXrj5ZXjpIBMr7uB+90ozGZw1uJEKi55d4g7KySht6TUMFCrlHTMGu8N7Xv0FyOY
         x0lUlCz6p2+9jX35hN66Rwk1GgmXiMpBEWog2NmSiPwEjso2iGqcQnXUMzJUSZDO1nJR
         DflOWXp6qr2nD0pk9ccTCCODnnnjwbGxST/KC3zqVkfyqzoLpJo6la87K2/BBTgxuv9C
         Eqrf9ZvJgeb9uGVVjjMIGKL6CdxatELUOmQlvJcew8GZJCZM5jEosqnWOxS+WKtGEPo/
         Mwnw==
X-Forwarded-Encrypted: i=1; AJvYcCVN1fzuwp6OpbBX0chIewPfE20I8kfBA6ZsvQNHwb43a1rj/JCkl0EV+UyLgiHUPgZGsFj93aiXB1+wa10D3uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEm356oJyJXVRKrGe75/Z4yqo0cd1HBGLHBthnBtcdeT7whA86
	CaTlJly1NDhmS9Lj8n6/CCV45i5GdiVMvAW2oeeQVrDa/tSUpjpuywkd3tNNB6cQF5qrd4W3mVJ
	DMHu7TePMLh3rxe6d7EzJe1gNwimwGtcFKq9rJg==
X-Gm-Gg: ASbGncuqvhxwF881sWrz5MyBHqWkYB5pTC8pYp5JM37cZXeWQwk2938Amogmz07qcsV
	fnGvCAhd1d4gocLvr0lUtmpXWZSUUyOlkXumjorxzf3mmfDwel6mPTU3r6FVyYKBR
X-Google-Smtp-Source: AGHT+IFGnKLva7FD+LaCZWDZWwF1THCBFHRVpsQutJS5kXSNOriJYKOl1H7ykN+A+qzX7nta9YxDL/rzI0cKEjaNzAA=
X-Received: by 2002:a05:6870:2f0d:b0:29e:5522:8eea with SMTP id
 586e51a60fabf-2b1c0b6cdc0mr17604012fac.38.1737689207038; Thu, 23 Jan 2025
 19:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115024024.84365-1-cuiyunhui@bytedance.com>
 <20250115024024.84365-3-cuiyunhui@bytedance.com> <20250121-4990d96a861a4ddd304abc33@orel>
In-Reply-To: <20250121-4990d96a861a4ddd304abc33@orel>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 24 Jan 2025 11:26:36 +0800
X-Gm-Features: AWEUYZmWZdjm8pzj4zzIf6rTTBzAFecQ8H3gVQ0i5poz74_c15zJ4cOjObQZY58
Message-ID: <CAEEQ3wnZK2xkQ0+pnNCEvXJ6TUVnCHrkL_VNfhK=9Duy0yKNoA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 2/3] RISC-V: hwprobe: Expose Zicbom
 extension and its block size
To: Andrew Jones <ajones@ventanamicro.com>
Cc: alexghiti@rivosinc.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, samuel.holland@sifive.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi drew,

On Tue, Jan 21, 2025 at 11:29=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Wed, Jan 15, 2025 at 10:40:23AM +0800, Yunhui Cui wrote:
> > Expose Zicbom through hwprobe and also provide a key to extract its
> > respective block size.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
> >  arch/riscv/include/asm/hwprobe.h      | 2 +-
> >  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
> >  arch/riscv/kernel/sys_hwprobe.c       | 6 ++++++
> >  4 files changed, 15 insertions(+), 1 deletion(-)
> >
>
> As the bot points out, we need to add the following to this patch.
OK, I'll update a version and change hwprobe_ext0_has's second param to u64=
.

>
> Thanks,
> drew
>
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index cb93adfffc48..6b5b24b399c3 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -160,7 +160,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pa=
ir,
>         pair->value &=3D ~missing;
>  }
>
> -static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long e=
xt)
> +static bool hwprobe_ext0_has(const struct cpumask *cpus, u64 ext)
>  {
>         struct riscv_hwprobe pair;
>

Thanks,
Yunhui

