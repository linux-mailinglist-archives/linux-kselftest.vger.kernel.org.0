Return-Path: <linux-kselftest+bounces-651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D515B7FA301
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 15:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DC7281842
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341611E501;
	Mon, 27 Nov 2023 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="JC4miItv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759EBD53
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 06:37:09 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so3037900a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 06:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1701095829; x=1701700629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTOVcypQtVTFXZLfWHCe+N3Q12yUhXgQHc0UVNtkCoA=;
        b=JC4miItvz+NNVDj+y3lT1yhmxlqFLhlRLgpxdSIpZq/XysiB9qs8kFDJqLnWKKEdvA
         zTvAixW8G1yrdu/1zfm3ED6XUuHXwts5h9rGRNpJ/CHg7UQ2DEILf9VMJ2VCaDCPxngA
         Xgev0L4WZg3F59EWaXc4iVfrmyRrTXhVT3Hhv3su9y6EKaH7GTQEDjq0UnqlU50YrS8z
         v3fYwnkEgYfRiqmO+9SwlyVvApjfNTvdnBUuLife6k24ENvxJHIl7TVGArrzHOaD0dsm
         NDkj3oK53dtUvsHi3aAHAwUuQs1qz1WJl8FfVBgRLnLa+e1NHGz9lLnIB0GguYYkpG1M
         Kopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095829; x=1701700629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTOVcypQtVTFXZLfWHCe+N3Q12yUhXgQHc0UVNtkCoA=;
        b=bdKlC8E/7PT04p58PSb8w5o0oXoixv2ssZwIOOcS8FZA3+dQOgOR0i9yFR4vjbpT/Y
         vFyxQ4WSlB8WlZhKns9lsnOmCS0biT6fD7CDVSUxkYZFbnW5V6vqhNihjdgwSyjc6yl6
         8vPBzE7JpHLwmco/XbICWp0hcZiJ+ehTYboNdYdDvzUuOd20TGpjqCDxMt1UG18KSnTo
         i6IMKddjcpzeehjMJZv5DErB30DZLa56Jeqfbnff5wqh6oWTf+1UXPQ/7oW+7oDImpLF
         1zKdlX39L3acdcJb9dhaU7sJs+DijG8ds+dTET1CoJWp2q9b3RaHMAI3ANRlxbODcr/s
         X6YA==
X-Gm-Message-State: AOJu0YxXeaQkgrtKqDJGaC0tHTvBFgtWrN/4oBJl5a6FXF81vdIJ6JKQ
	PW8nUMy5bHnRRP7lEkGmnU0/XjX1ViccS44DEyqDFA==
X-Google-Smtp-Source: AGHT+IEqiGw8cZsLsTuXV7V9RWHgcqAqIuGMwaeWQRzgkPyJ/z9ud9P0jKpwYm+TXJaPLPaE+VQDYAAo3ye99gZjpCI=
X-Received: by 2002:a17:90b:1b07:b0:285:9d0d:7e3 with SMTP id
 nu7-20020a17090b1b0700b002859d0d07e3mr10951786pjb.38.1701095828964; Mon, 27
 Nov 2023 06:37:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
 <20231124072142.2786653-3-christoph.muellner@vrull.eu> <2de6d526-918b-44f6-b26a-a0f30c42c5b3@sifive.com>
In-Reply-To: <2de6d526-918b-44f6-b26a-a0f30c42c5b3@sifive.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Mon, 27 Nov 2023 15:36:57 +0100
Message-ID: <CAEg0e7hPvpCcqn4VLsmuUkyoZSZ_oTBLJraR653yUcFPKsq3vw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] RISC-V: Expose Ssdtso via hwprobe API
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Anup Patel <apatel@ventanamicro.com>, 
	Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Jones <ajones@ventanamicro.com>, 
	Guo Ren <guoren@kernel.org>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Daniel Lustig <dlustig@nvidia.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 3:32=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Christoph,
>
> On 2023-11-24 1:21 AM, Christoph Muellner wrote:
> > From: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> >
> > This patch adds Ssdtso to the list of extensions which
> > are announced to user-space using te hwprobe API.
> >
> > Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> > ---
> >  Documentation/arch/riscv/hwprobe.rst  | 3 +++
> >  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
> >  arch/riscv/kernel/sys_riscv.c         | 1 +
> >  3 files changed, 5 insertions(+)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/=
riscv/hwprobe.rst
> > index 7b2384de471f..8de3349e0ca2 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -80,6 +80,9 @@ The following keys are defined:
> >    * :c:macro:`RISCV_HWPROBE_EXT_ZICBOZ`: The Zicboz extension is suppo=
rted, as
> >         ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv=
-CMOs.
> >
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOZ`: The Ssdtso extension is suppo=
rted, as
>
> Should be RISCV_HWPROBE_EXT_SSDTSO.

Thanks for reporting!
I've fixed this now as well in the github branch:
  https://github.com/cmuellner/linux/tree/ssdtso

BR
Christoph

>
> Regards,
> Samuel
>
> > +       in version v1.0-draft2 of the corresponding extension.
> > +
> >  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains perf=
ormance
> >    information about the selected set of processors.
> >
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include=
/uapi/asm/hwprobe.h
> > index b659ffcfcdb4..ed450c64e6b2 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -30,6 +30,7 @@ struct riscv_hwprobe {
> >  #define              RISCV_HWPROBE_EXT_ZBB           (1 << 4)
> >  #define              RISCV_HWPROBE_EXT_ZBS           (1 << 5)
> >  #define              RISCV_HWPROBE_EXT_ZICBOZ        (1 << 6)
> > +#define              RISCV_HWPROBE_EXT_SSDTSO        (1 << 7)
> >  #define RISCV_HWPROBE_KEY_CPUPERF_0  5
> >  #define              RISCV_HWPROBE_MISALIGNED_UNKNOWN        (0 << 0)
> >  #define              RISCV_HWPROBE_MISALIGNED_EMULATED       (1 << 0)
> > diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_risc=
v.c
> > index c712037dbe10..c654f43b9699 100644
> > --- a/arch/riscv/kernel/sys_riscv.c
> > +++ b/arch/riscv/kernel/sys_riscv.c
> > @@ -162,6 +162,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *=
pair,
> >               EXT_KEY(ZBB);
> >               EXT_KEY(ZBS);
> >               EXT_KEY(ZICBOZ);
> > +             EXT_KEY(SSDTSO);
> >  #undef EXT_KEY
> >       }
> >
>

