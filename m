Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900F576C294
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 04:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjHBCBU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 22:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHBCBT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 22:01:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85861E53;
        Tue,  1 Aug 2023 19:01:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so4308404e87.3;
        Tue, 01 Aug 2023 19:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690941676; x=1691546476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfJe9BpFl8b7JDGf91rp83jhgS2ZS1vO2M4ah8lJAhM=;
        b=h3VdRHTBZt3cAaKjjOGTTnH7QUnbMtm6Pfq3stfPGTm4mGpcTwULiRKf3CaYovDR20
         8BFdQiehASCHuPW0FD8aYP7gdkn0vMPjanuhskZDiKWWWq6EW0I4yFlEJXP0AdsttVU+
         sUkCi6wjzSV6FSARA9S45ckqy0Co2jFZs4AQGD9eyYwYlwN6AUpwfQpuHjGYbch1gesZ
         lMrRztTovO3MgPL1ioeEYBTRgp7uVk72WX0WEz99HSmBUE9P6ecI20k8Zu/T+R2D/u44
         1zu6DFOuvA+Uj8GnL6IoZvBklZun6O4VnzRr4+dQTWBTyF+m9jXmQvIGH+Ij769R4eBX
         BUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690941676; x=1691546476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfJe9BpFl8b7JDGf91rp83jhgS2ZS1vO2M4ah8lJAhM=;
        b=Nrx6aBEG0utbIIgjzZJAwCOqZc8AFNBQYmthi71ughaDkazNVgwgyxaf8OXs1coUmu
         cdfnxtUsKWT7k/P7K+Yv9wOwgYFcOpwf1BbRMSjs7Qjyd1g0S1OvWbaeCvq++H5ZVmna
         J1U8KxUCuQ8vtzOR6vopx6efykY83c/OUawZhJKKdmackJdQHlxw1nnn/8nsFWYYsIHl
         9hxfDTkL+1M6QbNU1TEng0Co1qEXh5fJ60e5fdqEW+bsXOWJE4aCWfzsdc0zvWbzK6rt
         01MN+zw3UUsA+k9UvUgTpiAV757/R44QrO3nKxectSr+cssxncqyzrayKNipHU/R7xJf
         qMvg==
X-Gm-Message-State: ABy/qLY4VkV4tnVa3kLYfnV5Yx7xkvJL4kTdzPHgB81KNsvh3FgT/Kn6
        jh0usv0SIAULPWcqoJY8BJTz9HURcvPbI2LxnzM=
X-Google-Smtp-Source: APBJJlFSc5EC10ZCdUzxQha4Ci3cTcn+L8pZloh77cez7PrKQIQzj4fBTNpduGray2L9IMoboiVn+AIBhCwewb9HLIM=
X-Received: by 2002:a2e:b001:0:b0:2b6:c2e4:a57a with SMTP id
 y1-20020a2eb001000000b002b6c2e4a57amr4186390ljk.38.1690941676288; Tue, 01 Aug
 2023 19:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com> <ZMKI8RknjjZBOaxf@google.com>
 <CAJve8o=GZnLLedT7TvCLvgd5Z3ZxJNfM6gG03Eyc+7krtMY--g@mail.gmail.com> <20230728-5b0f530eba70ad08e8f4a67d@orel>
In-Reply-To: <20230728-5b0f530eba70ad08e8f4a67d@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 2 Aug 2023 10:01:05 +0800
Message-ID: <CAJve8onvmDtD_GsbkUChzf6Sbt37FpfNvWEd+rJr7F1NxfjnCg@mail.gmail.com>
Subject: Re: [PATCH 0/4] RISCV: Add kvm Sstc timer selftest
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 5:57=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, Jul 28, 2023 at 09:37:36AM +0800, Haibo Xu wrote:
> > On Thu, Jul 27, 2023 at 11:14=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > >
> > > On Thu, Jul 27, 2023, Haibo Xu wrote:
> > > > The sstc_timer selftest is used to validate Sstc timer functionalit=
y
> > > > in a guest, which sets up periodic timer interrupts and check the
> > > > basic interrupt status upon its receipt.
> > > >
> > > > This KVM selftest was ported from aarch64 arch_timer and tested
> > > > with Linux v6.5-rc3 on a Qemu riscv64 virt machine.
> > >
> > > Would it be possible to extract the ARM bits from arch_timer and make=
 the bulk of
> > > the test common to ARM and RISC-V?  At a glance, there is quite a bit=
 of copy+paste.
> >
> > Sure, I will have a try to consolidate the common code for ARM and RISC=
-V in v2.
> >
>
> Yes, afaict, we should be able to make aarch64/arch_timer.c another "spli=
t
> test", like we did for aarch64/get-reg-list.c, but before we do that, I'd
> like to get an ack from the Arm maintainers on the get-reg-list split to
> be sure that approach is acceptable.
>

Yes, we can re-use the split method.

Since there is less configuration data that should be handled, I think
it may be
easier for the timer test  to consolidate the code, since most of the
operations
can be overloaded for different ARCH.

I'll have a try and send the v2 soon!

Thanks!

> Thanks,
> drew
