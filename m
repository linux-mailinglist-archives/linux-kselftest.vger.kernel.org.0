Return-Path: <linux-kselftest+bounces-25826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03531A28A74
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA611679BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7157322A4EF;
	Wed,  5 Feb 2025 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpXQJGqi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11911EA91;
	Wed,  5 Feb 2025 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759269; cv=none; b=B6/WCrj66Mx2Ip2DYDNWnIqi2NcTDmsyaSl9AjJvNzIZT6VjnRtRzsHJuauQA7+ZqYcalmndTKMptr/H7zlx9wPQWppExttIe3XOOJsghGZINUQ9C3PuKim6lbrqnFWH9EFO1AvlZGRxyKKXECGvurzRPIfw4ojLh1koMlRnKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759269; c=relaxed/simple;
	bh=pYhD+SHOxcSft14VFZBo/hBAX8Nxq+oO+kbTLpeDLGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwlR4My36BryloBfLZLM43gfp0Qb/NqywaLWrsIRh0W4rPPVtUm99fzN0MnF9rP2H9l8sk2Sn+CQbalS1OC9iyg7JHsMa46N9bHk4nWERWbu5vy4ii0QTXRL6yxR08q5axq5Brk5agrMjCSZcFWq+0nQbfp2+SJIcInO2a3+rMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpXQJGqi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso46683815e9.3;
        Wed, 05 Feb 2025 04:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759266; x=1739364066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2nY810+IaZK5n9EujS3czHJOBsB42FBjuOFqVzxuj0=;
        b=VpXQJGqi+2bFlgONaqA0ICu/b+3eA3Thd6vDkjsfU5pop1q3MrgaKK3fQP8gbDQKFS
         Sm75cFoAoVF0NXUXH2yyNd5kuCqFqQ5XjwDeXxZgVgkpC0SVunFQX5GmjLMejKZ6sUVO
         OuCqD1iPt+holKjsZDnhxsWgH/ezbb92KsLIcd/3bAkA/bsmaTm95nXOzeXjgmsC3+uH
         f5NlO/Uu2RLWAPkOp/iXYvBwlZPTx03TkVfsqLI4PqBqemu50QVv6NvVdQBc/r3oasjA
         nb0WcA/m5xVWUF1mzJMdtF9ghK+UcxZ6G0Xk25eWGrHNjZ9FnlsV8INFql+l+BSf4sHv
         wEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759266; x=1739364066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2nY810+IaZK5n9EujS3czHJOBsB42FBjuOFqVzxuj0=;
        b=fDBvaiASZb3lC3UG+9svZyARYfs3SvMqeH6PLJD/1/a7DgEU2vMJjN4iLsNC2gPGFh
         kacQdSEwNKi6HZmXP3d0OQB99WjUKrvlmrxYX8CFoBOP5ie821zQCpWFryTki4V7RBgJ
         N56TQIJo5Md92UH/lYHHgKfp68eKrsh0B1HVVuFQJy4Um9k25l/hDciqgaPoHqkIbM3r
         AeMqcTM6/dkTAarLv2TcrY8mSH8ogQAgqrKNWc7DeufhEAA0KobFARc/R0j+IBZeaM+t
         zKv0uVTcbW0PKasF9cpyZOWbeHgphvVAnyf9daeTTe0awLzoOlXMCksiGQ/grGc1NPAP
         DYqg==
X-Forwarded-Encrypted: i=1; AJvYcCViSZhNqHZzsRDIvQ1AYGivk2x6n2ZZh8fg5zW6r7LRqk/q1IB3sMQmb0lxXh3lxMp29yIIHg5Y5uZ4/igt5HNk@vger.kernel.org, AJvYcCW/VXUSHvLFRgqxshZN3JSMgLmQd0O8PCeH4Ft/6RNMCaxB628KlA5Lg6AhDeHlb3V6/HU=@vger.kernel.org, AJvYcCWZRHW7VfwN7CwyeXoE+IIrBWXZxyoODcsBMCfcVCnK0SuCD+BvTVz4rNPCin/1AY9vwIBfX0TBX7ji@vger.kernel.org, AJvYcCWaWRU9gcosuIP6T28n9MYyQlEOlaHlfz2eVJbGhVOQW1Sy9LKcOZGZLv/Wf7ZdwtZLdmwj3+wYYBzC/9/x@vger.kernel.org
X-Gm-Message-State: AOJu0YwkbBNgkUi4faoF43F/yKxwh5H6CmEDjhTkJFB2KxDZ0xGOsibp
	aFwqJmRNhaulfwdpP8OPD3olPaL4Kz3Qhlfb0wKQMJqV79kmVIyiQa4g7Qp9
X-Gm-Gg: ASbGnctD4/FfDfFOipRFhnA/4QyJDKhXUIxdCb32vbmyp/xsGdCuQqCM8MQP+XugQVh
	7bdfaGgphGQqYZPCDHcFQt8Ga88m1ICInM4lWRO+sj9FeIyQOCgPzY/N1jej4eLGS60OcZEjzQi
	C+5X6+2RcVXheKbbfDnvAA00KYzBfXzY6/jv5M9IoXgBqAzdWT1/T8mUybo4ny8LbYXJQKyx/Dq
	fvCWy1pFKsbPfTxWYK0XYoKjGSz1AFG4JZ8sHldZI3o0jpKW5Dou7wMVblCmEVxtDKL9yzTNLCc
	SWUiVEyx5ojNQqgW7guTIp4=
X-Google-Smtp-Source: AGHT+IGPDh0UCfW8C0UUaobE12fAfZcaYcWV+qO1/+Q7RfKKWpw6BN/Izj4F094IN//LhwjnBjSyNw==
X-Received: by 2002:a5d:64af:0:b0:38b:ed6f:f012 with SMTP id ffacd0b85a97d-38db48868a1mr1958421f8f.9.1738759265611;
        Wed, 05 Feb 2025 04:41:05 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d93383asm20448845e9.7.2025.02.05.04.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 04:41:04 -0800 (PST)
Message-ID: <53192c45-df3c-4a65-9047-bbd59d4aee47@gmail.com>
Date: Wed, 5 Feb 2025 12:41:11 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <6798ee97c73e1_987d9294d6@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/25 14:49, Willem de Bruijn wrote:
>>>> +struct net_devmem_dmabuf_binding *
>>>> +net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc)
>>>> +{
>>>> +     struct net_devmem_dmabuf_binding *binding;
>>>> +     int err = 0;
>>>> +
>>>> +     binding = net_devmem_lookup_dmabuf(sockc->dmabuf_id);
>>>
>>> This lookup is from global xarray net_devmem_dmabuf_bindings.
>>>
>>> Is there a check that the socket is sending out through the device
>>> to which this dmabuf was bound with netlink? Should there be?
>>> (e.g., SO_BINDTODEVICE).
>>>
>>
>> Yes, I think it may be an issue if the user triggers a send from a
>> different netdevice, because indeed when we bind a dmabuf we bind it
>> to a specific netdevice.
>>
>> One option is as you say to require TX sockets to be bound and to
>> check that we're bound to the correct netdev. I also wonder if I can
>> make this work without SO_BINDTODEVICE, by querying the netdev the
>> sock is currently trying to send out on and doing a check in the
>> tcp_sendmsg. I'm not sure if this is possible but I'll give it a look.
> 
> I was a bit quick on mentioning SO_BINDTODEVICE. Agreed that it is
> vastly preferable to not require that, but infer the device from
> the connected TCP sock.

I wonder why so? I'd imagine something like SO_BINDTODEVICE is a
better way to go. The user has to do it anyway, otherwise packets
might go to a different device and the user would suddenly start
getting errors with no good way to alleviate them (apart from
likes of SO_BINDTODEVICE). It's even worse if it works for a while
but starts to unpredictably fail as time passes. With binding at
least it'd fail fast if the setup is not done correctly.

-- 
Pavel Begunkov


