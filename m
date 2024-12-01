Return-Path: <linux-kselftest+bounces-22650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED039DF771
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 00:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74194B21398
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Dec 2024 23:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C51D8DF6;
	Sun,  1 Dec 2024 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WMaKlaFy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A201F94D
	for <linux-kselftest@vger.kernel.org>; Sun,  1 Dec 2024 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733096015; cv=none; b=rkaIuQRysALH3m6tdYu0t3qq5gC42u6iPAM6uSUqGDBocplMVZ4XNhaqHOquuL3d+15w7xEnsHvbPtXtRImJGbDqMXJVVitcTKp9zf4ebj7/0BOeB4IpJiizTV9F7MO/9d41qMjzl8bzUi1uTp53YE4gqbve0YbQNOIkOGiXgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733096015; c=relaxed/simple;
	bh=saAHsaq1CDBC+omTWYmzo+yQCX8obMYlOC3EGDMmcVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6hZ47mj0V9qKDDwBkC1GNdcQdyrHOnqaBiGzdDP0Z4LxGJOpbgAslKDRQ+EFreGMY0n19pxKMvOX8YajhL6OLYFYNLQEw2aEmU3E369BNpGmcR03Bl+Ifp983mpJTCJH6ACOWU+RzEy3M1olOrhtlNnMfkWXLq/K7WdjKnl/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WMaKlaFy; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so4505177a12.1
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Dec 2024 15:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733096011; x=1733700811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar39SOfyombA7mU0aCysAYFOknc8+SmqsbrmidfksXQ=;
        b=WMaKlaFySGbDQ0jqY6EfiqFOgR1YGGePIWfshA6W2ubsS7T28rq7cH1ok7FhpoDOgu
         nU5o10wApmT6PbGv1WEX6Hp42fTTTcE6KIhnd/s+QVYCizjTMczXKOoTkxqNPSHBg938
         chXZoVrqwzyXovrYMCdratG108C9tUtS7X+FKi3FPNX7pyIf9ElwC4HMpcOnovRmNADt
         NMaqhMHR16UFhd4Lll6ifA31Wrzz4AbpBvKranSUqbmwxEUGygEQVx6bbe5+aeNlBuHb
         LKFgXi5U4Ui6EzW1vpg9gOMeDEU0aLb9rzR7x/+x9fpp+gy7AGswY3SrCslVVTq8mdDl
         lluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733096011; x=1733700811;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar39SOfyombA7mU0aCysAYFOknc8+SmqsbrmidfksXQ=;
        b=KbkY3dSF4iGN2hJC7yDG4ORYjAR2KtuvyV2N7XKLyjTAdHS5/5aFE8af7GaMoChQpB
         YJUEc0RGCUVyFJVYMig8Cd/EuCRRV9zUH6djhttb/Lx+v4H1TXMNH1EsTGDFreMx0NnD
         hWj+wEGPtY50KY1RLXLrNHuw+D702HiAlYPbXG2lQbSeNqR16zvcWnPowmGRw81CHMdk
         FTjqPpQ0mjryZ2Xa7fy0T5mkpETWGx/37tMMamuoXNrZvJAjqXoPXfAQt42ccGVGLKiP
         m7KYSGMDWuZWMgBZD3rh0/ltBRYzZ7MAhWol9WLkSkToxFDXd3YBYVrAVNiFTl2wvkrF
         bXUg==
X-Forwarded-Encrypted: i=1; AJvYcCXtS1r/s96hL8qdTP7E3V5iFGurr7hJIEay8LFzE9ZclWI3zZTuicHk5i6SxNOfUrvcCs+3nhNwrbIBs6BZRdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnkcWUbYA9qlzp/F/BbpemJ4dCS3aWP8S+aWLypzBva+p7JgJk
	uc+rUK1Vgmue08G/P1pECQVAVqVH4g6Lbhuek0T3yV4RaQ/i6pbir+ZDoaGRHv4=
X-Gm-Gg: ASbGncsxTmhOF5I4PON4K0AeYfNzp7BnYEZJbd+seKi7PP5Uba5WiLoJbwP1qfoNlP/
	YgPdsfr5RDAg/bJKqeB4CtjxVvKeZQq6g8IncZlUl3lwk0KW4n/W9lf8gzttqKzhjcULb1/WQ8T
	rDWIIHdPaKnA3aO1ILurlBZ6AWOWQe22B6aT9Y0GcD+t8WA4anFJb9J3k94aIjeds9qzCM1BsZ6
	K7Jjj5EpJZiAAttHUeokk2LnfollX7RDi4YjO9uV9DtkUkS4zqmvQi83tybXujDXIUByOA3LAOF
	zAPifNH45A==
X-Google-Smtp-Source: AGHT+IFHL7u//pQws37e/BIFTrSGzZ1jXCz41r6jjRHlr2LaME983zUT8+lNZdmRMf3zcb3pC7Su+Q==
X-Received: by 2002:a05:6402:1d01:b0:5d0:d30b:d53e with SMTP id 4fb4d7f45d1cf-5d0d30bd5bemr5728913a12.19.1733096011533;
        Sun, 01 Dec 2024 15:33:31 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:4d54:a2d3:baf:1503? ([2001:67c:2fbc:1:4d54:a2d3:baf:1503])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0cfde6c82sm1916976a12.53.2024.12.01.15.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 15:33:30 -0800 (PST)
Message-ID: <eae5431f-e330-4066-8f27-0858a7ad9d66@openvpn.net>
Date: Mon, 2 Dec 2024 00:34:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
 <eabe28f9-d6a4-4bdc-a988-418e5137f3cb@gmail.com>
 <288f68cd-533a-4253-85c4-951cc4a9c862@openvpn.net>
 <aac209cc-589c-4b8a-9123-e44df9e794e4@gmail.com>
 <4c24d8ba-35d0-4aff-b207-9eca6eeda1fc@openvpn.net>
 <a4a537df-900b-43e6-bcc2-5049036b1ca2@openvpn.net> <Z0m_lNTOAV7yL9wo@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z0m_lNTOAV7yL9wo@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/11/2024 14:20, Sabrina Dubroca wrote:
> 2024-11-27, 02:40:02 +0100, Antonio Quartulli wrote:
>> On 26/11/2024 09:49, Antonio Quartulli wrote:
>> [...]
>>>>
>>>> The potential issue is tricky since we create it patch-by-patch.
>>>>
>>>> Up to this patch the socket releasing procedure looks solid and
>>>> reliable. E.g. the P2P netdev destroying:
>>>>
>>>>     ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
>>>>       ovpn_peer_release_p2p
>>>>         ovpn_peer_del_p2p
>>>>           ovpn_peer_put
>>>>             ovpn_peer_release_kref
>>>>               ovpn_peer_release
>>>>                 ovpn_socket_put
>>>>                   ovpn_socket_release_kref
>>>>                     ovpn_socket_detach
>>>>                       ovpn_udp_socket_detach
>>>>                         setup_udp_tunnel_sock
>>>>     netdev_run_todo
>>>>       rcu_barrier  <- no running ovpn_udp_encap_recv after this point
>>>>       free_netdev
>>>>
>>>> After the setup_udp_tunnel_sock() call no new ovpn_udp_encap_recv()
>>>> will be spawned. And after the rcu_barrier() all running
>>>> ovpn_udp_encap_recv() will be done. All good.
>>>>
>>>
>>> ok
>>>
>>>> Then, the following patch 'ovpn: implement TCP transport' disjoin
>>>> ovpn_socket_release_kref() and ovpn_socket_detach() by scheduling
>>>> the socket detach function call:
>>>>
>>>>     ovpn_socket_release_kref
>>>>       ovpn_socket_schedule_release
>>>>         schedule_work(&sock->work)
>>>>
>>>> And long time after the socket will be actually detached:
>>>>
>>>>     ovpn_socket_release_work
>>>>       ovpn_socket_detach
>>>>         ovpn_udp_socket_detach
>>>>           setup_udp_tunnel_sock
>>>>
>>>> And until this detaching will take a place, UDP handler can call
>>>> ovpn_udp_encap_recv() whatever number of times.
>>>>
>>>> So, we can end up with this scenario:
>>>>
>>>>     ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
>>>>       ovpn_peer_release_p2p
>>>>         ovpn_peer_del_p2p
>>>>           ovpn_peer_put
>>>>             ovpn_peer_release_kref
>>>>               ovpn_peer_release
>>>>                 ovpn_socket_put
>>>>                   ovpn_socket_release_kref
>>>>                     ovpn_socket_schedule_release
>>>>                       schedule_work(&sock->work)
>>>>     netdev_run_todo
>>>>       rcu_barrier
>>>>       free_netdev
>>>>
>>>>     ovpn_udp_encap_recv  <- called for an incoming UDP packet
>>>>       ovpn_from_udp_sock <- returns pointer to freed memory
>>>>       // Any access to ovpn pointer is the use-after-free
>>>>
>>>>     ovpn_socket_release_work  <- kernel finally ivoke the work
>>>>       ovpn_socket_detach
>>>>         ovpn_udp_socket_detach
>>>>           setup_udp_tunnel_sock
>>>>
>>>> To address the issue, I see two possible solutions:
>>>> 1. flush the workqueue somewhere before the netdev release
>>>
>>> yes! This is what I was missing. This will also solve the "how can the
>>> module wait for all workers to be done before unloading?"
>>>
>>
>> Actually there might be even a simpler solution: each ovpn_socket will hold
>> a reference to an ovpn_peer (TCP) or to an ovpn_priv (UDP).
>> I can simply increase the refcounter those objects while they are referenced
>> by the socket and decrease it when the socket is fully released (in the
>> detach() function called by the worker).
>>
>> This way the netdev cannot be released until all socket (and all peers) are
>> gone.
>>
>> This approach doesn't require any local workqueue or any other special
>> coordination as we'll just force the whole cleanup to happen in a specific
>> order.
>>
>> Does it make sense?
> 
> This dependency between refcounts worries me. I'm already having a
> hard time remembering how all objects interact together.
> 
> And since ovpn_peer_release already calls ovpn_socket_put, you'd get a
> refcount loop if ovpn_socket now also has a ref on the peer, no?

You're right.
Therefore I started playing with the following approach:
* implement ovpn_peer_remove() that is invoked by ovpn_peer_del(), i.e. 
when ovpn wants to remove the peer from its state
* ovpn_peer_remove() will do all kind of cleanup and unhash, including 
calling ovpn_socket_put()
* in turn, when the socket is released from all other contexts, it will 
also call ovpn_peer_put() and allow the peer to be free'd for good.

On one hand it sounds a bit clumsy, but on the other hand it allows each 
component to keep relying on any reference it is holding until the end.

The only downside is that we will start shutting down a peer and then 
keep it around until any reference is dropped. But it should work.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


