Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9F77A15E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 08:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjIOGJA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 02:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOGI7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 02:08:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72F91BC7;
        Thu, 14 Sep 2023 23:08:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50078eba7afso2936234e87.0;
        Thu, 14 Sep 2023 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694758133; x=1695362933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrUex7tZYzG80r+HRntdlogt24bgAFnmLNhpPfiHTo4=;
        b=Unyzodh+Pw35y6mdd0t9yAD4XH1/g7WqElhS945/VaFAWZH1gCSyyOg1U9m7soCC+a
         MfkbezDrVEiVT+iZ2ygB7vdgM0qFqCvN6qkkisdeX2XIaC7Uf/NLm2eAQBsc6HLdNLg0
         O7WZCx2bAUpQJhX+hZjCEjEiBmSAL+EmIGQ58CGuTgMHdX2Ys7Q41I53TVYpLxQyP4vy
         1+FsVAiYR5HJYOnIq1cGBI3VZEJsZ+dPBqahuGUWPZDPeesyMfNd5X7IPWUGGU1/6emH
         sMLdap/msG/QuOgpJBsQQtzc/jTZlgNhF/XKU6EhylvboIkkpsq0Yl1tME9T4/1LiaK/
         VmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694758133; x=1695362933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrUex7tZYzG80r+HRntdlogt24bgAFnmLNhpPfiHTo4=;
        b=Q3KzqFxdo68FeudCFEN9vl79Y1IdQCCxVQTSgNROMffBSm7SiZq1knOOo+lEa1NgdZ
         S4j3ofLRCU4ght+XegGWOHH4Amjm+NEG77m/hlVYG58vFKamityT1neNbL1JzcF8RnVS
         GFgmtRNg2C0XgEKSjsqAQewmUySARlgy7xZdTMOnz2eyJTfNDWed4U602+ZMCxvSpMYe
         yg7wg+omwC7VFFHIPjv0+XN8c1MBFe/Oy/Hsy0U65wirsZIXvwplQGKjpVGVnRRJnfT2
         nca0ESlp/mU/GijcMIlfXHvi9CvjsTx0R6SrtvEDJnjgji1jYigY0D6hiCJp9hstfqV0
         taaw==
X-Gm-Message-State: AOJu0YySNUBXGjQvYs+Cox9necwdAQ+OWAfAS8JP+rYjbp8liSKqpuHh
        9jMHiVOFl6yRBL30Hotk9vsdM36ujbUmiR0n+0E=
X-Google-Smtp-Source: AGHT+IE/XgBcSpKnAyn9kLVpBkUHetxKd4F0nqWTi/DQv3hNtF8/i08aGRvx7cFjKU4BchcvkCmtqJALN6++fwsZ4H0=
X-Received: by 2002:a05:6512:3096:b0:500:9969:60bf with SMTP id
 z22-20020a056512309600b00500996960bfmr655736lfd.68.1694758132725; Thu, 14 Sep
 2023 23:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694421911.git.haibo1.xu@intel.com> <119c9d06d64b7e4932c5f74a05af1e769cbe7da6.1694421911.git.haibo1.xu@intel.com>
 <20230914-90a562a03985a9a97afd953a@orel>
In-Reply-To: <20230914-90a562a03985a9a97afd953a@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Fri, 15 Sep 2023 14:08:41 +0800
Message-ID: <CAJve8o=uZGovGBdtYYxiodGnXO-kE9jj=8pkc5+_Tk+dirQO1Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] tools: riscv: Add header file csr.h
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Thomas Huth <thuth@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
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

On Thu, Sep 14, 2023 at 4:14=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Sep 14, 2023 at 09:36:58AM +0800, Haibo Xu wrote:
> > Borrow the csr definitions and operations from kernel's
> > arch/riscv/include/asm/csr.h to tools/ for riscv. Since
> > only 64bit was supported for RISC-V KVM selftests, add
> > CONFIG_64BIT definition in kvm/Makefile to ensure only
> > 64bit registers were available in csr.h.
> >
> > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  tools/arch/riscv/include/asm/csr.h   | 521 +++++++++++++++++++++++++++
> >  tools/testing/selftests/kvm/Makefile |   3 +
> >  2 files changed, 524 insertions(+)
> >  create mode 100644 tools/arch/riscv/include/asm/csr.h
> >
> > diff --git a/tools/arch/riscv/include/asm/csr.h b/tools/arch/riscv/incl=
ude/asm/csr.h
> > new file mode 100644
> > index 000000000000..4e86c82aacbd
> > --- /dev/null
> > +++ b/tools/arch/riscv/include/asm/csr.h
> ...
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selft=
ests/kvm/Makefile
> > index 0102a0297b84..89ecee2fdb73 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -222,6 +222,9 @@ CFLAGS +=3D -Wall -Wstrict-prototypes -Wuninitializ=
ed -O2 -g -std=3Dgnu99 \
> >  ifeq ($(ARCH),s390)
> >       CFLAGS +=3D -march=3Dz10
> >  endif
> > +ifeq ($(ARCH),riscv)
> > +     CFLAGS +=3D -DCONFIG_64BIT
> > +endif
>
> This should be a separate patch, since the "import csr.h to tools" should
> be completely separate from anything else. Also, all architectures that
> KVM selftests supports are 64-bit, so, as another completely separate
> patch, I think we should just add CONFIG_64BIT to CFLAGS for all builds,
> especially since there's a chance some of the includes the other
> architectures are using may need it. Of course we'll need sign-off and
> testing from the other arch maintainers.
>

Sure. Will fix it in V4.

Thanks,
Haibo

> Thanks,
> drew
