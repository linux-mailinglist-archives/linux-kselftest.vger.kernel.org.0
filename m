Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9063558CF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Apr 2021 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346217AbhDFQHz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Apr 2021 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhDFQHy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Apr 2021 12:07:54 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3CAC06175F
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Apr 2021 09:07:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t140so10678962pgb.13
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Apr 2021 09:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T+v5IX4cEX9CUYKYtfkvuLP/FWpj0bDTli11un4lbv0=;
        b=pviF+Jske75eIM5lqnUDaFVeWwFX3hgTYiikm0Q0Qq5BzbMJ75nxMKa9iNaylKyTPI
         4TuSiBU7vBaOjGIi001q7ELkEl3+BRTIB+ilS+K6sp8XkF914tTAeM0GQxNvSpyFIf/R
         XG/01KWEl894g+4NGovaSzDVgpF5lTB5vhFF2Q8IyA7IqcjsuUpcFe2pJS6Q7EphD2Q8
         wYk2BqQFQbBGgWV7doP6ZWXVy9QpyWM8Yo5erUz2pHsHbYFqqDztGWMMOXPPu9DIAlFk
         +NDfUmHukpBORvXgfdBgekL3TGl9WQ/U/+LOFEEY/SXs60VsU+SnCZp0DF5ePEac2zfl
         KWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+v5IX4cEX9CUYKYtfkvuLP/FWpj0bDTli11un4lbv0=;
        b=O9OzA2czOLrSxKArN9IDkey+qEUwkbozxsVmNs9EXDMtI8umrRz9ucPAS/6Z1e9hxn
         qe/TWskFKn8O1OQVHRV9F90ZhyO5WapyP6IAcn3ix7Xo8pr1h1o4T3dGADCKHKQDbG1U
         xytUoMx5FbX7D2uRQ2BgnJspjzL6GlEtNm/B2MxWv24/wHbbfZp0+4PgMaZu0xTbmtgk
         0qBj1E2zdHcnxgKJ2QnDvFFUX59fyIMuiAZlNmlPybxjqmQ3b0xv71xSxaTHT+anZAfl
         /yxPggFx+b08PB0jvIGqqp8p+l2C85ZasAsAx1eg+o+PsykKK1BTcA427i1YNVWjI2Ih
         FvPA==
X-Gm-Message-State: AOAM532jLxJPr6k/EKSD6Rz/p2ZrpQlD2NHrINzw8w+3yLUV2R33+SK8
        vuplA13SubTxrACfXCstwmRqMA==
X-Google-Smtp-Source: ABdhPJyP7PyvexG6El1USINm0FiegJ3CvKHW7goT+7lfuuiY2ihzL4LiC69CbYev8715MyrOzTZ7Jg==
X-Received: by 2002:a05:6a00:1344:b029:22b:948b:a548 with SMTP id k4-20020a056a001344b029022b948ba548mr27877718pfu.33.1617725266107;
        Tue, 06 Apr 2021 09:07:46 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id d22sm2889002pjx.24.2021.04.06.09.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:07:45 -0700 (PDT)
Date:   Tue, 6 Apr 2021 16:07:41 +0000
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
Subject: Re: [PATCH v3 1/4] KVM: x86: Fix a spurious -E2BIG in
 KVM_GET_EMULATED_CPUID
Message-ID: <YGyHTc0uJtrJY0gh@google.com>
References: <20210406082642.20115-1-eesposit@redhat.com>
 <20210406082642.20115-2-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406082642.20115-2-eesposit@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 06, 2021, Emanuele Giuseppe Esposito wrote:
> When retrieving emulated CPUID entries, check for an insufficient array
> size if and only if KVM is actually inserting an entry.
> If userspace has a priori knowledge of the exact array size,
> KVM_GET_EMULATED_CPUID will incorrectly fail due to effectively requiring
> an extra, unused entry.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>

Don't think it needs stable@, but I think it's worthwhile to add:

Fixes: 433f4ba19041 ("KVM: x86: fix out-of-bounds write in KVM_GET_EMULATED_CPUID (CVE-2019-19332)")


> ---
>  arch/x86/kvm/cpuid.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6bd2f8b830e4..27059ddf9f0a 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -567,34 +567,33 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
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
> +	memset(&entry, 0, sizeof(entry));
> +	entry.function = func;

Deep into nitpick territory... I think it makes sense to set entry.function only
after the switch statement, that way it'll be a bit more obvious that the default
case doesn't actually consume "entry".

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

Maybe add a comment here to call out that the check is done if and only if there
is a valid entry?

> +	if (array->nent >= array->maxnent)
> +		return -E2BIG;
> +
> +	memcpy(&array->entries[array->nent++], &entry, sizeof(entry));
> +
> +out:
>  	return 0;
>  }
>  
> -- 
> 2.30.2
> 
