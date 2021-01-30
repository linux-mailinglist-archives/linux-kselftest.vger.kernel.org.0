Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EED3096BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Jan 2021 17:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhA3Q2c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Jan 2021 11:28:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231986AbhA3Oes (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Jan 2021 09:34:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2237864D9F;
        Sat, 30 Jan 2021 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612017201;
        bh=frYChDynoZg+N8fOjTe4Tkt+LBi35yfdYAwUDLwVxfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMiSpV05hsjbvJ6zZ1n61EXx6/B7ks1gKwFylc+nxbVh0rMMEr6+XB9fOALsWEksr
         wlCdo2jGrkRFDPZiYjUo93cFz7y+oVYAXa3E0KDS8q0gqZ0JEl9+SRH0BhFXl1nuvD
         OtItTJdjGvHwp/YBBNkPDuPHf8rhoDO1MPLrRd7WaMPdI0zVru8QaG8vrTGlTXev0i
         //zTNb6WGWK/Tp3phiE1yktUZm4DcppqGo158/js/WjTCsKEBwzJT8HVQRGNbzLuwt
         h91Yuaciquz+aANsjQ0K/PEFFxCIt+giUBXjVTZOUPnoY3E0ypkjWONkknk8ZdPjjW
         Ql5faq65mC/Qg==
Date:   Sat, 30 Jan 2021 16:33:16 +0200
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
Subject: Re: [PATCH v3 5/5] x86/sgx: Remove redundant if conditions in
 sgx_encl_create
Message-ID: <YBVuLFriVAm5EiEc@kernel.org>
References: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
 <20210124062907.88229-6-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124062907.88229-6-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 24, 2021 at 02:29:07PM +0800, Tianjia Zhang wrote:
> In this scenario, there is no case where va_page is NULL, and
> the error has been checked. The if condition statement here is
> redundant, so remove the condition detection.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/sgx/ioctl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 1c6ecf9fbeff..b0b829f1b761 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -66,9 +66,11 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  	va_page = sgx_encl_grow(encl);
>  	if (IS_ERR(va_page))
>  		return PTR_ERR(va_page);
> -	else if (va_page)
> -		list_add(&va_page->list, &encl->va_pages);
> -	/* else the tail page of the VA page list had free slots. */

This is fine. The check does not make sense.

> +
> +	if (WARN_ONCE(!va_page, "non-empty VA page list before ECREATE"))
> +		return -EIO;

No need for this WARN_ONCE().

> +
> +	list_add(&va_page->list, &encl->va_pages);

This is fine.

>  
>  	/* The extra page goes to SECS. */
>  	encl_size = secs->size + PAGE_SIZE;
> -- 
> 2.19.1.3.ge56e4f7
> 
> 

/Jarkko
