Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4BC51F42F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 08:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiEIFzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 01:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbiEIFwa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 01:52:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D291649BE
        for <linux-kselftest@vger.kernel.org>; Sun,  8 May 2022 22:48:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so10097698wms.3
        for <linux-kselftest@vger.kernel.org>; Sun, 08 May 2022 22:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhjB+0fLqvVfgEW7nyDfKQG6j1ynFgP4NXUc8d2xwM0=;
        b=KRBKPxV+qsGatSWPNAc3af3H5ujwxrs+Gr4pVdA3sBnGGPhWhQGPoUsRMVfVwjGa8j
         BRwOOMwqH/BzQZnX9jaFYzJ3OibUiMA4SHKqxXI6lcf5NuQPNtjEYGayAZjmfEuE9NU/
         r76isaumn9lMtqZGvlFDl4ajlk0FhNpASTSF9v4cwSVq37OFP40NTs1AP8L97gsXfb/O
         Lu4uvNTjfW40FgGojYmF/GKAMnkaoGJxLi6h4uLsDIqN9X4AjULKqsA/mpibHQcF/WaG
         VZKXAjCy8fkbeYEFVbywdIE7WtOOLDH1Q1YuMO2sv6JUhiTPI8WmiCs+mJJseczfJUAK
         LYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhjB+0fLqvVfgEW7nyDfKQG6j1ynFgP4NXUc8d2xwM0=;
        b=nVNHt3mx8NChUa7xwcHzzTiD2kKVREo+lG1aG7vo+SVl7ERPC56y/7WR29tVVLx5lv
         uotW5YKycPXnHAfqizjFlKksp3O4ozjsXUL1M+Iyl1eo7husorf3qV7Vk13Pe79T1Fw/
         VrhPScdn9ZEpC7sBH74Fx93QpZrHbZIqHsqRaF0h0Md9j4obBBwTawj0YOzXE6uq4iJd
         eCGzEDpJYTBLK2dN8Ll0e+tZBUH7R2R4X2vJ392oFB9fM5vgWFqlfujpKkzRTLkdk94S
         9gL5x67N7mOF83vd5H7ODEblMSbRrD5xrAQp5QY4k5Goyy4um+erZcJF0pyX1KtdG+q/
         aITA==
X-Gm-Message-State: AOAM53160mCIZZwF/zyYQt9RdB5G9VC9HqL+kjNYs/VytQHPxWsCePtB
        ml89h5yNscJN9x8FKm6EwC115qwWW7Ju0aTrJd29vQ==
X-Google-Smtp-Source: ABdhPJy6eKa8jOFSpWN4A5O+QMgITHEAyUrGpHyC5wDtjCGOldB0UCq0bDht4iqGngOrVCjXcZWNcYVLIZBj+rjLbNY=
X-Received: by 2002:a05:600c:1d08:b0:394:54ee:c994 with SMTP id
 l8-20020a05600c1d0800b0039454eec994mr14116539wms.137.1652075269206; Sun, 08
 May 2022 22:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220506094512.116729-1-jiapeng.chong@linux.alibaba.com>
 <CAAhSdy15CE5ZUROH-mOwhpR0AuwsK8h+8W-Kd0jxwsTixpQOQg@mail.gmail.com> <918affc0a0a91dab08647696ed6587021264f25f.camel@perches.com>
In-Reply-To: <918affc0a0a91dab08647696ed6587021264f25f.camel@perches.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 May 2022 11:17:37 +0530
Message-ID: <CAAhSdy1iVV1qfpaYcr+XuFjMYz+Df4vCdcJGLOYK+MQO_y+PSA@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: riscv: Remove unneeded semicolon
To:     Joe Perches <joe@perches.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        KVM General <kvm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 9, 2022 at 11:06 AM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2022-05-09 at 10:37 +0530, Anup Patel wrote:
> > On Fri, May 6, 2022 at 3:15 PM Jiapeng Chong
> > <jiapeng.chong@linux.alibaba.com> wrote:
> > >
> > > Fix the following coccicheck warnings:
> > >
> > > ./tools/testing/selftests/kvm/lib/riscv/processor.c:353:3-4: Unneeded
> > > semicolon.
> > >
> > > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> >
> > In future, please CC kvm-riscv@lists.infradead.org for KVM RISC-V related
> > patches.
>
> Perhaps add or update some MAINTAINERS entry as this list is not
> currently specified by:
>
> $ ./scripts/get_maintainer.pl -f tools/testing/selftests/kvm/lib/riscv/processor.c --nogit --nogit-fallback
> Paolo Bonzini <pbonzini@redhat.com> (supporter:KERNEL VIRTUAL MACHINE (KVM))
> Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
> Paul Walmsley <paul.walmsley@sifive.com> (supporter:RISC-V ARCHITECTURE)
> Palmer Dabbelt <palmer@dabbelt.com> (supporter:RISC-V ARCHITECTURE)
> Albert Ou <aou@eecs.berkeley.edu> (supporter:RISC-V ARCHITECTURE)
> kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM))
> linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
> linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
> linux-kernel@vger.kernel.org (open list)
> $

Ahh, I see. I will certainly update the MAINTAINERS entry for
KVM RISC-V selftests.

Thanks,
Anup

>
>
