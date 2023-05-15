Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF37170247D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 08:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbjEOGXa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 02:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEOGXa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 02:23:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901319F;
        Sun, 14 May 2023 23:23:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24df4ef05d4so10520520a91.2;
        Sun, 14 May 2023 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684131801; x=1686723801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDHXdNQbYhXSREb9b4s64DzzPtUQRB9+Khu+X4RcHb8=;
        b=ZeNtexfq5V2ww/s02fXWGGUBRJqKqYrmmFjDJafk3vXa/fPrFT799BakZLoKwsVFNv
         izP6vKF1/85VbAMdjmsPkZt3PdteckEBye0bynlcVhmteIZjfeoIQgxsB6+Yy8Qnhtky
         lMqpcHYhWYV8x40rRYT6YecJjtSmGOKV3sutT52Y5Ugx6ho8DMyPGJpGuSHFW3tuHWNO
         5sPWCM/vFD+hzYghT1ekgimxBWT49Z+PxaqsXUgg3gs1E6Af6AHunZaZEv5mqeOHHpp9
         2IqPIgZDENpO7xMJiLYAlPQSOzgURsxOIB/j89xuuAxZiKS7jmnCyvXKTzGVxFDo9Ow6
         Bj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684131801; x=1686723801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDHXdNQbYhXSREb9b4s64DzzPtUQRB9+Khu+X4RcHb8=;
        b=B5/JfAufdOJNyVApEFmaDwzqexSfuFONFr3fR5KRLH7kFYkbaYjYXFnXzTj9Q5Ul1G
         q5eKpdOsfXeh6DTj810nqSLlFraWg+c/icDu6ALXlFbRrxxzuWpAAezccLx8HJx/5Z4Q
         PS7Hjj9kZ7dSiumVS+nHiZxDR5XLVQMi2wLvZHLCvL57bk2xaXWjasQuxdyfJOKlHR/m
         ExTvFXlVFuv82HBEYyslgulSrWZTglSMT4HaMN6MtE8Kc7wZTxRJbzgvE337UA7Gz7Tg
         OWW3KwUrixKGiwmgKLcAq6MIQu0O4oiYyWo/cJFVnFghY9GGvwNiZa4uhVezo2JyH/Mq
         kAjQ==
X-Gm-Message-State: AC+VfDw5Bhe1EnuTFBQsBzE5hpUDRghhtNhWaxI2rP5ss2FK5wCNsMlT
        hlN3tn1XyEPdN/PQ5WWri8euMthsyIZxWwVWWoU=
X-Google-Smtp-Source: ACHHUZ4GdM02yWWd/RVw6ZxMm0XmPUpxEPRJsgbK9JVDUKhxwEH/odjmbP5Y3hDS8qB0Pue4YJGzxOTNrLFlI4ViqR4=
X-Received: by 2002:a17:90a:db49:b0:250:d137:e2ae with SMTP id
 u9-20020a17090adb4900b00250d137e2aemr17275992pjx.23.1684131800927; Sun, 14
 May 2023 23:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683791148.git.haibo1.xu@intel.com> <921fc2e1a91887170e277acb1b52df57480a5736.1683791148.git.haibo1.xu@intel.com>
 <20230511-d0a207eebb30fc88de875e4f@orel>
In-Reply-To: <20230511-d0a207eebb30fc88de875e4f@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Mon, 15 May 2023 14:23:09 +0800
Message-ID: <CAJve8o=3VaQkjtgPnqeTtOcnNLEptUJzekoUgqaZ86K6GAF08A@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: kvm: Add KVM_GET_REG_LIST API support
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 12, 2023 at 12:40=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Thu, May 11, 2023 at 05:22:48PM +0800, Haibo Xu wrote:
> > KVM_GET_REG_LIST API will return all registers that are available to
> > KVM_GET/SET_ONE_REG APIs. It's very useful to identify some platform
> > regression issue during VM migration.
> >
> > Since this API was already supported on arm64, it'd be straightforward
> > to enable it on riscv with similar code structure.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  Documentation/virt/kvm/api.rst |   2 +-
> >  arch/riscv/kvm/vcpu.c          | 346 +++++++++++++++++++++++++++++++++
> >  2 files changed, 347 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/ap=
i.rst
> > index add067793b90..280e89abd004 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -3499,7 +3499,7 @@ VCPU matching underlying host.
> >  ---------------------
> >
> >  :Capability: basic
> > -:Architectures: arm64, mips
> > +:Architectures: arm64, mips, riscv
> >  :Type: vcpu ioctl
> >  :Parameters: struct kvm_reg_list (in/out)
> >  :Returns: 0 on success; -1 on error
> > diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> > index 8bd9f2a8a0b9..fb8834e4fa15 100644
> > --- a/arch/riscv/kvm/vcpu.c
> > +++ b/arch/riscv/kvm/vcpu.c
> > @@ -657,6 +657,334 @@ static int kvm_riscv_vcpu_set_reg_isa_ext(struct =
kvm_vcpu *vcpu,
> >       return 0;
> >  }
> >
> > +static inline unsigned long num_config_regs(void)
> > +{
> > +     return sizeof(struct kvm_riscv_config) / sizeof(unsigned long);
>
> We can't assume all config registers are present. For example,
> zicbom and zicboz block size registers are only present when their
> respective extensions are available.
>
> Thanks,
> drew

Yes, I will filter out these kinds of registers in the next version.

Thanks,
Haibo
