Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06521729A0C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjFIMb0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 08:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjFIMbZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 08:31:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B382330F4
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 05:30:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so2095519e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686313843; x=1688905843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8h26DQt30aCyEhPT/ooAbXH6FQid93QFBSmTC7V6R+4=;
        b=A1lJFrFXashPyOVE6TwjfXwLaFl61XNjBlCsCbs7HxXdXlscKu2aQeb9jnMUEWsnFP
         Gqa4zxdJoUevS4rlfUKzeXGooNKBl4E8McMllHfEube1l2jxq71XlpYKaEuc/AZTzZGU
         FsJEx0y3rWxOwbP1p8DZ4JU1y29iK9r7H2K4jK3YiLEIbADb92nGDzMy8FKbGTP1EjBu
         3917iiGGQ3TOwK7VW37L0tpiNLdcO/xRJYaSVn899cvVXqbC0NpJnY27H3fNnzr7Hp3R
         YkdzhR8Zn3sKS5jyM7PVZnwGzGYfrvHrwJrvRUDWtwkbk8efwrHQ7bTVrSq6sPp2DS0N
         OEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686313843; x=1688905843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h26DQt30aCyEhPT/ooAbXH6FQid93QFBSmTC7V6R+4=;
        b=i646JsoUbJpLDZDIZ8kKfJIh9TebFv+0donjGlDqnqirf8l/BOAuol02ydXl8C45Be
         SG9WFJFoHHEPa6sWQFKWhqCshoqbCcRObZ9tlWzfYAJHZr4DWBPXV5yF3udakbR245ag
         VJnSIFzvSay9f+nVuYCMpeZr3lnx3aIT7otYzVU2AqmXjbuSGGSjRmycL+mXW2KPo7QF
         UqINuByb/Cdj2WMGEG13Nw4RT0ulw4InoHdtXPs43oRDFcuuLirpxzHl3tFpI0iVAyzt
         Q63c5v2RWMX9xbocno6CdVEWFq3kmqUF+yYTiBUXobA6YJ/z/YADtGv+sMGJwDJU1CX+
         CGKQ==
X-Gm-Message-State: AC+VfDyvSa2TyGSlSQXSySg8bpKIFRKjZN2qofAYYG7fdyWJG+PArQZX
        6xbMk+jC3SmbvKRCA0eR5E5lrQ==
X-Google-Smtp-Source: ACHHUZ7LLidgDgGdihFdLBcYHtdurgJJ/J4UsIY+yeDDqqFfP2vMmCiYedKW6YkV6nfEzVsYqhM/Ow==
X-Received: by 2002:ac2:5bd0:0:b0:4f2:40dd:e2cf with SMTP id u16-20020ac25bd0000000b004f240dde2cfmr773184lfn.55.1686313843048;
        Fri, 09 Jun 2023 05:30:43 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7dbda000000b0050cc4461fc5sm1703120edt.92.2023.06.09.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 05:30:42 -0700 (PDT)
Date:   Fri, 9 Jun 2023 14:30:41 +0200
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
Subject: Re: [PATCH v3 07/10] KVM: arm64: selftests: Finish generalizing
 get-reg-list
Message-ID: <20230609-b900162a66c26a004b751b1f@orel>
References: <cover.1686275310.git.haibo1.xu@intel.com>
 <450cb59db52ebeaa68f3d77f1bd995618f3612b8.1686275310.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450cb59db52ebeaa68f3d77f1bd995618f3612b8.1686275310.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 09, 2023 at 10:12:15AM +0800, Haibo Xu wrote:
> From: Andrew Jones <ajones@ventanamicro.com>
> 
> Add some unfortunate #ifdeffery to ensure the common get-reg-list.c
> can be compiled and run with other architectures. The next
> architecture to support get-reg-list should now only need to provide
> $(ARCH_DIR)/get-reg-list.c where arch-specific print_reg() and
> vcpu_configs[] get defined.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/get-reg-list.c | 24 ++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> index 69bb91087081..c4bd5a5259da 100644
> --- a/tools/testing/selftests/kvm/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -98,6 +98,7 @@ void __weak print_reg(const char *prefix, __u64 id)
>  	printf("\t0x%llx,\n", id);
>  }
>  
> +#ifdef __aarch64__
>  static void prepare_vcpu_init(struct vcpu_reg_list *c, struct kvm_vcpu_init *init)
>  {
>  	struct vcpu_reg_sublist *s;
> @@ -120,6 +121,24 @@ static void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>  	}
>  }
>  
> +static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, struct kvm_vm *vm)
> +{
> +	struct kvm_vcpu_init init = { .target = -1, };
> +	struct kvm_vcpu *vcpu;
> +
> +	prepare_vcpu_init(c, &init);
> +	vcpu = __vm_vcpu_add(vm, 0);
> +	aarch64_vcpu_setup(vcpu, &init);
> +
> +	return vcpu;
> +}
> +#else
> +static struct kvm_vcpu *vcpu_config_get_vcpu(struct vcpu_reg_list *c, struct kvm_vm *vm)
> +{
> +	return __vm_vcpu_add(vm, 0);
> +}
> +#endif
> +
>  static void check_supported(struct vcpu_reg_list *c)
>  {
>  	struct vcpu_reg_sublist *s;
> @@ -139,7 +158,6 @@ static bool print_filtered;
>  
>  static void run_test(struct vcpu_reg_list *c)
>  {
> -	struct kvm_vcpu_init init = { .target = -1, };
>  	int new_regs = 0, missing_regs = 0, i, n;
>  	int failed_get = 0, failed_set = 0, failed_reject = 0;
>  	struct kvm_vcpu *vcpu;
> @@ -149,9 +167,7 @@ static void run_test(struct vcpu_reg_list *c)
>  	check_supported(c);
>  
>  	vm = vm_create_barebones();
> -	prepare_vcpu_init(c, &init);
> -	vcpu = __vm_vcpu_add(vm, 0);
> -	aarch64_vcpu_setup(vcpu, &init);
> +	vcpu = vcpu_config_get_vcpu(c, vm);
>  	finalize_vcpu(vcpu, c);

I just noticed that this has been modified from what I posted to leave
the finalize_vcpu() call here, despite it now being inside the #ifdef
__aarch64__. That breaks the purpose of the patch. Please make sure this
file compiles for other architectures without requiring additional
patches, which would keep the commit message honest. You can either
revert this to what I posted, and then readd the finalize_vcpu() call in
another patch, or you can add a finalize_vcpu() stub to the #else part
of the ifdef in this patch.

Also please don't modify patches authored by others without calling out
the modifications somewhere, either the commit message or under the ---
of the patch or in the cover letter.

Thanks,
drew
