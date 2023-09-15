Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C047A1602
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 08:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjIOGX4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 02:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIOGXz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 02:23:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4B6270B;
        Thu, 14 Sep 2023 23:23:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso2141635e87.1;
        Thu, 14 Sep 2023 23:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694759029; x=1695363829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1zuvJ7RRCqy9MSyULz3DiU3qO3y4/pQtJW6GP4mEKM=;
        b=hNEqoUQO/cTfVnBAqJ435MWPucNekQCo7hLibOtNN6t3uywMByiX0hlg093awL6lv7
         d0fZH7aZxzNMWL0j3hb2Tcaoex8P1GhymqJ3BSbjvQCDmazK0NtbsZG52W7fHnpeqZ+g
         hCJPraPNGxRkYqiXkqklDg0MGvIWdVKR/2THGlSJBK6F/RmrPNRWTpc6lJXtJ/lcRxN0
         4x+f1Uheh3cY5/ASavdQz89nrKpR6owZ6WZNfU3l+jv+yvnaxs9jilDNLWTbqPFwy3Gk
         pcIwuOWDLbDufm2D8JYDN/z3xC1nYOoFkcLcbFjMKqj48PmIJ+AKtWhW4SPQarNDZGUg
         8qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694759029; x=1695363829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1zuvJ7RRCqy9MSyULz3DiU3qO3y4/pQtJW6GP4mEKM=;
        b=v1ZFMLuhljvYHmsC8zO80hcCwa/xgb84uYwI1CeFZaAxaFIC/W0XkDOEzE440yuC4K
         3UpySiW9s56EBq3BoRAk6dSVQq4WjNC+tOhXRPrY+IR7GtfMpp8Q4jC3MID+01XLp8KI
         K5+NWURitc6WgeIukpK5t2CQS+TPMm1WjDB9pe0Bq+k6nAaT+Cskk/cTxxTUZMC37rdi
         GNN0Uvle2YJuVXKYub2tUWLJsqWUz61QnqdpumP/cXa99Kv8fD8e5ISBHUO3F5WdDfhY
         x5PuKXeDPTlBDUsRucjk4XyiafuE98y6tMV1mF45f8rKR8YBJ2IYU6mCzjzQ4LkLPMIi
         4+/w==
X-Gm-Message-State: AOJu0YzLkqgyT8uzZFsmYSoxbjGEwNpus88nwnRn93dZ7x++IwYt0x16
        5fFOcqDMjZaaQ6FJB1VHrFypynnRcIqGblAuNJs=
X-Google-Smtp-Source: AGHT+IGj/HsfBsymLbWepYETxK1fPN+QHY/uRqAGLNuLGZZu2qI+OypS0+lHToloM5nAwXB8QRxambJWef0/qHqiQfY=
X-Received: by 2002:a05:6512:1095:b0:502:d973:3206 with SMTP id
 j21-20020a056512109500b00502d9733206mr1476766lfg.6.1694759028702; Thu, 14 Sep
 2023 23:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694421911.git.haibo1.xu@intel.com> <64e0637cd6f22dd7557ed44bd2242001e7830d1c.1694421911.git.haibo1.xu@intel.com>
 <20230914-ee133dd5e804282ce28833d6@orel> <20230914-reflector-preshow-786425ad7ae2@wendy>
 <20230914-2232dea1c6d03fb5985755e6@orel>
In-Reply-To: <20230914-2232dea1c6d03fb5985755e6@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Fri, 15 Sep 2023 14:23:37 +0800
Message-ID: <CAJve8ok9de0bGMU24iyUSX6V4+1tZM3ca=Ntyk=2gythd4uWCg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] KVM: riscv: selftests: Add sstc timer test
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Haibo Xu <haibo1.xu@intel.com>,
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
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 6:15=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Sep 14, 2023 at 10:52:15AM +0100, Conor Dooley wrote:
> > On Thu, Sep 14, 2023 at 11:36:01AM +0200, Andrew Jones wrote:
> > > > +static inline void cpu_relax(void)
> > > > +{
> > > > +#ifdef __riscv_zihintpause
> > > > + asm volatile("pause" ::: "memory");
> > > > +#else
> > > > + /* Encoding of the pause instruction */
> > > > + asm volatile(".4byte 0x100000F" ::: "memory");
> > > > +#endif
> > > > +}
> > >
> > > cpu_relax() should go to include/riscv/processor.h
> >
> > Can the one from asm/vdso/processor.h be reused, or are there special
> > considerations preventing that?
>
> We'd need to copy it into tools/arch/riscv/include/asm, but it could be
> done. Hmm, now that I look at it, I see we're missing the barrier() call
> in this kvm selftests version.
>

Will reuse the one from asm/vdso/processor.h and copy it to
tools/arch/riscv/include/asm.

> Thanks,
> drew
