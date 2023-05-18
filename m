Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD059707BA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjERIKr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 04:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjERIKq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 04:10:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674BC97;
        Thu, 18 May 2023 01:10:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-25368740ff6so226268a91.0;
        Thu, 18 May 2023 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684397445; x=1686989445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0YTm0IoXUd5c4n5YN9L5DUYWH7WIf1ootPhSesQtpw=;
        b=ZcxKVWxTbbBRXRzIs4OQ4ef+VAjO+ndMZFtzZExu3rBaoSOYhiRDwTrHtb1FY0hdJG
         HGUxEL1az8vR0xr+PEWkNyfoZC7VZmxHQS8puY4JFtyDdFdQdEYCq982C2v+7yQiHUTh
         2CcMtV71QYcBV9Rd/bRK9tb3hDnWe8UdCiSe01V+/0u30JCDIBXYS27rsgHe3ATjCoJA
         VK9YXNtMXWhb9c2YGvxMkJ2Y3Joq5SDZMHybJnW4WPe47EY9cGMiT9Du9pGgftpjuTf4
         HQXcKIEsJ/dQ001VUznykafhZ8OKqYbGpZPg9PjPfzyONW9OZTc1r3x9VXJKDVRo4n9D
         G4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684397445; x=1686989445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0YTm0IoXUd5c4n5YN9L5DUYWH7WIf1ootPhSesQtpw=;
        b=P2piGP6bZQ342RcgkKaHMPk1UtPjsjyLeHH5cHvvzB7yCtnXdyi+BoUjQzVJL+YBf1
         J/VcOIO9C/WCYeVneTNlQNf3RVDx22P1VzHCQwT1eB67n2+Zw4AL6uU0n3h51uaE1IBW
         H4wEhfezz3CUeoJVcHL2ND5ktc2PxGHsxYMQGk6+t0l3f8W32cgY/x+/CzxlapQ2WlOi
         0rs5amt5jQ2laqMl8ORJny1CdZNLwiOte4hdrGjHUx/A3fC/DmZ/5k78LNiHwIDv6WrH
         GCtZl8eNAdNQG3xu2or/SbCSZ5C7yMQyxX5Gx6sBxgvxFypkRAC6D83e3Zjswtp2lVMW
         Xvhw==
X-Gm-Message-State: AC+VfDy+Yixd7HidZ5wIyLMPwRrjlsyCJk3FOydKt2wdG0xJh9rlkW7B
        gHlGFb51UUc0Ko4TuOKR/9LOrazpTirnItKcu3c=
X-Google-Smtp-Source: ACHHUZ6onfAai2ygXURVPYRaxZVnlUv+nfcC3Xm7KTFlJ9Cq8cFTmGv8mjKjQj7PLNnBVWE+ADL4xKVZrtzP+tH9rm0=
X-Received: by 2002:a17:90a:764d:b0:253:30f9:1849 with SMTP id
 s13-20020a17090a764d00b0025330f91849mr1748821pjl.12.1684397444829; Thu, 18
 May 2023 01:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683791148.git.haibo1.xu@intel.com> <751a84a9691c86df0e65cdb02abf1e073892d1ca.1683791148.git.haibo1.xu@intel.com>
 <20230511-28ec368a8168342c68ca2187@orel> <CAJve8okVFr-m6go6dCg7Cf=Uq3Yt9Xmxi0Z3B2vbWvahvx4GgA@mail.gmail.com>
 <20230518-60da3b82641bdaccec589b8b@orel>
In-Reply-To: <20230518-60da3b82641bdaccec589b8b@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Thu, 18 May 2023 16:10:33 +0800
Message-ID: <CAJve8on1qzEZ6MsaV4ZOJoKHwymeEPtd_vmY6ki1Nq9bnUPT2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Add riscv get-reg-list test
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.linux.dev,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Sean Christopherson <seanjc@google.com>
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

On Thu, May 18, 2023 at 3:32=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, May 18, 2023 at 12:17:18PM +0800, Haibo Xu wrote:
> ...
> > > The idea of these *to_str functions is to dump output that can be
> > > copy+pasted into a reg array (hence the trailing commas in print_reg
> > > lines). So we can't just print random lines here or return '##UNKOWN#=
#',
> > > as that won't compile. Instead, the default should return
> > >
> > >   str_with_index("KVM_REG_RISCV_CONFIG_REG(##)", reg_off)
> > >
> >
> > Thanks for sharing the detailed idea, will fix it in next version!
>
> I guess we could also return a string like,
>
> "KVM_REG_RISCV_CONFIG_REG(##) /* UNKNOWN */"
>
> as that would still compile and also convey the message that this
> register doesn't have a name because the test doesn't know it yet.
>

Yes, that's more friendly and self explanatory. Thanks for the suggestion!

> ...
> > > We should share all the code above, except print_reg(), with aarch64.
> > > I'll send a patch series that splits the arch-neutral code out of
> > > the aarch64 test that you can base this test on.
> > >
> >
> > Good idea! I will rebase the patch based on your work.
> >
>
> Ok, I've pushed patches to [1]. This series introduces two things to KVM
> selftests. Primarily it splits the aarch64/get-reg-list test into a
> cross-arch get-reg-list test and an $ARCH_DIR/get-reg-list.o object file,
> which the cross-arch test depends on. To do that, it also introduces the
> concept of a "split test", a test that has a cross-arch part which depend=
s
> on an arch-specific part. Using a split test is cleaner than the
> #ifdeffery we usually do for cross-arch tests.
>
> I've added kvmarm@lists.linux.dev, Marc, Oliver, and Sean to the CC of
> this message. You'll want to add them when you post v2 as well.
>

Sure, I will rebase your patch in v2. Thanks for your review!

> [1] https://github.com/jones-drew/linux/commits/arm64/kself/get-reg-list
>
> Thanks,
> drew
