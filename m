Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF232301A7F
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Jan 2021 09:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbhAXIU6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jan 2021 03:20:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbhAXIU5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jan 2021 03:20:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5224122582;
        Sun, 24 Jan 2021 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611476416;
        bh=ddlDzopnrYiMxu9Zb3VByaRyZwyo1UI1X84M6jXYSdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C77BTLOyqORhOKH0tSlhZbK52BUhEeEQJ2jPdKFSmRaznDuXe6ZonCGV9lcnR7oDv
         /a8KRRwXinkYziEXkfnVpLIwG8SGiZg2xVh+WPlSTz8RpQFIuxRTj9SftwVI/YfAY6
         6Uc/+zWeZXtYV92Hknk0POgLmSIh3pu06LkritX0=
Date:   Sun, 24 Jan 2021 09:20:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH v3 5/5] x86/sgx: Remove redundant if conditions in
 sgx_encl_create
Message-ID: <YA0tvOGp/shchVhu@kroah.com>
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
> +
> +	if (WARN_ONCE(!va_page, "non-empty VA page list before ECREATE"))
> +		return -EIO;

So you just crashed machines that have panic-on-warn enabled.  Don't do
that for no reason, just handle the error and move on.

thanks,

greg k-h
