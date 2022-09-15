Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F265B97C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 11:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiIOJpB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Sep 2022 05:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiIOJo5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Sep 2022 05:44:57 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3942713EA7;
        Thu, 15 Sep 2022 02:44:47 -0700 (PDT)
Date:   Thu, 15 Sep 2022 11:44:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663235085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9HGr/Xz3Nz5Oe6gQpIzDaO+SoCtgP8KCXpxOyiLDjzM=;
        b=vyZ1eCcD/MXc4cKd0CBFHSIaK3VdW708iT8jcXLnW7GbWRTKQhLFORj0pyCiZdva94aDwB
        3Me4DVSj1iVzzVcqiY+SC+tk4PdmeIZxyd7Nv/ROmTCJqAdu/9iYBlly0VGgDzEHQIK0xp
        HIdSCDtx2tbtZnOp65bRmR7bBhJaZv4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Subject: Re: [V2 PATCH 2/8] KVM: selftests: Add arch specific initialization
Message-ID: <20220915094442.45eldu4bes5alacm@kamzik>
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-3-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915000448.1674802-3-vannapurve@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 15, 2022 at 12:04:42AM +0000, Vishal Annapurve wrote:
> Introduce arch specific API: kvm_selftest_arch_init to allow each arch to
> handle initialization before running any selftest logic.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  .../selftests/kvm/include/kvm_util_base.h      |  5 +++++
>  .../selftests/kvm/lib/aarch64/processor.c      | 18 +++++++++---------
>  tools/testing/selftests/kvm/lib/kvm_util.c     |  2 ++
>  .../selftests/kvm/lib/riscv/processor.c        |  4 ++++
>  .../selftests/kvm/lib/s390x/processor.c        |  4 ++++
>  .../selftests/kvm/lib/x86_64/processor.c       |  4 ++++
>  6 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 24fde97f6121..98edbbda9f97 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -834,4 +834,9 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
>  	return __vm_enable_cap(vm, KVM_CAP_VM_DISABLE_NX_HUGE_PAGES, 0);
>  }
>  
> +/*
> + * API to execute architecture specific setup before executing selftest logic.
> + */
> +void kvm_selftest_arch_init(void);
> +
>  #endif /* SELFTEST_KVM_UTIL_BASE_H */
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index 6f5551368944..2281d6c5d02f 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -495,15 +495,6 @@ void aarch64_get_supported_page_sizes(uint32_t ipa,
>  	close(kvm_fd);
>  }
>  
> -/*
> - * arm64 doesn't have a true default mode, so start by computing the
> - * available IPA space and page sizes early.
> - */
> -void __attribute__((constructor)) init_guest_modes(void)
> -{
> -       guest_modes_append_default();
> -}
> -
>  void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
>  	       uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5,
>  	       uint64_t arg6, struct arm_smccc_res *res)
> @@ -528,3 +519,12 @@ void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
>  		       [arg4] "r"(arg4), [arg5] "r"(arg5), [arg6] "r"(arg6)
>  		     : "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7");
>  }
> +
> +/*
> + * arm64 doesn't have a true default mode, so start by computing the
> + * available IPA space and page sizes early.
> + */

It'd be better to move this comment inside the function above the
guest_modes_append_default call.

> +void kvm_selftest_arch_init(void)
> +{
> +	guest_modes_append_default();
> +}
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 3c83838999f5..dafe4471a6c7 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1984,4 +1984,6 @@ void __attribute((constructor)) kvm_selftest_init(void)
>  {
>  	/* Tell stdout not to buffer its content. */
>  	setbuf(stdout, NULL);
> +
> +	kvm_selftest_arch_init();
>  }
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index 604478151212..26660dd2ba78 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -362,3 +362,7 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
>  void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>  {
>  }
> +
> +void kvm_selftest_arch_init(void)
> +{
> +}
> diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> index 89d7340d9cbd..8654ec74009a 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> @@ -218,3 +218,7 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
>  void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>  {
>  }
> +
> +void kvm_selftest_arch_init(void)
> +{
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 2e6e61bbe81b..20bf125f9363 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1311,3 +1311,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
>  
>  	return val == 'Y';
>  }
> +
> +void kvm_selftest_arch_init(void)
> +{
> +}
> -- 
> 2.37.2.789.g6183377224-goog
>

Otherwise,

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
