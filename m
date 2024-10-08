Return-Path: <linux-kselftest+bounces-19242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F873994EEB
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 15:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8CB1F22650
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF861DFDB8;
	Tue,  8 Oct 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="D6Tyy9s9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB21DF988
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393711; cv=none; b=DM/pM/+XH7D0xmP9LH6UlT/7UyX7CbsLuZ5j9Xbdsnwlid8hdhqpMYzWIm2v3aqkKSBp7yjxgFuMcCHQ/JcsTCX5yXOI4g8CbwDWhtIFsLCsY0pvr8rARbnilp3lf0aOMZjMuF0dfPsqT/oQfgAL2qiyCvGQfK6lWYPvoVdmII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393711; c=relaxed/simple;
	bh=Y2NwIPBfopwGVzULHFGxxIZwuj6htpe1C4mcre4uAPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uo05YM9sb52czYfUulGw6araT5mYD/x+qIBbm6Th4oU6nzAaT0G/qOd7yRjbeNSPGE4ic/wipQfCnHwrx6KhVQ5rI1HBGMxo7Dq4efy0B6tEJ2M72ZnatWNFVZJQPQkjte30bH7BhPP39Gh59dyJO7UXxiI7J79l58zO6XXEuIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=D6Tyy9s9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so49487505e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1728393708; x=1728998508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IGwDh27EeGXf7C+l09NBLsyVsUfw+2j7TtSeoREWHV8=;
        b=D6Tyy9s9Yb4bM0SwMwMxqwaWau15Vbx3ZK2V7eszu1aBA+Ny6r55PzVJwczUuDmCGL
         w2aQBi+wUWutydmT40hztdDJr3EzUfyP6iPOqYrIJqmrl3r8EMYNYKXMYRsri7s5M5cf
         O+eQOXuBUfG+t9aIdYm9t9tO6A+Mqx6wBz+k94xRpNFwNWpfumWwUyB5tFlMievXsdOp
         +VUFchGUgPT4/O12XZ1yOHPzjQVV+XRMsZMb5CSh01FTE1H5pCZV79p2cqcjHu8UrFJa
         mC7fF4P9FPkqzpBYQ24nqxQSe0NWRwkky5c1PZV4O3hVamSyjwjR/MQiicunwJLIUajU
         A23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393708; x=1728998508;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGwDh27EeGXf7C+l09NBLsyVsUfw+2j7TtSeoREWHV8=;
        b=YFDydN93dvrsh5TzA9PKCrQTqat/pCsP/KwZp2SdAufdfbOd8LULmHLxQmeQIHWLov
         eOwG4yn2Cj+UtPgZ1H30Kd3U33NzU3k+2pmSN6TZvqEGjJzw7rVr7dKYRjp2KtZ4Q99p
         8eInSt8KbO1UyVTyzsQLfzBkMMVq82j4e6XA4nnxbpzStbRUKA+PcDeNSc/L0BbEmw4z
         p3ODwzLGd9RUM0o2jwDmHUSxR6GDMdUVeszhOmA9EtGMA89QokNUAzeAN3DJ7LSU5G9k
         K8Jd2moPgiaK28Xtv77GcA0EVSlDNn76hSjx4Ki/EC4uAFmwpjIWMrmoDgAX41QqOX2S
         dHHg==
X-Forwarded-Encrypted: i=1; AJvYcCUq6WZWIHVkeC7yUkahUZt6GyECJqjAhrLj0xGzRb0GJZzB5PkiApP5i0fDsSx28jsuJ5SUmrNCiVYJeVlulNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQ3/ITdnUiXrx51xnUlcwixC9h016JA9bZ+7lHKH82BNEu6Fp
	JnNrASUQdVrp731mmb9Sl6o44yB30TsfenzU4v6thGlVORusHHjpIN1F+7H3//o=
X-Google-Smtp-Source: AGHT+IFKAPyfcD6cHtfzXzf1ecrJz21uorYTRGkCpeSTZoGEvhelaz9wRAzhIhYNbbvhFnagaXMPRg==
X-Received: by 2002:adf:a198:0:b0:37c:d20d:447c with SMTP id ffacd0b85a97d-37d0e779f64mr8922794f8f.29.1728393707682;
        Tue, 08 Oct 2024 06:21:47 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:1075:5147:8807:441e? ([2001:67c:2fbc:1:1075:5147:8807:441e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695ec1esm8150559f8f.74.2024.10.08.06.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:21:47 -0700 (PDT)
Message-ID: <b6c46bf5-9ea6-41ac-bf75-1d85b12c9651@openvpn.net>
Date: Tue, 8 Oct 2024 15:21:48 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/24] ovpn: add basic netlink support
To: Jiri Pirko <jiri@resnulli.us>
Cc: ryazanov.s.a@gmail.com, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sd@queasysnail.net
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-3-37ceffcffbde@openvpn.net>
 <ZwP-_-qawQJIBZnv@nanopsycho.orion>
 <fd952c28-1f17-45da-bd64-48917a7db651@openvpn.net>
 <ZwT0SkGHu5VHQ9Hd@nanopsycho.orion>
 <056588a7-de1b-4416-8553-750c8d20dc97@openvpn.net>
 <ZwUrAn8xrF2BCrMp@nanopsycho.orion>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZwUrAn8xrF2BCrMp@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/10/2024 14:52, Jiri Pirko wrote:
> Tue, Oct 08, 2024 at 11:16:01AM CEST, antonio@openvpn.net wrote:
>> On 08/10/2024 10:58, Jiri Pirko wrote:
>>> Tue, Oct 08, 2024 at 10:01:40AM CEST, antonio@openvpn.net wrote:
>>>> Hi,
>>>>
>>>> On 07/10/24 17:32, Jiri Pirko wrote:
>>>>> Wed, Oct 02, 2024 at 11:02:17AM CEST, antonio@openvpn.net wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>
>>>>>> +operations:
>>>>>> +  list:
>>>>>> +    -
>>>>>> +      name: dev-new
>>>>>> +      attribute-set: ovpn
>>>>>> +      flags: [ admin-perm ]
>>>>>> +      doc: Create a new interface of type ovpn
>>>>>> +      do:
>>>>>> +        request:
>>>>>> +          attributes:
>>>>>> +            - ifname
>>>>>> +            - mode
>>>>>> +        reply:
>>>>>> +          attributes:
>>>>>> +            - ifname
>>>>>> +            - ifindex
>>>>>> +    -
>>>>>> +      name: dev-del
>>>>>
>>>>> Why you expose new and del here in ovn specific generic netlink iface?
>>>>> Why can't you use the exising RTNL api which is used for creation and
>>>>> destruction of other types of devices?
>>>>
>>>> That was my original approach in v1, but it was argued that an ovpn interface
>>>> needs a userspace program to be configured and used in a meaningful way,
>>>> therefore it was decided to concentrate all iface mgmt APIs along with the
>>>> others in the netlink family and to not expose any RTNL ops.
>>>
>>> Can you please point me to the message id?
>>
>> <CAHNKnsQnHAdxC-XhC9RP-cFp0d-E4YGb+7ie3WymXVL9N-QS6A@mail.gmail.com> from
>> Sergey and subsequent replies.
>> RTNL vs NL topic starts right after the definition of 'ovpn_link_ops'
> 
> Yeah, does not make sense to me. All devices should implement common
> rtnl ops, the extra-config, if needed, could be on a separate channel.
> I don't find Sergey's argumentation valid.

Thanks a lot for taking the time to read our conversation.

Ok, considering all points we have discussed so far (including future 
developments already on the roadmap), I think it makes sense to go back 
to RTNL and drop the new/del-dev ops from the netlink family.

Will do that in v9.

Regards,

> 
> 
>>
>> Recently Kuniyuki commented on this topic as well in:
>> <20240919055259.17622-1-kuniyu@amazon.com>
>> and that is why I added a default dellink implemetation.
> 
> Having dellink without newlink implemented is just wrong.
> 
> 
>>
>>>
>>>
>>>>
>>>> However, recently we decided to add a dellink implementation for better
>>>> integration with network namespaces and to allow the user to wipe a dangling
>>>> interface.
>>>
>>> Hmm, one more argument to have symmetric add/del impletentation in RTNL
>>>
>>>
>>>>
>>>> In the future we are planning to also add the possibility to create a
>>>> "persistent interface", that is an interface created before launching any
>>>> userspace program and that survives when the latter is stopped.
>>>> I can guess this functionality may be better suited for RTNL, but I am not
>>>> sure yet.
>>>
>>> That would be quite confusing to have RTNL and genetlink iface to
>>> add/del device. From what you described above, makes more sent to have
>>> it just in RTNL
>>
>> All in all I tend to agree.
>>
>>>
>>>>
>>>> @Jiri: do you have any particular opinion why we should use RTNL ops and not
>>>> netlink for creating/destroying interfaces? I feel this is mostly a matter of
>>>> taste, but maybe there are technical reasons we should consider.
>>>
>>> Well. technically, you can probabaly do both. But it is quite common
>>> that you can add/delete these kind of devices over RTNL. Lots of
>>> examples. People are used to it, aligns with existing flows.
>>
>> The only counterargument I see is the one brought by Sergey: "the ovpn
>> interface is not usable after creation, if no openvpn process is running".
>>
>> However, allowing to create "persistent interfaces" will define a use-case
>> for having an ovpn device without any userspace process.
>>
>> @Sergey what is your opinion here? I am not sure persistent interfaces were
>> discussed at the time you brought your point about RTNL vs NL.
>>
>>
>> Regards,
>>
>>
>>>
>>>>
>>>> Thanks a lot for your contribution.
>>>>
>>>> Regards,
>>>>
>>>>
>>>>>
>>>>>
>>>>> ip link add [link DEV | parentdev NAME] [ name ] NAME
>>>>> 		    [ txqueuelen PACKETS ]
>>>>> 		    [ address LLADDR ]
>>>>> 		    [ broadcast LLADDR ]
>>>>> 		    [ mtu MTU ] [index IDX ]
>>>>> 		    [ numtxqueues QUEUE_COUNT ]
>>>>> 		    [ numrxqueues QUEUE_COUNT ]
>>>>> 		    [ netns { PID | NETNSNAME | NETNSFILE } ]
>>>>> 		    type TYPE [ ARGS ]
>>>>>
>>>>> ip link delete { DEVICE | dev DEVICE | group DEVGROUP } type TYPE [ ARGS ]
>>>>>
>>>>> Lots of examples of existing types creation is for example here:
>>>>> https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking
>>>>>
>>>>>
>>>>>
>>>>>> +      attribute-set: ovpn
>>>>>> +      flags: [ admin-perm ]
>>>>>> +      doc: Delete existing interface of type ovpn
>>>>>> +      do:
>>>>>> +        pre: ovpn-nl-pre-doit
>>>>>> +        post: ovpn-nl-post-doit
>>>>>> +        request:
>>>>>> +          attributes:
>>>>>> +            - ifindex
>>>>>
>>>>> [...]
>>>>
>>>> -- 
>>>> Antonio Quartulli
>>>> OpenVPN Inc.
>>
>> -- 
>> Antonio Quartulli
>> OpenVPN Inc.

-- 
Antonio Quartulli
OpenVPN Inc.

