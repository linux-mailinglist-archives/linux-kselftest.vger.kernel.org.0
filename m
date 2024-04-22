Return-Path: <linux-kselftest+bounces-8590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A538AC3A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 07:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364321F21C4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 05:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994917C68;
	Mon, 22 Apr 2024 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="28iWJCyZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928E179AA
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763610; cv=none; b=RHQ61e5W4RdOxCrCKNkSTeaB5WQmcz0lt4Kdoh0wemGEw587RPq45MjkiKQt9dJL14CjUr9HhcruQ25/GaBfDJcYu9oByO7/yZjBIq1CzZdy59N7ZpQpgz1lHcHedWn0ckOfw7RagpsAUr5nHrsEWPUipEA7Gqd2x0fNf+7JgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763610; c=relaxed/simple;
	bh=S8RSp/2q15SRYkEZDE5+H+zC8HJZOOYbv21axv7mTXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YM595+gMvypeWKWW3CWYUlRWERv1jXRw340ObxKiYB2vORh9s0o783EVjxoce9/ctkuDC/a3MwvM9QO1rAQa21kLPSI1onL6KTx1ZvAOvnGbm7juWvRdNoyEsTOXxrkm6+jzg4bcPGyBFy1sdX8Cfbha3OPV8/ftWtFgK/srUiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=28iWJCyZ; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7dad4456a99so10417139f.1
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Apr 2024 22:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713763608; x=1714368408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cial3YyC1sggqpy7QrWZpU+HgoNnfN50j0VIzR/hees=;
        b=28iWJCyZ75v6mrJoXTnW0x+Y/8fMBuuWODfWdnsql28NVjG91HRXqDrsk4itTJtdu5
         PhRnx0VbjwYn6IgLfiOzntm05izcA8tkGRVRBtYprKhgeo+9K3MeGOBvIH0rqdGJKVSh
         VHQf+R1pJHYrZsDfLgSe/1SScadmUV/j0tmS3hhRSHtD2ErHjfIah7nFiW5Te8y9ABDv
         EMH8k8btOdYpwFjbCud450RATONngCcUSvRESCGuK97t/qQ2VP69BocuI7cegKBMxsPz
         BtlZ/Nk1kXftsysznqwsffuWSao/LbfKEdjq0FeWQQ2YtmtoLlTnvnUd+AGE4bT1K86l
         pSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763608; x=1714368408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cial3YyC1sggqpy7QrWZpU+HgoNnfN50j0VIzR/hees=;
        b=lxZQs/JjFR4TKoCyKdDjxb1RVpg+epPA0ZKMU4eq9zLjZyWZ8m/5z4kUkRTu8Fu6DQ
         IJLZDuECycWuGRkFnW7xBGZvIWTZhJjlDjBq1wm2mWh4SgQ3Nki+vl12Er7DVL8bDc+I
         ndaGUjHywL3I+QarHAkOb/7ha92HSJUkfE64ynZxtICxpuumysnfo+72Xe74vnn0lb4u
         SboxVRxlx2PFCtoii9pErs6KYGdf7+PpxMpaOtxsElYjyNi+8Hf1TWW6EsEA3BSXNWIq
         +dx9/ZL2NM6K3TRxzJ02hLIoMJi9Y4VECizQXhjRC4sx2TqiX5WyD+MhV3YlpaPfkrbF
         e4gg==
X-Forwarded-Encrypted: i=1; AJvYcCWJHV69xIyK79ZlWJfsFzBSWbOgQ4ptKO9+4IDAahjHnZ+J3WUjRfNVMiBiPGZ/3FEYmxrufrGPufe75R+JeLfAZL31mz7DaNKoy60XlS7X
X-Gm-Message-State: AOJu0YxWBEsjPB/G6Q9dV4DGDgY2Jkcd0eVWxQVRqje+UAiy0WU+qMrn
	tpPbL7mYiNnl+zOUMPGrQjLIzRAGVsm7vuCUEc4jRr6CelRqZJTPVMSPlgb6ZWUqIeCwa6Q49ls
	klWE5/5vCpTKep3vLhaGjFaSwD6bjSUSsBqTC3Q==
X-Google-Smtp-Source: AGHT+IEABacZ9QXPS+L5TLIrF699DxFIKbW3bDrYQOc34jyt+qHXpuDOMiVpMcu9RlTxm6mqruBv7i/++4LrvmLUpRQ=
X-Received: by 2002:a05:6e02:1386:b0:36b:aae:613 with SMTP id
 d6-20020a056e02138600b0036b0aae0613mr12274364ilo.10.1713763608202; Sun, 21
 Apr 2024 22:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-17-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-17-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 10:56:37 +0530
Message-ID: <CAAhSdy0OPv3Fg1CWV9vzE_nHo943TNRh6-xxt8WTK6fOFg_ptg@mail.gmail.com>
Subject: Re: [PATCH v8 16/24] RISC-V: KVM: Improve firmware counter read function
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 5:18=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Rename the function to indicate that it is meant for firmware
> counter read. While at it, add a range sanity check for it as
> well.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/kvm_vcpu_pmu.h | 2 +-
>  arch/riscv/kvm/vcpu_pmu.c             | 7 ++++++-
>  arch/riscv/kvm/vcpu_sbi_pmu.c         | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/a=
sm/kvm_vcpu_pmu.h
> index 55861b5d3382..fa0f535bbbf0 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> @@ -89,7 +89,7 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *v=
cpu, unsigned long ctr_ba
>                                      unsigned long ctr_mask, unsigned lon=
g flags,
>                                      unsigned long eidx, u64 evtdata,
>                                      struct kvm_vcpu_sbi_return *retdata)=
;
> -int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cid=
x,
> +int kvm_riscv_vcpu_pmu_fw_ctr_read(struct kvm_vcpu *vcpu, unsigned long =
cidx,
>                                 struct kvm_vcpu_sbi_return *retdata);
>  int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned lo=
ng cidx,
>                                       struct kvm_vcpu_sbi_return *retdata=
);
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e1409ec9afc0..04db1f993c47 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -235,6 +235,11 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsig=
ned long cidx,
>         u64 enabled, running;
>         int fevent_code;
>
> +       if (cidx >=3D kvm_pmu_num_counters(kvpmu) || cidx =3D=3D 1) {
> +               pr_warn("Invalid counter id [%ld] during read\n", cidx);
> +               return -EINVAL;
> +       }
> +
>         pmc =3D &kvpmu->pmc[cidx];
>
>         if (pmc->cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW) {
> @@ -747,7 +752,7 @@ int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu=
 *vcpu, unsigned long cidx,
>         return 0;
>  }
>
> -int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cid=
x,
> +int kvm_riscv_vcpu_pmu_fw_ctr_read(struct kvm_vcpu *vcpu, unsigned long =
cidx,
>                                 struct kvm_vcpu_sbi_return *retdata)
>  {
>         int ret;
> diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.=
c
> index cf111de51bdb..e4be34e03e83 100644
> --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> @@ -62,7 +62,7 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcp=
u, struct kvm_run *run,
>                 ret =3D kvm_riscv_vcpu_pmu_ctr_stop(vcpu, cp->a0, cp->a1,=
 cp->a2, retdata);
>                 break;
>         case SBI_EXT_PMU_COUNTER_FW_READ:
> -               ret =3D kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata=
);
> +               ret =3D kvm_riscv_vcpu_pmu_fw_ctr_read(vcpu, cp->a0, retd=
ata);
>                 break;
>         case SBI_EXT_PMU_COUNTER_FW_READ_HI:
>                 if (IS_ENABLED(CONFIG_32BIT))
> --
> 2.34.1
>

