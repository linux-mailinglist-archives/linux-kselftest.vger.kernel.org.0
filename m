Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7205877515E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 05:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjHID0y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 23:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjHID0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 23:26:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2C1BF7;
        Tue,  8 Aug 2023 20:26:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so10518207e87.0;
        Tue, 08 Aug 2023 20:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691551609; x=1692156409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDtqmE5WaBwuWbcG5niee6vR0Dh8gvhaHzvoiNOQiws=;
        b=owAHMA78RpdKw7tQgsXJuS/elEyAp7vSGAzfHHJ5z4MmckA+NQrtCeJ+W8B7PUvc2D
         I/WpHW66G3aWUjJpuletY1j0z6aKy1xgec4upQFXMpwU9ycs+tCk/ePKYCi6Nbx+Tq5H
         Qy6MPyf/gtpxrwP1m2i9XoznQjE+jLj5ZwBSTijY/98bVmFXY24MFJCymc8ScA3Nxj2n
         fSOujTjvaaQVXxt/vcJYEAVtUVvyYiN2uWpHFHiII9KFwlpZWIDhDRw8t4Y/QmWWdq4T
         tB+UNi3v3GnHUI0r44M6p5HgP9APdJozCrZvNY2C87aDLO+gxiwTpgoEZWh+gs2IkgG7
         f6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691551609; x=1692156409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDtqmE5WaBwuWbcG5niee6vR0Dh8gvhaHzvoiNOQiws=;
        b=YAPzH0E9wW5eOLhFONLzj3NjuA1GbLh8coHraIWzzmI8MN6XdCVgDphPv7esgF2cuX
         xeIHHiOf5HRX84sEUpmrw9PoZwm6AKyJxiyCKrRsCNPriz8iY/yIB1l8vHjTK5jCbCbU
         eXmY6qoh5vvyeW8yAVigzPZBbw41yJx3jFhho/PSnbS439fBPmHPYU+uOy/esBNDDUMc
         bseUIhDKWgw7i1NRg42zp60EM2poC723KCSr2yRB2sDA1tMpViboL7rx2MpDrtbJnqEK
         bLYxy9y2GNoksKI5WSYb072TZLyeMAMjnM9dXAtk5EMdurmyf4BDFgvjzira/HrWOteu
         OhJQ==
X-Gm-Message-State: AOJu0Yz36D/G9SLz91zSBk7JIu7GUwTJ/QZugUz5+3R/CaJvtQFtA2Bb
        FXLaeEO+goUqBDpIy5yI0aL/7Qx+F6cLe2+P51g=
X-Google-Smtp-Source: AGHT+IH2bKTSsX7/6xPrKfrQgho5P8O/hWC3nUT0gNKKQQAzMu/0fuX80th8S70Ytqj3VHXYwT6+ychP6EtQ0Fkfu08=
X-Received: by 2002:a2e:a16e:0:b0:2b5:9d78:213e with SMTP id
 u14-20020a2ea16e000000b002b59d78213emr935818ljl.22.1691551608635; Tue, 08 Aug
 2023 20:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690273969.git.haibo1.xu@intel.com> <CAAhSdy0yug=J0nxnnPoLYL=0MiT0w6qgPYOcv0QwMRe+fsQn8Q@mail.gmail.com>
 <87y1ilpz3m.wl-maz@kernel.org>
In-Reply-To: <87y1ilpz3m.wl-maz@kernel.org>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 9 Aug 2023 11:26:36 +0800
Message-ID: <CAJve8onZuOHkAUVY3=QeBPMx5n2F1fGgn57rPp7MB1Q5=vXasA@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] RISCV: Add KVM_GET_REG_LIST API
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>, oliver.upton@linux.dev,
        ajones@ventanamicro.com, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Like Xu <likexu@tencent.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        Haibo Xu <haibo1.xu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
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

On Tue, Aug 8, 2023 at 7:12=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 07 Aug 2023 04:48:33 +0100,
> Anup Patel <anup@brainfault.org> wrote:
> >
> > Hi Marc, Hi Oliver,
> >
> > On Tue, Jul 25, 2023 at 2:05=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> =
wrote:
> > >
> > > KVM_GET_REG_LIST will dump all register IDs that are available to
> > > KVM_GET/SET_ONE_REG and It's very useful to identify some platform
> > > regression issue during VM migration.
> > >
> > > Patch 1-7 re-structured the get-reg-list test in aarch64 to make some
> > > of the code as common test framework that can be shared by riscv.
> > >
> > > Patch 8 move reject_set check logic to a function so as to check for
> > > different errno for different registers.
> > > Patch 9 move finalize_vcpu back to run_test so that riscv can impleme=
nt
> > > its specific operation.
> > > Patch 10 change to do the get/set operation only on present-blessed l=
ist.
> > > Patch 11 add the skip_set facilities so that riscv can skip set opera=
tion
> > > on some registers.
> > > Patch 12 enabled the KVM_GET_REG_LIST API in riscv.
> > > patch 13 added the corresponding kselftest for checking possible
> > > register regressions.
> > >
> > > The get-reg-list kvm selftest was ported from aarch64 and tested with
> > > Linux v6.5-rc3 on a Qemu riscv64 virt machine.
> > >
> > > ---
> > > Changed since v5:
> > >   * Rebase to v6.5-rc3
> > >   * Minor fix for Andrew's comments
> > >
> > > Andrew Jones (7):
> > >   KVM: arm64: selftests: Replace str_with_index with strdup_printf
> > >   KVM: arm64: selftests: Drop SVE cap check in print_reg
> > >   KVM: arm64: selftests: Remove print_reg's dependency on vcpu_config
> > >   KVM: arm64: selftests: Rename vcpu_config and add to kvm_util.h
> > >   KVM: arm64: selftests: Delete core_reg_fixup
> > >   KVM: arm64: selftests: Split get-reg-list test code
> > >   KVM: arm64: selftests: Finish generalizing get-reg-list
> > >
> > > Haibo Xu (6):
> > >   KVM: arm64: selftests: Move reject_set check logic to a function
> > >   KVM: arm64: selftests: Move finalize_vcpu back to run_test
> > >   KVM: selftests: Only do get/set tests on present blessed list
> > >   KVM: selftests: Add skip_set facility to get_reg_list test
> > >   KVM: riscv: Add KVM_GET_REG_LIST API support
> > >   KVM: riscv: selftests: Add get-reg-list test
> >
> > Are you okay for this series to go through the KVM RISC-V tree ?
>
> Sure, seems fine from my point of view. But please put it on an
> immutable topic branch so that we can also merge it in the arm64 tree,
> should we need to resolve any conflicts.
>

Hi Marc,

Thanks for your review!

Which topic branch do you prefer or suggest to use?
I can do a rebase on it and fix any potential conflicts.

Regards,
Haibo

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
