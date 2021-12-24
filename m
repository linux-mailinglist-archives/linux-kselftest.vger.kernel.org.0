Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE347ECC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Dec 2021 08:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351902AbhLXHii (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Dec 2021 02:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351905AbhLXHie (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Dec 2021 02:38:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ABCC06175A
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Dec 2021 23:38:34 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v7so15960318wrv.12
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Dec 2021 23:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zehQu19sG8zPf6sTX7xbu4Pim5UWCx0QpvBAMXBdZsM=;
        b=Kc7Vq0z4QdQj5VZQWUJruEHr1vXWKQiy/GE0lgTeAHMJ4QcMlUr277gJ16+XTFn0sT
         bCYygv81STggBYOWNbKSVNP33Mf5gaXHpN6prAkGu49yN9Lc1a2AzJgDyFm+L/j6TY8J
         1TbfOhCJ5PL1CYsdhIUw1iNEc/OPIHjiNth0Rd3IIw0HtxMXHgeiVcCbcoedWKe3Uggb
         Y2P8QXdgyVAnBvghox7tN127eJJHfkYWyxMcYTGkjEHmnvin+ATSuiQ0GcZRWkcgnbPB
         UTMntwFq2Ch2n6jpZn4siAdn3phBB2Lpu8GsYvDbAQAPw6gIQzgS1cCMh0/dWS8B/KRf
         N2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zehQu19sG8zPf6sTX7xbu4Pim5UWCx0QpvBAMXBdZsM=;
        b=Rsk8OQ0WlsgNTem5R2+/mz8vjxxsJEFUGugFqEwFtVhj2Emot8mrdP6Z575+pDjG53
         /ohQ36u2Q0EtN1vkpS0XUfc2JrHbJBRLmJ1/ttmacdz5f0K3YuysKb1YoqEbGDWpeqon
         cwd5aJrhjwl9FO4GSIZ+lUx2OD8R8mOEheS0uG0PrKuufpkleqFLVU3vqFfFztWJsTYK
         d0IV20wANfPg8x5D+vvuCIWJxNT1UIoyjbA3IFZnz7Wefr6wPaZj7UnhWcWARFlasdob
         CQDZwHyaBf04DRyG7MsVYL12cNh6HJZVxsVjtG7AxfFQqNyMyLD6vdVT5tBz7XuujFv/
         md1w==
X-Gm-Message-State: AOAM5305hLZeathQBCqnYQm68TgMNkII881GwcuTKgxkcYzDs74Mylir
        WJhaRSHkHEoE5is9TS+j3/vKD84Bauy1tNCvr8/UjQ==
X-Google-Smtp-Source: ABdhPJyl+RLF9H+jUZa+5CGrWYy5DZy8pF9QpRofT4U/ZZybydpgrPxqo7pr1Asa3GRAZQ7HMCHf7E3gnAL6mmS40iw=
X-Received: by 2002:a5d:4d91:: with SMTP id b17mr3999415wru.214.1640331512744;
 Thu, 23 Dec 2021 23:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20211224073604.1085464-1-anup.patel@wdc.com>
In-Reply-To: <20211224073604.1085464-1-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 24 Dec 2021 13:08:21 +0530
Message-ID: <CAAhSdy2Gm96UVZhFMmbER+trrMgi-gFCpMvURR9Thb8NiNd88g@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] KVM RISC-V 64-bit selftests support
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi All,

On Fri, Dec 24, 2021 at 1:06 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> This series adds initial support for testing KVM RISC-V 64-bit using
> kernel selftests framework. The PATCH1 & PATCH2 of this series does
> some ground work in KVM RISC-V to implement RISC-V support in the KVM
> selftests whereas remaining patches does required changes in the KVM
> selftests.
>
> These patches can be found in riscv_kvm_selftests_v3 branch at:
> https://github.com/avpatel/linux.git

This is actually v3 series so please ignore the "PATCH v4" subject prefix.

Regards,
Anup

>
> Changes since v2:
>  - Rebased series on Linux-5.16-rc6
>  - Renamed kvm_riscv_stage2_gpa_size() to kvm_riscv_stage2_gpa_bits()
>    in PATCH2
>
> Changes since v1:
>  - Renamed kvm_sbi_ext_expevend_handler() to kvm_sbi_ext_forward_handler()
>    in PATCH1
>  - Renamed KVM_CAP_RISCV_VM_GPA_SIZE to KVM_CAP_VM_GPA_BITS in PATCH2
>    and PATCH4
>
> Anup Patel (4):
>   RISC-V: KVM: Forward SBI experimental and vendor extensions
>   RISC-V: KVM: Add VM capability to allow userspace get GPA bits
>   KVM: selftests: Add EXTRA_CFLAGS in top-level Makefile
>   KVM: selftests: Add initial support for RISC-V 64-bit
>
>  arch/riscv/include/asm/kvm_host.h             |   1 +
>  arch/riscv/kvm/mmu.c                          |   5 +
>  arch/riscv/kvm/vcpu_sbi.c                     |   4 +
>  arch/riscv/kvm/vcpu_sbi_base.c                |  27 ++
>  arch/riscv/kvm/vm.c                           |   3 +
>  include/uapi/linux/kvm.h                      |   1 +
>  tools/testing/selftests/kvm/Makefile          |  14 +-
>  .../testing/selftests/kvm/include/kvm_util.h  |  10 +
>  .../selftests/kvm/include/riscv/processor.h   | 135 +++++++
>  tools/testing/selftests/kvm/lib/guest_modes.c |  10 +
>  .../selftests/kvm/lib/riscv/processor.c       | 362 ++++++++++++++++++
>  tools/testing/selftests/kvm/lib/riscv/ucall.c |  87 +++++
>  12 files changed, 658 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/include/riscv/processor.h
>  create mode 100644 tools/testing/selftests/kvm/lib/riscv/processor.c
>  create mode 100644 tools/testing/selftests/kvm/lib/riscv/ucall.c
>
> --
> 2.25.1
>
