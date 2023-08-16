Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B141977E92D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 21:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbjHPS7a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbjHPS71 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 14:59:27 -0400
Received: from out-42.mta1.migadu.com (out-42.mta1.migadu.com [IPv6:2001:41d0:203:375::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C2F2700
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 11:59:25 -0700 (PDT)
Message-ID: <3590084f-bc61-b2c7-ed1b-dd4caa85fdcd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692212362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCFj1wUEPbKCUAicOTDsxyUO5WEYUOvgrXDS/ukJ/vw=;
        b=pVduOOAy3dw3c4iuelYrt3xow2jG7+SQcWBUGfqv58WAu6NkLuNcB3VtXyyrEGaRv549MB
        ppQQsVgUAivt2n09prjT8L27YETLhN/YnQrzxWne4u//uOPeyx4qZiZqV/FNKIyzfzL9jj
        lkpc3ZHx2YYM6kTZCPi0DdwbLph1aLY=
Date:   Wed, 16 Aug 2023 11:59:12 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v14 4/4] selftests/bpf: Add mptcpify test
Content-Language: en-US
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>
References: <cover.1692147782.git.geliang.tang@suse.com>
 <364e72f307e7bb38382ec7442c182d76298a9c41.1692147782.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <364e72f307e7bb38382ec7442c182d76298a9c41.1692147782.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/23 6:11 PM, Geliang Tang wrote:
> Implement a new test program mptcpify: if the family is AF_INET or
> AF_INET6, the type is SOCK_STREAM, and the protocol ID is 0 or
> IPPROTO_TCP, set it to IPPROTO_MPTCP. It will be hooked in
> update_socket_protocol().
> 
> Extend the MPTCP test base, add a selftest test_mptcpify() for the
> mptcpify case. Open and load the mptcpify test prog to mptcpify the
> TCP sockets dynamically, then use start_server() and connect_to_fd()
> to create a TCP socket, but actually what's created is an MPTCP
> socket, which can be verified through 'getsockopt(SOL_PROTOCOL)'
> and 'getsockopt(MPTCP_INFO)'.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>   .../testing/selftests/bpf/prog_tests/mptcp.c  | 116 ++++++++++++++++++
>   tools/testing/selftests/bpf/progs/mptcpify.c  |  20 +++
>   2 files changed, 136 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 3d3999067e27..68ebf9735e16 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -2,13 +2,30 @@
>   /* Copyright (c) 2020, Tessares SA. */
>   /* Copyright (c) 2022, SUSE. */
>   
> +#include <linux/mptcp.h>
bpf CI failed 
(https://github.com/kernel-patches/bpf/actions/runs/5882006207/job/15951617063):

   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/mptcp.c:5:10: fatal 
error: 'linux/mptcp.h' file not found
   #include <linux/mptcp.h>

I fixed that by copying the 'struct mptcp_info' but renamed to 'struct 
__mptcp_info' just in case any fallout in the future.

My environment also does not have SOL_MPTCP, so I do an ifndef for it also.

> +#include <netinet/in.h>
>   #include <test_progs.h>
>   #include "cgroup_helpers.h"
>   #include "network_helpers.h"
>   #include "mptcp_sock.skel.h"
> +#include "mptcpify.skel.h"
>   
>   #define NS_TEST "mptcp_ns"
>   
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif
> +
> +#ifndef MPTCP_INFO
> +#define MPTCP_INFO		1
> +#endif
> +#ifndef MPTCP_INFO_FLAG_FALLBACK
> +#define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)

I have to add '#include <linux/const.h>' for the _BITUL() here also....

The set is applied. Please follow up if I make mistake on those fixes.

