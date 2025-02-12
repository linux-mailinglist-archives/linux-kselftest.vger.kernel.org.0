Return-Path: <linux-kselftest+bounces-26475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A31BA32AE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 16:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E5A168400
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D5025A35E;
	Wed, 12 Feb 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6VymOBh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D625A354;
	Wed, 12 Feb 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375547; cv=none; b=VMHzuF+UjhM5Y1WIEB0SJJ7ojoCKQpqVROnw4tM4yqPmrEXNQeAgypTViE72rOyeDR8N9O0KK82/j9cgF5/IKw0ErVrAX0oPHW/Z45dSj4B0AlpXzz/psjqM0UC8pMiwgiQtIHWfWHbjzxM2+GByPRjKCPH6PUjwAWSisOzGds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375547; c=relaxed/simple;
	bh=jrXhWYnImskFko9wBtv2JPSJVKz9x+wgYx6uQ0eFWZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bN73G3vBx2WUxXzEXmPlJS22Qaa2I/4tpoXJzZTleFmsFAbGGJEd5nhOSS8/syCqWaqWZsVw/s7uI3huIGuDsLYSe8bu4ItZ8ysD+1/51qWdq22EFtHHNBT4zkOTF7J0/iJF2gappwQMTG30dmPt0u1ynDrTaw1RsG2L2U5w/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6VymOBh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dd011ff8bso4197151f8f.0;
        Wed, 12 Feb 2025 07:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739375544; x=1739980344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zy76W96ncGtjcIE/1RFX9zT9Pr7PxW1QtkdC0k/xF7g=;
        b=G6VymOBhgDwpbDuyoMazrUbYpQA1hTntdHRYV8udjB+/YX39Jyow/mkBf9q8Ixhlsm
         e5/WAJ++wRXMIc6wgVDzlwotBh7bit3Tz2009rjRm+0vkrTWZ9s+qM3NLVLICknLGJ9s
         TDfILeiDXZ9Hqj8wtmxa6wkMXjgYhANBRsPNTg+TzKXreqHzXSglGhZ9rzsO0WHL7RSb
         uSjTanDr8JBmEuxXT2894gJBEoVNC1IwTwHRpWwLiGpfe4vvFUsDl4uEroWw0ki9jt6O
         G9Np5FZzCDVix5/Xd5r8l+rBrAGinJ5q276GReQ8xRZ4qY3+V3CqAoZIbNx17SWtiX1F
         tuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739375544; x=1739980344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zy76W96ncGtjcIE/1RFX9zT9Pr7PxW1QtkdC0k/xF7g=;
        b=K1t2mony+93uNOUBe2OeMaBnZK53aZX2e06bkVnMm6IsW7H9CrZTy2VK4yHg21eyP2
         FsLZV+xSbAeWBONGkTA+UWKzO8JWGEHlCU75p7OBRs+o7HSG84lEhv+q1NIV7BGR1Dfw
         8p0n4XUSx2h06Qsn8/8aqsliiB2tWjoMqoEgFbd48CE8nu1s35FzyDqb8PSAkxbWg0Gn
         1PKwbJcFJ8MgNOHBvc1FQmbl/5SXQpVvLsbaXIVQpQwq7pDjvTrSbIJndMDw3uGgeykJ
         arxd8Qgvm8fybksXjQpdz7IUX3hVIRb7Pn2L5CE/I7u9kmtpAJbQ1cYj5Twk+0zhcnU2
         90KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUojgXkHg/X5fKScukYx0kqlGZ6sV7YrMSZ8irgdkuS6ylW20P6LCyBwIBG5mBJD71VhktI66hKsTdE@vger.kernel.org, AJvYcCVcXpwq22D9ieFDb/A/UFwCQploM88/0+SHC4q+CvaSZz1rUIv+cV0akL6EHauomrQQ5YSwCSyhx8/wlZa1@vger.kernel.org, AJvYcCXqPva3JfLbkPCGeThY+HbX4f3591hBig4Og5Ox24CkcKc33U9rnbLOUbH4+Gs9qp8K3Z1nejvUFpdX4RehaJb+@vger.kernel.org, AJvYcCXw3ewdCD5CpWMwFynXXYQGkGygYz/pE6Hl34mL1W6rS2YiPBlsDf/5TncXnjAdKL1j/Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUBxLzRXpkDL7j2KWsPZ7uAdvgzkIeHgvWeL5dc+7wddWmRsam
	5s6jcASjd427GsK+wY85U5reHA7a9qzmbB4HZC0U2kBAgHPTfk1k
X-Gm-Gg: ASbGnctLi4wEw195lN3JkPNtq01Vm7ICHrEWA/U4X2hmmK8ctCjnyJoHbUYQEY+vv/J
	6QPG8A5bVuVkgJ6b3Cdm9VnZHIiQmb/5zHwIItMjTHzcou5xhuM4Qac+cnJzrQzozTEu+GaeN1L
	dIfXEYrv0b/dA11S8oVkFb/DwywMat+5Q6swtcKQYmt163JCG+8aHGSgs0kQY+nE8t3cRUQ1xEk
	+Aw9DLML/U6nEBfaYNG99H7yK5lbqLpNcS1jsrWvUMasPlAsITScAWVVtT9ny9tn/v44O/9XcbD
	jCh6OWNPHVGKFmlZM0+c54/p
X-Google-Smtp-Source: AGHT+IGpD+27wLo/4uLAUDA60FDap/eR74/Ue8vD3BXCKcQh+GD2m9lFZwxy9qa3lhW3DrbvJ0WWIw==
X-Received: by 2002:a5d:6da5:0:b0:38d:eb33:79c2 with SMTP id ffacd0b85a97d-38deb337a6cmr2961051f8f.32.1739375543490;
        Wed, 12 Feb 2025 07:52:23 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04ee2fsm23278465e9.4.2025.02.12.07.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:52:22 -0800 (PST)
Message-ID: <28343e83-6d93-4002-a691-f8273d4d24a8@gmail.com>
Date: Wed, 12 Feb 2025 15:53:23 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/6] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-6-almasrymina@google.com>
 <abc22620-d509-4b12-80ac-0c36b08b36d9@gmail.com>
 <CAHS8izNOqaFe_40gFh09vdBz6-deWdeGu9Aky-e7E+Wu2qtfdw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNOqaFe_40gFh09vdBz6-deWdeGu9Aky-e7E+Wu2qtfdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/10/25 21:09, Mina Almasry wrote:
> On Wed, Feb 5, 2025 at 4:20 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 2/3/25 22:39, Mina Almasry wrote:
>> ...
>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>> index bb2b751d274a..3ff8f568c382 100644
>>> --- a/include/linux/skbuff.h
>>> +++ b/include/linux/skbuff.h
>>> @@ -1711,9 +1711,12 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
>> ...
>>>    int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>>>                                struct iov_iter *from, size_t length);
>>> @@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>>>    static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
>>>                                          struct msghdr *msg, int len)
>>>    {
>>> -     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len);
>>> +     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len,
>>> +                                    NULL);
>>
>> Instead of propagating it all the way down and carving a new path, why
>> not reuse the existing infra? You already hook into where ubuf is
>> allocated, you can stash the binding in there. And
> 
> It looks like it's not possible to increase the side of ubuf_info at
> all, otherwise the BUILD_BUG_ON in msg_zerocopy_alloc() fires.
> 
> It's asserting that sizeof(ubuf_info_msgzc) <= sizeof(skb->cb), and
> I'm guessing increasing skb->cb size is not really the way to go.
> 
> What I may be able to do here is stash the binding somewhere in
> ubuf_info_msgzc via union with fields we don't need for devmem, and/or

It doesn't need to account the memory against the user, and you
actually don't want that because dmabuf should take care of that.
So, it should be fine to reuse ->mmp.

It's also not a real sk_buff, so maybe maintainers wouldn't mind
reusing some more space out of it, if that would even be needed.

> stashing the binding in ubuf_info_ops (very hacky). Neither approach
> seems ideal, but the former may work and may be cleaner.
> 
> I'll take a deeper look here. I had looked before and concluded that
> we're piggybacking devmem TX on MSG_ZEROCOPY path, because we need
> almost all of the functionality there (no copying, send complete
> notifications, etc), with one minor change in the skb filling. I had
> concluded that if MSG_ZEROCOPY was never updated to use the existing
> infra, then it's appropriate for devmem TX piggybacking on top of it

MSG_ZEROCOPY does use the common infra, i.e. passing ubuf_info,
but doesn't need ->sg_from_iter as zerocopy_fill_skb_from_iter()
and it's what was there first.

> to follow that. I would not want to get into a refactor of
> MSG_ZEROCOPY for no real reason.
> 
> But I'll take a deeper look here and see if I can make something
> slightly cleaner work.
> 
>> zerocopy_fill_skb_from_devmem can implement ->sg_from_iter,
>> see __zerocopy_sg_from_iter().
>>
>> ...
>>> diff --git a/net/core/datagram.c b/net/core/datagram.c
>>> index f0693707aece..c989606ff58d 100644
>>> --- a/net/core/datagram.c
>>> +++ b/net/core/datagram.c
>>> @@ -63,6 +63,8 @@
>>> +static int
>>> +zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>>> +                           int length,
>>> +                           struct net_devmem_dmabuf_binding *binding)
>>> +{
>>> +     int i = skb_shinfo(skb)->nr_frags;
>>> +     size_t virt_addr, size, off;
>>> +     struct net_iov *niov;
>>> +
>>> +     while (length && iov_iter_count(from)) {
>>> +             if (i == MAX_SKB_FRAGS)
>>> +                     return -EMSGSIZE;
>>> +
>>> +             virt_addr = (size_t)iter_iov_addr(from);
>>
>> Unless I missed it somewhere it needs to check that the iter
>> is iovec based.
>>
> 
> How do we end up here with an iterator that is not iovec based? Is the
> user able to trigger that somehow and I missed it?

Hopefully not, but for example io_uring passes bvecs for a number of
requests that can end up in tcp_sendmsg_locked(). Those probably
would work with the current patch, but check the order of some of the
checks it will break. And once io_uring starts passing bvecs for
normal send[msg] requests, it'd definitely be possible. And there
are other in kernel users apart from send(2) path, so who knows.

The api allows it and therefore should be checked, it's better to
avoid quite possible latent bugs.

-- 
Pavel Begunkov


