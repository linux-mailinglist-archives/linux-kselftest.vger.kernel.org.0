Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB69630CE6C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Feb 2021 23:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhBBWFp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Feb 2021 17:05:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232210AbhBBWF3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Feb 2021 17:05:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69F0A64E49;
        Tue,  2 Feb 2021 22:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612303488;
        bh=e5pFrteIM567WP9mxMZoVgdTDDSwB786q9VxRr9pF5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4ybi0GbPZE6jcKtQegiaCx/EBEn+9Rto6opz6DTm0DV192Xb9Zy4YrHQtnzqLw4W
         DCGo2HjE+O6moseVupjH76mVDu0rzPfe97zjhMkrGSG4JEZuyVvqoCmIQ1wqlB/ECK
         H1Cg8b0JRd/VRz5FJZddfZpw2O3uFjRbr1TPgM7P9ujU8JQlKfF0hn4RFabKhdlrgn
         nFqyiwK1PsJNahzoDvFpf5/s20NwNKcyk/aK73YPlfCcC/cC3UGxBOD+aJm0a6lkdq
         QL66ox3hW1ePHwD7KFWwZh8TrLplMxveuVFAKGP0TRB+HDZZ5VIRIMEya0z/LEqrYJ
         SEqR4AkkVxDJA==
Date:   Wed, 3 Feb 2021 00:04:41 +0200
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
Subject: Re: [PATCH v4 5/5] x86/sgx: Remove redundant if conditions in
 sgx_encl_create
Message-ID: <YBnMeT32niwOW0K2@kernel.org>
References: <20210201132653.35690-1-tianjia.zhang@linux.alibaba.com>
 <20210201132653.35690-6-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201132653.35690-6-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 01, 2021 at 09:26:53PM +0800, Tianjia Zhang wrote:
> In this scenario, there is no case where va_page is NULL, and
> the error has been checked. The if condition statement here is

if-condition, i.e. dash missing

> redundant, so remove the condition detection.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
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
> +
> +	list_add(&va_page->list, &encl->va_pages);
>  
>  	/* The extra page goes to SECS. */
>  	encl_size = secs->size + PAGE_SIZE;
> -- 
> 2.19.1.3.ge56e4f7
> 
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
