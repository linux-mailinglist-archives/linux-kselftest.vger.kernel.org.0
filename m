Return-Path: <linux-kselftest+bounces-25869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8E9A29C8A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 23:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E206166F72
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 22:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD937218EA2;
	Wed,  5 Feb 2025 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih9lYxWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C521771B;
	Wed,  5 Feb 2025 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794148; cv=none; b=Y2LPiR6+hBd3tWWbwkzLOWmcEqewtYX55xAntqdxoD+ErafLE309MmxA5YrDc12xmlCTDiI+rAg2ftoQ9DFN4yAH1DKKjQOBaqf6b91OX25c7B/jrVjqr068RSfRV+hcSxCZtnbXXnsbZ3yuUxvOKwIxc1vV31CKg8b0QDOi5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794148; c=relaxed/simple;
	bh=L5+gFo1PzgCs5Jp92HGhCtO8WHR+/AY/PyDVD8OBrdU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rqLcOqX243kNR5bPp6vwgaLWmRFy8E7BrZDasEzuIxJG6V1C7mBRGXmIzRhFB0xYi/xwTuYTT8lNmp6I3JuIbq8k0mGr7AlH9BHYCSlCdD2xYzTJlf444j5c4POj/YGo6ltLmUV2oCAwGSdbKkhLbCFmmMH1A1j+6kVdunArgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih9lYxWZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38daf09d37fso169179f8f.1;
        Wed, 05 Feb 2025 14:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738794145; x=1739398945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SwjF2roasaF9WKDWEuBN69sTQIF/a3x7vDSFw8cR7Hs=;
        b=ih9lYxWZ5zk9Jkcmp0Az4W1tVNeRv3VwW3P5fze6qf+80vsg6890MTsR/2IH2ssrFA
         fKJri5c//5gvCp1Or/Gq9dn2CDPSjrJhjyHV6DM1NCkTvKJHUIqx89+FmGs+ELXfD08t
         vxX4tK9q5u5tvdpYWC9ToPd1fmsNzgTggJnDqoHZJinoLu5yQ8QNf2mnEqnFTGvCBIvS
         Q4E4cQgDGcbKtRVq3huT7QAYZpMvmI1XQYDD6GrtDSkqIkfo6ukeAU5OQx3Dst3CFRWO
         +HU+ClBJr78uqPmH8iOalJYy3HvFQKIF8oCaHhzGD0Am7dWi4LdGKoSpQiLZaXpskobP
         HHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794145; x=1739398945;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwjF2roasaF9WKDWEuBN69sTQIF/a3x7vDSFw8cR7Hs=;
        b=DiyVYlYQ/H/BcCgcniRjwwNQpwMke6h8GQRyeT0sVZCk3o83PG2RlDZjVaPk0hAq9A
         WFgIHV7YBycvZ/4SBfdnHIx1Y9/JvSQx8nf8TEYPt66V2taSZurTFNa4Kbj19l7dtuf5
         Wymw8lD3ZjQ69VQ3nvY3yIsc8Bwdj0usBVv3UvbuiRuNETMoZfH+G5DIVTrmJRUiAtG1
         1Ipb+DO/IPSoNwOOo3kVq6JmlCPbSPDypqeUM68o9RyukcPu02P36AYtt878IW7Dxkf9
         xsHn+tbM3eSirmsfzATWLVClLDKEpHzjjxx/4nKqJhIUl4CFRS6IxoLoxfIv4zwrLM/b
         x7YA==
X-Forwarded-Encrypted: i=1; AJvYcCU0SFEkgZqHzwnAmrP2hym1zkYHBDbLUYUj2FDF6tzxNGQsMpGRlwajDolcII1ADUXuPYk=@vger.kernel.org, AJvYcCUmzBclW09QaZW92/31enR+VOFSaP7YtgaO7kwFwB56JlWdUAhfW1i2AT0hnYOyj5bON9VSz5ifkjvUWz3P@vger.kernel.org, AJvYcCV+l3/1JxZ8d0fwmEmzn/lp8SpTQuoySQ1AauH3UQHoN1Hfs1rfyPUwanyVK55QHJBECabmfsuddU6A@vger.kernel.org, AJvYcCVS3jMTAzv/IDR1YPspkT7zU9A8FYMuHGT/zCHmqHjRWVKuKLt69TCvX7Hwt4bOFZ9uDHTkoCVg9uAZHs1bg8NG@vger.kernel.org, AJvYcCXKlx8s5xO5l/JAxw+0fO/K6rH25hLEi+XiHs4oQjYSUx1LAnPQliCbBHIfZ9HzImo4II2IKxAr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy31cLa8lhSrndhzAiqLyUJUa2OafqRNVe4zJuJOy6ppvVUSigj
	Pbb18d6D5N2Y0cBD+pQnlMB7jz1nOgPp0IXRXDz+TeV/6Mu3OlAU
X-Gm-Gg: ASbGncvs17tfBsX96eUFsggdsUyUVU5LfcxF5RRhxYypIDiQUheX+QD1vLzQMp53iwP
	XZjndp1TZ8f9kAbSvobaL9dzvyz1rt6evpdToaodWkrtAdL6arfuQwAc2eH8xR20yKUlLwYOJSJ
	05j/pRd8KJh+oq4idIY9VIKifzay0IsP/UXpCB/SEXFMwc/vXhV9c7j42LnLA1DUUjAwUb3ckGG
	yChbqCSaFwAk/zstbK1wZ91kH1rEkcJJd31M7uDqoWu0e6pYZD3oE1ixqnnjOy+hw4D5qT6oJBr
	h7fhZPgVDhtuVJ8ODCW0fUY=
X-Google-Smtp-Source: AGHT+IGWIhR1wpIA15Y21sf5pVUB30nHoofpzKsEw372JxakdAjiAFVNteXkr2tTjpZZLcb+sr4t0g==
X-Received: by 2002:a5d:588a:0:b0:38a:88ac:f115 with SMTP id ffacd0b85a97d-38db492a0e4mr3552492f8f.34.1738794144946;
        Wed, 05 Feb 2025 14:22:24 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d9335b6sm35078125e9.2.2025.02.05.14.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 14:22:24 -0800 (PST)
Message-ID: <76880ee8-d5ce-458d-b165-c11ce1a23c76@gmail.com>
Date: Wed, 5 Feb 2025 22:22:31 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
From: Pavel Begunkov <asml.silence@gmail.com>
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
 <88cb8f03-7976-4846-a74d-e2d234c5cf8d@gmail.com>
Content-Language: en-US
In-Reply-To: <88cb8f03-7976-4846-a74d-e2d234c5cf8d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/5/25 22:16, Pavel Begunkov wrote:
> On 2/5/25 20:22, Mina Almasry wrote:
>> On Wed, Feb 5, 2025 at 4:41 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>
>>> On 1/28/25 14:49, Willem de Bruijn wrote:
>>>>>>> +struct net_devmem_dmabuf_binding *
>>>>>>> +net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc)
>>>>>>> +{
>>>>>>> +     struct net_devmem_dmabuf_binding *binding;
>>>>>>> +     int err = 0;
>>>>>>> +
>>>>>>> +     binding = net_devmem_lookup_dmabuf(sockc->dmabuf_id);
>>>>>>
>>>>>> This lookup is from global xarray net_devmem_dmabuf_bindings.
>>>>>>
>>>>>> Is there a check that the socket is sending out through the device
>>>>>> to which this dmabuf was bound with netlink? Should there be?
>>>>>> (e.g., SO_BINDTODEVICE).
>>>>>>
>>>>>
>>>>> Yes, I think it may be an issue if the user triggers a send from a
>>>>> different netdevice, because indeed when we bind a dmabuf we bind it
>>>>> to a specific netdevice.
>>>>>
>>>>> One option is as you say to require TX sockets to be bound and to
>>>>> check that we're bound to the correct netdev. I also wonder if I can
>>>>> make this work without SO_BINDTODEVICE, by querying the netdev the
>>>>> sock is currently trying to send out on and doing a check in the
>>>>> tcp_sendmsg. I'm not sure if this is possible but I'll give it a look.
>>>>
>>>> I was a bit quick on mentioning SO_BINDTODEVICE. Agreed that it is
>>>> vastly preferable to not require that, but infer the device from
>>>> the connected TCP sock.
>>>
>>> I wonder why so? I'd imagine something like SO_BINDTODEVICE is a
>>> better way to go. The user has to do it anyway, otherwise packets
>>> might go to a different device and the user would suddenly start
>>> getting errors with no good way to alleviate them (apart from
>>> likes of SO_BINDTODEVICE). It's even worse if it works for a while
>>> but starts to unpredictably fail as time passes. With binding at
>>> least it'd fail fast if the setup is not done correctly.
>>>
>>
>> I think there may be a misunderstanding. There is nothing preventing
>> the user from SO_BINDTODEVICE to make sure the socket is bound to the
> 
> Right, not arguing otherwise
> 
>> ifindex, and the test changes in the latest series actually do this
>> binding.
>>
>> It's just that on TX, we check what device we happen to be going out
>> over, and fail if we're going out of a different device.
>>
>> There are setups where the device will always be correct even without
>> SO_BINDTODEVICE. Like if the host has only 1 interface or if the
>> egress IP is only reachable over 1 interface. I don't see much reason
>> to require the user to SO_BINDTODEVICE in these cases.
> 
> That's exactly the problem. People would test their code with one setup
> where it works just fine, but then there will be a rare user of a
> library used by some other framework or a lonely server where it starts
> to fails for no apparent reason while "it worked before and nothing has
> changed". It's more predictable if enforced.
> 
> I don't think we'd care about setup overhead one extra ioctl() here(?),
> but with this option we'd need to be careful about not racing with
> rebinding, if it's allowed.

FWIW, it's surely not a big deal, but it makes a clearer api.
Hence my curiosity what are the other reasons.

-- 
Pavel Begunkov


