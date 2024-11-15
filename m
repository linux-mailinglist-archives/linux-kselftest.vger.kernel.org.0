Return-Path: <linux-kselftest+bounces-22088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951229CDC1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 11:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07CFB266B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078A61B393C;
	Fri, 15 Nov 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="A7RtfOW9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE61B219E
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665105; cv=none; b=KH72QkfL367mFwPqf9zSG23qXtP2VC3FMAEeXAarViuPNYylGBzWZzidZUKq49FMHqQJpsFIYtl95E1WfStlXa5cp8rEGmog0Bf1NcZrAXY0Y1V+i/rCfsarxeqjkmFzj8+Ll878WAC0rrsqtnrO6bTWr5ETaFlTNHHMokwLmlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665105; c=relaxed/simple;
	bh=9UFteILIQ/ik06XzpgKEWpar7ygm5tTdXzZSrIpyuGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIqupTxBcJ9odIDZKaD12sTdX6+Cf++BNqE7u9xv4AhY9es6nr8GNto8DQd7XDU/Uy2PSPzma6Wdv+VYoZHttY/v+afx/6KTWRB/6YmGTeaZrmPFfjDvQ6kvn8bwebPKdnIhEn4+Vfis4smk5/lKtoY/3BBGhD+Xs4fPgewH2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=A7RtfOW9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so2457598a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 02:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731665101; x=1732269901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s4OiUEPXpIXkFmw5cnFtFbT/tcT2f3NjsbEMHrFWlh0=;
        b=A7RtfOW9qlapuVlN4N10E0Zm2SfFLDgaJ555GYxQAxl+dpNQIDqutAXvNtgO9QbnRE
         gNUCz+oS8xgEy3LnZSgUqmGVkYUCz79z7VKNGR6vZ5Tvl2AUqaO+r/X4HrVjgSHarpSL
         nDO0yQiR6jRziBDI2NKYybPNthX2SJWc7x9JV3vya8vmdYUlqLz9DDAZNGY/H4KXJyR5
         8ummD7i0IQ/V+SD1ltcxNC8exbJ8JP7wItXxjI6OahL+0Hwh0ik5R9TQrTb2j6/ryxab
         2InZOKZdBiSUHpTyB0WKC/Bk6jvySGcfzshPi0Y1RpD7O+xXMaPF0IiBCPMbtAi6WlVl
         K0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731665101; x=1732269901;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4OiUEPXpIXkFmw5cnFtFbT/tcT2f3NjsbEMHrFWlh0=;
        b=S5kYm0tpWydOH4/c8TOKI4D+pTZ6hhmfbVXerJ7M6roMyqmjTDLPhfLaqFqRG5KRxs
         IE9XLgxwBeOw+oJ1yAon/UClgsjiKYhnAlceQzh090gztbEeTSCryMj/NSKdj3L9CfUx
         htrNuC+KQVycgOJxbIPgCMDTYbRT8kekiJEbnX4UbrdW9C/kqDvN6IYjUHCEX8FSrxMy
         Nk9qQ9UviAPIZeegTGa9/ZOn8BrkouisD00xayy8zDSszYpEulsido1Tk6p0NAhNznhY
         CeQyQt+9b460HX4GZzWVF7dse3iGpYUxOOUtKA61iFelaCZ+1ibaojroGmGysNXlVXC4
         XmgA==
X-Forwarded-Encrypted: i=1; AJvYcCWsgXL8bvtkitrEXEj+RVPP90UzyNELf56J+V0LGMe7bWsWlkC9cwhVIZDj9c1X2z/eOkz5sxMYi6sNvydhEJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw33j3VMiV0eik0XGTHvJGIqxTMQQqGtvGcn3HBb9hY16/c7TGa
	Fj65l4v2pOjJcEPztXqe8pM8dhO5x/znm4K1eABRKNnV224Y9pkmjEgrWiaKLrs=
X-Google-Smtp-Source: AGHT+IEp/xxelHfn3FkGS4W98jXXPoUegJ3cpzn/2IJRmvvo3KBb1RfaEkuNJ/akU0KifsYqg7tpLw==
X-Received: by 2002:a05:6402:34cc:b0:5cf:7473:3318 with SMTP id 4fb4d7f45d1cf-5cf8fc315f9mr1617693a12.13.1731665100646;
        Fri, 15 Nov 2024 02:05:00 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b8a4d4sm1423472a12.4.2024.11.15.02.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 02:04:59 -0800 (PST)
Message-ID: <a8f3a9ca-698d-4b4e-ab4b-7d8aa651dddc@openvpn.net>
Date: Fri, 15 Nov 2024 11:05:24 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 03/23] ovpn: add basic netlink support
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-3-de4698c73a25@openvpn.net>
 <52a2f654-29e5-4567-b5f8-8362fa55c1e1@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <52a2f654-29e5-4567-b5f8-8362fa55c1e1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/11/2024 00:15, Sergey Ryazanov wrote:
> On 29.10.2024 12:47, Antonio Quartulli wrote:
>> This commit introduces basic netlink support with family
>> registration/unregistration functionalities and stub pre/post-doit.
>>
>> More importantly it introduces the YAML uAPI description along
>> with its auto-generated files:
>> - include/uapi/linux/ovpn.h
>> - drivers/net/ovpn/netlink-gen.c
>> - drivers/net/ovpn/netlink-gen.h
>>
>> Cc: donald.hunter@gmail.com
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> [skipped]
> 
>> diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/ 
>> netlink/specs/ovpn.yaml
> 
> [skipped]
> 
>> +attribute-sets:
>> +  -
>> +    name: peer
>> +    attributes:
>> +      -
>> +        name: id
>> +        type: u32
>> +        doc: |
>> +          The unique ID of the peer. To be used to identify peers during
>> +          operations
> 
> nit: could you specify the scope of uniqueness? I believe it is not 
> globally uniq, it is just interface uniq, right?

Yeah it's per interface/instance.
Will make it more clear, also for other IDs.

> 
>> +        checks:
>> +          max: 0xFFFFFF
> 
> [skipped]
> 
>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> index 
>> 369a5a2b2fc1a497c8444e59f9b058eb40e49524..d5bdb0055f4dd3a6e32dc6e792bed1e7fd59e101 100644
>> --- a/drivers/net/ovpn/main.c
>> +++ b/drivers/net/ovpn/main.c
>> @@ -7,11 +7,15 @@
>>    *        James Yonan <james@openvpn.net>
>>    */
>> +#include <linux/genetlink.h>
>>   #include <linux/module.h>
>>   #include <linux/netdevice.h>
>>   #include <net/rtnetlink.h>
>> +#include <uapi/linux/ovpn.h>
>> +#include "ovpnstruct.h"
>>   #include "main.h"
>> +#include "netlink.h"
>>   #include "io.h"
>>   /* Driver info */
>> @@ -37,7 +41,7 @@ static int ovpn_newlink(struct net *src_net, struct 
>> net_device *dev,
>>   }
>>   static struct rtnl_link_ops ovpn_link_ops = {
>> -    .kind = "ovpn",
>> +    .kind = OVPN_FAMILY_NAME,
> 
> nit: are you sure that the link kind is the same as the GENL family? I 
> mean, they are both deriviated from the protocol name that is common for 
> both entities, but is it making RTNL kind a derivative of GENL family?

I just want to use the same name everywhere and I thought it doesn't 
make sense to create a separate define (they can be decoupled later 
should see any need for that).
But I can add:

#define OVPN_RTNL_LINK_KIND OVPN_FAMILY_NAME

to make this relationship explicit?

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


