Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB33B770D13
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 03:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjHEBbj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 21:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHEBbi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 21:31:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F0BE72;
        Fri,  4 Aug 2023 18:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25C0E62193;
        Sat,  5 Aug 2023 01:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4BEC433CC;
        Sat,  5 Aug 2023 01:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691199096;
        bh=ci8WuP6g2LqliK0OHhqNPGA26G25KgSCEbHqWe0PT68=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QA3cE8I1zOdVnBlgr6ab50bKaWyj8synF3xXyhjxdE4vBfRvLRXpFLYpvdCRUmIsf
         8PkIa7yZDIjmG0Tt9ECDlTGPwfNNaDRNi25lzVsAGKvtx+QW8V+cuIL6e0ZYNDJB8M
         UZ/rYO7JybeG7cPBx82sZS9gx8Vueqth4ZHnQ1+73AaJvXbox93IBMkiP65LRZTsjS
         uR/EsdNk7ejMyirWMZ2HWttPmg8yvKfk6vrhZ+BtDPjigHAFhTS+nmAHYTx5JVK9Dw
         79fnWijGBmknBOSqRRp9uu4P4yPy/Xz3rZR9pAEWoc4F9uE7UounFGmwOkBP6+joLo
         2W0NiY2+BHLCw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5221c6a2d3dso3386720a12.3;
        Fri, 04 Aug 2023 18:31:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw8EFBS5mG13tPDqW3fx567iZVd44aEnDqHe6ZsOvWIH1i2RgPL
        xFrakQm0QiC1BaVUefg4vXjwZJ/T8VW8JMwWH5M=
X-Google-Smtp-Source: AGHT+IFd+UVpJ54Cs2bzLsBO42WkS7CwRLTDvfC4S2+C8McYBhJ44DBsoDX8bvx2T1Y2vcQvTfkpUl3/zFXzIHMGMTc=
X-Received: by 2002:a50:ee81:0:b0:523:1edf:c6b6 with SMTP id
 f1-20020a50ee81000000b005231edfc6b6mr2011319edr.40.1691199094841; Fri, 04 Aug
 2023 18:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com> <35ce2b9f7ca655eb3af13730b1ca9f05b518e08f.1690364259.git.haibo1.xu@intel.com>
 <20230728-879500f157954d849fb303ec@orel> <CAJve8onDLEC1JFdERi098sTmN3-UkwaJ1aJz3CJNYU-GShkEyg@mail.gmail.com>
 <ZMsbXk4JU/Ung7qu@gmail.com> <20230803-5b7e7c0d95597b004764a296@orel>
In-Reply-To: <20230803-5b7e7c0d95597b004764a296@orel>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 5 Aug 2023 09:31:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRHGkHnQZNUi6J+xsst0-8CDJxp=79tPj=i_1s2SiW7Hg@mail.gmail.com>
Message-ID: <CAJF2gTRHGkHnQZNUi6J+xsst0-8CDJxp=79tPj=i_1s2SiW7Hg@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: riscv: Add header file csr.h
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <xiaobo55x@gmail.com>, Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Colton Lewis <coltonlewis@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 3, 2023 at 3:44=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Wed, Aug 02, 2023 at 11:13:34PM -0400, Guo Ren wrote:
> > On Wed, Aug 02, 2023 at 10:05:00AM +0800, Haibo Xu wrote:
> > > On Fri, Jul 28, 2023 at 5:43=E2=80=AFPM Andrew Jones <ajones@ventanam=
icro.com> wrote:
> > > >
> > > > On Thu, Jul 27, 2023 at 03:20:05PM +0800, Haibo Xu wrote:
> > > > > Borrow some of the csr definitions and operations from kernel's
> > > > > arch/riscv/include/asm/csr.h to tools/ for riscv.
> > > >
> > > > You should copy the entire file verbatim.
> > > >
> > >
> > > Ok, will copy all the definitions in the original csr.h
> > Why not include the original one? Maintain the one csr.h is more
> > comfortable.
>
> selftests and other userspace tools can't always compile when including a
> kernel header without modifying the header in some way. Rather than
> polluting headers with #ifdeffery, the practice has been to copy necessar=
y
> headers to tools/include and modify if necessary.
Okay, got it.

>
> Thanks,
> drew



--=20
Best Regards
 Guo Ren
