Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FFC76615B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 03:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjG1Bhw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 21:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjG1Bhv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 21:37:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3731D213F;
        Thu, 27 Jul 2023 18:37:50 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9c66e2e36so13951681fa.1;
        Thu, 27 Jul 2023 18:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690508268; x=1691113068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmjTr+Ekzs2/OcMS11bK61qR3FE3+8TZNMuctMbi2xU=;
        b=g3XKJEBsMYV3c0Kt8g5oFFYp9QszFI4Xi44G0Vw+EBF1HesmjK55TbMbLP9qV1nrWq
         hqs3p0Uql3PmXLMlboft9T8dJATBm1bmt71uxJ0xe0ZpnzS65vPIrluuodviQhC7Vmbu
         belTfY1/A6XVbJd1Ca21hzt5C97wjfwHGqAZtnw+H9aPkbpp1xBMDkOHH1NT2/aSp49o
         QFEfxSo6zTyPkfaj3tIAOiCtWt11HHT6uZoGAqbc1b+HKjtfZdQ6vxa/h8pyedq5hiuf
         PCjjB7IZkdYe4ZiTc6OYPdx4bzbysqSB+7Oq8uh2akBDNMVUs1LyTg5dz32Nba9MpHrA
         SBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508268; x=1691113068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmjTr+Ekzs2/OcMS11bK61qR3FE3+8TZNMuctMbi2xU=;
        b=fJFZfgGeU5nlpUsySnjWmJIYBO2DHlb79MsXGYgo84SH/qkI5IlO/43o3Osu7tOfLy
         LS0I+CqmDn0TxRylR6C9Et5YOrsmsAwDhHLutbFHL3NmEFQV8n5ZhQplRqqpTySsQron
         xoaeTSWgCWtbl+Fx4ilf71WVduYv0Mp1USjsnf0oPh77yf2UlSEvPp50C1sKxSLtWISS
         RCGjvm2bsvgQW/9sXeAaLsC15OsSZB/Wf6xDjvdxxxTVoi3Zqswh18nHZbm0tEOoY1zw
         VKCjaDEzMD4sR7DCuLWLrRF0MOXUUBAFKH5SU9ghGyGM5YYhEsGYoE8AzTxVomlkevYF
         94Gg==
X-Gm-Message-State: ABy/qLZa4+OPY/jnbm1nz7QHnvllB8EAzlK0yMqk37zr95ymvBrIvyqf
        OCvwZiqzzLHYeFR6qdTtoa+d5kMInMtU+lWcxG0=
X-Google-Smtp-Source: APBJJlE7RBP0m6Cdxi2m2dGUmO1cYZcOkYxJP8XD/p6rsaSHOzDWb6nGGZU9uLRgMKl0lanZNx+EbxgKTJx1XXbcCh0=
X-Received: by 2002:a2e:b4b1:0:b0:2b9:b1fb:5ff4 with SMTP id
 q17-20020a2eb4b1000000b002b9b1fb5ff4mr1360093ljm.21.1690508268189; Thu, 27
 Jul 2023 18:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com> <ZMKI8RknjjZBOaxf@google.com>
In-Reply-To: <ZMKI8RknjjZBOaxf@google.com>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Fri, 28 Jul 2023 09:37:36 +0800
Message-ID: <CAJve8o=GZnLLedT7TvCLvgd5Z3ZxJNfM6gG03Eyc+7krtMY--g@mail.gmail.com>
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

On Thu, Jul 27, 2023 at 11:14=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Jul 27, 2023, Haibo Xu wrote:
> > The sstc_timer selftest is used to validate Sstc timer functionality
> > in a guest, which sets up periodic timer interrupts and check the
> > basic interrupt status upon its receipt.
> >
> > This KVM selftest was ported from aarch64 arch_timer and tested
> > with Linux v6.5-rc3 on a Qemu riscv64 virt machine.
>
> Would it be possible to extract the ARM bits from arch_timer and make the=
 bulk of
> the test common to ARM and RISC-V?  At a glance, there is quite a bit of =
copy+paste.

Sure, I will have a try to consolidate the common code for ARM and RISC-V i=
n v2.

Thanks,
Haibo
