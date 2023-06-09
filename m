Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0B729527
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbjFIJaZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 05:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbjFIJaM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 05:30:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF34619C
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 02:24:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5147e8972a1so2718657a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686302680; x=1688894680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZarEebR8QFxdGd6BDii6BW9L7KO3qDDoKK/MEwvn90=;
        b=Rs9/5cIfXIF0X9dJtfJjl+S6T33jQp4Px3GDSrcvuwkppHWZXUsL8ehgtlEdVWgQhp
         wZ7iBamYWGVLJ2Km1VI+A0c5Pj7Vi69maem4T1UfWqzM1ICaSwbq2qvkARzSMmxsidJ4
         Z5s05RkJYCldhPOJj5incQPIqdVf8FiB/bV5WhSttaKgHDMK9XkzcR2l0+oh0PPWQR6l
         uxEnpUlJ/GuQWDgQMmKCIbr+mIkQxQIkjpUfyCHTc3RKgv8Hd2GG7MxnWsWVzPJErurs
         8/ZrLm00PA/JasYULG9e43reLoImOlkCmqVWgNktIvQsgTUqewnuDM6i+qfRNSbyMjR2
         JIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686302680; x=1688894680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZarEebR8QFxdGd6BDii6BW9L7KO3qDDoKK/MEwvn90=;
        b=SqnsOgj3FabxLAhdyBSzvOsEjINY4wu+Iq1gw6tvett1UI5xRLeF2PHgd1oKrferoU
         pjWeYdfpzVm9bqhcgNgNzo8rxIIvfyLeiTiigUBZsogO9CacRMNHD3OrmxT0Qq+XPKyn
         M05OPPymoOKv/o/2TX3QH9RRIG1yKURb32rRxw+zv6lAWeIxeYIQtFTvO/4gR/yb0acb
         aoQOa6KdK5l+B28Jmq0cb1MZBQXyWd/ITAVtxhXiJtVfGRukP4mk4C95XWJc7Z7tBEIf
         r4E0VCH0CtKIhIoXO9DyoDOkex6NJPp2Bwj6Fk9/yW9eW2I4NpgPbrcsKDgDxA7lCCTu
         C6tA==
X-Gm-Message-State: AC+VfDyN4TkwsgDVl+X6tS1OXrK87X6dafbFotrzmh61aWxnDZ83APaq
        Cdu9vYCba1a2/EZkaVI+aa2Gig==
X-Google-Smtp-Source: ACHHUZ57wveqIUZeYQtbwSYnijhoIMs/IsyQJREmzHYMiZkR8YpHPOCyKtzTyeI/sdX9LNwraQyNBg==
X-Received: by 2002:a50:fb94:0:b0:4fa:3b3:c867 with SMTP id e20-20020a50fb94000000b004fa03b3c867mr858539edq.17.1686302679914;
        Fri, 09 Jun 2023 02:24:39 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n27-20020a056402515b00b00502689a06b2sm1537895edd.91.2023.06.09.02.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:24:39 -0700 (PDT)
Date:   Fri, 9 Jun 2023 11:24:38 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, maz@kernel.org, oliver.upton@linux.dev,
        seanjc@google.com, Paolo Bonzini <pbonzini@redhat.com>,
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
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 09/10] KVM: riscv: selftests: Skip some registers set
 operation
Message-ID: <20230609-05521f954b0485c69612f00b@orel>
References: <cover.1686275310.git.haibo1.xu@intel.com>
 <73045958d9ab71d5266d012f1e13061afa8c5331.1686275310.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73045958d9ab71d5266d012f1e13061afa8c5331.1686275310.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 09, 2023 at 10:12:17AM +0800, Haibo Xu wrote:
> Set operation on some riscv registers(mostly pesudo ones) was not
> supported and should be skipped in the get-reg-list test. Just
> reuse the rejects_set utilities to handle it in riscv.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/get-reg-list.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> index c4bd5a5259da..abacb95c21c6 100644
> --- a/tools/testing/selftests/kvm/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -211,16 +211,22 @@ static void run_test(struct vcpu_reg_list *c)
>  			++failed_get;
>  		}
>  
> -		/* rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE */
> +		/*
> +		 * rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE on aarch64,
> +		 * or registers that should skip set operation on riscv.
> +		 */
>  		for_each_sublist(c, s) {
>  			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
>  				reject_reg = true;
> -				ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
> -				if (ret != -1 || errno != EPERM) {
> -					printf("%s: Failed to reject (ret=%d, errno=%d) ", config_name(c), ret, errno);
> -					print_reg(config_name(c), reg.id);
> -					putchar('\n');
> -					++failed_reject;
> +				if ((reg.id & KVM_REG_ARCH_MASK) == KVM_REG_ARM64) {
> +					ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
> +					if (ret != -1 || errno != EPERM) {
> +						printf("%s: Failed to reject (ret=%d, errno=%d) ",
> +								config_name(c), ret, errno);
> +						print_reg(config_name(c), reg.id);
> +						putchar('\n');
> +						++failed_reject;
> +					}

Thinking about this some more, shouldn't we attempt the set ioctl for
riscv reject registers as well, but look for different error numbers?

Thanks,
drew
