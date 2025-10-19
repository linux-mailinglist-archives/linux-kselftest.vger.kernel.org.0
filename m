Return-Path: <linux-kselftest+bounces-43517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E25E1BEEDAF
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 23:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C9394E107E
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 21:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A9E23909F;
	Sun, 19 Oct 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqvXp7dd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDEF354AE4
	for <linux-kselftest@vger.kernel.org>; Sun, 19 Oct 2025 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760910195; cv=none; b=OfbsiAkxeG/TKCZ3p/kEyqzrvQsqeDVZUIMVzCaIRSrRc4Wo8pgvP+RV8EQGsObmU68VoftaVT4+3KWWxGKcg4/lBHVqB4fog2f+jCgnfxuV7YzEWsd46sIZglGPbknu7ZdwgMFmKvHnvz5bXeqEriHr8/FlO29TFIYD8v1vjdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760910195; c=relaxed/simple;
	bh=pRsbt++EaAsOCRGs//K7o3KjcQGI35o2ZneHcvdF6PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4SM8LG1coquy5My/hUnqIfLI82ZncbX6EeBt2GdAypa3hpMScJYXk13ouYmHPRMIoiqXDMB5mgDTg1XR7inznOeapB0ne0oYW7i3P5mmRXMMc8gV5ezW9wkkOcNtiBa3A+w53V9uAxO+6pgdHRZ6tSXJVucdOcdKpENBMU6p+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqvXp7dd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57bb7ee3142so4429471e87.0
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Oct 2025 14:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760910192; x=1761514992; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dYhtkFNaT6hVSLlWHWHG49KT7TJItYuebittp1GOm1g=;
        b=cqvXp7dd5jde5k3qWVlZCmyv84y2IITDIolrTlyv2uspW7IvEwLmFfuZmYqPBP79AI
         TUBf49oAakwYPqu+Vk6rgz+OIyk+JG04jNg5eFhEGad0qMl/seSOetcMO4qHCVrXpLbN
         g30rDBX4Nvqeb8R8B2zlmxfWnoOYNBigzygHZjlAiJd5PB7AvLydaVRW8cUmkH2il1xR
         aqJWn47+i5ZFr6+fA0VEY+nSBz6ssawMDh5ZlmXqB8XAzdIIRiRf4y4NXKgjSpenSZ/C
         vI5zD+Hu7bY1oUx8g85D4L+113RA0PtFdHGXl20AK0QHtFj2a9zb3ChVkm8UFd3KHMbb
         2VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760910192; x=1761514992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYhtkFNaT6hVSLlWHWHG49KT7TJItYuebittp1GOm1g=;
        b=nOzWHq0wNNlEHhc6iT7oWIfrGUPR3BV7wWUvmbnEymILZmo+vEhVdlzvMoyCYGkMHB
         mngTmkrUhb1rmFsziTOkfjxuXxyVB6tbIwW5HOgK6RwkWnFw3lCqfy27wzPVe/C0d5LL
         iSW//LklY8VIMFsGCISSFa70hPdgrwZglcubvXC0KHeqXflgc+4Z2x51UHnPsavWMLNB
         wkir0AWuC7k0wLKwi39PWGau0jl1zwGvR5NOA5q+dLBUJ/amtT1XKv9M2ldozf8+NmpX
         EJOSNf4oQVU/sijhTg9WrmTmBtakLlbSi36IT4BX661d7dDJeJ1LdxzcYtirFkIgd08d
         7vVg==
X-Forwarded-Encrypted: i=1; AJvYcCXPvbOwkR0lY//VY9lS3EVgcr1SdlWpkg1xoWl9QDDwAx5OeVHClrjBiefbEMRRBPCXOiuvqh/bJnC34kFzqy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymTee3ZXxQpndo6xZgQY9iitm7EIETupCH37JlCacBNsLyR17C
	jPHRy9NVqyffPvCj6scLFssVzUdOor1WSlxPoleM39Qk8bx0PeroG1Lc
X-Gm-Gg: ASbGncv9d+JT/jh0fJRbszDZ3ONknFkvkSN6QX/6zCcOCsmc+bSz2GVUOHxk3OeLMIy
	KD5GoOdsNT/mHmyYU0uU1f6zshHZX9z01iOg34JJHf8q5r5z+VdcdsttvynIVxeXMRMxW59GLd+
	tkSQSkDyigxmzn19quq08/k6KHdxdE5gIPhYhmkIpd9yxEJuNT1N7Cwgt7D4zUnuat0RCda2s+Y
	dmeh/duy1yo1RH5jhu7ATAgA7GqjnPgYxYOZC80AWxxmXjNQuCKIToo35kmcNEt4ooGtP7NtVGK
	WNOVadQaWpogym8tu6Ty1Lx/9YPX3t/Iaj1I+686UFw8VSOMt8yPeT+GOmr8rDvpecQOXl7r2Pa
	FuUQdEZO9Fxssy034kwMb7bplrRs+5RfaGmUHjbaLfQkHVNF2xQZYQ5FPLnLK8/mocU0=
X-Google-Smtp-Source: AGHT+IEccrrXEJD3s6OMYbBUvL6YIHVHeE/qRhkO2crqOi3Y/aWkGn/9+DVuRqho0TBNliCQtaJsww==
X-Received: by 2002:a05:6512:61a:b0:591:d903:4381 with SMTP id 2adb3069b0e04-591d9034751mr2196467e87.33.1760910191978;
        Sun, 19 Oct 2025 14:43:11 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def167e8sm1896349e87.65.2025.10.19.14.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 14:43:10 -0700 (PDT)
Date: Mon, 20 Oct 2025 00:43:07 +0300
From: Sergey Matyukevich <geomatsi@gmail.com>
To: Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nam Cao <namcao@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 6/6] riscv: vector: initialize vlenb on the first
 context switch
Message-ID: <aPVba5_moA6g-0Uo@curiosity>
References: <20251007115840.2320557-1-geomatsi@gmail.com>
 <20251007115840.2320557-7-geomatsi@gmail.com>
 <CAFTtA3PyEnscQx+JtM3wBb0YZJxFjoJp4JB6QJQXbN6q3HVFyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFTtA3PyEnscQx+JtM3wBb0YZJxFjoJp4JB6QJQXbN6q3HVFyA@mail.gmail.com>

On Wed, Oct 15, 2025 at 02:54:39PM -0500, Andy Chiu wrote:
> Hi Sergey,
> 
> On Tue, Oct 7, 2025 at 6:58 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
> >
> > The vstate in thread_struct is zeroed when the vector context is
> > initialized. That includes read-only register vlenb, which holds
> > the vector register length in bytes. This zeroed state persists
> > until mstatus.VS becomes 'dirty' and a context switch saves the
> > actual hardware values.
> >
> > This can expose the zero vlenb value to the user-space in early
> > debug scenarios, e.g. when ptrace attaches to a traced process
> > early, before any vector instruction except the first one was
> > executed.
> >
> > Fix this by forcing the vector context save on the first context switch.
> >
> > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> > ---
> >  arch/riscv/kernel/vector.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > index 901e67adf576..3dd22a71aa18 100644
> > --- a/arch/riscv/kernel/vector.c
> > +++ b/arch/riscv/kernel/vector.c
> > @@ -120,6 +120,7 @@ static int riscv_v_thread_zalloc(struct kmem_cache *cache,
> >
> >         ctx->datap = datap;
> >         memset(ctx, 0, offsetof(struct __riscv_v_ext_state, datap));
> > +
> >         return 0;
> >  }
> >
> > @@ -216,8 +217,11 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
> >                 force_sig(SIGBUS);
> >                 return true;
> >         }
> > +
> >         riscv_v_vstate_on(regs);
> >         riscv_v_vstate_set_restore(current, regs);
> > +       set_tsk_thread_flag(current, TIF_RISCV_V_FORCE_SAVE);
> > +
> 
> I am afraid that this approach can result in a security issue where a
> context switch happens before the v-restore part of the current
> process, cheating the kernel to store stale v-regs onto the current
> context memory. Please note that this handler is run with irq enabled
> so preemption is allowed.
> 
> I would expect simply initializing the vleb in riscv_v_thread_zalloc,
> perhaps dropping the "z" in the name to prevent confusion.

Ok, so we can just set 'ctx->vlenb = riscv_v_vsize / 32' in the renamed
riscv_v_thread_alloc function. But note, that w/o forced context save
we implicitly reset the vector configuration to 'all zeros', overwriting
the hardware defaults.

By the way, could you please elaborate a little bit more about your security
concerns with the TIF_RISCV_V_FORCE_SAVE approach ? The atomic and per-process
flag modification looks safe to me, so I'd like to understand what I am
missing.

Thanks,
Sergey

