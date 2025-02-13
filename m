Return-Path: <linux-kselftest+bounces-26549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E81EA34016
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 14:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B56188929E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F03227EBE;
	Thu, 13 Feb 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnX7YQnB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F3227E9C;
	Thu, 13 Feb 2025 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452667; cv=none; b=H65J6GuT+jgtu88lQuvutLVpv5cIBbudsaVqQxCXpTqMfUyoyyLYDWYVlHDLjr0haiCeCRSuDu2VoGKRATg0fdLd9IfUiu50YAJ6WExbyWV98j7cWRYsVbN9ZLXm2dONVejtme4HEUEhYwdOU0HZ+YViKX3bHyKg2GKv8BTBLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452667; c=relaxed/simple;
	bh=ZOrVSjQ6x7PTk/9ctQhhG+ZGpSsFcwHe8JsFOyeSGXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EocPFoguGi/aGRQbSEk54twDzGpEMATyKqMRUY7paJxkarNdHJufB5keuLifMYm4maU34p8q1+QDQZJTBfeN74b+uOxgkso67YM7jipkckXMewk8kkrIyBe/jX/dNSfOzcMrC0C749YvGbyDpqH1GfXbyikVw1AVENitNesvjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnX7YQnB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7c81b8681so170184066b.0;
        Thu, 13 Feb 2025 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739452664; x=1740057464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcBu1mmfCOw9BS5+FJzHYiV0BhZGp25NekRfDcZi1qw=;
        b=TnX7YQnB+bQrfIW1nIpsTL3LdRA0cc72LYvOi2Y7O8EtF2FNORRWC8oaeWNgqnXD6A
         KOflkVZavsgBf46/qh9Zw7jvgMTqxwl3swfL12bg1N4pi1/yx1BIu7DUnvBXSFslezLI
         WQcjrsDtDrRLj/+KWS01+a5IQjTDY+xAFWW1vIWi6+M4rmkMu4I4xyKaWTtje8Az2J/Y
         ASaHXmLPgdOE4dvFjXC90sQjLVpkVl56xoB2GYMcuDGUT/7M6FbM22AS2xbiP7iwfi56
         Pom49PgHeLxHgeeuxRKminczIeixv9nYz6Wgw68ZaItrjXueQgSoyZQSBDBfrXjet33v
         lcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739452664; x=1740057464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcBu1mmfCOw9BS5+FJzHYiV0BhZGp25NekRfDcZi1qw=;
        b=Cprqp8bzUEbsm6OyH2A/i53/ZeR0zjS/99/JW2Cc+EKbPZpIZM7KNYI7asxQS8GsTQ
         h1a9izZMhvpD9xKSvcAnfc8yVGEDt64dJxauWdzmve5DBicOpHScvKPuWOd8M07yopKO
         nLgOkmmFGGub6ZrcKWR+ZhJE4OLo19dhLi7dU4y5HDzcFPcPi/duDCi4SujmEdNTy2OH
         hI2ChDzZ7WIkRBJjVZ7JqSAGg6w8N/5qlS4JQsEvv8waBZLZpNQAvieGCnnJL+y1sDg2
         AHruNdLgW2bvP/IEBhEzchQ92nAvEveJTe2rKNSuPgU+eqVqYpHVQjJjIeYJuGchupGf
         kDdw==
X-Forwarded-Encrypted: i=1; AJvYcCVcK6eJsHfcuhSuuRpAN55Qz/W981LwdljWtLHdsQdHajl7H5x3JUghtMWlbsBS9rZdce8=@vger.kernel.org, AJvYcCWnPmLiil8+Fwre2SkfXAc5uVS4xJlY2eanmKBNUTR74y6fXEkd4KUxtfkUtvo0fKTBPkyLMgvncOK7b9xt@vger.kernel.org, AJvYcCWw6CTYCa9Gb5sJJzjKIj87ClIrOBrdNL0COB/y8y8Us7ySUDE2VWTlCdULMfvQTHwTGbheX8cnnKe2vgmNFHJ0@vger.kernel.org, AJvYcCX40NTAPpurb2Uyf3UeVOlRIinaXx0AXQXduKsnLfHPsJKTh+TptZG108v222hIu5nk1sg6YKWGhgAs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lQDAMFHh0LoAtJZqkZommmQpYcYtJR7O8PCxweKfi7NH/4Om
	ngZYrCTQLGC4bAGi6CLqTqquXwZ9h9LmkSNLun7NrGucR08Tpp1r
X-Gm-Gg: ASbGncvnhoyV1jybUHUJKfzpxLVuR35h6ZIdCxbd43duPK1x6pIaulljrQ6m4Jidd2k
	bejfENjV4AcTaB2PlcECuat3aHP2KL9Mwtzs9f+AyUIVD+s0Pp3uSfOTCbib0HPoMuLpsx5Q8H1
	FE/hHGM0h1TbbbTU8Hu0APxk9uhEfrIGemK7Xny3ZvsrXFcDROk/G8SqfoTiPtUuKMh5RvFLSYg
	DFUXT3X54b2+q2uTjhw2lvOZcMHb5W/iy3BLQ2PBplVwyVD7ksYPs+mfXtO+iqdrU2FJnDJHJBf
	Lo9eXarUtrck883F7QMPhCRvLXf0i4YXGJaDwdBBmBcOnYJR
X-Google-Smtp-Source: AGHT+IHYSRmvacENlOHPaEcGh9qwXupY4qr9g756WVVr7uCCm+4s+x/aI/sqeelBWyHDGxCBfNiyaQ==
X-Received: by 2002:a17:907:cf8a:b0:ab7:b878:e8bc with SMTP id a640c23a62f3a-ab7f387457fmr769377466b.38.1739452663746;
        Thu, 13 Feb 2025 05:17:43 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:1ba9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53280ee4sm130506966b.78.2025.02.13.05.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 05:17:43 -0800 (PST)
Message-ID: <9210a12c-9adb-46ba-b92c-90fd07e1980f@gmail.com>
Date: Thu, 13 Feb 2025 13:18:42 +0000
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
 <28343e83-6d93-4002-a691-f8273d4d24a8@gmail.com>
 <CAHS8izOE-JzMszieHEXtYBs7_6D-ngVx2kJyMwp8eCWLK-c0cQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izOE-JzMszieHEXtYBs7_6D-ngVx2kJyMwp8eCWLK-c0cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/25 19:18, Mina Almasry wrote:
> On Wed, Feb 12, 2025 at 7:52 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 2/10/25 21:09, Mina Almasry wrote:
>>> On Wed, Feb 5, 2025 at 4:20 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>
>>>> On 2/3/25 22:39, Mina Almasry wrote:
>>>> ...
>>>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>>>> index bb2b751d274a..3ff8f568c382 100644
>>>>> --- a/include/linux/skbuff.h
>>>>> +++ b/include/linux/skbuff.h
>>>>> @@ -1711,9 +1711,12 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
>>>> ...
>>>>>     int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>>>>>                                 struct iov_iter *from, size_t length);
>>>>> @@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>>>>>     static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
>>>>>                                           struct msghdr *msg, int len)
>>>>>     {
>>>>> -     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len);
>>>>> +     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len,
>>>>> +                                    NULL);
>>>>
>>>> Instead of propagating it all the way down and carving a new path, why
>>>> not reuse the existing infra? You already hook into where ubuf is
>>>> allocated, you can stash the binding in there. And
>>>
>>> It looks like it's not possible to increase the side of ubuf_info at
>>> all, otherwise the BUILD_BUG_ON in msg_zerocopy_alloc() fires.
>>>
>>> It's asserting that sizeof(ubuf_info_msgzc) <= sizeof(skb->cb), and
>>> I'm guessing increasing skb->cb size is not really the way to go.
>>>
>>> What I may be able to do here is stash the binding somewhere in
>>> ubuf_info_msgzc via union with fields we don't need for devmem, and/or
>>
>> It doesn't need to account the memory against the user, and you
>> actually don't want that because dmabuf should take care of that.
>> So, it should be fine to reuse ->mmp.
>>
>> It's also not a real sk_buff, so maybe maintainers wouldn't mind
>> reusing some more space out of it, if that would even be needed.
>>
> 
> netmem skb are real sk_buff, with the modification that frags are not

We were discussing ubuf_info allocation, take a look at
msg_zerocopy_alloc(), it has nothing to do with netmems and all that.

> readable, only in the case that the netmem is unreadable. I would not
> approve of considering netmem/devmem skbs "not real skbs", and start
> messing with the semantics of skb fields for devmem skbs, and having
> to start adding skb_is_devmem() checks through all code in the skb
> handlers that touch the fields being overwritten in the devmem case.
> No, I don't think we can re-use random fields in the skb for devmem.
> 
>>> stashing the binding in ubuf_info_ops (very hacky). Neither approach
>>> seems ideal, but the former may work and may be cleaner.
>>>
>>> I'll take a deeper look here. I had looked before and concluded that
>>> we're piggybacking devmem TX on MSG_ZEROCOPY path, because we need
>>> almost all of the functionality there (no copying, send complete
>>> notifications, etc), with one minor change in the skb filling. I had
>>> concluded that if MSG_ZEROCOPY was never updated to use the existing
>>> infra, then it's appropriate for devmem TX piggybacking on top of it
>>
>> MSG_ZEROCOPY does use the common infra, i.e. passing ubuf_info,
>> but doesn't need ->sg_from_iter as zerocopy_fill_skb_from_iter()
>> and it's what was there first.
>>
> 
> But MSG_ZEROCOPY doesn't set msg->msg_ubuf. And not setting
> msg->msg_ubuf fails to trigger msg->sg_from_iter altogether.
> 
> And also currently sg_from_iter isn't set up to take in a ubuf_info.
> We'd need that if we stash the binding in the ubuf_info.

https://github.com/isilence/linux.git sg-iter-ops

I have old patches for all of that, they even rebased cleanly. That
should do it for you, and I need to send then regardless of devmem.


> All in all I think I wanna prototype an msg->sg_from_iter approach and
> make a judgement call on whether it's cleaner than just passing the
> binding through a couple of helpers just as I'm doing here. My feeling
> is that the implementation in this patch may be cleaner than
> refactoring the entire msg_ubuf/sg_from_iter flows so we can sort of
> use it for MSG_ZEROCOPY with devmem when it currently doesn't use it.
> 
>>> to follow that. I would not want to get into a refactor of
>>> MSG_ZEROCOPY for no real reason.
>>>
>>> But I'll take a deeper look here and see if I can make something
>>> slightly cleaner work.

-- 
Pavel Begunkov


