Return-Path: <linux-kselftest+bounces-2260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B918C81A048
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 14:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329331F2974C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1EE358A5;
	Wed, 20 Dec 2023 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YejMj6yO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC538DD5;
	Wed, 20 Dec 2023 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc7d80324dso22215801fa.2;
        Wed, 20 Dec 2023 05:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703080296; x=1703685096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rei5fD9NGFINnaZoP+B7hv3sKvx8MD4zubiuSki3juc=;
        b=YejMj6yOZeG5bM5ZgEYx3UThHgaA25TGnd/euJ7ThvX4DSeA8xlKrMxqegGQdEUAQW
         duid4aS3Y/TsDAvr93C6YABOMX4j2L+eNu9jLpKYOTR8UbgY9he4PXjb/rHBQ+XshI5i
         ycmGejwhp++i20eHFmCQM5NbBYOqVgu9IY07Vct58knkckqEQniPq3bn2Z72ad1jJpiU
         8lefpUeJHnLwhXEzkEeF02fYPEGvMqOVU3aDWysCrxtt5bAd44o8u4+s00/vfOviHIvY
         AF7RlSoNthexes7OgjYM4b6/8YCZlazbr9HRI6gmknDjxApL6DwmmdHaaeKcmHKOR7GJ
         fW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703080296; x=1703685096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rei5fD9NGFINnaZoP+B7hv3sKvx8MD4zubiuSki3juc=;
        b=YfogNEFkhmxY7BvumRirQNkv8VCGusc/TxU5L0NIQBiU0Yk35xDwTkMbeAodSezI1V
         9RL8T81tXy1wbW1zXKbgwVQodNDDHlPZ/DLBVSM6/5pbhtbnUwAifm6OgfVwiIW2LycQ
         m8pM8nrAOdvsjpj0AKBLEeq0mWSrrkbkFxkHwh8+ODRr4ZciGK1/PcKcq5Xetv98TXjK
         Oy7WpvLHPH+q0bY7Kag6Zi2p8FbqPEwsI6U3Y4ATJQ8JPzmBu4FpJyY/LJWdkHq8RyS5
         PNQEOa3LJyLf6041komhHKzbvhPbtUKTzdCljP5XvuNdqaT9Dd0NG8E7Ei11UN+FDb2m
         2Lmw==
X-Gm-Message-State: AOJu0YzXfnM5LEyYGM+c3vCttZI49mViTBCP4oekqDha5PmeGAuyL8Y4
	2D7lR2JJJJyFJjsOnmVhxX0rhkpX23tnr8njlHA=
X-Google-Smtp-Source: AGHT+IGZec52dGpUhRR0rOVEDoEhnbeYTYNEvPvXIC1fF5bOhuW6KuhADUDrozoxLytShIKBvr4qyyNNDjrfwgJW9ik=
X-Received: by 2002:a05:651c:1055:b0:2cc:8481:f21e with SMTP id
 x21-20020a05651c105500b002cc8481f21emr712056ljm.39.1703080295789; Wed, 20 Dec
 2023 05:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702371136.git.haibo1.xu@intel.com> <0343a9e4bfa8011fbb6bca0286cee7eab1f17d5d.1702371136.git.haibo1.xu@intel.com>
 <8734vy832j.wl-maz@kernel.org> <CAJve8onc0WN5g98aOVBmJx15wFBAqfBKJ+ufoLY+oqYyVL+=3A@mail.gmail.com>
 <f98879dc24f948f7a8a7b5374a32bc04@kernel.org>
In-Reply-To: <f98879dc24f948f7a8a7b5374a32bc04@kernel.org>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Wed, 20 Dec 2023 21:51:24 +0800
Message-ID: <CAJve8ona7g=LxW1YeRB_FqGodF973H=A3b2m8054gmzK=Z7_ww@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] KVM: selftests: Enable tunning of err_margin_us
 in arch timer test
To: Marc Zyngier <maz@kernel.org>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Greentime Hu <greentime.hu@sifive.com>, 
	wchen <waylingii@gmail.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Heiko Stuebner <heiko@sntech.de>, Minda Chen <minda.chen@starfivetech.com>, 
	Samuel Holland <samuel@sholland.org>, Jisheng Zhang <jszhang@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>, 
	Vipin Sharma <vipinsh@google.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Aaron Lewis <aaronlewis@google.com>, 
	Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 5:00=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On 2023-12-20 06:50, Haibo Xu wrote:
> > On Wed, Dec 20, 2023 at 2:22=E2=80=AFAM Marc Zyngier <maz@kernel.org> w=
rote:
> >>
> >> On Tue, 12 Dec 2023 09:31:20 +0000,
> >> Haibo Xu <haibo1.xu@intel.com> wrote:
> >> > > @@ -216,6 +221,9 @@ static bool parse_args(int argc, char *argv[])
> >> >               case 'm':
> >> >                       test_args.migration_freq_ms =3D atoi_non_negat=
ive("Frequency", optarg);
> >> >                       break;
> >> > +             case 'e':
> >> > +                     test_args.timer_err_margin_us =3D atoi_non_neg=
ative("Error Margin", optarg);
> >> > +                     break;
> >>
> >> So your error margin is always unsigned...
> >>
> >
> > The error margin was supposed to be a non-negative [0, INT_MAX].
> > (May be need to define a Max for the input, instead of INT_MAX)
> >
> >> >               case 'o':
> >> >                       test_args.counter_offset =3D strtol(optarg, NU=
LL, 0);
> >> >                       test_args.reserved =3D 0;
> >> > diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tool=
s/testing/selftests/kvm/include/timer_test.h
> >> > index 968257b893a7..b1d405e7157d 100644
> >> > --- a/tools/testing/selftests/kvm/include/timer_test.h
> >> > +++ b/tools/testing/selftests/kvm/include/timer_test.h
> >> > @@ -22,6 +22,7 @@ struct test_args {
> >> >       int nr_iter;
> >> >       int timer_period_ms;
> >> >       int migration_freq_ms;
> >> > +     int timer_err_margin_us;
> >>
> >> ... except that you are storing it as a signed value. Some consistency
> >> wouldn't hurt, really, and would avoid issues when passing large
> >> values.
> >>
> >
> > Yes, it's more proper to use an unsigned int for the non-negative error
> > margin.
> > Storing as signed here is just to keep the type consistent with that
> > of timer_period_ms
> > since there will be '+' operation in other places.
> >
> >         tools/testing/selftests/kvm/aarch64/arch_timer.c
> >         /* Setup a timeout for the interrupt to arrive */
> >          udelay(msecs_to_usecs(test_args.timer_period_ms) +
> >              test_args.timer_err_margin_us);
>
> But that's exactly why using a signed quantity is wrong.
> What does it mean to have a huge *negative* margin?
>

Hi Marc,

I agree that negative values are meaningless for the margin.
If I understand correctly, the negative margin should be filtered by
assertion in atoi_non_negative().

Thanks,
Haibo

> I don't see how you can justify this.
>
>          M.
> --
> Jazz is not dead. It just smells funny...

