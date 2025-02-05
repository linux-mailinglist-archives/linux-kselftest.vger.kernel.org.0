Return-Path: <linux-kselftest+bounces-25868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 929C7A29C7A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 23:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCC01654C2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 22:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBF921517C;
	Wed,  5 Feb 2025 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwfN7NTj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8647207A18;
	Wed,  5 Feb 2025 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738793779; cv=none; b=fUy/iHFQSM3SzjKmVu+lO+glqasLuwFv380Fe11EbDJJbDARD/2jTHdKwOM0I0/8ZK+Tnokv3JpS6jy4KEPNRFzrmy/VEyyB9WaDQbLRJOglgjTmiLNZ6FZQ8EVDlHBWsEYMvI2EqESYqWS9qLMECtF3a3wmWzvyYtSWeatKSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738793779; c=relaxed/simple;
	bh=55U68o/HXEWOrqm9K4AOTOcQCPWE93DnNhIT8Ds+a4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ks/VPt07+QaAPFxaN6rDKBnZGSweUMBHySmzCY9cZkdDAKA0tb1L1tFwlB3C8b9JyWiZk1HoR4IWtep7qM5muE8lWOV296bEaA5l5+/uua2hit/yTQvBukj9ajAcTc6nLFnpjJ2MnOfBZDwsUcOW8CUrs1j5G1uoZMqwfPtz1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwfN7NTj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43626213fffso8470465e9.1;
        Wed, 05 Feb 2025 14:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738793774; x=1739398574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdDVNZ5dZQ4AB4CLiIP63HC/J89SDxWWeBPv4iIwUpQ=;
        b=XwfN7NTjgPzWl0Ng6DY8vuT7ybpfzyF7OBBMUQ9ppIhaVw+EN2VjZwaXT5KZ2w4d/O
         kaRiiThn96VlQO0At8/w1Gm3C9q9JPDctxNGqhQ41q4gtfZbMQVHLNaFJG8s9fMeONLM
         Wv+C1652BGCR5OwjGCV6B8zximMWjIDZ3yO1wn2UFY1zw7ihQI6TrEBlGTr1v0uniIse
         kxZmRfz9HYk2H823423cDnB8/8wAcDLmaMmv3TChcpvsGgrooDiJEzbCOuD9hs/+uuuT
         1RuW/COjFXBpRV8h/hTd30rmfbMk+boPLnBH8WkTS9mBTUY22VmDHWGb7/tRlGKh1SZA
         RfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738793774; x=1739398574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdDVNZ5dZQ4AB4CLiIP63HC/J89SDxWWeBPv4iIwUpQ=;
        b=Vd5sIeOjvhWueQA9QMVQ8wwDDZwp5Ot7e85WU/8GTvGIqoxtb/XFC4hy/9k2Ob9V3c
         NgCVOjCms3ELFYcSRUpWY0LuDmGY9Rgeuujz0rLyaU1tV+a+DVaYm0haPRPwRok78BPA
         BtgMC47X2LOPQHXIc0fxDT7S4MvqPCJuYe8ieZcDBEFxJEqKKls+jkpBf2nniMYcaIVX
         oj8mczk++wEEC/TDJpqfB4dt5A4MP1AOsLOPFAZa4d6onRf2B/iaksfafNX2BFlJLtT8
         T3e9vnL7hjUUM5AHGm7zw9LMtLsxTI97fxKUqfW+Vhsx7q/HjyAoPTUmnHh4jHInZ/DK
         dP0w==
X-Forwarded-Encrypted: i=1; AJvYcCUCaA6vWwqM/HSSrJe9GUCFLSzcEoq30i8zO60zCGlnTjLcSIZe5N9j08RV5HQl39ZAZrkH741TNsWMbucJU5eg@vger.kernel.org, AJvYcCUkeYDWRXugom+64T70OIXaZf7klIkWs59NvPCunzrP3qxjN32KgskPGnTm/mX5HiG7Shdd54LN@vger.kernel.org, AJvYcCUrNEoo2VRq2/iydD+AgCi/4inwo5JQfrbmQNmjnh5nS3mrhpY7/rjNUbBmeRHnHJVhJzY=@vger.kernel.org, AJvYcCUuJD48a0YAxpJcIrnaHqpIj/gZ+ERo7U4dR7h2Nd1gLRkINuCON3XXx5mz8k375yBUR20z/ZZk44fb@vger.kernel.org, AJvYcCX7t3J3bnVNDcs5Jbcse53Ny/aW7wlO0g9iFZrUXZW4ff6x9Kl2TEYMDxIkTy67VggpGO6T7AKQhvli81xe@vger.kernel.org
X-Gm-Message-State: AOJu0Yydd5FvYFSBEdpH8tWS5lUiy9OBOMrk/Q9+FJB82H3ELZe2bIzG
	eIw4Y31xCupLspSFyq5YiDNw2w4zcRqWQQJgFnmyn60NTBlVjkPZ
X-Gm-Gg: ASbGncvRrB+AyGNAi7mrs7cFRQfuMyRwOiPMa5i/7h+S+eKkG2aKLAOf6hT70rEjNFx
	ZG8f81V1bvv6BvOuK17pe0B5wioXaGisQxJ4qq6D6dDAclU4POqIshLObS0Rpq4hlw8Ig4izAb2
	1o2aMohALWBPCrYeFBNX11gAdMiLeftB2QC71W5M7HizxnLpgLc+jFi17oYnnrAsA94MGBSDUsc
	4NXh+uSZ+fSX3VALE3EWULsUXWgb6nf9i4aAhF2/PgZxksN/ENPnioKjbPWvq+SGt0pMsVBdcA/
	6MpBeGy6VRPBYeLJeUnMAeU=
X-Google-Smtp-Source: AGHT+IEdwD8+gf+P54b0oq9+6IB9SKMe1dPj4BWvNK0K6VPumKorBNlE9GpHAOH2VL8CKukBAjBygw==
X-Received: by 2002:a05:6000:4009:b0:38c:24f0:fc28 with SMTP id ffacd0b85a97d-38dbb20b3d7mr501077f8f.3.1738793773653;
        Wed, 05 Feb 2025 14:16:13 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c122465sm20046771f8f.47.2025.02.05.14.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 14:16:11 -0800 (PST)
Message-ID: <88cb8f03-7976-4846-a74d-e2d234c5cf8d@gmail.com>
Date: Wed, 5 Feb 2025 22:16:18 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-6-almasrymina@google.com>
 <676dd022d1388_1d346b2947@willemb.c.googlers.com.notmuch>
 <CAHS8izNzbEi_Dn+hDohF9Go=et7kts-BnmEpq=Znpot7o7B5wA@mail.gmail.com>
 <6798ee97c73e1_987d9294d6@willemb.c.googlers.com.notmuch>
 <53192c45-df3c-4a65-9047-bbd59d4aee47@gmail.com>
 <CAHS8izMcs=3qo1jhZSM499mxHh10-oBL6Fhb2W0eKWhJGax4Bg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMcs=3qo1jhZSM499mxHh10-oBL6Fhb2W0eKWhJGax4Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/5/25 20:22, Mina Almasry wrote:
> On Wed, Feb 5, 2025 at 4:41 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 1/28/25 14:49, Willem de Bruijn wrote:
>>>>>> +struct net_devmem_dmabuf_binding *
>>>>>> +net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc)
>>>>>> +{
>>>>>> +     struct net_devmem_dmabuf_binding *binding;
>>>>>> +     int err = 0;
>>>>>> +
>>>>>> +     binding = net_devmem_lookup_dmabuf(sockc->dmabuf_id);
>>>>>
>>>>> This lookup is from global xarray net_devmem_dmabuf_bindings.
>>>>>
>>>>> Is there a check that the socket is sending out through the device
>>>>> to which this dmabuf was bound with netlink? Should there be?
>>>>> (e.g., SO_BINDTODEVICE).
>>>>>
>>>>
>>>> Yes, I think it may be an issue if the user triggers a send from a
>>>> different netdevice, because indeed when we bind a dmabuf we bind it
>>>> to a specific netdevice.
>>>>
>>>> One option is as you say to require TX sockets to be bound and to
>>>> check that we're bound to the correct netdev. I also wonder if I can
>>>> make this work without SO_BINDTODEVICE, by querying the netdev the
>>>> sock is currently trying to send out on and doing a check in the
>>>> tcp_sendmsg. I'm not sure if this is possible but I'll give it a look.
>>>
>>> I was a bit quick on mentioning SO_BINDTODEVICE. Agreed that it is
>>> vastly preferable to not require that, but infer the device from
>>> the connected TCP sock.
>>
>> I wonder why so? I'd imagine something like SO_BINDTODEVICE is a
>> better way to go. The user has to do it anyway, otherwise packets
>> might go to a different device and the user would suddenly start
>> getting errors with no good way to alleviate them (apart from
>> likes of SO_BINDTODEVICE). It's even worse if it works for a while
>> but starts to unpredictably fail as time passes. With binding at
>> least it'd fail fast if the setup is not done correctly.
>>
> 
> I think there may be a misunderstanding. There is nothing preventing
> the user from SO_BINDTODEVICE to make sure the socket is bound to the

Right, not arguing otherwise

> ifindex, and the test changes in the latest series actually do this
> binding.
> 
> It's just that on TX, we check what device we happen to be going out
> over, and fail if we're going out of a different device.
> 
> There are setups where the device will always be correct even without
> SO_BINDTODEVICE. Like if the host has only 1 interface or if the
> egress IP is only reachable over 1 interface. I don't see much reason
> to require the user to SO_BINDTODEVICE in these cases.

That's exactly the problem. People would test their code with one setup
where it works just fine, but then there will be a rare user of a
library used by some other framework or a lonely server where it starts
to fails for no apparent reason while "it worked before and nothing has
changed". It's more predictable if enforced.

I don't think we'd care about setup overhead one extra ioctl() here(?),
but with this option we'd need to be careful about not racing with
rebinding, if it's allowed.

-- 
Pavel Begunkov


