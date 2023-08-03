Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D876DC9F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 02:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjHCA0z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 20:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjHCA0y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 20:26:54 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7491A2D4C;
        Wed,  2 Aug 2023 17:26:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so5685311fa.3;
        Wed, 02 Aug 2023 17:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691022410; x=1691627210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoZdJRRCD7DIg3T8Q7QTkRnDEpeEEskUwca7pJG+IxI=;
        b=BV2XGnI/qFy1jP2RZrxxy5PawxaXrBSIao/gy4MzJBqpa4EbCFUEpNLyYig7VDdtj9
         v+k1mvb1C7xOquCCMI6G1VL2Aay0byu28r9oephZTneSQYDz5ce+mhkGeFK8/elA09OC
         +PuzYQBmeVSBl4B7Ax0khlHfW4Xm+y1N+SCl4YtsjzG1cn8NzrahMD0ilWBze8j05C6a
         F7jlgJZXO0K5FQsAl2kQXMmOBMS2ItO9LD3B8Iv32RmhV0c/CybF3iW7WKlR13haTlBE
         e+6pJFPOeCl5dS/Ho3NvMbHoJhk9WgG1jdovtQiigPstzckWOtNglqw7zT9XtCDKHT/2
         OloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691022410; x=1691627210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoZdJRRCD7DIg3T8Q7QTkRnDEpeEEskUwca7pJG+IxI=;
        b=bh8pGURTyrksFMU/u8cUgx+pG3UzqFW1Swdk5DnDV5LY9HnIzzodmkvY0om2a2VYd0
         YMbKTUGbJMOzsiA83tWwd20kj+nqaeN6wq+SvV4aEqIpboU+uq+3QcRUgZmXeqcTBo2y
         Ye4j69j4+xgqmEDc9eAA05XMw2LaZC2PoqrV/uW7l1EhgOaSzDN8fsf/f8pTYlhRf8gh
         6DGR+g/IHS88ASG5axkm+tdwzZQiXygXSMdZMPYriXn8nHIBB7GyaLYrq950trLYubSK
         7OIP7PPiiKWctE7PT7J8pUomo+B1XWFhNaUF3slNrlv/P5Qeukvv0sZ2q7Ja0EkyRotD
         l7Iw==
X-Gm-Message-State: ABy/qLbjoqhHvTuXSACI+q86W702SvWatIWto9EM+Kou5BUtIKRmPpB9
        ayYm7xUpMKkDZwe1rmf0uvTSzELnbPqTjlAmuvQ=
X-Google-Smtp-Source: APBJJlEcAwC99kXfiEl4UCa5fPyerikS8DcTMLizuQYjiq50F+4FTOBrsrpftIMhPY0eV8AIVrrKUx1zPtue/DCnV4g=
X-Received: by 2002:a2e:380a:0:b0:2b9:601d:2ce with SMTP id
 f10-20020a2e380a000000b002b9601d02cemr6671331lja.35.1691022410379; Wed, 02
 Aug 2023 17:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com> <ZMrVrXlvu/FJEayx@google.com>
In-Reply-To: <ZMrVrXlvu/FJEayx@google.com>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Thu, 3 Aug 2023 08:26:39 +0800
Message-ID: <CAJve8omSEsGN6n9mzWLaPtu7-UxzP2mU3sw+h5AJwpgBrx4XgQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
> [*] https://lore.kernel.org/all/20230729003643.1053367-1-seanjc@google.co=
m

Sure, thanks for the info!
