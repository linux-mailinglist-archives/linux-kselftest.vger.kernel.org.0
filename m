Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBA55196E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 07:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiEDF3J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 01:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiEDF3J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 01:29:09 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E9A55B3
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 22:25:33 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f83983782fso4190357b3.6
        for <linux-kselftest@vger.kernel.org>; Tue, 03 May 2022 22:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbvOAJT4uwe4uxZaljDW/4uvXBb7LRgdeX0Ux1iDca0=;
        b=m5Mcn0MAiBMq+DbL7oOoSr5m0g1uVNEK1A5YSRXexDLN+5XHp2/wFHIpJNDYQODvIF
         zaBly7ujlJgnNrJ9ypssJz+woV4UyKKn2A68+/xs2JCjQ2CbcYQRuyKzDoubBnEBsZ6+
         xar7udvnnZ+WjxZAUuwQ6w091tCaXg+oXEWk33vdJ2h1sxhb329r3UdB81DKJoddUxkG
         AutMMOpaI/IJBnyw1ieTI+fNyMNfVXRz2mdhw81f1OIK+/8vYhSo/84lHyCkNwzPHCIe
         RR7iHNaYBqpmr+R35M4QMStgrfaqDrkDfBGuWj6j1Zyd+QCQ8YDIbkuUWmJ9M/Q/jFoC
         CI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbvOAJT4uwe4uxZaljDW/4uvXBb7LRgdeX0Ux1iDca0=;
        b=GTIKdVAJZutZ5AUN9mCttqvTLytu56Vz/UEblSiv1dw8eHwnZTYSwX5Pd7xZJk6tST
         f91O4kXkXbk3vYjsAE84dvB74Aas572XT4Iiy52nYW86RpZ2yme17cIfgtXIaAOg/BQB
         12V+pTRit4I14LKwC/AZJQ7n2d8zPUNXEh9YRm030uGoL4bgNFYeWOk65Vt4DHZ9YyU1
         hshY48caOuZWkNWgV6O1o7KiXtoiAr60YJ7GUEj+q5JjDay8cEVv09gJ1lqiKoRd+o6v
         Jx+6YtwiflTFVnPuTTNNslCv8hbAcS9FAYNLigWMLcExAPMx2pjCuCZh6Kir4RPYUAvO
         Bc9g==
X-Gm-Message-State: AOAM53095oN6/S6RY3z6IfcoAM9CiRy5zPJYNNW/wa1x3+fNpVfFTlcU
        81HT6I0EF76ymQrlLFdZ3PDQBUn1wTsbLeQ0JHDiJw==
X-Google-Smtp-Source: ABdhPJwppChYPQrME4HisQzIkXdWnQOqvrfW7WftTEQuk37QN96vTzAdDbrEIAq/2VrukEj/2ny9oZ6sRCj0w7Ym0K8=
X-Received: by 2002:a81:23ce:0:b0:2f8:ad74:1185 with SMTP id
 j197-20020a8123ce000000b002f8ad741185mr18078136ywj.120.1651641932339; Tue, 03
 May 2022 22:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220419112247.711548-1-broonie@kernel.org> <YnGrbEt3oBBTly7u@qian>
 <YnHANG5cM0CS9ffm@sirena.org.uk>
In-Reply-To: <YnHANG5cM0CS9ffm@sirena.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 4 May 2022 10:55:21 +0530
Message-ID: <CA+G9fYsRZKFXeiOQ0dp_-vL-3JimC5u75djvc1Ussv1cLsiUbA@mail.gmail.com>
Subject: Re: [PATCH v14 00/39] arm64/sme: Initial support for the Scalable
 Matrix Extension
To:     Mark Brown <broonie@kernel.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, Marc Zyngier <maz@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Will Deacon <will@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Luca Salabrino <luca.scalabrino@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 4 May 2022 at 05:22, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 03, 2022 at 06:23:40PM -0400, Qian Cai wrote:
> > On Tue, Apr 19, 2022 at 12:22:08PM +0100, Mark Brown wrote:
> > > This series provides initial support for the ARMv9 Scalable Matrix
> > > Extension (SME).  SME takes the approach used for vectors in SVE and
> > > extends this to provide architectural support for matrix operations.  A
> > > more detailed overview can be found in [1].
> >
> > Set CONFIG_ARM64_SME=n fixed a warning while running libhugetlbfs tests.
> >
> >         /*
> >          * There are several places where we assume that the order value is sane
> >          * so bail out early if the request is out of bound.
> >          */
> >         if (unlikely(order >= MAX_ORDER)) {
> >                 WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
> >                 return NULL;
> >         }
>
> Ugh, right.  These variable sized register sets really don't map
> entirely cleanly onto the ptrace interface but now you point it
> out what the code has there is going to give a rather larger
> number than is sensible.  Not fully checked but does the below
> fix things?
>
> Thanks for your testing with this stuff, it's been really
> helpful.
>
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 47d8a7472171..08c1cb43cf33 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -1447,8 +1447,8 @@ static const struct user_regset aarch64_regsets[] = {
>         },
>         [REGSET_ZA] = { /* SME ZA */
>                 .core_note_type = NT_ARM_ZA,
> -               .n = DIV_ROUND_UP(ZA_PT_ZA_SIZE(SVE_VQ_MAX), SVE_VQ_BYTES),
> -               .size = SVE_VQ_BYTES,
> +               .n = 1,
> +               .size = ZA_PT_SIZE(SVE_VQ_MAX),
>                 .align = SVE_VQ_BYTES,
>                 .regset_get = za_get,
>                 .set = za_set,

I have tested this patch but the warning did not fix.
Testing libhugetlbfs on qemu_arm64 triggering this warning.

Kernel warning:
-------------------
[   13.266791] kauditd_printk_skb: 1 callbacks suppressed
[   13.266794] audit: type=1701 audit(1651640394.652:25):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=463
comm=\"brk_near_huge\"
exe=\"/usr/lib/libhugetlbfs/tests/obj64/brk_near_huge\" sig=6 res=1
[   13.267376] ------------[ cut here ]------------
[   13.267378] WARNING: CPU: 2 PID: 463 at mm/page_alloc.c:5368
__alloc_pages+0x624/0xd50
[   13.269956] Modules linked in: crct10dif_ce rfkill fuse
[   13.270357] CPU: 2 PID: 463 Comm: brk_near_huge Not tainted
5.18.0-rc4-next-20220429 #1
[   13.270964] Hardware name: linux,dummy-virt (DT)
[   13.271315] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   13.271841] pc : __alloc_pages+0x624/0xd50
[   13.272157] lr : alloc_pages+0xb8/0x170
[   13.272451] sp : ffff800008873630
[   13.272704] x29: ffff800008873630 x28: 000000000000000f x27: ffffb53cfad91650
[   13.273248] x26: ffff0000c57f2c00 x25: ffff800008873c58 x24: 000000000000000f
[   13.273788] x23: 0000000000000dc0 x22: 0000000000000000 x21: 000000000000000f
[   13.274327] x20: ffffb53cfc8189a0 x19: 0000000000040dc0 x18: 0000000000000000
[   13.274868] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   13.275406] x14: 0000000000000000 x13: 0000000000000000 x12: ffff0000ff7f5b58
[   13.275945] x11: 0000000000000068 x10: ffffb53cfb77d000 x9 : ffffb53cf9d30e78
[   13.276485] x8 : fffffc00038e0001 x7 : dead000000000100 x6 : 0000000000000001
[   13.277021] x5 : 0000000000000000 x4 : ffff0000c55fe180 x3 : 0000000000000000
[   13.277559] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000040dc0
[   13.278096] Call trace:
[   13.278285]  __alloc_pages+0x624/0xd50
[   13.278576]  alloc_pages+0xb8/0x170
[   13.278844]  kmalloc_order+0x40/0x100
[   13.279126]  kmalloc_order_trace+0x38/0x130
[   13.279445]  __kmalloc+0x37c/0x3e0
[   13.279707]  __regset_get+0xa0/0x104
[   13.279983]  regset_get_alloc+0x20/0x2c
[   13.280277]  elf_core_dump+0x3a8/0xd10
[   13.280567]  do_coredump+0xe50/0x138c
[   13.280850]  get_signal+0x860/0x920
[   13.281119]  do_notify_resume+0x184/0x1480
[   13.281428]  el0_svc+0xa8/0xc0
[   13.281666]  el0t_64_sync_handler+0xbc/0x140
[   13.281992]  el0t_64_sync+0x18c/0x190
[   13.282273] ---[ end trace 0000000000000000 ]---

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

url:
https://lkft.validation.linaro.org/scheduler/job/4983793#L831

Build link: https://builds.tuxbuild.com/28gVhSoYA4NRerhwD1gkY4QdHLt/

--
Linaro LKFT
https://lkft.linaro.org
