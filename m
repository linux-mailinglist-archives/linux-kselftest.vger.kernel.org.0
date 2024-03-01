Return-Path: <linux-kselftest+bounces-5687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC6086DADC
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 05:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEE6286D5E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 04:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE3E4F8B2;
	Fri,  1 Mar 2024 04:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="2v0a2oEK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7070F2D796
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 04:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709268640; cv=none; b=iKpBZUJCFOGxva+gG5KBkYWiIAGa/Kn9FAXT2LaKxJVFTC537uu7n57o8mxB+mJA/zPj/Fm9zzDheGoPRMFz57Y0VZo1QD1ejKKafrfbeJaEcd0OjUNSl2LKsAqrk41T3ojxbsNp6y7MbC/T9M1EbIjFK/M15B8Ht4S56QXdsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709268640; c=relaxed/simple;
	bh=mT1MZ1fMMQlMkOxIDF9llF1ATqJHq4lOGAFPsYZQk6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2UCfN7Uo+9KawH60r2Jw5CBOLN999vgXFEBwtJV4XV4hf6xF9qOBhGDJIO/opN/L1b1GPPNjUco5v3bPj0e2JKalTWhHBt1Me6gHht8aTNbb2BDwE1zww5bhu3hauTWnaLEnR5bi2hevvMzihvC8p6zpU6FZnACKYdAkkUgEPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=2v0a2oEK; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c81e087882so12923239f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 20:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1709268638; x=1709873438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/sZmRwqepYm/t8DLI3pUHpFe+4LbBxk7Bh/ih2fnIs=;
        b=2v0a2oEK4BU9yivRhg8rs+Z4iTO09rfNckWCsEQtKeY2IzIQKCW8dDTxAH5QHubUFO
         sq/FCt3ZxPPZYi5qkzKoY//NwhaiGpUsHUWpDQUq/m0T7IzRGUcxQDU3hY5GuM9ub47t
         F2/MDdeCOYilEALcKoMNzvojkHYEztaYeHpfNB0maqxJKa3bXJaR/8aLKJhLxp0J65Iv
         edXjeAeiJU7FV2j8npoh3cuSrmQWhTgfMpK+jpMubD2l8CX2XRdVhOR7nx+uUD0ANrP/
         67tU8cRwRgx3MEv99UfcesV9AO6Dz+C5a1dyH9Kw1IMxiM5i6IFjS3/L0q/YCSpu7Q/a
         cvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709268638; x=1709873438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/sZmRwqepYm/t8DLI3pUHpFe+4LbBxk7Bh/ih2fnIs=;
        b=Yvrsw+m0Pz/X7Ss7Ko5gTMInKpDp8du8IviCGc9jiv40hVbe4ftVR+tqhQgsdfqgQz
         cYFBj2mM1mTln+5Opr5EcaNUUdYbQiGQ61DhPy4cgceESc6U5hYYdNxbQ7RPd0zGxVV5
         fIQ8Vt3/V7V5R2kGwS3iKSkzHG2S+abB6KQUK+xtC2TEMHIxdUFyQPTvIHj+qcExDhM9
         fVUknLpy3BE67TfIaVbmk4TzWKvNimZBH1elzGW26ULbiPamg0YaqHPumgGkBeQDEzOb
         PI7+Ywisa9EuRh4eh9Ljo6XSjRy3cCDW/jxVNPKUVzRk+u2YMCe6OuQ6fh5ibmX3stPl
         apxw==
X-Forwarded-Encrypted: i=1; AJvYcCV1TtXe5XC+01YjO0sLxkupOpgI8WcgwaRHNp3Gg2KhmxF8bUtoH46MXaT4bKNRDucnsCDf50exZt9PTmPycI8WzgEo/azOCJmUhU8uyqhL
X-Gm-Message-State: AOJu0YxRHmZ7/0J6Wh9kVx4u7WzfvKm+TwBEV8lVltDd6P0tZ115J4sm
	TdFxrbAIgN6vY1aVcKdYLILpKtAwdI3Ze8dyUeb+sMJKkV6DkMOIBXjwnAuG1sNLfnnYnvs2J/m
	EfXkEc7j0V8wtq16WTQqSgJj81XceO47EEu4Dxg==
X-Google-Smtp-Source: AGHT+IGYzBIPM643oFcIvsiDu+5sr4oZNOaCivuF08o4l3eApQNsFAjmvx/AbE+4pGw+amraL1AiGC9/BCnI+iVYOMA=
X-Received: by 2002:a05:6e02:16c7:b0:365:616a:72da with SMTP id
 7-20020a056e0216c700b00365616a72damr327075ilx.7.1709268637765; Thu, 29 Feb
 2024 20:50:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-15-atishp@rivosinc.com>
In-Reply-To: <20240229010130.1380926-15-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 1 Mar 2024 10:20:27 +0530
Message-ID: <CAAhSdy1nBpw=5hOkrkBTgMTT1eXvikSe7kSSU2KbGCfqMCn1Sg@mail.gmail.com>
Subject: Re: [PATCH v4 14/15] KVM: riscv: selftests: Add a test for PMU
 snapshot functionality
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:32=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Verify PMU snapshot functionality by setting up the shared memory
> correctly and reading the counter values from the shared memory
> instead of the CSR.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  .../selftests/kvm/include/riscv/processor.h   |  25 ++++
>  .../selftests/kvm/lib/riscv/processor.c       |  12 ++
>  tools/testing/selftests/kvm/riscv/sbi_pmu.c   | 124 ++++++++++++++++++
>  3 files changed, 161 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index a49a39c8e8d4..e114d039e87b 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -173,6 +173,7 @@ enum sbi_ext_id {
>  };
>
>  enum sbi_ext_base_fid {
> +       SBI_EXT_BASE_GET_IMP_VERSION =3D 2,
>         SBI_EXT_BASE_PROBE_EXT =3D 3,
>  };
>
> @@ -201,6 +202,12 @@ union sbi_pmu_ctr_info {
>         };
>  };
>
> +struct riscv_pmu_snapshot_data {
> +       u64 ctr_overflow_mask;
> +       u64 ctr_values[64];
> +       u64 reserved[447];
> +};
> +
>  struct sbiret {
>         long error;
>         long value;
> @@ -247,6 +254,14 @@ enum sbi_pmu_ctr_type {
>  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
>  #define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
>
> +#define SBI_STA_SHMEM_DISABLE          -1
> +
> +/* SBI spec version fields */
> +#define SBI_SPEC_VERSION_DEFAULT       0x1
> +#define SBI_SPEC_VERSION_MAJOR_SHIFT   24
> +#define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> +#define SBI_SPEC_VERSION_MINOR_MASK    0xffffff
> +
>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>                         unsigned long arg1, unsigned long arg2,
>                         unsigned long arg3, unsigned long arg4,
> @@ -254,6 +269,16 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned l=
ong arg0,
>
>  bool guest_sbi_probe_extension(int extid, long *out_val);
>
> +/* Make SBI version */
> +static inline unsigned long sbi_mk_version(unsigned long major,
> +                                           unsigned long minor)
> +{
> +       return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> +               SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
> +}
> +
> +unsigned long get_host_sbi_impl_version(void);
> +
>  static inline void local_irq_enable(void)
>  {
>         csr_set(CSR_SSTATUS, SR_SIE);
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ec66d331a127..b0162d923e38 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -499,3 +499,15 @@ bool guest_sbi_probe_extension(int extid, long *out_=
val)
>
>         return true;
>  }
> +
> +unsigned long get_host_sbi_impl_version(void)
> +{
> +       struct sbiret ret;
> +
> +       ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_VERSION, 0,
> +                      0, 0, 0, 0, 0);
> +
> +       GUEST_ASSERT(!ret.error);
> +
> +       return ret.value;
> +}
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu.c b/tools/testing/=
selftests/kvm/riscv/sbi_pmu.c
> index fc1fc5eea99e..8ea2a6db6610 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu.c
> @@ -21,6 +21,11 @@
>  #define RISCV_MAX_PMU_COUNTERS 64
>  union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
>
> +/* Snapshot shared memory data */
> +#define PMU_SNAPSHOT_GPA_BASE          (1 << 30)
> +static void *snapshot_gva;
> +static vm_paddr_t snapshot_gpa;
> +
>  /* Cache the available counters in a bitmask */
>  static unsigned long counter_mask_available;
>
> @@ -173,6 +178,20 @@ static void stop_counter(unsigned long counter, unsi=
gned long stop_flags)
>                                counter, ret.error);
>  }
>
> +static void snapshot_set_shmem(vm_paddr_t gpa, unsigned long flags)
> +{
> +       unsigned long lo =3D (unsigned long)gpa;
> +#if __riscv_xlen =3D=3D 32
> +       unsigned long hi =3D (unsigned long)(gpa >> 32);
> +#else
> +       unsigned long hi =3D gpa =3D=3D -1 ? -1 : 0;
> +#endif
> +       struct sbiret ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT=
_SET_SHMEM,
> +                                     lo, hi, flags, 0, 0, 0);
> +
> +       GUEST_ASSERT(ret.value =3D=3D 0 && ret.error =3D=3D 0);
> +}
> +
>  static void test_pmu_event(unsigned long event)
>  {
>         unsigned long counter;
> @@ -207,6 +226,43 @@ static void test_pmu_event(unsigned long event)
>         stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
>  }
>
> +static void test_pmu_event_snapshot(unsigned long event)
> +{
> +       unsigned long counter;
> +       unsigned long counter_value_pre, counter_value_post;
> +       unsigned long counter_init_value =3D 100;
> +       struct riscv_pmu_snapshot_data *snapshot_data =3D snapshot_gva;
> +
> +       counter =3D get_counter_index(0, counter_mask_available, 0, event=
);
> +       counter_value_pre =3D read_counter(counter, ctrinfo_arr[counter])=
;
> +
> +       /* Do not set the initial value */
> +       start_counter(counter, 0, 0);
> +       dummy_func_loop(10000);
> +
> +       stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
> +
> +       /* The counter value is updated w.r.t relative index of cbase */
> +       counter_value_post =3D READ_ONCE(snapshot_data->ctr_values[0]);
> +       __GUEST_ASSERT(counter_value_post > counter_value_pre,
> +                      "counter_value_post %lx counter_value_pre %lx\n",
> +                      counter_value_post, counter_value_pre);
> +
> +       /* Now set the initial value and compare */
> +       WRITE_ONCE(snapshot_data->ctr_values[0], counter_init_value);
> +       start_counter(counter, SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT, 0);
> +       dummy_func_loop(10000);
> +
> +       stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
> +
> +       counter_value_post =3D READ_ONCE(snapshot_data->ctr_values[0]);
> +       __GUEST_ASSERT(counter_value_post > counter_init_value,
> +                      "counter_value_post %lx counter_init_value %lx for=
 counter\n",
> +                      counter_value_post, counter_init_value);
> +
> +       stop_counter(counter, SBI_PMU_STOP_FLAG_RESET);
> +}
> +
>  static void test_invalid_event(void)
>  {
>         struct sbiret ret;
> @@ -270,6 +326,41 @@ static void test_pmu_basic_sanity(int cpu)
>         GUEST_DONE();
>  }
>
> +static void test_pmu_events_snaphost(int cpu)
> +{
> +       long out_val =3D 0;
> +       bool probe;
> +       int num_counters =3D 0;
> +       unsigned long sbi_impl_version;
> +       struct riscv_pmu_snapshot_data *snapshot_data =3D snapshot_gva;
> +       int i;
> +
> +       probe =3D guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> +       GUEST_ASSERT(probe && out_val =3D=3D 1);
> +
> +       sbi_impl_version =3D get_host_sbi_impl_version();
> +       if (sbi_impl_version >=3D sbi_mk_version(2, 0))
> +               __GUEST_ASSERT(0, "SBI implementation version doesn't sup=
port PMU Snapshot");
> +
> +       snapshot_set_shmem(snapshot_gpa, 0);
> +
> +       /* Get the counter details */
> +       num_counters =3D get_num_counters();
> +       update_counter_info(num_counters);
> +
> +       /* Validate shared memory access */
> +       GUEST_ASSERT_EQ(READ_ONCE(snapshot_data->ctr_overflow_mask), 0);
> +       for (i =3D 0; i < num_counters; i++) {
> +               if (counter_mask_available & (1UL << i))
> +                       GUEST_ASSERT_EQ(READ_ONCE(snapshot_data->ctr_valu=
es[i]), 0);
> +       }
> +       /* Only these two events are guranteed to be present */
> +       test_pmu_event_snapshot(SBI_PMU_HW_CPU_CYCLES);
> +       test_pmu_event_snapshot(SBI_PMU_HW_INSTRUCTIONS);
> +
> +       GUEST_DONE();
> +}
> +
>  static void run_vcpu(struct kvm_vcpu *vcpu)
>  {
>         struct ucall uc;
> @@ -328,6 +419,36 @@ static void test_vm_events_test(void *guest_code)
>         test_vm_destroy(vm);
>  }
>
> +static void test_vm_setup_snapshot_mem(struct kvm_vm *vm, struct kvm_vcp=
u *vcpu)
> +{
> +       vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, PMU_SNAPSHO=
T_GPA_BASE, 1, 1, 0);
> +       /* PMU Snapshot requires single page only */
> +       virt_map(vm, PMU_SNAPSHOT_GPA_BASE, PMU_SNAPSHOT_GPA_BASE, 1);
> +
> +       /* PMU_SNAPSHOT_GPA_BASE is identity mapped */
> +       snapshot_gva =3D (void *)(PMU_SNAPSHOT_GPA_BASE);
> +       snapshot_gpa =3D addr_gva2gpa(vcpu->vm, (vm_vaddr_t)snapshot_gva)=
;
> +       sync_global_to_guest(vcpu->vm, snapshot_gva);
> +       sync_global_to_guest(vcpu->vm, snapshot_gpa);
> +}
> +
> +static void test_vm_events_snapshot_test(void *guest_code)
> +{
> +       struct kvm_vm *vm =3D NULL;
> +       struct kvm_vcpu *vcpu =3D NULL;
> +
> +       vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +       __TEST_REQUIRE(__vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_S=
BI_EXT_PMU)),
> +                                  "SBI PMU not available, skipping test"=
);
> +
> +       test_vm_setup_snapshot_mem(vm, vcpu);
> +
> +       vcpu_args_set(vcpu, 1, 0);
> +       run_vcpu(vcpu);
> +
> +       test_vm_destroy(vm);
> +}
> +
>  int main(void)
>  {
>         test_vm_basic_test(test_pmu_basic_sanity);
> @@ -336,5 +457,8 @@ int main(void)
>         test_vm_events_test(test_pmu_events);
>         pr_info("SBI PMU event verification test : PASS\n");
>
> +       test_vm_events_snapshot_test(test_pmu_events_snaphost);
> +       pr_info("SBI PMU event verification with snapshot test : PASS\n")=
;
> +
>         return 0;
>  }
> --
> 2.34.1
>

