Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117DF3F534C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 00:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhHWWTw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Aug 2021 18:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhHWWTu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Aug 2021 18:19:50 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67229C061575
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Aug 2021 15:19:07 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i3-20020a056830210300b0051af5666070so30801253otc.4
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Aug 2021 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oyp89nAgbzeFEntwPqKbZqvGDPkK7mODDQJczrVIggE=;
        b=JqtPOtcVV446M+6xg7YXgQpqilpRCu+Ma4npGTn0f5VXUHJ1HmnoJMNnrrJF1GUXwW
         f3aPVbe1KrOr4z+QcYZgB/t4N5f8TQZdAHWXsimHISF4OnCvKWhJ8Oo9GE7stOBgauSs
         4VFLFpMfMn7iugPI3nc5AZIf/sT1MghmTTuJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oyp89nAgbzeFEntwPqKbZqvGDPkK7mODDQJczrVIggE=;
        b=NriBhmEo3+Rs5kVZfk4qdqUOmDZpg62XHvVZZH4dWcFvE9aqKxcZyYd6RwfGQwhogY
         B1dTESZaiw80efmgL3djVdckoXKHy/bHXTueVM7uXV6ezbwcZQHbLK4+wPV41AcbJY2T
         nPiogfaHn1sYPgcRvmmGn3m6FOdVUDuwZV5QdhniDZonGPfEgcip00d+SCl2FGKBy3AN
         Ct3q5FJixjklePkOUR68h4cDTuOwSl/inGCIR7rRIIPt/3wSNY9n/ivOqYtsVuXjXPkR
         JRCBgAd7z3hrshMaE+3e9925mCIpZP8G1UzgZ38KLKZcwzB9TeQmK+eeuZO041cfBU3A
         b/3w==
X-Gm-Message-State: AOAM531Un3VZYJzp3xCHSIxjNAPU0oAHc/8yjg7g9lAbATtjkJYzeMmf
        U3xL+ovlL3Ot+Z8JHyYgpfNsBg==
X-Google-Smtp-Source: ABdhPJyFTiS4AxQg+lLWzmQBDUW5zCPqeJfIwhTsBxRqKDWFjnd81ogpCxkIPhj14PpMeOxe29fx4A==
X-Received: by 2002:aca:3d46:: with SMTP id k67mr585273oia.145.1629757146749;
        Mon, 23 Aug 2021 15:19:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c24sm4148296otf.71.2021.08.23.15.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 15:19:06 -0700 (PDT)
Subject: Re: [PATCH] selftests/x86/sigreturn: Fix error: variably modified
 'altstack_data' at file scope
To:     Jun Miao <jun.miao@windriver.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210823093026.3839645-1-jun.miao@windriver.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <62fb376b-95fb-56c2-8571-d9dcf8867162@linuxfoundation.org>
Date:   Mon, 23 Aug 2021 16:19:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210823093026.3839645-1-jun.miao@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/23/21 3:30 AM, Jun Miao wrote:
> Based on glibc 2.33 -> 2.34, there is one new feature:
> 
> NEWS for version 2.34
> =====================
> 
> Major new features:
> * Add _SC_MINSIGSTKSZ and _SC_SIGSTKSZ.  When _DYNAMIC_STACK_SIZE_SOURCE
>    or _GNU_SOURCE are defined, MINSIGSTKSZ and SIGSTKSZ are no longer
>    constant on Linux.  MINSIGSTKSZ is redefined to sysconf(_SC_MINSIGSTKSZ)
>    and SIGSTKSZ is redefined to sysconf (_SC_SIGSTKSZ).  This supports
>    dynamic sized register sets for modern architectural features like
>    Arm SVE.
> 
> Build error with the GNU C Library 2.34:
> DEBUG:	| sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
> | sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
> DEBUG:	|   150 | static char altstack_data[SIGSTKSZ];
> |   150 | static char altstack_data[SIGSTKSZ];
> DEBUG:	|       |             ^~~~~~~~~~~~~
> 
> Signed-off-by: Jun Miao <jun.miao@windriver.com>
> ---
>   tools/testing/selftests/x86/sigreturn.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
> index 57c4f67f16ef..e32ffcc7053d 100644
> --- a/tools/testing/selftests/x86/sigreturn.c
> +++ b/tools/testing/selftests/x86/sigreturn.c
> @@ -138,9 +138,6 @@ static unsigned short LDT3(int idx)
>   	return (idx << 3) | 7;
>   }
>   
> -/* Our sigaltstack scratch space. */
> -static char altstack_data[SIGSTKSZ];
> -
>   static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
>   		       int flags)
>   {
> @@ -771,7 +768,8 @@ int main()
>   	setup_ldt();
>   
>   	stack_t stack = {
> -		.ss_sp = altstack_data,
> +		/* Our sigaltstack scratch space. */
> +		.ss_sp = malloc (sizeof(char) * SIGSTKSZ),
>   		.ss_size = SIGSTKSZ,
>   	};
>   	if (sigaltstack(&stack, NULL) != 0)
> @@ -872,5 +870,6 @@ int main()
>   	total_nerrs += test_nonstrict_ss();
>   #endif
>   
> +	free(stack.ss_sp);
>   	return total_nerrs ? 1 : 0;
>   }
>

Please see comments on your v2 that includes this change.

thanks,
-- Shuah


