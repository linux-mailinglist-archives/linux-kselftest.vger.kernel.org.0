Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF0362C67B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 18:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiKPRjZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 12:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiKPRjV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 12:39:21 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87562D137
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 09:39:20 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q9so18144706pfg.5
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 09:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=woc9XvHCluwnjBgDeQTp+afKtN+uNIb/n2sDhkeNv/Y=;
        b=Po/opkRWX7tXqX28ZPbJrCz7SMFs6Angs2xplEBL2EzqWrWrzrvwbXCbTHcKIv7KU7
         zzLMnNy9mrXJl7NwY00u8NbaLIaHVdhlkrznB0eRz+stXcpgSuneMVh/7/BlziBe/gyz
         uGut6IcfsJa04971thRJZ0u4maWN/CfgbDzcT8mBQt4cY5JcBSTudYGlDkE4nyzaNRlu
         hOSse4rHOVnx3G1gmUOrUiXL/gPqpCDIXyq1mPjeB6iyJqWn0UMgK6eUdubpw+j0E72J
         kUtFimCJg/DtuD2c/ZSIfhhJmoAj+yj3zJSwE+9ICwLFbQhmQCcmCjCSKgCxs6KkrmOF
         Sccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woc9XvHCluwnjBgDeQTp+afKtN+uNIb/n2sDhkeNv/Y=;
        b=KxJWQDT2EYskckqXoi0La0meCRtQk09Y7/BSlnK09n6mIie5sbMlBckYFe17PZ2evn
         wHhmHnRT3Ps7w045klwXI/0Sa2Dus3zeFtLLp4Hyacxtsh7pN/d8tJyuoKilv94nce9V
         O4/3SUALhuEJ7TE8eiPkHthO3mrI9uoihdwN9fKByBVy1Xn3BHaIrtGg1f10Tg5WwsQL
         08TaCWRci5g7MbI4dguo0RBK8ui78zSm6bgjDX+ML8JrNfdVU47FWXRHOQZwVxWXM8Xf
         fsWrJLHuxhM0RSEi0O7YK/RFLUb90T6ai8NmIkCedM1psnVrCXf/v6CHre41GDMD9qDb
         +wvg==
X-Gm-Message-State: ANoB5pn8h4ZyNTN+qPsocKPkJq2bKV401s0LPAKKB1m4NfH2VE0EsJMk
        pE2LRGZC4LKBD+9TM1tbUAyfzQ==
X-Google-Smtp-Source: AA0mqf40DHD4CfbwyVqbMOO+X0r1i0xfryvYr+8N12LYBW900jYCxY+/l04RPl3vpBFayPi3LuLmNw==
X-Received: by 2002:a62:6283:0:b0:56e:989d:7410 with SMTP id w125-20020a626283000000b0056e989d7410mr24379806pfb.1.1668620359870;
        Wed, 16 Nov 2022 09:39:19 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id m19-20020a170902f21300b00186b8752a78sm12410781plc.80.2022.11.16.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 09:39:19 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:39:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com,
        pgonda@google.com, andrew.jones@linux.dev
Subject: Re: [V4 PATCH 3/3] KVM: selftests: Add arch specific post vm
 creation hook
Message-ID: <Y3UgRDWKKYZf87Yu@google.com>
References: <20221115213845.3348210-1-vannapurve@google.com>
 <20221115213845.3348210-4-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115213845.3348210-4-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 15, 2022, Vishal Annapurve wrote:
> Add arch specific API kvm_arch_vm_post_create to perform any required setup
> after VM creation.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
> Reviewed-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util_base.h | 4 ++++
>  tools/testing/selftests/kvm/lib/kvm_util.c          | 9 ++++++---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c  | 6 ++++++
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index eec0e4898efe..1e7d3eae8c91 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -843,4 +843,8 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
>   */
>  void kvm_selftest_arch_init(void);
>  
> +/*
> + * API to execute architecture specific setup after creating the VM.
> + */

Meh, I think the function name is self-explanatory.

> +void kvm_arch_vm_post_create(struct kvm_vm *vm);
>  #endif /* SELFTEST_KVM_UTIL_BASE_H */
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index deb4c731b9fa..3ed72980c996 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -340,9 +340,8 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
>  
>  	kvm_vm_elf_load(vm, program_invocation_name);
>  
> -#ifdef __x86_64__
> -	vm_create_irqchip(vm);
> -#endif
> +	kvm_arch_vm_post_create(vm);
> +
>  	return vm;
>  }
>  
> @@ -2022,6 +2021,10 @@ void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
>  	}
>  }
>  
> +__weak void kvm_arch_vm_post_create(struct kvm_vm *vm)
> +{
> +}
> +
>  __weak void kvm_selftest_arch_init(void)
>  {
>  }
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 39c4409ef56a..fa65e8142c16 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1327,3 +1327,9 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
>  
>  	return get_kvm_intel_param_bool("unrestricted_guest");
>  }
> +
> +

Extra newline.

> +void kvm_arch_vm_post_create(struct kvm_vm *vm)
> +{
> +	vm_create_irqchip(vm);
> +}
> -- 
> 2.38.1.431.g37b22c650d-goog
> 
