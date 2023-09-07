Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC028797AC9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 19:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245694AbjIGRsx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 13:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245566AbjIGRsn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 13:48:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C632101
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Sep 2023 10:48:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bd0a5a5abbso21697751fa.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Sep 2023 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694108885; x=1694713685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SUKo+1CllhDiFuk8e5kRvChp7TbG5sdYIOTqTfNiyNA=;
        b=j6GXcpCinQ/wlXDrWkZgRo41Pa+7J0cy9zLbY5gwmRcoPBeu8G6EzpxY2WSB7MINE7
         hf0x3gU7oE/eJE+Rs2gkdAm/OzsDr7aX/JcFIkONgDy6AgPw7oa+Tos0w3Gh3my4GeJp
         G4j/fa066n9ZUT4J4dMp5JW3u2LGWgNf6rlYmGD28IsBATdFTM6vbc34ILsp+xvTLgZl
         ZkavuJ/rGAE/fuau9EXXCfvSwnpFOeErslayTRIdBs1cHthZvVe8Y70OQb8+A2U3kEAK
         bxIXu9XpNl6n6tJ1gbyzDXC9BrDnhd8oLz7jCeFLzC+KABRqdHp48/DYpfsGxpBQVCfr
         upNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108885; x=1694713685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUKo+1CllhDiFuk8e5kRvChp7TbG5sdYIOTqTfNiyNA=;
        b=RHjYUCRlxWxFtg+PN3LIi6EZqvZjkXnu/7tSzYxPqsEtsgo5zsUrmb9obEL3eaOKoo
         LCgEPIhgzdQft9KTn2X/Ke+y33DBJMzlaXec6uemYeI1pno2joX3WX5k1VIQzEcE3VH6
         cmCQHCG9pKB7vE8qvZP4ppZBuIAplrURIU2L0iFhb0LF/uFwL7Q9Kw3lJ3VKC/8ESUkI
         LOJK6JPHW6CpM+O3cZGyTgs3u8ylrd5dVsXk3IRcs0bWg4dIiTpNAvpQrsamXYoUDfw2
         /hdEPwBmO6LDu94qiefG1uCg84ekKJCsWrNZd40oWpWhUdnzUvQz5f/NKAxWJ2PGkNXs
         JXkg==
X-Gm-Message-State: AOJu0YzKNoOSs4mERPfhEUYZiEng5LKXbO5Xh1PpjsCbZOALuecvaVkR
        ovxOH7X1i1znRWwT25a6G606rZ8AvFkKHoWcUqU=
X-Google-Smtp-Source: AGHT+IFpt5OHjqn8E5AQWQ3lRTTwlRHl603sQrss7nLMvcblN8lMTU9C4YqIhqBmSU5t7umjGBWQQA==
X-Received: by 2002:a7b:c414:0:b0:3fe:f74c:b4f6 with SMTP id k20-20020a7bc414000000b003fef74cb4f6mr4055831wmi.17.1694077304089;
        Thu, 07 Sep 2023 02:01:44 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id s13-20020a7bc38d000000b003fe24441e23sm1882132wmj.24.2023.09.07.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:01:43 -0700 (PDT)
Date:   Thu, 7 Sep 2023 11:01:42 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <xiaobo55x@gmail.com>
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
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        wchen <waylingii@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Lei Wang <lei4.wang@intel.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Like Xu <likexu@tencent.com>, Peter Gonda <pgonda@google.com>,
        Thomas Huth <thuth@redhat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, Paul Durrant <paul@xen.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 7/8] KVM: riscv: selftest: Change vcpu_has_ext to a
 common function
Message-ID: <20230907-bde62d037a3aaeedfe31f964@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
 <b6ef1b031e3a581f481cf19a26623388163444b4.1693659382.git.haibo1.xu@intel.com>
 <20230904-aa8b0d8d23d391586686038a@orel>
 <CAJve8ok5cU+h1K+WJ+aDpB+u+PBo8XosUyyVbMGy-xR0XiWFdw@mail.gmail.com>
 <CAJve8om+dLcG+4trDfG1yx8vhj52RhPZrJoF-emWDX+OPM088A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8om+dLcG+4trDfG1yx8vhj52RhPZrJoF-emWDX+OPM088A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 07, 2023 at 11:57:00AM +0800, Haibo Xu wrote:
> On Wed, Sep 6, 2023 at 6:10 PM Haibo Xu <xiaobo55x@gmail.com> wrote:
> >
> > On Mon, Sep 4, 2023 at 10:04 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > >
> > > On Sat, Sep 02, 2023 at 08:59:29PM +0800, Haibo Xu wrote:
> > > > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > > index d8ecacd03ecf..c4028bf32e3f 100644
> > > > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > > > @@ -44,20 +44,6 @@ bool check_reject_set(int err)
> > > >       return err == EINVAL;
> > > >  }
> > > >
> > > > -static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > > > -{
> > > > -     int ret;
> > > > -     unsigned long value;
> > > > -
> > > > -     ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > > > -     if (ret) {
> > > > -             printf("Failed to get ext %d", ext);
> > > > -             return false;
> > > > -     }
> > > > -
> > > > -     return !!value;
> > >
> > > get-reg-list will now assert on get-reg when an extension isn't present,
> > > rather than failing the __TEST_REQUIRE(), which would do a skip instead.
> > > We need both the return false version and the assert version.
> > >
> >
> > Ok, Will keep this one for get-reg-list and add another one for
> > arch-timer specific usage.
> >
> 
> Just thought about it again, maybe we only need the "return false"
> version for both get-reg-list
> and arch-timer tests since if an extension was not available, the test
> can be skipped with a message.
> 
> bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> {
>        unsigned long value = 0;
> 
>        __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> 
>        return !!value;
> }

Yup, I had actually seen that when reviewing a later patch in this series,
but I wasn't concerned if we added the assert type anyway, since we
frequently end up with the two function types for KVM queries. If we don't
have a need for an assert type yet, then we don't need to introduce it.
However, we should introduce the non-assert type as __vcpu_has_ext(),
reserving the vcpu_has_ext() name for the assert type, per the kvm
selftests naming convention.

Thanks,
drew
