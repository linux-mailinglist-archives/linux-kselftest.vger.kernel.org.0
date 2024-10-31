Return-Path: <linux-kselftest+bounces-21198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 797009B7824
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 11:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9671B21035
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA5D198E83;
	Thu, 31 Oct 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ceowp+ML"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A9F198A0E
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368794; cv=none; b=hmaOajizucMO1vhKycUfByMVYpdmC+/AOWBMJuJfGhVccNRcP5R/34Y9xBz8fuHY52J7M+dBPVABH6vCgqQ2STf2rBxE3NKI+uDK1hGkS5fDF5uxnRalrwnpGECPyyDSvuBXFm0Nk8OU5MVjydn2ger09o27KlYJ++qXiYVJjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368794; c=relaxed/simple;
	bh=mKo4NA6OgiUAdt/SWKULSq2K+4l/u/RcFyt52YRZyy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Da83FaLgKOgtnaqV34q/RKee6cE4BHATG4twrwhavuFdkjf2QTrhLprjIswREs2IW5FXykIoy2UF8ZfJGkMLK6e4RiOu+UOwdZsTpng/eG6sVlYnRoLPnGq/zaeTlmqmjFAdHUZWa+h399TBiB8/1Chb4X0d+3LNM7Y2PHV3qn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ceowp+ML; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a0472306cso95087166b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730368790; x=1730973590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FjpKtv1K+1rcu8gD3BRqYtI3l2wMoIsIv0DTh0ihOrQ=;
        b=Ceowp+MLus/hRQ0WB6L1eljsLIdq0Qv4ZbBcG8doJbcX5JwAdryBoQDOo3EinN5BLK
         nCgn8BMFDi0836q6iGdZUOQbYQ4Io0Rh1jUAH0qItBazr6MqIEyDEUbUopwyX/KHM1us
         65ezEYiXt0Hb0GB90EpBh+teOtYK0d0ZDm66ug5vgQ000NJqasqt7UFSIxWTq05WhlHS
         zYpNCOAo5CLYqrsTBVzr9+uXWHJ+L+06zqMlt+/7Sc6bDA9Rb0LMJgI8be/TDH7mW76K
         UmspFBcAmNQD3nsordaBFgTK2WWry69vtnVukV3SGr1PUbGVORVOch2qxshPY9JwV016
         KD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730368790; x=1730973590;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjpKtv1K+1rcu8gD3BRqYtI3l2wMoIsIv0DTh0ihOrQ=;
        b=AoS9pVsz2ebSPSnjCQ18ppuANfTkyOaU3hYJvtlKZMqcb/u+QAXM848ejEcj63rKlw
         fA4IqGI6Ev4845uKPfZTotvWKAIbrjdb1EpiayFQECWBDdv/mfZ1SPuYX+4Hrv71phE9
         VJNsmm+5VhGK3FEp+hIyDyttJKUCAOmZPXiJ6zPN4WANd8NJCIiBi55oLIiusBUWX2kY
         ta8ViwW1aIfUukSyVI3Z3lp08VB0xZFdlPxMWdRMf4V8YgmdbTNnP2WjQ3YVD8/V4a16
         5pzISiaJJZGpg0B/noaoi6eClNGRhJSRnwP0u755knL9wJsRS49q8uXxKkkx4WBSRHl0
         5A2g==
X-Forwarded-Encrypted: i=1; AJvYcCWjDv8NGZYuhcyUme3OqVH+VhRgEYz4noqhoXRXPPF020fAUmh5tIT+ajlo0t96Srv9gHMRotZg8ap+z30raIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IVo6oYtBs4Xu7BcScldmIGbUstlqBe6RD73jJ0+zsI6dSeXl
	BefJuuU3F2ryvsnpzWLtrOPIOuIKbsODJGaNXBQe4SXOUx+OJ1KGhVjjqxB2S68=
X-Google-Smtp-Source: AGHT+IH41AlI9rMUB0nmlTgurjIVUeLNpjSMHV5CcL4BdxhsTvFfjtkLsKtMh8R9CS9rvNQ+YhA+YA==
X-Received: by 2002:a17:907:3f2a:b0:a9a:4cf:5cea with SMTP id a640c23a62f3a-a9e50cace53mr250562366b.54.1730368789729;
        Thu, 31 Oct 2024 02:59:49 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:634e:2582:d0aa:ee79? ([2001:67c:2fbc:1:634e:2582:d0aa:ee79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566447aesm47921966b.157.2024.10.31.02.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 02:59:49 -0700 (PDT)
Message-ID: <47b7f78a-0eba-4823-9e2d-2b9d1d2d7cf3@openvpn.net>
Date: Thu, 31 Oct 2024 11:00:05 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 00/23] Introducing OpenVPN Data Channel
 Offload
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, steffen.klassert@secunet.com,
 antony.antony@secunet.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It seems some little changes to ovpn.yaml were not reflected in the 
generated files I committed.

Specifically I changed some U32 to BE32 (IPv4 addresses) and files were 
not regenerated before committing.

(I saw the failure in patchwork about this)

It seems I'll have to send v12 after all.

Cheers,

On 29/10/2024 11:47, Antonio Quartulli wrote:
> Notable changes from v10:
> * extended commit message of 23/23 with brief description of the output
> * Link to v10: https://lore.kernel.org/r/20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net
> 
> Please note that some patches were already reviewed by Andre Lunn,
> Donald Hunter and Shuah Khan. They have retained the Reviewed-by tag
> since no major code modification has happened since the review.
> 
> The latest code can also be found at:
> 
> https://github.com/OpenVPN/linux-kernel-ovpn
> 
> Thanks a lot!
> Best Regards,
> 
> Antonio Quartulli
> OpenVPN Inc.
> 
> ---
> Antonio Quartulli (23):
>        netlink: add NLA_POLICY_MAX_LEN macro
>        net: introduce OpenVPN Data Channel Offload (ovpn)
>        ovpn: add basic netlink support
>        ovpn: add basic interface creation/destruction/management routines
>        ovpn: keep carrier always on
>        ovpn: introduce the ovpn_peer object
>        ovpn: introduce the ovpn_socket object
>        ovpn: implement basic TX path (UDP)
>        ovpn: implement basic RX path (UDP)
>        ovpn: implement packet processing
>        ovpn: store tunnel and transport statistics
>        ovpn: implement TCP transport
>        ovpn: implement multi-peer support
>        ovpn: implement peer lookup logic
>        ovpn: implement keepalive mechanism
>        ovpn: add support for updating local UDP endpoint
>        ovpn: add support for peer floating
>        ovpn: implement peer add/get/dump/delete via netlink
>        ovpn: implement key add/get/del/swap via netlink
>        ovpn: kill key and notify userspace in case of IV exhaustion
>        ovpn: notify userspace when a peer is deleted
>        ovpn: add basic ethtool support
>        testing/selftests: add test tool and scripts for ovpn module
> 
>   Documentation/netlink/specs/ovpn.yaml              |  362 +++
>   MAINTAINERS                                        |   11 +
>   drivers/net/Kconfig                                |   14 +
>   drivers/net/Makefile                               |    1 +
>   drivers/net/ovpn/Makefile                          |   22 +
>   drivers/net/ovpn/bind.c                            |   54 +
>   drivers/net/ovpn/bind.h                            |  117 +
>   drivers/net/ovpn/crypto.c                          |  214 ++
>   drivers/net/ovpn/crypto.h                          |  145 ++
>   drivers/net/ovpn/crypto_aead.c                     |  386 ++++
>   drivers/net/ovpn/crypto_aead.h                     |   33 +
>   drivers/net/ovpn/io.c                              |  462 ++++
>   drivers/net/ovpn/io.h                              |   25 +
>   drivers/net/ovpn/main.c                            |  337 +++
>   drivers/net/ovpn/main.h                            |   24 +
>   drivers/net/ovpn/netlink-gen.c                     |  212 ++
>   drivers/net/ovpn/netlink-gen.h                     |   41 +
>   drivers/net/ovpn/netlink.c                         | 1135 ++++++++++
>   drivers/net/ovpn/netlink.h                         |   18 +
>   drivers/net/ovpn/ovpnstruct.h                      |   61 +
>   drivers/net/ovpn/packet.h                          |   40 +
>   drivers/net/ovpn/peer.c                            | 1201 ++++++++++
>   drivers/net/ovpn/peer.h                            |  165 ++
>   drivers/net/ovpn/pktid.c                           |  130 ++
>   drivers/net/ovpn/pktid.h                           |   87 +
>   drivers/net/ovpn/proto.h                           |  104 +
>   drivers/net/ovpn/skb.h                             |   56 +
>   drivers/net/ovpn/socket.c                          |  178 ++
>   drivers/net/ovpn/socket.h                          |   55 +
>   drivers/net/ovpn/stats.c                           |   21 +
>   drivers/net/ovpn/stats.h                           |   47 +
>   drivers/net/ovpn/tcp.c                             |  506 +++++
>   drivers/net/ovpn/tcp.h                             |   44 +
>   drivers/net/ovpn/udp.c                             |  406 ++++
>   drivers/net/ovpn/udp.h                             |   26 +
>   include/net/netlink.h                              |    1 +
>   include/uapi/linux/if_link.h                       |   15 +
>   include/uapi/linux/ovpn.h                          |  109 +
>   include/uapi/linux/udp.h                           |    1 +
>   tools/net/ynl/ynl-gen-c.py                         |    4 +-
>   tools/testing/selftests/Makefile                   |    1 +
>   tools/testing/selftests/net/ovpn/.gitignore        |    2 +
>   tools/testing/selftests/net/ovpn/Makefile          |   17 +
>   tools/testing/selftests/net/ovpn/config            |   10 +
>   tools/testing/selftests/net/ovpn/data64.key        |    5 +
>   tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2370 ++++++++++++++++++++
>   tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
>   .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
>   tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
>   tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
>   tools/testing/selftests/net/ovpn/test.sh           |  183 ++
>   tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
>   52 files changed, 9494 insertions(+), 1 deletion(-)
> ---
> base-commit: ab101c553bc1f76a839163d1dc0d1e715ad6bb4e
> change-id: 20241002-b4-ovpn-eeee35c694a2
> 
> Best regards,

-- 
Antonio Quartulli
OpenVPN Inc.


