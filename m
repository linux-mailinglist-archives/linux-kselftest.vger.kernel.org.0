Return-Path: <linux-kselftest+bounces-9253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17418B9324
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 03:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3481C21468
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 01:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026DA12E75;
	Thu,  2 May 2024 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi6wer8x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585D712B93;
	Thu,  2 May 2024 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714613907; cv=none; b=MeXA/1SxgIzPdcklfhTzMpapxLF+uKmEt/CfnmF4Jqo96t0lbfVk0oAn/x2rl71N15G//Ty/RlMf1nMNnjt6aJbPADGAB9TLFo7ApsPkKfhwW4jjjLTpuZP9Lf4EBvs2eKoDAbfnHL44mQ7rG6kigL6EJjP7uaEx1zOK5X9Txwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714613907; c=relaxed/simple;
	bh=JZR8JM6/C6y1TrN5e2I5URm0lIdHoKbjEBvNWqk3K/E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NKx71jxJa6O5/j1hSLQPc9CwcorEGe3nfwOs9fqL/n3yWP3V0yYYF9C5UiwcufGzvRbGLxONIJGI/X6V9rnWl75wTrZfkPA0CyRFZ8nwCk3hKowXIKn2vjvz60hOZ0eS3M488P7QrmZKDScSM8qG0by7cfqiexOWb+QxEmoqzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi6wer8x; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6a0c8fb3540so13216526d6.1;
        Wed, 01 May 2024 18:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714613905; x=1715218705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPICephXaLessvRUUOJzNei7ZEdzmTmcsaiNIs+7jPU=;
        b=Qi6wer8xBZNKcoQ30G9/XFpiYmo6DEdcTSnvcq48WBTD4KNxpqJvJIGICy2Ez3J2aC
         gb9uZdjxA29Uc0rs3EcCYVANdzNXez8wAZg5KRSStgHCNUVR45JORyG5vldBQp2hweyX
         R6gF/ibI3BrZ9AzYxihHS3esRiXZguz4BCDco9Z+yNgJgE7j1NESe675zWTqQPo8iado
         rhFii8WRbVhwZ/WYYFlBXBKbBbZQDVNiL/LV3jgDPd/A62mY9JuVDGziTJFdmnnNWaXL
         M54GBm/YN31i3HpwupCZQ8/U7YIZh4SZ3f2GAMA6TBOnFlvThZ5g5sndYmBGY5urkL1y
         jrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714613905; x=1715218705;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IPICephXaLessvRUUOJzNei7ZEdzmTmcsaiNIs+7jPU=;
        b=IKxFjMFpnaDfo4Yrff31uZckW2lUWlH5E8779u4v2y8/PEBfSKDse6uC5IZ3qR4cm1
         jPmMgCj3IFqJlS4Jt25fYfb7dOmo/FsdiEuZkBYYmj36ATDBl4TQrYIZ0ub1ldbBSUHR
         wZa6hXgglMzET02YQ+hSEz4Riv6IumVJ5WXL2y+Fe2BwW8wJRc+0Yh9xkq1UlBeam3WC
         VfVd9HHRWAXcY/g0iO8hdvdVCO5fK1PiTBpbroUgcuOvsvQcqxTQXBMnT3KR1DPX5cAz
         eBWyxocyjjZlfgEJhFmcp0CB+yGrZdD0KVS8EcYszLZppRusbqHFbHfYuXIVWnS2k74c
         okGA==
X-Forwarded-Encrypted: i=1; AJvYcCWidTt75c9DYemLJT+u6YeyTLNPKP6SyDzbjdsgJ1zF3jax6dVeObZmH94ctAaFVkFmBsoZMrgjB2rVProltHK00RRfcLcrsJ9xXZBCnwTJ
X-Gm-Message-State: AOJu0Ywsin8Ut85Pn/zYrw6/kmHlaJt1YA9PvlZFzmZwcdJYDdcT5aF1
	z0NcgAKZYnO3Yo7qo8dKzocH+M06lQUPOag0bloC0b+YeB0OSabk
X-Google-Smtp-Source: AGHT+IHc/WBlt4xLMZIilRMl3XLXh+FH1kMFD2daVXfU18KycM6xVRUFkxcLjemx6wroLvNKWjUEZQ==
X-Received: by 2002:ad4:5f86:0:b0:6a0:a4db:b297 with SMTP id jp6-20020ad45f86000000b006a0a4dbb297mr2347760qvb.23.1714613905145;
        Wed, 01 May 2024 18:38:25 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id o2-20020a0cecc2000000b006a0ddff6523sm2061213qvq.1.2024.05.01.18.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 18:38:24 -0700 (PDT)
Date: Wed, 01 May 2024 21:38:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <6632ee9092206_37f3af294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240501180657.3eb1ef99@kernel.org>
References: <20240501185432.3593168-1-willemdebruijn.kernel@gmail.com>
 <20240501180657.3eb1ef99@kernel.org>
Subject: Re: [PATCH net-next] selftests: drv-net: add checksum tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Great! I run it on a couple of older machines. 
> 
> mlx5:
> 
> TAP version 13
> 1..1
> # timeout set to 0
> # selftests: drivers/net/hw: csum.py
> # KTAP version 1
> # 1..12
> # ok 1 csum.ipv4_rx_tcp # SKIP Test requires IPv4 connectivity
> # ok 2 csum.ipv4_rx_tcp_invalid # SKIP Test requires IPv4 connectivity
> # ok 3 csum.ipv4_rx_udp # SKIP Test requires IPv4 connectivity
> # ok 4 csum.ipv4_rx_udp_invalid # SKIP Test requires IPv4 connectivity
> # ok 5 csum.ipv4_tx_udp_csum_offload # SKIP Test requires IPv4 connectivity
> # ok 6 csum.ipv4_tx_udp_zero_checksum # SKIP Test requires IPv4 connectivity
> # ok 7 csum.ipv6_rx_tcp
> # ok 8 csum.ipv6_rx_tcp_invalid
> # ok 9 csum.ipv6_rx_udp
> # ok 10 csum.ipv6_rx_udp_invalid
> # ok 11 csum.ipv6_tx_udp_csum_offload
> # ok 12 csum.ipv6_tx_udp_zero_checksum
> # # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:6 error:0
> ok 1 selftests: drivers/net/hw: csum.py
> 
> bnxt:
> 
> TAP version 13
> 1..1
> # timeout set to 0
> # selftests: drivers/net/hw: csum.py
> # KTAP version 1
> # 1..12
> # ok 1 csum.ipv4_rx_tcp # SKIP Test requires IPv4 connectivity
> # ok 2 csum.ipv4_rx_tcp_invalid # SKIP Test requires IPv4 connectivity
> # ok 3 csum.ipv4_rx_udp # SKIP Test requires IPv4 connectivity
> # ok 4 csum.ipv4_rx_udp_invalid # SKIP Test requires IPv4 connectivity
> # ok 5 csum.ipv4_tx_udp_csum_offload # SKIP Test requires IPv4 connectivity
> # ok 6 csum.ipv4_tx_udp_zero_checksum # SKIP Test requires IPv4 connectivity
> # ok 7 csum.ipv6_rx_tcp
> # ok 8 csum.ipv6_rx_tcp_invalid
> # ok 9 csum.ipv6_rx_udp
> # ok 10 csum.ipv6_rx_udp_invalid
> # ok 11 csum.ipv6_tx_udp_csum_offload # SKIP Test requires tx checksum offload on eth0
> # ok 12 csum.ipv6_tx_udp_zero_checksum # SKIP Test requires tx checksum offload on eth0
> # # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:8 error:0
> ok 1 selftests: drivers/net/hw: csum.py

Nice, thanks for testing!

> On Wed,  1 May 2024 14:51:34 -0400 Willem de Bruijn wrote:
> > Run tools/testing/selftest/net/csum.c as part of drv-net.
> > This binary covers multiple scenarios, based on arguments given,
> > for both IPv4 and IPv6:
> 
> The use of csum.c is the only real concern I have. Could you move it to
> net/lib? I made net/lib into an automatically included target in commit
> b86761ff6374 ("selftests: net: add scaffolding for Netlink tests in Python").
> 
> It has a makefile like any selftest directory, so you should be able to
> do a simple move and minor path adjustments.
> 
> Without this if someone builds and deploys just the drivers/net{,/hw}
> targets the csum binary won't be there :( We could auto-include all of
> net but using the lib target felt a little cleaner.

Can do.

A few more may be in scope eventually: toeplitz, udpgso_bench, gro,
so_txtime. Move them on a case-by-case basis?
 
> > - Accept UDP correct checksum
> > - Detect UDP invalid checksum
> > - Accept TCP correct checksum
> > - Detect TCP invalid checksum
> > 
> > - Transmit UDP: basic checksum offload
> > - Transmit UDP: zero checksum conversion
> > 
> > The test direction is reversed between receive and transmit tests, so
> > that the NIC under test is always the local machine.
> > 
> > In total this adds up to 12 testcases, with more to follow. For
> > conciseness, I replaced individual functions with a function factory.
> > It saves a lot of boilerplate, but is a little harder to follow, so
> > partially here as a point for discussion.
> 
> LGTM, FWIW, but let's hear if anyone feels it's too magical.
> 
> > Warning that for now transmit errors are not detected, as for those
> > the receiver runs remotely and failures with bkg are ignored.
> 
> Should I send a fix for that?

Please do. I did not grasp your suggestion well enough to take a
stab. I may have already spotted the zero conversion test returning
success, while explicit logging of the stderr output shows otherwise.


