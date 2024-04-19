Return-Path: <linux-kselftest+bounces-8483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F17A8AB785
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DA51C20D58
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA98B13D8A2;
	Fri, 19 Apr 2024 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S/Hg4+r3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5413D88F
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570191; cv=none; b=aZDjNQl+kv1xolCz+znFBmOPRhI/NUOoNjiWpUdwa3cW9oKxGpW0gA18Gx6lXY3g23P4M5Ni/L0PlUIkKZIRndvZ9crOKhWNBaFlwxR1hfjPiL10BCAYLptfpxN3b/HiI7k/9k2VQIsbFmf8PgrtJ+fCFGjAx2MXnVPrufzzeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570191; c=relaxed/simple;
	bh=2KxG9fTLvR91sfKG6fLlR8/xCQ3v4bRsBvzm+yKz1p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpxP27hw1wRM2I1Y9okl0A7HvfU/MqebiWiaDjgYBl4KsvVmu0v7N6dh+fp6bx7E/apXIZRhNcNMBKhn2hRyDeRv+/zPRo1BvCyKV6Nbhn0KiYFnbDBdnaNHAUa+NFTffuY1DaUQHUbSx2ulbblR/aJNBl0xkvxNif5kbMaqswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S/Hg4+r3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso2428884e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570186; x=1714174986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD2pxgNKSCPML82rzRuAPE5s0Px/joHZCSPdZ0L5kUs=;
        b=S/Hg4+r3OxPGHZokNwI49m/ernNSPcIzeogp1HWv0NyIQ3VkW89b9E1+b3TQMaxqDu
         w1JfM3wdgcM438PdcY8ft32QxQGFqDG1JBP205IQEU/vMnf/nV9bsPvoEd9KYjI/efnZ
         Nl8Ke0n1DjGWgM508neAgmjcjAgBfpX7yWlUwU8uUz2eB2mOKThQO+TMi4mOt8MoKbPh
         T8pJAQtyIWtDlZ31VWnORsdOamS4vgZabqx8zie9LwqJerKgDFh//tHrPTzjmdzO20gJ
         NZR0yGHBDuhlTqfhd9B5NnGqw3WZ9EVjrY9Wv4XpR2hEc4vIdYktMorJfFAGMkgpHG3v
         ACnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570186; x=1714174986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tD2pxgNKSCPML82rzRuAPE5s0Px/joHZCSPdZ0L5kUs=;
        b=E1sdPokTF5XJrfr3RW3MWbv9hwCrglwpncnbKuo90kTj+J6xLhjqmRvOnMsjAOioLF
         auaP0hkIEiQ+U1YkYZToz1gruJeN8gYlc7/x+WEV7zB1Fm9yH6MsTK41Q6knDDasomWb
         jZNBPHbXZL8ap5ms4KGyhtrwPRlLydQ185Iv9YzRVG9byUqEODOXZ85TwrT1oUjVZdVu
         KheUCXG/DYp3+1t7eu9c07fyR6AJhSxu29l1smjZ9Zh1Xasm1SS+uOllSMuVk+nC10lY
         jhThzfjHI5dJYk+/muEvL58pXnkcFvWbRZX/eya4N9Ujg2xBoHE+S/gS+aGr+QcLb074
         NiVg==
X-Forwarded-Encrypted: i=1; AJvYcCWRXMm3g9P7VK1k2K4AmTbwTlVfZ3deA1G4gT/nfdd4nsUk8F4Rpnl+JTzdgYx2ZqCccS8N+qVzF8oVB0tn1anqb4UA6V7pUnx70teqB2k8
X-Gm-Message-State: AOJu0Yz8lnA3CUzc8F5oQYQCYVBsnwKh1CWO58z/w8y9fS9pUlm2PMIS
	tHLLRJ4l8a4upoiTs58yXtzFdkEWT4wOJxvEGRwVNGO8EqGsXV7JoCHf9LDqVwnEy3A52rf2tgl
	/8MF2fy7dK1hjRNi7uVQMwSBFdicdblusFY4yfA==
X-Google-Smtp-Source: AGHT+IFKab7i+AI/mbZbX3uCJm2P6qJH7L+iijwZhlzSJNN5GcbgWJ2MzLLaMRp3t6SjGuc9lOV04KE4GHMtG24HtxM=
X-Received: by 2002:ac2:5f87:0:b0:516:c97d:96b4 with SMTP id
 r7-20020ac25f87000000b00516c97d96b4mr1855186lfe.2.1713570185381; Fri, 19 Apr
 2024 16:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416184421.3693802-1-atishp@rivosinc.com> <20240416184421.3693802-9-atishp@rivosinc.com>
 <d4923b62-3cda-4bdd-900e-265059593cf2@sifive.com> <c3dab594-473e-4644-9543-66c172ae61bb@rivosinc.com>
 <1e13e981-14f2-4993-afba-dd3baadffe29@sifive.com>
In-Reply-To: <1e13e981-14f2-4993-afba-dd3baadffe29@sifive.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 19 Apr 2024 16:42:54 -0700
Message-ID: <CAHBxVyFBtJFLfQqy6_M99ypQRJDRE+QNYLHe0+HcZfqM-QyDcg@mail.gmail.com>
Subject: Re: [PATCH v7 08/24] drivers/perf: riscv: Implement SBI PMU snapshot function
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
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

On Thu, Apr 18, 2024 at 1:01=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Atish,
>
> On 2024-04-18 2:47 AM, Atish Patra wrote:
> >
> > On 4/16/24 21:02, Samuel Holland wrote:
> >> Hi Atish,
> >>
> >> On 2024-04-16 1:44 PM, Atish Patra wrote:
> >>> SBI v2.0 SBI introduced PMU snapshot feature which adds the following
> >>> features.
> >>>
> >>> 1. Read counter values directly from the shared memory instead of
> >>> csr read.
> >>> 2. Start multiple counters with initial values with one SBI call.
> >>>
> >>> These functionalities optimizes the number of traps to the higher
> >>> privilege mode. If the kernel is in VS mode while the hypervisor
> >>> deploy trap & emulate method, this would minimize all the hpmcounter
> >>> CSR read traps. If the kernel is running in S-mode, the benefits
> >>> reduced to CSR latency vs DRAM/cache latency as there is no trap
> >>> involved while accessing the hpmcounter CSRs.
> >>>
> >>> In both modes, it does saves the number of ecalls while starting
> >>> multiple counter together with an initial values. This is a likely
> >>> scenario if multiple counters overflow at the same time.
> >>>
> >>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> >>> Reviewed-by: Anup Patel <anup@brainfault.org>
> >>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> >>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >>> ---
> >>>   drivers/perf/riscv_pmu.c       |   1 +
> >>>   drivers/perf/riscv_pmu_sbi.c   | 224 ++++++++++++++++++++++++++++++=
+--
> >>>   include/linux/perf/riscv_pmu.h |   6 +
> >>>   3 files changed, 219 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> >>> index b4efdddb2ad9..36d348753d05 100644
> >>> --- a/drivers/perf/riscv_pmu.c
> >>> +++ b/drivers/perf/riscv_pmu.c
> >>> @@ -408,6 +408,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
> >>>           cpuc->n_events =3D 0;
> >>>           for (i =3D 0; i < RISCV_MAX_COUNTERS; i++)
> >>>               cpuc->events[i] =3D NULL;
> >>> +        cpuc->snapshot_addr =3D NULL;
> >>>       }
> >>>       pmu->pmu =3D (struct pmu) {
> >>>           .event_init    =3D riscv_pmu_event_init,
> >>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sb=
i.c
> >>> index f23501898657..dabf8a17b096 100644
> >>> --- a/drivers/perf/riscv_pmu_sbi.c
> >>> +++ b/drivers/perf/riscv_pmu_sbi.c
> >>> @@ -58,6 +58,9 @@ PMU_FORMAT_ATTR(event, "config:0-47");
> >>>   PMU_FORMAT_ATTR(firmware, "config:63");
> >>>     static bool sbi_v2_available;
> >>> +static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
> >>> +#define sbi_pmu_snapshot_available() \
> >>> +    static_branch_unlikely(&sbi_pmu_snapshot_available)
> >>>     static struct attribute *riscv_arch_formats_attr[] =3D {
> >>>       &format_attr_event.attr,
> >>> @@ -508,14 +511,109 @@ static int pmu_sbi_event_map(struct perf_event=
 *event,
> >>> u64 *econfig)
> >>>       return ret;
> >>>   }
> >>>   +static void pmu_sbi_snapshot_free(struct riscv_pmu *pmu)
> >>> +{
> >>> +    int cpu;
> >>> +
> >>> +    for_each_possible_cpu(cpu) {
> >>> +        struct cpu_hw_events *cpu_hw_evt =3D per_cpu_ptr(pmu->hw_eve=
nts, cpu);
> >>> +
> >>> +        if (!cpu_hw_evt->snapshot_addr)
> >>> +            continue;
> >>> +
> >>> +        free_page((unsigned long)cpu_hw_evt->snapshot_addr);
> >>> +        cpu_hw_evt->snapshot_addr =3D NULL;
> >>> +        cpu_hw_evt->snapshot_addr_phys =3D 0;
> >>> +    }
> >>> +}
> >>> +
> >>> +static int pmu_sbi_snapshot_alloc(struct riscv_pmu *pmu)
> >>> +{
> >>> +    int cpu;
> >>> +    struct page *snapshot_page;
> >>> +
> >>> +    for_each_possible_cpu(cpu) {
> >>> +        struct cpu_hw_events *cpu_hw_evt =3D per_cpu_ptr(pmu->hw_eve=
nts, cpu);
> >>> +
> >>> +        if (cpu_hw_evt->snapshot_addr)
> >>> +            continue;
> >> This condition can never occur because pmu_sbi_snapshot_free() is call=
ed in the
> >> error path.
> >
> > Yeah. Removed it.
> >
> >>
> >>> +
> >>> +        snapshot_page =3D alloc_page(GFP_ATOMIC | __GFP_ZERO);
> >>> +        if (!snapshot_page) {
> >>> +            pmu_sbi_snapshot_free(pmu);
> >>> +            return -ENOMEM;
> >>> +        }
> >>> +        cpu_hw_evt->snapshot_addr =3D page_to_virt(snapshot_page);
> >>> +        cpu_hw_evt->snapshot_addr_phys =3D page_to_phys(snapshot_pag=
e);
> >>> +    }
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static int pmu_sbi_snapshot_disable(void)
> >>> +{
> >>> +    struct sbiret ret;
> >>> +
> >>> +    ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> >>> SBI_SHMEM_DISABLE,
> >>> +            SBI_SHMEM_DISABLE, 0, 0, 0, 0);
> >>> +    if (ret.error) {
> >>> +        pr_warn("failed to disable snapshot shared memory\n");
> >>> +        return sbi_err_map_linux_errno(ret.error);
> >>> +    }
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static int pmu_sbi_snapshot_setup(struct riscv_pmu *pmu, int cpu)
> >>> +{
> >>> +    struct cpu_hw_events *cpu_hw_evt;
> >>> +    struct sbiret ret =3D {0};
> >>> +
> >>> +    cpu_hw_evt =3D per_cpu_ptr(pmu->hw_events, cpu);
> >>> +    if (!cpu_hw_evt->snapshot_addr_phys)
> >>> +        return -EINVAL;
> >>> +
> >>> +    if (cpu_hw_evt->snapshot_set_done)
> >>> +        return 0;
> >>> +
> >>> +    if (IS_ENABLED(CONFIG_32BIT))
> >>> +        ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHME=
M,
> >>> +                cpu_hw_evt->snapshot_addr_phys,
> >>> +                (u64)(cpu_hw_evt->snapshot_addr_phys) >> 32, 0, 0, 0=
, 0);
> >> phys_addr_t on riscv32 is 32 bits, so the high argument will always be=
 zero.
> >> (I'm guessing the compiler warned without the cast?) Do we need this s=
pecial
> >> case?
> >
> > As per the spec maximum physical address bits can be 34 bits on RV32. L=
inux
> > kernel doesn't support it yet though.
> > But the casting is there just for forward compatibility. We can remove =
it and
> > leave a commit but I thought of keeping it
> > there to make things explicit.
> >
> >>> +    else
> >>> +        ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHME=
M,
> >>> +                cpu_hw_evt->snapshot_addr_phys, 0, 0, 0, 0, 0);
> >>> +
> >>> +    /* Free up the snapshot area memory and fall back to SBI PMU cal=
ls
> >>> without snapshot */
> >>> +    if (ret.error) {
> >>> +        if (ret.error !=3D SBI_ERR_NOT_SUPPORTED)
> >>> +            pr_warn("pmu snapshot setup failed with error %ld\n", re=
t.error);
> >>> +        cpu_hw_evt->snapshot_set_done =3D false;
> >> This statement has no effect; snapshot_set_done is known to be false a=
bove.
> >
> > Removed it.
> >
> >>> +        return sbi_err_map_linux_errno(ret.error);
> >>> +    }
> >>> +
> >>> +    cpu_hw_evt->snapshot_set_done =3D true;
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>>   static u64 pmu_sbi_ctr_read(struct perf_event *event)
> >>>   {
> >>>       struct hw_perf_event *hwc =3D &event->hw;
> >>>       int idx =3D hwc->idx;
> >>>       struct sbiret ret;
> >>>       u64 val =3D 0;
> >>> +    struct riscv_pmu *pmu =3D to_riscv_pmu(event->pmu);
> >>> +    struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events=
);
> >>> +    struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_a=
ddr;
> >>>       union sbi_pmu_ctr_info info =3D pmu_ctr_list[idx];
> >>>   +    /* Read the value from the shared memory directly */
> >>> +    if (sbi_pmu_snapshot_available()) {
> >>> +        val =3D sdata->ctr_values[idx];
> >>> +        return val;
> >>> +    }
> >> This does not work if pmu_sbi_ctr_read() is called while the counter i=
s started,
> >> because ctr_values is only updated when stopping the counter (and the =
shared
> >> memory is only updated at that time as well). So you would need to che=
ck for
> >> PERF_HES_STOPPED or being in the overflow handler here. And this can't=
 possibly
> >
> > Do you see a case where it is not called before counters are stopped ?
> > IIRC, perf framework invokes pmu->read() function when counters are sto=
pped
> >
> > riscv_pmu.c invokes it only after stopping the counters
> > riscv_pmu_stop->riscv_pmu_event_update->rvpmu->ctr_read
>
> It is also called through riscv_pmu_read(). A trivial example where the c=
ounters
> are read while started is `perf stat -C <cpu> -I <interval>`. With loggin=
g the

Ahh okay. Collecting stats in interval mode triggers this path. Thanks.
As snapshot memory read is only valid after counter stop, I will add
the state(PERF_HES_STOPPED) check.
The state needs to be updated in the overflow use case as well.

> function and event_idx:
>
> root@riscv64:~# perf stat -C 0 -I 1000 -e cycles
> [  104.785970] riscv-pmu-sbi: pmu_sbi_ctr_start: 000001
> [  105.793160] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
> #           time             counts unit events
>      1.001090667         1015156505      cycles
> [  106.800077] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
>      2.008009126         1014973064      cycles
> [  107.806955] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
>      3.014884251         1014937544      cycles
> [  108.813842] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
>      4.021772502         1014941900      cycles
> [  109.820759] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
>      5.028687252         1014974904      cycles
> [  110.827678] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
>      6.035604711         1014971076      cycles
> [  111.835107] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
>      7.043036628         1015488590      cycles
> ^C[  111.959028] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
>      7.166958420[  111.964343] riscv-pmu-sbi: pmu_sbi_ctr_stop: 000001
> [  111.970435] riscv-pmu-sbi: pmu_sbi_ctr_read: 000001
> [  111.975337] riscv-pmu-sbi: pmu_sbi_ctr_stop: 000001
>           124942006      cycles
>
> root@riscv64:~#
>
> >> work for idx >=3D XLEN.
> >
> > The idx should be less than num_counters as that's what pmu_ctr_list is
> > allocated for.
> > ctr_values size limitation is 64 as per the spec which is sufficient as=
 given
> > number of defined
> > firmware events + hpmcounters < 64.
>
> Yes, but only the first XLEN elements in ctr_values can be read/updated b=
y an
> SBI call, and XLEN < 64 on riscv32. This actually works with the current =
code
> for the non-overflow case, because SBI_PMU_START_FLAG_INIT_SNAPSHOT is no=
t used,
> and the value copying code in pmu_sbi_ctr_stop() isn't limited by XLEN.
>
> However, pmu_sbi_stop_hw_ctrs() is broken, even after the next patch. Sto=
pping
> counters 32-63 will clobber (an arbitrary subset of) the values for count=
ers
> 0-31. You would need code to move the values for counters 32-63 from the =
first
> half of ctr_values to the second half. And because ctr_values is only wri=
tten by
> the SBI implementation _when the counter is stopped_, we can't ask the SB=
I
> implementation to restore the values for counters 0-31, so those values m=
ust be
> backed up somewhere else.
>
> The simple solution might be to have a shadow copy of ctr_values, that al=
ways
> puts the values at the same (absolute) offset.
>

Agreed. Fixed it.

> > We can add a paranoia check for idx but idx is retrieved from event->hw=
 which is
> > filled by the driver itself.
> > There are lot of function which access idx from event->hw as well.
> >
> > That's why, I don't think it is required.
>
> Right, I wasn't concerned about bounds checking, only that
> SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT is limited to writing to the first XLEN e=
lements
> of ctr_values.
>
> >>> +
> >>>       if (pmu_sbi_is_fw_event(event)) {
> >>>           ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
> >>>                   hwc->idx, 0, 0, 0, 0, 0);
> >>> @@ -565,6 +663,7 @@ static void pmu_sbi_ctr_start(struct perf_event *=
event,
> >>> u64 ival)
> >>>       struct hw_perf_event *hwc =3D &event->hw;
> >>>       unsigned long flag =3D SBI_PMU_START_FLAG_SET_INIT_VALUE;
> >>>   +    /* There is no benefit setting SNAPSHOT FLAG for a single coun=
ter */
> >>>   #if defined(CONFIG_32BIT)
> >>>       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->=
idx,
> >>>               1, flag, ival, ival >> 32, 0);
> >>> @@ -585,16 +684,36 @@ static void pmu_sbi_ctr_stop(struct perf_event =
*event,
> >>> unsigned long flag)
> >>>   {
> >>>       struct sbiret ret;
> >>>       struct hw_perf_event *hwc =3D &event->hw;
> >>> +    struct riscv_pmu *pmu =3D to_riscv_pmu(event->pmu);
> >>> +    struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events=
);
> >>> +    struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_a=
ddr;
> >>>         if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
> >>>           (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> >>>           pmu_sbi_reset_scounteren((void *)event);
> >>>   +    if (sbi_pmu_snapshot_available())
> >>> +        flag |=3D SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
> >>> +
> >>>       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->i=
dx, 1,
> >>> flag, 0, 0, 0);
> >>> -    if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STOPPED) &&
> >>> -        flag !=3D SBI_PMU_STOP_FLAG_RESET)
> >>> +    if (!ret.error && sbi_pmu_snapshot_available()) {
> >>> +        /*
> >>> +         * The counter snapshot is based on the index base specified=
 by
> >>> hwc->idx.
> >>> +         * The actual counter value is updated in shared memory at i=
ndex 0
> >>> when counter
> >>> +         * mask is 0x01. To ensure accurate counter values, it's nec=
essary
> >>> to transfer
> >>> +         * the counter value to shared memory. However, if hwc->idx =
is zero,
> >>> the counter
> >>> +         * value is already correctly updated in shared memory, requ=
iring no
> >>> further
> >>> +         * adjustment.
> >>> +         */
> >>> +        if (hwc->idx > 0) {
> >>> +            sdata->ctr_values[hwc->idx] =3D sdata->ctr_values[0];
> >>> +            sdata->ctr_values[0] =3D 0;
> >> This clobbers sdata->ctr_values[0], which may be used later by
> >> pmu_sbi_ctr_read(). This only happens to work if riscv_pmu_stop() is a=
lways
> >> called with the PERF_EF_UPDATE flag, and riscv_pmu_read() is never cal=
led with
> >> the event stopped but still in PERF_EVENT_STATE_ACTIVE. I think both o=
f those
> >> conditions are true at the moment, but this is still rather fragile.
> >
> > I don't understand the concern of being fragile when the current implem=
entation
> > does it what you just described.
> >
> > Can you describe the use case when you think it will be fragile ? Do yo=
u
> > envision some core perf framework
> > changes that would call pmu->stop() without PERF_EF_UPDATE ?
>
> PERF_EF_UPDATE is a flag, so the API seems to have been designed with the
> expectation that it is set only sometimes. I can't predict how the core p=
erf
> logic will change, but I doubt whoever is changing it will be aware of th=
e
> subtle undocumented requirements for correctness here. Regardless, it's n=
ot an
> issue if we copy the counter values outside the shared memory.
>


> >>> +        }
> >>> +    } else if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STOPPED)=
 &&
> >>> +        flag !=3D SBI_PMU_STOP_FLAG_RESET) {
> >>>           pr_err("Stopping counter idx %d failed with error %d\n",
> >>>               hwc->idx, sbi_err_map_linux_errno(ret.error));
> >>> +    }
> >>>   }
> >>>     static int pmu_sbi_find_num_ctrs(void)
> >>> @@ -652,10 +771,14 @@ static inline void pmu_sbi_stop_all(struct risc=
v_pmu *pmu)
> >>>   static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
> >>>   {
> >>>       struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_event=
s);
> >>> +    unsigned long flag =3D 0;
> >>> +
> >>> +    if (sbi_pmu_snapshot_available())
> >>> +        flag =3D SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
> >>>         /* No need to check the error here as we can't do anything ab=
out the
> >>> error */
> >>>       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
> >>> -          cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
> >>> +          cpu_hw_evt->used_hw_ctrs[0], flag, 0, 0, 0);
> >> This only updates the overflow bitmap and counter values for the first=
 XLEN
> >> counters. You need a second call for any remaining counters on riscv32=
. Of
> >> course, this will clobber (up to) the entire shared memory, breaking l=
ater calls
> >> to pmu_sbi_ctr_read().
> >
> > It's done in the next patch.
> > https://lore.kernel.org/lkml/20240416184421.3693802-10-atishp@rivosinc.=
com/
>
> This still isn't right (overflowed_ctrs and ctr_ovf_mask also need to be =
64
> bits), and the fix should come before patches adding new features.
>

Moved that patch before this patch and fixed the size of both masks to
allow logical
counters upto 64 bits.

> >>>   }
> >>>     /*
> >>> @@ -664,11 +787,10 @@ static inline void pmu_sbi_stop_hw_ctrs(struct
> >>> riscv_pmu *pmu)
> >>>    * while the overflowed counters need to be started with updated
> >>> initialization
> >>>    * value.
> >>>    */
> >>> -static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu=
,
> >>> -                           unsigned long ctr_ovf_mask)
> >>> +static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events
> >>> *cpu_hw_evt,
> >>> +                        unsigned long ctr_ovf_mask)
> >>>   {
> >>>       int idx =3D 0;
> >>> -    struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events=
);
> >>>       struct perf_event *event;
> >>>       unsigned long flag =3D SBI_PMU_START_FLAG_SET_INIT_VALUE;
> >>>       unsigned long ctr_start_mask =3D 0;
> >>> @@ -703,6 +825,48 @@ static inline void pmu_sbi_start_overflow_mask(s=
truct
> >>> riscv_pmu *pmu,
> >>>       }
> >>>   }
> >>>   +static noinline void pmu_sbi_start_ovf_ctrs_snapshot(struct cpu_hw=
_events
> >>> *cpu_hw_evt,
> >>> +                             unsigned long ctr_ovf_mask)
> >> Why do these two functions need to be noinline?
> >>
> > They don't. I will remove it.
> >
> >>> +{
> >>> +    int idx =3D 0;
> >>> +    struct perf_event *event;
> >>> +    unsigned long flag =3D SBI_PMU_START_FLAG_INIT_SNAPSHOT;
> >>> +    u64 max_period, init_val =3D 0;
> >>> +    struct hw_perf_event *hwc;
> >>> +    struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_a=
ddr;
> >>> +
> >>> +    for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTE=
RS) {
> >>> +        if (ctr_ovf_mask & BIT(idx)) {
> >> This is also broken on riscv32 (as is the existing code), since ctr_ov=
f_mask is
> >> only 32 bits there, but idx counts from 0 to 63.
> >
> > For RV32, if there is a counter idx that is beyond 32 bits, it is not s=
upported
> > in counter overflow
> > scenario anyways. So it doesn't matter now.
> >
> > We need to change the pmu_sbi_ovf_handler to handle counter overflows f=
or
> > counters > 32 bit though.
> > As there is not use case right now, I did not add it.
>
> There are two sets of indexes here. There's the bits in SCOUNTOVF, which =
are
> limited to 32 bits; and there are the SBI counter indexes, which go up to=
 64. A
> bit < 32 in SCOUNTOVF might map to a SBI counter index >=3D 32. The fact =
that
> pmu_sbi_ovf_handler() is limited to SBI counter indexes < XLEN is a bug.
>
> >>> +            event =3D cpu_hw_evt->events[idx];
> >>> +            hwc =3D &event->hw;
> >>> +            max_period =3D riscv_pmu_ctr_get_width_mask(event);
> >>> +            init_val =3D local64_read(&hwc->prev_count) & max_period=
;
> >>> +            sdata->ctr_values[idx] =3D init_val;
> >>> +        }
> >>> +        /*
> >>> +         * We do not need to update the non-overflow counters the pr=
evious
> >>> +         * value should have been there already.
> >>> +         */
> >>> +    }
> >>> +
> >>> +    for (idx =3D 0; idx < BITS_TO_LONGS(RISCV_MAX_COUNTERS); idx++) =
{
> >>> +        /* Start all the counters in a single shot */
> >>> +        sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx * BITS=
_PER_LONG,
> >>> +              cpu_hw_evt->used_hw_ctrs[idx], flag, 0, 0, 0);
> >>> +    }
> >>> +}
> >>> +
> >>> +static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> >>> +                    unsigned long ctr_ovf_mask)
> >>> +{
> >>> +    struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events=
);
> >>> +
> >>> +    if (sbi_pmu_snapshot_available())
> >>> +        pmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
> >>> +    else
> >>> +        pmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
> >>> +}
> >>> +
> >>>   static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
> >>>   {
> >>>       struct perf_sample_data data;
> >>> @@ -716,6 +880,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, v=
oid *dev)
> >>>       unsigned long overflowed_ctrs =3D 0;
> >>>       struct cpu_hw_events *cpu_hw_evt =3D dev;
> >>>       u64 start_clock =3D sched_clock();
> >>> +    struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_a=
ddr;
> >>>         if (WARN_ON_ONCE(!cpu_hw_evt))
> >>>           return IRQ_NONE;
> >>> @@ -737,8 +902,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, =
void *dev)
> >>>       pmu_sbi_stop_hw_ctrs(pmu);
> >>>         /* Overflow status register should only be read after counter=
 are
> >>> stopped */
> >>> -    ALT_SBI_PMU_OVERFLOW(overflow);
> >>> -
> >> nit: no need to remove this line.
> >
> > Fixed.
> >
> >
> >>> +    if (sbi_pmu_snapshot_available())
> >>> +        overflow =3D sdata->ctr_overflow_mask;
> >>> +    else
> >>> +        ALT_SBI_PMU_OVERFLOW(overflow);
> >>>       /*
> >>>        * Overflow interrupt pending bit should only be cleared after =
stopping
> >>>        * all the counters to avoid any race condition.
> >>> @@ -819,6 +986,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu,=
 struct
> >>> hlist_node *node)
> >>>           enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
> >>>       }
> >>>   +    if (sbi_pmu_snapshot_available())
> >>> +        return pmu_sbi_snapshot_setup(pmu, cpu);
> >>> +
> >>>       return 0;
> >>>   }
> >>>   @@ -831,6 +1001,9 @@ static int pmu_sbi_dying_cpu(unsigned int cpu,=
 struct
> >>> hlist_node *node)
> >>>       /* Disable all counters access for user mode now */
> >>>       csr_write(CSR_SCOUNTEREN, 0x0);
> >>>   +    if (sbi_pmu_snapshot_available())
> >>> +        return pmu_sbi_snapshot_disable();
> >>> +
> >>>       return 0;
> >>>   }
> >>>   @@ -939,6 +1112,11 @@ static inline void riscv_pm_pmu_unregister(st=
ruct
> >>> riscv_pmu *pmu) { }
> >>>     static void riscv_pmu_destroy(struct riscv_pmu *pmu)
> >>>   {
> >>> +    if (sbi_v2_available) {
> >>> +        pmu_sbi_snapshot_free(pmu);
> >>> +        if (sbi_pmu_snapshot_available())
> >>> +            pmu_sbi_snapshot_disable();
> >> This is technically fine because nothing is writing to the shmem at th=
is time,
> >> but it certainly looks like a possible use-after-free.
> >
> > Yes. It would have been use-after-free if pmu_sbi_snapshot_disable uses=
 the
> > allocated
> > address. I guess the the function name doesn't indicate that the disabl=
e happens
> > by passing -1 instead
> > of the previously allocated address.
> >
> >
> >> Also, this whole block can go inside the sbi_pmu_snapshot_available() =
check,
> >> because either the branch is set or pmu_sbi_snapshot_free() is already=
 called in
> >> the error case below.
> >
> > I kept it above because the conditions are different logically.
> > The sbi_pmu_snapshot_available is only enabled when snapshot_setup succ=
eeds not
> > when snapshot_alloc is successful.
> >
> > In reality, it doesn't matter though as we free it in the error case as=
 you
> > pointed.
> >
> > Either way, I will move it inside.
>
> Makes sense to me.
>
> Regards,
> Samuel
>
> >>> +    }
> >>>       riscv_pm_pmu_unregister(pmu);
> >>>       cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu-=
>node);
> >>>   }
> >>> @@ -1106,10 +1284,6 @@ static int pmu_sbi_device_probe(struct platfor=
m_device
> >>> *pdev)
> >>>       pmu->event_unmapped =3D pmu_sbi_event_unmapped;
> >>>       pmu->csr_index =3D pmu_sbi_csr_index;
> >>>   -    ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING,=
 &pmu->node);
> >>> -    if (ret)
> >>> -        return ret;
> >>> -
> >>>       ret =3D riscv_pm_pmu_register(pmu);
> >>>       if (ret)
> >>>           goto out_unregister;
> >>> @@ -1118,8 +1292,34 @@ static int pmu_sbi_device_probe(struct platfor=
m_device
> >>> *pdev)
> >>>       if (ret)
> >>>           goto out_unregister;
> >>>   +    /* SBI PMU Snapsphot is only available in SBI v2.0 */
> >>> +    if (sbi_v2_available) {
> >>> +        ret =3D pmu_sbi_snapshot_alloc(pmu);
> >>> +        if (ret)
> >>> +            goto out_unregister;
> >>> +
> >>> +        ret =3D pmu_sbi_snapshot_setup(pmu, smp_processor_id());
> >>> +        if (ret) {
> >>> +            /* Snapshot is an optional feature. Continue if not avai=
lable */
> >>> +            pmu_sbi_snapshot_free(pmu);
> >>> +        } else {
> >>> +            pr_info("SBI PMU snapshot detected\n");
> >>> +            /*
> >>> +             * We enable it once here for the boot cpu. If snapshot =
shmem setup
> >>> +             * fails during cpu hotplug process, it will fail to sta=
rt the cpu
> >>> +             * as we can not handle hetergenous PMUs with different =
snapshot
> >>> +             * capability.
> >>> +             */
> >>> +            static_branch_enable(&sbi_pmu_snapshot_available);
> >>> +        }
> >>> +    }
> >>> +
> >>>       register_sysctl("kernel", sbi_pmu_sysctl_table);
> >>>   +    ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING,=
 &pmu->node);
> >>> +    if (ret)
> >>> +        goto out_unregister;
> >>> +
> >>>       return 0;
> >>>     out_unregister:
> >>> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/risc=
v_pmu.h
> >>> index 43282e22ebe1..c3fa90970042 100644
> >>> --- a/include/linux/perf/riscv_pmu.h
> >>> +++ b/include/linux/perf/riscv_pmu.h
> >>> @@ -39,6 +39,12 @@ struct cpu_hw_events {
> >>>       DECLARE_BITMAP(used_hw_ctrs, RISCV_MAX_COUNTERS);
> >>>       /* currently enabled firmware counters */
> >>>       DECLARE_BITMAP(used_fw_ctrs, RISCV_MAX_COUNTERS);
> >>> +    /* The virtual address of the shared memory where counter snapsh=
ot will
> >>> be taken */
> >>> +    void *snapshot_addr;
> >>> +    /* The physical address of the shared memory where counter snaps=
hot will
> >>> be taken */
> >>> +    phys_addr_t snapshot_addr_phys;
> >>> +    /* Boolean flag to indicate setup is already done */
> >>> +    bool snapshot_set_done;
> >>>   };
> >>>     struct riscv_pmu {
>

