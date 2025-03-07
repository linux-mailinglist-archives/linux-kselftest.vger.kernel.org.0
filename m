Return-Path: <linux-kselftest+bounces-28469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A92A56430
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 10:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984ED3A8ADD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266501EDA10;
	Fri,  7 Mar 2025 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Fpv3ofoW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D01E1E04
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741340754; cv=none; b=C4uRGwbubeIzIQbx8T9Q44J1v0N5RHBWItT7qNcQY7fX4GWUIaFUKjEczCPHzq/GqiUV1uPH1qkmYQJ8SACuXPcwBc4OfWvWMQFadNlUq+eD4FGZNVVwAU4mUuwnDVq7UilZ4cpujA7wW7fIkIqNdJ21nn7luPaUa6K05GT2PBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741340754; c=relaxed/simple;
	bh=8BxwcUC03a1oPRZ2pAlv3i2yCxXMrV7cP/jYoHXH/zs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kigRZpEFqV9V8AhF7MGBRjaIbVpGGgiwYZx+no6Q3UOJpG0evaFwtwbar/5clRLr2elkHY7GJOLvifTosqsN62Ied1NOVi9+3tOHjCyZr8UgZMJiI8zBWa9AKup0cSwGF8xWUUNjI/d+0HehsB33ulAHXDoOPggdGGB9TeM/Wqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Fpv3ofoW; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tqUGs-0034iJ-8j; Fri, 07 Mar 2025 10:45:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=8tA/kRSVyx+JyEIR4+usiCzAfmuIpsak7pwQ/jnN35Y=; b=Fpv3ofoWZmCgQnpYPTTrolVu6P
	de8JefFtWeInaxjfUg6dvQf0fUMLHGZAWWioaw1DKq2pRg6rudQT4aJqR9D4nsI3a6I8wPG33XdWB
	8ktI4nOIW40I3Dycgnpt/LHRPDIQceBf4zW8rLy37gvK2Zf3mGEmxZ8axKldzz5/shnBQY3FhrqCa
	xySf0CsXSEEiR3LVnC6gDAo9QTdYg1onBEwRlHQ9wN00pIku4eado38x+zfsxt0Mdw8LPd/eu6hq6
	/IOIurS90GnhKLVxkwwHaesvOfewix+ImcI5Sz82I+c7v3hHOeoWN9TkumkXoCAHDmVoTZm62hlFX
	BQVMGIlg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tqUGq-0003Tb-67; Fri, 07 Mar 2025 10:45:32 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tqUGl-006bBn-4U; Fri, 07 Mar 2025 10:45:27 +0100
Message-ID: <baeca627-e6f1-4d0a-aea5-fa31689edc4d@rbox.co>
Date: Fri, 7 Mar 2025 10:45:25 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf-next v2 1/3] bpf, sockmap: avoid using sk_socket after
 free
To: Jiayuan Chen <jiayuan.chen@linux.dev>, xiyou.wangcong@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, martin.lau@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, sgarzare@redhat.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mrpre@163.com, cong.wang@bytedance.com,
 syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
References: <20250228055106.58071-1-jiayuan.chen@linux.dev>
 <20250228055106.58071-2-jiayuan.chen@linux.dev>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250228055106.58071-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 06:51, Jiayuan Chen wrote:
> ...
>  static void sk_psock_verdict_data_ready(struct sock *sk)
>  {
> -	struct socket *sock = sk->sk_socket;
> +	struct socket *sock;
>  	const struct proto_ops *ops;
>  	int copied;
>  
>  	trace_sk_data_ready(sk);
>  
> +	/* We need RCU to prevent the sk_socket from being released.
> +	 * Especially for Unix sockets, we are currently in the process
> +	 * context and do not have RCU protection.
> +	 */
> +	rcu_read_lock();
> +	sock = sk->sk_socket;
>  	if (unlikely(!sock))
> -		return;
> +		goto unlock;
> +
>  	ops = READ_ONCE(sock->ops);
>  	if (!ops || !ops->read_skb)
> -		return;
> +		goto unlock;
> +
>  	copied = ops->read_skb(sk, sk_psock_verdict_recv);
>  	if (copied >= 0) {
>  		struct sk_psock *psock;
>  
> -		rcu_read_lock();
>  		psock = sk_psock(sk);
>  		if (psock)
>  			sk_psock_data_ready(sk, psock);
> -		rcu_read_unlock();
>  	}
> +unlock:
> +	rcu_read_unlock();
>  }

Hi,

Doesn't sk_psock_handle_skb() (!ingress path) have the same `struct socket`
release race issue? Any plans on fixing that one, too?

BTW, lockdep (CONFIG_LOCKDEP=y) complains about calling AF_UNIX's
read_skb() under RCU read lock.

Thanks,
Michal

