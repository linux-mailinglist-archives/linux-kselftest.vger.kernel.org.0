Return-Path: <linux-kselftest+bounces-24747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F21A158DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 22:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C3B3A9418
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7A51AA792;
	Fri, 17 Jan 2025 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNjjx+uT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B82187550;
	Fri, 17 Jan 2025 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148316; cv=none; b=TfRm2BEqzJ20R2Y9vKq1JD3Qu/UOfVPFLp40KehwFF1rujf6rthr8R5Ae2xgtrlmcioueR0AdTLCOUVeYc9umZPxgHsvzti2BzjfOgDyEWp0dkD+5M//FdkQEJYWdSbChkHftnTleY7EtRH0wR7jSiPut+CF+5Gtf02vi4bmAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148316; c=relaxed/simple;
	bh=2nkz+8bkR0pAm+DUPBITuOIanxioDs8buSS8w+kpe2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDkblqluNY/qwE/pPg/p7Eluffv7kdEqEOePOqPNHbrKozkQtKGcFwcsXKJA+GYRxSdhP85erYpn03ge4iEO86qd4pku26SDrw5jRSbaLT+aPtQAOG1ntWqreBSURzNyRHqxsrF0C7L+l4qx7dWIYw7xR4K8DzIXb6Hycp90jdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNjjx+uT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596E4C4CEDD;
	Fri, 17 Jan 2025 21:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737148315;
	bh=2nkz+8bkR0pAm+DUPBITuOIanxioDs8buSS8w+kpe2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HNjjx+uTWkYvhpvh1df7RItpxSE0GvhwbXTntjyRpRn+XAB9lkmXFei1gz7G3HEf1
	 WlT2+6+lT9/x8kOpcz7prZRjNQL8zSjP/YthshwDzQfHJr0GHSuy6aAhQv7mOsRLXY
	 AB6IxAvzIWlrndEcUBySB2lxucd6oj2Th7FMLx6gX7U7j5QAfadrZHqMbsCEHQAC3a
	 4gTgSBcaEilcYWf7ko9LDtf4gZBiIzVGSoUKe1f1NYTZjBwIryVqeQJG5dpp+Fs++P
	 eR9+S6tMgArOMpuZPfbjb46jol6NMPgVmrNnmq1IxH5P9/LpBeU2Et5uBvHb0sS/x3
	 fg9xzLI1T5bgw==
Date: Fri, 17 Jan 2025 13:11:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Frederic
 Weisbecker <frederic@kernel.org>, Artem Chernyshev
 <artem.chernyshev@red-soft.ru>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH net-next v1 5/5] selftest: net: add proc_net_pktgen
Message-ID: <20250117131154.0f3d2057@kernel.org>
In-Reply-To: <20250117141613.691452-6-ps.report@gmx.net>
References: <20250117141613.691452-1-ps.report@gmx.net>
	<20250117141613.691452-6-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 15:16:13 +0100 Peter Seiderer wrote:
> +FIXTURE_SETUP(proc_net_pktgen) {
> +	ssize_t len;
> +
> +	self->ctrl_fd = open("/proc/net/pktgen/kpktgend_0", O_RDWR);
> +	ASSERT_GE(self->ctrl_fd, 0) TH_LOG("CONFIG_NET_PKTGEN not enabled, module pktgen nod loaded?");

nod -> not?

Please take a look at the instructions here:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
the test currently fails in our CI, you need to add it to
tools/testing/selftests/net/config, and perhaps try to call
modprobe in the test?

> +	len = write(self->ctrl_fd, add_loopback_0, sizeof(add_loopback_0));
> +	ASSERT_EQ(len, sizeof(add_loopback_0)) TH_LOG("device lo@0 already registered?");

FWIW we prefer to stick to 80 char line width in networking, 
but it's not a big deal for a test, up to you.

> +			// complete command string without/with trailing '\0'
> +			 EXPECT_EQ(len, i);

Run this patch thru checkpatch, please. This looks misaligned.

> +		}
> +	}
> +}

> +#if 0 // needs CONFIG_XFRM

Add it to the config, too, then?

> +TEST_F(proc_net_pktgen, device_command_spi) {
> +	ssize_t len;
> +
> +	len = write(self->device_fd, device_command_spi_0, sizeof(device_command_spi_0));
> +	EXPECT_EQ(len, sizeof(device_command_spi_0));
> +}
> +#endif

Thanks for working on a test!

