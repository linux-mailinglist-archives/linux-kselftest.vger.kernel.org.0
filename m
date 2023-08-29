Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DED78BDB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 07:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjH2FEs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 01:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjH2FEe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 01:04:34 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15103194;
        Mon, 28 Aug 2023 22:04:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bce552508fso60019441fa.1;
        Mon, 28 Aug 2023 22:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693285470; x=1693890270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxcmj7xCzomnU3k6tUiu3yMWfFqSb6wL7/6uLA5izWE=;
        b=jgkM3PsZPP3wztXEocbp+zXIzb0LypBxBeRDKQP740f+n4AWGE7pSMiKuL9077Ghzi
         KPKAbmJhYdv4OgFamcusrYpIp+obr20y8Y7frYh2CEKFzBIo2Ga+2Q439SVxwXkd9fEs
         nTCfdJ2NrbMU6aYKDpl1pY0qc9kGeSRLYbnroGoTAesjoe5ul8tKWcEms269cAvjODmx
         wvGsq9kSTiIQTHemOG3gGvWLTdDf+caXFq9IHh/cJljQcSGJPevZjre6KMiR3DWOlt4h
         x7yeQmOeRlyjFngHEOWgCGE0+cLm/MzwOAawZWauFqZ2u+pU04xdz5/o4bzUpiC9xIv2
         zcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693285470; x=1693890270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxcmj7xCzomnU3k6tUiu3yMWfFqSb6wL7/6uLA5izWE=;
        b=Qutts268A1/zsT2ky4YN8h5jtruc/lVZ1nL0PQHcw56YOKp77EsaBUrrIpS9IPbZR7
         1zE8DaoSyFtasr9rCXwnK+RpQLU23o8JndhY1Em97OIFyjILvSrYIAi6DjOKzGX8WcOD
         SvnqvHN2EYOnXTr4eanhP+CNfMQSF5bRoM1a0+g5gpvsSxJitZftvkxjN4kg6/T/ND2f
         cfBqE1KWWk971zA+TQTqsyllWaJWBvfHj35DD1ifTo6viYdG3zLDhJKRMBzJWgn5d2MV
         h80EKs5v8Wxla48XheEzw6oFAfiHNyy7XqQRWX3oBZVwaXBIwYyePoKTbTwDtXebDUET
         aatg==
X-Gm-Message-State: AOJu0Yy+d6/zEBG5w/Zm+hxGCHshPcaFif7eVcBm6fjQH3+fimvm5rab
        k93KXOPQeHy2cO85PllpOeR1dE/Zw9SZka9zpOc=
X-Google-Smtp-Source: AGHT+IFNMRSxgCv4AVg1hsluIhhbouSX6xEcacWfCeMyEZSelkwA1zKmgfTWPMugMsR1q5rWCG7dbiInjiJtz+wZjys=
X-Received: by 2002:a2e:9007:0:b0:2b9:e701:ac48 with SMTP id
 h7-20020a2e9007000000b002b9e701ac48mr23022126ljg.32.1693285469812; Mon, 28
 Aug 2023 22:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com> <ZMrVrXlvu/FJEayx@google.com>
 <CAJve8onbxHjJoC-k-TtOm1BBtjm38moaW-Kk8siKsxt9nwZZZw@mail.gmail.com> <ZOyqRfdvxpdtSE1c@google.com>
In-Reply-To: <ZOyqRfdvxpdtSE1c@google.com>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Tue, 29 Aug 2023 13:04:18 +0800
Message-ID: <CAJve8o=rFrVKxpaLLaJ8_KKQxMvyOOgVJn8qk715ymH8dpQ3MA@mail.gmail.com>
Subject: Re: [PATCH 0/4] RISCV: Add kvm Sstc timer selftest
To:     Sean Christopherson <seanjc@google.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 28, 2023 at 10:08=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Sun, Aug 27, 2023, Haibo Xu wrote:
> > On Thu, Aug 3, 2023 at 6:16=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Thu, Jul 27, 2023, Haibo Xu wrote:
> > > > The sstc_timer selftest is used to validate Sstc timer functionalit=
y
> > > > in a guest, which sets up periodic timer interrupts and check the
> > > > basic interrupt status upon its receipt.
> > > >
> > > > This KVM selftest was ported from aarch64 arch_timer and tested
> > > > with Linux v6.5-rc3 on a Qemu riscv64 virt machine.
> > > >
> > > > Haibo Xu (4):
> > > >   tools: riscv: Add header file csr.h
> > > >   KVM: riscv: selftests: Add exception handling support
> > > >   KVM: riscv: selftests: Add guest helper to get vcpu id
> > > >   KVM: riscv: selftests: Add sstc_timer test
> > >
> > > FYI, patch 4 will conflict with the in-flight guest printf changes[*]=
, as will
> > > reworking the existing arch_timer test.  My plan is to create an immu=
table tag
> > > later this week (waiting to make sure nothing explodes).  I highly re=
commend basing
> > > v2 on top of that.
> > >
> >
> > Hi Sean,
> >
> > Could you help point me to the immutable tag for the guest printf chang=
es?
>
> Sorry, I forgot to create the tag until last week, probably made it a bit=
 hard to
> find...
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-immutable-6=
.6

Thanks!
