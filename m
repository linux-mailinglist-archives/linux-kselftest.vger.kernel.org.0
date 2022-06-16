Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0B454E07B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376971AbiFPMCj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 08:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiFPMCj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 08:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82795FFA
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655380957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a1YqFst/wCS3dV9U1tom4IUI5FqJmZTxEQ7sGvmyW7Q=;
        b=RJdGcfl+i3u8t7j0cEg6S3ah4Z01mYuOsPHluadPG3IuufcxiGUfEgbCQMzmyDkqNIIjgJ
        KriszEvgDpgwPhwXiMb7yGoKtKGlXGdS10Bnu3ureEhiWwS/RD6VKQ5mvxPj+PSjsInrY5
        utbAII8H7x5+17SwyKRL74Tn4zOF/u0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-6C64or15O4yMUSAJye9LEg-1; Thu, 16 Jun 2022 08:02:36 -0400
X-MC-Unique: 6C64or15O4yMUSAJye9LEg-1
Received: by mail-ed1-f71.google.com with SMTP id co13-20020a0564020c0d00b0042dc9ef4f01so1095507edb.16
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 05:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1YqFst/wCS3dV9U1tom4IUI5FqJmZTxEQ7sGvmyW7Q=;
        b=cprGDhyFRa72m5hrOEJF3h3djci+D1ZOHi+bEH0a0EgEuVoCQM8iDFwp1rEWe4ssiU
         dhkZlFpCPCOWHg8xNXbHiJfaBaFN6J/wtuXmvU+a49AFGHtfj687QnWbF0m78Ey5RMUq
         jJ3/Wkc238o80UkED7xGxCNQOQL0c8r+YFwpRJhky9pFCG5M7WO1obpWF52EX12tA/xx
         EahAAONOeXm30riiN4IaRexSkziPZD1KyNTaCAv8mMo3ImLPzYpuGuO408qNun8MlJ/M
         Aa84ThNAmFm7/QsV5Bu/HrEd7rJtCdLfeoWvIOt5ctO8MvJ7U3EAU2n36gE5x72RnQ21
         yxzQ==
X-Gm-Message-State: AJIora+j0kz628YQK8eLTp6QMYOcos7/YJKtFrU7mZZYg8umQfmICcYJ
        YpZsNPabLBjt9kA0PckmLfvnw+f2tfXbrMK99W35gkSK/tMmuZR9MVw/hPKBGs5A+///k9fmXFx
        GFNxB69xAI1YSPqEKpZjAZaH6VSg9
X-Received: by 2002:a17:906:7489:b0:712:2a98:d36 with SMTP id e9-20020a170906748900b007122a980d36mr4185828ejl.340.1655380955113;
        Thu, 16 Jun 2022 05:02:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sEH/in2gBn+9ByhlZfqVmDXWc4YuaZczo9onOWmlO+Y4/lrgYkHIWOHfH8wVylG+qd74/UKg==
X-Received: by 2002:a17:906:7489:b0:712:2a98:d36 with SMTP id e9-20020a170906748900b007122a980d36mr4185795ejl.340.1655380954888;
        Thu, 16 Jun 2022 05:02:34 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090617d600b006f3ef214dc0sm709130eje.38.2022.06.16.05.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 05:02:34 -0700 (PDT)
Date:   Thu, 16 Jun 2022 14:02:32 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: KVM: Handle compiler optimizations in ucall
Message-ID: <20220616120232.ctkekviusrozqpru@gator>
References: <20220615185706.1099208-1-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615185706.1099208-1-rananta@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 15, 2022 at 06:57:06PM +0000, Raghavendra Rao Ananta wrote:
> The selftests, when built with newer versions of clang, is found
> to have over optimized guests' ucall() function, and eliminating
> the stores for uc.cmd (perhaps due to no immediate readers). This
> resulted in the userspace side always reading a value of '0', and
> causing multiple test failures.
> 
> As a result, prevent the compiler from optimizing the stores in
> ucall() with WRITE_ONCE().
> 
> Suggested-by: Ricardo Koller <ricarkol@google.com>
> Suggested-by: Reiji Watanabe <reijiw@google.com>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  tools/testing/selftests/kvm/lib/aarch64/ucall.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> index e0b0164e9af8..be1d9728c4ce 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> @@ -73,20 +73,19 @@ void ucall_uninit(struct kvm_vm *vm)
>  
>  void ucall(uint64_t cmd, int nargs, ...)
>  {
> -	struct ucall uc = {
> -		.cmd = cmd,
> -	};
> +	struct ucall uc = {};
>  	va_list va;
>  	int i;
>  
> +	WRITE_ONCE(uc.cmd, cmd);
>  	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
>  
>  	va_start(va, nargs);
>  	for (i = 0; i < nargs; ++i)
> -		uc.args[i] = va_arg(va, uint64_t);
> +		WRITE_ONCE(uc.args[i], va_arg(va, uint64_t));
>  	va_end(va);
>  
> -	*ucall_exit_mmio_addr = (vm_vaddr_t)&uc;
> +	WRITE_ONCE(*ucall_exit_mmio_addr, (vm_vaddr_t)&uc);
>  }
>  
>  uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
> -- 
> 2.36.1.476.g0c4daa206d-goog
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks,
drew

