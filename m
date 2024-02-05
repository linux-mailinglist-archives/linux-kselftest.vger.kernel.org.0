Return-Path: <linux-kselftest+bounces-4143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D1849B78
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E85B21E61
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59131CA86;
	Mon,  5 Feb 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U59F6zh9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26981C6B2;
	Mon,  5 Feb 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138642; cv=none; b=U5/aXwo5s3piWu8lG3SGCooFtPnrPTsIC0nZRVd1TD1eCGTH8z9wrMefothAikxsvJ1h5hNVPp2E3OPncczc/XarKA99HNiUs2pQVRjJwmT/QIHry5DNFxASixJDzgr1bcYWxLoRdSK3RaDAKi46FUjPP0eMeac2Z4UijLf685g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138642; c=relaxed/simple;
	bh=a7C8ciPQZp5QzEHWJtui24Jra/hcnLQehMJdzgp1ngY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnD4stc16BkjPA4uHMcbN3RZAh7UYBtlvP0J5c6RXGlOzK0aXE5zdW5PKtO7Bx6CByNg+gDb0VshwTNRfb8wxWW581ZIESRJDzTtwo9djiD0tF/hHT9qU1FdeaUVeOVwt0yVJBj0IpZzlBXsIqujekPs0IYKTIC1Hh6w0JrYgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U59F6zh9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5101cd91017so5691637e87.2;
        Mon, 05 Feb 2024 05:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707138639; x=1707743439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l52wGRJpdNZd5ZMPG8emXQNk5j5Wmg7cRfJ4UIcR334=;
        b=U59F6zh9rnAbKqQGinonryffgcH0D29aP4lQ23KcUDCHqGbiAQxyn6xRTOQPz1TRAh
         cDVidr9ZW1rc9H4ap/Mjbgx+H/69m5FnJltz1N72RU+Ismac1rX1OoSzNoR5iKpOnj02
         DD36XjwUHWpNGgepizcIv21l/HlC6qDm6+xCY3glE2m5yBKmtzybUP+JoGAJPlgMG6zC
         EO4dpSQryCfJ9gc/3hBjI2V4T6LVXqo7DOla9gnag0IjehII0SGqdvpp3qxWPX7uqrDj
         C3mdLKFjTsIr1EhB+MVBxGAbRdRVHC7DrsTZhHJqse9ii+dKerKcuCyrIz7hT5W29f4s
         BpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138639; x=1707743439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l52wGRJpdNZd5ZMPG8emXQNk5j5Wmg7cRfJ4UIcR334=;
        b=H74/gGycFwyHiKEb6T5myk55ZyMAWxSdUAQo/W5hzcHFXf6cXX/NheQeF2yxZIvj3o
         dxSTyccCzsovZk8FjxQU2AYZqco5mqqHhPeccBUlWLfjFEoNzgJ9+CA+hNmjTZPNbSu8
         mUh0AhFr+XjAMom6HlAWfvRklRwUj/Nr+sVkykAiGG5wbkz9j5iDTLBVZ/cNO/DH3iNX
         2pJMWQ4iB3laC1uRZFC64QGZMZk7KoOZrwh16dZYyyTBO7uHMda+yHBc1pGJa6SQqk99
         +p9LfW5TLUzE4BAcVbK7r7AkxKBaCn/Bp00J+bpI6Gf+qqyv8m4fHYPriwZ1hi7YU4yy
         B9lw==
X-Gm-Message-State: AOJu0Yyv5cRWzdz3E8lOvouNgZ8hl9IOdXK3oCaStzpJR9dT0WxbRJ2g
	2tX/JDOSbwlHfljpn7VqVPVx2+7SPUteEvqZKj7nPGQvEdFB7EHP+07ZuxThZCOeglLDG+2p1PE
	tTbdsc7hAwL3HShK1hHYDqNVoP4k=
X-Google-Smtp-Source: AGHT+IHcjgafryspZvflYvXmNwPr/1ZTRC4o5v0aRZqmLV0WFqjr47M7EyynLPGoweDD8l30req/4VrqIPpQvTK6l0U=
X-Received: by 2002:a05:6512:1150:b0:511:4e0c:bc3f with SMTP id
 m16-20020a056512115000b005114e0cbc3fmr2466365lfg.51.1707138638651; Mon, 05
 Feb 2024 05:10:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705916069.git.haibo1.xu@intel.com>
In-Reply-To: <cover.1705916069.git.haibo1.xu@intel.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Mon, 5 Feb 2024 21:10:26 +0800
Message-ID: <CAJve8onDbX44Ph6a-FdO2+p7QOQLah-7OyF+yUc06wud+SvmQQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] RISCV: Add kvm Sstc timer selftests
To: Haibo Xu <haibo1.xu@intel.com>
Cc: ajones@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	wchen <waylingii@gmail.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	Minda Chen <minda.chen@starfivetech.com>, Sean Christopherson <seanjc@google.com>, 
	Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>, 
	Vipin Sharma <vipinsh@google.com>, Thomas Huth <thuth@redhat.com>, 
	Aaron Lewis <aaronlewis@google.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc,

Could you help review the first 3 patches in this series?

Thanks,
Haibo

On Mon, Jan 22, 2024 at 5:45=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> The RISC-V arch_timer selftests is used to validate Sstc timer
> functionality in a guest, which sets up periodic timer interrupts
> and check the basic interrupt status upon its receipt.
>
> This KVM selftests was ported from aarch64 arch_timer and tested
> with Linux v6.7-rc8 on a Qemu riscv64 virt machine.
>
> ---
> Changed since v4:
>   * Rebased to Linux 6.7-rc8
>   * Added new patch(2/12) to clean up the data type in struct test_args
>   * Re-ordered patch(11/11) in v4 to patch(3/12)
>   * Changed the timer_err_margin_us type from int to uint32_t
>
> Haibo Xu (11):
>   KVM: arm64: selftests: Data type cleanup for arch_timer test
>   KVM: arm64: selftests: Enable tuning of error margin in arch_timer
>     test
>   KVM: arm64: selftests: Split arch_timer test code
>   KVM: selftests: Add CONFIG_64BIT definition for the build
>   tools: riscv: Add header file csr.h
>   tools: riscv: Add header file vdso/processor.h
>   KVM: riscv: selftests: Switch to use macro from csr.h
>   KVM: riscv: selftests: Add exception handling support
>   KVM: riscv: selftests: Add guest helper to get vcpu id
>   KVM: riscv: selftests: Change vcpu_has_ext to a common function
>   KVM: riscv: selftests: Add sstc timer test
>
> Paolo Bonzini (1):
>   selftests/kvm: Fix issues with $(SPLIT_TESTS)
>
>  tools/arch/riscv/include/asm/csr.h            | 541 ++++++++++++++++++
>  tools/arch/riscv/include/asm/vdso/processor.h |  32 ++
>  tools/testing/selftests/kvm/Makefile          |  27 +-
>  .../selftests/kvm/aarch64/arch_timer.c        | 295 +---------
>  tools/testing/selftests/kvm/arch_timer.c      | 259 +++++++++
>  .../selftests/kvm/include/aarch64/processor.h |   4 -
>  .../selftests/kvm/include/kvm_util_base.h     |   9 +
>  .../selftests/kvm/include/riscv/arch_timer.h  |  71 +++
>  .../selftests/kvm/include/riscv/processor.h   |  65 ++-
>  .../testing/selftests/kvm/include/test_util.h |   2 +
>  .../selftests/kvm/include/timer_test.h        |  45 ++
>  .../selftests/kvm/lib/riscv/handlers.S        | 101 ++++
>  .../selftests/kvm/lib/riscv/processor.c       |  87 +++
>  .../testing/selftests/kvm/riscv/arch_timer.c  | 111 ++++
>  .../selftests/kvm/riscv/get-reg-list.c        |  11 +-
>  15 files changed, 1353 insertions(+), 307 deletions(-)
>  create mode 100644 tools/arch/riscv/include/asm/csr.h
>  create mode 100644 tools/arch/riscv/include/asm/vdso/processor.h
>  create mode 100644 tools/testing/selftests/kvm/arch_timer.c
>  create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_timer.=
h
>  create mode 100644 tools/testing/selftests/kvm/include/timer_test.h
>  create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S
>  create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c
>
> --
> 2.34.1
>

