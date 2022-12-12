Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C87649CF3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Dec 2022 11:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiLLKqe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Dec 2022 05:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiLLKoh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Dec 2022 05:44:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A734F012
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Dec 2022 02:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670841531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0geoJp5y5vah58rc3h1onQRI09PobQgX5h6nKaS34UM=;
        b=UTOG3Xn/nlg2q5g1qlid6ooLJSUp4MOnsRQ2oiC+heTNWT49l+JHO9dAlk71/0cGNquz23
        I6NAYQi7HU72xSahX5wZOXaw3XLgREdagPv/q6ixINYFoktSo2Foo/WMRh9M+q4f88w+Wt
        hJmlqxhHLbWCutnwNV/8yOv/azOI8G8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-wFKsGjoGO7y16xAtp_nXzQ-1; Mon, 12 Dec 2022 05:38:50 -0500
X-MC-Unique: wFKsGjoGO7y16xAtp_nXzQ-1
Received: by mail-wm1-f70.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso3179473wmh.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Dec 2022 02:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0geoJp5y5vah58rc3h1onQRI09PobQgX5h6nKaS34UM=;
        b=RTwfiBHfmM0ES9tmVkifaeZVheKhcL/MYIrtt62i/9vvdKCFL+qkkt29shPzs6AawL
         fmUCZxW7kNf06TLNQ789XMPcM2WtLJPscZkV+fdVsCmYG8FBi1wK0Cb1XBb/h2ue4nuS
         HEzDDO8u1UYnj2Ad+5FIu3+pFDlriYbFfKQ10OqvnFJZ4gFrd1Ci3kLS3omQ1sRHxIPc
         wqn06UPRW7A6XCtWqlinGw9O1WiRwZ1mwwNnOLJc8kEi6H9W81kxRzT8/By3JjPkFMdK
         +KbMAvUeP5CxYqrVhSWyJ+fprPJZiWWnTg7r2UPuZJLkRXrGmKbUsXzw2sp4CffFfb0I
         PUfQ==
X-Gm-Message-State: ANoB5plEDnTYT1W+4FZK3V98s3Vz6w5XAr9od3QnawvHFzF0MfefmwxW
        eBxJrvNqpBnohYRPSzJjzF8VajCBIj2m/4ynwqQPm/PCMrfKYG912Q/5xLKTkiuHnv1f5ORSQ+Q
        bzoEmPh1uhmuCMCo/oaSNaKxbDFj2
X-Received: by 2002:a05:600c:5398:b0:3cf:d0b1:8aa1 with SMTP id hg24-20020a05600c539800b003cfd0b18aa1mr12355050wmb.0.1670841528987;
        Mon, 12 Dec 2022 02:38:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf43hHD3Xh/hVMzgx7AUun3dPtnLezNxJe71/MuBv74YiGy1tG1gohvB+wRobXA4W5SAS5QTYw==
X-Received: by 2002:a05:600c:5398:b0:3cf:d0b1:8aa1 with SMTP id hg24-20020a05600c539800b003cfd0b18aa1mr12355032wmb.0.1670841528795;
        Mon, 12 Dec 2022 02:38:48 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id iw3-20020a05600c54c300b003d220ef3232sm5442368wmb.34.2022.12.12.02.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 02:38:48 -0800 (PST)
Message-ID: <2ce6eab8-6156-1282-bf29-87fd74e4587a@redhat.com>
Date:   Mon, 12 Dec 2022 11:38:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 7/7] KVM: selftests: Avoid infinite loop if
 ucall_alloc() fails
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Peter Gonda <pgonda@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Ricardo Koller <ricarkol@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209015307.1781352-1-oliver.upton@linux.dev>
 <20221209015307.1781352-8-oliver.upton@linux.dev>
 <Y5OisdH5ohtr6r3j@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y5OisdH5ohtr6r3j@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/9/22 22:03, Sean Christopherson wrote:
> From: Sean Christopherson<seanjc@google.com>
> Date: Fri, 9 Dec 2022 12:55:44 -0800
> Subject: [PATCH] KVM: selftests: Use magic value to signal ucall_alloc()
>   failure
> 
> Use a magic value to signal a ucall_alloc() failure instead of simply
> doing GUEST_ASSERT().  GUEST_ASSERT() relies on ucall_alloc() and so a
> failure puts the guest into an infinite loop.
> 
> Use -1 as the magic value, as a real ucall struct should never wrap.
> 
> Reported-by: Oliver Upton<oliver.upton@linux.dev>
> Signed-off-by: Sean Christopherson<seanjc@google.com>
> ---
>   tools/testing/selftests/kvm/lib/ucall_common.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
> index 0cc0971ce60e..2f0e2ea941cc 100644
> --- a/tools/testing/selftests/kvm/lib/ucall_common.c
> +++ b/tools/testing/selftests/kvm/lib/ucall_common.c
> @@ -4,6 +4,8 @@
>   #include "linux/bitmap.h"
>   #include "linux/atomic.h"
>   
> +#define GUEST_UCALL_FAILED -1
> +
>   struct ucall_header {
>   	DECLARE_BITMAP(in_use, KVM_MAX_VCPUS);
>   	struct ucall ucalls[KVM_MAX_VCPUS];
> @@ -41,7 +43,8 @@ static struct ucall *ucall_alloc(void)
>   	struct ucall *uc;
>   	int i;
>   
> -	GUEST_ASSERT(ucall_pool);
> +	if (!ucall_pool)
> +		goto ucall_failed;
>   
>   	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
>   		if (!test_and_set_bit(i, ucall_pool->in_use)) {
> @@ -51,7 +54,13 @@ static struct ucall *ucall_alloc(void)
>   		}
>   	}
>   
> -	GUEST_ASSERT(0);
> +ucall_failed:
> +	/*
> +	 * If the vCPU cannot grab a ucall structure, make a bare ucall with a
> +	 * magic value to signal to get_ucall() that things went sideways.
> +	 * GUEST_ASSERT() depends on ucall_alloc() and so cannot be used here.
> +	 */
> +	ucall_arch_do_ucall(GUEST_UCALL_FAILED);
>   	return NULL;
>   }
>   
> @@ -93,6 +102,9 @@ uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
>   
>   	addr = ucall_arch_get_ucall(vcpu);
>   	if (addr) {
> +		TEST_ASSERT(addr != (void *)GUEST_UCALL_FAILED,
> +			    "Guest failed to allocate ucall struct");
> +
>   		memcpy(uc, addr, sizeof(*uc));
>   		vcpu_run_complete_io(vcpu);
>   	} else {
> 
> base-commit: dc2efbe4813e0dc4368779bc36c5f0e636cb8eb2
> -- 

Queued, thanks.

Paolo

