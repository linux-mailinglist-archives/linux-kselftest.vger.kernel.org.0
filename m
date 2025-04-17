Return-Path: <linux-kselftest+bounces-31041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0EA91890
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA665A11E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B451E20DD50;
	Thu, 17 Apr 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="c4bqrj3J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032001898FB
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884068; cv=none; b=rpqHtomwJgK34u/xzuRD6fiLGGLOc1uS9UivJd6OdS8Kg6D+2HU2wRLKIz0KjfQwwvpyzbPzd8QHmn9Pzunw/ObPT3Qqzh5bm+RdLKjBrKpNxc+fzGWhTRY9PtEtDlueWJet5KNFutXIu6WPHVmUCTu8CgNmd6VB9F6nPdrkY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884068; c=relaxed/simple;
	bh=zKJewt8DdfpnqxmmqbAdhHtC1kvoNw8bAarBwwBX8UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hj2dxHabRcEYQu4csRFK6o2D8/2sy40vBpaMmEbcqf5+Zc1eQW7oJUzUygKex52IEsAfmWYBpBWt23k56X0aHgm7YZaUyvuHcyV4SQzVhNdcogDbsu5CnX6L7tJlThX5WJE0Xp5WeQeooQHV9gzLgHkbUQ1au602aTk13um843k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=c4bqrj3J; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so4680395e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 03:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744884064; x=1745488864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MxFerUKx0G5DcpSy2SnTGBWX9+Esjg95rLfJB6rsNgc=;
        b=c4bqrj3J4fA9ziKmG/VSRaUAdjfS4zlbhxDlk0ZOqxQo7C//sQRT0/HbpYdlIfyiV5
         SQHXHqkcwKSvvtObWFiEyVN6SiLnwitZF8tDqTdVvLCi2Dv0rm6vEz2KohTwA48U5RSv
         2wCE23PnfjhoJ2yGAkNpXSokUOT6EQc0PQb9BKdewIWajgWLGxoSy8GNXLU6TU2xg1Re
         4d2XBJ3HBstGfiB9vbdqr9JfUm6Z05v6I8kzHMLVFIUFmqQ2yniQWPvmGeNnkfRTheGV
         SkR+z8O1R5A2Gz9SKedRl7y/zhzcfAworhPUU0b5AbjPQ0fF+js81YsoalMdOT4NEfXu
         2l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744884064; x=1745488864;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxFerUKx0G5DcpSy2SnTGBWX9+Esjg95rLfJB6rsNgc=;
        b=BSeMyUxCAJ/kGOl95zLbU+Ur2VYZWohn6j0vIh6xSIaBmLaagCkkOjYsrF9+WQASas
         lI7dN0uAHsEnlcOeA5MKXFEHUYSfYRlzNcY0hGk2mCbSIRBViXLqZYt5n2GxHzX4h8Iv
         48yUJUk1yWUbAMFWggMWkIX4rN7D0a9tDzxx+eGxd7t+BauHKFIqDoSzEEr4JtHM1pF0
         UhZgNFJz9HScHAK9LLgL1Ia8TqHCD5sTuc3sYoRN/bzo8dAHWdCLcQ1JqTvRITMiDLzz
         KCkCBvZ9m2QsUkACx+7lx4ziUw3+aSXzb4ijJ9PhdAH02P3rrfTqQqU3qUBnyjwoqtO6
         ZaUA==
X-Forwarded-Encrypted: i=1; AJvYcCXWzVurHcn1cpFFsNS8x+bewE6XLBoFp/Hg+zbbymxvle1Vm/ZEPT/PJQ8DWZVWjL4HngxMSNN75+vRm1Rbnyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykxmNegXo0ZmTWO9E74EgtvSKwO5kzffKR5nulryw/Vic07VjP
	D27G+xX5Z5mkCPqQGYzxevWPrKvEPKPoED7Ftvy8JR6fgRDPDE1+7ZDfXZS0KOrADms0AUhCXRw
	ZC3xLyCxL5RBB6OhX2ttCBcEOwBp28+4g+VcQPw7xoXlhIYOaGw29eNIM3ng=
X-Gm-Gg: ASbGncscuEYy43YAJzWeXJA+UjNM3fwvSxXMm0On+HU2jCoTpfIPyUDTCxxvCBkbm8t
	rG+9xStFFKcEvG8d1BpN8NNfxT0bUtFx94PO3DcEhjUG+nWsI6+3MBGACQyKXT8RcbvwkVahHf/
	8wCBrhf1shedWa9S4wx7WR6zyXDkbpCw2oE/1u1PPfeAAKCAPgJrjUIFpcY7g1qBbjqqxTkv5yV
	5QIHrJk6j2La3lv+2CpVnl6pCvWP1P4TBY+WheoFAO8PWK+wyo6Y6VqIwMKgd63f9d733UkSXYo
	OTtvzUSM1sJAwrc1alzigtAinWsv458EWJu6bS/HBobsRrtmZJsPzJj32vfb8vflwnj9jw4/Ug=
	=
X-Google-Smtp-Source: AGHT+IF+eY3xUI20nefH4S26JQMG7G3ra6vfd30qWKcASyWamRn1LG/0a9SBi+aHm4PKaAcmKUK9sg==
X-Received: by 2002:a05:600c:b95:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-4405d637b3amr48917185e9.19.1744884064154;
        Thu, 17 Apr 2025 03:01:04 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:dbd:fe3b:43d:324c? ([2001:67c:2fbc:1:dbd:fe3b:43d:324c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b53dee0sm47021625e9.33.2025.04.17.03.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 03:01:03 -0700 (PDT)
Message-ID: <419e701d-dc74-4072-a056-0845e77305aa@openvpn.net>
Date: Thu, 17 Apr 2025 12:01:02 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v26 00/23] Introducing OpenVPN Data Channel
 Offload
To: Oleksandr Natalenko <oleksandr@natalenko.name>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>, steffen.klassert@secunet.com,
 antony.antony@secunet.com, willemdebruijn.kernel@gmail.com,
 David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
 <5001537.31r3eYUQgx@natalenko.name>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <5001537.31r3eYUQgx@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Oleksandr,

Thanks a lot for testing!

On 17/04/2025 11:51, Oleksandr Natalenko wrote:
> Hello.
> 
> On úterý 15. dubna 2025 13:17:17, středoevropský letní čas Antonio Quartulli wrote:
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
> Thank you for this. I've backported the submission for my local v6.14-based build (had to adjust for 69c7be1b903fca) and I'm using it now with [1] as you've suggested previously. So far so good. Feel free to add my:
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> 
> A couple of notes if I may:
> 
> 1. is it expected for then tun iface to stay after the connection is brought down? If that matters, I'm using NetworkManager for managing my OpenVPN connections

If the interface is created by openvpn in userspace, the latter should 
also destroy it during cleanup.

> 2. a userspace nit probably not relevant to this submission: the daemon still reports "DCO version:" but with "N/A" value because that version file under /sys is not presented any more like it was with an out-of-tree v2 implementation

Thanks a lot, I have reported this point to gerrit (where the patch is 
being reviewed): https://gerrit.openvpn.net/c/openvpn/+/941


Regards,

> 
> [1]: https://github.com/mandelbitdev/openvpn/tree/gianmarco/179-ovpn-support
> 
>>
>> Thanks a lot!
>> Best Regards,
>>
>> Antonio Quartulli
>> OpenVPN Inc.
>>
>> ---
>> Antonio Quartulli (23):
>>        net: introduce OpenVPN Data Channel Offload (ovpn)
>>        ovpn: add basic netlink support
>>        ovpn: add basic interface creation/destruction/management routines
>>        ovpn: keep carrier always on for MP interfaces
>>        ovpn: introduce the ovpn_peer object
>>        ovpn: introduce the ovpn_socket object
>>        ovpn: implement basic TX path (UDP)
>>        ovpn: implement basic RX path (UDP)
>>        ovpn: implement packet processing
>>        ovpn: store tunnel and transport statistics
>>        ovpn: implement TCP transport
>>        skb: implement skb_send_sock_locked_with_flags()
>>        ovpn: add support for MSG_NOSIGNAL in tcp_sendmsg
>>        ovpn: implement multi-peer support
>>        ovpn: implement peer lookup logic
>>        ovpn: implement keepalive mechanism
>>        ovpn: add support for updating local or remote UDP endpoint
>>        ovpn: implement peer add/get/dump/delete via netlink
>>        ovpn: implement key add/get/del/swap via netlink
>>        ovpn: kill key and notify userspace in case of IV exhaustion
>>        ovpn: notify userspace when a peer is deleted
>>        ovpn: add basic ethtool support
>>        testing/selftests: add test tool and scripts for ovpn module
>>
>>   Documentation/netlink/specs/ovpn.yaml              |  367 +++
>>   Documentation/netlink/specs/rt-link.yaml           |   16 +
>>   MAINTAINERS                                        |   11 +
>>   drivers/net/Kconfig                                |   15 +
>>   drivers/net/Makefile                               |    1 +
>>   drivers/net/ovpn/Makefile                          |   22 +
>>   drivers/net/ovpn/bind.c                            |   55 +
>>   drivers/net/ovpn/bind.h                            |  101 +
>>   drivers/net/ovpn/crypto.c                          |  210 ++
>>   drivers/net/ovpn/crypto.h                          |  145 ++
>>   drivers/net/ovpn/crypto_aead.c                     |  383 ++++
>>   drivers/net/ovpn/crypto_aead.h                     |   29 +
>>   drivers/net/ovpn/io.c                              |  446 ++++
>>   drivers/net/ovpn/io.h                              |   34 +
>>   drivers/net/ovpn/main.c                            |  274 +++
>>   drivers/net/ovpn/main.h                            |   14 +
>>   drivers/net/ovpn/netlink-gen.c                     |  213 ++
>>   drivers/net/ovpn/netlink-gen.h                     |   41 +
>>   drivers/net/ovpn/netlink.c                         | 1258 +++++++++++
>>   drivers/net/ovpn/netlink.h                         |   18 +
>>   drivers/net/ovpn/ovpnpriv.h                        |   55 +
>>   drivers/net/ovpn/peer.c                            | 1365 +++++++++++
>>   drivers/net/ovpn/peer.h                            |  163 ++
>>   drivers/net/ovpn/pktid.c                           |  129 ++
>>   drivers/net/ovpn/pktid.h                           |   86 +
>>   drivers/net/ovpn/proto.h                           |  118 +
>>   drivers/net/ovpn/skb.h                             |   61 +
>>   drivers/net/ovpn/socket.c                          |  233 ++
>>   drivers/net/ovpn/socket.h                          |   49 +
>>   drivers/net/ovpn/stats.c                           |   21 +
>>   drivers/net/ovpn/stats.h                           |   47 +
>>   drivers/net/ovpn/tcp.c                             |  598 +++++
>>   drivers/net/ovpn/tcp.h                             |   36 +
>>   drivers/net/ovpn/udp.c                             |  439 ++++
>>   drivers/net/ovpn/udp.h                             |   25 +
>>   include/linux/skbuff.h                             |    2 +
>>   include/uapi/linux/if_link.h                       |   15 +
>>   include/uapi/linux/ovpn.h                          |  109 +
>>   include/uapi/linux/udp.h                           |    1 +
>>   net/core/skbuff.c                                  |   18 +-
>>   net/ipv6/af_inet6.c                                |    1 +
>>   tools/testing/selftests/Makefile                   |    1 +
>>   tools/testing/selftests/net/ovpn/.gitignore        |    2 +
>>   tools/testing/selftests/net/ovpn/Makefile          |   31 +
>>   tools/testing/selftests/net/ovpn/common.sh         |   92 +
>>   tools/testing/selftests/net/ovpn/config            |   10 +
>>   tools/testing/selftests/net/ovpn/data64.key        |    5 +
>>   tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2376 ++++++++++++++++++++
>>   tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
>>   .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
>>   .../selftests/net/ovpn/test-close-socket-tcp.sh    |    9 +
>>   .../selftests/net/ovpn/test-close-socket.sh        |   45 +
>>   tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
>>   tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
>>   tools/testing/selftests/net/ovpn/test.sh           |  113 +
>>   tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
>>   56 files changed, 9940 insertions(+), 5 deletions(-)
>> ---
>> base-commit: 23f09f01b495cc510a19b30b6093fb4cb0284aaf
>> change-id: 20241002-b4-ovpn-eeee35c694a2
>>
>> Best regards,
>>
> 
> 

-- 
Antonio Quartulli
OpenVPN Inc.


