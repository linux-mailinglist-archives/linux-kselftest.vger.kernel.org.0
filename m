Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005CC29EF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 21:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfEXTWA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 15:22:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54988 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfEXTV7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 15:21:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so10425918wml.4
        for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2019 12:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hhpEA5bjl58Li319ZLPi9C0clAwaLvwax4NH0f/4Z7g=;
        b=uD72r2hmuwvTUctkyaKA2s3AXA0l9387s9ZFmTWCCa93bA/EteMBVt/gPe4/iND/oG
         zmuUs7LdX3Lu1gCzB52KE5SJ2DqGETr31AQw91/TjtFQfNUaf23q08u6rFpJ03+dbXH2
         oL1QrC8pbzFFj6/W/uzs6/GNvDkb92tfJklIqyYlr6aY4AiZTUe1HC3AlWAbtJ3ov10m
         WOm7WIzTO6g2qu4xTag16H7aCmripThab7bUPS//yPOYfweAdqth8CHwVVWw8uiNmqqx
         eGz41ao7Dc0yqrgxr6UwnT4Q2JmmEjWigejNunwTr1izhn6cVu0TLcnOtmur/34JXwRn
         UqGg==
X-Gm-Message-State: APjAAAV6RlpuRdDPsgSJP4teUfcM3P2vQMhp/VE/K9KxEG9EGg/NFxHL
        yNy2bP1CXu3zbarMGSbcQV7OEQ==
X-Google-Smtp-Source: APXvYqzVW8+lSidchypL8va23vulSlBcABe601SqasKD35Z2ztw7HupPhfH149YMzdfE/fat/9pzVg==
X-Received: by 2002:a05:600c:551:: with SMTP id k17mr16995780wmc.35.1558725717133;
        Fri, 24 May 2019 12:21:57 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 67sm4994440wmd.38.2019.05.24.12.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:21:56 -0700 (PDT)
Subject: Re: [PATCH] KVM: s390: fix memory slot handling for
 KVM_SET_USER_MEMORY_REGION
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        linux-kselftest@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20190524140623.104033-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89ad11b6-b044-5669-a9a3-398da002182f@redhat.com>
Date:   Fri, 24 May 2019 21:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524140623.104033-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24/05/19 16:06, Christian Borntraeger wrote:
> kselftests exposed a problem in the s390 handling for memory slots.
> Right now we only do proper memory slot handling for creation of new
> memory slots. Neither MOVE, nor DELETION are handled properly. Let us
> implement those.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 871d2e99b156..6ec0685ab2c7 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4525,21 +4525,28 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  				const struct kvm_memory_slot *new,
>  				enum kvm_mr_change change)
>  {
> -	int rc;
> +	int rc = 0;
>  
> -	/* If the basics of the memslot do not change, we do not want
> -	 * to update the gmap. Every update causes several unnecessary
> -	 * segment translation exceptions. This is usually handled just
> -	 * fine by the normal fault handler + gmap, but it will also
> -	 * cause faults on the prefix page of running guest CPUs.
> -	 */
> -	if (old->userspace_addr == mem->userspace_addr &&
> -	    old->base_gfn * PAGE_SIZE == mem->guest_phys_addr &&
> -	    old->npages * PAGE_SIZE == mem->memory_size)
> -		return;
> -
> -	rc = gmap_map_segment(kvm->arch.gmap, mem->userspace_addr,
> -		mem->guest_phys_addr, mem->memory_size);
> +	switch (change) {
> +	case KVM_MR_DELETE:
> +		rc = gmap_unmap_segment(kvm->arch.gmap, old->base_gfn * PAGE_SIZE,
> +					old->npages * PAGE_SIZE);
> +		break;
> +	case KVM_MR_MOVE:
> +		rc = gmap_unmap_segment(kvm->arch.gmap, old->base_gfn * PAGE_SIZE,
> +					old->npages * PAGE_SIZE);
> +		if (rc)
> +			break;
> +		/* FALLTHROUGH */
> +	case KVM_MR_CREATE:
> +		rc = gmap_map_segment(kvm->arch.gmap, mem->userspace_addr,
> +				      mem->guest_phys_addr, mem->memory_size);
> +		break;
> +	case KVM_MR_FLAGS_ONLY:
> +		break;
> +	default:
> +		WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
> +	}
>  	if (rc)
>  		pr_warn("failed to commit memory region\n");
>  	return;
> 

Queued for 5.2-rc2, thanks.

Paolo
