Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4E130CE58
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Feb 2021 23:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhBBWA6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Feb 2021 17:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhBBWA4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Feb 2021 17:00:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CE2F64F60;
        Tue,  2 Feb 2021 22:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612303216;
        bh=7MwmGaIDa8krR7cbY5vwmlx4VkryftuFPHME4HwUihY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M00WsYIA5mTCeVa5IeOsB9EgOz9HobnLIAaZ3G4SuZvbN8p//zYZMxGZEDvv71rTg
         ABdK1OdGuPzq/Kkr9DpcnwtK0SR6Re/aJ/cdoxXBfFBVvjZQ4n9xaWznnyN3TgeV/5
         qWWqsMjoXZNyFilYNlvEBOTAT/DeNdy2CqCHyv4HdRqwA5F8Srkx3S4cq/lifU2BMN
         7bOYOtdi2HO+8VZRd6DB3XkvVZ/6UGy8orCDehwqIa8/FLeVbkx0Mm9wb/RcuMw0iW
         +jcOevLAU0mCCdJELbadoAzvKbRAQHf19zyxbOZaMy+irK0CLqwp53cCI+b2oENsaR
         rKb4bQrW8uuLg==
Date:   Wed, 3 Feb 2021 00:00:08 +0200
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
Subject: Re: [PATCH v4 2/5] x86/sgx: Reduce the locking range in
 sgx_sanitize_section()
Message-ID: <YBnLaEz0hi/s9T8X@kernel.org>
References: <20210201132653.35690-1-tianjia.zhang@linux.alibaba.com>
 <20210201132653.35690-3-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201132653.35690-3-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 01, 2021 at 09:26:50PM +0800, Tianjia Zhang wrote:
> The spin lock of sgx_epc_section only locks the page_list. The
> EREMOVE operation and init_laundry_list is not necessary in the
> protection range of the spin lock. This patch reduces the lock
> range of the spin lock in the function sgx_sanitize_section()
> and only protects the operation of the page_list.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

I'm not confident that this change has any practical value.

/Jarkko

> ---
>  arch/x86/kernel/cpu/sgx/main.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index c519fc5f6948..4465912174fd 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -41,20 +41,17 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
>  		if (kthread_should_stop())
>  			return;
>  
> -		/* needed for access to ->page_list: */
> -		spin_lock(&section->lock);
> -
>  		page = list_first_entry(&section->init_laundry_list,
>  					struct sgx_epc_page, list);
>  
>  		ret = __eremove(sgx_get_epc_virt_addr(page));
> -		if (!ret)
> +		if (!ret) {
> +			spin_lock(&section->lock);
>  			list_move(&page->list, &section->page_list);
> -		else
> +			spin_unlock(&section->lock);
> +		} else
>  			list_move_tail(&page->list, &dirty);
>  
> -		spin_unlock(&section->lock);
> -
>  		cond_resched();
>  	}
>  
> -- 
> 2.19.1.3.ge56e4f7
> 
> 
