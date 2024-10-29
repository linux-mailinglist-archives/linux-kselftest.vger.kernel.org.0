Return-Path: <linux-kselftest+bounces-20923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 299509B45DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E281F2349F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D2F2038D3;
	Tue, 29 Oct 2024 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SRVMMa3h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F01E1025
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194920; cv=none; b=EEuXv5n238DlJ8N9lio/Crcqrz46zMjbQgazaL2h6BicY+w1yvqM4SbWa9STSEpnlm/m5vFBNQ60sHlIwX7/p8yXFL6TEUPoN4+uO4OV1j00NRaYR+lXyzgLu1cLazNllTpHALakRPDyysGOwaRy2fkbtixjMdYXqQZzl9+TaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194920; c=relaxed/simple;
	bh=Rk1U0Q8IPzGXyW42DR/flbGw6vgMx+pYnP4sPaLW3FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMssG3UOKPWnWy5qwMIStYsJNQdzljwmhsZA2Gowrgjk0nneSo7KDaT2Rhn3IeFD6wHCfZsscYHDzT4dJmpUiGrouuMJPFS9MiCFracLn3I14zSxHXHH1E+7xWHJo2pGuQtfwRiAULalqSdvXydafyBMuzXs6fQ3PA+EZZaE9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SRVMMa3h; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d3ecad390so4534855f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730194915; x=1730799715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gLtr73VHqwgdcXGBbLOcbwXiHKwoIVyQG3J6RSZ3YZs=;
        b=SRVMMa3hn04cPq8TfRTkmFUq8h1qw6olJ5xv16506j/oS1nxovegaQk8g+hZkJdQx1
         ON1zMTufq2aocOi5WokkMR6haIIgrvRX7jpuLQz6fjvkp70P+a0SDAQhGXLjUd9YCE+x
         2vGROjiVfPEQoTqzdQ4l5iP7WaiXzag6okfKqGeLQVYugeHN6fAGKdDpl8uD5amaRz2v
         CN7uuFmUGJcOcJ65xUe43PP0KFn3FiD9Ze5KHKCgqEBV7OuFRfoY3jFvwraspJI0v0Lk
         Dt22KI16KA4L8HUJVWTegId8j/BX8GM+PXYNMngwuD8Mey+neZ7it0E29U1C432ira/8
         QquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730194915; x=1730799715;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLtr73VHqwgdcXGBbLOcbwXiHKwoIVyQG3J6RSZ3YZs=;
        b=b63NsuLhXy8Ht0tJA6h4j9UjbjeBF1AgzjvtVwv9GlDRxcRCJTmXxbJAkoluTVtr+P
         OOkvf8BFrOKJa+QN+2jkVSkgM/g7FSxcp9M+/GWJ36Gx5IJSDGaArKoPfNnD17au7tcf
         cva9lwV2NBGxxCgNrknXvs44VAN1YkMI27Gb/9n4wM1BwdS8T9hn9SAj8acel+1fAf1z
         CR62p+1fnkzb9Jzet7+Cx9mW9ZfHn+dGumiDFTi4IzOppOJcoktHCdGv04M1hL1uJYAm
         MYc/ExP/beOLRcLYuMiakVr/M8tmLxdugOuxvyFr4VpQ6pLVIeDb4p//VjfALWB1Ef7p
         zQbg==
X-Forwarded-Encrypted: i=1; AJvYcCXyywqWlLZGFxHTg7sg8sHv9DT5E4zBpdQsAgKOgrgULRWf1/63CDl98KdKmLbTAICaGHInJf+iuP7Cf493Ntk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9yod2YUv7wMGWDIzM33LExzADqFOu+bFkujTjZ5ErPKwEtLa
	/PfQmXAft+o2J4fKtB/5s3zZHU2r5grV0VoGrQVfn+LIVgzQbwbOZoObdNLzdq4=
X-Google-Smtp-Source: AGHT+IGqXDwnFNH7alnVVvpJskyB5278JBHkmt0HsSMEI09m7FRSIIR7myTRb9sj6Ecl9UHEE9DuWQ==
X-Received: by 2002:a5d:45c5:0:b0:374:bf6b:1021 with SMTP id ffacd0b85a97d-38162916869mr1208668f8f.27.1730194915081;
        Tue, 29 Oct 2024 02:41:55 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:3dcf:a6cb:47af:d9f? ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f6e47sm139676855e9.38.2024.10.29.02.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 02:41:54 -0700 (PDT)
Message-ID: <2f178d43-8a40-4f1a-b8cf-85d26ad0a063@openvpn.net>
Date: Tue, 29 Oct 2024 10:42:09 +0100
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
 <feef6601-0e68-4913-b305-3be3face4a9e@openvpn.net>
 <24edee6f-9f77-43f2-8565-566668e5f697@linuxfoundation.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <24edee6f-9f77-43f2-8565-566668e5f697@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29/10/2024 03:29, Shuah Khan wrote:
> On 10/28/24 04:13, Antonio Quartulli wrote:
>> On 27/10/2024 01:40, Shuah Khan wrote:
>>> On 10/25/24 03:14, Antonio Quartulli wrote:
>>>> The ovpn-cli tool can be compiled and used as selftest for the ovpn
>>>> kernel module.
>>>>
>>>> It implements the netlink API and can thus be integrated in any
>>>> script for more automated testing.
>>>>
>>>> Along with the tool, 4 scripts are added that perform basic
>>>> functionality tests by means of network namespaces.
>>>>
>>>> Cc: shuah@kernel.org
>>>> Cc: linux-kselftest@vger.kernel.org
>>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>>> ---
>>>>   MAINTAINERS                                        |    1 +
>>>>   tools/testing/selftests/Makefile                   |    1 +
>>>>   tools/testing/selftests/net/ovpn/.gitignore        |    2 +
>>>>   tools/testing/selftests/net/ovpn/Makefile          |   17 +
>>>>   tools/testing/selftests/net/ovpn/config            |   10 +
>>>>   tools/testing/selftests/net/ovpn/data64.key        |    5 +
>>>>   tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2370 ++++++++ 
>>>> ++ ++++++++++
>>>>   tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
>>>>   .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
>>>>   tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
>>>>   tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
>>>>   tools/testing/selftests/net/ovpn/test.sh           |  183 ++
>>>>   tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
>>>>   13 files changed, 2626 insertions(+)
>>>>
>>>
>>> What does the test output look like? Add that to the change log.
>>
>> Hi Shuan,
>>
>> is there any expected output for kselftest scripts?
>> Right now it just prints a bunch of messages about what is being 
>> tested, plus the output from `ping` and `iperf`.
>>
>> My assumption is that the output would be useful in case of failures, 
>> to understand where and what went wrong.
>>
>> I can document that, but I am not sure it is truly helpful (?).
>> What do you think?
>>
>> Is there any specific output format I should obey to?
>>
>>
>> [...]
>>
>>
>>>> +
>>>> +static void usage(const char *cmd)
>>>> +{
>>>> +    fprintf(stderr,
>>>> +        "Usage %s <command> <iface> [arguments..]\n",
>>>> +        cmd);
>>>> +    fprintf(stderr, "where <command> can be one of the 
>>>> following\n\n");
>>>> +
>>>> +    fprintf(stderr, "* new_iface <iface> [mode]: create new ovpn 
>>>> interface\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr, "\tmode:\n");
>>>> +    fprintf(stderr, "\t\t- P2P for peer-to-peer mode (i.e. 
>>>> client)\n");
>>>> +    fprintf(stderr, "\t\t- MP for multi-peer mode (i.e. server)\n");
>>>> +
>>>> +    fprintf(stderr, "* del_iface <iface>: delete ovpn interface\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +
>>>> +    fprintf(stderr,
>>>> +        "* listen <iface> <lport> <peers_file> [ipv6]: listen for 
>>>> incoming peer TCP connections\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr, "\tlport: TCP port to listen to\n");
>>>> +    fprintf(stderr,
>>>> +        "\tpeers_file: file containing one peer per line: Line 
>>>> format:\n");
>>>> +    fprintf(stderr, "\t\t<peer_id> <vpnaddr>\n");
>>>> +    fprintf(stderr,
>>>> +        "\tipv6: whether the socket should listen to the IPv6 
>>>> wildcard address\n");
>>>> +
>>>> +    fprintf(stderr,
>>>> +        "* connect <iface> <peer_id> <raddr> <rport> [key_file]: 
>>>> start connecting peer of TCP-based VPN session\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr, "\tpeer_id: peer ID of the connecting peer\n");
>>>> +    fprintf(stderr, "\traddr: peer IP address to connect to\n");
>>>> +    fprintf(stderr, "\trport: peer TCP port to connect to\n");
>>>> +    fprintf(stderr,
>>>> +        "\tkey_file: file containing the symmetric key for 
>>>> encryption\n");
>>>> +
>>>> +    fprintf(stderr,
>>>> +        "* new_peer <iface> <peer_id> <lport> <raddr> <rport> 
>>>> [vpnaddr]: add new peer\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr, "\tlport: local UDP port to bind to\n");
>>>> +    fprintf(stderr,
>>>> +        "\tpeer_id: peer ID to be used in data packets to/from this 
>>>> peer\n");
>>>> +    fprintf(stderr, "\traddr: peer IP address\n");
>>>> +    fprintf(stderr, "\trport: peer UDP port\n");
>>>> +    fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
>>>> +
>>>> +    fprintf(stderr,
>>>> +        "* new_multi_peer <iface> <lport> <peers_file>: add 
>>>> multiple peers as listed in the file\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr, "\tlport: local UDP port to bind to\n");
>>>> +    fprintf(stderr,
>>>> +        "\tpeers_file: text file containing one peer per line. Line 
>>>> format:\n");
>>>> +    fprintf(stderr, "\t\t<peer_id> <raddr> <rport> <vpnaddr>\n");
>>>> +
>>>> +    fprintf(stderr,
>>>> +        "* set_peer <iface> <peer_id> <keepalive_interval> 
>>>> <keepalive_timeout>: set peer attributes\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>>>> +    fprintf(stderr,
>>>> +        "\tkeepalive_interval: interval for sending ping messages\n");
>>>> +    fprintf(stderr,
>>>> +        "\tkeepalive_timeout: time after which a peer is timed 
>>>> out\n");
>>>> +
>>>> +    fprintf(stderr, "* del_peer <iface> <peer_id>: delete peer\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to delete\n");
>>>> +
>>>> +    fprintf(stderr, "* get_peer <iface> [peer_id]: retrieve peer(s) 
>>>> status\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr,
>>>> +        "\tpeer_id: peer ID of the peer to query. All peers are 
>>>> returned if omitted\n");
>>>> +
>>>> +    fprintf(stderr,
>>>> +        "* new_key <iface> <peer_id> <slot> <key_id> <cipher> 
>>>> <key_dir> <key_file>: set data channel key\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr,
>>>> +        "\tpeer_id: peer ID of the peer to configure the key for\n");
>>>> +    fprintf(stderr, "\tslot: either 1 (primary) or 2 (secondary)\n");
>>>> +    fprintf(stderr, "\tkey_id: an ID from 0 to 7\n");
>>>> +    fprintf(stderr,
>>>> +        "\tcipher: cipher to use, supported: aes (AES-GCM), 
>>>> chachapoly (CHACHA20POLY1305)\n");
>>>> +    fprintf(stderr,
>>>> +        "\tkey_dir: key direction, must 0 on one host and 1 on the 
>>>> other\n");
>>>> +    fprintf(stderr, "\tkey_file: file containing the pre-shared 
>>>> key\n");
>>>> +
>>>> +    fprintf(stderr,
>>>> +        "* del_key <iface> <peer_id> [slot]: erase existing data 
>>>> channel key\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>>>> +    fprintf(stderr, "\tslot: slot to erase. PRIMARY if omitted\n");
>>>> +
>>>> +    fprintf(stderr,
>>>> +        "* get_key <iface> <peer_id> <slot>: retrieve non sensible 
>>>> key data\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to query\n");
>>>> +    fprintf(stderr, "\tslot: either 1 (primary) or 2 (secondary)\n");
>>>> +
>>>> +    fprintf(stderr,
>>>> +        "* swap_keys <iface> <peer_id>: swap content of primary and 
>>>> secondary key slots\n");
>>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>>>> +
>>>> +    fprintf(stderr,
>>>> +        "* listen_mcast: listen to ovpn netlink multicast 
>>>> messages\n");
>>>> +}
>>>
>>> If this test is run from "make kselftest" as default run does this usage
>>> output show up in the report?
>>
>> No.
>> This usage is only printed when invoking ovpn-cli with wrong arguments 
>> and this can't be the case in the kselftest.
> 
> The usage() is great and much needed. My concern is if this usage would 
> show up
> when we run "make kselftest" - some tests do this by adding wrapper 
> shell script
> to run the test with different options to cover all the cases.
> 
>>
>>
>> Other than documenting the output, do you think there is any other 
>> critical part to be adjusted in this patch?
> 
> No - I don't have any other comments on the test itself. I just want to 
> make
> sure this usage inadvertently doesn't end up in the "make kselftest" run.
> 
> With that
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks a lot for your feedback.
I promise no usage() output will pollute the reports :-)

Ok then, I will extend the commit message with a description of the 
output and retain your Reviewed-by in v11.

I'll try to send it out today.

Thanks.
Regards,

> 
> thanks,
> -- Shuah

-- 
Antonio Quartulli
OpenVPN Inc.


