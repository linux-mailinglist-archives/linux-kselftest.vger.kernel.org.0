Return-Path: <linux-kselftest+bounces-1122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2FF804B96
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 08:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C6F28173D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DC633070;
	Tue,  5 Dec 2023 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUyMscos"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3244911F;
	Mon,  4 Dec 2023 23:58:16 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bee606265so2841880e87.2;
        Mon, 04 Dec 2023 23:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701763094; x=1702367894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDaBQlGZ8UjeyvNNGC2XDs5wlZCfXV5wgyIn7Cj35I0=;
        b=BUyMscos3p1dIHj8yoZ2M+4nlgLPQnWZXbDD1JPkl3uZBcGbVKfQmUej0vU5u4oHgL
         rNbrtu9p6VamKz1EXMNagc2IwFvq2gGtFKtDrN6bknPXwH7yUWSTeklN5iqZKHETfq0Y
         JpTWD+Y8wu5OZjoiHhyI4NbhiVXJGvhbCMXlu/MuhQjqyDqKkbkTxNlKR4ASO5ylYsph
         X4uFhWE8Cwkm4iPXwx3wDdlOMTecARML++N6As+6a4UYLt4HH/T3llABCipXXTApspyv
         bYZDj4jzeTJNRLDODFbjCnb5CkTn2mTMG+tAoi864EsQEwSlAqUAGXoQgf3n+HSA54NB
         nCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701763094; x=1702367894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDaBQlGZ8UjeyvNNGC2XDs5wlZCfXV5wgyIn7Cj35I0=;
        b=Y47UCR6qCuA45sS15cEm3ZXTMtjvLZzD+F0T+q/XH3rKaaFlt4aKhXvJfpVYZX+Lfl
         tFhpAiEzQkU7H2LWffCEX9NTc/dLBDKJJW/eXW6oTbvru42YEqX5G+S/DEn51oCHVZzz
         0aEUFhcMberb2qzsk7UgiUpjIJoUIvPBFVDBUieQKAn70iaRnbNX3rxSWVVZxd++R02q
         xHHGSDFyMSlLC3sUSO1jDn0X4DDmV3XmzGf7QefQcCHnhpKwYz5c2S4EdpoyWYLhCtIW
         jSC3Nr58ULYchyDjXRcrzvbkxnfNAQ1MAvTJPYwFtxYQD+j7hWfkInFLDoRnVdhW/XHG
         vFhA==
X-Gm-Message-State: AOJu0YxgloMmyFvCl4m8PGCpCkBGdak/0CU8wTxFqPyrfzPpU/ddhEKv
	AQiy7vJ+pTbbxdzIEbJcyilOE9V3k3T1ncbRHAI=
X-Google-Smtp-Source: AGHT+IFB7AXgBvjJC6KXRzmHN5fiSmN/CqaafqDV8LUeWsssBRPFI6TrMLt6kXoA/HN17H0Nd9dUlNSsNYRV4on7U8I=
X-Received: by 2002:a05:6512:3b8f:b0:50b:f019:366a with SMTP id
 g15-20020a0565123b8f00b0050bf019366amr2333164lfv.109.1701763094196; Mon, 04
 Dec 2023 23:58:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1694421911.git.haibo1.xu@intel.com> <64e0637cd6f22dd7557ed44bd2242001e7830d1c.1694421911.git.haibo1.xu@intel.com>
 <20230914-d2e594e7d84503ad14036e2d@orel> <CAJve8onhY534T=Hyncjfi4GfdZ+0D2xM+jRSaYCAWCdaKxPUcQ@mail.gmail.com>
 <CAJve8omitHDpijJaLV_wHk+5LXpsBUWF8_eTD4MeWKM-807Siw@mail.gmail.com> <20231204-980c95cca344f718ac6a48b6@orel>
In-Reply-To: <20231204-980c95cca344f718ac6a48b6@orel>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 5 Dec 2023 15:58:02 +0800
Message-ID: <CAJve8okwyPwY3AZcA31=aoc1tyZN7hx_5AmF0KMmn-bZ1VnyHA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] KVM: riscv: selftests: Add sstc timer test
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Sean Christopherson <seanjc@google.com>, Ricardo Koller <ricarkol@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vipin Sharma <vipinsh@google.com>, David Matlack <dmatlack@google.com>, 
	Colton Lewis <coltonlewis@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 7:32=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Mon, Dec 04, 2023 at 10:42:24AM +0800, Haibo Xu wrote:
> > On Fri, Sep 15, 2023 at 2:21=E2=80=AFPM Haibo Xu <xiaobo55x@gmail.com> =
wrote:
> > >
> > > On Thu, Sep 14, 2023 at 5:52=E2=80=AFPM Andrew Jones <ajones@ventanam=
icro.com> wrote:
> > > >
> > > > On Thu, Sep 14, 2023 at 09:37:03AM +0800, Haibo Xu wrote:
> > > > > Add a KVM selftests to validate the Sstc timer functionality.
> > > > > The test was ported from arm64 arch timer test.
> > > >
> > > > I just tried this test out. Running it over and over again on QEMU =
I see
> > > > it works sometimes, but it frequently fails with the
> > > > GUEST_ASSERT_EQ(config_iter + 1, irq_iter) assert and at least once=
 I
> > > > also saw the __GUEST_ASSERT(xcnt >=3D cmp) assert.
> > > >
> > >
> > > Good catch!
> > >
> > > I can also reproduce this issue and it is a common problem for both
> > > arm64 and riscv because it also happens in a arm64 Qemu VM.
> > >
> > > It seems like a synchronization issue between host and guest shared
> > > variables. Will double check the test code.
> > >
> > > > Thanks,
> > > > drew
> >
> > Hi Andrew,
> >
> > After several rounds of regression testing, some findings:
> > 1. The intermittent failure also happened on ARM64 Qemu VM, and even
> > in the initial arch_timer commit(4959d8650e9f4).
> > 2. it didn't happen on a ARM64 HW(but a different failure occured
> > during stress test)
> > 3. The failure have a close relationship with
> > TIMER_TEST_ERR_MARGIN_US(default 100), and after increasing
> >      the macro to 300, the failure couldn't reproduced in 1000 loops
> > stress test in RISC-V Qemu VM
> >
> > So my suggestion is we can expose the TIMER_TEST_ERR_MARGIN_US
> > parameter as an arch_timer test arg parameter
> > and tune it based on a specific test environment.
> >
> > What's your opinion?
>
> The concept of "timeout for an interrupt to arrive" is always going to
> leave us exposed to random failures. Your suggestion of making the
> timeout user configurable is probably the best we can do. I would
> suggest also adding more descriptive failure text and a hint about
> trying to adjust the timeout.
>
> Or, one thing we do in kvm-unit-tests, is to reduce typical delays while
> allowing expected delays to be longer by looping over a shorter delay and
> a non-fatal check, i.e.
>
>  pass =3D false;
>  for (i =3D 0; i < 10; i++) {
>    udelay(100);
>    if (check(...)) {
>       pass =3D true;
>       break;
>    }
>  }
>  assert(pass);
>
> We could try that approach here too.
>
> Thanks,
> drew

Thanks for the feedback, I will send out patch set v4 soon!

