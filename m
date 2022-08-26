Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33345A28CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiHZNsy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 09:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiHZNsw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 09:48:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B0B8053C;
        Fri, 26 Aug 2022 06:48:51 -0700 (PDT)
Received: from [192.168.10.7] (unknown [39.53.61.43])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 661336601ECE;
        Fri, 26 Aug 2022 14:48:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661521730;
        bh=wyZTBkl/LljdYgt4Tb8GKYj0jjhaykvQW272r+/nshQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=IgmxoTsgUfOVWXf/KEJQDzoqZeRe0KKtoYXfGSkmDpS70G0baYwxBg3F2BqF2MGbE
         XzjP1GFlFTKafCVRBVyvmR/osEtcgutNdIrT5s55ThREBgT9h4SB0EvlgEdJ5yzfGO
         CGfa5OvyJcoXrqEJ+FXFd/ZE6EsVOGYEGWMn4HxMruXKB4qMsJQK8gSeXiYeFsEocE
         zKgDqcRM8SmS71qVZlBhlcO9Y0g4N82giiCEfnxosfGX/mKS1RoZaQdfU7QB62J8s4
         KhVwkhQEw+whtbjPQJbw8/7MSt6j+zOEpeZ2zNmqXqr0KRujOsrHigOsvkAajkarA6
         FififvfrelAew==
Message-ID: <f1aa5e6c-6bcd-c605-97e9-c8aa58520cc3@collabora.com>
Date:   Fri, 26 Aug 2022 18:48:41 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Cc:     usama.anjum@collabora.com, Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Fix bind{4,6} tcp/socket header type
 conflict
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>, bpf@vger.kernel.org
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220825221751.258958-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/26/22 3:17 AM, James Hilliard wrote:
> There is a potential for us to hit a type conflict when including
> netinet/tcp.h with sys/socket.h, we can replace both of these includes
> with linux/tcp.h to avoid this conflict.
> 
> Fixes errors like:
> In file included from /usr/include/netinet/tcp.h:91,
>                  from progs/bind4_prog.c:10:
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
>    34 | typedef __INT8_TYPE__ int8_t;
>       |                       ^~~~~~
> In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>                  from progs/bind4_prog.c:9:
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
>    24 | typedef __int8_t int8_t;
>       |                  ^~~~~~
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
>    43 | typedef __INT64_TYPE__ int64_t;
>       |                        ^~~~~~~
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
>    27 | typedef __int64_t int64_t;
>       |                   ^~~~~~~
> make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
>  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> index 474c6a62078a..6bd20042fd53 100644
> --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> @@ -6,8 +6,7 @@
>  #include <linux/bpf.h>
>  #include <linux/in.h>
>  #include <linux/in6.h>
> -#include <sys/socket.h>
> -#include <netinet/tcp.h>
> +#include <linux/tcp.h>
>  #include <linux/if.h>
>  #include <errno.h>
>  
> diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
> index c19cfa869f30..f37617b35a55 100644
> --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> @@ -6,8 +6,7 @@
>  #include <linux/bpf.h>
>  #include <linux/in.h>
>  #include <linux/in6.h>
> -#include <sys/socket.h>
> -#include <netinet/tcp.h>
> +#include <linux/tcp.h>
>  #include <linux/if.h>
>  #include <errno.h>
>  

-- 
Muhammad Usama Anjum
