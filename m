Return-Path: <linux-kselftest+bounces-21211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B469B7B75
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5163F281250
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8E19E985;
	Thu, 31 Oct 2024 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BhFxCH+I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AA19DF4F
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380355; cv=none; b=n0glCqZNx7FNTvxJ/ZzYwxVYBnSa7MrjrE1YyQzyJfLBO9TbaVpLTB6XbRjTPJ8Via0Ox2z8MCZFWN9NNR7LXEcwoy6N+Y/MzUireTKjOgG0FGeUl6wSgB4bDJUWJDLpqW6lb7JUo0NpU+zwBpEHkXnPSga/VWC5SGrgPUBevJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380355; c=relaxed/simple;
	bh=ym1N7c/6t26tf3cwKfcmnn3Yn8xExbWlFoew4YMulTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbYykwSm6D0wSBw6Rl4mjVLZvlXiMG8pDOcWhRW4fPtEh5lvyAzG70XFNqdWru60YPNCXtENo75eytNM4vvGtvByEtyqwgAt+vfuUBmuWomsXl6TesMtdy4Rnh8lfDwjEC0l+XoEkq0wlsUxXQmHvW8NVncPSQSRT6eTcIs4Wms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BhFxCH+I; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb518014b9so7530041fa.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730380350; x=1730985150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd/LPVoyjETqDW8hwsq6kKowR64Os6FT/cO5AcmEZkM=;
        b=BhFxCH+Ibexl7n0cs1uXSeV2kFbkk5kp/4tOyTdkFOAPaRRShaFbecptmRRwAeB9Wg
         FWMA9EiEN/WRhGIUG+er5HiG78dUoQUoLdiT/cEgIlIrunu1Fd/+UqbaG47mDHY3exB8
         WilWwytvu1XiRKX5xwJi4Avgle10KXDPzwpO53SzxiH7qHr2s61e22qX06beTMZL841a
         dfZF+sfyAT6hl6sSFLH1dJuB0thjxo5GuWZQKAq1zsMwz8TvbFr3APFbvmWwAR1ijccy
         2wMtPY//b46PFSkGQJt5wqoBBgecsE8dzl4PRh0NikQktQMdoC8bPUUg8IHBCK08G1NI
         /1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730380350; x=1730985150;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd/LPVoyjETqDW8hwsq6kKowR64Os6FT/cO5AcmEZkM=;
        b=HclIr50j3yoO5G+KTNTXE9shGVOIJ/BDU6DLUNkbD6GiaX0ayTEq5yeHqZKRaFl1qW
         AUNNb+XEqZeEWy5jM0chPmrArseQpPMXvLvHWdmUWpR5ftH7iEnj80jydHto5ZVdYsjg
         hpMr+KJoGbWv8N7QKoHFGEWxRMkAWvhnpd/wcDJ8q+XqmvLAJph5fXJBb6bSFzUocJcO
         sucLAOV7+7lNNttyv+WfFEUudqKnzAOBpHOcNCcHp386gob9SMccPbC6L8SUZZul93yi
         rj6pvCg6UTr2njc27D00n7NtYl0DTv+2oeuSsAOKvn+iJ/DFBUIkSke4BehQMCrwVX+A
         D69w==
X-Forwarded-Encrypted: i=1; AJvYcCUeUZngz7Jk7z/NDWLJLbVCBQAvJtouoBEU1JtxCLJh2PV0VoJct3EHaQ17DuFy2KasxJXaf40m3Kfj9NEgFJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGckrnTUYCEoNqhEt/zPYbZ3ue76WS/SS2+PHQt1pUFWUiNjJ
	/0ZhXmsG+KEI55Fqg2Gxoss+qzNqXGU7XBfd4QsQCzxavGLF6yXsr5uzLDKrn+Q=
X-Google-Smtp-Source: AGHT+IGwfCnMclAPIygCvndVaVYKRM/k1M1XD+ZIVh82kXsNZRIL+Dj41Kg6TyhmPNfbB7wFa7tdqQ==
X-Received: by 2002:a05:651c:19ab:b0:2fb:8774:4412 with SMTP id 38308e7fff4ca-2fcbdfc9303mr81193491fa.24.1730380349566;
        Thu, 31 Oct 2024 06:12:29 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:634e:2582:d0aa:ee79? ([2001:67c:2fbc:1:634e:2582:d0aa:ee79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac770204sm601592a12.35.2024.10.31.06.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 06:12:29 -0700 (PDT)
Message-ID: <41d80bb3-0bcc-44da-a5f0-d933d7c0e85a@openvpn.net>
Date: Thu, 31 Oct 2024 14:12:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 11/23] ovpn: store tunnel and transport
 statistics
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-11-de4698c73a25@openvpn.net> <ZyNsFyx3fUtVxSSy@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZyNsFyx3fUtVxSSy@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/10/2024 12:37, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:24 +0100, Antonio Quartulli wrote:
>> @@ -136,6 +139,10 @@ void ovpn_decrypt_post(void *data, int ret)
>>   		goto drop;
>>   	}
>>   
>> +	/* increment RX stats */
>> +	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
>> +	ovpn_peer_stats_increment_rx(&peer->link_stats, orig_len);
> 
> [I don't know much about the userspace implementation, so maybe this
> is a silly question]
> 
> What's the value of keeping track of 2 separate stats if they are
> incremented exactly at the same time? Packet count will be the same,
> and the difference in bytes will be just measuring the encap overhead.
> 
> Should one of them be "packets/individual messages that get received
> over the UDP/TCP link" and the other "packets that get passed up to
> the stack"?

You're correct: link_stats if "received over the TCP/UDP socket", while 
vpn_stats if what is passing through the ovpn virtual device.

Packet count may not match though, for example when something happens 
between "received packet on the link" and "packet passed up to the 
device" (i.e. decryption error).

This makes me wonder why we increment them at the very same place....
link_stats should be increased upon RX from the socket, while vpn_stats 
just before delivery. I'll double check.

> 
> 
>> @@ -197,6 +206,8 @@ void ovpn_encrypt_post(void *data, int ret)
>>   		goto err;
>>   
>>   	skb_mark_not_on_list(skb);
>> +	ovpn_peer_stats_increment_tx(&peer->link_stats, skb->len);
>> +	ovpn_peer_stats_increment_tx(&peer->vpn_stats, orig_len);
>>   
>>   	switch (peer->sock->sock->sk->sk_protocol) {
>>   	case IPPROTO_UDP:
> 
> And on TX maybe something like "packets that the stack wants to send
> through the tunnel" and "packets that actually make it onto the
> UDP/TCP socket after encap/encrypt"?

Correct.

Same issue here. Increments should not happen back to back.


Thanks a lot for spotting these.

Regards,


> 

-- 
Antonio Quartulli
OpenVPN Inc.


