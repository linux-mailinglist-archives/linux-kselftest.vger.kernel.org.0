Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65773350658
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhCaSbb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbhCaSbP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 14:31:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804D7C06174A
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Mar 2021 11:31:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v10so14753412pgs.12
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Mar 2021 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P8G42q6zwMTsL78Dmf5N77/DWaHOJqpmtJu1f11p4Wk=;
        b=BF5DIg9LW5TabTQT0PvARh9x0vkxp/pQsO65oAGCDgMkbMXtvAgcgJJbDQ016zFjTS
         2xrivQ+LI1nqnS3uA6M1BFXG8PfYfoa7ir+pkuPa38tJ4mTLKSgoSrv5CuGfLqeAeTp0
         7GDd9fTXfPwzAxtQHZy1kbEe7G9QdCU/DTXEOGEoyXH/QybxjoUOgD/y/vzFbPROnXGz
         png0/4BmC2XPfUYrTXVUasASEqoy9eQfLb3w1n/j5T8PZCLV3qjMdwQ8cZf+64xqo97O
         2yBGSKFqSnQh183nqkxoZwsa3K7f+BbahEJ6cdjV6XjVJmAMjIhe/OaVCqceu1iBwf9A
         LAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P8G42q6zwMTsL78Dmf5N77/DWaHOJqpmtJu1f11p4Wk=;
        b=j4kl4MdCWlnhFf6uW9d+Ww/5hZq3rGlu0JNEaZ1jWIfLH26cpf5zWBqxcau0qHFvNX
         w+iC2wvSTAnhF8RJs+6i17Ad6eNWeS3BQJjM4h2aYizklNieNDpB50G5lWlMvk3WjIef
         mQuVv19YAf2wVvv0UnG0cRSCIjmSB/yTCUFhlW20IO72KgJD2yU1DearZMtB5JSJlUeE
         KKLTbT8jiktY9WReN24migjS7p74JELb6OiMY0Bk4oVM+w5Znevk3zEBILVCIOrQZfeJ
         ok2Nf3ILrJdh+RW53AmeSx+4NBSV4qbSxCiyBFgx1riHpM6dVnYzpOp3Vggy/M9Q1Nad
         Uv8A==
X-Gm-Message-State: AOAM532Pac3HlcFzQRImOvfVBSqsgrJ9JRMQBN5j3psvB4IKLZ7H6Itd
        WL4VojxPqDgkmmoRfSe5MX4Fsw==
X-Google-Smtp-Source: ABdhPJyJO9WCN8tCTCDKmSpbQeksq6+Qax21Pugu6+mRyYIjw7wFy2q9EGXJ5J0tGbfVX/LgxCus4A==
X-Received: by 2002:aa7:818e:0:b029:215:2466:3994 with SMTP id g14-20020aa7818e0000b029021524663994mr4333347pfi.48.1617215474808;
        Wed, 31 Mar 2021 11:31:14 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id z16sm3009330pfc.139.2021.03.31.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 11:31:14 -0700 (PDT)
Date:   Wed, 31 Mar 2021 18:31:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] kvm: cpuid: adjust the returned nent field of
 kvm_cpuid2 for KVM_GET_SUPPORTED_CPUID and KVM_GET_EMULATED_CPUID
Message-ID: <YGS/7hQo91cVuXbB@google.com>
References: <20210331122649.38323-1-eesposit@redhat.com>
 <20210331122649.38323-2-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331122649.38323-2-eesposit@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 31, 2021, Emanuele Giuseppe Esposito wrote:
> Calling the kvm KVM_GET_[SUPPORTED/EMULATED]_CPUID ioctl requires
> a nent field inside the kvm_cpuid2 struct to be big enough to contain
> all entries that will be set by kvm.
> Therefore if the nent field is too high, kvm will adjust it to the
> right value. If too low, -E2BIG is returned.
> 
> However, when filling the entries do_cpuid_func() requires an
> additional entry, so if the right nent is known in advance,
> giving the exact number of entries won't work because it has to be 
> increased by one.

I'd strong prefer to reword the shortlog and changelog.  It's not immediately
obvious what this is changing without the context from the v1 thread.  E.g.

  KVM: x86: Fix a spurious -E2BIG in KVM_GET_EMULATED_CPUID

  When retrieving emulated CPUID entries, check for an insufficient array size
  if and only if KVM is actually inserting an entry.  If userspace has a priori
  knowledge of the exact array size, KVM_GET_EMULATED_CPUID will incorrectly
  fail due to effectively requiring an extra, unused entry.

> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  arch/x86/kvm/cpuid.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6bd2f8b830e4..02a51f921548 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -567,34 +567,34 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
>  
>  static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>  {
> -	struct kvm_cpuid_entry2 *entry;
> -
> -	if (array->nent >= array->maxnent)
> -		return -E2BIG;
> +	struct kvm_cpuid_entry2 entry;
>  
> -	entry = &array->entries[array->nent];
> -	entry->function = func;
> -	entry->index = 0;
> -	entry->flags = 0;
> +	entry.function = func;
> +	entry.index = 0;
> +	entry.flags = 0;

Depending on the leaf, eax/ebx/ecx/edx will be left uninitialized.  This wasn't
a bug before since @array is zeroed on allocation.

What about pre-checking @func?  I don't particular like the duplicate checks,
but none of the solutions are particularly elegant.  E.g.

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 6bd2f8b830e4..9824947bd5ad 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -565,14 +565,18 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
        return entry;
 }

-static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
+static noinline int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
 {
        struct kvm_cpuid_entry2 *entry;

+       if (func != 0 && func != 1 && func != 7)
+               return 0;
+
        if (array->nent >= array->maxnent)
                return -E2BIG;

-       entry = &array->entries[array->nent];
+       entry = &array->entries[array->nent++];
+
        entry->function = func;
        entry->index = 0;
        entry->flags = 0;
@@ -580,19 +584,17 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
        switch (func) {
        case 0:
                entry->eax = 7;
-               ++array->nent;
                break;
        case 1:
                entry->ecx = F(MOVBE);
-               ++array->nent;
                break;
        case 7:
                entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
                entry->eax = 0;
                entry->ecx = F(RDPID);
-               ++array->nent;
-       default:
                break;
+       default:
+               BUG();
        }

        return 0


>  
>  	switch (func) {
>  	case 0:
> -		entry->eax = 7;
> -		++array->nent;
> +		entry.eax = 7;
>  		break;
>  	case 1:
> -		entry->ecx = F(MOVBE);
> -		++array->nent;
> +		entry.ecx = F(MOVBE);
>  		break;
>  	case 7:
> -		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> -		entry->eax = 0;
> -		entry->ecx = F(RDPID);
> -		++array->nent;
> -	default:
> +		entry.flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +		entry.eax = 0;
> +		entry.ecx = F(RDPID);
>  		break;
> +	default:
> +		goto out;
>  	}
>  
> +	if (array->nent >= array->maxnent)
> +		return -E2BIG;
> +
> +	memcpy(&array->entries[array->nent++], &entry, sizeof(entry));
> +
> +out:
>  	return 0;
>  }
>  
> @@ -975,6 +975,7 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>  
>  	if (cpuid->nent < 1)
>  		return -E2BIG;
> +
>  	if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
>  		cpuid->nent = KVM_MAX_CPUID_ENTRIES;
>  
> -- 
> 2.30.2
> 
