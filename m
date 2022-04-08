Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8AE4F9E37
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 22:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbiDHUd4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 16:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiDHUdz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 16:33:55 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5771C289B9;
        Fri,  8 Apr 2022 13:31:50 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1ncvGg-000Ak2-Hi; Fri, 08 Apr 2022 22:31:42 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ncvGg-000PVw-8J; Fri, 08 Apr 2022 22:31:42 +0200
Subject: Re: [PATCH v2 1/2] selftests: bpf: drop duplicate max/min definitions
To:     Geliang Tang <geliang.tang@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1649424565.git.geliang.tang@suse.com>
 <0efb81dab7a8de23044302c5c7fa9af308766236.1649424565.git.geliang.tang@suse.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <812d81d8-a011-11a9-f765-d9972afca230@iogearbox.net>
Date:   Fri, 8 Apr 2022 22:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0efb81dab7a8de23044302c5c7fa9af308766236.1649424565.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26506/Fri Apr  8 10:23:48 2022)
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/8/22 3:36 PM, Geliang Tang wrote:
> Drop duplicate macros min() and MAX() definitions in prog_tests, use MIN()
> or MAX() in sys/param.h instead.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
[...]

Thanks Geliang! One small final nit and then it's good to go to bpf-next:

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 5142a7d130b2..86561c0b0dea 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (c) 2020 Facebook */
> +#include <sys/param.h>
>   #include <test_progs.h>
>   #include "bpf_iter_ipv6_route.skel.h"
>   #include "bpf_iter_netlink.skel.h"
[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index 8f7a1cef7d87..ceed369361fc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -3,6 +3,7 @@
>   
>   #include <linux/err.h>
>   #include <netinet/tcp.h>
> +#include <sys/param.h>
>   #include <test_progs.h>
>   #include "network_helpers.h"
>   #include "bpf_dctcp.skel.h"
[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> index 394ebfc3bbf3..5ca70aa15c4a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (c) 2021 Google LLC. */
>   
> +#include <sys/param.h>
>   #include <test_progs.h>
>   #include "test_snprintf.skel.h"
>   #include "test_snprintf_single.skel.h"
> @@ -83,8 +84,6 @@ static void test_snprintf_positive(void)
[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> index 7ad66a247c02..52f1b9139145 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> @@ -20,6 +20,7 @@
>   #include <stdbool.h>
>   #include <stdio.h>
>   #include <sys/stat.h>
> +#include <sys/param.h>
>   #include <unistd.h>
>   
>   #include "test_progs.h"

Just add the sys/param.h to the test_progs.h header in BPF selftests where we also pull
in other sys headers; then all the duplicate includes above are not needed.

Thanks,
Daniel
