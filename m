Return-Path: <linux-kselftest+bounces-27018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E38A3CC8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 23:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5341891015
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 22:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9C25A33B;
	Wed, 19 Feb 2025 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6TzPoW1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BCE1CAA65;
	Wed, 19 Feb 2025 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004824; cv=none; b=ryl92xBNjNLQvn+M1BCJkf8lpvzrBNAHv6Ys6CEtvm8qUM2ASrOyo3Xoj7SGNpxKgjTeMGdL496xdgC2yq/OOcwinG68g4hKsdlWz/7kaB3iXl2mpJQKtgAOnXcZEHCAS5cgT3Qs23cXDo7mH3b0FUxKaon0iTkqp6fz2AYmW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004824; c=relaxed/simple;
	bh=8Mg75jClpkM1YDf5jhDaw+K4gMVsBWTTRKTduk5CQ0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxwUNesSq2UlLOUp4HQP6wI3CyURdgB9qbmrvX4eGBoPMVTC6mT7PosnKTrswOKOmkwgstszFLK2iYWJ48YkPK4KwMgWdqsCL+syw++Y6DSX7LCflXpK4SFYk/4UtrpCh3XGuWU1FpL9o8shbS1mUB4Sd/E2+ktCjGCkNBnhImg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6TzPoW1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43690d4605dso1706385e9.0;
        Wed, 19 Feb 2025 14:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740004819; x=1740609619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vrp/fBKUqrg/kv/ORpAWE3DQJG3A8sYFw9zN0z92NYg=;
        b=Q6TzPoW1qI6ujyeH+iEvVIg9bDfD6i8mHmR237RKULCI8fYs28tD46YWtgnk3Mar7R
         +e43tmUa23Vc1j8Ohl8rRUdYM8M7w7qw3wImjjvF3nFC5RYZfzNQpp0ls6zLvv3Niydl
         3xtppNSGtQaHGK30FjpN4GPhCQhNroItdRCbJB962GS0OyCBQJOo24h8jBAWpNmUoSGj
         MLWcIZS8k0Ocqof0kt+bzfU6zlnsmPtgVM0gseL8nqD0reON88mpcOODfCUZKpFoOAef
         HjILNW4MsIQu1xqIBQ0yWYcjdyNnHgSDc1Gr/oatoydPTE9mQBWeUFG0YzVbHtBcI7Ev
         y0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740004819; x=1740609619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vrp/fBKUqrg/kv/ORpAWE3DQJG3A8sYFw9zN0z92NYg=;
        b=J91ke25T1vT94+RrDyS95ZlY4WoEAWJKVdMkIyEo75+gwPyt5E4+IP9JeKGB3Njnsf
         me8p9JSvOWH90XgXSGlJZtUCmEOmLtlXOAgDHoot1Y3IVHUDA0zyYVc1PkNttwSCUN43
         sTm/Z+9cF5K6nnk1yRjqhZq/Kyegs6xVNLmfWyJGQm38FUtohNxfU1m2Dt7LsCTzsDkf
         xS5GQoCHtB4qG0nSfuwPWVlpaPrcx+Hh7M1gjBqy2OZnJm7iECXfx5xXaTCYz90Genil
         otgByfHL+49QPEeRvdr8v9tigkJOMRwWVo4R71nQxWwtsq2WKVM3EPNTzNpTvgUrikdG
         gf/g==
X-Forwarded-Encrypted: i=1; AJvYcCU6zbMKmzHLa+NjQEtjxdg/pywcC7oMjXaLuC0D0/DUmxLW2kUVyqp21pbKkc8xEMMsf+XtcKKws6eIDuN4rhrp@vger.kernel.org, AJvYcCUPJExUNyXjOJrrnVfOHICL3mBdwpoQsuG1uXL51lCzLXjGrXnEHPJkULM2ej0t3KjYWCq9gJwGA7oZ+lEO@vger.kernel.org, AJvYcCUSbHs3tAyODEzuOROPR9RMUy+kv1kc/g5vpCeFAYnDclSVs7JdBltmxBzusxi8AadbVZs=@vger.kernel.org, AJvYcCVfBk6rSIJoaPPAaY7bct/TmrVeBIoQdPU+q1DUTzzg7eHIglgllKV/XwnbvELNTj9myTqA2NAGnJaz@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBdJj1M7PZwNO17sMQ3/b9Nkd9LCn1ytyUqKLncpd/HHdV6Zt
	5E7glC+oBxgj/y3C7klFdvBmTL91fB9zux12xhhvcFk3Uh6zu9VH
X-Gm-Gg: ASbGncuvTvCaOTJB84AeXpU/rhDRaPN459mVS5yUVM8FDNt7zQRAOmZl4D4Q58xI+cg
	OAn8obWjwWErLRwbv+i2ZhVlJkl+drH2n6Yct0Ii133NeDlqDXyeUUN0Gfxhdtlew1fS0oUq9R9
	+3gqIt1OgPcPqSU53tuUQj7NnF7a6AR1Yi7JHMQdC1kVkdH83pO/p29U0axUjHHuErUY00AZXh4
	k80Ly3utt3xfbjuZ6e3QpLHfdYIowd/3CKYng5v1wJgZpj8tL+guoXK93mwo2oMxKVvw3KuQl88
	7K5XcuiReKFL6O6lwi1pomvQ
X-Google-Smtp-Source: AGHT+IHdEPtErxH8tweBsaBsHHLXYXev0UX3+JoIgfASCAjj1RolZY34QS5v5Mk2MKGpYvQ0fbmuAA==
X-Received: by 2002:a05:600c:458f:b0:439:8a8c:d3e1 with SMTP id 5b1f17b1804b1-4398a8cd6b3mr103365215e9.22.1740004819062;
        Wed, 19 Feb 2025 14:40:19 -0800 (PST)
Received: from [192.168.8.100] ([148.252.145.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43994f0c10csm58014075e9.26.2025.02.19.14.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 14:40:17 -0800 (PST)
Message-ID: <4cdfaff8-0623-4d3a-9204-5165ccbb84db@gmail.com>
Date: Wed, 19 Feb 2025 22:41:17 +0000
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
 <9210a12c-9adb-46ba-b92c-90fd07e1980f@gmail.com>
 <CAHS8izPHtk5x-W05_svxU53X-V4+++PiYErCgfr-3iDGgEaUig@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPHtk5x-W05_svxU53X-V4+++PiYErCgfr-3iDGgEaUig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/17/25 23:26, Mina Almasry wrote:
> On Thu, Feb 13, 2025 at 5:17 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
...
>>>>> It's asserting that sizeof(ubuf_info_msgzc) <= sizeof(skb->cb), and
>>>>> I'm guessing increasing skb->cb size is not really the way to go.
>>>>>
>>>>> What I may be able to do here is stash the binding somewhere in
>>>>> ubuf_info_msgzc via union with fields we don't need for devmem, and/or
>>>>
>>>> It doesn't need to account the memory against the user, and you
>>>> actually don't want that because dmabuf should take care of that.
>>>> So, it should be fine to reuse ->mmp.
>>>>
>>>> It's also not a real sk_buff, so maybe maintainers wouldn't mind
>>>> reusing some more space out of it, if that would even be needed.
>>>>
>>>
>>> netmem skb are real sk_buff, with the modification that frags are not
>>
>> We were discussing ubuf_info allocation, take a look at
>> msg_zerocopy_alloc(), it has nothing to do with netmems and all that.
>>
> 
> Yes. My response was regarding the suggestion that we can use space in
> devmem skbs however we want though.

Well, at least I didn't suggest that, assuming "devmem skbs" are skbs
filled with devmem frags. I think the confusion here is thinking
that skb->cb you mentioned above is about "devmem skbs", while it's
special skbs without data used only to piggy back ubuf allocation.
Functionally speaking, it'd be perfectly fine to get rid of the
warning and allocate it with kmalloc().

...
>>> But MSG_ZEROCOPY doesn't set msg->msg_ubuf. And not setting
>>> msg->msg_ubuf fails to trigger msg->sg_from_iter altogether.
>>>
>>> And also currently sg_from_iter isn't set up to take in a ubuf_info.
>>> We'd need that if we stash the binding in the ubuf_info.
>>
>> https://github.com/isilence/linux.git sg-iter-ops
>>
>> I have old patches for all of that, they even rebased cleanly. That
>> should do it for you, and I need to send then regardless of devmem.
>>
>>
> 
> These patches help a bit, but do not make any meaningful dent in
> addressing the concern I have in the earlier emails.
> 
> The concern is that we're piggybacking devmem TX on MSG_ZEROCOPY, and
> currently the MSG_ZEROCOPY code carefully avoids any code paths
> setting msg->[sg_from_iter|msg_ubuf].

Fwiw, with that branch you don't need ->msg_ubuf at all, just pass
it as an argument from tcp_sendmsg_locked() as usual, and
->sg_from_iter is gone from there as well.

> If we want devmem to reuse both the MSG_ZEROCOPY mechanisms and the
> msg->[sg_from_iter|ubuf_info] mechanism, I have to dissect the
> MSG_ZEROCOPY code carefully so that it works with and without
> setting msg->[ubuf_info|msg->sg_from_iter]. Having gone through this
> rabbit hole so far I see that it complicates the implementation and
> adds more checks to the fast MSG_ZEROCOPY paths.

If you've already done, maybe you can post it as a draft? At least
it'll be obvious why you say it's more complicated.

> The complication could be worth it if there was some upside, but I
> don't see one tbh. Passing the binding down to
> zerocopy_fill_skb_from_devmem seems like a better approach to my eye
> so far

The upside is that 1) you currently you add overhead to common
path (incl copy), 2) passing it down through all the function also
have overhead to the zerocopy and MSG_ZEROCOPY path, which I'd
assume is comparable to those extra checks you have. 3) tcp would
need to know about devmem tcp and its bindings, while it all could
be in one spot under the MSG_ZEROCOPY check. 4) When you'd want
another protocol to support that, instead of a simple

ubuf = get_devmem_ubuf();

You'd need to plumb binding passing through the stack there as
well.

5) And keeping it in one place makes it easier to keep around.

I just don't see why it'd be complicated, but maybe I miss
something, which is why a draft prototype would explain it
better than any words.

> I'm afraid I'm going to table this for now. If there is overwhelming
> consensus that msg->sg_from_iter is the right approach here I will
> revisit, but it seems to me to complicate code without a significant
> upside.

-- 
Pavel Begunkov


