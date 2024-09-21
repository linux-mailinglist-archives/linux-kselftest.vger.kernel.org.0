Return-Path: <linux-kselftest+bounces-18190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3AF97DC4F
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 11:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FE2B213EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 09:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377B8155346;
	Sat, 21 Sep 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQT6FECH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C61547DA;
	Sat, 21 Sep 2024 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726909927; cv=none; b=mTYES+6w/r5y6X3ccSfibrHYfEZXYBdXYnj90Hvf+LBz7UsCSwmiSENhI1N+F8ZM/tmoeGn9wZMKgWGW+RXQYZozoKmJ2Ur4hdS7muPxrU5Bzwyby4/oDvC05Xalg9UbrHi6S4AXkTaQOLso36AhrypFv9rI1tvt/rjt6/cv60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726909927; c=relaxed/simple;
	bh=G3H3dPYs7/6wDtQJ/JomZfKzndEqe3gBsLvsqtm9Svk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=l1Ou1VzqDbqoqahok/gbSLKS8Xnva8mReFp0h03ombUFWwKxjMeVVJsXC4hattaen6C3ns/p317E1aHM1FUbycIpnKhWFScLEv2lWi0HUQN4255TDUkVciVnHF8/aH8ovEQodC0ThQ04Sevp1Q9pAwU8uL+B5x/zU7qJHbAvLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQT6FECH; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a9a3071c6bso303299985a.0;
        Sat, 21 Sep 2024 02:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726909924; x=1727514724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PDcHztsDaQH8FBKuDStHGP3jXVpjw/pamxhwccv5Js=;
        b=BQT6FECHEfE8NEbRt/G57V0bRtcUtFGXudXewMK6m5L03RwLiVYHc9H+Vojt29t8v3
         gQaYS/YwUh1VYQq+4dLvJNAJyIs1+ifQZxX8XQkWbkfFnUb8jJtyb+IGFRamOaR+2YAp
         lcOlsS7k3BRqRvMkV93W129VcaOfLhs7JNdU3RGiO7kKnqkezv5T3GhzwgjtMJGixN6v
         G4rCUu404BlKbfyq8EzyrY/J/htUMpTtrCxMCorUpZiY/Sf2wecT00/VVk9b17P1Iudp
         3iVcAMEno5jzVrwwzgj6B7OReZwEBfwVBfn8oglkxVB10V4sBnonC2722G6dyGr+G+Kk
         lAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726909924; x=1727514724;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5PDcHztsDaQH8FBKuDStHGP3jXVpjw/pamxhwccv5Js=;
        b=DR6n9C7prmZEnQLPtggxvboZn4Gdl5PcTYdfxvY8Car1UApibZRVdFz2RZZfWmq3nu
         C5UY+NtumzjcYLlNRqbxM0FfRUM8itF7EK6olvKz2rrcyKdtfVTX0T69Lm1eq6OvxDFm
         CJVEIhXIfoh4PSTl4ibM3YOAKmWia6QBLfF5cPbnFq4pHCDeqfsPuEkmNZTMslInf3hY
         Ro5yg91gzYbf4xJvwZmcq3gcv8MEdLUSxKbeo1/rEWJsquaCRC8KoUvTJyREZedoVAS2
         WQWrSrS7fOeZW1Sv6N5kJKSaXP16TW5ESVSV/7AuBILE3r24jGeQ5HRiWb0YF6OOAo8I
         uEkg==
X-Forwarded-Encrypted: i=1; AJvYcCVPpH+TSLIPYL0o1MkGEucTgXKHUeemT6c2QVYbST/6+T1z4iPHOZD2wCl2zKdZNEW48RgNxFGSnijBoyoD@vger.kernel.org, AJvYcCWHWH0OxdXbNo9qq7MJ8xrX/TyJk9ZqCd+f3g8YM8mqmXP7jz7T4cfro0QxJfRTROrdMn0=@vger.kernel.org, AJvYcCXECcbYJwdeRU5fVO0SxOzVwZ0tSfkijCD69xakKDVF54FYuxted+hvP88HdgGUFIWY23VNU4cNwZe9CvpO5UMm@vger.kernel.org
X-Gm-Message-State: AOJu0YwTX4QxuQ3k6cHIDTRsIk/uGZ5fABLjU+VrLHdptQId6bqYtQtP
	A+vUku4agds8TYhRS71XvgWZ3To5cvgIWqwobqJEOLl7BDf5tan0
X-Google-Smtp-Source: AGHT+IFUQy1APIQIr5gSyWu6ctvQJnMpKODFF0V3e4keVJiWRWUZV7nGoZkyagZiqJeyCWkPptVK6g==
X-Received: by 2002:a05:620a:4488:b0:79f:148:db04 with SMTP id af79cd13be357-7acb82065acmr848702585a.45.1726909924254;
        Sat, 21 Sep 2024 02:12:04 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb082a557sm271387485a.71.2024.09.21.02.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 02:12:03 -0700 (PDT)
Date: Sat, 21 Sep 2024 05:12:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tiago Lam <tiagolam@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Tiago Lam <tiagolam@cloudflare.com>, 
 kernel-team@cloudflare.com
Message-ID: <66ee8de2744e9_35dcb129411@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240920-reverse-sk-lookup-v2-1-916a48c47d56@cloudflare.com>
References: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
 <20240920-reverse-sk-lookup-v2-1-916a48c47d56@cloudflare.com>
Subject: Re: [RFC PATCH v2 1/3] ipv4: Support setting src port in sendmsg().
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tiago Lam wrote:
> sendmsg() doesn't currently allow users to set the src port from which
> egress traffic should be sent from. This is possible if a user wants to
> configure the src address from which egress traffic should be sent from
> - with the IP_PKTINFO ancillary message, a user is currently able to
>   specify a source address to egress from when calling sendmsg().
> However, this still requires the user to set the IP_TRANSPARENT flag
> using setsockopt(), which happens to require special privileges in the
> case of IPv4.
> 
> To support users setting the src port for egress traffic when using
> sendmsg(), this patch extends the ancillary messages supported by
> sendmsg() to support the IP_ORIGDSTADDR ancillary message, reusing the
> same cmsg and struct used in recvmsg() - which already supports
> specifying a port.
> 
> Additionally, to avoid having to have special configurations, such as
> IP_TRANSPARENT, this patch allows egress traffic that's been configured
> using (the newly added) IP_ORIGDSTADDR to proceed if there's an ingress
> socket lookup (sk_lookup) that matches that traffic - by performing a
> reserve sk_lookup. Thus, if the sk_lookup reverse call returns a socket
> that matches the egress socket, we also let the egress traffic through -
> following the principle of, allowing return traffic to proceed if
> ingress traffic is allowed in. In case no match is found in the reverse
> sk_lookup, traffic falls back to the regular egress path.
> 
> This reverse lookup is only performed in case an sk_lookup ebpf program
> is attached and the source address and/or port for the return traffic
> have been modified using the (newly added) IP_ORIGDSTADDR in sendmsg.
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> ---
>  include/net/ip.h       |  1 +
>  net/ipv4/ip_sockglue.c | 11 +++++++++++
>  net/ipv4/udp.c         | 35 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/ip.h b/include/net/ip.h
> index c5606cadb1a5..e5753abd7247 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -75,6 +75,7 @@ static inline unsigned int ip_hdrlen(const struct sk_buff *skb)
>  struct ipcm_cookie {
>  	struct sockcm_cookie	sockc;
>  	__be32			addr;
> +	__be16			port;
>  	int			oif;
>  	struct ip_options_rcu	*opt;
>  	__u8			protocol;
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index cf377377b52d..6e55bd25b5f7 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -297,6 +297,17 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
>  			ipc->addr = info->ipi_spec_dst.s_addr;
>  			break;
>  		}
> +		case IP_ORIGDSTADDR:

Should this just be IP_SRCADDR?

> +		{
> +			struct sockaddr_in *dst_addr;
> +
> +			if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct sockaddr_in)))
> +				return -EINVAL;
> +			dst_addr = (struct sockaddr_in *)CMSG_DATA(cmsg);
> +			ipc->port = dst_addr->sin_port;
> +			ipc->addr = dst_addr->sin_addr.s_addr;
> +			break;
> +		}
>  		case IP_TTL:
>  			if (cmsg->cmsg_len != CMSG_LEN(sizeof(int)))
>  				return -EINVAL;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 49c622e743e8..208cee40c0ec 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1060,6 +1060,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
>  	struct flowi4 fl4_stack;
>  	struct flowi4 *fl4;
> +	__u8 flow_flags = inet_sk_flowi_flags(sk);
>  	int ulen = len;
>  	struct ipcm_cookie ipc;
>  	struct rtable *rt = NULL;
> @@ -1179,6 +1180,39 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  		}
>  	}
>  
> +	/* If we're egressing with a different source address and/or port, we
> +	 * perform a reverse socket lookup.  The rationale behind this is that
> +	 * we can allow return UDP traffic that has ingressed through sk_lookup
> +	 * to also egress correctly. In case this the reverse lookup fails.
> +	 *
> +	 * The lookup is performed if either source address and/or port
> +	 * changed, and neither is "0".
> +	 */
> +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> +	    !connected &&
> +	    (ipc.port && ipc.addr) &&
> +	    (inet->inet_saddr != ipc.addr || inet->inet_sport != ipc.port)) {
> +		struct sock *sk_egress;
> +
> +		bpf_sk_lookup_run_v4(sock_net(sk), IPPROTO_UDP,
> +				     daddr, dport, ipc.addr, ntohs(ipc.port),
> +				     1, &sk_egress);

Does this need to use a bpf helper rather than a normal route lookup
function?

I don't know this func, but the sk is returned without a reference
taken?

> +		if (IS_ERR_OR_NULL(sk_egress) || sk_egress != sk) {
> +			net_info_ratelimited("No reverse socket lookup match for local addr %pI4:%d remote addr %pI4:%d\n",
> +					     &ipc.addr, ntohs(ipc.port), &daddr,
> +					     ntohs(dport));

No need for logging to the kernel log when syscalls can just return an
error.

> +		} else {
> +			/* Override the source port to use with the one we got
> +			 * in cmsg, and tell routing to let us use a non-local
> +			 * address. Otherwise route lookups will fail with
> +			 * non-local source address when IP_TRANSPARENT isn't
> +			 * set.
> +			 */
> +			inet->inet_sport = ipc.port;
> +			flow_flags |= FLOWI_FLAG_ANYSRC;
> +		}
> +	}
> +
>  	saddr = ipc.addr;
>  	ipc.addr = faddr = daddr;
>  
> @@ -1223,7 +1257,6 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  
>  	if (!rt) {
>  		struct net *net = sock_net(sk);
> -		__u8 flow_flags = inet_sk_flowi_flags(sk);
>  
>  		fl4 = &fl4_stack;
>  
> 
> -- 
> 2.34.1
> 



