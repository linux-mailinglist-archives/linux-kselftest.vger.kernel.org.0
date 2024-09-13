Return-Path: <linux-kselftest+bounces-17955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 194429787BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 20:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15B0280EE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 18:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD0512D1F1;
	Fri, 13 Sep 2024 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NHAVNtU2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D012C473
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251865; cv=none; b=Qut/dWWZTZ44Gx0fnfRcjxS6UnXMoCNBlZ0M00PfUV8SAHe9dH23yV3Cy8xqRZ+6JkKTOG5+7PHiaZnpSb/4VVuvxqrTA9JwWXSHxc1fNwnEIfjFs2qK0+Y+h1XXgy0637I/npvJ/cGmAk1mttHGgCtnWwrWj5txnWlnUQO6Gp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251865; c=relaxed/simple;
	bh=FMnCn4o2qdaSUXi73ndLZFMOMrjiifMev7x7oJtFz8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpTOuoa2Qautwuk8fNqnh+0NyIFPhXUEoe5ubmy/jvNa0BOKp+eNPuA/3YEPrl33BNk7ydEBr90SnMxSBk60uT/TCrojIIGVqpc9hTAdHSS+bnIeuPQ2D4pEygvhBTN4u5Q38CU6pn0ibFuJwgEkHsL6lL/ywJmN3uwxluiJy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NHAVNtU2; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d17da5b6-6273-4c2c-abd7-99378723866e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726251861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STET5AXaIIGQswDEEBI7EGCg3LCwzAn8DRb4QZJG3wQ=;
	b=NHAVNtU2cEONxvAu5BGBDbSFgBqCccPGRmQmvrLsgOs+A5Y6y+mOVEcHed8JXsQMwAlnzo
	Fx1QOCna/Rmoh6YMKAt9XOlXOML0A1aj9hMU4nMbomT7DJR6V7Tj+J5EKWTaNeRYpm14pB
	7Wzjx/uoB51Yp0VvQ297kU+shUjruG0=
Date: Fri, 13 Sep 2024 11:24:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/3] ipv6: Run a reverse sk_lookup on sendmsg.
To: Tiago Lam <tiagolam@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 kernel-team@cloudflare.com
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/13/24 2:39 AM, Tiago Lam wrote:
> This follows the same rationale provided for the ipv4 counterpart, where
> it now runs a reverse socket lookup when source addresses and/or ports
> are changed, on sendmsg, to check whether egress traffic should be
> allowed to go through or not.
> 
> As with ipv4, the ipv6 sendmsg path is also extended here to support the
> IPV6_ORIGDSTADDR ancilliary message to be able to specify a source
> address/port.
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> ---
>   net/ipv6/datagram.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   net/ipv6/udp.c      |  8 ++++--
>   2 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index fff78496803d..4214dda1c320 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -756,6 +756,27 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
>   }
>   EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
>   
> +static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
> +				     struct in6_addr *saddr, __be16 sport)
> +{
> +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> +	    (saddr && sport) &&
> +	    (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) || inet_sk(sk)->inet_sport != sport)) {
> +		struct sock *sk_egress;
> +
> +		bpf_sk_lookup_run_v6(sock_net(sk), IPPROTO_UDP, &fl6->daddr, fl6->fl6_dport,
> +				     saddr, ntohs(sport), 0, &sk_egress);

iirc, in the ingress path, the sk could also be selected by a tc bpf prog doing 
bpf_sk_assign. Then this re-run on sk_lookup may give an incorrect result?

In general, is it necessary to rerun any bpf prog if the user space has 
specified the IP[v6]_ORIGDSTADDR.

> +		if (!IS_ERR_OR_NULL(sk_egress) &&
> +		    atomic64_read(&sk_egress->sk_cookie) == atomic64_read(&sk->sk_cookie))
> +			return true;
> +
> +		net_info_ratelimited("No reverse socket lookup match for local addr %pI6:%d remote addr %pI6:%d\n",
> +				     &saddr, ntohs(sport), &fl6->daddr, ntohs(fl6->fl6_dport));
> +	}
> +
> +	return false;
> +}
> +
>   int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>   			  struct msghdr *msg, struct flowi6 *fl6,
>   			  struct ipcm6_cookie *ipc6)
> @@ -844,7 +865,62 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>   
>   			break;
>   		    }
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
> +			/* If we're egressing with a different source address and/or port, we
> +			 * perform a reverse socket lookup.  The rationale behind this is that we
> +			 * can allow return UDP traffic that has ingressed through sk_lookup to
> +			 * also egress correctly. In case the reverse lookup fails, we
> +			 * continue with the normal path.
> +			 *
> +			 * The lookup is performed if either source address and/or port changed, and
> +			 * neither is "0".
> +			 */
> +			if (reverse_sk_lookup(fl6, sk, &sockaddr_in->sin6_addr,
> +					      sockaddr_in->sin6_port)) {
> +				/* Override the source port and address to use with the one we
> +				 * got in cmsg and bail early.
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
>   		case IPV6_FLOWINFO:
>   			if (cmsg->cmsg_len < CMSG_LEN(4)) {
>   				err = -EINVAL;
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 6602a2e9cdb5..6121cbb71ad3 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1476,6 +1476,12 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>   
>   	fl6->flowi6_uid = sk->sk_uid;
>   
> +	/* We use fl6's daddr and fl6_sport in the reverse sk_lookup done
> +	 * within ip6_datagram_send_ctl() now.
> +	 */
> +	fl6->daddr = *daddr;
> +	fl6->fl6_sport = inet->inet_sport;
> +
>   	if (msg->msg_controllen) {
>   		opt = &opt_space;
>   		memset(opt, 0, sizeof(struct ipv6_txoptions));
> @@ -1511,10 +1517,8 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>   
>   	fl6->flowi6_proto = sk->sk_protocol;
>   	fl6->flowi6_mark = ipc6.sockc.mark;
> -	fl6->daddr = *daddr;
>   	if (ipv6_addr_any(&fl6->saddr) && !ipv6_addr_any(&np->saddr))
>   		fl6->saddr = np->saddr;
> -	fl6->fl6_sport = inet->inet_sport;
>   
>   	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
>   		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
> 


