Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F5B309556
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Jan 2021 14:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhA3N1J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Jan 2021 08:27:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhA3N1G (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Jan 2021 08:27:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F111964E05;
        Sat, 30 Jan 2021 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612013185;
        bh=9g8Weva6Bu5I0fLYPtGE67zrIs27HNKf1unRqDZxlEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXJfBMXxV4u0dYwPJtTQ4Vlg5hacVZMJlJ1ENGA/tGGxMozaqW2iQC/3Lab8Zw9s9
         46EORyIB0J8gGhRGamLIkPo8beFQCJ7x6eZwen4cyidOzH2q/Wx/+knefkDWIc1oW/
         WjR/HqCV4UWRx2rVQVq80GEQG5i3g16eAvzcc5+csFq3/2v11N32g4h1souzn2UPP5
         +QyhvCJZbiCe2aTcyKEJA5mSmwVJ5SAC4kHfNZRxEriKxHf16gRxsFybsd7YX+1E9+
         sJjC8tk5A+VFx1x3+W9om1pdB/cgWUDeYTaK+JiGrUdKwaZ+cbAZKs8S2ig9nJIcuK
         St865nS088Nlw==
Date:   Sat, 30 Jan 2021 15:26:20 +0200
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
Subject: Re: [PATCH v3 4/5] x86/sgx: Allows ioctl PROVISION to execute before
 CREATE
Message-ID: <YBVefNF9x4mQRpSB@kernel.org>
References: <20210124062907.88229-1-tianjia.zhang@linux.alibaba.com>
 <20210124062907.88229-5-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124062907.88229-5-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 24, 2021 at 02:29:06PM +0800, Tianjia Zhang wrote:
> In the function sgx_create_enclave(), the direct assignment
> operation of attributes_mask determines that the ioctl PROVISION
> operation must be executed after the ioctl CREATE operation,
> which will limit the flexibility of sgx developers.
> 
> This patch takes the assignment of `attributes_mask` from the
> function sgx_create_enclave() has been moved to the function
> sgx_open() to avoid this restriction.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

The commit message should explicit that the API behaviour changes
as the result. Please don't use hyphens in quoting.

/Jarkko

> ---
>  arch/x86/kernel/cpu/sgx/driver.c | 1 +
>  arch/x86/kernel/cpu/sgx/ioctl.c  | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
> index f2eac41bb4ff..fba0d0bfe976 100644
> --- a/arch/x86/kernel/cpu/sgx/driver.c
> +++ b/arch/x86/kernel/cpu/sgx/driver.c
> @@ -36,6 +36,7 @@ static int sgx_open(struct inode *inode, struct file *file)
>  		return ret;
>  	}
>  
> +	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
>  	file->private_data = encl;
>  
>  	return 0;
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 90a5caf76939..1c6ecf9fbeff 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -109,7 +109,6 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  	encl->base = secs->base;
>  	encl->size = secs->size;
>  	encl->attributes = secs->attributes;
> -	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
>  
>  	/* Set only after completion, as encl->lock has not been taken. */
>  	set_bit(SGX_ENCL_CREATED, &encl->flags);
> -- 
> 2.19.1.3.ge56e4f7
> 
> 
