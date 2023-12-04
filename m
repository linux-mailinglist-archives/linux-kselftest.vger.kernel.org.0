Return-Path: <linux-kselftest+bounces-1031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8134D802A66
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 03:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399D0280C74
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 02:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8D4814;
	Mon,  4 Dec 2023 02:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2OuZqmu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A656D9;
	Sun,  3 Dec 2023 18:42:38 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ca03103155so4974391fa.0;
        Sun, 03 Dec 2023 18:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701657756; x=1702262556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEUh6K5iutasnoMeRQbvniZJyhB8EqO9DGWeSRBdHG8=;
        b=U2OuZqmucqFts8pAMt/wdD4lmr34uN6jJ/2bh2Hb8iYEpve6PK1jjBFcAMnW2jXsW0
         s9qMLepYbliqh1PIAorSrtzuxrHMcl8wTU42TkZaBwZMKIKvZG6bUoX2Nsm4huEBBKal
         kOV79Z5gP7m8T3TSMukeasr+T49wCsxWnRFS7+T38XWk7vivD2NqeRluCPmPEOA/7XXl
         8gs75xOLkFR3BA8umg/sUY5wQfANIOAZCgUwA01z6gKkcQh12fnV2NzpfacFv/a3bNmr
         4Ofk9fi7NdyeLyYg5BM9J7qyIlDB6S863h0geH75v3xQxjJVYF0M4OarjUVYPio0nvOj
         g4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701657756; x=1702262556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEUh6K5iutasnoMeRQbvniZJyhB8EqO9DGWeSRBdHG8=;
        b=WIUeDHzytcpf0c/oZdrX7GeB/I9tDhKNEBoS46Wz/Zwqgw4x1E5WA/So1Wr04JSEDi
         CNcG+HwMtydMbIfodpOfmBplpQPvBdncVDa08+MqTkR92TNtHnupWc525SytOhdEn74P
         yASIHfkd+aIh+uL7x8fCe5rlRBAQergP4LQmVhoOZIFPt02vdkJndLx98/5Vx6hUfEfi
         jWqVkDlGE9sYX7oiTGuzmvOf5mJu4bRnUWl85rbK+P1zRZ9tUqyX6cf/Am4afgV1EsxQ
         n+Zd4pha3Undmp5tv1yZlwu302tQH7pY7GlLqr306SiOTvqnPxKmL+M0SJ56LlRza4Rs
         mNHw==
X-Gm-Message-State: AOJu0Yz8KemNXAHDqY4CmCvYkm1cpYqbyqyN2QzL+kcPLM5k2c4MGxgN
	iUcjLfPC6+TZUnClqo7X5k3pYPQ9oTRT7X3dDnY=
X-Google-Smtp-Source: AGHT+IFwUdfTpFRUP7l0fmhtGiz7fd+NP19pyuThwxbiypx7Ivz7rX5Zrc/KjwBbAY7wO0CJI2SrHgFWM/kImEvN9oM=
X-Received: by 2002:a05:6512:ea1:b0:50b:f03c:1eaa with SMTP id
 bi33-20020a0565120ea100b0050bf03c1eaamr553100lfb.95.1701657756237; Sun, 03
 Dec 2023 18:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1694421911.git.haibo1.xu@intel.com> <64e0637cd6f22dd7557ed44bd2242001e7830d1c.1694421911.git.haibo1.xu@intel.com>
 <20230914-d2e594e7d84503ad14036e2d@orel> <CAJve8onhY534T=Hyncjfi4GfdZ+0D2xM+jRSaYCAWCdaKxPUcQ@mail.gmail.com>
In-Reply-To: <CAJve8onhY534T=Hyncjfi4GfdZ+0D2xM+jRSaYCAWCdaKxPUcQ@mail.gmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Mon, 4 Dec 2023 10:42:24 +0800
Message-ID: <CAJve8omitHDpijJaLV_wHk+5LXpsBUWF8_eTD4MeWKM-807Siw@mail.gmail.com>
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

On Fri, Sep 15, 2023 at 2:21=E2=80=AFPM Haibo Xu <xiaobo55x@gmail.com> wrot=
e:
>
> On Thu, Sep 14, 2023 at 5:52=E2=80=AFPM Andrew Jones <ajones@ventanamicro=
.com> wrote:
> >
> > On Thu, Sep 14, 2023 at 09:37:03AM +0800, Haibo Xu wrote:
> > > Add a KVM selftests to validate the Sstc timer functionality.
> > > The test was ported from arm64 arch timer test.
> >
> > I just tried this test out. Running it over and over again on QEMU I se=
e
> > it works sometimes, but it frequently fails with the
> > GUEST_ASSERT_EQ(config_iter + 1, irq_iter) assert and at least once I
> > also saw the __GUEST_ASSERT(xcnt >=3D cmp) assert.
> >
>
> Good catch!
>
> I can also reproduce this issue and it is a common problem for both
> arm64 and riscv because it also happens in a arm64 Qemu VM.
>
> It seems like a synchronization issue between host and guest shared
> variables. Will double check the test code.
>
> > Thanks,
> > drew

Hi Andrew,

After several rounds of regression testing, some findings:
1. The intermittent failure also happened on ARM64 Qemu VM, and even
in the initial arch_timer commit(4959d8650e9f4).
2. it didn't happen on a ARM64 HW(but a different failure occured
during stress test)
3. The failure have a close relationship with
TIMER_TEST_ERR_MARGIN_US(default 100), and after increasing
     the macro to 300, the failure couldn't reproduced in 1000 loops
stress test in RISC-V Qemu VM

So my suggestion is we can expose the TIMER_TEST_ERR_MARGIN_US
parameter as an arch_timer test arg parameter
and tune it based on a specific test environment.

What's your opinion?

Regards,
Haibo

