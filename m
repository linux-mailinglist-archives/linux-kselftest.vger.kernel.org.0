Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7BD17AD3E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 18:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgCER3B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 12:29:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgCER3B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 12:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583429340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ceF3GiUSQK1WEq8w5MgfVzcliLUcA5FO9ZKOb5pgtv0=;
        b=ExRlzcUXLdkweJrUtkySNEId5kV+Zi/gZIeLvAZPCaV5mOKdRnv1eNkR3wa7GzhuJOlD9k
        fmYUnsRBYEYaOgloPpIwDBNoP2U3VfpR23LcYtGcwMbrkEMNI13MVb9aloTtFvspCyK/wZ
        ibsQ1jAxb4YenqYZRyLBDxH1JX9Nf/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-77VqJ0fIMraheVRZ_8j_dg-1; Thu, 05 Mar 2020 12:28:56 -0500
X-MC-Unique: 77VqJ0fIMraheVRZ_8j_dg-1
Received: by mail-wm1-f72.google.com with SMTP id q20so1846225wmg.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Mar 2020 09:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ceF3GiUSQK1WEq8w5MgfVzcliLUcA5FO9ZKOb5pgtv0=;
        b=LZ+bDh+UPnMCVN5Zza7PhOWKnat86nD8aFEBZIL1zCJeJrPJXOM3SDhGtIWelMAtl/
         UK6MSBNycYerOmxbMMRODniXLrreUjGKZxAzElUykm5xM+CXkycg7wOKdj3+X6Dpv2sl
         03CnG75L4DyyqTh5cbhiMWqHGx35PIRmfAswB+zQty5pgu4lmj7uMg8/HUDnEOnvQE/i
         XYaHYZEhWY7g+yB+qRlsP355HQQi2ra/Op6wp/YQs7bRGX8GW/GnD0dPiLxgPWvIA85V
         tLj3emZIFIFRWLPIQ8Hz8YGRRiPZPreWasaOL9OUza3OZwPPAaVOw/u9ZKNVMBKWnEmv
         W9jg==
X-Gm-Message-State: ANhLgQ1k9x50KMXzdHTfXsoVYGlOuo5fkbn4C+YbMcl7ABc5fr3ZWhuf
        /oLTWsRlSW9qQ7Z62eWBMku5w/J9Rs6STDnX6uF0W/30zq1DynkN9N2H9X9CGhBLzT9v8/iYJUk
        9kihzROue1/qk8qEogE4bYnh/IjM+
X-Received: by 2002:adf:a505:: with SMTP id i5mr3856wrb.33.1583429335374;
        Thu, 05 Mar 2020 09:28:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsQoFH7kzyx+gM+glwSlc10vMgCj0V9akWbUaOT9igFNEYotJGKzGObcS79C1ILPoEQ5igBZg==
X-Received: by 2002:adf:a505:: with SMTP id i5mr3844wrb.33.1583429335147;
        Thu, 05 Mar 2020 09:28:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id o8sm9617441wmh.15.2020.03.05.09.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 09:28:54 -0800 (PST)
Subject: Re: [RFC PATCH 0/1] kvm: selftests: Add TEST_FAIL macro
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        kvm@vger.kernel.org
Cc:     shuah@kernel.org, tglx@linutronix.de, thuth@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200305172532.9360-1-wainersm@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7bacea1-6964-aeb2-633e-371ad1231881@redhat.com>
Date:   Thu, 5 Mar 2020 18:28:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305172532.9360-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05/03/20 18:25, Wainer dos Santos Moschetta wrote:
> The following patch's commit message is self-explanatory about this proposal.
> 
> I adjusted to use TEST_FAIL only a few source files, in reality it will
> need to change all the ones listed below. I will proceed with the
> adjustments if this new macro idea is accepted.
> 
> $ find . -type f -name "*.c" -exec grep -l "TEST_ASSERT(false" {} \;
> ./lib/kvm_util.c
> ./lib/io.c
> ./lib/x86_64/processor.c
> ./lib/aarch64/ucall.c
> ./lib/aarch64/processor.c
> ./x86_64/vmx_dirty_log_test.c
> ./x86_64/state_test.c
> ./x86_64/vmx_tsc_adjust_test.c
> ./x86_64/svm_vmcall_test.c
> ./x86_64/evmcs_test.c
> ./x86_64/vmx_close_while_nested_test.c
> 
> Wainer dos Santos Moschetta (1):
>   kvm: selftests: Add TEST_FAIL macro
> 
>  tools/testing/selftests/kvm/dirty_log_test.c             | 7 +++----
>  tools/testing/selftests/kvm/include/test_util.h          | 3 +++
>  tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c | 4 ++--
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 

Yes, why not.

Paolo

