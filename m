Return-Path: <linux-kselftest+bounces-20797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB2C9B2C85
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 11:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE789280D85
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733761D86E6;
	Mon, 28 Oct 2024 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PRvuLbPF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC601D358F
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110396; cv=none; b=nJuPnBumc3/QHui2l4+317kI+bErHocfrUGoOXf3b9doczI61POQhitNJu4Fw01JnM5A2foMvsdI4Xe0CKAUAa9ZK88K8yONoys10CwRbahlDAmSbElwyowS2xpE+SGl2UNGZvqlBpKvCXmH0Gc41AfhnLDZ8HzpRFj+jO672Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110396; c=relaxed/simple;
	bh=AV3H95WuR7HgF4Hklt8Oa1y3SpNFAqrinNBZJEI3sJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piiAg+HjFzuc+yAo/YJLjHLxzUN3h5KdE4bHkSylX8pzENLBXKH+gy/W4gQ0+pAX5X/QWrUC6cEUqCHAklyC4n+xaoup0H491YAp2MWQ9btvAqMJJP7zo8wJVJUzDfBvpU/2GMJzBCFpQw1fAd/VxSd9lDV4Ifs3wncJW4fQ+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PRvuLbPF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so4615310e87.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730110391; x=1730715191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kTse+UIA/55vueNOi33xp+1Nvpf6FMXtF/RFvE7Aux4=;
        b=PRvuLbPFV8VMfz7CFhOrRMz16hkBgn9sEnTjwUHM6/5ZmPcA/0g7sH4TkSD2c/LwcV
         bClZ0HnvebovwkFyZIw5YBtexXJS/9afyerdkL3QGoVvR/yKRIeGz9eeibwDXGZYbZqN
         yL4DaUiOvnRKgi8CHPz954FspgXQpuvAmS9TVs+Hw8saq/+Qz1oL4t+2vt8cAmDnsfSQ
         wnoazsWIXlJEA8t8HG3wdkQGRnKHtEja0REtgv68vziHFYJVph1E4vzLpK/FMKWhPGE5
         AbxNrFBO51M1F6QeNPkCqPEiz2ZOyIEzn4TJAN60Dj03ndNdvBMozMFNr2xmrGeTa7Dk
         SjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730110391; x=1730715191;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTse+UIA/55vueNOi33xp+1Nvpf6FMXtF/RFvE7Aux4=;
        b=A45MfPmSN12H1EjTKYjwfyaiI3rg6v5lTARzbtTTO3AqAbmRPkz4spi/N7/WITmAoH
         o3DNJOqa/AwTkk+Sdd2/bupNMjooVi0v+bNRG7h1fZbH73erhT/SOCNNaa3Ezps08bEt
         r189eDvO1DRHSw7CL5TvAjMmaJL1XYOD9PIn9r9W08tl8SIP1CZsCmA5BJ/N8mmKBBgd
         EAlIsSFZk2T0ZSE9NaTXc52THgmCwOlUb7elFwl2ttrQQy+aBcSA/LcDSqQm4SXMfkXj
         6lW+aUglwQ4LWkan4ylV8W0RWp22jKogRS7UAQUeqpKlk8W4mbiFFLcwQ+XBeKSpvY2X
         gUPA==
X-Forwarded-Encrypted: i=1; AJvYcCVGvDLxtSuU13AIu88RBrWbuPKAGk4gZSJu8s+A2RA0yyta4TbLVhqFdEvqMIBAy7RAGthUNb/LAhmfUyWUxKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8r9B/Yi8XUrrewu15I6JilB8YWbiZ6SO534m0WnrnFGe5wnQz
	Gki3qbxQyci6sMBtKH498LcfChFf7Y4t+TaQtR9hlctKyI29OomQjzJgSslKp5M=
X-Google-Smtp-Source: AGHT+IF1okyvZaKXse++KL2wEvd3Z6/OhR++/wqVVcCM7ZvtJyoTyPLnGArGk0C4r0iTm+16yUgihQ==
X-Received: by 2002:a05:6512:12d1:b0:539:fcba:cc6d with SMTP id 2adb3069b0e04-53b34a19019mr2673820e87.42.1730110384195;
        Mon, 28 Oct 2024 03:13:04 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e302:b53c:29e9:63b6? ([2001:67c:2fbc:1:e302:b53c:29e9:63b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193573d47sm106146525e9.3.2024.10.28.03.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 03:13:03 -0700 (PDT)
Message-ID: <feef6601-0e68-4913-b305-3be3face4a9e@openvpn.net>
Date: Mon, 28 Oct 2024 11:13:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 23/23] testing/selftests: add test tool and
 scripts for ovpn module
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 sd@queasysnail.net, Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
 <20241025-b4-ovpn-v10-23-b87530777be7@openvpn.net>
 <fe2b641f-a8aa-428c-9f04-f099015e0eb9@linuxfoundation.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <fe2b641f-a8aa-428c-9f04-f099015e0eb9@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/10/2024 01:40, Shuah Khan wrote:
> On 10/25/24 03:14, Antonio Quartulli wrote:
>> The ovpn-cli tool can be compiled and used as selftest for the ovpn
>> kernel module.
>>
>> It implements the netlink API and can thus be integrated in any
>> script for more automated testing.
>>
>> Along with the tool, 4 scripts are added that perform basic
>> functionality tests by means of network namespaces.
>>
>> Cc: shuah@kernel.org
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   MAINTAINERS                                        |    1 +
>>   tools/testing/selftests/Makefile                   |    1 +
>>   tools/testing/selftests/net/ovpn/.gitignore        |    2 +
>>   tools/testing/selftests/net/ovpn/Makefile          |   17 +
>>   tools/testing/selftests/net/ovpn/config            |   10 +
>>   tools/testing/selftests/net/ovpn/data64.key        |    5 +
>>   tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2370 ++++++++++ 
>> ++++++++++
>>   tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
>>   .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
>>   tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
>>   tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
>>   tools/testing/selftests/net/ovpn/test.sh           |  183 ++
>>   tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
>>   13 files changed, 2626 insertions(+)
>>
> 
> What does the test output look like? Add that to the change log.

Hi Shuan,

is there any expected output for kselftest scripts?
Right now it just prints a bunch of messages about what is being tested, 
plus the output from `ping` and `iperf`.

My assumption is that the output would be useful in case of failures, to 
understand where and what went wrong.

I can document that, but I am not sure it is truly helpful (?).
What do you think?

Is there any specific output format I should obey to?


[...]


>> +
>> +static void usage(const char *cmd)
>> +{
>> +    fprintf(stderr,
>> +        "Usage %s <command> <iface> [arguments..]\n",
>> +        cmd);
>> +    fprintf(stderr, "where <command> can be one of the following\n\n");
>> +
>> +    fprintf(stderr, "* new_iface <iface> [mode]: create new ovpn 
>> interface\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tmode:\n");
>> +    fprintf(stderr, "\t\t- P2P for peer-to-peer mode (i.e. client)\n");
>> +    fprintf(stderr, "\t\t- MP for multi-peer mode (i.e. server)\n");
>> +
>> +    fprintf(stderr, "* del_iface <iface>: delete ovpn interface\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +
>> +    fprintf(stderr,
>> +        "* listen <iface> <lport> <peers_file> [ipv6]: listen for 
>> incoming peer TCP connections\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tlport: TCP port to listen to\n");
>> +    fprintf(stderr,
>> +        "\tpeers_file: file containing one peer per line: Line 
>> format:\n");
>> +    fprintf(stderr, "\t\t<peer_id> <vpnaddr>\n");
>> +    fprintf(stderr,
>> +        "\tipv6: whether the socket should listen to the IPv6 
>> wildcard address\n");
>> +
>> +    fprintf(stderr,
>> +        "* connect <iface> <peer_id> <raddr> <rport> [key_file]: 
>> start connecting peer of TCP-based VPN session\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the connecting peer\n");
>> +    fprintf(stderr, "\traddr: peer IP address to connect to\n");
>> +    fprintf(stderr, "\trport: peer TCP port to connect to\n");
>> +    fprintf(stderr,
>> +        "\tkey_file: file containing the symmetric key for 
>> encryption\n");
>> +
>> +    fprintf(stderr,
>> +        "* new_peer <iface> <peer_id> <lport> <raddr> <rport> 
>> [vpnaddr]: add new peer\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tlport: local UDP port to bind to\n");
>> +    fprintf(stderr,
>> +        "\tpeer_id: peer ID to be used in data packets to/from this 
>> peer\n");
>> +    fprintf(stderr, "\traddr: peer IP address\n");
>> +    fprintf(stderr, "\trport: peer UDP port\n");
>> +    fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
>> +
>> +    fprintf(stderr,
>> +        "* new_multi_peer <iface> <lport> <peers_file>: add multiple 
>> peers as listed in the file\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tlport: local UDP port to bind to\n");
>> +    fprintf(stderr,
>> +        "\tpeers_file: text file containing one peer per line. Line 
>> format:\n");
>> +    fprintf(stderr, "\t\t<peer_id> <raddr> <rport> <vpnaddr>\n");
>> +
>> +    fprintf(stderr,
>> +        "* set_peer <iface> <peer_id> <keepalive_interval> 
>> <keepalive_timeout>: set peer attributes\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>> +    fprintf(stderr,
>> +        "\tkeepalive_interval: interval for sending ping messages\n");
>> +    fprintf(stderr,
>> +        "\tkeepalive_timeout: time after which a peer is timed out\n");
>> +
>> +    fprintf(stderr, "* del_peer <iface> <peer_id>: delete peer\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to delete\n");
>> +
>> +    fprintf(stderr, "* get_peer <iface> [peer_id]: retrieve peer(s) 
>> status\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr,
>> +        "\tpeer_id: peer ID of the peer to query. All peers are 
>> returned if omitted\n");
>> +
>> +    fprintf(stderr,
>> +        "* new_key <iface> <peer_id> <slot> <key_id> <cipher> 
>> <key_dir> <key_file>: set data channel key\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr,
>> +        "\tpeer_id: peer ID of the peer to configure the key for\n");
>> +    fprintf(stderr, "\tslot: either 1 (primary) or 2 (secondary)\n");
>> +    fprintf(stderr, "\tkey_id: an ID from 0 to 7\n");
>> +    fprintf(stderr,
>> +        "\tcipher: cipher to use, supported: aes (AES-GCM), 
>> chachapoly (CHACHA20POLY1305)\n");
>> +    fprintf(stderr,
>> +        "\tkey_dir: key direction, must 0 on one host and 1 on the 
>> other\n");
>> +    fprintf(stderr, "\tkey_file: file containing the pre-shared key\n");
>> +
>> +    fprintf(stderr,
>> +        "* del_key <iface> <peer_id> [slot]: erase existing data 
>> channel key\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>> +    fprintf(stderr, "\tslot: slot to erase. PRIMARY if omitted\n");
>> +
>> +    fprintf(stderr,
>> +        "* get_key <iface> <peer_id> <slot>: retrieve non sensible 
>> key data\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to query\n");
>> +    fprintf(stderr, "\tslot: either 1 (primary) or 2 (secondary)\n");
>> +
>> +    fprintf(stderr,
>> +        "* swap_keys <iface> <peer_id>: swap content of primary and 
>> secondary key slots\n");
>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>> +
>> +    fprintf(stderr,
>> +        "* listen_mcast: listen to ovpn netlink multicast messages\n");
>> +}
> 
> If this test is run from "make kselftest" as default run does this usage
> output show up in the report?

No.
This usage is only printed when invoking ovpn-cli with wrong arguments 
and this can't be the case in the kselftest.


Other than documenting the output, do you think there is any other 
critical part to be adjusted in this patch?

Thanks a lot for your time and patience.

Regards,



-- 
Antonio Quartulli
OpenVPN Inc.


