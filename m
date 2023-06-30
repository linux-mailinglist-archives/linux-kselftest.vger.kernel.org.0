Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0435D7432DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 04:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjF3Cr4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 22:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjF3Crz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 22:47:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F230D1;
        Thu, 29 Jun 2023 19:47:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id ffacd0b85a97d-311099fac92so1649499f8f.0;
        Thu, 29 Jun 2023 19:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688093272; x=1690685272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN5yxbuJ2nnYnl/4YBa8slTNyYfmpUDhYSEL5xstQsU=;
        b=IUaTt8TcLWNzXn8Ey8PCwkSOyValaLJHNsJBzfJ8c8VFkXDXWZ07DZAYAyY8ZpyG+D
         ViyKdbolLZuN3acuoZPui7va0jpo92CmUUIR/E7PR4LuPuZ/dAWAmpRWYosYBlh7+UXN
         SbsW85y6oTB4jNWi3r6NOH6/5NH8WmCp+PHbpfVjulKWtWdG30+EdGEfcyAzSfV0zRVP
         BTcIyC28klTeW45HEmkwSpo9CSqIcb1O9J4m64qHMGD47BrK1KM43qXMEAlbWKWW/g/d
         dLFlS0reoxJD2v1Q0NAKPAhoCVlf93BZoE/wJRWSISQssl9GtJnZi4AwMUJS8dA7GITJ
         i1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688093272; x=1690685272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN5yxbuJ2nnYnl/4YBa8slTNyYfmpUDhYSEL5xstQsU=;
        b=VQw18THOx28CsTP5o/yyu2WuJzMh6j1EWXH60pOUu6SQ2BAwkRFMMVjbrL7BA2V/Kx
         PmfOGDt309dI1tE0ivl6Rieivvp/qgJ1PA1pBAeFLVL+JwWhs2ME6gxDMuIqc+HdmKY4
         gMyY26bX19oZEZVUKrMCyi9ORREnRtmSFKSKtwa3OnxI57TGKGF5pYDpXT6UuwgJVVtL
         3vzZWzYlyU03gfGLUm3EnUohNmOZrWj0RK0eLLE2PR3oZwT1AEpAAMgDT7IFTe3N+gwM
         U2R/aqXz3rZtERQ/gpGG8EESABtLFlNaKKu2Ytto+asq+MZ7fTTMGsSMpsCaoP8GOwk+
         OZHw==
X-Gm-Message-State: ABy/qLa3kZ5xV4GJTz1Ou8Cu6J4FXhGWODDZ+M6zq4AsILw6oSCTi2zn
        hT9/nufL/tbu2htBuF23Ua4I+ODGqRR0U0OyPp8=
X-Google-Smtp-Source: APBJJlG2XSLJk7WgprfL+OPvH4/Ws0gRTftzgVG3a1nA2jukp+WyKKCCC6yZ9QwKgrCuixwdMY5UR+sy3rDqqsFm9rU=
X-Received: by 2002:a5d:514d:0:b0:313:e20c:b8e0 with SMTP id
 u13-20020a5d514d000000b00313e20cb8e0mr921811wrt.23.1688093272424; Thu, 29 Jun
 2023 19:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230607123700.40229-1-cloudliang@tencent.com>
 <20230607123700.40229-2-cloudliang@tencent.com> <ZJyj3QDu9eAtJ+eq@google.com>
In-Reply-To: <ZJyj3QDu9eAtJ+eq@google.com>
From:   Jinrong Liang <ljr.kernel@gmail.com>
Date:   Fri, 30 Jun 2023 10:47:40 +0800
Message-ID: <CAFg_LQVtcBaO-=dvrqe7OjMqift__x-F6FeJ8EEUh+Ei-tgyhg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] KVM: selftests: Introduce __kvm_pmu_event_filter
 to improved event filter settings
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Sean Christopherson <seanjc@google.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8829=
=E6=97=A5=E5=91=A8=E5=9B=9B 05:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jun 07, 2023, Jinrong Liang wrote:
> > -static struct kvm_pmu_event_filter *remove_event(struct kvm_pmu_event_=
filter *f,
> > +static struct kvm_pmu_event_filter *remove_event(struct __kvm_pmu_even=
t_filter *__f,
> >                                                uint64_t event)
>
> Can you tack on a patch to drop the return?  None of the callers consume =
it, and
> it incorrectly implies that the incoming filter isn't modified.

Thank you very much for your suggestion! I'm more than happy to follow
your advice and modify the code accordingly.

>
> >  {
> >       bool found =3D false;
> >       int i;
> > +     struct kvm_pmu_event_filter *f =3D (void *)__f;
>
> Nit, reverse xmas tree is preferred:
>
>         struct kvm_pmu_event_filter *f =3D (void *)__f;
>         bool found =3D false;
>         int i;
>
> Hoever, I don't think this one needs to cast, the cast is only necessary =
when
> invoking a KVM ioctl(), e.g. I believe this should work:
>
> static void remove_event(struct __kvm_pmu_event_filter *f, uint64_t event=
)
> {
>         bool found =3D false;
>         int i;
>
>         for (i =3D 0; i < f->nevents; i++) {
>                 if (found)
>                         f->events[i - 1] =3D f->events[i];
>                 else
>                         found =3D f->events[i] =3D=3D event;
>         }
>         if (found)
>                 f->nevents--;
> }
> > @@ -569,19 +554,16 @@ static void run_masked_events_test(struct kvm_vcp=
u *vcpu,
> >                                  const uint64_t masked_events[],
> >                                  const int nmasked_events)
> >  {
> > -     struct kvm_pmu_event_filter *f;
> > +     struct __kvm_pmu_event_filter f =3D {
> > +         .nevents =3D nmasked_events,
> > +         .action =3D KVM_PMU_EVENT_ALLOW,
> > +         .flags =3D KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
>
> Tabs, not spaces please.
>
> > +static int set_pmu_single_event_filter(struct kvm_vcpu *vcpu, uint64_t=
 event,
> > +                                    uint32_t flags, uint32_t action)
> > +{
> > +     struct __kvm_pmu_event_filter f =3D {
> > +         .nevents =3D 1,
> > +         .flags =3D flags,
> > +         .action =3D action,
> > +         .events =3D {
> > +             event,
>
> Tabs.

I will include these change in the new patch version and ensure that
any related code is adjusted accordingly.

Once again, I truly appreciate your guidance!
