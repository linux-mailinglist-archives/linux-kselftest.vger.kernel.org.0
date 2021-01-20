Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3E32FD313
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 15:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390380AbhATOnE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jan 2021 09:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390418AbhATOkJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jan 2021 09:40:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C39892245C;
        Wed, 20 Jan 2021 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611153568;
        bh=n44JGd/vTF7J6BFMXAiht4O145lHppu2U0ihRFRAC2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVOjpBYrje8sRC+KC0CUB4nD8DlrTa9KrfN4yYjWcGXFz/4HiuaICOOJNUrb/0kJ0
         V2+Smmap/YKmG+4QBBruHm7oLJDycM2rtnVZog/3iXLKxdJjgoCCRh4C6nz9dapzeq
         k6bLb6O5eIF5SK4Got3Cu6Ghx4rgt+LZM1ASKR+Eau8ni53Ty76023X6yxJy1KW/cA
         ToslcprN435Vl4jQDirIqOnUXH1Abn/ktZrGe1dOGFAeznx4el7B/h7C5QfrZ/MnWY
         WfSeX/cbjnSQH/ixH1YZGGK/VHV4fdXhPI8XzcqtSE8b4ZR9AtAqPTCWtbrRuNJ1V8
         gkC06wEid+3AQ==
Date:   Wed, 20 Jan 2021 16:39:22 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, haitao.huang@intel.com,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH] x86/sgx: Remove redundant if conditions in
 sgx_encl_create
Message-ID: <YAhAmv5SnhgBvnhD@kernel.org>
References: <20210118133358.99311-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118133358.99311-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 18, 2021 at 09:33:58PM +0800, Tianjia Zhang wrote:
> In this scenario, there is no case where va_page is NULL, and
> the error has been checked. The if condition statement here is
> redundant, so remove the condition detection.
> 
> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

What do we gain with this change and why is it reported as a
regression?

/Jarkko

> ---
>  arch/x86/kernel/cpu/sgx/ioctl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 90a5caf76939..f45957c05f69 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -66,9 +66,8 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  	va_page = sgx_encl_grow(encl);
>  	if (IS_ERR(va_page))
>  		return PTR_ERR(va_page);
> -	else if (va_page)
> -		list_add(&va_page->list, &encl->va_pages);
> -	/* else the tail page of the VA page list had free slots. */
> +
> +	list_add(&va_page->list, &encl->va_pages);
>  
>  	/* The extra page goes to SECS. */
>  	encl_size = secs->size + PAGE_SIZE;
> -- 
> 2.19.1.3.ge56e4f7
> 
> 
