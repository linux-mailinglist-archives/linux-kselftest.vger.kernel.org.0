Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763385A4FE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiH2PLw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiH2PLv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:11:51 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018A57F138;
        Mon, 29 Aug 2022 08:11:49 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSgQV-0007xd-AO; Mon, 29 Aug 2022 17:11:47 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSgQU-000Qpj-RB; Mon, 29 Aug 2022 17:11:46 +0200
Subject: Re: [PATCH] selftests/bpf: Fix connect4_prog tcp/socket header type
 conflict
To:     James Hilliard <james.hilliard1@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220826055025.1018491-1-james.hilliard1@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e3d9f936-926c-8cd4-1a21-4c2894bf22b6@iogearbox.net>
Date:   Mon, 29 Aug 2022 17:11:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220826055025.1018491-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26642/Mon Aug 29 09:54:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/26/22 7:50 AM, James Hilliard wrote:
[...]
> diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
> index b241932911db..0f68b8d756b3 100644
> --- a/tools/testing/selftests/bpf/progs/connect4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
> @@ -7,8 +7,7 @@
>   #include <linux/bpf.h>
>   #include <linux/in.h>
>   #include <linux/in6.h>
> -#include <sys/socket.h>
> -#include <netinet/tcp.h>
> +#include <linux/tcp.h>
>   #include <linux/if.h>
>   #include <errno.h>

Can't we just add:

#include "bpf_tcp_helpers.h"

It does define SOL_TCP already and is used also in other prog tests. I presume this
would avoid the need the change all the below.

> @@ -52,7 +51,7 @@ static __inline int verify_cc(struct bpf_sock_addr *ctx,
>   	char buf[TCP_CA_NAME_MAX];
>   	int i;
>   
> -	if (bpf_getsockopt(ctx, SOL_TCP, TCP_CONGESTION, &buf, sizeof(buf)))
> +	if (bpf_getsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, &buf, sizeof(buf)))
>   		return 1;
>   
>   	for (i = 0; i < TCP_CA_NAME_MAX; i++) {
> @@ -70,12 +69,12 @@ static __inline int set_cc(struct bpf_sock_addr *ctx)
>   	char reno[TCP_CA_NAME_MAX] = "reno";
>   	char cubic[TCP_CA_NAME_MAX] = "cubic";
>   
> -	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &reno, sizeof(reno)))
> +	if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, &reno, sizeof(reno)))
>   		return 1;
>   	if (verify_cc(ctx, reno))
>   		return 1;
>   
> -	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &cubic, sizeof(cubic)))
> +	if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, &cubic, sizeof(cubic)))
>   		return 1;
>   	if (verify_cc(ctx, cubic))
>   		return 1;
> @@ -113,15 +112,15 @@ static __inline int set_keepalive(struct bpf_sock_addr *ctx)
>   	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_KEEPALIVE, &one, sizeof(one)))
>   		return 1;
>   	if (ctx->type == SOCK_STREAM) {
> -		if (bpf_setsockopt(ctx, SOL_TCP, TCP_KEEPIDLE, &one, sizeof(one)))
> +		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_KEEPIDLE, &one, sizeof(one)))
>   			return 1;
> -		if (bpf_setsockopt(ctx, SOL_TCP, TCP_KEEPINTVL, &one, sizeof(one)))
> +		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_KEEPINTVL, &one, sizeof(one)))
>   			return 1;
> -		if (bpf_setsockopt(ctx, SOL_TCP, TCP_KEEPCNT, &one, sizeof(one)))
> +		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_KEEPCNT, &one, sizeof(one)))
>   			return 1;
> -		if (bpf_setsockopt(ctx, SOL_TCP, TCP_SYNCNT, &one, sizeof(one)))
> +		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_SYNCNT, &one, sizeof(one)))
>   			return 1;
> -		if (bpf_setsockopt(ctx, SOL_TCP, TCP_USER_TIMEOUT, &one, sizeof(one)))
> +		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_USER_TIMEOUT, &one, sizeof(one)))
>   			return 1;
>   	}
>   	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_KEEPALIVE, &zero, sizeof(zero)))
> @@ -135,7 +134,7 @@ static __inline int set_notsent_lowat(struct bpf_sock_addr *ctx)
>   	int lowat = 65535;
>   
>   	if (ctx->type == SOCK_STREAM) {
> -		if (bpf_setsockopt(ctx, SOL_TCP, TCP_NOTSENT_LOWAT, &lowat, sizeof(lowat)))
> +		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_NOTSENT_LOWAT, &lowat, sizeof(lowat)))
>   			return 1;
>   	}
>   
> 

