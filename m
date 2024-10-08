Return-Path: <linux-kselftest+bounces-19221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CC999420B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 10:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95578290273
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086FD1E906E;
	Tue,  8 Oct 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MFcmo2Rb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD11E9061
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374507; cv=none; b=HBNUr8fml+kDnkIK54dK+NCGB/YvVdWk72Z27KjxTLfi5R5Lfwylpz2zuXTv2XozqJSao74Zg2yH2EeqoNNiQoeJAOzVoYyQd9FpU7igdaKRSu6Vg7CZz2GN2EvNrG/9zNaJCgcDQ71Mj5ZUPMdfqdVT17qZXmceYnCGBJqXwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374507; c=relaxed/simple;
	bh=LZmDz6iNhvMt90dfMzQq3WFtioFDN/yJfqXcR37OWuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avvz97MDd2SZXgQ37CM2qURksBtbQP8/hPcPeCm+2WlciQkVtjuahAkaTkDYeQzA86iPcCqXw1dwmqZM7Eoil4FKLrNQnTVssGj86BWEJXdq/MJwLjl4i4+VpdgomqX9plSpB6USKYFDAUSpMk3kYbDMkbwG9wXtD4YepvNjeDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MFcmo2Rb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ccd81de57so3523187f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 01:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1728374503; x=1728979303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TehQzGqlQ7/A72VhokMvGGbcSaxUL90Hefcysi5X+2c=;
        b=MFcmo2Rba4eNnyClR6GWKCNjp/SNCtzlbe9rJjWztDhbLuBepSQ1YKrJRf2P09lnPM
         XxJ9Tl/C4MdB3T2DR02jXkRV5930AuHQmKovGLfJUpwx8Qifi5+BSSoJyotZbJG4zliZ
         FqWAWtgKt0xXTdKMOL1dZXmWu26EWcvpw8YnpOwPajIxTOo7GmEFJUIkvz7aRETgkxDq
         22ZoHo7NHcp0lqfvfWRn4db74u6W67pkFdA7GIxfTLENyiN3mWyl3xFyK+pmFHaCppE0
         rwicJgfzOwBweuNNj6evDFL4ps4lbjZWYEziRbB1GIzZJxf6el6h5rqHs7jK3uaGoVyy
         Hbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374503; x=1728979303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TehQzGqlQ7/A72VhokMvGGbcSaxUL90Hefcysi5X+2c=;
        b=A4Vtl3fvHNMDKTN3aCEwb+9/uENvDZzM9ZFhVzckdORiTUNzHlV3udrPDSCNGzi6kU
         VJMmcFfvGA5ES+NWMaKk1NaT7IBC14lk89GvRCS9kPYA1AwIKuH2nhtSs2VG2Qe10Noy
         mS0Td4v675tscy+om19YZxsOrWKp8KoTyDGFcCIepbSTyScO6DaTO9y+e7Wp9k/Z+dko
         dGIyWEmVUdddIrZdkxuLSp54ODorfEbzazFOHqHIFh6KekzZhK4mgtxSkx9deed0vDxU
         feVnKVH16lyO+D6tACkC1D8RazELgjFSfmE7SUS2GVjxhF1NVT4qTq8jRVHp6ym2mc9w
         +3Tg==
X-Forwarded-Encrypted: i=1; AJvYcCViZyFuwkq5ekFkKC5Gfg9bhEfZhDPkVI0riCFALF+agsDsaRxt9x+vVhA17sKVKM12GgX+tuXXeMznDnG/5tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCdYqlcsikK8j7YB9uhH8BnyGg0R2OuNZRP9GTAQjyQx7AGG7
	xgoqs46H0tBmBBKfa2oeY2U4VGI0UhWgZ1/dSylkh0v6wVhvvAKFn+36FLa0Pyo=
X-Google-Smtp-Source: AGHT+IH9ziQgmbKEumziF2/Xxptvs0roO67voR7Em/ui/HeZGyfcmtQFejktMLrTRIjO41lNztSXcQ==
X-Received: by 2002:a05:6000:2a0c:b0:37d:3161:12de with SMTP id ffacd0b85a97d-37d316113c0mr748358f8f.23.1728374503502;
        Tue, 08 Oct 2024 01:01:43 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:2089:55b1:87be:76d4? ([2001:67c:2fbc:1:2089:55b1:87be:76d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d2ce265fdsm943122f8f.83.2024.10.08.01.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:01:42 -0700 (PDT)
Message-ID: <fd952c28-1f17-45da-bd64-48917a7db651@openvpn.net>
Date: Tue, 8 Oct 2024 10:01:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/24] ovpn: add basic netlink support
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sd@queasysnail.net, ryazanov.s.a@gmail.com
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-3-37ceffcffbde@openvpn.net>
 <ZwP-_-qawQJIBZnv@nanopsycho.orion>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
In-Reply-To: <ZwP-_-qawQJIBZnv@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 07/10/24 17:32, Jiri Pirko wrote:
> Wed, Oct 02, 2024 at 11:02:17AM CEST, antonio@openvpn.net wrote:
> 
> [...]
> 
> 
>> +operations:
>> +  list:
>> +    -
>> +      name: dev-new
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Create a new interface of type ovpn
>> +      do:
>> +        request:
>> +          attributes:
>> +            - ifname
>> +            - mode
>> +        reply:
>> +          attributes:
>> +            - ifname
>> +            - ifindex
>> +    -
>> +      name: dev-del
> 
> Why you expose new and del here in ovn specific generic netlink iface?
> Why can't you use the exising RTNL api which is used for creation and
> destruction of other types of devices?

That was my original approach in v1, but it was argued that an ovpn 
interface needs a userspace program to be configured and used in a 
meaningful way, therefore it was decided to concentrate all iface mgmt 
APIs along with the others in the netlink family and to not expose any 
RTNL ops.

However, recently we decided to add a dellink implementation for better 
integration with network namespaces and to allow the user to wipe a 
dangling interface.

In the future we are planning to also add the possibility to create a 
"persistent interface", that is an interface created before launching 
any userspace program and that survives when the latter is stopped.
I can guess this functionality may be better suited for RTNL, but I am 
not sure yet.

@Jiri: do you have any particular opinion why we should use RTNL ops and 
not netlink for creating/destroying interfaces? I feel this is mostly a 
matter of taste, but maybe there are technical reasons we should consider.

Thanks a lot for your contribution.

Regards,


> 
> 
> ip link add [link DEV | parentdev NAME] [ name ] NAME
> 		    [ txqueuelen PACKETS ]
> 		    [ address LLADDR ]
> 		    [ broadcast LLADDR ]
> 		    [ mtu MTU ] [index IDX ]
> 		    [ numtxqueues QUEUE_COUNT ]
> 		    [ numrxqueues QUEUE_COUNT ]
> 		    [ netns { PID | NETNSNAME | NETNSFILE } ]
> 		    type TYPE [ ARGS ]
> 
> ip link delete { DEVICE | dev DEVICE | group DEVGROUP } type TYPE [ ARGS ]
> 
> Lots of examples of existing types creation is for example here:
> https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking
> 
> 
> 
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Delete existing interface of type ovpn
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
> 
> [...]

-- 
Antonio Quartulli
OpenVPN Inc.

