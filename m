Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A75770C8F
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 02:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjHEABE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 20:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjHEABD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 20:01:03 -0400
Received: from out-117.mta1.migadu.com (out-117.mta1.migadu.com [IPv6:2001:41d0:203:375::75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8633F4C04
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Aug 2023 17:01:01 -0700 (PDT)
Message-ID: <fbe1a1b0-3d6a-3336-44f8-7d2004ba961f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691193650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/jcy2U/xuMK5RhJ8wJ2uospEX0/x7PqUTuNJ2h2tcpI=;
        b=ibNOfQeQ66pl/mT2vFCuFRRO0GVS+iCyxBJNnPM/SJdAtE6gA376OOeLMrDNIWnMPRRfvQ
        Zp7GCNqL5rbO+gR643VdG1p8VcDAZamWMoeb3BL96BTjDLtXmE9KjEincvv6LU9L3COqtL
        5UcXj/UHkxB+qeWJeUgOfZHGXjBIqlQ=
Date:   Fri, 4 Aug 2023 17:00:39 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 1/5] bpf: Add update_socket_protocol hook
Content-Language: en-US
To:     Geliang Tang <geliang.tang@suse.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
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
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>
References: <cover.1691125344.git.geliang.tang@suse.com>
 <5155cc5bc678564fcc4e0f6d4a4f82f646c66beb.1691125344.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <5155cc5bc678564fcc4e0f6d4a4f82f646c66beb.1691125344.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/3/23 10:07 PM, Geliang Tang wrote:
> Add a hook named update_socket_protocol in __sys_socket(), for bpf
> progs to attach to and update socket protocol. One user case is to
> force legacy TCP apps to create and use MPTCP sockets instead of
> TCP ones.
> 
> Define a mod_ret set named bpf_mptcp_fmodret_ids, add the hook
> update_socket_protocol into this set, and register it in
> bpf_mptcp_kfunc_init().
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>   net/mptcp/bpf.c | 15 +++++++++++++++
>   net/socket.c    | 24 ++++++++++++++++++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 5a0a84ad94af..8a16672b94e2 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -19,3 +19,18 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>   
>   	return NULL;
>   }
> +
> +BTF_SET8_START(bpf_mptcp_fmodret_ids)
> +BTF_ID_FLAGS(func, update_socket_protocol)
> +BTF_SET8_END(bpf_mptcp_fmodret_ids)
> +
> +static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &bpf_mptcp_fmodret_ids,
> +};
> +
> +static int __init bpf_mptcp_kfunc_init(void)
> +{
> +	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> +}
> +late_initcall(bpf_mptcp_kfunc_init);
> diff --git a/net/socket.c b/net/socket.c
> index 2b0e54b2405c..9f98ced88ac5 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1644,11 +1644,35 @@ struct file *__sys_socket_file(int family, int type, int protocol)
>   	return sock_alloc_file(sock, flags, NULL);
>   }
>   
> +/*	A hook for bpf progs to attach to and update socket protocol.
> + *
> + *	A static noinline declaration here could cause the compiler to
> + *	optimize away the function. A global noinline declaration will
> + *	keep the definition, but may optimize away the callsite.
> + *	Therefore, __weak is needed to ensure that the call is still
> + *	emitted, by telling the compiler that we don't know what the
> + *	function might eventually be.
> + *
> + *	__diag_* below are needed to dismiss the missing prototype warning.
> + */
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "kfuncs which will be used in BPF programs");
This "kfuns which will be used in BPF programs" piece is not accurate. It is a 
fmod_ret entry point for bpf prog.

> +
> +__weak noinline int update_socket_protocol(int family, int type, int protocol)
> +{
> +	return protocol;
> +}
> +
> +__diag_pop();
> +
>   int __sys_socket(int family, int type, int protocol)
>   {
>   	struct socket *sock;
>   	int flags;
>   
> +	protocol = update_socket_protocol(family, type, protocol);

Paolo, could you help to take another look and ack this patch if it has 
addressed your earlier comment ?

>   	sock = __sys_socket_create(family, type, protocol);
>   	if (IS_ERR(sock))
>   		return PTR_ERR(sock);

