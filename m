Return-Path: <linux-kselftest+bounces-41075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B568B508E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 00:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D80F44E124D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 22:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3FB25B1FF;
	Tue,  9 Sep 2025 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgHewXgo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67450199931;
	Tue,  9 Sep 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757457229; cv=none; b=gl7cz2OKmRy4+vVu2jn3sEmzYlMmhgzT/i/EFYfFYMXfGZ9HU6NmCiKmjIIvLyZcTPoJcUqLaeBw/g3fnp94PGO9kEK+MZxZVxZEdPyO5gfeom8wpzA4Uac2oYFvhKyCbDw2gVD2VLlCc6/Bb5tHVdG+ePzN6Z7BcMAL+I/nsec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757457229; c=relaxed/simple;
	bh=4H40jQGFIGfAXqT3uXKFm2mX6cxL5Y6lXzcnOrg89VA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IT5Znz528R2LWNVwt2uUPgGvLg2rTX0aJ0i7ib15ZLvEp14eWy9A+IYdoK1oh9bET3hl12VYXCU7XB2ef1y2c80DHjYpi/huo1htcDmqlpAAnb8lfwKUGvj6N2ErB4WB73pARhXjEiVDeCfGU7DBSUsvoczBGrgEuOZJE2n+Hbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgHewXgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E080C4CEF4;
	Tue,  9 Sep 2025 22:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757457228;
	bh=4H40jQGFIGfAXqT3uXKFm2mX6cxL5Y6lXzcnOrg89VA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NgHewXgohNN/wzb39KPOXD72GmkN2pBR9wFBe8BLP0hzLvURsD3A2buznB9NRoIF+
	 LiP5ftJXOB9+t1+krNMNFVE9nqB6Im4qlnES7r0A8cvvdTdYb4Yxo/ToZIZiu8USUO
	 SSenA6jsnmDSKGcjrC8nKTUPBvQMyycv6WzMWObkHK1CCuIFRn6+ZeyEdi3KYhauOZ
	 fvZzrIvHgPbKa1DnRRU4bT0pvuPhN/0/oeeVsQ2ecgAa/jtpalnaxR2gfXaqNsib7M
	 FkC5kSGIbSenqEAF/2AWmhzleIkbMM0OtvSXtaz+Xfb4yOhgUerUx5bANNCuejJTRe
	 08B3ttLhMl96w==
Date: Tue, 9 Sep 2025 15:33:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next v2] selftests: net: replace sleeps in
 fcnal-test with waits
Message-ID: <20250909153346.4fa8c369@kernel.org>
In-Reply-To: <20250908200949.270433-1-kuba@kernel.org>
References: <20250908200949.270433-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 13:09:49 -0700 Jakub Kicinski wrote:
>  kill_procs()
>  {
>  	killall nettest ping ping6 >/dev/null 2>&1
> -	sleep 1
> +	slowwait 2 sh -c 'test -z "$(pgrep '"'^(nettest|ping|ping6)$'"')"'
>  }

This makes some ping tests fail.

https://netdev-3.bots.linux.dev/vmksft-net/results/289602/129-fcnal-other-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-net/results/289602/128-fcnal-ipv6-sh/stdout

I only tested with debug kernels, but the non-debug get upset.
I'll resend just the wait_local_port_listen changes. If the change
gets more complex it's probably good to separate them out in the first
place.

