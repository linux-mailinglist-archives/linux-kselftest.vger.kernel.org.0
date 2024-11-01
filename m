Return-Path: <linux-kselftest+bounces-21266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D05B9B8790
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 01:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D034428289D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 00:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05FBE571;
	Fri,  1 Nov 2024 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIsiYimV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64225125D5;
	Fri,  1 Nov 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420230; cv=none; b=WHqCjphoWvGLtKgk1HxPyN5AAefi/QAD+ra9djvT+1oxdgRV2GXnJ1DZWjJYONFF7TMKv5xCVAzKeCKgvodrRXjLxb9W79Of1DFP/u2Qd9wtCn+k/XVUqUv1H1mdNT/JBEVeC24Dc3dz0TNUDsGsP5myDGsrgqyxKzauVw8EL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420230; c=relaxed/simple;
	bh=WQg0JGL8yptHRH9IRuyPlWC2E1pyfVxO5c82rqB++qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mj0d7gecngX4hWvCnWA9FpB/1tHw/gUA8DhXwWj3R+PAybmAS6bGY+NcTzYT41OGlbyFvVVoex+t3zSzJc8e1iou7eEE47fsV5rfdvJ5ttNuFljlgkxLOW5cRRzTrmLXPg5m7ZdF5g3ee/UiB8znYJnTzDdKRExwrTJWSdIrvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIsiYimV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso13094535e9.3;
        Thu, 31 Oct 2024 17:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730420223; x=1731025023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2EJuEyFiN68hhK8MSxL7dIq2AKKdbwQxq43XbmG+7Y=;
        b=DIsiYimVFQc/RkMmV3TBqV8a+ZI6le+2Gg9by2v2oYRS3Q0bFpYJ91tj+P6/vh4BnU
         Nn/46zeMjYzWe41WlBorhfKbNK9+uuddTRNN+kek2ufvx5a/WAo6Fn3Fhyvqkl56xcQN
         wYYU9llqyhDXXXJP9wdcJay2Fe4AJVG6+uoavq8UlyPmlOURJ0kDIGKyPCwttZLSoBP+
         nMipbysXqxhh096J6KShCpjE/4T9nxeamp2zp6yLF5LcucMoL1Cp+YxTXg/yJ1oBSieh
         0zc83XfGeaCNnEK9TYAD71nqw0TgeJPuBlPZyDvyDduiRNgiE5LBvWTA5FrEjbiaJyJn
         ibZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730420223; x=1731025023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2EJuEyFiN68hhK8MSxL7dIq2AKKdbwQxq43XbmG+7Y=;
        b=L1PGzhu/+pEXty1d2mhEYfhGIr4CaMvGmGvXvbCUZvQgiLfBkgagg9FMswl2gmymko
         95tUSYxacVaC7mqZ9bM5LCPR0vV08SbyxU76jznEY2yC1O5K6JLccKix5ysIKX4QYX/W
         dPf7Fc09+x+Z1Lj4OZcLEd8/oTUqUhTOUOMBXSWv0b26iDG+Oa2JfmZ1/OX4wgGRSfV3
         W4mmIWJcghZngDF4JwzvZMtjnjuN4c+0PsZjMI9DSb+IQxZY5F8NeIJsTrYreCkPlqq7
         JwG05zwep68Fm5UrlyMhBnFq4HlRCXc+3nEAqsSUWfXeSJRn8pIqbtlwasdJBkfuYDRd
         DvXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC/KbzSaRm+sIA18NUg+bU2bYdZ3pn1e2menvYKUn97Nhna3Wka1R9wmHS3N6B6KRmPUdV0Qw9ylrwrVbd+fqB@vger.kernel.org, AJvYcCVVSrvgnMeBbwpw3AfdCmF+onglpIa+MxWuQMB75L/nQ9SYZ5ZAfyJohScGbhPCFf3Lu1jMCPvh@vger.kernel.org, AJvYcCX4XT9kppZCalIV9Qoc7cWipFVy8YjmVVv7sCggKAqKYWcrCYOm5XhrqIobL2gnHNn7Az1jI92Tzqe1qeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzCQdAusDadwTT8U7glNyDGJ+I90i3s+ZmA42NMxfY7JZE01o
	iTEYVj2GD92M7UIgpC5F9ncoXAUR13K4uK27Nnp1ad7/Qqy09gh+
X-Google-Smtp-Source: AGHT+IEK/UPPFoOiVemODI/IruJOOPVGN2GFsiItXtbwEv0NFeSgbbNb/dKCwgxzvtGzdyUfkMZG4g==
X-Received: by 2002:a5d:598d:0:b0:37c:d4ba:1127 with SMTP id ffacd0b85a97d-381be776e4amr4792793f8f.16.1730420222344;
        Thu, 31 Oct 2024 17:17:02 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e67csm3456537f8f.75.2024.10.31.17.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 17:17:00 -0700 (PDT)
Message-ID: <e05ca0a3-5573-4617-8bb9-f33c062fa519@gmail.com>
Date: Fri, 1 Nov 2024 02:17:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/24] ovpn: add basic netlink support
To: Jiri Pirko <jiri@resnulli.us>, Antonio Quartulli <antonio@openvpn.net>
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
 <056588a7-de1b-4416-8553-750c8d20dc97@openvpn.net>
 <ZwUrAn8xrF2BCrMp@nanopsycho.orion>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <ZwUrAn8xrF2BCrMp@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jiri,

Sorry for the late reply. Could you elaborate a bit reasons for the RTNL 
interface implementation? Please find the questions inlined.

On 08.10.2024 15:52, Jiri Pirko wrote:
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

Do we consider word *should* in terms of RFC 2119:

    SHOULD   This word, or the adjective "RECOMMENDED", mean that there
    may exist valid reasons in particular circumstances to ignore a
    particular item, but the full implications must be understood and
    carefully weighed before choosing a different course.

I am asking because rtnl_link_register() allows ops without .newlink 
implementation. What makes .newlink implementation as least optional and 
gives a freedom in design.

Let me briefly summarize my argumentation from the referenced thread. We 
have two classes of links point-to-point and point-to-multipoint. The 
major class is PtP and RTNL is perfectly suited to manage it. While PtMP 
is a minor class and it is an obstacle for RTNL due to need to manage 
multiple peers. What requires a different interface to manage these 
peers. Lets call it GENL interface. A PtMP-class netdev without any 
configured peer is useless, what makes GENL interface for peers 
management mandatory. Mandatory to implement in both user- and kernel-space.

Link creation can be implemented using any of these (RTNL or GENL) 
interfaces. GENL interface is already mandatory to implement in a 
user-space software, while RTNL can be considered optional to implement. 
So, implementing the link creation using GENL requires only a new 
message support implementation. While implementing the the link creation 
using RTNL requires a whole new interface implementation (socket 
read/write, messages demux, etc.).

My point is, GENL-only management gives us consolidated and clear 
solution, while GENL+RTNL requires code duplication and causes a 
complexity. That's it.


Jiri, do you see big flaws in this reasoning?


>> Recently Kuniyuki commented on this topic as well in:
>> <20240919055259.17622-1-kuniyu@amazon.com>
>> and that is why I added a default dellink implemetation.
> 
> Having dellink without newlink implemented is just wrong.

Could you clarify this statement please? I can not recall any 
documentation or a code block that enforces .newlink implementation in 
case of the .dellink presence.


Generally speaking, I can understand a feel of irregularity when looking 
at code implementing delete operation without a link creation 
counterpart. This confusion can be resolved taking into consideration a 
difference in a nature of these operations. A new link can not be 
created automatically while an existing link can be removed 
automatically without any extra inputs.

.newlink designated only for fulfilling user's requests since it 
requires extra information unavailable inside the kernel. While .dellink 
has two semantics: (a) user's requests fulfilling, (b) automatic cleanup 
of unneeded remainders.

 From that perspective, having an option to implement .dellink without 
.newlink implementation looks reasonable.


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

--
Sergey

