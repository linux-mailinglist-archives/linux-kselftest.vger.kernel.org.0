Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9646A436635
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhJUP3Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 11:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231819AbhJUP3Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 11:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634830027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6MrzrO7xesFuLzBcBSeQQGfqugRLLAD0yJI9mSpS6E=;
        b=ir6wvnX99ZtXjqIg4nol7R4+RPf0al6SNNMSmG+YYIT7qpPwvCbV3KN137qPM+GLwhs8Ae
        S86vB4qN8fD5EEo/eJ+AQDulU1fMQ7UvOlVXSgWIUQ5FYHNiYDyqfCvsZFMHLKQy0G1ebK
        G/sakayu4B4X2iMWxi7Ij2ZY9dPGN1s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-9l_OYgwYNGqKTZ05SxtLPg-1; Thu, 21 Oct 2021 11:27:05 -0400
X-MC-Unique: 9l_OYgwYNGqKTZ05SxtLPg-1
Received: by mail-ed1-f70.google.com with SMTP id z20-20020a05640240d400b003dce046ab51so708515edb.14
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 08:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v6MrzrO7xesFuLzBcBSeQQGfqugRLLAD0yJI9mSpS6E=;
        b=q1DRM7BirTMV+oLUbUqTl4/gAWJxkXvG/GTmPG9bakhl3OA/H1ufxX9N8ldg2G+oMr
         4njReMKZoITrLxgxMkvtmyLDRtw1IlQpmlG3REUXShYL015VSrYdujl0hZPvaPbuZw+h
         sSED4GjqkM/2Ews6CXUL+6e/lvaM6GRPFfuIVRH6IuROw1F8v/2vd2y2T+QFgSqsA8fP
         5zB3hwCOrIgCeiJDJ3Xft5G4088Sxk/qOoEvv3JjnvUbpPRYvfdXxkGSz2/XJvenyosc
         zZOROWULRS/gSoUDAxWOMx5AGrGduD431d52jAzS2fXEyhCQX+y1wOTZpITNhZEXxvub
         LPpw==
X-Gm-Message-State: AOAM532KgjiY6NSgr6chyl8r2gvxsZR5SijQkPfepNwY84ooKBkgoA7p
        VffJYq+hI8gar8Nk+nm3KdCOmPd9YF32a/3JzPjYf0V5BCLDT+ZEbKtBL8G1UhCdO+qVSgRWCDV
        Xi8iW+cBE2+UE8t9YUD4cufmQdKVz
X-Received: by 2002:a17:906:4fc8:: with SMTP id i8mr7830783ejw.342.1634830024457;
        Thu, 21 Oct 2021 08:27:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxDOrjICVVqTJ9+CDDGwf+1wA1UgMTXWu66IzWHwvhm5fM8zXDYn4XggFMnO9UcpVEQ2Hw1A==
X-Received: by 2002:a17:906:4fc8:: with SMTP id i8mr7830743ejw.342.1634830024244;
        Thu, 21 Oct 2021 08:27:04 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id o21sm3003991edc.60.2021.10.21.08.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:27:03 -0700 (PDT)
Message-ID: <31db4c63-218a-5b26-f6ed-d30113f95e29@redhat.com>
Date:   Thu, 21 Oct 2021 17:26:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC 03/16] KVM: selftests: handle encryption bits in page tables
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211005234459.430873-4-michael.roth@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211005234459.430873-4-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/10/21 01:44, Michael Roth wrote:
> SEV guests rely on an encyption bit which resides within the range that
> current code treats as address bits. Guest code will expect these bits
> to be set appropriately in their page tables, whereas helpers like
> addr_gpa2hva() will expect these bits to be masked away prior to
> translation. Add proper handling for these cases.

This is not what you're doing below in addr_gpa2hva, though---or did I 
misunderstand?

I may be wrong due to not actually having written the code, but I'd 
prefer if most of these APIs worked only if the C bit has already been 
stripped.  In general it's quite unlikely for host code to deal with C=1 
pages, so it's worth pointing out explicitly the cases where it does.

Paolo

> @@ -1460,9 +1480,10 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>    * address providing the memory to the vm physical address is returned.
>    * A TEST_ASSERT failure occurs if no region containing gpa exists.
>    */
> -void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa)
> +void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa_raw)
>   {
>   	struct userspace_mem_region *region;

