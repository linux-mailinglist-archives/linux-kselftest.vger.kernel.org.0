Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67888775223
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 07:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjHIFDN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 01:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHIFDM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 01:03:12 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E51736;
        Tue,  8 Aug 2023 22:03:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9c66e2e36so6250201fa.1;
        Tue, 08 Aug 2023 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691557389; x=1692162189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6b8QaOxHHxr0nsnmybM/OZmFkMm6krciNhVPEUkLHM=;
        b=fhVs64I4ddYpd00JLct4M5DXmmqZVvjx/PM5IA0btlXqhs7iDUEO3VxkEF91BxP6Dz
         WJgiF9XR5y4uvxG6IWoY7NHCRglOoZAYWJVo6VGrKhNNaTIDWbKOUU3WRiGAXIqGsDSE
         DK44YS7nhYYxRjSy2NhsWwdbvYRxD6x/XguExxEaFacDNw496QL+DfrN0JlS0HPz1ZLI
         UOLAUlPdagmdXrFv1r2hojgA2g+RVPCvAV8BiMueulCJhnlfNSHOo6YBR6FliCSnwNe5
         XJuhSf8r3sDdpjILN7XbNSBRB+K08tZWxAyUsK9+h6eNtxkVWvNujrFcPD6CM4BfmhGi
         8/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691557389; x=1692162189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6b8QaOxHHxr0nsnmybM/OZmFkMm6krciNhVPEUkLHM=;
        b=bS2wViS578mmLY3f71K19zH8nTcmwHHbJ0NyRUb94twiV+/V2VO6X+ykpIXC/4X75D
         xic65tsSAloeZCf5ZD9+91XRUzKXBwMUmjLWYFhQeJgJiRPFkuRa6DWNd/ZenjE4tp1+
         sbds8j1+DI6dsyuTQHfzG7eakWi+ByWLw6a531VVPvhD07mQg2JGBprU12c99e8u/vzI
         AXBZZC+mw4GYhJZHIhHxzhbmLkjJ58mjj10NANa7L6KnYsrTrIdwkCbxACuMsnIEdtSI
         4k+4WxJ7rxCx9XoiroSGoJTY9dcWQWZGSulTBWayP6RbkpeVqDIKBUKgOjyq53FgNxUT
         Tk9A==
X-Gm-Message-State: AOJu0YzuqlC/O0TKqdepo+OSas+RmlQtgmK0f7rEYl87pIJ86SeB12uA
        ufF4cwIkkUBjdlaDrghfygl/AzIgCED7TeQL+bs=
X-Google-Smtp-Source: AGHT+IHPj+fZ7S49PElSE5yx8scu586CwNUbYIc0xj64aUe7m/JpkHYOW0tpcJm9OPelp5Q2V/0HR3Dr50Nj19k+svo=
X-Received: by 2002:a05:651c:1713:b0:2b9:d0bf:a3c5 with SMTP id
 be19-20020a05651c171300b002b9d0bfa3c5mr3997983ljb.14.1691557389258; Tue, 08
 Aug 2023 22:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690273969.git.haibo1.xu@intel.com> <CAAhSdy0yug=J0nxnnPoLYL=0MiT0w6qgPYOcv0QwMRe+fsQn8Q@mail.gmail.com>
 <87y1ilpz3m.wl-maz@kernel.org> <CAJve8onZuOHkAUVY3=QeBPMx5n2F1fGgn57rPp7MB1Q5=vXasA@mail.gmail.com>
 <CAAhSdy277PEBZ4wyUHxQPyN2TugGfhBmC5jUoFTAqMU8vwbt5w@mail.gmail.com>
In-Reply-To: <CAAhSdy277PEBZ4wyUHxQPyN2TugGfhBmC5jUoFTAqMU8vwbt5w@mail.gmail.com>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 9 Aug 2023 13:02:57 +0800
Message-ID: <CAJve8o=6ukbqc_8RvgRxpss2c=q8Ltzf=cNdJ2B85fhNSvNgMQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] RISCV: Add KVM_GET_REG_LIST API
To:     Anup Patel <anup@brainfault.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 9, 2023 at 11:48=E2=80=AFAM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Wed, Aug 9, 2023 at 8:56=E2=80=AFAM Haibo Xu <xiaobo55x@gmail.com> wro=
te:
> >
> > On Tue, Aug 8, 2023 at 7:12=E2=80=AFPM Marc Zyngier <maz@kernel.org> wr=
ote:
> > >
> > > On Mon, 07 Aug 2023 04:48:33 +0100,
> > > Anup Patel <anup@brainfault.org> wrote:
> > > >
> > > > Hi Marc, Hi Oliver,
> > > >
> > > > On Tue, Jul 25, 2023 at 2:05=E2=80=AFPM Haibo Xu <haibo1.xu@intel.c=
om> wrote:
> > > > >
> > > > > KVM_GET_REG_LIST will dump all register IDs that are available to
> > > > > KVM_GET/SET_ONE_REG and It's very useful to identify some platfor=
m
> > > > > regression issue during VM migration.
> > > > >
> > > > > Patch 1-7 re-structured the get-reg-list test in aarch64 to make =
some
> > > > > of the code as common test framework that can be shared by riscv.
> > > > >
> > > > > Patch 8 move reject_set check logic to a function so as to check =
for
> > > > > different errno for different registers.
> > > > > Patch 9 move finalize_vcpu back to run_test so that riscv can imp=
lement
> > > > > its specific operation.
> > > > > Patch 10 change to do the get/set operation only on present-bless=
ed list.
> > > > > Patch 11 add the skip_set facilities so that riscv can skip set o=
peration
> > > > > on some registers.
> > > > > Patch 12 enabled the KVM_GET_REG_LIST API in riscv.
> > > > > patch 13 added the corresponding kselftest for checking possible
> > > > > register regressions.
> > > > >
> > > > > The get-reg-list kvm selftest was ported from aarch64 and tested =
with
> > > > > Linux v6.5-rc3 on a Qemu riscv64 virt machine.
> > > > >
> > > > > ---
> > > > > Changed since v5:
> > > > >   * Rebase to v6.5-rc3
> > > > >   * Minor fix for Andrew's comments
> > > > >
> > > > > Andrew Jones (7):
> > > > >   KVM: arm64: selftests: Replace str_with_index with strdup_print=
f
> > > > >   KVM: arm64: selftests: Drop SVE cap check in print_reg
> > > > >   KVM: arm64: selftests: Remove print_reg's dependency on vcpu_co=
nfig
> > > > >   KVM: arm64: selftests: Rename vcpu_config and add to kvm_util.h
> > > > >   KVM: arm64: selftests: Delete core_reg_fixup
> > > > >   KVM: arm64: selftests: Split get-reg-list test code
> > > > >   KVM: arm64: selftests: Finish generalizing get-reg-list
> > > > >
> > > > > Haibo Xu (6):
> > > > >   KVM: arm64: selftests: Move reject_set check logic to a functio=
n
> > > > >   KVM: arm64: selftests: Move finalize_vcpu back to run_test
> > > > >   KVM: selftests: Only do get/set tests on present blessed list
> > > > >   KVM: selftests: Add skip_set facility to get_reg_list test
> > > > >   KVM: riscv: Add KVM_GET_REG_LIST API support
> > > > >   KVM: riscv: selftests: Add get-reg-list test
> > > >
> > > > Are you okay for this series to go through the KVM RISC-V tree ?
> > >
> > > Sure, seems fine from my point of view. But please put it on an
> > > immutable topic branch so that we can also merge it in the arm64 tree=
,
> > > should we need to resolve any conflicts.
> > >
> >
> > Hi Marc,
> >
> > Thanks for your review!
> >
> > Which topic branch do you prefer or suggest to use?
> > I can do a rebase on it and fix any potential conflicts.
>
> I will share a branch with a stable commit history.
> I have already resolved conflicts at my end.
>

Cool! Thanks for your help!

> Regards,
> Anup
>
> >
> > Regards,
> > Haibo
> >
> > > Thanks,
> > >
> > >         M.
> > >
> > > --
> > > Without deviation from the norm, progress is not possible.
