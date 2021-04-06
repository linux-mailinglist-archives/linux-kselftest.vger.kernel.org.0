Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3923435567B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Apr 2021 16:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbhDFOV1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Apr 2021 10:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345112AbhDFOVV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Apr 2021 10:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617718873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Am7vvUfDx9XcXhjD7d6J26vzIdIONFgGza6knZUW9vQ=;
        b=JUlaeX6wSaqIw8Hj2euoPs7PGhSDf+UkNfrePR460CZriWnYg0c2DO29GjM6Tj5JPslaz0
        Dyoq3b0fvJDtcAR1KbV75m8lG6HdDUtLhbwCvGq+AKyMJhUC+x94PGdWAqgM7uVov5ms/h
        0QE43TeCmLEgEAtPyggHUtSlmneBQ8U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-I8y_907dPRO7IpaqzORP-A-1; Tue, 06 Apr 2021 10:21:11 -0400
X-MC-Unique: I8y_907dPRO7IpaqzORP-A-1
Received: by mail-ed1-f71.google.com with SMTP id h9so3526304edb.10
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Apr 2021 07:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Am7vvUfDx9XcXhjD7d6J26vzIdIONFgGza6knZUW9vQ=;
        b=njCONyQjXjA6dIwawIjVVslCJeQW/1CJUfgJ30/jQ1pWkx3AWbVWZ5nAF9z5PY8dTI
         ja5xIG0GFNdvD46QoyNqfdJ6CZ9z1B90m0D1BjIs3q5bMedmepM/LyDPMW4+mTjuvUWp
         l6OGcL4oi22hWRySuytELctG0YvOB+SDPqk9nZteKdUt5f/DhGe2AXpvm0Q5Nlcw2GM8
         CzgseS8tzJbKOBLKV1PkEze9zS7BlRGrGs47n7Y/31Aa4Es1N6SYorBdJ7SjMy1iNprz
         HG1ISPls8LWiBMiAltnXZZ96Flcm/xtQ94BkD2YKzHEuSedSnPS5Z9TopcUFArqFlAYf
         W1Cg==
X-Gm-Message-State: AOAM5312o+f/xbicjhNi/1oKoYhyMk3z1FwjNd/DURrOlR/Aqti1N7nx
        iJogJ3pQnpUReOpzCE3C75/KcuU+1h970NOAbl5VrwVgmKSA+QwJ3sL9B0EBtg9cJyMP72w61l2
        QCYTPOPJBe5/TXr2rY9/e8khB5BtzVadRmnSfX8OoJd++0y6ez/7vlPZFFZFlDtiiz8CalBO6ub
        3/YCH2
X-Received: by 2002:a05:6402:17d5:: with SMTP id s21mr38119971edy.65.1617718870194;
        Tue, 06 Apr 2021 07:21:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPtjzZ2GD7bnY4CkApHc9DhzxO9SHYDtZ5XMZBzMo4fQkRkzHOWssk3kUTVgUmLiK7fRmQbA==
X-Received: by 2002:a05:6402:17d5:: with SMTP id s21mr38119937edy.65.1617718870030;
        Tue, 06 Apr 2021 07:21:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id eo22sm11175964ejc.0.2021.04.06.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:21:09 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/4] KVM: x86: Fix a spurious -E2BIG in
 KVM_GET_EMULATED_CPUID
In-Reply-To: <20210406082642.20115-2-eesposit@redhat.com>
References: <20210406082642.20115-1-eesposit@redhat.com>
 <20210406082642.20115-2-eesposit@redhat.com>
Date:   Tue, 06 Apr 2021 16:21:08 +0200
Message-ID: <87k0pfcx4b.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Emanuele Giuseppe Esposito <eesposit@redhat.com> writes:

> When retrieving emulated CPUID entries, check for an insufficient array
> size if and only if KVM is actually inserting an entry.
> If userspace has a priori knowledge of the exact array size,
> KVM_GET_EMULATED_CPUID will incorrectly fail due to effectively requiring
> an extra, unused entry.
>
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
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

Nitpick: there's no need to set entry.eax = 0 as the whole structure was
zeroed. Also, '|=' for flags could be just '='.

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

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

