Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23687102CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 04:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjEYCUB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 22:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbjEYCT6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 22:19:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569A112E;
        Wed, 24 May 2023 19:19:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso9037266b.0;
        Wed, 24 May 2023 19:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684981196; x=1687573196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S52oQA0/VeO5+jyq6l06Dvqhz2AgZ7EQ+KLBmziYDnM=;
        b=Fzva5FWVqV/5xC30wA4lZUgXN9VgTPyU6CQ26eRLuSjH1YI5JJZC+5cu5BTbuAOsYp
         3BJ96JISVhpgwQDkT7WDf8xvGVcfwskKILfV/xGolHelLuERNyIRTn+Kp95wT5Ihp5yP
         6t6uY6MUdalUBM5VYqm+0cblXix9FwkIG8TqrPITAPMIcfqQGHly4ueQvlyG5tpqDpz3
         Suc2h/8cyiPmp8WHhwqfyeD0VxCyv5TZ0fFC846O1Yl1cmIf9rHCiTACZLvOMO8XfJW8
         lmfZI9CNlEHaMqsOA6Q5YrjzW7r+3U8EJN9CZ8Qu6xbL+5iP18dwrdrq7r4ZqFdmm4J2
         /4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684981196; x=1687573196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S52oQA0/VeO5+jyq6l06Dvqhz2AgZ7EQ+KLBmziYDnM=;
        b=M+vmHsSyRYvqeVKIkG4Ccg4dimEngzsc9r1iKIne3bFBqznG5BjXzqCuMweDHbjiRB
         9cYcGcIeX+eibIeRhYTQN6h/pbTnSePxAQoR24kf3lB+3ac6iuzC4NWFa/44zzlCne1B
         giguUitWQ3ImwBOZo/UmgaHzmJF3WAKyllzoLZLnxo7rRiVo78vXQRLl1/HvT0WOYSH8
         COc9z1fHswKK9moHqmYtB6RQO4UTg7Ld+6s3CowE4aCvuB0/uASfhzgJfnguPIi0dR/s
         Mspp+1HW9Ecz58BXx2M3JEkdmYLiIRmGImwNfbsOLixSaUQOZO+Jf4zSIsX9ILmRkQz4
         h8Jg==
X-Gm-Message-State: AC+VfDyRmJ4GxP3p2F0fWTa6BDIubcTRujXxNXT2NH1+pFuyoLwozNpv
        GYkecdrN03IISLCik/RWsE5QJfyDTsubLK4r11o=
X-Google-Smtp-Source: ACHHUZ71v53srzTdEIill3Ck8fMuSehVnushOsYQveW7RfM+JUszp/kGVTpAsuq7kxIjPbKV9pie9hagRqd+/UH6fqk=
X-Received: by 2002:a17:906:6a0f:b0:969:e88a:6071 with SMTP id
 qw15-20020a1709066a0f00b00969e88a6071mr38037ejc.61.1684981195615; Wed, 24 May
 2023 19:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230420104622.12504-1-ljrcore@126.com> <20230420104622.12504-8-ljrcore@126.com>
 <ZG6i3sqOcZDg/UCG@google.com>
In-Reply-To: <ZG6i3sqOcZDg/UCG@google.com>
From:   Jinrong Liang <ljr.kernel@gmail.com>
Date:   Thu, 25 May 2023 10:19:44 +0800
Message-ID: <CAFg_LQWdSnNOd+VwTu8pQezL7qaN=4L_YffHVQUQWJiV5U76wQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] KVM: selftests: Test pmu event filter with
 incompatible kvm_pmu_event_filter
To:     Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Sean Christopherson <seanjc@google.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8825=
=E6=97=A5=E5=91=A8=E5=9B=9B 07:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Apr 20, 2023, Jinrong Liang wrote:
> > From: Jinrong Liang <cloudliang@tencent.com>
> >
> > From: Jinrong Liang <cloudliang@tencent.com>
> >
> > Add test to verify the behavior of the pmu event filter when an
> > incomplete kvm_pmu_event_filter structure is used. By running the
> > test, we can ensure that the pmu event filter correctly handles
> > incomplete structures and does not allow events to be counted when
> > they should not be.
> >
> > Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> > ---
> >  .../kvm/x86_64/pmu_event_filter_test.c        | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c=
 b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > index 9be4c6f8fb7e..a6b6e0d086ae 100644
> > --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> > @@ -881,6 +881,24 @@ static bool fixed_ctr_is_allowed(uint8_t idx, uint=
32_t action, uint32_t bitmap)
> >               (action =3D=3D KVM_PMU_EVENT_DENY && !(bitmap & BIT_ULL(i=
dx)));
> >  }
> >
> > +struct incompatible_pmu_event_filter {
> > +     __u32 action;
> > +     __u32 nevents;
> > +     __u32 fixed_counter_bitmap;
> > +};
> > +
> > +static uint64_t test_incompatible_filter(struct kvm_vcpu *vcpu, uint32=
_t action,
> > +                                      uint32_t bitmap)
> > +{
> > +     struct incompatible_pmu_event_filter err_f;
> > +
> > +     err_f.action =3D action;
> > +     err_f.fixed_counter_bitmap =3D bitmap;
> > +     ioctl((vcpu->vm)->fd, KVM_SET_PMU_EVENT_FILTER, &err_f.action);
>
> This is completely busted.  It "passes" by luck, not because it's a valid=
 test.
> The size of the argument is embedded in the IOCTL number itself, which me=
ans that
> unless glibc is being very nice and using a macro + typeof + sizeof to sa=
nity check
> things, which I highly doubt is the case, this ioctl() is passing random =
stack data,
> a.k.a. garbage, to KVM.
>
> In short, drop this patch.

Thank you for letting us know about the issues with the patch. I will
drop the patch as suggested. Would you advise me to prepare version 3
to remove this patch?
