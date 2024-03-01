Return-Path: <linux-kselftest+bounces-5768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E518786E995
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 20:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82993284AF8
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E0A3A27E;
	Fri,  1 Mar 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JNOHpvvu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C723A292
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321415; cv=none; b=IYXhqznLerXAYk+0fenCIAH7iCzjW1A0wgLZaygqmTMAbfTC9USd2+TU7O4ssSLAJmfN35/N1cENeJWobwFXMS74YETRkaEuPCaDJW7uEEXnlxjATm7jjafiTJF5aXH+B2d6svtseVNK7eD6uEU9e9WJzCHGpMrxISMFqmh/DBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321415; c=relaxed/simple;
	bh=31x3y21LpH70GlBu1DdA1CFlQph1h/vZyT25oUhjLhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpXGr6VsxAUWyDejIrO+Pq2WNpw6BIX6txJhZ5/w7NQhxQD+UMoi9sdixwZf2Lw+aEfgsiFRcYgC3DYSBT5qqM6Fsn0hn5zkFh+T3QTJWM5jx2x+VhvzJzwdwIcpeP7rHD8vjKtQHDA1YLJkuyg7yLvsQWv14+fAgsblXCFl1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JNOHpvvu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51331634948so871945e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 11:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709321412; x=1709926212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsQincBmT/DYFfglWuXNoT+0WIOyDGqPo/zOjnWnfU0=;
        b=JNOHpvvuVdd8tz1ggRk1VcgQZGkzea+5HHurovTcr+/NbP0e6mbA3zocC4M+QFEPMA
         1wP+sDoQycxciBuQxjQltZ0QZQ+QyrXiOMnACURQBh4YdSdlHjC4stayeUDtuUH/0HVY
         W7gAMeD9ByTn4Awrva20M2wOTzRl5W+cgEaN7P5kabLfBJCG7KvfOnjNnhv/GQwV7hRB
         E1Vsp39i+Eq+wtO+xoEvoxHIthHzhZcuJCO/l7PezjHnf4fO01bv6ZSILSB5sbF7qwkK
         y06cZnGmWqDjz16mYyDydLU7h8zN9PLoJ3/aSQJSFr611CSYQdTGeRaTprtk2ZBA2Lbk
         b2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321412; x=1709926212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsQincBmT/DYFfglWuXNoT+0WIOyDGqPo/zOjnWnfU0=;
        b=U+PBP0eiS/vSao/Q9+u4BRTvYgy85w81tbYsTYUtz8T1ahGY8NAGmxxs02J2FHCeeB
         yPfXyiJYXG/vf7e7erloIoD2CX2tq1Hsy2j822z5jZfuT6oaW/y3qCF8sJeY1yeciKnF
         tonP4VLjyaLBn0yZNB80V9IXJiLmY/RX+7Lk/9J2JVKrJNeEcpFPuphBZSUw5Bp2JDja
         xZdzGXbujTO+A9GuJ1E08uhVdFi6uWFLZDlK4YZcVL2CULdJ2E8Va44MZUue6zVa22q3
         LHy0Jkp6UouMMucpeLdb6XaGNku2LnlYVGywxXrEQH0HdVO/LDwkG7VzIQiZg8eiTTR8
         TI5g==
X-Forwarded-Encrypted: i=1; AJvYcCX9GlpFZPJm3OGXK/Nz75cUZTTCbfFKXZ8M+XzVbRi+UdDaZs3H5eG1sF1VPYq90dp0bdDZLt13IQLEtReEiSFEO0wZFMzpC15ErHC3jKWX
X-Gm-Message-State: AOJu0YyoHugPNk8awnem+XcD8jQviv5l0Uoarl7Znef7sHn5q/HMkJk6
	prxqAwo1ZPI7UAjAP9BIMtolU1/KcdVRvtvqOWqbKe73A8cuf1EsFGX2v0eZCC2GGUEhfcgJq8q
	ivXIQHbcN7GNQkGVhd3VOqYFUAdMUg+mQFldpWw==
X-Google-Smtp-Source: AGHT+IE+PvaR/VOgtC2hoRUjS0qfpwNjV/lMNaZfJiJ9vAQn76qy2Szeh6K3tc4T3wCAmpo/ciJWJCZhYz2vHJy2yy8=
X-Received: by 2002:a05:6512:3993:b0:513:3309:d59a with SMTP id
 j19-20020a056512399300b005133309d59amr1701352lfu.34.1709321411711; Fri, 01
 Mar 2024 11:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-5-atishp@rivosinc.com>
 <20240301-1a1aa2a2c04640c34749cb5f@orel>
In-Reply-To: <20240301-1a1aa2a2c04640c34749cb5f@orel>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 1 Mar 2024 11:30:00 -0800
Message-ID: <CAHBxVyHCB+GJXyn1TjhXKFD=GNhRzMuRUUx1LjJMxV+3W=y7TQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] RISC-V: Add SBI PMU snapshot definitions
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@atishpatra.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>, 
	Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 3:14=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Wed, Feb 28, 2024 at 05:01:19PM -0800, Atish Patra wrote:
> > SBI PMU Snapshot function optimizes the number of traps to
> > higher privilege mode by leveraging a shared memory between the S/VS-mo=
de
> > and the M/HS mode. Add the definitions for that extension and new error
> > codes.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/sbi.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index ef8311dafb91..dfa830f7d54b 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -132,6 +132,7 @@ enum sbi_ext_pmu_fid {
> >       SBI_EXT_PMU_COUNTER_STOP,
> >       SBI_EXT_PMU_COUNTER_FW_READ,
> >       SBI_EXT_PMU_COUNTER_FW_READ_HI,
> > +     SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> >  };
> >
> >  union sbi_pmu_ctr_info {
> > @@ -148,6 +149,13 @@ union sbi_pmu_ctr_info {
> >       };
> >  };
> >
> > +/* Data structure to contain the pmu snapshot data */
> > +struct riscv_pmu_snapshot_data {
> > +     u64 ctr_overflow_mask;
> > +     u64 ctr_values[64];
> > +     u64 reserved[447];
> > +};
> > +
> >  #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
> >  #define RISCV_PMU_RAW_EVENT_IDX 0x20000
> >
> > @@ -244,9 +252,11 @@ enum sbi_pmu_ctr_type {
> >
> >  /* Flags defined for counter start function */
> >  #define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
>
> A patch before this which changes all flags to use BIT() instead of shift=
s
> would be good, since otherwise the new flags are inconsistent.
>

Done.

>
> > +#define SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT BIT(1)
>
> This is named SBI_PMU_START_FLAG_INIT_SNAPSHOT in the spec.
>

Fixed.

>
> >
> >  /* Flags defined for counter stop function */
> >  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> > +#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
> >
> >  enum sbi_ext_dbcn_fid {
> >       SBI_EXT_DBCN_CONSOLE_WRITE =3D 0,
> > @@ -285,6 +295,7 @@ struct sbi_sta_struct {
> >  #define SBI_ERR_ALREADY_AVAILABLE -6
> >  #define SBI_ERR_ALREADY_STARTED -7
> >  #define SBI_ERR_ALREADY_STOPPED -8
> > +#define SBI_ERR_NO_SHMEM     -9
> >
> >  extern unsigned long sbi_spec_version;
> >  struct sbiret {
> > --
> > 2.34.1
> >
>
> Thanks,
> drew

