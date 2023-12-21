Return-Path: <linux-kselftest+bounces-2293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CF381ACD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 03:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CD01C22AE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 02:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3A3D9F;
	Thu, 21 Dec 2023 02:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epYHyAl7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCB24691;
	Thu, 21 Dec 2023 02:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cc259392a6so2918521fa.2;
        Wed, 20 Dec 2023 18:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703127533; x=1703732333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bBzkO/x8C7pW+ybw+V7AQ5yP+2vx9qyk2y1ClRHSZw=;
        b=epYHyAl7TiA75ynKga5al2BKz1HG4HUHczes0Xfbr3Z+dTwcBCehybaT4KHMWS10uO
         yG9alFvIbmjCL64lHfimte6bpdTeyQNQs5S2oMZqS+OVuFJ4+f+1oLvUvUZEMDKtIjpi
         TSBI10xhk/jW1ddVgR3YG6VUtUJa+TDpzL5FEKgfE9UXdImGQwatqGZG9O0wlmgfol0x
         vr9GEPdtVRIWpMrEJImxDzIIUmzzVsFBl/iRCre8JdPiakhjPQwNWKsxfZlFU53offK5
         yEusJCTZ0/ybWG3cepjXmIbxkREi2ipognsGq3yWwFIue1P1/Bfx2IRU6X4IYzWR6gtg
         e0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703127533; x=1703732333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bBzkO/x8C7pW+ybw+V7AQ5yP+2vx9qyk2y1ClRHSZw=;
        b=HYd+ibw9j9lph2x+VxtCKy2IP16IgMlC4D99D8IM8Rs7iPBs/WZThE8djeUr04+R0m
         sOw5BP47/7Ow2b3biS4CI1UeOttLSCKAuEJ5vupTjXoOjRvp+Rbjna/JPXiJQjlr0acy
         c4t7/FCPKH76K1En4jmJVfngL+ny1BsQvyVxEcyIVYm0/jBcInAmiENETX3zf5xoO/iv
         KvSKe8rjdSl39cnAPZpKSZikiAJ/LTCWNevSNssip6gSuWRwXUbAxByYciG3syymNc1n
         57rRpyNAYfRiyqYTFN4kVPE8sQfCiOSMo5mMjwddo4q9tLl8cqjrs4AWXbI/YOXb4Nol
         +H9w==
X-Gm-Message-State: AOJu0YzPRXqDFqHi34JtY0kzBRzx/fQNYO43M1w7Vusm7othV2JUIL5c
	50bUN/NxwZMejgKrh7DkDUi9Jt1MDwvFG9T8yBI=
X-Google-Smtp-Source: AGHT+IGJHPrvnGt2Ru34bEuu9VEKW4Ddr4y1BwS+bbHJIUMRrvHhhF9Knr8M3TPrt5vBdMTPh9CciXS8rGxFOeFA2n4=
X-Received: by 2002:a2e:95d2:0:b0:2cc:7c8c:574b with SMTP id
 y18-20020a2e95d2000000b002cc7c8c574bmr1956176ljh.77.1703127532313; Wed, 20
 Dec 2023 18:58:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702371136.git.haibo1.xu@intel.com> <0343a9e4bfa8011fbb6bca0286cee7eab1f17d5d.1702371136.git.haibo1.xu@intel.com>
 <8734vy832j.wl-maz@kernel.org> <CAJve8onc0WN5g98aOVBmJx15wFBAqfBKJ+ufoLY+oqYyVL+=3A@mail.gmail.com>
 <f98879dc24f948f7a8a7b5374a32bc04@kernel.org> <CAJve8ona7g=LxW1YeRB_FqGodF973H=A3b2m8054gmzK=Z7_ww@mail.gmail.com>
 <87zfy5t1qt.wl-maz@kernel.org>
In-Reply-To: <87zfy5t1qt.wl-maz@kernel.org>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Thu, 21 Dec 2023 10:58:40 +0800
Message-ID: <CAJve8o=nTsAwwgSib4vOLXjOWSMV2+J+BFsUZ57OdAK7eW8q8A@mail.gmail.com>
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

On Wed, Dec 20, 2023 at 9:58=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Wed, 20 Dec 2023 13:51:24 +0000,
> Haibo Xu <xiaobo55x@gmail.com> wrote:
> >
> > On Wed, Dec 20, 2023 at 5:00=E2=80=AFPM Marc Zyngier <maz@kernel.org> w=
rote:
> > >
> > > On 2023-12-20 06:50, Haibo Xu wrote:
> > > > On Wed, Dec 20, 2023 at 2:22=E2=80=AFAM Marc Zyngier <maz@kernel.or=
g> wrote:
> > > >>
> > > >> On Tue, 12 Dec 2023 09:31:20 +0000,
> > > >> Haibo Xu <haibo1.xu@intel.com> wrote:
> > > >> > diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/=
tools/testing/selftests/kvm/include/timer_test.h
> > > >> > index 968257b893a7..b1d405e7157d 100644
> > > >> > --- a/tools/testing/selftests/kvm/include/timer_test.h
> > > >> > +++ b/tools/testing/selftests/kvm/include/timer_test.h
> > > >> > @@ -22,6 +22,7 @@ struct test_args {
> > > >> >       int nr_iter;
> > > >> >       int timer_period_ms;
> > > >> >       int migration_freq_ms;
> > > >> > +     int timer_err_margin_us;
> > > >>
> > > >> ... except that you are storing it as a signed value. Some consist=
ency
> > > >> wouldn't hurt, really, and would avoid issues when passing large
> > > >> values.
> > > >>
> > > >
> > > > Yes, it's more proper to use an unsigned int for the non-negative e=
rror
> > > > margin.
> > > > Storing as signed here is just to keep the type consistent with tha=
t
> > > > of timer_period_ms
> > > > since there will be '+' operation in other places.
> > > >
> > > >         tools/testing/selftests/kvm/aarch64/arch_timer.c
> > > >         /* Setup a timeout for the interrupt to arrive */
> > > >          udelay(msecs_to_usecs(test_args.timer_period_ms) +
> > > >              test_args.timer_err_margin_us);
> > >
> > > But that's exactly why using a signed quantity is wrong.
> > > What does it mean to have a huge *negative* margin?
> > >
> >
> > Hi Marc,
> >
> > I agree that negative values are meaningless for the margin.
> > If I understand correctly, the negative margin should be filtered by
> > assertion in atoi_non_negative().
>
> No. Please.
>
> atoi_non_negative() returns a uint32_t, which is what it should do.
> The bug is squarely in the use of an 'int' to store such value, and it
> is the *storage* that turns a positive value into a negative one.
>

Thanks for the detailed info!

May I understand that your concern is mainly for a platform with 64bit int =
type,
which may trigger the positive to negative convert?

If so, I think we may need to do a clean up for the test code since
several other
places have the same issue.

Regards,
Haibo

>         M.
>
> --
> Without deviation from the norm, progress is not possible.

