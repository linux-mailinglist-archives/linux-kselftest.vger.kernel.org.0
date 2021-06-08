Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605C539F0B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 10:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFHIXk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 04:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhFHIXk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 04:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623140507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMCysKzuhfWQj6CjYw5Jk5VY+X58qQ9BlT7Wd58h01I=;
        b=iwZ+bpC4zoGVXPlUT2oDxfYnOWAKaPvQM5FmHmz62Nwc34ESwBi+CpOvnvEbAtn0jZOzfw
        3WoK9fItQmsaHkJI+hJRUNBZ3OFCxqNSQjAa8m1HzchZBEYRXImRyek5qRtUHK48iH528W
        4IkUUy/CyvdMcmXxGwxqNAhHfSSDW0o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-lgRCDsrjNjG4OltrWVqcxQ-1; Tue, 08 Jun 2021 04:21:46 -0400
X-MC-Unique: lgRCDsrjNjG4OltrWVqcxQ-1
Received: by mail-wr1-f71.google.com with SMTP id d5-20020a0560001865b0290119bba6e1c7so5121084wri.20
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jun 2021 01:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dMCysKzuhfWQj6CjYw5Jk5VY+X58qQ9BlT7Wd58h01I=;
        b=FYmIxm+bnlq0Qi2ZEHAv7zTYR+dsMfVbkMuoy2dfL0C//52UxmQTR/D64yhueesyxZ
         CWsBKBpeVeYpK23aJGBueNxzaDwkcBMWdfksAlhMf2hvWC6IFiVEKTUMbB4AqT23vQv+
         zcs728LvmZS2BMuV5orvuMnLAI2BQ+Oh0A7eVp1QTmvjlVdxFVeDDzEYxhkhtybvTPqw
         UZKbo4R28L+Yugxy9lrHLpRnig47/0pa6WSPZ4redLdTTRrV3IqDeKgOpPLMA9VtmnC9
         3v0OiyKLxzcX3IRIHAHfxwBZdVUwTx+NLgvx1nAqSLukPxdhDlDW14E1WsC599ymsHHk
         W+3Q==
X-Gm-Message-State: AOAM530ICouNe3CLB2s9DQD5wnlv1Z4DZzN+oEpcmeY9JaRPdFF6HrVy
        H2XblPNSfU9QHTsCeVBi+5reFee7OWtUZqQNkZIEmYeBxKNpgd4mxyfcnnw3kQCdixVQGLYBI/m
        b/ZZsF0e0M9473lfEdY7WTdEiwCJ8
X-Received: by 2002:a05:6000:1a8f:: with SMTP id f15mr12814165wry.260.1623140505298;
        Tue, 08 Jun 2021 01:21:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyuR0+5SlrkVXKTif892WYOeuI/p/q0R0wvXFQ+l9tDT532OtMyty7IrKMW9uNQZ/2048MZA==
X-Received: by 2002:a05:6000:1a8f:: with SMTP id f15mr12814155wry.260.1623140505175;
        Tue, 08 Jun 2021 01:21:45 -0700 (PDT)
Received: from gator (93-137-73-41.adsl.net.t-com.hr. [93.137.73.41])
        by smtp.gmail.com with ESMTPSA id b135sm2121778wmb.5.2021.06.08.01.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 01:21:44 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:21:42 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, maciej.szmigiero@oracle.com,
        pbonzini@redhat.com, shuah@kernel.org
Subject: Re: [PATCH 1/3] Revert "selftests: kvm: make allocation of extra
 memory take effect"
Message-ID: <20210608082142.umk5jauizkxxs4yb@gator>
References: <20210608233816.423958-1-zhenzhong.duan@intel.com>
 <20210608233816.423958-2-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608233816.423958-2-zhenzhong.duan@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 09, 2021 at 07:38:14AM +0800, Zhenzhong Duan wrote:
> This reverts commit 39fe2fc96694164723846fccf6caa42c3aee6ec4.
> 
> Parameter extra_mem_pages in vm_create_default() is used to calculate
> the page table size for all the memory chunks.
> Real memory allocation for non-slot0 memory happens by extra call of
> vm_userspace_mem_region_add() outside of vm_create_default().
> 
> The reverted commit changed above meaning of extra_mem_pages as extra
> slot0 memory size. This way made the page table size calculations
> open coded in separate test.
> 
> Link: https://lkml.org/lkml/2021/6/3/551
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 28e528c19d28..63418df921f0 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -320,7 +320,7 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
>  	 */
>  	uint64_t vcpu_pages = (DEFAULT_STACK_PGS + num_percpu_pages) * nr_vcpus;
>  	uint64_t extra_pg_pages = (extra_mem_pages + vcpu_pages) / PTES_PER_MIN_PAGE * 2;
> -	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + extra_mem_pages + vcpu_pages + extra_pg_pages;
> +	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + vcpu_pages + extra_pg_pages;
>  	struct kvm_vm *vm;
>  	int i;
>  
> -- 
> 2.25.1
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

