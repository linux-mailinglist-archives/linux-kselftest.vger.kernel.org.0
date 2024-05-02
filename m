Return-Path: <linux-kselftest+bounces-9252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477AF8B9303
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 03:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EEC1F21710
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 01:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D84910A24;
	Thu,  2 May 2024 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2mgwVDc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A82F23;
	Thu,  2 May 2024 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714612019; cv=none; b=Lfb/Mb77JCqTdNxMQNfOLXhJesBfmL3Hg0fYZTzyDn00wi+lH7ebNprhPJsfa536cVQX1MPuT0/IKU0y6skpzWkRCXwX1OH4dY5NqrDXq9aaMnEXoLaEymm+nAv5wJs6tSe6UFmdGhcvEfHH4Wky4mw+y+uadvs7NVW5fsnCnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714612019; c=relaxed/simple;
	bh=Z6N3qRxg+3nZYFICC7K+iqK7CX9HjsQLVbsaCl2edaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbHFbtxhKH8YxjDwtlMoXTTLCwui89MjkNuTgZ4rSxuuJ+sKf8op6YsEduZRBdBkJMpcG+jUhARaVZO7UxALB0iKLOi5fWUoaiT/F9OBr7hF4pYsSLnMzKvFCkgJS8iur6DdgmFReiLJVuMbBxu6ak+EvGuiiiPsyGDJSU0HKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2mgwVDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FBBC072AA;
	Thu,  2 May 2024 01:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714612018;
	bh=Z6N3qRxg+3nZYFICC7K+iqK7CX9HjsQLVbsaCl2edaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e2mgwVDcqei/+FxZiSEWMDxzwVXinq3p9MjBkCoL3nsGATWEJT1G5CF41JGHpxB7j
	 7ACgRXo40LqED1juNJhyv2X5ar6VRhyJTbqymCB/v5viQHK+2sZkiVjpbLLKTLewPZ
	 TbyEL0OC5V2xyX4mi027FLHa5erS7av7Jvnza32ZgZbVCDTwv/MupIT8TbMntGouH9
	 p8ltrmXbKo5n+Spyz+BU4DQwOtjRbBOovvObf1BdOpTgcq/Dbh8IY8ZB5u4FS7PA7k
	 c4diFKTMyMsyq+vRQ+4W6kgzIevX44czaUWzjv1CMKc9CCPi9yafSgzr7vTwCbxlat
	 WobKsOyhKg+eA==
Date: Wed, 1 May 2024 18:06:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next] selftests: drv-net: add checksum tests
Message-ID: <20240501180657.3eb1ef99@kernel.org>
In-Reply-To: <20240501185432.3593168-1-willemdebruijn.kernel@gmail.com>
References: <20240501185432.3593168-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Great! I run it on a couple of older machines. 

mlx5:

TAP version 13
1..1
# timeout set to 0
# selftests: drivers/net/hw: csum.py
# KTAP version 1
# 1..12
# ok 1 csum.ipv4_rx_tcp # SKIP Test requires IPv4 connectivity
# ok 2 csum.ipv4_rx_tcp_invalid # SKIP Test requires IPv4 connectivity
# ok 3 csum.ipv4_rx_udp # SKIP Test requires IPv4 connectivity
# ok 4 csum.ipv4_rx_udp_invalid # SKIP Test requires IPv4 connectivity
# ok 5 csum.ipv4_tx_udp_csum_offload # SKIP Test requires IPv4 connectivity
# ok 6 csum.ipv4_tx_udp_zero_checksum # SKIP Test requires IPv4 connectivity
# ok 7 csum.ipv6_rx_tcp
# ok 8 csum.ipv6_rx_tcp_invalid
# ok 9 csum.ipv6_rx_udp
# ok 10 csum.ipv6_rx_udp_invalid
# ok 11 csum.ipv6_tx_udp_csum_offload
# ok 12 csum.ipv6_tx_udp_zero_checksum
# # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:6 error:0
ok 1 selftests: drivers/net/hw: csum.py

bnxt:

TAP version 13
1..1
# timeout set to 0
# selftests: drivers/net/hw: csum.py
# KTAP version 1
# 1..12
# ok 1 csum.ipv4_rx_tcp # SKIP Test requires IPv4 connectivity
# ok 2 csum.ipv4_rx_tcp_invalid # SKIP Test requires IPv4 connectivity
# ok 3 csum.ipv4_rx_udp # SKIP Test requires IPv4 connectivity
# ok 4 csum.ipv4_rx_udp_invalid # SKIP Test requires IPv4 connectivity
# ok 5 csum.ipv4_tx_udp_csum_offload # SKIP Test requires IPv4 connectivity
# ok 6 csum.ipv4_tx_udp_zero_checksum # SKIP Test requires IPv4 connectivity
# ok 7 csum.ipv6_rx_tcp
# ok 8 csum.ipv6_rx_tcp_invalid
# ok 9 csum.ipv6_rx_udp
# ok 10 csum.ipv6_rx_udp_invalid
# ok 11 csum.ipv6_tx_udp_csum_offload # SKIP Test requires tx checksum offload on eth0
# ok 12 csum.ipv6_tx_udp_zero_checksum # SKIP Test requires tx checksum offload on eth0
# # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:8 error:0
ok 1 selftests: drivers/net/hw: csum.py

On Wed,  1 May 2024 14:51:34 -0400 Willem de Bruijn wrote:
> Run tools/testing/selftest/net/csum.c as part of drv-net.
> This binary covers multiple scenarios, based on arguments given,
> for both IPv4 and IPv6:

The use of csum.c is the only real concern I have. Could you move it to
net/lib? I made net/lib into an automatically included target in commit
b86761ff6374 ("selftests: net: add scaffolding for Netlink tests in Python").

It has a makefile like any selftest directory, so you should be able to
do a simple move and minor path adjustments.

Without this if someone builds and deploys just the drivers/net{,/hw}
targets the csum binary won't be there :( We could auto-include all of
net but using the lib target felt a little cleaner.

> - Accept UDP correct checksum
> - Detect UDP invalid checksum
> - Accept TCP correct checksum
> - Detect TCP invalid checksum
> 
> - Transmit UDP: basic checksum offload
> - Transmit UDP: zero checksum conversion
> 
> The test direction is reversed between receive and transmit tests, so
> that the NIC under test is always the local machine.
> 
> In total this adds up to 12 testcases, with more to follow. For
> conciseness, I replaced individual functions with a function factory.
> It saves a lot of boilerplate, but is a little harder to follow, so
> partially here as a point for discussion.

LGTM, FWIW, but let's hear if anyone feels it's too magical.

> Warning that for now transmit errors are not detected, as for those
> the receiver runs remotely and failures with bkg are ignored.

Should I send a fix for that?

