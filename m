Return-Path: <linux-kselftest+bounces-2251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ADE8198CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 07:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45691F25F02
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 06:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE11912B84;
	Wed, 20 Dec 2023 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBtA0US3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242BB15496;
	Wed, 20 Dec 2023 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cc5e48779aso47440151fa.2;
        Tue, 19 Dec 2023 22:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703055015; x=1703659815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IloV9gHlRpc9SD2YCXR7E/7T42jMVfD74Pty8sLbHvY=;
        b=YBtA0US3frW0Vzy5nLl8FnXaHxMswBZmnKrl9G3/uZOQQ4GveJYNLyGsV5+gcDXI9V
         J+ga22b2F3ZGQbpYEP/cYv+55S06vo6ADryV8pJmAJ66zEGv7wsnB46zF+C6oU0hkYM9
         /6um/pYXfH4h66Sxhk69FdCqoGrzt7StX6YSTikAk4sWwoZGuF3VP6RLVYXs6t0EBfHJ
         gU0eU8f+ToLWBTDTpU9GJ1UL1tDiR/eYDkz99GCPc+Xpyc5iQM3Lzxp4VbfXfH3lz/bX
         gjhEzsKnXFnU5BqR2kyMHk2uZi3rOYtY5ulBxULSFpIAs12cHcJqMLUulTGlKhc7yrJJ
         3oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703055015; x=1703659815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IloV9gHlRpc9SD2YCXR7E/7T42jMVfD74Pty8sLbHvY=;
        b=QwWG5ZTwMoOLKkjbe2c95tg9UihY8ARFMIAVx725A5NT/po8CyfduIUpEmUatEo4ZW
         f+fNAulBqhF029fFyPjrLP564W9jnlmpv/JuO/VwMJI226OHPgW6apiUqMM3zoKPvA6O
         C3iwwu7aXwbHmQmRgXWvDs+NZ3BBnhfK4xs/h1cwil4X43lv8yX3MVafTJ9wCbZh3rWu
         4SF+MHDCJ07wuDhlbLP6Upr0op4nr29zxQuNGi+hwxjU+/6RtDL0tYUZMLSD0LkYPFkf
         JPmYermAM4gx/vEf97ia0RDTV+e//aJsxGChVtEvTUi0M1Wd6UOtugm/H4mg2ZsV7UuI
         0XXw==
X-Gm-Message-State: AOJu0YxvEG9AoYgICe6ozrgI4u2WMrLaOjY5r4fzztBLeid8YDkSPIl9
	Z2dpEZ6IbIW48YGK6Et9maYIUUwB7n0/Mp8FX/A=
X-Google-Smtp-Source: AGHT+IGyXIZ1XsWlabej49gCsPyJXlY+x34WunG9S1gzJ848CgF23IrFQFyfhwjo//9JKJAadF2riryatJZtvHVMNgc=
X-Received: by 2002:a2e:b0dc:0:b0:2cc:895c:5de3 with SMTP id
 g28-20020a2eb0dc000000b002cc895c5de3mr338259ljl.207.1703055014949; Tue, 19
 Dec 2023 22:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702371136.git.haibo1.xu@intel.com> <0343a9e4bfa8011fbb6bca0286cee7eab1f17d5d.1702371136.git.haibo1.xu@intel.com>
 <8734vy832j.wl-maz@kernel.org>
In-Reply-To: <8734vy832j.wl-maz@kernel.org>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Wed, 20 Dec 2023 14:50:03 +0800
Message-ID: <CAJve8onc0WN5g98aOVBmJx15wFBAqfBKJ+ufoLY+oqYyVL+=3A@mail.gmail.com>
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

On Wed, Dec 20, 2023 at 2:22=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Tue, 12 Dec 2023 09:31:20 +0000,
> Haibo Xu <haibo1.xu@intel.com> wrote:
> > > @@ -216,6 +221,9 @@ static bool parse_args(int argc, char *argv[])
> >               case 'm':
> >                       test_args.migration_freq_ms =3D atoi_non_negative=
("Frequency", optarg);
> >                       break;
> > +             case 'e':
> > +                     test_args.timer_err_margin_us =3D atoi_non_negati=
ve("Error Margin", optarg);
> > +                     break;
>
> So your error margin is always unsigned...
>

The error margin was supposed to be a non-negative [0, INT_MAX].
(May be need to define a Max for the input, instead of INT_MAX)

> >               case 'o':
> >                       test_args.counter_offset =3D strtol(optarg, NULL,=
 0);
> >                       test_args.reserved =3D 0;
> > diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/t=
esting/selftests/kvm/include/timer_test.h
> > index 968257b893a7..b1d405e7157d 100644
> > --- a/tools/testing/selftests/kvm/include/timer_test.h
> > +++ b/tools/testing/selftests/kvm/include/timer_test.h
> > @@ -22,6 +22,7 @@ struct test_args {
> >       int nr_iter;
> >       int timer_period_ms;
> >       int migration_freq_ms;
> > +     int timer_err_margin_us;
>
> ... except that you are storing it as a signed value. Some consistency
> wouldn't hurt, really, and would avoid issues when passing large
> values.
>

Yes, it's more proper to use an unsigned int for the non-negative error mar=
gin.
Storing as signed here is just to keep the type consistent with that
of timer_period_ms
since there will be '+' operation in other places.

        tools/testing/selftests/kvm/aarch64/arch_timer.c
        /* Setup a timeout for the interrupt to arrive */
         udelay(msecs_to_usecs(test_args.timer_period_ms) +
             test_args.timer_err_margin_us);

Thanks,
Haibo

>         M.
>
> --
> Without deviation from the norm, progress is not possible.

