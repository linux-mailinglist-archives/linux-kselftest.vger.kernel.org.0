Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7017479398C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjIFKKm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 06:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjIFKKl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 06:10:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051BA9E;
        Wed,  6 Sep 2023 03:10:38 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso53487381fa.0;
        Wed, 06 Sep 2023 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693995036; x=1694599836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfOqaeV+KknayCO8Oeiwloxt+zMetEN9D2laP149Llc=;
        b=eX7iAaVjLf53GweOplBPQovNC4DitqXdyaFSGS7sS4KLCaHEsY47HRom2wt4P8QvU9
         qF+Pv+myq4l5Etj6ij4jBQL/VbWh3uo+S2UOVwdhuVCKXu4EPs8rn1L3KNPJoRHfSVjS
         LLbfZ7NhgiAZ/h5yq/KMVTwMJMlC2eLBbyJXXLRM4LdgK1Z6Lb2KOvam0NMSDVqki7dn
         hn8GzHIMtIr6NUXSHuG+IZCTM+E2LXCM3tfA7SG9WEWnUdtAT8+C8Jp7wN/L9uIUuMND
         jNf3nlHjacG2MLgTbEnl41pcFxaNnXGejI3yMOdF8Ub5zi9mEGBjG1V15d9VS4NEU8sE
         bH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995036; x=1694599836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfOqaeV+KknayCO8Oeiwloxt+zMetEN9D2laP149Llc=;
        b=MVs+5RAYL/CJF+ph25mnyWqHMj7ADCDv+XknKKb3NFTd57YPceJGVl7WW+NbU7ONc8
         w0wm5MGzIRk2G2e83EEUZMb/0UUhMBPtscsn2LjFzfE+m/7YkW9ts4Qnd/USqmaPkjQ3
         BUEOHIp9a7+CNLVmdKUO9n6aifMz2c+/q5+nngL7MYlwbvoF7J71ysVVI/hAeyb2s2b5
         qtavY6j0khPpnHIE+81oJY4L25YZZpdOf4DCqxvkNMTy5sWRNrBAWrdkG10QMGp3+kpZ
         ED+APKOLyJJGGHs0XY7IUEnNgreglj8c4K1sprY22cOdVi6zDoyQwEBdiT/Pk5Syd94o
         EOzQ==
X-Gm-Message-State: AOJu0YxQilSnoIQMtBo5B9xXlgEl6W+szWwxgrpOD4mNorqB4BY8Mfwk
        ZLAJqvQBjDYlXhbTe2q/BPYmvlZLwyk61/TU3no=
X-Google-Smtp-Source: AGHT+IFgpGZUTmfvyaicrKry99f2uX/eh3DtKB8c/qKcmnkcHz7uwZYtn0qD9L1QTcGEetIJKq9wCp8WNJgZPbJB/RM=
X-Received: by 2002:a05:651c:104a:b0:2bd:180d:67b1 with SMTP id
 x10-20020a05651c104a00b002bd180d67b1mr1816321ljm.51.1693995035890; Wed, 06
 Sep 2023 03:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <b6ef1b031e3a581f481cf19a26623388163444b4.1693659382.git.haibo1.xu@intel.com>
 <20230904-aa8b0d8d23d391586686038a@orel>
In-Reply-To: <20230904-aa8b0d8d23d391586686038a@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 6 Sep 2023 18:10:24 +0800
Message-ID: <CAJve8ok5cU+h1K+WJ+aDpB+u+PBo8XosUyyVbMGy-xR0XiWFdw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] KVM: riscv: selftest: Change vcpu_has_ext to a
 common function
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        wchen <waylingii@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Lei Wang <lei4.wang@intel.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Like Xu <likexu@tencent.com>, Peter Gonda <pgonda@google.com>,
        Thomas Huth <thuth@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, Paul Durrant <paul@xen.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 4, 2023 at 10:04=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sat, Sep 02, 2023 at 08:59:29PM +0800, Haibo Xu wrote:
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/t=
esting/selftests/kvm/riscv/get-reg-list.c
> > index d8ecacd03ecf..c4028bf32e3f 100644
> > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > @@ -44,20 +44,6 @@ bool check_reject_set(int err)
> >       return err =3D=3D EINVAL;
> >  }
> >
> > -static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > -{
> > -     int ret;
> > -     unsigned long value;
> > -
> > -     ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > -     if (ret) {
> > -             printf("Failed to get ext %d", ext);
> > -             return false;
> > -     }
> > -
> > -     return !!value;
>
> get-reg-list will now assert on get-reg when an extension isn't present,
> rather than failing the __TEST_REQUIRE(), which would do a skip instead.
> We need both the return false version and the assert version.
>

Ok, Will keep this one for get-reg-list and add another one for
arch-timer specific usage.

> > -}
> > -
> >  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
> >  {
> >       struct vcpu_reg_sublist *s;
> > --
> > 2.34.1
> >
>
> Thanks,
> drew
