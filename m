Return-Path: <linux-kselftest+bounces-19146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EE3992994
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 12:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01F41C22176
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA6E1D1E75;
	Mon,  7 Oct 2024 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Mys1Duz7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A21D131D
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Oct 2024 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298678; cv=none; b=WPQHo4gZMo6p2ZSsulaJ5UtTPVrDIcQUPyPaDfeGRbEqTHFAE0yq2ZFh3nPJDXpQbU0z0Ch2AoMQXpVTLZ97G43lRd6utwK0nb2nRu97pJ9sXrqlSSsAbKTXixG+9eU6N20zujPgsZH89ddoK6d3kmSkmLtjbxwLmzNFLMRj7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298678; c=relaxed/simple;
	bh=eHP43u3qi9pYZ0wncTBBS6KMxs5K+qW3l2saey10/F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLSnM4Uv4M6P4/BOVUwSS20S4PehoaZm7iXLYsT6ht30a3IHyDGs07d9iuDJNZvudFwpPX9IybzZ9bLyK0l0TaJadO61yRD+OKAU54lA2Z4SXARSIDaRnihHJq6zHrj3WIm3NjkAX0Lrq04ecvq/uKw+qt/1KEl5GgOWYi+5ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Mys1Duz7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cc846fbc4so3367083f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 03:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1728298674; x=1728903474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W00gMYbiVAg6GfWlKaTZSO9FJAI5UCkdkkjNlBjRJBs=;
        b=Mys1Duz7ibMw85uRXKNOHB7/ydE867YPXyESlQhJ0i2XaXkVgwSqnEFPHWee/sOnBN
         tSpc8Sty59L/Dt/N4RGh0uX+nh+lS9afsdUcoN1AAk5Pe8bQAgwuQWzvMXomZCFv15e3
         DnPnBVr2gP5uIT1o20aKDUb17zXFxdQna0YJv2/ebqTL3IrDXFjsLiHNA60CJOz07dJy
         kN6jPDdP6W/hCF4WylqKUWDVGfJebNCstA1iRaswDK6enE0CYJymMJMc6kjRRk636DdK
         AJNraE1CuYxx6HVKMIhUkU+HBWqWYelPe2cOuTlz/ThijAKr/RsCP0O9FZjnIStklQFh
         hpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728298674; x=1728903474;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W00gMYbiVAg6GfWlKaTZSO9FJAI5UCkdkkjNlBjRJBs=;
        b=PCeiFG6/R0Fofc/sd0ZA/Y25WyaI+UGwXGMZzj6ssIclFl4CpLjii+nNQw/w1ldG0g
         m0UrWiq6BrnV4VpI85e8YzPX87U+Eg1zRU0YNgTFIkq31m/hSOFpcKIL1KG57o3rfiYV
         pNy5a2PUs+qLHW+4KZtspJKzhdkM52JdOyUy5e55vmyxREleNTsT6wX9YtOFXeXH9t6T
         4mc6a0vyjLduZeA5uB50/R+L7nJy9bOobc/cEYcQZmH/qCaYpIUXTH7OdSd6z7/BucFt
         igVNc0QxPzmr3SE4PyIlAogN11XcOjH7bBnoeRthV9AOOEYGfu6QLw3y+IPnyPLiwtmE
         hbhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUep35L5h6vV6Kj8rVhik4gptc+bYQKplo+obhOT1O7W2W/nqitv3Hw2JTDyH0//Mi5lgTNY4Oz4Wz+H6wM2XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQCArcropbiKVfCPSnBCxqk3izns0V5K25lqZxbfWx4ZwyG4t
	ZnlNoXxdFuEo5RIGwXws8s9K6PMMw3zjroC+69sycgWw5Buat+De6qMscMuMcnY4sXl2GmpKjq+
	L
X-Google-Smtp-Source: AGHT+IHuyUq1UUmMuugzWM9dizwtSx980ga2l3e7y/czQZiHAAwI07TLQlpmSXq4sS8NK5sD/k8LjQ==
X-Received: by 2002:adf:f884:0:b0:37c:cc96:d1cd with SMTP id ffacd0b85a97d-37d0e79c51emr6205443f8f.34.1728298674219;
        Mon, 07 Oct 2024 03:57:54 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:efc3:b0c0:f886:97ea? ([2001:67c:2fbc:1:efc3:b0c0:f886:97ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e89624sm70917915e9.12.2024.10.07.03.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 03:57:53 -0700 (PDT)
Message-ID: <76edb6d9-5b17-499e-ad0f-c0eee3cd547c@openvpn.net>
Date: Mon, 7 Oct 2024 12:57:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/24] ovpn: add basic netlink support
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-3-37ceffcffbde@openvpn.net>
 <CAD4GDZyZruh+gbA+=Wu_2aSOnaF8R6eDRU0=EE0qnWe-bTi2-Q@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CAD4GDZyZruh+gbA+=Wu_2aSOnaF8R6eDRU0=EE0qnWe-bTi2-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/10/2024 18:13, Donald Hunter wrote:
> On Wed, 2 Oct 2024 at 10:03, Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>> +definitions:
>> +  -
>> +    type: const
>> +    name: nonce-tail-size
>> +    value: 8
>> +  -
>> +    type: enum
>> +    name: cipher-alg
>> +    value-start: 0
> 
> value-start defaults to 0 for enum so this is unnecessary. Same for
> the following enum definitions.

ACK

> 
>> +    entries: [ none, aes-gcm, chacha20-poly1305 ]
>> +  -
>> +    type: enum
>> +    name: del-peer-reason
>> +    value-start: 0
>> +    entries: [ teardown, userspace, expired, transport-error, transport-disconnect ]
>> +  -
>> +    type: enum
>> +    name: key-slot
>> +    value-start: 0
>> +    entries: [ primary, secondary ]
>> +  -
>> +    type: enum
>> +    name: mode
>> +    value-start: 0
>> +    entries: [ p2p, mp ]
>> +
> 
> [...]
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
> There's no dev-get do/dump op. I think there should be one for
> diagnostics and metrics.

I am not sure how much information it can provide (as of now we only 
have the 'mode' that is being set upon creation).

In any case, I am not against implementing the op now and extend it 
later as we see fit.

> 
>> +    -
>> +      name: key-new
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Add a cipher key for a specific peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - keyconf
>> +    -
>> +      name: key-swap
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Swap primary and secondary session keys for a specific peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - keyconf
>> +    -
>> +      name: key-swap-ntf
>> +      notify: key-new
> 
> This doesn't work because key-new doesn't have a reply. You should
> define it with an event: block instead. You can see the build errors
> here:
> 
> make -C tools/net/ynl

Oh, I wasn't aware of this subfolder.
Thanks for pointing it out!

I am thinking that it may make sense to implement a key-get op to 
extract non-sensible data about the keys (i.e. what cipher was 
configured). This may be useful for debugging as well.

At that point the key-swap-ntf can re-use the key-get as notify.


Cheers,

> 
> CC ovpn-user.o
> In file included from ovpn-user.c:8:
> ovpn-user.h:1194:33: error: field ‘obj’ has incomplete type
>   1194 |         struct ovpn_key_new_rsp obj __attribute__((aligned(8)));
>        |                                 ^~~
> ovpn-user.c:835:35: error: ‘ovpn_key_new_rsp_parse’ undeclared here
> (not in a function); did you mean ‘ovpn_dev_new_rsp_parse’?
>    835 |                 .cb             = ovpn_key_new_rsp_parse,
>        |                                   ^~~~~~~~~~~~~~~~~~~~~~
>        |                                   ovpn_dev_new_rsp_parse
> make[1]: *** [Makefile:41: ovpn-user.o] Error 1
> 
>> +      doc: |
>> +        Notification about key having exhausted its IV space and requiring
>> +        renegotiation
>> +      mcgrp: peers
>> +    -
>> +      name: key-del
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Delete cipher key for a specific peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - keyconf
>> +
>> +mcast-groups:
>> +  list:
>> +    -
>> +      name: peers

-- 
Antonio Quartulli
OpenVPN Inc.

