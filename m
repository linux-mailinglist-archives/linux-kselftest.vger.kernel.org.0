Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79DF3A2A93
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhFJLs2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 07:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhFJLs2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 07:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623325591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/8j+wnWnTfb6LCWk89bGRuT4Gfnv7Lqnj2YgU0Psg0=;
        b=gxihVAZCwsSLdpifmb2EVMLUuCYfHtYznmgyH0PwTBSUvNuRG8UG1AQg2zWWUbmF+rYTK5
        OCmNDo+Bx7BQ6oLKLmALXTxlHd6wV4scKVFzcRFhD4fBstjcvaHWOWzbWAZDk76uHPMiGp
        KipevKOZDnw4dejnCQSxg4DGQkBHERU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-vM_WgdGQNKe-w2kNLVSf2A-1; Thu, 10 Jun 2021 07:46:30 -0400
X-MC-Unique: vM_WgdGQNKe-w2kNLVSf2A-1
Received: by mail-wr1-f69.google.com with SMTP id e11-20020a056000178bb0290119c11bd29eso784757wrg.2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 04:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I/8j+wnWnTfb6LCWk89bGRuT4Gfnv7Lqnj2YgU0Psg0=;
        b=Rp/xxdQtQB6x3K5Vne8j0V911BlfLOwEM/N8BgHPNkHWBQ68E01M75mVpwHaSZyyPT
         drJQ1Dp4QZfBuce7BIM+fOtGMUr2BfM+gawEEndowSp/e3pom7eQb65aAegWMeslVYWs
         MIWn0S+n1O4ypNvFjVGpgxBAGblnAZEvQx24L54KhOVQBPbwCCRvnvV4AuyUv2sIgbBq
         mGuGfm+7thU+mJqXtSkKBhd6cdXLVsl9KLw9sIJkI3uk6vIPVbXgeUyVw+akc396/2PT
         bpqlyfYhuHmXZAs56nNQvwll5g7N/WjX3uUCI5bXHyA0pLQ/Y7B8LHVFVPh/fRagAZrO
         h5Pw==
X-Gm-Message-State: AOAM531/zFMLqMGVOpGX5v3QvDCPfkEizj1iuAP2DlolVAFRPvehxr0h
        xPM+mxqZM6A84jAvlR2za692fFlyQ05ESwCLzqdPYOTnevbvBB/sn9Pny2oDld2B9PPsBSdIeek
        +RF93+pBWQxwV3gBLPIWW80K6lunX
X-Received: by 2002:a5d:48c6:: with SMTP id p6mr4963275wrs.45.1623325589181;
        Thu, 10 Jun 2021 04:46:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAY/peyXscV9r/3ZUt4QDtJlFNFailIfzbp8EjaoRTUVSlJrRv2T10doUS2XUyySbuumKZAg==
X-Received: by 2002:a5d:48c6:: with SMTP id p6mr4963260wrs.45.1623325588983;
        Thu, 10 Jun 2021 04:46:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id w23sm9281904wmi.0.2021.06.10.04.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 04:46:28 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Fix compiling errors when initializing
 the static structure
To:     Yanan Wang <wangyanan55@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ben Gardon <bgardon@google.com>,
        Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com
References: <20210610085418.35544-1-wangyanan55@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <43c197da-0ff7-5b95-0778-e5b19fa4f942@redhat.com>
Date:   Thu, 10 Jun 2021 13:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610085418.35544-1-wangyanan55@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/06/21 10:54, Yanan Wang wrote:
> Errors like below were produced from test_util.c when compiling the KVM
> selftests on my local platform.
> 
> lib/test_util.c: In function 'vm_mem_backing_src_alias':
> lib/test_util.c:177:12: error: initializer element is not constant
>      .flag = anon_flags,
>              ^~~~~~~~~~
> lib/test_util.c:177:12: note: (near initialization for 'aliases[0].flag')
> 
> The reason is that we are using non-const expressions to initialize the
> static structure, which will probably trigger a compiling error/warning
> on stricter GCC versions. Fix it by converting the two const variables
> "anon_flags" and "anon_huge_flags" into more stable macros.
> 
> Fixes: b3784bc28ccc0 ("KVM: selftests: refactor vm_mem_backing_src_type flags")
> Reported-by: Zenghui Yu <yuzenghui@huawei.com>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>   tools/testing/selftests/kvm/lib/test_util.c | 38 ++++++++++-----------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index 6ad6c8276b2e..af1031fed97f 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -166,75 +166,75 @@ size_t get_def_hugetlb_pagesz(void)
>   	return 0;
>   }
>   
> +#define ANON_FLAGS	(MAP_PRIVATE | MAP_ANONYMOUS)
> +#define ANON_HUGE_FLAGS	(ANON_FLAGS | MAP_HUGETLB)
> +
>   const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
>   {
> -	static const int anon_flags = MAP_PRIVATE | MAP_ANONYMOUS;
> -	static const int anon_huge_flags = anon_flags | MAP_HUGETLB;
> -
>   	static const struct vm_mem_backing_src_alias aliases[] = {
>   		[VM_MEM_SRC_ANONYMOUS] = {
>   			.name = "anonymous",
> -			.flag = anon_flags,
> +			.flag = ANON_FLAGS,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_THP] = {
>   			.name = "anonymous_thp",
> -			.flag = anon_flags,
> +			.flag = ANON_FLAGS,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB] = {
>   			.name = "anonymous_hugetlb",
> -			.flag = anon_huge_flags,
> +			.flag = ANON_HUGE_FLAGS,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16KB] = {
>   			.name = "anonymous_hugetlb_16kb",
> -			.flag = anon_huge_flags | MAP_HUGE_16KB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_16KB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_64KB] = {
>   			.name = "anonymous_hugetlb_64kb",
> -			.flag = anon_huge_flags | MAP_HUGE_64KB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_64KB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_512KB] = {
>   			.name = "anonymous_hugetlb_512kb",
> -			.flag = anon_huge_flags | MAP_HUGE_512KB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_512KB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_1MB] = {
>   			.name = "anonymous_hugetlb_1mb",
> -			.flag = anon_huge_flags | MAP_HUGE_1MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_1MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB] = {
>   			.name = "anonymous_hugetlb_2mb",
> -			.flag = anon_huge_flags | MAP_HUGE_2MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_2MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_8MB] = {
>   			.name = "anonymous_hugetlb_8mb",
> -			.flag = anon_huge_flags | MAP_HUGE_8MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_8MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16MB] = {
>   			.name = "anonymous_hugetlb_16mb",
> -			.flag = anon_huge_flags | MAP_HUGE_16MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_16MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_32MB] = {
>   			.name = "anonymous_hugetlb_32mb",
> -			.flag = anon_huge_flags | MAP_HUGE_32MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_32MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_256MB] = {
>   			.name = "anonymous_hugetlb_256mb",
> -			.flag = anon_huge_flags | MAP_HUGE_256MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_256MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_512MB] = {
>   			.name = "anonymous_hugetlb_512mb",
> -			.flag = anon_huge_flags | MAP_HUGE_512MB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_512MB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB] = {
>   			.name = "anonymous_hugetlb_1gb",
> -			.flag = anon_huge_flags | MAP_HUGE_1GB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_1GB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB] = {
>   			.name = "anonymous_hugetlb_2gb",
> -			.flag = anon_huge_flags | MAP_HUGE_2GB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_2GB,
>   		},
>   		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB] = {
>   			.name = "anonymous_hugetlb_16gb",
> -			.flag = anon_huge_flags | MAP_HUGE_16GB,
> +			.flag = ANON_HUGE_FLAGS | MAP_HUGE_16GB,
>   		},
>   		[VM_MEM_SRC_SHMEM] = {
>   			.name = "shmem",
> 

Queued, thanks.

Paolo

