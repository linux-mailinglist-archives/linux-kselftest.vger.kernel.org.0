Return-Path: <linux-kselftest+bounces-23055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 434AE9E9B9D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 17:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290AD2812B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911C6148316;
	Mon,  9 Dec 2024 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN+xj6jh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86D1474C9;
	Mon,  9 Dec 2024 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761619; cv=none; b=F61IX+evcqCQw814Bcj29XioqUld11ThGDiywCIUKYzUuHGAtENAtllTgJihNimWcX3LWS55Xk4IfWLXgc7n5Ji6WAvryPobzkl2kLd6WOwX54dV2CWIZzoMAvmI0RCg508Eq08AhlZv7yEtjjG/qN3W3AfyEoLgqZ+e08YDvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761619; c=relaxed/simple;
	bh=70s4BHZFldWeAL3yPeGci5plIEHzNmGXbTPLv9Fto+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTvMwzpmJfTEWEyXwPTuBTvkicUj/MAMkU/K3U3kCcqCsxl4SrvbEdGD4Q+WgdYm0MVyq1ce86jI8e1OKYj3XuY/Vcj5OH6j39aI38z7U3ycVmArB/+N42s0W9aLl4R/QAnSB/4VcKjMSV7XySLr1CQsECKBHCEnukA+k1LvxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN+xj6jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAECDC4CED1;
	Mon,  9 Dec 2024 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733761618;
	bh=70s4BHZFldWeAL3yPeGci5plIEHzNmGXbTPLv9Fto+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uN+xj6jhKTV/GSloqEzcg/XJisdudFqqpka/VHNw8JxYmmpXLrBEy6ZOvSAQs6dVO
	 PPdBz0y02mzU+bYYt/zib236PaSTb6L3otSB3cHiYH2spym5hr76FWa2LhBW/L7MDk
	 eM8gWnuyua4x61D9yCY9j8ZI6alGLNburTP8tBdoofkrXHR85HLCDQ1BqYh5IrdvWC
	 RIIxmcVW4LC3JrHzj8Q35EEf6/U01/XV9i5/1yykOA1LgL1FD+dl7clUBuUtgBboFq
	 m61DJ+M6cDFmtMmXvzbp6YR95ln0QmSiDd5FMyMtNLn/zklu6tkpa78TP6iszs0dVn
	 V2neqgtaztIYQ==
Message-ID: <4b9ce06a-8ece-4951-b660-05ac1afd1a5f@kernel.org>
Date: Mon, 9 Dec 2024 17:26:52 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v12 11/22] ovpn: implement TCP transport
Content-Language: en-GB
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-11-239ff733bf97@openvpn.net>
 <784fddc4-336c-4674-8277-c7cebea6b94f@redhat.com>
 <2a1b614c-c52d-44c7-8cb8-c68a8864508d@openvpn.net>
 <8714deae-c1f7-42ff-9e76-fabd9ca5188b@openvpn.net>
 <17e7d4c6-4912-4d5e-8723-45a06a1ad529@openvpn.net>
 <813d75bf-1d7f-472b-967f-27ab8f9d4759@kernel.org>
 <e447ef89-e7f1-4c5b-871e-d1cfaa045c6c@openvpn.net>
 <c34748e0-44ad-4775-abd5-52034c4f5fdc@kernel.org>
 <cb84c0e5-8ee9-4860-a8db-8787c44a703a@openvpn.net>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cb84c0e5-8ee9-4860-a8db-8787c44a703a@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/12/2024 15:08, Antonio Quartulli wrote:
> On 09/12/2024 12:31, Matthieu Baerts wrote:
>> On 09/12/2024 11:58, Antonio Quartulli wrote:
>>> On 09/12/2024 11:46, Matthieu Baerts wrote:
>>>> Hi Antonio,
>>>>
>>>> Thank you for working on this, and sharing your work here!
>>>>
>>>> On 05/12/2024 00:09, Antonio Quartulli wrote:
>>>>> On 04/12/2024 23:52, Antonio Quartulli wrote:
>>>>>> Paolo,
>>>>>>
>>>>>> On 04/12/2024 12:15, Antonio Quartulli wrote:
>>>>>> [...]
>>>>>>>>> +        mutex_lock(&tcp6_prot_mutex);
>>>>>>>>> +        if (!ovpn_tcp6_prot.recvmsg)
>>>>>>>>> +            ovpn_tcp_build_protos(&ovpn_tcp6_prot,
>>>>>>>>> &ovpn_tcp6_ops,
>>>>>>>>> +                          sock->sk->sk_prot,
>>>>>>>>> +                          sock->sk->sk_socket->ops);
>>>>>>>>> +        mutex_unlock(&tcp6_prot_mutex);
>>>>>>>>
>>>>>>>> This looks like an hack to avoid a build dependency on IPV6, I
>>>>>>>> think
>>>>>>>> the
>>>>>>>> explicit
>>>>>>>
>>>>>>> I happily copied this approach from
>>>>>>> espintcp.c:espintcp_init_sk() :-D
>>>>>>>
>>>>>>>>
>>>>>>>> #if IS_ENABLED(CONFIG_IPV6)
>>>>>>>>
>>>>>>>> at init time should be preferable
>>>>>>
>>>>>> To get this done at init time I need inet6_stream_ops to be
>>>>>> accessible, but it seems there is no EXPORT_SYMBOL() for this object.
>>>>>>
>>>>>> However, I see that mptcp/protocol.c is happily accessing it.
>>>>>> Any clue how this is possible?
>>>>>
>>>>> I answer myself: mptcp is not tristate and it can only be compiled as
>>>>> built-in.
>>>>
>>>> Indeed, that's why.
>>>>
>>>> Talking about MPTCP, by chance, do you plan to support it later on? :)
>>>
>>> Hi Matthieu,
>>>
>>> It is not on our current roadmap (TCP doesn't get much love in the VPN
>>> world), but I agree it could be an interesting option to explore!
>>
>> I understand, it makes sense not to recommend using TCP for the
>> transport layer for tunnelling solutions.
>>
>>> I have to admit that I haven't played much with MPTCP myself yet, but I
>>> am more than happy to talk about potential advantages for the ovpn use
>>> case.
>>
>> Some people told me they were interested in using OpenVPN with MPTCP to
>> use multiple (low-capacity) network links at the same time. I think
>> intercepting and proxying TCP traffic would always be the best in terms
>> of performances, but using OpenVPN with MPTCP seems to be enough for
>> some, especially when they want to "improve" some type of UDP traffic
>> that cannot be intercepted: QUIC, VPN, etc.
>>
>> I don't have numbers to share, but I can understand this feature can
>> help in some cases.
> 
> Yeah, some people may definitely benefit from this feature.
> I'll have a look at MPTCP once ovpn is merged.

Thank you :)

Don't hesitate to email the ML, or open an issue on the GitHub repo if
needed!

(More details: https://www.mptcp.dev/#communication)

>> (This reminds me this: https://github.com/OpenVPN/ovpn-dco/issues/60)
>> (and this: https://github.com/arinc9/openvpn/pull/1)
> 
> Right, this definitely shows some interest and it means we should easily
> find people willing to test :-)
Indeed!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


