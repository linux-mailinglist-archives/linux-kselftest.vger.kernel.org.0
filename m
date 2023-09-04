Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC0791959
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbjIDOEd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 10:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjIDOEc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 10:04:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B494CDF
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Sep 2023 07:04:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5007616b756so2530194e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Sep 2023 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693836267; x=1694441067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9tH83s7KCzR3FLIzIaXHcz20Hx2Sr3w2Og6WosJQfY=;
        b=nJ0/criCES/9sc5KpQ9lmmFAaZKE0bUoLf9J17AwOIKlGHtP29i0zBWdk5/1wUJuV3
         ezm7iUZciqsZFcV8JUxw6RkxCgZ3P/Cw72Z2u5I/wDE1MKQSp7iHcUNQ0H4NIa0lTNm9
         sm4tj/4N/6Evfb2dXYimeOb6t2M8meD46ZK2T4BDXafqdZ4EoAqMZVxIokuvfk8nOMl/
         trkxwvMbbBT6/xOE4NLWRhqV0MDmoRAwzcvekY1oqQPkhL66sXSHb69tnOGkoIVfJiN7
         sKo8xd0y16oiZRFqtsBmE6HLU1pSuo2HYNTlrZ+zlEU3CLuJ53UalV5yD2I4dbHRJfx+
         fpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693836267; x=1694441067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9tH83s7KCzR3FLIzIaXHcz20Hx2Sr3w2Og6WosJQfY=;
        b=M/jiHz5VKhyAjmRNKY+vEvImtetroDhsG8dJPMORANxD7u+90ZthlnMOJzkyxBWbfB
         jfS0X6Zti3y12Gs/40OTbkh+V200ugeClEDVu79i1AhKQZaEqgdjcRr5QnqkcITo9jBh
         Xu69Gic3e2SPIOkNTbctJ2/i5AQrXpeR2e2rIs92ewRqFhnzJsdQHxoXd4Ex8vYkN0yq
         JDwOZlgLUcDveoGipHrd9yRCycOwkouES8gPCnj6gMtrAQ9b9FnI7t4zZHMSDZQCFXu5
         v2W5ImjdlJSGdZGz86WjdiKCPJMFJvdlf6Mq/dywcis6MWY71UB+p7U97IA2zpAUVmeY
         OdYA==
X-Gm-Message-State: AOJu0Yy0KX/VAIeiCfSIu1DC64H+6O8QStfEysPjr94XGgA/9utjKlXg
        wf3qAwPtA19qLGMbW6v1rEfupw==
X-Google-Smtp-Source: AGHT+IFF/9PKy4T0NHsglzBux4yLOD/vizZwx8Nlo/Ot5FXCeYE3JH7zKOg8I6O1HYXtVBq3ndfieA==
X-Received: by 2002:a19:5e11:0:b0:500:c566:1797 with SMTP id s17-20020a195e11000000b00500c5661797mr5671974lfb.3.1693836266646;
        Mon, 04 Sep 2023 07:04:26 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id j8-20020a50ed08000000b0052333d7e320sm5801086eds.27.2023.09.04.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 07:04:25 -0700 (PDT)
Date:   Mon, 4 Sep 2023 16:04:24 +0200
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
Message-ID: <20230904-aa8b0d8d23d391586686038a@orel>
References: <cover.1693659382.git.haibo1.xu@intel.com>
 <b6ef1b031e3a581f481cf19a26623388163444b4.1693659382.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ef1b031e3a581f481cf19a26623388163444b4.1693659382.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 02, 2023 at 08:59:29PM +0800, Haibo Xu wrote:
> Move vcpu_has_ext to the processor.c so that other test cases
> can use it for vCPU extension check.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  .../selftests/kvm/include/riscv/processor.h        |  2 ++
>  tools/testing/selftests/kvm/lib/riscv/processor.c  |  9 +++++++++
>  tools/testing/selftests/kvm/riscv/get-reg-list.c   | 14 --------------
>  3 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index d1e5d9f7ad45..6087c8fc263a 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
>  #define RISCV_ISA_EXT_REG(idx)	__kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
>  					     idx, KVM_REG_SIZE_ULONG)
>  
> +bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
> +
>  struct ex_regs {
>  	unsigned long ra;
>  	unsigned long sp;
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index 39a1e9902dec..5ececa566f24 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -15,6 +15,15 @@
>  
>  static vm_vaddr_t exception_handlers;
>  
> +bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> +{
> +	unsigned long value = 0;
> +
> +	vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> +
> +	return !!value;
> +}
> +
>  static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
>  {
>  	return (v + vm->page_size) & ~(vm->page_size - 1);
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index d8ecacd03ecf..c4028bf32e3f 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -44,20 +44,6 @@ bool check_reject_set(int err)
>  	return err == EINVAL;
>  }
>  
> -static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> -{
> -	int ret;
> -	unsigned long value;
> -
> -	ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> -	if (ret) {
> -		printf("Failed to get ext %d", ext);
> -		return false;
> -	}
> -
> -	return !!value;

get-reg-list will now assert on get-reg when an extension isn't present,
rather than failing the __TEST_REQUIRE(), which would do a skip instead.
We need both the return false version and the assert version.

> -}
> -
>  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>  {
>  	struct vcpu_reg_sublist *s;
> -- 
> 2.34.1
>

Thanks,
drew
