Return-Path: <linux-kselftest+bounces-22014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C46AC9C84CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 09:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379F3B25364
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF341F708B;
	Thu, 14 Nov 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YeQcY/vb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850E1F754E
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572746; cv=none; b=nOZHL2qU9O8279MmDgOOBpTeoj0DrOIat9S0agXnjDLHwxH2il+m+Q9savsg6dJt7ZyoEBgvVZMbtpjt+1ENyjr8UgoYDjNMPNfR+ra4BKb0YbmBnGqC44QKdpQU/r9pwbQWfPd96Qjni7ZX9zbVGW+7S3XAurf0uyNno5Y3/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572746; c=relaxed/simple;
	bh=6Vee8QcL7yV8USCPdLdRXuF+gIl9+D5vlFvwmciO328=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFpfRgDfkQw/cXWsgeAthei5IBlrkTVrUBUfp5RYdita568v+E1qiu4SWt0QlMAMPSJXFNsgUqqxu5ot0+H0IeX93tkN9MHbGnzMAzOjkbTlIj1dwe+PhcTGwTRrGm6MN8WOawUOShL0V8bbSjY+M2h2bZbzUUMge65pSDrL7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YeQcY/vb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e8522c10bso41947966b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 00:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731572742; x=1732177542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MUG53R1M4hAynYYPEtM8N64WD9TAg8ll+ij6nAnaJEw=;
        b=YeQcY/vbqKqONyYJik+BXADHQGPWAVOpVSSOCsf4qvRDXU6zl2aXRg2TDFLrV8GDtY
         aeTLcH6KsIp5X1wzTcNmWo5DfV8n6QYdjwRi6BSDJdCb5uhffwHA57pEZFSe09Djr7Yp
         Dt7D7mSlu0OikyOux5hSutycKLGLH/YBBbID5qyz/oWFtF1f7ijzzfccRu9DkG2b22aI
         ykJPvsd/2OnlQrkW3TOxIaxMuUH7xlLwRcPuSXAyvueAOi/HJkZ5NqWGU8mB7tlnqyTE
         YNY82CCaAhqtcy5Q6CQByVCzJHERsl//rgGDEDhf/aKqqCqw9I39KIOiJwZew+CQPU7k
         300w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731572742; x=1732177542;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUG53R1M4hAynYYPEtM8N64WD9TAg8ll+ij6nAnaJEw=;
        b=H4pqZytnCMw1foi+H5u3rVmGVggkfXKoQogYbmRNWv2fE11rtjSs5UQ4T5WXYKH+Kt
         h7/c8+nSBw1EPgMEl00fqdWO1VM1VE/9ruj459IeDkBwXRjeoETQblGABOE3qnPRt4YU
         nKWN7dJ+JRqixsWtjgBlqyQa2pyF4HEAE6fxAJel2UGaYB4bX/g/pz36w981NGvfDSLg
         yC/egF/gtgb4XvfFg8APh6A41Dw8J17lGizbuWqG2vPSJjB8wzSPjyLFSSjW5s38AQOc
         /o0EW+nmBCxI/R4ai4kTkDX3o7nGVLOxgpWYeeA7TjmxsGyeoVkRrKuHmYm4q6rFgMtj
         czkg==
X-Forwarded-Encrypted: i=1; AJvYcCVzt/fj+w+mbaazbNUMtwVEsJxbkctAgIpCI3nss+2fl29/FSPTgHeZtgOd/pKoqMJe88woLOatARbqxwSkmFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnoeVbpXOUwcD7Kapf77Gu2ZE3wkjjLDnznZ+yjanYzOZ7Wn9c
	M6c80cXqe3IizknwhMnloTPncwKoOpLtqtsnZSZr2lrDPYe56/6kCiiZZH7QhM4=
X-Google-Smtp-Source: AGHT+IHMBCARloQHWsBRhGBPdkFXRS+gu6h3BOv+wWntUo40Ek+a45U5+NJuK23CznPRgSIVLswVew==
X-Received: by 2002:a17:907:78e:b0:a99:5f45:cb69 with SMTP id a640c23a62f3a-aa207680129mr283686066b.4.1731572742262;
        Thu, 14 Nov 2024 00:25:42 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:3779:22d5:a322:7c13? ([2001:67c:2fbc:1:3779:22d5:a322:7c13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e080a90sm34629066b.174.2024.11.14.00.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 00:25:41 -0800 (PST)
Message-ID: <aa9ec51d-6842-42e3-932e-1e1bd3cde42f@openvpn.net>
Date: Thu, 14 Nov 2024 09:26:07 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 17/23] ovpn: add support for peer floating
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-17-de4698c73a25@openvpn.net> <ZzM0U81dmvdEWqdF@hog>
 <955030bd-e230-448c-8a63-1b356590dd15@openvpn.net> <ZzSMrgFmbxX9NtIp@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZzSMrgFmbxX9NtIp@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2024 12:25, Sabrina Dubroca wrote:
> 2024-11-12, 15:03:00 +0100, Antonio Quartulli wrote:
>> On 12/11/2024 11:56, Sabrina Dubroca wrote:
>>> 2024-10-29, 11:47:30 +0100, Antonio Quartulli wrote:
>>>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>>>> index 63c140138bf98e5d1df79a2565b666d86513323d..0e8a6f2c76bc7b2ccc287ad1187cf50f033bf261 100644
>>>> --- a/drivers/net/ovpn/io.c
>>>> +++ b/drivers/net/ovpn/io.c
>>>> @@ -135,6 +135,15 @@ void ovpn_decrypt_post(void *data, int ret)
>>>>    	/* keep track of last received authenticated packet for keepalive */
>>>>    	peer->last_recv = ktime_get_real_seconds();
>>>> +	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP) {
>>>
>>> What prevents peer->sock from being replaced and released
>>> concurrently?
>>
>> Technically nothing.
>> Userspace currently does not even support updating a peer socket at runtime,
>> but I wanted ovpn to be flexible enough from the beginning.
> 
> Is there a reason to do that? With TCP the peer would have to
> reconnect, and I guess fully restart the whole process (become a new
> peer with a new ID etc). With UDP, do you need to replace the socket?

At the moment userspace won't try to do that, but I can foresee some 
future use cases: i.e. a peer that switches to a different interface and 
needs to open a new socket to keep sending data.

Moreover, in userspace we're currently working on multisocket support 
(theoretically server side only), therefore I can imagine a peer 
floating from one socket to the other while keeping the session alive.

This is all work in progress, but not that far in the future.

For TCP, you're right, although at some point we may even implement 
transport reconnections without losing the VPN state (this is not even 
planned, just a brain dump).

> 
>> One approach might be to go back to peer->sock being unmutable and forget
>> about this.
>>
>> OTOH, if we want to keep this flexibility (which I think is nice), I think I
>> should make peer->sock an RCU pointer and access it accordingly.
> 
> You already use kfree_rcu for ovpn_socket, so the only difference
> would be the __rcu annotation and helpers? (+ rcu_read_lock/unlock in
> a few places)
> 
> Adding rcu_read_lock for peer->sock in ovpn_tcp_tx_work looks
> painful... (another place that I missed where things could go bad if
> the socket was updated in the current implementation, btw)
> 
> Maybe save that for later since you don't have a use case for it yet?

I agree with you. I'll make the socket unmutable again and I'll work on 
this later on.

Thanks a lot for digging with me into this.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


