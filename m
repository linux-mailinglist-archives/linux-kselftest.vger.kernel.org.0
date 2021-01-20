Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1F2FD2D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 15:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390059AbhATOiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jan 2021 09:38:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390099AbhATOhR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jan 2021 09:37:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8FE22245C;
        Wed, 20 Jan 2021 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611153397;
        bh=gIx6Byc8LjKVM2fxtZc3MbFvHCR2ATctdI9B+bQjgWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkSuyQs8KSB/KtNGKxIrVGEifND+44NVHwWeNayUTerkL80A0LoOgfjJoX2lY7xWu
         Jjb0CRRjYi0vPSmrA0VC/ZpTt8zoq0WTd+lrjb801soxlOecDQ6uQ3nt2LdqUqR2Pz
         bQnYfuUJFtLVjBACmcPG3CyitoIgoj6VftlYiMfceXHsyoeFEe0mxJbGhBaS7OwLmp
         ApXp3/YG2LzIogMHRT16xfteWpqpp3FsMf8MNpT+UIap3qFkiwGt++1GlmynUQ8Q7J
         fU+LNDLUQmKQKbWsLyJAC7qBYCsxZwH1in5DlB9M8LwYwF3CpeXMoS3pMSoKF+ufCD
         iW7tB/rQMxsyw==
Date:   Wed, 20 Jan 2021 16:36:31 +0200
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
Subject: Re: [PATCH] x86/sgx: Fix free_cnt counting logic in epc section
Message-ID: <YAg/705sWZFriAdK@kernel.org>
References: <20210118133347.99158-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118133347.99158-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 18, 2021 at 09:33:47PM +0800, Tianjia Zhang wrote:
> Increase `section->free_cnt` in sgx_sanitize_section() is
> more reasonable, which is called in ksgxd kernel thread,
> instead of assigning it to epc section pages number at
> initialization. Although this is unlikely to fail, these
> pages cannot be allocated after initialization, and which
> need to be reset by ksgxd.
> 
> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

There is nothing broken in the logic. Convince me otherwise.

I.e. what is exactly broken, and how?

/Jarkko

> ---
>  arch/x86/kernel/cpu/sgx/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index c519fc5f6948..9e9a3cf7c00b 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -48,9 +48,10 @@ static void sgx_sanitize_section(struct sgx_epc_section *section)
>  					struct sgx_epc_page, list);
>  
>  		ret = __eremove(sgx_get_epc_virt_addr(page));
> -		if (!ret)
> +		if (!ret) {
>  			list_move(&page->list, &section->page_list);
> -		else
> +			section->free_cnt += 1;
> +		} else
>  			list_move_tail(&page->list, &dirty);
>  
>  		spin_unlock(&section->lock);
> @@ -646,7 +647,6 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
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
