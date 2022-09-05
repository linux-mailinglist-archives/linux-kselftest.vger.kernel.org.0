Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4A5ACD29
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 09:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiIEHqR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiIEHqQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 03:46:16 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FC42D1CD;
        Mon,  5 Sep 2022 00:46:13 -0700 (PDT)
Date:   Mon, 5 Sep 2022 09:46:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662363971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SCEfhooTBrQaT9LKoePqlJT/fiUrAZsQiPWsoYqSYtk=;
        b=RPVVe0Y+85TmCoLEQG4BCaTU0RINvvI0Rw/FiOm9gGlSwnPxpKwoLeRaknGpYL/QRORWmY
        iKugJUSvU/wnr9ycH2SI/Wdt5wHZs/4ZByM1c0wMKZrtr6slZ+rnn56/MvjxCWewEhHYPY
        ogZDO0Cw7F1j/5shF8Vky8jItHYHH+k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
        drjones@redhat.com, dmatlack@google.com
Subject: Re: [V1 PATCH 2/5] selftests: kvm: Introduce kvm_arch_main and
 helpers
Message-ID: <20220905074609.ga4tnpuxpcgppx4r@kamzik>
References: <20220903012849.938069-1-vannapurve@google.com>
 <20220903012849.938069-3-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903012849.938069-3-vannapurve@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 03, 2022 at 01:28:46AM +0000, Vishal Annapurve wrote:
> Introduce following APIs:
> 1) kvm_arch_main : to be called at the startup of each test.

With this, AArch64 can move the content of its constructor,
init_guest_modes(), into kvm_arch_main(). Or, instead of the

 main()
 {
    /* common main stuff */
    kvm_arch_main();
    __main();
 }

approach we could have each arch provide a constructor

 arch_init()
 {
    common_pre_main_stuff();
    /* arch specific pre-main stuff */
 }

I personally prefer the latter.

Thanks,
drew

> 2) kvm_arch_post_vm_load: called after guest elf image is loaded into
>    memory to populate any global state in guest memory.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util_base.h | 10 ++++++++++
>  tools/testing/selftests/kvm/lib/aarch64/processor.c |  8 ++++++++
>  tools/testing/selftests/kvm/lib/elf.c               |  2 ++
>  tools/testing/selftests/kvm/lib/kvm_util.c          |  2 ++
>  tools/testing/selftests/kvm/lib/riscv/processor.c   |  8 ++++++++
>  tools/testing/selftests/kvm/lib/s390x/processor.c   |  8 ++++++++
>  tools/testing/selftests/kvm/lib/x86_64/processor.c  |  8 ++++++++
>  7 files changed, 46 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 9e521d1c8afe..301bef6376a5 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -834,6 +834,16 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
>  	return __vm_enable_cap(vm, KVM_CAP_VM_DISABLE_NX_HUGE_PAGES, 0);
>  }
>  
> +/*
> + * API to execute architecture specific setup before executing selftest logic.
> + */
> +void kvm_arch_main(void);
> +
> +/*
> + * API to execute architecture specific setup after loading VMs.
> + */
> +void kvm_arch_post_vm_load(struct kvm_vm *vm);
> +
>  /*
>   * API to be implemented by all the selftests.
>   */
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index 6f5551368944..a7ca1947d574 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -528,3 +528,11 @@ void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
>  		       [arg4] "r"(arg4), [arg5] "r"(arg5), [arg6] "r"(arg6)
>  		     : "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7");
>  }
> +
> +void kvm_arch_main(void)
> +{
> +}
> +
> +void kvm_arch_post_vm_load(struct kvm_vm *vm)
> +{
> +}
> diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
> index 9f54c098d9d0..f56f9279e703 100644
> --- a/tools/testing/selftests/kvm/lib/elf.c
> +++ b/tools/testing/selftests/kvm/lib/elf.c
> @@ -189,4 +189,6 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
>  				phdr.p_filesz);
>  		}
>  	}
> +
> +	kvm_arch_post_vm_load(vm);
>  }
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 2e611a021c6e..b778dc684e30 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1985,6 +1985,8 @@ int main(int argc, char *argv[])
>  	/* Tell stdout not to buffer its content */
>  	setbuf(stdout, NULL);
>  
> +	kvm_arch_main();
> +
>  	__main(argc, argv);
>  
>  	return 0;
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index 604478151212..d992ad5b5771 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -362,3 +362,11 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
>  void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>  {
>  }
> +
> +void kvm_arch_main(void)
> +{
> +}
> +
> +void kvm_arch_post_vm_load(struct kvm_vm *vm)
> +{
> +}
> diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> index 89d7340d9cbd..3a249783b3fe 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> @@ -218,3 +218,11 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
>  void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>  {
>  }
> +
> +void kvm_arch_main(void)
> +{
> +}
> +
> +void kvm_arch_post_vm_load(struct kvm_vm *vm)
> +{
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 2e6e61bbe81b..e22cfc4bf284 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1311,3 +1311,11 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
>  
>  	return val == 'Y';
>  }
> +
> +void kvm_arch_main(void)
> +{
> +}
> +
> +void kvm_arch_post_vm_load(struct kvm_vm *vm)
> +{
> +}
> -- 
> 2.37.2.789.g6183377224-goog
> 
