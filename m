Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D702874056F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 23:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjF0VHV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 17:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjF0VHV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 17:07:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A09199B
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 14:07:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-263036d54b9so1555869a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 14:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687900039; x=1690492039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sirRvSov4RuE6Flh2RoZE9PzcNIKlryblf5nf7NWajA=;
        b=I7oLfq4KpGkW6eVaiiOLhvIZWSmjmi1emjZklKf+bs+mVe2Y/rBp86DxEkDUzFbYWB
         rB7Hsc6H3S3zI90tVgW7XSWyAOOCNjhtXeLBd/OKrrfmZw4/bwADF7DALuDS2bBkHL6w
         PMi+U/jAUXGMHJ9Q4B/k3RGkKrHOtqOd/JwKAf4vWOJnJJcCj8lF8OyvIl1+dEjBbRLX
         y1aDrBXI8eG0gsholAKLTe+oQ38sMzmZb5SPwNzVWZqHrzRHkYmlM0tRBSxhV6oN/lzq
         cJHJRzCMmqHJATkHwsNmlxp/m+CWI38VwV/l3KBrgH6zRmfzvIlwn7ObbbdCrt9dIWQE
         pcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687900039; x=1690492039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sirRvSov4RuE6Flh2RoZE9PzcNIKlryblf5nf7NWajA=;
        b=aCQc3NRNj+Gz+hCTs/8KWee90vgFO1APpXNcfcZRX4UbP7YziQ1YA/1/Am9d7izLBu
         LpCwoSGkvKv8vzdmF0K64D4zMPPzB1ZiAMN94x2znE9rjLSOvoM0bcnTr3f1H9sm41dT
         Pty7toglCtGvkZAI0DxX5hGZpreaPsu9gSm9WNdGFuGHhlrvc32BrseNWzExNR5DRLJp
         ArwDMwYmmFxcl78Wc6y1WlIDdSrL2xf2r5tQ5XeLa8/bnXG2OXGS952NryPnd79AdZe3
         rmNd2aH3H13B13Jn7hp2ZGSOlTUXrqcWAQNxN/zjI+vK40sIE+SKriQivmFD9TW+lTop
         DTgw==
X-Gm-Message-State: AC+VfDxHDk0GVdppW/CmS18VLu0TosR4kAvwoqtcQ9kDJhss0x5kuZDr
        Ks5Hx3F/t7dTKOw2k7nub3pq2MYYL2LOKo+kM2GY2Q==
X-Google-Smtp-Source: ACHHUZ5Q51IS/tAaF6PaipIVHaMH4/ZWm7RCaYeKfDNSDheaQLI1oupE8xj/yAqDJWqRYjjyAgKlsbVIw4XiC8NsIKM=
X-Received: by 2002:a17:90b:1648:b0:262:d661:75e4 with SMTP id
 il8-20020a17090b164800b00262d66175e4mr9330028pjb.0.1687900039345; Tue, 27 Jun
 2023 14:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230626183611.40479-1-charlie@rivosinc.com> <20230627-eternity-mulberry-e1f4babf06a1@spud>
 <CA+7dDtKARX35pcgdKopuM6c8oj+TKLRhXcF0+d4MZE51V7Bifg@mail.gmail.com>
In-Reply-To: <CA+7dDtKARX35pcgdKopuM6c8oj+TKLRhXcF0+d4MZE51V7Bifg@mail.gmail.com>
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 27 Jun 2023 14:07:08 -0700
Message-ID: <CA+7dDtL=bNCSWOTet8NLqOaceaNKQaPaw-cKEFbW2gh6wFeb7g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Restrict address space for sv39,sv48,sv57
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        David Hildenbrand <david@redhat.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:EXEC & BINFMT API" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Atish Kumar Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I see it in patchwork here:
https://patchwork.kernel.org/project/linux-mm/cover/20230626183611.40479-1-=
charlie@rivosinc.com/.

On Tue, Jun 27, 2023 at 1:44=E2=80=AFPM Charles Jenkins <charlie@rivosinc.c=
om> wrote:
>
> I talked to Atish, he's not sure what's going on here either. I am going
> to add him to the CC list.
>
> On Tue, Jun 27, 2023 at 11:24=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
>
> > Hey Charlie,
> >
> > On Mon, Jun 26, 2023 at 11:36:02AM -0700, Charlie Jenkins wrote:
> > > Make sv39 the default address space for mmap as some applications
> > > currently depend on this assumption. The RISC-V specification enforce=
s
> > > that bits outside of the virtual address range are not used, so
> > > restricting the size of the default address space as such should be
> > > temporary. A hint address passed to mmap will cause the largest addre=
ss
> > > space that fits entirely into the hint to be used. If the hint is les=
s
> > > than or equal to 1<<38, a 39-bit address will be used. After an addre=
ss
> > > space is completely full, the next smallest address space will be use=
d.
> > >
> > > Documentation is also added to the RISC-V virtual memory section to
> > explain
> > > these changes.
> >
> > I don't know what went wrong here, but this never ended up in patchwork
> > for some reason, although it has appeared on lore. That seems to be via
> > the docs mailing list, rather than linux-riscv. Could you speak to Atis=
h
> > and see if he knows what went wrong?
> >
> > Cheers,
> > Conor.
> >
> > >
> > > Charlie Jenkins (2):
> > >   RISC-V: mm: Restrict address space for sv39,sv48,sv57
> > >   RISC-V: mm: Update documentation and include test
> > >
> > >  Documentation/riscv/vm-layout.rst             | 20 ++++++++
> > >  arch/riscv/include/asm/elf.h                  |  2 +-
> > >  arch/riscv/include/asm/pgtable.h              | 21 ++++++--
> > >  arch/riscv/include/asm/processor.h            | 41 +++++++++++++---
> > >  tools/testing/selftests/riscv/Makefile        |  2 +-
> > >  tools/testing/selftests/riscv/mm/Makefile     | 22 +++++++++
> > >  .../selftests/riscv/mm/testcases/mmap.c       | 49 +++++++++++++++++=
++
> > >  7 files changed, 144 insertions(+), 13 deletions(-)
> > >  create mode 100644 tools/testing/selftests/riscv/mm/Makefile
> > >  create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c
> > >
> > >
> > > base-commit: eef509789cecdce895020682192d32e8bac790e8
> > > --
> > > 2.34.1
> > >
> >
