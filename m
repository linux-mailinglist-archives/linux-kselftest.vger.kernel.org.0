Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904E0474C80
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 21:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbhLNUK6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 15:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhLNUK6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 15:10:58 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C8C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 12:10:58 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p23so26307405iod.7
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 12:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aafqAbN1umCKsy+eoUr3Ub+q/hrUYaM2Oh/sRwwhJr8=;
        b=A3b3Melkvt0PCYRbdzuFHHduWmt+ur9YqPTbtAMv72E+6BSN1IaA/vsMwzHxfr/RnB
         AD/vFl1ujmbKZvNPw+zmBTWg4OcPcPI1zCW1zgFPlkCMDR68IwqW+cCJT9lkNDxFJL1Y
         PjB0Qhs+ejxqe5nrYjFf2EsxkoVtfj/uJz74A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aafqAbN1umCKsy+eoUr3Ub+q/hrUYaM2Oh/sRwwhJr8=;
        b=cdnwRrL/fbM4pUwVg1PvLrGrpaxAn2y8WyW/ZSpsiZ8xSVz9ddVOmYPPqOHAfiHXAZ
         OmbdCqR2pV70xAdg8NBsfLPMlbywhNrjGPs2UrFunMYo8PUnyyJmE1FU46TpoRlOSs9V
         KILcD5td0b0BoE9dUecyN40nQt0EgtiJeho1knh5vgN8kFBh/52EPMEbwHOzwBr/YOWQ
         DsiT2Xzq+UOAL29kQXAdxI9gf8n8t8Z6JMNGUNlzF7UM53+hsOAaqzj6kCug8PiIiq8n
         1niisYLQOZl4Y1Z3bQECMnN4NFu0ODyMp9XGcLgcp6T6I/LwcY1SOsuy8QjX1M9uVaG1
         UADQ==
X-Gm-Message-State: AOAM531E6N76LNN9ZBX2IXU0PMxZP0jfrDtdAuvJZ9HOko9pek/NfhAf
        B8n4A2yneADNoUbQ3W51UWntdQ==
X-Google-Smtp-Source: ABdhPJwNO/Sithe2Kktml/StLgHLdP/RJb+RQrKfKSIlt+H/eA7OYRCpr+N8hUj+cmnL7Uzkz1hi5g==
X-Received: by 2002:a05:6602:2acc:: with SMTP id m12mr5020000iov.107.1639512657258;
        Tue, 14 Dec 2021 12:10:57 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g7sm406692iln.67.2021.12.14.12.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 12:10:56 -0800 (PST)
Subject: Re: [PATCH V2] selftests/sgx: Fix build error caused by missing
 dependency
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, jarkko@kernel.org,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <de2a262e97e7b173548b909a608e9e99aab38e9d.1639509500.git.reinette.chatre@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8b7c98f4-f050-bc1c-5699-fa598ecc66a2@linuxfoundation.org>
Date:   Tue, 14 Dec 2021 13:10:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <de2a262e97e7b173548b909a608e9e99aab38e9d.1639509500.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/14/21 12:26 PM, Reinette Chatre wrote:
> Commit f0ff2447b861 ("selftests/sgx: Add a new kselftest:
> Unclobbered_vdso_oversubscribed") depends on __cpuid() without
> providing the dependency and thus introduces a build error:
> 
> $ make
> gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c main.c -o ../linux/tools/testing/selftests/sgx/main.o
> main.c: In function ‘get_total_epc_mem’:
> main.c:296:3: error: implicit declaration of function ‘__cpuid’ [-Werror=implicit-function-declaration]
>    296 |   __cpuid(&eax, &ebx, &ecx, &edx);
>        |   ^~~~~~~
> cc1: all warnings being treated as errors
> make: *** [Makefile:33: ../linux/tools/testing/selftests/sgx/main.o] Error 1
> $
> 
> Clone kernel's __cpuid() implementation to the self-test in order
> to make it available to the EPC enumeration code.
> 
> Fixes: f0ff2447b861 ("selftests/sgx: Add a new kselftest: Unclobbered_vdso_oversubscribed")
> Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> 
> The commit introducing the issue can be found on
> the x86/sgx branch of tip.git.
> 
> Changes since V1:
> - V1: https://lore.kernel.org/linux-sgx/797ff1331cfe540fc378fcc4a4a7b00ff5099fbe.1638905135.git.reinette.chatre@intel.com/
> - Improve commit message. (Jarkko)
> 
>   tools/testing/selftests/sgx/main.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 7e912db4c6c5..6dead57a3121 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -73,6 +73,18 @@ static bool vdso_get_symtab(void *addr, struct vdso_symtab *symtab)
>   	return true;
>   }
>   
> +static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
> +			   unsigned int *ecx, unsigned int *edx)
> +{
> +	asm volatile("cpuid"
> +	    : "=a" (*eax),
> +	      "=b" (*ebx),
> +	      "=c" (*ecx),
> +	      "=d" (*edx)
> +	    : "0" (*eax), "2" (*ecx)
> +	    : "memory");
> +}
> +
>   static unsigned long elf_sym_hash(const char *name)
>   {
>   	unsigned long h = 0, high;
> 

Let's not add one more __cpuid() define to the individual tests.
We so far have:

tools/testing/selftests/vm/pkey-x86.h
selftests/x86/corrupt_xstate_header.c

Let's move the defines to kselftest.h and remove all these duplicate
defines.

For now you could include vm/pkey-x86.h just to fix the build error
and do the proper cleanup.

There has been a proliferation of defines in tools and selftests.
I just fixed/remove 25+ ARRAY_SIZE duplicate define in selftests.
  
thanks,
-- Shuah
