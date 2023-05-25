Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3527711124
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 18:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjEYQkN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 12:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjEYQkM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 12:40:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3568797
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 09:40:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6cbf02747so6300705e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685032808; x=1687624808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AR0TcRh5E3uNMVlwV4MX3XAnDWVMVCj/HBAPlYOkb4Q=;
        b=SMOO/RHoH9sCbPbHZOhilUrB2bJNfvDLCzNO5ccrVnl5YTsggfxCAGw2enOsIJsw3S
         muOPMMbM8OB9rpMjOPTcLN0styrxHRbccc9yTmXWbgcevJUP1pwqZXi98iwgUX4Pfv55
         os7jsjCiXCLLhdD3CTPGSThlSx7rRpRDglbQkL4uhDoPpGndSA0UT7be/09Y3qB4sCTU
         9Jj2LjqrHnXVoyAXUQEyeCSGlSCPNGIKyvU2Ar0ZXlrITl5RpUUhEMrIW9rij7AQisZh
         pS4SfprjWAgXcStQyvo0bOqre47fTQRcCig3TUxi2T6iUTtbEYJBhRLX2YVECM6VJ7Ni
         /zsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685032808; x=1687624808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR0TcRh5E3uNMVlwV4MX3XAnDWVMVCj/HBAPlYOkb4Q=;
        b=Qy3XfhD6YELxHgrM8TNa1y/LVeHkPN/wzG6CtBpmJDL8jGUTj9uVAooQNGmM0oLtSP
         uv+s+xBzAz2RtjLjIQsej+OiGwEOtkL5VzVfsG29eunej+SDToLMEXCpMAn9OhyuMfYb
         T1sci55QsCTbQ2YEJsNNyCGKSdpqK3zz9myu5gj6wpfUEWoktJzShSV1kSgHyO3b30/L
         z7qKNtNmqI/dYSNW6e1QDR0IsByG5ue99X2twgOHUWu8jZd22yld0SqmP3SWDA7v4imj
         rxhowfPvpBlqJ6yfE5IcfgpGkOOYJZ0AOXA5HxFJuLCQoYfKqojNQ1tDMqvTX2GPVD1j
         wopQ==
X-Gm-Message-State: AC+VfDyXpPTGhf6d7QexxiaSgxhWN2e19Zadg2cD6r7uu0YsUkAFIO3u
        U7LgDF7daluzaxQOWyWWEnwA+w==
X-Google-Smtp-Source: ACHHUZ4E3vZaFea6aEdcJxuXhPYk5shRp2rDROSu38VNjlX+Zz36M4ciiQeNekDxjPytu3ey3fhDvg==
X-Received: by 2002:a7b:cbd6:0:b0:3f4:2452:9669 with SMTP id n22-20020a7bcbd6000000b003f424529669mr3090300wmi.0.1685032808575;
        Thu, 25 May 2023 09:40:08 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id c2-20020adfed82000000b003078a3f3a24sm2311517wro.114.2023.05.25.09.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:40:07 -0700 (PDT)
Date:   Thu, 25 May 2023 18:40:07 +0200
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
Subject: Re: [PATCH v2 09/11] KVM: riscv: selftests: Make check_supported
 arch specific
Message-ID: <20230525-705ddcbcd43aa63e3fd356c8@orel>
References: <cover.1684999824.git.haibo1.xu@intel.com>
 <26dea518fc5e8da51e61db279d175364bfecd009.1684999824.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26dea518fc5e8da51e61db279d175364bfecd009.1684999824.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 25, 2023 at 03:38:33PM +0800, Haibo Xu wrote:
> check_supported() was used to verify whether a feature/extension was
> supported in a guest in the get-reg-list test. Currently this info
> can be retrieved through the KVM_CAP_ARM_* API in aarch64, but in
> riscv, this info was only exposed through the KVM_GET_ONE_REG on
> KVM_REG_RISCV_ISA_EXT pseudo registers.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/get-reg-list.c | 32 +++++++++++-----------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> index f6ad7991a812..f1fc113e9719 100644
> --- a/tools/testing/selftests/kvm/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -99,6 +99,20 @@ void __weak print_reg(const char *prefix, __u64 id)
>  }
>  
>  #ifdef __aarch64__
> +static void check_supported(struct vcpu_reg_list *c)
> +{
> +	struct vcpu_reg_sublist *s;
> +
> +	for_each_sublist(c, s) {
> +		if (!s->capability)
> +			continue;

I was going to say that making this function aarch64 shouldn't be
necessary, since riscv leaves capability set to zero and this function
doesn't do anything, but then looking ahead I see riscv is abusing
capability by putting isa extensions in it. IMO, capability should
only be set to KVM_CAP_* values. Since riscv doesn't use it, then it
should be left zero.

If we're going to abuse something, then I'd rather abuse the 'feature'
member, but since it's only an int (not an unsigned long), then let's
just add an 'unsigned long extension' member.

Then, the finalize_vcpu() call can be moved back to run_test(), from
aarch64's vcpu_config_get_vcpu(). Both aarch64 and riscv will call it
right after vcpu_config_get_vcpu() and the riscv version of it will
do what your current riscv check_supported() is doing, using the
new 'extension' member instead of 'capability'.

And this patch gets dropped.

Thanks,
drew

> +
> +		__TEST_REQUIRE(kvm_has_cap(s->capability),
> +			       "%s: %s not available, skipping tests\n",
> +			       config_name(c), s->name);
> +	}
> +}
> +
>  static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu_init *init)
>  {
>  	struct vcpu_reg_sublist *s;
> @@ -126,6 +140,8 @@ static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, struct kvm
>  	struct kvm_vcpu_init init = { .target = -1, };
>  	struct kvm_vcpu *vcpu;
>  
> +	check_supported(c);
> +
>  	prepare_vcpu_init(c, &init);
>  	vcpu = __vm_vcpu_add(vm, 0);
>  	aarch64_vcpu_setup(vcpu, &init);
> @@ -140,20 +156,6 @@ static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, struct kvm
>  }
>  #endif
>  
> -static void check_supported(struct vcpu_reg_list *c)
> -{
> -	struct vcpu_reg_sublist *s;
> -
> -	for_each_sublist(c, s) {
> -		if (!s->capability)
> -			continue;
> -
> -		__TEST_REQUIRE(kvm_has_cap(s->capability),
> -			       "%s: %s not available, skipping tests\n",
> -			       config_name(c), s->name);
> -	}
> -}
> -
>  static bool print_list;
>  static bool print_filtered;
>  
> @@ -165,8 +167,6 @@ static void run_test(struct vcpu_reg_list *c)
>  	struct kvm_vm *vm;
>  	struct vcpu_reg_sublist *s;
>  
> -	check_supported(c);
> -
>  	vm = vm_create_barebones();
>  	vcpu = vcpu_config_get_vcpu(c, vm);
>  
> -- 
> 2.34.1
> 
