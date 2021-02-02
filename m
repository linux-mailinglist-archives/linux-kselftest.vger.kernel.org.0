Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB5830CE65
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Feb 2021 23:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbhBBWE2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Feb 2021 17:04:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234530AbhBBWDh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Feb 2021 17:03:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F26FF64E49;
        Tue,  2 Feb 2021 22:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612303376;
        bh=ZelVrOXLSNk+EelznVWiuqyQw7JN8k3FuopKGg7esik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlwliBRDjLXU/ZsO0dmmScbO3fdXyQnmFXrSwq+nv+QyTO/PYKoX8tN1gD2TSPwaH
         +QvYAi7UeEeIMZL7/UVXMf6GCSqY4hzdMER5DkvfljNHvTSlqTGS38HzIosy0F7snl
         jMQs0x81kWZxwejRrnFLGYLtIa49DmFEBbP4BbqD5RsW0RUPnglAkrIZNYz+sCofhk
         SsGMlSTJr+RxuJM8/V3Tm3i2IvLwDtoYJBDBY1v0yiECauzMa31iyLXTBG/DnKvW74
         QcqYYvUqmynIeflxi53uuQ1YcUmbzk7xfNqkmiiCI4MnnC2dxWj233SQpmhBGM3e9O
         IQ2qIcX9x9bsQ==
Date:   Wed, 3 Feb 2021 00:02:49 +0200
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
Subject: Re: [PATCH v4 1/5] selftests/x86: Use getauxval() to simplify the
 code in sgx
Message-ID: <YBnMCWW8tux490JK@kernel.org>
References: <20210201132653.35690-1-tianjia.zhang@linux.alibaba.com>
 <20210201132653.35690-2-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201132653.35690-2-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 01, 2021 at 09:26:49PM +0800, Tianjia Zhang wrote:
> Simplify the sgx code implemntation by using library function
> getauxval() instead of a custom function to get the base address
> of vDSO.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

This needs also ack from Shuah.

/Jarkko

> ---
>  tools/testing/selftests/sgx/main.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 724cec700926..5167505fbb46 100644
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
> +	addr = (void *)getauxval(AT_SYSINFO_EHDR);
>  	if (!addr)
>  		goto err;
>  
> -- 
> 2.19.1.3.ge56e4f7
> 
> 
