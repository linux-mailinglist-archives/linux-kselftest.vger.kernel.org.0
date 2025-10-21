Return-Path: <linux-kselftest+bounces-43685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53423BF900B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 00:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F3324E4D02
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86223285C8C;
	Tue, 21 Oct 2025 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQLjlWE0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44F258ED1
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084490; cv=none; b=JzHH5OT4Xxk1MhH71dBBTNX8KUVxdpUTTkEIbfsc24NQBcS1xxaTBj5VORZwjHM5cuLLzkpMCZiX1A8VhGvXPofvfIBZLqRws/LnK/R1NnP+z0hiCvfjHsAC4Ot8yKzx6rqsvhHl3tisvcyJ/ca667fGb1X7jpfmMMhNY+Y3VTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084490; c=relaxed/simple;
	bh=4qsm8FsP0dtmKdU9vOdB19fzdAVoHtjGAmNhKECK0Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ae33gIV98UrCxX/ihu8JwmEg5YoqOUNwCPBJbZLAMAR7qrQ45E2IK/TmZxCfL5Nro3cilX/wibbTrdzLIhqWeQW+Up41bi6EDnLTdgFo4ChNxpGMeygpXp7owpXXPnvEeF/HL9Q4jV5KsRxcI9aCoZX6pYEpPueJEuQLODnkKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQLjlWE0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b40f11a1027so1197566566b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761084487; x=1761689287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SJXvV85x5jMosgE1Az7dDeZnp5kW+qnV7kl2NORTrk=;
        b=mQLjlWE0dIFFiAN4RuSUfRVuVWA9+O0EnrMRjw+vmqkuujP36P81AA1E/L8STyRuaV
         FBHk7ukG8ouVD1zAGhiqlf1COUVo1eNcHuXl/KvR3sf4m8aEVwmlbufQ5B5OlqhvkQhp
         GHNoI9QTGK7yn4Vi2Y84A8OiWsgK5+/BuNWP+UZ7Sz6iz+AiXRUKjx1nkq3BqzjRvKsV
         CPVywmtaxndaOTNWk2scYlkxxmsWXuyxnVr22waX/gaK8Ju/0Y+wk7OM/fijATy32M5r
         Tpml7cSCsFjbhZniJTTxpgGFSK8wTkvLfAwbH62emZGASJMe/kVANlUUz++EWRUNFbaz
         uQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761084487; x=1761689287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SJXvV85x5jMosgE1Az7dDeZnp5kW+qnV7kl2NORTrk=;
        b=Xs/EzDrrK9t96oLJ9xlL6MS0scqJsOcvJJb/fmuF44xrsp8uss4EYRpbXU0Yv7vXa/
         NUkW6myrqz7eP4NcHGVYDHNW4DY/KAGx4o+2ZTHjZfTh2Efu98MYVKP6MPIFGpsfbhPL
         Wr9JAro9qmsLqRooaWfUAzt98KZG3Dx79YLe0SnSFgeT84/dJkiatbE/yQKqKOpoBtRd
         qu/QDU4p83Lo4pF705Jm3ai1otWhF8GOpOTsA8TIHfm0NJS5QbQcMupjomONl2Es9js+
         JF/nG0SzB9OYVX3gTIlRbsvYS1qCZaHiT1IWCXWA4AzAVEBjXZUVEihVqLgIZpcf7/eJ
         vD9A==
X-Forwarded-Encrypted: i=1; AJvYcCWbhHOTv/4T9mxxJnULd5FTHJSfl0x1ABYi8kQaV3Q5J6xVUL+7Ibay68E4p4xxWkQalGyD3i++rs14QF20OW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/R/AqJB7uhveCaUUq6wDVq5oHmVeGjWfpiXNxfLySq7mTPim
	vcY+/6ag4LZZjHQAhSfKBD2XCWuM735jCZtWkXFkYbY11n9N6pGaTEHUGPZvVuGH//xFAWV3v5S
	SIpAmokI1HI3M2HBaukDa9ensXhIJTZQ=
X-Gm-Gg: ASbGnctlDfy9laR40BOxY/FZQqao6uxNKiIYQoNZl8YTh0trn0TxU6WCvq3PJ3KRWVD
	SnHtJNTXItPC1/gjp3TC744+8eAmC0Hlpddhx0Hb9I5NX9sqqOHJh+caKUUxqU5lMEzgAyjIVs+
	6R7BZOwmAV2md+bzGd9peD5M273Zn8KWg83LweVLO7NdeN1XtxG4x6PCIz3WKMSczR7Id3hUpZY
	cpGLpjKRBk+/04Bqjq8YO545ugETf6Y6Az8y6RJrt3jM+4GfZg6QowLVQ==
X-Google-Smtp-Source: AGHT+IGDo+j3YXKHOCH7efiHHOrt3v6TVVXF/wuEOE3mxT2beymntSTmRW6G/B3jC0eiwCHDf4Q5xC6fF6QnKR0lv5g=
X-Received: by 2002:a17:906:dc92:b0:b4f:ee15:8af4 with SMTP id
 a640c23a62f3a-b6474b35fe6mr2129834666b.34.1761084486712; Tue, 21 Oct 2025
 15:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007115840.2320557-1-geomatsi@gmail.com> <20251007115840.2320557-7-geomatsi@gmail.com>
 <CAFTtA3PyEnscQx+JtM3wBb0YZJxFjoJp4JB6QJQXbN6q3HVFyA@mail.gmail.com> <aPVba5_moA6g-0Uo@curiosity>
In-Reply-To: <aPVba5_moA6g-0Uo@curiosity>
From: Andy Chiu <andybnac@gmail.com>
Date: Tue, 21 Oct 2025 17:07:55 -0500
X-Gm-Features: AS18NWBxOA6BKOJR9HnSchM5A8gYAiLSQ89wMSBHMqfEeBqTwrIduyXHCKRwkyg
Message-ID: <CAFTtA3NW=8JDnr=JN2X9q9YwYLihsF3zE06VTGSzg7kVjDLJZQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] riscv: vector: initialize vlenb on the first
 context switch
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Han Gao <rabenda.cn@gmail.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Nam Cao <namcao@linutronix.de>, 
	Joel Granados <joel.granados@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 4:43=E2=80=AFPM Sergey Matyukevich <geomatsi@gmail.=
com> wrote:
>
> On Wed, Oct 15, 2025 at 02:54:39PM -0500, Andy Chiu wrote:
> > Hi Sergey,
> >
> > On Tue, Oct 7, 2025 at 6:58=E2=80=AFAM Sergey Matyukevich <geomatsi@gma=
il.com> wrote:
> > >
> > > The vstate in thread_struct is zeroed when the vector context is
> > > initialized. That includes read-only register vlenb, which holds
> > > the vector register length in bytes. This zeroed state persists
> > > until mstatus.VS becomes 'dirty' and a context switch saves the
> > > actual hardware values.
> > >
> > > This can expose the zero vlenb value to the user-space in early
> > > debug scenarios, e.g. when ptrace attaches to a traced process
> > > early, before any vector instruction except the first one was
> > > executed.
> > >
> > > Fix this by forcing the vector context save on the first context swit=
ch.
> > >
> > > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> > > ---
> > >  arch/riscv/kernel/vector.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> > > index 901e67adf576..3dd22a71aa18 100644
> > > --- a/arch/riscv/kernel/vector.c
> > > +++ b/arch/riscv/kernel/vector.c
> > > @@ -120,6 +120,7 @@ static int riscv_v_thread_zalloc(struct kmem_cach=
e *cache,
> > >
> > >         ctx->datap =3D datap;
> > >         memset(ctx, 0, offsetof(struct __riscv_v_ext_state, datap));
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -216,8 +217,11 @@ bool riscv_v_first_use_handler(struct pt_regs *r=
egs)
> > >                 force_sig(SIGBUS);
> > >                 return true;
> > >         }
> > > +
> > >         riscv_v_vstate_on(regs);
> > >         riscv_v_vstate_set_restore(current, regs);
> > > +       set_tsk_thread_flag(current, TIF_RISCV_V_FORCE_SAVE);
> > > +
> >
> > I am afraid that this approach can result in a security issue where a
> > context switch happens before the v-restore part of the current
> > process, cheating the kernel to store stale v-regs onto the current
> > context memory. Please note that this handler is run with irq enabled
> > so preemption is allowed.
> >
> > I would expect simply initializing the vleb in riscv_v_thread_zalloc,
> > perhaps dropping the "z" in the name to prevent confusion.
>
> Ok, so we can just set 'ctx->vlenb =3D riscv_v_vsize / 32' in the renamed
> riscv_v_thread_alloc function. But note, that w/o forced context save
> we implicitly reset the vector configuration to 'all zeros', overwriting
> the hardware defaults.

Resetting all vregs to zero is desired as otherwise we may
unintentionally leak stale states from other users or the kernel to
the user process.

>
> By the way, could you please elaborate a little bit more about your secur=
ity
> concerns with the TIF_RISCV_V_FORCE_SAVE approach ? The atomic and per-pr=
ocess
> flag modification looks safe to me, so I'd like to understand what I am
> missing.
>

The concern is information leak. A context switch can happen right
after the FORCE_SAVE bit is set. At this point the kernel saves live
vregs on the machine to the context memory (vstate) of that process.
The content of live registers may come from another process, or stale
value of in-kernel Vector uses, since we don't flush registers at
every ownership change. When we switch back to the original process
and return to the user space, the saved stale content is restored back
to registers. As a result, the user space can read Vector registers
from other contexts.

Thanks,
Andy

