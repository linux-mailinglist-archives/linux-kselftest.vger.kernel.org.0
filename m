Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407932FD32A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbhATOvo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jan 2021 09:51:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390597AbhATOfk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jan 2021 09:35:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E0AF23329;
        Wed, 20 Jan 2021 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611153299;
        bh=iFdLpwpKeZkJepwYerrVF40vWRJ3GSqvzjorTDnVdD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ll53owdsB6m2x9i4robbS/FM07EzmKvW/7Iy/ycMt5rkzITycq9dnrnFdP+AL4q1P
         cK+Clib06xz7LXRK9hzzM5GaP7fI7s3urYUPLNHkohZRf8DGauG3MiE4vtW/VU/B/6
         e7xH/jQf/ZJlJ3uNK4QWDsACg6SQOcDKunvFaxU8pyfksjeDclo08iukFItIDqve6w
         xA5binXJ584bFr5CpU+YcBfqp8WLH6Bvw4T+HnF+h8Sw2C18hFqSpFjmSaDDPmB1aD
         F6pIoNgn0XkCzGxitIzuR0R1ekQPGnNtnoTUJrhekjhch9cznVHIOeR9m0FzHnT+Pg
         nfMh51c56T6iw==
Date:   Wed, 20 Jan 2021 16:34:53 +0200
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
Subject: Re: [PATCH] selftests/x86: Simplify the code of getting vdso base
 address in sgx
Message-ID: <YAg/jfoCdE0GanNQ@kernel.org>
References: <20210118133321.98655-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118133321.98655-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 18, 2021 at 09:33:21PM +0800, Tianjia Zhang wrote:
> The base address of vDSO can be obtained through the library function
> `getauxval()`, so use `getauxval(AT_SYSINFO_EHDR)` instead of a custom
> implementation to simplify the code.
> 
> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

- Remove reported-by, as there is no regression.
- Please write to the long description what the commit does.
  It's lacking that. I.e. instead of passive form: "Obtain the
  base address...".

/Jarkko

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
>  	if (!addr)
>  		goto err;
>  
> -- 
> 2.19.1.3.ge56e4f7
> 
> 
