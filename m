Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00832FD2BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 15:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbhATOc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jan 2021 09:32:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390576AbhATOcJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jan 2021 09:32:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4DF823329;
        Wed, 20 Jan 2021 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611153066;
        bh=8ijHEArz/T4yteWj2Qo2ETynpxRFgL8u5w2L3MIippg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6yhmSWuo5TCqMwsKHnuAdBHWipZGSvZEzuvDV2sg4DDvVeKNy21ThcJZDc1JpviA
         kUoUUd3Prgjewen8Geby42C8apKpctaIZTHb9VHrxBsZEYJScoRf5TkPszok7cjVpG
         Jh9pfVcjiAU73NKlZvyv8ijJckfqk5KvBQ0EZbcCf3DUSfpcXd31axMfshcoC90oAC
         astLVLfgvR94fFkni1HsBbKmpCIP7UxvNhXYSgytjSlbLlFuyz95t8uBWUiQ2tDimo
         qfLLrbphpGRNZwU5YRKjQF99+mCwKa9/iDUp/B6Wmh3HGm0kYpME+ARWqCQqkgumIH
         aK/jFIM6d8YIg==
Date:   Wed, 20 Jan 2021 16:31:00 +0200
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
Subject: Re: [PATCH] x86/sgx: Allows ioctl PROVISION to execute before CREATE
Message-ID: <YAg+pLjGZTZvx0ln@kernel.org>
References: <20210118133335.98907-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118133335.98907-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 18, 2021 at 09:33:35PM +0800, Tianjia Zhang wrote:
> In function sgx_encl_create(), the logic of directly assigning
> value to attributes_mask determines that the call to
> SGX_IOC_ENCLAVE_PROVISION must be after the command of
> SGX_IOC_ENCLAVE_CREATE. If change this assignment statement to
> or operation, the PROVISION command can be executed earlier and
> more flexibly.
> 
> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---

Why?

>  arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index f45957c05f69..0ca3fc238bc2 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -108,7 +108,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  	encl->base = secs->base;
>  	encl->size = secs->size;
>  	encl->attributes = secs->attributes;
> -	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
> +	encl->attributes_mask |= SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
>  
>  	/* Set only after completion, as encl->lock has not been taken. */
>  	set_bit(SGX_ENCL_CREATED, &encl->flags);
> -- 
> 2.19.1.3.ge56e4f7
> 
> 
