Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980E62FD2B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbhATOaY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jan 2021 09:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389307AbhATOaG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jan 2021 09:30:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8685E23329;
        Wed, 20 Jan 2021 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611152966;
        bh=JHHd5XKXRsuaWfamSWN2tPvthY11GXk7QS21FxFrvdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qztC3BI2X5X6WkB/wDGbA0u3PZ8r4+j+741azXlQHQxOIjUV8Tfv/1HuSuSw/rSXh
         LzkyEsv2Mkals4Xn8UpHYsAm7yZd27wk/nb1NEadNdBGSj/NxOj2SajfYS1IauzIGd
         TW2bIZR37X1v0OI7pekCjusxa2mC4cyMKwJo42+eEdCuKWsCJeE68RlIlF1n2cwz1r
         R5SswsxU3pXQ6h515wzphxcNZqRnO/UJe03Vdhtndx87n04bf2P7IpoQer88QbC4dr
         czZwgSMU1pHMU0qTvIw2qK9kYvDAzSieTa+hicKWmiVQwt1XNzigzsE40KKVX5Cenz
         2OJ1dYFFLe6Kw==
Date:   Wed, 20 Jan 2021 16:29:20 +0200
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
Subject: Re: [PATCH] mm: Optimizing error condition detection in
 do_mprotect_pkey()
Message-ID: <YAg+QHhczqtTZt4Z@kernel.org>
References: <20210118133310.98375-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118133310.98375-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On Mon, Jan 18, 2021 at 09:33:10PM +0800, Tianjia Zhang wrote:
> Obviously, the error variable detection of the if statement is
> for the mprotect callback function, so it is also put into the
> scope of calling callbck.
> 
> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

No fixes tag, no description what this commit does. Nothing
makes sense to me.

/Jarkko

> ---
>  mm/mprotect.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ab709023e9aa..94188df1ee55 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -617,10 +617,11 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  		if (tmp > end)
>  			tmp = end;
>  
> -		if (vma->vm_ops && vma->vm_ops->mprotect)
> +		if (vma->vm_ops && vma->vm_ops->mprotect) {
>  			error = vma->vm_ops->mprotect(vma, nstart, tmp, newflags);
> -		if (error)
> -			goto out;
> +			if (error)
> +				goto out;
> +		}
>  
>  		error = mprotect_fixup(vma, &prev, nstart, tmp, newflags);
>  		if (error)
> -- 
> 2.19.1.3.ge56e4f7
> 
> 
