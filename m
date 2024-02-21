Return-Path: <linux-kselftest+bounces-5164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A9885D8C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284111C22A58
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66269964;
	Wed, 21 Feb 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3PquIo0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBDB524CE;
	Wed, 21 Feb 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520914; cv=none; b=mk428AX0nMb4QISwOIjg0eVYu2Ajlc32bMCQic5vjmwxhEUuXIOzkm9gVHmWH6gX8KI8GVFp+WukZol68S7INQ6hUNr1XPjphJkCJ6/yJeuh+aA8+fTY/qtdw6pPmDVlvo0xGHSJSsiyVm6jLMhyrBDmYXQmpLB08VOyIAHp2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520914; c=relaxed/simple;
	bh=mWIx9PFeZocge748YA69ilYWO8vp7pIz8+RNbYpKzr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpNy2uQqVmFgBryzbGrgWFAKtUx/5AiUB6gg20rgBpVIp8C7dCFU2IJ/TtpxlmlxXr07bs6evthotrnzs0//JavtAuifV0VIV6ZQkDYFhWr1g/Lei/t238BO+XyTQXtvo48InCD3VeKWqzdQmMGU+j2j34ITGs41ZWd2D9a+qRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3PquIo0; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d208d0b282so88141541fa.0;
        Wed, 21 Feb 2024 05:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708520911; x=1709125711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxTdzzSE56mojm4+aLf5g+MB1IpHlx8dtkV73gFQqhM=;
        b=B3PquIo0Q/qex0tTOsV5KL5vQFZiSDluNeVhOaHw+h0VLO1j1lUoIuuwidAJMRByBQ
         j9z+BClpXGcWUgG65BQlMPXj+3DEKqkf3zYAIgztEiC5xO3B45B8/+Sm+Ey5N1ZtTH9Y
         Kk0QEMa/Yyhc4OUeZ0vqLnopCBoPTrI2V/QT5LSA4tbdSc8msZdelrSRJQaeDKPguAOQ
         uenoo9BJ4AaIaTmhCjw+H6iWR+8ZirH45pCu+0vV7UIjY0fjQFv5C9wSb6gFOSvjSuJz
         7Kq39+pNsZQhyEGH4ZmqAUJYXpf0rNvNjjobF5WYyIk6FoEgPqBqabBDRhOSZXwD/hBr
         4q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708520911; x=1709125711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxTdzzSE56mojm4+aLf5g+MB1IpHlx8dtkV73gFQqhM=;
        b=QdtkM8NeIPuM2DnHm2VXvrPCcWK8+btaDSX/z8FZIQnGvqBFQeSVCcPLFuBc/Em0Lx
         Tx05vkqYYX6iBIv1OCIw3BkBmWanVa37qxabqsIBKFOEpzWlVhvmd2PG4le3uqGNIWKI
         UPKvBWLJVyTbxeIk6b5lU2BqP0lGVXVILm840ZkpaxHzkBatvMe52L9ry3BxCp6xieeO
         lWlL8sDVS5UByd4P6hJuh5jF38yVyLxQRgHpp8F7bLq7cf1YnGorVWNLpazo3zKnzOzZ
         gbyx7eNhxVmk83P7eK36tQxcYuKetXweuPWsYPMyrmZwdfRrb1cB6HuxiVX+ILfhyRBf
         tOfg==
X-Forwarded-Encrypted: i=1; AJvYcCVJOf3XCQwTihTmCnW8qzdH4atdICo1d1r8626N46rw3V/fD1D2fNxBah0lsIyAiHMWJKfJEAtTxrtQu/F/z/6fZXkyMAVRg2ks/A3OYTqKIQa0LciVaebBhNgSkw/iBqTRt3PuYHBlaq13fqdSfFTFYmsXWSnRWSmVtqxN2Rc+wtbp
X-Gm-Message-State: AOJu0YzQLesugwbSIO+KiBfTqeqRDiN/c2guMzz23VpHS4fpQ3PPcUh1
	NF8g3DlT9sKQKoUUVYZsNCiZl0bl8aoUscLCbMTb1uKvMH1BHtL7v8JaGs2FKrEPpGLaRSOUx2f
	RHVvIwWbcBTU9d8+K0xuFmgrE/M0=
X-Google-Smtp-Source: AGHT+IEk4EjMAGYcW7Lzh75VAr5eflBXeC5jYHyhHnNqToNfa6pIH+DcVLj0qhM47mORzIqfli6g83qnltBwS3v9GvE=
X-Received: by 2002:a2e:6e08:0:b0:2d0:aa06:f496 with SMTP id
 j8-20020a2e6e08000000b002d0aa06f496mr12067305ljc.40.1708520910575; Wed, 21
 Feb 2024 05:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705916069.git.haibo1.xu@intel.com> <68856b86a93a4188558e5d0ebac0dd6aac8e404c.1705916069.git.haibo1.xu@intel.com>
 <CAOnJCULwRTSnrQkR2o1P53R=tJ3TAxX+y+XRBesW6OFEzgFv2g@mail.gmail.com>
 <CAJve8om2oOLg5-wKX7m7cBTgzwqiMcb35x=nDi1edY8evXjyMw@mail.gmail.com> <2c96c61a-2685-4cee-9cef-963ed833bf92@rivosinc.com>
In-Reply-To: <2c96c61a-2685-4cee-9cef-963ed833bf92@rivosinc.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Wed, 21 Feb 2024 21:08:19 +0800
Message-ID: <CAJve8omCZxsiP1jF0n5SBh0_U6q7Exj5A1ACFahWpdBoxohaMA@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] KVM: riscv: selftests: Change vcpu_has_ext to a
 common function
To: Atish Patra <atishp@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
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

On Wed, Feb 21, 2024 at 4:37=E2=80=AFPM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> On 2/20/24 18:13, Haibo Xu wrote:
> > On Wed, Feb 21, 2024 at 7:03=E2=80=AFAM Atish Patra <atishp@atishpatra.=
org> wrote:
> >>
> >> On Mon, Jan 22, 2024 at 1:48=E2=80=AFAM Haibo Xu <haibo1.xu@intel.com>=
 wrote:
> >>>
> >>> Move vcpu_has_ext to the processor.c and rename it to __vcpu_has_ext
> >>> so that other test cases can use it for vCPU extension check.
> >>>
> >>> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> >>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> >>> ---
> >>>   tools/testing/selftests/kvm/include/riscv/processor.h |  2 ++
> >>>   tools/testing/selftests/kvm/lib/riscv/processor.c     | 10 ++++++++=
++
> >>>   tools/testing/selftests/kvm/riscv/get-reg-list.c      | 11 +-------=
---
> >>>   3 files changed, 13 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/=
tools/testing/selftests/kvm/include/riscv/processor.h
> >>> index b68b1b731a34..bd27e1c67579 100644
> >>> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> >>> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> >>> @@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, =
uint64_t idx,
> >>>   #define RISCV_ISA_EXT_REG(idx) __kvm_reg_id(KVM_REG_RISCV_ISA_EXT, =
\
> >>>                                               idx, KVM_REG_SIZE_ULONG=
)
> >>>
> >>> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
> >>> +
> >>>   struct ex_regs {
> >>>          unsigned long ra;
> >>>          unsigned long sp;
> >>> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tool=
s/testing/selftests/kvm/lib/riscv/processor.c
> >>> index 39a1e9902dec..dad73ce18164 100644
> >>> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> >>> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> >>> @@ -15,6 +15,16 @@
> >>>
> >>>   static vm_vaddr_t exception_handlers;
> >>>
> >>> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> >>> +{
> >>> +       unsigned long value =3D 0;
> >>> +       int ret;
> >>> +
> >>> +       ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> >>> +
> >>> +       return !ret && !!value;
> >>> +}
> >>> +
> >>
> >> Not sure what was the base patch on which this was rebased. The actual
> >> commit in the queue branch looks different.
> >>
> >
> > This patch set was based on 6.7-rc8.
> >
> >> https://github.com/kvm-riscv/linux/commit/5563517cc2012e3326411b360c99=
24d3f2706c8d
> >>
> >> Both seem to have the same bug though the tests fail now and require
> >> the following fix.
> >> The ext id should be uint64_t and we need to pass ext directly so that
> >> SBI extension tests can also pass.
> >>
> >
> > It's weird that 6.7-rc8 has already included Andrew's change on the ISA=
 ext reg,
> > but this patch was not generated against his change.
> >
> > commit bdf6aa328f137e184b0fce607fd585354c3742f1
> > Author: Andrew Jones <ajones@ventanamicro.com>
> > Date:   Wed Dec 13 18:09:58 2023 +0100
> >
> >      RISC-V: KVM: selftests: Treat SBI ext regs like ISA ext regs
> >
> > Anyway, your changes were right. Please go ahead to include them when m=
erging.
> >
>
> I am not sure what happened. Probably, a merge conflict issue.
>
> I just realized I forgot to copy paste another fix in arch timer
>
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
>          int nr_vcpus =3D test_args.nr_vcpus;
>
>          vm =3D vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> -       __TEST_REQUIRE(__vcpu_has_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
> +       __TEST_REQUIRE(__vcpu_has_ext(vcpus[0],
> RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSTC)),
>

Right Fix!
Please let me know if I need to rebase this patch series on your tree
and resent it.

Thanks,
Haibo

