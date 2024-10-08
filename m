Return-Path: <linux-kselftest+bounces-19224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE139943EC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 11:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627F41C24918
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB7F13A878;
	Tue,  8 Oct 2024 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RkOaqHUt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DB13AA45
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378965; cv=none; b=p9y+PFM9Kc/1zXmgtpBTeMov1mLvjG19DBHcr+LlqdeuRC7qHahnXb1SfdhCuGfQJG649MOWHagHNPB0JoI7/Vu6f7RtfKcde55BKy/1rhkuci+Xk7y8OoqFN2kEE/f7j2bXOE8CADpRMhF7AX+dtywu1c9tOPdx9+WsQJDHY1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378965; c=relaxed/simple;
	bh=BIb6ky49pKlcCxSWFCn3FbS4FEb/o0sO1hh+b6iUjUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/YhMNH9qkocf54m0MgKJVS4JMm/AGZEiieGU9cX/WuKF27EB0Ae4G8v48pkaOjb/HokcAg62ekKtal7FfNjFr4rqIY9PelTLXX71cOyDAi+xK0Y2pzNtNxctor5W7d4WtwjZqUhKFZQ8yhPLV0bjsTIBCbAszUDvrNpZcbjDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RkOaqHUt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so55237845e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1728378961; x=1728983761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E/gkpdZua6cNQ8Ih6+gim40kZwxJstT2riF7r2XcuP8=;
        b=RkOaqHUtW5u6Ysn1rsUs9LzYhB/IG6UPDybWXk31L/47phGN5uwgN2gosp2r+WGksk
         j/v4sGkMfxbI6eXN5y5XBTMA76lt+yoHSao5BC1emKK6hrGgrwHEz3gV9tfq7kh9BCwL
         u3eQap7zU+tN2ZcTEF4HqKnhXfTGWWinGoDn7wOt1b1xSK4I2BPyXNgif6HgwB/j1AZs
         7x+oQqx7C5IwB2utKcw6E2A1gg6Eq4S7glQCqkThf+jTKmk7TjxgzyJopLAN0G5+oRHK
         WAcir84wHghETHNG5ZJeHBZBU7tqHkgq15xA7rYm4JR3Eoxi7gPTmPpEG7mb4jQJPvvA
         pOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728378961; x=1728983761;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/gkpdZua6cNQ8Ih6+gim40kZwxJstT2riF7r2XcuP8=;
        b=Paq3WJv9HIBybhGfM+4eY9hy0SLfA1tgkaAw3/4pRQ8U5hW/wrxhgGizNmJMHjbJYL
         jwwfFEKRASsbemctjg8L1Tfq7fCnt04CQGoohohhBsLg97D9fNH02cVTJwB43I4XUC0F
         yCZmZGlhSDMkBGWDTzVyKI6f2ofPBDio+6677VQ2gsWF8nrYxIGk2NKHicjHdrRmp0eu
         DbAror9xiirUG00rSDdN+C9spjTgXxS66dUJtfcYoxgrYSuuo59bzZLc4Bs6/XsZf4Me
         7Ud2QfJ+xIJCZfhB357AYGaL4dYsjyNZX8yAmCxYnKHiiEC0L9r7nTbAzrB7MaRPpkN7
         hmWw==
X-Forwarded-Encrypted: i=1; AJvYcCVvNHTmtzhfVKfYYZbH/erJnI3Ypf6hJQzY3x5gdRbOgppiILeRf7dBe37jTrmLXTW8LnMGMlrpxpINIuopoyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4fL11wu56XYgL/8moCSt6nKGFIqIQ50eAhIkny/I9Ryn/gWm
	ZBg29Od6ei2SDekCdJWRUnsA34UzLSFOJ38a1w3MHjF8IWSSeM+4294gK8UHPvY=
X-Google-Smtp-Source: AGHT+IFNOZCVjkcCMqpKHJe/PgoF2C9Rj5+jWdu3hfVpd90h26lENYFjll829q+i//lQ21ox4TWEWg==
X-Received: by 2002:a05:600c:6048:b0:42c:df54:1908 with SMTP id 5b1f17b1804b1-42f85ab7dffmr112390505e9.18.1728378961171;
        Tue, 08 Oct 2024 02:16:01 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:1075:5147:8807:441e? ([2001:67c:2fbc:1:1075:5147:8807:441e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43056da1d34sm2764855e9.29.2024.10.08.02.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 02:16:00 -0700 (PDT)
Message-ID: <056588a7-de1b-4416-8553-750c8d20dc97@openvpn.net>
Date: Tue, 8 Oct 2024 11:16:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/24] ovpn: add basic netlink support
To: Jiri Pirko <jiri@resnulli.us>, ryazanov.s.a@gmail.com
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sd@queasysnail.net
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-3-37ceffcffbde@openvpn.net>
 <ZwP-_-qawQJIBZnv@nanopsycho.orion>
 <fd952c28-1f17-45da-bd64-48917a7db651@openvpn.net>
 <ZwT0SkGHu5VHQ9Hd@nanopsycho.orion>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZwT0SkGHu5VHQ9Hd@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/10/2024 10:58, Jiri Pirko wrote:
> Tue, Oct 08, 2024 at 10:01:40AM CEST, antonio@openvpn.net wrote:
>> Hi,
>>
>> On 07/10/24 17:32, Jiri Pirko wrote:
>>> Wed, Oct 02, 2024 at 11:02:17AM CEST, antonio@openvpn.net wrote:
>>>
>>> [...]
>>>
>>>
>>>> +operations:
>>>> +  list:
>>>> +    -
>>>> +      name: dev-new
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Create a new interface of type ovpn
>>>> +      do:
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifname
>>>> +            - mode
>>>> +        reply:
>>>> +          attributes:
>>>> +            - ifname
>>>> +            - ifindex
>>>> +    -
>>>> +      name: dev-del
>>>
>>> Why you expose new and del here in ovn specific generic netlink iface?
>>> Why can't you use the exising RTNL api which is used for creation and
>>> destruction of other types of devices?
>>
>> That was my original approach in v1, but it was argued that an ovpn interface
>> needs a userspace program to be configured and used in a meaningful way,
>> therefore it was decided to concentrate all iface mgmt APIs along with the
>> others in the netlink family and to not expose any RTNL ops.
> 
> Can you please point me to the message id?

<CAHNKnsQnHAdxC-XhC9RP-cFp0d-E4YGb+7ie3WymXVL9N-QS6A@mail.gmail.com> 
from Sergey and subsequent replies.
RTNL vs NL topic starts right after the definition of 'ovpn_link_ops'

Recently Kuniyuki commented on this topic as well in:
<20240919055259.17622-1-kuniyu@amazon.com>
and that is why I added a default dellink implemetation.

> 
> 
>>
>> However, recently we decided to add a dellink implementation for better
>> integration with network namespaces and to allow the user to wipe a dangling
>> interface.
> 
> Hmm, one more argument to have symmetric add/del impletentation in RTNL
> 
> 
>>
>> In the future we are planning to also add the possibility to create a
>> "persistent interface", that is an interface created before launching any
>> userspace program and that survives when the latter is stopped.
>> I can guess this functionality may be better suited for RTNL, but I am not
>> sure yet.
> 
> That would be quite confusing to have RTNL and genetlink iface to
> add/del device. From what you described above, makes more sent to have
> it just in RTNL

All in all I tend to agree.

> 
>>
>> @Jiri: do you have any particular opinion why we should use RTNL ops and not
>> netlink for creating/destroying interfaces? I feel this is mostly a matter of
>> taste, but maybe there are technical reasons we should consider.
> 
> Well. technically, you can probabaly do both. But it is quite common
> that you can add/delete these kind of devices over RTNL. Lots of
> examples. People are used to it, aligns with existing flows.

The only counterargument I see is the one brought by Sergey: "the ovpn 
interface is not usable after creation, if no openvpn process is running".

However, allowing to create "persistent interfaces" will define a 
use-case for having an ovpn device without any userspace process.

@Sergey what is your opinion here? I am not sure persistent interfaces 
were discussed at the time you brought your point about RTNL vs NL.


Regards,


> 
>>
>> Thanks a lot for your contribution.
>>
>> Regards,
>>
>>
>>>
>>>
>>> ip link add [link DEV | parentdev NAME] [ name ] NAME
>>> 		    [ txqueuelen PACKETS ]
>>> 		    [ address LLADDR ]
>>> 		    [ broadcast LLADDR ]
>>> 		    [ mtu MTU ] [index IDX ]
>>> 		    [ numtxqueues QUEUE_COUNT ]
>>> 		    [ numrxqueues QUEUE_COUNT ]
>>> 		    [ netns { PID | NETNSNAME | NETNSFILE } ]
>>> 		    type TYPE [ ARGS ]
>>>
>>> ip link delete { DEVICE | dev DEVICE | group DEVGROUP } type TYPE [ ARGS ]
>>>
>>> Lots of examples of existing types creation is for example here:
>>> https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking
>>>
>>>
>>>
>>>> +      attribute-set: ovpn
>>>> +      flags: [ admin-perm ]
>>>> +      doc: Delete existing interface of type ovpn
>>>> +      do:
>>>> +        pre: ovpn-nl-pre-doit
>>>> +        post: ovpn-nl-post-doit
>>>> +        request:
>>>> +          attributes:
>>>> +            - ifindex
>>>
>>> [...]
>>
>> -- 
>> Antonio Quartulli
>> OpenVPN Inc.

-- 
Antonio Quartulli
OpenVPN Inc.

