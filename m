Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8949678B29C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjH1OIg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 10:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjH1OII (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 10:08:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2746F7
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 07:08:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6ce0c4489bso3655040276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693231685; x=1693836485;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQzBZViMiXxzuO/spH4qOnPzxeBorWIS0cpOhC8IESs=;
        b=fboNAGalMsxnymcuH7wioVYD/m5EN7GeTmFkCaLwBntl9TGqPNA3u6ygbRrxl7Bcq9
         f97CUH2ApiiuJJPtNUx+Z3gBbJcBve2BehuWVeWfMr055SQOZ+CgU3WInkb+o6z9+g2+
         dCK76Zlzg/tCdjA6DSxJYCTT1ufxAAZhuVIKllwjOneVYfUHtpnAOoEh8kKKjwW/t7BZ
         pO3GF1ygEUtt3cPTuLvedl5Q9WeNI39bm+goAiO+JQAVrQArtzZy3LXPwkfRbqgKBu0q
         kU/dyyguNYApXjsZF1QAl+nEFv+GzlSA2WwjvT/BKu7DVfH5VHhIkfJUyK2s8wIQ9ycL
         Ywaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693231685; x=1693836485;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQzBZViMiXxzuO/spH4qOnPzxeBorWIS0cpOhC8IESs=;
        b=R2ubOLkyfOhH1aiqPzd5WWr8fac3569iQRithGS2hak2dvuTIGLz+VefngYzmGMBrz
         OGGnvAVzSfnPHDrCTd4elbeJhrguNJSDNTrXS+VH0UbjXB+MRKnwuecN51GsCcm8lfCd
         34XX7Fxz1Lk4Qyk8NxHF13oo6qzrYGfDbR7RS8lQ8+JtUjwgn4SBLKBGJ8OfZEHMgLWn
         YTjEqx6uOj8L7EMH5c8vJqAUfNQ4FAwfzI1H6BbJg4De0layWVTrK699ogubVJ1hC9jB
         cMqdyg3HiwhInG0Go0ieQHXcSYPS3rGQtJsK1GuZIVBZhd6HcRgDkJf4aDZMsMIyNso2
         voSg==
X-Gm-Message-State: AOJu0Yxc9bOVUkgtY3zu4l6XdJfRLxIGYR7zVyNQOHRdAGJTOiyEBBXJ
        +qZfquGARLbVwASqy/Jo3AQUG3NtNZw=
X-Google-Smtp-Source: AGHT+IEPNT5dxV90uoo9KWwoJMe2AWhX3rk37xDhBjZEi+PP9HmLSdQmZzdNZnH9NrHYW4COEsiPyZAlMGs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:41c1:0:b0:d4f:638b:d806 with SMTP id
 o184-20020a2541c1000000b00d4f638bd806mr874814yba.8.1693231685064; Mon, 28 Aug
 2023 07:08:05 -0700 (PDT)
Date:   Mon, 28 Aug 2023 07:08:05 -0700
In-Reply-To: <CAJve8onbxHjJoC-k-TtOm1BBtjm38moaW-Kk8siKsxt9nwZZZw@mail.gmail.com>
Mime-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com> <ZMrVrXlvu/FJEayx@google.com>
 <CAJve8onbxHjJoC-k-TtOm1BBtjm38moaW-Kk8siKsxt9nwZZZw@mail.gmail.com>
Message-ID: <ZOyqRfdvxpdtSE1c@google.com>
Subject: Re: [PATCH 0/4] RISCV: Add kvm Sstc timer selftest
From:   Sean Christopherson <seanjc@google.com>
To:     Haibo Xu <xiaobo55x@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023, Haibo Xu wrote:
> On Thu, Aug 3, 2023 at 6:16=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Thu, Jul 27, 2023, Haibo Xu wrote:
> > > The sstc_timer selftest is used to validate Sstc timer functionality
> > > in a guest, which sets up periodic timer interrupts and check the
> > > basic interrupt status upon its receipt.
> > >
> > > This KVM selftest was ported from aarch64 arch_timer and tested
> > > with Linux v6.5-rc3 on a Qemu riscv64 virt machine.
> > >
> > > Haibo Xu (4):
> > >   tools: riscv: Add header file csr.h
> > >   KVM: riscv: selftests: Add exception handling support
> > >   KVM: riscv: selftests: Add guest helper to get vcpu id
> > >   KVM: riscv: selftests: Add sstc_timer test
> >
> > FYI, patch 4 will conflict with the in-flight guest printf changes[*], =
as will
> > reworking the existing arch_timer test.  My plan is to create an immuta=
ble tag
> > later this week (waiting to make sure nothing explodes).  I highly reco=
mmend basing
> > v2 on top of that.
> >
>=20
> Hi Sean,
>=20
> Could you help point me to the immutable tag for the guest printf changes=
?

Sorry, I forgot to create the tag until last week, probably made it a bit h=
ard to
find...

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-immutable-6.6
