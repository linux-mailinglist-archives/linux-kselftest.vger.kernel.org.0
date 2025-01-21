Return-Path: <linux-kselftest+bounces-24875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F465A17F8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972C53AB8B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C31F3D56;
	Tue, 21 Jan 2025 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Bk4t94gd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A11F3D46
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469125; cv=none; b=TzGQD0Qo1Nxz7cKMOKUS+zPekZivF5BqVAuVARzNo9zi0fcoYKdQ43ihFv+wytVtXDbPkY3TL9Ebr4GJyR/YOnVe6MKcBf3pTsS2pzt/EG2YibNwJNLNSklbIadpNXUrAtGlOGwKzj4zSFmakbm8W9M+0hH5e2py8exFDKKYlBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469125; c=relaxed/simple;
	bh=/gmcvEE0Rx5jh2LWVKSESye9GBDNj3K5WWNKzpCm8YY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XalWWu0UI82iLiUSkPG0jrM8z0s2+FAoCNDXqcKwUbWD3qJG8GS3YQNkaERRQRdYqsISxQf17YL98p0PWB7yq/nKnPxAzGlRUablQ1KtULbNafYzmrM6v40QE3GVi+DL1rng4+6lnQpX6Q05j1qVpAvgEp6nAHwjhcB6mjsqbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Bk4t94gd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so9112327a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 06:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737469122; x=1738073922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qla05eVWuaRhz56PMmfX4qN1VrFCNkwbqexOHM/ne0o=;
        b=Bk4t94gdUF6ISkZKOANckmTitYGXjlS1pbjZRAhcxncUwvWbBP/1mkJx66Gn7unN/4
         WopiB0rBMXWMLNY8/KCJSaAsfCYm2SnAmgyqP0Ou56N0HVgpuoe+y016xmYPOyFgUWYg
         wCuDehPqEgQPODDqMYGhmIPr4opi68N7gfSbluRzjx+pKR8CDFqVOHlQUPa7FNdv0ouS
         PrxMYkHegKrZSRs3F8j/6k604FLCIg0fxF1mZQR0oRB5Uq9OprI03GnU3Y2n93wFldMy
         IVpgY5J5G0b08AAWcF8o4T5zjHL8SUmuI83AN7Ezwip/0f+QH+XWIPhjoMTAYnXd7Ler
         LCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469122; x=1738073922;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qla05eVWuaRhz56PMmfX4qN1VrFCNkwbqexOHM/ne0o=;
        b=BgAgIurGHFqs7GXGYEFsnHXbWYqY3OorYW9+1fbwWzbPiPKwlnRd3BpBexhN8CWbkX
         63JpOiaV6NKgfLVsVakl0I70W5XhUXDYjjyw/mVuYx3RhSfZQVr/3BVHVygMNPx9Pqiw
         HLWiiB0eKeg/DgSPCclS5OFL6zFSNDufdZFjHJQfwiIAhSoTdCRSXmF6oCdl2OMxRVm/
         lfZz3fAb8NGqOPcN7zYsnOkxbUvjNmIjG4B/qgY3JQ/TdpwcvZf1t+DBnqsxRioqlqdV
         4XJsX5fVW/vPP+a0J0nCv+cmWFFQL2dInM/diUCXNKcF8uPEhtm6PcX4Bzam/7R8uXCd
         dapg==
X-Forwarded-Encrypted: i=1; AJvYcCWB/KgbB107ioPTKM6VxUfWOztWYCUA2JhHS28UvNY62ZiV3p33acIPAPYjvz48wcv9rmuEInwaXuQ1Ccl7r5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywda4puST/lqdwUNJN90zMENF8zF/bEve6Eu8KuFDFNJerBoeZB
	Zi14vGcNsVXa+g9tASLpqoP1k2SMRFMvO8txx1BZC2RFyP63+i7r5KdUEmDxAMo=
X-Gm-Gg: ASbGnctUITrJe75tEXPVRxrdJmlIouKK53Ymb0HqEOFBuHby4AScnkBi+fiyJczr0Eq
	GD0ph5xqVg1QXf2armvpNrkTQAVL7sODMm4B2l3lN5HKqHCqerSiYUDZz+u4JYGLMckwu/3R6cJ
	50VZ0WvJbkt89NhsLwxDlLDtmqD35Vu7sOgC0OQDuSIKrJ40ThsAtIdAuHf7GPjyREx90N737f6
	cvrIjn5kCemEokmpv9Kd8kHyvfctM9EIYCZlQz3/Ab6pHZsdmGLSAVhazJWyw==
X-Google-Smtp-Source: AGHT+IE7MknB8pX7AdlxBQQIKts5X/3H6kMfLnh3CI0RTLZmuygPNpxtEUif60oFdFgb7uUDBu/ing==
X-Received: by 2002:a05:6402:4416:b0:5d0:d3eb:a78f with SMTP id 4fb4d7f45d1cf-5db7d0eca61mr44380903a12.0.1737469121933;
        Tue, 21 Jan 2025 06:18:41 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5ba0:d60::38a:3e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db750293aesm7132668a12.71.2025.01.21.06.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:18:40 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v8 2/5] bpf: fix wrong copied_seq calculation
In-Reply-To: <20250121050707.55523-3-mrpre@163.com> (Jiayuan Chen's message of
	"Tue, 21 Jan 2025 13:07:04 +0800")
References: <20250121050707.55523-1-mrpre@163.com>
	<20250121050707.55523-3-mrpre@163.com>
Date: Tue, 21 Jan 2025 15:18:38 +0100
Message-ID: <875xm8i729.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 01:07 PM +08, Jiayuan Chen wrote:
> 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
> action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> the update logic for 'sk->copied_seq' was moved to
> tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
>
> It works for a single stream_verdict scenario, as it also modified
> 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
> to remove updating 'sk->copied_seq'.
>
> However, for programs where both stream_parser and stream_verdict are
> active(strparser purpose), tcp_read_sock() was used instead of

Nit: missing space, "active (strparser purpose)"
            ^

> tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)

Nit: missing period, "=E2=80=A6 (sk_data_ready->strp_data_ready->tcp_read_s=
ock)."
                                                                       ^

> tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated

Nit: grammar "still updates"
                          ^
Please run commit descriptions through a language tool or an LLM, if
possible. This makes reviewing easier.

> updates.
>
> In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
> in both tcp_read_sock() and tcp_bpf_recvmsg_parser().
>
> The issue causes incorrect copied_seq calculations, which prevent
> correct data reads from the recv() interface in user-land.
>
> We do not want to add new proto_ops to implement a new version of
> tcp_read_sock, as this would introduce code complexity [1].
>
> We add new callback for strparser for customized read operation.
>
> [1]: https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  include/linux/skmsg.h |  2 ++
>  include/net/tcp.h     |  8 ++++++++
>  net/core/skmsg.c      |  7 +++++++
>  net/ipv4/tcp.c        | 29 ++++++++++++++++++++++++-----
>  net/ipv4/tcp_bpf.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 83 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 2cbe0c22a32f..0b9095a281b8 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -91,6 +91,8 @@ struct sk_psock {
>  	struct sk_psock_progs		progs;
>  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>  	struct strparser		strp;
> +	u32				copied_seq;
> +	u32				ingress_bytes;
>  #endif
>  	struct sk_buff_head		ingress_skb;
>  	struct list_head		ingress_msg;
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index e9b37b76e894..06affc653247 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -729,6 +729,9 @@ void tcp_get_info(struct sock *, struct tcp_info *);
>  /* Read 'sendfile()'-style from a TCP socket */
>  int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  		  sk_read_actor_t recv_actor);
> +int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
> +			sk_read_actor_t recv_actor, bool noack,
> +			u32 *copied_seq);
>  int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
>  struct sk_buff *tcp_recv_skb(struct sock *sk, u32 seq, u32 *off);
>  void tcp_read_done(struct sock *sk, size_t len);
> @@ -2599,6 +2602,11 @@ struct sk_psock;
>  #ifdef CONFIG_BPF_SYSCALL
>  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r=
estore);
>  void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
> +#ifdef CONFIG_BPF_STREAM_PARSER
> +struct strparser;
> +int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *de=
sc,
> +			   sk_read_actor_t recv_actor);
> +#endif /* CONFIG_BPF_STREAM_PARSER */
>  #endif /* CONFIG_BPF_SYSCALL */
>=20=20
>  #ifdef CONFIG_INET
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 61f3f3d4e528..0ddc4c718833 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -549,6 +549,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buf=
f *skb,
>  			return num_sge;
>  	}
>=20=20
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +	psock->ingress_bytes +=3D len;
> +#endif
>  	copied =3D len;
>  	msg->sg.start =3D 0;
>  	msg->sg.size =3D copied;
> @@ -1144,6 +1147,10 @@ int sk_psock_init_strp(struct sock *sk, struct sk_=
psock *psock)
>  	if (!ret)
>  		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
>=20=20
> +	if (sk_is_tcp(sk)) {
> +		psock->strp.cb.read_sock =3D tcp_bpf_strp_read_sock;
> +		psock->copied_seq =3D tcp_sk(sk)->copied_seq;
> +	}
>  	return ret;
>  }
>=20=20
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6c41..285678d8ce07 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1565,12 +1565,13 @@ EXPORT_SYMBOL(tcp_recv_skb);
>   *	  or for 'peeking' the socket using this routine
>   *	  (although both would be easy to implement).
>   */
> -int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> -		  sk_read_actor_t recv_actor)
> +static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			   sk_read_actor_t recv_actor, bool noack,
> +			   u32 *copied_seq)
>  {
>  	struct sk_buff *skb;
>  	struct tcp_sock *tp =3D tcp_sk(sk);
> -	u32 seq =3D tp->copied_seq;
> +	u32 seq =3D *copied_seq;
>  	u32 offset;
>  	int copied =3D 0;
>=20=20
> @@ -1624,9 +1625,12 @@ int tcp_read_sock(struct sock *sk, read_descriptor=
_t *desc,
>  		tcp_eat_recv_skb(sk, skb);
>  		if (!desc->count)
>  			break;
> -		WRITE_ONCE(tp->copied_seq, seq);
> +		WRITE_ONCE(*copied_seq, seq);
>  	}
> -	WRITE_ONCE(tp->copied_seq, seq);
> +	WRITE_ONCE(*copied_seq, seq);
> +
> +	if (noack)
> +		goto out;
>=20=20
>  	tcp_rcv_space_adjust(sk);
>=20=20
> @@ -1635,10 +1639,25 @@ int tcp_read_sock(struct sock *sk, read_descripto=
r_t *desc,
>  		tcp_recv_skb(sk, seq, &offset);
>  		tcp_cleanup_rbuf(sk, copied);
>  	}
> +out:
>  	return copied;
>  }
> +
> +int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +		  sk_read_actor_t recv_actor)
> +{
> +	return __tcp_read_sock(sk, desc, recv_actor, false,
> +			       &tcp_sk(sk)->copied_seq);
> +}
>  EXPORT_SYMBOL(tcp_read_sock);
>=20=20
> +int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
> +			sk_read_actor_t recv_actor, bool noack,
> +			u32 *copied_seq)
> +{
> +	return __tcp_read_sock(sk, desc, recv_actor, noack, copied_seq);
> +}
> +
>  int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  {
>  	struct sk_buff *skb;
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 47f65b1b70ca..4dcf88ad8275 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -646,6 +646,48 @@ static int tcp_bpf_assert_proto_ops(struct proto *op=
s)
>  	       ops->sendmsg  =3D=3D tcp_sendmsg ? 0 : -ENOTSUPP;
>  }
>=20=20
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *de=
sc,
> +			   sk_read_actor_t recv_actor)
> +{
> +	struct sock *sk =3D strp->sk;
> +	struct sk_psock *psock;
> +	struct tcp_sock *tp;
> +	int copied =3D 0;
> +
> +	tp =3D tcp_sk(sk);
> +	rcu_read_lock();
> +	psock =3D sk_psock(sk);
> +	if (WARN_ON(!psock)) {

WARN_ON_ONCE, please. We don't want to flood dmesg.

> +		desc->error =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	psock->ingress_bytes =3D 0;
> +	/* We could easily add copied_seq and noack into desc then call
> +	 * ops->read_sock without calling symbol directly. But unfortunately
> +	 * most descriptors used by other modules are not inited with zero.
> +	 * Also it not work by replacing ops->read_sock without introducing
> +	 * new ops as ops itself is located in rodata segment.
> +	 */

Above commment explains an implementation decision and belongs in the
patch description, not in the code. It does not help with understanding
the code itself.

> +	copied =3D tcp_read_sock_noack(sk, desc, recv_actor, true,
> +				     &psock->copied_seq);
> +	if (copied < 0)
> +		goto out;
> +	/* recv_actor may redirect skb to another socket(SK_REDIRECT) or

Nit: missing space, "socket (SK_REDIRECT)"

> +	 * just put skb into ingress queue of current socket(SK_PASS).

Nit: missing space, "socket (SK_PASS)"

> +	 * For SK_REDIRECT, we need 'ack' the frame immediately but for

Nit: grammar, "we need to"
Nit: style, "to ack" is an accepted form of "to acknowlege", no need for
quotes around it.

> +	 * SK_PASS, the 'ack' was delay to tcp_bpf_recvmsg_parser()

Nit: grammar, "we want to delay the ack until tcp_bpf_recvmsg_parser()"

> +	 */
> +	tp->copied_seq =3D psock->copied_seq - psock->ingress_bytes;
> +	tcp_rcv_space_adjust(sk);
> +	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
> +out:
> +	rcu_read_unlock();
> +	return copied;
> +}
> +#endif /* CONFIG_BPF_STREAM_PARSER */
> +
>  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r=
estore)
>  {
>  	int family =3D sk->sk_family =3D=3D AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_I=
PV4;

