Return-Path: <linux-kselftest+bounces-5738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 943A586E4D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 16:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D731F21892
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE94C70CCC;
	Fri,  1 Mar 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="C5VnyCBo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B749338F9A
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308574; cv=none; b=nRsDWQ0pKz0ZS38hYGC5312YZvS55Z0hAKv3dLf4UyzzZKiNjGtf8PBWfR4Zel45WSpHFodzhSxLn6w91Xv79FNGMNaiJU5GkUSM4fYc+g5sqnOhqqR++7Pn92e2yNoDvEOZVcguqngEnBKisMHLq52kQ4xxZ8E8B44i6UvcHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308574; c=relaxed/simple;
	bh=3qmOebB3UHopSVDwuN6WNjhveeylUuACrOYXhlVUhpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHYlCr9b318CP/1CUTjK6mXFUqlZgJFNvyY1gO9NNNQ4hohuzo+tvMApAAr7Sh3KkiAPNtG/P6nHV49I7wrAOsLWhxLSMl1krZTC2hPtsGh9GXjg0qvHSOEXGjD+sMkNvBTwwv01YonUlzak42HeL2ORsMOqEMXA4YTJnaMgVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=C5VnyCBo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so3347838a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 07:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709308569; x=1709913369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naPNwvyBXjmXLhThffS3V0uHgnB049DxieoFeMxs860=;
        b=C5VnyCBoWURogPqMyOYXcUWX0G+VjQfDtpsQ9q9rp+6pXCiN2WR56zrPXvU2YlTkAV
         0ylqVExDmEocHK6R9Lcge5J3julHFjIv9KLrzQNg+ugn7PnMO+/PPw1qXLDolzfjq0Wo
         QNiF1Nb6E8iSkclPaklnSNOUyfsb/YZe8FfqwsT1NMFxXcsPFn5wthA7JyKM38M/Au3R
         0RAARawie2qA7725MVZFDYIfkt0DYDw75+wFj610/ciw0eUVLNTzm8aVay+Jmn+cSudk
         EnglKlMO/BkNEoskiBH9Iwtd1rZPfw42M4U220vMliorpEs494m061KLuxpQ1bJnRflK
         t5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709308569; x=1709913369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naPNwvyBXjmXLhThffS3V0uHgnB049DxieoFeMxs860=;
        b=UtHRMf989tSVIwISP9Q7Swaget+yierqnU/BWDp27fvq3W5zGfqD/umMfwL8jaZZ2x
         e9DARf7EoEdYbVhspo6liJgF4JXx6PmdnDGV/I2GREsNRswnMAXjJB9OFOY6MGK/P6h0
         KaS72pcvd7R75bkmWxQjTN1VIRJQt8t/es8/9BmQJ3F6ve52KVfiE3on5GRTA8GpGfqe
         54hOXJEUIRG6caRJnlNU+Yvf0KN1s4nPEpRcZAr6qjNms2ynzqpvjvOZep8LUwkKFhTm
         LKW0bYtlkojhP84z9CztHLT8cp2B6JmTmI0DfRxMI7OEEzBJmgOS3H6Km5AKuSmkHevp
         xZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCV9O4JJTZd1RU+jhHXQrHNXgdOZvC6eoif061BrMFXp0zzw1WvCN95J7tgEIjOWT90MAe4K/N9sPrLT2T7jFoScrk1hrozgG6KToYPgwd18
X-Gm-Message-State: AOJu0YyAcVRIqDHnUgfL043KJsI47XCjjIy7pGV1JSBZ02RwheerIDVZ
	QFks8FSMNYA7xw4Ogxu57eI4HSEK7Bi/Rhi8d3DxmrSsFNY591J9CjYBBTQBt365RwyIi+JEjWG
	dC4HL6TmZWXDBiIHFiRgX6fDw/uBl2zH4geforA==
X-Google-Smtp-Source: AGHT+IFxluVBPX70asFGPSiKlPN75/avRvw5oRPfoPG6YmTRf20tFpfgDn5RBc5qeI6UzGSui4/3kxI7YE7mKyZ2yp0=
X-Received: by 2002:a17:906:4c52:b0:a43:b50d:1075 with SMTP id
 d18-20020a1709064c5200b00a43b50d1075mr1551574ejw.25.1709308568993; Fri, 01
 Mar 2024 07:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-6-atishp@rivosinc.com>
 <20240301-9587f1bcaa6b25b1dcc7062e@orel>
In-Reply-To: <20240301-9587f1bcaa6b25b1dcc7062e@orel>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 1 Mar 2024 16:55:58 +0100
Message-ID: <CAHVXubimv-7CpT_8WSb=fQBmMSFm1=eq7XeQ1XFuSRqeuz=h+A@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] drivers/perf: riscv: Implement SBI PMU snapshot function
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, 
	Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 3:40=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Wed, Feb 28, 2024 at 05:01:20PM -0800, Atish Patra wrote:
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
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu.c       |   1 +
> >  drivers/perf/riscv_pmu_sbi.c   | 209 +++++++++++++++++++++++++++++++--
> >  include/linux/perf/riscv_pmu.h |   6 +
> >  3 files changed, 204 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > index 0dda70e1ef90..5b57acb770d3 100644
> > --- a/drivers/perf/riscv_pmu.c
> > +++ b/drivers/perf/riscv_pmu.c
> > @@ -412,6 +412,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
> >               cpuc->n_events =3D 0;
> >               for (i =3D 0; i < RISCV_MAX_COUNTERS; i++)
> >                       cpuc->events[i] =3D NULL;
> > +             cpuc->snapshot_addr =3D NULL;
> >       }
> >       pmu->pmu =3D (struct pmu) {
> >               .event_init     =3D riscv_pmu_event_init,
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index ea0fdb589f0d..8de5721e8019 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -36,6 +36,9 @@ PMU_FORMAT_ATTR(event, "config:0-47");
> >  PMU_FORMAT_ATTR(firmware, "config:63");
> >
> >  static bool sbi_v2_available;
> > +static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
> > +#define sbi_pmu_snapshot_available() \
> > +     static_branch_unlikely(&sbi_pmu_snapshot_available)
> >
> >  static struct attribute *riscv_arch_formats_attr[] =3D {
> >       &format_attr_event.attr,
> > @@ -485,14 +488,100 @@ static int pmu_sbi_event_map(struct perf_event *=
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
> > +             if (cpu_hw_evt->snapshot_addr)
> > +                     continue;
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
> > +static void pmu_sbi_snapshot_disable(void)
> > +{
> > +     sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, -1,
> > +               -1, 0, 0, 0, 0);
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
> > +     /* Read the value from the shared memory directly */
> > +     if (sbi_pmu_snapshot_available()) {
> > +             val =3D sdata->ctr_values[idx];
> > +             return val;
> > +     }
> > +
> >       if (pmu_sbi_is_fw_event(event)) {
> >               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_REA=
D,
> >                               hwc->idx, 0, 0, 0, 0, 0);
> > @@ -539,6 +628,7 @@ static void pmu_sbi_ctr_start(struct perf_event *ev=
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
> > @@ -559,16 +649,36 @@ static void pmu_sbi_ctr_stop(struct perf_event *e=
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
> > @@ -626,10 +736,14 @@ static inline void pmu_sbi_stop_all(struct riscv_=
pmu *pmu)
> >  static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
> >  {
> >       struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> > +     unsigned long flag =3D 0;
> > +
> > +     if (sbi_pmu_snapshot_available())
> > +             flag =3D SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
> >
> >       /* No need to check the error here as we can't do anything about =
the error */
> >       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
> > -               cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
> > +               cpu_hw_evt->used_hw_ctrs[0], flag, 0, 0, 0);
> >  }
> >
> >  /*
> > @@ -638,11 +752,10 @@ static inline void pmu_sbi_stop_hw_ctrs(struct ri=
scv_pmu *pmu)
> >   * while the overflowed counters need to be started with updated initi=
alization
> >   * value.
> >   */
> > -static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> > -                                            unsigned long ctr_ovf_mask=
)
> > +static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *=
cpu_hw_evt,
> > +                                             unsigned long ctr_ovf_mas=
k)
> >  {
> >       int idx =3D 0;
> > -     struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> >       struct perf_event *event;
> >       unsigned long flag =3D SBI_PMU_START_FLAG_SET_INIT_VALUE;
> >       unsigned long ctr_start_mask =3D 0;
> > @@ -677,6 +790,49 @@ static inline void pmu_sbi_start_overflow_mask(str=
uct riscv_pmu *pmu,
> >       }
> >  }
> >
> > +static noinline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw_eve=
nts *cpu_hw_evt,
> > +                                                  unsigned long ctr_ov=
f_mask)
> > +{
> > +     int idx =3D 0;
> > +     struct perf_event *event;
> > +     unsigned long flag =3D SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT;
> > +     u64 max_period, init_val =3D 0;
> > +     struct hw_perf_event *hwc;
> > +     unsigned long ctr_start_mask =3D 0;
> > +     struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_ad=
dr;
> > +
> > +     for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTER=
S) {
> > +             if (ctr_ovf_mask & (1 << idx)) {
>
> nit: BIT(idx)

Maybe more than a nit? It looks like the recent bug that Fei fixed
here https://lore.kernel.org/linux-riscv/20240228115425.2613856-1-fei2.wu@i=
ntel.com/

>
> > +                     event =3D cpu_hw_evt->events[idx];
> > +                     hwc =3D &event->hw;
> > +                     max_period =3D riscv_pmu_ctr_get_width_mask(event=
);
> > +                     init_val =3D local64_read(&hwc->prev_count) & max=
_period;
> > +                     sdata->ctr_values[idx] =3D init_val;
> > +             }
> > +             /*
> > +              * We donot need to update the non-overflow counters the =
previous
>
> do not
>
> > +              * value should have been there already.
> > +              */
> > +     }
> > +
> > +     ctr_start_mask =3D cpu_hw_evt->used_hw_ctrs[0];
> > +
> > +     /* Start all the counters in a single shot */
> > +     sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_ma=
sk,
> > +               flag, 0, 0, 0);
>
> I think we should always loop over all words of used_hw_ctrs[] since it'l=
l
> have more than one for riscv32. Hmm, it seems like there are several
> places where we don't expect riscv32's second word to be used...
>
> > +}
> > +
> > +static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> > +                                     unsigned long ctr_ovf_mask)
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
> > @@ -690,6 +846,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, voi=
d *dev)
> >       unsigned long overflowed_ctrs =3D 0;
> >       struct cpu_hw_events *cpu_hw_evt =3D dev;
> >       u64 start_clock =3D sched_clock();
> > +     struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_ad=
dr;
> >
> >       if (WARN_ON_ONCE(!cpu_hw_evt))
> >               return IRQ_NONE;
> > @@ -711,8 +868,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, vo=
id *dev)
> >       pmu_sbi_stop_hw_ctrs(pmu);
> >
> >       /* Overflow status register should only be read after counter are=
 stopped */
> > -     ALT_SBI_PMU_OVERFLOW(overflow);
> > -
> > +     if (sbi_pmu_snapshot_available())
> > +             overflow =3D sdata->ctr_overflow_mask;
> > +     else
> > +             ALT_SBI_PMU_OVERFLOW(overflow);
> >       /*
> >        * Overflow interrupt pending bit should only be cleared after st=
opping
> >        * all the counters to avoid any race condition.
> > @@ -794,6 +953,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, s=
truct hlist_node *node)
> >               enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
> >       }
> >
> > +     if (sbi_pmu_snapshot_available())
> > +             return pmu_sbi_snapshot_setup(pmu, cpu);
> > +
> >       return 0;
> >  }
> >
> > @@ -807,6 +969,9 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, stru=
ct hlist_node *node)
> >       /* Disable all counters access for user mode now */
> >       csr_write(CSR_SCOUNTEREN, 0x0);
> >
> > +     if (sbi_pmu_snapshot_available())
> > +             pmu_sbi_snapshot_disable();
> > +
> >       return 0;
> >  }
> >
> > @@ -1076,10 +1241,6 @@ static int pmu_sbi_device_probe(struct platform_=
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
> > @@ -1088,8 +1249,32 @@ static int pmu_sbi_device_probe(struct platform_=
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
> > +             if (!ret) {
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
> > +             /* Snapshot is an optional feature. Continue if not avail=
able */
> > +     }
> > +
> >       register_sysctl("kernel", sbi_pmu_sysctl_table);
> >
> > +     ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &p=
mu->node);
> > +     if (ret)
> > +             return ret;
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
>
> Instead of the 'snapshot_set_done' boolean, we can just use
> snapshot_addr, which can't be NULL after setup.
>
> >  };
> >
> >  struct riscv_pmu {
> > --
> > 2.34.1
> >
>
> Thanks,
> drew

