Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FB3714950
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 14:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjE2MVM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 08:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjE2MVL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 08:21:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E2AB;
        Mon, 29 May 2023 05:21:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b03b9f02b4so7027045ad.3;
        Mon, 29 May 2023 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685362870; x=1687954870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1Xvm17u+rCjsDQtsTRP4IW4hFNIZBwFcy3OF7utEfQ=;
        b=Iztf9BjgqoBy2nQa3hkO+Tngf5xL010erKXp2+fhMwz3aX9O/8sSXatTJ3RNWPKclo
         g2l+VY5BGH9IhFLnqtVx86UQ73tyBQSH9LS5AvJDga5jLPu3osDLC/hgypHvEYpHJSAs
         hQivyn1v/BqgEftAJZygsVyp9VbYp1ODqY+9qjs7zM8XiFp83jqB0CATWAzDoEC1+sxC
         QKr/Bfh3+hjkXgFSx0wr57sFBwgsOOltT3nqi8RjRAMiS3KN0hlaGn+104yyCuexGKSn
         4IBQLshG/UjbrGgRrJGUbvnm66TINLet3rtQUncCJXsvkeug+HzRBpXvwAjx/02XD5G3
         6Z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685362870; x=1687954870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1Xvm17u+rCjsDQtsTRP4IW4hFNIZBwFcy3OF7utEfQ=;
        b=CDDVk3g39zP61mNMxVmhuUG0Q8ZgbrknFimqffs3xJV5kNsGKTUjXjFxkHW/aYSPnj
         kpUOLa0HEgSKOPhOUuFk8Cm+8YajGm+rKKJlkeK7YemEOlMiZbsxqhLFMHXg8ZULNOzc
         F3qFCokcj9+P8UiFV6R/0I5JH7GXSPlFQ6GpNXcsZKoQ86dxlpsJ3R2DWejDGQSFCggJ
         Pc16DOt9um/d7UNAYCorcruwV0Ct173Qbhm8LlgcR9L5kn67uEHQ+baCQLVRu1T/dyVh
         npNNo/8KD2icNhPWtiebPkUsh6v3mTZEpm+8Xmraowuj8TIHU0sDaxYovYVokh2A4u/e
         8Azw==
X-Gm-Message-State: AC+VfDzc79n7qstOVaWuDkGhjY85xg9VyVwbYXmsC534drJBKinUs/GW
        VlQi1iRVlPm/p3vtX3rQJUPG5GHLmOwUb1ipokg=
X-Google-Smtp-Source: ACHHUZ6OkV3SZbwpjCqJa57IyIdEql6pFjbanDcFk7ZJ7Rj1kSsJag0dj6+D0yo7FilJN1xbZcoFIMZn3k8nj6DrI08=
X-Received: by 2002:a17:902:8218:b0:1af:bcf7:2bd8 with SMTP id
 x24-20020a170902821800b001afbcf72bd8mr8700574pln.52.1685362869847; Mon, 29
 May 2023 05:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684999824.git.haibo1.xu@intel.com> <da390e6200e838fce320a2a43b2f87951b4e0bbb.1684999824.git.haibo1.xu@intel.com>
 <20230525-2bab5376987792eab73507ac@orel> <CAJve8o=5ji5D-S8k+GaGd7sH7KXNWxDaWhD3jyxtHizKSMtjbA@mail.gmail.com>
 <20230529-7b3e41e6aca55f9e90dd6cd3@orel>
In-Reply-To: <20230529-7b3e41e6aca55f9e90dd6cd3@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Mon, 29 May 2023 20:20:58 +0800
Message-ID: <CAJve8o=wX+Lb84YeGBa9anp+eZnrgvTW6AOVgoeUnHZu7eWswA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] KVM: riscv: selftests: Add get-reg-list test
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>, maz@kernel.org,
        oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
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

On Mon, May 29, 2023 at 3:08=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sat, May 27, 2023 at 12:39:57PM +0800, Haibo Xu wrote:
> > On Fri, May 26, 2023 at 1:18=E2=80=AFAM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > On Thu, May 25, 2023 at 03:38:35PM +0800, Haibo Xu wrote:
> ...
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.a6),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.a7),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.s2),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.s3),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.s4),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.s5),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.s6),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.s7),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.s8),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.s9),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.s10),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.s11),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.t3),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.t4),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.t5),
> > > > +     KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_CORE | KVM_R=
EG_RISCV_CORE_REG(regs.t6),
> > >
> > > ...all the above would just be indices rather than named registers. I
> > > guess that's better for these registers.
> > >
> >
> > You mean to show it as KVM_REG_RISCV_CORE_REG(regs.regs[0]) ...
> > KVM_REG_RISCV_CORE_REG(regs.regs[31])?
> >
>
> I'm OK with these registers using their names in this list, it does look
> better. However the original idea for these lists was that they would be
> generated from print_reg(). In this case, print_reg() is generating them
> with their number instead of name. Either print_reg() could learn how to
> generate their names by handling the offset ranges of each register type,
> e.g.
>
> switch (reg_off) {
> case 10 ... 17:
>    strdup_printf("... KVM_REG_RISCV_CORE_REG(regs.a%d),", reg_off - 10);
>
> or we can use the numbers here in this list, or we can leave it as you
> have it (i.e. done manually).
>

I agree that the print_reg() should print the register name instead of
the register offset.
It may be better to manually encode/decode the register offset to name
case by case
in the print_reg() since we just need to handle it once. Will update it in =
v3.

Thanks,
Haibo

> Thanks,
> drew
