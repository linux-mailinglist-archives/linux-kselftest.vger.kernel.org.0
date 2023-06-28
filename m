Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8537F740ED1
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjF1Kb3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjF1K30 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 06:29:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ADF1B0;
        Wed, 28 Jun 2023 03:29:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so2691472e87.0;
        Wed, 28 Jun 2023 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687948161; x=1690540161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9+dB0uPjR6dzec0l9qeLYrn0RkeAmaPi6wiBE0Rz0s=;
        b=b2Rs2cSK28LUBmSPPPXn1tL6IRsmSP2tJgPSfQSx4O5vycvWrA8kXiiRZLuf47VqNQ
         3T5FosiCwHUqAqiWFHaG1ckoLAJZE8HaG1zHw5D8T0V+TrINR2QnL3/PH2dd8VbGR0O/
         A/bGKjFPDpYY/4XE571aMQ29SutOrFhUowFPKjCXEV8NJSbkp1tNbP4Vhgu8hW7zlCY9
         LIkALG9i847X5HSNaM32b94V+lrtjI9t6xRUthyF3e8TsPSeoRv5f8s0GX/aMf89bYrC
         cp+awk1KsU8+n8daJmyM+z1eW9ItpBDv93fq6bcTCW6DP4TZAhyDJkSjmYdWiR6uPH2q
         dKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687948161; x=1690540161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9+dB0uPjR6dzec0l9qeLYrn0RkeAmaPi6wiBE0Rz0s=;
        b=bSNcs6fmCJ56Ik1LT/Xszm1qJL6PqFSsld1YuSqKheBGSaqoq0en/++bNCffWVT2bI
         VYv1N856lubnc4mcXpPNiE2W1kPPoHwtjPrshY6E+MO3BYGN1bFC3+/nPm9hmb9tUNJw
         +JxEUGxVM/fCzZMbSAqxUdMCt7ixtzl77s4wPUZDFykmpCvnfWMQ7BpP3jY30+pBLghq
         pEdJfE84jYWWQRCZ6hCbefmdCYXycN+c0mhj9PyvO2QhDz4KfSS5bB9I9I0ojLE9Szpb
         4DF8Fe7LciaSoXxv7MDFDg8KIUEi4TBVIf9z8qoMnXUy0BPYVO7IRITWFRZrkof9bDzk
         eXsw==
X-Gm-Message-State: AC+VfDxbXpkvfwybdRmqFjE1cE4CZlLaPJsAVFK5Opz5LgkbtexhwSvM
        YegCqexpo3vXrVgN+q9JQxjyKdQGdaw1RfLdBVw=
X-Google-Smtp-Source: ACHHUZ4h09V3wI1azpJqOp/sAeZVBD2vtw10dniqbPA1C8M7x23FpqEn0BF2WO5Dy4bGcYG4R5lh8sQuVPSUE5aJ9aE=
X-Received: by 2002:a2e:9183:0:b0:2b4:6e21:637e with SMTP id
 f3-20020a2e9183000000b002b46e21637emr17706195ljg.16.1687948161020; Wed, 28
 Jun 2023 03:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687515463.git.haibo1.xu@intel.com> <fa6b80b578553e561ccacaeb24091e0716975593.1687515463.git.haibo1.xu@intel.com>
 <20230627-feb5bf584a3fd16d2c0ffe66@orel>
In-Reply-To: <20230627-feb5bf584a3fd16d2c0ffe66@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 28 Jun 2023 18:29:09 +0800
Message-ID: <CAJve8o=CN4TJz5R9+zne_mA9L_doNTwg+w39OgU5HKXPzb4hmg@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] KVM: riscv: selftests: Add finalize_vcpu check
 in run_test
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>, maz@kernel.org,
        oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
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

Thanks a lot!

On Tue, Jun 27, 2023 at 5:16=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, Jun 23, 2023 at 06:40:13PM +0800, Haibo Xu wrote:
> > Disable all vcpu extensions which were enabled by default
> > if they were available in the risc-v host, and only enable
> > the desired one for a vcpu_config.
> >
> > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/get-reg-list.c | 42 +++++++++++++++++++++-
> >  1 file changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing=
/selftests/kvm/get-reg-list.c
> > index 3beb6b62de0a..612dabc61137 100644
> > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > @@ -138,11 +138,50 @@ static struct kvm_vcpu *vcpu_config_get_vcpu(stru=
ct vcpu_reg_list *c, struct kvm
> >       prepare_vcpu_init(c, &init);
> >       vcpu =3D __vm_vcpu_add(vm, 0);
> >       aarch64_vcpu_setup(vcpu, &init);
> > -     finalize_vcpu(vcpu, c);
> >
> >       return vcpu;
> >  }
> >  #else
> > +static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > +{
> > +     int ret;
> > +     unsigned long value;
> > +
> > +     ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > +     if (ret) {
> > +             printf("Failed to get ext %d", ext);
> > +             return false;
> > +     }
> > +
> > +     return !!value;
> > +}
> > +
> > +static void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list =
*c)
> > +{
> > +     struct vcpu_reg_sublist *s;
> > +
> > +     /*
> > +      * Disable all extensions which were enabled by default
> > +      * if they were available in the risc-v host.
> > +      */
> > +     for (int i =3D 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
> > +             __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
> > +     }
>
> nit: can drop the {}
>
> > +
> > +     for_each_sublist(c, s) {
> > +             if (!s->feature)
> > +                     continue;
> > +
> > +             /* Try to enable the desired extension */
> > +             __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(s->feature), 1);
> > +
> > +             /* Double check whether the desired extension was enabled=
 */
> > +             __TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
> > +                            "%s: %s not available, skipping tests\n",
> > +                            config_name(c), s->name);
> > +     }
> > +}
> > +
> >  static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, =
struct kvm_vm *vm)
> >  {
> >       return __vm_vcpu_add(vm, 0);
> > @@ -178,6 +217,7 @@ static void run_test(struct vcpu_reg_list *c)
> >
> >       vm =3D vm_create_barebones();
> >       vcpu =3D vcpu_config_get_vcpu(c, vm);
> > +     finalize_vcpu(vcpu, c);
>
> Now that both arm and riscv call finalize_vcpu() we could do the weak
> function trick for it and move the arch-specific implementations to
> their own arch-specific files.
>
> >
> >       reg_list =3D vcpu_get_reg_list(vcpu);
> >
> > --
> > 2.34.1
> >
>
> Otherwise,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks,
> drew
