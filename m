Return-Path: <linux-kselftest+bounces-20887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCE89B406B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 03:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20BE282E46
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 02:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED868198A08;
	Tue, 29 Oct 2024 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TFfsktKY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A3193071
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730168969; cv=none; b=RXKpI7S6/7TWWwIDRckS5d3mxfwA3kXaYdhpufOTirC0rvxXnWknE7bN6QXevIsi1WcKCKxHtspYb12/stES9lJHYkQYV8KoJR874i5K3Uh1/EZFpsugAeFsSyhXbM416tZEsxqqopfJ+XzUHUJnRJ4C30Ki8If4n8RckPuEjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730168969; c=relaxed/simple;
	bh=XXaZT/CChIW7MIYG+hYAOvmT73RMWkSLXOiRMYINrfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCLmGeecLEV+MU39NzBqoFDUq4SJWPJjoyCcomgY8hWRrOg0Vb/3TnLspxjIvOpJUCFe4Rop/pxrUtyrSbbYBeGn+8wEpdi3xj5oF0MK0o9RkIlIrQB24xTOn+FznN+NUfOCyfSU3yDy6rYrmiNpT3+/zyKZJXLv6/6e99mc2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TFfsktKY; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so2392962fac.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730168966; x=1730773766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OtRjJzFUnvrxwtpcn9XJc/xdJDx9VYHHtrGlwpyzpKc=;
        b=TFfsktKYANMpcafgU86o4F+33TArGR3tyoWDvAnc/S5aFom9Yu144A/h4/gEbxoWxM
         u7TeFcOPtmnpUw1Hd5dTc0CYp+GtBKU3vjF5AaGcsiwnyUO3inT+5hajcqTupBbitZcs
         OR5yrFNWbtdZEf4+oAYbnhpJohDoFtsMzb8UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730168966; x=1730773766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtRjJzFUnvrxwtpcn9XJc/xdJDx9VYHHtrGlwpyzpKc=;
        b=R/wUaQY1zPixdkmur/k3Y1zCozLYSAbo1nHBacD5GLbOp/QtcRvXohyF7YbwPYyN9k
         870d5IazIUbKXgqm5GBOlZ1neliTP0w96UCQ/J9akj/Xx7eqWC0Rm6zcytwRx5IbTfs0
         tqxXNAHlVwYw7/+G3NNHPph3c3hmLuXYqdmhIlO7N75WNxyzsqo+M6bfXi2/VqNvVDlg
         IjzORbqThz8N6/zJzSTxB7YBQBEtDVpojMqcU5CcOSkC8a6Z85QCJiuUlY/xNrDuuMbq
         GEj3XNY2ZZRb08fswI8zFVieYTC3aeTkQRxT7nKtrbV+Mcb0mWmd1AxN+XgFAYt//rnj
         02og==
X-Forwarded-Encrypted: i=1; AJvYcCVPd4lvXEQFzmNBVz0N/1Lc0klChBuI+01fI94nDMFanK9cn8YNT27ajVX9RyRn8rayh184wlayr0KqdS1f8iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMcgmPrvkRs/Sbh+hUihVG9sF7QCbX0iZDoAEo/HpDdtd3d14g
	yOdhebOJjkdmxSJHLZeMe96wrgmZYSQDHKXqXqBFBwWmRFJ8Cx87QmjB7JKS5Ik=
X-Google-Smtp-Source: AGHT+IEhuV07cjeS4LVtoUzAOa1MQj9lnkz7ezBRTnWnZujCXNa+VG8DxmrCFjNULb+Q6rs3HF7TPg==
X-Received: by 2002:a05:6870:56a7:b0:288:716b:142c with SMTP id 586e51a60fabf-29051b6bb8emr9074339fac.18.1730168965832;
        Mon, 28 Oct 2024 19:29:25 -0700 (PDT)
Received: from [10.200.3.216] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1f61bsm6686081b3a.144.2024.10.28.19.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 19:29:25 -0700 (PDT)
Message-ID: <24edee6f-9f77-43f2-8565-566668e5f697@linuxfoundation.org>
Date: Mon, 28 Oct 2024 20:29:21 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 23/23] testing/selftests: add test tool and
 scripts for ovpn module
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 sd@queasysnail.net, Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
 <20241025-b4-ovpn-v10-23-b87530777be7@openvpn.net>
 <fe2b641f-a8aa-428c-9f04-f099015e0eb9@linuxfoundation.org>
 <feef6601-0e68-4913-b305-3be3face4a9e@openvpn.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <feef6601-0e68-4913-b305-3be3face4a9e@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/28/24 04:13, Antonio Quartulli wrote:
> On 27/10/2024 01:40, Shuah Khan wrote:
>> On 10/25/24 03:14, Antonio Quartulli wrote:
>>> The ovpn-cli tool can be compiled and used as selftest for the ovpn
>>> kernel module.
>>>
>>> It implements the netlink API and can thus be integrated in any
>>> script for more automated testing.
>>>
>>> Along with the tool, 4 scripts are added that perform basic
>>> functionality tests by means of network namespaces.
>>>
>>> Cc: shuah@kernel.org
>>> Cc: linux-kselftest@vger.kernel.org
>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>> ---
>>>   MAINTAINERS                                        |    1 +
>>>   tools/testing/selftests/Makefile                   |    1 +
>>>   tools/testing/selftests/net/ovpn/.gitignore        |    2 +
>>>   tools/testing/selftests/net/ovpn/Makefile          |   17 +
>>>   tools/testing/selftests/net/ovpn/config            |   10 +
>>>   tools/testing/selftests/net/ovpn/data64.key        |    5 +
>>>   tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2370 ++++++++++ ++++++++++
>>>   tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
>>>   .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
>>>   tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
>>>   tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
>>>   tools/testing/selftests/net/ovpn/test.sh           |  183 ++
>>>   tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
>>>   13 files changed, 2626 insertions(+)
>>>
>>
>> What does the test output look like? Add that to the change log.
> 
> Hi Shuan,
> 
> is there any expected output for kselftest scripts?
> Right now it just prints a bunch of messages about what is being tested, plus the output from `ping` and `iperf`.
> 
> My assumption is that the output would be useful in case of failures, to understand where and what went wrong.
> 
> I can document that, but I am not sure it is truly helpful (?).
> What do you think?
> 
> Is there any specific output format I should obey to?
> 
> 
> [...]
> 
> 
>>> +
>>> +static void usage(const char *cmd)
>>> +{
>>> +    fprintf(stderr,
>>> +        "Usage %s <command> <iface> [arguments..]\n",
>>> +        cmd);
>>> +    fprintf(stderr, "where <command> can be one of the following\n\n");
>>> +
>>> +    fprintf(stderr, "* new_iface <iface> [mode]: create new ovpn interface\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr, "\tmode:\n");
>>> +    fprintf(stderr, "\t\t- P2P for peer-to-peer mode (i.e. client)\n");
>>> +    fprintf(stderr, "\t\t- MP for multi-peer mode (i.e. server)\n");
>>> +
>>> +    fprintf(stderr, "* del_iface <iface>: delete ovpn interface\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +
>>> +    fprintf(stderr,
>>> +        "* listen <iface> <lport> <peers_file> [ipv6]: listen for incoming peer TCP connections\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr, "\tlport: TCP port to listen to\n");
>>> +    fprintf(stderr,
>>> +        "\tpeers_file: file containing one peer per line: Line format:\n");
>>> +    fprintf(stderr, "\t\t<peer_id> <vpnaddr>\n");
>>> +    fprintf(stderr,
>>> +        "\tipv6: whether the socket should listen to the IPv6 wildcard address\n");
>>> +
>>> +    fprintf(stderr,
>>> +        "* connect <iface> <peer_id> <raddr> <rport> [key_file]: start connecting peer of TCP-based VPN session\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr, "\tpeer_id: peer ID of the connecting peer\n");
>>> +    fprintf(stderr, "\traddr: peer IP address to connect to\n");
>>> +    fprintf(stderr, "\trport: peer TCP port to connect to\n");
>>> +    fprintf(stderr,
>>> +        "\tkey_file: file containing the symmetric key for encryption\n");
>>> +
>>> +    fprintf(stderr,
>>> +        "* new_peer <iface> <peer_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr, "\tlport: local UDP port to bind to\n");
>>> +    fprintf(stderr,
>>> +        "\tpeer_id: peer ID to be used in data packets to/from this peer\n");
>>> +    fprintf(stderr, "\traddr: peer IP address\n");
>>> +    fprintf(stderr, "\trport: peer UDP port\n");
>>> +    fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
>>> +
>>> +    fprintf(stderr,
>>> +        "* new_multi_peer <iface> <lport> <peers_file>: add multiple peers as listed in the file\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr, "\tlport: local UDP port to bind to\n");
>>> +    fprintf(stderr,
>>> +        "\tpeers_file: text file containing one peer per line. Line format:\n");
>>> +    fprintf(stderr, "\t\t<peer_id> <raddr> <rport> <vpnaddr>\n");
>>> +
>>> +    fprintf(stderr,
>>> +        "* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>>> +    fprintf(stderr,
>>> +        "\tkeepalive_interval: interval for sending ping messages\n");
>>> +    fprintf(stderr,
>>> +        "\tkeepalive_timeout: time after which a peer is timed out\n");
>>> +
>>> +    fprintf(stderr, "* del_peer <iface> <peer_id>: delete peer\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to delete\n");
>>> +
>>> +    fprintf(stderr, "* get_peer <iface> [peer_id]: retrieve peer(s) status\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr,
>>> +        "\tpeer_id: peer ID of the peer to query. All peers are returned if omitted\n");
>>> +
>>> +    fprintf(stderr,
>>> +        "* new_key <iface> <peer_id> <slot> <key_id> <cipher> <key_dir> <key_file>: set data channel key\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr,
>>> +        "\tpeer_id: peer ID of the peer to configure the key for\n");
>>> +    fprintf(stderr, "\tslot: either 1 (primary) or 2 (secondary)\n");
>>> +    fprintf(stderr, "\tkey_id: an ID from 0 to 7\n");
>>> +    fprintf(stderr,
>>> +        "\tcipher: cipher to use, supported: aes (AES-GCM), chachapoly (CHACHA20POLY1305)\n");
>>> +    fprintf(stderr,
>>> +        "\tkey_dir: key direction, must 0 on one host and 1 on the other\n");
>>> +    fprintf(stderr, "\tkey_file: file containing the pre-shared key\n");
>>> +
>>> +    fprintf(stderr,
>>> +        "* del_key <iface> <peer_id> [slot]: erase existing data channel key\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>>> +    fprintf(stderr, "\tslot: slot to erase. PRIMARY if omitted\n");
>>> +
>>> +    fprintf(stderr,
>>> +        "* get_key <iface> <peer_id> <slot>: retrieve non sensible key data\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to query\n");
>>> +    fprintf(stderr, "\tslot: either 1 (primary) or 2 (secondary)\n");
>>> +
>>> +    fprintf(stderr,
>>> +        "* swap_keys <iface> <peer_id>: swap content of primary and secondary key slots\n");
>>> +    fprintf(stderr, "\tiface: ovpn interface name\n");
>>> +    fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
>>> +
>>> +    fprintf(stderr,
>>> +        "* listen_mcast: listen to ovpn netlink multicast messages\n");
>>> +}
>>
>> If this test is run from "make kselftest" as default run does this usage
>> output show up in the report?
> 
> No.
> This usage is only printed when invoking ovpn-cli with wrong arguments and this can't be the case in the kselftest.

The usage() is great and much needed. My concern is if this usage would show up
when we run "make kselftest" - some tests do this by adding wrapper shell script
to run the test with different options to cover all the cases.

> 
> 
> Other than documenting the output, do you think there is any other critical part to be adjusted in this patch?

No - I don't have any other comments on the test itself. I just want to make
sure this usage inadvertently doesn't end up in the "make kselftest" run.

With that

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

