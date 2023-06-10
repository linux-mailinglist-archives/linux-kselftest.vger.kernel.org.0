Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C372772A87B
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 04:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjFJCfh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 22:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjFJCfh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 22:35:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3369235B3;
        Fri,  9 Jun 2023 19:35:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-65314ee05c6so2103964b3a.1;
        Fri, 09 Jun 2023 19:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686364535; x=1688956535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+cQ2OwbycVyxFVqiOSniKxXaS+hWOW1t5Cl7Mhvz3A=;
        b=Kb6eH8l3yhks8jc06qIZNQE1A8b6Q8s5z7YxYMQtG84G5idJNCwHY54K2aO+07BVS5
         kVtoqyGLMuNUelZqpalq41FDA8pNkYCcXjCVGGBapbfFqUJ4WSsdkvz7PCNssfTj/Xa8
         5MeFd1LjBHZo35Zu32oCkV1iO99HnUueFmuPioQlNu6KFlTDvjXnvErrqP+mmyAkZtbF
         gka37/1OCMSyGaD6KC6epfW2C0i/wirz53++DZI0bR0cNqJfWjqW/1PpEyU5NZDpv7O0
         CnKTY14bKBRCa5kXDZSvXPOsmMxbMOpwlAqTcIhkUC/6dIUhbTKPiD7sS5/BZgVX7Mvt
         xkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686364535; x=1688956535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+cQ2OwbycVyxFVqiOSniKxXaS+hWOW1t5Cl7Mhvz3A=;
        b=XRMb230QOqwq7aOVqVp4EQ/mssGd75/Hh08god+OrQ//ZVgyukOCSRUgBja138j3q0
         F2lNaiXZWjWn2jif9Wfkgvr/348bklRcFMRalecCcS0+MRELeJoHzf/+VeMHe8kUzlZI
         ZKY5Efi3OOcFK4stNFTQgoFGp8LB4ZAsQWHHmzjKmIpGTjAfV1Eu65eRNTIe+HU7p2sy
         MFrQmVfIgO5Zsi57HZEV3ei0Ly88r3DOGQWH+2a8gCm3gtxjYmEz1wnXai0Xves86AYh
         dbQ0NE+VynBBYykUx4QDfMwyACgGYGbYb1J/DIsMgp6y28S2aWkhAWHlnC1RJLcE5Qkw
         8Cww==
X-Gm-Message-State: AC+VfDyjD5MeFZF+zw1C+KCPVMBzTvNgY/B+MtemiDhCzGv+EG8NcKOH
        EtCWSHFL6cj9bgzoUX7tIisLZUKCLxLqTJHQ32c=
X-Google-Smtp-Source: ACHHUZ6rNnkh2m1Yt4Pj3/pGOqJ4UHP9zSc6CE3jFoWY+FrVfA5ENGv5ysmIcDXuIOSFDb9BxkKoP9BiytTg0kXa/dU=
X-Received: by 2002:a05:6a20:e616:b0:105:94e5:f5c5 with SMTP id
 my22-20020a056a20e61600b0010594e5f5c5mr2595006pzb.56.1686364535616; Fri, 09
 Jun 2023 19:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686275310.git.haibo1.xu@intel.com> <73045958d9ab71d5266d012f1e13061afa8c5331.1686275310.git.haibo1.xu@intel.com>
 <20230609-05521f954b0485c69612f00b@orel>
In-Reply-To: <20230609-05521f954b0485c69612f00b@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Sat, 10 Jun 2023 10:35:24 +0800
Message-ID: <CAJve8omPV_XgCSvw8POZwisb6uTOFMJU4FyAKArryui2SAsqtw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 9, 2023 at 5:24=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Fri, Jun 09, 2023 at 10:12:17AM +0800, Haibo Xu wrote:
> > Set operation on some riscv registers(mostly pesudo ones) was not
> > supported and should be skipped in the get-reg-list test. Just
> > reuse the rejects_set utilities to handle it in riscv.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  tools/testing/selftests/kvm/get-reg-list.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing=
/selftests/kvm/get-reg-list.c
> > index c4bd5a5259da..abacb95c21c6 100644
> > --- a/tools/testing/selftests/kvm/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/get-reg-list.c
> > @@ -211,16 +211,22 @@ static void run_test(struct vcpu_reg_list *c)
> >                       ++failed_get;
> >               }
> >
> > -             /* rejects_set registers are rejected after KVM_ARM_VCPU_=
FINALIZE */
> > +             /*
> > +              * rejects_set registers are rejected after KVM_ARM_VCPU_=
FINALIZE on aarch64,
> > +              * or registers that should skip set operation on riscv.
> > +              */
> >               for_each_sublist(c, s) {
> >                       if (s->rejects_set && find_reg(s->rejects_set, s-=
>rejects_set_n, reg.id)) {
> >                               reject_reg =3D true;
> > -                             ret =3D __vcpu_ioctl(vcpu, KVM_SET_ONE_RE=
G, &reg);
> > -                             if (ret !=3D -1 || errno !=3D EPERM) {
> > -                                     printf("%s: Failed to reject (ret=
=3D%d, errno=3D%d) ", config_name(c), ret, errno);
> > -                                     print_reg(config_name(c), reg.id)=
;
> > -                                     putchar('\n');
> > -                                     ++failed_reject;
> > +                             if ((reg.id & KVM_REG_ARCH_MASK) =3D=3D K=
VM_REG_ARM64) {
> > +                                     ret =3D __vcpu_ioctl(vcpu, KVM_SE=
T_ONE_REG, &reg);
> > +                                     if (ret !=3D -1 || errno !=3D EPE=
RM) {
> > +                                             printf("%s: Failed to rej=
ect (ret=3D%d, errno=3D%d) ",
> > +                                                             config_na=
me(c), ret, errno);
> > +                                             print_reg(config_name(c),=
 reg.id);
> > +                                             putchar('\n');
> > +                                             ++failed_reject;
> > +                                     }
>
> Thinking about this some more, shouldn't we attempt the set ioctl for
> riscv reject registers as well, but look for different error numbers?
>

Yes, we can. Currently, 2 different errno(EOPNOTSUPP/EINVAL) would be
reported for the rejected registers in risc-v.
These 2 errnos can be handled specially like below:

diff --git a/tools/testing/selftests/kvm/get-reg-list.c
b/tools/testing/selftests/kvm/get-reg-list.c
index 73f40e0842b8..f3f2c4519318 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -255,6 +255,15 @@ static void run_test(struct vcpu_reg_list *c)
                                                putchar('\n');
                                                ++failed_reject;
                                        }
+                } else {
+                                       ret =3D __vcpu_ioctl(vcpu,
KVM_SET_ONE_REG, &reg);
+                                       if (ret !=3D -1 || (errno !=3D
EINVAL && errno !=3D EOPNOTSUPP)) {
+                                               printf("%s: Failed to
reject (ret=3D%d, errno=3D%d) ",
+
config_name(c), ret, errno);
+
print_reg(config_name(c), reg.id);
+                                               putchar('\n');
+                                               ++failed_reject;
+                                       }

One possible issue for the above change is that when new registers
that don't support sets were added, we need
to add them to the reject registers list, or the test would fail.

Initially, in the v1 patch, the design was to just skip the EOPNOTSUPP
errno in set operations for all registers
since it's a known errno for registers that don't support sets. This
change cover all the registers even for future
new ones.

What's your opinion?

Thanks,
Haibo
> Thanks,
> drew
