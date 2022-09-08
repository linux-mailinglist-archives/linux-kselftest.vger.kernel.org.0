Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C21C5B29B4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 00:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiIHWzt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 18:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiIHWz3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 18:55:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4061DEFB
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Sep 2022 15:54:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id l65so19392147pfl.8
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Sep 2022 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=daVFUOIJ1WvNWC1qEjueC76owjUfPHOYDg0UZR0lqUg=;
        b=oZxlNPWf5K+8wt2ZAuxUKrIs0mMJQNNHHogkvWprEm/R4G4qfoYzEZThBQQl92orD2
         SM2jjY0tI864pjaB2AYavXwPkqvThI45Op0T4e2NyE7MNEcV2ndfFd30BDDq1WdB4pu1
         sGKTd+PlRflXg5hgtQBFqBEd9IYbY5HpWoDoeGcohkv0dYTiQ+i3+qK3M+WnUh2nl+ae
         ZpPFdMxJXzEzE0zw3BjPyRn77gSjeguZ+B5DQjyUUhGEtJyTsXvwUTG62RKsnt8+O4tw
         d0Hr1Ce3tFx230OGyqBdaNRTCTIMmXBnAoV1wtsDyUJjr21N2EbB80j1gGjIprlKQu9f
         aRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=daVFUOIJ1WvNWC1qEjueC76owjUfPHOYDg0UZR0lqUg=;
        b=6gJhGZ34EgFqs6rFx+3DaR8M68S4Oync34i6hTfaTtHTkik4+yhL+ls1HcdAf8P+Cy
         W4jreXtQNrC8Hpkd1EdRY1kB43AuK9IEFvq0QMuy74DCvbnlhgdO9Pmiy/z2yDyhwjhx
         9yczz4ewXKpd20yWABY2OoFrzg+ayK8GEJP6LODQwNXtHsLM62SDGdQof2kwRcQzUuKD
         JuRWUu/9YOptOv/ZBz9EZ3F386rKYp0eu5KTvute/JbabFTG5e/oRj3Yk55XUNnqrHom
         IMEtnf/4BOQm1Q3mQ9nfx/BmMB6AcgxaZ7EbJ7oSgDHu4vOhc4x7l2vUg6UXtIfoKRck
         NxLQ==
X-Gm-Message-State: ACgBeo3MyV9y5j7GwqoNKJA+hcq7wlRjqw5JxZHT62QuE/prJ/0DbboH
        Sfjo4NtbnTy/9pfv+SlEHP9OfQ==
X-Google-Smtp-Source: AA6agR6YEcDGbO4Kg4ywJJcJmZ+toO7/NZn4H/ZK6esHhw0XWPy9bdN7Q3xmO8DIIoBKbujZOqpxzA==
X-Received: by 2002:a63:fc13:0:b0:42b:890d:5954 with SMTP id j19-20020a63fc13000000b0042b890d5954mr9712872pgi.200.1662677687671;
        Thu, 08 Sep 2022 15:54:47 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id r1-20020aa79ec1000000b00540d75197f2sm139144pfq.143.2022.09.08.15.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 15:54:46 -0700 (PDT)
Date:   Thu, 8 Sep 2022 15:54:41 -0700
From:   David Matlack <dmatlack@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
        drjones@redhat.com
Subject: Re: [V1 PATCH 3/5] selftests: kvm: x86: Execute vmcall/vmmcall
 according to CPU type
Message-ID: <YxpysbHZb2G56K+f@google.com>
References: <20220903012849.938069-1-vannapurve@google.com>
 <20220903012849.938069-4-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903012849.938069-4-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Please use "KVM: selftest: ..." for the shortlog.

On Sat, Sep 03, 2022 at 01:28:47AM +0000, Vishal Annapurve wrote:
> Modify following APIs for x86 implementation:
> 1) kvm_arch_main : Query the cpu vendor and cache the value in advance.
> 2) kvm_arch_post_vm_load: Populate cpu type in the guest memory so that
> 	guest doesn't need to execute cpuid instruction again.

This commit message only describes a subset of the changes in this
commit, and does not provide any context on why the changes are being
made (other than a clue about avoiding CPUID).

I also think this could be split up into 2 separate commits.

I would suggest first patch changes is_{intel,amd}_cpu() to return a cached
result. e.g.

  KVM: selftests: Precompute the result for is_{intel,amd}_cpu()

  Cache the vendor CPU type in a global variable so that multiple calls
  to is_intel_cpu() do not need to re-execute CPUID. This will be useful
  in a follow-up commit to check if running on AMD or Intel from within
  a selftest guest where executing CPUID requires a VM-exit.

Then add support for AMD to kvm_hypercall():

  KVM: selftests: Add AMD support to kvm_hypercall()

  Add support for AMD hypercalls to kvm_hypercall() so that it can be
  used in selftests running on Intel or AMD hosts. This will be used in
  a follow up commit to ...

  As part of this change, sync the global variable is_cpu_amd into the
  guest so the guest can determine which hypercall instruction to use
  without needing to re-execute CPUID for every hypercall.

> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  .../testing/selftests/kvm/lib/x86_64/processor.c  | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index e22cfc4bf284..ac104653ab43 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -19,6 +19,7 @@
>  #define MAX_NR_CPUID_ENTRIES 100
>  
>  vm_vaddr_t exception_handlers;
> +static int is_cpu_amd = -1;

Should this just be a bool? Since you are initializing it before main(),
there is really no way for any code to observe it's pre-initialized
value. And nothing even checks if is_cpu_amd -1, it just silently
returns false from is_intel_cpu() and is_amd_cpu().

>  
>  static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
>  {
> @@ -1019,7 +1020,7 @@ static bool cpu_vendor_string_is(const char *vendor)
>  
>  bool is_intel_cpu(void)
>  {
> -	return cpu_vendor_string_is("GenuineIntel");
> +	return (is_cpu_amd == 0);
>  }
>  
>  /*
> @@ -1027,7 +1028,7 @@ bool is_intel_cpu(void)
>   */
>  bool is_amd_cpu(void)
>  {
> -	return cpu_vendor_string_is("AuthenticAMD");
> +	return (is_cpu_amd == 1);
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
>  void kvm_arch_main(void)
>  {
> +	is_cpu_amd = cpu_vendor_string_is("AuthenticAMD") ? 1 : 0;
>  }
>  
>  void kvm_arch_post_vm_load(struct kvm_vm *vm)
>  {
> +	sync_global_to_guest(vm, is_cpu_amd);
>  }
> -- 
> 2.37.2.789.g6183377224-goog
> 
