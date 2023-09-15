Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A372F7A15E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 08:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjIOGNd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 02:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOGNc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 02:13:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6DD196;
        Thu, 14 Sep 2023 23:13:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-501eec0a373so2843327e87.3;
        Thu, 14 Sep 2023 23:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694758405; x=1695363205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrYfSyvA1qDzz1C9me2YoJdAvmKAyt6HEOJS2kBsMOc=;
        b=HtixBu7PyJIh5WJebpRFX4vec4oTZqUF5BQgUu0KjQNws2CB74RMIdU3y7X3NoU08J
         4KQ52I3ivVs/cw8c+QhnhnIsH084M6tU730AII5IP3eoFBdxa/MAT0czpTCGNcf3Z9Rf
         HAMKYCJKGew4FRGIAxY3u/f64fELW2iZOHeVAs11+wJrAxhSs4TL/QCHN48/0H67KRsN
         erzHViwZyl050a+gAGSmjITZgUQ04uQhmZRIrvZaOvo0KuQhDViyywbSKNXNRVOJKn3F
         ///u9PRlBlfWMO13x3lR6/X73cxcslwMQlBanm0V2h70Z7JsPKkpouyF7fbUF9cmKAPB
         gIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694758405; x=1695363205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrYfSyvA1qDzz1C9me2YoJdAvmKAyt6HEOJS2kBsMOc=;
        b=BZsGkhZ2aY6AE0XMI0jvZbHDSsYsRrPyGLKNO/qRgMHHzqOVjciEULqELdS8fMQWJb
         f9YrMIRbMSd3CjRuP82nXMzeDTalMYvBVZFdt4wWvVrr4bhvpK4a1/3VzDCVZZicKzLQ
         tueP/iUut4AbpHAcRpLsLFp7tqZwk8WNvEQvQfHW58CxcOc5hCHIjkIPia9JFMhTwX8l
         DYtp4rfirPJvaO8bZnKckiTZ6K9zyuZLDugAT9YCH9zjyYO3susuBh8I2JbNv/Ec2YdF
         Zv90o8cHfcmgqpWUd34IS5m7h7NHQr5fQO853KZSqwg0WkuoHKdluu5HrwZZmmJK4BnB
         kiug==
X-Gm-Message-State: AOJu0YwJnbhugW2tB/+GbQpdCh5OvAnWrmFoMNW2HGKxi/1ST/JstCDe
        z5f7ep/T9Kj1fwLMvTb8JVbfAVSilrAGy2awwJs=
X-Google-Smtp-Source: AGHT+IGkLJqQ/k8slvZGXQMAE/UeB/ooMmN+gETIu3I1Y9kMMNpJ7F3dojbdtU+Jb3bl7yAYuGDVmI9UONACJCtektg=
X-Received: by 2002:ac2:4c8b:0:b0:4fc:3755:37d9 with SMTP id
 d11-20020ac24c8b000000b004fc375537d9mr634044lfl.68.1694758405211; Thu, 14 Sep
 2023 23:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694421911.git.haibo1.xu@intel.com> <6cdda82518977c67004ee01a767bc67962352c13.1694421911.git.haibo1.xu@intel.com>
 <20230914-18bfe93b679e290188e70307@orel>
In-Reply-To: <20230914-18bfe93b679e290188e70307@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Fri, 15 Sep 2023 14:13:13 +0800
Message-ID: <CAJve8okdUtcCihGh4wRb9rHTxuL7=7_1FY8Ez0+QMr=+x7fzoQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] KVM: riscv: selftests: Switch to use macro from csr.h
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
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Peter Xu <peterx@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
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

On Thu, Sep 14, 2023 at 4:52=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Sep 14, 2023 at 09:36:59AM +0800, Haibo Xu wrote:
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/include/riscv/processor.h | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/to=
ols/testing/selftests/kvm/include/riscv/processor.h
> > index 5b62a3d2aa9b..67766baed4f7 100644
> > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > @@ -8,6 +8,7 @@
> >  #define SELFTEST_KVM_PROCESSOR_H
> >
> >  #include "kvm_util.h"
> > +#include <asm/csr.h>
> >  #include <linux/stringify.h>
>
> nit: Usually we try to keep the order of our includes separated into five
> categories, listed below, where each category is sorted alphabetically. O=
f
> course any dependencies the includes have on each other need to be
> considered too.
>
> <library-includes-without-a-subdir>
> <library-includes-with-subdir>
> <linux/...>
> <asm/...>
> "local-includes"
>

It's very helpful. Thanks for sharing it!
Will fix it in v4.

> >
> >  static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
> > @@ -95,13 +96,6 @@ static inline uint64_t __kvm_reg_id(uint64_t type, u=
int64_t idx,
> >  #define PGTBL_PAGE_SIZE                              PGTBL_L0_BLOCK_SI=
ZE
> >  #define PGTBL_PAGE_SIZE_SHIFT                        PGTBL_L0_BLOCK_SH=
IFT
> >
> > -#define SATP_PPN                             _AC(0x00000FFFFFFFFFFF, U=
L)
> > -#define SATP_MODE_39                         _AC(0x8000000000000000, U=
L)
> > -#define SATP_MODE_48                         _AC(0x9000000000000000, U=
L)
> > -#define SATP_ASID_BITS                               16
> > -#define SATP_ASID_SHIFT                              44
> > -#define SATP_ASID_MASK                               _AC(0xFFFF, UL)
> > -
> >  #define SBI_EXT_EXPERIMENTAL_START           0x08000000
> >  #define SBI_EXT_EXPERIMENTAL_END             0x08FFFFFF
> >
> > --
> > 2.34.1
> >
>
> Assuming the CONFIG_64BIT patch will come before this, then
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks,
> drew
