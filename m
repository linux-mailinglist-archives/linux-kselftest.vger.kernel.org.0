Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD130624F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Jan 2021 18:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbhA0RmE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Jan 2021 12:42:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344079AbhA0Rld (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Jan 2021 12:41:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AFD664DA0;
        Wed, 27 Jan 2021 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611769252;
        bh=A+c4WcG4MCgojmNyR4EPgWEFyx6i6GsXsarr/bqWt68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIbnZ6+7cJyCVf922kPwWPaeD4UR9wS0i37zcn40hY/22CgPl+He7EcqlknAsYsp9
         1OxKDcH4YN9noy0f6OIM7tVH8O7H4ZBC4AhPMylm6+8qUyfkU4O03JK9bnomWXs2hs
         +NVh0kAaeq3o5eYirwAXcjtpINuzyI9lG9ifi4LH3+fD4KdkUcqse/EoCKy43/bZZO
         Tu9wLhT4GaeT6hcNslKpBWE3eVf0EbO8bgwHvpDK/dKWGyONmjnK/jp7qHS9+CdwR/
         APlB2xek78ivHBZhb+l28sFk1s/DQYXRCvouxAb7fbrvSTE9FYcjj3Gu5MbsmUlndG
         gB5Tw3Yf2/2Iw==
Date:   Wed, 27 Jan 2021 19:40:49 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH v3 3/5] x86/sgx: Optimize the free_cnt count in
 sgx_epc_section
Message-ID: <YBGlodsOaX4cWAtl@kernel.org>
References: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
 <20210124062907.88229-4-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124062907.88229-4-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I could bet some money that this does not bring any significant
performance gain.

On Sun, Jan 24, 2021 at 02:29:05PM +0800, Tianjia Zhang wrote:
> `section->free_cnt` represents the free page in sgx_epc_section,
> which is assigned once after initialization. In fact, just after the
> initialization is completed, the pages are in the `init_laundry_list`
> list and cannot be allocated. This needs to be recovered by EREMOVE
> of function sgx_sanitize_section() before it can be used as a page
> that can be allocated. The sgx_sanitize_section() will be called in
> the kernel thread ksgxd.
> 
> This patch moves the initialization of `section->free_cnt` from the
> initialization function `sgx_setup_epc_section()` to the function
> `sgx_sanitize_section()`, and then accumulates the count after the

Use single quotes instead of hyphens.

> successful execution of EREMOVE. This seems to be more reasonable,
> free_cnt will also truly reflect the allocatable free pages in EPC.
> 
> Sined-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 4465912174fd..e455ec7b3449 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -48,6 +48,7 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
>  		if (!ret) {
>  			spin_lock(&section->lock);
>  			list_move(&page->list, &section->page_list);
> +			section->free_cnt++;
>  			spin_unlock(&section->lock);

Someone can try to allocate a page while sanitize process is in progress.

I think it is better to keep critical sections in the form that when you
leave from one, the global state is legit.

>  		} else
>  			list_move_tail(&page->list, &dirty);
> @@ -643,7 +644,6 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
>  		list_add_tail(&section->pages[i].list, &section->init_laundry_list);
>  	}
>  
> -	section->free_cnt = nr_pages;
>  	return true;
>  }
>  
> -- 
> 2.19.1.3.ge56e4f7
> 
> 

/Jarkko
