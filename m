Return-Path: <linux-kselftest+bounces-27516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55519A44982
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCD91888DC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AD619CC06;
	Tue, 25 Feb 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVmnxV6o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744A15445D;
	Tue, 25 Feb 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506610; cv=none; b=qh447+iMZhDHmNpTqYZ/UlC7DTg15GO4WRMevk59h1h2kdwmc2yXE/33j1BLvIO2tV45u2WENNj+JYHgjq7MsNJCvalXYNvEMZEks8Cwv9BM1UmrSEGL9Jt5OPhMSlctFCewoYf/zv+t4s0W2zy4RHTgJqL5QQqYGc8hO8auaWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506610; c=relaxed/simple;
	bh=DCOUoVzVNSydpQ/dS03bguPxoI1g9gTndpvRpxQgL5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srth9ON8cS7uxndXqUHBDmn9wpykmuZ+mn7qV5y1maA+YtJAU7Mx5QyF9K42QD+sYLEzHKYXXrKvvBHfDdlWluSJXAAjFEUWGE4kfCHe+cmYGfhPAAriq6CXlhiglvjXI6Kyz3mZz7vnDLrb/bQAo2hyrHwRrDrs4TgY5lwEF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVmnxV6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989D2C4CEDD;
	Tue, 25 Feb 2025 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740506610;
	bh=DCOUoVzVNSydpQ/dS03bguPxoI1g9gTndpvRpxQgL5U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gVmnxV6oNNkD0+ncPquUaGL++hfjCkZTHvhFuvpdtUabzc6pemipfQ4iZYzu83xon
	 pRwkkf5xh/DVcSTsBOX65vog+SrmsoUmcy6ISp3y3vPCDVurmE28vRuAbOA/+Ya32A
	 JKlciHKttoak86VlLAj2HyuQbfVQNMDQmXlqq6l7ILI7CC/yt2TIsGXOa7JBex7k9t
	 65QZV1j/M3zjdFuI0UtXgEQwMl9DrT46m6rptwZ/UblGoodb8aOozG/rzaulK2Gabh
	 4Pk7Gy6R/BzrOashE02ihMAjxNzjWR1VF0rYixW9TLQ5/hZRNb8Zwm8AQ0/nOtbqBq
	 3Lfft0A1FtP7A==
Message-ID: <a003b144-0abf-4274-abff-a6e391a3e20b@kernel.org>
Date: Tue, 25 Feb 2025 11:03:27 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/9] net: devmem: Implement TX path
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-4-almasrymina@google.com>
 <a814c41a-40f9-4632-a5bb-ad3da5911fb6@redhat.com>
 <CAHS8izNfNJLrMtdR0je3DsXDAvP2Hs8HfKf5Jq7_kQJsVUbrzg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izNfNJLrMtdR0je3DsXDAvP2Hs8HfKf5Jq7_kQJsVUbrzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/25/25 10:41 AM, Mina Almasry wrote:
> On Tue, Feb 25, 2025 at 5:04 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 2/22/25 8:15 PM, Mina Almasry wrote:
>> [...]
>>> @@ -119,6 +122,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>>>       unsigned long xa_idx;
>>>       unsigned int rxq_idx;
>>>
>>> +     xa_erase(&net_devmem_dmabuf_bindings, binding->id);
>>> +
>>> +     /* Ensure no tx net_devmem_lookup_dmabuf() are in flight after the
>>> +      * erase.
>>> +      */
>>> +     synchronize_net();
>>
>> Is the above statement always true? can the dmabuf being stuck in some
>> qdisc? or even some local socket due to redirect?
>>
> 
> Yes, we could have have netmems in the TX path in the qdisc or waiting
> for retransmits that still have references to the dmabuf, and that's
> fine here I think.

skbs with references to netmem from a dmabuf can get stuck in retransmit
queues for a long time. The comment should at least acknowledge that.



