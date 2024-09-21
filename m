Return-Path: <linux-kselftest+bounces-18191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A659397DC55
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 11:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3931F21EAB
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6B815573F;
	Sat, 21 Sep 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7SIN0Nq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F413C9C4;
	Sat, 21 Sep 2024 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726910022; cv=none; b=Sc9o1tgiczRZTv4erkBkrQEV78lsGyyimeHRSChLXWr9ozInewulfAmxIU1KIcNRvQm8gVSjd5wIgwelXz8U9yKdRXTU4pT8msv1OU2i8getD4w+gjoUdjEB7A85c++zdpnrKsVZV5J+V9aMi4xD/UDlqvoaBb+zxWkV7V1Z4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726910022; c=relaxed/simple;
	bh=0lKnfMrh40S/BdEY1w2XE167YH6Wt7ukklJf59v95fU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DqIyIkgNFS3aFHy/7ckwU62lViYmJQko7RNTG8WWeoRyR9rgQTDVyzyQHRgMcXYtqGRJsZgtQgKNrtEOu3HUHQJF489j2VgU7hUTJAUOXEvHpyddEi9lGWHQ5Y+rnzUfawcuVFru0bu0Dxmkqb1LzIbW53gJQOjPRuLazH9tf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7SIN0Nq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c524b4f8b9so24185106d6.3;
        Sat, 21 Sep 2024 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726910020; x=1727514820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZAjg/ZpbipRoqw7eaS6np9oufeeMoV+12K+DbXxSII=;
        b=W7SIN0NqmwyT+5x5TeiGoKcy4m8NSOO0s8iRqKTrW7oSwXS3Xh077OSVxnddYqQskA
         yWJJaEbzIdJrPTfhocHL9ftwkpc5cF+Yl01Sye/z15GV1zsWdhvg5Jcf33bdZioLPinO
         ObvclFmbFxMpEWzTr6Az3M9UHTgLlMYzGlgQ3uV5c169gvJpmidtJYNEYey9iHYLpvur
         ecq2VmyxSynhm7In5p16CnGjUbOTcYvGyBxOfj5A8xdofPBem64Hmwe81eOZW1wksvxf
         gWUFdG7psUiyk4wqV/suewNMTkRwUQ27Hc8a6FMOuPDhUSdfBVb8YgTZP2p2cAR3aPBN
         mkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726910020; x=1727514820;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iZAjg/ZpbipRoqw7eaS6np9oufeeMoV+12K+DbXxSII=;
        b=LdN+9gxFF8J1e9DszYvsZK/y7bEDctHlN9sXxYgLwam9dPDE2TzyNA6UZuJNKgJo/q
         1uccIkP/lgrEVmWTOCn1kMNpt+NRbs+R5IeNkaJLh3UQrs4n2qsvER4bTjXTvPxMBXeT
         y6SQKS32NsbATgRoqWe/k6/1WFTAa8vDYxDknhuorUGS2T2HV1PANkeugIcFL8HilGvD
         WR7/zQFMW1OvUh/xWIkpBSZN+itvZt8RcXOB8yZD3jT8BreD+nnOwxKMTpUB78QKSv5l
         mZc4u+XpAh1CjCq7OX+bcdn46dMlKQNClRgsSDq4/tafMIZP/Dlod+A+Sqg83GZ6A+g2
         UG3g==
X-Forwarded-Encrypted: i=1; AJvYcCURdhOhmSx0G1vnTV/6sFTPOMHDN6hy04dCljy3pnEG7FCRfcUctDH8bciqg1Qz6TxEJfzRFhUnTUOEQu2r@vger.kernel.org, AJvYcCWgm8+hVRwcxcJac3SaoA9dccFc01qmKiOJ5TzjWkG766IYw+70FsrVc/M8KIvIXDceoB9xWwMJKXOF2apWhCNf@vger.kernel.org, AJvYcCX4irzkoZq9XBzQ2HvHDT27P2tiq1uDxX6/9j17zQng05v41gPINa/VyzqzbUihdq5yNVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQYsHjd7D2lD38lG9PECKMtpcnRifQWGP6yyQZDJa+ZYfuGyB
	H+Zf8YfqczkwUHz0Jdvc5nJ3ucdubYAnAA6IKC9gdkT9K5RTq02s
X-Google-Smtp-Source: AGHT+IGFwgh51uMZmQBeufabPqToSbZ4o/zFM8A/geYfD8AsxK6q+fbUID7WnZk0hlH5aoJi1oK+Vw==
X-Received: by 2002:a05:6214:281:b0:6c7:c034:f732 with SMTP id 6a1803df08f44-6c7c034f749mr58331746d6.21.1726910019659;
        Sat, 21 Sep 2024 02:13:39 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e4614fdsm27001446d6.37.2024.09.21.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 02:13:39 -0700 (PDT)
Date: Sat, 21 Sep 2024 05:13:38 -0400
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
Message-ID: <66ee8e42a8744_35dcb1294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240920-reverse-sk-lookup-v2-2-916a48c47d56@cloudflare.com>
References: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
 <20240920-reverse-sk-lookup-v2-2-916a48c47d56@cloudflare.com>
Subject: Re: [RFC PATCH v2 2/3] ipv6: Support setting src port in sendmsg().
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
> This follows the same rationale provided for the ipv4 counterpart, where
> the sendmsg() path is also extended here to support the IPV6_ORIGDSTADDR
> ancillary message to be able to specify a source address/port. This
> allows users to configure the source address and/or port egress traffic
> should be sent from.
> 
> To limit its usage, a reverse socket lookup is performed to check if the
> configured egress source address and/or port have any ingress sk_lookup
> match. If it does, traffic is allowed to proceed, otherwise it falls
> back to the regular egress path.
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> ---
>  net/ipv6/datagram.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/udp.c      |  8 ++++--
>  2 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index fff78496803d..369c64a478ec 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -756,6 +756,29 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
>  }
>  EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
>  
> +static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
> +				     struct in6_addr *saddr, __be16 sport)
> +{
> +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> +	    (saddr && sport) &&
> +	    (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) ||
> +	    inet_sk(sk)->inet_sport != sport)) {
> +		struct sock *sk_egress;
> +
> +		bpf_sk_lookup_run_v6(sock_net(sk), IPPROTO_UDP, &fl6->daddr,
> +				     fl6->fl6_dport, saddr, ntohs(sport), 0,
> +				     &sk_egress);
> +		if (!IS_ERR_OR_NULL(sk_egress) && sk_egress == sk)
> +			return true;
> +
> +		net_info_ratelimited("No reverse socket lookup match for local addr %pI6:%d remote addr %pI6:%d\n",
> +				     &saddr, ntohs(sport), &fl6->daddr,
> +				     ntohs(fl6->fl6_dport));
> +	}
> +
> +	return false;
> +}
> +
>  int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>  			  struct msghdr *msg, struct flowi6 *fl6,
>  			  struct ipcm6_cookie *ipc6)
> @@ -844,7 +867,63 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>  
>  			break;
>  		    }
> +		case IPV6_ORIGDSTADDR:
> +			{
> +			struct sockaddr_in6 *sockaddr_in;
> +			struct net_device *dev = NULL;
> +
> +			if (cmsg->cmsg_len < CMSG_LEN(sizeof(struct sockaddr_in6))) {
> +				err = -EINVAL;
> +				goto exit_f;
> +			}
> +
> +			sockaddr_in = (struct sockaddr_in6 *)CMSG_DATA(cmsg);
> +
> +			addr_type = __ipv6_addr_type(&sockaddr_in->sin6_addr);
> +
> +			if (addr_type & IPV6_ADDR_LINKLOCAL)
> +				return -EINVAL;
> +
> +			/* If we're egressing with a different source address
> +			 * and/or port, we perform a reverse socket lookup. The
> +			 * rationale behind this is that we can allow return
> +			 * UDP traffic that has ingressed through sk_lookup to
> +			 * also egress correctly. In case the reverse lookup
> +			 * fails, we continue with the normal path.
> +			 *
> +			 * The lookup is performed if either source address
> +			 * and/or port changed, and neither is "0".
> +			 */
> +			if (reverse_sk_lookup(fl6, sk, &sockaddr_in->sin6_addr,
> +					      sockaddr_in->sin6_port)) {
> +				/* Override the source port and address to use
> +				 * with the one we got in cmsg and bail early.
> +				 */
> +				fl6->saddr = sockaddr_in->sin6_addr;
> +				fl6->fl6_sport = sockaddr_in->sin6_port;
> +				break;
> +			}
>  
> +			if (addr_type != IPV6_ADDR_ANY) {
> +				int strict = __ipv6_addr_src_scope(addr_type) <= IPV6_ADDR_SCOPE_LINKLOCAL;
> +
> +				if (!ipv6_can_nonlocal_bind(net, inet_sk(sk)) &&
> +				    !ipv6_chk_addr_and_flags(net,
> +							     &sockaddr_in->sin6_addr,
> +							     dev, !strict, 0,
> +							     IFA_F_TENTATIVE) &&
> +				    !ipv6_chk_acast_addr_src(net, dev,
> +							     &sockaddr_in->sin6_addr))
> +					err = -EINVAL;
> +				else
> +					fl6->saddr = sockaddr_in->sin6_addr;
> +			}
> +
> +			if (err)
> +				goto exit_f;
> +
> +			break;
> +			}

How come IPv6 runs the check in the cmsg handler, but ipv4 in sendmsg
directly? Can the two be symmetric?

>  		case IPV6_FLOWINFO:
>  			if (cmsg->cmsg_len < CMSG_LEN(4)) {
>  				err = -EINVAL;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 6602a2e9cdb5..6121cbb71ad3 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1476,6 +1476,12 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  
>  	fl6->flowi6_uid = sk->sk_uid;
>  
> +	/* We use fl6's daddr and fl6_sport in the reverse sk_lookup done
> +	 * within ip6_datagram_send_ctl() now.
> +	 */
> +	fl6->daddr = *daddr;
> +	fl6->fl6_sport = inet->inet_sport;
> +
>  	if (msg->msg_controllen) {
>  		opt = &opt_space;
>  		memset(opt, 0, sizeof(struct ipv6_txoptions));
> @@ -1511,10 +1517,8 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  
>  	fl6->flowi6_proto = sk->sk_protocol;
>  	fl6->flowi6_mark = ipc6.sockc.mark;
> -	fl6->daddr = *daddr;
>  	if (ipv6_addr_any(&fl6->saddr) && !ipv6_addr_any(&np->saddr))
>  		fl6->saddr = np->saddr;
> -	fl6->fl6_sport = inet->inet_sport;
>  
>  	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
>  		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
> 
> -- 
> 2.34.1
> 



