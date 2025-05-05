Return-Path: <linux-kselftest+bounces-32316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D8BAA8D3B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19D91893CE4
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 07:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437019995E;
	Mon,  5 May 2025 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4GH5QHx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879D176AC8
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430981; cv=none; b=SommgRNcBELkHypwp1Z2ci7XLtbDiBLJLr1aJETKF0jRtqHM/YM6UDkSvo3eQ3qpng70492hB+WABlXdDYs2VsUCqDJmv12DIMxmIofFY/sW5PeYSvY9M7BEj2bH7EiL48vGxN3c2cgMbzYpMkgxF+p7lNyVbNglA5V5dELHW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430981; c=relaxed/simple;
	bh=/1L4VXQZnM4TVg9Q0XEcQOC1Z7dwzdgPChSwdWfL7fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JboforRwZwO64rDjXHaVSv8xla0aL59l06cxX3w5mYdUV4E08X6WTespm0hROR0/aoSG+bR1/7NR33as8MUJQNyXS2H+oI+PXBrDAFEb2l/ORLUC8iICEpM9nraMr6M/u0CPTFXNbz3o6NuZCGYc8Au4pzHwVAMxH8WHWG5uhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4GH5QHx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746430979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYutuEk9tS5pMcj+KQxarlK855jenHaF07JshpvJP/c=;
	b=Z4GH5QHxoexj+8CAHSfnsLYjCURK6Scrt0POfm1Yyap1vtUUF4yv3T1RfeUHtOssL7Zsyq
	K8KhVwT6VugNyHjJdhJM8hfX26mhvVeZw58YBZYOY7TJkKryFUgD1omrG4mhyrNq9cE+lp
	Pq2CkoYnljm9ojGQ+f6+rZtwJKIzDg4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-bW2ATmwbNkWG0A-Lg-E_gg-1; Mon, 05 May 2025 03:42:57 -0400
X-MC-Unique: bW2ATmwbNkWG0A-Lg-E_gg-1
X-Mimecast-MFC-AGG-ID: bW2ATmwbNkWG0A-Lg-E_gg_1746430976
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-549948b27a7so1904361e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 00:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746430976; x=1747035776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYutuEk9tS5pMcj+KQxarlK855jenHaF07JshpvJP/c=;
        b=ai9ibN1AymrI5pJ8Ks1NR8Mr1uyo3gjAJtsA9CJaYLNqUXQGcFuGgEbGIhTWT4wFDl
         vt7ihDxUTHBk/SzX52H6QndmTkAW7eJpceh+tFT+/LT7MyBnEutAzu/xxIWIlZkt7vT/
         PQ+z0caV8BrhM7Ce6oyX3a6Se0W3cSMV2SADba4ZtyJduLumUHCDghz5CQuhGBVXhJbB
         BUDktONCCagvJJ3+GSbcaDjUZMtKLUltnMY3vGta98miK33mLZOD5PipYJ56klVrHakN
         mjB3wFHz4ttB56IlrBha10ZVLKRnqWeFUIdl3mw5m9Y0Jz8w5WBihqOwoYnDB0xD2hQ/
         jEoA==
X-Forwarded-Encrypted: i=1; AJvYcCWg8PVvTEmPfWQDy1I4kWZBA3RYb4y06TR8a/oDarPIoxHXDin6NUqfHxhj6ml+y86/bnD9NCcIL3PWmPQoF6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFCktOabd9ekFq2pbYy4x5H/qs4UwtuPIHQmIhuavD29c2kqm
	XQkUfpBgroToLrRPAiIyladGxXWy3xKZV9444dcr6RokxnTxyoAd2j+Dm4oOCNCvESiTYK++4nx
	SLLCvXoHZ4kskN3HcTdl9omiXfMfnnYAAx2MbUUJ4kYb44ITFsnijYeDZ61HguuWRHPe1f/cZuf
	fma0w=
X-Gm-Gg: ASbGncvXmywr2N0g/0SvOBF5HtoAZzJaOQF2KFlCk/mJaWPdRdLEPYojsVPOlIDXmQe
	7X0wI+cTmyVCcV0FPmphB33szvjy99UjBA5v5mglffcOPLwFbARkgagevK7Qug1b04IAAw/gcOU
	1LeMPDNSx+Ys+3hqoZd86L/UaTHB5SBPrn1jTwk4lWE8x54jJhbz02XaQq23pE/eGZa7jo1gW3a
	T2ui6XLtX26JfajmxHqsTswDyVvA0xX80gd9PmwHkC+2VvomNfh16ywzCZCiLlwkud+toVIjWut
	CZdYDky/FvbLV7egnGEQYs0IGUkEeAKsbhbSCo0uYca5BWGOyqhG5K7OJVI=
X-Received: by 2002:a05:6512:3d86:b0:54b:f10:fe46 with SMTP id 2adb3069b0e04-54fa0a93d9dmr1211119e87.25.1746430975846;
        Mon, 05 May 2025 00:42:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsEsHgZOcmzKyEYKe53zgGMeSaMF3WinuQkv4wSGTWsyP+GpxlPUt85uINmh0HuIcOZYrSLQ==
X-Received: by 2002:a05:600c:1e09:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-441cb49494cmr15680615e9.17.1746430567130;
        Mon, 05 May 2025 00:36:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b391c42bsm162401715e9.39.2025.05.05.00.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 00:36:06 -0700 (PDT)
Message-ID: <8cdf120d-a0f0-4dcc-a8f9-cea967ce6e7b@redhat.com>
Date: Mon, 5 May 2025 09:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 4/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, io-uring@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
 <53433089-7beb-46cf-ae8a-6c58cd909e31@redhat.com>
 <CAHS8izMefrkHf9WXerrOY4Wo8U2KmxSVkgY+4JB+6iDuoCZ3WQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izMefrkHf9WXerrOY4Wo8U2KmxSVkgY+4JB+6iDuoCZ3WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/2/25 9:20 PM, Mina Almasry wrote:
> On Fri, May 2, 2025 at 4:47 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>> @@ -1078,7 +1092,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>>>                               zc = MSG_ZEROCOPY;
>>>               } else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>>>                       skb = tcp_write_queue_tail(sk);
>>> -                     uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb));
>>> +                     uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb),
>>> +                                                 sockc_valid && !!sockc.dmabuf_id);
>>
>> If sock_cmsg_send() failed and the user did not provide a dmabuf_id,
>> memory accounting will be incorrect.
> 
> Forgive me but I don't see it. sockc_valid will be false, so
> msg_zerocopy_realloc will do the normal MSG_ZEROCOPY accounting. Then
> below whech check sockc_valid in place of where we did the
> sock_cmsg_send before, and goto err. I assume the goto err should undo
> the memory accounting in the new code as in the old code. Can you
> elaborate on the bug you see?

Uhm, I think I misread the condition used for msg_zerocopy_realloc()
last argument.

Re-reading it now it the problem I see is that if sock_cmsg_send() fails
after correctly setting 'dmabuf_id', msg_zerocopy_realloc() will account
the dmabuf memory, which looks unexpected.

Somewhat related, I don't see any change to the msg_zerocopy/ubuf
complete/cleanup path(s): what will happen to the devmem ubuf memory at
uarg->complete() time? It looks like it will go unexpectedly through
mm_unaccount_pinned_pages()???

Thanks,

Paolo


