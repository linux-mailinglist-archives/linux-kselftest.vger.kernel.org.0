Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9846A3E063C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 18:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbhHDQ7w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Aug 2021 12:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbhHDQ7w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Aug 2021 12:59:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2B1C061799
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Aug 2021 09:59:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i6so4465097edu.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Aug 2021 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=KmLsmMlubIMU2spoNL+04wztjaeh8stCpkK1emGzO5k=;
        b=yleBr/Pw7peq2YBjw8s98ZTMwsBIobO4MskqXa/1tAZr10qSMSJdS9Cs+oAH6WbPEY
         WmnMc2Ya6c1RRySDP4OV7GQKrN+ufj5FgxWaa5U+nC3hwjMjVZhpGUFRj9YGw3dhFCZW
         a0K8L4VaWLoBcMCPCplnh7QvxvT4bv/TJud3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=KmLsmMlubIMU2spoNL+04wztjaeh8stCpkK1emGzO5k=;
        b=twZcbWjiZlWLeqP5ahkeBUfqCHfNQ2G7y+S26am/iSVFuxZE9M0/s77K+YfEv8n94u
         ReUfOJPv14fe6t6vhtwwWKCDY8qrV5nMDIW9sU7pm/lPAFyXdwfYTYRREeyLphAGjOf2
         5UaHxORvC79wYmTvd3urxgLvFJY0AjjhkbmDITepYX45LUSBU6D+d9n/TBa9jvKz6WGI
         DFR8o6RwSqbWMp56vSqDLT4s8y3/vumcht7dpDKOoW+5X5TF3pcGNPqf6uBiNrKu2YLq
         EFfDX8OVJkp+daDzCe3NbqQJixp2rxjNIqASJYUe7qn08PyS4lkEUiEK9H7j8aD5gUaR
         GeNQ==
X-Gm-Message-State: AOAM530+l3aiAFQEarrCmZ1YeL1wACdOwRuGmi5sqxPg5tQpY2WwSNOn
        kWzFlfvCI7IqyxZv7I7SIpnU7A==
X-Google-Smtp-Source: ABdhPJzzqPzFH3Owd+Czu2qCy9AiFVzdY2OQZB68bzphJTMuO8jpuskcK32mV1EhrbLOGgly1lHtZg==
X-Received: by 2002:a50:cac7:: with SMTP id f7mr871924edi.302.1628096377670;
        Wed, 04 Aug 2021 09:59:37 -0700 (PDT)
Received: from cloudflare.com (79.191.182.217.ipv4.supernova.orange.pl. [79.191.182.217])
        by smtp.gmail.com with ESMTPSA id i14sm1145518edx.30.2021.08.04.09.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 09:59:37 -0700 (PDT)
References: <20210802211912.116329-1-jiang.wang@bytedance.com>
 <20210802211912.116329-3-jiang.wang@bytedance.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Jiang Wang <jiang.wang@bytedance.com>
Cc:     netdev@vger.kernel.org, cong.wang@bytedance.com,
        duanxiongchun@bytedance.com, xieyongji@bytedance.com,
        chaiwen.cc@bytedance.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/5] af_unix: add unix_stream_proto for sockmap
In-reply-to: <20210802211912.116329-3-jiang.wang@bytedance.com>
Date:   Wed, 04 Aug 2021 18:59:35 +0200
Message-ID: <87zgtxcfig.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 02, 2021 at 11:19 PM CEST, Jiang Wang wrote:

[...]

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index ae5fa4338..42f50ea7a 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -517,9 +517,15 @@ static bool sk_is_tcp(const struct sock *sk)
>  	       sk->sk_protocol == IPPROTO_TCP;
>  }
>
> +static bool sk_is_unix_stream(const struct sock *sk)
> +{
> +	return sk->sk_type == SOCK_STREAM &&
> +	       sk->sk_protocol == PF_UNIX;
> +}
> +
>  static bool sock_map_redirect_allowed(const struct sock *sk)
>  {
> -	if (sk_is_tcp(sk))
> +	if (sk_is_tcp(sk) || sk_is_unix_stream(sk))
>  		return sk->sk_state != TCP_LISTEN;
>  	else
>  		return sk->sk_state == TCP_ESTABLISHED;

Let me provide some context.

The reason why we check != TCP_LISTEN for TCP sockets is that we want to
allow redirect redirect to sockets that are about to transition from
TCP_SYN_RECV to TCP_ESTABLISHED, in addition to sockets already in
TCP_ESTABLISHED state.

That's because BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB callback happens when
socket is still in TCP_SYN_RECV state. With BPF sockops program, we can
insert such socket into a sockmap. Hence, there is a short window of
opportunity when we could redirect to a socket in TCP_SYN_RECV.

UNIX sockets can be only in TCP_{CLOSE,LISTEN,ESTABLISHED} state,
AFAIK. So it is sufficient to rely on the default == TCP_ESTABLISHED
check.

> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 0ae3fc4c8..9c1711c67 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -791,17 +791,35 @@ static void unix_close(struct sock *sk, long timeout)
>  	 */
>  }
>
> -struct proto unix_proto = {
> -	.name			= "UNIX",
> +static void unix_unhash(struct sock *sk)
> +{
> +	/* Nothing to do here, unix socket does not need a ->unhash().
> +	 * This is merely for sockmap.
> +	 */
> +}
> +
> +struct proto unix_dgram_proto = {
> +	.name			= "UNIX-DGRAM",
> +	.owner			= THIS_MODULE,
> +	.obj_size		= sizeof(struct unix_sock),
> +	.close			= unix_close,
> +#ifdef CONFIG_BPF_SYSCALL
> +	.psock_update_sk_prot	= unix_dgram_bpf_update_proto,
> +#endif
> +};
> +
> +struct proto unix_stream_proto = {
> +	.name			= "UNIX-STREAM",
>  	.owner			= THIS_MODULE,
>  	.obj_size		= sizeof(struct unix_sock),
>  	.close			= unix_close,
> +	.unhash			= unix_unhash,
>  #ifdef CONFIG_BPF_SYSCALL
> -	.psock_update_sk_prot	= unix_bpf_update_proto,
> +	.psock_update_sk_prot	= unix_stream_bpf_update_proto,
>  #endif
>  };
>
> -static struct sock *unix_create1(struct net *net, struct socket *sock, int kern)
> +static struct sock *unix_create1(struct net *net, struct socket *sock, int kern, int type)
>  {
>  	struct sock *sk = NULL;
>  	struct unix_sock *u;
> @@ -810,7 +828,11 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern)
>  	if (atomic_long_read(&unix_nr_socks) > 2 * get_max_files())
>  		goto out;
>
> -	sk = sk_alloc(net, PF_UNIX, GFP_KERNEL, &unix_proto, kern);
> +	if (type == SOCK_STREAM)
> +		sk = sk_alloc(net, PF_UNIX, GFP_KERNEL, &unix_stream_proto, kern);
> +	else /*dgram and  seqpacket */
> +		sk = sk_alloc(net, PF_UNIX, GFP_KERNEL, &unix_dgram_proto, kern);
> +
>  	if (!sk)
>  		goto out;
>
> @@ -872,7 +894,7 @@ static int unix_create(struct net *net, struct socket *sock, int protocol,
>  		return -ESOCKTNOSUPPORT;
>  	}
>
> -	return unix_create1(net, sock, kern) ? 0 : -ENOMEM;
> +	return unix_create1(net, sock, kern, sock->type) ? 0 : -ENOMEM;
>  }
>
>  static int unix_release(struct socket *sock)
> @@ -1286,7 +1308,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  	err = -ENOMEM;
>
>  	/* create new sock for complete connection */
> -	newsk = unix_create1(sock_net(sk), NULL, 0);
> +	newsk = unix_create1(sock_net(sk), NULL, 0, sock->type);
>  	if (newsk == NULL)
>  		goto out;
>
> @@ -2214,7 +2236,7 @@ static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg, size_t si
>  	struct sock *sk = sock->sk;
>
>  #ifdef CONFIG_BPF_SYSCALL
> -	if (sk->sk_prot != &unix_proto)
> +	if (sk->sk_prot != &unix_dgram_proto)
>  		return sk->sk_prot->recvmsg(sk, msg, size, flags & MSG_DONTWAIT,
>  					    flags & ~MSG_DONTWAIT, NULL);
>  #endif


KASAN might be unhappy about access to sk->sk_prot not annotated with
READ_ONCE. In unix_bpf we have WRITE_ONCE(sk->sk_prot, ...) [1]

[...]

[1] https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE#why-kernel-code-should-use-read_once-and-write_once-for-shared-memory-accesses
