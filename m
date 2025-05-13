Return-Path: <linux-kselftest+bounces-32896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3747AB4EE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 11:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C7B189C149
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D9C212FAA;
	Tue, 13 May 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJRZ+77P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4441A8F
	for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127532; cv=none; b=eaxiMTa8rM3tMHZTZTT9EYO2RX4hoVm9YfDI8Fv1chTZOlACJZucvloQkhk8mQ5ydYtN+7yJedf3/alzBfVsvY3XflEkqZ1Rq/jIFQCGzrXrD9yBw1OpSth4fSLhVFqQhUY8n6xZVyXEfTL4XFGNHEJ9wdZveABIJdMIuPFuHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127532; c=relaxed/simple;
	bh=WDlpFsWbDcfzZLGnp/d3QNExJHb0unwOgNVXbvwod6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbzdBwB3r/nS3Hi+wYGh34kjZrcd1McNviBxaQFaY51TzeF2BICy8XKDkrrZw5LE2VUR1iYd9GAaLBOjqbHyRNU4Z/jAi+qfGDf4HKrb524zO9oBbHLY32w7Msq5tsdAUiMrw7Qei1bjsZU19y0icv/0HLTc4I8QNd/5UICvGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJRZ+77P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSKXGvXgaIuXifWFUaLvMDff9Ik6twAKIvR+Y496sQE=;
	b=YJRZ+77PE8fUZxIWsKZlghHM0YJkUVwOeJZwBMeezfbfQRLkI1xIQo9Oie4XCDO0BxO/tu
	u8rct+uqA1Lkz5Cy/ZMqQUKq7R6z/mzQSLroxYxYDwhwJVZ04u1PGSchHAjEbIaNPl2koP
	4Nfjrqz/MTJEgZkreySYNy4Qrwb7HU4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-ymZWkOFIMMuWlpAIA3ntNA-1; Tue, 13 May 2025 05:12:09 -0400
X-MC-Unique: ymZWkOFIMMuWlpAIA3ntNA-1
X-Mimecast-MFC-AGG-ID: ymZWkOFIMMuWlpAIA3ntNA_1747127528
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442cdf07ad9so22222845e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 02:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127528; x=1747732328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSKXGvXgaIuXifWFUaLvMDff9Ik6twAKIvR+Y496sQE=;
        b=eMgjMJd4Z+DTIaGJ4ovukFGPx9tGMFTVD47DC2lsg1WwWNBNoUeR31xaX8EoP1v8az
         a35VxZO29M2zazDaieKbJFz3K3zSUAS6JyG9raAS0D7eCBBcLtQjyDetP8nOSvJuvtfU
         YqCGOY96xPaoq12IqrmNFQk+po+g5uE5KH5uUopZTPQ/Ie9Wfphctpb7Yd2aW+7Esq8K
         wp9xbHncd6j8eN8nUXl0h7kUN0yJOmxiGcviemkUIsJ3tGwbiiM+k2MOVdXxge/i6lft
         pauwmYQ4P3sIuJs18moGCvB7SJmh3FnXbtaS2V4rovuBWtim/VlJhvACRS7PCc7dA9mh
         8b0w==
X-Forwarded-Encrypted: i=1; AJvYcCXok+TOykAWB7TYbOuWIDVusxduEj4V3h8N0WG1QgCX1eGz3NCO+SOqjerCTr/kLSIvH8lKMMane33rxOrqBCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ho0EtuF/xzF7EAADzxYEyZcMhVmeIku4jnfqC5IL9ztc2C0D
	N4UD29o6A0dsE+zlGwLCYC+Z5ZUkP/TygocqUxh+daQNjywuKD98r/Vu3+RxNX39uIepC3/2CjN
	YxOPU0r5/ErAAhQu3dK2nPiVi/abuzFximTPPf8G8WpUdeAS9UvsxcD56T+Ma+76MIQ==
X-Gm-Gg: ASbGncsgFqrPT6md20fFPRMoxZkwRoOS39Cv/pF+SYsu0c/soSSGEMhMAi/vYx44VBe
	h6H6xN8hy7OVKuhZw6SxdYeMCcpFC5RHgseOcTlpbnJvjvdJsO62Yqrom4lVOCa5viTkFtgJmBf
	5w6dk0kcVnjqRK+88H6Q20dLLOCLkQoi3vCYAUIQoh/rwNZat+odb5fyStsWelBrpm4pkg6hhOl
	XHVWxwKKltRDT0RDsoKB1BPfX09mBLTn/m+FAB7W4RVidADqW5RLadqrKtdU06rwUx4q7Eqh/lt
	OLczAWnPTsS+ZjOmAjU=
X-Received: by 2002:a05:600c:4454:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-442d6d44aa7mr175599975e9.10.1747127527684;
        Tue, 13 May 2025 02:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7UByCIdv1fV6GeTCbxFUgA3MTskc+HSiE9ez+aliKyTiJ4Fv/7gBQk/cE3vpwwsDlBoiWaw==
X-Received: by 2002:a05:600c:4454:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-442d6d44aa7mr175599485e9.10.1747127527311;
        Tue, 13 May 2025 02:12:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ea367102sm36670345e9.3.2025.05.13.02.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 02:12:06 -0700 (PDT)
Message-ID: <085a78fc-acfc-4a86-9dbf-18795ad68b4c@redhat.com>
Date: Tue, 13 May 2025 11:12:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 4/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 io-uring@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
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
References: <20250508004830.4100853-1-almasrymina@google.com>
 <20250508004830.4100853-5-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250508004830.4100853-5-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 2:48 AM, Mina Almasry wrote:
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 86c427f166367..0ae265d39184e 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1059,6 +1059,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
>  
>  int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  {
> +	struct net_devmem_dmabuf_binding *binding = NULL;
>  	struct tcp_sock *tp = tcp_sk(sk);
>  	struct ubuf_info *uarg = NULL;
>  	struct sk_buff *skb;
> @@ -1066,11 +1067,23 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  	int flags, err, copied = 0;
>  	int mss_now = 0, size_goal, copied_syn = 0;
>  	int process_backlog = 0;
> +	bool sockc_valid = true;
>  	int zc = 0;
>  	long timeo;
>  
>  	flags = msg->msg_flags;
>  
> +	sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags) };
> +	if (msg->msg_controllen) {
> +		err = sock_cmsg_send(sk, msg, &sockc);
> +		if (unlikely(err))
> +			/* Don't return error until MSG_FASTOPEN has been
> +			 * processed; that may succeed even if the cmsg is
> +			 * invalid.
> +			 */
> +			sockc_valid = false;

It occurred to me a bit too late that this chunk of code could be
cleaned-up a bit using a 'sockc_err' variable to store the
sock_cmsg_send() return code instead of the 'sockc_valid' bool. It
should avoid a conditional here and in the later error check.

(just to mention a possible follow-up! no need to repost!)

Thanks,

Paolo


