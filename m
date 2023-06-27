Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C7D740511
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 22:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjF0UoY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 16:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjF0UoX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 16:44:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0781BC8
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 13:44:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66767d628e2so2735598b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 13:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687898661; x=1690490661;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U6H5cDFr1dyx2lCsy2AJPNTJs3FzaFbYaxaijcdCN6c=;
        b=HnUnP0vwso/w9ndQv/pgq0gNpsaF7bZzRGOM3mn/GAVklFx34b8NPAaL7sUyHk6qP8
         TscFXAhsCRRRCjMXxq4JtP67y8CIDf/nsGEfyRTfL68tyxoXM5JjeRZVQSpJevIrjXzQ
         VJ5zf1a1qZPrc1Esj+4IolnS3L3jzjFcCBLA2MGTe3rDQO7WWm3M//XqBvXsxXVYm6ng
         Hg8/UR1Zn1BwBmpfGVWa5CTfCYGbL2453fVUHPbZYlZP1pRzbhOSf1PmEc09JniHtujp
         WQEXzfnygKQV8nLVvSI5/36pi8KJScrN3YK3lkUXteD1d7obO6u8OR5PXCFiH0IxPR90
         ZMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687898661; x=1690490661;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6H5cDFr1dyx2lCsy2AJPNTJs3FzaFbYaxaijcdCN6c=;
        b=ZrZJWIYdWOgMELbqokqe1jx+L6cFlnxYVOC2jsMkZKFoXiLBsbxrIA5qRkbmslaknG
         Kuwza+iKIEPzsb/JrpUaP7AFCw0LF6D3NYxC4yoHqnNlX3WehQGY4tPtcp0ix21rek0h
         rTIAFfXWdh92vvtm08cf5PcrMjoOVr9/XLIR5E3QUfx0on3H4gXDmzVodOl5oWBvIIg6
         IBddo+OSPFTqxNZYgoNMWprLHt3pw0WyjDOiKcuTAwGYf/Nu+zby7UERXB3N6sDjwMP7
         QYQ+6A8iQT53GZGP2ihhj3/9P3PXJok2RG1emswkTs05rqv9UcXP9FvracpwW3Rxm1Ac
         vlaQ==
X-Gm-Message-State: AC+VfDzeMpqZi5vkc6hZDgGHkUJyRbGFbN+ePvv1tTbpmG9ImB5A0fdg
        bH6si8Tjuta29GueJvYWHZBN6Q==
X-Google-Smtp-Source: ACHHUZ6yr8dixKzuikEVp36MwS6CX2PzvlrNDk/YH/WpQYExSF1m6bblfriT2qtqDBzbeyosRgtKBA==
X-Received: by 2002:a05:6a00:190a:b0:66c:9e97:aece with SMTP id y10-20020a056a00190a00b0066c9e97aecemr7488833pfi.10.1687898661261;
        Tue, 27 Jun 2023 13:44:21 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id g6-20020aa78746000000b00666b6dc10desm5238976pfo.56.2023.06.27.13.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 13:44:20 -0700 (PDT)
Date:   Tue, 27 Jun 2023 13:44:18 -0700
From:   Charles Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
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
Subject: Re: [PATCH 0/2] Restrict address space for sv39,sv48,sv57
Message-ID: <CA+7dDtKARX35pcgdKopuM6c8oj+TKLRhXcF0+d4MZE51V7Bifg@mail.gmail.com>
References: <20230626183611.40479-1-charlie@rivosinc.com>
 <20230627-eternity-mulberry-e1f4babf06a1@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627-eternity-mulberry-e1f4babf06a1@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I talked to Atish, he's not sure what's going on here either. I am going
to add him to the CC list.

On Tue, Jun 27, 2023 at 11:24 AM Conor Dooley <conor@kernel.org> wrote:

> Hey Charlie,
>
> On Mon, Jun 26, 2023 at 11:36:02AM -0700, Charlie Jenkins wrote:
> > Make sv39 the default address space for mmap as some applications
> > currently depend on this assumption. The RISC-V specification enforces
> > that bits outside of the virtual address range are not used, so
> > restricting the size of the default address space as such should be
> > temporary. A hint address passed to mmap will cause the largest address
> > space that fits entirely into the hint to be used. If the hint is less
> > than or equal to 1<<38, a 39-bit address will be used. After an address
> > space is completely full, the next smallest address space will be used.
> > 
> > Documentation is also added to the RISC-V virtual memory section to 
> explain
> > these changes.
>
> I don't know what went wrong here, but this never ended up in patchwork
> for some reason, although it has appeared on lore. That seems to be via
> the docs mailing list, rather than linux-riscv. Could you speak to Atish
> and see if he knows what went wrong?
>
> Cheers,
> Conor.
>
> > 
> > Charlie Jenkins (2):
> >   RISC-V: mm: Restrict address space for sv39,sv48,sv57
> >   RISC-V: mm: Update documentation and include test
> > 
> >  Documentation/riscv/vm-layout.rst             | 20 ++++++++
> >  arch/riscv/include/asm/elf.h                  |  2 +-
> >  arch/riscv/include/asm/pgtable.h              | 21 ++++++--
> >  arch/riscv/include/asm/processor.h            | 41 +++++++++++++---
> >  tools/testing/selftests/riscv/Makefile        |  2 +-
> >  tools/testing/selftests/riscv/mm/Makefile     | 22 +++++++++
> >  .../selftests/riscv/mm/testcases/mmap.c       | 49 +++++++++++++++++++
> >  7 files changed, 144 insertions(+), 13 deletions(-)
> >  create mode 100644 tools/testing/selftests/riscv/mm/Makefile
> >  create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c
> > 
> > 
> > base-commit: eef509789cecdce895020682192d32e8bac790e8
> > -- 
> > 2.34.1
> > 
>
