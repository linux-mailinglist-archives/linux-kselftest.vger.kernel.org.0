Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EAB79191A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352065AbjIDNsa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 09:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351208AbjIDNsa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 09:48:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D0B1712
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Sep 2023 06:48:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a645e54806so175660866b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Sep 2023 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693835302; x=1694440102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h3fvlfFXn3XSbLUjhzD0K7O7WyFDtRiY642hHRw1Uek=;
        b=XVJ61loohnlCQppZrhwndbL54iwlD/8QOhM6wmWdcBvTspmbye0CLST7U7jAScrOMc
         7ihwNbvTWteWCXJB/6aT9yaZZiGrcFZ3PhVtd/xw62S6Q1nZoC2nXzqsFXArw1l489wR
         B/+YDR/53KDwYxyIebSnFmvvukpK/8hbm+OVBMWZSgEj89jU9jbIXWmsGWpdg/WrdrP3
         yC5FjnLos2TWnpFpPX4MiC1kJfbxU4D1H0hKVufQqa+aCV4h5OllYme5DCQnx7Lwoe/r
         0knHcaD0zfZQGSPeHw7PrUMJIusBy/vkYtjjz1cxGWc/RgxqTs4ab/at/Kay8GicCFFf
         AdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693835302; x=1694440102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3fvlfFXn3XSbLUjhzD0K7O7WyFDtRiY642hHRw1Uek=;
        b=awhoohpOhY8vTEmXTejJLsEBBf7QO+W/MKzH3EHnQW/wEF4AWMcx/4wjj8oMlkUTMk
         LwJHmA58tWellQs+p8mlmv8npk+QCwdfu8ER/1GcdFqN+5mcIdmqVHa1q9t3SuPAjiVC
         DYYqGcgooSi0uy9k8EawVBxeR9Zl+sn4M3/7GnwEfSPXDFrMN3P9fsi5eRGYnNEqD+2V
         fyHGoRELBVGQu9JAkbGKHJneM1BDHBpWULpBBTxE/uBsa2coF/9jnnYr0vag0qBsE2Fe
         e07D4kM261gCO0kge3sTYza/3u/VVoGklkP/9C8yhplHoVL/J+L3k+ltr/+QUJ9UOwHG
         UEQA==
X-Gm-Message-State: AOJu0YxYYgXgWRw7F9CSqoB9IKwdoDM4b8lcg2ZrFiPJ1bxNoNkrMG1y
        q2JolD7xLr48Ik0UVa5WiAUVZA==
X-Google-Smtp-Source: AGHT+IEdmuQ6wKTsIKPR4BXTBtwQWbUG0Viumxey9/oZVxntWMhJSLmNtJQgpZUnWcUIixf4ahyhVQ==
X-Received: by 2002:a17:907:2e19:b0:9a1:ce57:8e47 with SMTP id ig25-20020a1709072e1900b009a1ce578e47mr7114400ejc.68.1693835302263;
        Mon, 04 Sep 2023 06:48:22 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id h26-20020a1709062dda00b009a1fef32ce6sm6233554eji.177.2023.09.04.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:48:21 -0700 (PDT)
Date:   Mon, 4 Sep 2023 15:48:21 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
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
        Greentime Hu <greentime.hu@sifive.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Lei Wang <lei4.wang@intel.com>,
        Vipin Sharma <vipinsh@google.com>,
        Like Xu <likexu@tencent.com>, Peter Gonda <pgonda@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Thomas Huth <thuth@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 6/8] KVM: riscv: selftests: Add guest helper to get
 vcpu id
Message-ID: <20230904-db7e8ba933a271ef6aafa4b3@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
 <23d13f60b5a2fd31b87ae78458507f46442fac3a.1693659382.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d13f60b5a2fd31b87ae78458507f46442fac3a.1693659382.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 02, 2023 at 08:59:28PM +0800, Haibo Xu wrote:
> Add guest_get_vcpuid() helper to simplify accessing to per-cpu
> private data. The sscratch CSR was used to store the vcpu id.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/include/aarch64/processor.h | 4 ----
>  tools/testing/selftests/kvm/include/kvm_util_base.h     | 2 ++
>  tools/testing/selftests/kvm/lib/riscv/processor.c       | 8 ++++++++
>  3 files changed, 10 insertions(+), 4 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
