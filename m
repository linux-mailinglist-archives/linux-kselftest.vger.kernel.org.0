Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95713789C6B
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 11:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjH0JAX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 05:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjH0I7v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 04:59:51 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB49CAC;
        Sun, 27 Aug 2023 01:59:34 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so34226031fa.3;
        Sun, 27 Aug 2023 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693126773; x=1693731573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDTbBWfZTyLSY1GxTLcGBmj9Y3R8+oQOjLKgrRVSRoI=;
        b=QsTJuukBOy9Wx5+UjxISZ03vjGGYXro+mcZAYFcirguMTn9wzEcqwl3AWIhPfbjSyk
         luVnPk0eM9dz9PKRvwu4DR210UOLRAd4/aBqeq6Fv8e7VamaG42C6935IR6Ypka1P2z6
         5lokt1yKQIEyNSrNa9Wpt4jrLPhkDto+udqpKpNpxXYxTBTLnYZreMAFn0Kthsq5TUzZ
         NsvqrXNK56usF0VJbCp4Fm2TE8tIzLSj/0agSbXp762Jtu6yFvc3ywz4kfYBRYXEcYRb
         A6yXEtiwgi0ehzbg2Ke0OYKeokPz9JJabP62Sk+aTjTDgwJkCq8s/CZWe2iEVVHcIeaF
         vhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693126773; x=1693731573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDTbBWfZTyLSY1GxTLcGBmj9Y3R8+oQOjLKgrRVSRoI=;
        b=ek+f/g3VbPd5gRkSVCcJz4pvZWu4aE+S5MO/Z/X9xOR3TbbW2ONSf+WY6IbOsqc/Em
         5m1dSqd82T5GqTUzeMHiqKG9MgCE9qtm3s56yOVfrWRajXDHi+7L+YcSZTqg/tADKTKh
         mfR38jDIf8sZITmdgPWcK6QS3PslT1+jX9+y1Axvc9uPqP+Oo9cvG+NFCbOwGfnV0ik3
         XQlZ0KBl/rbrWyuJHvNB6bFDVeet2CRZgxjYfkRZ8hU8WPQUGwEH0rrnbRjTrH1TPBvd
         ngO5X9dwuFJV++o1TuLwf8N1g8oZ4WSYEZgwREISKm0mtPqjG2E8T6Q+jNv9GD0AFBZ2
         M2hg==
X-Gm-Message-State: AOJu0YxA0GvdIhoJJWxdBRtCHdbh9iTmx+VQMgF2aQWW3wzy1Il4UJjc
        +/DBvFRYeWFKK0A/sK4hcup2P2mW2OuHlP7AjIc=
X-Google-Smtp-Source: AGHT+IELcxDKtVSIb76h/AeuCg5XOvMcz/LwNeD+AyhN6t71aP3KPCKwg35DFtyslslGZGaVHIe92vXp93/iEL4SPfM=
X-Received: by 2002:a2e:93c4:0:b0:2b4:6e21:637e with SMTP id
 p4-20020a2e93c4000000b002b46e21637emr14351630ljh.16.1693126772636; Sun, 27
 Aug 2023 01:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com> <ZMrVrXlvu/FJEayx@google.com>
In-Reply-To: <ZMrVrXlvu/FJEayx@google.com>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Sun, 27 Aug 2023 16:59:21 +0800
Message-ID: <CAJve8onbxHjJoC-k-TtOm1BBtjm38moaW-Kk8siKsxt9nwZZZw@mail.gmail.com>
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

On Thu, Aug 3, 2023 at 6:16=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Jul 27, 2023, Haibo Xu wrote:
> > The sstc_timer selftest is used to validate Sstc timer functionality
> > in a guest, which sets up periodic timer interrupts and check the
> > basic interrupt status upon its receipt.
> >
> > This KVM selftest was ported from aarch64 arch_timer and tested
> > with Linux v6.5-rc3 on a Qemu riscv64 virt machine.
> >
> > Haibo Xu (4):
> >   tools: riscv: Add header file csr.h
> >   KVM: riscv: selftests: Add exception handling support
> >   KVM: riscv: selftests: Add guest helper to get vcpu id
> >   KVM: riscv: selftests: Add sstc_timer test
>
> FYI, patch 4 will conflict with the in-flight guest printf changes[*], as=
 will
> reworking the existing arch_timer test.  My plan is to create an immutabl=
e tag
> later this week (waiting to make sure nothing explodes).  I highly recomm=
end basing
> v2 on top of that.
>

Hi Sean,

Could you help point me to the immutable tag for the guest printf changes?

Regards,
Haibo

> [*] https://lore.kernel.org/all/20230729003643.1053367-1-seanjc@google.co=
m
