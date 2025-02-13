Return-Path: <linux-kselftest+bounces-26534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536E0A33E67
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515737A06AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406421422A;
	Thu, 13 Feb 2025 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="asilKgaf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395A211A06
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447198; cv=none; b=NpTK5JeQVVMKykFnQMzIwuN/IBaho/O3rNyTg7j+NZDmgMGfAbH74EhjWrHgHtpTfK8lUemsYoKY+UWEAuIDfsRls3oUirbEjyx9MtytSyDeUy2xepEYSdHLSmHQrfm3hYA8Thdkcdi0wxf/nwH5jcuQN3PxEvIuroMgILpCgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447198; c=relaxed/simple;
	bh=Gt0tMFFzR5IlIKVaO3OfCljuPflErhSeAuqyN39sKfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+o5MLih7P7En8o+wH1U6YT5pYTgmDShEvJoaJdDKuQz8OcCpTVa2Y4BsgQpdxqMumePZQ/9PaV7b6RROHrz478KvzbljQpy73IuHLp+e0OteJMb71USrYxxxG1EDE4LdNb88f4tqQa9fA3Z/HFBHnc1Uw5rc6HIvxF59ETw3V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=asilKgaf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so8444275e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 03:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739447194; x=1740051994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pLvkb9HlJyUozDiDHO4/drWQgsoe+VSaExuzLx0XOw4=;
        b=asilKgafl9i0ISeFFmLW+GbaWANQDfufF85l3jcp/7fMv1EM07FN8Xvu+M777rF55d
         rjyKhHCLztpaxK6ODjjm9z5bWRfdCoSQtChv3PUc5SVo1Rk74C5dVpgD5nVCHvpoX959
         V4bUAntmme/R05biFpXM5gxoRCBza5CKpNbBRp7tyTVJR1JQgFYEN8EPwyo8dbXk1tv4
         znVXNfZFlB0uCbsE6UKxgXlCA/qboU43F9W8a8Iwj5pUG+d5OIPF9w1Bp5YM5/kbPlQG
         ZQNq5QiTyakSCVd8o9OR+HRWEK4wiGwElK7VfKHpW94ZV2SysvKBG65kQS4lfZ6o5PW2
         hSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739447194; x=1740051994;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLvkb9HlJyUozDiDHO4/drWQgsoe+VSaExuzLx0XOw4=;
        b=X1tmm11AqRwJNPFAaqebtKaH8EHoFKo6bN9+txdv6QSh5Y2X3OCXNYGnomZz0viMAZ
         jJxWQvAHIv4qAVOAA4KztGaYfyl8FzfVqW4oKeYI3allgSfLtC4sDwYLkt7FrEZcxPoh
         F2jl6LFFfohxe8ciTfuqjZ7HWJOZ3eqCn1OLUfBkqZteimZR5VfTBvC5ONjpJRrunuEH
         fZrOqnA4BVdO9i+unqVrvKelZhInIr69afbtvutvoObkfXIvSBUNgppHizvtDmB/G2Wc
         QRN703MLg4TzVP1oMOnWvq82gWs+x8K642gSr5DGEKOVPJeP/nu2+8dLMUdUk0VyjnFE
         VT8g==
X-Forwarded-Encrypted: i=1; AJvYcCXyZ0LTL7DbEGDsxaMt0Rn6ulpp2zgZGu5meQDDBhDLXOjURZzw92Cy7kyrYyGHaWNJyXStIRz3oKtM6Wx6elk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NWfY2kqdoxhy5zP5lRgCew6o4VGgNx0YVURi/VnijeteT7YP
	daeC42Jvwr0gUDmCt2TAeSE0ggteOfyf0VHXOMLsWlPDjI2USvc1eGrcqI3B0b4=
X-Gm-Gg: ASbGncvyDEJOYi3eXAmdXOVlvQim++U4Ed8BrUzH+8kwtVkcFA7eo/nUHg4KPYpCqmw
	4f4oSgARm7A9vtq97bMQ23NC7lhXCrJ6exjjevo/hqiqw9kSTE1wHXO5XGPMAOOgjDkdS4fvTLT
	5H1dCiZuIeP5poqAHJ+ijixK4VFttpDzfxt4SKHddORF0cbFP9tutEpN4cv4rtT1GW3PlMCGwDw
	8seLf6eDYcIkysoJHZTE6I5pACC5f5a7/jqIXDy5h9Nu1OHVhBFDDuE2AmzfXI5cPr/LSmBcJQ0
	LbwJCnHYrAB1fUUICzvwKQRKanrBIr/gV8uxng0GuZq1chvT/iGwQQ==
X-Google-Smtp-Source: AGHT+IGc0R4jikBYLoD4kdApspmKli3hWqBkBAV/vMF0JaPNaKhRS5GIlRqwwYV+GGz7ZQ8tBLD2Fg==
X-Received: by 2002:a05:6000:1ace:b0:38d:d0ca:fbad with SMTP id ffacd0b85a97d-38dea270cf3mr6983294f8f.14.1739447194514;
        Thu, 13 Feb 2025 03:46:34 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:9591:8141:43d0:1ca6? ([2001:67c:2fbc:1:9591:8141:43d0:1ca6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8217sm1658833f8f.90.2025.02.13.03.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 03:46:34 -0800 (PST)
Message-ID: <090524ac-724d-4915-8699-fe2ae736ab8c@openvpn.net>
Date: Thu, 13 Feb 2025 12:46:34 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 00/26] Introducing OpenVPN Data Channel
 Offload
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
 <Z60wIRjw5Id1VTal@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z60wIRjw5Id1VTal@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2025 00:34, Sabrina Dubroca wrote:
> Hello,
> 
> 2025-02-11, 01:39:53 +0100, Antonio Quartulli wrote:
>> All minor and major reported problems have been finally addressed.
>> Big thanks to Sabrina, who took the time to guide me through
>> converting the peer socket to an RCU pointer.
> 
> Something is off (not sure if it's new to this version): if I use
> test-tcp.sh to setup a set of interfaces and peers (I stop the test
> just after setup to keep the environment alive), then remove all netns
> with "ip -all netns delete", I expect all devices to go away, but they
> don't. With debug messages enabled I'm seeing some activity from the
> module ("tun0: sending keepalive to peer 3" and so on), and
> ovpn_net_uninit/ovpn_priv_free never got called.

I can reproduce it. If later I rmmod ovpn I then get all the "Deleting 
peer" messages.
So instances are not being purged on netns exit.

Will dive into it.

> 
> [...]
>> So there is NO risk of deadlock (and indeed nothing hangs), but I
>> couldn't find a way to make the warning go away.
> 
> I've spotted another splat on strparser cleanup that looked like an
> actual deadlock, but it's not very reproducible. Still looking into
> it, but I'm not convinced it's ok to call strp_done (as is done from
> ovpn_tcp_socket_detach) while under lock_sock, because AFAIU
> cancel_work_sync(&strp->work) may be waiting for a work that needs to
> lock the socket (cb.lock in do_strp_work). I guess tcp_tx_work would
> have the same problem.

Will have a look here too.

Thanks!


-- 
Antonio Quartulli
OpenVPN Inc.


