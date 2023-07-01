Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42E47449D5
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jul 2023 16:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjGAOgD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Jul 2023 10:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGAOgC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Jul 2023 10:36:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2E3A85;
        Sat,  1 Jul 2023 07:35:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so4646085e87.1;
        Sat, 01 Jul 2023 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688222157; x=1690814157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V/OaCk35GXcvxIpFzFUkmNdu7t+Cev7etdBc/VnCek=;
        b=lM2R9YLWTG63m4x3XLk1JBq46StY57Yi1KchPgo6OP1FGoUOGKGeA2mSLMbBPoN/R3
         wwHbCBy/o7/MZp6JBoZqKE5CWisIZmWdwlJNzLZChC/3/y5gKq4jlYyseMonUPnbemcO
         6fm581uIutzDokJzmJ3/tHMh1bRG/3TPNbRQ4TDLC+7DzgmE6zkKK475KqsAhq0DjeIL
         ziF+8fs5yGgaT8EUHtCP5J89OX1P36SU7zDL/7ue6y/WiDgK0/g1ivKOXTSkhUyvIkzF
         Noal17wCUkpPLCPxlmGil+JaW7kqp293Ph89hxPOBHRAl56YKYT5hs415bdMytOaGU3T
         xnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688222157; x=1690814157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V/OaCk35GXcvxIpFzFUkmNdu7t+Cev7etdBc/VnCek=;
        b=Bx9BgnybN5iAP1bk7TyadzGAFCMRjyIJMAx3iFFy4LSV+QWwp1FZhJm2JmmiS55xBV
         gS3+W5FyiEqN31wd5sT0g+6SroXX94O9m4bLikZXISDKXFB453J5C5Q7W96Wywb8LTZn
         c5sJvXxSVTMr+2jpW8uZ3gdjhRMdhofgWj5wkMqUiRaglfQCrMBM2Yho0hsiKkQYPgO8
         zhFMJvVPrKMyaCv/5tGKj0ZZCTQSIHNPaZEZa9IRGnqwA7ir97Y0DTOJPeOG/J7clG/W
         Pof31j0xz9+zz46Hgvb2ZWtpy+KiDV4ISWGNJTQ+xt4yqGERCfJegHkvH3R4ub0YaYjS
         O5Jw==
X-Gm-Message-State: ABy/qLZ+nYHeD4i4iE5Pgt/XS2+IrPodDzCwrBJ6BVsIB+JhFNGudHVt
        u6JS6YKqfVwFCYJcDJqivYelyLvUSN/IY58c19M=
X-Google-Smtp-Source: APBJJlG/QIcXSayEfxPpuYGywiiOlYiD+XK2+DWZtT+iwy6MKp99BEaedzmKCQ1YYvFUUhsoDckL5zr5JRnH+C0ENJY=
X-Received: by 2002:a2e:780e:0:b0:2b6:b85d:b48b with SMTP id
 t14-20020a2e780e000000b002b6b85db48bmr3828061ljc.32.1688222156753; Sat, 01
 Jul 2023 07:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688010022.git.haibo1.xu@intel.com> <0a418f26388e744b6ae2f17639bea08a05643549.1688010022.git.haibo1.xu@intel.com>
 <20230701-2da2a0ffa7c1ccd3a549acea@orel>
In-Reply-To: <20230701-2da2a0ffa7c1ccd3a549acea@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Sat, 1 Jul 2023 22:35:45 +0800
Message-ID: <CAJve8o=c9TV6arYd=sOTOM8BS37cgV+oO8LBjLwb1Za9NZnA+Q@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] KVM: selftests: Add skip_set facility to
 get_reg_list test
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
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
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

On Sat, Jul 1, 2023 at 10:28=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sat, Jul 01, 2023 at 09:42:59PM +0800, Haibo Xu wrote:
> > Add new skips_set members to vcpu_reg_sublist so as to skip
> > set operation on some registers.
> >
> > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/get-reg-list.c    | 20 +++++++++++++------
> >  .../selftests/kvm/include/kvm_util_base.h     |  2 ++
> >  2 files changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing=
/selftests/kvm/get-reg-list.c
> > index 74fb6f6fdd09..1a32a900aeea 100644
> > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > @@ -157,6 +157,7 @@ static void run_test(struct vcpu_reg_list *c)
> >  {
> >       int new_regs =3D 0, missing_regs =3D 0, i, n;
> >       int failed_get =3D 0, failed_set =3D 0, failed_reject =3D 0;
> > +     int skipped_set =3D 0;
> >       struct kvm_vcpu *vcpu;
> >       struct kvm_vm *vm;
> >       struct vcpu_reg_sublist *s;
> > @@ -210,7 +211,7 @@ static void run_test(struct vcpu_reg_list *c)
> >                       .id =3D reg_list->reg[i],
> >                       .addr =3D (__u64)&addr,
> >               };
> > -             bool reject_reg =3D false;
> > +             bool reject_reg =3D false, skip_reg =3D false;
> >               int ret;
> >
> >               ret =3D __vcpu_get_reg(vcpu, reg_list->reg[i], &addr);
> > @@ -221,8 +222,8 @@ static void run_test(struct vcpu_reg_list *c)
> >                       ++failed_get;
> >               }
> >
> > -             /* rejects_set registers are rejected after KVM_ARM_VCPU_=
FINALIZE */
> >               for_each_sublist(c, s) {
> > +                     /* rejects_set registers are rejected for set ope=
ration */
> >                       if (s->rejects_set && find_reg(s->rejects_set, s-=
>rejects_set_n, reg.id)) {
> >                               reject_reg =3D true;
> >                               ret =3D __vcpu_ioctl(vcpu, KVM_SET_ONE_RE=
G, &reg);
> > @@ -234,9 +235,16 @@ static void run_test(struct vcpu_reg_list *c)
> >                               }
> >                               break;
> >                       }
> > +
> > +                     /* skips_set registers are skipped for set operat=
ion */
> > +                     if (s->skips_set && find_reg(s->skips_set, s->ski=
ps_set_n, reg.id)) {
> > +                             skip_reg =3D true;
> > +                             ++skipped_set;
> > +                             break;
> > +                     }
> >               }
> >
> > -             if (!reject_reg) {
> > +             if (!reject_reg && !skip_reg) {
> >                       ret =3D __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg)=
;
> >                       if (ret) {
> >                               printf("%s: Failed to set ", config_name(=
c));
> > @@ -281,9 +289,9 @@ static void run_test(struct vcpu_reg_list *c)
> >       }
> >
> >       TEST_ASSERT(!missing_regs && !failed_get && !failed_set && !faile=
d_reject,
> > -                 "%s: There are %d missing registers; "
> > -                 "%d registers failed get; %d registers failed set; %d=
 registers failed reject",
> > -                 config_name(c), missing_regs, failed_get, failed_set,=
 failed_reject);
> > +                 "%s: There are %d missing registers; %d registers fai=
led get; "
> > +                 "%d registers failed set; %d registers failed reject;=
 %d registers skipped set",
> > +                 config_name(c), missing_regs, failed_get, failed_set,=
 failed_reject, skipped_set);
> >
> >       pr_info("%s: PASS\n", config_name(c));
> >       blessed_n =3D 0;
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tool=
s/testing/selftests/kvm/include/kvm_util_base.h
> > index e4480049000d..67c031fe89a1 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > @@ -134,6 +134,8 @@ struct vcpu_reg_sublist {
> >       __u64 regs_n;
> >       __u64 *rejects_set;
> >       __u64 rejects_set_n;
> > +     __u64 *skips_set;
> > +     __u64 skips_set_n;
> >  };
> >
> >  struct vcpu_reg_list {
> > --
> > 2.34.1
> >
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks!
