Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B46740C6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 11:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjF1JI5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjF1Itw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 04:49:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8BD3A9B;
        Wed, 28 Jun 2023 01:42:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so2505011e87.0;
        Wed, 28 Jun 2023 01:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687941753; x=1690533753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g54qKoeGjWz5wLaqSLQFYfEyGEtCRjTvx7zRiV5BneY=;
        b=E5/fD6H+BE8e9eM4PW7j8lCTlWH1PJ6wKXBMhLgltNdLZtqhif+dAU6ErCt6xjnO2n
         blrxZo+o+h9is0Kh3DBqUvRvELDuNGekKV5hEsI3Tm/WeNqOKlEs20l7VWWqw+0nAAnL
         grS2UbVE9shuMYKdnuHK/3brcfz1oL9AeIqadZ5dFzddSUGtW2zKVrtvqJPyxJtokQVk
         Hye0cd/ZwA+C20D7/S90adg5AzJhKMqaea+Ra7TKT48x1UhuQVFyTCzUcrS681LR40Aw
         KG9+s5ZS+kRGfIZsdryvSB1COUaadyrYFTciLbGp3kZYPwYR+cxE6knYrMqPlheuRkYv
         WQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687941753; x=1690533753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g54qKoeGjWz5wLaqSLQFYfEyGEtCRjTvx7zRiV5BneY=;
        b=LDH6PIcZARUi+vznjMPioFXwrkBuJLmb5e9sQry8G3BCWJhqheaDa51CcQOpfZwMq+
         onSfvUSJt5DO+2JpzdQpa6ORrqy2jm5vsA7FUGkOtYqiQ9AA0ecj9J20w7Qfav2qLg67
         4Xo1HGN3e0buKr6+KRzCURColgqiUe+Mxs15Hbdli0L0VQ2rcHXbJDgo+u8mKj9t9+NB
         7OBgflMGhKJV2w7awuHDYKI8aL4DuzFgUQ2IRSjtVYzDGMbH01tEDBC1X4jNtBjasY0w
         fpCey9IHFYHVuQgzalLoFr3/hV1Wa+l0eoxkLiAKyO/IjUeLFuAhS3TiAzNdhHyAI7K0
         TXlQ==
X-Gm-Message-State: AC+VfDzuemng+0yn6bTQXoowj4hkZrXPjX0WVzfWXLLADe4kVJq0zaBD
        uGLH/oYT9EwONjoWZ69K15iAafr1wXb7hZrQhb2C+g+V
X-Google-Smtp-Source: ACHHUZ7VQCn+YpLvmFmYlf+FOQl2niELacwE4Dcgqiq8I8RkRNKRsyCtVuMehnHMGr1vYCdhl+c2sAGOLh6Bb/4fwYA=
X-Received: by 2002:a05:651c:8f:b0:2b6:a17b:a120 with SMTP id
 15-20020a05651c008f00b002b6a17ba120mr5672641ljq.22.1687932068929; Tue, 27 Jun
 2023 23:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687515463.git.haibo1.xu@intel.com> <47f0502d076c071260a87953cbabadfc85d278cf.1687515463.git.haibo1.xu@intel.com>
 <20230627-adcb173b3ee813e2e16353bd@orel>
In-Reply-To: <20230627-adcb173b3ee813e2e16353bd@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 28 Jun 2023 14:00:57 +0800
Message-ID: <CAJve8onuBoOOOL4yp3wTTsBMqxf4MZL6uUjgMBjUmWsTO61A2g@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] KVM: selftests: Only do get/set tests on present
 blessed list
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
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
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

On Tue, Jun 27, 2023 at 5:11=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, Jun 23, 2023 at 06:40:11PM +0800, Haibo Xu wrote:
> > Only do the get/set tests on present and blessed registers
> > since we don't know the capabilities of any new ones.
> >
> > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/get-reg-list.c | 29 ++++++++++++++--------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing=
/selftests/kvm/get-reg-list.c
> > index b956ee410996..3beb6b62de0a 100644
> > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > @@ -52,6 +52,10 @@ extern int vcpu_configs_n;
> >       for_each_reg_filtered(i)                                         =
       \
> >               if (!find_reg(blessed_reg, blessed_n, reg_list->reg[i]))
> >
> > +#define for_each_present_blessed_reg(i)                      \
> > +     for ((i) =3D 0; (i) < blessed_n; ++(i))           \
> > +             if (find_reg(reg_list->reg, reg_list->n, blessed_reg[i]))
> > +
> >  static const char *config_name(struct vcpu_reg_list *c)
> >  {
> >       struct vcpu_reg_sublist *s;
> > @@ -189,6 +193,16 @@ static void run_test(struct vcpu_reg_list *c)
> >               return;
> >       }
> >
> > +     for_each_sublist(c, s)
> > +             blessed_n +=3D s->regs_n;
> > +     blessed_reg =3D calloc(blessed_n, sizeof(__u64));
> > +
> > +     n =3D 0;
> > +     for_each_sublist(c, s) {
> > +             for (i =3D 0; i < s->regs_n; ++i)
> > +                     blessed_reg[n++] =3D s->regs[i];
> > +     }
> > +
> >       /*
> >        * We only test that we can get the register and then write back =
the
> >        * same value. Some registers may allow other values to be writte=
n
> > @@ -198,8 +212,11 @@ static void run_test(struct vcpu_reg_list *c)
> >        * be written need to have the other values tested, then we shoul=
d
> >        * create a new set of tests for those in a new independent test
> >        * executable.
> > +      *
> > +      * Only do the get/set tests on present, blessed list registers,
> > +      * since we don't know the capabilities of any new registers.
> >        */
> > -     for_each_reg(i) {
> > +     for_each_present_blessed_reg(i) {
> >               uint8_t addr[2048 / 8];
> >               struct kvm_one_reg reg =3D {
> >                       .id =3D reg_list->reg[i],
> > @@ -242,16 +259,6 @@ static void run_test(struct vcpu_reg_list *c)
> >               }
> >       }
> >
> > -     for_each_sublist(c, s)
> > -             blessed_n +=3D s->regs_n;
> > -     blessed_reg =3D calloc(blessed_n, sizeof(__u64));
> > -
> > -     n =3D 0;
> > -     for_each_sublist(c, s) {
> > -             for (i =3D 0; i < s->regs_n; ++i)
> > -                     blessed_reg[n++] =3D s->regs[i];
> > -     }
> > -
> >       for_each_new_reg(i)
> >               ++new_regs;
> >
> > --
> > 2.34.1
> >
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks,
> drew

Thanks for the review!
