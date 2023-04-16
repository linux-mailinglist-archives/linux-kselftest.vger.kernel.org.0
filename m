Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BFB6E349A
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Apr 2023 02:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDPAZy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Apr 2023 20:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjDPAZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Apr 2023 20:25:53 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8EF35A9;
        Sat, 15 Apr 2023 17:25:52 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dx24so11056814ejb.11;
        Sat, 15 Apr 2023 17:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681604751; x=1684196751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AikccuILl/rWwVlUOcy4wtolB2YL8IX34+EVMpD42sg=;
        b=dPCVE1VQ9k0Cuu8quWGycURV9SGO5kqGK2tGTmoickhgMNDpDqcBvl5IcL+XDpuhl3
         cOWkJWembdBu9WvJy52kUQA2ZSXBiRBiKCBqFVzjviJFVC9Brxy3iw/ErGO6jsBpHYk3
         S8G4PAKdZopqWjA7S4NdtvXkORXKKQqN1OI20eQ3ILhOJAwlk2Bal7PjzFxSuXSc1CQ8
         Ttlog++cOP2dT+V1t2hhXvarZyGaZvsQqW6cK2Gjry3vMUL53+d15wQ4UOagzze5+Fat
         x9ohAczNH1lDYPkB1IjdaaQ88fmk6W9MLBV72LT8BTvwgcYPdUH861TPzTUgvKIek4QS
         cYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681604751; x=1684196751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AikccuILl/rWwVlUOcy4wtolB2YL8IX34+EVMpD42sg=;
        b=TDRuc3NbJGuq0JPeJ1jmJ65fkcyIA3PxSKVXzdQML8MZ9aTf8CpGkPGe1na93cWLHk
         /ZOMUIwDNDAbbF1h8e6/cS2Je8vQsDEeNqd9NobF0PlmrkxzRMoiNlkakQY571UCUHHR
         UQgtHRXlGEkAlqD0q2zZihADBbEVlGX6PsrCkTjUXLiAEXSykuA/MlvIPOkHx6Hzn6mD
         re/fUTr2evy/qRqoV3gHKB0AwOD+ZdcBAKrBsubYsfqUT4gb8HJAE38dFwFkvuLkeBtf
         iYA4mkb576PbGQBT3j6N1GvUTBEFPyAsEVjeiAEflWf5CRTX4hB5wIqOhlXhEwkWu1xz
         8S1g==
X-Gm-Message-State: AAQBX9dG8ZnyrBDQ+inO9hYaHLtfFoxKPZrpLeyHdvaeUVHpRQNkbpzN
        BgHYFnVQV7LzboFZ5fbXpH+pnwX9NSl75ObNV7E=
X-Google-Smtp-Source: AKy350bwAxk4mfYw5rLmjnhLo0oyAebJps3Rkaf2Za1xbwAMpcl5KBQjhfMpWZzvodcmJLLEgxG23DeILztqemeHW6Q=
X-Received: by 2002:a17:906:fcd8:b0:94e:2d:e94f with SMTP id
 qx24-20020a170906fcd800b0094e002de94fmr1597507ejb.8.1681604751315; Sat, 15
 Apr 2023 17:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230414110056.19665-1-cloudliang@tencent.com>
 <20230414110056.19665-5-cloudliang@tencent.com> <ZDoY1hOJfMwJk1SQ@debian.me>
In-Reply-To: <ZDoY1hOJfMwJk1SQ@debian.me>
From:   Jinrong Liang <ljr.kernel@gmail.com>
Date:   Sun, 16 Apr 2023 08:25:40 +0800
Message-ID: <CAFg_LQVLzXUhgOkzO780D1HmtLJ6topwPNQJTYXFbR9L7+X17Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] KVM: x86/pmu: Add documentation for fixed ctr on PMU filter
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8815=E6=
=97=A5=E5=91=A8=E5=85=AD 11:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Apr 14, 2023 at 07:00:53PM +0800, Jinrong Liang wrote:
> > +Specifically, KVM follows the following pseudo-code when determining w=
hether to
> > +allow the guest FixCtr[i] to count its pre-defined fixed event:
> > +
> > +  FixCtr[i]_is_allowed =3D (action =3D=3D ALLOW) && (bitmap & BIT(i)) =
||
> > +    (action =3D=3D DENY) && !(bitmap & BIT(i));
> > +  FixCtr[i]_is_denied =3D !FixCtr[i]_is_allowed;
> > +
>
> As kernel test robot has reported [1], you need to wrap the code above
> in a code block:

I will make the changes as you suggested, i.e. wrap the code above in
a code block.

Thanks.

>
> ---- >8 ----
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 036f5b1a39aff8..b5836767e0e76d 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5126,7 +5126,7 @@ Via this API, KVM userspace can also control the be=
havior of the VM's fixed
>  counters (if any) by configuring the "action" and "fixed_counter_bitmap"=
 fields.
>
>  Specifically, KVM follows the following pseudo-code when determining whe=
ther to
> -allow the guest FixCtr[i] to count its pre-defined fixed event:
> +allow the guest FixCtr[i] to count its pre-defined fixed event::
>
>    FixCtr[i]_is_allowed =3D (action =3D=3D ALLOW) && (bitmap & BIT(i)) ||
>      (action =3D=3D DENY) && !(bitmap & BIT(i));
>
> Thanks.
>
> [1]: https://lore.kernel.org/linux-doc/202304150850.rx4UDDsB-lkp@intel.co=
m/
>
> --
> An old man doll... just what I always wanted! - Clara
