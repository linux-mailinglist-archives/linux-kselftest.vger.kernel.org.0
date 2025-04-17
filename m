Return-Path: <linux-kselftest+bounces-31045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A20DA91A20
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C7446219C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC141237168;
	Thu, 17 Apr 2025 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F+cqJcuT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471C23644E
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888261; cv=none; b=kkXsQeSGtXpIwRKrpY7OjdSlOFiraRxNRpHyg3tawCZ4tEw3oovfJgIKgQxIahOInz3UlzukHHpoc1tUYY+gs1zpEZ0onYSV58msXNw6bIRTRqBpiJlLhkON74C4RaxmeilghLasXf/fzh87UlmCwizwS2y3fSpuH0Oh7vHoNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888261; c=relaxed/simple;
	bh=4WVa4tlHKmMnIZkrmijwlyWKAyT/54rWx0L6IZz43t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWIZeNzJBnd5y5hqYCuGbPC25shzrQ3hLK8tZXmfwElD4wAf9is7FypNeSwdBwfZQA+Xe/ao8T0OHZHVF0iks1yKTr0D6k9a+pYJub52PRinJeMRdDfJuQTQgIG/ALF48DzqPoMzOuAFebdLsAzu6sHrIZfN/lS6FFOVONkhP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F+cqJcuT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39ac9aea656so855916f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 04:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744888258; x=1745493058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j2ecxvMlFGge0FVUqk6iTuFS/LC9a5IfwQDFL8JLrgw=;
        b=F+cqJcuTKMOmndEhClG8lFakbh6I0gpNORpBskyeGn4qOyUmaug+l27q/jTHnAA87H
         PHraTYYXUp5XS88EnXbsSrJt3zLHGZVhrNQV7h9cwZxBP92mL84gIGsXyGot+2lbKwsl
         EyaB2mRDycpeeZV2fshJJ6nkoAaexAlOvvyEV5lvvpnxNtYzxJJepB21qMy+pMQ3fUbg
         uTwHZ/vv7htX6fOfTPFDPinoVoh4yLyuBpCAcmJaXTA2sQsWmtoTT4TXzEqUfNTvCUBL
         S04qsnVq/m29kzCAn+ct09Pldo05ha36yUrtE9JVu/jQDstxtznU93Roau0N0T1qlXDE
         x09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744888258; x=1745493058;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2ecxvMlFGge0FVUqk6iTuFS/LC9a5IfwQDFL8JLrgw=;
        b=SAvqDYwwW5imkipx+AqQW3Cb3wrSDNiLoakyIxWvj8daqKSOKFRlvzeLjLwCu0I8BN
         XnVh9WfNdxGz694W9rgYTb4alWDGt4NeaGi+YVCIC6BNPhCRXM+KuoNT8G7i3h2tJQpZ
         yG+TzWxH5/CgkD4c1Qd4Ry2874h7kplP1y+BytyD/FCPQj2dz0u7PumxtoW8V7lGLVkl
         IK1jsfs+cMBmf+Pjyrny8PsdkUBsFv1xIiWdvfz+SKZ8poLEu/c5LrqlCy+mYKanY3sZ
         8zMk0Va9ekbNIrcqdViuFWaq1hdAAvGRHhSqMNe8xbF6EpkxQjxbSEaXvVEHmX1xS1HJ
         PaJw==
X-Forwarded-Encrypted: i=1; AJvYcCXBZ/XgpIDt/yPib6du9y4gcm/0hvKgIPe8Dbvf1urY/0sRjuadKMbLQ/GZgZqWdblmCMS9HxLYgrexGfdQcSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jehhm35LcAlR7eYkJS2iA1Z+u73raX8mDzS3y+Qu74+jokAm
	HTF/46DYXgQZOqwY/DhmTA4uUHMn8OIkjhEaBXAVVMSVHlnWyIM1OGFPYL2wEQn2BixvOmLnYH7
	e8t0CRfF3kPnng1MybTxv+OzxXqe+rnocuW2VkHpTXylgCD3U1hW5/CCuPjA=
X-Gm-Gg: ASbGncsSrgdt8N1+KSx+0o7DE/ztjN59vpr+Bgd3oPV1oCPpESEL8anRwQqErkOlBxQ
	venJ5Q7OqLusnOve0FoSBKsQlxBWyL73G3hz9IyTnjZ+IDdCTc/UevEeSEw31XwlQh7tousP4iN
	5JqDit2l/nZSSgGSVQolzM3uoT6dHcP+gBIiCbu9HZsm7dkyxbyVv8VxvE2+S7uxmzgt3NYmhbu
	H8Omwnsjngl3UCiaUD6VQOg8yFgnWDpbnV108gbIYMH9MZ5PsWg1XvXAIrYSD+QsDeGWnpoSqMH
	FsuvlA13KrC91oeT/1SsOnzV6EGcgsBLtFiBEcOkikwRpjkpRt6rquDrfkO5+R4F2mK8zqqyf7p
	LNFKk3PmX
X-Google-Smtp-Source: AGHT+IGBNChZlUvCoOUWUTudYlb6W7GE4ujI1IR03t50H3uSVsX3Rmw4vcS6YA7Xt3NrcYcWnSBZpg==
X-Received: by 2002:a05:6000:1887:b0:38f:2766:759f with SMTP id ffacd0b85a97d-39ee5b9d6f7mr4706617f8f.41.1744888257677;
        Thu, 17 Apr 2025 04:10:57 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:dbd:fe3b:43d:324c? ([2001:67c:2fbc:1:dbd:fe3b:43d:324c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae979620sm20052067f8f.52.2025.04.17.04.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 04:10:57 -0700 (PDT)
Message-ID: <39f2793b-97c9-4e84-a62f-34c25f1fd635@openvpn.net>
Date: Thu, 17 Apr 2025 13:10:55 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v26 00/23] Introducing OpenVPN Data Channel
 Offload
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
 <8bfc6c5f-4bfc-4df4-ac52-b96d902a9d7f@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EZmhJFwEIAOAWiIj1EYkbikxXSSP3AazkI+Y/ICzdFDmiXXrYnf/mYEzORB0K
 vqNRQOdLyjbLKPQwSjYEt1uqwKaD1LRLbA7FpktAShDK4yIljkxhvDI8semfQ5WE/1Jj/I/Q
 U+4VXhkd6UvvpyQt/LiWvyAfvExPEvhiMnsg2zkQbBQ/M4Ns7ck0zQ4BTAVzW/GqoT2z03mg
 p1FhxkfzHMKPQ6ImEpuY5cZTQwrBUgWif6HzCtQJL7Ipa2fFnDaIHQeiJG0RXl/g9x3YlwWG
 sxOFrpWWsh6GI0Mo2W2nkinEIts48+wNDBCMcMlOaMYpyAI7fT5ziDuG2CBA060ZT7qqdl6b
 aXUAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJmaEkXAhsMBQkB4TOA
 AAoJEEjwzLaPWdFMbRUP/0t5FrjF8KY6uCU4Tx029NYKDN9zJr0CVwSGsNfC8WWonKs66QE1
 pd6xBVoBzu5InFRWa2ed6d6vBw2BaJHC0aMg3iwwBbEgPn4Jx89QfczFMJvFm+MNc2DLDrqN
 zaQSqBzQ5SvUjxh8lQ+iqAhi0MPv4e2YbXD0ROyO+ITRgQVZBVXoPm4IJGYWgmVmxP34oUQh
 BM7ipfCVbcOFU5OPhd9/jn1BCHzir+/i0fY2Z/aexMYHwXUMha/itvsBHGcIEYKk7PL9FEfs
 wlbq+vWoCtUTUc0AjDgB76AcUVxxJtxxpyvES9aFxWD7Qc+dnGJnfxVJI0zbN2b37fX138Bf
 27NuKpokv0sBnNEtsD7TY4gBz4QhvRNSBli0E5bGUbkM31rh4Iz21Qk0cCwR9D/vwQVsgPvG
 ioRqhvFWtLsEt/xKolOmUWA/jP0p8wnQ+3jY6a/DJ+o5LnVFzFqbK3fSojKbfr3bY33iZTSj
 DX9A4BcohRyqhnpNYyHL36gaOnNnOc+uXFCdoQkI531hXjzIsVs2OlfRufuDrWwAv+em2uOT
 BnRX9nFx9kPSO42TkFK55Dr5EDeBO3v33recscuB8VVN5xvh0GV57Qre+9sJrEq7Es9W609a
 +M0yRJWJEjFnMa/jsGZ+QyLD5QTL6SGuZ9gKI3W1SfFZOzV7hHsxPTZ6
Organization: OpenVPN Inc.
In-Reply-To: <8bfc6c5f-4bfc-4df4-ac52-b96d902a9d7f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/04/2025 12:48, Paolo Abeni wrote:
> On 4/15/25 1:17 PM, Antonio Quartulli wrote:
>> Notable changes since v25:
>> * removed netdev notifier (was only used for our own devices)
>> * added .dellink implementation to address what was previously
>>    done in notifier
>> * removed .ndo_open and moved netif_carrier_off() call to .ndo_init
>> * fixed author in MODULE_AUTHOR()
>> * properly indented checks in ovpn.yaml
>> * switched from TSTATS to DSTATS
>> * removed obsolete comment in ovpn_socket_new()
>> * removed unrelated hunk in ovpn_socket_new()
>>
>> The latest code can also be found at:
>>
>> https://github.com/OpenVPN/ovpn-net-next
> 
> I think it's finally time to merge this. Thanks Anotonio for your
> patience and persistence and thank you Sabrina for the huge review effort.

Thanks Paolo and thank you all for the reviews (especially Sabrina!), 
suggestions and hints!

It's been a bumpy ride, but we crossed the finish line! :-)

Cheers,

-- 
Antonio Quartulli
OpenVPN Inc.


