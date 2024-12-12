Return-Path: <linux-kselftest+bounces-23250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1329EE33D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 10:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30E81616FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848C20E717;
	Thu, 12 Dec 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwlDR4wP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7620E339
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996461; cv=none; b=G7K7HFUYdJqqBzaSnOawXOiqr5oM+QHKAChABtn1A0U3TEDKsS2jsmL3RLhxFICZHZ6HcD2TCxO2o6i6QxWQTcne46HaiaAY6mCGsbRu60ko6iMX2hGjcJyFzsQOpwpN7WSy5Bi3RHJpiZTsSz/QegmbNBN8YaemiRMadqsvvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996461; c=relaxed/simple;
	bh=vS3YMZ8TTS+sy79u9btJFf1HSWBg0QXdTjZNCNiaehM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USha68i2/5r//EKLgUJ/xP1B3PRMP/FSZA/eRJJ6/W9XKN6N36sxyf33mRn7KmQNtMSfewIh9NHfrnOIPPM7vVip/XPMrVUlLvEz6QoWqFZ7Omt7Jt/dWRMqOITPwdRLOAeZ29h9JRrd8h9MYThFxBWz+rihGBzjpTN2qP1zgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwlDR4wP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733996458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vO5x2q/Sa0e5fTHlXfwREEvSvA3RWPrUa1t93Ro/NiA=;
	b=UwlDR4wPRD6Eb4DFKgZ9fdxy8jAxr4kXYjZjFN/zmkEFJ9w3k/zX/cLiYvBzK/alfpc/Hb
	rAbdn+t+LjOQXYLJspmbchLoDiRJY7zo3f8HOOTgiYiOc542STFiuYx+glNIYF+rQeeWW0
	vV7y+ITjtmpKvXxrKp2DyZ68bPmzkM0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-pVdNlDnxNkGfIS17Xcfamw-1; Thu, 12 Dec 2024 04:40:57 -0500
X-MC-Unique: pVdNlDnxNkGfIS17Xcfamw-1
X-Mimecast-MFC-AGG-ID: pVdNlDnxNkGfIS17Xcfamw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38639b4f19cso261725f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 01:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996456; x=1734601256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vO5x2q/Sa0e5fTHlXfwREEvSvA3RWPrUa1t93Ro/NiA=;
        b=qqE4TP9Lb/A7Wq5iciuqAlMR4Iw6q7cJeTBk6tuuHjZl6lBm1r7HWzOmPrt75HPVDo
         /vIq4FgkAjwu1bN1MSvcob2CEOlL6RfxY0VlrNmQKMpRa8Qzc2qg1+O3JWFUj2w3SmP5
         OGprHpK29Nak1zVA74oTT4KIXdRKWvgFXetTilrcL0rtAurWxV3EcvsZ9W+rZ4YdzmPx
         928bRI/XXCcKzHJQQLc6npgGlaxPdtTypPt3KUvZHzLSzBl+KQye3KauSJES25yX02jg
         Hpgaad8fdkKl6alA+nheKFf40jUPHlCjKtRtUK1libPGo7jsb1wAHS3J5EFGt2gJYOS+
         8gcg==
X-Forwarded-Encrypted: i=1; AJvYcCWJl86V8fYzv1Hk1muWjXIzIKNz/ubMKynGLCpvZ+rs6JxD6A0c0kH1bC8TY6ckcb10750xNuzWvxQlzhcMJrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZeE/j4VxFCAHGl3iyGXYgmb/vThMCS9MklE7UYwLJuaoQ+rS
	yDF3qU07cpYaQfq6UTVtIMIBUqJ/0S/Ojh0Hr4i1BQV3g4f7ETgTts3bu3RWNTgYRhFSBol4FBi
	fclIjY59Xkuo4yf106RRN4AtTqlLF6fUe50dm2HSwC1OT2y0fvcO1Jh/Mz6uagzYl7w==
X-Gm-Gg: ASbGncvHR4oG7bEUIBBFyz/rHemQxQ84wscwB0hlKWBRGxO2GSQkucP8U9nubYhZJrg
	2RS/RxodMYfF/mw1hR23G8NVFRKr1B9BtMD2QZHhNBJl+fGQJeo5kAhmJYU8KOELucRetBNWFRe
	pdwh4o8EIAMEAk4EFtiex+DtirwmroRP2jl9ZS/Ac4AZviiyaK/Sbd2QZL1oZswsDhk9/txeXic
	8kgVCqF587S/sb/G2SijWqGvcs57fKzi7YRAv53LmlHjuEyXF1iR9YRET0yMvOCW+Pnnf4R2c7L
	EVw0iuo=
X-Received: by 2002:a05:6000:1fa9:b0:385:f23a:2fec with SMTP id ffacd0b85a97d-3864ce88e29mr6040201f8f.11.1733996455831;
        Thu, 12 Dec 2024 01:40:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPT0KYgGEFCZGrqybSALsE3Qqj+pmWswO0HlvX3IBSNS8HmdA5fJvJjIK2Fq1iEV0Tr46sRQ==
X-Received: by 2002:a05:6000:1fa9:b0:385:f23a:2fec with SMTP id ffacd0b85a97d-3864ce88e29mr6040187f8f.11.1733996455462;
        Thu, 12 Dec 2024 01:40:55 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c462sm11164015e9.14.2024.12.12.01.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:40:55 -0800 (PST)
Message-ID: <4a2fe99a-772d-4df1-a8ef-14338682b69e@redhat.com>
Date: Thu, 12 Dec 2024 10:40:53 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/5] selftests: net: Add two test cases for
 link netns
To: Xiao Liang <shaw.leon@gmail.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209140151.231257-1-shaw.leon@gmail.com>
 <20241209140151.231257-6-shaw.leon@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241209140151.231257-6-shaw.leon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 15:01, Xiao Liang wrote:
>  - Add test for creating link in another netns when a link of the same
>    name and ifindex exists in current netns.
>  - Add test for link netns atomicity - create link directly in target
>    netns, and no notifications should be generated in current netns.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> ---
>  tools/testing/selftests/net/Makefile        |  1 +
>  tools/testing/selftests/net/netns-name.sh   | 10 ++++++
>  tools/testing/selftests/net/netns_atomic.py | 39 +++++++++++++++++++++
>  3 files changed, 50 insertions(+)
>  create mode 100755 tools/testing/selftests/net/netns_atomic.py
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index cb2fc601de66..f9f7a765d645 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -34,6 +34,7 @@ TEST_PROGS += gre_gso.sh
>  TEST_PROGS += cmsg_so_mark.sh
>  TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
>  TEST_PROGS += netns-name.sh
> +TEST_PROGS += netns_atomic.py
>  TEST_PROGS += nl_netdev.py
>  TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
>  TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
> diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/selftests/net/netns-name.sh
> index 6974474c26f3..0be1905d1f2f 100755
> --- a/tools/testing/selftests/net/netns-name.sh
> +++ b/tools/testing/selftests/net/netns-name.sh
> @@ -78,6 +78,16 @@ ip -netns $NS link show dev $ALT_NAME 2> /dev/null &&
>      fail "Can still find alt-name after move"
>  ip -netns $test_ns link del $DEV || fail
>  
> +#
> +# Test no conflict of the same name/ifindex in different netns
> +#
> +ip -netns $NS link add name $DEV index 100 type dummy || fail
> +ip -netns $NS link add netns $test_ns name $DEV index 100 type dummy ||
> +    fail "Can create in netns without moving"
> +ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not found"
> +ip -netns $NS link del $DEV || fail
> +ip -netns $test_ns link del $DEV || fail
> +
>  echo -ne "$(basename $0) \t\t\t\t"
>  if [ $RET_CODE -eq 0 ]; then
>      echo "[  OK  ]"
> diff --git a/tools/testing/selftests/net/netns_atomic.py b/tools/testing/selftests/net/netns_atomic.py
> new file mode 100755
> index 000000000000..d350a3fc0a91
> --- /dev/null
> +++ b/tools/testing/selftests/net/netns_atomic.py
> @@ -0,0 +1,39 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import time
> +
> +from lib.py import ksft_run, ksft_exit, ksft_true
> +from lib.py import ip
> +from lib.py import NetNS, NetNSEnter
> +from lib.py import RtnlFamily
> +
> +
> +def test_event(ns1, ns2) -> None:
> +    with NetNSEnter(str(ns1)):
> +        rtnl = RtnlFamily()
> +
> +    rtnl.ntf_subscribe("rtnlgrp-link")
> +
> +    ip(f"netns set {ns1} 0", ns=str(ns2))
> +
> +    ip(f"link add netns {ns2} link-netnsid 0 dummy1 type dummy")
> +    ip(f"link add netns {ns2} dummy2 type dummy", ns=str(ns1))
> +
> +    ip("link del dummy1", ns=str(ns2))
> +    ip("link del dummy2", ns=str(ns2))
> +
> +    time.sleep(1)
> +    rtnl.check_ntf()
> +    ksft_true(rtnl.async_msg_queue.empty(),
> +              "Received unexpected link notification")

I think we need a much larger coverage here, possibly testing all the
update drivers and more 'netns', 'link-netnsid', 'peer netns'
permutations for the devices that allow them.

Thanks,

Paolo


