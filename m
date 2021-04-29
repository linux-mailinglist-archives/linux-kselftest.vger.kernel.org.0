Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA97A36E2CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Apr 2021 03:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhD2BA5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 21:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhD2BA4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 21:00:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26040C06138B
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Apr 2021 18:00:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o16so20236311plg.5
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Apr 2021 18:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W1foyVnHpt10zkANi9y0LWp7jrRDQd/Q7wAouJW7aRU=;
        b=l0enqpDX6x7/rQ/qhKF4XS/4BoLoz2AHWukBmE29ObLVOk7DOcHRi1ABbXlXZ/mbKI
         gTvEh3P2XsGnujeGXSCa99jrGp4J6td9wZOVTUs/KZwwxIuVjCOKUuGkKsUl8QI1npFz
         XfXBXDVswe5VSNifnAhJp2j/P3+ptoAye9aN/5HVivKg2Er7aGzTVLrDGU3hglCFMXic
         YROk6OR7rBzv/ifeBonAwUsWOiHGGLTQWatjKEQtWK+CoT999dY+Fj26fsWVrAAnasKx
         zMeNQzFD6UViMEA7Vg69DpU2tXqZlS44ForW8kl4IsPVVovQ2n3U9POGTXArPoWJVRWF
         xyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W1foyVnHpt10zkANi9y0LWp7jrRDQd/Q7wAouJW7aRU=;
        b=fOkUrdK51nlPW7oWxKWsVfyeQiD6UXMB56eUi/TPI4a6ee7ctCymWtoDOFqQvqDOkD
         +NVnSQKVn6fq2bySHwGS50ce9yg0/t6QVT4dZ56LLB8DBN+EighDkyY8lYrCEMiFpn4j
         bMGFilUqwbuHM0SnL3/3B99L1NX8k7HqD+JFmaqxYyCLJd2FcOLgzPKwUi/ivmQwPzUg
         cc/1g+y1R3LfZFkOxGIZvhq+FBr/q3bYN9PqBj4wBJtB5Oxr9NeAO+bqkrIQieshD/nn
         yNYI0Nf17ORWIJpJdKaMCKv4nNb3JUwoe7DngpFw6q9tqN6S+o1H+yc4JyKtthwG8vBY
         xJ8w==
X-Gm-Message-State: AOAM533sOmBUh7w5dmwYr3fkmK8JtOcVZBXqg2owJjKGMojlEsniac0p
        h5jvYOif9G2Kb2vws/drJP/mXg==
X-Google-Smtp-Source: ABdhPJzn0rzOp7Odw2sXRwk+fWNrSxVdAPCKwhagPdWng4HyaQb+oJYvsO5jwpedNc8uRrmK9PtTZQ==
X-Received: by 2002:a17:902:7e86:b029:ed:74b7:8fd4 with SMTP id z6-20020a1709027e86b02900ed74b78fd4mr4989129pla.21.1619658010508;
        Wed, 28 Apr 2021 18:00:10 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id 5sm729450pfi.43.2021.04.28.18.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 18:00:10 -0700 (PDT)
Date:   Thu, 29 Apr 2021 01:00:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Denis Lunev <den@openvz.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid
 entries count
Message-ID: <YIoFFl72VSeuhCRt@google.com>
References: <20210428172729.3551-1-valeriy.vdovin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428172729.3551-1-valeriy.vdovin@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 28, 2021, Valeriy Vdovin wrote:
> It's very explicit by the code that it was designed to receive some
> small number of entries to return E2BIG along with the corrected number.

LOL, saying KVM_GET_CPUID2 was "designed" is definitely giving the KVM
forefathers the benefit of the doubt.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index efc7a82ab140..3f941b1f4e78 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4773,14 +4773,17 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
>  			goto out;
> +
>  		r = kvm_vcpu_ioctl_get_cpuid2(vcpu, &cpuid,
>  					      cpuid_arg->entries);
> -		if (r)
> +
> +		if (r && r != -E2BIG)
>  			goto out;
> -		r = -EFAULT;
> -		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
> +
> +		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid))) {
> +			r = -EFAULT;
>  			goto out;

As I pointed out[*], copying the number of entries but not the entries themselves
is wrong.  All of my feedback on v1 still stands.

[*] https://lkml.kernel.org/r/YIl4M/GgaYvwNuXv@google.com

> -		r = 0;
> +		}
>  		break;
>  	}
>  	case KVM_GET_MSRS: {
