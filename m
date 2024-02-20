Return-Path: <linux-kselftest+bounces-5083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 629CD85CBB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25D2B21122
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA0F154448;
	Tue, 20 Feb 2024 23:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="kWPHlb/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8D154C06
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470237; cv=none; b=hAH3AckFFnsPAWlcTBu/pPgwIHs6UlXigsJGY+pMDCDFw6Fx16gSOkUmKOIXGnzJMRe8nR+JrM1gbV2SjvxpxvB50EPxlAWY0Uk1CujohEYFAaKUaoVk3Q/9iozAkOTuDip5jUeVUG6Tqv5VZTi4JSFqY3SX+RFdPlX1BBzKb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470237; c=relaxed/simple;
	bh=mL0tHNbpRNJfM7MBgHBurNu693ubcSIDZDSiHBuy7vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIL2vCvrDuHO6gpZOA5bBsSKd03gaAScXEozqJ+VPQlYzwW8T79EJIJcqthJHpafV2RLzam2pn54Rf5yCE2HfLa5WJE8l+aGqoqp/UPlUdTCCtfxoCHY0yQdg7EM9kUAgIQysNl/7wCM5Vv+99IvXeokbDXDi0eIeaZnEf16NB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=kWPHlb/E; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso5056257e87.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 15:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1708470232; x=1709075032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqH0ROPbbtIdqXSURYkySpHgNfveY4dFLQe0qUwTePc=;
        b=kWPHlb/EUWj0atJuzBGuzs30Q9oiJNiWq3MA1xEpr+clF0Tb9vztx06FxRSM97DpE5
         Mgh50M7eJNpqpxPzbQyp55nGKH/vdohuR6J16ekM4B43FYS3hE3OnoSJi7i7MeFSe8ys
         Ba2QDK/R/XOcyfl9nlQDatl5ysmYbjQORrP8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470232; x=1709075032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqH0ROPbbtIdqXSURYkySpHgNfveY4dFLQe0qUwTePc=;
        b=YaNv3jplli10UuCDmP5iTqdS+goJpOrV8HLd+X7vsv6dZY+wB2ElcA5a2O7bNyMAYO
         eQA7LiLba3ALVhgB+5Pu0WOMGyT+jHKlfEfIlejcxMgW6rc6+sUlp7ydWpTuTpRBEOnG
         0adoc1dLVB8k8vwbYGX4Bb10Xr2VxuCENCNhXEHlA+4LKQ4jq0jFvduHJdkHYRh2paGx
         wyc5tncic1ZUlar49yp6+uLfi9iFUG5B4Vhp0Coeycpm6hyoeDgHpF4D3Q1cB7feNRNe
         LqPlkiy2PDCz9VUNT0UWCuH/xciwVPG0BH2FYXb+eAcomKo8dT6rRubPbForVlm1ZgK9
         NzOg==
X-Forwarded-Encrypted: i=1; AJvYcCWqV0De4OfO9FFGSD2m26+jfSOvuwobwtnikuiO1UpraSlHwn1LRdru1iIgVQBvB3SQG9Mjlg1ENG1QxP70HT6827LGnNhgFwxKifQM7Z6D
X-Gm-Message-State: AOJu0YwjKAAqdITTgQNzYboBw48Mx5jMf8nDEnAseLrH0DAl1BmywJl4
	KjSYJ++00ke+Apsak5+joIaMpgc9rFCA5hNYQfQWLu1yEBGPk8+N+UtSLDhmKzEtbQWLD3zDyOg
	Z+7Jx/ciHeWsVdj7fd2KcYqcxMy75QNhfk/LN
X-Google-Smtp-Source: AGHT+IHvIMp97EquM1HGvlF+EshWPYeFqFX2gVhb+xvtJN9u9TgHl4t/ylyvXaDa1s3oTu4/8hBS3HdAlZdC/VROf90=
X-Received: by 2002:a05:6512:3a8b:b0:512:a964:f222 with SMTP id
 q11-20020a0565123a8b00b00512a964f222mr7687790lfu.21.1708470231958; Tue, 20
 Feb 2024 15:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705916069.git.haibo1.xu@intel.com> <68856b86a93a4188558e5d0ebac0dd6aac8e404c.1705916069.git.haibo1.xu@intel.com>
In-Reply-To: <68856b86a93a4188558e5d0ebac0dd6aac8e404c.1705916069.git.haibo1.xu@intel.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 20 Feb 2024 15:03:40 -0800
Message-ID: <CAOnJCULwRTSnrQkR2o1P53R=tJ3TAxX+y+XRBesW6OFEzgFv2g@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] KVM: riscv: selftests: Change vcpu_has_ext to a
 common function
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Samuel Holland <samuel@sholland.org>, Minda Chen <minda.chen@starfivetech.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Sean Christopherson <seanjc@google.com>, Peter Xu <peterx@redhat.com>, 
	Like Xu <likexu@tencent.com>, Vipin Sharma <vipinsh@google.com>, Thomas Huth <thuth@redhat.com>, 
	Aaron Lewis <aaronlewis@google.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 1:48=E2=80=AFAM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> Move vcpu_has_ext to the processor.c and rename it to __vcpu_has_ext
> so that other test cases can use it for vCPU extension check.
>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h |  2 ++
>  tools/testing/selftests/kvm/lib/riscv/processor.c     | 10 ++++++++++
>  tools/testing/selftests/kvm/riscv/get-reg-list.c      | 11 +----------
>  3 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index b68b1b731a34..bd27e1c67579 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint=
64_t idx,
>  #define RISCV_ISA_EXT_REG(idx) __kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
>                                              idx, KVM_REG_SIZE_ULONG)
>
> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
> +
>  struct ex_regs {
>         unsigned long ra;
>         unsigned long sp;
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index 39a1e9902dec..dad73ce18164 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -15,6 +15,16 @@
>
>  static vm_vaddr_t exception_handlers;
>
> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> +{
> +       unsigned long value =3D 0;
> +       int ret;
> +
> +       ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> +
> +       return !ret && !!value;
> +}
> +

Not sure what was the base patch on which this was rebased. The actual
commit in the queue branch looks different.

https://github.com/kvm-riscv/linux/commit/5563517cc2012e3326411b360c9924d3f=
2706c8d

Both seem to have the same bug though the tests fail now and require
the following fix.
The ext id should be uint64_t and we need to pass ext directly so that
SBI extension tests can also pass.


--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -48,7 +48,7 @@ static inline uint64_t __kvm_reg_id(uint64_t type,
uint64_t subtype,
KVM_REG_RISCV_SBI_SINGLE, \
idx, KVM_REG_SIZE_ULONG)

-bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
+bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);

struct ex_regs {
unsigned long ra;
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c
b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 282587cd4bbc..ec66d331a127 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -15,12 +15,12 @@

static vm_vaddr_t exception_handlers;

-bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
+bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext)
{
unsigned long value =3D 0;
int ret;

- ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
+ ret =3D __vcpu_get_reg(vcpu, ext, &value);

return !ret && !!value;
}

With the above the fix, Both SBI/ISA extension tests pass.
# ./get-reg-list
sbi-base: PASS
sbi-sta: PASS
sbi-pmu: PASS
sbi-dbcn: PASS
aia: PASS
fp_f: PASS
fp_d: PASS
1..0 # SKIP - h not available, skipping tests
smstateen: PASS
sscofpmf: PASS
sstc: PASS
1..0 # SKIP - svinval not available, skipping tests
1..0 # SKIP - svnapot not available, skipping tests
1..0 # SKIP - svpbmt not available, skipping tests
zba: PASS
zbb: PASS
zbc: PASS
1..0 # SKIP - zbkb not available, skipping tests
1..0 # SKIP - zbkc not available, skipping tests
1..0 # SKIP - zbkx not available, skipping tests
zbs: PASS
zfa: PASS
1..0 # SKIP - zfh not available, skipping tests
1..0 # SKIP - zfhmin not available, skipping tests
zicbom: PASS
zicboz: PASS
zicntr: PASS
1..0 # SKIP - zicond not available, skipping tests
zicsr: PASS
zifencei: PASS
zihintntl: PASS
zihintpause: PASS
zihpm: PASS


>  static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
>  {
>         return (v + vm->page_size) & ~(vm->page_size - 1);
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 25de4b8bc347..ed29ba45588c 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -75,15 +75,6 @@ bool check_reject_set(int err)
>         return err =3D=3D EINVAL;
>  }
>
> -static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> -{
> -       int ret;
> -       unsigned long value;
> -
> -       ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> -       return (ret) ? false : !!value;
> -}
> -
>  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>  {
>         unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] =3D { 0 };
> @@ -111,7 +102,7 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu=
_reg_list *c)
>                 __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(s->feature), 1);
>
>                 /* Double check whether the desired extension was enabled=
 */
> -               __TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
> +               __TEST_REQUIRE(__vcpu_has_ext(vcpu, s->feature),
>                                "%s not available, skipping tests\n", s->n=
ame);
>         }
>  }
> --
> 2.34.1
>


--=20
Regards,
Atish

