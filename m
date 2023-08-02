Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05FB76C297
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 04:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjHBCCY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 22:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHBCCW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 22:02:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B201E67;
        Tue,  1 Aug 2023 19:02:21 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9bd59d465so97404251fa.3;
        Tue, 01 Aug 2023 19:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690941739; x=1691546539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BRNQZESjyk6IP99SQFSrutDbZmWlCuaWV8SfC7y5xc=;
        b=RescUJyA4czz2u48U2yw6OwDEJhPPMZ5LPu/vHcqMP2ujZH2KrD93KlDeAzenoKEQV
         2lTjLCYkYzvWRowhIE4IlB27gLUJ5UUVgAIvqpAHZd5ynlMs5CQQNG35qkhmHDebxT5P
         V8VUysW079YKkGkz9/ivxoDvOQ3i6EF+X85hYKxDmt+nd82A53KN/Zy0KRXZ6TbAzjLG
         d4q8oaVncLzZ2GGhw0fxstmxv0oLqDlSev+NubvETyLS5f1YFDLLwz2IlM+SxtqKxVJR
         7Cit8m8XPAVblxn5NVRaai4sCh67qSxbEAb4KrlypAJRTqAK3uE5obDASpc8aalSo3+G
         AjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690941739; x=1691546539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BRNQZESjyk6IP99SQFSrutDbZmWlCuaWV8SfC7y5xc=;
        b=DkO5SfgcRFSN2VqxeaMLJXfHKvp31mW314oRru5r14qaFCbdT2Ei/DEzC3CCk53ErJ
         AxACtLj2EXAJCs14cFtAqGnNlQ7XGhZbHXR9ea2DUkcwi6D8QNqPDzVgb0ud3Wr+qNEz
         eedlqRPETBl+pMOK3p+K6jhvrSm/RzzfboACJiY2Q6zyGqhlA4V4KbVBO/PSkycz+Jpc
         d89UvaZS58EkcI3q7abFXo9VnDe75v9fYQZpZf0WE1XR9CcjJObfdRjppj1Y/FYQw7bL
         XvRtkndxZur9tPr3lS/7Svib+yB+yP0Fu9yKufDqIe/RwctecRZTQVeLuCMAxQiTdmdk
         0GYg==
X-Gm-Message-State: ABy/qLbTA33O42rBjnP/9AEp/06hsAnu1PqvgIRQyC8XeQb2MsH5SphO
        MKgrTcT7yVwhlDssl5eFsc1Yl3HM9yRMpLDBolk=
X-Google-Smtp-Source: APBJJlHWMN+tdmvCgw7W5gmCWTgI3jD9ANjOYsnpgN9t/xJYLucTLaKx+Y5GKFzrL3a8R5KltoFMpV8MP4RICRmEGes=
X-Received: by 2002:a2e:9942:0:b0:2b9:cb2a:11bf with SMTP id
 r2-20020a2e9942000000b002b9cb2a11bfmr3820055ljj.49.1690941739021; Tue, 01 Aug
 2023 19:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com> <36b5837e9e94465dd2b7d7a17bb84dea082f2ffa.1690364259.git.haibo1.xu@intel.com>
 <20230728-42019a78766a59dc5abdd412@orel>
In-Reply-To: <20230728-42019a78766a59dc5abdd412@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 2 Aug 2023 10:02:07 +0800
Message-ID: <CAJve8omPWM7JR+Bqtemw0XjP8Q-C5zNbAzWxB_HMFcWKoSFuog@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: riscv: selftests: Add guest helper to get vcpu id
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Vipin Sharma <vipinsh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 5:49=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Jul 27, 2023 at 03:20:07PM +0800, Haibo Xu wrote:
> > Add guest_get_vcpuid() helper to simplify accessing to per-cpu
> > private data. The sscratch CSR was used to store the vcpu id.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/include/riscv/processor.h | 2 ++
> >  tools/testing/selftests/kvm/lib/riscv/processor.c     | 8 ++++++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/to=
ols/testing/selftests/kvm/include/riscv/processor.h
> > index 9ea6e7bedc61..ca53570ce6de 100644
> > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > @@ -165,4 +165,6 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned =
long arg0,
> >                       unsigned long arg3, unsigned long arg4,
> >                       unsigned long arg5);
> >
> > +uint32_t guest_get_vcpuid(void);
>
> I'd also put this prototype somewhere common.
>
> > +
> >  #endif /* SELFTEST_KVM_PROCESSOR_H */
> > diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/=
testing/selftests/kvm/lib/riscv/processor.c
> > index f1b0be58a5dc..b8ad3e69a697 100644
> > --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > @@ -316,6 +316,9 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm=
, uint32_t vcpu_id,
> >       vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.sp), stack_vaddr + stack_s=
ize);
> >       vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.pc), (unsigned long)guest_=
code);
> >
> > +     /* Setup scratch regiter of guest */
>
> typo: register
>
> The comment above is pretty useless since it just states what the code
> states, but with even less information, since it doesn't state how the
> sscratch register is getting set up. I'd either drop it or write it
> as
>
>  /* Setup sscratch for guest_get_vcpuid() */
>
> > +     vcpu_set_reg(vcpu, RISCV_CSR_REG(sscratch), vcpu_id);
> > +
> >       /* Setup default exception vector of guest */
> >       vcpu_set_reg(vcpu, RISCV_CSR_REG(stvec), (unsigned long)guest_une=
xp_trap);
> >
> > @@ -424,3 +427,8 @@ void vm_install_interrupt_handler(struct kvm_vm *vm=
, void (*handler)(struct ex_r
> >
> >       handlers->exception_handlers[1][0] =3D handler;
> >  }
> > +
> > +uint32_t guest_get_vcpuid(void)
> > +{
> > +     return csr_read(CSR_SSCRATCH);
> > +}
> > --
> > 2.34.1
> >
>

Sure! will fix them in v2.

Thanks,
Haibo

> Thanks,
> drew
