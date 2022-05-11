Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145D052351E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiEKOMo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 10:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244423AbiEKOMl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 10:12:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5376B014
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 07:12:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so1307275wme.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSGHn1F0BncOfTcKYhrKyIk0Nc9jRJLzLB3ecNcIZy4=;
        b=jW12ZwQnnCztcNwkigLKzLeyKxuLaypSdNh5RLphYPfrxCmn7JNKcAFQyhsDExQ715
         wJwjtZki4XfUaxqAYliizclV7JqcbjMJZH3O294nmneM4g9jdOzsk+Y7dwWTdMhJNmFr
         luTgFG70VKGd5rBsQuYZFTUjRfEcJ0/y7nPhAyW1ERcls1P51FqhBYBEYo8vF1V2mXNd
         8SRsu7Z8MrurgPTYpBt1TQjav+1DEREjLXAbJ0D6pm6Q+pDArYfJ2vpNCWaWnM02wpn/
         0SNSQoIcK+vj+GrpRIllI9L4jtsan3nrlQwi8mHwvPTLx1sPHdv/4t0fc5sKaLD/XZ2s
         9LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSGHn1F0BncOfTcKYhrKyIk0Nc9jRJLzLB3ecNcIZy4=;
        b=tIaMnlpeqaMAUhEw4bkT8BN2bKfFfVrpK0bjGMWleEb9UKEu7OL/r6ecjxcLMhlr4E
         FHgo3HU7Vt+kHBXU2QNS3fpU2ZCYzoVIwKgJv9QmEjiQT1KBBeqYoKkmKCf5OXdrsueW
         RTysBQ0YaRxp0c6GmICVfVYeD5t/MGmlQTu4NK0LlaGdXeAZztpMDnP0igxVPtBPpom3
         6GY+I3oMREWficXEdIo/Qr+5Sv3tujR5jqqZ3Xg+MFhE9Rx49Hcm8nIlTRdEiLP+KRgp
         q+jIx2Pj/BNgu4d2sTgrHkPGVpWE/W5gcMlE+M2jqai2LhnpUQVdrZpit8ba7923d99D
         nwBA==
X-Gm-Message-State: AOAM531z+e4GHoG/oHmPNMQksVTjWThjh8QmfpPBTF1bUZ2FKuED+jdL
        oipad/rMUi6Nt3DjGe+xeGatgHCWDgC30PU32nzYeg==
X-Google-Smtp-Source: ABdhPJx0EgilpXqO9xhDBZma49ZiZYBQW1CYQalIbu7JvciYQUGx6pSOeqXv1MQtlngcxiEp7hb87+4QPXM1UtmgtzY=
X-Received: by 2002:a05:600c:1d08:b0:394:54ee:c994 with SMTP id
 l8-20020a05600c1d0800b0039454eec994mr5072481wms.137.1652278359083; Wed, 11
 May 2022 07:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120621.36956-1-guozhengkui@vivo.com>
In-Reply-To: <20220511120621.36956-1-guozhengkui@vivo.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 11 May 2022 19:42:27 +0530
Message-ID: <CAAhSdy3Ynx-8DgDEE6huye2nA_21CV6cN=keopaCJOK2b00k5g@mail.gmail.com>
Subject: Re: [PATCH] selftests: kvm: replace ternary operator with min()
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        zhengkui_guo@outlook.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 11, 2022 at 5:38 PM Guo Zhengkui <guozhengkui@vivo.com> wrote:
>
> Fix the following coccicheck warnings:
>
> tools/testing/selftests/kvm/lib/s390x/ucall.c:25:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/x86_64/ucall.c:27:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/riscv/ucall.c:56:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/aarch64/ucall.c:82:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/aarch64/ucall.c:55:20-21: WARNING
> opportunity for min()
>
> min() is defined in tools/include/linux/kernel.h.
>
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  tools/testing/selftests/kvm/lib/aarch64/ucall.c | 4 ++--
>  tools/testing/selftests/kvm/lib/riscv/ucall.c   | 2 +-
>  tools/testing/selftests/kvm/lib/s390x/ucall.c   | 2 +-
>  tools/testing/selftests/kvm/lib/x86_64/ucall.c  | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> index e0b0164e9af8..00be3ef195ca 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> @@ -52,7 +52,7 @@ void ucall_init(struct kvm_vm *vm, void *arg)
>          * lower and won't match physical addresses.
>          */
>         bits = vm->va_bits - 1;
> -       bits = vm->pa_bits < bits ? vm->pa_bits : bits;
> +       bits = min(vm->pa_bits, bits);
>         end = 1ul << bits;
>         start = end * 5 / 8;
>         step = end / 16;
> @@ -79,7 +79,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>         va_list va;
>         int i;
>
> -       nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +       nargs = min(nargs, UCALL_MAX_ARGS);
>
>         va_start(va, nargs);
>         for (i = 0; i < nargs; ++i)
> diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
> index 9e42d8248fa6..34f16fe70ce8 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
> @@ -53,7 +53,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>         va_list va;
>         int i;
>
> -       nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +       nargs = min(nargs, UCALL_MAX_ARGS);
>
>         va_start(va, nargs);
>         for (i = 0; i < nargs; ++i)
> diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
> index 9d3b0f15249a..665267c1135d 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
> @@ -22,7 +22,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>         va_list va;
>         int i;
>
> -       nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +       nargs = min(nargs, UCALL_MAX_ARGS);
>
>         va_start(va, nargs);
>         for (i = 0; i < nargs; ++i)
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> index a3489973e290..2ea31a0ebe30 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> @@ -24,7 +24,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>         va_list va;
>         int i;
>
> -       nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +       nargs = min(nargs, UCALL_MAX_ARGS);
>
>         va_start(va, nargs);
>         for (i = 0; i < nargs; ++i)
> --
> 2.20.1
>
