Return-Path: <linux-kselftest+bounces-23408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 722829F2FC7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 12:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2691883149
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43CE2040BC;
	Mon, 16 Dec 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="c9vwyuZ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F9203712
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349808; cv=none; b=T47IQvdx8hDM3TLcS6tHTxj8BwSBnUH6SEBOfPgf65fktwnGe+Dd5pRFowpRZiWc2a3/a+5a0Jctw1c3yZveMsl61aH+s2wEJPBXy8/UZKinbzOxtpNFa3Jv+vGC3I+zHSVSQteZGnHE9kDTZTvfEIpc3UPaLdK+2f6GCCynY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349808; c=relaxed/simple;
	bh=LjoNpo99IS9TQ2tcnB3Fb50v0g/in8V7E04lFrHtrcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSpZdgJOAGvz02glZ7fhN0wNhklQe+aTsHl50jcf9eP3TOS1AiqtwTuO/ILlZfQP6Jc6wVMLQFJ8mKiMUze8IGMhR2EE+IofSVkOsrjvJtn7aZWEOy3tJG2YFhxHK9ij3h0brPGV9Aip8bT9yQu1L2aA22jVVnTTeBduc2VJ3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=c9vwyuZ8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa692211331so768756666b.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734349805; x=1734954605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n4Fnqt3+wn3Jqih2/E06bFWlfYBOS+/nVME6Ot/StK8=;
        b=c9vwyuZ89rAz7fOyhoTxkT4XTjxhvSfi8DfiW/OjpFNMUsA6v8hG/0DMPbvXC/rz/l
         mEs7ru+VNaN8SR2XoIjkmkvTCMcWxveJ221IG5428MABbHm2OCcgfwF8MsRA47LsDijz
         jI5zrkCHtawtSvKKMW8ZdPV6ugWaD45Qfr8WmV07MyZ/uCGM0kl7n5KVYLs+Ct4EMw1n
         Nlye7HkWVhOLvd6ZSY3O74dwKvlgj/U7iOKklH0TOIGBaVMLFZ4b6wjhYJhbuCmkO7tD
         WmRYq51FMQ03kdB1nFYWNXaBa+f8fCsp4mt1EULh09x+A5fRqfkkrVMJqmVdNqufzKQe
         JQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734349805; x=1734954605;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4Fnqt3+wn3Jqih2/E06bFWlfYBOS+/nVME6Ot/StK8=;
        b=IAXsydsmYBTHvwsZPSEUxPB3vca+m5sC75b2Zrw3sbeA3SVEhvsm2VZqUZjvpdl7Sv
         Z6/8Z5WZ9hBHnFZiccm5sye2N4t4bllo/OCXk9m7mXrCKCYAFXjjizD3djG0R5e+42tj
         QG5PF6WYfAPmGdMMLxMDUWtwtHVUP0OGqyW6xNW6gtWa91LXvRsebqxWMFWG84A1VfRm
         ggwiqC9dxb/+UyKUTqYPsL426frUcfAbnZUSdTGtdu9pnbM47m7cAT5yNju5ceyt8N2g
         bu9irIbdgUEprYfzn4IX+gyDCyteso8hv//K+jAlJiOCJJrhoLta1bwjg8Mq1HDYm2zP
         Fo3A==
X-Forwarded-Encrypted: i=1; AJvYcCWBJ18K0MBNTYJhP58YwNajIkZZKNsB4+XyfZiVHsKP42y8AueMntfgi4velCIHUSem2J7lHY475OcqjnAOqa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFo+aZczuIv4SkD12J/Jt+MJIihNnDfNMAXBv/V9g8IRFuNk22
	HIEpOU2s2kG/xwqQGgYCqiEVsHS5awukHaKKU6TmNCvL6b4leUSi4JU40xP3EMA=
X-Gm-Gg: ASbGncsGZPoYWUTpc28WecnRENsz6e2evNm+asDLzVp15jw5D9gtoD5h8vj+0C2DMmA
	Wp7Kr4HL2zz/ivn46jSevquF3C6NmKTW8ubMC2gRbaQ0OkPE7q98fJmn5NBonAzyrUEOf4I3mHG
	l5keq6OYC+wsHmqntF6S5aXkbKJ3diLR1sGAZ920vOUmIpjqBzArTjFkYQqyGPOkTI+kP5nt5u4
	a800aVwse8IwXmGJZmjWqLmrzzJ/i5oOG22xAUp4X7Tiy+Gtavg0mp/G0KqiEH4E4V9Dna1tvkW
	Dw5vqYVeSx81EvJ5Ij0=
X-Google-Smtp-Source: AGHT+IEnfewEiJGs3lq7FqGj7ad6Ew/gCcV3xnhPzkvANe07z2h/NIw9ORmy8DNUwq06lbUogwLfZA==
X-Received: by 2002:a17:907:7e92:b0:aa6:a9fe:46de with SMTP id a640c23a62f3a-aab7b777564mr1235220266b.19.1734349804846;
        Mon, 16 Dec 2024 03:50:04 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f3f5:d43f:11fb:5f45? ([2001:67c:2fbc:1:f3f5:d43f:11fb:5f45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96089f88sm321885466b.91.2024.12.16.03.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 03:50:04 -0800 (PST)
Message-ID: <a1137cc2-6985-44bc-a802-e070da7208dc@openvpn.net>
Date: Mon, 16 Dec 2024 12:50:53 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 06/22] ovpn: introduce the ovpn_socket object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 willemdebruijn.kernel@gmail.com
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-6-314e2cad0618@openvpn.net> <Z1sNEgQLMzZua3mS@hog>
 <fa19f3a8-c273-4d2c-a10e-e9bda2375365@openvpn.net> <Z2AKg6ntLd94anHv@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z2AKg6ntLd94anHv@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2024 12:09, Sabrina Dubroca wrote:
[...]
>> Maybe we should call cancel_sync_work(&ovpn_sock->work) inside
>> ovpn_socket_get()?
>> So the latter will return NULL only when it is sure that the socket has been
>> detached.
>>
>> At that point we can skip the following return and continue along the "new
>> socket" path.
>>
>> What do you think?
> 
> The work may not have been scheduled yet? (small window between the
> last kref_put and schedule_work)
> 
> Maybe a completion [Documentation/scheduler/completion.rst] would
> solve it (but it makes things even more complex, unfortunately):
> 
>   - at the end of ovpn_socket_detach: complete(&ovpn_sock->detached);
>   - in ovpn_socket_new when handling EALREADY: wait_for_completion(&ovpn_sock->detached);
>   - in ovpn_socket_new for the new socket: init_completion(&ovpn_sock->detached);
> 
> but ovpn_sock could be gone immediately after complete(). Maybe
> something with completion_done() before the kfree_rcu in
> ovpn_socket_detach? I'm not that familiar with the completion API.
> 

It seems the solution we are aiming for is more complex than the concept 
of ovpn_socket per se :-D

I'll think a bit more about this..maybe we can avoid entering this 
situation at all..

> 
>> However, this makes we wonder: what happens if we have two racing PEER_NEW
>> with the same non-yet-attached UDP socket?
> 
> mhmm, I remember noticing that, but it seems I never mentioned it in
> my reviews. Sorry.
> 
>> Maybe we should lock the socket in ovpn_udp_socket_attach() when checking
>> its user-data and setting it (in order to make the test-and-set atomic)?
> 
> I'd use the lock to protect all of ovpn_socket_new.
> ovpn_tcp_socket_attach locks the socket but after doing the initial
> checks, so 2 callers could both see sock->sk->sk_user_data == NULL and
> do the full attach. And I don't think unlocking before
> rcu_assign_sk_user_data is safe for either UDP or TCP.

I tend to agree here. Guarding the whole ovpn_socket_new with 
lock_sock() seems the right thing to do.

> 
>> I am specifically talking about this in udp.c:
>>
>> 345         /* make sure no pre-existing encapsulation handler exists */
>> 346         rcu_read_lock();
>> 347         old_data = rcu_dereference_sk_user_data(sock->sk);
>> 348         if (!old_data) {
>> 349                 /* socket is currently unused - we can take it */
>> 350                 rcu_read_unlock();
>> 351                 setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
>> 352                 return 0;
>> 353         }
>>
>> We will end up returning 0 in both contexts and thus allocate two
>> ovpn_sockets instead of re-using the first one we allocated.
>>
>> Does it make sense?
> 
> Yes.
> 
> [...]
>>> [I have some more nits/typos here and there but I worry the
>>> maintainers will get "slightly" annoyed if I make you repost 22
>>> patches once again :) -- if that's all I find in the next few days,
>>> everyone might be happier if I stash them and we get them fixed after
>>> merging?]
>>
>> If we have to rework this socket attaching part, it may be worth throwing in
>> those typ0 fixes too :)
> 
> ACK, I'll send them out.

Thanks.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


