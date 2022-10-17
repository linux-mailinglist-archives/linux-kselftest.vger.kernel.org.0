Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97A6005D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 05:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiJQDrE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Oct 2022 23:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiJQDrD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Oct 2022 23:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD21C50F88
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Oct 2022 20:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C9E460F05
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 03:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1581C43470
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 03:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665978421;
        bh=gFlCfq117VRVLAxlo1bNCpasOJZNVAJeNeJRIJRLfiw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZOSm3kxgtK/kZVRrDpP+nxhwitDk27YCET63uECeT+t4OnSgfchmJ8dof4Y/zu3hD
         VCA9aL4ZRKox/RHJs9osGuO4GUoyAt19ttR51krtBzoztkXzPLBOL843ji4VyP7dZc
         NAuljT4B26YvYklgAq8MTzRr95eFbpyn2SXPdcjkbPi076w0EbJv/3UhBmIoGzRozW
         AUDsK/EcH5yuHvt03Sz87PM2Lixo+Wb2eXe0ISXZvnpRD0ErDxr02wmHyyUr7Motjc
         HMNC3GKmHt4pDulWzbDN/DmW6Z99P3ebZv+dpMCiKYjMDjS6DSLYXFRWDmndK7Ch2j
         nAzP0Rbd8fbuA==
Received: by mail-ed1-f45.google.com with SMTP id s2so14273063edd.2
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Oct 2022 20:47:01 -0700 (PDT)
X-Gm-Message-State: ACrzQf2KFXkKjj6EXDl/yetMBgB5QtUrY/Ybp1w8QbpiBcVF5erL3e7Z
        WazSFLmA5EaZbWyW0WuiuK8kd5KPV5O3L3l/ux4=
X-Google-Smtp-Source: AMsMyM4v7qla7xbK8U1wX9tm6zg4n0bG/EEVJEacMfc6ruCa7UvbKsiroJbPj1PKGqJQjS3hpP5Rtd/OZR/0RWJxUrE=
X-Received: by 2002:aa7:df16:0:b0:45b:f51f:ab73 with SMTP id
 c22-20020aa7df16000000b0045bf51fab73mr8392539edy.366.1665978420038; Sun, 16
 Oct 2022 20:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220903095507.3425208-1-chenhuacai@loongson.cn> <CAAhV-H4Rn0vQpD5PA8iGHPHLYw1tReNzQM4dps9YoK=u7YNY3Q@mail.gmail.com>
In-Reply-To: <CAAhV-H4Rn0vQpD5PA8iGHPHLYw1tReNzQM4dps9YoK=u7YNY3Q@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 17 Oct 2022 11:46:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ww7NWzL9v+mCTMztf6pYWpVyp_R9kso8wXTGrnhSvDQ@mail.gmail.com>
Message-ID: <CAAhV-H6ww7NWzL9v+mCTMztf6pYWpVyp_R9kso8wXTGrnhSvDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: Add LoongArch build infrastructure
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, loongarch@lists.linux.dev,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ping^2?

On Sat, Sep 17, 2022 at 4:57 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Ping?
>
> On Sat, Sep 3, 2022 at 5:55 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > We will add tools support for LoongArch (bpf, perf, objtool, etc.), add
> > build infrastructure and common headers for preparation.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  tools/arch/loongarch/include/uapi/asm/bitsperlong.h |  9 +++++++++
> >  tools/scripts/Makefile.arch                         | 11 ++++++++++-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/arch/loongarch/include/uapi/asm/bitsperlong.h
> >
> > diff --git a/tools/arch/loongarch/include/uapi/asm/bitsperlong.h b/tools/arch/loongarch/include/uapi/asm/bitsperlong.h
> > new file mode 100644
> > index 000000000000..d4e32b3d4843
> > --- /dev/null
> > +++ b/tools/arch/loongarch/include/uapi/asm/bitsperlong.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef __ASM_LOONGARCH_BITSPERLONG_H
> > +#define __ASM_LOONGARCH_BITSPERLONG_H
> > +
> > +#define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
> > +
> > +#include <asm-generic/bitsperlong.h>
> > +
> > +#endif /* __ASM_LOONGARCH_BITSPERLONG_H */
> > diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
> > index 0c6c7f456887..1c72d07cb9fe 100644
> > --- a/tools/scripts/Makefile.arch
> > +++ b/tools/scripts/Makefile.arch
> > @@ -5,7 +5,7 @@ HOSTARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
> >                                    -e s/s390x/s390/ -e s/parisc64/parisc/ \
> >                                    -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
> >                                    -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
> > -                                  -e s/riscv.*/riscv/)
> > +                                  -e s/riscv.*/riscv/ -e s/loongarch.*/loongarch/)
> >
> >  ifndef ARCH
> >  ARCH := $(HOSTARCH)
> > @@ -34,6 +34,15 @@ ifeq ($(ARCH),sh64)
> >         SRCARCH := sh
> >  endif
> >
> > +# Additional ARCH settings for loongarch
> > +ifeq ($(ARCH),loongarch32)
> > +       SRCARCH := loongarch
> > +endif
> > +
> > +ifeq ($(ARCH),loongarch64)
> > +       SRCARCH := loongarch
> > +endif
> > +
> >  LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
> >  ifeq ($(LP64), 1)
> >    IS_64_BIT := 1
> > --
> > 2.31.1
> >
> >
