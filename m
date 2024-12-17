Return-Path: <linux-kselftest+bounces-23438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F219F3EE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 01:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A98188A2F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 00:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9334B1B95B;
	Tue, 17 Dec 2024 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="O7nDj05X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191EC125
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2024 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734395997; cv=none; b=qoYq0IPBLNRLmof3pLO51J/TPly0JgJ5ofdXBQ3VcsdYzbHQcL6vBStP3TuqgSbtzn+T/Ui9YAI5/4F+GNfbeaUDT4vyP3GOVKxdvo8DXSNPpbIYcQN9DMeWcYxWFZucWppzMGQ/Eh04ThhWyARw+2a2CCYBLEz6ThPBnUkAYyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734395997; c=relaxed/simple;
	bh=fqMOpP+gLPV9PTBU5XyiUxkaI9hqZTSgbaXag4NUkKo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rwj8N0A8Azvd/5ZokvQ0Fai6Z1VRQPsrGBJ5TeNTKl8Gknb33/0i4wIgNBW6yQ+f63KDgkVisQaiIbIUZyQS8ffhneavFITKGXUnRDTlcN+CMV5Cfkk+WUElRrcDWpUYEXtKNyidM6jBwy5Ez2kntbS4WjLodqg2grcFF9/4iU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=O7nDj05X; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so6485868a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 16:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734395994; x=1735000794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYRbkaHHnC/etCZezQ2pl5tTtDyqOxlK9TXmrruYcsw=;
        b=O7nDj05X6R4lOo/3A8nS5tG41njrV58wM69M9PWolbaSNu0DPbkeXRJ9Zw7h+VHg73
         cMlHHvOyT5ruRl3+lqETI1H90OjSy46caBQbwUhy500TVLmI5XsZXNbt3NKNFvmUrupV
         E2ebCkx5YxwjEke0/FW4DkhYze0N9EXXD4QbXlBVlKzxflvT59UD9r66BNJGCT7Fb29P
         EDxUfPh89EugPqtVvkZeee87tlN/k/25KXgOxnalMbrKrar66oANzTpkQpS+FtuQF/QX
         HtdrfC34uagqL8oxgMGCYDDuhhvfWsia4fpOIIBmLHb3GZy5uRvAi0747msCe+lgtVu8
         Eqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734395994; x=1735000794;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MYRbkaHHnC/etCZezQ2pl5tTtDyqOxlK9TXmrruYcsw=;
        b=U4bezCrullc/GR1cFqNzL7MjxG2F57z5rn2ryvJWoEjJW40Jicbc5knLBSdHlQeCVH
         wOvFT6Evg8DZSdDjxhv2qZcr9yYbZ5DQ2jStolPp3ymg/9q4SUic1bNRly1fhj/gOE4V
         pEBAa7iXpIKRrBRsLnPCirhD0HImI6aUky8O5+7hlkTOy/ug6bIa5yiEbSesf57N2kR3
         AO63XNNzduPiO4nxBaaoHJnV0HNiQUcwbuD6R7hujrqM2Oc0h93xGyzUGUvNW8cA/+FJ
         2mYTTjCAWYZOWuxgw/My5ekdcSN5nZQt+0ftIPfXx2w7F6R+q26JMhpuFXX+AJsrcZ+E
         9eLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMBd3p+OOEXBVdfXmQTsXpv4fPUCwaiRlWpHp20tQVD5aN3BIib1fDlwcsJiVUJC5KOBqOREu++N7bXIGzI9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLlfg0WjaKMTGyZRe8Ml1EP5sCmsyvgs5PBDUBk8LWsD2/a614
	q/gOmtUAVWFWb4larxgRGANR8/xGgG6dswPJBqw2fI1zpd9SHvi+Lm6sXCvPI9Y=
X-Gm-Gg: ASbGnct8VVX+uctjIIz6rIJU336y2hbpPIyqDX125e2SenE1w/Zph7qer0Q/bi6uCs9
	YLpN9K1Vy7ubqvFh2PIVSiTbvPajzubRDQF5mKWgh4BXN4x2g3HtxFfMjdSo6xgQQwW5Zta82Gv
	MPDoemH4MaLrhxib/CdtV3DQZZJSdLGKczwKK5VY8kG2TALHB1yXiKvQzVUauSVQjr+Tutwy/nm
	tRuCybyqZRSBGKnmk9+WGGi7HDbzrDqhz82MWs3IV8qnKiAxs+5XKxDw1P0E5tbfQJoXdft4FVI
	iBiTV14hYeM/HNLHP7k=
X-Google-Smtp-Source: AGHT+IGiScgCOieFOYpv5S1wQrxBppIkYHKpnH4On4C12WULPTAzWw3/WLoEQv2eBS0zx5zXdWrJnA==
X-Received: by 2002:a17:907:2da0:b0:aa6:9176:61ed with SMTP id a640c23a62f3a-aab77ea6187mr1335761566b.48.1734395993711;
        Mon, 16 Dec 2024 16:39:53 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:ba62:2253:142a:aa5f? ([2001:67c:2fbc:1:ba62:2253:142a:aa5f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963892c1sm381817066b.133.2024.12.16.16.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 16:39:53 -0800 (PST)
Message-ID: <fa56bc54-445f-4844-8401-934bb8e41021@openvpn.net>
Date: Tue, 17 Dec 2024 01:40:41 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 06/22] ovpn: introduce the ovpn_socket object
From: Antonio Quartulli <antonio@openvpn.net>
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
 <a1137cc2-6985-44bc-a802-e070da7208dc@openvpn.net>
Content-Language: en-US
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
In-Reply-To: <a1137cc2-6985-44bc-a802-e070da7208dc@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/12/2024 12:50, Antonio Quartulli wrote:
> On 16/12/2024 12:09, Sabrina Dubroca wrote:
> [...]
>>> Maybe we should call cancel_sync_work(&ovpn_sock->work) inside
>>> ovpn_socket_get()?
>>> So the latter will return NULL only when it is sure that the socket 
>>> has been
>>> detached.
>>>
>>> At that point we can skip the following return and continue along the 
>>> "new
>>> socket" path.
>>>
>>> What do you think?
>>
>> The work may not have been scheduled yet? (small window between the
>> last kref_put and schedule_work)
>>
>> Maybe a completion [Documentation/scheduler/completion.rst] would
>> solve it (but it makes things even more complex, unfortunately):
>>
>>   - at the end of ovpn_socket_detach: complete(&ovpn_sock->detached);
>>   - in ovpn_socket_new when handling EALREADY: 
>> wait_for_completion(&ovpn_sock->detached);
>>   - in ovpn_socket_new for the new socket: init_completion(&ovpn_sock- 
>> >detached);
>>
>> but ovpn_sock could be gone immediately after complete(). Maybe
>> something with completion_done() before the kfree_rcu in
>> ovpn_socket_detach? I'm not that familiar with the completion API.
>>
> 
> It seems the solution we are aiming for is more complex than the concept 
> of ovpn_socket per se :-D
> 
> I'll think a bit more about this..maybe we can avoid entering this 
> situation at all..

I see that there are some kref_put variants that acquire a lock just 
before hitting zero and running the release cb.

If I implement a kref_put variant that acquires the lock_sock, I could 
then perform the udp detach under lock, thus ensuring that zero'ing the 
refcount and erasing the sk_user_data happens while holding the lock_sock.

This way I should be able to prevent the situation where "sk_user_data 
still says EALREADY, but the refcnt is actually 0".

I hope adding this new API is fine.

I am giving it a try now.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


