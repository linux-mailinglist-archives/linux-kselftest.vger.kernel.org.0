Return-Path: <linux-kselftest+bounces-21861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C30F99C5A21
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 15:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EAACB3A7CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6689E1442F3;
	Tue, 12 Nov 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="R1fGFGwp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12261EF01
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417627; cv=none; b=IRC+ZMiSrzXmRrHhK4BL2R7CQ71qWCAR6BPl2gU1v8WbUKWglun2wuqR+gDSJTYigBd9EJ9z5QUDgAB/0QasVF9mvjax9tTrIY4RLF0a4CElz0jzXLmJgLP0rPfc3uKfWNsQlp/X23kJp92YukhE3L8rM+idLxrs15yC8QC2ckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417627; c=relaxed/simple;
	bh=4uQQKVnJVNkYxj3Jf3V9uXYx3Kw1s6pIzZwwAp0Wiaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlOtRCq9pTtVYGZ0cuxTnRTJnQwOjABU05zha310O6B4jpwZajEfop2CONfnYcwmXIBclqJuJKoIQsol5Geh0rwXkc51E/6x/wKKGz4jWTh8qxyHVlCAypBipxCOQX46uSO+gknOeoOfPAzgdUmJ7OPEgidycgJBhbyOES/RzO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=R1fGFGwp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso751365966b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 05:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731417622; x=1732022422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A1t9Ib/aPHDdfQvoVKx/Fp+uYeREslGX9huBdxy8D5w=;
        b=R1fGFGwpLwBuY22360zqHCFEnrtfk2hrVbS8OpLp+AYP9e1SySpJPTZcqrWxCqjgQ/
         CtHDSrQDdNVPvhM5cgIaKBv7pEJ+ceYEGN73V32Wfbw2LSEYL8GXVKLgTd2f1dTVKjlb
         7cJP/UpEaUm9iCVWwOeaRM/5blXj5ML6D/5rnW7T5ihfPCRHQkLa84+kpZzgs72NaKPl
         qZreU/NfePX9GRTF1xtg/hOZG6UftZ/8/l5Vht+eGmpS7GH7ZcDslLA3jJQgN+GRvURF
         pEaJfvO7RiXhmdLWXoAntXxo4lxPwlL9XW+SFeCoI2TUk/hVty3Sokumt1vFjrzV5x3t
         GT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731417622; x=1732022422;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1t9Ib/aPHDdfQvoVKx/Fp+uYeREslGX9huBdxy8D5w=;
        b=rk0quRm5wJXcYrHWKCJ17u14KP5ntw8g1wUFnYOYH0J0neNlAv40RPzMVbwRZzs1er
         wMEo8nSbpWuCZIReaeJLWYMM71DvgV9pKy7Ndy2puQKmRBDYsKucxXKnc7Xfu7qUd3Bj
         xO4tkeRBd/h0sOwzK2Q4cj4h7hcHN/TP8gf0HxWVgvxDGYX2W9HseVPQ0DlAe84SHD8u
         D5XXDtvfmQ3r616E8ozbK+6l68jZ16NGMUVmUNhScoX6o+CxfjmRqinWY/jE/gQW1Rj4
         dRjrF1akCg9N6KtYDHw9dLATuNCKSK3fEpgPLS3DvMgKxJY1yse+ra5DoLMV6CIlp4hk
         /QJA==
X-Forwarded-Encrypted: i=1; AJvYcCVRxAq3LI7lCYuy2KLofsp9GGY/zoEXYyulgPjDk6E68+m8qZqRSk9iiMIxw/QoVJZy2/0aHuxWEc06QLhhYzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxy1E1P7XAr3YdPYYUPlR6yc6TAuySiyXl+WAk6Un1xIW26FkX
	S3HY1PWpbEjU8aePIUu6AjVRq9VTPT7fipYUGGEKtr/uWlRuRATuAMr2ydWGISA=
X-Google-Smtp-Source: AGHT+IHxDEAm5J4fyPiYBfUUcx8JGUKH/71W41+JakmzEd92mmK3cHWQHCGpTj47KLde3aEZt1tLWg==
X-Received: by 2002:a17:907:72c8:b0:a9a:1739:91e9 with SMTP id a640c23a62f3a-a9eefeebe72mr1631965066b.24.1731417622152;
        Tue, 12 Nov 2024 05:20:22 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e829:c484:5241:93b2? ([2001:67c:2fbc:1:e829:c484:5241:93b2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc5112sm718813966b.112.2024.11.12.05.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:20:21 -0800 (PST)
Message-ID: <189dbeea-127a-47e8-84f8-c8cf1cc03536@openvpn.net>
Date: Tue, 12 Nov 2024 14:20:45 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 15/23] ovpn: implement keepalive mechanism
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-15-de4698c73a25@openvpn.net> <ZypfnyfToF1b6YAZ@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZypfnyfToF1b6YAZ@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2024 19:10, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:28 +0100, Antonio Quartulli wrote:
>> @@ -105,6 +132,9 @@ void ovpn_decrypt_post(void *data, int ret)
>>   		goto drop;
>>   	}
>>   
>> +	/* keep track of last received authenticated packet for keepalive */
>> +	peer->last_recv = ktime_get_real_seconds();
> 
> It doesn't look like we're locking the peer here so that should be a
> WRITE_ONCE() (and READ_ONCE(peer->last_recv) for all reads).

Is that because last_recv is 64 bit long (and might be more than one 
word on certain architectures)?

I don't remember having to do so for reading/writing 32 bit long integers.

I presume we need a WRITE_ONCE also upon initialization in 
ovpn_peer_keepalive_set() right?
We still want to coordinate that with other reads/writes.

> 
>> +
>>   	/* point to encapsulated IP packet */
>>   	__skb_pull(skb, payload_offset);
>>   
>> @@ -121,6 +151,12 @@ void ovpn_decrypt_post(void *data, int ret)
>>   			goto drop;
>>   		}
>>   
>> +		if (ovpn_is_keepalive(skb)) {
>> +			net_dbg_ratelimited("%s: ping received from peer %u\n",
>> +					    peer->ovpn->dev->name, peer->id);
>> +			goto drop;
> 
> To help with debugging connectivity issues, maybe keepalives shouldn't
> be counted as drops? (consume_skb instead of kfree_skb, and not
> incrementing rx_dropped)
> The packet was successfully received and did all it had to do.

you're absolutely right. Will change that.

> 
>> +		}
>> +
>>   		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
>>   				     peer->ovpn->dev->name, peer->id);
>>   		goto drop;
>> @@ -221,6 +257,10 @@ void ovpn_encrypt_post(void *data, int ret)
>>   		/* no transport configured yet */
>>   		goto err;
>>   	}
>> +
>> +	/* keep track of last sent packet for keepalive */
>> +	peer->last_sent = ktime_get_real_seconds();
> 
> And another WRITE_ONCE() here (also paired with READ_ONCE() on the
> read side).

Yap

> 
> 
>> +static int ovpn_peer_del_nolock(struct ovpn_peer *peer,
>> +				enum ovpn_del_peer_reason reason)
>> +{
>> +	switch (peer->ovpn->mode) {
>> +	case OVPN_MODE_MP:
> 
> I think it would be nice to add
> 
>      lockdep_assert_held(&peer->ovpn->peers->lock);
> 
>> +		return ovpn_peer_del_mp(peer, reason);
>> +	case OVPN_MODE_P2P:
> 
> and here
> 
>      lockdep_assert_held(&peer->ovpn->lock);

Yeah, good idea.
__must_hold() can't work here, so lockdep_assert_held is definitely the 
way to go.

> 
> (I had to check that ovpn_peer_del_nolock is indeed called with those
> locks held since they're taken by ovpn_peer_keepalive_work_{mp,p2p},
> adding these assertions would make it clear that ovpn_peer_del_nolock
> is not an unsafe version of ovpn_peer_del)

Right, it makes sense.

> 
>> +		return ovpn_peer_del_p2p(peer, reason);
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>>   /**
>>    * ovpn_peers_free - free all peers in the instance
>>    * @ovpn: the instance whose peers should be released
>> @@ -830,3 +871,150 @@ void ovpn_peers_free(struct ovpn_struct *ovpn)
>>   		ovpn_peer_unhash(peer, OVPN_DEL_PEER_REASON_TEARDOWN);
>>   	spin_unlock_bh(&ovpn->peers->lock);
>>   }
>> +
>> +static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
>> +						time64_t now)
>> +{
>> +	time64_t next_run1, next_run2, delta;
>> +	unsigned long timeout, interval;
>> +	bool expired;
>> +
>> +	spin_lock_bh(&peer->lock);
>> +	/* we expect both timers to be configured at the same time,
>> +	 * therefore bail out if either is not set
>> +	 */
>> +	if (!peer->keepalive_timeout || !peer->keepalive_interval) {
>> +		spin_unlock_bh(&peer->lock);
>> +		return 0;
>> +	}
>> +
>> +	/* check for peer timeout */
>> +	expired = false;
>> +	timeout = peer->keepalive_timeout;
>> +	delta = now - peer->last_recv;
> 
> I'm not sure that's always > 0 if we finish decrypting a packet just
> as the workqueue starts:
> 
>    ovpn_peer_keepalive_work
>      now = ...
> 
>                                         ovpn_decrypt_post
>                                           peer->last_recv = ...
> 
>    ovpn_peer_keepalive_work_single
>      delta: now < peer->last_recv
> 

Yeah, there is nothing preventing this from happening...but is this 
truly a problem? The math should still work, no?

However:

> 
> 
>> +	if (delta < timeout) {
>> +		peer->keepalive_recv_exp = now + timeout - delta;
> 
> I'd shorten that to
> 
>      peer->keepalive_recv_exp = peer->last_recv + timeout;
> 
> it's a bit more readable to my eyes and avoids risks of wrapping
> values.
> 
> So I'd probably get rid of delta and go with:
> 
>      last_recv = READ_ONCE(peer->last_recv)
>      if (now < last_recv + timeout) {
>      	peer->keepalive_recv_exp = last_recv + timeout;
>      	next_run1 = peer->keepalive_recv_exp;
>      } else if ...
> 
>> +		next_run1 = peer->keepalive_recv_exp;
>> +	} else if (peer->keepalive_recv_exp > now) {
>> +		next_run1 = peer->keepalive_recv_exp;
>> +	} else {
>> +		expired = true;
>> +	}

I agree this is simpler to read and gets rid of some extra operations.

[note: I took inspiration from nat_keepalive_work_single() - it could be 
simplified as well I guess]

> 
> [...]
>> +	/* check for peer keepalive */
>> +	expired = false;
>> +	interval = peer->keepalive_interval;
>> +	delta = now - peer->last_sent;
>> +	if (delta < interval) {
>> +		peer->keepalive_xmit_exp = now + interval - delta;
>> +		next_run2 = peer->keepalive_xmit_exp;
> 
> and same here

Yeah, will change both. Thanks!


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


