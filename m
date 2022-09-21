Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E425C5E5514
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 23:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIUVTL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiIUVTK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 17:19:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F49EA5C7D
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 14:19:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so84130pjq.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cVhxa2A/nQQB1gcuL+Q0FTqCG2B+iraWTdgWSmrMTK0=;
        b=Rf3znSeTDbeIZxLDpXIV6tlAStO2/wDGFBCb+5L1paeNgKL4+GtfP3tWt+RYxEi26J
         54Y21Ew2Cy7qTG2LluP1aAEfolNKlK+pq8jofBHfzN7dT+R4VjpuKgwkmQDZDGtpm2CH
         JDHewjvm7iXkjz3N0mnpOvXOz9X+hLmgp34iyT9VJTbbFKzUzxvN7XkeTD3sQPRQEUjd
         pPFpuQwJNgqlJSpo4J9hP6Qkbz4cKJgByP12O8N6bcbHwx/lb5Wg7wQeZ4SiIxMNumER
         vK88Hm8gkTYzD5xOtuadZxUr+ym3H8HOM6r9/ZODOdXvYe6mg/9Bg2iUuyBhSH4wEG38
         LVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cVhxa2A/nQQB1gcuL+Q0FTqCG2B+iraWTdgWSmrMTK0=;
        b=bvAuY44PmKQXhwcyq3UomFQX0eAcs33RTgN84FH3SCyNb1F1kUvSlvZC3VGTITqRH3
         1fal3k7+8tqcNiV8AWGO1ecT5w1/k/i5eHMK/DD2muWXF27T0bs/XcHRAu09CvO1xFI0
         41J74V+8SZNrHY4B9siu1791f9ZwG3CzzuQWWWlFIwOMo4nKodCIt/N5ze684uExJ4TS
         V2yCGI4bEtUAQdipZWyF3b9+Uxx7sojEvY7DDYbLUQuYpY9YRewfTodDtybSQWw4504D
         YIIOdTizrbUjO/t6ia9PGcV7laF71+LZayOj+6EQ72SA33CFkG2GifPaZb0ppG4+p8Js
         KtpA==
X-Gm-Message-State: ACrzQf3VOScQnvQiHdb0HQCcwDEglBTngrUtjJNabNEAcZiMmFWvOe6C
        e11HRtjG4RL0eb4Xy9iCkY2H5w==
X-Google-Smtp-Source: AMsMyM6zqAY+UlJw/Jp/dmFBovhmCOG2qPta/rZnpfpDZX4Es9D2YfJuZBXqmWUT0Dm4YZLP4TsD9w==
X-Received: by 2002:a17:902:aa46:b0:178:9ee5:c7f1 with SMTP id c6-20020a170902aa4600b001789ee5c7f1mr6877940plr.69.1663795147141;
        Wed, 21 Sep 2022 14:19:07 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902c41100b001750361f430sm2520669plk.155.2022.09.21.14.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:19:06 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:19:02 -0700
From:   David Matlack <dmatlack@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com
Subject: Re: [V2 PATCH 4/8] KVM: selftests: x86: Precompute the result for
 is_{intel,amd}_cpu()
Message-ID: <Yyt/xgPkHfbOE3vH@google.com>
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-5-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915000448.1674802-5-vannapurve@google.com>
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

On Thu, Sep 15, 2022 at 12:04:44AM +0000, Vishal Annapurve wrote:
> Cache the vendor CPU type in a global variable so that multiple calls
> to is_intel_cpu() do not need to re-execute CPUID.
> 
> Add cpu vendor check in kvm_hypercall() so that it executes correct
> vmcall/vmmcall instruction when running on Intel/AMD hosts. This avoids
> exit to KVM which anyway tries to patch the instruction according to
> the cpu type.

The commit shortlog makes no mention (nor even implies) that this commit
adds AMD support to kvm_hypercall(). Please break this commit up into 2.
One to precompute the result of is_{intel,amd}_cpu() and one to add AMD
support to kvm_hypercall().

If you really want to keep this as one commit (I don't know what the
benefit would be), please change the shortlog and commit message to
focus on the kvm_hypercall() change, as that is the real goal of this
commit. The precomputation is arguably and implementation detail. e.g.

  KVM: selftest: Add support for AMD to kvm_hypercall()

  Make it possible to use kvm_hypercall() on AMD by checking if running
  on an AMD CPU and, if so, using vmmcall instead of vmcall. In order to
  avoid executing CPUID in the guest on every call t kvm_hypercall()
  (which would be slow), pre-compute the result of is_{intel,amd}_cpu()
  as part of kvm_selftest_arch_init() and sync it into the guest
  after loading the ELF image.

But again, it'd be cleaner just to split it up. Caching the result of
is_{intel,amd}_cpu() is useful in its own right, independent of the
kvm_hypercall() change.

> 
> As part of this change, sync the global variable is_cpu_amd into the
> guest so the guest can determine which hypercall instruction to use
> without needing to re-execute CPUID for every hypercall.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  .../testing/selftests/kvm/lib/x86_64/processor.c  | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 25ae972f5c71..c0ae938772f6 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -19,6 +19,7 @@
>  #define MAX_NR_CPUID_ENTRIES 100
>  
>  vm_vaddr_t exception_handlers;
> +static bool is_cpu_amd;
>  
>  static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
>  {
> @@ -1019,7 +1020,7 @@ static bool cpu_vendor_string_is(const char *vendor)
>  
>  bool is_intel_cpu(void)
>  {
> -	return cpu_vendor_string_is("GenuineIntel");
> +	return (is_cpu_amd == false);
>  }
>  
>  /*
> @@ -1027,7 +1028,7 @@ bool is_intel_cpu(void)
>   */
>  bool is_amd_cpu(void)
>  {
> -	return cpu_vendor_string_is("AuthenticAMD");
> +	return (is_cpu_amd == true);
>  }
>  
>  void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
> @@ -1182,9 +1183,15 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
>  {
>  	uint64_t r;
>  
> -	asm volatile("vmcall"
> +	if (is_amd_cpu())
> +		asm volatile("vmmcall"
>  		     : "=a"(r)
>  		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
> +	else
> +		asm volatile("vmcall"
> +		     : "=a"(r)
> +		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
> +
>  	return r;
>  }
>  
> @@ -1314,8 +1321,10 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
>  
>  void kvm_selftest_arch_init(void)
>  {
> +	is_cpu_amd = cpu_vendor_string_is("AuthenticAMD");
>  }
>  
>  void kvm_arch_post_vm_elf_load(struct kvm_vm *vm)
>  {
> +	sync_global_to_guest(vm, is_cpu_amd);
>  }
> -- 
> 2.37.2.789.g6183377224-goog
> 
