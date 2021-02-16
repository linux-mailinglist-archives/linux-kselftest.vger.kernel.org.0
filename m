Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83A831C75D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Feb 2021 09:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBPIcA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Feb 2021 03:32:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhBPIbS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Feb 2021 03:31:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38DB264E08;
        Tue, 16 Feb 2021 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613464180;
        bh=xp2E7pVtr9+d2BktWCe8eCxmT+MJcLpfXlVFen7+2R8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P22fm4xO1zbk7rb9lHb1iki62q78cwkLEo/0/ifn+xuvYoCtWnZdBFohO+QY6+DQj
         lUqGucXVJadLmm7X54q4ogiIOMxMrod7Phou2sj8rEYX8E/q0oUPR2GMbHf10+PYJv
         AEGyJR2BAA1aOMKoTQnQTFvu9li6nOLLcSjSQ6cxicxwyiI7Uovblg0ZFhvTxWbP8o
         xbb3dKCGDV4VxoQlEKXphmPoob0UGdnzUi17aVn/pWb75R/vOeASREdwex3x/MS3bV
         f8lgptM2P4oFLtSAXg/It5BQEDHhCle5Ev3vzwHZClEhvOY3FDjIbWWMNZ8ffRJW+y
         PA3YhwWimKwCA==
Date:   Tue, 16 Feb 2021 10:29:28 +0200
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
Subject: Re: [PATCH v5 3/3] x86/sgx: Remove redundant if conditions in
 sgx_encl_create
Message-ID: <YCuCaG2CWNeoKQFQ@kernel.org>
References: <20210216033133.79543-1-tianjia.zhang@linux.alibaba.com>
 <20210216033133.79543-4-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216033133.79543-4-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 16, 2021 at 11:31:33AM +0800, Tianjia Zhang wrote:
> In this scenario, there is no case where va_page is NULL, and
> the error has been checked. The if-condition statement here is
> redundant, so remove the condition detection.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  arch/x86/kernel/cpu/sgx/ioctl.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 1c6ecf9fbeff..719c21cca569 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -66,9 +66,10 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  	va_page = sgx_encl_grow(encl);
>  	if (IS_ERR(va_page))
>  		return PTR_ERR(va_page);
> -	else if (va_page)
> -		list_add(&va_page->list, &encl->va_pages);
> -	/* else the tail page of the VA page list had free slots. */
> +	if (!va_page)
> +		return -EIO;

Why this check?

> +
> +	list_add(&va_page->list, &encl->va_pages);
>  
>  	/* The extra page goes to SECS. */
>  	encl_size = secs->size + PAGE_SIZE;
> -- 
> 2.19.1.3.ge56e4f7
> 
> 

/Jarkko
