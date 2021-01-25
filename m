Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C143029BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 19:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbhAYSOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jan 2021 13:14:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731260AbhAYSNh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 13:13:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B563D22583;
        Mon, 25 Jan 2021 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611598376;
        bh=xUqyJZQ/DcDP2maOwJW2N/DX3loKg7J8/mDXbjv2zj8=;
        h=Date:From:To:Cc:Subject:From;
        b=NDXk+cUAn0q765alGCwBd0SAc3GwcVMGzSxZJDdM8qMAP0z+YDfKkdswqe3o5Alt7
         qHPDP0Shs2MU7EAjlHzWPzN6jQzLMhGW5BddLvx1lcnw+Eu9szO+ADibHrXblEbAt9
         loWTUJv+gF3/uA5N00r2KHxH766f6Q1fbPtBql4iPyhscIKmeFoM2jAGyxG/cqLmH6
         c6b24kf0oL9w4uI1Q8iK/cINJzK0Jhd/65W5+CkF0knmVUTQEXCN/XEjnAuLmvtlUf
         vOmsD9fjl7PEW15le0Gai+tvDY/JiMYFdjy8S7bQwqjAZQxEMKcNBgF3fCRzh/ZP+M
         +99undM/pEn6w==
Date:   Mon, 25 Jan 2021 20:12:53 +0200
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
Subject: Re: [PATCH v3 1/5] selftests/x86: Simplify the code to get vdso base
 address in sgx
Message-ID: <YA8KJXkLRnaDot58@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

What the short summary is saying now, is that this commit would make the
existing code to use vDSO base address. It's already doing that.

You could instead just "Use getauxval() to simplify the code".

Also, I'd prefer to properly use upper and lower case letter, e.g.  vDSO
instead of vdso.

Reply-To: 
In-Reply-To: <20210124062907.88229-2-tianjia.zhang@linux.alibaba.com>

On Sun, Jan 24, 2021 at 02:29:03PM +0800, Tianjia Zhang wrote:
> This patch uses the library function `getauxval(AT_SYSINFO_EHDR)`
> instead of the custom function `vdso_get_base_addr` to obtain the

Use either double or single quotation mark instead of hyphen.

> base address of vDSO, which will simplify the code implementation.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

This needs to be imperative form, e.g. "Simplify the code implemntation
by using getauxval() instead of a custom function."

> ---
>  tools/testing/selftests/sgx/main.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 724cec700926..365d01dea67b 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -15,6 +15,7 @@
>  #include <sys/stat.h>
>  #include <sys/time.h>
>  #include <sys/types.h>
> +#include <sys/auxv.h>
>  #include "defines.h"
>  #include "main.h"
>  #include "../kselftest.h"
> @@ -28,24 +29,6 @@ struct vdso_symtab {
>  	Elf64_Word *elf_hashtab;
>  };
>  
> -static void *vdso_get_base_addr(char *envp[])
> -{
> -	Elf64_auxv_t *auxv;
> -	int i;
> -
> -	for (i = 0; envp[i]; i++)
> -		;
> -
> -	auxv = (Elf64_auxv_t *)&envp[i + 1];
> -
> -	for (i = 0; auxv[i].a_type != AT_NULL; i++) {
> -		if (auxv[i].a_type == AT_SYSINFO_EHDR)
> -			return (void *)auxv[i].a_un.a_val;
> -	}
> -
> -	return NULL;
> -}
> -
>  static Elf64_Dyn *vdso_get_dyntab(void *addr)
>  {
>  	Elf64_Ehdr *ehdr = addr;
> @@ -162,7 +145,7 @@ static int user_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r
>  	return 0;
>  }
>  
> -int main(int argc, char *argv[], char *envp[])
> +int main(int argc, char *argv[])
>  {
>  	struct sgx_enclave_run run;
>  	struct vdso_symtab symtab;
> @@ -203,7 +186,8 @@ int main(int argc, char *argv[], char *envp[])
>  	memset(&run, 0, sizeof(run));
>  	run.tcs = encl.encl_base;
>  
> -	addr = vdso_get_base_addr(envp);
> +	/* Get vDSO base address */
> +	addr = (void *)(uintptr_t)getauxval(AT_SYSINFO_EHDR);

You could just case the result the result directly to void *.

>  	if (!addr)
>  		goto err;
>  
> -- 
> 2.19.1.3.ge56e4f7
> 
> 

/Jarkko
