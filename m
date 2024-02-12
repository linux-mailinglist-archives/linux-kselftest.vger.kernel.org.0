Return-Path: <linux-kselftest+bounces-4509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD4E85137E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 13:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597081C2135B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75039FCB;
	Mon, 12 Feb 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="vHN6aOep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED0239AF6
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740652; cv=none; b=fF3KP0GxMfvfFyDLgjWd6k2WwsENegjI9ukrLrrNWgYdZey2SByqzHLO7ac2Eq4POFTDlHFZqK38jIq0yhqvK0vlGNCwi++HPtu19qbP7dao3O+9bCIvpbmpTa2b/Gg+pbpQBktU0QMNVmFt1V27mlbynqE4xmkyYqKRGOCD5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740652; c=relaxed/simple;
	bh=enGcxkA/imgb+5ygnxbIY0QQCaD86a1hixHI14ZUv1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyVR6/qAEZepEhLlPZbtb0wE+Nd4Z1FDvl4JelkGGHD/aNAsGL0/aldxWFTHh05syytV22Z5/Uosp17iaG8/YO6E4Fx6PxjGszpHop4kEXMCuNkTbfGnld9ij4IPJxYZ32JkLi0ZsjZqSyEsox0GPulwpVFFMqI8+dol+yH0a+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=vHN6aOep; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-363b5bcec8fso12228355ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 04:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1707740649; x=1708345449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CQJAbVN1hEJxIfRK6BeBiBHbVNEAmKsPHC3r9j+pPA=;
        b=vHN6aOepVj8Pl16NHWtT4f4BrkJD/rHERubcAQ41gB5mXJlewVrqesGHuusI/nEwrt
         5sniX13mRgfmWYpY/PaFh5xSqv3Fq41IxpFx6LyvXzPF7xN26+9NkqfllRfH91C4DiDt
         hNpk2I7Kz/HcKvSOyj6NPN9CfY6+r01Zx8lancN5OcAOvRHjq5ZPF/2VR8mOwTPXCcWN
         EWOVK5LtPKyGhrGdMv3es5y0x7tlFX9kcBlCS0pHyTjISLJafDxVoe9X+qFFJbpOSuZ0
         iYXNLcMt+G3ROa5cougn4efvJNsPQDL6EIQ3cTQO1vVv9z7+fgzCscrWcZcy+SbAfi0x
         mobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707740649; x=1708345449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CQJAbVN1hEJxIfRK6BeBiBHbVNEAmKsPHC3r9j+pPA=;
        b=uZZHpfTBcCYlmn13h5tVdlUoYVgorjXntGjF3P/BqalOKrFLfC98qag98RPy13XAC1
         lAcHWTR+V2e829ipC0ggGaf1xytO/ld/10cjj93VPgiYNEUybFd3/0NxDhUr5LdY96JM
         IJfzV5DS0zka+Cx4IOyD4Z+AuAd5OgralAn+rLUPVvK6VxN56mM4bK2ljxlmcg4OWFfk
         scscthFPNosDkHNlBc2ZXfPhe4QWJnFJCu3SIMTIVf0PCpTqRWjZlAOoP8c2lEDp6Gd6
         dvGXOczNPEEs9o2MEpRvZfpvwCNCTQWAJVSFSTu0igsuPAa0O6FmIGeMMZ72aYq0Ed5B
         Lz8w==
X-Gm-Message-State: AOJu0Yw9tg/fDbaciS/OAKZ4uayN+Uh8Iru/qHghDiIpDsfMew2vCp4S
	4dyrTRYIFYTS58LVrn1DtvLnWDZla8gtJOxwKaQ4MSjrICcmnFhkge21bJGkGbrJ0AW2RJDhSbD
	bysBmmJ6PbcUx0QGlTqOGB0PtL5owKmNj8w9DjQ==
X-Google-Smtp-Source: AGHT+IGzhXfq5zT3FYgC1LPkY3wsC1WD62YVWVgEP5W8s001037XANdQn59nNXrbCGSEhsi8pEoYiewroYfMiW87JoM=
X-Received: by 2002:a92:caca:0:b0:363:e7ff:f378 with SMTP id
 m10-20020a92caca000000b00363e7fff378mr8506844ilq.28.1707740649498; Mon, 12
 Feb 2024 04:24:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705916069.git.haibo1.xu@intel.com>
In-Reply-To: <cover.1705916069.git.haibo1.xu@intel.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 12 Feb 2024 17:53:58 +0530
Message-ID: <CAAhSdy2wFzk0h5MiM5y9Fij0HyWake=7vNuV1MExUxkEtMWShw@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] RISCV: Add kvm Sstc timer selftests
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atishp@atishpatra.org>, 
	Guo Ren <guoren@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, wchen <waylingii@gmail.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Minda Chen <minda.chen@starfivetech.com>, 
	Sean Christopherson <seanjc@google.com>, Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>, 
	Vipin Sharma <vipinsh@google.com>, Thomas Huth <thuth@redhat.com>, 
	Aaron Lewis <aaronlewis@google.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 3:15=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
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

Rebased on Linux-6.8-rc4 and queued this series for Linux-6.9

Thanks,
Anup

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

