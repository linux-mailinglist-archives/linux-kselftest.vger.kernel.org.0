Return-Path: <linux-kselftest+bounces-22033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E399C8E6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796BD2886C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FDD18C907;
	Thu, 14 Nov 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IPR/Lk2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218E2AEF1
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598360; cv=none; b=PjvPNpGJGel9iKJMdCJ+GvHo4DYVM+7M76RHCdnIeFcFvrJxKxhkubx/N5v/ziS29Wyp33JdZ5sTFoV8Mn83btHEmafHibE8PwDiNhusBD+A82HIeRELQmJ04vSVgS7NP6gOwgIsybtH2YGaCEfuqn4Nt5Ds9nODGjfkceI0kdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598360; c=relaxed/simple;
	bh=K+3Th5Q++5HUxSp1hVDWsLMIxmGiK0HaUFgVbSqlY/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+rDiRXRSp7eo9p4j8OLQM2lputnEG270CMJUeawUkC2NrTM2BsF3d7kRHuAtxcD4Smn1I6Yrgj+123xIKzLGnr2DIyvEhzGfv/MpchgI7UI/97IlohkjBG1E/oYq3+4JhWHfWxdE4t9aHfXQDvLZx72qHcaZKTXqic5dJJFEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IPR/Lk2u; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cf872ecce7so315691a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 07:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731598357; x=1732203157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lhlNxLWWoabmlExNDUzh7LDAJ1jX1Gjtz/aG2arQZrc=;
        b=IPR/Lk2uNcCPzZr/g2x7cab3Gy7jI2gQycd1Iw9eSuGOah0nqq0gayf2HBfEPcAHuI
         SSQ9fAx07GWeeNioXYAMUfOBtPmxauY0CQO0I537HtqRl9d/w3+D4sMwcea2zW9Pdcpe
         wTJP8Z8IW5fy4UwPF4nQIPXzD5rGtJzuZw97dnIHXBitBTphGWAix/u63q/48XHoa/7a
         bj4NGP3cfDSKwkGuL/oNzBEJ15TnCGGZi8EpRJmEvFVz/JbRa/+QI2a1aur9wGfY+4qc
         a+7W46MWfEaKikpQee2P83ix/+LrScM/m/s+pkvgID3ahdOxk8wGKirplsg5Ia/FsIKa
         QuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598357; x=1732203157;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhlNxLWWoabmlExNDUzh7LDAJ1jX1Gjtz/aG2arQZrc=;
        b=fnR0LHTFHmR2EpSMrrVPOb2G4CSlTfGs/o39qQHCI/fHqVJDRlCnFgyhmxZStYUa1f
         a7gsFrMyhCFrQwgW2vPQ3q7j/RdxAbvZqO/5bsgamZO7nftzVyp0KITKmFtuy/Q1tX26
         E4OKGfTCocq5h1Od5t2gACp2LFV8Aj3/0zZp3aBG3hUvsjNPMgLrzdl+y/hYkGOKiUJ8
         +xXs5A3rN4zblfIXGTMWQXh6jt9KFUKzLMYJjeBWpDAot88yTuyH8HNtSKmCtSu6v/je
         fHYpXOxQOoo2UNRepUaQ1LSoyz8NrHJKDYdCpuQTlAoWV9kp86Waq4gUt0x2mlNEC6hC
         VoDg==
X-Forwarded-Encrypted: i=1; AJvYcCXhWsgMsP2PQCcDoaNdb9yWHubBDF5v1HPHEn7PA+H+VrcU3KkvAy6aOblWi0/h/R+CXXBePolraxyiYk77Uac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkwA7v+yfHnTsYAv8abVi1CQ7TVMH10CHF7bM3rxh7/O0whSZ
	mMmprz95dPqQXBsmrEBaEMp0FgtFNM/RK5nETDeGiZ2OvvtMw5tK4cK/9NvH3js=
X-Google-Smtp-Source: AGHT+IFa2gi/aEPlmVRGMZ2KFCSySjruI6gTHEROD6baMQ+UQbzs2SVZxO3Khbd+XB8BOWUYsgYYsQ==
X-Received: by 2002:a17:907:80e:b0:a9e:b5d0:e5c with SMTP id a640c23a62f3a-a9ef003347amr2146391466b.61.1731598356513;
        Thu, 14 Nov 2024 07:32:36 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e7c9:910b:dd41:da18? ([2001:67c:2fbc:1:e7c9:910b:dd41:da18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e0452a0sm74302666b.148.2024.11.14.07.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:32:36 -0800 (PST)
Message-ID: <a7009e7e-a1f9-4aa5-ad41-2befc64b5d3e@openvpn.net>
Date: Thu, 14 Nov 2024 16:33:01 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 00/23] Introducing OpenVPN Data Channel
 Offload
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <2828411f-f2e5-4dfc-80ff-577eb5fd359a@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <2828411f-f2e5-4dfc-80ff-577eb5fd359a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/11/2024 02:18, Sergey Ryazanov wrote:
> Hi Antonio,
> 
> On 29.10.2024 12:47, Antonio Quartulli wrote:
>> Notable changes from v10:
>> * extended commit message of 23/23 with brief description of the output
>> * Link to v10: https://lore.kernel.org/r/20241025-b4-ovpn-v10-0- 
>> b87530777be7@openvpn.net
>>
>> Please note that some patches were already reviewed by Andre Lunn,
>> Donald Hunter and Shuah Khan. They have retained the Reviewed-by tag
>> since no major code modification has happened since the review.
>>
>> The latest code can also be found at:
>>
>> https://github.com/OpenVPN/linux-kernel-ovpn
> 
> As I promised many months ago I am starting publishing some nit picks 
> regarding the series. 

Thanks and welcome back!

> The review was started when series was V3 
> "rebasing" the review to every next version to publish it at once. But I 
> lost this race to the new version releasing velocity :) So, I am going 
> to publish it patch-by-patch.
> 
> Anyway you and all participants have done a great progress toward making 
> accelerator part of the kernel. Most of considerable things already 
> resolved so do not wait me please to finish picking every nit.

I'll go through them all and judge what's meaningful to add to v12 and 
what can be postponed for later improvements.

> 
> Regarding "big" topics I have only two concerns: link creation using 
> RTNL and a switch statement usage. In the corresponding thread, I asked 
> Jiri to clarify that "should" regarding .newlink implementation. Hope he 
> will have a chance to find a time to reply.

True, but to be honest at this point I am fine with sticking to RTNL, 
also because we will soon introduce the ability to create 'persistent' 
ifaces, which a user should be able to create before starting openvpn.

Going through RTNL for this is the best choice IMHO, therefore we have 
an extra use case in favour of this approach (next to what Jiri already 
mentioned).

> 
> For the 'switch' statement, I see a repeating pattern of handling mode- 
> or family-specific cases like this:
> 
> int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
> {
>    switch (ovpn->mode) {
>    case OVPN_MODE_MP:
>      return ovpn_peer_add_mp(ovpn, peer);
>    case OVPN_MODE_P2P:
>      return ovpn_peer_add_p2p(ovpn, peer);
>    default:
>      return -EOPNOTSUPP;
>    }
> }
> 
> or
> 
> void ovpn_encrypt_post(void *data, int ret)
> {
>    ...
>    switch (peer->sock->sock->sk->sk_protocol) {
>    case IPPROTO_UDP:
>      ovpn_udp_send_skb(peer->ovpn, peer, skb);
>      break;
>    case IPPROTO_TCP:
>      ovpn_tcp_send_skb(peer, skb);
>      break;
>    default:
>      /* no transport configured yet */
>      goto err;
>    }
>    ...
> }
> 
> or
> 
> void ovpn_peer_keepalive_work(...)
> {
>    ...
>    switch (ovpn->mode) {
>    case OVPN_MODE_MP:
>      next_run = ovpn_peer_keepalive_work_mp(ovpn, now);
>      break;
>    case OVPN_MODE_P2P:
>      next_run = ovpn_peer_keepalive_work_p2p(ovpn, now);
>      break;
>    }
>    ...
> }
> 
> Did you consider to implement mode specific operations as a set of 
> operations like this:
> 
> ovpn_ops {
>    int (*peer_add)(struct ovpn_struct *ovpn, struct ovpn_peer *peer);
>    int (*peer_del)(struct ovpn_peer *peer, enum ovpn_del_peer_reason 
> reason);
>    void (*send_skb)(struct ovpn_peer *peer, struct sk_buff *skb);
>    time64_t (*keepalive_work)(...);
> };
> 
> Initialize them during the interface creation and invoke these 
> operations indirectly. E.g.
> 
> int ovpn_peer_add(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
> {
>    return ovpn->ops->peer_add(ovpn, peer);
> }
> 
> void ovpn_encrypt_post(void *data, int ret)
> {
>    ...
>    ovpn->ops->send_skb(peer, skb);
>    ...
> }
> 
> void ovpn_peer_keepalive_work(...)
> {
>    ...
>    next_run = ovpn->ops->keepalive_work(ovpn, now);
>    ...
> }
> 
> Anyway the module has all these option values in advance during the 
> network interface creation phase and I believe replacing 'switch' 
> statements with indirect calls can make code easy to read.

I see this was already discussed with Sabrina under another patch and I 
have the same opinion.

To me the switch/case approach looks cleaner and I truly like it, 
especially when enums are involved.

ops/callbacks are fine when they can be redefined at runtime (i.e. a 
proto that can be registered by another module), but this is not the 
case here.
I also feel that with ops it's not easy to understand what call is truly 
being made by just looking at the caller context and reading can be harder.

So I truly prefer to stick to this schema.

Thanks a lot for sharing your point though.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


