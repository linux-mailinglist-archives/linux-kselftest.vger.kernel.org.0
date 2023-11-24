Return-Path: <linux-kselftest+bounces-543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC337F721F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 11:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACB11C20F34
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B604404;
	Fri, 24 Nov 2023 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="EJcSyp3Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBD51B5
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 02:53:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfa8f7c356so1491975ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 02:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700823199; x=1701427999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G13q4Npyv/Ly9t6e83+KIY+krKu4thVjMslYff6WcPI=;
        b=EJcSyp3YLMqAnDWIZf7+QSxzyWIrVOM7ZFjx3xpbO/iP6aZZA8sQDS1x5VcRUmyycm
         dqvXwdlpdXnCxTwaAR7UYflX8598ojNcUeCB/Fl1x0g+vAZ8fI/W1nozcP7/sA3f0r8P
         WtSmDnbYwSYLuD5NVoJ/qBU7lBd30GunQ5oXSebijFz6c+O0sMrNsYUf8PLqI8bbYByX
         ix0CmYpasQuH+G/2OIgkff6IKJZwZOUjLLSAT4fTBZqBuZNdZsto2hV6ZcmHikQX1EuD
         sIVd03GrhmBpIOrvB5n5gjljOU2GhlaQOtCIS/S/PF8OX+dpamYYua+nsW+vREnthu0n
         PcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700823199; x=1701427999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G13q4Npyv/Ly9t6e83+KIY+krKu4thVjMslYff6WcPI=;
        b=Bvc086bTqC0SpsRSfvoKJyHJTNs7d04HVKULHwqIu2C6ZR44ZQYvRgExRLHd/B4tj2
         Ce9GJfyf6sfHtLt0303g2hS8lVTwt12vgRWdmZAUFXBCvygGj3MKVdfJ7XdcTYvlsdGO
         e6VzmF9Ks9atK2OyOlIVKIWqzowgpS71fEJaX7y2iYM7OxGwUsa0BBCR1x4YKiaXb4d9
         5WBeUi7XUdWc1CpsnADrw9dmKCfoHcx1r4NMeGpj/+kFsPDOXAAYG5rQkdyWcDlDB8Gr
         hMwLV2v2TngDMFZy9MCMosA+ieHikOvvX490G9n77IwCRBtR+bPh1LjcvWGmCNUl4K4C
         x1uA==
X-Gm-Message-State: AOJu0YyWukU62BpPtiw9ARrdoprIMstlnzqhCLEduT7QQRFURTP7ZTA5
	GKy90KgJKFVyxDJ1U4glWFbYla9j9bt3RLvIO0gnEw==
X-Google-Smtp-Source: AGHT+IFIeQIFowpfBFOWrzbJuo6dqXpVySOYNiIwl+Kh/YJg26vm2tehxdWw4alf5s2od+tF6f8fxXN9ap5KOjqXBjQ=
X-Received: by 2002:a17:90b:4d0e:b0:280:62a7:3743 with SMTP id
 mw14-20020a17090b4d0e00b0028062a73743mr2278223pjb.30.1700823199176; Fri, 24
 Nov 2023 02:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu> <20231124101519.GP3818@noisy.programming.kicks-ass.net>
In-Reply-To: <20231124101519.GP3818@noisy.programming.kicks-ass.net>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Fri, 24 Nov 2023 11:53:06 +0100
Message-ID: <CAEg0e7j1AvzTyaQ45wUP9QnsMpCG=ZMzcLNFYhGPPSgAwsty6A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Anup Patel <apatel@ventanamicro.com>, 
	Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Jones <ajones@ventanamicro.com>, 
	Guo Ren <guoren@kernel.org>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Daniel Lustig <dlustig@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 11:15=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Nov 24, 2023 at 08:21:37AM +0100, Christoph Muellner wrote:
> > From: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> >
> > The upcoming RISC-V Ssdtso specification introduces a bit in the senvcf=
g
> > CSR to switch the memory consistency model at run-time from RVWMO to TS=
O
> > (and back). The active consistency model can therefore be switched on a
> > per-hart base and managed by the kernel on a per-process/thread base.
>
> You guys, computers are hartless, nobody told ya?

That's why they came up with RISC-V, the ISA with hart!

> > This patch implements basic Ssdtso support and adds a prctl API on top
> > so that user-space processes can switch to a stronger memory consistenc=
y
> > model (than the kernel was written for) at run-time.
> >
> > I am not sure if other architectures support switching the memory
> > consistency model at run-time, but designing the prctl API in an
> > arch-independent way allows reusing it in the future.
>
> IIRC some Sparc chips could do this, but I don't think anybody ever
> exposed this to userspace (or used it much).
>
> IA64 had planned to do this, except they messed it up and did it the
> wrong way around (strong first and then relax it later), which lead to
> the discovery that all existing software broke (d'uh).
>
> I think ARM64 approached this problem by adding the
> load-acquire/store-release instructions and for TSO based code,
> translate into those (eg. x86 -> arm64 transpilers).
>
> IIRC Risc-V actually has such instructions as well, so *why* are you
> doing this?!?!

Not needing a transpiler is already a benefit.
And the DTSO approach also covers the cases where transpilers can't be used
(e.g. binary-only executables or libraries).

We are also working on extending ld.so such, that it switches to DTSO
(if available) in case the user wants to start an executable that was
compiled for Ztso or loads a library that was compiled for Ztso.
This would utilize the API that is introduced in this patchset.

