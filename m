Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289FA72BE42
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbjFLKDQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjFLKB0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 06:01:26 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F9F3598;
        Mon, 12 Jun 2023 02:44:39 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b16cbe4fb6so2714334a34.1;
        Mon, 12 Jun 2023 02:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686563078; x=1689155078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxkf6jrO4dEZx2mwSY4xMRu+z/wFzxrSpMsDqPXhZ5o=;
        b=W66LBfOWiiTsiZ/jfv9BUP8aQ4UfXXP7S7asvtInvAZ0+41KbPzHcmy+DZbscCDnCs
         J0VsiXPFg7xu6lz+cGKwTFsn6EJM/iPxDuG/08DA0toBY3blImbX8Ar1cPBN6OUUkl1Z
         E5Cw5qfEpazhmrnDES7MzPWC29a6FXJRN0xcKUtwEf0++rZL5U/c9Enzu1vC8wFAQp3r
         Tla5PgbfaXjpxm9AM1Ffyu9eId7z9ELqBGA2mhu73RxrC0HdT5YzwA5jRvDu2hrLFPxF
         R3ssFuKYAfdKEjA/N3KJOTQ7/V0CejatMjwjb1g5llwpK/SGadIr9K6S1er5ehndO0OQ
         gnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563078; x=1689155078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxkf6jrO4dEZx2mwSY4xMRu+z/wFzxrSpMsDqPXhZ5o=;
        b=A95eWnQz7V/uGUtu0S7bDXnbwPKi0Mus7rnL8NSd3ldR1i5qZDaorxIdJ7xdGaSoIq
         k72E/2aWfiE7vRQBwBSlHQb3FRtO2gFWIhrZvschChFfQIIAQtervhiyO+CYyli63K0E
         rQMFvv4oUUTvS0tBe2a98M/fGnvAU17CFhAMDIbLKlT3d4L5vNvOfsw8Sx3h6aIptD5r
         QDdN9UZyKZQx+Z1XqAZeax0aimPyWpJAh7OQA+B2WKMDxUgrEy72UI2CApOyWGk56IjW
         KPsEj1NQfm0rj+9+3fryYgs3NCjLhUyRJxdV97xJXI5OuWrXUYeUYUQ6X6xH1UYs263/
         pMHQ==
X-Gm-Message-State: AC+VfDy5s7f8nvIDm2C7/ZxgAnb7ceqwDnIQK75HuiC582gqtcTTuh/g
        hq882F+AQ3FwO/CR3ZiiiiXC3d2SIHOkoEcZvs8=
X-Google-Smtp-Source: ACHHUZ7x6+asQtR9uojrnXOYMbtxE9WXKqmvAG5Y58QN3Q+1M9AvT+ew0zEvisqgZmSNnEvIcddaaMqz+PXoYqJFll8=
X-Received: by 2002:a05:6808:189e:b0:396:40c4:a2ef with SMTP id
 bi30-20020a056808189e00b0039640c4a2efmr4005165oib.11.1686563078478; Mon, 12
 Jun 2023 02:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686275310.git.haibo1.xu@intel.com> <73045958d9ab71d5266d012f1e13061afa8c5331.1686275310.git.haibo1.xu@intel.com>
 <20230609-05521f954b0485c69612f00b@orel> <CAJve8omPV_XgCSvw8POZwisb6uTOFMJU4FyAKArryui2SAsqtw@mail.gmail.com>
 <20230612-05314de3b73277af1ee729b0@orel>
In-Reply-To: <20230612-05314de3b73277af1ee729b0@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Mon, 12 Jun 2023 17:44:27 +0800
Message-ID: <CAJve8om8tjsXejtBWjuSg+kCUgfDdzq2AS2abC0qx9q2a7eSQw@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] KVM: riscv: selftests: Skip some registers set operation
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

On Mon, Jun 12, 2023 at 4:57=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sat, Jun 10, 2023 at 10:35:24AM +0800, Haibo Xu wrote:
> > On Fri, Jun 9, 2023 at 5:24=E2=80=AFPM Andrew Jones <ajones@ventanamicr=
o.com> wrote:
> > >
> > > On Fri, Jun 09, 2023 at 10:12:17AM +0800, Haibo Xu wrote:
> > > > Set operation on some riscv registers(mostly pesudo ones) was not
> > > > supported and should be skipped in the get-reg-list test. Just
> > > > reuse the rejects_set utilities to handle it in riscv.
> > > >
> > > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > ---
> > > >  tools/testing/selftests/kvm/get-reg-list.c | 20 +++++++++++++-----=
--
> > > >  1 file changed, 13 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/tes=
ting/selftests/kvm/get-reg-list.c
> > > > index c4bd5a5259da..abacb95c21c6 100644
> > > > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > > > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > > > @@ -211,16 +211,22 @@ static void run_test(struct vcpu_reg_list *c)
> > > >                       ++failed_get;
> > > >               }
> > > >
> > > > -             /* rejects_set registers are rejected after KVM_ARM_V=
CPU_FINALIZE */
> > > > +             /*
> > > > +              * rejects_set registers are rejected after KVM_ARM_V=
CPU_FINALIZE on aarch64,
> > > > +              * or registers that should skip set operation on ris=
cv.
> > > > +              */
> > > >               for_each_sublist(c, s) {
> > > >                       if (s->rejects_set && find_reg(s->rejects_set=
, s->rejects_set_n, reg.id)) {
> > > >                               reject_reg =3D true;
> > > > -                             ret =3D __vcpu_ioctl(vcpu, KVM_SET_ON=
E_REG, &reg);
> > > > -                             if (ret !=3D -1 || errno !=3D EPERM) =
{
> > > > -                                     printf("%s: Failed to reject =
(ret=3D%d, errno=3D%d) ", config_name(c), ret, errno);
> > > > -                                     print_reg(config_name(c), reg=
.id);
> > > > -                                     putchar('\n');
> > > > -                                     ++failed_reject;
> > > > +                             if ((reg.id & KVM_REG_ARCH_MASK) =3D=
=3D KVM_REG_ARM64) {
> > > > +                                     ret =3D __vcpu_ioctl(vcpu, KV=
M_SET_ONE_REG, &reg);
> > > > +                                     if (ret !=3D -1 || errno !=3D=
 EPERM) {
> > > > +                                             printf("%s: Failed to=
 reject (ret=3D%d, errno=3D%d) ",
> > > > +                                                             confi=
g_name(c), ret, errno);
> > > > +                                             print_reg(config_name=
(c), reg.id);
> > > > +                                             putchar('\n');
> > > > +                                             ++failed_reject;
> > > > +                                     }
> > >
> > > Thinking about this some more, shouldn't we attempt the set ioctl for
> > > riscv reject registers as well, but look for different error numbers?
> > >
> >
> > Yes, we can. Currently, 2 different errno(EOPNOTSUPP/EINVAL) would be
> > reported for the rejected registers in risc-v.
> > These 2 errnos can be handled specially like below:
> >
> > diff --git a/tools/testing/selftests/kvm/get-reg-list.c
> > b/tools/testing/selftests/kvm/get-reg-list.c
> > index 73f40e0842b8..f3f2c4519318 100644
> > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > @@ -255,6 +255,15 @@ static void run_test(struct vcpu_reg_list *c)
> >                                                 putchar('\n');
> >                                                 ++failed_reject;
> >                                         }
> > +                } else {
> > +                                       ret =3D __vcpu_ioctl(vcpu,
> > KVM_SET_ONE_REG, &reg);
> > +                                       if (ret !=3D -1 || (errno !=3D
> > EINVAL && errno !=3D EOPNOTSUPP)) {
> > +                                               printf("%s: Failed to
> > reject (ret=3D%d, errno=3D%d) ",
> > +
> > config_name(c), ret, errno);
> > +
> > print_reg(config_name(c), reg.id);
> > +                                               putchar('\n');
> > +                                               ++failed_reject;
> > +                                       }
>
> Instead of duplicating the code Arm uses, we just need an errno check
> function, preferably one that takes the register as an input, so we
> can check for specific errnos for specific registers.
>
> >
> > One possible issue for the above change is that when new registers
> > that don't support sets were added, we need
> > to add them to the reject registers list, or the test would fail.
> >
> > Initially, in the v1 patch, the design was to just skip the EOPNOTSUPP
> > errno in set operations for all registers
> > since it's a known errno for registers that don't support sets. This
> > change cover all the registers even for future
> > new ones.
> >
> > What's your opinion?
>
> I think we should only do the get/set tests on present, blessed list
> registers, since if it's a new register we don't know its capabilities.
>
> So, instead of
>
>   for_each_reg(i) {
>      /* get/set tests */
>   }
>
> we do
>
>   for_each_present_blessed_reg(i) {
>      /* get/set tests */
>   }
>
> where we have
>
>  #define for_each_present_blessed_reg(i) \
>      for ((i) =3D 0; (i) < blessed_n; ++(i)) \
>          if (find_reg(reg_list->reg, reg_list->n, blessed_reg[i]))
>
>
> Changing run_test() to work this way should be a separate patch.
>

Good idea! let me have a try.

Thanks,
Haibo

> Thanks,
> drew
