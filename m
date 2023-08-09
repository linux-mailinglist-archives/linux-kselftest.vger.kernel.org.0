Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55F97751A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 05:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjHIDs2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 23:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHIDs0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 23:48:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE6C173A
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 20:48:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so964069a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Aug 2023 20:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1691552903; x=1692157703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcsclxtm27Oz1sDHzPRuy+Izl0iwle6aRoNm7chV/mE=;
        b=EAu5utSgSArNbjdpW2PWgXWxU171HGHts/s7dBkm0zVj5aCYmQgRY1eVDfdx5vr8cA
         uGKn7OVjBlH4x+6LdBhrQT6Lg9LhLj1yy1RH2qqx1h5mvCbwLwDTmi/MZ0ikszErkW7A
         c2wgoyYGmr5Xx1SM2v4R30bMVFeofVKHtC6o0RiWqEd1AY94fkLRImRdySpiVfKzCHyP
         2nptFLeLbD+hH2/FAjLldDdYM1xVC0YQevFNuibuhkBMw35KddsaCG7bR1RVsurPGN57
         4zXG/WD6m3xLx9dq37bTRRVaAPx+TLrhm8T5caUwPW3f4koGnwh0i2q7yp3JZqW5SBBb
         uphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691552903; x=1692157703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcsclxtm27Oz1sDHzPRuy+Izl0iwle6aRoNm7chV/mE=;
        b=R1Z0gHmTymxBt4VEjb9dwwHSv0HBFsXLxvihdD134FfN8BVkTXzu1yl1V8C9T/eXRK
         fSmgTNW1LrgsXKfviBQDl/V8qROMm7/YF1cwJWjeBGqy/5YbRQ97rhhiwKDgc7OSO9tn
         o67vqEpr3wvm3lB/1Oq4M0L02EjeYoayGMZtyIRhiXKBY+eatgkx6pPsG5cVaC/fF6pZ
         SYa/mPxu8HYDTcKWZAmMcqh7FLfI0aXW+S2V4mOVPBWHmEUiO0FxZZ/odjNMaz7H8fBi
         NRpzLAW+vgmD37hzsHkEPGKRgN/p/mlNFbdCW2AV5YsHKhHVGI0U7DUu5bu/KptU9qtB
         N5OA==
X-Gm-Message-State: AOJu0YwxI8RmJsRXLu/rwJ5qKwxVBI4FkNvKh4h3nwxUI87MhIHSQzFP
        5UQuVcUZ1VPV87XNEVykKTN30Crc45Z4TZpXl3kMWw==
X-Google-Smtp-Source: AGHT+IFauvweysXXn8GP5MBQlVkSnEFT74it4SwljMy29zvw5obroURdfY0qKL+rjI6eMwJTbfFGGEzPUIYTUHgx/6I=
X-Received: by 2002:a05:6402:3587:b0:51f:ef58:da87 with SMTP id
 y7-20020a056402358700b0051fef58da87mr14581549edc.2.1691552902500; Tue, 08 Aug
 2023 20:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690273969.git.haibo1.xu@intel.com> <CAAhSdy0yug=J0nxnnPoLYL=0MiT0w6qgPYOcv0QwMRe+fsQn8Q@mail.gmail.com>
 <87y1ilpz3m.wl-maz@kernel.org> <CAJve8onZuOHkAUVY3=QeBPMx5n2F1fGgn57rPp7MB1Q5=vXasA@mail.gmail.com>
In-Reply-To: <CAJve8onZuOHkAUVY3=QeBPMx5n2F1fGgn57rPp7MB1Q5=vXasA@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 9 Aug 2023 09:18:09 +0530
Message-ID: <CAAhSdy277PEBZ4wyUHxQPyN2TugGfhBmC5jUoFTAqMU8vwbt5w@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] RISCV: Add KVM_GET_REG_LIST API
To:     Haibo Xu <xiaobo55x@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, oliver.upton@linux.dev,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 9, 2023 at 8:56=E2=80=AFAM Haibo Xu <xiaobo55x@gmail.com> wrote=
:
>
> On Tue, Aug 8, 2023 at 7:12=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrot=
e:
> >
> > On Mon, 07 Aug 2023 04:48:33 +0100,
> > Anup Patel <anup@brainfault.org> wrote:
> > >
> > > Hi Marc, Hi Oliver,
> > >
> > > On Tue, Jul 25, 2023 at 2:05=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com=
> wrote:
> > > >
> > > > KVM_GET_REG_LIST will dump all register IDs that are available to
> > > > KVM_GET/SET_ONE_REG and It's very useful to identify some platform
> > > > regression issue during VM migration.
> > > >
> > > > Patch 1-7 re-structured the get-reg-list test in aarch64 to make so=
me
> > > > of the code as common test framework that can be shared by riscv.
> > > >
> > > > Patch 8 move reject_set check logic to a function so as to check fo=
r
> > > > different errno for different registers.
> > > > Patch 9 move finalize_vcpu back to run_test so that riscv can imple=
ment
> > > > its specific operation.
> > > > Patch 10 change to do the get/set operation only on present-blessed=
 list.
> > > > Patch 11 add the skip_set facilities so that riscv can skip set ope=
ration
> > > > on some registers.
> > > > Patch 12 enabled the KVM_GET_REG_LIST API in riscv.
> > > > patch 13 added the corresponding kselftest for checking possible
> > > > register regressions.
> > > >
> > > > The get-reg-list kvm selftest was ported from aarch64 and tested wi=
th
> > > > Linux v6.5-rc3 on a Qemu riscv64 virt machine.
> > > >
> > > > ---
> > > > Changed since v5:
> > > >   * Rebase to v6.5-rc3
> > > >   * Minor fix for Andrew's comments
> > > >
> > > > Andrew Jones (7):
> > > >   KVM: arm64: selftests: Replace str_with_index with strdup_printf
> > > >   KVM: arm64: selftests: Drop SVE cap check in print_reg
> > > >   KVM: arm64: selftests: Remove print_reg's dependency on vcpu_conf=
ig
> > > >   KVM: arm64: selftests: Rename vcpu_config and add to kvm_util.h
> > > >   KVM: arm64: selftests: Delete core_reg_fixup
> > > >   KVM: arm64: selftests: Split get-reg-list test code
> > > >   KVM: arm64: selftests: Finish generalizing get-reg-list
> > > >
> > > > Haibo Xu (6):
> > > >   KVM: arm64: selftests: Move reject_set check logic to a function
> > > >   KVM: arm64: selftests: Move finalize_vcpu back to run_test
> > > >   KVM: selftests: Only do get/set tests on present blessed list
> > > >   KVM: selftests: Add skip_set facility to get_reg_list test
> > > >   KVM: riscv: Add KVM_GET_REG_LIST API support
> > > >   KVM: riscv: selftests: Add get-reg-list test
> > >
> > > Are you okay for this series to go through the KVM RISC-V tree ?
> >
> > Sure, seems fine from my point of view. But please put it on an
> > immutable topic branch so that we can also merge it in the arm64 tree,
> > should we need to resolve any conflicts.
> >
>
> Hi Marc,
>
> Thanks for your review!
>
> Which topic branch do you prefer or suggest to use?
> I can do a rebase on it and fix any potential conflicts.

I will share a branch with a stable commit history.
I have already resolved conflicts at my end.

Regards,
Anup

>
> Regards,
> Haibo
>
> > Thanks,
> >
> >         M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
