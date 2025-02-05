Return-Path: <linux-kselftest+bounces-25823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4981A28A26
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C48D16937D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A7722C358;
	Wed,  5 Feb 2025 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKUH+syv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B822B8B7;
	Wed,  5 Feb 2025 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738758031; cv=none; b=ToxYXqeExQp2Xa02gPkI03TCR6lM41Y1/PG7cYRCFAARtQHnAlQ9dqquBWzbAairpoC3YRvfaPdWg4UCVNv8hL9tjPXwSU1J65uf1zB5Dcc2WRttJOLNXOm+RsR2Lbh4ZoP/G0GjOnJmcHYMV5Es8tajyQxcOGUTWuOjbddvfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738758031; c=relaxed/simple;
	bh=mliisTJtC4/x2He8n/YtxnJipD2aoHXMhReWhBlgrO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ob8meXJ60l2i5EGERqoajiPWFoS1huaMzAF3SNi532zbgOVN376gwyR0lKPHHEnPIN317itr/D/WKxiXLkqnF20jMuBVnOTJ3cnDQ7uGEJLVj/0aWfTkLGitaj//vm1tnaKjE97XMdpLqflgXEc6vWyfHd1IsT3gyc9zbd4oa4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKUH+syv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361c705434so49676545e9.3;
        Wed, 05 Feb 2025 04:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738758028; x=1739362828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6UxSbzx0mqyS4ecv7b06nR9TIVmkjaPNaX7UQ2Szu4=;
        b=NKUH+syvZhUlzi4N5/ERuDGB32FsyHNPare1iNi8spbuzSreFVwl7ekvj9S+9WYOMk
         2Z2eXdWF/FsHgn9I4/N0OQoylu8JAORQZMnfmuTIxXJ1MLmgQ4v5ly+XRbFgyziD+HhA
         ELRrLUHGqWGxF4vv/JIiECVhcgho/p+nyABKp+zIcY8VhgPP+f98Q9OEzV0ufkD63pr9
         rrIhuSCe/7tq3Ks7R/shKBPOejqWokNjjlb4F+hCeto/7kjiHPDhLzYITbifl21X3+75
         UXq/OBQzFMP8/qEcq2huL82b/FIPKUdpnvyxIaRpY4NJr0VmX+tl4/PY6s/M328XclbP
         8OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738758028; x=1739362828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6UxSbzx0mqyS4ecv7b06nR9TIVmkjaPNaX7UQ2Szu4=;
        b=Z3Wvf5rPvEGKB8wFzCGCty3kyFHFr1ugpt+r6mxE7Go3QH5WYmDlCVNSauz0bRp6xE
         FrQfeWGLChSY3gQKQ0L+Ajiy7OoW2e2YR1hWY8nNVHyaicsihLHRh736Y6lPkoL+SYVc
         1iKK5ozeq8zcQwEJUsnntmixRy2CFlYNXG3dMRl6xqL2d98pnAGVJC0Xg8QCzgbtMmYp
         rT5EDfFsmsnj1kiH7Z055XQJIQSnm4d8eX+2VtXLiRnxWMUJueg8RbUdEJkyOAyJQfKi
         A0RXBkOyR6l5UphkbZP4XtwV4tBUp1FmprQlNNtzL/AE7Yb+wNmTd8kE/ZxueUQBjIJ8
         ucJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnN+J1AHYTgUqs3LoRlpsK9wHQ9haqn7Ip1CbN7slnbwV1rV/UmEWs3u3IJd7E6MU9jZg=@vger.kernel.org, AJvYcCVYGVHMZoTRxzl7wm/TpduhejuyEPaXA07A0o0gGqSyCMmEXPfjRal9uvG+RxpGx+vHLP8+BAjuV/aighVibncL@vger.kernel.org, AJvYcCW+mTAjbjJJTPuV24gBdT2dOj98p2H9vrBQvleW5xDT3aIGSKN0NDeqsEi+DRY38+8/dlJoe0I8mG4k@vger.kernel.org, AJvYcCWj7PvU52Iywjc7Vj/niFskzZE0m/iWE5Nb+rvDOOLCm49U/izV9tHn2MiaLacWh9I78wofCDslAvzDJxiI@vger.kernel.org, AJvYcCXb7yqn4yj5TxyAcbVUwKVLj9rc3rH6ZXTlPjUAVjxM3h2lSsKEfR6SmLx83/VUux6zHosScDoe@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPkXP3S9qyeW3T2vW/K4iM2oxiE9k83wxENOGnFepVKsy/Rqa
	RNKUOe9GZgzu05d/sTFPFaomEw/P4zaTr+Ge/R2JygaFoocpkcxh
X-Gm-Gg: ASbGncs//8KbsHyuE0+rcNQ9OeJYph5YZQWcsYtRrDe6ixe88r2zSvhwXbRwpz4BBqf
	3wz5dkQjciFUPfo9jhAFRgrCrp96pObdEixhguqphL56CnkJOTmnT1ft6oUzQQPRhIcCFHIIfCs
	JM+ognUNf6sSh5Hg2dbvatve1g1cbM2YeadBJp5gVGkx/C0Cyk6OZ6PbErPxuQOBHP2cjq/j2JT
	br6eKl/tcRLU71QZDvTL8V/jDj2cNxDrZ7ZCwf5m4pE1X9QSc5DhUh9E8Cnc/rk8zjSUq4YztWu
	jVBAT1/Cm3nTGRi7QfLlVhw=
X-Google-Smtp-Source: AGHT+IGJDXvIG/7Qnnn/pmmyUc/PCQsFzD0zmP7oGwtUvw9dR3YQPaYZ7+KNbPMVMRYa9yN06wEAdQ==
X-Received: by 2002:a5d:6c6a:0:b0:38c:5bfa:a93b with SMTP id ffacd0b85a97d-38db48a987emr1829547f8f.2.1738758028045;
        Wed, 05 Feb 2025 04:20:28 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1016easm18630336f8f.24.2025.02.05.04.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 04:20:27 -0800 (PST)
Message-ID: <abc22620-d509-4b12-80ac-0c36b08b36d9@gmail.com>
Date: Wed, 5 Feb 2025 12:20:34 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/6] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-6-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250203223916.1064540-6-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/25 22:39, Mina Almasry wrote:
...
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..3ff8f568c382 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1711,9 +1711,12 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
...
>   int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>   				struct iov_iter *from, size_t length);
> @@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>   static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
>   					  struct msghdr *msg, int len)
>   {
> -	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len);
> +	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len,
> +				       NULL);

Instead of propagating it all the way down and carving a new path, why
not reuse the existing infra? You already hook into where ubuf is
allocated, you can stash the binding in there. And
zerocopy_fill_skb_from_devmem can implement ->sg_from_iter,
see __zerocopy_sg_from_iter().

...
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index f0693707aece..c989606ff58d 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -63,6 +63,8 @@
> +static int
> +zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
> +			      int length,
> +			      struct net_devmem_dmabuf_binding *binding)
> +{
> +	int i = skb_shinfo(skb)->nr_frags;
> +	size_t virt_addr, size, off;
> +	struct net_iov *niov;
> +
> +	while (length && iov_iter_count(from)) {
> +		if (i == MAX_SKB_FRAGS)
> +			return -EMSGSIZE;
> +
> +		virt_addr = (size_t)iter_iov_addr(from);

Unless I missed it somewhere it needs to check that the iter
is iovec based.

> +		niov = net_devmem_get_niov_at(binding, virt_addr, &off, &size);
> +		if (!niov)
> +			return -EFAULT;
> +
> +		size = min_t(size_t, size, length);
> +		size = min_t(size_t, size, iter_iov_len(from));
> +
> +		get_netmem(net_iov_to_netmem(niov));
> +		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
> +				       size, PAGE_SIZE);
> +		iov_iter_advance(from, size);
> +		length -= size;
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
>   int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>   			    struct sk_buff *skb, struct iov_iter *from,
> -			    size_t length)
> +			    size_t length,
> +			    struct net_devmem_dmabuf_binding *binding)
>   {
>   	unsigned long orig_size = skb->truesize;
>   	unsigned long truesize;
> @@ -702,6 +737,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>   
>   	if (msg && msg->msg_ubuf && msg->sg_from_iter)
>   		ret = msg->sg_from_iter(skb, from, length);

As mentioned above, you can implement this callback. The callback can
also be moved into ubuf_info ops if that's more convenient, I had
patches stashed for that.

> +	else if (unlikely(binding))
> +		ret = zerocopy_fill_skb_from_devmem(skb, from, length, binding);
>   	else
>   		ret = zerocopy_fill_skb_from_iter(skb, from, length);
>   
> @@ -735,7 +772,7 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
>   	if (skb_copy_datagram_from_iter(skb, 0, from, copy))
>   		return -EFAULT;

...

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6c41..44198ae7e44c 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1051,6 +1051,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
>   
>   int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   {
> +	struct net_devmem_dmabuf_binding *binding = NULL;
>   	struct tcp_sock *tp = tcp_sk(sk);
>   	struct ubuf_info *uarg = NULL;
>   	struct sk_buff *skb;
> @@ -1063,6 +1064,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   
>   	flags = msg->msg_flags;
>   
> +	sockcm_init(&sockc, sk);
> +	if (msg->msg_controllen) {
> +		err = sock_cmsg_send(sk, msg, &sockc);
> +		if (unlikely(err)) {
> +			err = -EINVAL;
> +			goto out_err;
> +		}
> +	}
> +
>   	if ((flags & MSG_ZEROCOPY) && size) {
>   		if (msg->msg_ubuf) {
>   			uarg = msg->msg_ubuf;
> @@ -1080,6 +1090,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   			else
>   				uarg_to_msgzc(uarg)->zerocopy = 0;
>   		}
> +
> +		if (sockc.dmabuf_id != 0) {

It's better to be mutually exclusive with msg->msg_ubuf, the callers
have expectations about the buffers used. And you likely don't want
to mix it with normal MSG_ZEROCOPY in a single skb and/or ubuf_info,
you can force reallocation of ubuf_info here.

> +			binding = net_devmem_get_binding(sk, sockc.dmabuf_id);
> +			if (IS_ERR(binding)) {
> +				err = PTR_ERR(binding);
> +				binding = NULL;
> +				goto out_err;
> +			}
> +		}

-- 
Pavel Begunkov


