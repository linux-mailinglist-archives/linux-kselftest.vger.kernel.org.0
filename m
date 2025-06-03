Return-Path: <linux-kselftest+bounces-34247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51603ACCE5A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048D6170F7D
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 20:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4982221F11;
	Tue,  3 Jun 2025 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htkpEJRe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9519E975
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983717; cv=none; b=IbTBuYUocnNV2oG+y/XM+Zpyr9ziT1LU7xPwyuCl3sLrzFv244WZVMa6Iah8HmZSHVD0n89nVkaRlbCTU/QP82HVXJPEUBBZPZ0ioHD7x8EFf54JYH918WVjp6p1dgl6MdWUMM3WyfiXUJhv8wEuPIs1/s6FArdTeYXHQ95957g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983717; c=relaxed/simple;
	bh=J4Gy+MHq+K8H73A1pdlJXVmj/G1iM1mYhcwzLpTgyXE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=gCXTFJ+V3dnMYzxmLjm77Wa9AvJJjCogdES1UIOMcfXoA707WWIZOJ23BXr3AMqgKRvonh5VgKP27FKrU1J3KfXblDfhHwRHxJu3Vxn1xLiC7oLrYwaragVaaRoUxoNu7j4lvHtz2BIXRRQNzSziyysoXuBIpFPaKZtmiLt0M+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htkpEJRe; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddb4dcebfaso32483635ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748983714; x=1749588514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xqk6Ae+AoodqjhacwdxkSu1Yb8TCbPjMAbFosVWhG+Q=;
        b=htkpEJReoFE7VEGCg7XYcSAyYDSYdHAaZfuWAqSiunI6KT4v39wfnQ66LVoAwxMqkg
         ks414emV9EuyBpH4k/iXTQE6kD6NjOva1Zi4bLFEalMOEObfhaF15ZDOltzD2dRf/cPU
         bHazM9PmuQNlZ2O/CzogpguPMep0FqfmumSuUo9TlVaIHHvULDT89MTRGHNmPtzpl+Mu
         L9hS3hsnNkO7dUAaEfuCi9wRysW7N0/ET3B7DslMHnx0n+A3KGXlu1goLjVN8CsOqoH+
         4tBBIgV+I0J4BCBrS7F0xGudu3lX75skESdbZ6MFDF5whLEQrGkTZoIfkXLYJTG3usDC
         Ju+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983714; x=1749588514;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqk6Ae+AoodqjhacwdxkSu1Yb8TCbPjMAbFosVWhG+Q=;
        b=Laz46OCg7h20JlBpQBZznPqRpG8GP7N2AOg4i+YGvJh5c5LCk4TFrK/eeiv4Y8Axnz
         pxA15rbn0Vr4W0qe1bC0HSI5pqTKCoARFw0vd2NQ1yoUfz994ass9VrGdPTFbDb2vS0w
         8wrK9eA/l3ax3Uf1UeefbAi+NNoUZvvMmyxeyZBVD7o4avK57pXl/fG9Y6QGnSV+HH+q
         N7F1pQ2l7+gppWiFNeGHdVU4EU6TleDzMIyPNed7LbcKzRnueJxYSNGLIcKa9P0XcOLd
         weE5B+lQkyGgWTRhavab4cF5qO8CiCQpwOJX5czgtBmkAu9jYxPIcvOIY7xs5GLj0gNs
         gpAA==
X-Forwarded-Encrypted: i=1; AJvYcCVgTlTZwXT2XvI9xaOZv1ADEei0Cg9YVQxZEXHZpj7OqEJv4GYg3j3UFyJOZDpGFg26GMSZ39H0dT+5XYTXkak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjwbxi882BQvYD7bckrU29g9EF3KmNN35aY1SO3utY1kHgslIW
	aCMHRXgdgKatRQAq9GZCdVbzyZ6UUR8/LWiAmsXkT2Mdpq7ZXES7O6Lpj2H9sOeItyHSwjUR16A
	4Uo33UCY+v26OF7JMVHyF/SOKUA==
X-Google-Smtp-Source: AGHT+IH++9MIP5okdS2+/trmd8V6fLN6bmZyUPwJNgnr4Lv2JKgei2gsZjCTP6Pc/H1zIhLn0nH3fYC4XYFcP1PDwQ==
X-Received: from ilbbz4.prod.google.com ([2002:a05:6e02:2684:b0:3dd:b9c7:8f2f])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:260c:b0:3dd:89b0:8e1b with SMTP id e9e14a558f8ab-3ddbed8aa48mr5481105ab.15.1748983713821;
 Tue, 03 Jun 2025 13:48:33 -0700 (PDT)
Date: Tue, 03 Jun 2025 20:48:32 +0000
In-Reply-To: <aD4a1T7ZmBLNunxi@google.com> (message from Sean Christopherson
 on Mon, 2 Jun 2025 14:42:45 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnta56o361r.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 04/17] KVM: arm64: Cleanup PMU includes
From: Colton Lewis <coltonlewis@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	shuah@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Jun 02, 2025, Colton Lewis wrote:
>> * Delete kvm/arm_pmu.h. These functions are mostly internal to KVM and
>>    should go in asm/kvm_host.h.

> Ha!  I'm a hair too late, as usual.  I _just_ resurrected a patch[*] to  
> move and
> rename all of the <kvm/arm_xxx.h> headers to <asm/kvm_xxx.h>.  If only I  
> had
> posted on Friday when they were ready :-)

Great minds think alike :) (In this case the other one was Marc)

> It's a relatively small series (mostly arm64 code movement), but it does  
> touch
> all architectures due to giving the same treatment to kvm/iodev.h (and  
> purging
> include/kvm entirely).

> Any preference/thoughts on how to proceed?  My stuff obviously isn't  
> urgent since
> I sat on the patches for almost two years.  On the other hand, the almost  
> pure
> code movement would be a nice precursor to this patch, e.g. move and  
> rename to
> asm/kvm_pmu.h before extracting chunks of code into asm/kvm_host.h.

Letting the rename go first is fine and won't inconveneince me. I'm
expecting this series to take a while to be accepted and Oliver told me
I'll probably need a reroll to make my context switching lazy. Thanks
for asking.

> [*]  
> https://lore.kernel.org/all/20230916003118.2540661-15-seanjc@google.com


> Diff stats for context:
> ---
> Anish Ghulati (1):
>    KVM: arm64: Move arm_{psci,hypercalls}.h to an internal KVM path

> Sean Christopherson (7):
>    KVM: arm64: Include KVM headers to get forward declarations
>    KVM: arm64: Move ARM specific headers in include/kvm to arch directory
>    KVM: Move include/kvm/iodev.h to include/linux as kvm_iodev.h
>    KVM: MIPS: Stop adding virt/kvm to the arch include path
>    KVM: PPC: Stop adding virt/kvm to the arch include path
>    KVM: s390: Stop adding virt/kvm to the arch include path
>    KVM: Standardize include paths across all architectures

>   MAINTAINERS                                                | 1 -
>   .../arm64/include/asm/kvm_arch_timer.h                     | 2 ++
>   arch/arm64/include/asm/kvm_host.h                          | 7 +++----
>   include/kvm/arm_pmu.h => arch/arm64/include/asm/kvm_pmu.h  | 2 ++
>   .../kvm/arm_vgic.h => arch/arm64/include/asm/kvm_vgic.h    | 2 +-
>   arch/arm64/kvm/Makefile                                    | 2 --
>   arch/arm64/kvm/arch_timer.c                                | 5 ++---
>   arch/arm64/kvm/arm.c                                       | 6 +++---
>   {include => arch/arm64}/kvm/arm_hypercalls.h               | 0
>   {include => arch/arm64}/kvm/arm_psci.h                     | 0
>   arch/arm64/kvm/guest.c                                     | 2 +-
>   arch/arm64/kvm/handle_exit.c                               | 2 +-
>   arch/arm64/kvm/hyp/Makefile                                | 6 +++---
>   arch/arm64/kvm/hyp/include/hyp/switch.h                    | 4 ++--
>   arch/arm64/kvm/hyp/nvhe/switch.c                           | 4 ++--
>   arch/arm64/kvm/hyp/vhe/switch.c                            | 4 ++--
>   arch/arm64/kvm/hypercalls.c                                | 4 ++--
>   arch/arm64/kvm/pmu-emul.c                                  | 4 ++--
>   arch/arm64/kvm/psci.c                                      | 4 ++--
>   arch/arm64/kvm/pvtime.c                                    | 2 +-
>   arch/arm64/kvm/reset.c                                     | 3 +--
>   arch/arm64/kvm/trace_arm.h                                 | 2 +-
>   arch/arm64/kvm/trng.c                                      | 2 +-
>   arch/arm64/kvm/vgic/vgic-debug.c                           | 2 +-
>   arch/arm64/kvm/vgic/vgic-init.c                            | 2 +-
>   arch/arm64/kvm/vgic/vgic-irqfd.c                           | 2 +-
>   arch/arm64/kvm/vgic/vgic-kvm-device.c                      | 2 +-
>   arch/arm64/kvm/vgic/vgic-mmio-v2.c                         | 4 ++--
>   arch/arm64/kvm/vgic/vgic-mmio-v3.c                         | 4 ++--
>   arch/arm64/kvm/vgic/vgic-mmio.c                            | 6 +++---
>   arch/arm64/kvm/vgic/vgic-v2.c                              | 2 +-
>   arch/arm64/kvm/vgic/vgic-v3-nested.c                       | 3 +--
>   arch/arm64/kvm/vgic/vgic-v3.c                              | 2 +-
>   arch/loongarch/include/asm/kvm_eiointc.h                   | 2 +-
>   arch/loongarch/include/asm/kvm_ipi.h                       | 2 +-
>   arch/loongarch/include/asm/kvm_pch_pic.h                   | 2 +-
>   arch/mips/include/asm/kvm_host.h                           | 3 +--
>   arch/mips/kvm/Makefile                                     | 2 --
>   arch/powerpc/kvm/Makefile                                  | 2 --
>   arch/powerpc/kvm/mpic.c                                    | 2 +-
>   arch/riscv/kvm/Makefile                                    | 2 --
>   arch/riscv/kvm/aia_aplic.c                                 | 2 +-
>   arch/riscv/kvm/aia_imsic.c                                 | 2 +-
>   arch/s390/kvm/Makefile                                     | 2 --
>   arch/x86/kvm/Makefile                                      | 1 -
>   arch/x86/kvm/i8254.h                                       | 2 +-
>   arch/x86/kvm/ioapic.h                                      | 2 +-
>   arch/x86/kvm/irq.h                                         | 2 +-
>   arch/x86/kvm/lapic.h                                       | 2 +-
>   include/{kvm/iodev.h => linux/kvm_iodev.h}                 | 0
>   virt/kvm/Makefile.kvm                                      | 2 ++
>   virt/kvm/coalesced_mmio.c                                  | 3 +--
>   virt/kvm/eventfd.c                                         | 2 +-
>   virt/kvm/kvm_main.c                                        | 3 +--
>   54 files changed, 64 insertions(+), 77 deletions(-)
>   rename include/kvm/arm_arch_timer.h =>  
> arch/arm64/include/asm/kvm_arch_timer.h (98%)
>   rename include/kvm/arm_pmu.h => arch/arm64/include/asm/kvm_pmu.h (99%)
>   rename include/kvm/arm_vgic.h => arch/arm64/include/asm/kvm_vgic.h (99%)
>   rename {include => arch/arm64}/kvm/arm_hypercalls.h (100%)
>   rename {include => arch/arm64}/kvm/arm_psci.h (100%)
>   rename include/{kvm/iodev.h => linux/kvm_iodev.h} (100%)


> base-commit: 45eb29140e68ffe8e93a5471006858a018480a45
> --

