Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031D37935C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 08:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjIFG5M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 02:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjIFG5L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 02:57:11 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F893CC3;
        Tue,  5 Sep 2023 23:57:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so56073511fa.3;
        Tue, 05 Sep 2023 23:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693983426; x=1694588226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlJV3YrVhcDgjJFnq8JrFHKjW/deWsGxcZLe+DpQPlY=;
        b=IdISELx4D7SkYZ4DrW+yN4qELLd+SqBUZ8WrC3j5G+EsxCTTjQH3hiZWRGMij2XpaE
         QsTYw92BhMyG6whAkAHIvYcCLeSGOP4UXgTrFtJ0Mcd518PqV+tchzfp4Ajb3lPOSY+H
         RS/ZvreFMszz99HACj3H+3X90xTWa9cxvzNkHdgi49Ir5XTaHNV7TAHybgSZYkDlMCAJ
         bS2s30pO66ofzsvFreW/ghDrZ3rVRRxfA6cigY4VVJSyaQPaHFmsDam0yo3ygN4OdnkG
         fer2i22rmjL3h1K3whh89x712cn2cWuF6JSK6mdxSpR4ESM1aSnR9817CTQho73dqT87
         8Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693983426; x=1694588226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlJV3YrVhcDgjJFnq8JrFHKjW/deWsGxcZLe+DpQPlY=;
        b=l0s1WhuiRe3TCSTTpAXAal9nJzT2S/lyPU4fUbUX7n8I0gQvKYd5jQ7n10nABdHdHT
         CYARlPAUCA/TkgHNmqwPSuYoy0SxO6142QMZlYIiulf5NEaaSvOjHMH3HY/XjmLuiDGj
         nJfZ2Ks9D8imdPA8ECE0ucUbdNiD7k33EirioqBxe33QPgFu7bL6vZ/Ll5knEw+iw4qa
         TXgBlMGcPp9/rtO0RcHClEEM90cM6/REUzmEn6mC6gz8fjoC/h9b/403XLm6QNA3nlFc
         uDfSB21SZIG3k93uCCEvKgANbVgc0JqJTU1tXT9FCYeJP3hZ8fPa4BmTiL7AOAcEgmEL
         Egvg==
X-Gm-Message-State: AOJu0YwIsrV1XI9DdvzeRC7pazlLE4NJh+KfBWPPm23zeuQTk+u2px3q
        Hw9y+Y6tiYTqxUIVF72RqgL+VZDuFhoGVYbFczE=
X-Google-Smtp-Source: AGHT+IE2wohgSgl/gZUM1LzzLcCwq5kIveaGhSl1JWbsEVX+uMGhnRmRqbVkQ36vSc6Xb8HN2ND74xdMHJJ7AowqLIU=
X-Received: by 2002:a2e:b051:0:b0:2bc:e1a3:fbaa with SMTP id
 d17-20020a2eb051000000b002bce1a3fbaamr1470233ljl.22.1693983425421; Tue, 05
 Sep 2023 23:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693659382.git.haibo1.xu@intel.com> <ee4e518cbed9ff4210b74a22c5af21c410fab85d.1693659382.git.haibo1.xu@intel.com>
 <20230904-d35320b23119ee97737e8a74@orel>
In-Reply-To: <20230904-d35320b23119ee97737e8a74@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 6 Sep 2023 14:56:54 +0800
Message-ID: <CAJve8om7Rmp-gbyT7DfHQVPrpkrgA95pbLVrTh=-S2HegkuXpQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] KVM: riscv: selftests: Switch to use macro from csr.h
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        wchen <waylingii@gmail.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>, Like Xu <likexu@tencent.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Thomas Huth <thuth@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
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

On Mon, Sep 4, 2023 at 9:31=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Sat, Sep 02, 2023 at 08:59:26PM +0800, Haibo Xu wrote:
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/include/riscv/processor.h | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/to=
ols/testing/selftests/kvm/include/riscv/processor.h
> > index 5b62a3d2aa9b..6810c887fadc 100644
> > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > @@ -8,6 +8,7 @@
> >  #define SELFTEST_KVM_PROCESSOR_H
> >
> >  #include "kvm_util.h"
> > +#include <asm/csr.h>
> >  #include <linux/stringify.h>
> >
> >  static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
> > @@ -95,12 +96,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, u=
int64_t idx,
> >  #define PGTBL_PAGE_SIZE                              PGTBL_L0_BLOCK_SI=
ZE
> >  #define PGTBL_PAGE_SIZE_SHIFT                        PGTBL_L0_BLOCK_SH=
IFT
> >
> > -#define SATP_PPN                             _AC(0x00000FFFFFFFFFFF, U=
L)
> >  #define SATP_MODE_39                         _AC(0x8000000000000000, U=
L)
> >  #define SATP_MODE_48                         _AC(0x9000000000000000, U=
L)
>
> SATP_MODE_39/48 are also in csr.h
>

Good catch! These 2 should also be removed. Will fix it in the next version=
.

> > -#define SATP_ASID_BITS                               16
> > -#define SATP_ASID_SHIFT                              44
> > -#define SATP_ASID_MASK                               _AC(0xFFFF, UL)
> >
> >  #define SBI_EXT_EXPERIMENTAL_START           0x08000000
> >  #define SBI_EXT_EXPERIMENTAL_END             0x08FFFFFF
> > --
> > 2.34.1
> >
>
> Thanks,
> drew
