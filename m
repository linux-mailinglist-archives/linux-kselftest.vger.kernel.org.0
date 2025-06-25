Return-Path: <linux-kselftest+bounces-35800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A55AE9062
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 23:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C59B189ADBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 21:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DEB20DD54;
	Wed, 25 Jun 2025 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYGgbLZj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AAB5234;
	Wed, 25 Jun 2025 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887966; cv=none; b=JUKFwtnh+475CWTwVimLhpVF+GawSr89uc32oHZ6uA/i4pBdWJ7xBaNfdw3EbF8FeKcc/8R9FHYQBX/GaS+PsASiCtUr48DxOK1+FU4JFQV/rLO9sS9PTuh0YC/IGGNfTSlk1GH3bRHpnFuWfXgccATlsBXQnnUWCrE3AKRC6Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887966; c=relaxed/simple;
	bh=wzYUEdB5fNwXy6rhECSNq0oE2cM9yjMSXFd7RBAnExY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQigvF0PTmZzWfeForII0psplsTHlGWFhI8Nv8AAZRiURASV6tR6k24RGwpv514x1vLm2lPjv6GRPyaQP8iid3xhJ75UW4FJ9cLe/wnA7RpmRyEYHPutzvHbzbapNigjEIWU2GBfmXsrkyTrvVU14evHqvRfTewT7bDmAe6SxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYGgbLZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6272C4CEEA;
	Wed, 25 Jun 2025 21:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750887966;
	bh=wzYUEdB5fNwXy6rhECSNq0oE2cM9yjMSXFd7RBAnExY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RYGgbLZj8iYcNULlY8k8X3+/JZ6KlASpSFjZeUfSDIm32qAEodtGKruVfzEE9Y7r2
	 hHdXX+oJ61vh+xWg244Htsy89Nl2xt2UntEsqTufFcEw7A2PV03Q+QcTX3r6DqnX55
	 kJo3dDdZxC6yO04nsUnMUJ0wYP8iR3QHPFGIRPCETrrJ3yhsjneeFfO00OsZKcIupJ
	 OoX7poUPTzfjemRhcJhc1SCoWkfxxOYTukjdMF1UJPnysmxac9+9oCmmbsEX/9V/jL
	 XTJAeeGh/i7Mc5kwWQFDNQxo7lBbyq2nJRxEwSLANjKgjRWxkaqVsGdLlFFvTIVSmD
	 7tibpJ91g5GWA==
Date: Wed, 25 Jun 2025 14:46:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org,
 gustavold@gmail.com, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 0/4] selftest: net: Add selftest for netpoll
Message-ID: <20250625144604.3f60d09d@kernel.org>
In-Reply-To: <20250625184346.GM1562@horms.kernel.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
	<20250625184346.GM1562@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 19:43:46 +0100 Simon Horman wrote:
> # # Exception| Traceback (most recent call last):
> # # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/net/lib/py/ksft.py", line 243, in ksft_run
> # # Exception|     case(*args)
> # # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 308, in test_netpoll
> # # Exception|     do_netpoll_flush_monitored(cfg, netdevnl, ifname, target_name)
> # # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 243, in do_netpoll_flush_monitored
> # # Exception|     do_netpoll_flush(cfg, netdevnl, ifname, target_name)
> # # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 278, in do_netpoll_flush
> # # Exception|     if bpftrace_any_hit(join=False):
> # # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 230, in bpftrace_any_hit
> # # Exception|     raise KsftFailEx(f"bpftrace failed to run!?: {MAPS}")
> # # Exception| net.lib.py.ksft.KsftFailEx: bpftrace failed to run!?: {}

Looks like I haven't added bpftrace to the image before.
Fixed now.

