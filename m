Return-Path: <linux-kselftest+bounces-2175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB5817FC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 03:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F0C28552A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 02:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8D31FDD;
	Tue, 19 Dec 2023 02:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYfMlNWc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E491FAE;
	Tue, 19 Dec 2023 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cc5ee69960so28631461fa.0;
        Mon, 18 Dec 2023 18:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702952923; x=1703557723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LybLCdgFs9gLLPX00YSt1nmK2aV7C82qKaPm0j5xx54=;
        b=nYfMlNWcmEI58Xo10dgk6HKEKZ+IuRuLbDb9+LqAiOU82pYM1JLBuYPjZL/I+w7S9f
         hlcHgZU+Xe3Rz4Xroh8HFHbtPyYCG3ZE9LuEHjnLKmlRqQxUnDsY1J7b/jzRIueNj5/J
         jy1sku2NauOrbdkyFBkuh39k2xESJEivdS2qZegXywTSvQJVb+5oXuk6sZHixq1kV4Du
         xrnBKPAqpdqF6Z1P6GqFKL0eda+Dbhzlyt9bq9mZCUklHWADCcIY5qCNz8qQflkU1p2n
         d9n4xFue8IAMTYa8uqF3WbHYe8GFROuNMK6TyR8nYu8kliyldTU0JEYIeOosH5JzGg/j
         BLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702952923; x=1703557723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LybLCdgFs9gLLPX00YSt1nmK2aV7C82qKaPm0j5xx54=;
        b=P5ooeq6n8bnFgZmMQ3LBnvh1KmeVXMs0YGIirjI4HGX+P5Li7krlmBieDtmosunCXY
         K36EbwthB1gp4pHkHsctTh9GGFxzxO1uXg+SlW0lQRpslstJx3V5H6TlEKxgWHvOeyf/
         MfS5wReeEnUmZ71o1IXJpDTOwSEWfFXf/QCh+5709HNwZO7ZBBPce5uojLdftyXoN2hp
         pCPnLCG5rywfVJMuVXbJIb41c8ZjIPJpc1LeXAPJEGNUog+5Y3ZYLBTiDpoleVrxBTDn
         QDT6eQ7pc26QrXbiHNEhPu5p1Lr36JyB7VoKAUyCZqEP0pQYBhfwtKvflfIZ7Iv+16Hn
         Mejw==
X-Gm-Message-State: AOJu0YwLO6U3EsC6lfRVuhRp/ttZs4JxAeLNncqafS1nysmLjk7ypRgb
	fzJLXe0ridfJsL2G1jnDEsDnilGJXevass2HCcw=
X-Google-Smtp-Source: AGHT+IG6tljE07OMLVo3iJQf47agztV1nHz7B1i2JzU7TDEW4jew8QvJDd4tPS3eMEBquQ1JC0Eg0TLSm7SvcF9wtYg=
X-Received: by 2002:a05:6512:b0b:b0:50b:eb40:441a with SMTP id
 w11-20020a0565120b0b00b0050beb40441amr7027389lfu.127.1702952922543; Mon, 18
 Dec 2023 18:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702371136.git.haibo1.xu@intel.com> <02f6c9ccaaeb4ceb67137863e0317f62cef62496.1702371136.git.haibo1.xu@intel.com>
 <20231213-b02db86aaf7957be22b200f1@orel>
In-Reply-To: <20231213-b02db86aaf7957be22b200f1@orel>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 19 Dec 2023 10:28:31 +0800
Message-ID: <CAJve8okOO=e66Kko3LyDfsD+tRZvDGf_Zgmog-u5TUzk1JZ1RA@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] KVM: riscv: selftests: Add guest helper to get
 vcpu id
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Greentime Hu <greentime.hu@sifive.com>, wchen <waylingii@gmail.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Minda Chen <minda.chen@starfivetech.com>, 
	Samuel Holland <samuel@sholland.org>, Sean Christopherson <seanjc@google.com>, Like Xu <likexu@tencent.com>, 
	Peter Xu <peterx@redhat.com>, Vipin Sharma <vipinsh@google.com>, 
	Aaron Lewis <aaronlewis@google.com>, Thomas Huth <thuth@redhat.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:08=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Tue, Dec 12, 2023 at 05:31:17PM +0800, Haibo Xu wrote:
> > Add guest_get_vcpuid() helper to simplify accessing to per-cpu
> > private data. The sscratch CSR was used to store the vcpu id.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  tools/testing/selftests/kvm/include/aarch64/processor.h | 4 ----
> >  tools/testing/selftests/kvm/include/kvm_util_base.h     | 9 +++++++++
> >  tools/testing/selftests/kvm/lib/riscv/processor.c       | 8 ++++++++
> >  3 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/=
tools/testing/selftests/kvm/include/aarch64/processor.h
> > index c42d683102c7..16ae0ac01879 100644
> > --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> > +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> > @@ -226,8 +226,4 @@ void smccc_smc(uint32_t function_id, uint64_t arg0,=
 uint64_t arg1,
> >              uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5=
,
> >              uint64_t arg6, struct arm_smccc_res *res);
> >
> > -
> > -
> > -uint32_t guest_get_vcpuid(void);
> > -
> >  #endif /* SELFTEST_KVM_PROCESSOR_H */
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tool=
s/testing/selftests/kvm/include/kvm_util_base.h
> > index a18db6a7b3cf..666438113d22 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > @@ -932,4 +932,13 @@ void kvm_selftest_arch_init(void);
> >
> >  void kvm_arch_vm_post_create(struct kvm_vm *vm);
> >
> > +void vm_init_vector_tables(struct kvm_vm *vm);
> > +void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
> > +
> > +struct ex_regs;
> > +typedef void(*exception_handler_fn)(struct ex_regs *);
> > +void vm_install_exception_handler(struct kvm_vm *vm, int vector, excep=
tion_handler_fn handler);
>
> I think something happend on rebase since the above should be in a
> different patch (and were for v3). I suggest checking your previous
> and current version branches with git-range-diff after rebasing in
> order to catch stuff like this.
>
> Thanks,
> drew
>

Thanks for pointing it out. Will fix it in v5.

> > +
> > +uint32_t guest_get_vcpuid(void);
> > +
> >  #endif /* SELFTEST_KVM_UTIL_BASE_H */
> > diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/=
testing/selftests/kvm/lib/riscv/processor.c
> > index efd9ac4b0198..39a1e9902dec 100644
> > --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > @@ -316,6 +316,9 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm=
, uint32_t vcpu_id,
> >       vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.sp), stack_vaddr + stack_s=
ize);
> >       vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.pc), (unsigned long)guest_=
code);
> >
> > +     /* Setup sscratch for guest_get_vcpuid() */
> > +     vcpu_set_reg(vcpu, RISCV_CSR_REG(sscratch), vcpu_id);
> > +
> >       /* Setup default exception vector of guest */
> >       vcpu_set_reg(vcpu, RISCV_CSR_REG(stvec), (unsigned long)guest_une=
xp_trap);
> >
> > @@ -436,3 +439,8 @@ void vm_install_interrupt_handler(struct kvm_vm *vm=
, exception_handler_fn handle
> >
> >       handlers->exception_handlers[1][0] =3D handler;
> >  }
> > +
> > +uint32_t guest_get_vcpuid(void)
> > +{
> > +     return csr_read(CSR_SSCRATCH);
> > +}
> > --
> > 2.34.1
> >

