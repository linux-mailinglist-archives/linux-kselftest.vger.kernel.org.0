Return-Path: <linux-kselftest+bounces-43259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91000BE08DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 21:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461583AE907
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4752FE05A;
	Wed, 15 Oct 2025 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmHAfKiq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A51D90DF
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558095; cv=none; b=cEuaY3wjRd+UrRjNz4+eRvj/kSmLHh+eDvJAy2WfLepzxAXx9RkPgcGM6l9tPSgobjLEcx1sCZ7AuHaiUttGAm2pybNyEASoicLtzSz8JV7Z0nmYob/qLoqVGWPJNmaRF+VLVDJT6vObwtO9TgtN8uIeAdaE/ganqkR52bbsdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558095; c=relaxed/simple;
	bh=7cERwAYvh7kapEYt4KUJoU/OdetumyCby/e4pAxQs3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K13soJSNGUkqcogcW1Rhvz0n+PqQY8gK9Kz2L6j+00RaqkSC+5MSRWaKIptwGJ7NayMsse5QjDzlH0vttnarDLRVeXTBoTyw+wRPIpcBjUGhNqdkm3yKajIpjNcGRXeV7P1VmRhYzEJwq5WmtxLZ89/7vplyswuYxrEPRZnoN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmHAfKiq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-634b774f135so11258040a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760558092; x=1761162892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6txPrWGJQKba/YBePw8USSq9dZr1PQIVujAd1UbYZG0=;
        b=KmHAfKiqqueh6WZSce87x0aXV3RfnrIQvUruY1h1ljjkpf4i0/0Xyj0TJEIBTnWg/5
         PWiboW7YtuqNJdakENSbmeKdh3Lhh0zJShIEKfMaqWyGi/hEJ6gppytElA1jOG+Uf+Ii
         gwazGNWoDSYcbn+1EMcWT+k8048BxlsF7R4x2eqzQ9Ja58tsFr34CNFUmmb8n4HMOlZ1
         B3nzj1XbWMMoVpn9c2/COuUKsjeJtD1rQEZjvDRxIPK+YZBOCf1Ehg4jkkXUIqoRPaQw
         Kp0wzpeIjZC+Q4ItxcqXry1Mzr6h2B8NOJcacqNmH20b7oNSbP53JrlEKJTFkz+j35ph
         oCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760558092; x=1761162892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6txPrWGJQKba/YBePw8USSq9dZr1PQIVujAd1UbYZG0=;
        b=DWZ36BYVt1hW+n4taHU+pZVA+Rfo8Op7IJTDZaJdSTsWoPBOJs8Iz4OHab1N9bT9rz
         Ts+IGVCnFJW6pEaKzytElHGvckxmd8twi6B8zTqF/qVpA2xRArqjaTd0qsGmsFa++OlH
         NYxk0GX3yEiyZi1YRrW+tb6z4PJ6+XLbH/niPKbOW4aZjBBvcTGVRslggKb9WBcs84Si
         0RD48A8XHadGqsJW5Pkbq8urZ5GuLRXcGbDIxYOAMkLmcJGCUAI7dJ7IDdsFbrvFNG0a
         xAFvD4a5XZgzj8u0jyIPVqRogIS/R93SnytbMClSi0lyst9I19nFEH4a/e9VS/92ro2C
         bwTA==
X-Forwarded-Encrypted: i=1; AJvYcCVnFrLl0rcdxlcx9WijKM07hxcvfIUrEtUJEAdxhYVzZDIzZoZU6OmgE54+5rtAbuhbxqZvINHvJouK5UpIXg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPsC7VjreN1Eqq+P5UBHooJyIYDd/zdNPT5VUIhYYwL8QbxmN
	VaF2/1M5zKU/CUBf4wvoAEwVVF6e0Hk2XTg6qfd8lisxyyICkxuBLRFCxHqSpj/rGMEzdPpxuI+
	BVgVxM9uiWRtzV8MyNCw74huMHd65ZaQ=
X-Gm-Gg: ASbGncttrRHgt5ETGpVAs/9HCXAVmIKEu8FE78PsJPzdDfGkrrrjdkF3VoCy3Px2HjZ
	MOMITlqzutQYNaQb52jTx+C+SPemDJG7okrj2mZMlRk8eqxWl2bVo2oaULfBu1zxYvocEK0iu25
	cj50KA6jvtoqKo381m0LKtCwYsIOn7qENy8vzgALBw/88ETHswte3qZLbcI/W/JoKVGBtKe5Qv3
	FbVfYpLRkGCsSlaKBOtpzIEknVCuNuhqg==
X-Google-Smtp-Source: AGHT+IEUqo0R2GZOT/KXkXAx0vTk4GL7xiLp5gkL3ByIOaHhbjRuEg2HqJikmhAYuLgjjr/94NEnrgCCj3+qDPfl2F4=
X-Received: by 2002:a05:6402:50c7:b0:634:ab36:3c74 with SMTP id
 4fb4d7f45d1cf-639d5b80653mr28131910a12.9.1760558091971; Wed, 15 Oct 2025
 12:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007115840.2320557-1-geomatsi@gmail.com> <20251007115840.2320557-7-geomatsi@gmail.com>
In-Reply-To: <20251007115840.2320557-7-geomatsi@gmail.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 15 Oct 2025 14:54:39 -0500
X-Gm-Features: AS18NWAHrDSUKeL_x2zKeFwwB6V8GhrxKoLsuT-6g2e1OqQMu1bXWZWGOV6Nh_U
Message-ID: <CAFTtA3PyEnscQx+JtM3wBb0YZJxFjoJp4JB6QJQXbN6q3HVFyA@mail.gmail.com>
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

Hi Sergey,

On Tue, Oct 7, 2025 at 6:58=E2=80=AFAM Sergey Matyukevich <geomatsi@gmail.c=
om> wrote:
>
> The vstate in thread_struct is zeroed when the vector context is
> initialized. That includes read-only register vlenb, which holds
> the vector register length in bytes. This zeroed state persists
> until mstatus.VS becomes 'dirty' and a context switch saves the
> actual hardware values.
>
> This can expose the zero vlenb value to the user-space in early
> debug scenarios, e.g. when ptrace attaches to a traced process
> early, before any vector instruction except the first one was
> executed.
>
> Fix this by forcing the vector context save on the first context switch.
>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  arch/riscv/kernel/vector.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 901e67adf576..3dd22a71aa18 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -120,6 +120,7 @@ static int riscv_v_thread_zalloc(struct kmem_cache *c=
ache,
>
>         ctx->datap =3D datap;
>         memset(ctx, 0, offsetof(struct __riscv_v_ext_state, datap));
> +
>         return 0;
>  }
>
> @@ -216,8 +217,11 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
>                 force_sig(SIGBUS);
>                 return true;
>         }
> +
>         riscv_v_vstate_on(regs);
>         riscv_v_vstate_set_restore(current, regs);
> +       set_tsk_thread_flag(current, TIF_RISCV_V_FORCE_SAVE);
> +

I am afraid that this approach can result in a security issue where a
context switch happens before the v-restore part of the current
process, cheating the kernel to store stale v-regs onto the current
context memory. Please note that this handler is run with irq enabled
so preemption is allowed.

I would expect simply initializing the vleb in riscv_v_thread_zalloc,
perhaps dropping the "z" in the name to prevent confusion.

>         return true;
>  }
>
> --
> 2.51.0
>

Thanks,
Andy

