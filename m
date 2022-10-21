Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85BB606C59
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 02:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJUADY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 20:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJUADX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 20:03:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52356230A9D
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 17:03:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n7so809199plp.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYVRxk9zv95/rFuldjiWQhzUXXLiE1Nf1Pm7x/wKrxU=;
        b=THfVzfjL32SPhvD/WSWN519kLVcz4lMkjLoJrROQzqF/Imj3q2uPrEhEJxP0FNrx+a
         OAJerLFzuN3w6n3GuhPH83m5Wg5LBcclvi7UvyXYpawGCJXIPv443xRdzFQiZQJZA+zo
         SJB5G3OxiLIcU3+RIx83DNwwaslDLKvkBH5CPE1Np4DhzWr28FAAKPwTickTvZOaHinA
         X0cfowmPTUOgI6VNxoZwB4J5noWT10ZjSTi8TG+ZYf+nIa/KOcAR3CX1zdk+upvXi7oG
         JMUS7Rryj6G1eMDMjtz7bQuyQelGvXxw1bVaXg9Z+gZuyYYac2BUow1MtsjgY2w0lvoC
         YTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYVRxk9zv95/rFuldjiWQhzUXXLiE1Nf1Pm7x/wKrxU=;
        b=4AOpyIqKr1O8Iie3DN3cFon7mnLvJSezMFtlVihkxqSxCzEdVaPWqe8hUCUPaA45Rq
         +Ys0mbv6+IW8kFb+fPSfSsQuvmIjpXytIcyFP7p/jjXSlm6RY91v/pAgpYsQdSryez4F
         3RVooIvbjqs01eiTHUjPVCg7DbK78a8IRxVgBi31jvXd8oBs1JZrvQTJQdUCytGxB9H8
         ySSe8ZC2RGVby9mO1QqqJnhDsSKssCEp6u1prQKRPe0h4j5y+o01Q8QFuXxcJoonOkRf
         BVkXiMVGuF/xQtA7rHQVZ/oAKoW7s2Ms+YN5Cv8eaQV9VK2mNYsCdanjMvXxqpcP0aro
         jWJQ==
X-Gm-Message-State: ACrzQf1hkqLVQPlmamLiZdGqqvnDrno5ekh5pCaVp5KsZBk4qNwCJvw/
        r4iHzn9reNj/Mjup//KwNe/9lA==
X-Google-Smtp-Source: AMsMyM5oP6p5xd1sG1FSBuifQFZ9eTxa2EctG1rAcLMZeClgXEj3gfbfaIwU9m/ygjES8kXEyGVGRw==
X-Received: by 2002:a17:90a:1b0d:b0:20d:69b1:70c3 with SMTP id q13-20020a17090a1b0d00b0020d69b170c3mr19296704pjq.5.1666310599088;
        Thu, 20 Oct 2022 17:03:19 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u7-20020a170903124700b0017a1145eec7sm13618876plh.157.2022.10.20.17.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 17:03:18 -0700 (PDT)
Date:   Fri, 21 Oct 2022 00:03:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com
Subject: Re: [V3 PATCH 4/4] KVM: selftests: x86: Precompute the cpu type
Message-ID: <Y1Hhw40H58EmZ6lK@google.com>
References: <20221013121319.994170-1-vannapurve@google.com>
 <20221013121319.994170-5-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013121319.994170-5-vannapurve@google.com>
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

On Thu, Oct 13, 2022, Vishal Annapurve wrote:
> Cache the vendor CPU type in a global variable so that multiple calls
> to is_amd/intel_cpu() do not need to re-execute CPUID.
> 
> Sync the global variable is_cpu_amd into the guest so the guest can also
> avoid executing CPUID instruction.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index fa65e8142c16..f508e58346e9 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -19,6 +19,7 @@
>  #define MAX_NR_CPUID_ENTRIES 100
>  
>  vm_vaddr_t exception_handlers;
> +static bool is_cpu_amd;

This should probably have a "host" qualifier, e.g. is_host_cpu_amd.  More below.

>  
>  static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
>  {
> @@ -1046,7 +1047,7 @@ static bool cpu_vendor_string_is(const char *vendor)
>  
>  bool is_intel_cpu(void)

It'll be more churn, but I think we should drop the wrappers in this patch so
that we can visually audit all users.  There is technically a subtle functional
change here, as previously executing is_intel_cpu() and is_amd_cpu() in the guest
will consume the _guest_ CPUID, whereas with this change, the guest will now
consume the _host_ CPUID.

It just so happens that the existing user and the new user both want to query
Intel vs. AMD for VMCALL vs. VMMCALL, i.e. care about the host even when checking
from the guest.  It's extreme paranoia since I don't think there are any parallel
series that are adding is_intel_cpu()/is_amd_cpu() users, not to mention that I
don't think any selftests does cross-vendor virtualization, but on the other hand
the paranoia doesn't cost much.

>  {
> -	return cpu_vendor_string_is("GenuineIntel");
> +	return !is_cpu_amd;

Please keep the explicit "GenuineIntel" check, i.e. add is_host_cpu_intel.  KVM
technically supports other vendors, e.g. Centaur and Zhaoxin for VMX, and Hygon
for AMD, so it's not impossible that someone could run on Centuar or Zhaoxin and
get a false positive.  Again, extreme paranoia, but doesn't cost much.

>  }
>  
>  /*
> @@ -1054,7 +1055,7 @@ bool is_intel_cpu(void)
>   */
>  bool is_amd_cpu(void)
>  {
> -	return cpu_vendor_string_is("AuthenticAMD");
> +	return is_cpu_amd;
>  }
>  
>  void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
> @@ -1328,8 +1329,13 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
>  	return get_kvm_intel_param_bool("unrestricted_guest");
>  }
>  
> +void kvm_selftest_arch_init(void)
> +{
> +	is_cpu_amd = cpu_vendor_string_is("AuthenticAMD");
> +}
>  
>  void kvm_arch_vm_post_create(struct kvm_vm *vm)
>  {
>  	vm_create_irqchip(vm);
> +	sync_global_to_guest(vm, is_cpu_amd);
>  }
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
