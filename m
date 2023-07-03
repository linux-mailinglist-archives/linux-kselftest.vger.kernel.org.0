Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019E67453FD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 04:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGCCxa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 22:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGCCx3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 22:53:29 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9235218F;
        Sun,  2 Jul 2023 19:53:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6c3921c8bso61859691fa.3;
        Sun, 02 Jul 2023 19:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688352807; x=1690944807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhyBGVQ1gaH5Dq33+rfxBQOlHqFL4drvkmIj6aJ3EDI=;
        b=O1hWsfHy6op+iJK7RchZka3HezdQVlH4vq5oZ4Ax4HtYBJHdp7SiTUlOd/0MeGRlXW
         qD/ZIYJ7S7K1mp3qOnr6kToxa76JlnRwNUBFg8F1baXgmRqJNnWHdQllc+zNQ/KDquxA
         7ErHevq/QuYL5AcR4Ql1h5QzNaJ9QIQcafCqt4dGXfaEkOM3HL++icZX1GE7OHuqT4Je
         cvxgKsI/a5C0cZWpASXrd1T8JMo5yoIoj74Zs2ka04Rmp+6QnFbys2scKj3azEQXgQ2p
         1SDy5h+KL7Ty3XPYq179EooH/TEpDroawrvKxJ2iJS0i2N+UJhV225NmXPpDfy0Ly7ur
         MwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688352807; x=1690944807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhyBGVQ1gaH5Dq33+rfxBQOlHqFL4drvkmIj6aJ3EDI=;
        b=IM3Gs7DaIM4xwZMU9A1O9itQhG30KTZobBn0AR+a+u8sllFva9Ed/rN8dlYq5UUUJe
         mqwOfWPDos11UnFLWa7Nn5mfXckUMRh1QV3XTswGu63bNyalMTzxX1KHo3aPSsw3oOua
         XIL3+R/C4WpqzAv8C4DOZv8v1+3zsrZJYx+R0G/gCseFgOwU/h9Cn9TSYaBZ7He9BAq+
         zJ9rk4ksxSPbBgduEwbWjMrSeWsAQjp7BHt/Qg5UkEi0A3XzkwMrOloiGasgMQQY8IJY
         8FxwnxaMAT3b14LIzC15p/cokJysVJkS/jm+Fc1v8mYZx9jdZcclue8109N0gVAI9zhk
         5TDw==
X-Gm-Message-State: ABy/qLYEjZYszfkDLSeNnhovWb8bYYM7Qay0+YwH315a4nouOHDmol2N
        qs4FV/4EWddpejUYov3plOZl1DZKhVzaDHnTKhg=
X-Google-Smtp-Source: APBJJlFfL2px5Y6Cyr17rNDrNo5fJ8sdzYko47a6W75rx7foKvBUjbZJAB2cC/NyOavCuc3SoyWVNmryeUVMgdKDyso=
X-Received: by 2002:a2e:9205:0:b0:2b6:e128:e7a3 with SMTP id
 k5-20020a2e9205000000b002b6e128e7a3mr2116081ljg.33.1688352806560; Sun, 02 Jul
 2023 19:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688010022.git.haibo1.xu@intel.com> <20230701-e1bff47a0ed38ec3ab6ca252@orel>
In-Reply-To: <20230701-e1bff47a0ed38ec3ab6ca252@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Mon, 3 Jul 2023 10:53:15 +0800
Message-ID: <CAJve8on_SRbPmQ4U16imMUjrqs_abLsW64xJotBxRSv65WJa-w@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] RISCV: Add KVM_GET_REG_LIST API
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
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
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

On Sat, Jul 1, 2023 at 10:53=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sat, Jul 01, 2023 at 09:42:48PM +0800, Haibo Xu wrote:
> > KVM_GET_REG_LIST will dump all register IDs that are available to
> > KVM_GET/SET_ONE_REG and It's very useful to identify some platform
> > regression issue during VM migration.
> >
> > Patch 1-7 re-structured the get-reg-list test in aarch64 to make some
> > of the code as common test framework that can be shared by riscv.
> >
> > Patch 8 move reject_set check logic to a function so as to check for
> > different errno for different registers.
> > Patch 9 move finalize_vcpu back to run_test so that riscv can implement
> > its specific operation.
> > Patch 10 change to do the get/set operation only on present-blessed lis=
t.
> > Patch 11 add the skip_set facilities so that riscv can skip set operati=
on
> > on some registers.
> > Patch 12 enabled the KVM_GET_REG_LIST API in riscv.
> > patch 13 added the corresponding kselftest for checking possible
> > register regressions.
> >
> > The get-reg-list kvm selftest was ported from aarch64 and tested with
> > Linux v6.4 on a Qemu riscv64 virt machine.
>
> Hi Haibo,
>
> This series needs a rebase on top of these recent patches
>
>  commit ee053e03b08e ("KVM: selftests: get-reg-list: support ID register =
features")
>  commit 5f0419a0083b ("KVM: selftests: get-reg-list: add Permission Indir=
ection registers")
>
> The conflicts will be in my patches, which do the splitting of the test.
> I'll do the rebase and push it to a branch for you to pick up.
>

Thanks for the heads up. I will include your changes in v6.

> Thanks,
> drew
