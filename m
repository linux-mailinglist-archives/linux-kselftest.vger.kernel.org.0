Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362F65E5558
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 23:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiIUVnz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 17:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiIUVny (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 17:43:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8E5A6AD5
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 14:43:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so164544pjm.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 14:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rQPfZBxd1rmPHcMH/Vq6+PYGtr8fyXl02ju6wUUI8P0=;
        b=SFBEzY4qJzxkgSWBqaGCF3vnjRKkSimLFYKk/tL2S+BUGV1AglvhDvLY3aXk8jyJK7
         Lyqs6GxV+iPPXcyjkHXNI3mBAFpBhXHH625FgR6vJy5aE7gSG+8fujghA+9DJeqH8JmF
         2TJW8JSKQIEQ+umxK67vay/vO5Apr1VDsMbBzbxd8yCEi66+sY8Xi4pck7x5x69Zx3XQ
         4c5pFfeH4jcBTzY3DsDX0Yi7THI+iJdnbjKoFOPoi88wDoOUdMB2xfUia9+lMunFbVK0
         zEeecAdaBrcGnVALB1KCml7DvvK4HNRiI3wV7exzvpSIPqAbd3mSi5AJoSs3tJkZTQY9
         u/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rQPfZBxd1rmPHcMH/Vq6+PYGtr8fyXl02ju6wUUI8P0=;
        b=0MAAlSr+2D3xzIo+CTLRcZp7ZekP4BHb/kl5v+0dRZ277qkIhXgO82mEU//fQXaNgB
         Uzro35dM3vXELydR+iszBe0mWPMijLhrGNOnog21tC94s1KQebUNAn6SVoJHLasFe4du
         iNz7qHWlOZsDubeuHJJAM8SKP0//c3O6ot0A723Hida7KthEfUQhnRO/twwM+DhuJajC
         qRcoYB34cFt7iJHCRmqkAS1oiUTIOLikS/ZG2PKTlxwfvOe8S5jbBOnRVErs6Yf8Zas9
         u0czcVlZedSGqkaXbjovtxWW+YAbuaAxTde0Ms/InYktx1NJyT12reV4UXYs3r1+g16A
         WrUg==
X-Gm-Message-State: ACrzQf0xVllAC8nDRmTSqbW79UwCQiVBX4UIBQ+4OCIobX2j6j3rbdQV
        Izcke/bL3eYWnSxsFDMwD8KLug==
X-Google-Smtp-Source: AMsMyM4VH7AjGpJAeikzUBI/1r2K8hVaIYquj34LCfDDthukEdd8NhfmqV7KnpF6dsvE+zUcXfzZuA==
X-Received: by 2002:a17:90b:3543:b0:202:aa2d:b87 with SMTP id lt3-20020a17090b354300b00202aa2d0b87mr204958pjb.118.1663796631514;
        Wed, 21 Sep 2022 14:43:51 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902e74b00b00176cdd7e4c6sm2556379plf.50.2022.09.21.14.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:43:51 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:43:46 -0700
From:   David Matlack <dmatlack@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com
Subject: Re: [V2 PATCH 7/8] Kvm: selftests: x86: Execute cpu specific vmcall
 instruction
Message-ID: <YyuFkmJRP/4ynKqD@google.com>
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-8-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915000448.1674802-8-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 15, 2022 at 12:04:47AM +0000, Vishal Annapurve wrote:
> Update the vmcall instruction invocation to happen according to the cpu
> type.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  tools/testing/selftests/kvm/include/x86_64/processor.h    | 8 ++++++++
>  tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c | 2 +-
>  .../selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c    | 2 +-
>  tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c  | 2 +-

What's the reason to use kvm_hypercall() for these tests? All of these
are Intel-specific. i.e. is_amd_cpu() will always return false.

>  4 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 18a8a6a2b786..74893a7a80f8 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -833,6 +833,14 @@ void vm_set_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
>  uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
>  		       uint64_t a3);
>  
> +/*
> + * Execute vmcall instruction.
> + */
> +static inline void vmcall(void)
> +{
> +	kvm_hypercall(0, 0, 0, 0, 0);
> +}
> +
>  void nested_guest_vmcall(void);
>  
>  void __vm_xsave_require_permission(int bit, const char *name);
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
> index 5abecf06329e..8180711c8684 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
> @@ -31,7 +31,7 @@
>  static void l2_guest_code(void)
>  {
>  	/* Exit to L1 */
> -	__asm__ __volatile__("vmcall");
> +	vmcall();
>  }
>  
>  static void l1_guest_code(struct vmx_pages *vmx_pages, unsigned long high_gpa)
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
> index 465a9434d61c..37da9d01d5d6 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
> @@ -76,7 +76,7 @@ static void l2_guest_code(void)
>  	check_tsc_freq(UCHECK_L2);
>  
>  	/* exit to L1 */
> -	__asm__ __volatile__("vmcall");
> +	vmcall();
>  }
>  
>  static void l1_guest_code(struct vmx_pages *vmx_pages)
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
> index 5943187e8594..00192f564d9b 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
> @@ -74,7 +74,7 @@ static void l2_guest_code(void)
>  	check_ia32_tsc_adjust(-2 * TSC_ADJUST_VALUE);
>  
>  	/* Exit to L1 */
> -	__asm__ __volatile__("vmcall");
> +	vmcall();
>  }
>  
>  static void l1_guest_code(struct vmx_pages *vmx_pages)
> -- 
> 2.37.2.789.g6183377224-goog
> 
