Return-Path: <linux-kselftest+bounces-32164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA514AA70D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 13:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870AB9A0839
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 11:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C4723E34D;
	Fri,  2 May 2025 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFkpBt5A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA321993B7
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746186433; cv=none; b=FhL0sKRKQgZ1lhFeY7cIUSDrXBDrEXrqCcy+q0HTVKzwDTO3XKq8JkcNe2a7qRDX289yXoLSP+BDJ2J2y3SVzZj+HNcgHM4JrZLNcxdxdw30vXD7eiZVDmMgf9A1+AW9EEgcUNZ5JNlHUzDWX5wkD98vio9zeOQOzRq7vF1/vJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746186433; c=relaxed/simple;
	bh=cB2cxb192pgUkDCF/6JRnHqrlQVpXJEBsmB29jSR3dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQVyBS9fGintQMRpri2BeAUGC84I6Dbri+9MuGGGXRcZ591R/M31ltdIm5lq/3WI3OaobRi3PoDHKyVMnS1EuPjDTOa+hH/y2ShKp2NwdJOzTzNXFMu56Ebg5/iElWT+pBALQdK0ESgKEof66MR/f6jHn/kCSkaNtyggj1E8mVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFkpBt5A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746186430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bd+qrSUziC6Hp37oryqfJ42cozggFXlnjz2f5SA/Nlw=;
	b=fFkpBt5ASInIcYUqC1X3F4MllL7i2sYe+cL4uM1wEdqd+zLXJjUjRDRpRdm6c3kXuNIoW0
	ZJkymdIeCfy09v6Z2aocdpq9Y8fWGws85ch1ZUSMPRBbfLcLJXbYltsxXWk4b1Sz3+OjFd
	92n5MHsluco0W5rRu5GrjEbz1wB7PEE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-EXKNjLH_MkOrWZNjE-hOKw-1; Fri, 02 May 2025 07:47:09 -0400
X-MC-Unique: EXKNjLH_MkOrWZNjE-hOKw-1
X-Mimecast-MFC-AGG-ID: EXKNjLH_MkOrWZNjE-hOKw_1746186429
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ea256f039so13652015e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 04:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746186428; x=1746791228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bd+qrSUziC6Hp37oryqfJ42cozggFXlnjz2f5SA/Nlw=;
        b=rKDTRlgbBAEbgIQCa3eZySAXt23Sx7Npi98us/gGC66TtrMncf5KGEcxS2immmHZ6K
         7xfRzYzwTC9E5UBgQXIPeAudsAKxJHeTJQtHgiWfeqrqmZP1jlFrlRcz2888TZAkRAQV
         YV9fesaPk3D2KQ5T6hB9lfi2tbBPYSwq9kGEJCrQMTJhKW9DWBJCY+AQAF0yrexmcI4h
         OVGGGf+OpOvkr7/Gt0QcPM+1r6EWXlcU+RtH9bzj3hNl1LTXC2XMOAYqdw1t/Ha92216
         +NVolJREudCuijbTUw9yZfSAqjs3S7S1LS50PAx8uWceZekMI//t45AN/y2aRyFh9Fv9
         2LRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVJNEUbUGTTRMFSeXwsMf620BRSFcdACxNYReZPvfkf+LQ/f3SAWZ2Ko7nYmXIZ0BtqGQm8jzABDpZpI+yiDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAMxFcg9SoQEqaskCQhEglT00fhs/By2qe9fNOYcl9JfEb4CS1
	CmkJM6AdDiyiWXPUMmNfq3DDT1wUw7dacoYX7S9Tw9supUHlAgIuhu8AaWYX+jijHfpIaKaAsHr
	VrATeji02Yz4xjL3PqShufK2hLTaVV22Zdhxi9GMxo+fbZuPhEz9ZOwCOqc63xJbDsg==
X-Gm-Gg: ASbGncubSS1f1B4dbbRdXa8j55rlRybwEwZnPRR0P6kfGH8LqvVE/mraHQEXbY78gYZ
	AbBGoxgYxosK2oXIcOdzgZkNRjxNZ0KFJGR/Jfxp4cfYtlygOl/YAXbuPH8GCMcq4FrnjP3yzwO
	bn1NO0AF6mpjSalMYcOIEegse38KbCNGPgamTqPKd33ayxIZb+a15HKfEka8PVyTHFW8jynMVgu
	MF/QxAGjttS+gObnL8sFIYCgiUHRFYYxh8AKWUdIlc3hXz9lOY+xE+1wv0nlbkME2/BxYDHsT81
	6WtDdirsGeQQRWRVFGE=
X-Received: by 2002:a05:600c:1907:b0:43d:aed:f7de with SMTP id 5b1f17b1804b1-441bbf31b4fmr17578905e9.21.1746186428658;
        Fri, 02 May 2025 04:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNkSVOCPi9/Yl9G06/uxys7n8ZbaJNy9wtYWx0RJ7ALzhpTB8PeBBxho/R9jjz77v4vvgt8Q==
X-Received: by 2002:a05:600c:1907:b0:43d:aed:f7de with SMTP id 5b1f17b1804b1-441bbf31b4fmr17578465e9.21.1746186428227;
        Fri, 02 May 2025 04:47:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aecc89sm87546305e9.9.2025.05.02.04.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 04:47:07 -0700 (PDT)
Message-ID: <53433089-7beb-46cf-ae8a-6c58cd909e31@redhat.com>
Date: Fri, 2 May 2025 13:47:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 4/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 io-uring@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250429032645.363766-1-almasrymina@google.com>
 <20250429032645.363766-5-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250429032645.363766-5-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/29/25 5:26 AM, Mina Almasry wrote:
> Augment dmabuf binding to be able to handle TX. Additional to all the RX
> binding, we also create tx_vec needed for the TX path.
> 
> Provide API for sendmsg to be able to send dmabufs bound to this device:
> 
> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
> 
> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
> implementation, while disabling instances where MSG_ZEROCOPY falls back
> to copying.
> 
> We additionally pipe the binding down to the new
> zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
> instead of the traditional page netmems.
> 
> We also special case skb_frag_dma_map to return the dma-address of these
> dmabuf net_iovs instead of attempting to map pages.
> 
> The TX path may release the dmabuf in a context where we cannot wait.
> This happens when the user unbinds a TX dmabuf while there are still
> references to its netmems in the TX path. In that case, the netmems will
> be put_netmem'd from a context where we can't unmap the dmabuf, Resolve
> this by making __net_devmem_dmabuf_binding_free schedule_work'd.
> 
> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
> of the implementation came from devmem TCP RFC v1[1], which included the
> TX path, but Stan did all the rebasing on top of netmem/net_iov.
> 
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

I'm sorry for the late feedback. A bunch of things I did not notice
before...

> @@ -701,6 +743,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  
>  	if (msg && msg->msg_ubuf && msg->sg_from_iter)
>  		ret = msg->sg_from_iter(skb, from, length);
> +	else if (unlikely(binding))

I'm unsure if the unlikely() here (and in similar tests below) it's
worthy: depending on the actual workload this condition could be very
likely.

[...]
> @@ -1066,11 +1067,24 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  	int flags, err, copied = 0;
>  	int mss_now = 0, size_goal, copied_syn = 0;
>  	int process_backlog = 0;
> +	bool sockc_valid = true;
>  	int zc = 0;
>  	long timeo;
>  
>  	flags = msg->msg_flags;
>  
> +	sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags),
> +					.dmabuf_id = 0 };

the '.dmabuf_id = 0' part is not needed, and possibly the code is
clearer without it.

> +	if (msg->msg_controllen) {
> +		err = sock_cmsg_send(sk, msg, &sockc);
> +		if (unlikely(err))
> +			/* Don't return error until MSG_FASTOPEN has been
> +			 * processed; that may succeed even if the cmsg is
> +			 * invalid.
> +			 */
> +			sockc_valid = false;
> +	}
> +
>  	if ((flags & MSG_ZEROCOPY) && size) {
>  		if (msg->msg_ubuf) {
>  			uarg = msg->msg_ubuf;
> @@ -1078,7 +1092,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  				zc = MSG_ZEROCOPY;
>  		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>  			skb = tcp_write_queue_tail(sk);
> -			uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb));
> +			uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb),
> +						    sockc_valid && !!sockc.dmabuf_id);

If sock_cmsg_send() failed and the user did not provide a dmabuf_id,
memory accounting will be incorrect.

>  			if (!uarg) {
>  				err = -ENOBUFS;
>  				goto out_err;
> @@ -1087,12 +1102,27 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  				zc = MSG_ZEROCOPY;
>  			else
>  				uarg_to_msgzc(uarg)->zerocopy = 0;
> +
> +			if (sockc_valid && sockc.dmabuf_id) {
> +				binding = net_devmem_get_binding(sk, sockc.dmabuf_id);
> +				if (IS_ERR(binding)) {
> +					err = PTR_ERR(binding);
> +					binding = NULL;
> +					goto out_err;
> +				}
> +			}
>  		}
>  	} else if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES) && size) {
>  		if (sk->sk_route_caps & NETIF_F_SG)
>  			zc = MSG_SPLICE_PAGES;
>  	}
>  
> +	if (sockc_valid && sockc.dmabuf_id &&
> +	    (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
> +		err = -EINVAL;
> +		goto out_err;
> +	}
> +
>  	if (unlikely(flags & MSG_FASTOPEN ||
>  		     inet_test_bit(DEFER_CONNECT, sk)) &&
>  	    !tp->repair) {
> @@ -1131,14 +1161,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  		/* 'common' sending to sendq */
>  	}
>  
> -	sockc = (struct sockcm_cookie) { .tsflags = READ_ONCE(sk->sk_tsflags)};
> -	if (msg->msg_controllen) {
> -		err = sock_cmsg_send(sk, msg, &sockc);
> -		if (unlikely(err)) {
> -			err = -EINVAL;
> -			goto out_err;
> -		}
> -	}
> +	if (!sockc_valid)
> +		goto out_err;

Here 'err' could have been zeroed by tcp_sendmsg_fastopen(), and out_err
could emit a wrong return value.

Possibly it's better to keep the 'dmabuf_id' initialization out of
sock_cmsg_send() in a separate helper could simplify the handling here?

/P


