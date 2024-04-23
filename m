Return-Path: <linux-kselftest+bounces-8728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A1F8AF80B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 22:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226701C22A3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 20:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1739142E83;
	Tue, 23 Apr 2024 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2CpmQOL4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52713E02C
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904487; cv=none; b=aU4yNNAU5/vwKtroobetvY22Hd7oVZQxJgr85vOpzWfIJd2GBRhgZOw+NoPiy52tcWeriLlwaNoOH4ptGDO760o0swPSdzIlbXvh6Ofgoejn8Kicts0G+IWOo0Ps7ZoEJJgXXh8eiLj3YIzA/FU1e/19r1BaOaDu+LtGYElUWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904487; c=relaxed/simple;
	bh=U0PES+OxT3xT3YJmrsdqrBJVFMoNrVv91zql0X2v7os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4shEIQ/1KmcDBhmy1lqvFfpqhnTcryuu/7HTy8O9gTTgP1AEGlbqX7c0HuFh0GAhunsTTEvgAIR6StSUzjx0CWDSXsK/2RD4fc2oLEq4cY+LvLPqB3eMJcXeghj+ImdtTnKgftb2DEEUa/QN46tG3HTiL0N0rmYtxEs9Y0HYw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2CpmQOL4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d8b194341eso61815551fa.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713904482; x=1714509282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnFW8er6gqAt6msNaW51HjjnzTZID8dvEoS/g8pohKk=;
        b=2CpmQOL4DG7HGSqeTmD7eyfJma1BCn3nLL9h+QtSV2G2Z+8GNBRRV5Zg9GyhlEaGpV
         4s7siJARM+AfmNiJDiei6fGHfNNWUx7A0jyOqljHbEY3HzexWVV6FYvPT0ztb9IS0PNg
         zaCAbGGAFJJPdmNsfT7hm7vTaZj+GXzJL3Opaz7TolEB9nK2bUVc5E3YHQL0EFN/74MI
         7WV+N0olA11jE/I7OpEw1KRp7wzCmMGSZjBkkpsYRF6Hjqx0AsWvahNLM4SMk3ER7eGG
         w7G5MiEiHKFAoLBtCqbXNq2xEVZpLwU1hijfNTIhdLQ8aGO8Q8DO648Sruy8bsM/z+RQ
         7VjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713904482; x=1714509282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnFW8er6gqAt6msNaW51HjjnzTZID8dvEoS/g8pohKk=;
        b=QLTMkdYSqVISOGUFAM9bo490pjiuX8J02ylHVrEQgPZykFKM/ociYnFYZSnU7HS2eC
         5J45hFFa9QQB6QT2zokXjYOuDSVuReeSuRP0NQZX/+XbQS9A+5VT2HYYaf7bl+gPvFF8
         bovplgSFV4DoMvBUYXHmE+XbB8XEv0incF3kyugNUcF51WRAQMjE+Nst23MyVu2Dscx9
         dNereQkNYtVLvpW/OMxY9y3rWkgkgegiHt+TpL5CnHVfG8aCSmdi6BqtnOz6EfSiqU2/
         rl60XKGZ4QHcF5okqxmLx4kkXZ7MFu1Fbxu1zAY94CbSE84ryNzF7xyP8RpE7UerPVRK
         8xVg==
X-Forwarded-Encrypted: i=1; AJvYcCXIMOz0Z6qepiv8Gf3YRkpC+jSQ7nxuPFwvsgqm5CMBcrqtiDvR4iSotN+Uxv1d8VZGHCWwfJgJCx9McO1hGQ+tcMd+6DuMfpzeUxtirkxD
X-Gm-Message-State: AOJu0YynoIM59tyxp4zymLp53lZRWS0JkBLi/PKhaFLHeNgmOfrAUdMq
	tK6oZdOBMEgkxd2sAq23x0CrTv9tnbfQAvpQGXx1JWZEv2T293wjCvh0Jm2M7UA12r70xY90wT1
	nFYM3OaNG0YVSMOhAp1Z+mvznkdVNhSmdSriMgA==
X-Google-Smtp-Source: AGHT+IHJWI2YOvko5wbGTn+hp1Q1BkOs/UucbCBpVxvgTXgybvUYzgp7APOJ3ND70I9fziwajryw8hPQO+VP9BALiDg=
X-Received: by 2002:a2e:9891:0:b0:2d8:9537:6d37 with SMTP id
 b17-20020a2e9891000000b002d895376d37mr214600ljj.21.1713904481982; Tue, 23 Apr
 2024 13:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-10-atishp@rivosinc.com>
 <2f43393d-2488-40c8-abde-4dc82a64a829@sifive.com>
In-Reply-To: <2f43393d-2488-40c8-abde-4dc82a64a829@sifive.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 23 Apr 2024 13:34:31 -0700
Message-ID: <CAHBxVyGjzeZQ+FkPXbAKF822eSCE25iyb8O56PkRbtEkXW00kw@mail.gmail.com>
Subject: Re: [PATCH v8 09/24] drivers/perf: riscv: Implement SBI PMU snapshot function
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, 
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 9:06=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Atish,
>
> On 2024-04-20 10:17 AM, Atish Patra wrote:
> > SBI v2.0 SBI introduced PMU snapshot feature which adds the following
> > features.
> >
> > 1. Read counter values directly from the shared memory instead of
> > csr read.
> > 2. Start multiple counters with initial values with one SBI call.
> >
> > These functionalities optimizes the number of traps to the higher
> > privilege mode. If the kernel is in VS mode while the hypervisor
> > deploy trap & emulate method, this would minimize all the hpmcounter
> > CSR read traps. If the kernel is running in S-mode, the benefits
> > reduced to CSR latency vs DRAM/cache latency as there is no trap
> > involved while accessing the hpmcounter CSRs.
> >
> > In both modes, it does saves the number of ecalls while starting
> > multiple counter together with an initial values. This is a likely
> > scenario if multiple counters overflow at the same time.
> >
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu.c       |   1 +
> >  drivers/perf/riscv_pmu_sbi.c   | 265 ++++++++++++++++++++++++++++++---
> >  include/linux/perf/riscv_pmu.h |   6 +
> >  3 files changed, 255 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > index b4efdddb2ad9..36d348753d05 100644
> > --- a/drivers/perf/riscv_pmu.c
> > +++ b/drivers/perf/riscv_pmu.c
> > @@ -408,6 +408,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
> >               cpuc->n_events =3D 0;
> >               for (i =3D 0; i < RISCV_MAX_COUNTERS; i++)
> >                       cpuc->events[i] =3D NULL;
> > +             cpuc->snapshot_addr =3D NULL;
> >       }
> >       pmu->pmu =3D (struct pmu) {
> >               .event_init     =3D riscv_pmu_event_init,
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 4eacd89141a9..2694110f1cff 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -58,6 +58,9 @@ PMU_FORMAT_ATTR(event, "config:0-47");
> >  PMU_FORMAT_ATTR(firmware, "config:63");
> >
> >  static bool sbi_v2_available;
> > +static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
> > +#define sbi_pmu_snapshot_available() \
> > +     static_branch_unlikely(&sbi_pmu_snapshot_available)
> >
> >  static struct attribute *riscv_arch_formats_attr[] =3D {
> >       &format_attr_event.attr,
> > @@ -508,14 +511,105 @@ static int pmu_sbi_event_map(struct perf_event *=
event, u64 *econfig)
> >       return ret;
> >  }
> >
> > +static void pmu_sbi_snapshot_free(struct riscv_pmu *pmu)
> > +{
> > +     int cpu;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             struct cpu_hw_events *cpu_hw_evt =3D per_cpu_ptr(pmu->hw_=
events, cpu);
> > +
> > +             if (!cpu_hw_evt->snapshot_addr)
> > +                     continue;
> > +
> > +             free_page((unsigned long)cpu_hw_evt->snapshot_addr);
> > +             cpu_hw_evt->snapshot_addr =3D NULL;
> > +             cpu_hw_evt->snapshot_addr_phys =3D 0;
> > +     }
> > +}
> > +
> > +static int pmu_sbi_snapshot_alloc(struct riscv_pmu *pmu)
> > +{
> > +     int cpu;
> > +     struct page *snapshot_page;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             struct cpu_hw_events *cpu_hw_evt =3D per_cpu_ptr(pmu->hw_=
events, cpu);
> > +
> > +             snapshot_page =3D alloc_page(GFP_ATOMIC | __GFP_ZERO);
> > +             if (!snapshot_page) {
> > +                     pmu_sbi_snapshot_free(pmu);
> > +                     return -ENOMEM;
> > +             }
> > +             cpu_hw_evt->snapshot_addr =3D page_to_virt(snapshot_page)=
;
> > +             cpu_hw_evt->snapshot_addr_phys =3D page_to_phys(snapshot_=
page);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int pmu_sbi_snapshot_disable(void)
> > +{
> > +     struct sbiret ret;
> > +
> > +     ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, SB=
I_SHMEM_DISABLE,
> > +                     SBI_SHMEM_DISABLE, 0, 0, 0, 0);
> > +     if (ret.error) {
> > +             pr_warn("failed to disable snapshot shared memory\n");
> > +             return sbi_err_map_linux_errno(ret.error);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int pmu_sbi_snapshot_setup(struct riscv_pmu *pmu, int cpu)
> > +{
> > +     struct cpu_hw_events *cpu_hw_evt;
> > +     struct sbiret ret =3D {0};
> > +
> > +     cpu_hw_evt =3D per_cpu_ptr(pmu->hw_events, cpu);
> > +     if (!cpu_hw_evt->snapshot_addr_phys)
> > +             return -EINVAL;
> > +
> > +     if (cpu_hw_evt->snapshot_set_done)
> > +             return 0;
> > +
> > +     if (IS_ENABLED(CONFIG_32BIT))
> > +             ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_S=
HMEM,
> > +                             cpu_hw_evt->snapshot_addr_phys,
> > +                             (u64)(cpu_hw_evt->snapshot_addr_phys) >> =
32, 0, 0, 0, 0);
> > +     else
> > +             ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_S=
HMEM,
> > +                             cpu_hw_evt->snapshot_addr_phys, 0, 0, 0, =
0, 0);
> > +
> > +     /* Free up the snapshot area memory and fall back to SBI PMU call=
s without snapshot */
> > +     if (ret.error) {
> > +             if (ret.error !=3D SBI_ERR_NOT_SUPPORTED)
> > +                     pr_warn("pmu snapshot setup failed with error %ld=
\n", ret.error);
> > +             return sbi_err_map_linux_errno(ret.error);
> > +     }
> > +
> > +     cpu_hw_evt->snapshot_set_done =3D true;
> > +
> > +     return 0;
> > +}
> > +
> >  static u64 pmu_sbi_ctr_read(struct perf_event *event)
> >  {
> >       struct hw_perf_event *hwc =3D &event->hw;
> >       int idx =3D hwc->idx;
> >       struct sbiret ret;
> >       u64 val =3D 0;
> > +     struct riscv_pmu *pmu =3D to_riscv_pmu(event->pmu);
> > +     struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> > +     struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_ad=
dr;
> >       union sbi_pmu_ctr_info info =3D pmu_ctr_list[idx];
> >
> > +     /* Read the value from the shared memory directly only if counter=
 is stopped */
> > +     if (sbi_pmu_snapshot_available() & (hwc->state & PERF_HES_STOPPED=
)) {
>
> nit: logical && between the two conditions
>

Fixed.

> > +             val =3D sdata->ctr_values[idx];
> > +             return val;
> > +     }
> > +
> >       if (pmu_sbi_is_fw_event(event)) {
> >               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_REA=
D,
> >                               hwc->idx, 0, 0, 0, 0, 0);
> > @@ -565,6 +659,7 @@ static void pmu_sbi_ctr_start(struct perf_event *ev=
ent, u64 ival)
> >       struct hw_perf_event *hwc =3D &event->hw;
> >       unsigned long flag =3D SBI_PMU_START_FLAG_SET_INIT_VALUE;
> >
> > +     /* There is no benefit setting SNAPSHOT FLAG for a single counter=
 */
> >  #if defined(CONFIG_32BIT)
> >       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->id=
x,
> >                       1, flag, ival, ival >> 32, 0);
> > @@ -585,16 +680,36 @@ static void pmu_sbi_ctr_stop(struct perf_event *e=
vent, unsigned long flag)
> >  {
> >       struct sbiret ret;
> >       struct hw_perf_event *hwc =3D &event->hw;
> > +     struct riscv_pmu *pmu =3D to_riscv_pmu(event->pmu);
> > +     struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> > +     struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_ad=
dr;
> >
> >       if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
> >           (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> >               pmu_sbi_reset_scounteren((void *)event);
> >
> > +     if (sbi_pmu_snapshot_available())
> > +             flag |=3D SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
> > +
> >       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx=
, 1, flag, 0, 0, 0);
> > -     if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STOPPED) &&
> > -             flag !=3D SBI_PMU_STOP_FLAG_RESET)
> > +     if (!ret.error && sbi_pmu_snapshot_available()) {
> > +             /*
> > +              * The counter snapshot is based on the index base specif=
ied by hwc->idx.
> > +              * The actual counter value is updated in shared memory a=
t index 0 when counter
> > +              * mask is 0x01. To ensure accurate counter values, it's =
necessary to transfer
> > +              * the counter value to shared memory. However, if hwc->i=
dx is zero, the counter
> > +              * value is already correctly updated in shared memory, r=
equiring no further
> > +              * adjustment.
> > +              */
> > +             if (hwc->idx > 0) {
> > +                     sdata->ctr_values[hwc->idx] =3D sdata->ctr_values=
[0];
> > +                     sdata->ctr_values[0] =3D 0;
> > +             }
> > +     } else if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STOPPED) =
&&
> > +             flag !=3D SBI_PMU_STOP_FLAG_RESET) {
> >               pr_err("Stopping counter idx %d failed with error %d\n",
> >                       hwc->idx, sbi_err_map_linux_errno(ret.error));
> > +     }
> >  }
> >
> >  static int pmu_sbi_find_num_ctrs(void)
> > @@ -652,12 +767,39 @@ static inline void pmu_sbi_stop_all(struct riscv_=
pmu *pmu)
> >  static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
> >  {
> >       struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> > +     struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_ad=
dr;
> > +     unsigned long flag =3D 0;
> >       int i;
> > +     struct sbiret ret;
> > +     unsigned long temp_ctr_values[64] =3D {0};
> > +     unsigned long ctr_val, temp_ctr_overflow_mask =3D 0;
> >
> > -     for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
> > +     if (sbi_pmu_snapshot_available())
> > +             flag =3D SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
> > +
> > +     for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> >               /* No need to check the error here as we can't do anythin=
g about the error */
> > -             sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS=
_PER_LONG,
> > -                       cpu_hw_evt->used_hw_ctrs[i], 0, 0, 0, 0);
> > +             ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, =
i * BITS_PER_LONG,
> > +                             cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, =
0);
> > +             if (!ret.error && sbi_pmu_snapshot_available()) {
> > +                     /* Save the counter values to avoid clobbering */
> > +                     temp_ctr_values[i * BITS_PER_LONG + i] =3D sdata-=
>ctr_values[i];
> > +                     /* Save the overflow mask to avoid clobbering */
> > +                     if (BIT(i) & sdata->ctr_overflow_mask)
> > +                             temp_ctr_overflow_mask |=3D BIT(i + i * B=
ITS_PER_LONG);
>
> `i` is iterating over longs here, not individual counters. Using `i` twic=
e in
> the same expression like this makes no sense.
>
> And again, since you made temp_ctr_overflow_mask an `unsigned long`, this=
 BIT
> expression overflows during the second iteration of the loop on riscv32.
>

Arrgh. I don't know what I was thinking. That was the result of me
sending the patch in haste.

> > +             }
> > +     }
> > +
> > +     /* Restore the counter values to the shared memory */
> > +     if (sbi_pmu_snapshot_available()) {
> > +             for (i =3D 0; i < 64; i++) {
> > +                     ctr_val =3D temp_ctr_values[i];
> > +                     if (ctr_val)
> > +                             sdata->ctr_values[i] =3D ctr_val;
>
> It is entirely possible for the correct value of a counter to be zero whe=
n some
> other counter overflows. But here if a counter with value zero is clobber=
ed by a
> nonzero value, the correct value will not be restored.
>

Very unlikely but possible. Anyways, it doesn't save much by only
restoring the values
with non-zero. So I will remove it.

> > +                     if (temp_ctr_overflow_mask)
> > +                             sdata->ctr_overflow_mask =3D temp_ctr_ove=
rflow_mask;
>
> This doesn't need to be inside the loop. And if temp_ctr_overflow_mask is=
 the
Sure. I will move it outside.

> 64-bit combination of the two 32-bit values from the SBI calls (which see=
ms to
> be the intention), then we already know there is at least one set bit, si=
nce
> this is called from the overflow IRQ handler.

The check is there as a sanity check incase there is a spurious interrupt.

>
> > +             }
> > +     }
> >  }
> >
> >  /*
> > @@ -666,11 +808,10 @@ static inline void pmu_sbi_stop_hw_ctrs(struct ri=
scv_pmu *pmu)
> >   * while the overflowed counters need to be started with updated initi=
alization
> >   * value.
> >   */
> > -static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> > -                                            unsigned long ctr_ovf_mask=
)
> > +static inline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cp=
u_hw_evt,
> > +                                           u64 ctr_ovf_mask)
> >  {
> >       int idx =3D 0, i;
> > -     struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> >       struct perf_event *event;
> >       unsigned long flag =3D SBI_PMU_START_FLAG_SET_INIT_VALUE;
> >       unsigned long ctr_start_mask =3D 0;
> > @@ -706,6 +847,48 @@ static inline void pmu_sbi_start_overflow_mask(str=
uct riscv_pmu *pmu,
> >       }
> >  }
> >
> > +static inline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_event=
s *cpu_hw_evt,
> > +                                                u64 ctr_ovf_mask)
> > +{
> > +     int idx =3D 0;
> > +     struct perf_event *event;
> > +     unsigned long flag =3D SBI_PMU_START_FLAG_INIT_SNAPSHOT;
> > +     u64 max_period, init_val =3D 0;
> > +     struct hw_perf_event *hwc;
> > +     struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_ad=
dr;
> > +
> > +     for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTER=
S) {
> > +             if (ctr_ovf_mask & BIT(idx)) {
> > +                     event =3D cpu_hw_evt->events[idx];
> > +                     hwc =3D &event->hw;
> > +                     max_period =3D riscv_pmu_ctr_get_width_mask(event=
);
> > +                     init_val =3D local64_read(&hwc->prev_count) & max=
_period;
> > +                     sdata->ctr_values[idx] =3D init_val;
> > +             }
> > +             /*
> > +              * We do not need to update the non-overflow counters the=
 previous
> > +              * value should have been there already.
> > +              */
> > +     }
> > +
> > +     for (idx =3D 0; idx < BITS_TO_LONGS(RISCV_MAX_COUNTERS); idx++) {
> > +             /* Start all the counters in a single shot */
> > +             sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * B=
ITS_PER_LONG,
> > +                       cpu_hw_evt->used_hw_ctrs[idx], flag, 0, 0, 0);
>
> This doesn't work either... for riscv32 you have to copy the initial valu=
es for
> counters 32-63 to ctr_values indexes 0-31, since that is where the SBI
> implementation expects to find them. And since this clobbers counters 0-3=
1,
> those need to be preserved somewhere. That's why I recommended a shadow c=
opy of
> ctr_values -- globally, not local to pmu_sbi_stop_hw_ctrs().
>

Yeah. Again, it's the result of haste to send the patch on Friday
evening before the trip. My bad!

> Also, you need SBI_PMU_START_FLAG_INIT_SNAPSHOT here to actually load the=
 values
> from shared memory, so this is broken on riscv64 as well.

The "flag" declared above is initialized with SBI_PMU_START_FLAG_INIT_SNAPS=
HOT.

>
> > +     }
> > +}
> > +
> > +static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> > +                                     u64 ctr_ovf_mask)
> > +{
> > +     struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> > +
> > +     if (sbi_pmu_snapshot_available())
> > +             pmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask)=
;
> > +     else
> > +             pmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
> > +}
> > +
> >  static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
> >  {
> >       struct perf_sample_data data;
> > @@ -716,9 +899,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, vo=
id *dev)
> >       struct riscv_pmu *pmu;
> >       struct perf_event *event;
> >       unsigned long overflow;
> > -     unsigned long overflowed_ctrs =3D 0;
> > +     u64 overflowed_ctrs =3D 0;
> >       struct cpu_hw_events *cpu_hw_evt =3D dev;
> >       u64 start_clock =3D sched_clock();
> > +     struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_ad=
dr;
> >
> >       if (WARN_ON_ONCE(!cpu_hw_evt))
> >               return IRQ_NONE;
> > @@ -740,7 +924,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, vo=
id *dev)
> >       pmu_sbi_stop_hw_ctrs(pmu);
> >
> >       /* Overflow status register should only be read after counter are=
 stopped */
> > -     ALT_SBI_PMU_OVERFLOW(overflow);
> > +     if (sbi_pmu_snapshot_available())
> > +             overflow =3D sdata->ctr_overflow_mask;
>
> Overflow is `unsigned long`, so this assignment truncates ctr_overflow_ma=
sk on
> riscv32.
>

Will fix it.

> Was this series tested on riscv32?
>

This particular code path is very unlikely in normal testing scenarios
as it requires more than 32 counters for rv32 configuration which is
not the common case. Moreover, the physical counter indices are less
than 32 to match the hardware CSR number. You can only configure more
than 32 counters with firmware counters but kvm currently doesn't
support overflow.

Thus, we need to construct an artificial case to create logical
counters with indexes more than 32 for hardware counters with CSR
remapping or support firmware counter overflow.

Let me know if you have any better ideas for quicker testing.

Regarding the whole series, I had tested some earlier versions but
perf tool seems to be broken for riscv32 now. I will fix it and give
it a spin. If you have a working setup of rv32 perf testing, let me
know as well.

Regards,
Atish

> Regards,
> Samuel
>
> > +     else
> > +             ALT_SBI_PMU_OVERFLOW(overflow);
> >
> >       /*
> >        * Overflow interrupt pending bit should only be cleared after st=
opping
> > @@ -766,9 +953,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, vo=
id *dev)
> >               if (!info || info->type !=3D SBI_PMU_CTR_TYPE_HW)
> >                       continue;
> >
> > -             /* compute hardware counter index */
> > -             hidx =3D info->csr - CSR_CYCLE;
> > -             /* check if the corresponding bit is set in sscountovf */
> > +             if (sbi_pmu_snapshot_available())
> > +                     /* SBI implementation already updated the logical=
 indicies */
> > +                     hidx =3D lidx;
> > +             else
> > +                     /* compute hardware counter index */
> > +                     hidx =3D info->csr - CSR_CYCLE;
> > +
> > +             /* check if the corresponding bit is set in sscountovf or=
 overflow mask in shmem */
> >               if (!(overflow & BIT(hidx)))
> >                       continue;
> >
> > @@ -778,7 +970,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, vo=
id *dev)
> >                */
> >               overflowed_ctrs |=3D BIT(lidx);
> >               hw_evt =3D &event->hw;
> > +             /* Update the event states here so that we know the state=
 while reading */
> > +             hw_evt->state |=3D PERF_HES_STOPPED;
> >               riscv_pmu_event_update(event);
> > +             hw_evt->state |=3D PERF_HES_UPTODATE;
> >               perf_sample_data_init(&data, 0, hw_evt->last_period);
> >               if (riscv_pmu_event_set_period(event)) {
> >                       /*
> > @@ -791,6 +986,8 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, voi=
d *dev)
> >                        */
> >                       perf_event_overflow(event, &data, regs);
> >               }
> > +             /* Reset the state as we are going to start the counter a=
fter the loop */
> > +             hw_evt->state =3D 0;
> >       }
> >
> >       pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
> > @@ -822,6 +1019,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, =
struct hlist_node *node)
> >               enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
> >       }
> >
> > +     if (sbi_pmu_snapshot_available())
> > +             return pmu_sbi_snapshot_setup(pmu, cpu);
> > +
> >       return 0;
> >  }
> >
> > @@ -834,6 +1034,9 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, str=
uct hlist_node *node)
> >       /* Disable all counters access for user mode now */
> >       csr_write(CSR_SCOUNTEREN, 0x0);
> >
> > +     if (sbi_pmu_snapshot_available())
> > +             return pmu_sbi_snapshot_disable();
> > +
> >       return 0;
> >  }
> >
> > @@ -942,6 +1145,12 @@ static inline void riscv_pm_pmu_unregister(struct=
 riscv_pmu *pmu) { }
> >
> >  static void riscv_pmu_destroy(struct riscv_pmu *pmu)
> >  {
> > +     if (sbi_v2_available) {
> > +             if (sbi_pmu_snapshot_available()) {
> > +                     pmu_sbi_snapshot_disable();
> > +                     pmu_sbi_snapshot_free(pmu);
> > +             }
> > +     }
> >       riscv_pm_pmu_unregister(pmu);
> >       cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->n=
ode);
> >  }
> > @@ -1109,10 +1318,6 @@ static int pmu_sbi_device_probe(struct platform_=
device *pdev)
> >       pmu->event_unmapped =3D pmu_sbi_event_unmapped;
> >       pmu->csr_index =3D pmu_sbi_csr_index;
> >
> > -     ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &p=
mu->node);
> > -     if (ret)
> > -             return ret;
> > -
> >       ret =3D riscv_pm_pmu_register(pmu);
> >       if (ret)
> >               goto out_unregister;
> > @@ -1121,8 +1326,34 @@ static int pmu_sbi_device_probe(struct platform_=
device *pdev)
> >       if (ret)
> >               goto out_unregister;
> >
> > +     /* SBI PMU Snapsphot is only available in SBI v2.0 */
> > +     if (sbi_v2_available) {
> > +             ret =3D pmu_sbi_snapshot_alloc(pmu);
> > +             if (ret)
> > +                     goto out_unregister;
> > +
> > +             ret =3D pmu_sbi_snapshot_setup(pmu, smp_processor_id());
> > +             if (ret) {
> > +                     /* Snapshot is an optional feature. Continue if n=
ot available */
> > +                     pmu_sbi_snapshot_free(pmu);
> > +             } else {
> > +                     pr_info("SBI PMU snapshot detected\n");
> > +                     /*
> > +                      * We enable it once here for the boot cpu. If sn=
apshot shmem setup
> > +                      * fails during cpu hotplug process, it will fail=
 to start the cpu
> > +                      * as we can not handle hetergenous PMUs with dif=
ferent snapshot
> > +                      * capability.
> > +                      */
> > +                     static_branch_enable(&sbi_pmu_snapshot_available)=
;
> > +             }
> > +     }
> > +
> >       register_sysctl("kernel", sbi_pmu_sysctl_table);
> >
> > +     ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &p=
mu->node);
> > +     if (ret)
> > +             goto out_unregister;
> > +
> >       return 0;
> >
> >  out_unregister:
> > diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_=
pmu.h
> > index 43282e22ebe1..c3fa90970042 100644
> > --- a/include/linux/perf/riscv_pmu.h
> > +++ b/include/linux/perf/riscv_pmu.h
> > @@ -39,6 +39,12 @@ struct cpu_hw_events {
> >       DECLARE_BITMAP(used_hw_ctrs, RISCV_MAX_COUNTERS);
> >       /* currently enabled firmware counters */
> >       DECLARE_BITMAP(used_fw_ctrs, RISCV_MAX_COUNTERS);
> > +     /* The virtual address of the shared memory where counter snapsho=
t will be taken */
> > +     void *snapshot_addr;
> > +     /* The physical address of the shared memory where counter snapsh=
ot will be taken */
> > +     phys_addr_t snapshot_addr_phys;
> > +     /* Boolean flag to indicate setup is already done */
> > +     bool snapshot_set_done;
> >  };
> >
> >  struct riscv_pmu {
>

